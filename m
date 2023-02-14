Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACD1C05027
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 19:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBNTlV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNTlV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 14:41:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991B2D151
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 11:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676403680; x=1707939680;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tmgiVEpLaWqe1BQl25W5cg9h7OAZnF6E93adQUu5Rvw=;
  b=SyXcpFjx8AAtTXKjFl9LfIyoRXlAYrtThElpWTGKFLmnS5ZKHgE6fGOJ
   Bf4PXcua2bcCe4lT8skTcI2mgGjEzJ7dC205fjsrveII9UBHCvYVd0wDm
   ya778LF3lPS0hrG5pJcpWNjgxBH3qc6fl2Oi7nPDXgrndaMG8jBwSWgwE
   Gxr3yrYL9JLTMfh/a5diHCsOEy/vHckMMVFSYceWm6PWAsblaxTndMw3N
   nz9ZbOpBBRIdZuVyT8lX+uwuPd5l5HiS8Ly16eWth2Uu9RNQzwuThAWdU
   Sxj6m54imptUv1v0KPGaxDuser382u0pqxJAwarKl3lFLa4lkiw0vx+i4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333384855"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="333384855"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793207876"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="793207876"
Received: from mofarooq-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.68.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:19 -0800
Subject: [PATCH v5 3/7] cxl/pci: Refactor cxl_hdm_decode_init()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Tue, 14 Feb 2023 11:41:19 -0800
Message-ID: <167640367916.935665.12898404758336059003.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
References: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

With the previous refactoring of DVSEC range registers out of
cxl_hdm_decode_init(), it basically becomes a skeleton function. Squash
__cxl_hdm_decode_init() with cxl_hdm_decode_init() to simplify the code.
cxl_hdm_decode_init() now returns more error codes than just -EBUSY.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c |  135 +++++++++++++++++++-----------------------------
 1 file changed, 54 insertions(+), 81 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 948fa3724a0f..d0b25481bdce 100644
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
 int cxl_dvsec_rr_decode(struct device *dev, int d,
 			struct cxl_endpoint_dvsec_info *info)
 {
@@ -447,19 +373,66 @@ EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_decode, CXL);
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info)
 {
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_port *port = cxlhdm->port;
 	struct device *dev = cxlds->dev;
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
 

