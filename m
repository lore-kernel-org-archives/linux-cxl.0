Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC230C4321E
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 23:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiK3XU3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiK3XT5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 18:19:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2098F102F
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669849979; x=1701385979;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c2O4WXY0pE+wjOrAJMW+0OK7FaEClFvd3QCs0X1nrIc=;
  b=NPa1mQTorBgDSvqFoxW1c395UmIF+E6gHwDGisbVL9xVaamkaAl324Mo
   IkX4L9MlivcrqWhnpbrqV1Q8XvH41NF/P533zDt8m48X1MeIrXl49nXYG
   dWe1uM5Xxx3jqmS04y13BG8BSI/Y0RoCQM6j0U5Cg7GF2ebcxb7UI/J7v
   xnGWdf80Azhd1RCMcrmGHCced6JDq3ahQ9VMEdIrikIo2Gp3zzzT9Pmxf
   DhPqMlfe6+aFk2s3qmdBK7YRLq2QmAQzSHsdkrHi1c6sUXx//5+e1PMtc
   gGI0gKhVJxRjgmqupeFZZDOtnMbwbI9hFhsfftHjkwb+JMNl8lPUHxgMD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="314232874"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="314232874"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="675206172"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="675206172"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:26 -0800
Subject: [RFC PATCH 2/8] cxl: export cxl_dvsec_rr_decode() to cxl_port
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rrichter@amd.com, terry.bowman@amd.com
Date:   Wed, 30 Nov 2022 16:12:26 -0700
Message-ID: <166984994667.2805382.3598594737505566629.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Call cxl_dvsec_rr_decode() in the beginning of cxl_port_probe() and
preserve the decoded information in the 'struct cxl_endpoint_dvsec_info'.
This info can be passed to various functions later on in order to support
the HDM decoder emulation. The invocation of cxl_dvsec_rr_decode() in
cxl_hdm_decode_init() is removed and a pointer to the 'struct
cxl_endpoint_dvsec_info' is passed in.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |   17 ++++++-----------
 drivers/cxl/cxl.h      |   14 ++++++++++++++
 drivers/cxl/cxlmem.h   |   12 ------------
 drivers/cxl/cxlpci.h   |    3 ++-
 drivers/cxl/port.c     |   15 +++++++++++----
 5 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d674ddfe141c..7196b1fcdcfc 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -335,8 +335,8 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 }
 
 
-static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
-			       struct cxl_endpoint_dvsec_info *info)
+int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
+			struct cxl_endpoint_dvsec_info *info)
 {
 	int hdm_count, rc, i, ranges = 0;
 	struct device *dev = &pdev->dev;
@@ -431,6 +431,7 @@ static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
 	info->ranges = ranges;
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_decode, CXL);
 
 /**
  * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
@@ -439,23 +440,17 @@ static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
  *
  * Try to enable the endpoint's HDM Decoder Capability
  */
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
+			struct cxl_endpoint_dvsec_info *info)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct cxl_endpoint_dvsec_info info = { 0 };
-	int rc;
 	struct device *dev = &pdev->dev;
-	int d = cxlds->cxl_dvsec;
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
index d94635e43a50..b6caf1cfb3e9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -591,10 +591,24 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 
+/**
+  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
+  * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
+  * @ranges: Number of active HDM ranges this device uses.
+  * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
+  */
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
index 35d485d041f0..fd8ed573fbf9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -179,18 +179,6 @@ static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
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
index eec597dbe763..02a39a2609b7 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -73,6 +73,7 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
+			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..f899d62a91af 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -32,7 +32,10 @@ static void schedule_detach(void *cxlmd)
 
 static int cxl_port_probe(struct device *dev)
 {
+	struct cxl_endpoint_dvsec_info info = { 0 };
 	struct cxl_port *port = to_cxl_port(dev);
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev *cxlmd;
 	struct cxl_hdm *cxlhdm;
 	int rc;
 
@@ -43,6 +46,13 @@ static int cxl_port_probe(struct device *dev)
 			return rc;
 		if (rc == 1)
 			return devm_cxl_add_passthrough_decoder(port);
+	} else {
+		cxlmd = to_cxl_memdev(port->uport);
+		cxlds = cxlmd->cxlds;
+		rc = cxl_dvsec_rr_decode(to_pci_dev(cxlds->dev),
+					 cxlds->cxl_dvsec, &info);
+		if (rc < 0)
+			return rc;
 	}
 
 	cxlhdm = devm_cxl_setup_hdm(port);
@@ -50,9 +60,6 @@ static int cxl_port_probe(struct device *dev)
 		return PTR_ERR(cxlhdm);
 
 	if (is_cxl_endpoint(port)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
-		struct cxl_dev_state *cxlds = cxlmd->cxlds;
-
 		/* Cache the data early to ensure is_visible() works */
 		read_cdat_data(port);
 
@@ -61,7 +68,7 @@ static int cxl_port_probe(struct device *dev)
 		if (rc)
 			return rc;
 
-		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
+		rc = cxl_hdm_decode_init(cxlds, cxlhdm, &info);
 		if (rc)
 			return rc;
 


