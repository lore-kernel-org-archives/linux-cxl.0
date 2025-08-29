Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC6266B66
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452118; cv=none; b=A4Ig0q69Z60wHKYBf9UT8E40XgW1U3H4Vjvvl465ChiycLlGSTjQIyxhPCIPF6tqRXAMbcI3UWohTMJIctEmFhqKR8zMF4XB91G2ItUtyvYOFVBY5i+dpp3f37owma1WTIB0MoeS6JnkJClTZyMzjZ+jerYTYzzLr4gQvww2doM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452118; c=relaxed/simple;
	bh=aJ2B1cf38AcLEVoy8gJRBF1jsU9O75g9CPsIv+io+P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/432YFjwEzZ2uhL+luqe0TgZAphpkTb32/QWv6pXl5Bri12r1atOXQIV5lS+du04ePGYGOKe/NrRB5pcIyqIIpb4AOQ93LVfvPTMGRCBVZTTBr6yOPzWG4p8qxSTJCYcFAPMpeIYwIImtNw+0uAV7m63FOEODXKKBHwdtCWgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCHcumAn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCHcumAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756452117; x=1787988117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aJ2B1cf38AcLEVoy8gJRBF1jsU9O75g9CPsIv+io+P0=;
  b=nCHcumAnHPRGN9/+5hrRqIaAPP0M+FCrtV1bk9IUltZXvRbSZIleDjlm
   q4LU1hFF842wXhk7gOGq5SIAkAN55WvC6bgRERE60QzWFlQSWHxmWCHxT
   IgEMoiLhK7HWe3yDC0/TREi/+eHl7SQbAiju3kcGp4GWqXGELjB4zF9Cl
   +IO2RM7y1x+veMmpGOtuxCirl4NDrJmVd/jCpclr/GODX7XdlOGVxGyTi
   PPDuZLtSFmGxyqpdcm5DXxU11ENUfLbCyeMBPw9OcIE6UM0y5tg/OAANL
   OPxXlXlOKoCULMHpxl1MxGQIzSoJq17RyxEu/r/CtO+EdaP5weNY8/koP
   w==;
X-CSE-ConnectionGUID: 9fQe5zmFRY+NYz+t2s6LAA==
X-CSE-MsgGUID: QoazGqpsQlGt+LByQ2gyxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58585012"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58585012"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:21:55 -0700
X-CSE-ConnectionGUID: aqE7XjH0R86e/jX4INE5dg==
X-CSE-MsgGUID: uYjo1S/kRXyRIEy0qyJ11g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175613144"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.170])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:21:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 3/3] cxl/test: Add cxl_translate module for address translation testing
Date: Fri, 29 Aug 2025 00:21:27 -0700
Message-ID: <bb2fcaa2f21a0024c3291c113cc99a867513c845.1756446925.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1756446925.git.alison.schofield@intel.com>
References: <cover.1756446925.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a loadable test module that validates CXL address translation
calculations using parameterized test vectors. The module tests both
host to device and device to host address translations for Modulo and
XOR interleave arithmetic.

Test vectors are provided as module parameters in the format:
"dpa pos r_eiw r_eig hb_ways math expected_spa"

The module performs round-trip validation:
1. Translate a DPA and position to a SPA
2. Verify the result matches expected SPA
3. Translate that SPA back to a DPA and position
4. Verify round-trip consistency

The module accesses the refactored translation functions through the
exports made available only to CXL test modules.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 tools/testing/cxl/Kbuild               |   2 +
 tools/testing/cxl/cxl_acpi_exports.c   |   7 +
 tools/testing/cxl/cxl_core_exports.c   |  12 +
 tools/testing/cxl/cxl_test.h           |  18 ++
 tools/testing/cxl/test/Kbuild          |   2 +
 tools/testing/cxl/test/cxl_translate.c | 303 +++++++++++++++++++++++++
 6 files changed, 344 insertions(+)
 create mode 100644 tools/testing/cxl/cxl_acpi_exports.c
 create mode 100644 tools/testing/cxl/cxl_test.h
 create mode 100644 tools/testing/cxl/test/cxl_translate.c

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index d07f14cb7aa4..95397434fc12 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -21,6 +21,7 @@ CXL_SRC := $(DRIVERS)/cxl
 CXL_CORE_SRC := $(DRIVERS)/cxl/core
 ccflags-y := -I$(srctree)/drivers/cxl/
 ccflags-y += -D__mock=__weak
