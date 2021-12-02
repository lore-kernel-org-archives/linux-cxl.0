Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10816C43219
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355520AbhLBEnx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:61242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355537AbhLBEnq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438385"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438385"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717481"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:09 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        kernel test robot <lkp@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 11/14] cxl/port: Introduce a port driver
Date:   Wed,  1 Dec 2021 20:37:47 -0800
Message-Id: <20211202043750.3501494-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL port driver is responsible for managing the decoder resources
contained within the port. It will also provide APIs that other drivers
will consume for managing these resources.

There are 4 types of ports in a system:
1. Platform port. This is a non-programmable entity. Such a port is
   named rootX. It is enumerated with an ACPI0017 object, by cxl_acpi in
   an ACPI based system.
2. Host Bridge port. This port's register emumeration is defined in a
   platform specific way (CHBS for ACPI platforms). It has n downstream
   ports, each of which are known as CXL 2.0 root ports. Once the
   platform specific mechanism to get the offset to the registers is
   obtained it operates just like other CXL components. The enumeration
   of this component is started by cxl_acpi and completed by cxl_port.
3. Switch port. A switch port is similar to a Host Bridge port except
   register enumeration is defined in the CXL specification in a
   platform agnostic way. The enumeration of these are entirely
   contained within cxl_port.
4. Endpoint port. Endpoint ports are similar to switch ports with the
   exception that they have no downstream ports, only the underlying
   media on the device. The enumeration of these are started by cxl_pci,
   and completed by cxl_port.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since v1:
- Include header for ioread64_hi_lo (LKP)
- Fix variable out of scope usage (Jonathan)
- Cleanup error cases when adding decoder (Jonathan)
- Handle decoder initialization in separate function (Jonathan)
- Commit message rewording (Bjorn)
- Grammar, whitespace, and typo fixes (Bjorn)
- Skip DVSEC mess; mem driver won't add (Dan)
- Skip checking global enable; move to mem driver
- Use better names for get_caps and map_regs
- Rework helper functions to be more idiomatic
---
 .../driver-api/cxl/memory-devices.rst         |   5 +
 drivers/cxl/Kconfig                           |  21 ++
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/core/bus.c                        |  67 ++++
 drivers/cxl/core/regs.c                       |   6 +-
 drivers/cxl/cxl.h                             |  32 +-
 drivers/cxl/port.c                            | 318 ++++++++++++++++++
 7 files changed, 442 insertions(+), 9 deletions(-)
 create mode 100644 drivers/cxl/port.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 3b8f41395f6b..fbf0393cdddc 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -28,6 +28,11 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+CXL Port
+--------
+.. kernel-doc:: drivers/cxl/port.c
+   :doc: cxl port
+
 CXL Core
 --------
 .. kernel-doc:: drivers/cxl/cxl.h
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ef05e96f8f97..d224bddf238a 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -77,4 +77,25 @@ config CXL_PMEM
 	  provisioning the persistent memory capacity of CXL memory expanders.
 
 	  If unsure say 'm'.
+
+config CXL_MEM
+	tristate "CXL.mem: Memory Devices"
+	select CXL_PORT
+	depends on CXL_PCI
+	default CXL_BUS
+	help
+	  The CXL.mem protocol allows a device to act as a provider of "System
+	  RAM" and/or "Persistent Memory" that is fully coherent as if the
+	  memory were attached to the typical CPU memory controller. This is
+	  known as HDM "Host-managed Device Memory".
+
+	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
+	  memory expansion and control of HDM. See Chapter 9.13 in the CXL 2.0
+	  specification for a detailed description of HDM.
+
+	  If unsure say 'm'.
+
+config CXL_PORT
+	tristate
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index cf07ae6cea17..56fcac2323cb 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -3,7 +3,9 @@ obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
+obj-$(CONFIG_CXL_PORT) += cxl_port.o
 
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
+cxl_port-y := port.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 7da5fbe7a1af..e2cdea990b81 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -31,6 +31,8 @@ static DECLARE_RWSEM(root_port_sem);
 
 static struct device *cxl_topology_host;
 
+static bool is_cxl_decoder(struct device *dev);
+
 int cxl_register_topology_host(struct device *host)
 {
 	down_write(&topology_host_sem);
@@ -75,6 +77,45 @@ static void put_cxl_topology_host(struct device *dev)
 	up_read(&topology_host_sem);
 }
 
