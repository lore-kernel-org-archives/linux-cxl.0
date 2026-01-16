Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7974309DA5
	for <linux-cxl@vger.kernel.org>; Fri, 16 Jan 2026 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539547; cv=none; b=IZ4V2BYrUDPNQi+s8ePEjPaX3cCz7/kaEbgY8bVbjjwK8Aa9lm5vVLZYnTg1M1OKj6WFEky0ugl7znZrd/+M3rFx9MlkjQkUk+v+kGXDgYDRZ+WqxuHBADMWkEuhurYpvQvPtwInxGktT+OEXcFESHGOSr7SRaAXCWg7afMyANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539547; c=relaxed/simple;
	bh=patK062i567KVQwLc+9LUzQUIaNnCgcSZojqShENNpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6jyFsNHGQM2RUOpPf4B2FsXXyPtHgIc2wPo3Ph6hj/yT6bxZfUR0gRrYOchmDaP1oVP/ybA2XwS5bAiF6HKMNMRBw84a6DE5T39QmHSDZcOqGWSTvQc6NyGWat6mQAlxYhK6iBnaNwNr9TGi7WN8UsBYy1GoFbX+KkD+MQihSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJzhpDVV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJzhpDVV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768539544; x=1800075544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=patK062i567KVQwLc+9LUzQUIaNnCgcSZojqShENNpc=;
  b=MJzhpDVVqp1X57RDJEUALhf86wyaX3AtMpVqdxvAIKMWXO/1Rs3WJROL
   9WZTDmrOLLQDw2EGREYuaFE3KIriMpFE54wcv5NTYyOxyoCkVihEQvwNo
   DxxZK6AfYJJwHpvWS2Sr9b0BrplFKkPbCvC6dZDW+wpg3rrywrjxjJbOw
   QUN+c7xpT/8HrJFVs8rhooGt67tCzLzV5DEHq5a+JXVgDof5zflCLa7Kt
   RH2gpAs7YV/lWDbNUM5DcYd1GnQ0apzVX5I1I7Kz08WVzTtpHO2ZZ7R5J
   f4wwsDPMLUoSIUbfO5K5kyPLYUf8UTR774x+2FoImZIMI+jQ1pZ18Nj8z
   w==;
X-CSE-ConnectionGUID: XeXX6FWbSba/orEeuLG4gQ==
X-CSE-MsgGUID: 1tYj/GNcQr2vTLKVX5FJZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69750225"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="69750225"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 20:59:02 -0800
X-CSE-ConnectionGUID: U/ll6vLrR+S5Zltsrtr+gA==
X-CSE-MsgGUID: qTjMBBT5Ree4GV2g+5c/Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209289494"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.9])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 20:59:01 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Qing Huang <qing.huang@intel.com>
Subject: [PATCH v6 1/2] cxl/region: Translate DPA->HPA in unaligned MOD3 regions
Date: Thu, 15 Jan 2026 20:58:36 -0800
Message-ID: <e7c53215bf69f2ff1ae7e58bcc49ca387b7b0299.1768538962.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1768538962.git.alison.schofield@intel.com>
References: <cover.1768538962.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL driver implementation of DPA->HPA address translation depends
on a region's starting address always being aligned to Host Bridge
Interleave Ways * 256MB. The driver follows the decode methods
defined in the CXL Spec[1] and expanded upon in the CXL Driver Writers
Guide[2], which describe bit manipulations based on power-of-2
alignment to translate a DPA to an HPA.

With the introduction of MOD3 interleave way support, platforms may
create regions at starting addresses that are not power-of-2 aligned.
This allows platforms to avoid gaps in the memory map, but addresses
within those regions cannot be translated using the existing bit
manipulation method.

Introduce an unaligned translation method for DPA->HPA that
reconstructs an HPA by restoring the address first at the port level
and then at the host bridge level.

[1] CXL Spec 4.0 8.2.4.20.13 Implementation Note Device Decoder Logic
[2] CXL Type 3 Memory Software Guide 1.1 2.13.25 DPA to HPA Translation

Suggested-by: Qing Huang <qing.huang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 166 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 158 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae899f68551f..cdfa454b940d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3112,13 +3112,146 @@ u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig)
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_hpa_offset, "cxl_translate");
 
