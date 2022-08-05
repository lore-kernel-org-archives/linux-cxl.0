Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155E7C00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbiHEU1y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbiHEU1x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:27:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7852C12F
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731272; x=1691267272;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZRWV1+5opmHqObzKTIWZnpxPfi226yRiosWga7WU20U=;
  b=KdLZMUwre+d/Ce9weIChQnGXdTxY9Bh5lTPzmjTAuPY9ZRT69r6ssZEK
   Gp/f5zyO9cAY1PuDsf4exDS/UjdcrZltfBcMedpAU32fVDzIBMtpEtWFA
   RtBmKGw5NF216EBDUTxNyMfd7L7aGibtSd+ybZ0P7vXYqfxL7lTdRYCQ4
   sDrmlVxV8WC7Ou9d169VfKB97yVsC9rq4fj31d8ZoWS8Ek4ckOGAQXW1I
   SSO3xlzDXAPPX4+S5TyHGi7EUQmrtQtycoQcNTTvoulOcs2/a2416ywex
   YFeubAttQB0NgqEQ2j3VIR0YueaqqOsnd9fYra2bIKsXH5xDsiogEjQ2z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="287847941"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287847941"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:27:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="779855809"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:27:52 -0700
Subject: [PATCH v2 3/3] cxl/region: Disallow region granularity != window
 granularity
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com, dave.jiang@intel.com
Date:   Fri, 05 Aug 2022 13:27:51 -0700
Message-ID: <165973127171.1526540.9923273539049172976.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The endpoint decode granularity must be <= the window granularity
otherwise capacity in the endpoints is lost in the decode. Consider an
attempt to have a region granularity of 512 with 4 devices within a
window that maps 2 host bridges at a granularity of 256 bytes:

HPA	DPA Offset	HB	Port	EP
0x0	0x0		0	0	0
0x100	0x0		1	0	2
0x200	0x100		0	0	0
0x300	0x100		1	0	2
0x400	0x200		0	1	1
0x500	0x200		1	1	3
0x600	0x300		0	1	1
0x700	0x300		1	1	3
0x800	0x400		0	0	0
0x900	0x400		1	0	2
0xA00	0x500		0	0	0
0xB00	0x500		1	0	2

Notice how endpoint0 maps HPA 0x0 and 0x200 correctly, but then HPA
0x800 results in DPA 0x200 to 0x400 on endpoint0 being not skipped.

Fix this by restricing the region granularity to be equal to the window
granularity resulting in the following for a x4 region under a x2 window
at a granularity of 256.

HPA	DPA Offset	HB	Port	EP
0x0	0x0		0	0	0
0x100	0x0		1	0	2
0x200	0x0		0	1	1
0x300	0x0		1	1	3
0x400	0x100		0	0	0
0x500	0x100		1	0	2
0x600	0x100		0	1	1
0x700	0x100		1	1	3

Not that it ever made practical sense to support region granularity >
window granularity. The window rotates host bridges causing endpoints to
never see a consecutive stream of requests at the desired granularity
without breaks to issue cycles to the other host bridge.

Fixes: 80d10a6cee05 ("cxl/region: Add interleave geometry attributes")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 641bc6344a4a..401148016978 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -395,13 +395,14 @@ static ssize_t interleave_granularity_store(struct device *dev,
 		return rc;
 
 	/*
-	 * Disallow region granularity less than root granularity to
-	 * simplify the implementation. Otherwise, region's with a
-	 * granularity less than the root interleave result in needing
-	 * multiple endpoints to support a single slot in the
-	 * interleave.
+	 * When the host-bridge is interleaved, disallow region granularity !=
+	 * root granularity. Regions with a granularity less than the root
+	 * interleave result in needing multiple endpoints to support a single
+	 * slot in the interleave (possible to suport in the future). Regions
+	 * with a granularity greater than the root interleave result in invalid
+	 * DPA translations (invalid to support).
 	 */
-	if (val < cxld->interleave_granularity)
+	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
 	rc = down_write_killable(&cxl_region_rwsem);

