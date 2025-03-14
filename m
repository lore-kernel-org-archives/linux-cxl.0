Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B421FDE1E;
	Fri, 14 Mar 2025 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952261; cv=none; b=JsY3XdSjDaFMpOqib56dMP87USnro2qWx8n8vH1rpiWiNqyuX0F8cDDqthv8IVi8UlMSuhGP2Gazf/+vbP8BOEgTkETwrC2Ge+LcsJ570HvNc3pU8Y1rEks4ty4bvQiazo+J8lrzvQs8213e6JAQMfqwgNVq8WctKwChX/Lb2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952261; c=relaxed/simple;
	bh=AAolH3eVvDN1fp3/Izn+Wkxmg1SmgxnM6q/6Ix3GxjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIBdzTprP3oJms5OXuqFrTG0R3Rh8EWAGG7PApE1ZYWT29EtdtD15fRFetEfV7YKeHkQupPDNiNxDpX9P7UYq2hqnysnFT5eenmr9hPOHOv4lJkKJdUoBQlrgBw413i9mMD5S0yqTOrX1aF9Ok2VfYNx6aHNUSOhp4xCRXBs7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UM0bpX4X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UM0bpX4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741952260; x=1773488260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAolH3eVvDN1fp3/Izn+Wkxmg1SmgxnM6q/6Ix3GxjU=;
  b=UM0bpX4XIm/QheDbSeU1IA5UX/1MId8fzZJ0EU3Vx/poGJz3VDVkcYlT
   R8JM1dq0+YzrjXG0G4Q9W7t3U+oWGM38w4r7RNAyakXI+kbsFnS6j/9L2
   D74/vNL75P7p3cT7mm6zNHUFbDMR4Pvl2Gx3YzyIz7Cm1D6f4AHqokULm
   lk8NEcpS/MuH8HgzdjpkEDDDTULl4RjOcPU55xnu9d2LK6eN8PS6SdzdX
   TCH2Tc/CyfHc8opoGtH3C3AFQQfVYjXgzQ9eBlT6qyJhCx1SjvK4VNyTP
   EQs+sCIRt8GeZNUtP+mCZcN9v/eWIyWcjIO9svZ29WHdDjwQl9HBO28Hd
   A==;
X-CSE-ConnectionGUID: geelo6IjTgSksA74vnTJWQ==
X-CSE-MsgGUID: 4gA7diRTRfmM58YH4debGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60497553"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60497553"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:40 -0700
X-CSE-ConnectionGUID: T+aokh08Rha7dGFGLp7JwA==
X-CSE-MsgGUID: /swWRN2qQMyVmmhXiLRz+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121751440"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:37 -0700
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
Subject: [PATCH 4/4 v3] cxl/test: Simulate an x86 Low Memory Hole for tests
Date: Fri, 14 Mar 2025 12:36:33 +0100
Message-ID: <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
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

Simulate an x86 Low Memory Hole for the CXL tests by changing the first
mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range sizes
to 1GB.

Since the auto-created region of cxl-test uses mock_cfmws[0], whose range
base address is typically different from the one published by the BIOS on
real hardware, the driver would fail to create and attach CXL Regions if
it was run on the mock environment created by cxl-tests.

Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match CXL
Root Decoders and Regions with Endpoint Decoders when the driver is run on
mock devices.

Since the auto-created region of cxl-test uses mock_cfmws[0], the
LMH path in the CXL Driver will be exercised every time the cxl-test
module is loaded. Executing unit test: cxl-topology.sh, confirms the
region created successfully with a LMH.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/lmh.c               | 35 ++++++++++++++++++++++++----
 drivers/cxl/core/lmh.h               |  2 ++
 tools/testing/cxl/cxl_core_exports.c |  2 ++
 tools/testing/cxl/test/cxl.c         | 10 ++++++++
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
index 2e32f867eb94..9c55670c1c84 100644
--- a/drivers/cxl/core/lmh.c
+++ b/drivers/cxl/core/lmh.c
@@ -1,11 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/range.h>
+#include <linux/pci.h>
+
 #include "lmh.h"
 
 /* Start of CFMWS range that end before x86 Low Memory Holes */
 #define LMH_CFMWS_RANGE_START 0x0ULL
 