+static int decoder_match(struct device *dev, void *data)
+{
+	struct resource *theirs = (struct resource *)data;
+	struct cxl_decoder *cxld;
+
+	if (!is_cxl_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+	if (theirs->start <= cxld->decoder_range.start &&
+	    theirs->end >= cxld->decoder_range.end)
+		return 1;
+
+	return 0;
+}
+
+static struct cxl_decoder *cxl_find_root_decoder(resource_size_t base,
+						 resource_size_t size)
+{
+	struct cxl_decoder *cxld = NULL;
+	struct device *cxldd;
+	struct device *host;
+	struct resource res = (struct resource){
+		.start = base,
+		.end = base + size - 1,
+	};
+
+	host = get_cxl_topology_host();
+	if (!host)
+		return NULL;
+
+	cxldd = device_find_child(host, &res, decoder_match);
+	if (cxldd)
+		cxld = to_cxl_decoder(cxldd);
+
+	put_cxl_topology_host(host);
+	return cxld;
+}
+
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -280,6 +321,11 @@ bool is_root_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
+static bool is_cxl_decoder(struct device *dev)
+{
+	return dev->type->release == cxl_decoder_release;
+}
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
@@ -327,6 +373,7 @@ struct cxl_port *to_cxl_port(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_port, dev);
 }
+EXPORT_SYMBOL_NS_GPL(to_cxl_port, CXL);
 
 struct cxl_dport *cxl_get_root_dport(struct device *dev)
 {
@@ -798,6 +845,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
 
 static void cxld_unregister(void *dev)
 {
+	struct cxl_decoder *plat_decoder, *cxld = to_cxl_decoder(dev);
+	resource_size_t base, size;
+
+	if (is_root_decoder(dev)) {
+		device_unregister(dev);
+		return;
+	}
+
+	base = cxld->decoder_range.start;
+	size = range_len(&cxld->decoder_range);
+
+	if (size) {
+		plat_decoder = cxl_find_root_decoder(base, size);
+		if (plat_decoder)
+			__release_region(&plat_decoder->platform_res, base,
+					 size);
+	}
+
 	device_unregister(dev);
 }
 
@@ -852,6 +917,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM_BRIDGE;
 	if (dev->type == &cxl_nvdimm_type)
 		return CXL_DEVICE_NVDIMM;
+	if (dev->type == &cxl_port_type)
+		return CXL_DEVICE_PORT;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 7a1c4290f0a3..1fb931e6c83e 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -159,9 +159,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);
 
