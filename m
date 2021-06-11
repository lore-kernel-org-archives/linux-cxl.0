Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F2FC48BE5
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 19:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19F7613D3
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 19:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFKTDY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 15:03:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:53659 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhFKTDX (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 11 Jun 2021 15:03:23 -0400
IronPort-SDR: PhN5osVQPXhmQ4ukuWYOu9lY3Z7sdc0ahgzINHOheHYjnHj2tQBP8FavMexbZCcpA2ZKwpxuIi
 29Ckwrc6qxCQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205548493"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="205548493"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 12:01:22 -0700
IronPort-SDR: ZAzsywYcVc/O4gfdcWZaEGoricTlz7ZOi3kknhN1im4rx1yIBd4pT9CEJ827DtRZSQZVqA8BrK
 hT7QvXZ9qCjA==
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="403097380"
Received: from chtanaka-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.239])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 12:01:22 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] cxl/hdm: Fix decoder count calculation
Date:   Fri, 11 Jun 2021 12:01:11 -0700
Message-Id: <20210611190111.121295-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610215332.991905-1-ben.widawsky@intel.com>
References: <20210610215332.991905-1-ben.widawsky@intel.com>
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
5 – 10 Decoders
All other values are reserved

Nothing is actually fixed by this as nothing actually used this mapping
yet.

Cc: Ira Weiny <ira.weiny@intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
v2:
- Minor whitespace cleanup in commit message.
- Move value decoder to inline function. (Dan)
- Rework value decoding logic to be more concise.
---
 drivers/cxl/core.c | 2 +-
 drivers/cxl/cxl.h  | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 6db660249cea..49744ad885de 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -603,7 +603,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 
 			hdr = readl(register_block);
 
-			decoder_cnt = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, hdr);
+			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 
 			map->hdm_decoder.valid = true;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3f9a6f7b05db..f1e52487c644 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -42,6 +42,13 @@
 #define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
 #define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
 
+static inline int cxl_hdm_decoder_count(u32 cap_hdr)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
+
+	return val ? val * 2 : 1;
+}
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
-- 
2.32.0

