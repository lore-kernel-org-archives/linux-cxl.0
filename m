Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E7DC43217
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 18:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiDMSkP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbiDMSkO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 14:40:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410A1532CE
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649875072; x=1681411072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZwNEpFjzgDKXYjZD1HIgwd1pFDMWLxI8kgblOJUA2nE=;
  b=PFeWKcJsl7An0pyyANqp4Kksp1h2eDs7JoAMbC5HGR0cGAe80rYUxQWs
   i0k6fNz2l9ApbjdD3T/4XIA4UnWswfyi1pX0izuun6YxemcENdyQoM3sP
   IS1K2kW1/MuqglE3aZ/fwstzWVcmxMKKk+020pgQ5o058HFR7AVisGTbA
   pvzxqhsToCCxZ8SgP/hIN8Cp0ibpMQ3KzJIx/vhmNoTms9mqiEHN0NOJV
   zxgBxw4WGAbeo70KomAmyNyZZElw0Br5OK33qv2Y2do9M5UorvXae7fvU
   j5fZK/6p7kRYu/MPC9mwwUXXGkb3ImASq1xLLzZZ99soiYYmP8l9SSmeh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262497747"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262497747"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725013614"
Received: from sushobhi-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.131.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:50 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 10/15] cxl/core: Extract IW/IG decoding
Date:   Wed, 13 Apr 2022 11:37:15 -0700
Message-Id: <20220413183720.2444089-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413183720.2444089-1-ben.widawsky@intel.com>
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
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
 drivers/cxl/core/hdm.c | 11 ++---------
 drivers/cxl/cxl.h      | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 5326a2cd6968..b4b65aa55bd2 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -134,21 +134,14 @@ static int to_interleave_granularity(u32 ctrl)
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
index 07df13f05d3d..0586c3d4592c 100644
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
2.35.1

