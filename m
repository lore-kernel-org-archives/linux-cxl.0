Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF0FC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 04:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiKREdk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiKREdh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 23:33:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CACBC30
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 20:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668746015; x=1700282015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lpRLTPl2SE69uU6JVBTffT9AY6g0GPR3KrY7U8pH2jU=;
  b=hwpOEwO5XloMi107xteYP0VrzpdV2ayfpqNgx5yIkE75YT/OHRyE7XQI
   3cUjn+xZkdYJVbuaaITTcLr8CsrOL4PXc8XUSMJZthYnts8WJLhJAgNkj
   MuZwNxyaHb2HZYOyNAFjTswihpiV/cE2jL7Muka/QQAfkZ+L4JOmDTweJ
   jnFg53FCTNTeOtudICTtl3AzLXYbWIt+QxS/rulSA+mCmOoyhX/jkL+ga
   3vW4aXnT8hBXZkOhbguFePAuNA6REy/sywvM8l5oXrpW0WeaV+M7Azwgl
   f3gUpzoJ2azX207opzILLChoMtnJFrir80G/89OJchW4xkxmQvK4cwj/3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296416366"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="296416366"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 20:33:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="782508631"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="782508631"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.84.12])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 20:33:34 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v7 3/3] tools/testing/cxl: Add XOR Math support to cxl_test
Date:   Thu, 17 Nov 2022 20:33:29 -0800
Message-Id: <ad92ca4c279271dfbad9a17d1fa9fa8ddf6a7963.1668745515.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668745515.git.alison.schofield@intel.com>
References: <cover.1668745515.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Expand the cxl_test topology to include CFMWS's that use XOR math
for interleave arithmetic, as defined in the CXL Specification 3.0.

With this expanded topology, cxl_test is useful for testing:
x1,x2,x4 ways with XOR interleave arithmetic.

Define the additional XOR CFMWS entries to appear only with the
module parameter interleave_arithmetic=1. The cxl_test default
continues to be modulo math.

modprobe cxl_test interleave_arithmetic=1

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 118 ++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 7edce12fd2ce..97849e9753f5 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -11,6 +11,8 @@
 #include <cxlmem.h>
 #include "mock.h"
 
+static int interleave_arithmetic;
+
 #define NR_CXL_HOST_BRIDGES 2
 #define NR_CXL_SINGLE_HOST 1
 #define NR_CXL_ROOT_PORTS 2
@@ -122,6 +124,22 @@ static struct {
 		struct acpi_cedt_cfmws cfmws;
 		u32 target[1];
 	} cfmws4;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[1];
+	} cfmws5;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[2];
+	} cfmws6;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[4];
+	} cfmws7;
+	struct {
+		struct acpi_cedt_cxims cxims;
+		u64 xormap_list[2];
+	} cxims0;
 } __packed mock_cedt = {
 	.cedt = {
 		.header = {
@@ -229,14 +247,89 @@ static struct {
 		},
 		.target = { 2 },
 	},
+	/* .cfmws5,6,7 use XOR Math (interleave_arithmetic == 1) */
+	.cfmws5 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws5),
+			},
+			.interleave_arithmetic = 1,
+			.interleave_ways = 0,
+			.granularity = 4,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = 0,
+			.window_size = SZ_256M * 8UL,
+		},
+		.target = { 0 },
+	},
+	.cfmws6 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws6),
+			},
+			.interleave_arithmetic = 1,
+			.interleave_ways = 1,
+			.granularity = 0,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = 1,
+			.window_size = SZ_256M * 8UL,
+		},
+		.target = { 0, 1, },
+	},
+	.cfmws7 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws7),
+			},
+			.interleave_arithmetic = 1,
+			.interleave_ways = 2,
+			.granularity = 0,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = 0,
+			.window_size = SZ_256M * 16UL,
+		},
+		.target = { 0, 1, 0, 1, },
+	},
+	.cxims0 = {
+		.cxims = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CXIMS,
+				.length = sizeof(mock_cedt.cxims0),
+			},
+			.hbig = 0,
+			.nr_xormaps = 2,
+		},
+		.xormap_list = { 0x404100, 0x808200 },
+	},
 };
 
-struct acpi_cedt_cfmws *mock_cfmws[] = {
+struct acpi_cedt_cfmws *mock_cfmws[8] = {
 	[0] = &mock_cedt.cfmws0.cfmws,
 	[1] = &mock_cedt.cfmws1.cfmws,
 	[2] = &mock_cedt.cfmws2.cfmws,
 	[3] = &mock_cedt.cfmws3.cfmws,
 	[4] = &mock_cedt.cfmws4.cfmws,
+	/* Modulo Math above, XOR Math below */
+	[5] = &mock_cedt.cfmws5.cfmws,
+	[6] = &mock_cedt.cfmws6.cfmws,
+	[7] = &mock_cedt.cfmws7.cfmws,
+};
+
+static int cfmws_start;
+static int cfmws_end;
+#define CFMWS_MOD_ARRAY_START 0
+#define CFMWS_MOD_ARRAY_END   4
+#define CFMWS_XOR_ARRAY_START 5
+#define CFMWS_XOR_ARRAY_END   7
+
+struct acpi_cedt_cxims *mock_cxims[1] = {
+	[0] = &mock_cedt.cxims0.cxims,
 };
 
 struct cxl_mock_res {
@@ -308,7 +401,7 @@ static int populate_cedt(void)
 		chbs->length = size;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(mock_cfmws); i++) {
+	for (i = cfmws_start; i <= cfmws_end; i++) {
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 
 		res = alloc_mock_res(window->window_size);
@@ -351,12 +444,19 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
 		}
 
 	if (id == ACPI_CEDT_TYPE_CFMWS)
-		for (i = 0; i < ARRAY_SIZE(mock_cfmws); i++) {
+		for (i = cfmws_start; i <= cfmws_end; i++) {
 			h = (union acpi_subtable_headers *) mock_cfmws[i];
 			end = (unsigned long) h + mock_cfmws[i]->header.length;
 			handler_arg(h, arg, end);
 		}
 
+	if (id == ACPI_CEDT_TYPE_CXIMS)
+		for (i = 0; i < ARRAY_SIZE(mock_cxims); i++) {
+			h = (union acpi_subtable_headers *)mock_cxims[i];
+			end = (unsigned long)h + mock_cxims[i]->header.length;
+			handler_arg(h, arg, end);
+		}
+
 	return 0;
 }
 
@@ -897,6 +997,16 @@ static __init int cxl_test_init(void)
 	if (rc)
 		goto err_gen_pool_add;
 
+	if (interleave_arithmetic == 1) {
+		cfmws_start = CFMWS_XOR_ARRAY_START;
+		cfmws_end = CFMWS_XOR_ARRAY_END;
+		dev_dbg(NULL, "cxl_test loading xor math option\n");
+	} else {
+		cfmws_start = CFMWS_MOD_ARRAY_START;
+		cfmws_end = CFMWS_MOD_ARRAY_END;
+		dev_dbg(NULL, "cxl_test loading modulo math option\n");
+	}
+
 	rc = populate_cedt();
 	if (rc)
 		goto err_populate;
@@ -1073,6 +1183,8 @@ static __exit void cxl_test_exit(void)
 	unregister_cxl_mock_ops(&cxl_mock_ops);
 }
 
+module_param(interleave_arithmetic, int, 0000);
+MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.37.3

