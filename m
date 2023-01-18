Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8EC32793
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 18:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjARSJa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjARSJI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 13:09:08 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD08F56889
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674065320; x=1705601320;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nPJn+ICOpzprj+9FtJqwdPvu3PG472VLjZJrVeJMMmU=;
  b=h+ht+0UdQJB0Mf1SoVuXcb2KKBYEOS1UCxz7JP9nueoJBtB/DGACEkDs
   5g2PBYChLqFBFqRlPdwDBtsZWkxwTqE1daDSgo3b+tD4w3iKaPgaefITr
   Vx7vtTlH1+JxiVkbgSfGSp82Oxc6P/ZrPVAHWxeRZOVNrMqWKzNzHNyeV
   bWQ3lJBzIwqRheWJfQZ1gcv5xaW6iZ0qJ2VGRT/bU8Cxj/MWudXKD/iH+
   KBgbM+p6FQXT8TiGNzzbwXAE4auKByM31fXfLO73gMV89uA/BB3Z6PF4l
   feskXrZnLXhrpU1k7geIuwlug3sa5IkVcrGzj5n2HzoX4BJnnR2nfkM7u
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="387406012"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="387406012"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:08:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767851910"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767851910"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.179.103])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:08:39 -0800
Subject: [PATCH v3 2/8] cxl: export cxl_dvsec_rr_decode() to cxl_port
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Wed, 18 Jan 2023 11:08:37 -0700
Message-ID: <167406531610.1455071.16749242105523531268.stgit@djiang5-mobl3.local>
In-Reply-To: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Call cxl_dvsec_rr_decode() in the beginning of cxl_port_probe() and
preserve the decoded information in a local
'struct cxl_endpoint_dvsec_info'. This info can be passed to various
functions later on in order to support the HDM decoder emulation.
The invocation of cxl_dvsec_rr_decode() in cxl_hdm_decode_init() is
removed and a pointer to the 'struct cxl_endpoint_dvsec_info' is passed
in.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

 ---
v2:
- Update kdoc comments (Jonathan)
- Use a bool for is_cxl_endpoint() to make it easier for static analysis
  (Jonathan)
---
 drivers/cxl/core/pci.c |   18 +++++++-----------
 drivers/cxl/cxl.h      |   14 ++++++++++++++
 drivers/cxl/cxlmem.h   |   12 ------------
 drivers/cxl/cxlpci.h   |    3 ++-
 drivers/cxl/port.c     |   21 ++++++++++++++-------
 5 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a8ecc6ddb3d7..2b68b5d462da 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -333,8 +333,8 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 	return true;
 }
 
-static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
-			       struct cxl_endpoint_dvsec_info *info)
+int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
+			struct cxl_endpoint_dvsec_info *info)
 {
 	int hdm_count, rc, i, ranges = 0;
 	struct device *dev = &pdev->dev;
@@ -434,31 +434,27 @@ static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_decode, CXL);
 
 /**
  * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
  * @cxlds: Device state
  * @cxlhdm: Mapped HDM decoder Capability
+ * @info: Cached DVSEC range registers info
  *
  * Try to enable the endpoint's HDM Decoder Capability
  */
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
+			struct cxl_endpoint_dvsec_info *info)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct cxl_endpoint_dvsec_info info = { 0 };
 	struct device *dev = &pdev->dev;
-	int d = cxlds->cxl_dvsec;
-	int rc;
-
-	rc = cxl_dvsec_rr_decode(pdev, d, &info);
-	if (rc < 0)
-		return rc;
 
 	/*
 	 * If DVSEC ranges are being used instead of HDM decoder registers there
 	 * is no use in trying to manage those.
 	 */
-	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, &info)) {
+	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, info)) {
 		dev_err(dev,
 			"Legacy range registers configuration prevents HDM operation.\n");
 		return -EBUSY;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1b1cf459ac77..1057affb2db0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -630,10 +630,24 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 
+/**
+ * struct cxl_endpoint_dvsec_info - Cached DVSEC info
+ * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
+ * @ranges: Number of active HDM ranges this device uses.
+ * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
+ */
+struct cxl_endpoint_dvsec_info {
+	bool mem_enabled;
+	int ranges;
+	struct range dvsec_range[2];
+};
+
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
+int cxl_dvsec_rr_decode(struct pci_dev *pdev, int dvsec,
+			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..187a310780a9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -181,18 +181,6 @@ static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
  */
 #define CXL_CAPACITY_MULTIPLIER SZ_256M
 
-/**
- * struct cxl_endpoint_dvsec_info - Cached DVSEC info
- * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
- * @ranges: Number of active HDM ranges this device uses.
- * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
- */
-struct cxl_endpoint_dvsec_info {
-	bool mem_enabled;
-	int ranges;
-	struct range dvsec_range[2];
-};
-
 /**
  * struct cxl_dev_state - The driver device state
  *
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 920909791bb9..430e23345a16 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -64,6 +64,7 @@ enum cxl_regloc_type {
 
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
+			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..404639a1c3d0 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -32,12 +32,22 @@ static void schedule_detach(void *cxlmd)
 
 static int cxl_port_probe(struct device *dev)
 {
+	struct cxl_endpoint_dvsec_info info = { 0 };
 	struct cxl_port *port = to_cxl_port(dev);
+	bool is_ep = is_cxl_endpoint(port);
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev *cxlmd;
 	struct cxl_hdm *cxlhdm;
 	int rc;
 
-
-	if (!is_cxl_endpoint(port)) {
+	if (is_ep) {
+		cxlmd = to_cxl_memdev(port->uport);
+		cxlds = cxlmd->cxlds;
+		rc = cxl_dvsec_rr_decode(to_pci_dev(cxlds->dev),
+					 cxlds->cxl_dvsec, &info);
+		if (rc < 0)
+			return rc;
+	} else {
 		rc = devm_cxl_port_enumerate_dports(port);
 		if (rc < 0)
 			return rc;
@@ -49,10 +59,7 @@ static int cxl_port_probe(struct device *dev)
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
-	if (is_cxl_endpoint(port)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
-		struct cxl_dev_state *cxlds = cxlmd->cxlds;
-
+	if (is_ep) {
 		/* Cache the data early to ensure is_visible() works */
 		read_cdat_data(port);
 
@@ -61,7 +68,7 @@ static int cxl_port_probe(struct device *dev)
 		if (rc)
 			return rc;
 
-		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
+		rc = cxl_hdm_decode_init(cxlds, cxlhdm, &info);
 		if (rc)
 			return rc;
 


