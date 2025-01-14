Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB220CCC5;
	Tue, 14 Jan 2025 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886896; cv=none; b=ZxTNg6SET7CzjA8WQyfsdA2oSEX//JhcISgjRPt1xi8hTe7iazRCjCXIOnjfh93aMY36+92+w9w//EGasmjgvT/t27TcslsuR6SFWcCH3E0MjRpPqzA6PqQmbEbCD+gakYVp5s5fp39RQWEezNWwI1Xy4H9IuYW+CxjkFbcvkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886896; c=relaxed/simple;
	bh=UMYJZN/yNBUypCwr4Ub6K9pfLsSa0lKo6t07HsBmrWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P43zIxnOcIdRQj7SU7VZMPNIa1UTlDiMMh3c+oKy+Pvnf98En/LXqsBTuWe35j5GJgX3HGMnaYKktUnHKJLT4g/GjTMH7Hhf7etRvKG9TtmbFrkcTQkpM7zqJHdp2ywUlRmfCi8pU7akCSCkkARumPXhGK7eSdXw3sJHK0dHI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngWBtoA0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngWBtoA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736886895; x=1768422895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UMYJZN/yNBUypCwr4Ub6K9pfLsSa0lKo6t07HsBmrWw=;
  b=ngWBtoA0aticns3lPWGVsxxW6an1OXyjZOglCTw6IVmzzjDfYhrN5py6
   ooEInPKQ8Nz0pBZ/IIH7zjclWyjwvRpcIa/kwsrHL9JeKg9bnCGyxhhML
   3dRPt0/+j2wuzNi2BckTJ9CE2eyMQoJVwrzKWgKfVVQCiksD736bwPpwj
   V59Z7e/Q9/q6cSDFIPaFYejXnNhSdkZHzSBi3PqQDwzuw4Lgh1beU94zF
   3gCBhLS7sTuXlQ/lIQa6rW87TOSjxrDjcwqZDTjUJ9rqwRQsgkxqqQtKf
   i+VxS/Um0COmWI56Hc5vl2ISGYK65hx0eUMFaE33y1BVred+w4lVLk4q/
   A==;
X-CSE-ConnectionGUID: XGnuulIVT9mp5s5k83ut+A==
X-CSE-MsgGUID: a8v5m0MHSCit6OSMzvkOeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47693530"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="47693530"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:34:55 -0800
X-CSE-ConnectionGUID: pgHeC8jFS4aIYQ1kjDZMCQ==
X-CSE-MsgGUID: H6ttqjfZSXauxtxSN36Csg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="135751354"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.88])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:34:50 -0800
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
Subject: [PATCH 2/4 v2] cxl/core: Add helpers to detect Low memory Holes on x86
Date: Tue, 14 Jan 2025 21:32:54 +0100
Message-ID: <20250114203432.31861-3-fabio.m.de.francesco@linux.intel.com>
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
 drivers/cxl/core/lmh.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/lmh.h | 28 +++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 drivers/cxl/core/lmh.c
 create mode 100644 drivers/cxl/core/lmh.h

diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
new file mode 100644
index 0000000000000..232ebea0a8364
--- /dev/null
+++ b/drivers/cxl/core/lmh.c
@@ -0,0 +1,55 @@
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
+	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
+	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
+	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
+		return true;
+
+	return false;
+}
+
+/* Similar to arch_match_spa(), it matches regions and decoders */
+bool arch_match_region(struct cxl_region_params *p, struct cxl_decoder *cxld)
+{
+	struct range *r = &cxld->hpa_range;
+	struct resource *res = p->res;
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
index 0000000000000..ec8907145afe8
--- /dev/null
+++ b/drivers/cxl/core/lmh.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include "cxl.h"
+
+#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
+bool arch_match_spa(struct cxl_root_decoder *cxlrd,
+		    struct cxl_endpoint_decoder *cxled);
+bool arch_match_region(struct cxl_region_params *p, struct cxl_decoder *cxld);
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
2.47.1

