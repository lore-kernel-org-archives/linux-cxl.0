Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC217C636CA
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jul 2021 23:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4890613DF
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jul 2021 23:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbhGPXTB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jul 2021 19:19:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:65194 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237660AbhGPXS5 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 16 Jul 2021 19:18:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="190479027"
X-IronPort-AV: E=Sophos;i="5.84,246,1620716400"; 
   d="scan'208";a="190479027"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 16:16:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,246,1620716400"; 
   d="scan'208";a="431362193"
Received: from jhiga-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.135.195])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 16:16:00 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/3] cxl/pci: Simplify register setup
Date:   Fri, 16 Jul 2021 16:15:47 -0700
Message-Id: <20210716231548.174778-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716231548.174778-1-ben.widawsky@intel.com>
References: <20210716231548.174778-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

It is desirable to retain the mappings from the calling function. By
simplifying this code, it will be much more straightforward to do that.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h |  1 -
 drivers/cxl/pci.c | 38 ++++++++++++--------------------------
 drivers/cxl/pci.h |  1 +
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6bda39a59e3..53927f9fa77e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -140,7 +140,6 @@ struct cxl_device_reg_map {
 };
 
 struct cxl_register_map {
-	struct list_head list;
 	u64 block_offset;
 	u8 reg_type;
 	u8 barno;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index dd0ac89fbdf4..8be18daa1420 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1079,9 +1079,8 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	struct device *dev = &pdev->dev;
 	u32 regloc_size, regblocks;
 	void __iomem *base;
-	int regloc, i;
-	struct cxl_register_map *map, *n;
-	LIST_HEAD(register_maps);
+	int regloc, i, n_maps;
+	struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
 	int ret = 0;
 
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
@@ -1100,7 +1099,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
 	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
 
-	for (i = 0; i < regblocks; i++, regloc += 8) {
+	for (i = 0, n_maps = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
 		u8 reg_type;
 		u64 offset;
@@ -1119,20 +1118,11 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
 			continue;
 
-		map = kzalloc(sizeof(*map), GFP_KERNEL);
-		if (!map) {
-			ret = -ENOMEM;
-			goto free_maps;
-		}
-
-		list_add(&map->list, &register_maps);
-
 		base = cxl_mem_map_regblock(cxlm, bar, offset);
-		if (!base) {
-			ret = -ENOMEM;
-			goto free_maps;
-		}
+		if (!base)
+			return -ENOMEM;
 
+		map = &maps[n_maps];
 		map->barno = bar;
 		map->block_offset = offset;
 		map->reg_type = reg_type;
@@ -1143,21 +1133,17 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		cxl_mem_unmap_regblock(cxlm, base);
 
 		if (ret)
-			goto free_maps;
+			return ret;
+
+		n_maps++;
 	}
 
 	pci_release_mem_regions(pdev);
 
-	list_for_each_entry(map, &register_maps, list) {
-		ret = cxl_map_regs(cxlm, map);
+	for (i = 0; i < n_maps; i++) {
+		ret = cxl_map_regs(cxlm, &maps[i]);
 		if (ret)
-			goto free_maps;
-	}
-
-free_maps:
-	list_for_each_entry_safe(map, n, &register_maps, list) {
-		list_del(&map->list);
-		kfree(map);
+			break;
 	}
 
 	return ret;
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index dad7a831f65f..8c1a58813816 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -25,6 +25,7 @@
 #define CXL_REGLOC_RBI_COMPONENT 1
 #define CXL_REGLOC_RBI_VIRT 2
 #define CXL_REGLOC_RBI_MEMDEV 3
+#define CXL_REGLOC_RBI_TYPES CXL_REGLOC_RBI_MEMDEV + 1
 
 #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
 
-- 
2.32.0

