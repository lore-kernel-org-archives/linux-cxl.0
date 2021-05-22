Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C6C04FF3
	for <linux-cxl@archiver.kernel.org>; Sat, 22 May 2021 00:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7186138C
	for <linux-cxl@archiver.kernel.org>; Sat, 22 May 2021 00:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhEVANX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 May 2021 20:13:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:2007 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbhEVANW (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 21 May 2021 20:13:22 -0400
IronPort-SDR: 3CtZJ1SppyskY3nrOEaUrjItP4A4q2aP2ksI92XEK9pBU2K2fvih0FvtxOH5BTcANn99m6vuJP
 +CE3fjsL+GMw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188727597"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188727597"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 17:11:58 -0700
IronPort-SDR: BiyTmhFchCnfiGjSpMmsAoSp3DWtrrc4AwiV04RNZYiu1VPt72S8V899WkfJSWNK/ACIvTFLOB
 KjV5/9RIMc7w==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="631990649"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 17:11:56 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] cxl/mem: Introduce cxl_decode_register_block()
Date:   Fri, 21 May 2021 17:11:50 -0700
Message-Id: <20210522001154.2680157-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210522001154.2680157-1-ira.weiny@intel.com>
References: <20210522001154.2680157-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Each register block located in the DVSEC needs to be decoded from 2
words, 'register offset high' and 'register offset low'.

Create a function, cxl_decode_register_block() to perform this decode
and return the bar, offset, and register type of the register block.

Then use the values decoded in cxl_mem_map_regblock() instead of passing
the raw registers.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V2:
	Push this to the start of the series
---
 drivers/cxl/pci.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8bdae74d7d78..b2f978954daa 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -922,17 +922,13 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev)
 	return cxlm;
 }
 
-static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
+static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
+					  u8 bar, u64 offset)
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
-	u64 offset;
-	u8 bar;
 	int rc;
 
-	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
-	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
-
 	/* Basic sanity check that BAR is big enough */
 	if (pci_resource_len(pdev, bar) < offset) {
 		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
@@ -974,6 +970,14 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
+static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
+				      u8 *bar, u64 *offset, u8 *reg_type)
+{
+	*offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
+	*bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
+	*reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
+}
+
 /**
  * cxl_mem_setup_regs() - Setup necessary MMIO.
  * @cxlm: The CXL memory device to communicate with.
@@ -1009,15 +1013,21 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	for (i = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
 		u8 reg_type;
+		u64 offset;
+		u8 bar;
 
 		/* "register low and high" contain other bits */
 		pci_read_config_dword(pdev, regloc, &reg_lo);
 		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
 
-		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
+		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
+					  &reg_type);
+
+		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
+			bar, offset, reg_type);
 
 		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
-			base = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
+			base = cxl_mem_map_regblock(cxlm, bar, offset);
 			if (IS_ERR(base))
 				return PTR_ERR(base);
 			break;
-- 
2.28.0.rc0.12.gb6a658bd00c9

