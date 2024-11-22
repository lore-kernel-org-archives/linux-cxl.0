Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41631DF249;
	Fri, 22 Nov 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290781; cv=none; b=nm9aT2YLLMxkBzMAmGzl1zWVWnOSjzJ+Dqsp0miEYE/1+C8sPMrc9Q73bRpmWxVlzCtRCDQldWDiXqOYll9czu1gRQTfCFCv0p2/qQbE9AakROV+a3zWOkmJ1N7rvPJVLzjzI8B3uvPBpIq05lDwdykHuWRfbIZameZZ+bi6uHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290781; c=relaxed/simple;
	bh=Tv97rb3Wx7Y/dwrRBidIVVoKTBqtGZhoZigmZiNxHeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6evLHAvqEyIRiLlC0l3/gwmJvkyu7dBZsSoXmQOnRdJCGSVT0snCBbB+Bj2iieNPmDqtUn/pvarbnyDlRiK3ug2sqUHXSZPHfoNoVLNLioi47mmdA0eNtpjzrfsGahwbEbDrjaEdrc2mt/GhZuqeJYxXtWsUGsi6ihsizv4x0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHz+96LT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHz+96LT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732290780; x=1763826780;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Tv97rb3Wx7Y/dwrRBidIVVoKTBqtGZhoZigmZiNxHeU=;
  b=VHz+96LTgInXkSjL2hwP4CkUcZvi/wzLvCixD2g4sUT63khVPd7TMGQH
   /WtO58UIqORp2LKDeI2TD4H5ISqBflzhtwB7SSDMDu5LzGyEp+yPH/JI8
   YY0iNYrx0CXGuJ4t0ONH6S6YNVbpokCzzOWo4wEGU+ip3xynh/g9cI2Wt
   RTgYqFJUGeSPlaxtwJ+iI/1nk73aiV5Dv1nvlptl3JjhJ85sHgHHu/am2
   vRXW9tk8/Z/MCBNwOqxZWsZYnMgu2XllEUOOc/mcTOrIJ2omlPB+GWa7z
   +wZCLJj38QHs6WJKjyuMbZa+pcP4FuiSpw8sIcMhGFRZl2/OTTEYU4wuJ
   g==;
X-CSE-ConnectionGUID: 7vFjX6hxQBuXVwHeh/esTA==
X-CSE-MsgGUID: +1PE0fCmSLeQuY081nypxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32386583"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32386583"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:52:59 -0800
X-CSE-ConnectionGUID: DEkHqqV5R7aOoQEV8Hd6aw==
X-CSE-MsgGUID: CBLLCEdqQtGzU0/ka6Bc2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="91408778"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.64])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:52:55 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low Memory Hole
Date: Fri, 22 Nov 2024 16:51:53 +0100
Message-ID: <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
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

Detect Low Memory Holes by comparing Root Decoders and Endpoint Decoders
ranges: both must start at physical address 0 and end below 4 GB, while
the Root Decoder ranges end at lower addresses than the matching Endpoint
Decoders which instead must always respect the above-mentioned CXL hardware
decoders HPA alignment constraint.

Match misaligned CFMWS and CXL Regions with corresponding CXL Endpoint
Decoders if driver detects Low Memory Holes.

Construct CXL Regions with HPA range's end trimmed by matching SPA.

