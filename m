Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD76BC25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 21:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbiHQVVu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 17:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiHQVVt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 17:21:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB5A598F
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660771308; x=1692307308;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5A5/0jZL3pefKsVIXlqpe6/p+MZ4LA78/Xko9r/ywCg=;
  b=I/+cBoAGAdiTgQ6BVO93TtS0Gpx7AK1U+NgF4u6mNmE840V/H4CzAy74
   6Nj9gv5zr421Wms0Q8OdHYJ9IwN2H77v+qVSq1EdoHYfwxtfIVA0Da1P5
   udMVPjaNpjTXBM/2yZTlAIUhRfOsXLdf1RhvbxpPZg6IxHVIurYx/L7A5
   9WbnzdQNZhdLJMs8r7hEO9yV+9I/cXg4kNAep51/V9FQdVMHR5DfoLuUf
   GOeywLJa4pDO4LSEK2u9/KKqIml7xh7723VbJqFidDt85mImEP8Qxef9f
   5KB8XCPeY1HIhyHTQ8kAsvVKsETn8cKV1H9Tb8cUU3OT/PyUwqLeiKzFr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="290174237"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="290174237"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="935530000"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:48 -0700
Subject: [PATCH v4 2/6] cxl: Add CXL spec v3.0 interleave support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 17 Aug 2022 14:21:48 -0700
Message-ID: <166077130837.1743055.16772443540776610507.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
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

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c    |    6 ++++++
 drivers/cxl/core/region.c |    3 +++
 drivers/cxl/cxl.h         |    2 ++
 drivers/cxl/cxlmem.h      |    5 +++++
 4 files changed, 16 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..2f91ff9b0227 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -80,6 +80,12 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(11, 8);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
+
+	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_DEFAULT;
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
+		cxlhdm->interleave_cap |= CXL_HDM_INTERLEAVE_CAP_3_6_12;
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
+		cxlhdm->interleave_cap |= CXL_HDM_INTERLEAVE_CAP_16;
 }
 
 static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 28272b0196e6..9851ab2782f2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -960,6 +960,9 @@ static int cxl_interleave_capable(struct cxl_port *port, struct device *dev,
 	if (eiw == 0)
 		return 0;
 
+	if (!test_bit(ways, &cxlhdm->interleave_cap))
+		return -EINVAL;
+
 	if (is_power_of_2(eiw))
 		addr_mask = GENMASK(eig + 8 + eiw - 1, eig + 8);
 	else
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..11f2a14f42eb 100644
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
index 88e3a8e54b6a..4e65c9cc1d30 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -393,11 +393,16 @@ static inline void cxl_mem_active_dec(void)
 }
 #endif
 
+#define CXL_HDM_INTERLEAVE_CAP_DEFAULT BIT(1) | BIT(2) | BIT(4) | BIT(8)
+#define CXL_HDM_INTERLEAVE_CAP_3_6_12 BIT(3) | BIT(6) | BIT(12)
+#define CXL_HDM_INTERLEAVE_CAP_16 BIT(16)
+
 struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
 	unsigned int target_count;
 	unsigned int interleave_mask;
+	unsigned long interleave_cap;
 	struct cxl_port *port;
 };
 


