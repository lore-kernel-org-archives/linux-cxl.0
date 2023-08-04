Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CBBC41513
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 19:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjHDTcB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHDTbu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 15:31:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CEA5248
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691177504; x=1722713504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fiqsPXOPbCE8vWsqIhRsUdfKNAfi47IFmZAtG895J0A=;
  b=XeHrCaeuYd4pzxM3pZuU8I/440UwZQiSTlArXfJlFwHFnPJDWejl2d+n
   Ysc20SnAziejymJs/1tMKQQxpXyZx92TQntdxIfBv0wVzYLGDoeWqdF7l
   XIIlg/oPq7hlsv44+6Nt2c89osbRdIf964dvKKSqpZBLLyF8uHHjaWde0
   79gYaXB2Xlved/aW2ktcQEnr7DeHSWyz/DcizZKmLybM6vw+UtGIcsOEC
   6b5GazEXcUSji9fCzy1LcJdle904GwE2buyOPt/Dps09S/JHWSVmgCfGX
   KzwZ0FjI9ZljVN/nko6RyurFtemcJSrDpRkH3OSROjnwzNA074P8x+EGa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="369128147"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="369128147"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759690015"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="759690015"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.168.219])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:31:42 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/2] cxl/region: Try to add a region resource to a soft reserved parent
Date:   Fri,  4 Aug 2023 12:31:39 -0700
Message-Id: <6cd07222f169d951921486306187e87951853035.1691176651.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1691176651.git.alison.schofield@intel.com>
References: <cover.1691176651.git.alison.schofield@intel.com>
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
index e115ba382e04..36c0c0dd5697 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2709,6 +2709,28 @@ static int match_region_by_range(struct device *dev, void *data)
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
@@ -2719,7 +2741,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	struct resource *res;
-	int rc;
+	int rc = 0;
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
@@ -2755,7 +2777,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
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