+static int decode_pos(int region_ways, int hb_ways, int pos, int *pos_port,
+		      int *pos_hb)
+{
+	int devices_per_hb;
+
+	/*
+	 * Decode for 3-6-12 way interleaves as defined in the CXL
+	 * Spec 4.0 9.13.1.1 Legal Interleaving Configurations.
+	 * Region creation should prevent invalid combinations but
+	 * sanity check here to avoid a silent bad decode.
+	 */
+	switch (hb_ways) {
+	case 3:
+		if (region_ways != 3 && region_ways != 6 && region_ways != 12)
+			return -EINVAL;
+		break;
+	case 6:
+		if (region_ways != 6 && region_ways != 12)
+			return -EINVAL;
+		break;
+	case 12:
+		if (region_ways != 12)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	/*
+	 * Each host bridge contributes an equal number of endpoints
+	 * that are laid out contiguously per host bridge. Modulo
+	 * selects the port within a host bridge and division selects
+	 * the host bridge position.
+	 */
+	devices_per_hb = region_ways / hb_ways;
+	*pos_port = pos % devices_per_hb;
+	*pos_hb = pos / devices_per_hb;
+
+	return 0;
+}
+
+/*
+ * restore_parent() reconstruct the address in parent
+ *
+ * This math, specifically the bitmask creation 'mask = gran - 1' relies
+ * on the CXL Spec requirement that interleave granularity is always a
+ * power of two.
+ *
+ * [mask]		isolate the offset with the granularity
+ * [addr & ~mask]	remove the offset leaving the aligned portion
+ * [* ways]		distribute across all interleave ways
+ * [+ (pos * gran)]	add the positional offset
+ * [+ (addr & mask)]	restore the masked offset
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
+ * start address is not aligned at Host Bridge Interleave Ways * 256MB.
+ *
+ * Unaligned start addresses only occur with MOD3 interleaves. All power-
+ * of-two interleaves are guaranteed aligned.
+ */
+static u64 unaligned_dpa_to_hpa(struct cxl_decoder *cxld,
+				struct cxl_region_params *p, int pos, u64 dpa)
+{
+	int ways_port = p->interleave_ways / cxld->interleave_ways;
+	int gran_port = p->interleave_granularity;
+	int gran_hb = cxld->interleave_granularity;
+	int ways_hb = cxld->interleave_ways;
+	int pos_port, pos_hb, gran_shift;
+	u64 hpa_port = 0;
+
+	/* Decode an endpoint 'pos' into port and host-bridge components */
+	if (decode_pos(p->interleave_ways, ways_hb, pos, &pos_port, &pos_hb)) {
+		dev_dbg(&cxld->dev, "not supported for region ways:%d\n",
+			p->interleave_ways);
+		return ULLONG_MAX;
+	}
+
+	/* Restore the port parent address if needed */
+	if (gran_hb != gran_port)
+		hpa_port = restore_parent(dpa, pos_port, gran_port, ways_port);
+	else
+		hpa_port = dpa;
+
+	/*
+	 * Complete the HPA reconstruction by restoring the address as if
+	 * each HB position is a candidate. Test against expected pos_hb
+	 * to confirm match.
+	 */
+	gran_shift = ilog2(gran_hb);
+	for (int position = 0; position < ways_hb; position++) {
+		u64 shifted, hpa;
+
+		hpa = restore_parent(hpa_port, position, gran_hb, ways_hb);
+		hpa += p->res->start;
+
+		shifted = hpa >> gran_shift;
+		if (do_div(shifted, ways_hb) == pos_hb)
+			return hpa;
+	}
+
+	dev_dbg(&cxld->dev, "fail dpa:%#llx region:%pr pos:%d\n", dpa, p->res,
+		pos);
+	dev_dbg(&cxld->dev, "     port-w/g/p:%d/%d/%d hb-w/g/p:%d/%d/%d\n",
+		ways_port, gran_port, pos_port, ways_hb, gran_hb, pos_hb);
+
+	return ULLONG_MAX;
+}
+
+static bool region_is_unaligned_mod3(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p = &cxlr->params;
+	int hbiw = cxld->interleave_ways;
+	u64 rem;
+
+	if (is_power_of_2(hbiw))
+		return false;
+
+	div64_u64_rem(p->res->start, (u64)hbiw * SZ_256M, &rem);
+
+	return (rem != 0);
+}
+
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 dpa_offset, hpa_offset, hpa;
+	bool unaligned = false;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -3132,15 +3265,32 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	if (!cxled)
 		return ULLONG_MAX;
 
-	pos = cxled->pos;
-	ways_to_eiw(p->interleave_ways, &eiw);
-	granularity_to_eig(p->interleave_granularity, &eig);
-
 	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+
+	/* Unaligned calc for MOD3 interleaves not hbiw * 256MB aligned */
+	unaligned = region_is_unaligned_mod3(cxlr);
+	if (unaligned) {
+		hpa = unaligned_dpa_to_hpa(cxld, p, cxled->pos, dpa_offset);
+		if (hpa == ULLONG_MAX)
+			return ULLONG_MAX;
+
+		goto skip_aligned;
+	}
+	/*
+	 * Aligned calc for all power-of-2 interleaves and for MOD3
+	 * interleaves that are aligned at hbiw * 256MB
+	 */
+	pos = cxled->pos;
+	ways_to_eiw(p->interleave_ways, &eiw);
+	granularity_to_eig(p->interleave_granularity, &eig);
+
 	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
 
 	/* Apply the hpa_offset to the region base address */
-	hpa = hpa_offset + p->res->start + p->cache_size;
+	hpa = hpa_offset + p->res->start;
+
+skip_aligned:
+	hpa += p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
 	if (cxlrd->ops.hpa_to_spa)
@@ -3151,9 +3301,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
 		return ULLONG_MAX;
 	}
-
-	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!cxlrd->ops.hpa_to_spa && !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
+	/* Chunk check applies to aligned modulo decodes only */
+	if (!unaligned && !cxlrd->ops.hpa_to_spa &&
+	    !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
 		return ULLONG_MAX;
 
 	return hpa;
-- 
2.37.3

