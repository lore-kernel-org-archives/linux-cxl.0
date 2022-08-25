Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E4BECAA24
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Aug 2022 16:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiHYQKH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiHYQKD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 Aug 2022 12:10:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406042AD2
        for <linux-cxl@vger.kernel.org>; Thu, 25 Aug 2022 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661443801; x=1692979801;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOn5tDL/NpkJCOZ67v5SJGP9AwKI4TY1zvxfD41LEng=;
  b=Dfg6TRSNfjoXu6jL8ESKjBPX4LQUtMcEUGAZSeSHPFinWpo5aOE1Qf7q
   V+NuT1SghI2td0FVXNycfFFxZbyxj3BNdIkZ+5X9qCnkNgjjp9S+6pN0P
   rs7qyeu/UvnfcIEEIUsRQOra6gjPwzI0ggE0x7nom8DvTJdpqBuy64Qhq
   3ds1LMANaUIWOBLZVzv7XFaF2Y0szYcatpn7xDuVZoEFY4GZtXg6YV75v
   kZwotQtecNfNEVvTnGoEkhe7xSHct3stSmolj7aAFhk0f4wxi4z7+mzu6
   KZxKahZTHtQW7M/AtrU+sMGWN4h89wm4421gMVvUoCmwaH7LUVZxHIu5e
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320362968"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="320362968"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="678517822"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:46 -0700
Subject: [PATCH v5 2/6] cxl: Add CXL spec v3.0 interleave support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 25 Aug 2022 09:07:46 -0700
Message-ID: <166144366619.745916.10798926478044975266.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
References: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL spec rev3.0 added 2 CAP bits to the CXL HDM Decoder Capability Register.
CXL spec rev3.0 8.2.4.19.1. Bit 11 indicates that 3, 6, and 12 way interleave
is capable. Bit 12 indicates that 16 way interleave is capable.

Add code to parse_hdm_decoder_caps() to cache those new bits. Add check in
cxl_interleave_capable() call to make sure those CAP bits matches the passed
in interleave value.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c    |    6 ++++++
 drivers/cxl/core/region.c |    3 +++
 drivers/cxl/cxl.h         |    2 ++
 drivers/cxl/cxlmem.h      |    5 +++++
 4 files changed, 16 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..51d8cbcdace1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -80,6 +80,12 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(11, 8);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
+
+	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_BASELINE;
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
index 88e3a8e54b6a..5a147ce70f4c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -393,11 +393,16 @@ static inline void cxl_mem_active_dec(void)
 }
 #endif
 
+#define CXL_HDM_INTERLEAVE_CAP_BASELINE BIT(1) | BIT(2) | BIT(4) | BIT(8)
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
 


