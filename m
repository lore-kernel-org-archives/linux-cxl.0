Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C73EC47088
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 23:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiK3XUo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiK3XUM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 18:20:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898C798005
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 15:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669849985; x=1701385985;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJDyeITSCeC3z03AedLhyOfaQo2CXqiIxZuxZ1oRsS8=;
  b=JWQmmwIuKX0+bpEwlJS7SLR+/0FHO2QKRpu7vUl3T/WxMvzAZW7clGiP
   SKEdLWtqBRwbgPSVAOsQhoh4sDy4uiWUhSnsBlU3nXYlCr45NvvKLj3wX
   sUbr4m3WEC9iG++TQQL1ctyljt56gN3FJdy1BE3r2UrRzWlU3ChI0Vc8y
   Jd4ME0JyPAVNwe3EIG7cOLNEfQ2SNo1GgVE3irHWAACzgmDPKMr42zDj+
   wzsVNXlg2Joqpl6A6phT/5n4odgzAXVJkmPfezbyDkmU7MT2LI9/KyGML
   SCszrnEUeyBGCXbPeeRa3a/DZxmcBufX0+CBkm2OL7xXeTEa2bj79CifT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379811984"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379811984"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733171014"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="733171014"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:32 -0800
Subject: [RFC PATCH 3/8] cxl: refactor cxl_hdm_decode_init()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rrichter@amd.com, terry.bowman@amd.com
Date:   Wed, 30 Nov 2022 16:12:32 -0700
Message-ID: <166984995249.2805382.1339697898311247332.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With the previous refactoring of DVSEC range registers out of
cxl_hdm_decode_init(), it basically becomes a skeleton function. Squash
__cxl_hdm_decode_init() with cxl_hdm_decode_init() to simplify the code.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |  138 ++++++++++++++++++++----------------------------
 1 file changed, 57 insertions(+), 81 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7196b1fcdcfc..385dbe9bd5f2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -260,81 +260,6 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
 
-static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
-				  struct cxl_hdm *cxlhdm,
-				  struct cxl_endpoint_dvsec_info *info)
-{
-	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	struct cxl_port *port = cxlhdm->port;
-	struct device *dev = cxlds->dev;
-	struct cxl_port *root;
-	int i, rc, allowed;
-	u32 global_ctrl;
-
-	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-
-	/*
-	 * If the HDM Decoder Capability is already enabled then assume
-	 * that some other agent like platform firmware set it up.
-	 */
-	if (global_ctrl & CXL_HDM_DECODER_ENABLE) {
-		rc = devm_cxl_enable_mem(&port->dev, cxlds);
-		if (rc)
-			return false;
-		return true;
-	}
-
-	root = to_cxl_port(port->dev.parent);
-	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
-		root = to_cxl_port(root->dev.parent);
-	if (!is_cxl_root(root)) {
-		dev_err(dev, "Failed to acquire root port for HDM enable\n");
-		return false;
-	}
-
-	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
-		struct device *cxld_dev;
-
-		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
-					     dvsec_range_allowed);
-		if (!cxld_dev) {
-			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
-			continue;
-		}
-		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
-		put_device(cxld_dev);
-		allowed++;
-	}
-
-	if (!allowed) {
-		cxl_set_mem_enable(cxlds, 0);
-		info->mem_enabled = 0;
-	}
-
-	/*
-	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
-	 * [High,Low] when HDM operation is enabled the range register values
-	 * are ignored by the device, but the spec also recommends matching the
-	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
-	 * are expected even though Linux does not require or maintain that
-	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
-	 */
-	if (info->mem_enabled)
-		return false;
-
-	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
-	if (rc)
-		return false;
-
-	rc = devm_cxl_enable_mem(&port->dev, cxlds);
-	if (rc)
-		return false;
-
-	return true;
-}
-
-
 int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
 			struct cxl_endpoint_dvsec_info *info)
 {
@@ -445,17 +370,68 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct device *dev = &pdev->dev;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_port *root;
+	int i, rc, allowed;
+	u32 global_ctrl;
+
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 
 	/*
-	 * If DVSEC ranges are being used instead of HDM decoder registers there
-	 * is no use in trying to manage those.
+	 * If the HDM Decoder Capability is already enabled then assume
+	 * that some other agent like platform firmware set it up.
 	 */
-	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, info)) {
-		dev_err(dev,
-			"Legacy range registers configuration prevents HDM operation.\n");
-		return -EBUSY;
+	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
+		return devm_cxl_enable_mem(&port->dev, cxlds);
+
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return -ENODEV;
 	}
 
+	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
+		struct device *cxld_dev;
+
+		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
+					     dvsec_range_allowed);
+		if (!cxld_dev) {
+			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
+			continue;
+		}
+		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
+		put_device(cxld_dev);
+		allowed++;
+	}
+
+	if (!allowed) {
+		cxl_set_mem_enable(cxlds, 0);
+		info->mem_enabled = 0;
+	}
+
+	/*
+	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
+	 * [High,Low] when HDM operation is enabled the range register values
+	 * are ignored by the device, but the spec also recommends matching the
+	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
+	 * are expected even though Linux does not require or maintain that
+	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
+	 * Decoder Capability Enable.
+	 */
+	if (info->mem_enabled)
+		return -EBUSY;
+
+	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+	if (rc)
+		return rc;
+
+	rc = devm_cxl_enable_mem(&port->dev, cxlds);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);


