Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646922;
	b=QQuSfaD1wYjxauGUvqMni+GO0EbdvgLH567kO0WnriBNETm8C7mwZwaZTNrICKMWUwc0
	 bftCcb8E8N770FtVexKncIGfTPTqtRPx5ra9zzB8nLEnk//ImeW1BtqLgpjB8MO1n4FrL
	 SNAlJf7ZPiU8bMdfRnjQE7DnLabui5ja2YEXGSwytVlshRuMpZoILVM5KpKgI4YbMLTOn
	 87QjSl9PNueIgiteW0lH/OuwLEl9qxRR4rJpN3QwqzgC3Ga1U4ujp3wO6xaljDPaHmj+I
	 m9EvIVdZyhoaMB2Z3SdFKoxe2iYvJs87Rd44Fras8JMkS0qGYAdXdrJW5NIx8rlJFng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646922;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9GFLo/L8+kP6Z95RmOvcRjCJQj/Orxt/888I0Q7hon0=;
	b=Jb6TDfLFWEEt8fLowsJqDUTWyb4cnjgrUB5vdcxUpk+cmEb/AMsoh/fcQHr51UO+PdEM
	 Wo5WSeLlJauJ4Y+uBWMhcXinhBvWCOYc9ty/RjO28MyAsAq72M9WPqzc4sVTxfn0tFSMo
	 we76Psw8LwFbSqz12wGnYZq4XK4LM6YqqJE6LEA1BuJCsDlR9ufoBqokCSI/OmR4fGY6k
	 vSZE4lBSy0oIyeTawBgyMewxPOOsQO+RKOwEvnj9mhaA7und63rUyKZ3rfKL8Yi+NnK1R
	 33SChEQnM/M/TuHqF7u+A0F56cAOEMVlcwSfhEzGJzxLp3u7sITGn3EqW4egVoN4nEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrvKCRV1;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E0606D810
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 19:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 013E0606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrvKCRV1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793646921; x=1825182921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l0eXxg7PpFTTILBDdUBjyoJvQYLD1VYjRMOLQlZdm0k=;
  b=GrvKCRV1oE1KcuwXd0+4ttXiQCcoe3/Fa0Y4MmL/KTOvAdWDmd5lDOta
   gCdM3M5ZcRSH7Zfn2lvD9NxLcF9vFck2Nc30avYwF+UT0JUPNQ46+NlZQ
   PMtG9gjS5bFXrpFZYSsa4dIMY//WXHk3Drmoek+yi0dHD/CAdZhO8ooTe
   VSk6OfawKL4cktk/DBVjmdxWbTSz6/0687UDcjKOb+FriHIp/gkaqccUs
   2kAvU+G3xHcKjRYtIUotmYI9N4StkfLTuedII4557VYjcxXJUpmuOolVo
   WhQm1NE9UrZo7HwDsnLO1MVG3GeW1T/i3aDnHxMoV5QH8aMa1Twxww339
   g==;
X-CSE-ConnectionGUID: maFtPHHzQg2nbmhccrAR/w==
X-CSE-MsgGUID: 8goeqhgzQgmlAFy2hMUbDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2383490"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2383490"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:15:20 -0800
X-CSE-ConnectionGUID: 7sIlhUj4RRixBgCXP57f+w==
X-CSE-MsgGUID: 0qa+ncIYS2SPcfUzt1T7Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6294153"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:15:20 -0800
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
Subject: [PATCH v2 4/4] cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()
Date: Mon,  2 Nov 2026 11:15:14 -0800
Message-ID: <7e9ed4f09b2fb56847c58e0fc5a9b2590d6576f2.1793645996.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793645996.git.alison.schofield@intel.com>
References: <cover.1793645996.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/driver-api/cxl/testing.rst |   3 +
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/tests/Makefile          |   5 +
 drivers/cxl/core/tests/mbox_kunit.c      | 250 +++++++++++++++++++++++
 4 files changed, 259 insertions(+)
 create mode 100644 drivers/cxl/core/tests/Makefile
 create mode 100644 drivers/cxl/core/tests/mbox_kunit.c

diff --git a/Documentation/driver-api/cxl/testing.rst b/Documentation/driver-api/cxl/testing.rst
index 923492b6bfa9..6ce1cb581ec4 100644
--- a/Documentation/driver-api/cxl/testing.rst
+++ b/Documentation/driver-api/cxl/testing.rst
@@ -122,6 +122,9 @@ A CXL KUnit test follows these rules:
 - Use exported interfaces where possible, importing the CXL symbol namespace as
   needed.
 
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
index 000000000000..9c0f3355ff16
--- /dev/null
+++ b/drivers/cxl/core/tests/mbox_kunit.c
@@ -0,0 +1,250 @@
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
+	mock->return_code = CXL_MBOX_CMD_RC_SUCCESS;
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

