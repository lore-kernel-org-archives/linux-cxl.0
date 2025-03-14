Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DA1F4275;
	Fri, 14 Mar 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952257; cv=none; b=LJ1uQMwssA4bg609gJ/qXewrFXi1l/0aBlHwGpN4urAstPl/RtOJZlEqZwi/uqCgq4veOcyjU5l7RDLIpFNFXSgehdTb0L2JAbI+eWANw28740GOBX09aMsVbM/4f9osWQr1SsWTwxA/DBudfwAGYLd+t2dXkYrFzn4fAE9s9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952257; c=relaxed/simple;
	bh=yoz7vzPBQbojGartel9sBsofEoAKwjMmDsSeksIb9GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IplClxpLyIYwsqMxLoZeVF/IeVzBmSQe3egtyLFgtNppBLu+xV+77C/4aK2iKcXpfxodsBWjw8MEHQbawm7Ic1BMFMiGAjHc9YvtgavM/Xx9T1xQ6GtCUWjyMh8D9ADbeyVb+izaFwohSK1nGM7d55nk6ULYd3zUQjotxp7zR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2IIDiFc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2IIDiFc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741952256; x=1773488256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yoz7vzPBQbojGartel9sBsofEoAKwjMmDsSeksIb9GQ=;
  b=k2IIDiFcFGEdY6ElxHBk+RSzYO0rszSE2FQ7JeabgLDKVozEUidmqtzk
   XLrX/IC5cH8SLYJwKAmlhhRaCO9ara3U35XutwwTOqMut8qEaf98v7Hox
   WdkMYJkj3CLuXF7PdHsVWbHwnNu9OlrB5dj+cJi6AXtQYgmbctKCAsqLJ
   GIxCIXy7bQ11bk5uzVgkXELcBclVkN4/h7PgVoPg5CS5GYP5FfHR7E46z
   gZuVfVJBJ8PcWKguEIlpO9wjF6VdvVL2c6jiQJX+LDUt1BNgNqZ5a8xtV
   LMYL4DBdtL5UqLCXq3QPEurQIt7T80ePhBzuvgs4eZiJ2UojXpYLWQQug
   w==;
X-CSE-ConnectionGUID: CGPBwaO5RDqnQpMvnJzgQA==
X-CSE-MsgGUID: TW290A5VTnu6NIDKJ/SypA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60497547"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60497547"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:36 -0700
X-CSE-ConnectionGUID: 43E+oxghRHSz+JHAHcb8lA==
X-CSE-MsgGUID: QTW9fdbJS1iCKa51OFgiSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121751415"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:31 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 3/4 v3] cxl/core: Enable Region creation on x86 with Low Memory Hole
Date: Fri, 14 Mar 2025 12:36:32 +0100
Message-ID: <20250314113708.759808-4-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
Physical Address (HPA) windows that are associated with each CXL Host
Bridge. Each window represents a contiguous HPA that may be interleaved
with one or more targets (CXL v3.1 - 9.18.1.3).

The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
memory to which systems cannot send transactions. In some cases the size
of that hole is not compatible with the CXL hardware decoder constraint
that the size is always aligned to 256M * Interleave Ways.

On those systems, BIOS publishes CFMWS which communicate the active System
Physical Address (SPA) ranges that map to a subset of the Host Physical
Address (HPA) ranges. The SPA range trims out the hole, and capacity in
the endpoint is lost with no SPA to map to CXL HPA in that hole.

In the early stages of CXL Regions construction and attach on platforms
with Low Memory Holes, cxl_add_to_region() fails and returns an error
because it can't find any CXL Window that matches a given CXL Endpoint
Decoder.

Detect a Low Memory Hole by comparing Root Decoders and Endpoint Decoders
ranges with the use of arch_match_{spa,region}() helpers.

Match Root Decoders and CXL Regions with corresponding CXL Endpoint
Decoders. Currently a Low Memory Holes would prevent the matching functions
to return true.

Construct CXL Regions with HPA range's end adjusted to the matching SPA.

Allow the attach target process to complete by allowing Regions to not
comply with alignment constraints (i.e., alignment to NIW * 256M rule).

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/Kconfig       |  5 ++++
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/region.c | 56 +++++++++++++++++++++++++++++++++------
 tools/testing/cxl/Kbuild  |  1 +
 4 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 205547e5543a..3bb282ef01df 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -139,6 +139,11 @@ config CXL_REGION
 
 	  If unsure say 'y'
 