-static void __iomem *devm_cxl_iomap_block(struct device *dev,
-					  resource_size_t addr,
-					  resource_size_t length)
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length)
 {
 	void __iomem *ret_val;
 	struct resource *res;
@@ -180,6 +179,7 @@ static void __iomem *devm_cxl_iomap_block(struct device *dev,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(struct pci_dev *pdev,
 			   struct cxl_component_regs *regs,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c744d2998628..dd6c76ac89df 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -17,6 +17,9 @@
  * (port-driver, region-driver, nvdimm object-drivers... etc).
  */
 
+/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
+#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
+
 /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
 #define CXL_CM_OFFSET 0x1000
 #define CXL_CM_CAP_HDR_OFFSET 0x0
@@ -36,11 +39,22 @@
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
-#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
-#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
-#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
-#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
-#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
+#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
+#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
+#define   CXL_HDM_DECODER_ENABLE BIT(1)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
+#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
+#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
+#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
+#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
+#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
+#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 
 static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
@@ -148,6 +162,8 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
@@ -165,7 +181,8 @@ void cxl_unregister_topology_host(struct device *host);
 #define CXL_DECODER_F_TYPE2 BIT(2)
 #define CXL_DECODER_F_TYPE3 BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_MASK  GENMASK(4, 0)
+#define CXL_DECODER_F_ENABLE    BIT(5)
+#define CXL_DECODER_F_MASK  GENMASK(5, 0)
 
 enum cxl_decoder_type {
        CXL_DECODER_ACCELERATOR = 2,
@@ -255,6 +272,7 @@ struct cxl_walk_context {
  * @dports: cxl_dport instances referenced by decoders
  * @decoder_ida: allocator for decoder ids
  * @component_reg_phys: component register capability base address (optional)
+ * @rescan_work: worker object for bus rescans after port additions
  */
 struct cxl_port {
 	struct device dev;
@@ -263,6 +281,7 @@ struct cxl_port {
 	struct list_head dports;
 	struct ida decoder_ida;
 	resource_size_t component_reg_phys;
+	struct work_struct rescan_work;
 };
 
 /**
@@ -328,6 +347,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
+#define CXL_DEVICE_PORT			3
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
new file mode 100644
index 000000000000..242e6374f4a1
--- /dev/null
+++ b/drivers/cxl/port.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "cxlmem.h"
+
+/**
+ * DOC: cxl port
+ *
+ * The port driver implements the set of functionality needed to allow full
+ * decoder enumeration and routing. A CXL port is an abstraction of a CXL
+ * component that implements some amount of CXL decoding of CXL.mem traffic.
+ * As of the CXL 2.0 spec, this includes:
+ *
+ *	.. list-table:: CXL Components w/ Ports
+ *		:widths: 25 25 50
+ *		:header-rows: 1
+ *
+ *		* - component
+ *		  - upstream
+ *		  - downstream
+ *		* - Host Bridge
+ *		  - ACPI0016
+ *		  - Root Port
+ *		* - Switch
+ *		  - Switch Upstream Port
+ *		  - Switch Downstream Port
+ *		* - Endpoint
+ *		  - Endpoint Port
+ *		  - N/A
+ *
+ * The primary service this driver provides is enumerating HDM decoders and
+ * presenting APIs to other drivers to utilize the decoders.
+ */
+
+static struct workqueue_struct *cxl_port_wq;
+
+struct cxl_port_data {
+	struct cxl_component_regs regs;
+
+	struct port_caps {
+		unsigned int count;
+		unsigned int tc;
+		unsigned int interleave11_8;
+		unsigned int interleave14_12;
+	} caps;
+};
+
+static inline int to_interleave_granularity(u32 ctrl)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
+
+	return 256 << val;
+}
+
+static inline int to_interleave_ways(u32 ctrl)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
+
+	return 1 << val;
+}
+
+static struct port_caps parse_hdm_decoder_caps(void __iomem *hdm_decoder)
+{
+	u32 hdm_cap = readl(hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
+	struct port_caps caps;
+
+	caps.count = cxl_hdm_decoder_count(hdm_cap);
+	caps.tc = FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
+	caps.interleave11_8 =
+		FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap);
+	caps.interleave14_12 =
+		FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap);
+
+	return caps;
+}
+
+static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
+					  void __iomem *crb)
+{
+	struct cxl_register_map map;
+	struct cxl_component_reg_map *comp_map = &map.component_map;
+
+	cxl_probe_component_regs(&port->dev, crb, comp_map);
+	if (!comp_map->hdm_decoder.valid) {
+		dev_err(&port->dev, "HDM decoder registers invalid\n");
+		return IOMEM_ERR_PTR(-ENXIO);
+	}
+
+	return crb + comp_map->hdm_decoder.offset;
+}
+
+static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
+{
+	u32 ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(n));
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
+		return 0;
+
+	return ioread64_hi_lo(hdm_decoder +
+			      CXL_HDM_DECODER0_SIZE_LOW_OFFSET(n));
+}
+
+static bool is_endpoint_port(struct cxl_port *port)
+{
+	/* Endpoints can't be ports... yet! */
+	return false;
+}
+
+static void rescan_ports(struct work_struct *work)
+{
+	if (bus_rescan_devices(&cxl_bus_type))
+		pr_warn("%s: Failed to rescan. Some CXL devices may be missing\n",
+			KBUILD_MODNAME);
+}
+
+static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
+			     void __iomem *hdm_decoder, int which)
+{
+	u64 size, base;
+	u32 ctrl;
+	int i;
+	union {
+		u64 value;
+		char target_id[8];
+	} target_list;
+
+	size = get_decoder_size(hdm_decoder, which);
+	if (!size)
+		return;
+
+	ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(which));
+	base = ioread64_hi_lo(hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
+
+	cxld->decoder_range = (struct range) {
+		.start = base,
+		.end = base + size - 1
+	};
+
+	cxld->flags = CXL_DECODER_F_ENABLE;
+	cxld->interleave_ways = to_interleave_ways(ctrl);
+	cxld->interleave_granularity = to_interleave_granularity(ctrl);
+
+	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0)
+		cxld->target_type = CXL_DECODER_ACCELERATOR;
+
+	target_list.value = ioread64_hi_lo(hdm_decoder + CXL_HDM_DECODER0_TL_LOW(which));
+	for (i = 0; i < cxld->interleave_ways; i++)
+		target_map[i] = target_list.target_id[i];
+}
+
+static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
+			   int *target_map)
+{
+	int rc;
+
+	rc = cxl_decoder_add_locked(cxld, target_map);
+	if (rc) {
+		put_device(&cxld->dev);
+		dev_err(&port->dev, "Failed to add decoder\n");
+		return rc;
+	}
+
+	rc = cxl_decoder_autoremove(&port->dev, cxld);
+	if (!rc)
+		dev_dbg(&cxld->dev, "Added to port %s\n", dev_name(&port->dev));
+
+	return rc;
+}
+
+static int enumerate_endpoint_decoder(struct cxl_port *port,
+				      struct cxl_port_data *portdata)
+{
+	void __iomem *hdm_decoder = portdata->regs.hdm_decoder;
+	struct cxl_decoder *cxld;
+	int rc;
+
+	cxld = cxl_endpoint_decoder_alloc(port);
+	if (IS_ERR(cxld)) {
+		dev_warn(&port->dev, "Failed to allocate endpoint decoder\n");
+		return PTR_ERR(cxld);
+	}
+
+	init_hdm_decoder(cxld, NULL, hdm_decoder, 0);
+	rc = add_hdm_decoder(port, cxld, NULL);
+
+	return rc;
+}
+
+/* Enumerates CXL switches and Host Bridges */
+static int enumerate_switch_decoders(struct cxl_port *port,
+				     struct cxl_port_data *portdata)
+{
+	void __iomem *hdm_decoder = portdata->regs.hdm_decoder;
+	int i = 0;
+
+	for (i = 0; i < portdata->caps.count; i++) {
+		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
+		int rc, target_count = portdata->caps.tc;
+		struct cxl_decoder *cxld;
+
+		cxld = cxl_switch_decoder_alloc(port, target_count);
+		if (IS_ERR(cxld)) {
+			dev_warn(&port->dev,
+				 "Failed to allocate the decoder\n");
+			return PTR_ERR(cxld);
+		}
+
+		init_hdm_decoder(cxld, target_map, hdm_decoder, i);
+		rc = add_hdm_decoder(port, cxld, target_map);
+		if (rc) {
+			dev_warn(&port->dev,
+				 "Failed to add decoder to switch port\n");
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static int cxl_port_probe(struct device *dev)
+{
+	struct cxl_port *port = to_cxl_port(dev);
+	struct cxl_port_data *portdata;
+	void __iomem *crb;
+	int rc;
+
+	/*
+	 * All ports should have component registers except for the platform
+	 * specific root port. There's no point in binding that device.
+	 */
+	if (port->component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENODEV;
+
+	portdata = devm_kzalloc(dev, sizeof(*portdata), GFP_KERNEL);
+	if (!portdata)
+		return -ENOMEM;
+
+	crb = devm_cxl_iomap_block(&port->dev, port->component_reg_phys,
+				   CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (!crb) {
+		dev_err(&port->dev, "No component registers mapped\n");
+		return -ENXIO;
+	}
+
+	portdata->regs.hdm_decoder = map_hdm_decoder_regs(port, crb);
+	if (IS_ERR(portdata->regs.hdm_decoder))
+		return PTR_ERR(portdata->regs.hdm_decoder);
+
+	portdata->caps = parse_hdm_decoder_caps(portdata->regs.hdm_decoder);
+	if (portdata->caps.count == 0) {
+		dev_err(&port->dev, "Spec violation. Caps invalid\n");
+		return -ENXIO;
+	}
+
+	if (is_endpoint_port(port))
+		rc = enumerate_endpoint_decoder(port, portdata);
+	else
+		rc = enumerate_switch_decoders(port, portdata);
+	if (rc) {
+		dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
+		return rc;
+	}
+
+	/*
+	 * Bus rescan is done in a workqueue so that we can do so with the
+	 * device lock dropped.
+	 *
+	 * Why do we need to rescan? There is a race between cxl_acpi and
+	 * cxl_mem (which depends on cxl_pci). cxl_mem will only create a port
+	 * if it can establish a path up to a root port, which is enumerated by
+	 * a platform specific driver (ie. cxl_acpi) and bound by this driver.
+	 * While cxl_acpi could do the rescan, it makes sense to be here as
+	 * other platform drivers might require the same functionality.
+	 */
+	INIT_WORK(&port->rescan_work, rescan_ports);
+	queue_work(cxl_port_wq, &port->rescan_work);
+
+	return 0;
+}
+
+static struct cxl_driver cxl_port_driver = {
+	.name = "cxl_port",
+	.probe = cxl_port_probe,
+	.id = CXL_DEVICE_PORT,
+};
+
+static __init int cxl_port_init(void)
+{
+	int rc;
+
+	cxl_port_wq = alloc_ordered_workqueue("cxl_port", 0);
+	if (!cxl_port_wq)
+		return -ENOMEM;
+
+	rc = cxl_driver_register(&cxl_port_driver);
+	if (rc) {
+		destroy_workqueue(cxl_port_wq);
+		return rc;
+	}
+
+	return 0;
+}
+
+static __exit void cxl_port_exit(void)
+{
+	destroy_workqueue(cxl_port_wq);
+	cxl_driver_unregister(&cxl_port_driver);
+}
+
+module_init(cxl_port_init);
+module_exit(cxl_port_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
-- 
2.34.1

