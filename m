Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F56F31E
	for <linux-cxl@vger.kernel.org>; Thu,  6 Mar 2025 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290214; cv=none; b=Oj6aRpDVwH+05v82uH/kdMJWchddDVpwYdpSEtw/753hmrCO1zg7PDz7Hi2iwdvVWB2GZ0tqQBbZIQdft88tqtESQ6AMonQF0BmK2ZL+dlrAdMFhYroH9AfwHazRnd4VUcSc3e85tsbNcyrThX2lrvdOx8Ru4hIYuArEoaa5fZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290214; c=relaxed/simple;
	bh=uSAgVfCo5KVFOTRsUa3m7cbmhNpmCzSsNcxN18LgEpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdaArCaB4Lcvv89fsZ9H64bJ71/DqWN0CYKa8Kfla2tC8wXcQvZuvIAy9LQ+/c8IR97MmLgFmJw4UqmI65ZUX8VVCXzkLbTsW/mawMm57933MYrk+/i0m3o5G1COx56Xk2D/TyUHvQBcTkBQhgtJNcYeHKZ49tlxS6MQs4Yj3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFLOGDIt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFLOGDIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741290213; x=1772826213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uSAgVfCo5KVFOTRsUa3m7cbmhNpmCzSsNcxN18LgEpc=;
  b=QFLOGDIt/C82I523NUdxubBPungnB3bPuLrfxwPtrJ9g97DQlszi4gjz
   obtc9wh2GiuP0sBd38wVQ0ESK2DOhzJeRedf/foXAUTm4rSDYdH4OrvNS
   /7RLcKyk4D4rBKyVsDRfJ88BO+gQ4Hf3Fi1dTql+kKKcBnHaGlx41ou63
   xd2FUzITXTaaWnlMxbZVph1iRRMONjsrbZTyYDKJlDwt7mPjHl0JQOiYa
   uQn/BQrbhHKG4zKrrhYuoUvzEQZ+/B0q2NydIz5CRzL8uvTLh+kKwmlhg
   NNHELE33fKWHETjenXldVZ21IZj0hg7vOSFK0I0tFExMK6emc7PfRueAx
   g==;
X-CSE-ConnectionGUID: MnFyFOhURV2HVT3HfYSWbg==
X-CSE-MsgGUID: m9CV3QgZSvOilrWalh/Yxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46251879"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="46251879"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 11:43:32 -0800
X-CSE-ConnectionGUID: 9059ch23TpyKAt9YK1bwFA==
X-CSE-MsgGUID: DkWHg+WGSlmyYN6Wv+LEDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123300199"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.63])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 11:43:31 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Qing Huang <qing.huang@intel.com>
Subject: [RFC PATCH] cxl/region: Translate DPA->HPA in unaligned MOD3 regions
Date: Thu,  6 Mar 2025 11:43:26 -0800
Message-ID: <20250306194328.2600429-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Posting as an RFC because this adds support for a configuration that
is not CXL spec compliant.

The CXL driver implementation of DPA->HPA address translation depends
upon the spec defined requirement[1] that a regions starting address
will always be a multiple of the host bridge interleave ways. The CXL
driver implementation follows the decode methods defined in the CXL
Spec[2] and expanded upon in the CXL Driver Writers Guide[3].

A platform has presented with a CFMWS defined 3-way Host Bridge inter-
leave that breaks alignment in order to avoid gaps in the platform
memory layout and requires a new DPA->HPA decode.

This unaligned decode takes little from the existing method because
without alignment, bit manipulations cannot restore the position bits
to the correct location. Instead it reconstructs the HPA by breaking
the process into two steps: restore the address at the port level and
then at the host bridge level. (See in code comments)

Support is limited to 3,6,12 way region interleaves built upon 3-way
Host Bridge interleaves without switches. ie: 1+1+1 2+2+2 4+4+4+4

This method could be made to work for all configs, aligned or not.
Expanding for all configs at least requires rework of decode_pos()
and support for switches.

[1] CXL Spec 3.2 9-22 Interleave Target List Description
[2] CXL Spec 3.2 8.2.4.20.13 Implementation Note Device Decoder Logic
[3] CXL Type 3 Memory Software Guide 1.1 2.13.25 DPA to HPA Translation

Suggested-by: Qing Huang <qing.huang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

This patch is built upon cxl/next and is not dependent upon
cxl/region: Allow 6 & 12 way regions on 3-way HB interleaves
that is also in review on this list.

With this patch alone, 3-way unaligned regions can be translated.

cxl/test: Define a CFMWS capable of a 3 way HB interleave is also
on cxl/next and provides and unaligned 3-way CMFWS.


 drivers/cxl/core/region.c | 113 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8537b6a9ca18..411a108e87ad 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2883,13 +2883,112 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 	return false;
 }
 
