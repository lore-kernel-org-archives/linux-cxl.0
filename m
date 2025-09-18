Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155EE4A2D
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758154242; cv=none; b=agBvFDIpeHu/TBR5lKxjIcbDktdC1fJP42+Bvd++v4r+ru76abcKlE/FAP2v+2sRoo5i5Wo72V5X88BcQrYUL+2Wrse9zxCBLVjol1e7zv//wpz404VBH/bNNfDJ/5Yssbxd5a89fAiavCZYQOZid81sndqmdIf8EjEWGaXWDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758154242; c=relaxed/simple;
	bh=170DQyny0/0pYL6QV4g8DGWjKmW2Tu1K6ae41lCVUvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8mRexq1gVbT8bzMd44xxsqwFyM3v2E2H3DFirbnVfQeda7/4cq13bVgloIS+TKjSbR/n/ZsFnyGCEO3vRNhocvwal4yzpI9mdBSUZ4bbYIjcNgPOxB27BisDxrtvukRqxzzAPtHOGHOKCCbon8iHUSvKhkmEQ1SdtByLiBGG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKgZKwca; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKgZKwca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758154240; x=1789690240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=170DQyny0/0pYL6QV4g8DGWjKmW2Tu1K6ae41lCVUvk=;
  b=TKgZKwcamj8LAQL/8lJm9NMrBW5F0oJ3hhbc68L3Pwn1+O1BKQKLNSTw
   uHPJoN03sxUiNtJjenq/7xZTbHbwqDlgi9PRGqwUCU7Z9hEMTRAf8LKf5
   1TkrXqtjy7Ng5c3i5UfRM8c86DzI1QW8JULAneMc1Yn1VFGIl9R1MZ4bu
   HMrkLzHqjEY9VZauMnc6fhAtAXGy9ktif6YpAaaBypuQplr9JNaIP/c6N
   irgWUUKeRPLk7Z0N91jfPIhJE9nvnYV2OW60jcHnr0K21nagiZZYbT3Qm
   ezjE7+dGGfSqIvh+00Bpp/IBAU5yCPSzfDcIGFbaHBybBBF42ZAHGjlAq
   g==;
X-CSE-ConnectionGUID: 3E+qR5YYTSiE6/KvmfGeNw==
X-CSE-MsgGUID: fXf2Y5HpSTy5fJDDEVQumw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="63106140"
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="63106140"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 17:10:39 -0700
X-CSE-ConnectionGUID: vR3BtTOGTQ+fhI4DrBFT9g==
X-CSE-MsgGUID: QVSelpvmR+ydJ/v32cPtrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="174500050"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.125])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 17:10:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/3] cxl/region: Refactor address translation funcs for testing
Date: Wed, 17 Sep 2025 17:10:30 -0700
Message-ID: <f0913dd2db0b86c27021b9184d63fe12395bde4d.1758150087.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1758150087.git.alison.schofield@intel.com>
References: <cover.1758150087.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding a test module that exercises the address
translation calculations, extract the core calculations into stand-
alone functions that operate on base parameters without dependencies
on struct cxl_region.

Perform additional parameter validation to protect against a test
module sending bad parameters. Export the validation function, as
well as the three core translation functions for use by test module
cxl_translate only.

This refactoring enables unit testing of the address translation logic
with controlled inputs, while preserving identical functionality in
the existing code paths.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 204 ++++++++++++++++++++++++++------------
 drivers/cxl/cxl.h         |   6 ++
 2 files changed, 149 insertions(+), 61 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e14c1d305b22..27c5c7de1fff 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2934,28 +2934,119 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
 	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
 }
 
