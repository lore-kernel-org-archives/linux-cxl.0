Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42EDC54EBD
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Jan 2023 21:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjAIVoP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbjAIVnv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 9 Jan 2023 16:43:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61F25B
        for <linux-cxl@vger.kernel.org>; Mon,  9 Jan 2023 13:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673300630; x=1704836630;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H7U4E/EiJmIW+DPLfAwq1viDQORc3aeOytCU3iyZYOc=;
  b=XwgpqeEEC4WzoALhTrDbMe5DtNecR409QBzXob1bESJCU9LJsWj77nDS
   sJapNvDUj3OOdaP5u6DnLwd09COvhJyv9SeI3mFuRD8xHRAn1C2gbJ2o1
   qO6s5I/+OkWHllACFD2aAmLsA54+bfzZckFxYMHf0xGqedQ/qikXGyzML
   7uMeBangpy6qRNMdZL1tCrxzklCOAgzgXUjDev5dGXSnSYruhzwVimJwK
   s5GIaeLTXpjdLbkFLvm+dnHgkILx29VFdvcpeT6D1bVpBuNb8h9jDzbjb
   uLbzm9lcpWamUoXuHNX87v3gn8njZW3vJrLLADxfVI1w0oB46RbT7kvwM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="320687623"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="320687623"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:43:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="985540754"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="985540754"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.37.174])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:43:47 -0800
Subject: [PATCH v2 5/8] cxl: create emulated cxl_hdm for devices that do not
 have HDM decoders
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Mon, 09 Jan 2023 14:43:43 -0700
Message-ID: <167330062229.975161.18102703412584824456.stgit@djiang5-mobl3.local>
In-Reply-To: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Set target_count to same as number of ranges. (Jonathan)
---
 drivers/cxl/core/hdm.c |   27 ++++++++++++++++++++++++++-
 drivers/cxl/core/pci.c |    9 ++++++---
 drivers/cxl/cxl.h      |    3 ++-
 drivers/cxl/port.c     |    2 +-
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index af1f5f906f52..165c0f382ce1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -101,11 +101,33 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
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
  */
-struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
+				   struct cxl_endpoint_dvsec_info *info)
 {
 	struct device *dev = &port->dev;
 	struct cxl_hdm *cxlhdm;
@@ -119,6 +141,9 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
 	cxlhdm->port = port;
 	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
 	if (!crb) {
+		if (info->mem_enabled)
+			return devm_cxl_setup_emulated_hdm(port, info);
+
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
 	}
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d5eb3aa1df85..c6d6d7b720c5 100644
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
 


