Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91902EDD6F;
	Tue, 18 Nov 2025 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495023; cv=none; b=nEL6BhIQbO+5qYJxTrnXr+qku/sYGpTUCnCazZd3Bm3Tkp2xP9aC64Lf7XHJ2jyFaSyqpNFeYpuBgO2otNNIIpYTqCQZTNvB2LPj4gUoGir7XmfW1knfsvVhFURlW0ANE7d35kgGKwslBTo6RAiQpqs1T9KAPBLrgznJl5yyejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495023; c=relaxed/simple;
	bh=0QfgrRUHg+jZDsY24Jn8NQtsGpk2ErSuCqlsE9TDYzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzMXScPOuIMHDdvLWPw520/sYo7k9L87Zu8JI6R+7iFbQLoej0WJdqYWMo3H3laFYJlM8qcsqzglZzJH0ynfX3tetXGew0RFHEhQ4pMPA237lqIl3VShpp7hENRRpZRXBxJLEuCJht/IrQcKskko0kFHfxKmA1Z4hf7SunMoPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEvYQ7Aa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEvYQ7Aa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763495021; x=1795031021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0QfgrRUHg+jZDsY24Jn8NQtsGpk2ErSuCqlsE9TDYzc=;
  b=QEvYQ7Aa0SBIcHg1hPIzvyzGkluumKoDNqLqX5K1J2Q+odXCTSN1hHOi
   fGcRTGvgmCmFEYFuRjC3Du804dvVc8JBt3Gl1pnVn4Ks9KFwFeG4qmoDu
   JgBSOvLjRyneMlB7JH+th0aABIhxWPtsPv5/1QyazEWooPUcjb4dw7fSn
   FFxipO+bx5HYpxSXUnqhmnk9YGfK1PlazC92CKeAvTQhYaw2tgJsNqfth
   4Ed8GRMcjwkuZaUKo/h0Qv78Oh/qmiLi2pRteEhT0pfkDQLakTudXP2iL
   svvcbHxiUuqw7HW2CHHRN7rcZHx9I0wV/pXICb3EzF6nbcPUwWz8lq8rx
   Q==;
X-CSE-ConnectionGUID: e0Q2jxojTkentmlooQHGVw==
X-CSE-MsgGUID: yj3w0k04Rs+pJq10vu5rAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76138704"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76138704"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:43:41 -0800
X-CSE-ConnectionGUID: yOcvvpNaRkGQ9mV9mG4POA==
X-CSE-MsgGUID: HYy05487Tn6dU6pzUp9iTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="228188893"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:43:36 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 2/4 v6] cxl/core: Add helpers to detect Low Memory Holes on x86
Date: Tue, 18 Nov 2025 20:43:04 +0100
Message-ID: <20251118194321.1773484-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118194321.1773484-1-fabio.m.de.francesco@linux.intel.com>
References: <20251118194321.1773484-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a x86 platform with a low memory hole (LMH), the BIOS may publish
CFMWS that describes a system physical address (SPA) range that
typically is only a subset of the corresponding CXL intermediate switch
and endpoint decoder's host physical address (HPA) ranges. The CFMWS
range never intersects the LHM and so the driver instantiates a root
decoder whose HPA range size doesn't fully contain the matching switch
and endpoint decoders' HPA ranges.[1]

To construct regions and attach decoders, the driver needs to match root
decoders and regions with endpoint decoders. The process fails and
returns errors because the driver is not designed to deal with SPA
ranges which are smaller than the corresponding hardware decoders HPA
ranges.

Introduce two functions that indirectly detect the presence of x86 LMH
and allow the matching between a root decoder or an already constructed
region with a corresponding intermediate switch or endpoint decoder to
enable the construction of a region and the subsequent attachment of the
same decoders to that region.

These functions return true when SPA/HPA misalignments due to LMH's are
detected under specific conditions:

