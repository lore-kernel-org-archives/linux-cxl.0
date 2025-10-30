Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BB29CE1
	for <linux-cxl@vger.kernel.org>; Thu, 30 Oct 2025 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761794131; cv=none; b=KQzM/MMMF4Uz3i6j/VNLELSHE5gkXnoXAzIsGqexK0Ix9uBJNqgsi0HKgY72A1M5O7nwJW9Wgyg4uciDkcB/hEq/170RWTvXcri/gidfACZeU6ZY2P0ukOnZIYoylpYYZXe2Obp4Z8xNMSwH3K0axX4XX1Wm/Sd4ixbI6s5GVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761794131; c=relaxed/simple;
	bh=uQep6K6qmUatOGAX/IrH6Jij6Sm682+ia9iDCM1qk0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFx6k6jncs+OVytkrxzcj1p7yntiPhg9+upYd2SIZ4bo0R0579BPt4OI+7RduwNIbk8Ez5q1YdRiXtGpMGQbZ5fChycRmIOXavxqonv/zpE+L9XYmpCWLa4Th5JlQfh1U66GA0KHyHvYykZjd2CrZczmQDTkz+h0kjI1n1TAJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmaUEKz7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmaUEKz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761794131; x=1793330131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uQep6K6qmUatOGAX/IrH6Jij6Sm682+ia9iDCM1qk0M=;
  b=fmaUEKz76RaswmLNyXN5Lkz4IDOCRuXgh5CB7Bm91YIbi4hdenYdkXuv
   3a9hO9adRXHWVWu/IheyFIVJgHwHezE6zOr4gbRYsl4uAUBgG4deM/3iG
   KjSobdenNzTa/rn4fTfCvfDmWH7hYcr0Tp0M+KzQolyc1pV1O32Imod8M
   Lo5WzQ6fb4eci2hhS+R0GsOGkosenjbnf8CX2eH0xYeLZQA3oWl7mXynP
   L2c/QI5r154tdBf/a4HL+/UjeQ/5tkn0Hj6c3b2totWbSUuupsfx7pAQQ
   d+VAwOlFdk6RDBsd01Gy3eTAikcxA6fTb7k7TeSql6hMDBUucSccoiYz9
   A==;
X-CSE-ConnectionGUID: BzLbF6gtT7mhNzzH72bdig==
X-CSE-MsgGUID: dxnuX6oMTB++THMZQa1u7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67579732"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="67579732"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 20:15:29 -0700
X-CSE-ConnectionGUID: fvnhNh7nT9ehWaRGB/culQ==
X-CSE-MsgGUID: jB7Tv9rbT7eCuCBahqoLwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216497293"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.174])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 20:15:27 -0700
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
Subject: [PATCH v3] cxl/region: Translate DPA->HPA in unaligned MOD3 regions
Date: Wed, 29 Oct 2025 20:15:21 -0700
Message-ID: <20251030031523.1252791-1-alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v3:
- Add bracketing to avert possibly uninitialized usage (lkp)
- Remove excessive narration in decode_pos()  (Jonathan)
- Calculate devices_per_hb only once after switch in decode_pos() (Jonathan)
- Reduce scope of hpa and shifted in unaligned_dpa_to_hpa() (Jonathan)
- Unmix non- and assignment declarations in unaligned_dpa_to_hpa()  (Jonathan)
- Add blank line after return ULLONG_MAX in unaligned_dpa_to_hpa() (Jonathan)
- s/index/position in for loop in unaligned_dpa_to_hpa() (Jonathan)
- Initialize bool aligned true
- Comment that restore_parent() math relies on power-of-2 granularity
- Tidy-up the restore_parent() comment block

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

 drivers/cxl/core/region.c | 148 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 141 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..e5f9adb9e1d6 100644
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
+	case 3:
+		if (reg_ways != 3 && reg_ways != 6 && reg_ways != 12)
+			return -EINVAL;
+		break;
+	case 6:
+		if (reg_ways != 6 && reg_ways != 12)
+			return -EINVAL;
+		break;
+	case 12:
+		if (reg_ways != 12)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	/* Calculate port and host bridge positions */
+	devices_per_hb = reg_ways / hb_ways;
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
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
+	int hbiw = cxld->interleave_ways;
+	bool aligned = true;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -2953,6 +3064,29 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
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
+		if (!aligned) {
+			hpa = unaligned_dpa_to_hpa(cxld, p, cxled->pos,
+						   dpa_offset);
+			if (hpa == ULLONG_MAX)
+				return ULLONG_MAX;
+
+			goto skip_aligned;
+		}
+	}
+
+	/*
+	 * Aligned calc: all power-of-2 interleaves and MOD3 interleaves
+	 * that are aligned at hbiw * 256MB
+	 */
 	pos = cxled->pos;
 	ways_to_eiw(p->interleave_ways, &eiw);
 	granularity_to_eig(p->interleave_granularity, &eig);
@@ -2967,9 +3101,6 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
 	 */
 
-	/* Remove the dpa base */
-	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
-
 	mask_upper = GENMASK_ULL(51, eig + 8);
 
 	if (eiw < 8) {
@@ -2985,7 +3116,10 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
 
 	/* Apply the hpa_offset to the region base address */
-	hpa = hpa_offset + p->res->start + p->cache_size;
+	hpa = hpa_offset + p->res->start;
+
+skip_aligned:
+	hpa += p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
 	if (has_hpa_to_spa(cxlrd))
@@ -2996,9 +3130,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
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

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.37.3

