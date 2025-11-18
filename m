Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEE2F2903;
	Tue, 18 Nov 2025 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495034; cv=none; b=OY6IELY5WmJNgKtnuRR5um17TVtw7wxM/GXQkY3SGsDorgxtZ61xmiwvOLUuOOo7y62VBtAuEKKGleFoXi5LkprEuHmcCrHFTHvnJaCFzycS8xgIqjMh5lxSFThBULxJQ9w/AHCVtKpu45I+xkOCdar1MEf5lIs0ItofoCfu2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495034; c=relaxed/simple;
	bh=B6hBR83dAXHR1Vl0krml335CG9Q3WF7AuxAkPuLIa+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOs+T9ehJppybnKXM09h94zycler4/K8hIzvD5jt+Myzoue2BN1tg0//HnPmx82iRh6066Lr6XTKpapEe9w4opVRQ6jc1fvEoefBXk+FFDlcNyTMlckhZMBW51cbBHi65YX/lBAELpUhuAzEygDtP1t/VKu9egm9oX4OMua0uN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f73p4Cj5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f73p4Cj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763495031; x=1795031031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B6hBR83dAXHR1Vl0krml335CG9Q3WF7AuxAkPuLIa+o=;
  b=f73p4Cj5InqifYdby8tEAkwZsarH8mBhvijK20NqJ0xaYJP/WZ2j6r1q
   8CJlAF3UsV0HQOmN7bpactFHJr59+2ZmvTgAhORgCAtPES/LxfUAX7A0E
   Qe0xNpIU2hFg+9NbURKQmpj2/VGxslRcq8hm6Dow5yc9NhDp6N6QgCDaf
   xY+tx11eV1fbtzlHB7bNiQUe339+Nkdlvw4QucQbCHr3neUtRiK6tzsIs
   H/2Y4jRUNyvY7PO738I+8vJvVdNyUNNs4/l06GQn3G2C6G7vwqx/jEdzI
   d1F8Imo+kFSCdZDB/BobdecaVtZNLrdAwfxdloKDd+zLeloqIuhtSqE/u
   w==;
X-CSE-ConnectionGUID: t9hWFjnCQvGjQ6IJtNjkFg==
X-CSE-MsgGUID: hNpwUKmfQbublR2wtaTWWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76138729"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76138729"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:43:51 -0800
X-CSE-ConnectionGUID: QZDmcBgjQaSE7emtNQz1WA==
X-CSE-MsgGUID: uil6DXNXSI+YusXk1qd2cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="228188920"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:43:46 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 4/4 v6] cxl/test: Simulate an x86 Low Memory Hole for tests
Date: Tue, 18 Nov 2025 20:43:06 +0100
Message-ID: <20251118194321.1773484-5-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118194321.1773484-1-fabio.m.de.francesco@linux.intel.com>
References: <20251118194321.1773484-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simulate an x86 Low Memory Hole for the CXL tests by changing the first
mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range
sizes to 1GB. The auto-created region of cxl-test uses mock_cfmws[0],
therefore the LMH path in the CXL Driver will be exercised every time
the cxl-test module is loaded.

Since mock_cfmws[0] range base address is typically different from the
one published by the BIOS on real hardware, the driver would fail to
create and attach CXL Regions when it's run on the mock environment
created by cxl-tests.

To make the above-mentioned tests succeed again, add two "mock" versions
of platform_*() that check the HPA range start of mock_cfmws[0] instead
of LMH_CFMWS_RANGE_START. When cxl_core calls a cxl_core exported
function and that function is mocked by cxl_test, the call chain causes
a circular dependency issue. Then add also two "redirect" versions of
platform_*() to work out the circular dependency issue.

The LMH simulation for cxl_test.ko is enabled at module insertion time
with 'low_memory_hole=1'.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/platform_quirks.c   | 31 +++++++++---
 drivers/cxl/core/platform_quirks.h   | 19 ++++++-
 tools/testing/cxl/cxl_core_exports.c | 23 +++++++++
 tools/testing/cxl/exports.h          |  7 +++
 tools/testing/cxl/test/cxl.c         | 75 ++++++++++++++++++++++++++++
 tools/testing/cxl/test/mock.c        | 48 ++++++++++++++++++
 tools/testing/cxl/test/mock.h        |  4 ++
 7 files changed, 197 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/platform_quirks.c b/drivers/cxl/core/platform_quirks.c
