Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E45C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0707B6102A
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347398AbhIBTvc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:41967 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347397AbhIBTva (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778205"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778205"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:26 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451630"
Received: from kappusam-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:26 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 07/13] cxl/memdev: Determine CXL.mem capability
Date:   Thu,  2 Sep 2021 12:50:11 -0700
Message-Id: <20210902195017.2516472-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

If the "upstream" port of the endpoint is an enumerated downstream CXL
port, and the device itself is CXL capable and enabled, the memdev
driver can bind. This binding useful for region configuration/creation
because it provides a clean way for the region code to determine if the
memdev is actually CXL capable.

A memdev/hostbridge probe race is solved with a full CXL bus rescan at
the end of ACPI probing (see comment in code for details). Switch
enumeration will be done as a follow-on patch. As a result, if a switch
is in the topology the memdev driver will not bind to any devices.

CXL.mem capability is checked lazily at the time a region is bound.
This is in line with the other configuration parameters.

Below is an example (mem0, and mem1) of CXL memdev devices that now
exist on the bus.

/sys/bus/cxl/devices/
├── decoder0.0 -> ../../../devices/platform/ACPI0017:00/root0/decoder0.0
├── mem0 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/mem0
├── mem1 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem1
├── pmem0 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/mem0/pmem0
├── pmem1 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem1/pmem1
├── port1 -> ../../../devices/platform/ACPI0017:00/root0/port1
└── root0 -> ../../../devices/platform/ACPI0017:00/root0

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c        | 27 +++++++-----------
 drivers/cxl/core/bus.c    | 60 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/memdev.c |  6 ++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/cxl/cxlmem.h      |  2 ++
 drivers/cxl/mem.c         | 55 ++++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c         | 23 ---------------
 drivers/cxl/pci.h         |  7 ++++-
 8 files changed, 141 insertions(+), 41 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7130beffc929..fd14094bdb3f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -240,21 +240,6 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
