Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5630F959
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430283; cv=none; b=rZAXqwvN4xqwiZlJuooAw4DradnJh+GQAJgw3jlLwu/vnSbG/zWBCFzovbP1NyLVv4hueRq/E4XUKg3pz6iAXjHaoDFdCApAh7Fm12Hg5xmD0bz1mviQFFvgIHvlTBA+4A8TtMhyAd/P1mo6LoeD3P1l/VJRHvUc21BsiO5cujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430283; c=relaxed/simple;
	bh=KMZUIfvbMmYpWOIgU/pW3gJ5ve8eD1nZIXs3RyHobw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT9i8lXd0vVk63bUEdmWPejl+DmMKmbyTwSzRniUowLfP5itRBcrN7X8wtBMpjZMn0Bn+KmXi2efO1tyc2dMk/oypkwlHJ4LMnjpavuvadEAk+I6Vq1XLfbqN9i7y44+2lhkUx+/VBoYO4n9RBQhEkfXcNgo/AxUJa+qS10EjpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBUaS8HF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBUaS8HF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760430282; x=1791966282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KMZUIfvbMmYpWOIgU/pW3gJ5ve8eD1nZIXs3RyHobw0=;
  b=mBUaS8HF9Oh6eUwZcGpEMgU8tuBBfzul890Ht90PQBWJdxKTiBVVBHgq
   1rFooeWiutzx5ziDPyyqhoVskRBn+Z/P8qjLWqeEEpPtzq2lZNFGAiuzZ
   mq4Fk6QV8CjdJMrwlKeR5wUupeyJkcVgUKV34AN7yr5MOb3ZhUysRdecs
   mxVQej+sbhSvCyqlEh/u67h5lNofp2tFO/nP6DqN+fAshm2I5zwlArnWf
   3hTS9Q8xzfIkZ0lzKu3X4z9ysJyJBQucXVHVO6RTN4aNwN2ABAf7eC61r
   EMYB0JmG4yDLp4Ca/R6FAwR1tm1H7+xr+185iz5IkHjeGaAXkNob9tlgt
   A==;
X-CSE-ConnectionGUID: vQpGA2jWT+SwQTsTuc6qpA==
X-CSE-MsgGUID: AhPXDKMmQh2QUx4zHaKfrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62619312"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62619312"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:24:40 -0700
X-CSE-ConnectionGUID: bNK5oxb8QLuMV2MjaqvvIg==
X-CSE-MsgGUID: KEBMoK7+TIaD4xSITLK8tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="218966073"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:24:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 1/3] cxl/region: Refactor address translation funcs for testing
Date: Tue, 14 Oct 2025 01:24:30 -0700
Message-ID: <0f7def3f31295d5cb36b54eda8c05d7be566e789.1760429439.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1760429439.git.alison.schofield@intel.com>
References: <cover.1760429439.git.alison.schofield@intel.com>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 204 ++++++++++++++++++++++++++------------
 drivers/cxl/cxl.h         |   6 ++
 2 files changed, 149 insertions(+), 61 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e14c1d305b22..632204a3f902 100644
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
+EXPORT_SYMBOL_FOR_MODULES(cxl_validate_translation_params, "cxl_translate");
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
+EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_dpa_offset, "cxl_translate");
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
+EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_position, "cxl_translate");
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
+EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_hpa_offset, "cxl_translate");
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
index 231ddccf8977..10bee9aaa943 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -738,6 +738,12 @@ static inline bool is_cxl_root(struct cxl_port *port)
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

