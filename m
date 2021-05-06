Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1EAC433ED
	for <linux-cxl@archiver.kernel.org>; Thu,  6 May 2021 22:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BECE61289
	for <linux-cxl@archiver.kernel.org>; Thu,  6 May 2021 22:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhEFWiR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 May 2021 18:38:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:7720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231288AbhEFWiP (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 6 May 2021 18:38:15 -0400
IronPort-SDR: aTj69W2eFU02dEBSd61sHkrUN0CT8ar4kPvn252WLJgraXcDy/OFA9yXomvhhiCdAi2l/VS6pH
 mFtLelsLseBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="185726278"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="185726278"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:37:14 -0700
IronPort-SDR: 77lX7bN9If9vdrUzhVqvPDyz4SdSKt7UglqFKfc+8LEFf7cj07bS8c/hdU4seLzjqcrz7T9Xlg
 tXRClt7RDyNg==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="622630623"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:37:14 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] cxl/mem: Map registers based on capabilities
Date:   Thu,  6 May 2021 15:36:54 -0700
Message-Id: <20210506223654.1310516-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210506223654.1310516-1-ira.weiny@intel.com>
References: <20210506223654.1310516-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The information required to map registers based on capabilities is
contained within the bars themselves.  This means the bar must be mapped
to read the information needed and then unmapped to map the individual
parts of the BAR based on capabilities.

Change cxl_setup_device_regs() to return a register map, change the
name to cxl_probe_device_regs().  Allocate and place these register maps
on a list while processing each register block.

