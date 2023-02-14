Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D339BC05027
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 19:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjBNTld (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNTlc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 14:41:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206242D143
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676403691; x=1707939691;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LP6LVpUwVSh+ii7pzF+ZrvgaeTsgKnH0qle7Kudfe70=;
  b=gPeitwBjVmywIL9asUgF0KhiYhnuXnZs5hqB9Qpl+gHzkdYoTWgPZQwI
   0Ve3J1e/lgzDnRMkJz3BEtzqcs5S5XYt+Z7ZQ096n5pb6EbFtb5aeGNxM
   7FnGAH4eNqBaF7EZS4raOWty4kONaTrpyRrA2KIkkzLl5bBcAuFsnaaCl
   kkU+GH5w7LOtyCZACOcgXSwTm5+CN5qqn0PrXzXu3h7cQ2couwWJ7FK5b
   KaoNI7pG0Ljda/6Usyunyt05fqtIRJqa+dXWbw3fuGYniszOWQM8EcXoO
   X7Y+qMI2GPYigWtZXxBjKh7qd3OmrEq9DmJ1L/6CrANcWJ9zgvM/IRTJT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333384910"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="333384910"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793207968"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="793207968"
Received: from mofarooq-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.68.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:30 -0800
Subject: [PATCH v5 5/7] cxl/hdm: Create emulated cxl_hdm for devices that do
 not have HDM decoders
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Tue, 14 Feb 2023 11:41:30 -0800
Message-ID: <167640368994.935665.15831225724059704620.stgit@dwillia2-xfh.jf.intel.com>
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

CXL rev3 spec 8.1.3

RCDs may not have HDM register blocks. Create a fake HDM with information
from the CXL PCIe DVSEC registers. The decoder count will be set to the
HDM count retrieved from the DVSEC cap register.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c        |   58 ++++++++++++++++++++++++++++++++++-------
 drivers/cxl/core/pci.c        |    9 ++++--
 drivers/cxl/cxl.h             |    3 +-
 drivers/cxl/port.c            |    2 +
 tools/testing/cxl/test/cxl.c  |    3 +-
 tools/testing/cxl/test/mock.c |    8 ++++--
 tools/testing/cxl/test/mock.h |    3 +-
 7 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c0f224454447..a49543f22dca 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -101,11 +101,34 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 				      BIT(CXL_CM_CAP_CAP_ID_HDM));
 }
 
+static struct cxl_hdm *devm_cxl_setup_emulated_hdm(struct cxl_port *port,
+						   struct cxl_endpoint_dvsec_info *info)
+{
+	struct device *dev = &port->dev;
+	struct cxl_hdm *cxlhdm;
+
+	if (!info->mem_enabled)
+		return ERR_PTR(-ENODEV);
+
+	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
+	if (!cxlhdm)
+		return ERR_PTR(-ENOMEM);
+
+	cxlhdm->port = port;
+	cxlhdm->decoder_count = info->ranges;
+	cxlhdm->target_count = info->ranges;
+	dev_set_drvdata(&port->dev, cxlhdm);
+
+	return cxlhdm;
+}
+
 /**
  * devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
+ * @info: cached DVSEC range register info
  */
-struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
+				   struct cxl_endpoint_dvsec_info *info)
 {
 	struct device *dev = &port->dev;
 	struct cxl_hdm *cxlhdm;
@@ -119,6 +142,9 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
 	cxlhdm->port = port;
 	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
 	if (!crb) {
+		if (info->mem_enabled)
+			return devm_cxl_setup_emulated_hdm(port, info);
+
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
 	}
@@ -814,19 +840,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	return 0;
 }
 
-/**
- * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
- * @cxlhdm: Structure to populate with HDM capabilities
- */
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
-				struct cxl_endpoint_dvsec_info *info)
+static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	struct cxl_port *port = cxlhdm->port;
-	int i, committed;
-	u64 dpa_base = 0;
+	int committed, i;
 	u32 ctrl;
 
+	if (!hdm)
+		return;
+
 	/*
 	 * Since the register resource was recently claimed via request_region()
 	 * be careful about trusting the "not-committed" status until the commit
@@ -843,6 +865,22 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	/* ensure that future checks of committed can be trusted */
 	if (committed != cxlhdm->decoder_count)
 		msleep(20);
+}
+
+/**
+ * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
+ * @cxlhdm: Structure to populate with HDM capabilities
+ * @info: cached DVSEC range register info
+ */
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_port *port = cxlhdm->port;
+	int i;
+	u64 dpa_base = 0;
+
+	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
 		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4df0b35c9b1a..4eb34dee7c95 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -378,16 +378,19 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	struct device *dev = cxlds->dev;
 	struct cxl_port *root;
 	int i, rc, allowed;
-	u32 global_ctrl;
+	u32 global_ctrl = 0;
 
-	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	if (hdm)
+		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 
 	/*
 	 * If the HDM Decoder Capability is already enabled then assume
 	 * that some other agent like platform firmware set it up.
 	 */
-	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
+	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
+	else if (!hdm)
+		return -ENODEV;
 
 	root = to_cxl_port(port->dev.parent);
 	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fe9d75989c8a..f8cbc5275451 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -643,7 +643,8 @@ struct cxl_endpoint_dvsec_info {
 };
 
 struct cxl_hdm;
-struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
+				   struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d3a708e32565..9f9cc268b597 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -54,7 +54,7 @@ static int cxl_port_probe(struct device *dev)
 			return devm_cxl_add_passthrough_decoder(port);
 	}
 
-	cxlhdm = devm_cxl_setup_hdm(port);
+	cxlhdm = devm_cxl_setup_hdm(port, &info);
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3b4916adf29c..94197abd44aa 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -618,7 +618,8 @@ static struct acpi_pci_root *mock_acpi_pci_find_root(acpi_handle handle)
 	return &mock_pci_root[host_bridge_index(adev)];
 }
 
-static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
+static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
+					  struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm = devm_kzalloc(&port->dev, sizeof(*cxlhdm), GFP_KERNEL);
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 3116c9f07c5d..c4e53f22e421 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -131,16 +131,18 @@ __wrap_nvdimm_bus_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
 
-struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port)
+struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
+					  struct cxl_endpoint_dvsec_info *info)
+
 {
 	int index;
 	struct cxl_hdm *cxlhdm;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(port->uport))
-		cxlhdm = ops->devm_cxl_setup_hdm(port);
+		cxlhdm = ops->devm_cxl_setup_hdm(port, info);
 	else
-		cxlhdm = devm_cxl_setup_hdm(port);
+		cxlhdm = devm_cxl_setup_hdm(port, info);
 	put_cxl_mock_ops(index);
 
 	return cxlhdm;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index e377ced5f1b3..bef8817b01f2 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -23,7 +23,8 @@ struct cxl_mock_ops {
 	bool (*is_mock_port)(struct device *dev);
 	bool (*is_mock_dev)(struct device *dev);
 	int (*devm_cxl_port_enumerate_dports)(struct cxl_port *port);
-	struct cxl_hdm *(*devm_cxl_setup_hdm)(struct cxl_port *port);
+	struct cxl_hdm *(*devm_cxl_setup_hdm)(
+		struct cxl_port *port, struct cxl_endpoint_dvsec_info *info);
 	int (*devm_cxl_add_passthrough_decoder)(struct cxl_port *port);
 	int (*devm_cxl_enumerate_decoders)(
 		struct cxl_hdm *hdm, struct cxl_endpoint_dvsec_info *info);