-u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
-		   u64 dpa)
+#define CXL_POS_ZERO 0
+/**
+ * cxl_validate_translation_params
+ * @eiw: encoded interleave ways
+ * @eig: encoded interleave granularity
+ * @pos: position in interleave
+ *
+ * Callers pass CXL_POS_ZERO when no position parameter needs validating.
+ *
+ * Returns: 0 on success, -EINVAL on first invalid parameter
+ */
+int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
-	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_endpoint_decoder *cxled = NULL;
-	u16 eig = 0;
-	u8 eiw = 0;
-	int pos;
-
-	for (int i = 0; i < p->nr_targets; i++) {
-		cxled = p->targets[i];
-		if (cxlmd == cxled_to_memdev(cxled))
-			break;
+	int ways, gran;
+
+	if (eiw_to_ways(eiw, &ways)) {
+		pr_debug("%s: invalid eiw=%u\n", __func__, eiw);
+		return -EINVAL;
+	}
+	if (eig_to_granularity(eig, &gran)) {
+		pr_debug("%s: invalid eig=%u\n", __func__, eig);
+		return -EINVAL;
+	}
+	if (pos < 0 || pos >= ways) {
+		pr_debug("%s: invalid pos=%d for ways=%u\n", __func__, pos,
+			 ways);
+		return -EINVAL;
 	}
-	if (!cxled || cxlmd != cxled_to_memdev(cxled))
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL_FOR_MODULES(cxl_validate_translation_params, "cxl_translate");
+
+u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig)
+{
+	u64 dpa_offset, bits_lower, bits_upper, temp;
+	int ret;
+
+	ret = cxl_validate_translation_params(eiw, eig, CXL_POS_ZERO);
+	if (ret)
 		return ULLONG_MAX;
 
-	pos = cxled->pos;
-	ways_to_eiw(p->interleave_ways, &eiw);
-	granularity_to_eig(p->interleave_granularity, &eig);
+	/*
+	 * DPA offset: CXL Spec 3.2 Section 8.2.4.20.13
+	 * Lower bits [IG+7:0] pass through unchanged
+	 * (eiw < 8)
+	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
+	 *	Clear the position bits to isolate upper section, then
+	 *	reverse the left shift by eiw that occurred during DPA->HPA
+	 * (eiw >= 8)
+	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
+	 *	Extract upper bits from the correct bit range and divide by 3
+	 *	to recover the original DPA upper bits
+	 */
+	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
+	if (eiw < 8) {
+		temp = hpa_offset &= ~GENMASK_ULL(eig + eiw + 8 - 1, 0);
+		dpa_offset = temp >> eiw;
+	} else {
+		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
+		dpa_offset = bits_upper << (eig + 8);
+	}
+	dpa_offset |= bits_lower;
+
+	return dpa_offset;
+}
+EXPORT_SYMBOL_GPL_FOR_MODULES(cxl_calculate_dpa_offset, "cxl_translate");
+
+int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig)
+{
+	unsigned int ways = 0;
+	u64 shifted, rem;
+	int pos, ret;
+
+	ret = cxl_validate_translation_params(eiw, eig, CXL_POS_ZERO);
+	if (ret)
+		return ret;
+
+	if (!eiw)
+		/* position is 0 if no interleaving */
+		return 0;
+
+	/*
+	 * Interleave position: CXL Spec 3.2 Section 8.2.4.20.13
+	 * eiw < 8
+	 *	Position is in the IW bits at HPA_OFFSET[IG+8+IW-1:IG+8].
+	 *	Per spec "remove IW bits starting with bit position IG+8"
+	 * eiw >= 8
+	 *	Position is not explicitly stored in HPA_OFFSET bits. It is
+	 *	derived from the modulo operation of the upper bits using
+	 *	the total number of interleave ways.
+	 */
+	if (eiw < 8) {
+		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
+	} else {
+		shifted = hpa_offset >> (eig + 8);
+		eiw_to_ways(eiw, &ways);
+		div64_u64_rem(shifted, ways, &rem);
+		pos = rem;
+	}
+
+	return pos;
+}
+EXPORT_SYMBOL_GPL_FOR_MODULES(cxl_calculate_position, "cxl_translate");
+
+u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig)
+{
+	u64 mask_upper, hpa_offset, bits_upper;
+	int ret;
+
+	ret = cxl_validate_translation_params(eiw, eig, pos);
+	if (ret)
+		return ULLONG_MAX;
 
 	/*
 	 * The device position in the region interleave set was removed
@@ -2967,9 +3058,6 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
 	 */
 
-	/* Remove the dpa base */
-	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
-
 	mask_upper = GENMASK_ULL(51, eig + 8);
 
 	if (eiw < 8) {
@@ -2984,6 +3072,37 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	/* The lower bits remain unchanged */
 	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
 
+	return hpa_offset;
+}
+EXPORT_SYMBOL_GPL_FOR_MODULES(cxl_calculate_hpa_offset, "cxl_translate");
+
+u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
+		   u64 dpa)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled = NULL;
+	u64 dpa_offset, hpa_offset, hpa;
+	u16 eig = 0;
+	u8 eiw = 0;
+	int pos;
+
+	for (int i = 0; i < p->nr_targets; i++) {
+		if (cxlmd == cxled_to_memdev(p->targets[i])) {
+			cxled = p->targets[i];
+			break;
+		}
+	}
+	if (!cxled)
+		return ULLONG_MAX;
+
+	pos = cxled->pos;
+	ways_to_eiw(p->interleave_ways, &eiw);
+	granularity_to_eig(p->interleave_granularity, &eig);
+
+	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
+
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
@@ -3016,8 +3135,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
-	u64 bits_upper, bits_lower;
-	u64 shifted, rem, temp;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -3039,50 +3156,15 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	} else {
 		hpa_offset = offset;
 	}
-	/*
-	 * Interleave position: CXL Spec 3.2 Section 8.2.4.20.13
-	 * eiw < 8
-	 *	Position is in the IW bits at HPA_OFFSET[IG+8+IW-1:IG+8].
-	 *	Per spec "remove IW bits starting with bit position IG+8"
-	 * eiw >= 8
-	 *	Position is not explicitly stored in HPA_OFFSET bits. It is
-	 *	derived from the modulo operation of the upper bits using
-	 *	the total number of interleave ways.
-	 */
-	if (eiw < 8) {
-		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
-	} else {
-		shifted = hpa_offset >> (eig + 8);
-		div64_u64_rem(shifted, p->interleave_ways, &rem);
-		pos = rem;
-	}
+
+	pos = cxl_calculate_position(hpa_offset, eiw, eig);
 	if (pos < 0 || pos >= p->nr_targets) {
 		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
 			pos, p->nr_targets);
 		return -ENXIO;
 	}
 
-	/*
-	 * DPA offset: CXL Spec 3.2 Section 8.2.4.20.13
-	 * Lower bits [IG+7:0] pass through unchanged
-	 * (eiw < 8)
-	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
-	 *	Clear the position bits to isolate upper section, then
-	 *	reverse the left shift by eiw that occurred during DPA->HPA
-	 * (eiw >= 8)
-	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
-	 *	Extract upper bits from the correct bit range and divide by 3
-	 *	to recover the original DPA upper bits
-	 */
-	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
-	if (eiw < 8) {
-		temp = hpa_offset &= ~((u64)GENMASK(eig + eiw + 8 - 1, 0));
-		dpa_offset = temp >> eiw;
-	} else {
-		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
-		dpa_offset = bits_upper << (eig + 8);
-	}
-	dpa_offset |= bits_lower;
+	dpa_offset = cxl_calculate_dpa_offset(hpa_offset, eiw, eig);
 
 	/* Look-up and return the result: a memdev and a DPA */
 	for (int i = 0; i < p->nr_targets; i++) {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 64a523a51ed6..ee33fabfec4a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -736,6 +736,12 @@ static inline bool is_cxl_root(struct cxl_port *port)
 	return port->uport_dev == port->dev.parent;
 }
 
+/* Address translation functions exported to cxl_translate test module only */
+int cxl_validate_translation_params(u8 eiw, u16 eig, int pos);
+u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig);
+u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig);
+int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig);
+
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
-- 
2.37.3

