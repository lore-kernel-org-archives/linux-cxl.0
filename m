Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC13C636D6
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 19:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjBHTVV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjBHTVU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 14:21:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA35828F
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 11:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675884076; x=1707420076;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fdJO9PK91eaVvybNKx35iF36fc78DSsqi9jbCkewzfM=;
  b=lBBJRj61OTIEiSCh0ussNPWa//Iaqe0c/N0/HzggpKV8e5Uy/W6TOz5i
   WUuk4R6Gqky6akUQruCsEcRdBya/XwXF+iUb1CXv94lbRX526PJzTje/Y
   mLf5u9Be0hT7rw/6tjq+uGqnz1FW+iPAJuhd8NUcNUxWrsqB5Pr/Bl+Bg
   nvN27nudRnbMC2fvGmGPm9BW0G5k+eqK+YW+8Fpr0bLewfJvM0wVHGIZH
   GuoSFyb9Jp6N9MLmTnmG4Wm3pOlOg1Gr6ZXax161nlcn6ntF2FbBuoGrH
   kMhr2c18GEa6obKtSjG+ZYMq40g8mLcP04uqGzw+qV5tyW2Oj4hcb6M9K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357298466"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357298466"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:21:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="730998477"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="730998477"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.48.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:21:15 -0800
Subject: [PATCH v4 3/7] cxl: refactor cxl_hdm_decode_init()
From:   Dave Jiang <dave.jiang@intel.com>
To:     dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Date:   Wed, 08 Feb 2023 12:21:12 -0700
Message-ID: <167588407080.1155956.5454204009189141313.stgit@djiang5-mobl3.local>
In-Reply-To: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
References: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With the previous refactoring of DVSEC range registers out of
cxl_hdm_decode_init(), it basically becomes a skeleton function. Squash
__cxl_hdm_decode_init() with cxl_hdm_decode_init() to simplify the code.
cxl_hdm_decode_init() now returns more error codes than just -EBUSY.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Simplify to directly return devm_cxl_enable_mem() in
  cxl_hdm_decode_init(). (Jonathan)
v2:
- Update commit log to indicate cxl_hdm_decode_init() return additional
  error codes after change. (Jonathan)
---
 drivers/cxl/core/pci.c |  135 +++++++++++++++++++-----------------------------
 1 file changed, 54 insertions(+), 81 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a76735393b38..2e86c209e24d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -259,80 +259,6 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
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
 int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
 			struct cxl_endpoint_dvsec_info *info)
 {
@@ -449,18 +375,65 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
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
 
-	return 0;
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
+	return devm_cxl_enable_mem(&port->dev, cxlds);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
 


