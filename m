Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D91FC678D6
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Jan 2023 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjAIVoM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbjAIVn3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 9 Jan 2023 16:43:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55C4D116
        for <linux-cxl@vger.kernel.org>; Mon,  9 Jan 2023 13:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673300608; x=1704836608;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u9aepsaXyirNhcbFiN9vznmR3hEwKZCc4Z+/uMAW3XI=;
  b=YL1u4nfYGaRYxOiqnY0dbf3EjErZnkWJIG1QvZ1mi0LXPCo4XJiLjjR/
   HdPBt5uAPJiJKiW8w5BemkJrQoi42ppu+RweHZkm0DDaOfP5KCGD8ClHz
   2uwhZI4VTR5wP6/gBvs3ViAs2zP2p2etgBnsyo5BXq6EkRNL6Ylbs28YT
   GLOHS8lDG6baJTWEYUA90UjKmhJIquIN+4/6lCrKukX8wVmH61fmKt3NU
   QId/F4jEml2gayaM0zSdc0i2RMF7TPqIdy2z+i+bwfuqWKNftpohLRz8w
   G0G7XJI1LWXUuSiK1ZojUzycRkMqC1YRVFT0ujj0MoHwUBDcD14/mWCft
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="320687549"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="320687549"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:43:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="985540657"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="985540657"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.37.174])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:43:28 -0800
Subject: [PATCH v2 3/8] cxl: refactor cxl_hdm_decode_init()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Mon, 09 Jan 2023 14:43:26 -0700
Message-ID: <167330060509.975161.6672958439144493413.stgit@djiang5-mobl3.local>
In-Reply-To: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Update commit log to indicate cxl_hdm_decode_init() return additional
  error codes after change. (Jonathan)
---
 drivers/cxl/core/pci.c |  137 ++++++++++++++++++++----------------------------
 1 file changed, 57 insertions(+), 80 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2b68b5d462da..fac6094bb6d4 100644
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
@@ -449,17 +375,68 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
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
+	}
+
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
 	}
 
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


