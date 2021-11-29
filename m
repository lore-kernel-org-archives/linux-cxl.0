Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901DCC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 21:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhK2V4H (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:56:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:47152 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhK2VyD (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 16:54:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222968501"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222968501"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458596085"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.141.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:25 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/9] cxl: Flesh out register names
Date:   Mon, 29 Nov 2021 13:47:14 -0800
Message-Id: <20211129214721.1668325-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129214721.1668325-1-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Get a better naming scheme in place for upcoming additions. By dropping
redundant usages of CXL and DVSEC where appropriate we can get more
concise and also more grepable defines.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 14 +++++++-------
 drivers/cxl/pci.h | 19 ++++++++++---------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8dc91fd3396a..a6ea9811a05b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -403,10 +403,10 @@ static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *ma
 static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
 				struct cxl_register_map *map)
 {
-	map->block_offset =
-		((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
-	map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
-	map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
+	map->block_offset = ((u64)reg_hi << 32) |
+			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
 }
 
 /**
@@ -427,15 +427,15 @@ static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 	int regloc, i;
 
 	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
-					   PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
+					   CXL_DVSEC_REG_LOCATOR);
 	if (!regloc)
 		return -ENXIO;
 
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
 
-	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
-	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
+	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
+	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
 
 	for (i = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 7d3e4bf06b45..29b8eaef3a0a 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -7,17 +7,21 @@
 
 /*
  * See section 8.1 Configuration Space Registers in the CXL 2.0
- * Specification
+ * Specification. Names are taken straight from the specification with "CXL" and
+ * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
  */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
 #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
-#define PCI_DVSEC_ID_CXL		0x0
 
-#define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
-#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE					0
 
-/* BAR Indicator Register (BIR) */
-#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
+/* CXL 2.0 8.1.9: Register Locator DVSEC */
+#define CXL_DVSEC_REG_LOCATOR					8
+#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
+#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
+#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
+#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
 
 /* Register Block Identifier (RBI) */
 enum cxl_regloc_type {
@@ -28,7 +32,4 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_TYPES
 };
 
-#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
-#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
-
 #endif /* __CXL_PCI_H__ */
-- 
2.34.1

