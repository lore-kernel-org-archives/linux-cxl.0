Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66F3EE4993
	for <linux-cxl@archiver.kernel.org>; Mon, 21 Aug 2023 18:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbjHUSOt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjHUSOs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 21 Aug 2023 14:14:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B710E
        for <linux-cxl@vger.kernel.org>; Mon, 21 Aug 2023 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692641684; x=1724177684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dBhUPfL41O3d3+5y359VALWO/si9HvuvMds6LKMnTIs=;
  b=gydhm+0DLUdNiKEutV87CHibkvegU4ecdaQR7TZwrkOz13e/VaTdWLmp
   3O/1Qf1qJkMLoOoeZkgkQSECf35MUYuQP8HmA3XduDX/I6Du1YL/OcW6L
   9E6WjuM8H6O4yIspyakaBGTIzCjfsiZ+RH6vTLQ9wdOQsSC5akmxZnOYe
   RNXgxf1mz0QAhXwNp4r2fts4NYCCaADhkZFs1ttVLJd8NTpxrxHvPdQeM
   qELP0OVRJI3OMdV5lbCvSJISRJkUwBRhYTk8Bdt/J/L5VmSwomfBYiIvG
   13wNH1+XQ5Jox6jeh9W8cnSKsJJHtqaF5vl5t/5Hvttpg2/sjHcsLrXpx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353978361"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="353978361"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 11:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859569977"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="859569977"
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
Cc:     linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>
Subject: [PATCH v3 2/2] cxl/region: Remove a soft reserved resource at region teardown
Date:   Mon, 21 Aug 2023 11:14:37 -0700
Message-Id: <29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1692638817.git.alison.schofield@intel.com>
References: <cover.1692638817.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When CXL regions are created through autodiscovery their resource
may be a child of a soft reserved resource. Currently, when such a
region is destroyed, its soft reserved resource remains in place.
That means that the HPA range that the region could release is
actually unavailable for reuse.

Free the soft reserved resource on region teardown by examining
the alignment of the resources, and handling accordingly. The
two resources will be exactly aligned, partially aligned, or not
aligned at all.

|----------- "Soft Reserved" -----------|
|-------------- "Region #" -------------|
Exactly aligned. Any dangling children move up to a parent on removal.
The removal of this soft reserved seems guaranteed, however the
availability of the address range for reuse depends on complete cleanup
of the region child resources also.

|----------- "Soft Reserved" -----------|
|-------- "Region #" -------|
or
|----------- "Soft Reserved" -----------|
            |-------- "Region #" -------|
Either start or end aligns. Unlike removing a resource, which simply
moves child resources up the resource tree, adjustments fail if any
child resources map the range being truncated. So this one will fail
for dangling child resources of the region.

|---------- "Soft Reserved" ----------|
        |---- "Region #" ----|
No alignment. Freeing the resource of a region in the middle succeeds
if no child resources map the leading or trailing address space.

Reported-by: Derick Marks <derick.w.marks@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 130 +++++++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c487aab15ad..dcf8d4ad2cf4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -569,22 +569,134 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	return 0;
 }
 
+static int add_soft_reserved(struct resource *parent, resource_size_t start,
+			     resource_size_t len, unsigned long flags)
+{
+	struct resource *res __free(kfree) = kmalloc(sizeof(*res), GFP_KERNEL);
+	int rc;
+
+	if (!res)
+		return -ENOMEM;
+
+	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
+
+	res->desc = IORES_DESC_SOFT_RESERVED;
+	res->flags = res->flags | flags;
+	rc = insert_resource(parent, res);
+	if (rc)
+		return rc;
+
+	no_free_ptr(res);
+	return 0;
+}
+
+static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
+				 resource_size_t start, resource_size_t end)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	resource_size_t new_start, new_end;
+	struct resource *parent;
+	unsigned long flags;
+	int rc;
+
+	/* Prevent new usage while removing or adjusting the resource */
+	guard(mutex)(&cxlrd->range_lock);
+
+	/* Aligns at both resource start and end */
+	if (soft->start == start && soft->end == end) {
+		rc = remove_resource(soft);
+		if (rc)
+			dev_dbg(&cxlr->dev,
+				"cannot remove soft reserved resource %pr\n",
+				soft);
+		else
+			kfree(soft);
+
+		return;
+	}
+
+	/* Aligns at either resource start or end */
+	if (soft->start == start || soft->end == end) {
+		if (soft->start == start) {
+			new_start = end + 1;
+			new_end = soft->end;
+		} else {
+			new_start = soft->start;
+			new_end = start + 1;
+		}
+		rc =  adjust_resource(soft, new_start, new_end - new_start + 1);
+		if (rc)
+			dev_dbg(&cxlr->dev,
+				"cannot adjust soft reserved resource %pr\n",
+				soft);
+		return;
+	}
+
+	/*
+	 * No alignment. Attempt a 3-way split that removes the part of
+	 * the resource the region occupied, and then creates new soft
+	 * reserved resources for the leading and trailing addr space.
+	 * adjust_resource() will stop the attempt if there are any
+	 * child resources.
+	 */
+
+	/* Save the original soft reserved resource params before adjusting */
+	new_start = soft->start;
+	new_end = soft->end;
+	parent = soft->parent;
+	flags = soft->flags;
+
+	rc = adjust_resource(soft, start, end - start);
+	if (rc) {
+		dev_dbg(&cxlr->dev,
+			"cannot adjust soft reserved resource %pr\n", soft);
+		return;
+	}
+	rc = remove_resource(soft);
+	if (rc)
+		dev_warn(&cxlr->dev,
+			 "cannot remove soft reserved resource %pr\n", soft);
+
+	rc = add_soft_reserved(parent, new_start, start - new_start, flags);
+	if (rc)
+		dev_warn(&cxlr->dev,
+			 "cannot add new soft reserved resource at %pa\n",
+			 &new_start);
+
+	rc = add_soft_reserved(parent, end + 1, new_end - end, flags);
+	if (rc)
+		dev_warn(&cxlr->dev,
+			 "cannot add new soft reserved resource at %pa + 1\n",
+			 &end);
+}
+
 static void cxl_region_iomem_release(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
+	struct resource *parent, *res = p->res;
+	resource_size_t start, end;
 
 	if (device_is_registered(&cxlr->dev))
 		lockdep_assert_held_write(&cxl_region_rwsem);
-	if (p->res) {
-		/*
-		 * Autodiscovered regions may not have been able to insert their
-		 * resource.
-		 */
-		if (p->res->parent)
-			remove_resource(p->res);
-		kfree(p->res);
-		p->res = NULL;
+	if (!res)
+		return;
+	/*
+	 * Autodiscovered regions may not have been able to insert their
+	 * resource. If a Soft Reserved parent resource exists, try to
+	 * remove that also.
+	 */
+	if (p->res->parent) {
+		parent = p->res->parent;
+		start = p->res->start;
+		end = p->res->end;
+		remove_resource(p->res);
+		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags) &&
+		    parent->desc == IORES_DESC_SOFT_RESERVED)
+			remove_soft_reserved(cxlr, parent, start, end);
 	}
+
+	kfree(p->res);
+	p->res = NULL;
 }
 
 static int free_hpa(struct cxl_region *cxlr)
-- 
2.37.3

