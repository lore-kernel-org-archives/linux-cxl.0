Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D476FC6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjC2VhF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjC2Vgq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 17:36:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B77730C7
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680125805; x=1711661805;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iZ//7D047zw5T0ln0QtvlZLMdWGyeOLrS+N9cbPIoVc=;
  b=myo5HvxNoAfp4ax4b3UGdCao1ksmkoyyH/pY/rt+U6UWsMzVDr8BjjqZ
   T6T55cgTl61OPMwm0QC+Y3jMdS2VMNdj3oUBgz9+7Faj/j6ExAJiXAV9g
   sEMNaWN2qudwmLs30UyPAPJpCfRahhCiewCuEmOP+m+5AHQXh52uv0jvw
   h9moJvmYErrI09c4QKWoz1+NHdnG3DVbv6KB0yPI8W2fGpovrPhPawu2u
   N52HHp6uG/S0MI+c5KFyARDKtXs0WYN+8m5EPz9Ezg6AsJArQ3coMJYjL
   TjTspxIMFvJ9/b3PMdnHudCQC2j+dfTaWKFVzZXf5nSP0WWiXH3eUb9Zw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="321391436"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="321391436"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:35:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753754492"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="753754492"
Received: from zmutlu-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.176.100])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:35:55 -0700
Subject: [PATCH] cxl/hdm: Extend DVSEC range register emulation for region
 enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>
Date:   Wed, 29 Mar 2023 14:35:55 -0700
Message-ID: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 9884b6d4d930..5339c0719177 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -738,20 +738,26 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
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
+	struct range *range;
+	int rc;
+
 	if (!is_cxl_endpoint(port))
 		return -EOPNOTSUPP;
 
-	if (!range_len(&info->dvsec_range[which]))
+	cxled = to_cxl_endpoint_decoder(&cxld->dev);
+	range = &info->dvsec_range[which];
+	if (!range_len(range))
 		return -ENOENT;
 
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->commit = NULL;
 	cxld->reset = NULL;
-	cxld->hpa_range = info->dvsec_range[which];
+	cxld->hpa_range = *range;
 
 	/*
 	 * Set the emulated decoder as locked pending additional support to
@@ -760,6 +766,17 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
 	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
 	port->commit_end = cxld->id;
 
+	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, range_len(range), 0);
+	if (rc) {
+		dev_err(&port->dev,
+			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
+			port->id, cxld->id, *dpa_base,
+			*dpa_base + range_len(range) - 1, rc);
+		return rc;
+	}
+	*dpa_base += range_len(range);
+	cxled->state = CXL_DECODER_STATE_AUTO;
+
 	return 0;
 }
 
@@ -779,7 +796,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	} target_list;
 
 	if (should_emulate_decoders(info))
-		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
+		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
+							which, info);
 
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));

