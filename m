Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2992DECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 17:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJXRNO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 13:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJXRMq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 13:12:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B028CA98F6
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666626481; x=1698162481;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=onf9zROfXc1O2d23Hid9Fv8oBLaPpR69FBwqnshatss=;
  b=KpwM/eeuX+pQPVK5pu8dwlfDEhalbxQRb/XKzQZMMbdUOROPag7ou24+
   eOvY7auK+GS+sxxTRY23Q+f9Xs52B3fUYb8P0SL7K63J0xMwZPu5D9qlc
   Gu0rp+Vk/BdfZMMuVVwGd/bswyn131fsMtoeU2laM/hHDNV1MNvPpWEgU
   uISbFoR3kuHCgK5UEVOebgoBrbXSGr6+p9ZIyPQTLAGD5vz4F9FuLR3zI
   yqrac4Sv73IOZHBpj7gC2lrCZY55S/RaYV9wds4TFYz5bR7KTZUtaGBRv
   /OJBXvprRs7M6jZrGfENhX7fLJSCkDzzgiIvW2z8kZAigR+PbjTszJOR9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="306183414"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="306183414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:43:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="806348297"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="806348297"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:43:30 -0700
Subject: [PATCH v3] cxl: check decoder count for end device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Mon, 24 Oct 2022 08:43:30 -0700
Message-ID: <166662616015.232090.4970569004666131514.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
indicates that for devices, only 10 decoders should be advertised. Add
check on number of decoders greater than 10 for devices and emit warning.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v3:
- Fix commit header and output message to reflect code change from v2.

v2:
- Remove decoder count reassignment from violation (Dan)

 drivers/cxl/core/hdm.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..c3b756f93261 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -71,9 +71,19 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
 static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 {
 	u32 hdm_cap;
+	struct device *dev = &cxlhdm->port->dev;
 
 	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
 	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
+	/*
+	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
+	 * more than 10 decoders. Switches and Host Bridges may advertise up to
+	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
+	 * found.
+	 */
+	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
+		dev_warn(dev, "Endpoint decoder count (%d) > 10, spec violation!\n",
+			 cxlhdm->decoder_count);
 	cxlhdm->target_count =
 		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))


