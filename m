Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FB1CABA
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844094; cv=none; b=jUjnnpxJSEZ6eOZQ1YKpForKEO1EqzulhJhy/pfyNr1yOiYgf+i6936sDMqxhjrkyIzlxCd9HN6xWbnb5xIxnJpmH50rRs83BTDSk8XWdruib7a7nIPj4NqTzQJAuzKzCrsgb41BHIXuwMdSlkiwA+eVvdz6Y2/GxG1ngzNR214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844094; c=relaxed/simple;
	bh=yPYnKclMREVRLLUt2xYrlcYrMI1HGouYO5TgD/9AZYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3ojjxEm1pAeIRLRCFeWRcDoa+eJxfoozeXxXSHSW95BzWG3FDf0lXqRtMEwRs8BX7cotuWwWojF/Fqk3Ht1Rt7aaBHvCpxDv1XMmTERKvADI181po7QqBt9cQLsQigqZkWzBZQtYwg4a09SWFX93Y5+Q/lTogM9XX3GFN3r9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTzwBKyw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTzwBKyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713844092; x=1745380092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yPYnKclMREVRLLUt2xYrlcYrMI1HGouYO5TgD/9AZYU=;
  b=GTzwBKywbQfPL5/iNEbSFvef2ldSt6s7HBcXfkTMug1YCb0Of0BSVkKv
   6oijnVUJOBM/qWOfWyz6r+kUjmC3PnoElK5Qk9VgXD4L2t/SaqQYIvECX
   Wm+KvnhtRnMsjmroiAt/eeZdjDBmsArdOteqKCLIbM6xXdmFN+uN68yS2
   TU6J5JFF6xndK0gWUkJS2ihcVUHQb+jyxOSoQ7ZLg93cyxzhlVuOAjPxS
   /FmOa58oVtgb5mVxrydeuLGl/ydpPPVuA5Y8ep8o5GdecG+qL4b26ls3a
   X0RlFQOLMpNIPm2k4pTAZg3d2qfRl6oWUmy7auTh3UL93XiL4yQNlKPyc
   Q==;
X-CSE-ConnectionGUID: Z8G06JKUQf25lCDB3okOCg==
X-CSE-MsgGUID: p3SiSOL6QSuUGPma4RvCJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26925893"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26925893"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:48:10 -0700
X-CSE-ConnectionGUID: 7UJHRm/eTW+FcWS9sy13lg==
X-CSE-MsgGUID: RFVzn4FiSWGHeuCL6MkYcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28884703"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.73.120])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:48:10 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/4] cxl/region: Move cxl_trace_hpa() work to the region driver
Date: Mon, 22 Apr 2024 20:48:04 -0700
Message-Id: <9a7b3700f9ab84d7d0ea087b7e212c63850e41f9.1713842838.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713842838.git.alison.schofield@intel.com>
References: <cover.1713842838.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

This work belongs in the region driver as it is only useful with
CONFIG_CXL_REGION. Add a stub in core.h for when the region driver
is not built.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/core.h   |  7 +++
 drivers/cxl/core/region.c | 91 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.c  | 91 ---------------------------------------
 drivers/cxl/core/trace.h  |  2 -
 4 files changed, 98 insertions(+), 93 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 87008505f8a9..625394486459 100644
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
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
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