-static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
-{
-	struct cxl_dport *dport;
-
-	device_lock(&port->dev);
-	list_for_each_entry(dport, &port->dports, list)
-		if (dport->dport == dev) {
-			device_unlock(&port->dev);
-			return dport;
-		}
-
-	device_unlock(&port->dev);
-	return NULL;
-}
-
 __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
 					      struct device *dev)
 {
@@ -459,9 +444,19 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		goto out;
 
-	if (IS_ENABLED(CONFIG_CXL_PMEM))
+	if (IS_ENABLED(CONFIG_CXL_PMEM)) {
 		rc = device_for_each_child(&root_port->dev, root_port,
 					   add_root_nvdimm_bridge);
+		if (rc)
+			goto out;
+	}
+
+	/*
+	 * While ACPI is scanning hostbridge ports, switches and memory devices
+	 * may have been probed. Those devices will need to know whether the
+	 * hostbridge is CXL capable.
+	 */
+	rc = bus_rescan_devices(&cxl_bus_type);
 
 out:
 	acpi_put_table(acpi_cedt);
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 256e55dc2a3b..56f57302d27b 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <cxlmem.h>
 #include <cxl.h>
+#include <pci.h>
 #include "core.h"
 
 /**
@@ -259,6 +260,12 @@ static const struct device_type cxl_port_type = {
 	.groups = cxl_port_attribute_groups,
 };
 
+bool is_cxl_port(struct device *dev)
+{
+	return dev->type == &cxl_port_type;
+}
+EXPORT_SYMBOL_GPL(is_cxl_port);
+
 struct cxl_port *to_cxl_port(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_port_type,
@@ -266,6 +273,7 @@ struct cxl_port *to_cxl_port(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_port, dev);
 }
+EXPORT_SYMBOL_GPL(to_cxl_port);
 
 static void unregister_port(void *_port)
 {
@@ -424,6 +432,27 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 	return dup ? -EEXIST : 0;
 }
 
+/**
+ * find_dport_by_dev - gets downstream CXL port from a struct device
+ * @port: cxl [upstream] port that "owns" the downstream port is being queried
+ * @dev: The device that is backing the downstream port
+ */
+struct cxl_dport *find_dport_by_dev(struct cxl_port *port, const struct device *dev)
+{
+	struct cxl_dport *dport;
+
+	device_lock(&port->dev);
+	list_for_each_entry(dport, &port->dports, list)
+		if (dport->dport == dev) {
+			device_unlock(&port->dev);
+			return dport;
+		}
+
+	device_unlock(&port->dev);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(find_dport_by_dev);
+
 /**
  * cxl_add_dport - append downstream port data to a cxl_port
  * @port: the cxl_port that references this dport
@@ -596,6 +625,37 @@ int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
 }
 EXPORT_SYMBOL_GPL(cxl_decoder_autoremove);
 
+/**
+ * cxl_pci_dvsec - Gets offset for the given DVSEC id
+ * @pdev: PCI device to search for the DVSEC
+ * @dvsec: DVSEC id to look for
+ *
+ * Return: offset within the PCI header for the given DVSEC id. 0 if not found
+ */
+int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
+{
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
+	if (!pos)
+		return 0;
+
+	while (pos) {
+		u16 vendor, id;
+
+		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
+		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
+		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
+			return pos;
+
+		pos = pci_find_next_ext_capability(pdev, pos,
+						   PCI_EXT_CAP_ID_DVSEC);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_mem_dvsec);
+
 /**
  * __cxl_driver_register - register a driver for the cxl bus
  * @cxl_drv: cxl driver structure to attach
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c9dd054bd813..0068b5ff5f3e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -337,3 +337,9 @@ void cxl_memdev_exit(void)
 {
 	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
 }
+
+bool is_cxl_mem_capable(struct cxl_memdev *cxlmd)
+{
+	return !!cxlmd->dev.driver;
+}
+EXPORT_SYMBOL_GPL(is_cxl_mem_capable);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b48bdbefd949..a168520d741b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -283,8 +283,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);
 
+bool is_cxl_port(struct device *dev);
 int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 		  resource_size_t component_reg_phys);
+struct cxl_dport *find_dport_by_dev(struct cxl_port *port, const struct device *dev);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 811b24451604..88264204c4b9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -51,6 +51,8 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_mem *cxlm);
 
+bool is_cxl_mem_capable(struct cxl_memdev *cxlmd);
+
 /**
  * struct cxl_mbox_cmd - A command to be submitted to hardware.
  * @opcode: (input) The command set and command submitted to hardware.
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 978a54b0a51a..b6dc34d18a86 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -2,8 +2,10 @@
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 
 #include "cxlmem.h"
+#include "pci.h"
 
 /**
  * DOC: cxl mem
@@ -17,9 +19,60 @@
  * components.
  */
 
+static int port_match(struct device *dev, const void *data)
+{
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	if (find_dport_by_dev(port, (struct device *)data))
+		return 1;
+
+	return 0;
+}
+
+static bool is_cxl_mem_enabled(struct pci_dev *pdev)
+{
+	int pcie_dvsec;
+	u16 dvsec_ctrl;
+
+	pcie_dvsec = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID);
+	if (!pcie_dvsec) {
+		dev_info(&pdev->dev, "Unable to determine CXL protocol support");
+		return false;
+	}
+
+	pci_read_config_word(pdev,
+			     pcie_dvsec + PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET,
+			     &dvsec_ctrl);
+	if (!(dvsec_ctrl & CXL_PCIE_MEM_ENABLE)) {
+		dev_info(&pdev->dev, "CXL.mem protocol not supported on device");
+		return false;
+	}
+
+	return true;
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
-	return -EOPNOTSUPP;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct device *pdev_parent = cxlm->dev->parent;
+	struct pci_dev *pdev = to_pci_dev(cxlm->dev);
+	struct device *port_dev;
+
+	if (!is_cxl_mem_enabled(pdev))
+		return -ENODEV;
+
+	/* TODO: if parent is a switch, this will fail. */
+	port_dev = bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
+	if (!port_dev)
+		return -ENODEV;
+
+	return 0;
 }
 
 static void cxl_mem_remove(struct device *dev)
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6931885c83ce..244b99948c40 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -335,29 +335,6 @@ static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
 	pci_iounmap(to_pci_dev(cxlm->dev), base);
 }
 
-static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
-{
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
-	if (!pos)
-		return 0;
-
-	while (pos) {
-		u16 vendor, id;
-
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
-		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
-			return pos;
-
-		pos = pci_find_next_ext_capability(pdev, pos,
-						   PCI_EXT_CAP_ID_DVSEC);
-	}
-
-	return 0;
-}
-
 static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 			  struct cxl_register_map *map)
 {
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 8c1a58813816..d6b9978d05b0 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -11,7 +11,10 @@
  */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
 #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
-#define PCI_DVSEC_ID_CXL		0x0
+
+#define PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID	0x0
+#define PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET	0xC
+#define   CXL_PCIE_MEM_ENABLE			BIT(2)
 
 #define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
 #define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
@@ -29,4 +32,6 @@
 
 #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
 
+int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec);
+
 #endif /* __CXL_PCI_H__ */
-- 
2.33.0