+static u64 mock_cfmws0_range_start = ULLONG_MAX;
+
+void set_mock_cfmws0_range_start(const u64 start)
+{
+	mock_cfmws0_range_start = start;
+}
+
+static u64 get_cfmws_range_start(const struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return LMH_CFMWS_RANGE_START;
+
+	return mock_cfmws0_range_start;
+}
+
 /*
  * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
  *
@@ -19,14 +36,19 @@ bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
 		    const struct cxl_endpoint_decoder *cxled)
 {
 	const struct range *r1, *r2;
+	u64 cfmws_range_start;
 	int niw;
 
+	cfmws_range_start = get_cfmws_range_start(&cxled->cxld.dev);
+	if (cfmws_range_start == ULLONG_MAX)
+		return false;
+
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 	niw = cxled->cxld.interleave_ways;
 
-	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
-	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
+	if (r1->start == cfmws_range_start && r1->start == r2->start &&
+	    r1->end < (cfmws_range_start + SZ_4G) && r1->end < r2->end &&
 	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
 		return true;
 
@@ -40,9 +62,14 @@ bool arch_match_region(const struct cxl_region_params *p,
 	const struct range *r = &cxld->hpa_range;
 	const struct resource *res = p->res;
 	int niw = cxld->interleave_ways;
+	u64 cfmws_range_start;
+
+	cfmws_range_start = get_cfmws_range_start(&cxld->dev);
+	if (cfmws_range_start == ULLONG_MAX)
+		return false;
 
-	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
-	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
+	if (res->start == cfmws_range_start && res->start == r->start &&
+	    res->end < (cfmws_range_start + SZ_4G) && res->end < r->end &&
 	    IS_ALIGNED(range_len(r), niw * SZ_256M))
 		return true;
 
diff --git a/drivers/cxl/core/lmh.h b/drivers/cxl/core/lmh.h
index 16746ceac1ed..b6337120ee17 100644
--- a/drivers/cxl/core/lmh.h
+++ b/drivers/cxl/core/lmh.h
@@ -2,6 +2,8 @@
 
 #include "cxl.h"
 
+void set_mock_cfmws0_range_start(u64 start);
+
 #ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
 bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
 		    const struct cxl_endpoint_decoder *cxled);
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index f088792a8925..7b20f9fcf0d7 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
 #include "cxl.h"
+#include "lmh.h"
 
 /* Exporting of cxl_core symbols that are only used by cxl_test */
 EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
+EXPORT_SYMBOL_NS_GPL(set_mock_cfmws0_range_start, "CXL");
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 1c3336095923..8c69ce0a272f 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -9,6 +9,7 @@
 #include <linux/pci.h>
 #include <linux/mm.h>
 #include <cxlmem.h>
+#include <core/lmh.h>
 
 #include "../watermark.h"
 #include "mock.h"
@@ -212,7 +213,11 @@ static struct {
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
+#if defined(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE)
+			.window_size = SZ_256M * 3UL,
+#else
 			.window_size = SZ_256M * 4UL,
+#endif
 		},
 		.target = { 0 },
 	},
@@ -454,6 +459,7 @@ static int populate_cedt(void)
 			return -ENOMEM;
 		window->base_hpa = res->range.start;
 	}
+	set_mock_cfmws0_range_start(mock_cfmws[0]->base_hpa);
 
 	return 0;
 }
@@ -744,7 +750,11 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *port, *iter;
+#if defined(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE)
+	const int size = SZ_1G;
+#else
 	const int size = SZ_512M;
+#endif
 	struct cxl_memdev *cxlmd;
 	struct cxl_dport *dport;
 	struct device *dev;
-- 
2.48.1

