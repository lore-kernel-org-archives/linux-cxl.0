Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FDBC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Mar 2022 08:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiCJIkY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiCJIkX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Mar 2022 03:40:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AF7136EEC
        for <linux-cxl@vger.kernel.org>; Thu, 10 Mar 2022 00:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646901563; x=1678437563;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/XN5HHZPjAAafLKY11mRjopQZF+6kW1PVcBSdZCixgA=;
  b=SCqpP70/x7YZSQWKcu0sJf7EcWQv2ANpjfmweTTaHtgBB4abx2zskSxw
   9kqf70g1xACZc5rE4s44OYbiccGuYC8QcFPUQPFxu1kysz41/1SS/Pb8q
   ya1no8r0+R2Xl0AsFh5tlcCAMNKh8ixx0HZcSZFLTPc7ic9hB5PaHStaN
   ezDHElc1SnorpP6Y+ZUNAwTePgP95M/uG38TLk7/wX9iSqYv2j2w2TtJD
   rZJfNTfOPeIkwY9gjXZBAVQdOxXcji2gqWRkVeIrCgGhbs9mkgUrQvSjt
   77B/Hj30H2+cD86uE1/1nIYEGzaH1EVjDFa3LWCA4vggXzd15cY8+MgVc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252762946"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="252762946"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:39:22 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="513893378"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:39:22 -0800
Subject: [PATCH 2/2] cxl/pci: Preserve mailbox access after DVSEC probe
 failure
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Krzysztof Zach <krzysztof.zach@intel.com>,
        Jonathan.Cameron@huawei.com, ben.widawsky@intel.com
Date:   Thu, 10 Mar 2022 00:39:22 -0800
Message-ID: <164690156234.3326488.1880097554956913603.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164690155138.3326488.16049914482944930295.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164690155138.3326488.16049914482944930295.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cxl_pci driver is tasked with establishing mailbox communications
with a CXL Memory Expander and then building a cxl_memdev to represent
the CXL.mem component of the device. Part of that construction involves
probing the CXL DVSEC to discover the state of CXL.mem resources on the
card and whether legacy "range registers" are enabled instead of the HDM
decoder expectation.

If that CXL DVSEC probe fails there is still value in preserving cxl_pci
operations to access the mailbox, or otherwise attempt to debug / repair
CXL.mem operation.

Add debug to indicate the reason for CXL DVSEC probe failures, and do
not fail cxl_pci probe on those failures. Cleanup
cxl_dvsec_decode_init() to make it clear that any non-zero value of
info->ranges is a reason to not proceed with enabling HDM operation.

Reported-by: Krzysztof Zach <krzysztof.zach@intel.com>
Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   20 +++++++++-----------
 drivers/cxl/pci.c |   40 ++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index cd4e8bba82aa..9363107b438e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -84,7 +84,7 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
 	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
 	struct cxl_register_map map;
 	struct cxl_component_reg_map *cmap = &map.component_map;
-	bool global_enable, do_hdm_init = false;
+	bool global_enable, do_hdm_init = true;
 	void __iomem *crb;
 	u32 global_ctrl;
 
@@ -104,26 +104,24 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
 	global_ctrl = readl(crb + cmap->hdm_decoder.offset +
 			    CXL_HDM_DECODER_CTRL_OFFSET);
 	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
-	if (!global_enable && info->ranges) {
+	if (global_enable)
+		goto out;
+
+	if (info->ranges != 0) {
 		dev_dbg(cxlds->dev,
 			"DVSEC ranges already programmed and HDM decoders not enabled.\n");
+		do_hdm_init = false;
 		goto out;
 	}
 
-	do_hdm_init = true;
-
 	/*
 	 * Permanently (for this boot at least) opt the device into HDM
 	 * operation. Individual HDM decoders still need to be enabled after
 	 * this point.
 	 */
-	if (!global_enable) {
-		dev_dbg(cxlds->dev, "Enabling HDM decode\n");
-		writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
-		       crb + cmap->hdm_decoder.offset +
-			       CXL_HDM_DECODER_CTRL_OFFSET);
-	}
-
+	dev_dbg(cxlds->dev, "Enabling HDM decode\n");
+	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
+	       crb + cmap->hdm_decoder.offset + CXL_HDM_DECODER_CTRL_OFFSET);
 out:
 	iounmap(crb);
 	return do_hdm_init;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8a7267d116b7..2e482969c147 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -463,16 +463,24 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
-static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
+/*
+ * Return positive number of non-zero ranges on success and a negative
+ * error code on failure. The cxl_mem driver depends on ranges == 0 to
+ * init HDM operation.
+ */
+static int __cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
+			    struct cxl_endpoint_dvsec_info *info)
 {
-	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int hdm_count, rc, i, ranges = 0;
+	struct device *dev = &pdev->dev;
 	int d = cxlds->cxl_dvsec;
-	int hdm_count, rc, i;
 	u16 cap, ctrl;
 
-	if (!d)
+	if (!d) {
+		dev_dbg(dev, "No DVSEC Capability\n");
 		return -ENXIO;
+	}
 
 	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
 	if (rc)
@@ -482,8 +490,10 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 	if (rc)
 		return rc;
 
-	if (!(cap & CXL_DVSEC_MEM_CAPABLE))
+	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
+		dev_dbg(dev, "Not MEM Capable\n");
 		return -ENXIO;
+	}
 
 	/*
 	 * It is not allowed by spec for MEM.capable to be set and have 0 legacy
@@ -496,8 +506,10 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 		return -EINVAL;
 
 	rc = wait_for_valid(cxlds);
-	if (rc)
+	if (rc) {
+		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
 		return rc;
+	}
 
 	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
 
@@ -539,10 +551,17 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 		};
 
 		if (size)
-			info->ranges++;
+			ranges++;
 	}
 
-	return 0;
+	return ranges;
+}
+
+static void cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
+{
+	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
+
+	info->ranges = __cxl_dvsec_ranges(cxlds, info);
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -611,10 +630,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_dvsec_ranges(cxlds);
-	if (rc)
-		dev_warn(&pdev->dev,
-			 "Failed to get DVSEC range information (%d)\n", rc);
+	cxl_dvsec_ranges(cxlds);
 
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))

