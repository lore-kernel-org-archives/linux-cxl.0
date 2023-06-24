Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAFCC0015E
	for <linux-cxl@archiver.kernel.org>; Sat, 24 Jun 2023 01:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjFXBZF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jun 2023 21:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjFXBZE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Jun 2023 21:25:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE95272C
        for <linux-cxl@vger.kernel.org>; Fri, 23 Jun 2023 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687569903; x=1719105903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I2v7MjV3YCi4y/fQOeRQuJtV0kcxHSBclT+nKhtgXn0=;
  b=iEM2yIMlcpnvHAXkblYkmyw9W8Vq9W/P+fCTs5OX+QDK41kqUlz6rze/
   3gn/t95Ow0gebQ1noZBz0cpMcNj42//S2FuBe4LJ44YVI27Ukq9Hp6MNm
   mEl45BEoUEOHeFKj4H4kYv+Oi9cEtVyjBgL2mqn3xf7bSC6+OA039xP3z
   TuLPikrI2grQqeBRRfktQKbd3PXrOx/hHskT72ItV17PFS6XyDpX/ufM0
   EVwMLZrpLMSWhZYtDDvWrip0DH8++vYYkpDF3P4wOOfrp1nIbmRkm30AE
   oxW21bKHCsq9GKmSwNu6o7g0VJZyui4b6Cc2q8b0FUgZwKGXfkWX0ox8g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="341241791"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="341241791"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 18:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="780767793"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="780767793"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.28.92])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 18:25:01 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] cxl/region: Try to add a region resource to a soft reserved parent
Date:   Fri, 23 Jun 2023 18:24:56 -0700
Message-Id: <3ffcb94cda1b2b578fdce5791488398837475b37.1687568084.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687568084.git.alison.schofield@intel.com>
References: <cover.1687568084.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

During region autodiscovery, the region driver always inserts the
region resource as a child of the root decoder, a CXL WINDOW. It
has the effect of making a soft reserved resource, with an exactly
matching address range, a child of the region resource.

It looks like this in /proc/iomem:

2080000000-29dbfffffff : CXL Window 0
  2080000000-247fffffff : region0
    2080000000-247fffffff : Soft Reserved

Search for soft reserved resources that include the region resource,
and add the new region resource as a child of that found resource.
If a soft reserved resource is not found, insert to the root decoder
as usual.

With this change, it looks like this:

2080000000-29dbfffffff : CXL Window 0
  2080000000-247fffffff : Soft Reserved
    2080000000-247fffffff : region0

This odd parenting only occurs when the resources are an exact match.
When the region resource only uses part of a soft reserved resource,
the parenting appears more logical like this:

2080000000-29dbfffffff : CXL Window 0
  2080000000-287fffffff : Soft Reserved
    2080000000-247fffffff : region0

Aside from the more logical appearance, this change is in preparation
for further cleanup in region teardown. A follow-on patch intends to
find and free soft reserved resources upon region teardown.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f822de44bee0..1769ea92bf3a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2652,6 +2652,28 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
+static int insert_resource_soft_reserved(struct resource *soft_res, void *arg)
+{
+	struct resource *parent, *new, *res = arg;
+	bool found = false;
+
+	parent = soft_res->parent;
+	if (!parent)
+		return 0;
+
+	/* Caller provides a copy of soft_res. Find the actual resource. */
+	for (new = parent->child; new; new = new->sibling) {
+		if (resource_contains(new, soft_res)) {
+			found = true;
+			break;
+		}
+	}
+	if (found)
+		return insert_resource(new, res) == 0;
+
+	return 0;
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -2662,7 +2684,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	struct resource *res;
-	int rc;
+	int rc = 0;
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
@@ -2698,7 +2720,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
-	rc = insert_resource(cxlrd->res, res);
+
+	/* Try inserting to a Soft Reserved parent, fallback to root decoder */
+	if (walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, 0,
+				res->start, res->end, res,
+				insert_resource_soft_reserved) != 1)
+		rc = insert_resource(cxlrd->res, res);
+
 	if (rc) {
 		/*
 		 * Platform-firmware may not have split resources like "System
-- 
2.37.3

