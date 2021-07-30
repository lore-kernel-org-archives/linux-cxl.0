Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D630C4320A
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Jul 2021 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051A860F42
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Jul 2021 20:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhG3UHe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 30 Jul 2021 16:07:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:7892 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhG3UHe (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 30 Jul 2021 16:07:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="213194677"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="213194677"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 13:07:17 -0700
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="457267724"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 13:07:17 -0700
Subject: [PATCH v3 4/6] cxl/core: Move register mapping infrastructure
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Fri, 30 Jul 2021 13:07:17 -0700
Message-ID: <162767563728.3322476.6325060177505186597.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The register mapping infrastructure is large enough to move to its own
compilation unit. This also cleans up an unnecessary include of <mem.h>
core/bus.c.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/driver-api/cxl/memory-devices.rst |    3 
 drivers/cxl/core/Makefile                       |    1 
 drivers/cxl/core/bus.c                          |  229 ----------------------
 drivers/cxl/core/regs.c                         |  235 +++++++++++++++++++++++
 4 files changed, 239 insertions(+), 229 deletions(-)
 create mode 100644 drivers/cxl/core/regs.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index e65c0ba82229..46847d8c70a0 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -42,6 +42,9 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/pmem.c
    :internal:
 
+.. kernel-doc:: drivers/cxl/core/regs.c
+   :internal:
+
 External Interfaces
 ===================
 
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 3be8ef61fda3..a49bd72dfed3 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_CXL_BUS) += cxl_core.o
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I./drivers/cxl
 cxl_core-y := bus.o
 cxl_core-y += pmem.o
