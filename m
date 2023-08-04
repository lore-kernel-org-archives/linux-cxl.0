Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A7C04A6A
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 19:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHDTcB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjHDTbv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 15:31:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7DA1BF
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691177509; x=1722713509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPyPz0adXyr83BC5OBo+vy4lWp3wct6X8V/gRz6m8C4=;
  b=O7MPBqfN9tHX4CL1x+GsuwDubiZIwOU16Rgsq3QNQ1Ld4KpSqqoxj5br
   wkVhC5RPe/37PIdflgoUBGINJM1r15DAt6uILctpCn5dOcluEOSS64BeI
   dXhY5qHr2hn1u9lxIvLXV/C3wDRvrM/kOzolxzR8X3wgHmbr8ikLHdrSz
   904JOkJCQQS4ZVav5C73jmhc9USsO0EnE+ovxkmWe/lLZAYUOF0eeWztu
   ScTcOmVa16tIbSnF+u5eEWc6rssaToGs4kzxRjPH9RyQTYh4AAy1jsK8t
   o1OBYiF5d9wtwGzeVza4+2GeKaRKf2d8EQTcOIRyAnOBJNoDpvowMokYa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="369128151"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="369128151"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759690018"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="759690018"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.168.219])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:31:43 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/2] cxl/region: Remove a soft reserved resource at region teardown
Date:   Fri,  4 Aug 2023 12:31:40 -0700
Message-Id: <2aa10593dbe6a4a8da35077aa492c8aacd363901.1691176651.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1691176651.git.alison.schofield@intel.com>
References: <cover.1691176651.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When CXL regions are created through autodiscovery their resource
may be a child of a soft reserved resource. Today, when such a
region is destroyed, its soft reserved resource remains in place.
That means that the HPA range that the region could release, is
actually unavailable for reuse.

Free the soft reserved resource on region teardown by examining
the alignment of the resources, and handling accordingly. The
two resources, will be exactly aligned, partially aligned, or not
aligned at all.

|----------- "Soft Reserved" -----------|
|-------------- "Region #" -------------|
Exactly aligned. Any dangling children move up to a parent on removal.
The removal of this soft reserved seems guaranteed, however, the
availability of the address range for use depends on complete cleanup
of the region child resources also.

|----------- "Soft Reserved" -----------|
|-------- "Region #" -------|
or
|----------- "Soft Reserved" -----------|
            |-------- "Region #" -------|
Either start or end aligns. Unlike removing a resource, which simply
moves child resources up the resource tree, adjustments fail if any
child resources map the range being truncated. So, this one will fail
for dangling child resources of the region.

|---------- "Soft Reserved" ----------|
        |---- "Region #" ----|
No alignment. Freeing the resource of a region in the middle is possible
if no child resources map the leading or trailing address space.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 132 +++++++++++++++++++++++++++++++++++---
 1 file changed, 123 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 36c0c0dd5697..b8a02afa3514 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -569,22 +569,136 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	return 0;
 }
 
+static int add_soft_reserved(struct resource *parent, resource_size_t start,
+			     resource_size_t len, unsigned long flags)
+{
+	struct resource *res;
+	int rc;
+
+	res = kmalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
+
+	res->desc = IORES_DESC_SOFT_RESERVED;
+	res->flags = res->flags | flags;
+	rc = insert_resource(parent, res);
+	if (rc)
+		kfree(res);
+
+	return rc;
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
+	mutex_lock(&cxlrd->range_lock);
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
+		goto out;
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
+		goto out;
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
+		goto out;
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
+out:
+	mutex_unlock(&cxlrd->range_lock);
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

