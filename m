Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BB2C00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 21:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiHHVHG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiHHVHD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 17:07:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6809013D19
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659992823; x=1691528823;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wRfMdynpyHtgzPN7sbP0/GpsoE7zm+/qTVu+XWbn+js=;
  b=WjPPXLgNAAFKMxwFzZi0m1QhN3J2GEhiK7k+YmbdQ5ezP1KRbliC7LsU
   W9EFq2qFEYzJaB4L4+cRT5w/dvs1/SotEOqAMwhCMjqwfxmmIc8MiK9vq
   IAzJi34YJyH6fKythKjufFfDGmsvg7T5J4MoYy9u0A0Q0sJAJAORvWT9l
   vH1h2qlpJdpS5kqJRa3RY1Uo+v1pKB2S4/jPl8pIAUyzCcO1iNDVwwTjm
   Zgb2STS2AO5RfI66ReJzJA2Tf/bwNDetNGqQe+bHYoKDD3tZuSVKjypoB
   Ko8Vfvf4e2fM6T7fPy4g+kOc2jeFuKdcV+QmtKIHP0pFQVN9wlkmBUDYq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="376984892"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="376984892"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:07:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="555080261"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:07:02 -0700
Subject: [PATCH 2/3] cxl: Add CXL spec v3.0 interleave support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 Aug 2022 14:07:02 -0700
Message-ID: <165999282258.493131.2782730417677035484.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL spec v3.0 added 2 CAP bits to the CXL HDM Decoder Capability Register.
CXL spec v3.0 8.2.4.19.1. Bit 11 indicates that 3, 6, and 12 way interleave
is capable. Bit 12 indicates that 16 way interleave is capable.

Add code to parse_hdm_decoder_caps() to cache those new bits. Add check in
cxl_interleave_verify() call to make sure those CAP bits matches the passed
in interleave value.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c |    4 ++++
 drivers/cxl/cxl.h      |    2 ++
 drivers/cxl/cxlmem.h   |   29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 8143e2615957..50ff7387e425 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -80,6 +80,10 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(11, 8);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
+		cxlhdm->interleave_3_6_12 = true;
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
+		cxlhdm->interleave_16 = true;
 }
 
 static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 275979fbd15a..db9631d09dd0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -42,6 +42,8 @@
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
 #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE BIT(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d5f872ca62f9..9b4b23b3b78a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -398,9 +398,35 @@ struct cxl_hdm {
 	unsigned int decoder_count;
 	unsigned int target_count;
 	unsigned int interleave_mask;
+	bool interleave_3_6_12;
+	bool interleave_16;
 	struct cxl_port *port;
 };
 
+static inline bool valid_interleave(struct cxl_hdm *cxlhdm, u8 iw)
+{
+	switch (iw) {
+	case CXL_INTERLEAVE_1_WAY:
+	case CXL_INTERLEAVE_2_WAY:
+	case CXL_INTERLEAVE_4_WAY:
+	case CXL_INTERLEAVE_8_WAY:
+		return true;
+	case CXL_INTERLEAVE_16_WAY:
+		if (!cxlhdm->interleave_16)
+			return false;
+		return true;
+	case CXL_INTERLEAVE_3_WAY:
+	case CXL_INTERLEAVE_6_WAY:
+	case CXL_INTERLEAVE_12_WAY:
+		if (!cxlhdm->interleave_3_6_12)
+			return false;
+		return true;
+	default:
+	};
+
+	return false;
+}
+
 static inline int cxl_interleave_verify(struct cxl_port *port,
 					int ways, int granularity)
 {
@@ -421,6 +447,9 @@ static inline int cxl_interleave_verify(struct cxl_port *port,
 	if (iw == 0)
 		return 0;
 
+	if (!valid_interleave(cxlhdm, iw))
+		return -EINVAL;
+
 	if (iw < CXL_INTERLEAVE_3_WAY)
 		addr_mask = GENMASK(ig + 8 + iw - 1, ig + 8);
 	else


