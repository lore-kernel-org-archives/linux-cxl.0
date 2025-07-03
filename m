Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC416225A59
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515419; cv=none; b=Zperfgt+jmzLziKHPIMWsnD19akbjA4rI6Gtz+k7FqTOg3pMhbp+rpHL5+LQhyHRkTb7va1QebpPDRbAz7HpofW99HQBJO55UNKoFkPCnwmhGqIYpKaZNsJyZ5JHkTyoECxQvZQYwzkf3/rCObawgFmX4fbNtOSoA0ny9oqzPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515419; c=relaxed/simple;
	bh=P6v37N95aSNytin+OrTd+wqRlrnE3tV/hPDJAwYt9y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhVb5X25t8irENgXrbhJRdevVrWljJS9YobtOdL7CwaDjDavlqvva+vbGsFksdBGGGWXaHSjxVqVUpgv9KXGjpw/bxOoVcnnqtzh5w9/5o/YZjR2d/5Ds3owwfIVuXEFSlejcB2JFf8dzbndJQHUmptDKQTR0rEKbpeA917f62Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNiNayLC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNiNayLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751515418; x=1783051418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P6v37N95aSNytin+OrTd+wqRlrnE3tV/hPDJAwYt9y0=;
  b=MNiNayLCSZ669xz9O2kFKLB15eWgaLfQDoEfCg5KJo4MqPwq3ygOZ6dF
   TSJfR5v4nZrCMCXVkAWtuyKVBOmIMOflhYOeG/QHXNC+6/vlYxntwaPWH
   Po+FWAhtmHuXccubeCuKKwXOxSzl4R5ffXM49IxbaVsXysa64D6Bywnzr
   ZIImgqPuuYv+Y29J0NTgLZAfGSsP5zvuDieXRRUHnElTbYOqK+ze1ic8z
   2qcTkUFoJNxqYJyi6yYlJIRTVBeZTFKEOlY35RTa4nvZyYvotkvIRIoSy
   n53U+vtrxoAbtl+O+RWTmUQJklMaI1wO3lkltGpQ0fgFM0/weks5mv1Wm
   Q==;
X-CSE-ConnectionGUID: bUN6s4ARSkC3/ON1iGdqVg==
X-CSE-MsgGUID: IR8meOTzSHuUlxklD2rAiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53692337"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="53692337"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:03:35 -0700
X-CSE-ConnectionGUID: ad0At/wYQpOoRSrBXsWTQw==
X-CSE-MsgGUID: SftlwPNWTROJT1c3JRtMcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="159951149"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:03:34 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/4] cxl/region: Introduce SPA to DPA address translation
Date: Wed,  2 Jul 2025 21:03:21 -0700
Message-ID: <b3216602850003d06016f4735246b5d4f9fdd643.1751513505.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1751513505.git.alison.schofield@intel.com>
References: <cover.1751513505.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Add infrastructure to translate System Physical Addresses (HPA) to
Device Physical Addresses (DPA) within CXL regions. This capability
will be used by follow-on patches that add poison inject and clear
operations at the region level.

The SPA-to-DPA translation process follows these steps:
1. Apply root decoder transformations (SPA to HPA) if configured.
2. Extract the position in region interleave from the HPA offset.
3. Extract the DPA offset from the HPA offset.
4. Use position to find endpoint decoder.
5. Use endpoint decoder to find memdev and calculate DPA from offset.
6. Return the result - a memdev and a DPA.

It is Step 1 above that makes this a driver level operation and not
work we can push to user space. Rather than exporting the XOR maps for
root decoders configured with XOR interleave, the driver performs this
complex calculation for the user.

Steps 2 and 3 follow the CXL Spec 3.2 Section 8.2.4.20.13
Implementation Note: Device Decode Logic.

