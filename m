Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B8BC4321E
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 21:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiLEVQL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLEVQK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 16:16:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD85B13F62
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 13:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670274969; x=1701810969;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jdnIp1gK8DxkX2xDpIizdrRDLRY18cWbl/dF/IqqzgU=;
  b=mSWKFtGpdswrgKIahkeLe6VNMR8XGEr62puvjM1cZYqSEGshHiMT2yp2
   g9bKxoF8msEoRt6ZOtw8y3dWbJvSwfyDhsKnAoaYWR0BRnH+NYZfiiCbN
   Kfr676R5lg6zaX5/evMcYQipF9aHsJDvHSK6svvI9CIC1GCB9UUdwSWpk
   ifKbZP0WW90se6TIT+u4cAoxhiHXd84Zs3yt4EcGuqgb5yuZVFoJsnilT
   +PKPqzYqbS6x3phy55N3E3IsbUmu+VerulD+yPIoUyesCinhi5ErL1xO/
   J3U5yNZY1O7o8qAPq6AlR7aJ8jqfI3eBoLz6b0UWIIZhpNqojFRwlv4TE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="299893384"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="299893384"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:16:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="596338254"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="596338254"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:16:07 -0800
Subject: [PATCH v6] cxl: update names for interleave granularity conversion
 macros
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        dan.j.williams@intel.com
Date:   Mon, 05 Dec 2022 14:16:07 -0700
Message-ID: <167027493237.3124429.8948852388671827664.stgit@djiang5-desk3.ch.intel.com>
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
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v6:
- rebased against latest cxl/next
v5:
- Merge mangled patch. Fixed mistake.
v4:
- rebased against cxl/pending branch. Conflict against Adam's patch.
v3:
- change enig to eig for better consistency of overall code (Jonathan, Dan)
- Pick up Jonatha's review tag.
v2:
- change ig to granularity for better clarification (Alison)

 drivers/cxl/acpi.c        |    4 ++--
 drivers/cxl/core/hdm.c    |    6 +++---
 drivers/cxl/core/region.c |    6 +++---
 drivers/cxl/cxl.h         |   13 +++++++------
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 657ef250d848..eb33d2b08b8a 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -86,7 +86,7 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
 	unsigned int hbig, nr_maps;
 	int rc;
 
-	rc = cxl_to_granularity(cxims->hbig, &hbig);
+	rc = eig_to_granularity(cxims->hbig, &hbig);
 	if (rc)
 		return rc;
 
@@ -224,7 +224,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
 	if (rc)
 		return rc;
-	rc = cxl_to_granularity(cfmws->granularity, &ig);
+	rc = eig_to_granularity(cfmws->granularity, &ig);
 	if (rc)
 		return rc;
 	for (i = 0; i < ways; i++)
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 100d0881bde4..40b2ea99d92f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -497,7 +497,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	if (WARN_ONCE(ways_to_cxl(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_cxl(cxld->interleave_granularity, &eig),
+	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
 		      "invalid interleave_granularity: %d\n",
 		      cxld->interleave_granularity))
 		return;
@@ -749,8 +749,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
index f75df35b9d3d..60d0b64279ae 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -391,7 +391,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	rc = granularity_to_cxl(val, &ig);
+	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
 
@@ -1028,7 +1028,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		parent_iw = parent_cxld->interleave_ways;
 	}
 
-	rc = granularity_to_cxl(parent_ig, &peig);
+	rc = granularity_to_eig(parent_ig, &peig);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
 			dev_name(parent_port->uport),
@@ -1065,7 +1065,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		eig = peig;
 	}
 
-	rc = cxl_to_granularity(eig, &ig);
+	rc = eig_to_granularity(eig, &ig);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
 			dev_name(port->uport), dev_name(&port->dev),
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ed2b0a2e80e2..7d0c81172a58 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -74,11 +74,11 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
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
 
@@ -99,11 +99,12 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val)
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
 