+ccflags-y += -D__mock_export=
 ccflags-y += -DTRACE_INCLUDE_PATH=$(CXL_CORE_SRC) -I$(srctree)/drivers/cxl/core/
 
 obj-m += cxl_acpi.o
@@ -29,6 +30,7 @@ cxl_acpi-y := $(CXL_SRC)/acpi.o
 cxl_acpi-y += mock_acpi.o
 cxl_acpi-y += config_check.o
 cxl_acpi-y += cxl_acpi_test.o
+cxl_acpi-y += cxl_acpi_exports.o
 
 obj-m += cxl_pmem.o
 
diff --git a/tools/testing/cxl/cxl_acpi_exports.c b/tools/testing/cxl/cxl_acpi_exports.c
new file mode 100644
index 000000000000..b66fa0696db1
--- /dev/null
+++ b/tools/testing/cxl/cxl_acpi_exports.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include "cxl_test.h"
+
+/* Export of cxl_acpi (acpi.o) symbol used only by cxl_translate */
+EXPORT_SYMBOL_NS_GPL(cxl_do_xormap_calc, "CXL");
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index f088792a8925..4927797dfa31 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -2,6 +2,18 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
 #include "cxl.h"
+#include "cxl_test.h"
 
 /* Exporting of cxl_core symbols that are only used by cxl_test */
 EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
+
+/*
+ * Exporting of cxl_core symbols used only by the cxl_translate module.
+ *
+ * Note: checkpatch warns about EXPORT_SYMBOL placement, but this is
+ * the established pattern for CXL test exports where functions are
+ * defined in drivers/cxl/core/.
+ */
+EXPORT_SYMBOL_NS_GPL(cxl_calculate_hpa_offset, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_calculate_dpa_offset, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_calculate_position, "CXL");
diff --git a/tools/testing/cxl/cxl_test.h b/tools/testing/cxl/cxl_test.h
new file mode 100644
index 000000000000..94777d999cb3
--- /dev/null
+++ b/tools/testing/cxl/cxl_test.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CXL_TEST_H__
+#define __CXL_TEST_H__
+
+#include <linux/acpi.h>
+
+/* Function declarations only visible to test code */
+
+/* XOR calculation function from drivers/cxl/acpi.c */
+u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw);
+
+/* Address translation functions from drivers/cxl/core/region.c */
+u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig);
+u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig);
+int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig);
+
+#endif
diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
index 6b1927897856..d55973e61fdd 100644
--- a/tools/testing/cxl/test/Kbuild
+++ b/tools/testing/cxl/test/Kbuild
@@ -5,6 +5,8 @@ obj-m += cxl_test.o
 obj-m += cxl_mock.o
 obj-m += cxl_mock_mem.o
 
+obj-m += cxl_translate.o
+
 cxl_test-y := cxl.o
 cxl_mock-y := mock.o
 cxl_mock_mem-y := mem.o
diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
new file mode 100644
index 000000000000..f7076f4069d4
--- /dev/null
+++ b/tools/testing/cxl/test/cxl_translate.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2025 Intel Corporation. All rights reserved.
+
+#include <linux/moduleparam.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+#include <cxlmem.h>
+
+#include "../cxl_test.h"
+
+/* Maximum number of test vectors and entry length */
+#define MAX_TABLE_ENTRIES 128
+#define MAX_ENTRY_LEN 128
+
+/* Expected number of parameters in each test vector */
+#define EXPECTED_PARAMS 7
+
+/* Module parameters for test vectors */
+static char *table[MAX_TABLE_ENTRIES];
+static int table_num;
+
+/* Interleave Arithmetic */
+#define MODULO_MATH 0
+#define XOR_MATH 1
+
+/*
+ * XOR mapping configuration
+ * The test data sets all use the same set of xormaps. When additional
+ * data sets arrive for validation, this static setup will need to
+ * be changed to accept xormaps as additional parameters.
+ */
+struct cxl_cxims_data *cximsd;
+static u64 xormaps[] = {
+	0x2020900,
+	0x4041200,
+	0x1010400,
+	0x800,
+};
+
+static int nr_maps = ARRAY_SIZE(xormaps);
+
+/**
+ * to_hpa - calculate an HPA offset from a DPA offset and position
+ *
+ * dpa_offset: device physical address offset
+ * pos: devices position in interleave
+ * r_eiw: region encoded interleave ways
+ * r_eig: region encoded interleave granularity
+ * hb_ways: host bridge interleave ways
+ * math: interleave arithmetic (MODULO_MATH or XOR_MATH)
+ *
+ * Returns: host physical address offset
+ */
+static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
+		  u8 math)
+{
+	u64 hpa_offset;
+
+	/* Calculate base HPA offset from DPA and position */
+	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
+
+	/* Apply XOR mapping if specified */
+	if (math == XOR_MATH)
+		hpa_offset = cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
+
+	return hpa_offset;
+}
+
+/**
+ * to_dpa - translate an HPA offset to DPA offset
+ *
+ * hpa_offset: host physical address offset
+ * r_eiw: region encoded interleave ways
+ * r_eig: region encoded interleave granularity
+ * hb_ways: host bridge interleave ways
+ * math: interleave arithmetic (MODULO_MATH or XOR_MATH)
+ *
+ * Returns: device physical address offset
+ */
+static u64 to_dpa(u64 hpa_offset, u8 r_eiw, u16 r_eig, u8 hb_ways, u8 math)
+{
+	u64 offset = hpa_offset;
+
+	/* Reverse XOR mapping if specified */
+	if (math == XOR_MATH)
+		offset = cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
+
+	return cxl_calculate_dpa_offset(offset, r_eiw, r_eig);
+}
+
+/**
+ * to_pos - extract an interleave position from an HPA offset
+ *
+ * hpa_offset: host physical address offset
+ * r_eiw: region encoded interleave ways
+ * r_eig: region encoded interleave granularity
+ * hb_ways: host bridge interleave ways
+ * math: interleave arithmetic (MODULO_MATH or XOR_MATH)
+ *
+ * Returns: devices position in region interleave
+ */
+static u64 to_pos(u64 hpa_offset, u8 r_eiw, u16 r_eig, u8 hb_ways, u8 math)
+{
+	u64 offset = hpa_offset;
+
+	/* Reverse XOR mapping if specified */
+	if (math == XOR_MATH)
+		offset = cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
+
+	return cxl_calculate_position(offset, r_eiw, r_eig);
+}
+
+/**
+ * run_translation_test - execute forward and reverse translations
+ *
+ * @dpa: device physical address
+ * @pos: expected position in region interleave
+ * @r_eiw: region encoded interleave ways
+ * @r_eig: region encoded interleave granularity
+ * @hb_ways: host bridge interleave ways
+ * @math: interleave arithmetic (MODULO_MATH or XOR_MATH)
+ * @expect_spa: expected system physical address
+ *
+ * Returns: 0 on success, -1 on failure
+ */
+static int run_translation_test(u64 dpa, int pos, u8 r_eiw, u16 r_eig,
+				u8 hb_ways, int math, u64 expect_hpa)
+{
+	u64 translated_spa, reverse_dpa;
+	int reverse_pos;
+
+	/* Test Device to Host translation: DPA + POS -> SPA */
+	translated_spa = to_hpa(dpa, pos, r_eiw, r_eig, hb_ways, math);
+	if (translated_spa != expect_hpa) {
+		pr_err("Device to host failed: expected HPA %llu, got %llu\n",
+		       expect_hpa, translated_spa);
+		return -1;
+	}
+
+	/* Test Host to Device DPA translation: SPA -> DPA */
+	reverse_dpa = to_dpa(translated_spa, r_eiw, r_eig, hb_ways, math);
+	if (reverse_dpa != dpa) {
+		pr_err("Host to Device DPA failed: expected %llu, got %llu\n",
+		       dpa, reverse_dpa);
+		return -1;
+	}
+
+	/* Test Host to Device Position translation: SPA -> POS */
+	reverse_pos = to_pos(translated_spa, r_eiw, r_eig, hb_ways, math);
+	if (reverse_pos != pos) {
+		pr_err("Position lookup failed: expected %d, got %d\n", pos,
+		       reverse_pos);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * parse_test_vector - parse a single test vector string
+ *
+ * entry: test vector string to parse
+ * dpa: device physical address
+ * pos: expected position in region interleave
+ * r_eiw: region encoded interleave ways
+ * r_eig: region encoded interleave granularity
+ * hb_ways: host bridge interleave ways
+ * math: interleave arithmetic (MODULO_MATH or XOR_MATH)
+ * expect_spa: expected system physical address
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+static int parse_test_vector(const char *entry, u64 *dpa, int *pos, u8 *r_eiw,
+			     u16 *r_eig, u8 *hb_ways, int *math,
+			     u64 *expect_hpa)
+{
+	unsigned int tmp_r_eiw, tmp_r_eig, tmp_hb_ways;
+	int parsed;
+
+	parsed = sscanf(entry, "%llu %d %u %u %u %d %llu", dpa, pos, &tmp_r_eiw,
+			&tmp_r_eig, &tmp_hb_ways, math, expect_hpa);
+
+	if (parsed != EXPECTED_PARAMS) {
+		pr_err("Parse error: expected %d parameters, got %d in '%s'\n",
+		       EXPECTED_PARAMS, parsed, entry);
+		return -EINVAL;
+	}
+	if (tmp_r_eiw > U8_MAX || tmp_r_eig > U16_MAX || tmp_hb_ways > U8_MAX) {
+		pr_err("Parameter overflow in entry: '%s'\n", entry);
+		return -ERANGE;
+	}
+	if (*math != MODULO_MATH && *math != XOR_MATH) {
+		pr_err("Invalid math type %d in entry: '%s'\n", *math, entry);
+		return -EINVAL;
+	}
+	*r_eiw = tmp_r_eiw;
+	*r_eig = tmp_r_eig;
+	*hb_ways = tmp_hb_ways;
+
+	return 0;
+}
+
+/*
+ * setup_xor_mapping - Initialize XOR mapping data structure
+ *
+ * The test data sets all use the same set of xormaps. When additional
+ * data sets arrive for validation, this static setup will need to
+ * be changed to accept xormaps as additional parameters.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+static int setup_xor_mapping(void)
+{
+	if (nr_maps <= 0)
+		return -EINVAL;
+
+	cximsd = kzalloc(struct_size(cximsd, xormaps, nr_maps), GFP_KERNEL);
+	if (!cximsd)
+		return -ENOMEM;
+
+	memcpy(cximsd->xormaps, xormaps, nr_maps * sizeof(*cximsd->xormaps));
+	cximsd->nr_maps = nr_maps;
+
+	return 0;
+}
+
+/*
+ * cxl_translate_init - parse test vectors and kicks off translation tests
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+static int __init cxl_translate_init(void)
+{
+	int ret, i;
+
+	/* Validate module parameters */
+	if (table_num == 0) {
+		pr_err("No test vectors provided\n");
+		return -EINVAL;
+	}
+
+	pr_info("CXL translate test module loaded with %d test vectors\n",
+		table_num);
+
+	ret = setup_xor_mapping();
+	if (ret)
+		return ret;
+
+	/* Process each test vector */
+	for (i = 0; i < table_num; i++) {
+		u64 dpa, expect_spa;
+		int pos, math;
+		u8 r_eiw, hb_ways;
+		u16 r_eig;
+
+		pr_debug("Processing test vector %d: '%s'\n", i, table[i]);
+
+		/* Parse the test vector */
+		ret = parse_test_vector(table[i], &dpa, &pos, &r_eiw, &r_eig,
+					&hb_ways, &math, &expect_spa);
+		if (ret) {
+			pr_err("CXL Translate Test %d: FAIL\n"
+			       "    Failed to parse test vector '%s'\n",
+			       i, table[i]);
+			continue;
+		}
+		/* Run the translation test */
+		ret = run_translation_test(dpa, pos, r_eiw, r_eig, hb_ways,
+					   math, expect_spa);
+		if (ret) {
+			pr_err("CXL Translate Test %d: FAIL\n"
+			       "    dpa=%llu pos=%d r_eiw=%u r_eig=%u hb_ways=%u math=%s expect_spa=%llu\n",
+			       i, dpa, pos, r_eiw, r_eig, hb_ways,
+			       (math == XOR_MATH) ? "XOR" : "MODULO",
+			       expect_spa);
+		} else {
+			pr_info("CXL Translate Test %d: PASS\n", i);
+		}
+	}
+
+	pr_info("CXL translate test completed\n");
+	return 0;
+}
+
+static void __exit cxl_translate_exit(void)
+{
+	kfree(cximsd);
+
+	pr_info("CXL translate test module unloaded\n");
+}
+
+module_param_array(table, charp, &table_num, 0444);
+MODULE_PARM_DESC(table, "Test vectors as space-separated decimal strings");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("cxl_test: cxl address translation test module");
+MODULE_IMPORT_NS("CXL");
+
+module_init(cxl_translate_init);
+module_exit(cxl_translate_exit);
-- 
2.37.3

