Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9236C43217
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 04:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKREdi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiKREdh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 23:33:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28285BC19
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 20:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668746015; x=1700282015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PX/hl4VLMJ0EQFhm3XNp0sAvBsy6CBGN/VfPMKPq2ZY=;
  b=acGMXyb4MJ//LTv2RxHH8AytZWUD/1SxFezNzvc43MGimX/+ZkYG5aWc
   2I4ZEZCSjXwXuro2hC/ory5x8aYRstH8OOgmMCc+XQEdvxQjyF30DHeiq
   D7btyXHAM8KarrtVHL3mLEnVnpa41VHLEbfZ5QreI1DhzQu55S3W2CGLA
   b7DsRPm9rmxx3onyW1ooiCauHLyVPE1z+vyvjOi4Xk+z+N4n+KFqlPrq1
   MtZQAlcsQkptXbz2tsFIDwxlktb1Pw6f+6PJXiTK9U+X32qbxNPNHhN1X
   Vx8vgWy3cJPqjpVFVCDyHWF3/7f4YKPGFbJjrUra+Ob8SHq32llt5ccPz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="377321663"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="377321663"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 20:33:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634304319"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="634304319"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.84.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 20:33:33 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v7 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Date:   Thu, 17 Nov 2022 20:33:28 -0800
Message-Id: <e174bd5f4224ad43c6be4303978d6ee21c120036.1668745515.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668745515.git.alison.schofield@intel.com>
References: <cover.1668745515.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When the CFMWS is using XOR math, parse the corresponding
CXIMS structure and store the xormaps in the root decoder
structure. Use the xormaps in a new lookup, cxl_hb_xor(),
to find a targets entry in the host bridge interleave
target list.

Defined in CXL Specfication 3.0 Section: 9.17.1

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c      | 126 +++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/port.c |   8 ++-
 drivers/cxl/cxl.h       |   8 ++-
 3 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb649683dd3a..98c84942ed37 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -6,9 +6,107 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
+#include <asm/div64.h>
 #include "cxlpci.h"
 #include "cxl.h"
 
+struct cxl_cxims_data {
+	int nr_maps;
+	u64 xormaps[];
+};
+
+/*
+ * Find a targets entry (n) in the host bridge interleave list.
+ * CXL Specfication 3.0 Table 9-22
+ */
+static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int ig = cxld->interleave_granularity;
+	int iw = cxld->interleave_ways;
+	int eiw, i = 0, n = 0;
+	u64 hpa;
+
+	if (dev_WARN_ONCE(&cxld->dev,
+			  cxld->interleave_ways != cxlsd->nr_targets,
+			  "misconfigured root decoder\n"))
+		return NULL;
+
+	if (iw == 1)
+		/* Entry is always 0 for no interleave */
+		return cxlrd->cxlsd.target[0];
+
+	hpa = cxlrd->res->start + pos * ig;
+
+	if (iw == 3)
+		goto no_map;
+
+	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
+	for (i = 0; i < cximsd->nr_maps; i++)
+		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
+
+no_map:
+	/* IW: 3,6,12 add a modulo calculation to 'n' */
+	if (!is_power_of_2(iw)) {
+		eiw = ilog2(iw / 3) + 8;
+		hpa &= GENMASK_ULL(51, eiw + ig);
+		n |= do_div(hpa, 3) << i;
+	}
+	return cxlrd->cxlsd.target[n];
+}
+
+struct cxl_cxims_context {
+	struct device *dev;
+	struct cxl_root_decoder *cxlrd;
+};
+
+static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
+			   const unsigned long end)
+{
+	struct acpi_cedt_cxims *cxims = (struct acpi_cedt_cxims *)header;
+	struct cxl_cxims_context *ctx = arg;
+	struct cxl_root_decoder *cxlrd = ctx->cxlrd;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct device *dev = ctx->dev;
+	struct cxl_cxims_data *cximsd;
+	unsigned int hbig, nr_maps;
+	int rc;
+
+	rc = cxl_to_granularity(cxims->hbig, &hbig);
+	if (rc)
+		return rc;
+
+	if (hbig == cxld->interleave_granularity) {
+		/* IW 1,3 do not use xormaps and skip this parsing entirely */
+
+		if (is_power_of_2(cxld->interleave_ways))
+			/* 2, 4, 8, 16 way */
+			nr_maps = ilog2(cxld->interleave_ways);
+		else
+			/* 6, 12 way */
+			nr_maps = ilog2(cxld->interleave_ways / 3);
+
+		if (cxims->nr_xormaps < nr_maps) {
+			dev_dbg(dev, "CXIMS nr_xormaps[%d] expected[%d]\n",
+				cxims->nr_xormaps, nr_maps);
+			return -ENXIO;
+		}
+
+		cximsd = devm_kzalloc(dev,
+				      struct_size(cximsd, xormaps, nr_maps),
+				      GFP_KERNEL);
+		if (!cximsd)
+			return -ENOMEM;
+		memcpy(cximsd->xormaps, cxims->xormap_list,
+		       nr_maps * sizeof(*cximsd->xormaps));
+		cximsd->nr_maps = nr_maps;
+		cxlrd->platform_data = cximsd;
+	}
+	return 0;
+}
+
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
@@ -33,8 +131,10 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 	int rc, expected_len;
 	unsigned int ways;
 
