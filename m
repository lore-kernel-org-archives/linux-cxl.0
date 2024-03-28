Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6193DBBF
	for <linux-cxl@vger.kernel.org>; Thu, 28 Mar 2024 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600601; cv=none; b=aL48oFc4Yt8/6MVQyHHaW+Kc4oMVj6jBUqnZUEU88cgiA8XyfznQoGW6x5teT4aYJjvMkeKU5rmG7rGUm8+csQOa5jevWRPWaetmx9BUoq84VXijhi/n05tzHQZrQaaHIOYqHabU+BRmjKep84pQZReaw+ICEQISVmtboMP89ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600601; c=relaxed/simple;
	bh=3eklbBkaBKlcOyFU2RzNB7nlTYbRhn79qpW7bovy1PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2Wyt3jf+uTqbU4xJgs1PInvgzPZT27U6sZoUnwGAGn8ak0GXpqzJ3X4sptnwEu8aMt0lPrPicydYNJSlq5LZSD7DQkO7fBwlFEAGs20O1EQ9ElP0tlvVx9mYwtYAUzC+4glGQKUDAjqx8lqRmnRXD7d/FYsHbvc18Yz5flH3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrwEE/BJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrwEE/BJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711600600; x=1743136600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3eklbBkaBKlcOyFU2RzNB7nlTYbRhn79qpW7bovy1PE=;
  b=lrwEE/BJCl8SQQXttgTNZtNEsXLe13D4UT09Wv+ATPzoqkTgHlWJCSDv
   FoTuWSE6bFvJwcXOimwA8H3GTPR/Yg6fiBd4Gx62HpFSxWe3j9XGZ+VKq
   N27Ge96VumlBX08H3pUz1QuIsMrt7QBm1i1H9UZBZjAGahKaKTnhKGC7z
   GpWrQImVhkqNs5PYLBD8E+j5JHxMjRXbO+9j2nDHADEMWrFZUwmOm6EQa
   /BxcI4GDLLBOnIFcuM/yl9xXMPpOyJqGSmUHgIe+S/bLamN83cIMiaY2z
   1pKNpara0NncGw+rfG97z7IKj/+rAM5dTrKx71sSrY0TBcO14tT8y9rAY
   Q==;
X-CSE-ConnectionGUID: /vpwjH/wTV6qPUtFOMxXjg==
X-CSE-MsgGUID: pVXJqJsNTi6xyfGIfEkIMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10542215"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="10542215"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 21:36:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21184487"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.82.250])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 21:36:37 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/4] cxl/region: Move cxl_trace_hpa() work to the region driver
Date: Wed, 27 Mar 2024 21:36:31 -0700
Message-Id: <0174dc9414d4beb71828f66e173a8fcc4ebe76ab.1711598777.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711598777.git.alison.schofield@intel.com>
References: <cover.1711598777.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

This work belongs in the region driver as it is only useful with
CONFIG_CXL_REGION. Add stubs in core.h for when the region driver
is not built.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/core.h   |  7 +++
 drivers/cxl/core/region.c | 91 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.c  | 91 ---------------------------------------
 drivers/cxl/core/trace.h  |  2 -
 4 files changed, 98 insertions(+), 93 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 6ceba8037101..24454a1cb250 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -28,8 +28,15 @@ int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
+u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
+		  u64 dpa);
 
 #else
+static inline u64
+cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
+{
+	return ULLONG_MAX;
+}
 static inline
 struct cxl_region cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 {
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4b227659e3f8..45eb9c560fd6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2723,6 +2723,97 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	return ctx.cxlr;
 }
 
