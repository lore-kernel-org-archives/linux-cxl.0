Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092B2C4321E
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355526AbhLBEnx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:61242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355541AbhLBEnr (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438390"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438390"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717507"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:11 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 14/14] cxl/mem: Introduce cxl_mem driver
Date:   Wed,  1 Dec 2021 20:37:50 -0800
Message-Id: <20211202043750.3501494-15-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a driver that is capable of determining whether a device is in a
CXL.mem routed part of the topology.

This driver allows a higher level driver - such as one controlling CXL
regions, which is itself a set of CXL devices - to easily determine if
the CXL devices are CXL.mem capable by checking if the driver has bound.
CXL memory device services may also be provided by this driver though
none are needed as of yet. cxl_mem also plays the part of registering
itself as an endpoint port, which is a required step to enumerate the
device's HDM decoder resources.

Even though cxl_mem driver is the only consumer of the new
cxl_scan_ports() introduced in cxl_core, because that functionality has
PCIe specificity it is kept out of this driver.

As part of this patch, find_dport_by_dev() is promoted to the cxl_core's
set of APIs for use by the new driver.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since v1:
- Remove duplicative CXL_MEM config option (Randy Dunlap)
- Remove stray newline (Jonathan)
- Cleanup port addition (Jonathan)
- Move consumer of opaque data to this patch (Jonathan)
- Add documentation for root_port link (Jonathan)
- Handle DVSEC checking in this driver (Dan)
- Mark DVSEC ranges as in use in case BIOS didn't (Dan)
---
 Documentation/ABI/testing/sysfs-bus-cxl       |   9 +
 .../driver-api/cxl/memory-devices.rst         |   9 +
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/acpi.c                            |  17 +-
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/bus.c                        | 125 ++++++++
 drivers/cxl/core/core.h                       |   3 +
 drivers/cxl/core/memdev.c                     |   2 +-
 drivers/cxl/core/pci.c                        | 117 +++++++
 drivers/cxl/cxl.h                             |   8 +
 drivers/cxl/cxlmem.h                          |   3 +
 drivers/cxl/mem.c                             | 285 ++++++++++++++++++
 drivers/cxl/pci.h                             |   3 +
 drivers/cxl/port.c                            |  12 +-
 tools/testing/cxl/Kbuild                      |   1 +
 15 files changed, 578 insertions(+), 19 deletions(-)
 create mode 100644 drivers/cxl/core/pci.c
 create mode 100644 drivers/cxl/mem.c

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0b6a2e6e8fbb..9b7f3c272138 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -7,6 +7,15 @@ Description:
 		Memory Device Output Payload in the CXL-2.0
 		specification.
 
+What:		/sys/bus/cxl/devices/memX/root_port
+Date:		November, 2021
+KernelVersion:	v5.17
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Link to the upstream CXL-2.0 root port. This link may be
+		used by userspace to help build a representation of the CXL
+		topology.
+
 What:		/sys/bus/cxl/devices/memX/ram/size
 Date:		December, 2020
 KernelVersion:	v5.12
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index fbf0393cdddc..b4ff5f209c34 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -28,6 +28,9 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+.. kernel-doc:: drivers/cxl/mem.c
+   :doc: cxl mem
+
 CXL Port
 --------
 .. kernel-doc:: drivers/cxl/port.c
@@ -47,6 +50,12 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/bus.c
    :identifiers:
 
+.. kernel-doc:: drivers/cxl/core/pci.c
+   :doc: cxl core pci
+
+.. kernel-doc:: drivers/cxl/core/pci.c
+   :identifiers:
+
 .. kernel-doc:: drivers/cxl/core/pmem.c
    :doc: cxl pmem
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 56fcac2323cb..ce267ef11d93 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
 
+cxl_mem-y := mem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7bb5699fc1ce..be4f4b767d37 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -172,21 +172,6 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
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
@@ -217,7 +202,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (!bridge)
 		return 0;
 
-	dport = find_dport_by_dev(root_port, match);
+	dport = cxl_find_dport_by_dev(root_port, match);
 	if (!dport) {
 		dev_dbg(host, "host bridge expected and not found\n");
 		return 0;
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 40ab50318daf..5b8ec478fb0b 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -7,3 +7,4 @@ cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
+cxl_core-y += pci.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 34a308708a99..e8063cb7c5c8 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <cxlmem.h>
 #include <cxl.h>
+#include <pci.h>
 #include "core.h"
 
 /**
@@ -531,6 +532,111 @@ struct cxl_port *devm_cxl_add_port(struct device *uport,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
 
+static int add_upstream_port(struct device *host, struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cxl_port *parent_port;
+	struct cxl_register_map map;
+	struct cxl_port *port;
+	int rc;
+
+	/* A port is useless if there are no component registers */
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+
+	parent_port = find_parent_cxl_port(pdev);
+	if (!parent_port)
+		return -ENODEV;
+
+	if (!parent_port->dev.driver) {
+		dev_dbg(dev, "Upstream port has no driver\n");
+		put_device(&parent_port->dev);
+		return -ENODEV;
+	}
+
+	port = devm_cxl_add_port(dev, cxl_regmap_to_base(pdev, &map),
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
+	parent_port = find_parent_cxl_port(pdev);
+	if (!parent_port)
+		return -ENODEV;
+
+	if (!parent_port->dev.driver) {
+		dev_dbg(dev, "Host port to dport has no driver\n");
+		put_device(&parent_port->dev);
+		return -ENODEV;
+	}
+
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap) != PCIBIOS_SUCCESSFUL)
+		return 1;
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		dev_dbg(dev, "Failed to obtain component registers\n");
+
+	rc = cxl_add_dport(parent_port, dev, port_num,
+			   cxl_regmap_to_base(pdev, &map), false);
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
+
+	if (is_cxl_switch_usp((dev)))
+		return add_upstream_port(host, pdev);
+	else if (is_cxl_switch_dsp((dev)))
+		return add_downstream_port(pdev);
+	else
+		return 0;
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
+EXPORT_SYMBOL_NS_GPL(cxl_scan_ports, CXL);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
@@ -614,6 +720,23 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_dport, CXL);
 
+struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
+					struct device *dev)
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
+EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
+
 static int decoder_populate_targets(struct cxl_decoder *cxld,
 				    struct cxl_port *port, int *target_map)
 {
@@ -921,6 +1044,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM;
 	if (dev->type == &cxl_port_type)
 		return CXL_DEVICE_PORT;
+	if (dev->type == &cxl_memdev_type)
+		return CXL_DEVICE_MEMORY_EXPANDER;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e0c9aacc4e9c..c5836f071eaa 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
+extern const struct device_type cxl_memdev_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
@@ -20,4 +21,6 @@ void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
 void cxl_mbox_exit(void);
 
+struct cxl_port *find_parent_cxl_port(struct pci_dev *pdev);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 61029cb7ac62..149665fd2d3f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -127,7 +127,7 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	NULL,
 };
 
-static const struct device_type cxl_memdev_type = {
+const struct device_type cxl_memdev_type = {
 	.name = "cxl_memdev",
 	.release = cxl_memdev_release,
 	.devnode = cxl_memdev_devnode,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
new file mode 100644
index 000000000000..6821f31a4e52
--- /dev/null
+++ b/drivers/cxl/core/pci.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <cxl.h>
+#include <pci.h>
+#include "core.h"
+
+/**
+ * DOC: cxl core pci
+ *
+ * Compute Express Link protocols are layered on top of PCIe. CXL core provides
+ * a set of helpers for CXL interactions which occur via PCIe.
+ */
+
+/**
+ * find_parent_cxl_port() - Finds parent port through PCIe mechanisms
+ * @pdev: PCIe USP or DSP to find an upstream port for
+ *
+ * Once all CXL ports are enumerated, there is no need to reference the PCIe
+ * parallel universe as all downstream ports are contained in a linked list, and
+ * all upstream ports are accessible via pointer. During the enumeration, it is
+ * very convenient to be able to peak up one level in the hierarchy without
+ * needing the established relationship between data structures so that the
+ * parenting can be done as the ports/dports are created.
+ *
+ * A reference is kept to the found port.
+ */
+struct cxl_port *find_parent_cxl_port(struct pci_dev *pdev)
+{
+	struct device *parent_dev, *gparent_dev;
+	const int type = pci_pcie_type(pdev);
+
+	/* Parent is either a downstream port, or root port */
+	parent_dev = get_device(pdev->dev.parent);
+
+	if (is_cxl_switch_usp(&pdev->dev)) {
+		if (dev_WARN_ONCE(&pdev->dev,
+				  type != PCI_EXP_TYPE_DOWNSTREAM &&
+					  type != PCI_EXP_TYPE_ROOT_PORT,
+				  "Parent not downstream\n"))
+			goto err;
+
+		/*
+		 * Grandparent is either an upstream port or a platform device that has
+		 * been added as a cxl_port already.
+		 */
+		gparent_dev = get_device(parent_dev->parent);
+		put_device(parent_dev);
+
+		return to_cxl_port(gparent_dev);
+	} else if (is_cxl_switch_dsp(&pdev->dev)) {
+		if (dev_WARN_ONCE(&pdev->dev, type != PCI_EXP_TYPE_UPSTREAM,
+				  "Parent not upstream"))
+			goto err;
+		return to_cxl_port(parent_dev);
+	}
+
+err:
+	dev_WARN(&pdev->dev, "Invalid topology\n");
+	put_device(parent_dev);
+	return NULL;
+}
+
+/*
+ * Unlike endpoints, switches don't discern CXL.mem capability. Simply finding
+ * the DVSEC is sufficient.
+ */
+static bool is_cxl_switch(struct pci_dev *pdev)
+{
+	return pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+					 CXL_DVSEC_PORT_EXTENSIONS);
+}
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
+	       is_cxl_switch(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_switch_usp, CXL);
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
+	       is_cxl_switch(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_switch_dsp, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index df25dd20ff95..9e3091857906 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -275,6 +275,7 @@ struct cxl_walk_context {
  * @decoder_ida: allocator for decoder ids
  * @component_reg_phys: component register capability base address (optional)
  * @rescan_work: worker object for bus rescans after port additions
+ * @data: opaque data with driver specific usage
  */
 struct cxl_port {
 	struct device dev;
@@ -284,6 +285,7 @@ struct cxl_port {
 	struct ida decoder_ida;
 	resource_size_t component_reg_phys;
 	struct work_struct rescan_work;
+	void *data;
 };
 
 /**
@@ -294,6 +296,7 @@ struct cxl_port {
  * @port: reference to cxl_port that contains this downstream port
  * @list: node for a cxl_port's list of cxl_dport instances
  * @root_port_link: node for global list of root ports
+ * @data: Opaque data passed by other drivers, used by port driver
  */
 struct cxl_dport {
 	struct device *dport;
@@ -302,16 +305,20 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct list_head list;
 	struct list_head root_port_link;
+	void *data;
 };
 
 struct cxl_port *to_cxl_port(struct device *dev);
 struct cxl_port *devm_cxl_add_port(struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);
+void cxl_scan_ports(struct cxl_dport *root_port);
 
 int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 		  resource_size_t component_reg_phys, bool root_port);
 struct cxl_dport *cxl_get_root_dport(struct device *dev);
+struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
+					struct device *dev);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
@@ -350,6 +357,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
 #define CXL_DEVICE_PORT			3
+#define CXL_DEVICE_MEMORY_EXPANDER	4
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ebb4d1cdded2..68cc143d2273 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -35,12 +35,15 @@
  * @cdev: char dev core object for ioctl operations
  * @cxlds: The device state backing this device
  * @id: id number of this memdev instance.
+ * @component_reg_phys: register base of component registers
+ * @root_port: Hostbridge's root port connected to this endpoint
  */
 struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
 	int id;
+	struct cxl_dport *root_port;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
new file mode 100644
index 000000000000..aaaabaeef24f
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "cxlmem.h"
+#include "pci.h"
+
+/**
+ * DOC: cxl mem
+ *
+ * CXL memory endpoint devices and switches are CXL capable devices that are
+ * participating in CXL.mem protocol. Their functionality builds on top of the
+ * CXL.io protocol that allows enumerating and configuring components via
+ * standard PCI mechanisms.
+ *
+ * The cxl_mem driver owns kicking off the enumeration of this CXL.mem
+ * capability. With the detection of a CXL capable endpoint, the driver will
+ * walk up to find the platform specific port it is connected to, and determine
+ * if there are intervening switches in the path. If there are switches, a
+ * secondary action to enumerate those (implemented in cxl_core). Finally the
+ * cxl_mem driver will add the device it is bound to as a CXL port for use in
+ * higher level operations.
+ */
+
+struct walk_ctx {
+	struct cxl_dport *root_port;
+	bool has_switch;
+};
+
+/**
+ * walk_to_root_port() - Walk up to root port
+ * @dev: Device to walk up from
+ * @ctx: Information to populate while walking
+ *
+ * A platform specific driver such as cxl_acpi is responsible for scanning CXL
+ * topologies in a top-down fashion. If the CXL memory device is directly
+ * connected to the top level hostbridge, nothing else needs to be done. If
+ * however there are CXL components (ie. a CXL switch) in between an endpoint
+ * and a hostbridge the platform specific driver must be notified after all the
+ * components are enumerated.
+ */
+static void walk_to_root_port(struct device *dev, struct walk_ctx *ctx)
+{
+	struct cxl_dport *root_port;
+
+	if (!dev->parent)
+		return;
+
+	root_port = cxl_get_root_dport(dev);
+	if (root_port)
+		ctx->root_port = root_port;
+
+	if (is_cxl_switch_usp(dev))
+		ctx->has_switch = true;
+
+	walk_to_root_port(dev->parent, ctx);
+}
+
+static void remove_endpoint(void *_cxlmd)
+{
+	struct cxl_memdev *cxlmd = _cxlmd;
+
+	if (cxlmd->root_port)
+		sysfs_remove_link(&cxlmd->dev.kobj, "root_port");
+}
+
+static int wait_for_media(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_endpoint_dvsec_info *info = cxlds->info;
+	int rc;
+
+	if (!info)
+		return -ENXIO;
+
+	if (!info->mem_enabled)
+		return -EBUSY;
+
+	rc = cxlds->wait_media_ready(cxlds);
+	if (rc)
+		return rc;
+
+	/*
+	 * We know the device is active, and enabled, if any ranges are non-zero
+	 * we'll need to check later before adding the port since that owns the
+	 * HDM decoder registers.
+	 */
+	return 0;
+}
+
+static int create_endpoint(struct device *dev, struct cxl_port *parent,
+			   struct cxl_dport *dport)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *endpoint;
+	int rc;
+
+	endpoint = devm_cxl_add_port(dev, cxlds->component_reg_phys, parent);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	rc = sysfs_create_link(&cxlmd->dev.kobj, &dport->dport->kobj,
+			       "root_port");
+	if (rc) {
+		device_del(&endpoint->dev);
+		return rc;
+	}
+	dev_dbg(dev, "add: %s\n", dev_name(&endpoint->dev));
+
+	return devm_add_action_or_reset(dev, remove_endpoint, cxlmd);
+}
+
+/**
+ * hdm_decode_init() - Setup HDM decoding for the endpoint
+ * @cxlds: Device state
+ *
+ * Additionally, enables global HDM decoding. Warning: don't call this outside
+ * of probe. Once probe is complete, the port driver owns all access to the HDM
+ * decoder registers.
+ *
+ * Returns: false if DVSEC Ranges are being used instead of HDM decoders;
+ *	    otherwise returns true.
+ */
+static bool hdm_decode_init(struct cxl_dev_state *cxlds)
+{
+	struct cxl_endpoint_dvsec_info *info = cxlds->info;
+	struct cxl_register_map map;
+	struct cxl_component_reg_map *cmap = &map.component_map;
+
+	bool global_enable;
+	void __iomem *crb;
+	u32 global_ctrl;
+
+	/* map hdm decoder */
+	crb = ioremap(cxlds->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (!crb) {
+		dev_dbg(cxlds->dev, "Failed to map component registers\n");
+		return info->ranges;
+	}
+
+	cxl_probe_component_regs(cxlds->dev, crb, cmap);
+	if (!cmap->hdm_decoder.valid) {
+		iounmap(crb);
+		dev_dbg(cxlds->dev, "Invalid HDM decoder registers\n");
+		return info->ranges;
+	}
+
+	global_ctrl = readl(crb + cmap->hdm_decoder.offset +
+			    CXL_HDM_DECODER_CTRL_OFFSET);
+	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
+	if (!global_enable && info->ranges) {
+		iounmap(crb);
+		dev_dbg(cxlds->dev, "DVSEC regions\n");
+		return false;
+	}
+
+	/*
+	 * Turn on global enable now since DVSEC ranges aren't being used and
+	 * we'll eventually want the decoder enabled. This also prevents special
+	 * casing in the port driver since this only applies to endpoints.
+	 */
+	if (!global_enable) {
+		dev_dbg(cxlds->dev, "Enabling HDM decode\n");
+		writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
+		       crb + cmap->hdm_decoder.offset +
+			       CXL_HDM_DECODER_CTRL_OFFSET);
+	}
+
+	iounmap(crb);
+	return true;
+}
+
+static int cxl_mem_probe(struct device *dev)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *hostbridge, *parent_port;
+	struct walk_ctx ctx = { NULL, false };
+	struct cxl_dport *dport;
+	int rc;
+
+	rc = wait_for_media(cxlmd);
+	if (rc) {
+		dev_err(dev, "Media not active (%d)\n", rc);
+		return rc;
+	}
+
+	/*
+	 * If DVSEC ranges are being used instead of HDM decoder registers there
+	 * is no use in trying to manage those.
+	 */
+	if (!hdm_decode_init(cxlds)) {
+		struct cxl_endpoint_dvsec_info *info = cxlds->info;
+		int i;
+
+		/* */
+		for (i = 0; i < 2; i++) {
+			u64 base, size;
+
+			/*
+			 * Give a nice warning to the user that BIOS has really
+			 * botched things for them if it didn't place DVSEC
+			 * ranges in the memory map.
+			 */
+			base = info->dvsec_range[i].start;
+			size = range_len(&info->dvsec_range[i]);
+			if (size && !region_intersects(base, size,
+						       IORESOURCE_SYSTEM_RAM,
+						       IORES_DESC_NONE)) {
+				dev_err(dev,
+					"DVSEC range %#llx-%#llx must be reserved by BIOS, but isn't\n",
+					base, base + size - 1);
+			}
+		}
+		dev_err(dev,
+			"Active DVSEC range registers in use. Will not bind.\n");
+		return -EBUSY;
+	}
+
+	walk_to_root_port(dev, &ctx);
+
+	/*
+	 * Couldn't find a CXL capable root port. This may happen even with a
+	 * CXL capable topology if cxl_acpi hasn't completed yet. A rescan will
+	 * occur.
+	 */
+	if (!ctx.root_port)
+		return -ENODEV;
+
+	hostbridge = ctx.root_port->port;
+	device_lock(&hostbridge->dev);
+
+	/* hostbridge has no port driver, the topology isn't enabled yet */
+	if (!hostbridge->dev.driver) {
+		device_unlock(&hostbridge->dev);
+		return -ENODEV;
+	}
+
+	/* No switch + found root port means we're done */
+	if (!ctx.has_switch) {
+		parent_port = to_cxl_port(&hostbridge->dev);
+		dport = ctx.root_port;
+		goto out;
+	}
+
+	/* Walk down from the root port and add all switches */
+	cxl_scan_ports(ctx.root_port);
+
+#if 0
+	/* FIXME: Find the parent_port without PCI domain */
+	parent_port = find_parent_cxl_port(to_pci_dev(dev));
+	dport = cxl_find_dport_by_dev(parent_port, dev->parent);
+	if (!dport) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+#endif
+
+out:
+	rc = create_endpoint(dev, parent_port, dport);
+	if (rc)
+		goto err_out;
+
+	cxlmd->root_port = ctx.root_port;
+
+err_out:
+	device_unlock(&hostbridge->dev);
+	return rc;
+}
+
+static struct cxl_driver cxl_mem_driver = {
+	.name = "cxl_mem",
+	.probe = cxl_mem_probe,
+	.id = CXL_DEVICE_MEMORY_EXPANDER,
+};
+
+module_cxl_driver(cxl_mem_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
+MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 7eb38030e376..bf527399a5de 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -69,4 +69,7 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 	return pci_resource_start(pdev, map->barno) + map->block_offset;
 }
 
+bool is_cxl_switch_usp(struct device *dev);
+bool is_cxl_switch_dsp(struct device *dev);
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4100cf395ec3..21cc5484877f 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -106,8 +106,16 @@ static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
 
 static bool is_endpoint_port(struct cxl_port *port)
 {
-	/* Endpoints can't be ports... yet! */
-	return false;
+	/*
+	 * It's tempting to just check list_empty(port->dports) here, but this
+	 * might get called before dports are setup for a port.
+	 */
+
+	if (!port->uport->driver)
+		return false;
+
+	return to_cxl_drv(port->uport->driver)->id ==
+	       CXL_DEVICE_MEMORY_EXPANDER;
 }
 
 static void rescan_ports(struct work_struct *work)
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 1acdf2fc31c5..4c2359772f3c 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -30,6 +30,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pmem.o
 cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
+cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += config_check.o
 
 cxl_core-y += mock_pmem.o
-- 
2.34.1