index be57b9666c9b..1d44a8e255c6 100644
--- a/drivers/cxl/core/platform_quirks.c
+++ b/drivers/cxl/core/platform_quirks.c
@@ -2,20 +2,22 @@
 // Copyright(c) 2025 Intel Corporation
 
 #include <linux/range.h>
+#include <cxlmem.h>
+#include <cxl.h>
+
 #include "platform_quirks.h"
-#include "cxlmem.h"
 #include "core.h"
 
 /* Start of CFMWS range that end before x86 Low Memory Holes */
 #define LMH_CFMWS_RANGE_START 0x0ULL
 
 /**
- * platform_cxlrd_matches_cxled() - Platform quirk to match CXL Root and
+ * __platform_cxlrd_matches_cxled() - Platform quirk to match CXL Root and
  * Endpoint Decoders. It allows matching on platforms with LMH's.
  * @cxlrd: The Root Decoder against which @cxled is tested for matching.
  * @cxled: The Endpoint Decoder to be tested for matching @cxlrd.
  *
- * platform_cxlrd_matches_cxled() is typically called from the
+ * __platform_cxlrd_matches_cxled() is typically called from the
  * match_*_by_range() functions in region.c. It checks if an endpoint decoder
  * matches a given root decoder and returns true to allow the driver to succeed
  * in the construction of regions where it would otherwise fail for the presence
@@ -30,8 +32,8 @@
  *
  * Return: true if an endpoint matches a root decoder, else false.
  */
-bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
-				  const struct cxl_endpoint_decoder *cxled)
+bool __platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+				    const struct cxl_endpoint_decoder *cxled)
 {
 	const struct range *rd_r, *sd_r;
 	int align;
@@ -46,9 +48,10 @@ bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
 	       rd_r->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
 	       IS_ALIGNED(range_len(sd_r), align);
 }
+EXPORT_SYMBOL_NS_GPL(__platform_cxlrd_matches_cxled, "CXL");
 
 /**
- * platform_region_matches_cxld() - Platform quirk to match a CXL Region and a
+ * __platform_region_matches_cxld() - Platform quirk to match a CXL Region and a
  * Switch or Endpoint Decoder. It allows matching on platforms with LMH's.
  * @p: Region Params against which @cxled is matched.
  * @cxld: Switch or Endpoint Decoder to be tested for matching @p.
@@ -58,8 +61,8 @@ bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
  *
  * Return: true if a Decoder matches a Region, else false.
  */
