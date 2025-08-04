Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6BA1A727D
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297570; cv=none; b=dDZFawb9xLtOxIzSGndxO8J2BEVKXyANgA9JtBNwPMv8v2UOKB0MYcG6zu71Ipfp143wJhRj6zK5HHRB2dYHFgMRs25cp/ZDpGYlwq47lmxMCt6hUFGzjYqovIEsS+Y9LYuf93hi2V/6X4gj2rzX6w0d8lE1+/Frp88L0lM31lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297570; c=relaxed/simple;
	bh=RGuOH3nHgBFWp5VVu2DwOG2AEdukTCxjFVGeaC5RZow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLwiY8k0YTmtXvGm3xgHKclISXmMmyuvfmvDiaRFtKtW7LUiPVn7KrYcmN9+zRtL+2tjz4aXzZHCncqbDnGWWx4sYhm9LUeVW9V4WSwdnYTVT4y9AoG/2b9KInAeCkOw7TUJYplQ/xrkHX4SeDcVCiqme7UxuVzAm+4le/I3kfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2bMzk4H; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2bMzk4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754297569; x=1785833569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGuOH3nHgBFWp5VVu2DwOG2AEdukTCxjFVGeaC5RZow=;
  b=B2bMzk4HLk0lBTlDGrLjFQanoo20tRMBRTgnMpVnl8+8zHA32PKy40cR
   8VZ8FL579FlPl1comJiOF/OiTnxaKnykZmzGFWjogCAxpwLePvEMVl9Tf
   6sLMT7vSI12KK2AlCfWACrQbiFgdNfTM3XWjKolbbWJjZaQ+sksg+tHcK
   Hy8Fk0C44RQsK0S6BomC6Ov2XI7jGwPvxQLQADx6Hz6MKxHFvenOKDo+8
   PRLyTTWNKqtwvCHOtMa+shrHzvHijWXmo80W1iaVi1Bqn83pBsgk6YlSH
   VPuhmVsUiNq/e6RlTlQGKnAS3sLTu+4RoRfTQjd5uU4k9oX25f5ic4ZrU
   A==;
X-CSE-ConnectionGUID: l1du5XrqTReFcXUPXNLakg==
X-CSE-MsgGUID: v0IrZgLDQpK4ixklMeSRiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56442164"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56442164"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:52:48 -0700
X-CSE-ConnectionGUID: kRwZVNwkS8qQW/DHYhKEvA==
X-CSE-MsgGUID: MqZ6B0OMQ8iPWzyD6u3OZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164104236"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.77])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:52:47 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/3] cxl/region: Refactor address translation funcs for testing
Date: Mon,  4 Aug 2025 01:52:39 -0700
Message-ID: <d60d89dab66e1431bb2ff5cd7da1f0960bc2a057.1754291501.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1754291501.git.alison.schofield@intel.com>
References: <cover.1754291501.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

In preparation for adding a test module that exercises the address
translation calculations, extract the core calculations into stand-
alone functions that operate on base parameters without dependencies
on struct cxl_region.

This refactoring enables unit testing of the address translation logic
with controlled inputs, while maintaining identical functionality in
the existing code paths.

The moved code has only one change. In the new cxl_calculate_position()
eiw_to_ways(eiw, &ways) replaces the prior usage of p->interleave_ways,
since the new function cannot depend upon struct cxl_region_params.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 145 +++++++++++++++++++++++---------------
 drivers/cxl/cxl.h         |   3 +
 2 files changed, 90 insertions(+), 58 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 281a31df686f..ccee5049d700 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2929,13 +2929,91 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
 	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
 }
 
+u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig)
+{
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
+int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig)
+{
+	unsigned int ways = 0;
+	u64 shifted, rem;
+	int pos;
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
+
+u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig)
+{
+	u64 mask_upper, hpa_offset, bits_upper;
+
+	mask_upper = GENMASK_ULL(51, eig + 8);
+
+	if (eiw < 8) {
+		hpa_offset = (dpa_offset & mask_upper) << eiw;
+		hpa_offset |= pos << (eig + 8);
+	} else {
+		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
+		bits_upper = bits_upper * 3;
+		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
+	}
+
+	/* The lower bits remain unchanged */
+	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
+
+	return hpa_offset;
+}
+
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
-	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
+	u64 dpa_offset, hpa_offset, hpa;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -2965,19 +3043,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	/* Remove the dpa base */
 	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
 
-	mask_upper = GENMASK_ULL(51, eig + 8);
-
-	if (eiw < 8) {
-		hpa_offset = (dpa_offset & mask_upper) << eiw;
-		hpa_offset |= pos << (eig + 8);
-	} else {
-		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
-		bits_upper = bits_upper * 3;
-		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
-	}
-
-	/* The lower bits remain unchanged */
-	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
+	/* this chunk was moved, maybe move comment too */
+	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
 
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start + p->cache_size;
@@ -3011,8 +3078,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
-	u64 bits_upper, bits_lower;
-	u64 shifted, rem, temp;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -3034,50 +3099,14 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
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
-	if (pos < 0 || pos >= p->nr_targets) {
-		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
-			pos, p->nr_targets);
+
+	pos = cxl_calculate_position(hpa_offset, eiw, eig);
+	if (pos < 0 || pos >= p->nr_targets)
 		return -ENXIO;
-	}
 
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
+	if (dpa_offset == ULLONG_MAX)
+		return -ENXIO;
 
 	/* Look-up and return the result: a memdev and a DPA */
 	for (int i = 0; i < p->nr_targets; i++) {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f87628a22852..151a8ce698c5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -731,6 +731,9 @@ static inline bool is_cxl_root(struct cxl_port *port)
 	return port->uport_dev == port->dev.parent;
 }
 
+u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig);
+u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig);
+int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig);
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
-- 
2.37.3

