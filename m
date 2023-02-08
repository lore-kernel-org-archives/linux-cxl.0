Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3074C64EC7
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 19:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjBHTVz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjBHTVw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 14:21:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975353E7A
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675884101; x=1707420101;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+VaGE5DKf6ZbLvGvyK94FdZgwMm1sqj4CnNcE4fZ0NE=;
  b=G3h7epq4SAnrSiIr5Z9F/ncRaR4JN+vRCe2YKxTbJjSZS9BVCqlcvE24
   GIcgpT6UOF9JUQerH7fuiQ/VGy8j3DjoqXhjCDfBHlAUtzbCXPMtVB5wx
   +0nX81Pm0cerEVNWOhDI5UrEDtwh7YfzZWQC4Y9BKahikKlYnnWQACg/9
   mdPmsvP4cp9Aj59AYusvpk4DVDr42dROGnnFmSgKQ1kPHwyNde6UKPNB8
   Pi8vBcfY+jy/S6J4piziMaZt24K+DlMlgZ/n3FJXpPinfAReoOY5hbcxE
   jNekFo+/VUKyhFa4CS8x4YjiBBsYQFBJfefNGNpFgO9CFK0G47B1UHVEa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416119852"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="416119852"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:21:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912825238"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912825238"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.48.215])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:21:40 -0800
Subject: [PATCH v4 6/7] cxl: Add emulation when HDM decoders are not committed
From:   Dave Jiang <dave.jiang@intel.com>
To:     dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Date:   Wed, 08 Feb 2023 12:21:38 -0700
Message-ID: <167588409751.1155956.623031449338237326.stgit@djiang5-mobl3.local>
In-Reply-To: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
References: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For the case where DVSEC range register(s) are active and HDM decoders are
not committed, use RR to provide emulation. A first pass is done to note
whether any decoders are committed. If there are no committed endpoint
decoders, then DVSEC ranges will be used for emulation.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v4:
- Remove ->emulate_decoders (Dan)
- Removed previous patch to just delete in this patch. (Dan)
---
 drivers/cxl/core/hdm.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index a49543f22dca..39e02f28b6a6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -730,6 +730,32 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
 	return 0;
 }
 
+static bool should_emulate_decoders(struct cxl_port *port)
+{
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	u32 ctrl;
+	int i;
+
+	if (!is_cxl_endpoint(cxlhdm->port))
+		return false;
+
+	if (!hdm)
+		return true;
+
+	/*
+	 * If any decoders are committed already, there should not be any
+	 * emulated DVSEC decoders.
+	 */
+	for (i = 0; i < cxlhdm->decoder_count; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return false;
+	}
+
+	return true;
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
@@ -745,6 +771,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		unsigned char target_id[8];
 	} target_list;
 
+	if (should_emulate_decoders(port))
+		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
+
 	if (is_endpoint_decoder(&cxld->dev))
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
 


