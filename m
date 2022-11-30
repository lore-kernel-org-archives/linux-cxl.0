Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6638C47088
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 22:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiK3Wrj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiK3Wrh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 17:47:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D98C5C
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 14:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669848455; x=1701384455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VR2EM7y4qFxVXtySed340ALUw9Ek194gIh6mitn2riY=;
  b=Uk6d8AeVRBNFrbj0IfyBwbK0/AcFrHIdpBPJVZMROQe0rtdqUfuE5Gi/
   dtJwH43Tg3AoMgNFhmHixmLbDZxXFlL5re57xN6oLyNl4EZC9jhIHbgBf
   /vmnVHZp5lm144GgQGvi315kf1Co8cjLeLJ27oHClIRKf4JnQjnm4w1vM
   WVHhFsYH7l5NUSKOA/VZws1dxdgLSq8bwVXRJfb/F0VV0DZ9CR0NlBgM5
   jmq9Dy23u90kGoA1Zl2TO6AK5olckaFuhcQ8YpaFmtH1eJ4PSHK0LUXlG
   WRfqwq/ex9cF+No8gyvW1jippFeqaYvQRksD4hfJQ/V4l97WqJd+Geiw2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="316682639"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="316682639"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:47:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="769003143"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="769003143"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.3.88])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:47:31 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Date:   Wed, 30 Nov 2022 14:47:25 -0800
Message-Id: <5794813acdf7b67cfba3609c6aaff46932fa38d0.1669847017.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669847017.git.alison.schofield@intel.com>
References: <cover.1669847017.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/acpi.c      | 136 +++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/port.c |   9 ++-
 drivers/cxl/cxl.h       |  11 +++-
 3 files changed, 148 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb649683dd3a..8eee0aa49a77 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -6,9 +6,117 @@
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
+static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
+			  int ig)
+{
+	int i = 0, n = 0;
+	u8 eiw;
+
+	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
+	if (iw != 3) {
+		for (i = 0; i < cximsd->nr_maps; i++)
+			n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
+	}
+	/* IW: 3,6,12 add a modulo calculation to 'n' */
+	if (!is_power_of_2(iw)) {
+		if (ways_to_cxl(iw, &eiw))
+			return -1;
+		hpa &= GENMASK_ULL(51, eiw + ig);
+		n |= do_div(hpa, 3) << i;
+	}
+	return n;
+}
+
+static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int ig = cxld->interleave_granularity;
+	int iw = cxld->interleave_ways;
+	int n = 0;
+	u64 hpa;
+
+	if (dev_WARN_ONCE(&cxld->dev,
+			  cxld->interleave_ways != cxlsd->nr_targets,
+			  "misconfigured root decoder\n"))
+		return NULL;
+
+	hpa = cxlrd->res->start + pos * ig;
+
+	/* Entry (n) is 0 for no interleave (iw == 1) */
+	if (iw != 1)
+		n = cxl_xor_calc_n(hpa, cximsd, iw, ig);
+
+	if (n < 0)
+		return NULL;
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
@@ -33,8 +141,10 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
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
 
@@ -84,9 +194,11 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
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
@@ -128,7 +240,12 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
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
 
@@ -148,7 +265,20 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
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
index e7556864ea80..42cdf224a85d 100644
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
 
@@ -1502,6 +1503,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  * cxl_root_decoder_alloc - Allocate a root level decoder
  * @port: owning CXL root of this decoder
  * @nr_targets: static number of downstream targets
+ * @calc_hb: which host bridge covers the n'th position by granularity
  *
  * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
  * 'CXL root' decoder is one that decodes from a top-level / static platform
@@ -1509,7 +1511,8 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  * topology.
  */
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-						unsigned int nr_targets)
+						unsigned int nr_targets,
+						cxl_calc_hb_fn calc_hb)
 {
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_switch_decoder *cxlsd;
@@ -1531,7 +1534,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 		return ERR_PTR(rc);
 	}
 
-	cxlrd->calc_hb = cxl_hb_modulo;
+	cxlrd->calc_hb = calc_hb;
 
 	cxld = &cxlsd->cxld;
 	cxld->dev.type = &cxl_decoder_root_type;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ac75554b5d76..5f611b8a37cf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -324,18 +324,23 @@ struct cxl_switch_decoder {
 	struct cxl_dport *target[];
 };
 
+struct cxl_root_decoder;
+typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
+					    int pos);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @platform_data: platform specific configuration data
  * @cxlsd: base cxl switch decoder
  */
 struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
-	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
+	cxl_calc_hb_fn calc_hb;
+	void *platform_data;
 	struct cxl_switch_decoder cxlsd;
 };
 
@@ -581,7 +586,9 @@ struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
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

