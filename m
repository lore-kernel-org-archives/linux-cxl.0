Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA63DC05027
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 19:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjBNTlQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNTlP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 14:41:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774712BEF2
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 11:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676403674; x=1707939674;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9sLzpyr0L0B8KqEVzmHDsYaQ5+dLrausBYiqCHgd4Ig=;
  b=RaDBm4aVxeQ9EGsn7MLxoaCL2KJNbaUvCufIBhL2iAMBiELwKtd1xCIx
   TiQs89Ix+G7XTOY/jNOihnLI361XfVuy34SuyG9GZ7MaUUaJiYzrTyn8o
   5CPgEEZ71l0fTV+fYfPVUBbRrJeuHCwxBjUt621OKYbTIZXA3VKdzL6JT
   JJpOyiXizgIKGXxBf+z/1HK1MHZYdcrpypJI9oXH4Ltu9kaUmIznyvqaS
   Hp1sAjnEpvOINpJueXKIy3CvqGlLR5/+KtH+iQU0O04Gou63MHd8+VCCA
   th4/nUwSxTQRBq3OJ7UWsf2QJqp/ObRYoOCa4dVyD8CZTK316CbnQdkcV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333384824"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="333384824"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793207839"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="793207839"
Received: from mofarooq-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.68.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:14 -0800
Subject: [PATCH v5 2/7] cxl/port: Export cxl_dvsec_rr_decode() to cxl_port
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Tue, 14 Feb 2023 11:41:13 -0800
Message-ID: <167640367377.935665.2848747799651019676.stgit@dwillia2-xfh.jf.intel.com>
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

Call cxl_dvsec_rr_decode() in the beginning of cxl_port_probe() and
preserve the decoded information in a local
'struct cxl_endpoint_dvsec_info'. This info can be passed to various
functions later on in order to support the HDM decoder emulation.
The invocation of cxl_dvsec_rr_decode() in cxl_hdm_decode_init() is
removed and a pointer to the 'struct cxl_endpoint_dvsec_info' is passed
in.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c        |   18 +++++++-----------
 drivers/cxl/cxl.h             |   14 ++++++++++++++
 drivers/cxl/cxlmem.h          |   12 ------------
 drivers/cxl/cxlpci.h          |    3 ++-
 drivers/cxl/port.c            |   20 +++++++++++++-------
 tools/testing/cxl/Kbuild      |    1 +
 tools/testing/cxl/test/mock.c |   21 +++++++++++++++++++--
 7 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 52bf6b4d093e..948fa3724a0f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -333,8 +333,8 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 	return true;
 }
 
-static int cxl_dvsec_rr_decode(struct device *dev, int d,
-			       struct cxl_endpoint_dvsec_info *info)
+int cxl_dvsec_rr_decode(struct device *dev, int d,
+			struct cxl_endpoint_dvsec_info *info)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	int hdm_count, rc, i, ranges = 0;
@@ -434,30 +434,26 @@ static int cxl_dvsec_rr_decode(struct device *dev, int d,
 
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
-	struct cxl_endpoint_dvsec_info info = { 0 };
 	struct device *dev = cxlds->dev;
-	int d = cxlds->cxl_dvsec;
-	int rc;
-
-	rc = cxl_dvsec_rr_decode(dev, d, &info);
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
index 1b1cf459ac77..fc01ce96d326 100644
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
+int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
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
index 5453771bf330..9e09728b20d9 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -32,12 +32,21 @@ static void schedule_detach(void *cxlmd)
 
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
+		rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
+		if (rc < 0)
+			return rc;
+	} else {
 		rc = devm_cxl_port_enumerate_dports(port);
 		if (rc < 0)
 			return rc;
@@ -49,10 +58,7 @@ static int cxl_port_probe(struct device *dev)
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
-	if (is_cxl_endpoint(port)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
-		struct cxl_dev_state *cxlds = cxlmd->cxlds;
-
+	if (is_ep) {
 		/* Cache the data early to ensure is_visible() works */
 		read_cdat_data(port);
 
@@ -61,7 +67,7 @@ static int cxl_port_probe(struct device *dev)
 		if (rc)
 			return rc;
 
-		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
+		rc = cxl_hdm_decode_init(cxlds, cxlhdm, &info);
 		if (rc)
 			return rc;
 
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 0805f08af8b3..012149ad5c1c 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -10,6 +10,7 @@ ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
+ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=cxl_rcrb_to_component
 
 DRIVERS := ../../../drivers
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 5dface08e0de..2a13f4722891 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -209,7 +209,8 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
 
 int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
-			       struct cxl_hdm *cxlhdm)
+			       struct cxl_hdm *cxlhdm,
+			       struct cxl_endpoint_dvsec_info *info)
 {
 	int rc = 0, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
@@ -217,13 +218,29 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 	if (ops && ops->is_mock_dev(cxlds->dev))
 		rc = 0;
 	else
-		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
+		rc = cxl_hdm_decode_init(cxlds, cxlhdm, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
 
+int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
+			       struct cxl_endpoint_dvsec_info *info)
+{
+	int rc = 0, index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_dev(dev))
+		rc = 0;
+	else
+		rc = cxl_dvsec_rr_decode(dev, dvsec, info);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_rr_decode, CXL);
+
 resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
 					     resource_size_t rcrb,
 					     enum cxl_rcrb which)

