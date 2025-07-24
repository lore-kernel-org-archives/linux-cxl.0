Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659692E54B9;
	Thu, 24 Jul 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367130; cv=none; b=alvpPTgR1/BMb1gvJJCqEa4cGlhM/chWJ7DlcvuSDZHvV/vIz9gmZH1/oqAS6/jSAv8rYpIqI8c5Le8yQLDzUL4GbxEGV8ndFIzl1fxWUt3HCJgQrPQyJKj422/wdGnZvPMtd9PFM6eJnotlEbTJcb6iPWSZqeomtcUFxRhI6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367130; c=relaxed/simple;
	bh=EAPPpssxPZYF3VUgXA7gXTj4OzBpD/qHTIbo4501zOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkXeXldW3jVMAX5Npcdha30RY35RuY0lYX/AlM+tphhDX9tGKrrS4KhFdjMPiI+pnFu+7mIWf2HDXoNj8xMK2td3NLB2hHMKFsziGVdX9DvrmSWb1xa4tnhLlAFlF8IKvMzbuim+JbPJjG4WSE2X1DAxWmhvQORNyHU/HptexYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJtWciWC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJtWciWC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753367128; x=1784903128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EAPPpssxPZYF3VUgXA7gXTj4OzBpD/qHTIbo4501zOc=;
  b=OJtWciWCtWiSydbOhPnBa3nhv7h6gpB4Jq36WasLsPugTjtDZ3DCQnxq
   ssQJ8TcC7cm5vkS72kh+2z2yJHXIWvuvg+UYrQG8ZCVjexsAqtpX/gqpK
   +UYaZcO0WKKxjJ6ccXYyrCYVEIRsnrg2b8480VXAUo/pS4kDcXNcPdPew
   1Ly1SWCvsWUxmDNqzgvF/rXBSo+Z71OPzjW9woENswqBR6mBrnN1ftnxh
   cCP8gJVYqCbJwTtLesHC9S43fCXncAj4HDcU+ok5Np1pOrQKxdzjkoSdS
   k7TGG3qPTGm7Evc0mkqFIAcR8XmYRv056kdpGJ9qywn1IjL+9IedHPi/O
   w==;
X-CSE-ConnectionGUID: dIjFLyVlQvq19ipq+K4GKg==
X-CSE-MsgGUID: aaR+PiLzQ6uZv6wtTFF3hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66250287"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="66250287"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:25:28 -0700
X-CSE-ConnectionGUID: V49M8n9iSAacmvlh6IrDVg==
X-CSE-MsgGUID: DTLVz4BWSqGScTPqJso6HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160245802"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.151])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:25:24 -0700
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
Subject: [PATCH 4/4 v4] cxl/test: Simulate an x86 Low Memory Hole for tests
Date: Thu, 24 Jul 2025 16:20:34 +0200
Message-ID: <20250724142144.776992-5-fabio.m.de.francesco@linux.intel.com>
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

Simulate an x86 Low Memory Hole for the CXL tests by changing the first
mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range sizes
to 1GB.

The auto-created region of cxl-test uses mock_cfmws[0], therefore the LMH
path in the CXL Driver will be exercised every time the cxl-test module is
loaded. Executing unit test: cxl-topology.sh, confirms the region created
successfully with a LMH.

Since mock_cfmws[0] range base address is typically different from the one
published by the BIOS on real hardware, the driver would fail to create and
attach CXL Regions when it's run on the mock environment created by
cxl-tests.

Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match CXL
Root Decoders and Regions with Endpoint Decoders when the driver is run on
mock devices.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/platform.c       |   9 +-
 tools/testing/cxl/Kbuild          |   1 +
 tools/testing/cxl/mock_platform.c | 137 ++++++++++++++++++++++++++++++
 tools/testing/cxl/test/cxl.c      |  10 +++
 tools/testing/cxl/test/mock.h     |   1 +
 5 files changed, 154 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/cxl/mock_platform.c

diff --git a/drivers/cxl/core/platform.c b/drivers/cxl/core/platform.c
index 8202750742d0..ba1dafece495 100644
--- a/drivers/cxl/core/platform.c
+++ b/drivers/cxl/core/platform.c
@@ -17,8 +17,9 @@
  * also larger than that of the matching root decoder. If there are LMH's,
  * the root decoder range end is always less than SZ_4G.
  */
-bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
-				    const struct cxl_endpoint_decoder *cxled)
+__weak bool
+platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+			       const struct cxl_endpoint_decoder *cxled)
 {
 	const struct range *r1, *r2;
 	int niw;
@@ -39,8 +40,8 @@ bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
  * Similar to platform_root_decoder_contains(), it matches regions and
  * decoders
  */
-bool platform_region_contains(const struct cxl_region_params *p,
-			      const struct cxl_decoder *cxld)
+__weak bool platform_region_contains(const struct cxl_region_params *p,
+				     const struct cxl_decoder *cxld)
 {
 	const struct range *r = &cxld->hpa_range;
 	const struct resource *res = p->res;
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 77e392c4b541..64c5c8c34805 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -66,6 +66,7 @@ cxl_core-y += $(CXL_CORE_SRC)/acpi.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += $(CXL_CORE_SRC)/platform.o
+cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += mock_platform.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
diff --git a/tools/testing/cxl/mock_platform.c b/tools/testing/cxl/mock_platform.c
new file mode 100644
index 000000000000..1775c64b3c7c
--- /dev/null
+++ b/tools/testing/cxl/mock_platform.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/completion.h>
+#include <linux/module.h>
+#include <linux/range.h>
+#include <linux/pci.h>
+
+#include <cxlmem.h>
+#include <platform.h>
+#include "test/mock.h"
+
+static u64 mock_cfmws0_range_start;
+
+void set_mock_cfmws0_range_start(u64 start)
+{
+	mock_cfmws0_range_start = start;
+}
+EXPORT_SYMBOL_NS_GPL(set_mock_cfmws0_range_start, "CXL");
+
+static bool is_mock_port(struct device *dev)
+{
+	struct cxl_mock_ops *(*get_ops_fn)(int *index);
+	struct cxl_mock_ops *ops = NULL;
+	void (*put_ops_fn)(int index);
+	bool is_mock = false;
+	int index;
+
+	get_ops_fn = symbol_get(get_cxl_mock_ops);
+	if (!get_ops_fn)
+		return false;
+	put_ops_fn = symbol_get(put_cxl_mock_ops);
+	if (!put_ops_fn)
+		goto out;
+
+	ops = get_ops_fn(&index);
+	if (ops)
+		is_mock = ops->is_mock_port(dev);
+	put_ops_fn(index);
+
+out:
+	symbol_put(get_cxl_mock_ops);
+
+	return is_mock;
+}
+
+/* Start of CFMWS range that end before x86 Low Memory Holes */
+#define LMH_CFMWS_RANGE_START 0x0ULL
+
+static bool
+real_platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
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
+static bool
+cxl_test_platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+					const struct cxl_endpoint_decoder *cxled)
+{
+	const struct range *r1, *r2;
+	int niw;
+
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
+	niw = cxled->cxld.interleave_ways;
+
+	if (r1->start == mock_cfmws0_range_start && r1->start == r2->start &&
+	    r1->end < (mock_cfmws0_range_start + SZ_4G) && r1->end < r2->end &&
+	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
+		return true;
+
+	return false;
+}
+
+bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
+				    const struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
+
+	if (is_mock_port(port->uport_dev))
+		return cxl_test_platform_root_decoder_contains(cxlrd, cxled);
+
+	return real_platform_root_decoder_contains(cxlrd, cxled);
+}
+
+static bool real_platform_region_contains(const struct cxl_region_params *p,
+					  const struct cxl_decoder *cxld)
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
+static bool cxl_test_platform_region_contains(const struct cxl_region_params *p,
+					      const struct cxl_decoder *cxld)
+{
+	const struct range *r = &cxld->hpa_range;
+	const struct resource *res = p->res;
+	int niw = cxld->interleave_ways;
+
+	if (res->start == mock_cfmws0_range_start && res->start == r->start &&
+	    res->end < (mock_cfmws0_range_start + SZ_4G) && res->end < r->end &&
+	    IS_ALIGNED(range_len(r), niw * SZ_256M))
+		return true;
+
+	return false;
+}
+
+bool platform_region_contains(const struct cxl_region_params *p,
+			      const struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	if (is_mock_port(port->uport_dev))
+		return cxl_test_platform_region_contains(p, cxld);
+
+	return real_platform_region_contains(p, cxld);
+}
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8a5815ca870d..a411c055d390 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -212,7 +212,11 @@ static struct {
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
+#if defined(CONFIG_CXL_PLATFORM_QUIRKS)
+			.window_size = SZ_256M * 3UL,
+#else
 			.window_size = SZ_256M * 4UL,
+#endif
 		},
 		.target = { 0 },
 	},
@@ -453,6 +457,8 @@ static int populate_cedt(void)
 		if (!res)
 			return -ENOMEM;
 		window->base_hpa = res->range.start;
+		if (i == 0)
+			set_mock_cfmws0_range_start(res->range.start);
 	}
 
 	return 0;
@@ -744,7 +750,11 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *port, *iter;
+#if defined(CONFIG_CXL_PLATFORM_QUIRKS)
+	const int size = SZ_1G;
+#else
 	const int size = SZ_512M;
+#endif
 	struct cxl_memdev *cxlmd;
 	struct cxl_dport *dport;
 	struct device *dev;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index d1b0271d2822..792eabbd0f18 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -32,3 +32,4 @@ void register_cxl_mock_ops(struct cxl_mock_ops *ops);
 void unregister_cxl_mock_ops(struct cxl_mock_ops *ops);
 struct cxl_mock_ops *get_cxl_mock_ops(int *index);
 void put_cxl_mock_ops(int index);
+void set_mock_cfmws0_range_start(u64 start);
-- 
2.50.1

