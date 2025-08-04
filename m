Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CD24167F
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294423; cv=none; b=SfC7ZGWKQ/D7DFpR49PzsmzgMOdAyW+ozeZjPXEJGcRDbBQ02aczMEGfKfpI2C3vK8IgIgk+T72lqAGQld3GatouBtduFUJKKg9oM3tVax3R7BxLzNf2IdwrOZr8430H9rPOHwer4hAHH7MpcyyVGIm+FjJz8vZlHQsnS/0aMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294423; c=relaxed/simple;
	bh=EKStetNTzjv+a1fbhsQiPisfkOi27PlgY7JGO1z8JQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNvFsnvIvvsunjXWybdV9X8Pt0RSibOZ1xGw3BYkS8/sT3D70p/h3WGllt0HHiSW5bsUmK73yaJ2JJhbYxvuRTgPsWkNXf5tjc3HWlpprJ0XKV6ztqfoEcmOCEgIFMO1JxcRjkv4ADdb90tRB5N1QW797SIxDk5EWlWBgCpLfdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oi37RZWJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oi37RZWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754294421; x=1785830421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EKStetNTzjv+a1fbhsQiPisfkOi27PlgY7JGO1z8JQE=;
  b=Oi37RZWJZRXEaw4laKbNnX7wKAkX6QX9nCcuIsbQ2hpLJfCRMkhCKESR
   nto6wFSmcwrQIJtqKJey6UT9UBPBqclNyZhJtL56fZJtYcI+15mmGP+AS
   c8eX3corf2uffEKyTX6p+sVGmOlTnd6HgdOTv0sJ497LJU6fmTeqzEaU5
   UOWjs8B+8mZtH0QhXOjFgU1voaYLUKILP9B5CLaS5vgOIIia4y+KnmaFr
   1pZCYlw/Pweknwibyy+gP4x0X9ulBiri+yYiHi8zJpDVKR3l8p8/M57pg
   VvXSq7nKqm/Ero9ridXp/a8blICwl+IS2rCFeq4zbpPQDsl1k12dIEqyB
   g==;
X-CSE-ConnectionGUID: 0r6lJ5OoSEeYtoaMYOAl0w==
X-CSE-MsgGUID: IBwdiLGXTfujvk0Yf4K3Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56474222"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56474222"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:00:21 -0700
X-CSE-ConnectionGUID: dZCmoopMRC2onyER3lGzyA==
X-CSE-MsgGUID: 1ed8dP0yQ5qf6fElVNcRLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168548831"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.77])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:00:21 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v5 2/5] cxl: Define a SPA->CXL HPA root decoder callback for XOR Math
Date: Mon,  4 Aug 2025 01:00:10 -0700
Message-ID: <79d9d72230c599cae94d7221781ead6392ae6d3f.1754290144.git.alison.schofield@intel.com>
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

When DPA->SPA translation was introduced, it included a helper that
applied the XOR maps to do the CXL HPA -> SPA translation for XOR
region interleaves. In preparation for adding SPA->DPA address
translation, introduce the reverse callback.

The root decoder callback is defined generically and not all usages
may be self inverting like this XOR function. Add another root decoder
callback that is the spa_to_hpa function.

Update the existing cxl_xor_hpa_to_spa() with a name that reflects
what it does without directionality: cxl_apply_xor_maps(), a generic
parameter: addr replaces hpa, and code comments stating that the
function supports the translation in either direction.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---

Changes in v5: none

 drivers/cxl/acpi.c | 27 ++++++++++++++++-----------
 drivers/cxl/cxl.h  |  2 ++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index b8d69460a368..f1625212b08b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -20,7 +20,7 @@ static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
-static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
+static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
 {
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
 	int hbiw = cxlrd->cxlsd.nr_targets;
@@ -29,19 +29,23 @@ static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
 
 	/* No xormaps for host bridge interleave ways of 1 or 3 */
 	if (hbiw == 1 || hbiw == 3)
-		return hpa;
+		return addr;
 
 	/*
-	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
-	 * the position bit to its value before the xormap was applied at
-	 * HPA->DPA translation.
+	 * In regions using XOR interleave arithmetic the CXL HPA may not
+	 * be the same as the SPA. This helper performs the SPA->CXL HPA
+	 * or the CXL HPA->SPA translation. Since XOR is self-inverting,
+	 * so is this function.
+	 *
+	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) applying the
+	 * xormaps will toggle a position bit.
 	 *
 	 * pos is the lowest set bit in an XORMAP
-	 * val is the XORALLBITS(HPA & XORMAP)
+	 * val is the XORALLBITS(addr & XORMAP)
 	 *
 	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
 	 * as an operation that outputs a single bit by XORing all the
-	 * bits in the input (hpa & xormap). Implement XORALLBITS using
+	 * bits in the input (addr & xormap). Implement XORALLBITS using
 	 * hweight64(). If the hamming weight is even the XOR of those
 	 * bits results in val==0, if odd the XOR result is val==1.
 	 */
@@ -50,11 +54,11 @@ static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
 		if (!cximsd->xormaps[i])
 			continue;
 		pos = __ffs(cximsd->xormaps[i]);
-		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
-		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
+		val = (hweight64(addr & cximsd->xormaps[i]) & 1);
+		addr = (addr & ~(1ULL << pos)) | (val << pos);
 	}
 
-	return hpa;
+	return addr;
 }
 
 struct cxl_cxims_context {
@@ -476,7 +480,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		if (!cxlrd->ops)
 			return -ENOMEM;
 
-		cxlrd->ops->hpa_to_spa = cxl_xor_hpa_to_spa;
+		cxlrd->ops->hpa_to_spa = cxl_apply_xor_maps;
+		cxlrd->ops->spa_to_hpa = cxl_apply_xor_maps;
 	}
 
 	rc = cxl_decoder_add(cxld, target_map);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index bb82777128a2..f87628a22852 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -421,9 +421,11 @@ struct cxl_root_decoder;
 /**
  * struct cxl_rd_ops - CXL root decoder callback operations
  * @hpa_to_spa: Convert host physical address to system physical address
+ * @spa_to_hpa: Convert system physical address to host physical address
  */
 struct cxl_rd_ops {
 	u64 (*hpa_to_spa)(struct cxl_root_decoder *cxlrd, u64 hpa);
+	u64 (*spa_to_hpa)(struct cxl_root_decoder *cxlrd, u64 spa);
 };
 
 /**
-- 
2.37.3

