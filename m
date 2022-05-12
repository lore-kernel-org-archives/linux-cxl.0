Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C970C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbiELSPP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357516AbiELSPO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:15:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1490D27018D
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379312; x=1683915312;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zyNebfl4q03bMAcJollomNPxMYs3yGlrStmWlRId2TM=;
  b=IOW/EeLUCMlCDMSbuQ5Mz7w2GKbBDvTX01kWxJ8amEKDjhY11rY7h6m1
   G/oPkBwgG8NXupinmE5DIO/o9nzM7lyv0sLpjs/D0E9tL6KaJqKzwxEz7
   8rGK5xciqvFC9rFxsivX6NjE0MQjU9X+ohu2/W+9DVYLy00/JaJEKmP2N
   1E9t5daNqNp112ePAa/LTLKlVXY4TK4ESAr3tbDaSKUIwlJX1TsBsf67G
   Ggw53tn8jmkRMT3RHhTv1eJEH41jRWMmfMkbeAtJrkxIKy3dohoB3Ypfg
   srt/Sn0x6A8YVvncwhY09vZuyvbzsxjxct+IMgsy9tZGE8BHhBD7fzCk+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="356528297"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="356528297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="521076790"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:10 -0700
Subject: [PATCH 10/14] cxl/mem: Merge cxl_dvsec_ranges() and
 cxl_hdm_decode_init()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:15:10 -0700
Message-ID: <165237931038.3832067.12279320857149894554.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for changing how the driver handles 'mem_enable' in the CXL
DVSEC control register. Merge the contents of cxl_hdm_decode_init() into
cxl_dvsec_ranges() and rename the combined function cxl_hdm_decode_init().
The possible cleanups and fixes that result from this merge are saved for a
follow-on change.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c        |   74 +++++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxlpci.h          |    4 +-
 drivers/cxl/mem.c             |   72 +---------------------------------------
 tools/testing/cxl/Kbuild      |    3 +-
 tools/testing/cxl/mock_mem.c  |   10 ------
 tools/testing/cxl/test/mock.c |    8 ++--
 6 files changed, 75 insertions(+), 96 deletions(-)
 delete mode 100644 tools/testing/cxl/mock_mem.c

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f1c0677a4f52..6146764ac68e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -175,13 +175,63 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
 	return -ETIMEDOUT;
 }
 
-/*
- * Return positive number of non-zero ranges on success and a negative
- * error code on failure. The cxl_mem driver depends on ranges == 0 to
- * init HDM operation.
+static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
+				  struct cxl_endpoint_dvsec_info *info)
+{
+	struct cxl_register_map map;
+	struct cxl_component_reg_map *cmap = &map.component_map;
+	bool global_enable, retval = false;
+	void __iomem *crb;
+	u32 global_ctrl;
+
+	/* map hdm decoder */
+	crb = ioremap(cxlds->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (!crb) {
+		dev_dbg(cxlds->dev, "Failed to map component registers\n");
+		return false;
+	}
+
+	cxl_probe_component_regs(cxlds->dev, crb, cmap);
+	if (!cmap->hdm_decoder.valid) {
+		dev_dbg(cxlds->dev, "Invalid HDM decoder registers\n");
+		goto out;
+	}
+
+	global_ctrl = readl(crb + cmap->hdm_decoder.offset +
+			    CXL_HDM_DECODER_CTRL_OFFSET);
+	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
+
+	if (!global_enable && info->mem_enabled)
+		goto out;
+
+	retval = true;
+
+	/*
+	 * Permanently (for this boot at least) opt the device into HDM
+	 * operation. Individual HDM decoders still need to be enabled after
+	 * this point.
+	 */
+	if (!global_enable) {
+		dev_dbg(cxlds->dev, "Enabling HDM decode\n");
+		writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
+		       crb + cmap->hdm_decoder.offset +
+			       CXL_HDM_DECODER_CTRL_OFFSET);
+	}
+
+out:
+	iounmap(crb);
+	return retval;
+}
+
+/**
+ * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
+ * @cxlds: Device state
+ * @info: DVSEC Range cached enumeration
+ *
+ * Try to enable the endpoint's HDM Decoder Capability
  */
-int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
-		     struct cxl_endpoint_dvsec_info *info)
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
+			struct cxl_endpoint_dvsec_info *info)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int hdm_count, rc, i, ranges = 0;
@@ -274,6 +324,16 @@ int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
 
 	info->ranges = ranges;
 
