Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FE409271
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951485; cv=none; b=axLFQZ+xJaRYDZsnVnDySER1qb786z0fOmUMY0iWIy5V8Vqb25kMKPnO2SiSDjoJ86CsTptJ/Z+3NSWiDjWWCrqUnadane3LPQmL+c8ZbFYjMO1ZwiYkI++RnqyZ7U2XOJbtZhfkQaZmfLXi6K8AEQGI0F0D0/xvN073PlhFLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951485; c=relaxed/simple;
	bh=/UkKqJLrZeif5jlc2le6r3UUb1JTAEOhTqPWX/V6eUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DD6fBYy2gIRwqlBiSv7U4qceCOKrEn0ytfpSw8M16tyes3Tzg7+FHl+ux+dzSee+yQYPIQrhHAScPZCg0Epqga5w3zSdI4l2gyoVJJT7uS2fT/45XMnYHMrpsw5GJ/FJ9hKLL3jGk44Ap/auso/ZBErGa7Mh4En/gXpFqSgaUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npX2VH9A; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npX2VH9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791951483; x=1823487483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UkKqJLrZeif5jlc2le6r3UUb1JTAEOhTqPWX/V6eUk=;
  b=npX2VH9ADCh4TGU6ELhImYQt9tyTzy3sUt4VRd6snVaxKNCuM6jkbFTf
   HWcBpD/ptedMNv5iAwF7QxHKlBd+TkItQ34UsaX1N6xn0etBc8pG3PDGT
   WeY+wbfqyB+Fi33JAqNuSPqjEsfEgPtCtRbbYEUXSqavS1vCWcApTspZF
   JQ36RHbEL8IH0BLIJIs3B2l4UaD+aCAHyZiTIiMBDLIjSS4rZOfzgtKGE
   KjPdtvi1djbuj7yVs00ljzSUjsw7GVHQITb7WAz6LW6+yGxLkUXbWAbG7
   vaOHqwNhA4egVgfqlD0xf1nIzB8204UhWHbKW4q0FpLdYPIcxxDxGYDw2
   Q==;
X-CSE-ConnectionGUID: c7cmzPxdTAyJ8UFxbWbzOQ==
X-CSE-MsgGUID: XBKUXQOzQyyP71sVm5szqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="696245"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="696245"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:02 -0700
X-CSE-ConnectionGUID: Z+NFufkuQLmppsshkggU1Q==
X-CSE-MsgGUID: FZ7ILZjpSTOhtMk7YOem9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1783576"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/4] cxl: Add KUnit tests for HDM decoder encoding helpers
Date: Tue, 13 Oct 2026 21:17:53 -0700
Message-ID: <73af16d29561eec944e128af116783e20b990dae.1791949910.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791949910.git.alison.schofield@intel.com>
References: <cover.1791949910.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL subsystem has no KUnit infrastructure for testing self-contained
logic.

Introduce CONFIG_CXL_KUNIT_TEST and drivers/cxl/.kunitconfig, along with
an initial suite for the HDM decoder interleave encoding helpers. The
suite checks valid and invalid encodings and round-trip conversions.

Use a single Kconfig option for all CXL KUnit suites, with each suite
built as a separate module. This allows new suites to be added without
requiring additional configuration options.

The HDM decoder helpers provide a starting point for establishing the
location, naming, and configuration conventions for future CXL KUnit tests.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/.kunitconfig               |   4 +
 drivers/cxl/Kconfig                    |  16 +++
 drivers/cxl/Makefile                   |   1 +
 drivers/cxl/tests/Makefile             |   5 +
 drivers/cxl/tests/hdm_encoding_kunit.c | 156 +++++++++++++++++++++++++
 5 files changed, 182 insertions(+)
 create mode 100644 drivers/cxl/.kunitconfig
 create mode 100644 drivers/cxl/tests/Makefile
 create mode 100644 drivers/cxl/tests/hdm_encoding_kunit.c

