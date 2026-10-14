Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2D41442D
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951487; cv=none; b=M8+3ukqxtWhMZeTC2x9eehh0o4MJqudcrke7l5E7SI9ZE80iihv7Wiv0FbjZ4e3pY6CGRNILVPeBdyIKwf/Q8iTon0FZb1WQ9IJ/+M66VRI3PPXfOD4rEas6EP99qpSmL6UgewYehcT8nBEt/iDv8FvV488ujYiPdWsSA6+A+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951487; c=relaxed/simple;
	bh=pDenK4fQVsShGl6HdhGO4e2WQ8dMmEfi35anl6G1zjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ihl+3yY+KN2B3Q7kIacrvHxBI31cP4ohHUiaEun8EonoV8oTNN/AfAYu61IiHSQ9vqHLX9JE7SA96i6wf4GdaxfnoMTBb5tnlaIQDyUPrVllBPxmNuNB3MUCAhmdrqjklqpNAjpSt9kjtj1HKVM/gxaWcFJkvheKLQrhZOdgjtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c36QNhtr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c36QNhtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791951485; x=1823487485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pDenK4fQVsShGl6HdhGO4e2WQ8dMmEfi35anl6G1zjM=;
  b=c36QNhtr0F63KYgb2ku7zZhYtdaUOGD/6KzDmk/CuwOlYJB8p7p4qzi8
   E3TCjD68t85WPRDn1ZAcevksfao+ndLVFLwpDiuicmcrRnzrH884zqUUm
   H3F594TQH/HBjj0A+eVGTpO8Od9blO7nDqRt1ipuLvkZdk0JX3hpyXp0c
   hXQS8VDOmmxuTbrw+TE2D3Sm4pVTo+00HbQURP9EUFZo9odAAyIB3zAHb
   Vs/XNjy8cEO4xFpgpX3fZRciY4xKpHxYL0ZO+p60k90nEaG1EnvMSCiFJ
   KC3YneVIxMSy5UC4ubeGPnyi3T5SmBxVusX00YfzD/UCnME4xcHFny7fm
   Q==;
X-CSE-ConnectionGUID: j/qvzqViREiDOXqItdCkZQ==
X-CSE-MsgGUID: 7ZHzWSMxQw620xOZcsxiJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="696261"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="696261"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:04 -0700
X-CSE-ConnectionGUID: ISyJKMJ8Rd2Rdvk3g6DWXg==
X-CSE-MsgGUID: IlOi0+9tRWihMnwMoeN0UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1783586"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:04 -0700
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
Subject: [PATCH 4/4] cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()
Date: Tue, 13 Oct 2026 21:17:55 -0700
Message-ID: <ccb2c0974781ec3500c56e82c61eb3026c73d183.1791949910.git.alison.schofield@intel.com>
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

cxl_internal_send_cmd() validates mailbox payload sizes, translates device
return codes to errnos, and checks returned output sizes. Existing cxl_test
coverage does not exercise many of its error paths.

Add a KUnit suite that replaces mbox_send() with a stub transport, allowing
tests to control transport errors, device return codes, and output sizes.

The suite covers command forwarding, payload size limits, transport errors,
defined and unknown device return codes, background commands, and fixed
versus variable output sizes.

The unknown return code cases provide regression coverage for "cxl/mbox:
Treat unknown device return codes as errors". Without that change, the
tests fail and KASAN reports a global out-of-bounds read.

The suite uses the existing CONFIG_CXL_KUNIT_TEST option, allowing it to
run without additional configuration.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/driver-api/cxl/testing.rst |   3 +
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/tests/Makefile          |   5 +
 drivers/cxl/core/tests/mbox_kunit.c      | 249 +++++++++++++++++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 drivers/cxl/core/tests/Makefile
 create mode 100644 drivers/cxl/core/tests/mbox_kunit.c

diff --git a/Documentation/driver-api/cxl/testing.rst b/Documentation/driver-api/cxl/testing.rst
index e3e2613172a2..8d1eb5722334 100644
--- a/Documentation/driver-api/cxl/testing.rst
+++ b/Documentation/driver-api/cxl/testing.rst
@@ -103,6 +103,9 @@ A CXL KUnit test follows these rules:
 
 - Use exported interfaces where possible, importing the CXL symbol namespace as needed.
 