+static int decode_pos(int region_ways, int pos, int *pos_port, int *pos_hb)
+{
+	switch (region_ways) {
+	/*
+	 * Extract the port and hb positions from an endpoint position.
+	 * Knowing there is only one possible decode** for each of these
+	 * regions, decode logic is:
+	 *	 3-way: port always 0, hb is pos
+	 *	 6-way: port cycles thru 0,1, hb increments every 2
+	 *	12-way: port cycles thru 0,1,2,3, hb increments every 4
+	 *
+	 *	**CXL Spec 3.2 9.13.1.1 Legal Interleaving Configurations
+	 */
+	case 3:
+		*pos_port = 0;
+		*pos_hb = pos;
+		break;
+	case 6:
+		*pos_port = pos % 2;
+		*pos_hb = pos / 2;
+		break;
+	case 12:
+		*pos_port = pos % 4;
+		*pos_hb = pos / 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * restore_parent() reconstructs the address in parent
+ *
+ * [mask] isolate the offset with the granularity
+ * [addr & ~mask] remove the offset leaving the aligned portion
+ * [* ways] distribute across all interleave ways
+ * [+ (pos * gran)] add the positional offset
+ * [+ (addr & mask)] restore the masked offset
+ */
+static u64 restore_parent(u64 addr, u64 pos, u64 gran, u64 ways)
+{
+	u64 mask = gran - 1;
+
+	return ((addr & ~mask) * ways) + (pos * gran) + (addr & mask);
+}
+
+/*
+ * unaligned_dpa_to_hpa() translates a DPA to HPA when the region resource
+ * start address is not a multiple of the Host Bridge interleave ways.
+ *
+ * Unaligned address translation is only supported for regions built upon
+ * 3-way HB interleaves, 1+1+1 2+2+2 4+4+4+4, and will fail on any other
+ * unaligned regions. ie. if a 4-way region appears with an unaligned start
+ * address it fails at the decode_pos().
+ */
+static u64 unaligned_dpa_to_hpa(struct cxl_decoder *cxld,
+				struct cxl_region_params *p, int pos, u64 dpa)
+{
+	int ways_port = p->interleave_ways / cxld->interleave_ways;
+	int gran_port = p->interleave_granularity;
+	int gran_hb = cxld->interleave_granularity;
+	int ways_hb = cxld->interleave_ways;
+	u64 hpa, hpa_port = 0;
+	int pos_port, pos_hb;
+
+	/* Decode an endpoint 'pos' into port and host-bridge components */
+	if (decode_pos(p->interleave_ways, pos, &pos_port, &pos_hb)) {
+		dev_dbg(&cxld->dev, "not supported for region ways:%d\n",
+			p->interleave_ways);
+		return ULLONG_MAX;
+	}
+	/* Restore the port parent address if needed */
+	/* This could also be 'if (region ways > 3)' for this limited soln */
+	if (gran_hb != gran_port)
+		hpa_port = restore_parent(dpa, pos_port, gran_port, ways_port);
+
+	/*
+	 * Complete the HPA reconstruction by restoring the address as if
+	 * each HB position is a candidate. Test against expected pos_hb
+	 * to confirm match.
+	 */
+	for (int index = 0; index < ways_hb; index++) {
+		hpa = restore_parent(hpa_port, index, gran_hb, ways_hb);
+		hpa += p->res->start;
+		if ((hpa / gran_hb) % ways_hb == pos_hb)
+			return hpa;
+	}
+
+	dev_dbg(&cxld->dev, "fail dpa:%#llx start:%#llx pos:%d\n", dpa,
+		p->res->start, pos);
+	dev_dbg(&cxld->dev, "     port-w/g/p:%d/%d/%d hb-w/g/p:%d/%d/%d\n",
+		ways_port, gran_port, pos_port, ways_hb, gran_hb, pos_hb);
+
+	return ULLONG_MAX;
+}
+
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
+	bool aligned;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -2902,6 +3001,14 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	if (!cxled || cxlmd != cxled_to_memdev(cxled))
 		return ULLONG_MAX;
 
+	aligned = (p->res->start % cxld->interleave_ways == 0);
+	if (!aligned) {
+		hpa = unaligned_dpa_to_hpa(cxld, p, cxled->pos, dpa);
+		if (hpa == ULLONG_MAX)
+			return ULLONG_MAX;
+
+		goto to_spa;
+	}
 	pos = cxled->pos;
 	ways_to_eiw(p->interleave_ways, &eiw);
 	granularity_to_eig(p->interleave_granularity, &eig);
@@ -2936,6 +3043,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
+to_spa:
 	/* Root decoder translation overrides typical modulo decode */
 	if (cxlrd->hpa_to_spa)
 		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
@@ -2946,8 +3054,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		return ULLONG_MAX;
 	}
 
-	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!cxlrd->hpa_to_spa && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	/* Chunk check applies to aligned modulo decodes only */
+	if (aligned && !cxlrd->hpa_to_spa &&
+	    !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
 		return ULLONG_MAX;
 
 	return hpa;

base-commit: 26600bf10173beda5358d194ec425a1cfafa2fe2
-- 
2.37.3

