Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE22AD00
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390781; cv=none; b=qeGRNWbmCTlbXv/6YPJkukI/G4Z8cvr6ogKD/TB67+rCvmTJxLvKAO1AcEChZi5amA3vdoy/ZbxXAydKSkidzfmAPajz/hg3qBzZXK08ZaV6uil4sj46mKizIJrW0/QBveJiRr5zb60v0GXiqb2RmnOmW5wnzEjKSp4s5jWTPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390781; c=relaxed/simple;
	bh=tyrCkVY5+BVqoFCTqlyubHCHIXu5etImtbxBPZDQDpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFOKQg+1UsqIrz9mPDeQPsqx3z0gtUuNi8HBJeiFxGRChKkPV+yf5p2SGGbvBMIBYwHel4hmnUWfwN763TCqy+C+B6ZdmLRwKC2axBzpO6guoOoxi4YghvfNoylM6IIoKehsdvva1rajWghueN2dKTXFceK3bOYDsNAk5zqVeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87179C113D0;
	Mon, 17 Nov 2025 14:46:20 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2 2/3] cxl/test: Add cxl_test CFMWS support for extended linear cache
Date: Mon, 17 Nov 2025 07:46:10 -0700
Message-ID: <20251117144611.903692-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117144611.903692-1-dave.jiang@intel.com>
References: <20251117144611.903692-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a module parameter to allow activation of extended linear cache
on the auto region for cxl_test. The current platform implementation
for extended linear cache is 1:1 of DRAM and CXL memory. A CFMWS is
created with the size of both memory together where DRAM takes the
first part of the memory range and CXL covers the second part. The
current CXL auto region on cxl_test consists of 2 256M devices that
creates a 512M region. The new extended linear cache setup will have
512M DRAM and 512M CXL memory for a total of 1G CFMWS. The hardware
decoders must have their starting offset moved to after the DRAM region
to handle the CXL regions.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- change to use mock_auto_region_size
---
 tools/testing/cxl/test/cxl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index f0e734536081..2c3979c0b505 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -15,6 +15,7 @@
 #include "mock.h"
 
 static int interleave_arithmetic;
+static bool extended_linear_cache;
 
 #define FAKE_QTG_ID	42
 
@@ -429,6 +430,24 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
 	return res;
 }
 
+/*
+ * Only update CFMWS0 as this is used by the auto region.
+ */
+static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
+{
+	if (!extended_linear_cache)
+		return;
+
+	if (index != 0)
+		return;
+
+	/*
+	 * The window size should be 2x of the CXL region size where half is
+	 * DRAM and half is CXL
+	 */
+	window->window_size = mock_auto_region_size * 2;
+}
+
 static int populate_cedt(void)
 {
 	struct cxl_mock_res *res;
@@ -453,6 +472,7 @@ static int populate_cedt(void)
 	for (i = cfmws_start; i <= cfmws_end; i++) {
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 
+		cfmws_elc_update(window, i);
 		res = alloc_mock_res(window->window_size, SZ_256M);
 		if (!res)
 			return -ENOMEM;
@@ -783,6 +803,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	}
 
 	base = window->base_hpa;
+	if (extended_linear_cache)
+		base += mock_auto_region_size;
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
@@ -1609,6 +1631,8 @@ static __exit void cxl_test_exit(void)
 
 module_param(interleave_arithmetic, int, 0444);
 MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
+module_param(extended_linear_cache, bool, 0444);
+MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.51.1

