Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D64C19F29
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 07:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiHCHYq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 03:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiHCHYn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 03:24:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620671D30C
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 00:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659511482; x=1691047482;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZCWGRSuKfJARINwAzVMo5zWdwnijPTGD6BLp/khSXc=;
  b=hbuUdwbhjDjGlhg/kEaCyJ2MtgP33A4qOft99VIdL/ih6sh/YDFS+bvY
   npMUAssgVsChBadYSNIXHlzAUPyF49n3GCoc1eqia/xCj7djkED3vfTiC
   ri7SS5RbSNszC3paLwlsi19NCIpFCjG0WF70Re47aoygMqYpHLjL8WKLp
   nTDm6KQN5RpfS2S5dewTyvCLbS/V6zfin74FqcYSTvp+EmthbAljcnODm
   CplCsGwbVBLDK9kM1wr2ST+l6QyKAhgxusWVyR9K7X1XzdHO4NcaRL+4x
   dtaq1wDv6JbUdNJqNoB3O/sTQ47roPVqaSOHqBc17EEx8sSdrVL6WD6kh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269987581"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="269987581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="599554122"
Received: from anushkab-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.28.212])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:29 -0700
Subject: [PATCH 2/4] cxl/region: Move HPA setup to cxl_region_attach()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        ira.weiny@intel.com, dave.jiang@intel.com
Date:   Wed, 03 Aug 2022 00:24:29 -0700
Message-ID: <165951146924.967013.13625127756930271590.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A recent bug fix added the setup of the endpoint decoder interleave
geometry settings to cxl_region_attach(). Move the HPA setup there as
well to keep all endpoint decoder parameter setting in a central
location.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c    |   17 ++---------------
 drivers/cxl/core/region.c |    4 ++++
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 8143e2615957..5aadefd670d1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -499,20 +499,6 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 			  CXL_HDM_DECODER0_CTRL_TYPE);
 }
 
-static void cxld_set_hpa(struct cxl_decoder *cxld, u64 *base, u64 *size)
-{
-	struct cxl_region *cxlr = cxld->region;
-	struct cxl_region_params *p = &cxlr->params;
-
-	cxld->hpa_range = (struct range) {
-		.start = p->res->start,
-		.end = p->res->end,
-	};
-
-	*base = p->res->start;
-	*size = resource_size(p->res);
-}
-
 static void cxld_clear_hpa(struct cxl_decoder *cxld)
 {
 	cxld->hpa_range = (struct range) {
@@ -601,7 +587,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
 	cxld_set_interleave(cxld, &ctrl);
 	cxld_set_type(cxld, &ctrl);
-	cxld_set_hpa(cxld, &base, &size);
+	base = cxld->hpa_range.start;
+	size = range_len(&cxld->hpa_range);
 
 	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8e6ff3f39755..a073f16355ca 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1296,6 +1296,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 
 	cxled->cxld.interleave_ways = p->interleave_ways;
 	cxled->cxld.interleave_granularity = p->interleave_granularity;
+	cxled->cxld.hpa_range = (struct range) {
+		.start = p->res->start,
+		.end = p->res->end,
+	};
 
 	return 0;
 

