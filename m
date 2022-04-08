Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A2C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Apr 2022 19:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiDHTck (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Apr 2022 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbiDHTcg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Apr 2022 15:32:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307313EA9
        for <linux-cxl@vger.kernel.org>; Fri,  8 Apr 2022 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649446231; x=1680982231;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cS1FEn1GuK1u3UbOtH8EETpNYnI4qwJeWQXKIvBkqiI=;
  b=RHUCzjZSky1pM+Ty+8HuocbdeZluh+EFiFhV/76Zqmk86VwpJ+BLpdE4
   eV7rHIh6UQhAK6pXkIL0gwO3KTVqi2gt1mUJmYIX19IJlxNPYZfKD9tdT
   awzD2RE7Ga125nINVm/Wq82WAnQ9RqRNX2hy2/mSodlxHQeoc4URzdoaW
   f4MSh+MVtbGxHWPCWDYlIJ1qmEcEyKL8CcHeAWUsCFdZ5DpdW76gP8NB1
   WpgY7IwiSxTqxW1R7RjQvN2TpEhP5QpTwGG13Vkjhh9usGt40tH6e5nyK
   QccDlp+DMqwdUCIrJQxINOl5SRtAokx1LCvaFjv1CevwbThkA8R1fSNAW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261849804"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261849804"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:30:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="589337563"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:30:30 -0700
Subject: [PATCH v3 6/6] cxl/mem: Replace redundant debug message with a
 comment
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Date:   Fri, 08 Apr 2022 12:30:29 -0700
Message-ID: <164944616743.454665.7055846627973202403.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164730736948.3806189.17828261054974867700.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730736948.3806189.17828261054974867700.stgit@dwillia2-desk3.amr.corp.intel.com>
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
values of info->ranges irrelevant, and the Linux behavior with respect
to the spec recommendation to mirror CXL Range registers with HDM
Decoder Base + Size registers.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v2:
- Clarify that Linux does not maintain the spec recommended match
  between HDM decoders and CXL DVSEC range registers. (Ben and Jonathan)

 drivers/cxl/mem.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3baae1332760..43e73d259207 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -107,11 +107,17 @@ __mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
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
+	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
+	 * are expected even though Linux does not require or maintain that
+	 * match.
+	 */
+	if (!global_enable && info->ranges)
 		goto out;
-	}
 
 	retval = true;
 

