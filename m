Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BD29E110
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423336; cv=none; b=W+2ZTpZCpTeNdM8b+88ZpoVwHhxeh3jGG6iNNL7edO87ttsTu9Wic0V9iF5w4wbEQ+G+OvzxXFpQksf+2H9sd8wlZyfBTT1+naQkmhvVfK3M6UAu7uoi760DL5YbEJFG47y0FcbxNErhBuEGAzw3bdjK6TEv2vpIMA2wIxMiek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423336; c=relaxed/simple;
	bh=ZfAgczN9HIijHCqWmiqB7ta63CNx48t2hbIHy1x5FyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L89XfYKdTN1cFvinAJPBJFlKyLeJU051JNVR53DBYXMyb+Eumz4nXiOAaJ16Wh7wklTY/iZ0HdFoy07MeWDNrj67flsHTla8CYO54TvYCZsVjJvr/xDj1Cyfr0z4NxVPMWZmtM+rv5ef93n/AmnJn+6G7//WCwA0kSkSTmLEztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsUwt4ng; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsUwt4ng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760423335; x=1791959335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZfAgczN9HIijHCqWmiqB7ta63CNx48t2hbIHy1x5FyM=;
  b=jsUwt4ngRrCEF2rPMjJQbbSIO3+aUwC8c/GnS9Rjg2SQrEsf0B/pxzRR
   j4M//6MARxScCHyWUWAf43fXTZjT9cxsvTVbnlGcz7+jdRw27yRDpQeka
   IbPAnz8wWNCY6Q0joYA6/2tGUeDqr5WQ+eVZ0apW4TkXJqYFKYdELSQpD
   olCNFSMNJMl0hsxFFr6VEAml5d0/Ri61FsCs1cOaC576kVUPsqDOY+ivi
   6CDHGlKBTn83eylER/CmAwva2RTC0PVNc04sehfHFDam7NMc0MBjR9uZv
   7e4ang/oYfTJVf+pB8vwVUiHZtJstvlWQ8x7akOrM/FXjCPPn6/36J/ih
   w==;
X-CSE-ConnectionGUID: 2zHx2itQSi+5r0gnF8QmCw==
X-CSE-MsgGUID: izi0sl61TvWG+Fprt1D7EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62725630"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62725630"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 23:28:54 -0700
X-CSE-ConnectionGUID: 5I9FwDZASge2cGIlDq6dkg==
X-CSE-MsgGUID: 2V7qZYJtQbKPqx6M7jPlHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="180949045"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.105])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 23:28:53 -0700
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
Subject: [PATCH v2] cxl/region: Translate DPA->HPA in unaligned MOD3 regions
Date: Mon, 13 Oct 2025 23:28:48 -0700
Message-ID: <20251014062850.727428-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
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

[1] CXL Spec 3.2 8.2.4.20.13 Implementation Note Device Decoder Logic
[2] CXL Type 3 Memory Software Guide 1.1 2.13.25 DPA to HPA Translation

Suggested-by: Qing Huang <qing.huang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Add 6 and 12 Host Bridge interleaves to decode_pos() (Jonathan)
- Limit the unalignment check to MOD3 regions
- Move the cache_size increment to a single place 
- Updated some in code comments
- Rebase on v6.18-rc1 

Changes in v1 (was RFC):
- Replace "/" with do_div() to quiet i386 build warning (lkp)
- Replace 'cxld->interleave_ways' with 'hbiw' for clarity
- Use div64_u64_rem() for alignment alignment
- Fix up a printk format specifier (lkp)
- Update code comments and commit log
- Rebase on v6.17-rc7


 drivers/cxl/core/region.c | 147 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e14c1d305b22..3dc6f0ae9f19 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2934,13 +2934,124 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
 	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
 }
 
+static int decode_pos(int reg_ways, int hb_ways, int pos, int *pos_port,
+		      int *pos_hb)
+{
+	int devices_per_hb;
+
+	/*
+	 * Decode for 3-6-12 way interleaves as defined in the CXL
+	 * Spec 3.2 9.13.1.1 Legal Interleaving Configurations.
+	 */
+	switch (hb_ways) {
+	case 3: /* Supports 3-way, 6-way, or 12-way regions */
+		if (reg_ways != 3 && reg_ways != 6 && reg_ways != 12)
+			return -EINVAL;
+
+		devices_per_hb = reg_ways / 3;
+		break;
+
+	case 6: /* Supports 6-way or 12-way regions */
+		if (reg_ways != 6 && reg_ways != 12)
+			return -EINVAL;
+
+		devices_per_hb = reg_ways / 6;
+		break;
+
+	case 12: /* Supports 12-way regions */
+		if (reg_ways != 12)
+			return -EINVAL;
+
+		devices_per_hb = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+	/* Calculate port and host bridge positions */
+	*pos_port = pos % devices_per_hb;
+	*pos_hb = pos / devices_per_hb;
+
+	return 0;
+}
+
+/*
+ * restore_parent() reconstruct the address in parent
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
+	u64 shifted, hpa, hpa_port = 0;
+
+	/* Decode an endpoint 'pos' into port and host-bridge components */
+	if (decode_pos(p->interleave_ways, ways_hb, pos, &pos_port, &pos_hb)) {
+		dev_dbg(&cxld->dev, "not supported for region ways:%d\n",
+			p->interleave_ways);
+		return ULLONG_MAX;
+	}
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
+	for (int index = 0; index < ways_hb; index++) {
+		hpa = restore_parent(hpa_port, index, gran_hb, ways_hb);
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
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
+	int hbiw = cxld->interleave_ways;
+	bool aligned;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -2953,6 +3064,28 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	if (!cxled || cxlmd != cxled_to_memdev(cxled))
 		return ULLONG_MAX;
 
+	/* Remove the dpa base */
+	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+
+	/* Unaligned calc: MOD3 interleaves not hbiw * 256MB aligned */
+	if (!is_power_of_2(hbiw)) {
+		u64 rem;
+
+		div64_u64_rem(p->res->start, (u64)hbiw * SZ_256M, &rem);
+		aligned = (rem == 0);
+		if (!aligned)
+			hpa = unaligned_dpa_to_hpa(cxld, p, cxled->pos,
+						   dpa_offset);
+		if (hpa == ULLONG_MAX)
+			return ULLONG_MAX;
+
+		goto skip_aligned;
+	}
+
+	/*
+	 * Aligned calc: all power-of-2 interleaves and MOD3 interleaves
+	 * that are aligned at hbiw * 256MB
+	 */
 	pos = cxled->pos;
 	ways_to_eiw(p->interleave_ways, &eiw);
 	granularity_to_eig(p->interleave_granularity, &eig);
@@ -2967,9 +3100,6 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
 	 */
 
-	/* Remove the dpa base */
-	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
-
 	mask_upper = GENMASK_ULL(51, eig + 8);
 
 	if (eiw < 8) {
@@ -2985,7 +3115,10 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
 
 	/* Apply the hpa_offset to the region base address */
-	hpa = hpa_offset + p->res->start + p->cache_size;
+	hpa = hpa_offset + p->res->start;
+
+skip_aligned:
+	hpa += p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
 	if (has_hpa_to_spa(cxlrd))
@@ -2996,9 +3129,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
 		return ULLONG_MAX;
 	}
-
-	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	/* Chunk check applies to aligned modulo decodes only */
+	if (aligned && !has_hpa_to_spa(cxlrd) &&
+	    !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
 		return ULLONG_MAX;
 
 	return hpa;

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.37.3

