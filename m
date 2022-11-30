Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C58C4321E
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiK3XVA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiK3XUm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 18:20:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA810B0328
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 15:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669850005; x=1701386005;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=er5rcaLuDpbnT7fs/EuI+OwZZrxSFUterqYzVlsiiJc=;
  b=CddgDNSQwwFWzrV8GFo5zfbnH9fc9Q8sqyQwnyQKqnEsCKEMcy+5DrEC
   NMGtouo/wmj02z9WDSNC/8wKDLVfyXClecnrf8WCsXSUQrjAI0nI4eVXp
   yiT7WikK2qRCFF+LdEtk/T9khxRJ17ijuPGmShgARXpwuaNbvRX8utnV/
   TFgz+lKH0v4XSlXnauv+BOWEFGY8MWgG9DNWdvn+4gAGYmUuHv2X3M8rB
   XdBthF/1utvZTlf0hBOQs82UFJ4ak8XSZh1ERLqtQ+6Xb676z0ysZJiAJ
   mNvo9Y5q/CmFYTBNTH2sU8dZ3/CA01FBFo3PLvQUrPtLpc+FoHZG+mllH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379812064"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379812064"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733171098"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="733171098"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:49 -0800
Subject: [RFC PATCH 6/8] cxl: create emulated decoders for devices without HDM
 decoders
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rrichter@amd.com, terry.bowman@amd.com
Date:   Wed, 30 Nov 2022 16:12:49 -0700
Message-ID: <166984996963.2805382.2390204746333079984.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL rev3.0 spec 8.1.3
RCDs may not have HDM register blocks. Create fake decoders based on CXL
PCIe DVSEC registers. The DVSEC Range Regiters provide the memory range for
these decoder structs. For the RCD, there can be up to 2 decoders depending
on the DVSEC Capability register HDM_count.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c |   59 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3a9e9b854587..60b6c141f514 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -721,6 +721,29 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
 	return 0;
 }
 
+static int init_emulated_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
+				     struct cxl_endpoint_dvsec_info *info, int which)
+{
+	if (info->dvsec_range[which].start == CXL_RESOURCE_NONE)
+		return -ENODEV;
+
+	cxld->hpa_range = (struct range) {
+		.start = info->dvsec_range[which].start,
+		.end = info->dvsec_range[which].end,
+	};
+
+	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxld->target_type = CXL_DECODER_ACCELERATOR;
+	if (cxld->id != port->commit_end + 1) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Committed out of order\n",
+			 port->id, cxld->id);
+		return -ENXIO;
+	}
+	port->commit_end = cxld->id;
+	return 0;
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
@@ -739,6 +762,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (is_endpoint_decoder(&cxld->dev))
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
 
+	if (!hdm) {
+		if (cxled)
+			return init_emulated_hdm_decoder(port, cxld, info, which);
+		else
+			return -EINVAL;
+	}
+
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
 	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
@@ -832,19 +862,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	return 0;
 }
 
-/**
- * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
- * @cxlhdm: Structure to populate with HDM capabilities
- */
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
-				struct cxl_endpoint_dvsec_info *info)
+static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	struct cxl_port *port = cxlhdm->port;
-	int i, committed;
-	u64 dpa_base = 0;
+	int committed, i;
 	u32 ctrl;
 
+	if (!hdm)
+		return;
+
 	/*
 	 * Since the register resource was recently claimed via request_region()
 	 * be careful about trusting the "not-committed" status until the commit
@@ -861,6 +887,21 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	/* ensure that future checks of committed can be trusted */
 	if (committed != cxlhdm->decoder_count)
 		msleep(20);
+}
+
+/**
+ * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
+ * @cxlhdm: Structure to populate with HDM capabilities
+ */
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_port *port = cxlhdm->port;
+	int i;
+	u64 dpa_base = 0;
+
+	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
 		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };


