Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBCF4963C
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jul 2024 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984600; cv=none; b=Bqc8rW9fMDdF2l9TPuTlncX4d1qoHQTGPBecCyWy2sKyP9dTD9pVwbpylg2Z5g6jZM3nSEk1IaFsSknfdbnhEYB2QTLq70ErN7F2qoMKakR0mxcgcMZI9OjCIIedZ9r+B0jpaBXYsWOpxJMElCqO+3MF+iUm/pvqicgX3mM6p7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984600; c=relaxed/simple;
	bh=AmOnQggBXqezuOAmxRDbBpkUjUs3C38k0GLxjb3/kxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JcFhDBrHCeUhPNkxNYbGdlIl0rIbXyqj/+nzLxc94vMxrWQm91we5CaJ+/KAlApLcfjNmXE6F9eNXBXu/aiipDR7oPVnSllDrGvhv0if3iKgNt34CZYUG7IuOtOKdT7zTAsEcxgDxP8SrZEcIgwf6vtuKhkcvYpSQqFmVNh0x3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gal2XqTP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gal2XqTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719984598; x=1751520598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmOnQggBXqezuOAmxRDbBpkUjUs3C38k0GLxjb3/kxo=;
  b=gal2XqTPISKHjrbT/cryGwGjHxqzkYdF7xu6c9dmJUGUm6U7vOqaqhrY
   2NB3k8p7r7shptffvAJre3kXXKj6MiTyF1qsDcIc+P1eEfcv3AnvYUSai
   dW24DFR1E+QOfepzKlN1gmqVlaGAOk9AhWZu1aUhEXlXsYH4k6iF9lFAv
   S5J8dDS2KeCBtFx4M6L8DjJlZWVFevUHNctJsvU5szlyH0Dz1KPyubfUq
   HG3FI020azhzdwRTDj6J/Vm8PsmVP30Rj6wpgRjmYL2+i9quo3CX0o+iN
   HSMpNa1B6znq/SuB1x9RGAHiYDM8J02aXyempCEfJkPsQcNT45o5JTakh
   g==;
X-CSE-ConnectionGUID: +32UlwQ5T2SlDBp5D6708A==
X-CSE-MsgGUID: O6ORHtHsQGGMfktqRmpgCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28326348"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28326348"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:29:58 -0700
X-CSE-ConnectionGUID: eMLZZjXvR4ifQJnomEe0Vg==
X-CSE-MsgGUID: +6YrMFZZSsO0f3HEh9SSNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46004072"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.8.146])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:29:57 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
Subject: [PATCH v4 2/4] cxl: Restore XOR'd position bits during address translation
Date: Tue,  2 Jul 2024 22:29:50 -0700
Message-Id: <1a1ac880d9f889bd6384e657e810431b9a0a72e5.1719980933.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1719980933.git.alison.schofield@intel.com>
References: <cover.1719980933.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When a device reports a DPA in events like poison, general_media,
and dram, the driver translates that DPA back to an HPA. Presently,
the CXL driver translation only considers the Modulo position and
will report the wrong HPA for XOR configured root decoders.

Add a helper function that restores the XOR'd bits during DPA->HPA
address translation. Plumb a root decoder callback to the new helper
when XOR interleave arithmetic is in use. For Modulo arithmetic, just
let the callback be NULL - as in no extra work required.

Upon completion of a DPA->HPA translation a couple of checks are
performed on the result. One simply confirms that the calculated
HPA is within the address range of the region. That test is useful
for both Modulo and XOR interleave arithmetic decodes.

A second check confirms that the HPA is within an expected chunk
based on the endpoints position in the region and the region
granularity. An XOR decode disrupts the Modulo pattern making the
chunk check useless.

To align the checks with the proper decode, pull the region range
check inline and use the helper to do the chunk check for Modulo
decodes only.

A cxl-test unit test is posted for upstream review here:
https://lore.kernel.org/20240624210644.495563-1-alison.schofield@intel.com/

Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
---
 drivers/cxl/acpi.c        | 40 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c | 23 +++++++++++++---------
 drivers/cxl/cxl.h         |  3 +++
 3 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..6b6ae9c81368 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 	return cxlrd->cxlsd.target[n];
 }
 
+static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	int hbiw = cxlrd->cxlsd.nr_targets;
+	u64 val;
+	int pos;
+
+	/* No xormaps for host bridge interleave ways of 1 or 3 */
+	if (hbiw == 1 || hbiw == 3)
+		return hpa;
+
+	/*
+	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
+	 * the position bit to its value before the xormap was applied at
+	 * HPA->DPA translation.
+	 *
+	 * pos is the lowest set bit in an XORMAP
+	 * val is the XORALLBITS(HPA & XORMAP)
+	 *
+	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
+	 * as an operation that outputs a single bit by XORing all the
+	 * bits in the input (hpa & xormap). Implement XORALLBITS using
+	 * hweight64(). If the hamming weight is even the XOR of those
+	 * bits results in val==0, if odd the XOR result is val==1.
+	 */
+
+	for (int i = 0; i < cximsd->nr_maps; i++) {
+		if (!cximsd->xormaps[i])
+			continue;
+		pos = __ffs(cximsd->xormaps[i]);
+		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
+		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
+	}
+
+	return hpa;
+}
+
 struct cxl_cxims_context {
 	struct device *dev;
 	struct cxl_root_decoder *cxlrd;
@@ -434,6 +471,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxlrd->qos_class = cfmws->qtg_id;
 
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
+		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
+
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 237c28d5f2cc..23abd0f7b856 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2723,20 +2723,13 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	return ctx.cxlr;
 }
 
-static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
+static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	int gran = p->interleave_granularity;
 	int ways = p->interleave_ways;
 	u64 offset;
 
-	/* Is the hpa within this region at all */
-	if (hpa < p->res->start || hpa > p->res->end) {
-		dev_dbg(&cxlr->dev,
-			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
-		return false;
-	}
-
 	/* Is the hpa in an expected chunk for its pos(-ition) */
 	offset = hpa - p->res->start;
 	offset = do_div(offset, gran * ways);
@@ -2752,6 +2745,7 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
@@ -2801,7 +2795,18 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start;
 
-	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
+	/* Root decoder translation overrides typical modulo decode */
+	if (cxlrd->hpa_to_spa)
+		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
+
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_dbg(&cxlr->dev,
+			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
+		return ULLONG_MAX;
+	}
+
+	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
+	if (!cxlrd->hpa_to_spa && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
 		return ULLONG_MAX;
 
 	return hpa;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 603c0120cff8..dfc4f27d195c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -434,12 +434,14 @@ struct cxl_switch_decoder {
 struct cxl_root_decoder;
 typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
 					    int pos);
+typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
  * @qos_class: QoS performance class cookie
@@ -449,6 +451,7 @@ struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
 	cxl_calc_hb_fn calc_hb;
+	cxl_hpa_to_spa_fn hpa_to_spa;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-- 
2.37.3

