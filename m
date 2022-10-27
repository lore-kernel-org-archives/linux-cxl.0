Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C191FA3742
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Oct 2022 04:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiJ0EIB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Oct 2022 00:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiJ0EH7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Oct 2022 00:07:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F01153E39
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666843676; x=1698379676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LSCupKRwHiZXl4R0jkeEJVRxoLEL2AOmjhSxJqvK2Jc=;
  b=RfB9Co7HGmSMJi8G17246L5ZRzHqFUo9zcTWdPwipbMB/teZAYklM7gC
   5eVlPDI902WUgQN7uT4JUU0MRzgYlFcnDtGoWqrizExYSlYbCnLDEcmTH
   nxKDUInr1fD26BBbI7qXYn6+cxk9NEJRu6VcIObsRFRBG4qgctQDkOAqw
   XS+v1s0eKDparp02XKuSoRGNDJzY4j/+SlERUAmZ90aBJ8MHwXlkpbe+w
   gT/uoWmzNtZepsqv8+LGFcA143EqFxakAfQU5e/dpmjlGtqv80tZ7TZ+4
   h9j0t/gOYciASffNpqqIA+RJrXbZGEqq7hn3lWGwCspD4zBEoV/Po/MEu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="295533036"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="295533036"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:07:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="961475588"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="961475588"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.1.141])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:07:53 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 3/3] tools/testing/cxl: Add XOR Math support to cxl_test
Date:   Wed, 26 Oct 2022 21:07:43 -0700
Message-Id: <89cfaf7ec8e77635914f3fc0abb638fdca4f7e04.1666841669.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666841669.git.alison.schofield@intel.com>
References: <cover.1666841669.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Expand the cxl_test topology to include CFMWS's that use XOR math
for interleave arithmetic, as defined in the CXL Specification 3.0.

With this expanded topology, cxl_test is useful for testing
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
index a072b2d3e726..82f349cf84f5 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -11,6 +11,8 @@
 #include <cxlmem.h>
 #include "mock.h"
 
+static int interleave_arithmetic;
+
 #define NR_CXL_HOST_BRIDGES 2
 #define NR_CXL_ROOT_PORTS 2
 #define NR_CXL_SWITCH_PORTS 2
@@ -83,6 +85,22 @@ static struct {
 		struct acpi_cedt_cfmws cfmws;
 		u32 target[2];
 	} cfmws3;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[1];
+	} cfmws4;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[2];
+	} cfmws5;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[4];
+	} cfmws6;
+	struct {
+		struct acpi_cedt_cxims cxims;
+		u64 xormap_list[2];
+	} cxims0;
 } __packed mock_cedt = {
 	.cedt = {
 		.header = {
@@ -167,13 +185,88 @@ static struct {
 		},
 		.target = { 0, 1, },
 	},
+	/* .cfmws4,5,6 use XOR Math (interleave_arithmetic == 1) */
+	.cfmws4 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws4),
+			},
+			.interleave_arithmetic = 1,
+			.interleave_ways = 0,
+			.granularity = 4,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = 0,
+			.window_size = SZ_256M * 4UL,
+		},
+		.target = { 0 },
+	},
+	.cfmws5 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws5),
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
+	.cfmws6 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws6),
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
 
-struct acpi_cedt_cfmws *mock_cfmws[4] = {
+struct acpi_cedt_cfmws *mock_cfmws[7] = {
 	[0] = &mock_cedt.cfmws0.cfmws,
 	[1] = &mock_cedt.cfmws1.cfmws,
 	[2] = &mock_cedt.cfmws2.cfmws,
 	[3] = &mock_cedt.cfmws3.cfmws,
+	/* Modulo Math above, XOR Math below */
+	[4] = &mock_cedt.cfmws4.cfmws,
+	[5] = &mock_cedt.cfmws5.cfmws,
+	[6] = &mock_cedt.cfmws6.cfmws,
+};
+
+static int cfmws_start;
+static int cfmws_end;
+#define CFMWS_MOD_ARRAY_START 0
+#define CFMWS_MOD_ARRAY_END   3
+#define CFMWS_XOR_ARRAY_START 4
+#define CFMWS_XOR_ARRAY_END   6
+
+struct acpi_cedt_cxims *mock_cxims[1] = {
+	[0] = &mock_cedt.cxims0.cxims,
 };
 
 struct cxl_mock_res {
@@ -245,7 +338,7 @@ static int populate_cedt(void)
 		chbs->length = size;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(mock_cfmws); i++) {
+	for (i = cfmws_start; i <= cfmws_end; i++) {
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 
 		res = alloc_mock_res(window->window_size);
@@ -288,12 +381,19 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
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
 
@@ -644,6 +744,16 @@ static __init int cxl_test_init(void)
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
@@ -814,6 +924,8 @@ static __exit void cxl_test_exit(void)
 	unregister_cxl_mock_ops(&cxl_mock_ops);
 }
 
+module_param(interleave_arithmetic, int, 0000);
+MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.37.3

