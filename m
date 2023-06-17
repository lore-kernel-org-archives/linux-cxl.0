Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E1EEB64D7
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Jun 2023 01:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjFQBYo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 21:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFQBYn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 21:24:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D27C3AAE
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686965082; x=1718501082;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qpGGveCuGqnZs09AtgHn4rMn9UDK9+2UVj95rt4TR7g=;
  b=awd/Ut4VNWiVEqcDXIomrdC+8AfFBi5qQMNBFSmxxrucmBZgh/9CpqX4
   8rD2TZl2sariWesjLJO7+3v6981f59plVbyAGjXEhFYxHBkCXXglH9mLK
   fz9SgWDEor+eqYa3jSWxEXOK9CyXp23rnXjwVXin9r9/ncamw6kyPfLIv
   9yzGUtyiFMpDuAI5bpMWlxCX7SL9yxSp6gHfQGbLpGFIYqy+H2rSmy5Ur
   GHuVixZ6f4lvTYzyljBkgFVyVthlp/Z8aBjlsMO1tJTZ8nnUW2dmT1ftC
   HFL5XzK0NaJ8vYMDEfq2oBjK8Qgc2JiqFq6oepW0asD9SzY9fITjCKwJp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="362762334"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="362762334"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 18:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="713073300"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="713073300"
Received: from slovely-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.23.80])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 18:24:29 -0700
Subject: [PATCH 1/3] cxl/region: Move cache invalidation before region
 teardown, and before setup
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vikram Sethi <vsethi@nvidia.com>
Date:   Fri, 16 Jun 2023 18:24:28 -0700
Message-ID: <168696506886.3590522.4597053660991916591.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
References: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vikram raised a concern with the theoretical case of a CPU sending
MemClnEvict to a device that is not prepared to receive. MemClnEvict is
a message that is sent after a CPU has taken ownership of a cacheline
from accelerator memory (HDM-DB). In the case of hotplug or HDM decoder
reconfiguration it is possible that the CPU is holding old contents for
a new device that has taken over the physical address range being cached
by the CPU.

To avoid this scenario, invalidate caches prior to tearing down an HDM
decoder configuration.

Now, this poses another problem that it is possible for something to
speculate into that space while the decode configuration is still up, so
to close that gap also invalidate prior to establish new contents behind
a given physical address range.

With this change the cache invalidation is now explicit and need not be
checked in cxl_region_probe(), and that obviates the need for
CXL_REGION_F_INCOHERENT.

Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Fixes: d18bc74aced6 ("cxl/region: Manage CPU caches relative to DPA invalidation events")
Reported-by: Vikram Sethi <vsethi@nvidia.com>
Closes: http://lore.kernel.org/r/BYAPR12MB33364B5EB908BF7239BB996BBD53A@BYAPR12MB3336.namprd12.prod.outlook.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   66 +++++++++++++++++++++++++--------------------
 drivers/cxl/cxl.h         |    8 +----
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 013f3656e661..d48c5916f2e9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -125,10 +125,38 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
 	return xa_load(&port->regions, (unsigned long)cxlr);
 }
 
+static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
+{
+	if (!cpu_cache_has_invalidate_memregion()) {
+		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
+			dev_warn_once(
+				&cxlr->dev,
+				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
+			return 0;
+		} else {
+			dev_err(&cxlr->dev,
+				"Failed to synchronize CPU cache state\n");
+			return -ENXIO;
+		}
+	}
+
+	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+	return 0;
+}
+
 static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	int i;
+	int i, rc = 0;
+
+	/*
+	 * Before region teardown attempt to flush, and if the flush
+	 * fails cancel the region teardown for data consistency
+	 * concerns
+	 */
+	rc = cxl_region_invalidate_memregion(cxlr);
+	if (rc)
+		return rc;
 
 	for (i = count - 1; i >= 0; i--) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
@@ -136,7 +164,6 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 		struct cxl_port *iter = cxled_to_port(cxled);
 		struct cxl_dev_state *cxlds = cxlmd->cxlds;
 		struct cxl_ep *ep;
-		int rc = 0;
 
 		if (cxlds->rcd)
 			goto endpoint_reset;
@@ -256,6 +283,14 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 		goto out;
 	}
 
+	/*
+	 * Invalidate caches before region setup to drop any speculative
+	 * consumption of this address space
+	 */
+	rc = cxl_region_invalidate_memregion(cxlr);
+	if (rc)
+		return rc;
+
 	if (commit)
 		rc = cxl_region_decode_commit(cxlr);
 	else {
@@ -1686,7 +1721,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		if (rc)
 			goto err_decrement;
 		p->state = CXL_CONFIG_ACTIVE;
-		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
 	}
 
 	cxled->cxld.interleave_ways = p->interleave_ways;
@@ -2815,30 +2849,6 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
 
-static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
-{
-	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
-		return 0;
-
-	if (!cpu_cache_has_invalidate_memregion()) {
-		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
-			dev_warn_once(
-				&cxlr->dev,
-				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
-			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
-			return 0;
-		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
-			return -ENXIO;
-		}
-	}
-
-	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
-	clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
-	return 0;
-}
-
 static int is_system_ram(struct resource *res, void *arg)
 {
 	struct cxl_region *cxlr = arg;
@@ -2866,8 +2876,6 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
-	rc = cxl_region_invalidate_memregion(cxlr);
-
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f0c428cb9a71..187abd8ba673 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -462,18 +462,12 @@ struct cxl_region_params {
 	int nr_targets;
 };
 
-/*
- * Flag whether this region needs to have its HPA span synchronized with
- * CPU cache state at region activation time.
- */
-#define CXL_REGION_F_INCOHERENT 0
-
 /*
  * Indicate whether this region has been assembled by autodetection or
  * userspace assembly. Prevent endpoint decoders outside of automatic
  * detection from being added to the region.
  */
-#define CXL_REGION_F_AUTO 1
+#define CXL_REGION_F_AUTO 0
 
 /**
  * struct cxl_region - CXL region

