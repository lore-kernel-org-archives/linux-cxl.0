Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DD8ECAAA1
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 01:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIPBac (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Sep 2022 21:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIPBac (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Sep 2022 21:30:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829F3D5A8
        for <linux-cxl@vger.kernel.org>; Thu, 15 Sep 2022 18:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663291830; x=1694827830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xPS+H01T6RLZ2AXoUcHQ9MADOVpTKE02Sx5YaTgAOZI=;
  b=Ffcj6axzpb9Ph/ulpOYjMX2xo/KRdUrPT3idtLxpjj+vRmfNhT5GG5Yo
   gcEBRwNvRlJZz7Z/P6cb8/k4fNeDl3g60BPITkRzP/exj39tn8dbTBGxV
   VVLTuTI2Pe9mvXosBKDdUo6Tx7RcH3syCPAkWWuDQMQJgh32ZufRsgUyF
   2XqI3uXA+zulOBL04610IJdRxpBt0lnHlUHZ80hDPkdT8HR9m60RcyY8G
   ENt/93m/kUkZAU1wdVB550RIvyp1MJ3m3kVh2QcHGMTn5JTk6+3mWuJfX
   x2Tk2eeuzX35ULyhL+6zbJYOv7JqCCf9+Lv+ndBtxDh+GYSAHTdiIh8j7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="281913023"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="281913023"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:30:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="617502240"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.120.139])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:30:30 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Date:   Thu, 15 Sep 2022 18:30:23 -0700
Message-Id: <6cbe113e3aebc732d10cb77a316f547b581f22fa.1663291370.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1663291370.git.alison.schofield@intel.com>
References: <cover.1663291370.git.alison.schofield@intel.com>
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
 drivers/cxl/cxl.h  |   2 +
 drivers/cxl/acpi.c | 132 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 129 insertions(+), 5 deletions(-)

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
index fb649683dd3a..3ff0fd6e3e93 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -9,6 +9,106 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
+struct cxims_data {
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
+	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	struct cxims_data *cximsd = cxlrd->platform_data;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int ig = cxld->interleave_granularity;
+	int iw = cxld->interleave_ways;
+	int i, eiw, n = 0;
+	u64 hpa, mask;
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
+	if (iw == 3) {
+		/* Initialize 'i' for the modulo calc */
+		i = 0;
+		goto no_map;
+	}
+
+	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
+	for (i = 0; i < cximsd->nr_maps; i++)
+		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
+
+no_map:
+	/* IW: 3,6,12 add a modulo calculation to 'n' */
+	if (!is_power_of_2(iw)) {
+		eiw = ilog2(iw / 3) + 8;
+		mask = GENMASK(51, eiw + ig);
+		n |= (hpa & mask) % 3 << i;
+	}
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
+		memcpy(cximsd->xormaps, cxims->xormap_list,
+		       nr_maps * sizeof(*cximsd->xormaps));
+		cximsd->nr_maps = nr_maps;
+		cxlrd->platform_data = cximsd;
+		cxlrd->calc_hb = cxl_hb_xor;
+	}
+	return 0;
+}
+
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
@@ -33,11 +133,6 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
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
@@ -84,6 +179,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
 	struct resource *cxl_res = ctx->cxl_res;
+	struct cxl_cxims_context cxims_ctx;
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
@@ -148,7 +244,33 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
+		if (ways == 1 || ways == 3)	{
+			/* Skip CXIMS parsing for IW 1 or 3. No xormaps used */
+			cxlrd->calc_hb = cxl_hb_xor;
+			goto decoder_add;
+		}
+
+		cxims_ctx = (struct cxl_cxims_context) {
+			.dev = dev,
+			.cxlrd = cxlrd,
+		};
+
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
+
+decoder_add:
 	rc = cxl_decoder_add(cxld, target_map);
+
+err_xormap:
 	if (rc)
 		put_device(&cxld->dev);
 	else
-- 
2.31.1

