Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BDC433FE
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Nov 2022 04:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiKLElj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Nov 2022 23:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiKLElg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Nov 2022 23:41:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA4CE0D0
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 20:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668228095; x=1699764095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AgDrqh5C6G9edqr21sApHv9NMRx+b/NUu/WUyQk094I=;
  b=SX4J3I5uaQa0NzMO4YpZxJeALUnLmkeiyPEntTCB4ko81sGFcgHL5+O5
   Y6DZyoHCfxOFeDi/aFgGNuX1RMHrimx+Vh3chROfMZ0Zy/tTQs017ET83
   RKay/csPU+QujUhyfZzMb1SJ4NiVB60QDhcnAFEqY0+5JpfPUdADMd/Ks
   PM/DAyqs4vfKFSMJ1y3s+BhXBWj2K8+cdXyFVfZ5WJqbqZWlacmrKhOBc
   F5fv++FP7N9Ry6Ij1UB/6FlnWrAvV6+51MhzvgY3c6Hvs3gdfgEBPrwel
   654esjp6eNWZk14wq6RAuYq/IPo9Y+8wRd0+QT0vlcCOCCdUEQXLLotWJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="375968589"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="375968589"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:41:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="670920049"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="670920049"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.134.249])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:41:34 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v6 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Date:   Fri, 11 Nov 2022 20:41:28 -0800
Message-Id: <37ac2e3d3580af13755edd6f8e0bbdf11d5c206b.1668227077.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668227077.git.alison.schofield@intel.com>
References: <cover.1668227077.git.alison.schofield@intel.com>
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
 drivers/cxl/acpi.c | 129 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h  |   2 +
 2 files changed, 126 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb649683dd3a..1211c31c29d2 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -6,9 +6,106 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
+#include <asm/div64.h>
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
@@ -33,11 +130,6 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
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
@@ -84,6 +176,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
 	struct resource *cxl_res = ctx->cxl_res;
+	struct cxl_cxims_context cxims_ctx;
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
@@ -148,7 +241,33 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ac75554b5d76..3f97a5e01c12 100644
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
 
-- 
2.37.3

