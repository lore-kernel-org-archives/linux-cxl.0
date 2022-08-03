Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4561FC19F2A
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 07:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiHCHYp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiHCHYn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 03:24:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578121CFF8
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 00:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659511482; x=1691047482;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5VyLK7zLsvMs11Lr/T+aqE92V4Dg2vmFXrVcVV4Lv9I=;
  b=S5+uJW9Bg2JdW/sP3VlC5sG/xkIHTs+tb6BnSFgdjWSfwr3eZQkfWUpG
   91mjAd+huFX1KtZIG8/Azb1EA+8b7h9LdEJirffX2zATwO2Vyc3W7jUEf
   rRoAcWv9PXdq821GKwWvzZJ6bVDSD8kd6D/3BP4pAavdMOLDGyYjILtZT
   V3qpxJ+Ps66rfYZ4Ma1xJ3mDiwDdC2VvcD7rL/s1A5A2G/SlWIWd19D/k
   j95/eH8wFzn6Yw7if25rlf9OuvHGrKi+YxvA2c7LUbDGJe5jzsWYK++rS
   KyWj+Qvnj/dMxqqyFoAc8rdnGbg6Z7clpW7WlsosEQ0QZ2Z11MiT+gSh7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="353611078"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="353611078"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="606294220"
Received: from jplumb-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.28.212])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:41 -0700
Subject: [PATCH 4/4] cxl/region: Fix region commit uninitialized variable
 warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com
Date:   Wed, 03 Aug 2022 00:24:41 -0700
Message-ID: <165951148105.967013.14191992449932268431.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

0day robot reports:

drivers/cxl/core/region.c:196 cxl_region_decode_commit() error: uninitialized symbol 'rc'.

The re-checking of loop termination conditions to determine "success"
makes it hard to see that @rc is initialized in all cases. Remove those
to make it explicit that @rc reflects a commit error and that the rest
of logic is concerned with unwinding committed decoders.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c931b6eb4e7..a68e4e0cf169 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -159,7 +159,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 static int cxl_region_decode_commit(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	int i, rc;
+	int i, rc = 0;
 
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
@@ -180,7 +180,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 		}
 
 		/* success, all decoders up to the root are programmed */
-		if (is_cxl_root(iter))
+		if (rc == 0)
 			continue;
 
 		/* programming @iter failed, teardown */
@@ -192,14 +192,12 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 		}
 
 		cxled->cxld.reset(&cxled->cxld);
-		if (i == 0)
-			return rc;
-		break;
+		goto err;
 	}
 
-	if (i >= p->nr_targets)
-		return 0;
+	return 0;
 
+err:
 	/* undo the targets that were successfully committed */
 	cxl_region_decode_reset(cxlr, i);
 	return rc;

