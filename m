Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E407AC433ED
	for <linux-cxl@archiver.kernel.org>; Thu,  6 May 2021 22:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5034613B5
	for <linux-cxl@archiver.kernel.org>; Thu,  6 May 2021 22:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhEFWiL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 May 2021 18:38:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:7715 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhEFWiK (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 6 May 2021 18:38:10 -0400
IronPort-SDR: I1LhFAC+k5WsX5HVAxonjIz+MyIzNFquyTOWXeDLO2sVOaGTPK5Z8i8eVPevqjQCH8EytoR4DM
 kvP5DRwb24ow==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="185726267"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="185726267"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:37:10 -0700
IronPort-SDR: lrsSp+RXpFD1W1E/w335wMHAvegV0TxG/bPWkiDEuBGClcfSRuPwTUI/ZzjmqXVtgLwEnaO7lC
 5hDoCvLaAP1w==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="622630595"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:37:10 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] cxl/mem: Fully decode device capability header
Date:   Thu,  6 May 2021 15:36:51 -0700
Message-Id: <20210506223654.1310516-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210506223654.1310516-1-ira.weiny@intel.com>
References: <20210506223654.1310516-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Previously only the capability ID and offset were decoded.

Create a version MASK and decode the additional version and length
fields of the header.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core.c | 15 ++++++++++++---
 drivers/cxl/cxl.h  |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index b3c3532b53f7..21553386e218 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -501,12 +501,21 @@ void cxl_setup_device_regs(struct device *dev, void __iomem *base,
 
 	for (cap = 1; cap <= cap_count; cap++) {
 		void __iomem *register_block;
-		u32 offset;
+		u32 hdr, offset, __maybe_unused length;
 		u16 cap_id;
+		u8 version;
+
+		hdr = readl(base + cap * 0x10);
+
+		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK, hdr);
+		version = FIELD_GET(CXLDEV_CAP_HDR_VERSION_MASK, hdr);
+		if (version != 1)
+			dev_err(dev, "Vendor cap ID: %x incorrect version (0x%x)\n",
+				cap_id, version);
 
-		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
-				   readl(base + cap * 0x10));
 		offset = readl(base + cap * 0x10 + 0x4);
+		length = readl(base + cap * 0x10 + 0x8);
+
 		register_block = base + offset;
 
 		switch (cap_id) {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0211f44c95a2..9b315c069557 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -15,6 +15,7 @@
 #define   CXLDEV_CAP_ARRAY_COUNT_MASK GENMASK_ULL(47, 32)
 /* CXL 2.0 8.2.8.2 CXL Device Capability Header Register */
 #define CXLDEV_CAP_HDR_CAP_ID_MASK GENMASK(15, 0)
+#define CXLDEV_CAP_HDR_VERSION_MASK GENMASK(23, 16)
 /* CXL 2.0 8.2.8.2.1 CXL Device Capabilities */
 #define CXLDEV_CAP_CAP_ID_DEVICE_STATUS 0x1
 #define CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX 0x2
-- 
2.28.0.rc0.12.gb6a658bd00c9

