Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21A5C54EBE
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjARSKL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjARSJe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 13:09:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEEA56EEC
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 10:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674065346; x=1705601346;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xA47metFBsbr16tA8m7AYocNh1EapwJjNHE32CX/aNY=;
  b=R5pUje4mrMNY85PzgjY44mogoJPWVqyitPBgzf01lIK0yr8x5vGnrjNd
   J4LMhdUVIjo/iinCvF1MJjSXKNniamJnhL8JJC47Q0td9p5XZP9JKGGh0
   OzYD0c9wQtO2WEUJU+5Fi2DgELEkUWSkHCi3uL7oNeaOO9bhx+7V8ee/s
   YVUa+13AqG7IaJYvAp27QtSnBa2t418oC1b9e01i20tafYCSJINVzh3+N
   TdwfuaSgL6byED4n32bQuBvvqBxNSwizadjLLrplarICy44nnhPa0UgbC
   /pBhEbAxxUkNxOg4ZUoSHxYqWw7FAK5S4Z1C38cBp0kL+VQxwfYqJ2LVN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="352308087"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="352308087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:09:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="905195451"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="905195451"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.179.103])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:09:05 -0800
Subject: [PATCH v3 5/8] cxl: create emulated cxl_hdm for devices that do not
 have HDM decoders
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Wed, 18 Jan 2023 11:09:04 -0700
Message-ID: <167406534263.1455071.15469331778875048496.stgit@djiang5-mobl3.local>
In-Reply-To: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL rev3 spec 8.1.3

RCDs may not have HDM register blocks. Create a fake HDM with information
from the CXL PCIe DVSEC registers. The decoder count will be set to the
HDM count retrieved from the DVSEC cap register.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Move relevant changes from next patch in series. (Jonathan)
- Add kernel doc update. (Jonathan)
v2:
- Set target_count to same as number of ranges. (Jonathan)
---
 drivers/cxl/core/hdm.c |   58 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/cxl/core/pci.c |    9 +++++--
 drivers/cxl/cxl.h      |    3 ++
 drivers/cxl/port.c     |    2 +-
 4 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index af1f5f906f52..86fe1be2e961 100644
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
@@ -815,19 +841,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
@@ -844,6 +866,22 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
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
index 81882ea94adf..be59f7271f62 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -379,16 +379,19 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
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
index ea9548cbc7eb..0ec047cced90 100644
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
index 7f1b71c5cf15..875bf45db4ad 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -55,7 +55,7 @@ static int cxl_port_probe(struct device *dev)
 			return devm_cxl_add_passthrough_decoder(port);
 	}
 
-	cxlhdm = devm_cxl_setup_hdm(port);
+	cxlhdm = devm_cxl_setup_hdm(port, &info);
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 