After probing all blocks go back to map the individual registers blocks
as specified in the map and free the maps created.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core.c |  73 ++++++++++++++++++++++-------
 drivers/cxl/cxl.h  |  33 ++++++++++++--
 drivers/cxl/pci.c  | 111 ++++++++++++++++++++++++++++++++++++---------
 3 files changed, 175 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 21553386e218..b8c7ca9d3203 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/pci.h>
 #include "cxl.h"
 
 /**
@@ -479,18 +480,13 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_port);
 
-/*
- * cxl_setup_device_regs() - Detect CXL Device register blocks
- * @dev: Host device of the @base mapping
- * @base: mapping of CXL 2.0 8.2.8 CXL Device Register Interface
- */
-void cxl_setup_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_regs *regs)
+void cxl_probe_device_regs(struct device *dev, void __iomem *base,
+			   struct cxl_device_reg_map *map)
 {
 	int cap, cap_count;
 	u64 cap_array;
 
-	*regs = (struct cxl_device_regs) { 0 };
+	*map = (struct cxl_device_reg_map){ 0 };
 
 	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
 	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
@@ -500,8 +496,7 @@ void cxl_setup_device_regs(struct device *dev, void __iomem *base,
 	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
 
 	for (cap = 1; cap <= cap_count; cap++) {
-		void __iomem *register_block;
-		u32 hdr, offset, __maybe_unused length;
+		u32 hdr, offset, length;
 		u16 cap_id;
 		u8 version;
 
@@ -516,23 +511,28 @@ void cxl_setup_device_regs(struct device *dev, void __iomem *base,
 		offset = readl(base + cap * 0x10 + 0x4);
 		length = readl(base + cap * 0x10 + 0x8);
 
-		register_block = base + offset;
-
 		switch (cap_id) {
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
-			regs->status = register_block;
+
+			map->status.valid = true;
+			map->status.offset = offset;
+			map->status.size = length;
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
-			regs->mbox = register_block;
+			map->mbox.valid = true;
+			map->mbox.offset = offset;
+			map->mbox.size = length;
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
 			break;
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
-			regs->memdev = register_block;
+			map->memdev.valid = true;
+			map->memdev.offset = offset;
+			map->memdev.size = length;
 			break;
 		default:
 			if (cap_id > 0x8000)
@@ -543,7 +543,48 @@ void cxl_setup_device_regs(struct device *dev, void __iomem *base,
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(cxl_setup_device_regs);
+EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
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
+		regs->status = devm_ioremap(dev, addr, length);
+	}
+
+	if (map->device_map.mbox.valid) {
+		resource_size_t addr;
+		resource_size_t length;
+
+		addr = phys_addr + map->device_map.mbox.offset;
+		length = map->device_map.mbox.size;
+		regs->mbox = devm_ioremap(dev, addr, length);
+	}
+
+	if (map->device_map.memdev.valid) {
+		resource_size_t addr;
+		resource_size_t length;
+
+		addr = phys_addr + map->device_map.memdev.offset;
+		length = map->device_map.memdev.size;
+		regs->memdev = devm_ioremap(dev, addr, length);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_map_device_regs);
 
 struct bus_type cxl_bus_type = {
 	.name = "cxl",
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9b315c069557..afc18ee89795 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -55,9 +55,7 @@ struct cxl_device_regs {
 /*
  * Note, the anonymous union organization allows for per
  * register-block-type helper routines, without requiring block-type
- * agnostic code to include the prefix. I.e.
- * cxl_setup_device_regs(&cxlm->regs.dev) vs readl(cxlm->regs.mbox).
- * The specificity reads naturally from left-to-right.
+ * agnostic code to include the prefix.
  */
 struct cxl_regs {
 	union {
@@ -68,8 +66,33 @@ struct cxl_regs {
 	};
 };
 
-void cxl_setup_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_regs *regs);
+struct cxl_reg_map {
+	bool valid;
+	unsigned long offset;
+	unsigned long size;
+};
+
+struct cxl_device_reg_map {
+	struct cxl_reg_map status;
+	struct cxl_reg_map mbox;
+	struct cxl_reg_map memdev;
+};
+
+struct cxl_register_map {
+	struct list_head list;
+	u64 block_offset;
+	u8 reg_type;
+	u8 barno;
+	union {
+		struct cxl_device_reg_map device_map;
+	};
+};
+
+void cxl_probe_device_regs(struct device *dev, void __iomem *base,
+			   struct cxl_device_reg_map *map);
+int cxl_map_device_regs(struct pci_dev *pdev,
+			struct cxl_device_regs *regs,
+			struct cxl_register_map *map);
 
 /*
  * Address space properties derived from:
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index cee14de0f251..97361c0e8a32 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/mutex.h>
+#include <linux/list.h>
 #include <linux/cdev.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
@@ -936,7 +937,7 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
 		return (void __iomem *)ERR_PTR(-ENXIO);
 	}
 
-	rc = pcim_iomap(pdev, bar, 0);
+	rc = pci_iomap(pdev, bar, 0);
 	if (!rc) {
 		dev_err(dev, "failed to map registers\n");
 		return (void __iomem *)ERR_PTR(-ENOMEM);
@@ -945,7 +946,12 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
 	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ 0x%llx\n",
 		bar, offset);
 
-	return pcim_iomap_table(pdev)[bar] + offset;
+	return rc;
+}
+
+static void cxl_mem_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
+{
+	pci_iounmap(cxlm->pdev, base);
 }
 
 static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
@@ -971,6 +977,52 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
+static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
+			  struct cxl_register_map *map)
+{
+	struct pci_dev *pdev = cxlm->pdev;
+	struct device *dev = &pdev->dev;
+	struct cxl_device_reg_map *dev_map;
+
+	switch (map->reg_type) {
+	case CXL_REGLOC_RBI_MEMDEV:
+		dev_map = &map->device_map;
+		cxl_probe_device_regs(dev, base, dev_map);
+		if (!dev_map->status.valid || !dev_map->mbox.valid ||
+		    !dev_map->memdev.valid) {
+			dev_err(dev, "registers not found: %s%s%s\n",
+				!dev_map->status.valid ? "status " : "",
+				!dev_map->mbox.valid ? "status " : "",
+				!dev_map->memdev.valid ? "status " : "");
+			return -ENXIO;
+		}
+
+		dev_dbg(dev, "Probing device registers...\n");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
+{
+	struct pci_dev *pdev = cxlm->pdev;
+	struct device *dev = &pdev->dev;
+
+	switch (map->reg_type) {
+	case CXL_REGLOC_RBI_MEMDEV:
+		cxl_map_device_regs(pdev, &cxlm->regs.device_regs, map);
+		dev_dbg(dev, "Probing device registers...\n");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
 				      u8 *bar, u64 *offset, u8 *reg_type)
 {
@@ -991,12 +1043,14 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
  */
 static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 {
-	struct cxl_regs *regs = &cxlm->regs;
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
 	u32 regloc_size, regblocks;
 	void __iomem *base;
 	int regloc, i;
+	struct cxl_register_map *map, *n;
+	LIST_HEAD(register_maps);
+	int ret = 0;
 
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
 	if (!regloc) {
@@ -1020,7 +1074,14 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		u64 offset;
 		u8 bar;
 
-		/* "register low and high" contain other bits */
+		map = kzalloc(sizeof(*map), GFP_KERNEL);
+		if (!map) {
+			ret = -ENOMEM;
+			goto free_maps;
+		}
+
+		list_add(&map->list, &register_maps);
+
 		pci_read_config_dword(pdev, regloc, &reg_lo);
 		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
 
@@ -1030,30 +1091,38 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
 			bar, offset, reg_type);
 
-		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
-			base = cxl_mem_map_regblock(cxlm, bar, offset);
-			if (IS_ERR(base))
-				return PTR_ERR(base);
-			break;
+		base = cxl_mem_map_regblock(cxlm, bar, offset);
+		if (IS_ERR(base)) {
+			ret = PTR_ERR(base);
+			goto free_maps;
 		}
-	}
 
-	if (i == regblocks) {
-		dev_err(dev, "Missing register locator for device registers\n");
-		return -ENXIO;
+		map->barno = bar;
+		map->block_offset = offset;
+		map->reg_type = reg_type;
+
+		ret = cxl_probe_regs(cxlm, base + offset, map);
+
+		/* Always unmap the regblock regardless of probe success */
+		cxl_mem_unmap_regblock(cxlm, base);
+
+		if (ret)
+			goto free_maps;
 	}
 
-	cxl_setup_device_regs(dev, base, &regs->device_regs);
+	list_for_each_entry(map, &register_maps, list) {
+		ret = cxl_map_regs(cxlm, map);
+		if (ret)
+			goto free_maps;
+	}
 
-	if (!regs->status || !regs->mbox || !regs->memdev) {
-		dev_err(dev, "registers not found: %s%s%s\n",
-			!regs->status ? "status " : "",
-			!regs->mbox ? "mbox " : "",
-			!regs->memdev ? "memdev" : "");
-		return -ENXIO;
+free_maps:
+	list_for_each_entry_safe(map, n, &register_maps, list) {
+		list_del(&map->list);
+		kfree(map);
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct cxl_memdev *to_cxl_memdev(struct device *dev)
-- 
2.28.0.rc0.12.gb6a658bd00c9