- Both the SPA and HPA ranges must start at LMH_CFMWS_RANGE_START (i.e.,
  0x0 on x86 with LMH's).
- The SPA range's size is less than HPA's.
- The SPA range's size is less than 4G.
- The HPA range's size is aligned to the NIW * 256M rule.

Also introduce a function that adjusts the range end of a region to be
constructed and the DPA range's end of the endpoint decoders that will
be later attached to that region.

[1] commit c5dca38633da ("cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution")

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/Kconfig                |  11 +++
 drivers/cxl/core/Makefile          |   1 +
 drivers/cxl/core/platform_quirks.c | 103 +++++++++++++++++++++++++++++
 drivers/cxl/core/platform_quirks.h |  36 ++++++++++
 4 files changed, 151 insertions(+)
 create mode 100644 drivers/cxl/core/platform_quirks.c
 create mode 100644 drivers/cxl/core/platform_quirks.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..5ab8d5c23187 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -211,6 +211,17 @@ config CXL_REGION
 
 	  If unsure say 'y'
 
+config CXL_PLATFORM_QUIRKS
+	bool "CXL: Region Platform Quirks"
+	depends on CXL_REGION
+	help
+	  Enable support for the following platform quirks:
+
+		- Region creation / Endpoint Decoders attach in x86 with Low
+		  Memory Holes (Documentation/driver-api/cxl/conventions.rst).
+
+	  If unsure say 'y'
+
 config CXL_REGION_INVALIDATION_TEST
 	bool "CXL: Region Cache Management Bypass (TEST)"
 	depends on CXL_REGION
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 5ad8fef210b5..1684e46b8709 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,6 +17,7 @@ cxl_core-y += cdat.o
 cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += platform_quirks.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/platform_quirks.c b/drivers/cxl/core/platform_quirks.c
new file mode 100644
index 000000000000..be57b9666c9b
--- /dev/null
+++ b/drivers/cxl/core/platform_quirks.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2025 Intel Corporation
+
+#include <linux/range.h>
+#include "platform_quirks.h"
+#include "cxlmem.h"
+#include "core.h"
+
+/* Start of CFMWS range that end before x86 Low Memory Holes */
+#define LMH_CFMWS_RANGE_START 0x0ULL
+
+/**
+ * platform_cxlrd_matches_cxled() - Platform quirk to match CXL Root and
+ * Endpoint Decoders. It allows matching on platforms with LMH's.
+ * @cxlrd: The Root Decoder against which @cxled is tested for matching.
+ * @cxled: The Endpoint Decoder to be tested for matching @cxlrd.
+ *
+ * platform_cxlrd_matches_cxled() is typically called from the
+ * match_*_by_range() functions in region.c. It checks if an endpoint decoder
+ * matches a given root decoder and returns true to allow the driver to succeed
+ * in the construction of regions where it would otherwise fail for the presence
+ * of a Low Memory Hole (see Documentation/driver-api/cxl/conventions.rst).
+ *
+ * In x86 platforms with LMH's, the CFMWS ranges never intersect the LMH, the
+ * endpoint decoder's HPA range size is always guaranteed aligned to NIW*256MB
+ * and also typically larger than the matching root decoder's, and the root
+ * decoder's range end is at an address that is necessarily less than SZ_4G
+ * (i.e., the Hole is in Low Memory - this function doesn't deal with other
+ * kinds of holes).
+ *
+ * Return: true if an endpoint matches a root decoder, else false.
+ */
+bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+				  const struct cxl_endpoint_decoder *cxled)
+{
+	const struct range *rd_r, *sd_r;
+	int align;
+
+	rd_r = &cxlrd->cxlsd.cxld.hpa_range;
+	sd_r = &cxled->cxld.hpa_range;
+	align = cxled->cxld.interleave_ways * SZ_256M;
+
+	return rd_r->start == LMH_CFMWS_RANGE_START &&
+	       rd_r->start == sd_r->start &&
+	       rd_r->end < sd_r->end &&
+	       rd_r->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
+	       IS_ALIGNED(range_len(sd_r), align);
+}
+
+/**
+ * platform_region_matches_cxld() - Platform quirk to match a CXL Region and a
+ * Switch or Endpoint Decoder. It allows matching on platforms with LMH's.
+ * @p: Region Params against which @cxled is matched.
+ * @cxld: Switch or Endpoint Decoder to be tested for matching @p.
+ *
+ * Similar to platform_cxlrd_matches_cxled(), it matches regions and
+ * decoders on platforms with LMH's.
+ *
+ * Return: true if a Decoder matches a Region, else false.
+ */
+bool platform_region_matches_cxld(const struct cxl_region_params *p,
+				  const struct cxl_decoder *cxld)
+{
+	const struct range *r = &cxld->hpa_range;
+	const struct resource *res = p->res;
+	int align = cxld->interleave_ways * SZ_256M;
+
+	return res->start == LMH_CFMWS_RANGE_START &&
+	       res->start == r->start &&
+	       res->end < r->end &&
+	       res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
+	       IS_ALIGNED(range_len(r), align);
+}
+
+void platform_adjust_resources(struct resource *res,
+			       struct cxl_endpoint_decoder *cxled,
+			       const struct cxl_root_decoder *cxlrd,
+			       const struct device *region_dev)
+{
+	struct resource dpa_res_orig = *cxled->dpa_res;
+	u64 slice;
+
+	if (!platform_cxlrd_matches_cxled(cxlrd, cxled))
+		return;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+
+	/* Region resource will need a trim at first endpoint attach only */
+	if (res && res->end != cxlrd->res->end) {
+		dev_info(region_dev,
+			 "LMH Low memory hole trims region resource %pr to %pr)\n",
+			 res, cxlrd->res);
+		res->end = cxlrd->res->end;
+	}
+
+	/* Adjust the endpoint decoder DPA resource end */
+	slice = div_u64(resource_size(cxlrd->res), cxled->cxld.interleave_ways);
+	cxled->dpa_res->end = cxled->dpa_res->start + slice - 1;
+
+	dev_info(&cxled->cxld.dev,
+		 "LMH Low memory hole trims DPA resource %pr to %pr)\n",
+		 &dpa_res_orig, cxled->dpa_res);
+}
diff --git a/drivers/cxl/core/platform_quirks.h b/drivers/cxl/core/platform_quirks.h
new file mode 100644
index 000000000000..fce376232c16
--- /dev/null
+++ b/drivers/cxl/core/platform_quirks.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2025 Intel Corporation */
+
+#include "cxl.h"
+
+#ifdef CONFIG_CXL_PLATFORM_QUIRKS
+bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+				  const struct cxl_endpoint_decoder *cxled);
+bool platform_region_matches_cxld(const struct cxl_region_params *p,
+				  const struct cxl_decoder *cxld);
+void platform_adjust_resources(struct resource *res,
+			       struct cxl_endpoint_decoder *cxled,
+			       const struct cxl_root_decoder *cxlrd,
+			       const struct device *region_dev);
+#else
+static inline bool
+platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+			       const struct cxl_endpoint_decoder *cxled)
+{
+	return false;
+}
+
+static inline bool
+platform_region_matches_cxld(const struct cxl_region_params *p,
+			     const struct cxl_decoder *cxld)
+{
+	return false;
+}
+
+static inline void
+platform_adjust_resources(struct resource *res,
+			  struct cxl_endpoint_decoder *cxled,
+			  const struct cxl_root_decoder *cxlrd,
+			  const struct device *region_dev)
+{ }
+#endif /* CONFIG_CXL_PLATFORM_QUIRKS */
-- 
2.51.1

