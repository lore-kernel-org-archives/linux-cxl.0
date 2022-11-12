Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C8DC43217
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Nov 2022 04:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiKLElj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Nov 2022 23:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiKLElg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Nov 2022 23:41:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA5E01F
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 20:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668228095; x=1699764095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lpRLTPl2SE69uU6JVBTffT9AY6g0GPR3KrY7U8pH2jU=;
  b=V+kEGzOlXFfNCwxAxKtptZL+Wa8CYGxkSMYGKv11RZuWcnFWxljAg8qD
   WEKpKhugNU3n97n0C6IqUHwCfOIORlgUF6c82XMYT66dVaCvd/91ccP26
   p8BC5vZTsfitqWVbK0q/gaNTgO3oKLavOZK0ZsPdbkSfGGRs1ekPPpqn8
   sQz+vFusrmVgr+O37/a9vXZbw63kcZ0haDuQI5x6qHH7ylqD9IE9/wiWK
   KpMqh3vvbLtHeqbArcRYgwoGBwYSAlJubRD8BnnHn38ll30mYkQGl9pYG
   XIeqEte7TBKHyDucKWsmUSsSq6SwijQ/Z+Z1U2jdHI9PNw0wUGYt3KJBi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="375968591"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="375968591"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:41:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="670920052"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="670920052"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.134.249])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:41:35 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v6 3/3] tools/testing/cxl: Add XOR Math support to cxl_test
Date:   Fri, 11 Nov 2022 20:41:29 -0800
Message-Id: <4992a372d362c02206c2d331974f6761b5001392.1668227077.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668227077.git.alison.schofield@intel.com>
References: <cover.1668227077.git.alison.schofield@intel.com>
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

