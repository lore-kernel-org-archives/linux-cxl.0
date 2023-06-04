Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0634C77B73
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjFDXdU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjFDXdU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:33:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F1D2
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921599; x=1717457599;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0BhQoQJwJwp0uZjbYzScCQixtkWNUSe3Yl+qAjC9Om8=;
  b=Oc+7ecBD+fmir5YCFg3UZoIFRCwT6lAALSw03Q7Tl09/aS7/SzniVDeY
   cL89dC39BwrJm2yceFOiOIMH7o+SYPtEvUOeWzSzdExALhNZkba3SlZnT
   XZs6AuRnICKSwAbxfaNzXixyMSmr2lrDT3jC0zOCPlAgDZRn7p7mPOTme
   6Nle+qTGHYtlIcOUPSyeLuvvkdtB9H/wKHxCA7qvmuVUcovpyh99IO9qS
   adehM+XCl3MlF7yqpJWGUmyYdBPW7LWPxGgMM9X7Q9m6Aqn/feFalFMWi
   tK3iRZN5zv4JWQq1Sfb2cxxxeduJQNuE+J7eWBv+nazwmvNxmA977/75x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353734240"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353734240"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="658874833"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="658874833"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:18 -0700
Subject: [PATCH 18/19] cxl/region: Define a driver interface for region
 creation
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:33:18 -0700
Message-ID: <168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Scenarios like recreating persistent memory regions from label data and
establishing new regions for CXL attached accelerators with local memory
need a kernel internal facility to establish new regions.

Introduce cxl_create_region() that takes an array of endpoint decoders
with reserved capacity and a root decoder object to establish a new
region.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |  107 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |    3 +
 2 files changed, 110 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a41756249f8d..543c4499379e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2878,6 +2878,104 @@ construct_region_begin(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder **cxled, int ways)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	resource_size_t size = 0;
+	struct cxl_region *cxlr;
+	int rc, i;
+
+	if (ways < 1)
+		return ERR_PTR(-EINVAL);
+
+	cxlr = construct_region_begin(cxlrd, cxled[0]);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		goto out;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto out;
+
+	down_read(&cxl_dpa_rwsem);
+	for (i = 0; i < ways; i++) {
+		if (!cxled[i]->dpa_res)
+			break;
+		size += resource_size(cxled[i]->dpa_res);
+	}
+	up_read(&cxl_dpa_rwsem);
+
+	if (i < ways)
+		goto out;
+
+	rc = alloc_hpa(cxlr, size);
+	if (rc)
+		goto out;
+
+	down_read(&cxl_dpa_rwsem);
+	for (i = 0; i < ways; i++) {
+		rc = cxl_region_attach(cxlr, cxled[i], i);
+		if (rc)
+			break;
+	}
+	up_read(&cxl_dpa_rwsem);
+
+	if (rc)
+		goto out;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto out;
+
+	p = &cxlr->params;
+	p->state = CXL_CONFIG_COMMIT;
+out:
+	construct_region_end();
+	if (rc) {
+		drop_region(cxlr);
+		return ERR_PTR(rc);
+	}
+	return cxlr;
+}
+
+/**
+ * cxl_create_region - Establish a region given an array of endpoint decoders
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: array of endpoint decoders with reserved DPA capacity
+ * @ways: size of @cxled array
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3085,6 +3183,15 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+
+		/*
+		 * HDM-D[B] (device-memory) regions have accelerator
+		 * specific usage, skip device-dax registration.
+		 */
+		if (cxlr->type == CXL_DECODER_DEVMEM)
+			return 0;
+
+		/* HDM-H routes to device-dax */
 		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 69f07186502d..ad7f806549d3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -98,6 +98,9 @@ struct cxl_root_decoder *cxl_hpa_freespace(struct cxl_port *endpoint,
 					   int interleave_ways,
 					   unsigned long flags,
 					   resource_size_t *max);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways);
 
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)