+cxl_core-y += regs.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index d25fe6c235f5..176db3058575 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -7,7 +7,6 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <cxl.h>
-#include <mem.h>
 #include "core.h"
 
 /**
@@ -550,234 +549,6 @@ devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_decoder);
 
-/**
- * cxl_probe_component_regs() - Detect CXL Component register blocks
- * @dev: Host device of the @base mapping
- * @base: Mapping containing the HDM Decoder Capability Header
- * @map: Map object describing the register block information found
- *
- * See CXL 2.0 8.2.4 Component Register Layout and Definition
- * See CXL 2.0 8.2.5.5 CXL Device Register Interface
- *
- * Probe for component register information and return it in map object.
- */
-void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
-{
-	int cap, cap_count;
-	u64 cap_array;
-
-	*map = (struct cxl_component_reg_map) { 0 };
-
-	/*
-	 * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
-	 * CXL 2.0 8.2.4 Table 141.
-	 */
-	base += CXL_CM_OFFSET;
-
-	cap_array = readq(base + CXL_CM_CAP_HDR_OFFSET);
-
-	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
-		dev_err(dev,
-			"Couldn't locate the CXL.cache and CXL.mem capability array header./n");
-		return;
-	}
-
-	/* It's assumed that future versions will be backward compatible */
-	cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_array);
-
-	for (cap = 1; cap <= cap_count; cap++) {
-		void __iomem *register_block;
-		u32 hdr;
-		int decoder_cnt;
-		u16 cap_id, offset;
-		u32 length;
-
-		hdr = readl(base + cap * 0x4);
-
-		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
-		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
-		register_block = base + offset;
-
-		switch (cap_id) {
-		case CXL_CM_CAP_CAP_ID_HDM:
-			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
-				offset);
-
-			hdr = readl(register_block);
-
-			decoder_cnt = cxl_hdm_decoder_count(hdr);
-			length = 0x20 * decoder_cnt + 0x10;
-
-			map->hdm_decoder.valid = true;
-			map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
-			map->hdm_decoder.size = length;
-			break;
-		default:
-			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
-				offset);
-			break;
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(cxl_probe_component_regs);
-
-/**
- * cxl_probe_device_regs() - Detect CXL Device register blocks
- * @dev: Host device of the @base mapping
- * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
- * @map: Map object describing the register block information found
- *
- * Probe for device register information and return it in map object.
- */
-void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map)
-{
-	int cap, cap_count;
-	u64 cap_array;
-
-	*map = (struct cxl_device_reg_map){ 0 };
-
-	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
-	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
-	    CXLDEV_CAP_ARRAY_CAP_ID)
-		return;
-
-	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
-
-	for (cap = 1; cap <= cap_count; cap++) {
-		u32 offset, length;
-		u16 cap_id;
-
-		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
-				   readl(base + cap * 0x10));
-		offset = readl(base + cap * 0x10 + 0x4);
-		length = readl(base + cap * 0x10 + 0x8);
-
-		switch (cap_id) {
-		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
-			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
-
-			map->status.valid = true;
-			map->status.offset = offset;
-			map->status.size = length;
-			break;
-		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
-			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
-			map->mbox.valid = true;
-			map->mbox.offset = offset;
-			map->mbox.size = length;
-			break;
-		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
-			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
-			break;
-		case CXLDEV_CAP_CAP_ID_MEMDEV:
-			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
-			map->memdev.valid = true;
-			map->memdev.offset = offset;
-			map->memdev.size = length;
-			break;
-		default:
-			if (cap_id >= 0x8000)
-				dev_dbg(dev, "Vendor cap ID: %#x offset: %#x\n", cap_id, offset);
-			else
-				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
-			break;
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
-
-static void __iomem *devm_cxl_iomap_block(struct device *dev,
-					  resource_size_t addr,
-					  resource_size_t length)
-{
-	void __iomem *ret_val;
-	struct resource *res;
-
-	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
-	if (!res) {
-		resource_size_t end = addr + length - 1;
-
-		dev_err(dev, "Failed to request region %pa-%pa\n", &addr, &end);
-		return NULL;
-	}
-
-	ret_val = devm_ioremap(dev, addr, length);
-	if (!ret_val)
-		dev_err(dev, "Failed to map region %pr\n", res);
-
-	return ret_val;
-}
-
-int cxl_map_component_regs(struct pci_dev *pdev,
-			   struct cxl_component_regs *regs,
-			   struct cxl_register_map *map)
-{
-	struct device *dev = &pdev->dev;
-	resource_size_t phys_addr;
-	resource_size_t length;
-
-	phys_addr = pci_resource_start(pdev, map->barno);
-	phys_addr += map->block_offset;
-
-	phys_addr += map->component_map.hdm_decoder.offset;
-	length = map->component_map.hdm_decoder.size;
-	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
-	if (!regs->hdm_decoder)
-		return -ENOMEM;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cxl_map_component_regs);
-
-int cxl_map_device_regs(struct pci_dev *pdev,
-			struct cxl_device_regs *regs,
-			struct cxl_register_map *map)
-{
-	struct device *dev = &pdev->dev;
-	resource_size_t phys_addr;
-
-	phys_addr = pci_resource_start(pdev, map->barno);
-	phys_addr += map->block_offset;
-
-	if (map->device_map.status.valid) {
-		resource_size_t addr;
-		resource_size_t length;
-
-		addr = phys_addr + map->device_map.status.offset;
-		length = map->device_map.status.size;
-		regs->status = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->status)
-			return -ENOMEM;
-	}
-
-	if (map->device_map.mbox.valid) {
-		resource_size_t addr;
-		resource_size_t length;
-
-		addr = phys_addr + map->device_map.mbox.offset;
-		length = map->device_map.mbox.size;
-		regs->mbox = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->mbox)
-			return -ENOMEM;
-	}
-
-	if (map->device_map.memdev.valid) {
-		resource_size_t addr;
-		resource_size_t length;
-
-		addr = phys_addr + map->device_map.memdev.offset;
-		length = map->device_map.memdev.size;
-		regs->memdev = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->memdev)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cxl_map_device_regs);
-
 /**
  * __cxl_driver_register - register a driver for the cxl bus
  * @cxl_drv: cxl driver structure to attach
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
new file mode 100644
index 000000000000..edf0f4d387ae
--- /dev/null
+++ b/drivers/cxl/core/regs.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <mem.h>
+
+/**
+ * cxl_probe_component_regs() - Detect CXL Component register blocks
+ * @dev: Host device of the @base mapping
+ * @base: Mapping containing the HDM Decoder Capability Header
+ * @map: Map object describing the register block information found
+ *
+ * See CXL 2.0 8.2.4 Component Register Layout and Definition
+ * See CXL 2.0 8.2.5.5 CXL Device Register Interface
+ *
+ * Probe for component register information and return it in map object.
+ */
+void cxl_probe_component_regs(struct device *dev, void __iomem *base,
+			      struct cxl_component_reg_map *map)
+{
+	int cap, cap_count;
+	u64 cap_array;
+
+	*map = (struct cxl_component_reg_map) { 0 };
+
+	/*
+	 * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
+	 * CXL 2.0 8.2.4 Table 141.
+	 */
+	base += CXL_CM_OFFSET;
+
+	cap_array = readq(base + CXL_CM_CAP_HDR_OFFSET);
+
+	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
+		dev_err(dev,
+			"Couldn't locate the CXL.cache and CXL.mem capability array header./n");
+		return;
+	}
+
+	/* It's assumed that future versions will be backward compatible */
+	cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_array);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		void __iomem *register_block;
+		u32 hdr;
+		int decoder_cnt;
+		u16 cap_id, offset;
+		u32 length;
+
+		hdr = readl(base + cap * 0x4);
+
+		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
+		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
+		register_block = base + offset;
+
+		switch (cap_id) {
+		case CXL_CM_CAP_CAP_ID_HDM:
+			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
+				offset);
+
+			hdr = readl(register_block);
+
+			decoder_cnt = cxl_hdm_decoder_count(hdr);
+			length = 0x20 * decoder_cnt + 0x10;
+
+			map->hdm_decoder.valid = true;
+			map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
+			map->hdm_decoder.size = length;
+			break;
+		default:
+			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
+				offset);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(cxl_probe_component_regs);
+
+/**
+ * cxl_probe_device_regs() - Detect CXL Device register blocks
+ * @dev: Host device of the @base mapping
+ * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
+ * @map: Map object describing the register block information found
+ *
+ * Probe for device register information and return it in map object.
+ */
+void cxl_probe_device_regs(struct device *dev, void __iomem *base,
+			   struct cxl_device_reg_map *map)
+{
+	int cap, cap_count;
+	u64 cap_array;
+
+	*map = (struct cxl_device_reg_map){ 0 };
+
+	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
+	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
+	    CXLDEV_CAP_ARRAY_CAP_ID)
+		return;
+
+	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		u32 offset, length;
+		u16 cap_id;
+
+		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
+				   readl(base + cap * 0x10));
+		offset = readl(base + cap * 0x10 + 0x4);
+		length = readl(base + cap * 0x10 + 0x8);
+
+		switch (cap_id) {
+		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
+			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
+
+			map->status.valid = true;
+			map->status.offset = offset;
+			map->status.size = length;
+			break;
+		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
+			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
+			map->mbox.valid = true;
+			map->mbox.offset = offset;
+			map->mbox.size = length;
+			break;
+		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
+			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
+			break;
+		case CXLDEV_CAP_CAP_ID_MEMDEV:
+			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
+			map->memdev.valid = true;
+			map->memdev.offset = offset;
+			map->memdev.size = length;
+			break;
+		default:
+			if (cap_id >= 0x8000)
+				dev_dbg(dev, "Vendor cap ID: %#x offset: %#x\n", cap_id, offset);
+			else
+				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
+
+static void __iomem *devm_cxl_iomap_block(struct device *dev,
+					  resource_size_t addr,
+					  resource_size_t length)
+{
+	void __iomem *ret_val;
+	struct resource *res;
+
+	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
+	if (!res) {
+		resource_size_t end = addr + length - 1;
+
+		dev_err(dev, "Failed to request region %pa-%pa\n", &addr, &end);
+		return NULL;
+	}
+
+	ret_val = devm_ioremap(dev, addr, length);
+	if (!ret_val)
+		dev_err(dev, "Failed to map region %pr\n", res);
+
+	return ret_val;
+}
+
+int cxl_map_component_regs(struct pci_dev *pdev,
+			   struct cxl_component_regs *regs,
+			   struct cxl_register_map *map)
+{
+	struct device *dev = &pdev->dev;
+	resource_size_t phys_addr;
+	resource_size_t length;
+
+	phys_addr = pci_resource_start(pdev, map->barno);
+	phys_addr += map->block_offset;
+
+	phys_addr += map->component_map.hdm_decoder.offset;
+	length = map->component_map.hdm_decoder.size;
+	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
+	if (!regs->hdm_decoder)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_map_component_regs);
+
+int cxl_map_device_regs(struct pci_dev *pdev,
+			struct cxl_device_regs *regs,
+			struct cxl_register_map *map)
+{
+	struct device *dev = &pdev->dev;
+	resource_size_t phys_addr;
+
+	phys_addr = pci_resource_start(pdev, map->barno);
+	phys_addr += map->block_offset;
+
+	if (map->device_map.status.valid) {
+		resource_size_t addr;
+		resource_size_t length;
+
+		addr = phys_addr + map->device_map.status.offset;
+		length = map->device_map.status.size;
+		regs->status = devm_cxl_iomap_block(dev, addr, length);
+		if (!regs->status)
+			return -ENOMEM;
+	}
+
+	if (map->device_map.mbox.valid) {
+		resource_size_t addr;
+		resource_size_t length;
+
+		addr = phys_addr + map->device_map.mbox.offset;
+		length = map->device_map.mbox.size;
+		regs->mbox = devm_cxl_iomap_block(dev, addr, length);
+		if (!regs->mbox)
+			return -ENOMEM;
+	}
+
+	if (map->device_map.memdev.valid) {
+		resource_size_t addr;
+		resource_size_t length;
+
+		addr = phys_addr + map->device_map.memdev.offset;
+		length = map->device_map.memdev.size;
+		regs->memdev = devm_cxl_iomap_block(dev, addr, length);
+		if (!regs->memdev)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_map_device_regs);

