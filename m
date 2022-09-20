Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907A8ECAAD8
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Sep 2022 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiITPjf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiITPjd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Sep 2022 11:39:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD9AFEF
        for <linux-cxl@vger.kernel.org>; Tue, 20 Sep 2022 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663688372; x=1695224372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BONtVqVsnGcbYyHQqG59s0QKj/wWHt1Y1GEi/Qmb1FE=;
  b=DyVBx1JZKeLiSzbhylHPcnfx1y5DgPkZn/Fr4NQpG7nMLQaH6rdtXCLj
   vaExEhHMatwlCZK4WEJCfCGAUpUnBHtj8wFXgb8BXC8b83TL2OTNs4IYu
   KGqVK8hRGF6BImuzKuLvGfYdYWERq0yB7DP4ys+xgjuHBzIFV8DuYHYQq
   npw0WOgkWeIiP5nzPJQbZcXDr0s0PPr93A2JhnSsZ8njjS9AG175imQB4
   YSzNH6y/NHvSXSrhnFzNj/q0gywzU9IfPSs6VlrjgjDBvYmTOt1aEOvaI
   EV6eYjOY9TH369i6OQoTGTNPZO2IyngHLqoC68WlqteyRDLdEN4ecmzZj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301110861"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="301110861"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 08:39:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="794302331"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.139.149])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 08:39:31 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v4 3/3] tools/testing/cxl: Add XOR math support
Date:   Tue, 20 Sep 2022 08:39:26 -0700
Message-Id: <81e989f7539f59dfaab5ec456591698904e5cbfc.1663687681.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1663687681.git.alison.schofield@intel.com>
References: <cover.1663687681.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Expand the cxl_test topology to include CFMWS's that use XOR math
for interleave arithmetic, as defined in the CXL Specification 3.0,
and to include an additional host bridge for testing a 4-way
host bridge interleave.

With this expanded topology, cxl_test is useful for testing:
x1 - no interleave, target index is always 0
x2 - 2 way interleave uses one xormap
x3 - 3 way interleave uses no xormaps and relies on a modulo calc.
x4 - 4 way interleave uses two xormaps

Interleave ways not offered here (x6, 8, 12, 16) follow patterns
tested in the set above.

Avoid memory bloat in cxl_test by defining a set of CFMWS entries
that use XOR interleave arithmetic and can be allocated using a new
module parameter 'interleave_arithmetic'. The default remains as
Modulo (0).

modprobe cxl_test interleave_arithmetic=1

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 161 ++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index fc2fc5561f28..84e845e30f40 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -11,7 +11,9 @@
 #include <cxlmem.h>
 #include "mock.h"
 
-#define NR_CXL_HOST_BRIDGES 2
+static int interleave_arithmetic;
+
+#define NR_CXL_HOST_BRIDGES 3
 #define NR_CXL_DIRECT_HOST_BRIDGES 1
 #define NR_CXL_ROOT_PORTS 2
 #define NR_CXL_DIRECT_ROOT_PORTS 4
@@ -45,6 +47,9 @@ host_bridge[NR_CXL_HOST_BRIDGES + NR_CXL_DIRECT_HOST_BRIDGES] = {
 	[2] = {
 		.handle = &host_bridge[2],
 	},
+	[3] = {
+		.handle = &host_bridge[3],
+	},
 };
 
 static bool is_mock_dev(struct device *dev)
@@ -101,6 +106,26 @@ static struct {
 		struct acpi_cedt_cfmws cfmws;
 		u32 target[1];
 	} cfmws5;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[1];
