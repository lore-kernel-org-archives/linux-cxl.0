Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872EC2E040A;
	Thu, 24 Jul 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367125; cv=none; b=N8dIxlrZPXESrJuJl1QCZusNdZcm4+ejmkbE8KnHR6AyJSsMFvmYysS1hBiZV7rjPJuj8fHwfRRSA6094+2OfZc9XepQ1dsccSFPPQN6HPikNYymGNgmcaGDnszYHqgjcgSTXpE82eSOKvswgW5BrnpPP4WzdVWkAIxe9GfAiT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367125; c=relaxed/simple;
	bh=cgmwb3mci90b/IZ5B6grKyUsc+NSsc/OSjiBfPuIC/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXqftFKr9i2utdA8EG1EwFzGhib+i/yBRFGXon7axMollGZbUv3vzX7ZXCiUIGKbR/kvSonj6H3qEi3YA4MMjacEFtTo5HEedisMwS8FSe/gVjxZx31lbtELF/nZhJsDIxJ+0lbVEEFPuhfpasCGaHemJNfEzeG0PrZptXwfN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvafLgFI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvafLgFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753367123; x=1784903123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cgmwb3mci90b/IZ5B6grKyUsc+NSsc/OSjiBfPuIC/E=;
  b=SvafLgFIf6aKWVfwgHKXxPiDCfayarBNb4KMIeT/8M/5GnTEMhEXlun4
   2G7dAfm74FnQRNCB7GN4YrgS6cd1rHZvKWh3v63/YBJBYBDC0EoBw0ex+
   UJYyEMYP93nlkpi9j3ThCelR4gRZhlPcoHqi9vwFEWBcNlvhMbk453PES
   Q4/Qgo1UP1TRqEVB6x40k3PTL8SIBJhazdrQzxvzP8ndW+jyzkn3ghwEu
   fGxCDqgYBTKm5vQxJx/fdOx1qZNQC2aqVpUnwcYiNtjyB9LAMkkWUHhWQ
   jOjPTotng85jlx3ALCM99Haj6InVrl4uAEOsgPy6MTzx5dgRytnhM9DT2
   A==;
X-CSE-ConnectionGUID: +xVY3sBFSPi+w8F9aKnWNA==
X-CSE-MsgGUID: IiUPlW6/SrOlHhR+PPlkdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66250265"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="66250265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:25:22 -0700
X-CSE-ConnectionGUID: Hu4B2kGKSaK7k1wfKFL3sQ==
X-CSE-MsgGUID: 85cqgE+BSmmr131X98nlhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160245764"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.151])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:25:18 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 3/4 v4] cxl/core: Enable Region creation on x86 with LMH
Date: Thu, 24 Jul 2025 16:20:33 +0200
Message-ID: <20250724142144.776992-4-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
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
fit with alignment constraints (i.e., alignment to NIW * 256M rule).

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 53 +++++++++++++++++++++++++++++++++------
 tools/testing/cxl/Kbuild  |  1 +
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f607e7f97184..b7fdf9c4393d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -12,6 +12,7 @@
 #include <linux/memory-tiers.h>
 #include <cxlmem.h>
 #include <cxl.h>
+#include "platform.h"
 #include "core.h"
 
 /**
@@ -834,6 +835,8 @@ static int match_free_decoder(struct device *dev, const void *data)
 static bool region_res_match_cxl_range(const struct cxl_region_params *p,
 				       struct range *range)
 {
+	struct cxl_decoder *cxld;
+
 	if (!p->res)
 		return false;
 
@@ -842,8 +845,15 @@ static bool region_res_match_cxl_range(const struct cxl_region_params *p,
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
+	if (platform_region_contains(p, cxld))
+		return true;
+
+	return false;
 }
 
 static int match_auto_decoder(struct device *dev, const void *data)
@@ -1763,6 +1773,7 @@ static int match_switch_and_ep_decoders(struct device *dev, const void *data)
 {
 	const struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
 	const struct range *r1, *r2;
 
 	if (!is_switch_decoder(dev))
@@ -1772,8 +1783,13 @@ static int match_switch_and_ep_decoders(struct device *dev, const void *data)
 	r1 = &cxlsd->cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 
-	if (is_root_decoder(dev))
-		return range_contains(r1, r2);
+	if (is_root_decoder(dev)) {
+		if (range_contains(r1, r2))
+			return 1;
+		cxlrd = to_cxl_root_decoder(dev);
+		if (platform_root_decoder_contains(cxlrd, cxled))
+			return 1;
+	}
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
@@ -1990,7 +2006,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	}
 
 	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
-	    resource_size(p->res)) {
+	    resource_size(p->res) && !platform_root_decoder_contains(cxlrd, cxled)) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s-size-%#llx * ways-%d + cache-%#llx != region-size-%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
@@ -3230,7 +3246,12 @@ static int match_root_and_ep_decoders(struct device *dev, const void *data)
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 
-	return range_contains(r1, r2);
+	if (range_contains(r1, r2))
+		return true;
+	if (platform_root_decoder_contains(cxlrd, cxled))
+		return true;
+
+	return false;
 }
 
 static struct cxl_decoder *
@@ -3277,8 +3298,12 @@ static int match_region_and_ep_decoder(struct device *dev, const void *data)
 	p = &cxlr->params;
 
 	guard(rwsem_read)(&cxl_region_rwsem);
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		return 1;
+	if (p->res) {
+		if (p->res->start == r->start && p->res->end == r->end)
+			return 1;
+		if (platform_region_contains(p, &cxled->cxld))
+			return 1;
+	}
 
 	return 0;
 }
@@ -3355,6 +3380,12 @@ static int __construct_region(struct cxl_region *cxlr,
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
 
+	/*
+	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
+	 * platform
+	 */
+	platform_res_adjust(res, cxled, cxlrd);
+
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
 	if (rc && rc != -EOPNOTSUPP) {
 		/*
@@ -3464,6 +3495,12 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 		cxl_find_region_by_range(cxlrd, cxled);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
+	else
+		/*
+		 * Adjust the Endpoint Decoder's dpa_res to fit the Region which
+		 * it has to be attached to
+		 */
+		platform_res_adjust(NULL, cxled, cxlrd);
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 31a2d73c963f..77e392c4b541 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -65,6 +65,7 @@ cxl_core-y += $(CXL_CORE_SRC)/ras.o
 cxl_core-y += $(CXL_CORE_SRC)/acpi.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
+cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += $(CXL_CORE_SRC)/platform.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
-- 
2.50.1