-bool platform_region_matches_cxld(const struct cxl_region_params *p,
-				  const struct cxl_decoder *cxld)
+bool __platform_region_matches_cxld(const struct cxl_region_params *p,
+				    const struct cxl_decoder *cxld)
 {
 	const struct range *r = &cxld->hpa_range;
 	const struct resource *res = p->res;
@@ -71,7 +74,19 @@ bool platform_region_matches_cxld(const struct cxl_region_params *p,
 	       res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
 	       IS_ALIGNED(range_len(r), align);
 }
+EXPORT_SYMBOL_NS_GPL(__platform_region_matches_cxld, "CXL");
 
+/**
+ * platform_adjust_resources() - Platform quirk that adjusts Region and Endpoint
+ * Decoder DPA resources to be equal to the Root Decoder's resource end.
+ * @res: Resource parameters for Region construction
+ * @cxled: Endpoint Decoder whose DPA needs adjustment
+ * @cxlrd: Root Decoder whose HPA range is needed to adjust @res->end
+ * @region_dev: Region device for printing Region name
+ *
+ * Adjusts the Region and Endpoint Decoder DPA resource end to be equal to the
+ * Root Decoder's resource end. It's needed when SPA < HPA
+ */
 void platform_adjust_resources(struct resource *res,
 			       struct cxl_endpoint_decoder *cxled,
 			       const struct cxl_root_decoder *cxlrd,
diff --git a/drivers/cxl/core/platform_quirks.h b/drivers/cxl/core/platform_quirks.h
index fce376232c16..7c2f459bb29a 100644
--- a/drivers/cxl/core/platform_quirks.h
+++ b/drivers/cxl/core/platform_quirks.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright(c) 2025 Intel Corporation */
 
+#ifndef __PLATFORM_QUIRKS_H__
+#define __PLATFORM_QUIRKS_H__
+
 #include "cxl.h"
 
 #ifdef CONFIG_CXL_PLATFORM_QUIRKS
@@ -8,14 +11,18 @@ bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
 				  const struct cxl_endpoint_decoder *cxled);
 bool platform_region_matches_cxld(const struct cxl_region_params *p,
 				  const struct cxl_decoder *cxld);
+bool __platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+				    const struct cxl_endpoint_decoder *cxled);
+bool __platform_region_matches_cxld(const struct cxl_region_params *p,
+				    const struct cxl_decoder *cxld);
 void platform_adjust_resources(struct resource *res,
 			       struct cxl_endpoint_decoder *cxled,
 			       const struct cxl_root_decoder *cxlrd,
 			       const struct device *region_dev);
 #else
 static inline bool
-platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
-			       const struct cxl_endpoint_decoder *cxled)
+platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+			     const struct cxl_endpoint_decoder *cxled)
 {
 	return false;
 }
@@ -34,3 +41,11 @@ platform_adjust_resources(struct resource *res,
 			  const struct device *region_dev)
 { }
 #endif /* CONFIG_CXL_PLATFORM_QUIRKS */
+
+#ifndef CXL_TEST_ENABLE
+#define DECLARE_TESTABLE(x) __##x
+#define platform_cxlrd_matches_cxled DECLARE_TESTABLE(platform_cxlrd_matches_cxled)
+#define platform_region_matches_cxld DECLARE_TESTABLE(platform_region_matches_cxld)
+#endif
+
+#endif /* __PLATFORM_QUIRKS_H__ */
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index 6754de35598d..a9e37156d126 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -3,6 +3,7 @@
 
 #include "cxl.h"
 #include "exports.h"
+#include "platform_quirks.h"
 
 /* Exporting of cxl_core symbols that are only used by cxl_test */
 EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
@@ -27,3 +28,25 @@ int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 	return _devm_cxl_switch_port_decoders_setup(port);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_switch_port_decoders_setup, "CXL");
+
+platform_cxlrd_matches_cxled_fn _platform_cxlrd_matches_cxled =
+	__platform_cxlrd_matches_cxled;
+EXPORT_SYMBOL_NS_GPL(_platform_cxlrd_matches_cxled, "CXL");
+
+bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+				  const struct cxl_endpoint_decoder *cxled)
+{
+	return _platform_cxlrd_matches_cxled(cxlrd, cxled);
+}
+EXPORT_SYMBOL_NS_GPL(platform_cxlrd_matches_cxled, "CXL");
+
+platform_region_matches_cxld_fn _platform_region_matches_cxld =
+	__platform_region_matches_cxld;
+EXPORT_SYMBOL_NS_GPL(_platform_region_matches_cxld, "CXL");
+
+bool platform_region_matches_cxld(const struct cxl_region_params *p,
+				  const struct cxl_decoder *cxld)
+{
+	return _platform_region_matches_cxld(p, cxld);
+}
+EXPORT_SYMBOL_NS_GPL(platform_region_matches_cxld, "CXL");
diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
index 7ebee7c0bd67..e0e4c58dadf2 100644
--- a/tools/testing/cxl/exports.h
+++ b/tools/testing/cxl/exports.h
@@ -10,4 +10,11 @@ extern cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev;
 typedef int(*cxl_switch_decoders_setup_fn)(struct cxl_port *port);
 extern cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup;
 
