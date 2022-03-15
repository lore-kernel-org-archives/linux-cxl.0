Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3BDC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Mar 2022 01:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbiCOBYD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbiCOBYC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Mar 2022 21:24:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E3D25F2
        for <linux-cxl@vger.kernel.org>; Mon, 14 Mar 2022 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647307370; x=1678843370;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qN9p5xk/WTDkF0MZWYCxJPoJ4gEUABCCaka9eqvWLf4=;
  b=HgkqF10HA2rfFk6curRavQaO3b1+vNud0rkXk1fnEBCSOgnVo96T7FjC
   J+7vXZ076A1o9wKGowidvbLickKWGcCd1ANKLOeTg2dF5FWeu0PvHSJZN
   FxVcxD+sRQoV6BrQJQpNS6WBIZWzdVKRnulOWQY8bz/R2aiGUZqqJ0WFv
   4Q1jPBzfDbzIha8ruu/Utg7OI4gS4tASFoKSk8poyEjp8WP9Lbcr6zP78
   1drtmuw2dhIrQNdBMo1/RFuo3v7nYi+/syqMSn0lVU1rkYGkSl7ctJsgJ
   bFYUfNJl4nlj88PLOkuw1DiHB4vkY20Xb9s1CGyui8QAzg1UCadweMAQA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319408179"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="319408179"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="512432574"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:49 -0700
Subject: [PATCH v2 6/6] cxl/mem: Replace redundant debug message with a
 comment
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Mon, 14 Mar 2022 18:22:49 -0700
Message-ID: <164730736948.3806189.17828261054974867700.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

cxl_mem_probe() already emits a log message when HDM operation can not
be established. Delete the similar one in cxl_hdm_decode_init().

What is less obvious is why global_ctrl being enabled makes positive
values of info->ranges irrelevant.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3baae1332760..6def7d7b6bfd 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -107,11 +107,16 @@ __mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
 	global_ctrl = readl(crb + cmap->hdm_decoder.offset +
 			    CXL_HDM_DECODER_CTRL_OFFSET);
 	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
-	if (!global_enable && info->ranges) {
-		dev_dbg(cxlds->dev,
-			"DVSEC ranges already programmed and HDM decoders not enabled.\n");
+
+	/*
+	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
+	 * [High,Low] when HDM operation is enabled the range register values
+	 * are ignored by the device, but the spec also recommends matching the
+	 * DVSEC Range 1,2 to HDM Decoder Range 0,1 so, non-zero info->ranges
+	 * are expected.
+	 */
+	if (!global_enable && info->ranges)
 		goto out;
-	}
 
 	retval = true;
 

