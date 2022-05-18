Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93017C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiERXfT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiERXfS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:35:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3514D34
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916917; x=1684452917;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/7pkBdciCH2t7Aahs7LX9gAXpWNZjiH/xCdF+6ESFRU=;
  b=OMuvLwD3yl3TF+FpBmqjo2k1Etc7aZAofSQ23opWGD9aA7jV0m3YYUY6
   Lb0ZgCBU+J8oH9eZIDG2lWEHoGd3XWJtzAfHex3H25PNHjp9OLQkW+a2M
   6w9ALNYNY1OWpgXGhpoJvcqnjgfv9SPccU/bOWad5+OzNxwXTZpgJKcMQ
   7IUiSjpXcWgrqqKAYCDo5iTStT3JvJ6D4VgTJ/SpSvvXe8XGCwIBl3BSc
   lvYuCj3H7G++90PjtEzo7b8KtY3VYEAL2a+uWXVnZyYhoXILIyn4lnieN
   EMXaiETx5BV8msLU9Kf2dG+RGUGpD3yFJKOGD2NvVqPHio93FK6/jBkVG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272068481"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="272068481"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:35:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="661417216"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:35:17 -0700
Subject: [PATCH v3 12/13] cxl/port: Reuse 'struct cxl_hdm' context for hdm
 init
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:35:17 -0700
Message-ID: <165291691712.1426646.14336397551571515480.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c        |   39 ++++++++++-----------------------------
 drivers/cxl/cxlpci.h          |    2 +-
 drivers/cxl/port.c            |   25 ++++++++++++++-----------
 tools/testing/cxl/test/mock.c |    5 +++--
 4 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7d2238edc379..3305e9b750af 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -176,29 +176,14 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
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
 
 	/*
@@ -210,9 +195,7 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 	 * match.
 	 */
 	if (!global_enable && info->mem_enabled && info->ranges)
-		goto out;
-
-	retval = true;
+		return false;
 
 	/*
 	 * Permanently (for this boot at least) opt the device into HDM
@@ -222,22 +205,20 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
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
@@ -331,7 +312,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
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

