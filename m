Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92838C4332F
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FCB6124B
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbhJPFRu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:1743 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243683AbhJPFRt (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489607"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489607"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743283"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:41 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 13/27] cxl/core: Introduce API to scan switch ports
Date:   Fri, 15 Oct 2021 22:15:17 -0700
Message-Id: <20211016051531.622613-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL drivers encapsulate the components that direct memory traffic in
an entity known as a cxl_port. Compute Express Link specifies three such
components: hostbridge (ie. a collection of root ports), switches, and
endpoints. There are currently drivers that create these ports for the
hostbridges and the endpoints (cxl_acpi and cxl_mem). The new API
introduced allows callers to initiate a scan down from the hostbridge
and create ports for switches in the CXL topology.

The intended user of this API is for endpoint devices. An endpoint
device will need to determine if it is CXL.mem capable, which requires
all components in the path from hostbridge to the endpoint to be CXL.mem
capable. Once an endpoint device determines it's connected to a CXL
capable root port, it can call this API to fill in all the ports in
between the hostbridge and itself.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .../driver-api/cxl/memory-devices.rst         |   6 +
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/bus.c                        | 135 ++++++++++++++++++
 drivers/cxl/core/pci.c                        |  99 +++++++++++++
 drivers/cxl/cxl.h                             |   1 +
 drivers/cxl/pci.h                             |   6 +
 tools/testing/cxl/Kbuild                      |   1 +
 7 files changed, 249 insertions(+)
 create mode 100644 drivers/cxl/core/pci.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index fbf0393cdddc..547336c95593 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -47,6 +47,12 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/bus.c
    :identifiers:
 
+.. kernel-doc:: drivers/cxl/core/pci.c
+   :doc: cxl pci
+
+.. kernel-doc:: drivers/cxl/core/pci.c
+   :identifiers:
+
 .. kernel-doc:: drivers/cxl/core/pmem.c
    :doc: cxl pmem
 
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 07eb8e1fb8a6..9d33d2d5bf09 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -7,3 +7,4 @@ cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
+cxl_core-y += pci.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index fa37115ef8e1..b34cedf9c62c 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <cxlmem.h>
 #include <cxl.h>
+#include <pci.h>
 #include "core.h"
 
 /**
@@ -420,6 +421,140 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_port);
 
+static int match_port(struct device *dev, const void *data)
+{
+	struct pci_dev *pdev = (struct pci_dev *)data;
+
+	if (dev->type != &cxl_port_type)
+		return 0;
+
+	return to_cxl_port(dev)->uport == &pdev->dev;
+}
+
+static struct cxl_port *find_cxl_port(struct pci_dev *usp)
+{
+	struct device *port_dev;
+
+	if (!pci_is_pcie(usp) || pci_pcie_type(usp) != PCI_EXP_TYPE_UPSTREAM)
+		return NULL;
+
+	port_dev = bus_find_device(&cxl_bus_type, NULL, usp, match_port);
+	if (port_dev)
+		return to_cxl_port(port_dev);
+
+	return NULL;
+}
+
+static int add_upstream_port(struct device *host, struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cxl_port *parent_port;
+	struct cxl_register_map map;
+	struct cxl_port *port;
+	int rc;
+
+	/*
+	 * Upstream ports must be connected to a downstream port or root port.
+	 * That downstream or root port must have a parent.
+	 */
+	if (!pdev->dev.parent->parent)
+		return -ENXIO;
+
+	/* A port is useless if there are no component registers */
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+
+	parent_port = find_cxl_port(to_pci_dev(pdev->dev.parent->parent));
+	if (!parent_port)
+		return -ENODEV;
+
+	port = devm_cxl_add_port(host, dev, cxl_reg_block(pdev, &map),
+				 parent_port);
+	put_device(&parent_port->dev);
+	if (IS_ERR(port))
+		dev_err(dev, "Failed to add upstream port %ld\n",
+			PTR_ERR(port));
+	else
+		dev_dbg(dev, "Added CXL port\n");
+
+	return rc;
+}
+
+static int add_downstream_port(struct pci_dev *pdev)
+{
+	resource_size_t creg = CXL_RESOURCE_NONE;
+	struct device *dev = &pdev->dev;
+	struct cxl_port *parent_port;
+	struct cxl_register_map map;
+	u32 lnkcap, port_num;
+	int rc;
+
+	/*
+	 * Ports are to be scanned from top down. Therefore, the upstream port
+	 * must already exist.
+	 */
+	parent_port = find_cxl_port(to_pci_dev(pdev->dev.parent));
+	if (!parent_port)
+		return -ENODEV;
+
+	/*
+	 * The spec mandates component registers are present but the
+	 * driver does not.
+	 */
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (!rc)
+		creg = cxl_reg_block(pdev, &map);
+
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap) != PCIBIOS_SUCCESSFUL)
+		return 1;
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+
+	rc = cxl_add_dport(parent_port, dev, port_num, creg, false);
+	put_device(&parent_port->dev);
+	if (rc)
+		dev_err(dev, "Failed to add downstream port to %s\n",
+			dev_name(&parent_port->dev));
+	else
+		dev_dbg(dev, "Added downstream port to %s\n",
+			dev_name(&parent_port->dev));
+
+	return rc;
+}
+
+static int match_add_ports(struct pci_dev *pdev, void *data)
+{
+	struct device *dev = &pdev->dev;
+	struct device *host = data;
+	int rc;
+
+	/* This port has already been added... */
+	if (find_cxl_port(pdev))
+		return 0;
+
+	if (is_cxl_switch_usp((dev)))
+		rc = add_upstream_port(host, pdev);
+
+	if (is_cxl_switch_dsp((dev)))
+		rc = add_downstream_port(pdev);
+
+	return rc;
+}
+
+/**
+ * cxl_scan_ports() - Adds all ports for the subtree beginning with @dport
+ * @dport: Beginning node of the CXL topology
+ */
+void cxl_scan_ports(struct cxl_dport *dport)
+{
+	struct device *d = dport->dport;
+	struct pci_dev *pdev = to_pci_dev(d);
+
+	pci_walk_bus(pdev->bus, match_add_ports, &dport->port->dev);
+}
+EXPORT_SYMBOL_GPL(cxl_scan_ports);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
new file mode 100644
index 000000000000..c0cbe984c778
--- /dev/null
+++ b/drivers/cxl/core/pci.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <pci.h>
+
+/**
+ * DOC: cxl pci
+ *
+ * Compute Express Link protocols are layered on top of PCIe. CXL core provides
+ * a set of helpers for CXL interactions which occur via PCIe.
+ */
+
+/**
+ * is_cxl_mem_enabled() - Does the device understand CXL.mem protocol
+ * @pdev: The PCI device for which to determine CXL enablement
+ *
+ * This is the most discrete determination as to whether a device supports
+ * CXL.mem protocol. At a minimum, a CXL device must advertise it is capable of
+ * negotiating the CXL.mem protocol while operating in Flex Bus.CXL mode. There
+ * are other determining factors as to whether CXL.mem protocol is supported in
+ * the path from root port to endpoint. Those other factors require a more
+ * comprehensive survey of the CXL topology and would use is_cxl_mem_enabled()
+ * as a cursory check.
+ *
+ * If the PCI device is enabled for CXL.mem protocol return true; otherwise
+ * return false.
+ *
+ * TODO: Is there other architecturally visible state that can be used to infer
+ *       CXL.mem protocol support?
+ */
+bool is_cxl_mem_enabled(struct pci_dev *pdev)
+{
+	int pcie_dvsec;
+	u16 dvsec_ctrl;
+
+	pcie_dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+					       CXL_DVSEC_PCIE_DEVICE);
+	if (!pcie_dvsec) {
+		dev_info(&pdev->dev,
+			 "Unable to determine CXL protocol support");
+		return false;
+	}
+
+	pci_read_config_word(pdev,
+			     pcie_dvsec + DVSEC_PCIE_DEVICE_CONTROL_OFFSET,
+			     &dvsec_ctrl);
+	if (!(dvsec_ctrl & DVSEC_PCIE_DEVICE_MEM_ENABLE)) {
+		dev_info(&pdev->dev, "CXL.mem protocol not enabled on device");
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(is_cxl_mem_enabled);
+
+/**
+ * is_cxl_switch_usp() - Is the device a CXL.mem enabled switch
+ * @dev: Device to query for switch type
+ *
+ * If the device is a CXL.mem capable upstream switch port return true;
+ * otherwise return false.
+ */
+bool is_cxl_switch_usp(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+
+	return pci_is_pcie(pdev) &&
+	       pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM &&
+	       is_cxl_mem_enabled(pdev);
+}
+EXPORT_SYMBOL_GPL(is_cxl_switch_usp);
+
+/**
+ * is_cxl_switch_dsp() - Is the device a CXL.mem enabled switch
+ * @dev: Device to query for switch type
+ *
+ * If the device is a CXL.mem capable downstream switch port return true;
+ * otherwise return false.
+ */
+bool is_cxl_switch_dsp(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+
+	return pci_is_pcie(pdev) &&
+	       pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+	       is_cxl_mem_enabled(pdev);
+}
+EXPORT_SYMBOL_GPL(is_cxl_switch_dsp);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 260091f1ab6f..e8ae852a7d8f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -306,6 +306,7 @@ struct cxl_port *to_cxl_port(struct device *dev);
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);
+void cxl_scan_ports(struct cxl_dport *root_port);
 
 int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 		  resource_size_t component_reg_phys, bool root_port);
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index fe2898b17736..9d6ca77d3e14 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -15,6 +15,8 @@
 
 /* 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
+#define   DVSEC_PCIE_DEVICE_CONTROL_OFFSET			0xC
+#define     DVSEC_PCIE_DEVICE_MEM_ENABLE			BIT(2)
 
 /* 8.1.4: Non-CXL Function Map DVSEC */
 #define CXL_DVSEC_FUNCTION_MAP					2
@@ -57,4 +59,8 @@ enum cxl_regloc_type {
 	((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \
 			   (map)->block_offset))
 
+bool is_cxl_switch_usp(struct device *dev);
+bool is_cxl_switch_dsp(struct device *dev);
+bool is_cxl_mem_enabled(struct pci_dev *pdev);
+
 #endif /* __CXL_PCI_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 86deba8308a1..46db4dd345a0 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -31,6 +31,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pmem.o
 cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
+cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += config_check.o
 
 cxl_core-y += mock_pmem.o
-- 
2.33.1