+static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int gran = p->interleave_granularity;
+	int ways = p->interleave_ways;
+	u64 offset;
+
+	/* Is the hpa within this region at all */
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_dbg(&cxlr->dev,
+			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
+		return false;
+	}
+
+	/* Is the hpa in an expected chunk for its pos(-ition) */
+	offset = hpa - p->res->start;
+	offset = do_div(offset, gran * ways);
+	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
+		return true;
+
+	dev_dbg(&cxlr->dev,
+		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
+
+	return false;
+}
+
+static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
+			  struct cxl_endpoint_decoder *cxled)
+{
+	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
+	struct cxl_region_params *p = &cxlr->params;
+	int pos = cxled->pos;
+	u16 eig = 0;
+	u8 eiw = 0;
+
+	ways_to_eiw(p->interleave_ways, &eiw);
+	granularity_to_eig(p->interleave_granularity, &eig);
+
+	/*
+	 * The device position in the region interleave set was removed
+	 * from the offset at HPA->DPA translation. To reconstruct the
+	 * HPA, place the 'pos' in the offset.
+	 *
+	 * The placement of 'pos' in the HPA is determined by interleave
+	 * ways and granularity and is defined in the CXL Spec 3.0 Section
+	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
+	 */
+
+	/* Remove the dpa base */
+	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+
+	mask_upper = GENMASK_ULL(51, eig + 8);
+
+	if (eiw < 8) {
+		hpa_offset = (dpa_offset & mask_upper) << eiw;
+		hpa_offset |= pos << (eig + 8);
+	} else {
+		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
+		bits_upper = bits_upper * 3;
+		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
+	}
+
+	/* The lower bits remain unchanged */
+	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
+
+	/* Apply the hpa_offset to the region base address */
+	hpa = hpa_offset + p->res->start;
+
+	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
+		return ULLONG_MAX;
+
+	return hpa;
+}
+
+u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
+		  u64 dpa)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled = NULL;
+
+	for (int i = 0; i <  p->nr_targets; i++) {
+		cxled = p->targets[i];
+		if (cxlmd == cxled_to_memdev(cxled))
+			break;
+	}
+	if (!cxled || cxlmd != cxled_to_memdev(cxled))
+		return ULLONG_MAX;
+
+	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
+}
+
 static struct lock_class_key cxl_pmem_region_key;
 
 static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
index d0403dc3c8ab..7f2a9dd0d0e3 100644
--- a/drivers/cxl/core/trace.c
+++ b/drivers/cxl/core/trace.c
@@ -6,94 +6,3 @@
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
-
-static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
-{
-	struct cxl_region_params *p = &cxlr->params;
-	int gran = p->interleave_granularity;
-	int ways = p->interleave_ways;
-	u64 offset;
-
-	/* Is the hpa within this region at all */
-	if (hpa < p->res->start || hpa > p->res->end) {
-		dev_dbg(&cxlr->dev,
-			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
-		return false;
-	}
-
-	/* Is the hpa in an expected chunk for its pos(-ition) */
-	offset = hpa - p->res->start;
-	offset = do_div(offset, gran * ways);
-	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
-		return true;
-
-	dev_dbg(&cxlr->dev,
-		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
-
-	return false;
-}
-
-static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
-			  struct cxl_endpoint_decoder *cxled)
-{
-	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
-	struct cxl_region_params *p = &cxlr->params;
-	int pos = cxled->pos;
-	u16 eig = 0;
-	u8 eiw = 0;
-
-	ways_to_eiw(p->interleave_ways, &eiw);
-	granularity_to_eig(p->interleave_granularity, &eig);
-
-	/*
-	 * The device position in the region interleave set was removed
-	 * from the offset at HPA->DPA translation. To reconstruct the
-	 * HPA, place the 'pos' in the offset.
-	 *
-	 * The placement of 'pos' in the HPA is determined by interleave
-	 * ways and granularity and is defined in the CXL Spec 3.0 Section
-	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
-	 */
-
-	/* Remove the dpa base */
-	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
-
-	mask_upper = GENMASK_ULL(51, eig + 8);
-
-	if (eiw < 8) {
-		hpa_offset = (dpa_offset & mask_upper) << eiw;
-		hpa_offset |= pos << (eig + 8);
-	} else {
-		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
-		bits_upper = bits_upper * 3;
-		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
-	}
-
-	/* The lower bits remain unchanged */
-	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
-
-	/* Apply the hpa_offset to the region base address */
-	hpa = hpa_offset + p->res->start;
-
-	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
-		return ULLONG_MAX;
-
-	return hpa;
-}
-
-u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *cxlmd,
-		  u64 dpa)
-{
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_endpoint_decoder *cxled = NULL;
-
-	for (int i = 0; i <  p->nr_targets; i++) {
-		cxled = p->targets[i];
-		if (cxlmd == cxled_to_memdev(cxled))
-			break;
-	}
-	if (!cxled || cxlmd != cxled_to_memdev(cxled))
-		return ULLONG_MAX;
-
-	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
-}
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e5f13260fc52..161bdb5734b0 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -642,8 +642,6 @@ TRACE_EVENT(cxl_memory_module,
 #define cxl_poison_overflow(flags, time)				\
 	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
 
-u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
-
 TRACE_EVENT(cxl_poison,
 
 	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
-- 
2.37.3

