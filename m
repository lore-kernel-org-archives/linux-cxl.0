Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4779DC38159
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 18:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjARSKQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjARSJs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 13:09:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D952C5AA4D
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 10:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674065363; x=1705601363;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zVU9M/3xOIeHEW7yM1YWrghQ2+9shCTXIWXHYA6UFvo=;
  b=KF0+WpSCDfhMIKqIgAh29nbtCumkaE0HAAEa5RS84MgFwoPR4zOFfUny
   H5xlmSAedJUyJoI6yAVrBd7/GJ0HqfEJnyk8emN/9EK98cqHuph58P9zt
   8sVeO+R9LjfdGWWCjTBQ7mB3VBu4vNde/h7W7qL3Uhb/M/R2RtNJR0nHe
   2mmaX1hei8BnX3XhXT44m38C3ubgFjXR2JsSzqPxy9NqoT/+z8KdCKuH8
   QACJ8HoTHsYCK8CFM9sc3dgaNg68Mb62hlov4jJ1NvOSaDB1lX+P69IEX
   +WTgb/aXKnwyjl8MGdYmtPqi9nIStCsY3apaJrgkPRDEwXTQYfPCB8PBt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="387406225"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="387406225"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:09:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="905195573"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="905195573"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.179.103])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:09:22 -0800
Subject: [PATCH v3 7/8] cxl: Add emulation when HDM decoders are not committed
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Wed, 18 Jan 2023 11:09:21 -0700
Message-ID: <167406535984.1455071.5414508134960800436.stgit@djiang5-mobl3.local>
In-Reply-To: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
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
 drivers/cxl/core/hdm.c |   37 ++++++++++++++++++++++++++++++-------
 drivers/cxl/cxl.h      |    1 +
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index cbec955db4c9..32728f63084a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -730,6 +730,31 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
 	return 0;
 }
 
+static bool should_emulate_decoders(struct cxl_hdm *cxlhdm)
+{
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
@@ -745,16 +770,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		unsigned char target_id[8];
 	} target_list;
 
+	if (info->emulate_decoders)
+		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
+
 	if (is_endpoint_decoder(&cxld->dev))
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
 
-	if (!hdm) {
-		if (!cxled)
-			return -EINVAL;
-
-		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
-	}
-
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
 	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
@@ -890,6 +911,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
 	cxl_settle_decoders(cxlhdm);
 
+	info->emulate_decoders = should_emulate_decoders(cxlhdm);
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
 		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
 		int rc, target_count = cxlhdm->target_count;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0ec047cced90..f1aa57a95150 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -640,6 +640,7 @@ struct cxl_endpoint_dvsec_info {
 	bool mem_enabled;
 	int ranges;
 	struct range dvsec_range[2];
+	bool emulate_decoders;
 };
 
 struct cxl_hdm;