+	} cfmws6;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[2];
+	} cfmws7;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[3];
+	} cfmws8;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[4];
+	} cfmws9;
+	struct {
+		struct acpi_cedt_cxims cxims;
+		u64 xormap_list[2];
+	} cxims0;
 } __packed mock_cedt = {
 	.cedt = {
 		.header = {
@@ -133,6 +158,14 @@ static struct {
 		.uid = 2,
 		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
 	},
+	.chbs[3] = {
+		.header = {
+			.type = ACPI_CEDT_TYPE_CHBS,
+			.length = sizeof(mock_cedt.chbs[0]),
+		},
+		.uid = 3,
+		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
+	},
 	.cfmws0 = {
 		.cfmws = {
 			.header = {
@@ -223,15 +256,113 @@ static struct {
 		},
 		.target = { 2 },
 	},
+
+/* CFMWS #6 through #9 use XOR Math (interleave_arithmetic == 1) */
+	.cfmws6 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws6),
+			},
+			.interleave_arithmetic = 1,
+			/* No interleaving */
+			.interleave_ways = 0,
+			.granularity = 0,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = 0,
+			.window_size = SZ_256M * 4UL,
+		},
+		.target = { 0 },
+	},
+	.cfmws7 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws7),
+			},
+			.interleave_arithmetic = 1,
+			/* 2-way interleave */
+			.interleave_ways = 1,
+			.granularity = 0,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = 0,
+			.window_size = SZ_256M * 8UL,
+		},
+		.target = { 0, 1, },
+	},
+	.cfmws8 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws8),
+			},
+			.interleave_arithmetic = 1,
+			/* 3-way interleave */
+			.interleave_ways = 8,
+			.granularity = 0,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = 0,
+			.window_size = SZ_256M * 12UL,
+		},
+		.target = { 0, 1, 2 },
+	},
+	.cfmws9 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws9),
+			},
+			.interleave_arithmetic = 1,
+			/* 4-way interleave */
+			.interleave_ways = 2,
+			.granularity = 0,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = 0,
+			.window_size = SZ_256M * 16UL,
+		},
+		.target = { 0, 1, 2, 3 },
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
+
 };
 
-struct acpi_cedt_cfmws *mock_cfmws[6] = {
+struct acpi_cedt_cfmws *mock_cfmws[10] = {
 	[0] = &mock_cedt.cfmws0.cfmws,
 	[1] = &mock_cedt.cfmws1.cfmws,
 	[2] = &mock_cedt.cfmws2.cfmws,
 	[3] = &mock_cedt.cfmws3.cfmws,
 	[4] = &mock_cedt.cfmws4.cfmws,
 	[5] = &mock_cedt.cfmws5.cfmws,
+	/* Modulo Math above, XOR Math below */
+	[6] = &mock_cedt.cfmws6.cfmws,
+	[7] = &mock_cedt.cfmws7.cfmws,
+	[8] = &mock_cedt.cfmws8.cfmws,
+	[9] = &mock_cedt.cfmws9.cfmws,
+};
+
+static int cfmws_start;
+static int cfmws_end;
+#define CFMWS_MOD_ARRAY_START 0
+#define CFMWS_MOD_ARRAY_END   5
+#define CFMWS_XOR_ARRAY_START 6
+#define CFMWS_XOR_ARRAY_END   9
+
+struct acpi_cedt_cxims *mock_cxims[1] = {
+	[0] = &mock_cedt.cxims0.cxims,
 };
 
 struct cxl_mock_res {
@@ -303,7 +434,7 @@ static int populate_cedt(void)
 		chbs->length = size;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(mock_cfmws); i++) {
+	for (i = cfmws_start; i <= cfmws_end; i++) {
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 
 		res = alloc_mock_res(window->window_size);
@@ -346,12 +477,19 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
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
 
@@ -432,6 +570,9 @@ mock_pci_root[NR_CXL_HOST_BRIDGES + NR_CXL_DIRECT_HOST_BRIDGES] = {
 	[2] = {
 		.bus = &mock_pci_bus[2],
 	},
+	[3] = {
+		.bus = &mock_pci_bus[3],
+	},
 };
 
 static bool is_mock_bus(struct pci_bus *bus)
@@ -713,6 +854,16 @@ static __init int cxl_test_init(void)
 	if (rc)
 		goto err_gen_pool_add;
 
+	if (interleave_arithmetic == 1) {
+		cfmws_start = CFMWS_XOR_ARRAY_START;
+		cfmws_end = CFMWS_XOR_ARRAY_END;
+		dev_dbg(NULL, "cxl_test loading xor_math option\n");
+	} else {
+		cfmws_start = CFMWS_MOD_ARRAY_START;
+		cfmws_end = CFMWS_MOD_ARRAY_END;
+		dev_dbg(NULL, "cxl_test loading default (modulo) option\n");
+	}
+
 	rc = populate_cedt();
 	if (rc)
 		goto err_populate;
@@ -926,6 +1077,8 @@ static __exit void cxl_test_exit(void)
 	unregister_cxl_mock_ops(&cxl_mock_ops);
 }
 
+module_param(interleave_arithmetic, int, 0000);
+MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.31.1

