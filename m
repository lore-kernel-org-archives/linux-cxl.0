Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5E2E5414;
	Thu, 24 Jul 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367116; cv=none; b=iodsUcTpf6nAS/lTk6r9OZPh/g7y1lPYFy5nJ098BZN3sdsius2F4gr/smE6PjLIxmAG4h6zTXJ0Nq/mZWCT+suMBjFr3mN0D8WQ+Rl6ONLS6SfFpND/1Kxzb8suR9Y3j+fkBqYM1v6cx6n/UUr34meR+ozkG/28I4/Ov4VnzeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367116; c=relaxed/simple;
	bh=5M5cMMIyVxTIneCLOuvT2muZq9GBRryiuEAUCSI2UD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCy/ipHl1lSnPhFrIVZmK7eMqkIHLQOLNunx5Ax2khcSwaIu/Dfh3gQkjsgGDz0RnrhWE9bDIPvf4YO/0xC9768sVi8WU8heTJ7IsJeIyLQfHOZNQ78OdbqAZ6iUJ7FHFDmtxRRlUt1jsT22dP6zSSqnGWdjLwAESxwURJj8Z4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KblPWyzL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KblPWyzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753367115; x=1784903115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5M5cMMIyVxTIneCLOuvT2muZq9GBRryiuEAUCSI2UD4=;
  b=KblPWyzLr8EcKaIo0VbvdMyHtiApNUFf1/GKAPLMZ4Qsfz/qaVA0QKaH
   646kR6k5TdyL/hE8xkBFSVFg9Ga0+vZY6A7jjgWNcs0NF6iTUkD4QR2gA
   uC/HQyj3jS9M6TRY4RMD5FtcG5c6VhtKbIYOwbEFqPaPXYEAXyV4TFF+q
   BzcC4S6J4QXm5E6vjZppgpqO9nlp42oG2zcEUxFFanzH2p6/uQEbg5Edc
   VDd2f+pkbdWoQUlF6SAWS7rREsOOxgBqvzwfUKmN62dD/uvIbEfNzOGQo
   JAL+KI1y6DgwwBwR837G+6Sq3NzA83Vql8Uhveu8c/6Uja7dUFqv0PoTI
   A==;
X-CSE-ConnectionGUID: ArE7QaDYRYmGpW0D4qtq6g==
X-CSE-MsgGUID: 9g7iVLBwThOY7VAlS6Xx/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66250252"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="66250252"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:25:14 -0700
X-CSE-ConnectionGUID: d+k6iEqBR8ypi2bGg3sprw==
X-CSE-MsgGUID: wCPW4++JSSeYD7Kj1LBqQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160245718"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.151])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:25:10 -0700
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
Subject: [PATCH 2/4 v4] cxl/core: Add helpers to detect Low Memory Holes on x86
Date: Thu, 24 Jul 2025 16:20:32 +0200
Message-ID: <20250724142144.776992-3-fabio.m.de.francesco@linux.intel.com>
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
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/Kconfig         |  5 +++
 drivers/cxl/core/Makefile   |  1 +
 drivers/cxl/core/platform.c | 85 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/platform.h | 32 ++++++++++++++
 4 files changed, 123 insertions(+)
 create mode 100644 drivers/cxl/core/platform.c
 create mode 100644 drivers/cxl/core/platform.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..eca90baeac10 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -211,6 +211,11 @@ config CXL_REGION
 
 	  If unsure say 'y'
 
+config CXL_PLATFORM_QUIRKS
+	def_bool y
+	depends on CXL_REGION
+	depends on X86
+
 config CXL_REGION_INVALIDATION_TEST
 	bool "CXL: Region Cache Management Bypass (TEST)"
 	depends on CXL_REGION
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79e2ef81fde8..4be729fb7d64 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -18,6 +18,7 @@ cxl_core-y += ras.o
 cxl_core-y += acpi.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += platform.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/platform.c b/drivers/cxl/core/platform.c
new file mode 100644
index 000000000000..8202750742d0
--- /dev/null
+++ b/drivers/cxl/core/platform.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/range.h>
+#include "platform.h"
+#include "cxlmem.h"
+#include "core.h"
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
+bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+				    const struct cxl_endpoint_decoder *cxled)
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
+/*
+ * Similar to platform_root_decoder_contains(), it matches regions and
+ * decoders
+ */
+bool platform_region_contains(const struct cxl_region_params *p,
+			      const struct cxl_decoder *cxld)
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
+void platform_res_adjust(struct resource *res,
+			 struct cxl_endpoint_decoder *cxled,
+			 const struct cxl_root_decoder *cxlrd)
+{
+	if (!platform_root_decoder_contains(cxlrd, cxled))
+		return;
+
+	guard(rwsem_write)(&cxl_dpa_rwsem);
+	dev_info(cxled_to_memdev(cxled)->dev.parent,
+		 "(LMH) Resources were (%s: %pr, %pr)\n",
+		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
+	if (res) {
+		/*
+		 * A region must be constructed with Endpoint Decoder's
+		 * HPA range end adjusted to Root Decoder's resource end
+		 */
+		res->end = cxlrd->res->end;
+	}
+	/*
+	 * The Endpoint Decoder's dpa_res->end must be adjusted with Root
+	 * Decoder's resource end
+	 */
+	cxled->dpa_res->end =
+		cxled->dpa_res->start +
+		resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;
+	dev_info(cxled_to_memdev(cxled)->dev.parent,
+		 "(LMH) Resources have been adjusted (%s: %pr, %pr)\n",
+		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
+}
diff --git a/drivers/cxl/core/platform.h b/drivers/cxl/core/platform.h
new file mode 100644
index 000000000000..0baa39938729
--- /dev/null
+++ b/drivers/cxl/core/platform.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include "cxl.h"
+
+#ifdef CONFIG_CXL_PLATFORM_QUIRKS
+bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+				    const struct cxl_endpoint_decoder *cxled);
+bool platform_region_contains(const struct cxl_region_params *p,
+			      const struct cxl_decoder *cxld);
+void platform_res_adjust(struct resource *res,
+			 struct cxl_endpoint_decoder *cxled,
+			 const struct cxl_root_decoder *cxlrd);
+#else
+static bool
+platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+			       const struct cxl_endpoint_decoder *cxled)
+{
+	return false;
+}
+
+static bool platform_region_contains(const struct cxl_region_params *p,
+				     const struct cxl_decoder *cxld)
+{
+	return false;
+}
+
+void platform_res_adjust(struct resource *res,
+			 struct cxl_endpoint_decoder *cxled,
+			 const struct cxl_root_decoder *cxlrd)
+{
+}
+#endif /* CONFIG_CXL_PLATFORM_QUIRKS */
-- 
2.50.1

