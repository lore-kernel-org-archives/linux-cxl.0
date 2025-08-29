Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1A263F43
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452107; cv=none; b=PyAmykVfayz03rkK8sA2A1qZXbrtBVkQNRXJEjIouc+wNnit+RZ7/aTKxGgUtMaSAwd0GEcitOaFG/QNT5dZl/uSS0Eas+8OIC8k5Oj9qhAyyUsvkgslTkI/i3WJmtvVOhIRjzftrF7/ueLZQ73iHWc8iUuI8ZEhhncq5UTsBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452107; c=relaxed/simple;
	bh=W3PWJfbOFWkRrHtGEZrR7WlVYY0/pr6ZcFBNPJrxwWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suGuSa/6iV8ujt7MdOAd5udr3RSLceeaVOHlWeWwOc4ULT+t0AR35wmwClTQOh6gWYNYbUFEdiIwY4CdVJK/l7byRIy6bY6mmBdceefUZsyJrCQPNYCOhTu1MwDO4cvo9ajGBOr1MceLPyH+q4pnhyYbvRGjddnasEo3lMiOTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFjN+1Zi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFjN+1Zi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756452105; x=1787988105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3PWJfbOFWkRrHtGEZrR7WlVYY0/pr6ZcFBNPJrxwWY=;
  b=kFjN+1ZiDj07G8bM1U9qX1xzwn4kv7QUjCFkhbJT3ZBUVzCZyVQFqvn5
   pE9KFOFwUGpvdtnTukAnGgACBpIZUgQ808OOOgBzheFyWA2oZdIovcbHC
   /U0Zp7h2wYdNifxst6EtNdF3SLWKfHYSo0Tx7T+aEDjKEXJP/toPQAYwY
   xoFSzAoKRRkMM1KdeVSm85Ljajx38krI35Tz34FiMoW2vEYCjgOXZViMG
   Xu93AoThh9r9q0aOrMuvvvZXwwjWsFZz1t9tIzTSABzTZDqDm2AXQzj8K
   LYuwNiYve9aFHFw1iCXbWOflNddltRpwrxobtjxVA3WcfEqYZvbIazbM0
   A==;
X-CSE-ConnectionGUID: 2XycQnC9Q4qUCM5Hg9UI5A==
X-CSE-MsgGUID: 1YFz0gpjTci+BOowvZYvLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58584996"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58584996"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:21:45 -0700
X-CSE-ConnectionGUID: HCYXsQNRTZKO7rOEaLqXgg==
X-CSE-MsgGUID: HiEJansGQ1m2c8TcH/4DPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175613118"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.170])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:21:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/3] cxl/region: Refactor address translation funcs for testing
Date: Fri, 29 Aug 2025 00:21:25 -0700
Message-ID: <f0c6fa733cea8585f2bfda0851489bd7ca2e2b2c.1756446925.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1756446925.git.alison.schofield@intel.com>
References: <cover.1756446925.git.alison.schofield@intel.com>
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

Mark the new functions as static outside of test builds by adding
and using a new __mock_export label.

This refactoring enables unit testing of the address translation logic
with controlled inputs, while maintaining identical functionality in
the existing code paths.

The moved code has only one change. In the new cxl_calculate_position()
eiw_to_ways(eiw, &ways) replaces the prior usage of p->interleave_ways,
since the new function cannot depend upon struct cxl_region_params.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 147 ++++++++++++++++++++++----------------
 drivers/cxl/cxl.h         |   5 ++
 2 files changed, 92 insertions(+), 60 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 29d3809ab2bb..71c01447b234 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2928,28 +2928,66 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
 	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
 }
 
-u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
-		   u64 dpa)
+__mock_export u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
-	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_endpoint_decoder *cxled = NULL;
-	u16 eig = 0;
-	u8 eiw = 0;
+	u64 dpa_offset, bits_lower, bits_upper, temp;
+
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
+		temp = hpa_offset &= ~((u64)GENMASK(eig + eiw + 8 - 1, 0));
+		dpa_offset = temp >> eiw;
+	} else {
+		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
+		dpa_offset = bits_upper << (eig + 8);
+	}
+	dpa_offset |= bits_lower;
+
+	return dpa_offset;
+}
+
+__mock_export int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig)
+{
+	unsigned int ways = 0;
+	u64 shifted, rem;
 	int pos;
 
-	for (int i = 0; i < p->nr_targets; i++) {
-		cxled = p->targets[i];
-		if (cxlmd == cxled_to_memdev(cxled))
-			break;
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
 	}
-	if (!cxled || cxlmd != cxled_to_memdev(cxled))
-		return ULLONG_MAX;
 
-	pos = cxled->pos;
-	ways_to_eiw(p->interleave_ways, &eiw);
-	granularity_to_eig(p->interleave_granularity, &eig);
+	return pos;
+}
+
+__mock_export u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig)
+{
+	u64 mask_upper, hpa_offset, bits_upper;
 
 	/*
 	 * The device position in the region interleave set was removed
@@ -2961,9 +2999,6 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
 	 */
 
-	/* Remove the dpa base */
-	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
-
 	mask_upper = GENMASK_ULL(51, eig + 8);
 
 	if (eiw < 8) {
@@ -2978,6 +3013,35 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	/* The lower bits remain unchanged */
 	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
 
+	return hpa_offset;
+}
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
+		cxled = p->targets[i];
+		if (cxlmd == cxled_to_memdev(cxled))
+			break;
+	}
+	if (!cxled || cxlmd != cxled_to_memdev(cxled))
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
 
@@ -3010,8 +3074,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
-	u64 bits_upper, bits_lower;
-	u64 shifted, rem, temp;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -3033,50 +3095,15 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
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
index 4fe3df06f57a..57590d131f75 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -922,5 +922,10 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 #define __mock static
 #endif
 
+/* Unit test build overrides this to export, otherwise static */
+#ifndef __mock_export
+#define __mock_export static
+#endif
+
 u16 cxl_gpf_get_dvsec(struct device *dev);
 #endif /* __CXL_H__ */
-- 
2.37.3

