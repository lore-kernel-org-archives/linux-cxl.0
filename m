Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E95EC77B73
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjFDXcI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFDXcH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F7AB
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921525; x=1717457525;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3sCQINl4wQ2HdriWuHP8qWgZool+d2x7aQv4pazRoI=;
  b=S64MBaN4zwLebvSOxDxtyXdr21AAfGlf1BZoa3kYYiak48OAAkjKZrRf
   JMrf8DsOEdfTL3KeBrh1o7+euqC1YdD+j1Xt1KC5+dJVRDVgCBOLWXGyF
   EB7YVk/9kEEp/kpIPrFbAqx4prDWKCXTrR1BvtVqcFKCGfGdcgWEbpNQH
   EAoQCjDLnn80ukYK7Zztv4kr5f5IgLHRM41ct/Olh/QjcbiMZTWTBEEtN
   1usjFDVZ2ns0dmglf+PailxUqjA5FUhe+pWbXK7qYP44qK5ZxU3aRBfAQ
   Uqq6XCRgieuVFDR8S1jJpQ80xCwxY5zTCTl1SoYSHY+q8v7bwsfVjrnwQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384534737"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384534737"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="832611403"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="832611403"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:05 -0700
Subject: [PATCH 05/19] cxl/port: Rename CXL_DECODER_{EXPANDER,
 ACCELERATOR} => {HOSTMEM, DEVMEM}
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:32:05 -0700
Message-ID: <168592152508.1948938.17633369037592532464.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for support for HDM-D and HDM-DB configuration
(device-memory, and device-memory with back-invalidate). Rename the current
type designators to use HOSTMEM and DEVMEM as a suffix.

HDM-DB can be supported by devices that are not accelerators, so DEVMEM is
a more generic term for that case.

Fixup one location where this type value was open coded.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c           |    2 +-
 drivers/cxl/core/hdm.c       |   10 +++++-----
 drivers/cxl/core/port.c      |    6 +++---
 drivers/cxl/core/region.c    |    2 +-
 drivers/cxl/cxl.h            |    4 ++--
 tools/testing/cxl/test/cxl.c |    6 +++---
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7e1765b09e04..4e66483f1fd3 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -258,7 +258,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTMEM;
 	cxld->hpa_range = (struct range) {
 		.start = res->start,
 		.end = res->end,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7889ff203a34..de8a3fb28331 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -570,7 +570,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 
 static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 {
-	u32p_replace_bits(ctrl, !!(cxld->target_type == 3),
+	u32p_replace_bits(ctrl, !!(cxld->target_type == CXL_DECODER_HOSTMEM),
 			  CXL_HDM_DECODER0_CTRL_TYPE);
 }
 
@@ -764,7 +764,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	if (!len)
 		return -ENOENT;
 
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTMEM;
 	cxld->commit = NULL;
 	cxld->reset = NULL;
 	cxld->hpa_range = info->dvsec_range[which];
@@ -838,9 +838,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
-			cxld->target_type = CXL_DECODER_EXPANDER;
+			cxld->target_type = CXL_DECODER_HOSTMEM;
 		else
-			cxld->target_type = CXL_DECODER_ACCELERATOR;
+			cxld->target_type = CXL_DECODER_DEVMEM;
 		if (cxld->id != port->commit_end + 1) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",
@@ -861,7 +861,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
-		cxld->target_type = CXL_DECODER_EXPANDER;
+		cxld->target_type = CXL_DECODER_HOSTMEM;
 	}
 	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
 			  &cxld->interleave_ways);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e7c284c890bc..432a4ac38f36 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -117,9 +117,9 @@ static ssize_t target_type_show(struct device *dev,
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
 	switch (cxld->target_type) {
-	case CXL_DECODER_ACCELERATOR:
+	case CXL_DECODER_DEVMEM:
 		return sysfs_emit(buf, "accelerator\n");
-	case CXL_DECODER_EXPANDER:
+	case CXL_DECODER_HOSTMEM:
 		return sysfs_emit(buf, "expander\n");
 	}
 	return -ENXIO;
@@ -1550,7 +1550,7 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 	/* Pre initialize an "empty" decoder */
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = PAGE_SIZE;
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTMEM;
 	cxld->hpa_range = (struct range) {
 		.start = 0,
 		.end = -1,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f822de44bee0..dca94c458b8f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2103,7 +2103,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
+	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTMEM);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dfc94e76c7d6..e2d0ae228cba 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -290,8 +290,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 #define CXL_DECODER_F_MASK  GENMASK(5, 0)
 
 enum cxl_decoder_type {
-       CXL_DECODER_ACCELERATOR = 2,
-       CXL_DECODER_EXPANDER = 3,
+	CXL_DECODER_DEVMEM = 2,
+	CXL_DECODER_HOSTMEM = 3,
 };
 
 /*
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index bf00dc52fe96..e3f1b2e88e3e 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -713,7 +713,7 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = 256;
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTMEM;
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 }
@@ -787,7 +787,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 
 	cxld->interleave_ways = 2;
 	eig_to_granularity(window->granularity, &cxld->interleave_granularity);
-	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->target_type = CXL_DECODER_HOSTMEM;
 	cxld->flags = CXL_DECODER_F_ENABLE;
 	cxled->state = CXL_DECODER_STATE_AUTO;
 	port->commit_end = cxld->id;
@@ -820,7 +820,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		} else
 			cxlsd->target[0] = dport;
 		cxld = &cxlsd->cxld;
-		cxld->target_type = CXL_DECODER_EXPANDER;
+		cxld->target_type = CXL_DECODER_HOSTMEM;
 		cxld->flags = CXL_DECODER_F_ENABLE;
 		iter->commit_end = 0;
 		/*

