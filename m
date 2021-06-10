Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86535C48BDF
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672B3613F1
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 21:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFJVzh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:55:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:59108 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhFJVzh (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 10 Jun 2021 17:55:37 -0400
IronPort-SDR: 1+91e4l2ddGxkxR6cwwVt7P4ekX7PKdMlRMHYWgpLP0+5fQXdA+XMJP4lns87wIGFu7NiGkQSE
 boURK6YHX7uQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185102366"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="185102366"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:53:40 -0700
IronPort-SDR: HJ4KjlG7DLAzRqRqtg4NBItQlVl+3GvXUB6WDOjbF5wJufKd+WH/6My8SUf+5yoPkWoCVNsL5f
 YgRfkuZdiXrw==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="414254917"
Received: from millers-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.140.70])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:53:40 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] cxl/hdm: Fix decoder count calculation
Date:   Thu, 10 Jun 2021 14:53:32 -0700
Message-Id: <20210610215332.991905-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The decoder count in the HDM decoder capability structure is an encoded
field. As defined in the spec:

Decoder Count: Reports the number of memory address decoders implemented
by the component.
0 – 1 Decoder
1 – 2 Decoders
2 – 4 Decoders
3 – 6 Decoders
4 – 8 Decoders
5 – 10 DecodersAll other values are reserved

Nothing is actually fixed by this as nothing actually used this mapping
yet.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core.c | 3 ++-
 drivers/cxl/cxl.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index cda09a9cd98e..92db02fe7aa8 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -666,7 +666,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 
 			hdr = readl(register_block);
 
-			decoder_cnt = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, hdr);
+			decoder_cnt =
+				cxl_hdm_decoder_count(FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, hdr));
 			length = 0x20 * decoder_cnt + 0x10;
 
 			map->hdm_decoder.valid = true;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1ffc5e07e24d..f0dff7d96286 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -35,6 +35,7 @@
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
+#define	    cxl_hdm_decoder_count(bits) ((bits) == 0 ? 1 : (bits) * 2)
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
 #define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
-- 
2.32.0

