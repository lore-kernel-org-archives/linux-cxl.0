Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE56DC05027
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 19:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjBNTlh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNTlh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 14:41:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAD92BEF2
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676403696; x=1707939696;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyeuKSSXsD8L2XP6hCzly7UAxFq0OjqfVapFcno9ZIQ=;
  b=V/i3Kkq4VzrufPJEdD8VvwmeIUmK5ag3N9SAg8GEnqtqui/9u7NkizHv
   Ils/LBVh43e14eme97j7RiTM+m+SUfdsHBg1J968qpRJmdfWZhHjnJRr1
   UBW/ysqAMH1WyIXGweP8ZCbd9fSUfI28/A35gcijjWqCobVvN0mZ0+Q01
   hf5ULso0lxoUELzq7gzS5Pxtj0Zpfd+2GaA5eQr+Co+NxB4Hx/mNAxTJE
   brwXi0zbu6u9FO8L2kQABBYm4QJtinCEo+psB3P7eQ8Z97pe6lPqXmZGN
   UzaGmonT56bxrzDj7Z6t8CkEOW57nUZRcH4LpfYRoJKnIqlcoKjjOLL0L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329877769"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="329877769"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="662653292"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="662653292"
Received: from mofarooq-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.68.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:35 -0800
Subject: [PATCH v5 6/7] cxl/hdm: Add emulation when HDM decoders are not
 committed
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Tue, 14 Feb 2023 11:41:35 -0800
Message-ID: <167640369536.935665.611974113442400127.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
References: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

For the case where DVSEC range register(s) are active and HDM decoders are
not committed, use RR to provide emulation. A first pass is done to note
whether any decoders are committed. If there are no committed endpoint
decoders, then DVSEC ranges will be used for emulation.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
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
 

