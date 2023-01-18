Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C816C32793
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 18:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjARSJp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjARSJU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 13:09:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0D59E6B
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 10:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674065330; x=1705601330;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nwWop7JSlIxVCStYmHXIufxo9Gy9trRwxh3Tfdb93QE=;
  b=nnqEpv12KUvacAtat2zYAVqTLYwW8KqZrtNCfR+oVcW0d1boAmJ9ILoz
   FL7v7H2gWCoNBlwOB05SvgkjV9vfeegfZN50wpZSN3s650YP/luqWDNnL
   PZ53UuqDwaz4TXK9/X0DmNOyARhOTVgqXpFk11Suz7BvIA3qiyKoB1OSZ
   vLyg5uiN+JbbLO/mG+AIxg6LEQYESezPJAlaRBKWiYtt62Zy1IJvfs/p7
   MxkAwpJFEPq91OQi+vw+36e5Mb7vWT8taggyzzhFrk11U+uWlruiQCyH0
   8bReXB9C52BIaeHQTcAzvUyFwTxSPAVsnfmEduiQ6Iu64dm+DYXqmCdLc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="387406051"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="387406051"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:08:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767851997"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767851997"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.179.103])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:08:48 -0800
Subject: [PATCH v3 3/8] cxl: refactor cxl_hdm_decode_init()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Wed, 18 Jan 2023 11:08:45 -0700
Message-ID: <167406532445.1455071.11912469846849312756.stgit@djiang5-mobl3.local>
In-Reply-To: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
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
index 2b68b5d462da..97690c429e05 100644
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
 


