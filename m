Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB2DC761A6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Mar 2023 18:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjC1Sgj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC1Sgi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Mar 2023 14:36:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6701FC6
        for <linux-cxl@vger.kernel.org>; Tue, 28 Mar 2023 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680028589; x=1711564589;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NPn8QDNBl/shOhSTz5604/F2Cc8aQZuHdLYTsFqe3fM=;
  b=gt/SmYt/9lr3ukc0HUvM1uDx09Gld1d0U/qOvYWJl38JIkdMYrWxH2jj
   wzFeVnwk9rmA8IcbiMa2XERUcmWCgQnnOwz3dXGnn5kmXxw7OLiZc+qKt
   bj9f/N7DaKrKSogxTctMI1IYQ6Ayj54OWB1HyJDg5AOrt8K7vkMT8xS6E
   jwJKFnuYtP7pFYlUpreX/tSgsg4jm/aA/mFIdQfL1NI93wVuFam73Y1IM
   z756tWR3nGSqJs76mW/CYf9NaOTSGWfWz6tBEWRHrU3yG9VI1Tqoy3+WT
   b4UjqkfUFwcUzPRLaYPIoioXmAnf4DHokboGWtXxBg0sPZw3TW4U65n/f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403273435"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="403273435"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 11:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="714356732"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="714356732"
Received: from liujimm1-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.164.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 11:36:28 -0700
Subject: [PATCH] cxl/region: Move coherence tracking into cxl_region_attach()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Tue, 28 Mar 2023 11:36:28 -0700
Message-ID: <168002858817.50647.1217607907088920888.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Each time the contents of a given HPA are potentially changed in a cache
incoherent manner the CXL core sets CXL_REGION_F_INCOHERENT to
invalidate CPU caches before the region is used.

Successful invocation of attach_target() indicates that DPA has been
newly assigned to a given HPA in the dynamic region creation flow.
However, attach_target() is also reused in the autodiscovery flow where
the region was activated by platform firmware. In that case there is no
need to invalidate caches because that region is already in active use
and nothing about the autodiscovery flow modifies the HPA-to-DPA
relationship.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 52bbf6268d5f..b2fd67fcebfb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1674,6 +1674,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		if (rc)
 			goto err_decrement;
 		p->state = CXL_CONFIG_ACTIVE;
+		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
 	}
 
 	cxled->cxld.interleave_ways = p->interleave_ways;
@@ -1775,8 +1776,6 @@ static int attach_target(struct cxl_region *cxlr,
 
 	down_read(&cxl_dpa_rwsem);
 	rc = cxl_region_attach(cxlr, cxled, pos);
-	if (rc == 0)
-		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
 	up_read(&cxl_dpa_rwsem);
 	up_write(&cxl_region_rwsem);
 	return rc;

