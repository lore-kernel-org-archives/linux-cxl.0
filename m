Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0ADC76196
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Apr 2023 23:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjDCXGR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Apr 2023 19:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjDCXGR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Apr 2023 19:06:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A5AA8
        for <linux-cxl@vger.kernel.org>; Mon,  3 Apr 2023 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680563175; x=1712099175;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LduSQlEmDuRBUPQLoUBunWoyhUYcAiAySEiUnMY2GZk=;
  b=D7GaLIB/KIAY/n4N8ovNJR0I6O8xqJFa9hNdkUwauXCY7md8orD9faJm
   R7QrqAFVpj79sB6cKeweBQCYgsW1yxtZrbtTmKpKr/hjNLUzbbWeM4u/9
   l1/VXTqv24ODvz+VRCwYytWCgLbP/rwNIkxd4C5qbpH4f1MDAg6FYdw9O
   NaGkzdBejiXZvHYAXvvSLVJfV2Ru1UYbEQIuaGMmjyKMAy8AzxpRdQerJ
   oDPa2Gc9rTmDySnP1gI1Spu2uuNCKSGsEQnv8of6/mYyU3P4rFTVz4x0k
   ZUoZiUO5K6Sto1HC7kXOamkRLjH92mgFykBtd0miC3vq3iMYHWvslxKsP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="342062664"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="342062664"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 16:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775398287"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="775398287"
Received: from kkohner-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.97.191])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 16:06:14 -0700
Subject: [PATCH v2] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Gregory Price <gregory.price@memverge.com>
Date:   Mon, 03 Apr 2023 16:06:14 -0700
Message-ID: <168056315526.436217.14417826023537916154.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

One motivation for mapping range registers to decoder objects is
to use those settings for region autodiscovery.

The need to map a region for devices programmed to use range registers
is especially urgent now that the kernel no longer routes "Soft
Reserved" ranges in the memory map to device-dax by default. The CXL
memory range loses all access mechanisms.

Complete the implementation by filling out ways and granularity, marking
the DPA reservation, and setting the endpoint-decoder state to signal
autodiscovery.

Fixes: 09d09e04d2fc ("cxl/dax: Create dax devices for CXL RAM regions")
Tested-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gregory.price@memverge.com>
Link: https://lore.kernel.org/r/168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1:
- Swap out the local @range variable which was mostly only used for the
  mapping length with a @len variable for that purpose (Jonathan)

 drivers/cxl/core/hdm.c |   27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 9884b6d4d930..02cc2c38b44b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -738,14 +738,20 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
 	return 0;
 }
 
-static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
-					    struct cxl_decoder *cxld, int which,
-					    struct cxl_endpoint_dvsec_info *info)
+static int cxl_setup_hdm_decoder_from_dvsec(
+	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
+	int which, struct cxl_endpoint_dvsec_info *info)
 {
+	struct cxl_endpoint_decoder *cxled;
+	u64 len;
+	int rc;
+
 	if (!is_cxl_endpoint(port))
 		return -EOPNOTSUPP;
 
-	if (!range_len(&info->dvsec_range[which]))
+	cxled = to_cxl_endpoint_decoder(&cxld->dev);
+	len = range_len(&info->dvsec_range[which]);
+	if (!len)
 		return -ENOENT;
 
 	cxld->target_type = CXL_DECODER_EXPANDER;
@@ -760,6 +766,16 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
 	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
 	port->commit_end = cxld->id;
 
+	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
+	if (rc) {
+		dev_err(&port->dev,
+			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
+			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
+		return rc;
+	}
+	*dpa_base += len;
+	cxled->state = CXL_DECODER_STATE_AUTO;
+
 	return 0;
 }
 
@@ -779,7 +795,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	} target_list;
 
 	if (should_emulate_decoders(info))
-		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
+		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
+							which, info);
 
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));

