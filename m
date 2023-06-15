Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95507EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbjFOBaT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjFOBaS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:30:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D470F212D
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792617; x=1718328617;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TFE5nlyo/HywvxL0+IZVzMkBYbeIEllEggxFm9OAIas=;
  b=A1f48jvQhgQ6jUCBbOmNnMrIzPOMBQxt+DzYCr7QQh5fLmPfm1Ssry9Q
   klI93UXrYZqtTQ7BKlKCG1wiPA39EI/p7g/RAoktUvLgd52P9hmmCg2iY
   ow3s9xSUZJ/1BWTZ6xf2OSJ9rzx++gboAjRxG5M6S9Rsb3qkIycKzgqgp
   mq4H//CDwu8OvvIvs2C877RHFToqXgDS9lTW5YqTdiCdWLEedkI2wlhRl
   kzMrFYiAHdAdwA5CUE3SjLZzpGAoU+F6vPlbwQG87EunIt9zlWu51H742
   o3zEMPqwzqh5bUZqPGkf4BHWQdLynadtH7q0SOpp05QDStXdTU+KfPyKQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338412377"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338412377"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782307246"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782307246"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:14 -0700
Subject: [PATCH v2 07/12] cxl/port: Rename CXL_DECODER_{EXPANDER,
 ACCELERATOR} => {HOSTONLYMEM, DEVMEM}
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 14 Jun 2023 18:30:13 -0700
Message-ID: <168679261369.3436160.7042443847605280593.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for support for HDM-D and HDM-DB configuration
(device-memory, and device-memory with back-invalidate). Rename the current
type designators to use HOSTONLYMEM and DEVMEM as a suffix.

HDM-DB can be supported by devices that are not accelerators, so DEVMEM is
a more generic term for that case.

Fixup one location where this type value was open coded.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c           |    2 +-
 drivers/cxl/core/hdm.c       |   11 ++++++-----
 drivers/cxl/core/port.c      |    6 +++---
 drivers/cxl/core/region.c    |    2 +-
 drivers/cxl/cxl.h            |    4 ++--
 tools/testing/cxl/test/cxl.c |    6 +++---
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7e1765b09e04..603e5df8aec0 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -258,7 +258,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
 		.start = res->start,
 		.end = res->end,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7889ff203a34..79170de13d89 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -570,7 +570,8 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 
 static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 {
-	u32p_replace_bits(ctrl, !!(cxld->target_type == 3),
+	u32p_replace_bits(ctrl,
+			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_TYPE);
 }
 
@@ -764,7 +765,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	if (!len)
 		return -ENOENT;
 
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->commit = NULL;
 	cxld->reset = NULL;
 	cxld->hpa_range = info->dvsec_range[which];
@@ -838,9 +839,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
-			cxld->target_type = CXL_DECODER_EXPANDER;
+			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
-			cxld->target_type = CXL_DECODER_ACCELERATOR;
+			cxld->target_type = CXL_DECODER_DEVMEM;
 		if (cxld->id != port->commit_end + 1) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",
@@ -861,7 +862,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
-		cxld->target_type = CXL_DECODER_EXPANDER;
+		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	}
 	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
 			  &cxld->interleave_ways);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e7c284c890bc..6d7811b26b5a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -117,9 +117,9 @@ static ssize_t target_type_show(struct device *dev,
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
 	switch (cxld->target_type) {
-	case CXL_DECODER_ACCELERATOR:
+	case CXL_DECODER_DEVMEM:
 		return sysfs_emit(buf, "accelerator\n");
-	case CXL_DECODER_EXPANDER:
+	case CXL_DECODER_HOSTONLYMEM:
 		return sysfs_emit(buf, "expander\n");
 	}
 	return -ENXIO;
@@ -1550,7 +1550,7 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 	/* Pre initialize an "empty" decoder */
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = PAGE_SIZE;
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
 		.start = 0,
 		.end = -1,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f822de44bee0..6a875f86901b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2103,7 +2103,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
+	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dfc94e76c7d6..ae0965ac8c5a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -290,8 +290,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 #define CXL_DECODER_F_MASK  GENMASK(5, 0)
 
 enum cxl_decoder_type {
-       CXL_DECODER_ACCELERATOR = 2,
-       CXL_DECODER_EXPANDER = 3,
+	CXL_DECODER_DEVMEM = 2,
+	CXL_DECODER_HOSTONLYMEM = 3,
 };
 
 /*
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index bf00dc52fe96..5565164d6658 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -713,7 +713,7 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = 256;
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 }
@@ -787,7 +787,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 
 	cxld->interleave_ways = 2;
 	eig_to_granularity(window->granularity, &cxld->interleave_granularity);
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->flags = CXL_DECODER_F_ENABLE;
 	cxled->state = CXL_DECODER_STATE_AUTO;
 	port->commit_end = cxld->id;
@@ -820,7 +820,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		} else
 			cxlsd->target[0] = dport;
 		cxld = &cxlsd->cxld;
-		cxld->target_type = CXL_DECODER_EXPANDER;
+		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		cxld->flags = CXL_DECODER_F_ENABLE;
 		iter->commit_end = 0;
 		/*

