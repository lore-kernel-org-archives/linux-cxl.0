Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9363C4167B
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF1361263
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbhJPFRs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:1736 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238636AbhJPFRr (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489596"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489596"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743258"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 07/27] cxl/port: Introduce a port driver
Date:   Fri, 15 Oct 2021 22:15:11 -0700
Message-Id: <20211016051531.622613-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL port driver will be responsible for managing the decoder
resources contained within the port. It will also provide APIs that
other drivers will consume for managing these resources.

This patch has no functional change because no driver is registering new
ports and the root ports that are already registered should be skipped.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .../driver-api/cxl/memory-devices.rst         |   5 +
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/acpi.c                            |   1 +
 drivers/cxl/core/bus.c                        |   3 +
 drivers/cxl/core/regs.c                       |   6 +-
 drivers/cxl/cxl.h                             |  30 ++-
 drivers/cxl/port.c                            | 241 ++++++++++++++++++
 7 files changed, 279 insertions(+), 9 deletions(-)
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
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index cf07ae6cea17..40b386aaedf7 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
+obj-$(CONFIG_CXL_MEM) += cxl_port.o
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
@@ -7,3 +8,4 @@ obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
+cxl_port-y := port.o
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index b972abc9f6ef..d61397055e9f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -491,3 +491,4 @@ static struct platform_driver cxl_acpi_driver = {
 module_platform_driver(cxl_acpi_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
+MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 5564a71773e2..64d0157191d0 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -266,6 +266,7 @@ struct cxl_port *to_cxl_port(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_port, dev);
 }
+EXPORT_SYMBOL_GPL(to_cxl_port);
 
 static void unregister_port(void *_port)
 {
@@ -632,6 +633,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM_BRIDGE;
 	if (dev->type == &cxl_nvdimm_type)
 		return CXL_DEVICE_NVDIMM;
+	if (dev->type == &cxl_port_type)
+		return CXL_DEVICE_PORT;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 40598905c080..c8ab8880b81b 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -159,9 +159,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
 
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
+EXPORT_SYMBOL_GPL(devm_cxl_iomap_block);
 
 int cxl_map_component_regs(struct pci_dev *pdev,
 			   struct cxl_component_regs *regs,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 91b8fd54bc93..ce05e805b597 100644
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
@@ -164,6 +178,8 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
@@ -178,7 +194,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 #define CXL_DECODER_F_TYPE2 BIT(2)
 #define CXL_DECODER_F_TYPE3 BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_MASK  GENMASK(4, 0)
+#define CXL_DECODER_F_EN    BIT(5)
+#define CXL_DECODER_F_MASK  GENMASK(5, 0)
 
 enum cxl_decoder_type {
        CXL_DECODER_ACCELERATOR = 2,
@@ -323,6 +340,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
+#define CXL_DEVICE_PORT			3
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
new file mode 100644
index 000000000000..4d65560eb739
--- /dev/null
+++ b/drivers/cxl/port.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
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
+ *		* - Hostbridge
+ *		  - ACPI0016
+ *		  - root port
+ *		* - Switch
+ *		  - Switch Upstream Port
+ *		  - Switch Downstream Port
+ *		* - Endpoint (not yet implemented)
+ *		  - Endpoint Port
+ *		  - N/A
+ *
+ * The primary service this driver provides is enumerating HDM decoders and
+ * presenting APIs to other drivers to utilize the decoders.
+ */
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
+static inline int cxl_hdm_decoder_ig(u32 ctrl)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
+
+	return 8 + val;
+}
+
+static inline int cxl_hdm_decoder_iw(u32 ctrl)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
+
+	return 1 << val;
+}
+
+static void get_caps(struct cxl_port *port, struct cxl_port_data *cpd)
+{
+	void __iomem *hdm_decoder = cpd->regs.hdm_decoder;
+	struct port_caps *caps = &cpd->caps;
+	u32 hdm_cap;
+
+	hdm_cap = readl(hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
+
+	caps->count = cxl_hdm_decoder_count(hdm_cap);
+	caps->tc = FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
+	caps->interleave11_8 =
+		FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap);
+	caps->interleave14_12 =
+		FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap);
+}
+
+static int map_regs(struct cxl_port *port, void __iomem *crb,
+		    struct cxl_port_data *cpd)
+{
+	struct cxl_register_map map;
+	struct cxl_component_reg_map *comp_map = &map.component_map;
+
+	cxl_probe_component_regs(&port->dev, crb, comp_map);
+	if (!comp_map->hdm_decoder.valid) {
+		dev_err(&port->dev, "HDM decoder registers invalid\n");
+		return -ENXIO;
+	}
+
+	cpd->regs.hdm_decoder = crb + comp_map->hdm_decoder.offset;
+
+	return 0;
+}
+
+static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
+{
+	u32 ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(n));
+
+	if (!!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+		return 0;
+
+	return ioread64_hi_lo(hdm_decoder +
+			      CXL_HDM_DECODER0_SIZE_LOW_OFFSET(n));
+}
+
+static bool is_endpoint_port(struct cxl_port *port)
+{
+	if (!port->uport->driver)
+		return false;
+
+	return to_cxl_drv(port->uport->driver)->id ==
+	       CXL_DEVICE_MEMORY_EXPANDER;
+}
+
+static int enumerate_hdm_decoders(struct cxl_port *port,
+				  struct cxl_port_data *portdata)
+{
+	int i = 0;
+
+	for (i = 0; i < portdata->caps.count; i++) {
+		int iw = 1, ig = 0, rc, target_count = portdata->caps.tc;
+		void __iomem *hdm_decoder = portdata->regs.hdm_decoder;
+		enum cxl_decoder_type type = CXL_DECODER_EXPANDER;
+		struct resource res = DEFINE_RES_MEM(0, 0);
+		struct cxl_decoder *cxld;
+		int *target_map = NULL;
+		u64 size;
+
+		if (is_endpoint_port(port))
+			target_count = 0;
+
+		cxld = cxl_decoder_alloc(port, target_count);
+		if (IS_ERR(cxld)) {
+			dev_warn(&port->dev,
+				 "Failed to allocate the decoder\n");
+			return PTR_ERR(cxld);
+		}
+
+		size = get_decoder_size(hdm_decoder, i);
+		if (size != 0) {
+			int temp[CXL_DECODER_MAX_INTERLEAVE];
+			u64 target_list, base;
+			u32 ctrl;
+			int j;
+
+			target_map = temp;
+			ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+			base = ioread64_hi_lo(hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i));
+			res = (struct resource)DEFINE_RES_MEM(base, size);
+
+			cxld->flags = CXL_DECODER_F_EN;
+			iw = cxl_hdm_decoder_iw(ctrl);
+			ig = cxl_hdm_decoder_ig(ctrl);
+
+			if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0)
+				type = CXL_DECODER_ACCELERATOR;
+
+			target_list = ioread64_hi_lo(hdm_decoder + CXL_HDM_DECODER0_TL_LOW(i));
+			for (j = 0; j < iw; j++)
+				target_map[j] = (target_list >> (j * 8)) & 0xff;
+		}
+
+		cxld->target_type = type;
+		cxld->res = res;
+		cxld->interleave_ways = iw;
+		cxld->interleave_granularity = ig;
+
+		rc = cxl_decoder_add(cxld, target_map);
+		if (rc) {
+			dev_warn(&port->dev,
+				 "Failed to add decoder%d (%d)\n", i, rc);
+			kfree(cxld);
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
+	u32 ctrl;
+	int rc;
+
+	if (port->component_reg_phys == CXL_RESOURCE_NONE)
+		return 0;
+
+	portdata = devm_kzalloc(dev, sizeof(*portdata), GFP_KERNEL);
+	if (!portdata)
+		return -ENOMEM;
+
+	crb = devm_cxl_iomap_block(&port->dev, port->component_reg_phys,
+				   CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (IS_ERR_OR_NULL(crb)) {
+		dev_err(&port->dev, "No component registers mapped\n");
+		return -ENXIO;
+	}
+
+	rc = map_regs(port, crb, portdata);
+	if (rc)
+		return rc;
+
+	get_caps(port, portdata);
+	if (portdata->caps.count == 0) {
+		dev_err(&port->dev, "Spec violation. Caps invalid\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * Enable HDM decoders for this port.
+	 *
+	 * FIXME: If the component was using DVSEC range registers for decode,
+	 * this will destroy that.
+	 */
+	ctrl = readl(portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
+	ctrl |= CXL_HDM_DECODER_ENABLE;
+	writel(ctrl, portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	rc = enumerate_hdm_decoders(port, portdata);
+	if (rc) {
+		dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
+		return rc;
+	}
+
+	dev_set_drvdata(dev, portdata);
+	return 0;
+}
+
+static struct cxl_driver cxl_port_driver = {
+	.name = "cxl_port",
+	.probe = cxl_port_probe,
+	.id = CXL_DEVICE_PORT,
+};
+module_cxl_driver(cxl_port_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
-- 
2.33.1