-	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
-		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
+	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO &&
+	    cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
+		dev_err(dev, "CFMWS Unknown Interleave Arithmetic: %d\n",
+			cfmws->interleave_arithmetic);
 		return -EINVAL;
 	}
 
@@ -84,9 +184,11 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
 	struct resource *cxl_res = ctx->cxl_res;
+	struct cxl_cxims_context cxims_ctx;
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
+	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
 	struct resource *res;
@@ -128,7 +230,12 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	if (rc)
 		goto err_insert;
 
-	cxlrd = cxl_root_decoder_alloc(root_port, ways);
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
+		cxl_calc_hb = cxl_hb_modulo;
+	else
+		cxl_calc_hb = cxl_hb_xor;
+
+	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
 	if (IS_ERR(cxlrd))
 		return 0;
 
@@ -148,7 +255,20 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
+		if (ways != 1 && ways != 3) {
+			cxims_ctx = (struct cxl_cxims_context) {
+				.dev = dev,
+				.cxlrd = cxlrd,
+			};
+			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
+						   cxl_parse_cxims, &cxims_ctx);
+			if (rc < 0)
+				goto err_xormap;
+		}
+	}
 	rc = cxl_decoder_add(cxld, target_map);
+err_xormap:
 	if (rc)
 		put_device(&cxld->dev);
 	else
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e7556864ea80..974f0f51bcd7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1428,7 +1428,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 	return rc;
 }
 
-static struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos)
+struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos)
 {
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
@@ -1441,6 +1441,7 @@ static struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos)
 
 	return cxlrd->cxlsd.target[pos % iw];
 }
+EXPORT_SYMBOL_NS_GPL(cxl_hb_modulo, CXL);
 
 static struct lock_class_key cxl_decoder_key;
 
@@ -1509,7 +1510,8 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  * topology.
  */
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-						unsigned int nr_targets)
+						unsigned int nr_targets,
+						cxl_calc_hb_fn calc_hb)
 {
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_switch_decoder *cxlsd;
@@ -1531,7 +1533,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 		return ERR_PTR(rc);
 	}
 
-	cxlrd->calc_hb = cxl_hb_modulo;
+	cxlrd->calc_hb = calc_hb;
 
 	cxld = &cxlsd->cxld;
 	cxld->dev.type = &cxl_decoder_root_type;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ac75554b5d76..e2a3df01a0ce 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -330,12 +330,14 @@ struct cxl_switch_decoder {
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @platform_data: platform specific configuration data
  * @cxlsd: base cxl switch decoder
  */
 struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
 	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
+	void *platform_data;
 	struct cxl_switch_decoder cxlsd;
 };
 
@@ -580,8 +582,12 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
+
+typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd, int pos);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-						unsigned int nr_targets);
+						unsigned int nr_targets,
+						cxl_calc_hb_fn calc_hb);
+struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
-- 
2.37.3

