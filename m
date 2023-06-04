Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34DFC77B73
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjFDXcS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFDXcR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0262AC
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921536; x=1717457536;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xaa/DBEo33nXZo8Trd+qkfIeKF8XEBSLMNr0phNzuTI=;
  b=jwH8BkhumC2BBGzsL51scBQHqvHap0YcOf2BsboX8xbPjFdXZcpMrzyg
   cbeJzADKq1DTbK0oITJuZq0C2wFePCJYd5g8mDN3DipwPNwV0rb4zXXjq
   2Ajs3mhO3CwGNbm7FpUPPPnoZ0BuSKdPVxpJwTunGVr0yKjgZ5R5co3Tu
   /Qpn/1th7J4xr5LLzzBkI1k2gyNsnGawEXABakT/I1bGjLBWiuYuRSR0h
   EuNCZq5iiSJmuOCJ/E25sUu94dr3IFChMLxIMB2t9xkOXRWtnQ9mXOnzJ
   PCJaOI7otKjcjF3ax5mEbJYYJksKiDlET9R7iwUhJUYVD9I96bSutv94D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384534749"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384534749"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="832611432"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="832611432"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:16 -0700
Subject: [PATCH 07/19] cxl/region: Manage decoder target_type at
 decoder-attach time
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:32:16 -0700
Message-ID: <168592153599.1948938.3754212703217628741.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dca94c458b8f..c7170d92f47f 100644
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

