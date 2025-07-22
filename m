Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C627702E
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217277; cv=none; b=gHyR3fwH4nnLJzPi8byzXT3XQqQOT0TH6j+D7E3jouyVQ2HKk8tEhY/CjBC++PK9eJn5HlVdI8pRnQV2UKrovR7W4cGEjfLw+SVjBLCXSlPTZxYKIrHalOkILa4TUT+STvRvL/Hnxit9XhKvOqwh7Xm8fbzQ1gMdYABUJgHfgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217277; c=relaxed/simple;
	bh=HfvnM/JX5kz337U+crkCtcaPPu0AxDOfNbHyvQUmbgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuGoHm5c69bKjEH+lFoq/rwPSa/NPOgB0GjfLxxh+y12U15nM6zBghQzmmHHVb4yXwJV4a58FPQh8yiGsNXtcJGJYr7O6A+cHv4JtTmv9zJcCOCp+4ap5+BNz61UuV9tYw8o+GudWYdAOkXISZ6+RndNzZE/TkaOvd0MEnY0Pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0NZ1jkL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0NZ1jkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753217275; x=1784753275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HfvnM/JX5kz337U+crkCtcaPPu0AxDOfNbHyvQUmbgg=;
  b=c0NZ1jkL7ALcrokNxP4iuhzG/58IOpDMkSXlswxZyZDQc8eSSpQ2dH7k
   PQ6LeKrGYz5oUf63piFdTWJnNpSi6bbrnUQXy9knHZlQ9KKfLsxi1FOVv
   YKUxhQYXVmNjzRUMYgfSrN7Gnl73DAae3qE4q061HFA2DQEVWXzsRJ48/
   6uQsEXMe8I/EHgHmRjVGByUX4FOPemz8O9Y/GkrIB6Gl/VptFs9wJQTeR
   gdyaymPsp7es3ZHip5F6/5vJ0/6h80f0bMj8StB1mRrUvaFl2fDSSYEii
   /zaYSV217a6RuuqFLtsdHuSaff80MX3dmeU5s2h0rs+tR/S5I2aeet1ym
   g==;
X-CSE-ConnectionGUID: NSgHG0/lROmSkFNlnMJlOA==
X-CSE-MsgGUID: 5P0/EIiXToKovE40JroXTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58100186"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="58100186"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:55 -0700
X-CSE-ConnectionGUID: RW+0Tgh6TtCxHyfDI+3Ykw==
X-CSE-MsgGUID: T2KaWfGITGO2nFoN2lp7Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="159001629"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.207])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:55 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 3/5] cxl/region: Introduce SPA to DPA address translation
Date: Tue, 22 Jul 2025 13:47:42 -0700
Message-ID: <ba6227b3e91d66b87e15cbaeb92f85f2426c7edf.1753214969.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1753214969.git.alison.schofield@intel.com>
References: <cover.1753214969.git.alison.schofield@intel.com>
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

Changes in v4:
Add /* Input validation ensures valid ways and gran */ (Jonathan)
Use a temp instead of modifying hpa_offset in place (Jonathan)
Reorder mask addends to match spec definition (Jonathan)
Add a blank line, remove a blank line (Jonathan)
s/Deivce/Device in commit log (Jonathan)
Use div64_u64_rem() for MOD operation (lkp)

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

