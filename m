Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4AFC43217
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJLRX1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJLRX1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 13:23:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3092326AEF
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 10:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665595406; x=1697131406;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vcw53EWvGe+/2cwrJNPc0eygxlGvMjlu+vn89ZUrejs=;
  b=euHjj+81j1AjqAVFOHRkRGQ+k8cmJhUlIP5vulqoPQMnU1gvNKj/eoOa
   mkWEftw/0Q76SP6jpDVW/SBQceAMtpL11iY3KBWaBYME4h3ro/46W380L
   ijQYrBUFo6p9AkS3y9ljj9isRtgqC5pt17v2sH+2JLMlLsBtUFt04p1ur
   l9dhy8dfJHw1Kdwl4iNeuc7NgIIvOPgy9zdo1gyV8bR1T/odQF+Z2xavE
   ktNkSGM7OyknzPGTTuDNCZRHJBBCAw7hm0UNua/EQpU2TmZihW16Y6QHV
   cuaxPf/5yBrodAYnSA5+gFOS4h/KSL23xcxjIRqUSEy+TdrFNtdciovJc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="366857718"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="366857718"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 10:23:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="871994028"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="871994028"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 10:23:23 -0700
Subject: [PATCH v2] cxl: update names for interleave granularity conversion
 macros
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Wed, 12 Oct 2022 10:23:23 -0700
Message-ID: <166559536239.2130185.18009064249679668239.stgit@djiang5-desk3.ch.intel.com>
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
enig == encoded interleave granularity

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2:
- change ig to granularity for better clarificiation (Alison)

 drivers/cxl/acpi.c        |    2 +-
 drivers/cxl/core/hdm.c    |    6 +++---
 drivers/cxl/core/region.c |    6 +++---
 drivers/cxl/cxl.h         |   12 ++++++------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb649683dd3a..5664411c3198 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -105,7 +105,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
 	if (rc)
 		return rc;
-	rc = cxl_to_granularity(cfmws->granularity, &ig);
+	rc = enig_to_granularity(cfmws->granularity, &ig);
 	if (rc)
 		return rc;
 	for (i = 0; i < ways; i++)
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..626cb7d66194 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -492,7 +492,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	if (WARN_ONCE(ways_to_cxl(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_cxl(cxld->interleave_granularity, &eig),
+	if (WARN_ONCE(granularity_to_enig(cxld->interleave_granularity, &eig),
 		      "invalid interleave_granularity: %d\n",
 		      cxld->interleave_granularity))
 		return;
@@ -744,8 +744,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			 port->id, cxld->id, ctrl);
 		return rc;
 	}
-	rc = cxl_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				&cxld->interleave_granularity);
+	rc = enig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
+				 &cxld->interleave_granularity);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 401148016978..34590f961740 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -390,7 +390,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	rc = granularity_to_cxl(val, &ig);
+	rc = granularity_to_enig(val, &ig);
 	if (rc)
 		return rc;
 
@@ -1002,7 +1002,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		parent_iw = parent_cxld->interleave_ways;
 	}
 
-	rc = granularity_to_cxl(parent_ig, &peig);
+	rc = granularity_to_enig(parent_ig, &peig);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
 			dev_name(parent_port->uport),
@@ -1039,7 +1039,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		eig = peig;
 	}
 
-	rc = cxl_to_granularity(eig, &ig);
+	rc = enig_to_granularity(eig, &ig);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
 			dev_name(port->uport), dev_name(&port->dev),
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..ef6cc63c06ef 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -69,11 +69,11 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 }
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
-static inline int cxl_to_granularity(u16 ig, unsigned int *val)
+static inline int enig_to_granularity(u16 enig, unsigned int *granularity)
 {
-	if (ig > 6)
+	if (enig > 6)
 		return -EINVAL;
-	*val = 256 << ig;
+	*granularity = 256 << enig;
 	return 0;
 }
 
@@ -94,11 +94,11 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val)
 	return 0;
 }
 
-static inline int granularity_to_cxl(int g, u16 *ig)
+static inline int granularity_to_enig(int granularity, u16 *enig)
 {
-	if (g > SZ_16K || g < 256 || !is_power_of_2(g))
+	if (granularity > SZ_16K || granularity < 256 || !is_power_of_2(granularity))
 		return -EINVAL;
-	*ig = ilog2(g) - 8;
+	*enig = ilog2(granularity) - 8;
 	return 0;
 }
 


