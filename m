Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD92D9494;
	Mon,  6 Oct 2025 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766349; cv=none; b=Q+KHvnGgIXyDJbYDsXRCum5cqcQphfiwMEp5cX3z0VDLXyeczemp2/xlqtt03wdiR7/FnQEL+yabAsmlQflQddxVyTgzl08Tng0xha/LiQ8hHrdeWsUAMzSSOzhVWrn6pfrjrb99Nao2Rg9diUR/orD8otfesH1295y7O2wdSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766349; c=relaxed/simple;
	bh=yBUM9OFJir9sKXcqYDtMwtTiT7jrTjmUM4oGbKvhxH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3QL744jhh/vVm+mwuLwSVtUuyLYmzJvoy0hh8QXPMd2+sMwCJnV8LHk17S47Ra6TSvKz1BzpxvIBap64dKWqf7h/WQsbkeM1xvfxsPqh3lpOTJyqdHhqn67UPRfLQEeM1NUKfsDAbrTS1nNqfRq/sANgxGxli3SjkxWit0/svA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYHHvwPk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYHHvwPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759766348; x=1791302348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yBUM9OFJir9sKXcqYDtMwtTiT7jrTjmUM4oGbKvhxH8=;
  b=HYHHvwPkyKloOc+kiaZdt34alpzCgDUqvNSHhWioblUss+QT4+bfCT0z
   J620Svc7/X5WskPodxDYhfhFn7ksMe4Z672EifDixF2NyQfL2QnPSdtB5
   d1MS9Wdm7ykWtRAQEPBv83Kh9j7KdC1mjn5zAkEhWlOuKLbtDFR0ydFFn
   LcdcPKlVZI9Zd9hexbPRq1KFEFJraN2haj1t6IubTRBzfGDrA8CjJfhNW
   konBqsZM66O2meQY4BOXhL0JaDHRksmFEMUfqhv4jqzH7gUL3R6l9BNxe
   qZzkkzcUTyJHpyOEMh3YjxsCqNSEkiKQMYQoVFoBHnMIpiriYF5Zm9ED5
   w==;
X-CSE-ConnectionGUID: YmS/laQsTKCrljiuGZfZjg==
X-CSE-MsgGUID: /sxzGT4xT/qjfHJVsrqemA==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61150589"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="61150589"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:59:03 -0700
X-CSE-ConnectionGUID: 7CLoz8tYSXSV1RsVmN4n2A==
X-CSE-MsgGUID: ckdc9OYuTV26PmTZErmryw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="185189616"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.245.98])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:58:58 -0700
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
Subject: [PATCH 3/4 v5] cxl/core: Enable Region creation on x86 with LMH
Date: Mon,  6 Oct 2025 17:58:06 +0200
Message-ID: <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>
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

The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
Host Physical Address (HPA) windows that are associated with each CXL
Host Bridge. Each window represents a contiguous HPA that may be
interleaved with one or more targets (CXL v3.2 - 9.18.1.3).

The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
memory to which systems cannot send transactions. In some case the size
of that hole is not compatible with the constraint that the CFMWS size
shall be multiple of Interleave Ways * 256 MB. (CXL v3.2 - Table 9-22).

On those systems, the BIOS publishes CFMWS which communicate the active
System Physical Address (SPA) ranges that map to a subset of the Host
Physical Address (HPA) ranges. The SPA range trims out the hole, and the
capacity in the endpoint is lost with no SPA to map to CXL HPA in that
hole.

In the early stages of CXL regions construction and attach on platforms
that have Low Memory Holes, cxl_add_to_region() fails and returns an
error for it can't find any CFMWS range that matches a given endpoint
decoder.

Detect an LMH by comparing root decoder and endpoint decoder range.
Match root decoders HPA range and constructed region with the
corresponding endpoint decoders. Construct CXL region with the end of
its HPA ranges end adjusted to the matching SPA and adjust the DPA
resource end of the hardware decoders to fit the region.  Allow the
attach target process to complete by allowing regions and decoders to
bypass the constraints that don't hold when an LMH is present.[1]

[1] commit 7a81173f3 ("cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution")

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 47 ++++++++++++++++++++++++++++++++-------
 tools/testing/cxl/Kbuild  |  1 +
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 43a854036202..9a499bfca23d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -14,6 +14,7 @@
 #include <linux/string_choices.h>
 #include <cxlmem.h>
 #include <cxl.h>
+#include "platform_quirks.h"
 #include "core.h"
 
 /**
@@ -841,6 +842,8 @@ static int match_free_decoder(struct device *dev, const void *data)
 static bool region_res_match_cxl_range(const struct cxl_region_params *p,
 				       struct range *range)
 {
+	struct cxl_decoder *cxld;
+
 	if (!p->res)
 		return false;
 
@@ -849,8 +852,13 @@ static bool region_res_match_cxl_range(const struct cxl_region_params *p,
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
+
+	return platform_region_matches_cxld(p, cxld);
 }
 
 static int match_auto_decoder(struct device *dev, const void *data)
@@ -1770,6 +1778,7 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
 {
 	const struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
 	const struct range *r1, *r2;
 
 	if (!is_switch_decoder(dev))
@@ -1779,8 +1788,13 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
 	r1 = &cxlsd->cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 
-	if (is_root_decoder(dev))
-		return range_contains(r1, r2);
+	if (is_root_decoder(dev)) {
+		if (range_contains(r1, r2))
+			return 1;
+		cxlrd = to_cxl_root_decoder(dev);
+		if (platform_cxlrd_matches_cxled(cxlrd, cxled))
+			return 1;
+	}
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
@@ -1997,7 +2011,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	}
 
 	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
-	    resource_size(p->res)) {
+	    resource_size(p->res) && !platform_cxlrd_matches_cxled(cxlrd, cxled)) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s-size-%#llx * ways-%d + cache-%#llx != region-size-%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
@@ -3357,7 +3371,8 @@ static int match_cxlrd_to_cxled_by_range(struct device *dev, const void *data)
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 
-	return range_contains(r1, r2);
+	return (range_contains(r1, r2)) ||
+		(platform_cxlrd_matches_cxled(cxlrd, cxled));
 }
 
 static struct cxl_decoder *
@@ -3406,8 +3421,12 @@ static int match_region_to_cxled_by_range(struct device *dev, const void *data)
 	p = &cxlr->params;
 
 	guard(rwsem_read)(&cxl_rwsem.region);
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		return 1;
+	if (p->res) {
+		if (p->res->start == r->start && p->res->end == r->end)
+			return 1;
+		if (platform_region_matches_cxld(p, &cxled->cxld))
+			return 1;
+	}
 
 	return 0;
 }
@@ -3479,6 +3498,12 @@ static int __construct_region(struct cxl_region *cxlr,
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
@@ -3588,6 +3613,12 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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
index 0d5ce4b74b9f..205f4c813468 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -61,6 +61,7 @@ cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-y += $(CXL_CORE_SRC)/ras.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
+cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += $(CXL_CORE_SRC)/platform_quirks.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
-- 
2.50.1