+For an example of testing mailbox command handling with a stub transport, see
+drivers/cxl/core/tests/mbox_kunit.c.
+
 When to add a test
 ==================
 
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..b2627933b7fb 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
+obj-$(CONFIG_CXL_KUNIT_TEST) += tests/
 
 ccflags-y += -I$(srctree)/drivers/cxl
 CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
diff --git a/drivers/cxl/core/tests/Makefile b/drivers/cxl/core/tests/Makefile
new file mode 100644
index 000000000000..08d97303d0d1
--- /dev/null
+++ b/drivers/cxl/core/tests/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+ccflags-y += -I$(srctree)/drivers/cxl
+
+obj-$(CONFIG_CXL_KUNIT_TEST) += cxl_core_mbox_kunit.o
+cxl_core_mbox_kunit-y := mbox_kunit.o
diff --git a/drivers/cxl/core/tests/mbox_kunit.c b/drivers/cxl/core/tests/mbox_kunit.c
new file mode 100644
index 000000000000..68f9fe87d743
--- /dev/null
+++ b/drivers/cxl/core/tests/mbox_kunit.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for cxl_internal_send_cmd() using a stub mailbox
+ * transport in place of hardware.
+ */
+#include <kunit/test.h>
+#include <cxl/mailbox.h>
+#include "cxlmem.h"
+
+#define TEST_PAYLOAD_SIZE SZ_4K
+
+/*
+ * Stub transport state: what the "device" returns, and a record of
+ * what the core passed down.
+ */
+struct mock_mbox {
+	struct cxl_mailbox cxl_mbox;
+	int send_rc;
+	u16 return_code;
+	size_t size_out;
+	int calls;
+	struct cxl_mbox_cmd seen;
+};
+
+static int mock_mbox_send(struct cxl_mailbox *cxl_mbox,
+			  struct cxl_mbox_cmd *cmd)
+{
+	struct mock_mbox *mock;
+
+	mock = container_of(cxl_mbox, struct mock_mbox, cxl_mbox);
+	mock->calls++;
+	mock->seen = *cmd;
+	if (mock->send_rc)
+		return mock->send_rc;
+
+	cmd->return_code = mock->return_code;
+	cmd->size_out = mock->size_out;
+	return 0;
+}
+
+static int cxl_mbox_test_init(struct kunit *test)
+{
+	struct mock_mbox *mock;
+
+	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mock);
+
+	mock->cxl_mbox.payload_size = TEST_PAYLOAD_SIZE;
+	mock->cxl_mbox.mbox_send = mock_mbox_send;
+	test->priv = mock;
+
+	return 0;
+}
+
+static void send_success(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+	u8 in[16], out[64];
+	struct cxl_mbox_cmd cmd = {
+		.opcode = CXL_MBOX_OP_IDENTIFY,
+		.payload_in = in,
+		.size_in = sizeof(in),
+		.payload_out = out,
+		.size_out = sizeof(out),
+	};
+
+	mock->size_out = sizeof(out);
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
+	KUNIT_EXPECT_EQ(test, mock->calls, 1);
+
+	/* The command reaches the transport as the caller built it */
+	KUNIT_EXPECT_EQ(test, mock->seen.opcode, CXL_MBOX_OP_IDENTIFY);
+	KUNIT_EXPECT_PTR_EQ(test, mock->seen.payload_in, (void *)in);
+	KUNIT_EXPECT_EQ(test, mock->seen.size_in, sizeof(in));
+	KUNIT_EXPECT_PTR_EQ(test, mock->seen.payload_out, (void *)out);
+	KUNIT_EXPECT_EQ(test, mock->seen.size_out, sizeof(out));
+}
+
+static void send_no_output(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+	struct cxl_mbox_cmd cmd = {};
+
+	/* No output was requested, so the returned size is not checked */
+	mock->size_out = 0;
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
+}
+
+static void send_size_in_too_big(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+	struct cxl_mbox_cmd cmd = {
+		.size_in = TEST_PAYLOAD_SIZE + 1,
+	};
+
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
+			-E2BIG);
+	KUNIT_EXPECT_EQ(test, mock->calls, 0);
+}
+
+static void send_size_out_too_big(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+	struct cxl_mbox_cmd cmd = {
+		.size_out = TEST_PAYLOAD_SIZE + 1,
+	};
+
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
+			-E2BIG);
+	KUNIT_EXPECT_EQ(test, mock->calls, 0);
+}
+
+static void send_full_payload(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+	struct cxl_mbox_cmd cmd = {
+		.size_in = TEST_PAYLOAD_SIZE,
+		.size_out = TEST_PAYLOAD_SIZE,
+	};
+
+	mock->size_out = TEST_PAYLOAD_SIZE;
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
+}
+
+static void send_transport_error(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+	struct cxl_mbox_cmd cmd = {};
+
+	mock->send_rc = -ETIMEDOUT;
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
+			-ETIMEDOUT);
+}
+
+static void send_device_error(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+
+	/* Every defined error code fails the command */
+	for (u16 code = CXL_MBOX_CMD_RC_INPUT;
+	     code < ARRAY_SIZE(cxl_mbox_cmd_rctable); code++) {
+		struct cxl_mbox_cmd cmd = {};
+		int expect, rc;
+
+		switch (code) {
+		case CXL_MBOX_CMD_RC_PADDR:
+			expect = -EFAULT;
+			break;
+		case CXL_MBOX_CMD_RC_POISONLMT:
+			expect = -EBUSY;
+			break;
+		default:
+			expect = -ENXIO;
+			break;
+		}
+
+		mock->return_code = code;
+		rc = cxl_internal_send_cmd(&mock->cxl_mbox, &cmd);
+		KUNIT_EXPECT_EQ_MSG(test, rc, expect, "return_code=%#x", code);
+	}
+}
+
+static void send_unknown_return_code(struct kunit *test)
+{
+	static const u16 codes[] = { ARRAY_SIZE(cxl_mbox_cmd_rctable), 0x100,
+				     0xffff };
+	struct mock_mbox *mock = test->priv;
+
+	/* Codes the driver does not know are still device errors */
+	for (int i = 0; i < ARRAY_SIZE(codes); i++) {
+		struct cxl_mbox_cmd cmd = {};
+		int rc;
+
+		mock->return_code = codes[i];
+		rc = cxl_internal_send_cmd(&mock->cxl_mbox, &cmd);
+		KUNIT_EXPECT_EQ_MSG(test, rc, -ENXIO, "return_code=%#x",
+				    codes[i]);
+		KUNIT_EXPECT_STREQ_MSG(test, cxl_mbox_cmd_rc2str(&cmd),
+				       "unknown return code", "return_code=%#x",
+				       codes[i]);
+	}
+}
+
+static void send_background_started(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+	struct cxl_mbox_cmd cmd = {};
+
+	/* A background command that started is not an error */
+	mock->return_code = CXL_MBOX_CMD_RC_BACKGROUND;
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
+}
+
+static void send_short_fixed_output(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+	struct cxl_mbox_cmd cmd = {
+		.size_out = 64,
+	};
+
+	/* Without min_out, the full requested size is required */
+	mock->size_out = 63;
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
+			-EIO);
+}
+
+static void send_variable_output(struct kunit *test)
+{
+	struct mock_mbox *mock = test->priv;
+	struct cxl_mbox_cmd cmd;
+
+	/* Output at or above min_out is accepted */
+	cmd = (struct cxl_mbox_cmd){ .size_out = 64, .min_out = 8 };
+	mock->size_out = 8;
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
+
+	/* Output below min_out is rejected */
+	cmd = (struct cxl_mbox_cmd){ .size_out = 64, .min_out = 8 };
+	mock->size_out = 7;
+	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
+			-EIO);
+}
+
+static struct kunit_case cxl_core_mbox_cases[] = {
+	KUNIT_CASE(send_success),
+	KUNIT_CASE(send_no_output),
+	KUNIT_CASE(send_size_in_too_big),
+	KUNIT_CASE(send_size_out_too_big),
+	KUNIT_CASE(send_full_payload),
+	KUNIT_CASE(send_transport_error),
+	KUNIT_CASE(send_device_error),
+	KUNIT_CASE(send_unknown_return_code),
+	KUNIT_CASE(send_background_started),
+	KUNIT_CASE(send_short_fixed_output),
+	KUNIT_CASE(send_variable_output),
+	{}
+};
+
+static struct kunit_suite cxl_core_mbox_suite = {
+	.name = "cxl_core_mbox",
+	.init = cxl_mbox_test_init,
+	.test_cases = cxl_core_mbox_cases,
+};
+
+kunit_test_suite(cxl_core_mbox_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the CXL mailbox command core");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("CXL");
-- 
2.37.3

