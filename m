Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B86C54EBE
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Jan 2023 21:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjAIVoQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjAIVoI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 9 Jan 2023 16:44:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A594DC8
        for <linux-cxl@vger.kernel.org>; Mon,  9 Jan 2023 13:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673300647; x=1704836647;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fx7sWD4wX92tsiAevGnOosHj/a5EJwFgkJqoukHvyf0=;
  b=epi742WxfnLAt3C4sfUcLa7ufSPhvBbZ9gMTqWxmTLq/SPNTYKI/Q34s
   gH2nWsoQQsxmrLhuwVjcNQ5zgjJm9w+PVtlvYER4a+6exNLFNgotvZG9n
   oa0XwP7HHt4HnqU7M1/dewdxBMcosLO1ML0nzfUGP1T8QEjP5NRccc+k8
   SjMWXLEJxp3Hs53bWhBQb8i7/GsLB3DW8QX5E9WeSVYO04lLpBH6HVIWm
   nZbwrqMjRmLvY2hWGZahrLkuzW2bzDoNNlHp2F8qCQu97oX0qz4PjF8lG
   HIriFN5YTF7CiCBIhdw8NOKUtE56N8wSZiqVmUmt3HlpouTbs64xEq9m8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324996133"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324996133"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:44:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="780833630"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="780833630"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.37.174])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:44:05 -0800
Subject: [PATCH v2 7/8] cxl: Add emulation when HDM decoders are not committed
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Mon, 09 Jan 2023 14:44:03 -0700
Message-ID: <167330064247.975161.16867413974628215063.stgit@djiang5-mobl3.local>
In-Reply-To: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c |   39 ++++++++++++++++++++++++++++++++-------
 drivers/cxl/cxl.h      |    1 +
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ed5e9ef3aa9b..40844ff2fe52 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -729,6 +729,33 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
 	return 0;
 }
 
+static bool should_emulate_decoders(struct cxl_hdm *cxlhdm)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	bool committed;
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
+		committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+		if (committed)
+			return false;
+	}
+
+	return true;
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
@@ -744,16 +771,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
@@ -889,6 +912,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
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