+typedef bool(*platform_cxlrd_matches_cxled_fn)(const struct cxl_root_decoder *cxlrd,
+					       const struct cxl_endpoint_decoder *cxled);
+extern platform_cxlrd_matches_cxled_fn _platform_cxlrd_matches_cxled;
+
+typedef bool(*platform_region_matches_cxld_fn)(const struct cxl_region_params *p,
+					       const struct cxl_decoder *cxld);
+extern platform_region_matches_cxld_fn _platform_region_matches_cxld;
 #endif
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 81e2aef3627a..2081b79cb354 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -9,6 +9,8 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/mm.h>
+
+#include <platform_quirks.h>
 #include <cxlmem.h>
 
 #include "../watermark.h"
@@ -16,6 +18,7 @@
 
 static int interleave_arithmetic;
 static bool extended_linear_cache;
+static int low_memory_hole;
 
 #define FAKE_QTG_ID	42
 
@@ -446,6 +449,35 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
 	window->window_size = mock_auto_region_size * 2;
 }
 
+/*
+ * Set the CFMWS[0] size to 768M and the endpoint decoders HPA range size to 1G
+ * to simulate a low memory hole that trims the window and results in SPA < HPA
+ */
+static void lmh_range_size_update(struct acpi_cedt_cfmws *window, int index)
+{
+	if (!low_memory_hole)
+		return;
+
+	if (index != 0)
+		return;
+
+	window->window_size = mock_auto_region_size * 2 - SZ_256M;
+	mock_auto_region_size = mock_auto_region_size * 2;
+}
+
+static u64 mock_cfmws0_range_start;
+
+static void set_mock_cfmws0_range_start(u64 start, int index)
+{
+	if (!low_memory_hole)
+		return;
+
+	if (index != 0)
+		return;
+
+	mock_cfmws0_range_start = start;
+}
+
 static int populate_cedt(void)
 {
 	struct cxl_mock_res *res;
@@ -471,10 +503,12 @@ static int populate_cedt(void)
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 
 		cfmws_elc_update(window, i);
+		lmh_range_size_update(window, i);
 		res = alloc_mock_res(window->window_size, SZ_256M);
 		if (!res)
 			return -ENOMEM;
 		window->base_hpa = res->range.start;
+		set_mock_cfmws0_range_start(res->range.start, i);
 	}
 
 	return 0;
@@ -1114,6 +1148,39 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
 	cxl_endpoint_get_perf_coordinates(port, ep_c);
 }
 
+static bool
+mock_platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+				  const struct cxl_endpoint_decoder *cxled)
+{
+	const struct range *rd_r, *ed_r;
+	int align;
+
+	rd_r = &cxlrd->cxlsd.cxld.hpa_range;
+	ed_r = &cxled->cxld.hpa_range;
+	align = cxled->cxld.interleave_ways * SZ_256M;
+
+	return rd_r->start == mock_cfmws0_range_start &&
+	       rd_r->start == ed_r->start &&
+	       rd_r->end < (mock_cfmws0_range_start + SZ_4G) &&
+	       rd_r->end < ed_r->end &&
+	       IS_ALIGNED(range_len(ed_r), align);
+}
+
+static bool
+mock_platform_region_matches_cxld(const struct cxl_region_params *p,
+				  const struct cxl_decoder *cxld)
+{
+	const struct range *r = &cxld->hpa_range;
+	const struct resource *res = p->res;
+	int align = cxld->interleave_ways * SZ_256M;
+
+	return res->start == mock_cfmws0_range_start &&
+	       res->start == r->start &&
+	       res->end < (mock_cfmws0_range_start + SZ_4G) &&
+	       res->end < r->end &&
+	       IS_ALIGNED(range_len(r), align);
+}
+
 static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_adev = is_mock_adev,
 	.is_mock_bridge = is_mock_bridge,
@@ -1129,6 +1196,8 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.devm_cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
 	.hmat_get_extended_linear_cache_size =
 		mock_hmat_get_extended_linear_cache_size,
+	.platform_cxlrd_matches_cxled = mock_platform_cxlrd_matches_cxled,
+	.platform_region_matches_cxld = mock_platform_region_matches_cxld,
 	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
 };
 
