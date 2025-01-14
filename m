Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517F20D51E;
	Tue, 14 Jan 2025 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886901; cv=none; b=Z1rG7pEukqAAVjOFZtkEgxcKFeuplsb3b070M6EZshR/hpESndi45b89Q6VMOPtYCA9sHE18/5ALQaA6GqGw9NdQ4uyK934fwaua989sqnBnBuX+INjTY1FcuHePftaTQ1COicSh8JgosvgWVeOiNbC1pyO0b9p7P5ZI3VCzbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886901; c=relaxed/simple;
	bh=2aKty44xiRVvvM3/8cgVtjinfhkxhp4f4neBBgaazo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8yWSl5DnK+QdOh489wgtOE6whQyMPpAQRaU0s0gKvG/j/dppscNAs/kmoylYz9/MpfAnfB77HkPD3icl7DHNg9ncP4rtGLiBir8yHJwFfOSWxm7qz74qRn1MmXh56yUlZGEewsk3j0ei/KXvfl0JF9kBCHgTdx8+P11yFXcfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Byo/608A; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Byo/608A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736886900; x=1768422900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2aKty44xiRVvvM3/8cgVtjinfhkxhp4f4neBBgaazo0=;
  b=Byo/608AAVQ77FK5Bf5YtTG+h2pHq/uf10SCa0ayzxh0KFO3QFKjDPpf
   AtZw2ZteKuwXdps6vQgKJ880t2bLHwtqa4/JwoXi686CbJY6W5nFz5nmS
   oWmUs8g7yFRSxuDr9AL93uuAuIiWZd4tbZRwyuBE3RZ1UrYVjX+GcFNyy
   T1jxmbZl49aXs3p7T83qYjwQWffSLXl+7e5Guu+eyTqKrzWsV5jqSTmd3
   Xu1KZq4QcgbPCobYYpEYWaKDcqn/MHM9uw40nI0G4/o6cP7kjGHR1a+lC
   pQlErU9J2pzMzb9YdaV28RdTUpHdrSYXDBJoOXMeaB+ClffF7CliXXv1l
   Q==;
X-CSE-ConnectionGUID: 2dcGoYQNQjSTZq/FBQCJKA==
X-CSE-MsgGUID: DVmGn6quSgW7tLXFVjzLFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47693543"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="47693543"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:35:00 -0800
X-CSE-ConnectionGUID: /1zPZ45wRK6FTS1gR++xBw==
X-CSE-MsgGUID: 2olffc/YT3WxEEQRd5LBEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="135751372"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.88])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:34:55 -0800
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
Subject: [PATCH 3/4 v2] cxl/core: Enable Region creation on x86 with Low Memory Hole
Date: Tue, 14 Jan 2025 21:32:55 +0100
Message-ID: <20250114203432.31861-4-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
References: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
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
 drivers/cxl/core/region.c | 56 ++++++++++++++++++++++++++++++++-------
 tools/testing/cxl/Kbuild  |  1 +
 4 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 876469e23f7a7..07b87f217e590 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -128,6 +128,11 @@ config CXL_REGION
 
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
index 9259bcc6773c8..6e80215e8444f 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,4 +15,5 @@ cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
+cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += lmh.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9d2c31f5caf26..b25e48da17d53 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -13,6 +13,7 @@
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
+#include "lmh.h"
 
 /**
  * DOC: cxl core region
@@ -836,8 +837,12 @@ static int match_auto_decoder(struct device *dev, void *data)
 	cxld = to_cxl_decoder(dev);
 	r = &cxld->hpa_range;
 
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		return 1;
+	if (p->res) {
+		if (p->res->start == r->start && p->res->end == r->end)
+			return 1;
+		if (arch_match_region(p, cxld))
+			return 1;
+	}
 
 	return 0;
 }
@@ -1425,7 +1430,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		if (cxld->interleave_ways != iw ||
 		    cxld->interleave_granularity != ig ||
 		    cxld->hpa_range.start != p->res->start ||
-		    cxld->hpa_range.end != p->res->end ||
+		    (cxld->hpa_range.end != p->res->end &&
+		     !arch_match_region(p, cxld)) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
@@ -1737,6 +1743,7 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
 {
 	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
 	struct range *r1, *r2;
 
 	if (!is_switch_decoder(dev))
@@ -1746,8 +1753,13 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
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
 
@@ -1954,7 +1966,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	}
 
 	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
-	    resource_size(p->res)) {
+		    resource_size(p->res) &&
+	    !arch_match_spa(cxlrd, cxled)) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
@@ -3204,7 +3217,12 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
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
 
 static int match_region_by_range(struct device *dev, void *data)
@@ -3222,8 +3240,12 @@ static int match_region_by_range(struct device *dev, void *data)
 	p = &cxlr->params;
 
 	down_read(&cxl_region_rwsem);
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		rc = 1;
+	if (p->res) {
+		if (p->res->start == r->start && p->res->end == r->end)
+			rc = 1;
+		if (arch_match_region(p, &cxled->cxld))
+			rc = 1;
+	}
 	up_read(&cxl_region_rwsem);
 
 	return rc;
@@ -3275,6 +3297,22 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
+
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
index b1256fee3567f..fe9c4480f7583 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -62,6 +62,7 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
+cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += $(CXL_CORE_SRC)/lmh.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
-- 
2.47.1