Allow the attach target process to complete by relaxing Decoder constraints
which would lead to failures.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/Kconfig       |  5 ++++
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/lmh.c    | 53 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++++++-------
 drivers/cxl/cxl.h         | 25 ++++++++++++++++++
 5 files changed, 130 insertions(+), 9 deletions(-)
 create mode 100644 drivers/cxl/core/lmh.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 876469e23f7a..07b87f217e59 100644
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
index 9259bcc6773c..6e80215e8444 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,4 +15,5 @@ cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
+cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += lmh.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
new file mode 100644
index 000000000000..da76b2a534ec
--- /dev/null
+++ b/drivers/cxl/core/lmh.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/range.h>
+#include "cxl.h"
+
+/* In x86 with memory hole, misaligned CFMWS range starts at 0x0 */
+#define MISALIGNED_CFMWS_RANGE_BASE 0x0
+
+/*
+ * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
+ *
+ * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
+ * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
+ * the given endpoint decoder HPA range size is always expected aligned and
+ * also larger than that of the matching root decoder
+ */
+bool arch_match_spa(struct cxl_root_decoder *cxlrd,
+		    struct cxl_endpoint_decoder *cxled)
+{
+	struct range *r1, *r2;
+	int niw;
+
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
+	niw = cxled->cxld.interleave_ways;
+
+	if (r1->start == MISALIGNED_CFMWS_RANGE_BASE &&
+	    r1->start == r2->start && r1->end < r2->end &&
+	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
+		return true;
+	return false;
+}
+
+/* Similar to arch_match_spa(), it matches regions and decoders */
+bool arch_match_region(struct cxl_region_params *p,
+		       struct cxl_decoder *cxld)
+{
+	struct range *r = &cxld->hpa_range;
+	struct resource *res = p->res;
+	int niw = cxld->interleave_ways;
+
+	if (res->start == MISALIGNED_CFMWS_RANGE_BASE &&
+	    res->start == r->start && res->end < r->end &&
+	    IS_ALIGNED(range_len(r), niw * SZ_256M))
+		return true;
+	return false;
+}
+
+void arch_trim_hpa_by_spa(struct resource *res,
+			  struct cxl_root_decoder *cxlrd)
+{
+	res->end = cxlrd->res->end;
+}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ac2c486c16e9..3cb5a69e9731 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -836,8 +836,12 @@ static int match_auto_decoder(struct device *dev, void *data)
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
@@ -1414,7 +1418,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		if (cxld->interleave_ways != iw ||
 		    cxld->interleave_granularity != ig ||
 		    cxld->hpa_range.start != p->res->start ||
-		    cxld->hpa_range.end != p->res->end ||
+		    (cxld->hpa_range.end != p->res->end &&
+		     !arch_match_region(p, cxld)) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
@@ -1726,6 +1731,7 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
 {
 	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
 	struct range *r1, *r2;
 
 	if (!is_switch_decoder(dev))
@@ -1735,8 +1741,13 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
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
 
@@ -1943,7 +1954,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	}
 
 	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
-	    resource_size(p->res)) {
+	    resource_size(p->res) && !arch_match_spa(cxlrd, cxled)) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
@@ -3199,7 +3210,13 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 
-	return range_contains(r1, r2);
+	if (range_contains(r1, r2))
+		return true;
+
+	if (arch_match_spa(cxlrd, cxled))
+		return true;
+
+	return false;
 }
 
 static int match_region_by_range(struct device *dev, void *data)
@@ -3217,8 +3234,12 @@ static int match_region_by_range(struct device *dev, void *data)
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
@@ -3270,6 +3291,22 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
+
+	/*
+	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
+	 * platform
+	 */
+	if (arch_match_spa(cxlrd, cxled)) {
+		struct range *range = &cxlrd->cxlsd.cxld.hpa_range;
+
+		arch_trim_hpa_by_spa(res, cxlrd);
+		dev_dbg(cxlmd->dev.parent,
+			"%s: Trim HPA (%s: %pr) by SPA (%s: %pr)\n",
+			__func__,
+			dev_name(&cxlrd->cxlsd.cxld.dev), range,
+			dev_name(&cxled->cxld.dev), hpa);
+	}
+
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
 		/*
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..a5ad4499381e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -902,6 +902,31 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
+bool arch_match_spa(struct cxl_root_decoder *cxlrd,
+		    struct cxl_endpoint_decoder *cxled);
+bool arch_match_region(struct cxl_region_params *p,
+		       struct cxl_decoder *cxld);
+void arch_trim_hpa_by_spa(struct resource *res,
+			  struct cxl_root_decoder *cxlrd);
+#else
+bool arch_match_spa(struct cxl_root_decoder *cxlrd,
+		    struct cxl_endpoint_decoder *cxled)
+{
+	return false;
+}
+
+bool arch_match_region(struct cxl_region_params *p,
+		       struct cxl_decoder *cxld)
+{
+	return false;
+}
+
+void arch_trim_hpa_by_spa(struct resource *res,
+			  struct cxl_root_decoder *cxlrd)
+{ }
+#endif /* CXL_ARCH_LOW_MEMORY_HOLE */
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
-- 
2.46.2

