Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80864131E2D
	for <linux-cxl@vger.kernel.org>; Sun, 13 Jul 2025 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752374287; cv=none; b=OWvOxRcePADM1jISdvIa8t7rZTNtJUyN0iOFJQWA3bsc/yRTzidRGhpJ87pYV6oittTJBWcxK+naG2uqH6qSbeiiTTVmMI+ChqCp3j6/UYXkY6B1duGXjjR5ZUZOkD6ZnLoZJuFIUAQadefmYEpjbP1f+hBr7rauPb6YtbtFD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752374287; c=relaxed/simple;
	bh=ATzdGKXOIiwBl58Fb3x4x1mYS3qKvIn4wRXk1oCQX+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qckpQo2EuUO6mPn90E55HLBeaah6ZptjzV6dzJA4lXZVm+57VT9AfV9cM5zxgvZrbcj6Zh1C5NQhX4zAfi5Gu7GOZy2WCnH8XtbFOg0YiFVVMOwsKPiOI/cgd9f988S7XRUiqHQaL41uoElpEyRq1cFEG8NO67oHAqzAvDh4mdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TR/Gderh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TR/Gderh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752374285; x=1783910285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ATzdGKXOIiwBl58Fb3x4x1mYS3qKvIn4wRXk1oCQX+Y=;
  b=TR/Gderhawwyc7rg2vucwUXY2CqIkgDY3qK/V3jaHUYqEA6meSqAftIN
   c5Nau83qtxTViFxTgsRBs+YsE9Bokraju3fpYz0kEbvB3MoX1eyVce790
   lr3smcIsGoVEtezM+Pt/t1sLcnQuihfTi3fGfQ258z/r3VKGtqQ48xcOx
   3ROHI329BFpg/wGTDG+RHygncz+caZKquf8c8lEhOw9BwoVBPXGMq79GF
   vmmphJV+UO6hkQ70YYDh0JtD632wLhI/XwkX5TWnOrXngxxSSfbFPLzoD
   ITZ39mVvVnc/zcBfscca/lrthGetNWU00UXsJCCbmcaJDGJMEGP2WMsFt
   A==;
X-CSE-ConnectionGUID: TlKjAYRMTwqR+kl0BUIAFg==
X-CSE-MsgGUID: R8Ez/JPHTT+SwuF/X6k1rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65967442"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="65967442"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 19:38:05 -0700
X-CSE-ConnectionGUID: MD31sYCiQR6SNx+ZtAma2A==
X-CSE-MsgGUID: hqnQ9Wz1SPGLysc9z5PF7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="157206916"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.247])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 19:38:04 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 2/4] cxl/region: Introduce SPA to DPA address translation
Date: Sat, 12 Jul 2025 19:37:55 -0700
Message-ID: <28eeffc8905e658dc3ed62a7c52e030cbcfd5158.1752365427.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1752365427.git.alison.schofield@intel.com>
References: <cover.1752365427.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Add infrastructure to translate System Physical Addresses (SPA) to
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
reverse the spec defined 'Deivce Decode Logic'.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v3:
Check return of ways_to_eiw() & granularity_to_eig() (Jonathan)
Collapse a header comment into pos and offset blocks (Jonathan)
Calc pos for 3,6,12 using actual ways, not always 3 (Jonathan)
Mask off bottom bits in < 8 offset case (Jonathan)
Wrap code comments closer to column 80 (Jonathan)
Use a continue to un-nest a for loop. (Jonathan)

 drivers/cxl/core/region.c | 93 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a2ba19151d4f..404f69864d61 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2956,6 +2956,99 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
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
+	u16 eig = 0;
+	u8 eiw = 0;
+	int pos;
+
+	lockdep_assert_held(&cxl_rwsem.region);
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
+	if (granularity_to_eig(p->interleave_granularity, &eig) ||
+	    ways_to_eiw(p->interleave_ways, &eiw))
+		return -ENXIO;
+
+	/*
+	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
+	 * CXL HPA is assumed to equal SPA.
+	 */
+	if (cxlrd->spa_to_hpa) {
+		hpa = cxlrd->spa_to_hpa(cxlrd, p->res->start + offset);
+		hpa_offset = hpa - p->res->start;
+	} else {
+		hpa_offset = offset;
+	}
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
+	if (eiw < 8)
+		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
+	else
+		pos = (hpa_offset >> (eig + 8)) % p->interleave_ways;
+
+	if (pos < 0 || pos >= p->nr_targets) {
+		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
+			pos, p->nr_targets);
+		return -ENXIO;
+	}
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
+
+	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
+	if (eiw < 8) {
+		hpa_offset &= ~((u64)GENMASK(eiw + eig + 8 - 1, 0));
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
+		if (cxled->pos != pos)
+			continue;
+		result->cxlmd = cxled_to_memdev(cxled);
+		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
+
+		return 0;
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

