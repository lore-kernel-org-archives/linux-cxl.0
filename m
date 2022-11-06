Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3FEC433FE
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Nov 2022 23:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKFXsD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Nov 2022 18:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKFXsD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Nov 2022 18:48:03 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EBAD2EA
        for <linux-cxl@vger.kernel.org>; Sun,  6 Nov 2022 15:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667778482; x=1699314482;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3Y9wevBdrZle9FG1ih1WNj+BAi/g7XVzrgCeUPT/HA=;
  b=FXf3u24vuFIsFGzbCTLJtCRWQoWXpsuxsJdLEiqKiKPtxDFwYeXaLBoQ
   K7qV7FQc7ByztvTUF07WMy9iLlFCFWMHclnW9pQZGjoldJsFrU39MCVKp
   RRbbynYX7d3niOSpkwW41yt4BhBQOOuJaTzuuUmAUa2b+3B21Cvopmfkc
   PQph7K5GlW6gQVeXTE4t8qAR1lbxpZEoQpk4IUZWtqzaxLfi8Jt/Ydv5n
   R5xZM9QyPHq9Yi6yh8+A5nDM0hFpJ8Eg9WxG5dyZHHogWgn4gZJPmBWQK
   EOhyFgLZMyqiyNRRGmB29XhEi7BTw7uqWMdXwIPvAopgj6UW0ZBReySLp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="372407822"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="372407822"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:48:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="704674867"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="704674867"
Received: from durgasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.240.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:48:01 -0800
Subject: [ndctl PATCH 13/15] cxl/region: Default to memdev mode for create
 with no arguments
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 06 Nov 2022 15:48:01 -0800
Message-ID: <166777848122.1238089.2150948506074701593.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Allow for:

   cxl create-region -d decoderX.Y

...to assume (-m -w $(count of memdevs beneath decoderX.Y))

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/region.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index aa0735194fa1..c0cf4ab350da 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -227,10 +227,13 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 	}
 
 	/*
-	 * For all practical purposes, -m is the default target type, but
-	 * hold off on actively making that decision until a second target
-	 * option is available.
+	 * For all practical purposes, -m is the default target type, but hold
+	 * off on actively making that decision until a second target option is
+	 * available. Unless there are no arguments then just assume memdevs.
 	 */
+	if (!count)
+		param.memdevs = true;
+
 	if (!param.memdevs) {
 		log_err(&rl,
 			"must specify option for target object types (-m)\n");
@@ -272,11 +275,8 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 		p->ways = count;
 		if (!validate_ways(p, count))
 			return -EINVAL;
-	} else {
-		log_err(&rl,
-			"couldn't determine interleave ways from options or arguments\n");
-		return -EINVAL;
-	}
+	} else
+		p->ways = p->num_memdevs;
 
 	if (param.granularity < INT_MAX) {
 		if (param.granularity <= 0) {

