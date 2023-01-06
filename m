Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B94C5479D
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Jan 2023 16:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjAFQkf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 6 Jan 2023 11:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjAFQkV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 6 Jan 2023 11:40:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9217A38A
        for <linux-cxl@vger.kernel.org>; Fri,  6 Jan 2023 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673023192; x=1704559192;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LNqexmITW7IRjB5/S/NhTfpxIErMvWnH51CrYavCiXQ=;
  b=er43CmkpUi5hWW+jXayePMMhnZRNlFqqBuHjFe7pxDfzpXuXrlzmhEVQ
   P9yn9IF28daypTgV2+GqlrbAJwWUJGSUuNh0++wYEyIELlVP+C0+Mr1+T
   jccxQimp4rJ9tpIei/oNoM6EZir0TuZRu83LfX3U2uJdTsKeVIBT2L8Uz
   jTvehSd+v4O/kal7pStYXz401PyLE0ElQj2vZuICFQjH28aLgC14rILFV
   39q6v041YFSwE+8gxPuC+8177QWzmrb7Oh1vbPjnSj/i1eAVvrlKQgngK
   dTtI9Iv5LXvi4wD/rYmX3oARFcwNKorLXerwluNqMchW46UHTtweiwjla
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="324523555"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="324523555"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 08:39:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="901331458"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="901331458"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.171.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 08:39:51 -0800
Subject: [PATCH] cxl: fix cxl_report_and_clear() RAS UE addr mis-assignment
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Fri, 06 Jan 2023 09:39:49 -0700
Message-ID: <167302318779.580155.15233596744650706167.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

'addr' that contains RAS UE register address is re-assigned to
RAS_CAP_CONTROL offset if there are multiple UE errors. Use different addr
variable to avoid the reassignment mistake.

Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 33083a522fd1..258004f34281 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -554,8 +554,11 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
-		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
-		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(addr)));
+		void __iomem *rcc_addr =
+			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
+
+		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+				   readl(rcc_addr)));
 	} else {
 		fe = status;
 	}


