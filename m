Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A26C4321E
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 23:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiK3XUq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiK3XU1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 18:20:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786C3A0571
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 15:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669849992; x=1701385992;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJnR5quGMjk9DtK9wME+6whYjdrDoTUPqDidMK2nkB8=;
  b=Fc/unhQIBnG98pruba0SA+Lbdj62EyWo7u0806nnfmdkyblnU3aISPjy
   F5iYahVHiTV2n3GH9FKaagF7mMlbHwlKKNoSwLWaly2f0Q/syHJ26uF6m
   QM1erBng1+nGKSPCahfx9j+GJYvfwyei75uTocEOonJTVLc9fJDLfBIYJ
   /5Urvw4FfdHZI9Itdcqmyolzmv/CfUaHAIOfVycaAQXjHwfSfHhZso4Qk
   ZBfbCHIENRU8Un5VWoIfXJ/xZDYXso9H6YaIeVCHVAe4ugWPdVK6SEEpa
   VLCwzq7IR8+irlZF3vDsiJoUFKwHBmteE51lvmmwUVR8zeipQ5Ep7G+ML
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379812030"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379812030"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733171063"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="733171063"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:44 -0800
Subject: [RFC PATCH 5/8] cxl: create emulated cxl_hdm for devices that do not
 have HDM decoders
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rrichter@amd.com, terry.bowman@amd.com
Date:   Wed, 30 Nov 2022 16:12:43 -0700
Message-ID: <166984996390.2805382.1358232383903012041.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c |   27 ++++++++++++++++++++++++++-
 drivers/cxl/core/pci.c |    9 ++++++---
 drivers/cxl/cxl.h      |    3 ++-
 drivers/cxl/cxlmem.h   |    1 +
 drivers/cxl/port.c     |    2 +-
 5 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 9773a5efaefd..3a9e9b854587 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -96,11 +96,31 @@ static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
 	return crb + map.hdm_decoder.offset;
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
+	dev_set_drvdata(&port->dev, cxlhdm);
+	return cxlhdm;
+}
+
 /**
  * devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
  */
-struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
+				   struct cxl_endpoint_dvsec_info *info)
 {
 	struct device *dev = &port->dev;
 	void __iomem *crb, *hdm;
@@ -111,9 +131,14 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
+	if (port->parent_dport->rch)
+		cxlhdm->rcd = true;
 	crb = devm_cxl_iomap_block(dev, port->component_reg_phys,
 				   CXL_COMPONENT_REG_BLOCK_SIZE);
 	if (!crb) {
+		if (info->mem_enabled)
+			return devm_cxl_setup_emulated_hdm(port, info);
+
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
 	}
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5e44fe23fa76..009c11b43303 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -374,16 +374,19 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
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
index 3fe1043a7796..b2eea921bd5f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -604,7 +604,8 @@ struct cxl_endpoint_dvsec_info {
 };
 
 struct cxl_hdm;
-struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
+				   struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index fd8ed573fbf9..6d477590559c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -402,6 +402,7 @@ struct cxl_hdm {
 	unsigned int target_count;
 	unsigned int interleave_mask;
 	struct cxl_port *port;
+	bool rcd;
 };
 
 struct seq_file;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 3dedf3dd534a..910ebfc19a45 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -55,7 +55,7 @@ static int cxl_port_probe(struct device *dev)
 			return rc;
 	}
 
-	cxlhdm = devm_cxl_setup_hdm(port);
+	cxlhdm = devm_cxl_setup_hdm(port, &info);
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 


