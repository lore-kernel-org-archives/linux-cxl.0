Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AABC0015E
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Aug 2023 17:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjHORXT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Aug 2023 13:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbjHORWv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 15 Aug 2023 13:22:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946881FC4
        for <linux-cxl@vger.kernel.org>; Tue, 15 Aug 2023 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692120140; x=1723656140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MJjw5ohvvwuDmAQ7bMuxVZGvnmliVMl+7Z+IpsvrdcM=;
  b=NoXCestBr7ZwBSeiKDPLNf9iIvDwaEhVm9wQalEyGpN8DloH6CjcSa7+
   32zTfscK4p9mO5GRZ6HzrLjY3LtopdMHF/aBjncVqw3WA5OTeADqAHZ/b
   A20r+tW49GXEz1Ki0D3yYd5gS7V7OUtn+zYiN8mgTDU8vpaQzrxJEJVN4
   n31q5Wt/Q31NSTa3UvK44YTSuJzB6LIYOelnjvRbd2LR66FrwmmP4IZjR
   RboGeh6Jc+xNJAeWwa6qQIZe+M0u4mmy9Q9qsKPRmCwoqu0pCSlWC0xoa
   uAhuNMhSD+wjJpL/OoOIa0fcHR0SWgJNAigGWidzf5ol1gF4PUNuSJBSg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371247834"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="371247834"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 10:20:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="710799744"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="710799744"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.27.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 10:20:57 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/mbox: Remove useless cast in cxl_mem_create_range_info()
Date:   Tue, 15 Aug 2023 10:20:52 -0700
Message-Id: <20230815172052.22514-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

DEFINE_RES_MEM() is a wrapper around the DEFINE_RES_NAMED() macro
which already has the (struct resource) for the compound literal.
The user of the macro should not repeat the cast.

Cleans up these sparse warnings:
drivers/cxl/core/mbox.c:1184:18: warning: cast to non-scalar
drivers/cxl/core/mbox.c:1184:18: warning: cast from non-scalar

Fixes: 52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Update commit log (Andy)
- Add fixes tag (Jonathan)

 drivers/cxl/core/mbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..01de4b438b2a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1180,8 +1180,7 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
 		return 0;
 	}
 
-	cxlds->dpa_res =
-		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
+	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
 
 	if (mds->partition_align_bytes == 0) {
 		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,

base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.37.3