These calculations mirror much of the logic introduced earlier in DPA
to SPA translation, see cxl_dpa_to_hpa(), where the driver needed to
reverse the spec defined steps. This case is not the reversal, it
follows the device decode logic per the spec.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
Shift by (eig + eiw) not (eig + 8) in MOD 3 interleaves (Jonathan)
Simplify bottom bit handling by saving and restoring (Jonathan)
Calculate the pos and dpa_offset inline, not in a helper
Use the new root decoder callback for spa_to_hpa()
Use div64_u64 instead of / to fix 32-bit ARM (lkp)
Use div64_u64_rem instead of % for arch safety
Pass pointer to results structures (DaveJ)
Add spec references and comments (DaveJ)
Add validate_region_offset() helper


 drivers/cxl/core/region.c | 100 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a2ba19151d4f..d965f07ba8a8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2956,6 +2956,106 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	return hpa;
 }
 
+struct dpa_result {
+	struct cxl_memdev *cxlmd;
+	u64 dpa;
+};
+
+static int __maybe_unused region_offset_to_dpa_result(struct cxl_region *cxlr,
+						      u64 offset,
+						      struct dpa_result *result)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_endpoint_decoder *cxled;
+	u64 hpa, hpa_offset, dpa_offset;
+	u64 bits_upper, bits_lower;
+	u64 shifted, rem;
+	u16 eig = 0;
+	u8 eiw = 0;
+	int pos;
+
+	lockdep_assert_held(&cxl_rwsem.region);
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
+	ways_to_eiw(p->interleave_ways, &eiw);
+	granularity_to_eig(p->interleave_granularity, &eig);
+
+	/*
+	 * If the root decoder has SPA to CXL HPA callback,
+	 * use it. Otherwise CXL HPA is assumed to equal SPA.
+	 */
+	if (cxlrd->spa_to_hpa) {
+		hpa = cxlrd->spa_to_hpa(cxlrd, p->res->start + offset);
+		hpa_offset = hpa - p->res->start;
+	} else {
+		hpa_offset = offset;
+	}
+	/*
+	 * Extracting the interleave position and the DPA offset
+	 * is based on the steps defined in CXL Spec 3.2 Section
+	 * 8.2.4.20.13 Implementation Note: Device Decode Logic
+	 */
+	/*
+	 * Interleave position:
+	 * eiw < 8
+	 *	Position is in the IW bits at HPA_OFFSET[IG+8+eiw-1:IG+8].
+	 *	Per spec "remove IW bits starting with bit position IG+8"
+	 * eiw >= 8
+	 *	Position is not explicitly stored in HPA_OFFSET. It is
+	 *	derived from the modulo-3 remainder of the upper bits.
+	 */
+	if (eiw < 8) {
+		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
+	} else {
+		shifted = hpa_offset >> (eig + eiw);
+		div64_u64_rem(shifted, 3, &rem);
+		pos = rem;
+	}
+	if (pos < 0 || pos >= p->nr_targets) {
+		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
+			pos, p->nr_targets);
+		return -ENXIO;
+	}
+	/*
+	 * DPA offset:
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
+
+	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
+	if (eiw < 8) {
+		hpa_offset &= ~((u64)GENMASK(eiw - 1, 0) << (eig + 8));
+		dpa_offset = hpa_offset >> eiw;
+	} else {
+		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
+		dpa_offset = bits_upper << (eig + 8);
+	}
+	dpa_offset |= bits_lower;
+
+	/* Look-up and return the result: a memdev and a DPA */
+	for (int i = 0; i < p->nr_targets; i++) {
+		cxled = p->targets[i];
+		if (cxled->pos == pos) {
+			result->cxlmd = cxled_to_memdev(cxled);
+			result->dpa =
+				cxl_dpa_resource_start(cxled) + dpa_offset;
+
+			return 0;
+		}
+	}
+	dev_err(&cxlr->dev, "No device found for position %d\n", pos);
+
+	return -ENXIO;
+}
+
 static struct lock_class_key cxl_pmem_region_key;
 
 static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
-- 
2.37.3