@@ -1426,6 +1495,10 @@ static __init int cxl_test_init(void)
 	cxl_pmem_test();
 	cxl_port_test();
 
+	/* LMH and ELC tests are nutually exclusive */
+	if (low_memory_hole && extended_linear_cache)
+		return -EINVAL;
+
 	register_cxl_mock_ops(&cxl_mock_ops);
 
 	cxl_mock_pool = gen_pool_create(ilog2(SZ_2M), NUMA_NO_NODE);
@@ -1620,6 +1693,8 @@ module_param(interleave_arithmetic, int, 0444);
 MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
 module_param(extended_linear_cache, bool, 0444);
 MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
+module_param(low_memory_hole, int, 0444);
+MODULE_PARM_DESC(low_memory_hole, "Enable Low Memory Hole simulation");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 6eb15991a414..0cf4d7a8c4c4 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -7,6 +7,8 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
+
+#include <platform_quirks.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include "mock.h"
@@ -18,6 +20,12 @@ static struct cxl_dport *
 redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
 				   struct device *dport_dev);
 static int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
+static bool
+redirect_platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+				      const struct cxl_endpoint_decoder *cxled);
+static bool
+redirect_platform_region_matches_cxld(const struct cxl_region_params *p,
+				      const struct cxl_decoder *cxld);
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
@@ -25,6 +33,8 @@ void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 	_devm_cxl_add_dport_by_dev = redirect_devm_cxl_add_dport_by_dev;
 	_devm_cxl_switch_port_decoders_setup =
 		redirect_devm_cxl_switch_port_decoders_setup;
+	_platform_cxlrd_matches_cxled = redirect_platform_cxlrd_matches_cxled;
+	_platform_region_matches_cxld = redirect_platform_region_matches_cxld;
 }
 EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
 
@@ -35,6 +45,8 @@ void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
 	_devm_cxl_switch_port_decoders_setup =
 		__devm_cxl_switch_port_decoders_setup;
 	_devm_cxl_add_dport_by_dev = __devm_cxl_add_dport_by_dev;
+	_platform_cxlrd_matches_cxled = __platform_cxlrd_matches_cxled;
+	_platform_region_matches_cxld = __platform_region_matches_cxld;
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&cxl_mock_srcu);
 }
@@ -290,6 +302,42 @@ struct cxl_dport *redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
 	return dport;
 }
 
+static bool
+redirect_platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
+				      const struct cxl_endpoint_decoder *cxled)
+{
+	int index;
+	bool match;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
+
+	if (ops && ops->is_mock_port(port->uport_dev))
+		match = ops->platform_cxlrd_matches_cxled(cxlrd, cxled);
+	else
+		match = __platform_cxlrd_matches_cxled(cxlrd, cxled);
+	put_cxl_mock_ops(index);
+
+	return match;
+}
+
+static bool
+redirect_platform_region_matches_cxld(const struct cxl_region_params *p,
+				      const struct cxl_decoder *cxld)
+{
+	int index;
+	bool match;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	if (ops && ops->is_mock_port(port->uport_dev))
+		match = ops->platform_region_matches_cxld(p, cxld);
+	else
+		match = __platform_region_matches_cxld(p, cxld);
+	put_cxl_mock_ops(index);
+
+	return match;
+}
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("cxl_test: emulation module");
 MODULE_IMPORT_NS("ACPI");
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 2684b89c8aa2..ac66cf171834 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -27,6 +27,10 @@ struct cxl_mock_ops {
 	int (*hmat_get_extended_linear_cache_size)(struct resource *backing_res,
 						   int nid,
 						   resource_size_t *cache_size);
+	bool (*platform_cxlrd_matches_cxled)(const struct cxl_root_decoder *cxlrd,
+					     const struct cxl_endpoint_decoder *cxled);
+	bool (*platform_region_matches_cxld)(const struct cxl_region_params *p,
+					     const struct cxl_decoder *cxld);
 };
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops);
-- 
2.51.1

