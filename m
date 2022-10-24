Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797F8ECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 17:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiJXRIh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 13:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiJXRIO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 13:08:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489679D503
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666626188; x=1698162188;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xEhwIotXJ1l3c5mv/nxCQcYH55y6PkLu4Y1pdh7lQoE=;
  b=ckl49YtSwaGku8b5aSPyzk9g4zr1qf8wr9RBveigEtRWdmGC13aBZ92A
   7VgzlPqUmu56ynzJTFMV//O5x8EplhPa0qXvw9WR9uQAIy3A3eYiqc4gS
   B5LZjN70fR0MNuz0p0KLGR6Jklt1HYbH9g1k7+0J4DIukwlgN+Gd6QaCJ
   CfleUvyTY6X1EksT1qwVwf13IPy/Z3QtSKrcJ4vntYy+UqtVxVF7vH9F7
   V3kcJIlbjEs+8jhYv5U73JEP90K27Ghk+4smgOjpZWLPD9hbLiiZjGopQ
   cju01aWeY289xDM4UiNvQCmlAyqkbSjkgCdjd4p2IQJYo4TkPwKQR4buh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287170127"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287170127"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:39:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="756613228"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="756613228"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:39:12 -0700
Subject: [PATCH v2] cxl: check decoder count for end device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Mon, 24 Oct 2022 08:39:11 -0700
Message-ID: <166662591658.231711.18305612334545370247.stgit@djiang5-desk3.ch.intel.com>
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

v2:
- Remove decoder count reassignment from violation (Dan)

 drivers/cxl/core/hdm.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..ff53c758e95a 100644
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
+		dev_warn(dev, "Reset decoders count (%d) to 10, spec violation!\n",
+			 cxlhdm->decoder_count);
 	cxlhdm->target_count =
 		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))


