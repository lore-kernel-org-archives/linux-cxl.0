Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F320CCE1;
	Tue, 14 Jan 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886905; cv=none; b=MfEVexHbwrNDo/WrJh7Ua4LLq3sKoodJAnX6ChGw8AzbkaKB4zFXHFhgiKxeHgVnCow0+l5SQpDYmJNwkvCXnhmJ5+QVu6PO4OCcbEwf3S/RvKJea3D6Wl+jtlPAEwH1cNLXpVF1rgGrWgFaU2DGn3VZRuDBAMYks46qyghNVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886905; c=relaxed/simple;
	bh=/APxzXDFKLv/4MMx+aCv6YJHiEB/aU+KzNUx3IBKBME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7PWpTSu4OBqb4LqGnpT8fFDFOFpczsYS8ETUaTWDqfaIbumxkCF7newwY6vF+3l0tLKvm2AS8Ug9J6gKP1tVS7WnNJi9tFOS1MHwAL0qW1xupuxokCaeU9+tY2z4H13kinlcVA2E8DuaEniNXi3jGyginPPFfs8Msx2hyZmjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IniGODOO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IniGODOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736886905; x=1768422905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/APxzXDFKLv/4MMx+aCv6YJHiEB/aU+KzNUx3IBKBME=;
  b=IniGODOObFbHnJd/sOKCens6E3MylC9uR5lrz/iWwjukG3feHRNmXlVw
   7TZaGn8ojOZYQPBQyxyRkxvljUED0RWzatOSzT2S+NLgqxStk7ifRPiki
   iW4nOIAUbxpH017aGq7FiTlTkJvXA9uwyZM6MbaRz7Zjk8uoTsmG/yDjl
   B1JV4ZTvmAhCfSdyvcVhRFu9qPb2keek3J1CBpJ987dJ9o/JOut4QBTug
   DL74zb+3xOcyS0gaMbEmTzoJJWIjPWIpwHDmPkl3UlDufgYTv5Hc0/DPq
   bnTg7GCVxJPqhX/VNK0bP5coEWH5teS71IN9kqTlzHefY80L485HkfmRc
   A==;
X-CSE-ConnectionGUID: z9r490q5R8WcC87QIlr97w==
X-CSE-MsgGUID: oERR7E0ESdajYY7Ub9wPgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47693556"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="47693556"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:35:04 -0800
X-CSE-ConnectionGUID: P20IBt/+R+G3+e7GbnNyBQ==
X-CSE-MsgGUID: zTxsanarQeCyv3Q5cC0Yag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="135751394"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.88])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:35:00 -0800
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
Subject: [PATCH 4/4 v2] cxl/test: Simulate an x86 Low Memory Hole for tests
Date: Tue, 14 Jan 2025 21:32:56 +0100
Message-ID: <20250114203432.31861-5-fabio.m.de.francesco@linux.intel.com>
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

