Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23617BB21
	for <linux-cxl@vger.kernel.org>; Tue, 30 Sep 2025 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759205324; cv=none; b=Nx4odwT0edl8dM4Us2teSs05NPT0V4sZyh18lPB/TENksKDMDoDIsJy8cldTZ5mrP6DJ2i2Q2GLYsOjG3QIbtnGQU870wGL6DMeAedAWnDIGYAhiqJ5Ub8ERoYg+rvEhNILwoKPhZRjlebB/tzuUiYWHQkeBTEAyT+WzeKCsciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759205324; c=relaxed/simple;
	bh=bnmkkU0d2orLCCNwKxV+eOnO4kcbaF84unvK3HTQcO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+2vghLCzAaM5Q2N4vagorTWMmdFh9m7lD5B9S9D+w4gawjL3Kd7U4JePj01fHtHbHTaV/jSVv/CwciioZb2DS1eloVmvnn5fbLnc1wISTvzjQrhsjIO8Xj8YAa18neZXJtCSP0ONqTkU6kNSQlZB6xLW2+ggyooEr6JYfqEgH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJA9EjIA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJA9EjIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759205322; x=1790741322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bnmkkU0d2orLCCNwKxV+eOnO4kcbaF84unvK3HTQcO8=;
  b=gJA9EjIA9iIp1G5hvBrrOk5QCRZMxXM8yHB65S1IZZBMQQqCiR88mYXl
   0EbAnn0dGTax5WGY0WvONtQU1knQR2AfoJgTtLZiVlG4D+Us+9566wE4b
   jWWI1yAIB+OcNjYw0BCGFh8fNWheWR2I6gEL0uZq3bftj5C5bDIYEMfvS
   1Nc+KuZbc96fp48ztlumNRTzSN5mNVRceKub9eZMEc7+OuvbZjI9e3nx8
   QuGOXeh1mL2vmL8vvY4ryBlPVIh33XabP2+EWHv1wOc5TlYmUbTZuhRqt
   b55egFP9WvGggz3DaDLLd0JaFrr/vJp1rNRjvLAdKqf9ippCVJd5T5fh1
   g==;
X-CSE-ConnectionGUID: wLLFR/gLQh2Et+EqEm25iA==
X-CSE-MsgGUID: OxY2P7a8ThKni+LdEUEnYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72070878"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="72070878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 21:08:41 -0700
X-CSE-ConnectionGUID: M//b1KfTT0mqocRZ17wQ6Q==
X-CSE-MsgGUID: 1KfDtrhETEeL/TuXzcSQpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="209364085"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 21:08:41 -0700
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
Subject: [PATCH] cxl/region: Translate DPA->HPA in unaligned MOD3 regions
Date: Mon, 29 Sep 2025 21:08:36 -0700
Message-ID: <20250930040838.353229-1-alison.schofield@intel.com>
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

Changes in v1 (was RFC):
- Replace "/" with do_div() to quiet i386 build warning (lkp)
- Replace 'cxld->interleave_ways' with 'hbiw' for clarity
- Use div64_u64_rem() for alignment alignment
- Fix up a printk format specifier (lkp)
- Update code comments and commit log
- Rebase on v717-rc7

 drivers/cxl/core/region.c | 125 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d05248..4fc0d1450c2c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2918,13 +2918,115 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
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
+	if (decode_pos(p->interleave_ways, pos, &pos_port, &pos_hb)) {
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
-	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
+	u64 dpa_offset, rem, hpa_offset, bits_upper, mask_upper, hpa;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
+	int hbiw = cxld->interleave_ways;
+	bool aligned;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -2937,6 +3039,18 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	if (!cxled || cxlmd != cxled_to_memdev(cxled))
 		return ULLONG_MAX;
 
+	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+	div64_u64_rem(p->res->start, (u64)hbiw * SZ_256M, &rem);
+	aligned = (rem == 0);
+	if (!aligned) {
+		hpa = unaligned_dpa_to_hpa(cxld, p, cxled->pos, dpa_offset);
+		if (hpa == ULLONG_MAX)
+			return ULLONG_MAX;
+
+		hpa += p->cache_size;
+		goto to_spa;
+	}
+
 	pos = cxled->pos;
 	ways_to_eiw(p->interleave_ways, &eiw);
 	granularity_to_eig(p->interleave_granularity, &eig);
@@ -2951,9 +3065,6 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
 	 */
 
-	/* Remove the dpa base */
-	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
-
 	mask_upper = GENMASK_ULL(51, eig + 8);
 
 	if (eiw < 8) {
@@ -2971,6 +3082,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
+to_spa:
 	/* Root decoder translation overrides typical modulo decode */
 	if (cxlrd->hpa_to_spa)
 		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
@@ -2981,8 +3093,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		return ULLONG_MAX;
 	}
 
-	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!cxlrd->hpa_to_spa && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	/* Chunk check applies to aligned modulo decodes only */
+	if (aligned && !cxlrd->hpa_to_spa &&
+	    !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
 		return ULLONG_MAX;
 
 	return hpa;

base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
-- 
2.37.3

