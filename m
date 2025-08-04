Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32F817D346
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294424; cv=none; b=kFgHVUW11yCcDqVLfTC4I4m2zGHtWf6RTbAnQLfEkZSyagwyi6kuifsYn7VYh5Zl16dBz1HTC14FnqmrjY8JGefLvbgknDKw2W0VLFw9dr3DsIbHZBpkA9SJSm8z3DNeLhiNrWy7++n1DiUgYVrZ98jznPdGVBmjDqZA7uSETKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294424; c=relaxed/simple;
	bh=TSdoa2e7GMBlCBYosTkcb89+jC8r6HuieO67GYGl54Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iK8BJk7B9d6g7hzFAviuCPsgVWNxI0hFx3bLNkuX7SRPeH0Wxvn51JCahL5xLOwIsOzACHKn6IoB1/C4i5TF6jNSSJCVIEulFA20wQNNi2gzbACsTL0KkVVruRWBZKzzYZhgoGeRI3/NXBQI9EsRB0z1/7ptEcewcUZz3W/RJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgsxnWc+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgsxnWc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754294423; x=1785830423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSdoa2e7GMBlCBYosTkcb89+jC8r6HuieO67GYGl54Y=;
  b=UgsxnWc+8duRewjTcauVCZ2WFdl73IS1WFPeryTKZihv1taUnob/JjVm
   Uv0CWHz9CMQRwEdG6dH0/USnCiuVJxR5wccTOw/sfX0XG3AzkIhjUGocJ
   XEhu20qd721SQ4CJyeCLMWY2BheIOew5r6QmsR0yRaoS1TgTubrF0EYNX
   XaglE3ilnl/tOUtBvul+duhO6ja0fJGg1XM/vZNrrhKbPGKb7pAfOsrdt
   wvg/nZkG8a7aVTUG5yoLBZWstUBE5z3c580KT7xj3dPt+m5lCkCelfG+8
   myBiGIoadteBs8UTTJi4xd85WpiHmZJYO5JONBkU7zKvI2Hvk2CEHEG7U
   g==;
X-CSE-ConnectionGUID: ERD5r/hoSNSDg1UVtghJPw==
X-CSE-MsgGUID: YbUsm1uRSkqUhPI9kktpmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56474226"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56474226"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:00:22 -0700
X-CSE-ConnectionGUID: vRsfTaOsSIeEdr0sshv4wg==
X-CSE-MsgGUID: cCwqfH16Rwa6roKh9o7Bew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168548852"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.77])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:00:22 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v5 3/5] cxl/region: Introduce SPA to DPA address translation
Date: Mon,  4 Aug 2025 01:00:11 -0700
Message-ID: <422f0e27742c6ca9a11f7cd83e6ba9fa1a8d0c74.1754290144.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1754290144.git.alison.schofield@intel.com>
References: <cover.1754290144.git.alison.schofield@intel.com>
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
reverse the spec defined 'Device Decode Logic'.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v5: none

 drivers/cxl/core/region.c | 101 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3a097ecda1ea..da0759acb87e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2923,6 +2923,11 @@ static bool has_hpa_to_spa(struct cxl_root_decoder *cxlrd)
 	return cxlrd->ops && cxlrd->ops->hpa_to_spa;
 }
 
+static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
+{
+	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
+}
+
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
@@ -2993,6 +2998,102 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
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
+	u64 shifted, rem, temp;
+	u16 eig = 0;
+	u8 eiw = 0;
+	int pos;
+
+	lockdep_assert_held(&cxl_rwsem.region);
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
+	/* Input validation ensures valid ways and gran */
+	granularity_to_eig(p->interleave_granularity, &eig);
+	ways_to_eiw(p->interleave_ways, &eiw);
+
+	/*
+	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
+	 * CXL HPA is assumed to equal SPA.
+	 */
+	if (has_spa_to_hpa(cxlrd)) {
+		hpa = cxlrd->ops->spa_to_hpa(cxlrd, p->res->start + offset);
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
+	if (eiw < 8) {
+		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
+	} else {
+		shifted = hpa_offset >> (eig + 8);
+		div64_u64_rem(shifted, p->interleave_ways, &rem);
+		pos = rem;
+	}
+	if (pos < 0 || pos >= p->nr_targets) {
+		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
+			pos, p->nr_targets);
+		return -ENXIO;
+	}
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

