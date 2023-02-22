Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFF6C61DA3
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 01:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBVBvn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBvm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 20:51:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB6D2CFC8
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 17:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677030685; x=1708566685;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1i+6jn8qoRuqmM3GZLn1QLDY80EGXT3hr3QQm9xF18Y=;
  b=n4lJPlSz27S/nc1PSuAjAFxoYp1RUkZzhoSOcnka8vAMd9LyEWM/6iy0
   S9w6lrFi49ehFWKMRcmw+sF0rz1V1rU0+1oc6HtBUczSMRQXRSP5zbSXE
   sQUSfSzFJb5T2AXXv1q4SLmemQik0l+Olx0WmTF35Knggsuj2mUaNY/DL
   AfN3SBTkfEofGPhmkWrP67fPm4M++bEKF7A4aLw7LairiyLd7ZtPlteCC
   q9Ygqk1S5MFc1M9K7J+JUB6UWOL9XgT55XUKTNXCIZQJj1qhNPWahR2t9
   T7LJUFscKw7Ysv+HEA+4UiDHMQqLiMk9lrU8mUu+V/fytRuHelmR50Oit
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="360288009"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="360288009"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:51:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="621737207"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="621737207"
Received: from pjois-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.101.5])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:51:24 -0800
Subject: [PATCH 2/2] cxl/hdm: Skip emulation when driver manages mem_enable
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dave.jiang@intel.com
Date:   Tue, 21 Feb 2023 17:51:24 -0800
Message-ID: <167703068474.185722.664126485486344246.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

If the driver is allowed to enable memory operation itself then it can
also turn on HDM decoder support at will.

With this the second call to cxl_setup_hdm_decoder_from_dvsec(), when
an HDM decoder is not committed, is not needed.

Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
Link: http://lore.kernel.org/r/20230220113657.000042e1@huawei.com
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   31 ++++++++++++++++++-------------
 drivers/cxl/cxl.h      |    4 +++-
 drivers/cxl/port.c     |    2 +-
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 520814130928..5293fe13fce3 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -717,19 +717,29 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
 	return 0;
 }
 
-static bool should_emulate_decoders(struct cxl_port *port)
+static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
-	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
-	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_hdm *cxlhdm;
+	void __iomem *hdm;
 	u32 ctrl;
 	int i;
 
-	if (!is_cxl_endpoint(cxlhdm->port))
+	if (!info)
 		return false;
 
+	cxlhdm = dev_get_drvdata(&info->port->dev);
+	hdm = cxlhdm->regs.hdm_decoder;
+
 	if (!hdm)
 		return true;
 
+	/*
+	 * If HDM decoders are present and the driver is in control of
+	 * Mem_Enable skip DVSEC based emulation
+	 */
+	if (!info->mem_enabled)
+		return false;
+
 	/*
 	 * If any decoders are committed already, there should not be any
 	 * emulated DVSEC decoders.
@@ -747,7 +757,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
-	struct cxl_endpoint_decoder *cxled = NULL;
+	struct cxl_endpoint_decoder *cxled;
 	u64 size, base, skip, dpa_size;
 	bool committed;
 	u32 remainder;
@@ -758,12 +768,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		unsigned char target_id[8];
 	} target_list;
 
-	if (should_emulate_decoders(port))
+	if (should_emulate_decoders(info))
 		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
 
-	if (is_endpoint_decoder(&cxld->dev))
-		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
 	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
@@ -784,9 +791,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
-	if (cxled && !committed && range_len(&info->dvsec_range[which]))
-		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
-
 	/* decoders are enabled if committed */
 	if (committed) {
 		cxld->flags |= CXL_DECODER_F_ENABLE;
@@ -824,7 +828,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (rc)
 		return rc;
 
-	if (!cxled) {
+	if (!info) {
 		target_list.value =
 			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		for (i = 0; i < cxld->interleave_ways; i++)
@@ -844,6 +848,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		return -ENXIO;
 	}
 	skip = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
+	cxled = to_cxl_endpoint_decoder(&cxld->dev);
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d853a0238ad7..dd4b7a729419 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -695,13 +695,15 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
- * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
+ * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
  * @ranges: Number of active HDM ranges this device uses.
+ * @port: endpoint port associated with this info instance
  * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
  */
 struct cxl_endpoint_dvsec_info {
 	bool mem_enabled;
 	int ranges;
+	struct cxl_port *port;
 	struct range dvsec_range[2];
 };
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 1049bb5ea496..9c8f46ed336b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -78,8 +78,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
+	struct cxl_endpoint_dvsec_info info = { .port = port };
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
-	struct cxl_endpoint_dvsec_info info = { 0 };
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
 	struct cxl_port *root;

