Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DF6ECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIPXL0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIPXLZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:11:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A339D11A
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663369884; x=1694905884;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k5cHlGWY4EmcsQsYex6FDcP/zis5eJbzwrkle93UcAM=;
  b=inJyeKpCdu42MBRkSM9b22R3ASe/9Gx6R7uam2/jz9IQ4OAOHC5jHbu6
   dtroi/D8TebpTCa7XnQxmqH/+PSYNp3i0A5+xQjJUScuE4Ho1qHJsz4LG
   d+g7/24s1zUFt3l82uYwDzW9WNsvWRJQ44iFcdwWpUE9+Zo+07CQYbifh
   na5sxlU9fJtrIHzhHtq248HPQerwbYyk2wPGqDa0drtnpornG+3ti/F4Z
   eSZfJNi9BMQOL1Ta2XvE9hyUcoPfH0HaWLNq+3mt1SjhYgfQSdsXB3+iz
   524hB3Oqyy50Ztdp+uBZw3PYnBNrWXxoixGGuAaPQWmbdaNV6oGjep4DZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="286138600"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="286138600"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="686305283"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:23 -0700
Subject: [PATCH RFC v2 5/9] cxl/port: Limit the port driver to just the HDM
 Decoder Capability
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, shiju.jose@huawei.com,
        rrichter@amd.com
Date:   Fri, 16 Sep 2022 16:11:22 -0700
Message-ID: <166336988294.3803215.7334374806071251168.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Update the port driver to use cxl_map_component_registers() so that the
component register block can be shared between the cxl_pci driver and
the cxl_port driver. I.e. stop the port driver from reserving the entire
component register block for itself via request_region() when it only
needs the HDM Decoder Capability subset.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..061551148cfe 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -82,18 +82,22 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
 }
 
-static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
-					  void __iomem *crb)
+static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
+				struct cxl_component_regs *regs)
 {
-	struct cxl_component_reg_map map;
+	struct cxl_register_map map = {
+		.resource = port->component_reg_phys,
+		.base = crb,
+		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
+	};
 
-	cxl_probe_component_regs(&port->dev, crb, &map);
-	if (!map.hdm_decoder.valid) {
+	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
+	if (!map.component_map.hdm_decoder.valid) {
 		dev_err(&port->dev, "HDM decoder registers invalid\n");
-		return IOMEM_ERR_PTR(-ENXIO);
+		return -ENXIO;
 	}
 
-	return crb + map.hdm_decoder.offset;
+	return cxl_map_component_regs(&port->dev, regs, &map);
 }
 
 /**
@@ -103,25 +107,25 @@ static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
 {
 	struct device *dev = &port->dev;
-	void __iomem *crb, *hdm;
 	struct cxl_hdm *cxlhdm;
+	void __iomem *crb;
+	int rc;
 
 	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
 	if (!cxlhdm)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
-	crb = devm_cxl_iomap_block(dev, port->component_reg_phys,
-				   CXL_COMPONENT_REG_BLOCK_SIZE);
+	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
 	if (!crb) {
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
 	}
 
-	hdm = map_hdm_decoder_regs(port, crb);
-	if (IS_ERR(hdm))
-		return ERR_CAST(hdm);
-	cxlhdm->regs.hdm_decoder = hdm;
+	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
+	iounmap(crb);
+	if (rc)
+		return ERR_PTR(rc);
 
 	parse_hdm_decoder_caps(cxlhdm);
 	if (cxlhdm->decoder_count == 0) {


