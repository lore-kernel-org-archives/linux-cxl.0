Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B159C19F2A
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 20:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiHKUvp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiHKUvl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 16:51:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F085AB2
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660251100; x=1691787100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8fxLIu3FPlN/55RQUvg9aIaQpf4fci93KUSq0ZerI1U=;
  b=Si6QcuD24arT5vKTsnQaotT0Ar+nb8Bj0y+aXskYn0cgXh8U2K12wPgq
   HwfOAOwFVtRFpvpjKlTRr0UH2JFvKb6gbFhByOoX2uDaszBYiaPjQ21e+
   M1RjnT9B5GmauwIXuCyUdVN5Z/VZq3y0G7noDuwGwF7+L8Eb21Uew5Bae
   p+x6uSnGJ6iU/eLOr7yCKpOVytYI9K1WYCSoc2hUZaHNLYqkzdaI5iey9
   QMpvGrVIEyHoFmTqVjtZwMreGaBjPL6AFiB3WA1Uhsidx81gy6/rYa+Ym
   MTYTrnLVfb9HwKN/J76DSI4pKgym6kHRGqJRqF8JV3UkkvcDtS4acttln
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292720488"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="292720488"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:51:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="851345664"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:51:38 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/2] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Date:   Thu, 11 Aug 2022 13:49:12 -0700
Message-Id: <3f4a6a6d66d53ff4a11a62a4db4d1a295c1b642f.1660250360.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660250360.git.alison.schofield@intel.com>
References: <cover.1660250360.git.alison.schofield@intel.com>
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
Changes in v2:
- Use ilog2() of the decoded interleave ways to determine number
of xormaps, instead of using encoded ways directly. This fixes
3, 6, and 12 way interleaves. (Dan)


 drivers/cxl/cxl.h  |  2 +
 drivers/cxl/acpi.c | 94 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 5 deletions(-)

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
index fb649683dd3a..4dddef228b10 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -9,6 +9,77 @@
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
+	unsigned int hbig, nr_maps;
+	int rc;
+
+	rc = cxl_to_granularity(cxims->hbig, &hbig);
+	if (rc)
+		return rc;
+
+	nr_maps = ilog2(cxld->interleave_ways);
+
+	if (hbig == cxld->interleave_granularity) {
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
@@ -33,11 +104,6 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
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
@@ -84,6 +150,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
 	struct resource *cxl_res = ctx->cxl_res;
+	struct cxl_cxims_context cxims_ctx;
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
@@ -148,7 +215,24 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
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

