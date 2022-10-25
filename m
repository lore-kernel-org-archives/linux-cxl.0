Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F6FC04A95
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 16:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiJYQ4n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 12:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiJYQ4L (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 12:56:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF10E1011A0
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666716970; x=1698252970;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b0l3a+ioaCVyC2EsBIziWyRYlrOhTuCcQplDVHOB2UY=;
  b=R2me6nZTkKQ2kqQERG4PcAEediizRj9T+Mp1Tlt9TIAHwqNQ6oA1d+re
   Taao5y3eNA2WTlQ7fmwTS0KdTtLGWqO48wM/9qYEzAi+3zWeohlH8xRdM
   FFu3/qtf98zfZbDogTn5ogYPcvIQ9pXfFnH7vi3vtGX2ZUrf9aUkZ7o8y
   gLZn5pgEuJXzBRtcmRSzWYcH6BhaspNveZIxlHVs5tcsjyUPzloQvDBCT
   H9SSXq2ZiZ0CNzT9AGWvGDkVmF073wKP77sG4DrDNH7YI6CGs3Z0aPxqI
   xrzhso1phNqHuzT1rSk0X6+eznaiROVlaDXyz+QHljU7oeyjm7ahxuFHB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="307728601"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="307728601"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 09:56:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="626491387"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="626491387"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 09:56:09 -0700
Subject: [PATCH v5] cxl: update names for interleave granularity conversion
 macros
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Tue, 25 Oct 2022 09:56:09 -0700
Message-ID: <166671690569.878473.14156988187731937590.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Change names for granularity macros to clearly indicate which
variable is encoded and which is the actual granularity.

granularity == interleave granularity
eig == encoded interleave granularity

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v5:
- Merge mangled patch. Fixed mistake.
v4:
- rebased against cxl/pending branch. Conflict against Adam's patch.
v3:
- change enig to eig for better consistency of overall code (Jonathan, Dan)
- Pick up Jonatha's review tag.
v2:
- change ig to granularity for better clarification (Alison)


 drivers/cxl/acpi.c        |    2 +-
 drivers/cxl/core/hdm.c    |    6 +++---
 drivers/cxl/core/region.c |    6 +++---
 drivers/cxl/cxl.h         |   13 +++++++------
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb649683dd3a..9434f8333287 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -105,7 +105,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
 	if (rc)
 		return rc;
-	rc = cxl_to_granularity(cfmws->granularity, &ig);
+	rc = eig_to_granularity(cfmws->granularity, &ig);
 	if (rc)
 		return rc;
 	for (i = 0; i < ways; i++)
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..a04ce9e6e186 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -492,7 +492,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	if (WARN_ONCE(ways_to_cxl(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_cxl(cxld->interleave_granularity, &eig),
+	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
 		      "invalid interleave_granularity: %d\n",
 		      cxld->interleave_granularity))
 		return;
@@ -744,8 +744,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			 port->id, cxld->id, ctrl);
 		return rc;
 	}
-	rc = cxl_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				&cxld->interleave_granularity);
+	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
+				 &cxld->interleave_granularity);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 401148016978..df294a6fd2c9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -390,7 +390,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	rc = granularity_to_cxl(val, &ig);
+	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
 
@@ -1002,7 +1002,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		parent_iw = parent_cxld->interleave_ways;
 	}
 
-	rc = granularity_to_cxl(parent_ig, &peig);
+	rc = granularity_to_eig(parent_ig, &peig);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
 			dev_name(parent_port->uport),
@@ -1039,7 +1039,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		eig = peig;
 	}
 
-	rc = cxl_to_granularity(eig, &ig);
+	rc = eig_to_granularity(eig, &ig);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
 			dev_name(port->uport), dev_name(&port->dev),
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3ab81ad9d2e5..b6abab1c622d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -73,11 +73,11 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 }
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
-static inline int cxl_to_granularity(u16 ig, unsigned int *val)
+static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
 {
-	if (ig > CXL_DECODER_MAX_ENCODED_IG)
+	if (eig > CXL_DECODER_MAX_ENCODED_IG)
 		return -EINVAL;
-	*val = CXL_DECODER_MIN_GRANULARITY << ig;
+	*granularity = CXL_DECODER_MIN_GRANULARITY << eig;
 	return 0;
 }
 
@@ -98,11 +98,12 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val)
 	return 0;
 }
 
-static inline int granularity_to_cxl(int g, u16 *ig)
+static inline int granularity_to_eig(int granularity, u16 *eig)
 {
-	if (g > SZ_16K || g < CXL_DECODER_MIN_GRANULARITY || !is_power_of_2(g))
+	if (granularity > SZ_16K || granularity < CXL_DECODER_MIN_GRANULARITY ||
+	    !is_power_of_2(granularity))
 		return -EINVAL;
-	*ig = ilog2(g) - 8;
+	*eig = ilog2(granularity) - 8;
 	return 0;
 }
 


