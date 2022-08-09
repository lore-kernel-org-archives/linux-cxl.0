Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F38AC25B08
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 21:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiHIVqh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 17:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiHIVqd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 17:46:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845116AA3B
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 14:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660081592; x=1691617592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1cGqvIC6c0DwoMWtOvbSSW7nuOipN1kaEr125ksuH8g=;
  b=Xk5whu0qLfenJM6kKPG8ytLPuGr/OH4hkvHueOaubJPGLv/3qTkRnSYd
   brBkxE4wgW8WvX8klbPxYQ4dl3U5NNfg8wdpDsQTg4nryU/cPp4leWj8I
   rBeQImogtZa0QDAV9tnCipCzFrtVuiE7tXYhogZFm81h+Pik5HhD+rp7H
   vdSi90qB0QCrolDg3CwnnQ1K6+F5YzWmRUwJBw4ceiIevUR+ESUG/3K7S
   RZM2syuPztVfSWMdtSkNe1Pk1PJMYOG2YB2hjoyi5xhOyxS3/u7yK8cdn
   QNZ6PAKoeJzkR2f1Rln1SbU4YDTY5dNBpRmJo38UlFovb9M28P6qt9yQq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="270716269"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="270716269"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 14:46:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="601592820"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 14:46:31 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Date:   Tue,  9 Aug 2022 14:44:10 -0700
Message-Id: <f092ab4c6eb82c83c9cec4e7000bac8115c3664d.1660079951.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660079951.git.alison.schofield@intel.com>
References: <cover.1660079951.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When the CFMWS is using XOR math, parse the corresponding
CXIMS structure and store the xormaps in the root decoder.
Use the xormaps in a new lookup, cxl_hb_xor(), to discover
a targets entry in a host bridge interleave target list.

Defined in CXL Spec 3.0 Section: 9.17.1

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/cxl.h  |  2 +
 drivers/cxl/acpi.c | 96 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..0a17a7007bff 100644
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
 
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb649683dd3a..6ac6751c7f4e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -9,6 +9,79 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
+struct cxims_data {
+	int nr_maps;
+	u64 xormaps[];
+};
+
+static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
+{
+	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	struct cxims_data *cximsd = cxlrd->platform_data;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int ig = cxld->interleave_granularity;
+	int i, n = 0;
+	u64 hpa;
+
+	if (dev_WARN_ONCE(&cxld->dev,
+			  cxld->interleave_ways != cxlsd->nr_targets,
+			  "misconfigured root decoder\n"))
+		return NULL;
+	/*
+	 * Find this targets entry (n) in the host bridge interleave
+	 * list. Defined in CXL Spec 3.0 Section 9.17.1.3 Table 9-22
+	 */
+	hpa = cxlrd->res->start + pos * ig;
+	for (i = 0; i < cximsd->nr_maps; i++)
+		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
+
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
+	struct cxims_data *cximsd;
+	unsigned int hbig;
+	u8 eiw;
+	int rc;
+
+	rc = cxl_to_granularity(cxims->hbig, &hbig);
+	if (rc)
+		return rc;
+
+	rc = ways_to_cxl(cxld->interleave_ways, &eiw);
+	if (rc)
+		return rc;
+
+	if (hbig == cxld->interleave_granularity) {
+		if (cxims->nr_xormaps < eiw) {
+			dev_dbg(dev, "CXIMS nr_xormaps[%d] expected[%d]\n",
+				cxims->nr_xormaps, eiw);
+			return -ENXIO;
+		}
+
+		cximsd = devm_kzalloc(dev, struct_size(cximsd, xormaps, eiw),
+				      GFP_KERNEL);
+		memcpy(cximsd->xormaps, cxims->xormap_list,
+		       eiw * sizeof(*cximsd->xormaps));
+		cximsd->nr_maps = eiw;
+		cxlrd->platform_data = cximsd;
+		cxlrd->calc_hb = cxl_hb_xor;
+	}
+	return 0;
+}
+
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
@@ -33,11 +106,6 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 	int rc, expected_len;
 	unsigned int ways;
 
-	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
-		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
-		return -EINVAL;
-	}
-
 	if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
 		dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
 		return -EINVAL;
@@ -84,6 +152,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
 	struct resource *cxl_res = ctx->cxl_res;
+	struct cxl_cxims_context cxims_ctx;
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
@@ -148,7 +217,24 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
+		cxims_ctx = (struct cxl_cxims_context) {
+			.dev = dev,
+			.cxlrd = cxlrd,
+		};
+		rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
+					   cxl_parse_cxims, &cxims_ctx);
+		if (rc < 0)
+			goto err_xormap;
+
+		if (cxlrd->calc_hb != cxl_hb_xor) {
+			rc = -ENXIO;
+			goto err_xormap;
+		}
+	}
 	rc = cxl_decoder_add(cxld, target_map);
+
+err_xormap:
 	if (rc)
 		put_device(&cxld->dev);
 	else
-- 
2.31.1

