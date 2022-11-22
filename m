Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B654C43217
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Nov 2022 23:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiKVXIB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiKVXH7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Nov 2022 18:07:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45F56D77
        for <linux-cxl@vger.kernel.org>; Tue, 22 Nov 2022 15:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669158478; x=1700694478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJShsi1CvkSFHdjt+KsvqpwAmeic0J+dCE35QcMIrDE=;
  b=ndGkR57vbhXZrmGGeaqaMRUlpD4Qfu63GlCINpSiyV051aerjnX8XhoC
   hCBHHA/+S4SySmvDdDA8E84kMov6EcA8OsqSGzxAlKtu+5IJI0H47kZD4
   gFxWJiRNLRfNQensJCGgmVZohXt78+lANoXDApeHGdgA7rIokC+S1NID7
   gHbFvQJ3WVyKThnTecm12RyKGbLAAU/9X2LhsPeUGAlpX0a68yRze+hrp
   LUsCa8BrMhYmWrGZsMvEX457hTCBd1lOHGMJ0Erb7My2ERqXGaY6Nyf8S
   ngSk06Hi5thERyrHRJEiQfKFYi2Ypt0/lKYV3zLjwsDC0+LeUk8oSzQJC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376079341"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="376079341"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747542502"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747542502"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.144.204])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:55 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/4] cxl/region: Check addr trans at pmem region create (debug only)
Date:   Tue, 22 Nov 2022 15:07:49 -0800
Message-Id: <48b8ab49a54597d56b1732fc4e2955b5e726d4c9.1669153711.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669153711.git.alison.schofield@intel.com>
References: <cover.1669153711.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

At the time of region creation, device physical addresses (DPA)
are mapped to host physical addresses (HPA). The CXL driver
translates DPA's to HPA's for user space consumption. In order
to prove and exercise that translation functionality, perform
a small sample of DPA to HPA translations whenever a pmem region
is created in a debug kernel.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c847517e766c..32216b5fe450 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1945,6 +1945,36 @@ u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
 	return hpa;
 }
 
+static bool cxl_check_addrtrans(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled;
+	u64 start, end, dpa;
+
+	/*
+	 * Translate a few DPAs (start,mid,end) to HPAs
+	 * for each contributing endpoint decoder.
+	 */
+	for (int i = 0; i <  p->nr_targets; i++) {
+		cxled = p->targets[i];
+		start = cxl_dpa_resource_start(cxled);
+		end = start + cxl_dpa_size(cxled) - 1;
+
+		dpa = start;
+		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
+			return false;
+
+		dpa = start + cxl_dpa_size(cxled) / 2;
+		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
+			return false;
+
+		dpa = end;
+		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
+			return false;
+	}
+	return true;
+}
+
 /**
  * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
  * @cxlr: parent CXL region for this pmem region bridge device
@@ -1973,8 +2003,10 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
+	dev_dbg(&cxlr->dev, "Address translation check: %s\n",
+		cxl_check_addrtrans(cxlr) ? "Pass" : "Fail");
+
 	return devm_add_action_or_reset(&cxlr->dev, cxlr_pmem_unregister, dev);
-
 err:
 	put_device(dev);
 	return rc;
-- 
2.37.3

