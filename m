Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A144CC43217
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiA0V3h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:29:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:30536 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235091AbiA0V3g (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 Jan 2022 16:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643318976; x=1674854976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hnTws23roenYnf9FuTxI5kIVmD5micpi0QGZFv8KyLc=;
  b=jY3YUb/YbFcQ9QxD4MuSJ9tHoz3ZkNNh/5sP53k6gNxpKBUYP5E/WFMk
   atQq//X5IjVhEbSBDYolY7HMdiFNSzMBKKJaRR+AIDhARVE6CUA/V7zMt
   I3sOWWio/2rgGg6s8HcMwjVouTezLVnFbXUDID9zc0Hrxh3yn6gV9sgoD
   DTyyNe7H8anbIXtZQIy1jZcbgzRo58B4suC/VvwCLm8F0AjcBN4XaaUj7
   NwS4WK/t+jPf9NoE5dxhfx9qWHSDVAfDRGZ4iWj9FkInCgpaNH5cl9aEu
   3ZvesGhaAIXh2CQZ8yLKwG6FDn9OjcIT4X/q5+gJaYbF+mMmTvBwSNuUU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246914536"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="246914536"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:29:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="521402193"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:29:32 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 3/4] cxl/core: Extract IW/IG decoding
Date:   Thu, 27 Jan 2022 13:29:10 -0800
Message-Id: <20220127212911.127741-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127212911.127741-1-ben.widawsky@intel.com>
References: <20220127212911.127741-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Interleave granularity and ways have specification defined encodings.
Extracting this functionality into the common header file allows other
consumers to make use of it.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---

I'm in favor of making these helps part of UABI. Having userspace and
kernel disagree (because of differing spec versions for example) would
be difficult to manage.

Thoughts?
---
 drivers/cxl/core/hdm.c | 11 ++---------
 drivers/cxl/cxl.h      | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4955ba16c9c8..a28369f264da 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -133,21 +133,14 @@ static int to_interleave_granularity(u32 ctrl)
 {
 	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
 
-	return 256 << val;
+	return cxl_to_interleave_granularity(val);
 }
 
 static int to_interleave_ways(u32 ctrl)
 {
 	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
 
-	switch (val) {
-	case 0 ... 4:
-		return 1 << val;
-	case 8 ... 10:
-		return 3 << (val - 8);
-	default:
-		return 0;
-	}
+	return cxl_to_interleave_ways(val);
 }
 
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 962629c5775f..13fb06849199 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -64,6 +64,23 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 	return val ? val * 2 : 1;
 }
 
+static inline int cxl_to_interleave_granularity(u16 ig)
+{
+	return 256 << ig;
+}
+
+static inline int cxl_to_interleave_ways(u8 eniw)
+{
+	switch (eniw) {
+	case 0 ... 4:
+		return 1 << eniw;
+	case 8 ... 10:
+		return 3 << (eniw - 8);
+	default:
+		return 0;
+	}
+}
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
-- 
2.35.0

