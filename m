Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42729ECAAA1
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Sep 2022 18:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIOSLK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Sep 2022 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIOSLJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Sep 2022 14:11:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927E75CCA
        for <linux-cxl@vger.kernel.org>; Thu, 15 Sep 2022 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663265468; x=1694801468;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=00hVdQty0E3L3tH2cVkG/9dtIuE76VBouch/i0b9L3o=;
  b=X0v+Y7B/GTl4xKkhsyoWsC7yDjiqhy4n2mLA6toOTr/greAT+hxOrecX
   mOnVJCJmYM/yt01ApK2wS65FRQU8xMG5FzRxbDKHSACVnr73S2lxxPz5n
   aZziA44Qrw/Ud8bB/d6iXbXm2XvmkYoYOPxgp7qmvFWWUrlpPgldMER+O
   5CRlAp0B/5quTVe9pTWN7ra9aOOjC7zFq4s+cbKd88KKbi6CM2t5KhaEH
   gkt17QDVlPJ8elFwYy9yUFN7gi3UL5FbK0JHeg8Hx6uKQH94ifbwHchVL
   i6svlFFkJ3xJS4kKfDxkc//xNlyLkvoLJsoFiYIsPqYnOO+32vz2PHlkz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="296389148"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="296389148"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 11:11:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="706463134"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 11:11:07 -0700
Subject: [PATCH] cxl: check decoder count for end device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Date:   Thu, 15 Sep 2022 11:11:07 -0700
Message-ID: <166326546707.3348078.8667496731861557941.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
indicates that for devices, only 10 decoders should be advertised. Add
check on number of decoders greater than 10 for devices and reset to 10 to
force spec compliance.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..1919d99d157e 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -71,9 +71,23 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
 static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 {
 	u32 hdm_cap;
+	int decoder_count;
+	struct device *dev = &cxlhdm->port->dev;
 
 	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
-	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
+	decoder_count = cxl_hdm_decoder_count(hdm_cap);
+	/*
+	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
+	 * more than 10 decoders. Switches and Host Bridges may advertise up to
+	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
+	 * found.
+	 */
+	if (is_cxl_endpoint(cxlhdm->port) && decoder_count > 10) {
+		dev_warn(dev, "Reset decoders count (%d) to 10, spec violation!\n",
+			 decoder_count);
+		decoder_count = 10;
+	}
+	cxlhdm->decoder_count = decoder_count;
 	cxlhdm->target_count =
 		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))