+	/*
+	 * If DVSEC ranges are being used instead of HDM decoder registers there
+	 * is no use in trying to manage those.
+	 */
+	if (!__cxl_hdm_decode_init(cxlds, info)) {
+		dev_err(dev,
+			"Legacy range registers configuration prevents HDM operation.\n");
+		return -EBUSY;
+	}
+
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_dvsec_ranges, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index ad1b62843195..202fdaa8d293 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,6 +74,6 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 struct cxl_endpoint_dvsec_info;
-int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
-		     struct cxl_endpoint_dvsec_info *info);
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
+			struct cxl_endpoint_dvsec_info *info);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index af4a88d3c5fa..2a5dc92d566f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -46,66 +46,6 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
 	return cxl_endpoint_autoremove(cxlmd, endpoint);
 }
 
-/**
- * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
- * @cxlds: Device state
- *
- * Additionally, enables global HDM decoding. Warning: don't call this outside
- * of probe. Once probe is complete, the port driver owns all access to the HDM
- * decoder registers.
- *
- * Returns: false if DVSEC Ranges are being used instead of HDM
- * decoders, or if it can not be determined if DVSEC Ranges are in use.
- * Otherwise, returns true.
- */
-__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
-				struct cxl_endpoint_dvsec_info *info)
-{
-	struct cxl_register_map map;
-	struct cxl_component_reg_map *cmap = &map.component_map;
-	bool global_enable, retval = false;
-	void __iomem *crb;
-	u32 global_ctrl;
-
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
-	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
-
-	if (!global_enable && info->mem_enabled)
-		goto out;
-
-	retval = true;
-
-	/*
-	 * Permanently (for this boot at least) opt the device into HDM
-	 * operation. Individual HDM decoders still need to be enabled after
-	 * this point.
-	 */
-	if (!global_enable) {
-		dev_dbg(cxlds->dev, "Enabling HDM decode\n");
-		writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
-		       crb + cmap->hdm_decoder.offset +
-			       CXL_HDM_DECODER_CTRL_OFFSET);
-	}
-
-out:
-	iounmap(crb);
-	return retval;
-}
-
 static void enable_suspend(void *data)
 {
 	cxl_mem_active_dec();
@@ -155,7 +95,7 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = cxl_dvsec_ranges(cxlds, &info);
+	rc = cxl_hdm_decode_init(cxlds, &info);
 	if (rc)
 		return rc;
 
@@ -165,16 +105,6 @@ static int cxl_mem_probe(struct device *dev)
 		return rc;
 	}
 
-	/*
-	 * If DVSEC ranges are being used instead of HDM decoder registers there
-	 * is no use in trying to manage those.
-	 */
-	if (!cxl_hdm_decode_init(cxlds, &info)) {
-		dev_err(dev,
-			"Legacy range registers configuration prevents HDM operation.\n");
-		return -EBUSY;
-	}
-
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2ea6fcb8baa5..33543231d453 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -9,7 +9,7 @@ ldflags-y += --wrap=devm_cxl_setup_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
-ldflags-y += --wrap=cxl_dvsec_ranges
+ldflags-y += --wrap=cxl_hdm_decode_init
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
@@ -36,7 +36,6 @@ cxl_port-y += config_check.o
 obj-m += cxl_mem.o
 
 cxl_mem-y := $(CXL_SRC)/mem.o
-cxl_mem-y += mock_mem.o
 cxl_mem-y += config_check.o
 
 obj-m += cxl_core.o
diff --git a/tools/testing/cxl/mock_mem.c b/tools/testing/cxl/mock_mem.c
deleted file mode 100644
index 69946f678cfa..000000000000
--- a/tools/testing/cxl/mock_mem.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
-
-#include <linux/types.h>
-
-struct cxl_dev_state;
-bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
-{
-	return true;
-}
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index d6aa644822db..ddf0e7dd9249 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -208,8 +208,8 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
 
-int __wrap_cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
-			    struct cxl_endpoint_dvsec_info *info)
+int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
+				struct cxl_endpoint_dvsec_info *info)
 {
 	int rc = 0, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
@@ -217,12 +217,12 @@ int __wrap_cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
 	if (ops && ops->is_mock_dev(cxlds->dev))
 		info->mem_enabled = 1;
 	else
-		rc = cxl_dvsec_ranges(cxlds, info);
+		rc = cxl_hdm_decode_init(cxlds, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_ranges, CXL);
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
 
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);

