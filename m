Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579272D9494;
	Mon,  6 Oct 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766341; cv=none; b=gJRrHFNWJvQq4HU9wnil+Y4J6wFrXtZJPlA1A6azDlKRjAO/ZfyhmuDZk4EVV2T3xvC5+ofMUmLqWRTf/Cx17dBt/3VlOSBAuG3eF4wRe+2QfWpCxwrqFvfIukJekXRlA+1W/IpdKB9cqTzCH/WLhikr7aoV8fYeh4UNGjFRx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766341; c=relaxed/simple;
	bh=xfZxBoXh41LQL83DNU0/RFHlC5XlyyDqch6/rPVAMhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M36P6PfIBGAqbSDVoWZ93QVjepX4L2qmALlFxPyvXZO6ZCHBGFLEgI7xvXUKl2xbgwqOEHcYBfkvi7lwqC4Jx2mtKSRD7dYSQEC+2ILPs/EOUap/b2z6s325drafLR0e5j9ehH10yRvWuswXdpAKVe9YpdcKrw6gUDscakP6w+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7rW0zS6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7rW0zS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759766340; x=1791302340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xfZxBoXh41LQL83DNU0/RFHlC5XlyyDqch6/rPVAMhU=;
  b=c7rW0zS6CNC/Cg8ghcu+n/tvN+k8aTJs7br4tm+usIXXQDEE/+q2j3vY
   FsFTbRg4Bl3Revv0Hpdi/5FSA8tmwFsClC0pHK3KxCoAscP26yrUkJyT/
   yUZCu4ZVXeJPkDB2pEYjhRAayzS8Up5ivtVs/87rOkz4LDXetwseaQZTY
   7Kts9U5NAwMvC+6AZ+bhM+e4zchmPkjzNwZJtsxpA1o0eLidjElUFUvQ/
   vqkttPHZurdJnD1THWEHuQs6hqE6senyFUhgcGN1y3B2WOsf0zPx/LMwk
   +aHjQ5/bcqcYbinb5vGDBXzOX7UfumDabKbUk/ATjkr/FBGbZkDUR/6sX
   w==;
X-CSE-ConnectionGUID: lvP+ACXRSfKDU8gRItEr1w==
X-CSE-MsgGUID: /CTncogSQa+aZarIl5H6gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61150572"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="61150572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:58:59 -0700
X-CSE-ConnectionGUID: RV/EO52JSVmHD8aK/S+RSA==
X-CSE-MsgGUID: +2Ep6JOWRQ6iATVAZLU3XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="185189594"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.245.98])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:58:53 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes on x86
Date: Mon,  6 Oct 2025 17:58:05 +0200
Message-ID: <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a x86 platform with a low memory hole (LHM), the BIOS may publish
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

[1] commit 7a81173f3 ("cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution")

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/Kconfig                |  4 ++
 drivers/cxl/core/Makefile          |  1 +
 drivers/cxl/core/platform_quirks.c | 99 ++++++++++++++++++++++++++++++
 drivers/cxl/core/platform_quirks.h | 33 ++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 drivers/cxl/core/platform_quirks.c
 create mode 100644 drivers/cxl/core/platform_quirks.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..03c0583bc9a3 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -211,6 +211,10 @@ config CXL_REGION
 
 	  If unsure say 'y'
 
+config CXL_PLATFORM_QUIRKS
+	def_bool y
+	depends on CXL_REGION
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
index 000000000000..7e76e392b1ae
--- /dev/null
+++ b/drivers/cxl/core/platform_quirks.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+	if (rd_r->start == LMH_CFMWS_RANGE_START &&
+	    rd_r->start == sd_r->start && rd_r->end < sd_r->end &&
+	    rd_r->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
+	    IS_ALIGNED(range_len(sd_r), align))
+		return true;
+
+	return false;
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
+	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
+	    res->end < r->end && res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
+	    IS_ALIGNED(range_len(r), align))
+		return true;
+
+	return false;
+}
+
+void platform_res_adjust(struct resource *res,
+			 struct cxl_endpoint_decoder *cxled,
+			 const struct cxl_root_decoder *cxlrd)
+{
+	if (!platform_cxlrd_matches_cxled(cxlrd, cxled))
+		return;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	dev_dbg(cxled_to_memdev(cxled)->dev.parent,
+		"Low Memory Hole detected. Resources were (%s: %pr, %pr)\n",
+		dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
+	if (res) {
+		/* Trim region resource overlap with LMH */
+		res->end = cxlrd->res->end;
+	}
+	/* Match endpoint decoder's DPA resource to root decoder's */
+	cxled->dpa_res->end =
+		cxled->dpa_res->start +
+		resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;
+	dev_info(cxled_to_memdev(cxled)->dev.parent,
+		 "Resources have been adjusted for LMH (%s: %pr, %pr)\n",
+		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
+}
diff --git a/drivers/cxl/core/platform_quirks.h b/drivers/cxl/core/platform_quirks.h
new file mode 100644
index 000000000000..a15592b4e90e
--- /dev/null
+++ b/drivers/cxl/core/platform_quirks.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include "cxl.h"
+
+#ifdef CONFIG_CXL_PLATFORM_QUIRKS
+bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+				  const struct cxl_endpoint_decoder *cxled);
+bool platform_region_matches_cxld(const struct cxl_region_params *p,
+				  const struct cxl_decoder *cxld);
+void platform_res_adjust(struct resource *res,
+			 struct cxl_endpoint_decoder *cxled,
+			 const struct cxl_root_decoder *cxlrd);
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
+inline void platform_res_adjust(struct resource *res,
+				struct cxl_endpoint_decoder *cxled,
+				const struct cxl_root_decoder *cxlrd)
+{
+}
+#endif /* CONFIG_CXL_PLATFORM_QUIRKS */
-- 
2.50.1

