Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977A6C7EE29
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 00:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjEZAdR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 May 2023 20:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjEZAdQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 May 2023 20:33:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB4198
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685061195; x=1716597195;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uITC1Aj4NNDwmLyEnOmvjMnvf4/TAOQ5ypZOqA3BaVU=;
  b=bAa1GtO+2gc5eB+lOmEwm1TqJHBot09yhFYKsFXez7+/oKcGulR4NEjJ
   jufkTluG5H4iVxMw1D1qFxFJJYrl++eCmpc24g/BzGuU13hTarx6EwI95
   6GspWFThKaOu78VsSMYqkZ7pzJ2w2w6qKRdsmgePBpyD2Bynf1LGPupl8
   naBSGncPVt2cCTWjiribYWIJ3tKLmRFE4KeyJYG6cpzpaSKK4j58DBiRD
   bLExc8eDZ8pWJicrBTkduaTXzTEW/8aUon3QUeoHG8aFFhbVn7rTuGZ4V
   iw3SPlB6G0P5Am0KhwTOm9F1VZSHscaDIQJthU5GgDPVcYopBD7bdO2bO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="382314248"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="382314248"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 17:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="682536454"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="682536454"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.85.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 17:33:02 -0700
Subject: [PATCH] cxl: Explicitly initialize resources when media is not ready
From:   Dave Jiang <dave.jiang@intel.com>
To:     dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Thu, 25 May 2023 17:33:01 -0700
Message-ID: <168506118166.3004974.13523455340007852589.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When media is not ready, all media information are not read from the
device. Explicitly set zero out the resources instead of going through the
success code path with 0 size capacity to init the resources and return.

Fixes: e764f12208b9 ("cxl: Move cxl_await_media_ready() to before capacity info retrieval")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2c8dc7e2b84d..e1d257051a7d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1105,6 +1105,13 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 	struct device *dev = cxlds->dev;
 	int rc;
 
+	if (!cxlds->media_ready) {
+		cxlds->dpa_res = (struct resource)DEFINE_RES_MEM(0, 0);
+		cxlds->ram_res = (struct resource)DEFINE_RES_MEM(0, 0);
+		cxlds->pmem_res = (struct resource)DEFINE_RES_MEM(0, 0);
+		return 0;
+	}
+
 	cxlds->dpa_res =
 		(struct resource)DEFINE_RES_MEM(0, cxlds->total_bytes);
 
@@ -1118,12 +1125,10 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 				   cxlds->persistent_only_bytes, "pmem");
 	}
 
-	if (cxlds->media_ready) {
-		rc = cxl_mem_get_partition_info(cxlds);
-		if (rc) {
-			dev_err(dev, "Failed to query partition information\n");
-			return rc;
-		}
+	rc = cxl_mem_get_partition_info(cxlds);
+	if (rc) {
+		dev_err(dev, "Failed to query partition information\n");
+		return rc;
 	}
 
 	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,


