Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3000DC7EE23
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjFDXcl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjFDXck (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814FCAB
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921559; x=1717457559;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yAQbujAoj6+5kS/FPoOnwWb+HfsYpbLcCx8epwW4enE=;
  b=kDvxCVeXtZqiqBKY5MYIN3u821bRny8UpSYQ4xcr9hCNCZUeO30RoRoM
   CP89Nb8fhHF20tzVRecOaWqlFSNNXTUhrAFtLz3gqrbIya7krZBk2YKfc
   5WaQf1I52Fx6rI5BgNtoSmQmVO0s2iY6gP/G/HZlFktgPE9y/N2jvWfLC
   9jLzPOCTUKQDCrZ8zXAEu+gThFgUEyoHTsPgkU1RbIuGrUCRaUjhx93JH
   0CFeGkeqwaX2W5pPDyjNk+PX1yvzV/jFNFF56dJJMuQkF7ydXiXFYQxeI
   jxuXtVHLcz2kekGZt9yBSo0JLTakcWo+i01d+Cxl5w7FzX0bZVyr9rpQO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="336596800"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336596800"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038571979"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038571979"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:39 -0700
Subject: [PATCH 11/19] cxl/region: Factor out construct_region_{begin,
 end} and drop_region() for reuse
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:32:38 -0700
Message-ID: <168592155858.1948938.18413203801464814822.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for constructing regions from newly allocated HPA, factor
out some helpers that can be shared with the existing kernel-internal
region construction from BIOS pre-allocated regions. Handle acquiring a
new region object under the region rwsem, and optionally tearing it down
if the region assembly process fails.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   73 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c7170d92f47f..bd3c3d4b2683 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2191,19 +2191,25 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport, unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
-	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_region *cxlr;
 
 	cxlr = cxl_find_region_by_name(cxlrd, buf);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
-
-	devm_release_action(port->uport, unregister_region, cxlr);
+	drop_region(cxlr);
 	put_device(&cxlr->dev);
 
 	return len;
@@ -2664,17 +2670,19 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static void construct_region_end(void)
+{
+	up_write(&cxl_region_rwsem);
+}
+
+static struct cxl_region *
+construct_region_begin(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct resource *res;
-	int rc;
+	int err = 0;
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
@@ -2693,19 +2701,41 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s autodiscovery interrupted\n",
+			"%s:%s: %s region setup interrupted\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__);
-		rc = -EBUSY;
-		goto err;
+		err = -EBUSY;
+	}
+
+	if (err) {
+		construct_region_end();
+		drop_region(cxlr);
+		return ERR_PTR(err);
 	}
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct resource *res;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res) {
 		rc = -ENOMEM;
-		goto err;
+		goto out;
 	}
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
@@ -2722,6 +2752,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -2729,7 +2760,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
-		goto err;
+		goto out;
 
 	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
 		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
@@ -2738,14 +2769,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
-	up_write(&cxl_region_rwsem);
 
+out:
+	construct_region_end();
+	if (rc) {
+		drop_region(cxlr);
+		return ERR_PTR(rc);
+	}
 	return cxlr;
-
-err:
-	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport, unregister_region, cxlr);
-	return ERR_PTR(rc);
 }
 
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)

