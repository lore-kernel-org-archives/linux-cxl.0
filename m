Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D76C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357502AbiELSPa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357509AbiELSP3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:15:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E565270183
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379327; x=1683915327;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9kGsO5pAQQZWycUsX7Tczvdvlf1ak2YZaE6R2omvcjE=;
  b=R1IEBdiKMZitvu5qqR44E+Q9G5Au4NBm0EM1XrpPRBtDbVF/75oEbmgA
   C6dfw3XgCIQs45/z/GBXr3HTtYXOWw5RGTXiNCBqfyNpeA17BUkKx3B1k
   cVgn/T8O4rvJISkIjsDogEsYgl0P612ntPEOKKLwwN3ewN9iMNtzLYTd6
   fKKXlQGeoORnER90WAbpYC8G/xycPpD8KkQmGe6UvqHIg3xEzclHVwqad
   ibNUB9HI5BIkF30REKlzskRHScRu7XsxI9F9iJTIXT2ZZ9mgUKV97jji3
   3a/DM/IAfeFP/u3K91AXqosB0Z+GBO5m14mVX2O7R1kqVW9yE88sdeRHY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270230998"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="270230998"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="698157691"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:26 -0700
Subject: [PATCH 13/14] cxl/port: Reuse 'struct cxl_hdm' context for hdm init
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:15:26 -0700
Message-ID: <165237932607.3832067.16032830550616928509.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The port driver maps component registers for port operations. Reuse that
mapping for HDM Decoder Capability setup / enable. Move
devm_cxl_setup_hdm() before cxl_hdm_decode_init() and plumb @cxlhdm
through the hdm init helpers.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c        |   39 ++++++++++-----------------------------
 drivers/cxl/cxlpci.h          |    2 +-
 drivers/cxl/port.c            |   25 ++++++++++++++-----------
 tools/testing/cxl/test/mock.c |    5 +++--
 4 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8f14d846713c..a697c48fc830 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -176,35 +176,18 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
 }
 
 static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
+				  struct cxl_hdm *cxlhdm,
 				  struct cxl_endpoint_dvsec_info *info)
 {
-	struct cxl_register_map map;
-	struct cxl_component_reg_map *cmap = &map.component_map;
-	bool global_enable, retval = false;
-	void __iomem *crb;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	bool global_enable;
 	u32 global_ctrl;
 
-	/* map hdm decoder */
-	crb = ioremap(cxlds->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
-	if (!crb) {
-		dev_dbg(cxlds->dev, "Failed to map component registers\n");
-		return false;
-	}
-
-	cxl_probe_component_regs(cxlds->dev, crb, cmap);
-	if (!cmap->hdm_decoder.valid) {
-		dev_dbg(cxlds->dev, "Invalid HDM decoder registers\n");
-		goto out;
-	}
-
-	global_ctrl = readl(crb + cmap->hdm_decoder.offset +
-			    CXL_HDM_DECODER_CTRL_OFFSET);
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
 
 	if (!global_enable && info->mem_enabled)
-		goto out;
-
-	retval = true;
+		return false;
 
 	/*
 	 * Permanently (for this boot at least) opt the device into HDM
@@ -214,22 +197,20 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 	if (!global_enable) {
 		dev_dbg(cxlds->dev, "Enabling HDM decode\n");
 		writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
-		       crb + cmap->hdm_decoder.offset +
-			       CXL_HDM_DECODER_CTRL_OFFSET);
+		       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 	}
 
-out:
-	iounmap(crb);
-	return retval;
+	return true;
 }
 
 /**
  * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
  * @cxlds: Device state
+ * @cxlhdm: Mapped HDM decoder Capability
  *
  * Try to enable the endpoint's HDM Decoder Capability
  */
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct cxl_endpoint_dvsec_info info = { 0 };
@@ -327,7 +308,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
 	 * If DVSEC ranges are being used instead of HDM decoder registers there
 	 * is no use in trying to manage those.
 	 */
-	if (!__cxl_hdm_decode_init(cxlds, &info)) {
+	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, &info)) {
 		dev_err(dev,
 			"Legacy range registers configuration prevents HDM operation.\n");
 		return -EBUSY;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 53cd34f8813c..fce1c11729c2 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -73,5 +73,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds);
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a7deaeaf0276..3cf308f114c4 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -36,6 +36,19 @@ static int cxl_port_probe(struct device *dev)
 	struct cxl_hdm *cxlhdm;
 	int rc;
 
+
+	if (!is_cxl_endpoint(port)) {
+		rc = devm_cxl_port_enumerate_dports(port);
+		if (rc < 0)
+			return rc;
+		if (rc == 1)
+			return devm_cxl_add_passthrough_decoder(port);
+	}
+
+	cxlhdm = devm_cxl_setup_hdm(port);
+	if (IS_ERR(cxlhdm))
+		return PTR_ERR(cxlhdm);
+
 	if (is_cxl_endpoint(port)) {
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
 		struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -45,7 +58,7 @@ static int cxl_port_probe(struct device *dev)
 		if (rc)
 			return rc;
 
-		rc = cxl_hdm_decode_init(cxlds);
+		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
 		if (rc)
 			return rc;
 
@@ -54,18 +67,8 @@ static int cxl_port_probe(struct device *dev)
 			dev_err(dev, "Media not active (%d)\n", rc);
 			return rc;
 		}
-	} else {
-		rc = devm_cxl_port_enumerate_dports(port);
-		if (rc < 0)
-			return rc;
-		if (rc == 1)
-			return devm_cxl_add_passthrough_decoder(port);
 	}
 
-	cxlhdm = devm_cxl_setup_hdm(port);
-	if (IS_ERR(cxlhdm))
-		return PTR_ERR(cxlhdm);
-
 	rc = devm_cxl_enumerate_decoders(cxlhdm);
 	if (rc) {
 		dev_err(dev, "Couldn't enumerate decoders (%d)\n", rc);
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 45ffbb8f519a..f1f8c40948c5 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -208,13 +208,14 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
 
-bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
+bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
+				struct cxl_hdm *cxlhdm)
 {
 	int rc = 0, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (!ops || !ops->is_mock_dev(cxlds->dev))
-		rc = cxl_hdm_decode_init(cxlds);
+		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
 	put_cxl_mock_ops(index);
 
 	return rc;

