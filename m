Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F0C4708B
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 00:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428FD61358
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 00:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhE1AvE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 May 2021 20:51:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:19710 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234417AbhE1AvD (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 May 2021 20:51:03 -0400
IronPort-SDR: UpgtKDeRoIakwCONjvdZXEAD6+h1d8XbOV4XAW50DfD4pD7wz/LrbtZT+S8/nsbuUDGDV1zKrM
 gg2bfmPuOGwg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="266753498"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="266753498"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:27 -0700
IronPort-SDR: NNIz5EfdTROmJDR/POA5Wc7SMsyHyub6zBhXw78VgQW5VVvgPQ3xn28BZ2hQiP4qk0bgHp38wN
 5uGyANdKcJCw==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="443791878"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:26 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/5] cxl/mem: Introduce cxl_decode_register_block()
Date:   Thu, 27 May 2021 17:49:18 -0700
Message-Id: <20210528004922.3980613-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210528004922.3980613-1-ira.weiny@intel.com>
References: <20210528004922.3980613-1-ira.weiny@intel.com>
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

