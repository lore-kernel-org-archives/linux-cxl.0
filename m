Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321791DF267;
	Fri, 22 Nov 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290786; cv=none; b=CXOBQPB5UPdVxqgXXM95Y2FUsxYmOmJDCFd8urnP2SPUmLjP5lRCerIzr7x9YqBm7WMKq5Rdp03aJMMW9nNKt4aABUhLF7OX6FxGbTRcCY4pBHKN6hO4lf+fYZmS08NDqbiJGeuV0r8FrAkqGXOMgUf0UhBvsadhbdS1efNOKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290786; c=relaxed/simple;
	bh=AL+3PXVZs+qggbFiQ6H4dWmhdzmqi8FzODkbElx4rQo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7wR2YCP/wGswbdn8+MggiJNZpAXCb0oct43CAk5ag09HwxdsPXKkrbrye2UagHa+gksIK8BkQMRme8PTHhZ8pACj2B5BWHNgizzHeKrw250p5SnkXChpIWchGcs4tzWb6kfFq2+bsDzqD176UfQA6LGlMauXi4RIgbM1+fBSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQq5iCQd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQq5iCQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732290785; x=1763826785;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=AL+3PXVZs+qggbFiQ6H4dWmhdzmqi8FzODkbElx4rQo=;
  b=dQq5iCQdY2N/gcTtfXUqoeUQ6aDNqlGXwQ2F5pWJdxLd/24R7qoYwWyP
   iHb/1BJTSFJEl8xCdilcA8msKdOHAcBjuynvTdWOXimka/sJV51AbFS1N
   V4CQod+r4mbqaVbNpxQ2r2l5Gc05mqh+z02kYWpKF76/5H57gFcdu/oKs
   SCxK8htKKsyuzC09wQ6nzWPNGm2Dtc11hblW92rHXluACY9Dn9eMNygq3
   GTtEVt5XbLOE4KlgUqGrtKtY03EKgoaupIIZhsEjcp5TQpGQM+ZT9E/iu
   0/7jRqnxe4118sHwoYI2y4vD0X+T1ZDxv6tJdfSXqieGrf/Zxm65yGWkt
   w==;
X-CSE-ConnectionGUID: 9JZ+fq/vSmKdPFUwINlSlQ==
X-CSE-MsgGUID: oeQw01qmTT6dtcWe4K+NfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32386598"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32386598"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:53:04 -0800
X-CSE-ConnectionGUID: qjrI4stGShW0FDe5SscxMQ==
X-CSE-MsgGUID: DPo+aH7TTTGcpKxcC358Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="91408805"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.64])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:53:00 -0800
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
Subject: [PATCH 3/3] cxl/test: Simulate an x86 Low Memory Hole for tests
Date: Fri, 22 Nov 2024 16:51:54 +0100
Message-ID: <20241122155226.2068287-4-fabio.m.de.francesco@linux.intel.com>
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

Simulate an x86 Low Memory Hole for the CXL tests by changing
mock_cfmws[0] range size to 768MB and CXL Endpoint Decoder HPA range size
to 1GB and have get_cfmws_range_start() return two different addresses
which depend on whether the passed device is real or mock.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/lmh.c       | 21 +++++++++++++--------
 drivers/cxl/cxl.h            |  7 +++++++
 tools/testing/cxl/Kbuild     |  1 +
 tools/testing/cxl/test/cxl.c |  4 ++--
 4 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
index da76b2a534ec..350008324bdc 100644
--- a/drivers/cxl/core/lmh.c
+++ b/drivers/cxl/core/lmh.c
@@ -1,10 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/range.h>
+#include <linux/pci.h>
 #include "cxl.h"
 
-/* In x86 with memory hole, misaligned CFMWS range starts at 0x0 */
-#define MISALIGNED_CFMWS_RANGE_BASE 0x0
+u64 get_cfmws_range_start(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return MISALIGNED_CFMWS_RANGE_START;
+	return MISALIGNED_MOCK_CFMWS_RANGE_START;
+}
 
 /*
  * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
@@ -17,6 +22,7 @@
 bool arch_match_spa(struct cxl_root_decoder *cxlrd,
 		    struct cxl_endpoint_decoder *cxled)
 {
+	u64 cfmws_range_start = get_cfmws_range_start(&cxled->cxld.dev);
 	struct range *r1, *r2;
 	int niw;
 
@@ -24,9 +30,8 @@ bool arch_match_spa(struct cxl_root_decoder *cxlrd,
 	r2 = &cxled->cxld.hpa_range;
 	niw = cxled->cxld.interleave_ways;
 
-	if (r1->start == MISALIGNED_CFMWS_RANGE_BASE &&
-	    r1->start == r2->start && r1->end < r2->end &&
-	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
+	if (r1->start == cfmws_range_start && r1->start == r2->start &&
+	    r1->end < r2->end && IS_ALIGNED(range_len(r2), niw * SZ_256M))
 		return true;
 	return false;
 }
@@ -35,13 +40,13 @@ bool arch_match_spa(struct cxl_root_decoder *cxlrd,
 bool arch_match_region(struct cxl_region_params *p,
 		       struct cxl_decoder *cxld)
 {
+	u64 cfmws_range_start = get_cfmws_range_start(&cxld->dev);
 	struct range *r = &cxld->hpa_range;
 	struct resource *res = p->res;
 	int niw = cxld->interleave_ways;
 
-	if (res->start == MISALIGNED_CFMWS_RANGE_BASE &&
-	    res->start == r->start && res->end < r->end &&
-	    IS_ALIGNED(range_len(r), niw * SZ_256M))
+	if (res->start == cfmws_range_start && res->start == r->start &&
+	    res->end < r->end && IS_ALIGNED(range_len(r), niw * SZ_256M))
 		return true;
 	return false;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a5ad4499381e..51dc80f8e50c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -903,12 +903,19 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
+
+/* Range start address of misaligned CFMWS in x86 with LMH */
+#define MISALIGNED_CFMWS_RANGE_START 0x0
+/* Range start address of mock misaligned CFMWS for tests */
+#define MISALIGNED_MOCK_CFMWS_RANGE_START 0xf010000000
+
 bool arch_match_spa(struct cxl_root_decoder *cxlrd,
 		    struct cxl_endpoint_decoder *cxled);
 bool arch_match_region(struct cxl_region_params *p,
 		       struct cxl_decoder *cxld);
 void arch_trim_hpa_by_spa(struct resource *res,
 			  struct cxl_root_decoder *cxlrd);
+u64 get_cfmws_range_start(struct device *dev);
 #else
 bool arch_match_spa(struct cxl_root_decoder *cxlrd,
 		    struct cxl_endpoint_decoder *cxled)
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index b1256fee3567..fe9c4480f758 100644
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
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 050725afa45d..b61c3d78fed3 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -212,7 +212,7 @@ static struct {
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
-			.window_size = SZ_256M * 4UL,
+			.window_size = SZ_256M * 3UL,
 		},
 		.target = { 0 },
 	},
@@ -744,7 +744,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *port, *iter;
-	const int size = SZ_512M;
+	const int size = SZ_1G;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dport *dport;
 	struct device *dev;
-- 
2.46.2

