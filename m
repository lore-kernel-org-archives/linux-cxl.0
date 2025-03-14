Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3191FECD3;
	Fri, 14 Mar 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952251; cv=none; b=BEEF1E6Hy+N0F+W+sDRIhkCRjnTRR8/rd3uzpHnOWerDce8oysPi2i/WKBVCyMmNRZsQMYw7JbKep/K0UnKitCHobIHCEf1grsdT5zGa+hnL8Vg/HHTB+w7pddrnxjjyvPLOEg2yjVeUFG2dmtDpm4GQiyk04FcG86AWCXKvO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952251; c=relaxed/simple;
	bh=xFmXCrFJnBeTXVCGrGod6OfzDR52YhQH2+7EW6pQWD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeijW0HqJTNEC2hXgazC/lP9zdU4f/lfefzK9S+YpGkCoKJ4ECKsJixEzZi8BnUsf6M6u2jQ9GiiLklj0KtT1iLRYtSEeDXSqIOGXsqfKl1o2y+ibAPihfzG1iXWZJJl+YJh3RS9X+kx96c4I/SHHGd2td5Cn7xtaMIWE1Yz4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEvACrQC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEvACrQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741952250; x=1773488250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFmXCrFJnBeTXVCGrGod6OfzDR52YhQH2+7EW6pQWD4=;
  b=mEvACrQCbu86YfUivy1C6kjuS9A6jkFvljq7bdd0iWFlDM6ywlME6umc
   LcT/jHtYPGrcvhNNraBr80TGjCz5fXY85XBsU+uH116kAlsmULWJnWt9G
   3ogKJAnnBok6gFhYeofh1YiFoVz4p+/8Q42mQu5lzuJ+oZlz9QL38VE9Z
   uH30Q+cK4WaxzMieZlpVXhN3O6oZRQrXbXXqaMGiHq2U1/2B8hwj5Mg2S
   RUnmD5OgBRZgOxOiYiXbDInd0IkcSBHQ3bbmQd8G6SWvWJdtHE1vkcjqJ
   Gpieeax/hq/Abt1AAIW/yNG8TRIWIxTZAoX2fOmp63UucTNXAALcua2Kk
   Q==;
X-CSE-ConnectionGUID: azSWlBAKTwWGD2FB66XCuw==
X-CSE-MsgGUID: A7+ff1E3RQ25nql82AzotQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60497541"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60497541"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:30 -0700
X-CSE-ConnectionGUID: DqKcZS1LQjejBNG5JHNDDA==
X-CSE-MsgGUID: Flfjf3aoSkuP2oCsNCcLwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121751407"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:26 -0700
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
Subject: [PATCH 2/4 v3] cxl/core: Add helpers to detect Low memory Holes on x86
Date: Fri, 14 Mar 2025 12:36:31 +0100
Message-ID: <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
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

In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe
SPA ranges which are subsets of the corresponding CXL Endpoint Decoders
HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
ranges are always guaranteed to align to the NIW * 256M rule.

In order to construct Regions and attach Decoders, the driver needs to
match Root Decoders and Regions with Endpoint Decoders, but it fails and
the entire process returns errors because it doesn't expect to deal with
SPA range lengths smaller than corresponding HPA's.

Introduce functions that indirectly detect x86 LMH's by comparing SPA's
with corresponding HPA's. They will be used in the process of Regions
creation and Endpoint attachments to prevent driver failures in a few
steps of the above-mentioned process.

The helpers return true when HPA/SPA misalignments are detected under
specific conditions: both the SPA and HPA ranges must start at
LMH_CFMWS_RANGE_START (that in x86 with LMH's is 0x0), SPA range sizes
be less than HPA's, SPA's range's size be less than 4G, HPA's size be
aligned to the NIW * 256M rule.

Also introduce a function to adjust the range end of the Regions to be
created on x86 with LMH's.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/lmh.c | 56 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/lmh.h | 29 ++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 drivers/cxl/core/lmh.c
 create mode 100644 drivers/cxl/core/lmh.h

diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
new file mode 100644
index 000000000000..2e32f867eb94
--- /dev/null
+++ b/drivers/cxl/core/lmh.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/range.h>
+#include "lmh.h"
+
+/* Start of CFMWS range that end before x86 Low Memory Holes */
+#define LMH_CFMWS_RANGE_START 0x0ULL
+
+/*
+ * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
+ *
+ * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
+ * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
+ * the given endpoint decoder HPA range size is always expected aligned and
+ * also larger than that of the matching root decoder. If there are LMH's,
+ * the root decoder range end is always less than SZ_4G.
+ */
+bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
+		    const struct cxl_endpoint_decoder *cxled)
+{
+	const struct range *r1, *r2;
+	int niw;
+
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
+	niw = cxled->cxld.interleave_ways;
+
+	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
+	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
+	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
+		return true;
+
+	return false;
+}
+
+/* Similar to arch_match_spa(), it matches regions and decoders */
+bool arch_match_region(const struct cxl_region_params *p,
+		       const struct cxl_decoder *cxld)
+{
+	const struct range *r = &cxld->hpa_range;
+	const struct resource *res = p->res;
+	int niw = cxld->interleave_ways;
+
+	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
+	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
+	    IS_ALIGNED(range_len(r), niw * SZ_256M))
+		return true;
+
+	return false;
+}
+
+void arch_adjust_region_resource(struct resource *res,
+				 struct cxl_root_decoder *cxlrd)
+{
+	res->end = cxlrd->res->end;
+}
diff --git a/drivers/cxl/core/lmh.h b/drivers/cxl/core/lmh.h
new file mode 100644
index 000000000000..16746ceac1ed
--- /dev/null
+++ b/drivers/cxl/core/lmh.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include "cxl.h"
+
+#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
+bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
+		    const struct cxl_endpoint_decoder *cxled);
+bool arch_match_region(const struct cxl_region_params *p,
+		       const struct cxl_decoder *cxld);
+void arch_adjust_region_resource(struct resource *res,
+				 struct cxl_root_decoder *cxlrd);
+#else
+static bool arch_match_spa(struct cxl_root_decoder *cxlrd,
+			   struct cxl_endpoint_decoder *cxled)
+{
+	return false;
+}
+
+static bool arch_match_region(struct cxl_region_params *p,
+			      struct cxl_decoder *cxld)
+{
+	return false;
+}
+
+static void arch_adjust_region_resource(struct resource *res,
+					struct cxl_root_decoder *cxlrd)
+{
+}
+#endif /* CXL_ARCH_LOW_MEMORY_HOLE */
-- 
2.48.1

