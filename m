Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B965CC2B9F4
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CFD613B9
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhFRAcZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:32:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:16212 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232683AbhFRAcZ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 20:32:25 -0400
IronPort-SDR: wKTdXKCaB2p+MB92BYS7Ta5riTb4dV6Aq2dNQs6FCKp/4ju4GSZSeuJutD5t2Wjk5IGOTSTslx
 GenCP8fYLcjA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206510674"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="206510674"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:30:16 -0700
IronPort-SDR: LY6OuxQ9oKfABhnFoDyaOdp2QKdo7YyFglmoUw+V+0McHVqNV/fyEztNXuDG3b4YrxVo24S6a1
 qV3B+4sVQldg==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="479642429"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:30:16 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] cxl/pci: Rename CXL REGLOC ID
Date:   Thu, 17 Jun 2021 17:30:09 -0700
Message-Id: <20210618003009.956929-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The current naming is confusing and wrong. The Register Locator is
identified by the DSVSEC identifier, not an offset.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 2 +-
 drivers/cxl/pci.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f8408e5f0754..4cf351a3cf99 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1086,7 +1086,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	LIST_HEAD(register_maps);
 	int ret = 0;
 
-	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
+	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
 	if (!regloc) {
 		dev_err(dev, "register location dvsec not found\n");
 		return -ENXIO;
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index af3ec078cf6c..dad7a831f65f 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -13,7 +13,7 @@
 #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
 #define PCI_DVSEC_ID_CXL		0x0
 
-#define PCI_DVSEC_ID_CXL_REGLOC_OFFSET		0x8
+#define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
 #define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
 
 /* BAR Indicator Register (BIR) */
-- 
2.32.0