+config CXL_ARCH_LOW_MEMORY_HOLE
+	def_bool y
+	depends on CXL_REGION
+	depends on X86
+
 config CXL_REGION_INVALIDATION_TEST
 	bool "CXL: Region Cache Management Bypass (TEST)"
 	depends on CXL_REGION
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 139b349b3a52..3dccd3c224f1 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,6 +17,7 @@ cxl_core-y += cdat.o
 cxl_core-y += acpi.o
 cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
+cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += lmh.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 97122d645cc1..9eb23ecedecf 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -13,6 +13,7 @@
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
+#include "lmh.h"
 
 /**
  * DOC: cxl core region
@@ -835,6 +836,8 @@ static int match_free_decoder(struct device *dev, const void *data)
 static bool region_res_match_cxl_range(const struct cxl_region_params *p,
 				       struct range *range)
 {
+	struct cxl_decoder *cxld;
+
 	if (!p->res)
 		return false;
 
@@ -843,8 +846,15 @@ static bool region_res_match_cxl_range(const struct cxl_region_params *p,
 	 * to be fronted by the DRAM range in current known implementation.
 	 * This assumption will be made until a variant implementation exists.
 	 */
-	return p->res->start + p->cache_size == range->start &&
-		p->res->end == range->end;
+	if (p->res->start + p->cache_size == range->start &&
+	    p->res->end == range->end)
+		return true;
+
+	cxld = container_of(range, struct cxl_decoder, hpa_range);
+	if (arch_match_region(p, cxld))
+		return true;
+
+	return false;
 }
 
 static int match_auto_decoder(struct device *dev, const void *data)
@@ -1760,6 +1770,7 @@ static int match_switch_decoder_by_range(struct device *dev,
 {
 	const struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
 	const struct range *r1, *r2;
 
 	if (!is_switch_decoder(dev))
@@ -1769,8 +1780,13 @@ static int match_switch_decoder_by_range(struct device *dev,
 	r1 = &cxlsd->cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 
-	if (is_root_decoder(dev))
-		return range_contains(r1, r2);
+	if (is_root_decoder(dev)) {
+		if (range_contains(r1, r2))
+			return 1;
+		cxlrd = to_cxl_root_decoder(dev);
+		if (arch_match_spa(cxlrd, cxled))
+			return 1;
+	}
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
@@ -1978,7 +1994,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	}
 
 	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
-	    resource_size(p->res)) {
+	    resource_size(p->res) && !arch_match_spa(cxlrd, cxled)) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s-size-%#llx * ways-%d + cache-%#llx != region-size-%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
@@ -3213,7 +3229,12 @@ static int match_root_decoder_by_range(struct device *dev,
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 
-	return range_contains(r1, r2);
+	if (range_contains(r1, r2))
+		return true;
+	if (arch_match_spa(cxlrd, cxled))
+		return true;
+
+	return false;
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
@@ -3230,8 +3251,12 @@ static int match_region_by_range(struct device *dev, const void *data)
 	p = &cxlr->params;
 
 	guard(rwsem_read)(&cxl_region_rwsem);
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		return 1;
+	if (p->res) {
+		if (p->res->start == r->start && p->res->end == r->end)
+			return 1;
+		if (arch_match_region(p, &cxled->cxld))
+			return 1;
+	}
 
 	return 0;
 }
@@ -3319,6 +3344,21 @@ static int __construct_region(struct cxl_region *cxlr,
 			 "Extended linear cache calculation failed rc:%d\n", rc);
 	}
 
+	/*
+	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
+	 * platform
+	 */
+	if (arch_match_spa(cxlrd, cxled)) {
+		dev_dbg(cxlmd->dev.parent, "(LMH) Resource (%s: %pr)\n",
+			dev_name(&cxled->cxld.dev), res);
+
+		arch_adjust_region_resource(res, cxlrd);
+
+		dev_dbg(cxlmd->dev.parent,
+			"(LMH) has been adjusted (%s: %pr)\n",
+			dev_name(&cxled->cxld.dev), res);
+	}
+
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
 		/*
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 4efcc0606bd6..3b3c24b1496e 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -64,6 +64,7 @@ cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-y += $(CXL_CORE_SRC)/acpi.o
 cxl_core-y += $(CXL_CORE_SRC)/ras.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
+cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += $(CXL_CORE_SRC)/lmh.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
-- 
2.48.1

