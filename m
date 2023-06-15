Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC1EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbjFOBa1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbjFOBa0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:30:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF9212A
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792626; x=1718328626;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gN8BJtVwevndGATx0j5H+aVeVis6ShXYsLCj7Mb/sF0=;
  b=KgP6x3JWPVITZ8bkCDGon8SNiwzXD5bCF9jQtqBZfZMlSlUizUXSZO6N
   5SXDknB2cCEDh1gbYI7YOnrQhvlHC3+PirzHt3V7223SsJ8F1eJ3zBzYL
   TeaD6RN/FqpizuR6ujAY8M+8Sduaw2ptgmV3gALllPnbAs1lT6p31MzLP
   g4hT2XqIvJ3i634RYN4t6RNvI04WGJuVdwgCK3x1bVWNzyDRWbWYUzTYE
   XrSmJboCNdEqr2qs0j4HkN9s2H9FYJXMQIRBBhwpjFcK0T7bvUQbljzGv
   s95mXGTyrVk6f3qChXpOn6wZgK5rTktCD0z2Ou0RUHw+s4EINMQ/E+92S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338412402"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338412402"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782307422"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782307422"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:25 -0700
Subject: [PATCH v2 09/12] cxl/region: Manage decoder target_type at
 decoder-attach time
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Wed, 14 Jun 2023 18:30:25 -0700
Message-ID: <168679262543.3436160.13053831955768440312.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Switch-level (mid-level) decoders between the platform root and an
endpoint can dynamically switch modes between HDM-H and HDM-D[B]
depending on which region they target. Use the region type to fixup each
decoder that gets allocated to map the given region.

Note that endpoint decoders are meant to determine the region type, so
warn if those ever need to be fixed up, but since it is possible to
continue do so.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6a875f86901b..013f3656e661 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -809,6 +809,18 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 		return -EBUSY;
 	}
 
+	/*
+	 * Endpoints should already match the region type, but backstop that
+	 * assumption with an assertion. Switch-decoders change mapping-type
+	 * based on what is mapped when they are assigned to a region.
+	 */
+	dev_WARN_ONCE(&cxlr->dev,
+		      port == cxled_to_port(cxled) &&
+			      cxld->target_type != cxlr->type,
+		      "%s:%s mismatch decoder type %d -> %d\n",
+		      dev_name(&cxled_to_memdev(cxled)->dev),
+		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
+	cxld->target_type = cxlr->type;
 	cxl_rr->decoder = cxld;
 	return 0;
 }