diff --git a/drivers/cxl/.kunitconfig b/drivers/cxl/.kunitconfig
new file mode 100644
index 000000000000..4fee684f5ff6
--- /dev/null
+++ b/drivers/cxl/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_PCI=y
+CONFIG_CXL_BUS=y
+CONFIG_CXL_KUNIT_TEST=y
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..fdd57a4118db 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -243,4 +243,20 @@ config CXL_ATL
 	depends on CXL_REGION
 	depends on ACPI_PRMT && AMD_NB
 
+config CXL_KUNIT_TEST
+	tristate "KUnit tests for CXL" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit tests for the CXL subsystem. When built
+	  as a module, each test suite is its own cxl_<name>_kunit
+	  module. This one option covers every CXL KUnit test, so new
+	  tests need no new configuration.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..d57fb0e9e7da 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_KUNIT_TEST) += tests/
 
 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
diff --git a/drivers/cxl/tests/Makefile b/drivers/cxl/tests/Makefile
new file mode 100644
index 000000000000..aa5e4f8e3638
--- /dev/null
+++ b/drivers/cxl/tests/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+ccflags-y += -I$(srctree)/drivers/cxl
+
+obj-$(CONFIG_CXL_KUNIT_TEST) += cxl_hdm_encoding_kunit.o
+cxl_hdm_encoding_kunit-y := hdm_encoding_kunit.o
diff --git a/drivers/cxl/tests/hdm_encoding_kunit.c b/drivers/cxl/tests/hdm_encoding_kunit.c
new file mode 100644
index 000000000000..54a7cb078a06
--- /dev/null
+++ b/drivers/cxl/tests/hdm_encoding_kunit.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for the HDM decoder interleave encode/decode helpers
+ * in drivers/cxl/cxl.h
+ */
+#include <kunit/test.h>
+#include "cxl.h"
+
+struct eiw_case {
+	u8 eiw;
+	int ways;
+};
+
+/* Encodings of the IW field in the HDM Decoder n Control Register */
+static const struct eiw_case valid_eiw[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 }, { 4, 16 },
+	{ 8, 3 }, { 9, 6 }, { 10, 12 },
+};
+
+static const u8 invalid_eiw[] = { 5, 6, 7, 11, 12, 13, 14, 15, 0xff };
+
+static const unsigned int invalid_ways[] = {
+	0, 5, 7, 9, 10, 11, 13, 14, 15, 17, 24, 32,
+};
+
+static void eiw_to_ways_valid(struct kunit *test)
+{
+	for (int i = 0; i < ARRAY_SIZE(valid_eiw); i++) {
+		int ways = 0;
+
+		KUNIT_EXPECT_EQ_MSG(test, eiw_to_ways(valid_eiw[i].eiw, &ways),
+				    0, "eiw=%u", valid_eiw[i].eiw);
+		KUNIT_EXPECT_EQ_MSG(test, ways, valid_eiw[i].ways, "eiw=%u",
+				    valid_eiw[i].eiw);
+	}
+}
+
+static void eiw_to_ways_invalid(struct kunit *test)
+{
+	for (int i = 0; i < ARRAY_SIZE(invalid_eiw); i++) {
+		int ways;
+
+		KUNIT_EXPECT_EQ_MSG(test, eiw_to_ways(invalid_eiw[i], &ways),
+				    -EINVAL, "eiw=%u", invalid_eiw[i]);
+	}
+}
+
+static void ways_to_eiw_valid(struct kunit *test)
+{
+	for (int i = 0; i < ARRAY_SIZE(valid_eiw); i++) {
+		u8 eiw = 0xff;
+
+		KUNIT_EXPECT_EQ_MSG(test, ways_to_eiw(valid_eiw[i].ways, &eiw),
+				    0, "ways=%d", valid_eiw[i].ways);
+		KUNIT_EXPECT_EQ_MSG(test, eiw, valid_eiw[i].eiw, "ways=%d",
+				    valid_eiw[i].ways);
+	}
+}
+
+static void ways_to_eiw_invalid(struct kunit *test)
+{
+	for (int i = 0; i < ARRAY_SIZE(invalid_ways); i++) {
+		u8 eiw;
+
+		KUNIT_EXPECT_EQ_MSG(test, ways_to_eiw(invalid_ways[i], &eiw),
+				    -EINVAL, "ways=%u", invalid_ways[i]);
+	}
+}
+
+static void eig_to_granularity_valid(struct kunit *test)
+{
+	for (u16 eig = 0; eig <= CXL_DECODER_MAX_ENCODED_IG; eig++) {
+		int gran = 0;
+		u16 back = 0xffff;
+
+		KUNIT_EXPECT_EQ_MSG(test, eig_to_granularity(eig, &gran), 0,
+				    "eig=%u", eig);
+		KUNIT_EXPECT_EQ_MSG(test, gran, 256 << eig, "eig=%u", eig);
+
+		/* Round trip back to the encoding */
+		KUNIT_EXPECT_EQ_MSG(test, granularity_to_eig(gran, &back), 0,
+				    "gran=%d", gran);
+		KUNIT_EXPECT_EQ_MSG(test, back, eig, "gran=%d", gran);
+	}
+}
+
+static void eig_to_granularity_invalid(struct kunit *test)
+{
+	static const u16 invalid_eig[] = { 7, 8, 15, 0xffff };
+
+	for (int i = 0; i < ARRAY_SIZE(invalid_eig); i++) {
+		int gran;
+
+		KUNIT_EXPECT_EQ_MSG(test,
+				    eig_to_granularity(invalid_eig[i], &gran),
+				    -EINVAL, "eig=%u", invalid_eig[i]);
+	}
+}
+
+static void granularity_to_eig_invalid(struct kunit *test)
+{
+	static const int invalid_gran[] = {
+		0, 1, 128, 255, 257, 384, 768, SZ_32K, -256,
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(invalid_gran); i++) {
+		u16 eig;
+
+		KUNIT_EXPECT_EQ_MSG(test,
+				    granularity_to_eig(invalid_gran[i], &eig),
+				    -EINVAL, "gran=%d", invalid_gran[i]);
+	}
+}
+
+/* Decoder Count field of the CXL HDM Decoder Capability Register */
+static void hdm_decoder_count(struct kunit *test)
+{
+	static const int expect[16] = {
+		1, 2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32,
+		-ENXIO, -ENXIO, -ENXIO,
+	};
+
+	for (u32 val = 0; val < ARRAY_SIZE(expect); val++) {
+		u32 cap = FIELD_PREP(CXL_HDM_DECODER_COUNT_MASK, val);
+
+		KUNIT_EXPECT_EQ_MSG(test, cxl_hdm_decoder_count(cap),
+				    expect[val], "count field=%u", val);
+	}
+
+	/* Bits outside the count field are ignored */
+	KUNIT_EXPECT_EQ(test,
+			cxl_hdm_decoder_count((u32)~CXL_HDM_DECODER_COUNT_MASK),
+			1);
+}
+
+static struct kunit_case cxl_hdm_encoding_cases[] = {
+	KUNIT_CASE(eiw_to_ways_valid),
+	KUNIT_CASE(eiw_to_ways_invalid),
+	KUNIT_CASE(ways_to_eiw_valid),
+	KUNIT_CASE(ways_to_eiw_invalid),
+	KUNIT_CASE(eig_to_granularity_valid),
+	KUNIT_CASE(eig_to_granularity_invalid),
+	KUNIT_CASE(granularity_to_eig_invalid),
+	KUNIT_CASE(hdm_decoder_count),
+	{}
+};
+
+static struct kunit_suite cxl_hdm_encoding_suite = {
+	.name = "cxl_hdm_encoding",
+	.test_cases = cxl_hdm_encoding_cases,
+};
+
+kunit_test_suite(cxl_hdm_encoding_suite);
+
+MODULE_DESCRIPTION("KUnit tests for CXL HDM decoder encoding helpers");
+MODULE_LICENSE("GPL");
-- 
2.37.3

