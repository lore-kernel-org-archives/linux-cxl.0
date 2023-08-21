Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F6CEE49A6
	for <linux-cxl@archiver.kernel.org>; Mon, 21 Aug 2023 18:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjHUSOu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbjHUSOt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 21 Aug 2023 14:14:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656AE10E
        for <linux-cxl@vger.kernel.org>; Mon, 21 Aug 2023 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692641688; x=1724177688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fk5ispeQuoAGFTua/Q7cqH/TXSFcqw6a+J1sZnrPrb0=;
  b=lLEy/qMxCzxZoeQBHrJFazMdyFlsEmHSWeCgbkWau5Zz3ur7FipkLa3S
   hdde/uxNDH53ubsDmeKxBMUP7S+v0u7EKYazFiD5BZGTnieE9zVszqv2m
   GdcGzb8k+6fRcVG5oQqjzBx43c1T2BJixTVqNbYp5iD0SWL90UCwIJsI8
   8RXNryvC1BCFBnye/+JC/W6N+yYXxhz9VUtexW0Z7nMAq9jPCiezGF2go
   1xTK2GHWWDcnHX5JlJEmMQS02CUQ0DpVDEOoMXCtQ3r4DvxN1mK8CQJBK
   5j/H9fP1OyFGd5ik/LoTEho9vp5egKNUkE6CHCME44Z2sASDhoNU3IxVx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353978360"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="353978360"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 11:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859569973"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="859569973"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.106.94])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 11:14:41 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/2] cxl/region: Try to add a region resource to a soft reserved parent
Date:   Mon, 21 Aug 2023 11:14:36 -0700
Message-Id: <4cf018843ee9846c5b9907b8fc7140ab66b929b6.1692638817.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1692638817.git.alison.schofield@intel.com>
References: <cover.1692638817.git.alison.schofield@intel.com>
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

Search for soft reserved resources that include the region resource
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
 drivers/cxl/core/region.c | 57 ++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e115ba382e04..5c487aab15ad 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2709,6 +2709,31 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
+static int insert_resource_soft_reserved(struct resource *soft_res, void *arg)
+{
+	struct resource *parent, *new, *res = arg;
+	bool found = false;
+	int rc = 0;
+
+	parent = soft_res->parent;
+	if (!parent)
+		return 0;
+
+	/* Caller provides a copy of soft_res. Find the actual resource. */
+	for (new = parent->child; new; new = new->sibling) {
+		if (resource_contains(new, soft_res)) {
+			rc = insert_resource(new, res);
+			found = true;
+			break;
+		}
+	}
+	/* Caller handles failure to find or insert resource */
+	if (!found || rc)
+		return rc;
+
+	return 1;
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -2755,16 +2780,28 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
-	rc = insert_resource(cxlrd->res, res);
-	if (rc) {
-		/*
-		 * Platform-firmware may not have split resources like "System
-		 * RAM" on CXL window boundaries see cxl_region_iomem_release()
-		 */
-		dev_warn(cxlmd->dev.parent,
-			 "%s:%s: %s %s cannot insert resource\n",
-			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			 __func__, dev_name(&cxlr->dev));
+
+	/* Try inserting to a Soft Reserved parent. Fallback to root decoder */
+	rc = walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, 0, res->start,
+				 res->end, res, insert_resource_soft_reserved);
+	if (!rc || rc == -EBUSY)
+		dev_dbg(&cxlmd->dev,
+			"insert %pr to soft reserved parent failed rc:%d\n",
+			res, rc);
+	if (rc != 1) {
+		rc = insert_resource(cxlrd->res, res);
+		if (rc) {
+			/*
+			 * Platform-firmware may not have split resources
+			 * like "System RAM" on CXL window boundaries see
+			 * cxl_region_iomem_release()
+			 */
+			dev_warn(cxlmd->dev.parent,
+				 "%s:%s: %s %s cannot insert resource\n",
+				 dev_name(&cxlmd->dev),
+				 dev_name(&cxled->cxld.dev), __func__,
+				 dev_name(&cxlr->dev));
+		}
 	}
 
 	p->res = res;
-- 
2.37.3

