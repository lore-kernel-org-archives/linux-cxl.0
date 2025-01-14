Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81B1459FD;
	Tue, 14 Jan 2025 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886727; cv=none; b=F071GBIUKdhP8VjhNSuTTrb6uGLOkobxGB6Cbb8JrW92r9w3wJyTfLaJV51eDA8Z0fRooxY7cjeI46s4zZRlGoWBRINYovIl2R/qvPsItzljKAmtdSxzhOBzW56YFukGQsR0Bia+Ibogau7fb0s6ttAA79NI89e55TJnJCGJUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886727; c=relaxed/simple;
	bh=/APxzXDFKLv/4MMx+aCv6YJHiEB/aU+KzNUx3IBKBME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jW7sylbmBuxZRjbeVvgk9++/ywMEL3Mgi7E0DicKMjAgD4GgFWX0GRCSaVKpITj5WvWx1/0UmZSj6a80zDoPxTSaa6r60HDqwwRo+HoNFUklCe8FXfFBPB4gez7nxUnGwCsHw9FqwXnJsn/7GH5o+rIjviqcfN8rwBvXYyjd46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gM8D+lpI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gM8D+lpI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736886726; x=1768422726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/APxzXDFKLv/4MMx+aCv6YJHiEB/aU+KzNUx3IBKBME=;
  b=gM8D+lpIa4DcTXmowohw/245X9ZiRKKD1AS+8jeAskYooArKCkrAW4UR
   KpV9fz9D66n4rf4xjzbQdh9cgHRA8vH2T3iKD1Qp6+//GkXd9Xar3410+
   m2NYa+99ZqDdOjHf8bx/AyZrllCbhdf2dacEca9eKXDA7RqVoyjSgiasd
   Yn/6U8u58wBMVx6ENKM7g2sYGnzrC8cSkjyMd9Cdg/m+foBOxxyaim185
   lfgm22A1SYSPB4QzA9Uq+H990lEjOofOASK3IwIrm1kCZCXGZsEOio8GP
   N6/B57w9RxPOg1AzDplIiZUV/15ZJFBniMB+frwi4omqUOwFLnUsLWHfA
   A==;
X-CSE-ConnectionGUID: cIys1L7JRFa8ENn9WgKNHA==
X-CSE-MsgGUID: Fkb39rmWRLecir+JfrguDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54621510"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="54621510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:32:06 -0800
X-CSE-ConnectionGUID: dNu+neEfTeutzsI53D+VXA==
X-CSE-MsgGUID: 0ScvnQB0TsOwNVdL+7TDbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142184225"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.88])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:32:02 -0800
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
Subject: [PATCH 4/4] cxl/test: Simulate an x86 Low Memory Hole for tests
Date: Tue, 14 Jan 2025 21:31:04 +0100
Message-ID: <20250114203136.31704-5-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114203136.31704-1-fabio.m.de.francesco@linux.intel.com>
References: <20250114203136.31704-1-fabio.m.de.francesco@linux.intel.com>
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
 drivers/cxl/core/lmh.c               | 32 +++++++++++++++++++++++++---
 drivers/cxl/core/lmh.h               |  2 ++
 tools/testing/cxl/cxl_core_exports.c |  2 ++
 tools/testing/cxl/test/cxl.c         | 10 +++++++++
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
index 232ebea0a8364..b981aeea805d6 100644
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
+void set_mock_cfmws0_range_start(u64 start)
+{
+	mock_cfmws0_range_start = start;
+}
+
+static u64 get_cfmws_range_start(struct device *dev)
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
@@ -18,9 +35,14 @@
 bool arch_match_spa(struct cxl_root_decoder *cxlrd,
 		    struct cxl_endpoint_decoder *cxled)
 {
+	u64 cfmws_range_start;
 	struct range *r1, *r2;
 	int niw;
 
+	cfmws_range_start = get_cfmws_range_start(&cxled->cxld.dev);
+	if (cfmws_range_start == ULLONG_MAX)
+		return false;
+
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 	r2 = &cxled->cxld.hpa_range;
 	niw = cxled->cxld.interleave_ways;
@@ -36,13 +58,17 @@ bool arch_match_spa(struct cxl_root_decoder *cxlrd,
 /* Similar to arch_match_spa(), it matches regions and decoders */
 bool arch_match_region(struct cxl_region_params *p, struct cxl_decoder *cxld)
 {
+	u64 cfmws_range_start;
 	struct range *r = &cxld->hpa_range;
 	struct resource *res = p->res;
 	int niw = cxld->interleave_ways;
 
-	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
-	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
-	    IS_ALIGNED(range_len(r), niw * SZ_256M))
+	cfmws_range_start = get_cfmws_range_start(&cxld->dev);
+	if (cfmws_range_start == ULLONG_MAX)
+		return false;
+
+	if (res->start == cfmws_range_start && res->start == r->start &&
+	    res->end < r->end && IS_ALIGNED(range_len(r), niw * SZ_256M))
 		return true;
 
 	return false;
diff --git a/drivers/cxl/core/lmh.h b/drivers/cxl/core/lmh.h
index ec8907145afe8..d804108fbb41a 100644
--- a/drivers/cxl/core/lmh.h
+++ b/drivers/cxl/core/lmh.h
@@ -2,6 +2,8 @@
 
 #include "cxl.h"
 
+void set_mock_cfmws0_range_start(u64 start);
+
 #ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
 bool arch_match_spa(struct cxl_root_decoder *cxlrd,
 		    struct cxl_endpoint_decoder *cxled);
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index f088792a8925f..7b20f9fcf0d75 100644
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
index d0337c11f9ee6..6bd305e778687 100644
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
2.47.1

