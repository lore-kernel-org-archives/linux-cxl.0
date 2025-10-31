Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD330497A
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931949; cv=none; b=cPKEKT0TEbhvbczWpQLUigsrgECmdkGm/GzhuPW5mO2zocfdmSl/zmOMKHS/BB55NDSi67JwvHzNFIOYr/BcACxl0oT159nH4Ms1YfNUstMDsZc4NR/w18YMqZ0BuiKn3ROwY9YcbqQRmtjAketowXwBhq6yvqxyC8YGeZ5qZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931949; c=relaxed/simple;
	bh=jfYylwR/uzCxajSriyoMdSTGh3whabPbWkd5AUvdmlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESlyLxi/AE+EWcyVtdaVEXRSQzVWaZROsw5YWKDA/3u0wpK0VAD6vYqsMsTJKJHkDaVUE5WjAo2zWj5GDKhMK3yT24b68vAwmQHVm0SWvHhieT2I/TBXlxxJ62+ap15AsLflVXsBeIcgFGu1O+Sdlpr6Q2H1bltLpcJ1g3dZ6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7446CC4CEE7;
	Fri, 31 Oct 2025 17:32:28 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 2/4] cxl/test: Add cxl_test CFMWS support for extended linear cache
Date: Fri, 31 Oct 2025 10:32:22 -0700
Message-ID: <20251031173224.3537030-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031173224.3537030-1-dave.jiang@intel.com>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index d53b72bc034f..4e9007f2d510 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -15,6 +15,7 @@
 #include "mock.h"
 
 static int interleave_arithmetic;
+static bool extended_linear_cache;
 
 #define FAKE_QTG_ID	42
 
@@ -428,6 +429,24 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
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
+	window->window_size = MOCK_AUTO_REGION_SIZE * 2;
+}
+
 static int populate_cedt(void)
 {
 	struct cxl_mock_res *res;
@@ -452,6 +471,7 @@ static int populate_cedt(void)
 	for (i = cfmws_start; i <= cfmws_end; i++) {
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 
+		cfmws_elc_update(window, i);
 		res = alloc_mock_res(window->window_size, SZ_256M);
 		if (!res)
 			return -ENOMEM;
@@ -782,6 +802,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	}
 
 	base = window->base_hpa;
+	if (extended_linear_cache)
+		base += MOCK_AUTO_REGION_SIZE;
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + MOCK_AUTO_REGION_SIZE - 1,
@@ -1608,6 +1630,8 @@ static __exit void cxl_test_exit(void)
 
 module_param(interleave_arithmetic, int, 0444);
 MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
+module_param(extended_linear_cache, bool, 0444);
+MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.51.0

