Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5A46D096
	for <linux-cxl@vger.kernel.org>; Thu, 15 Oct 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057066; cv=pass; b=JpUiMclanYOnQKHPkwqQb6V/Y0SP7XR//RA8YZ8Oqm9xMUOQ4FUhd8BqRpuE/WCm7pps1hUylxqKhiBNXk71i9k7FFN4MUDgmHssh8NJbdyXCtb+3tMoiT2PjBFJD3TgOyHpKrMojLK5+5JuZgYMhfwOeWV9UmHOo6kNWWw/esw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057066; c=relaxed/simple;
	bh=XseqZYxtyxi5+WFgLEVQIrzzvtGa2+F/zBuYwUe/bpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpCY0Ib9ZNJLfuWfn3vIyaQS6A7RgJ9lZ1gFLEcUVZlsn/zRISXVMHiZeFG13fCr2D0dk6KDEievoudOgw7QsUNAAxpuB4VQ20DXzHx4kzFSf27hLX1bZlPH76BdKJvVBFAp/D4DufmmAKEv2/rHksDRJ09Os5Z32vB0DXiluhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=IUzAGapU; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="IUzAGapU"
ARC-Seal: i=1; a=rsa-sha256; t=1792057051; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fPiV0oJRDjEti1AQ/V7Xk+ktuA3Xa6bzsn2kGauZYuuvMp1A9t0PA/KG0Ku9lfgyls1biwAMr/O72hQKHOHyuJYFolFb0ZZK+mpPjDGoHhEsQ3VY17Z4eiVTvfQFzegIrrzWOJ166asN6Yy08JLWPbsqWa9HpVOXmHdfy0tacqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792057051; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tvf2GxjHjpBk8XwxMtEj1nZ0udG2Gu+RxzqfvRwXJGo=; 
	b=G9KueBt5/jkT5nTdl30e2M6BsauLJLXFQU7AcGQRoUfl9VSXmMHV8Ou9OjF//v9Xoh1rxrAsORitto12u2xHcPhazkjaOYmW/wq1n+uZjhDOPZ7ealrDVkrTKVhgcQU6Umzjo0Ra3PHuAGQDH3ZBK1EsLgpkS763McdfkyMbTd4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792057051;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Tvf2GxjHjpBk8XwxMtEj1nZ0udG2Gu+RxzqfvRwXJGo=;
	b=IUzAGapUZlLk9VxWSWus/mWxfyT4XCKxwDrvTYZuRrrowLyCjF68g0oKnom+wShf
	LZu0Gs1n6ocMEQb8Y4spiI0xvWcjIEIl01Q4EVWADtLnB63FsQG0KyHyZ8Ir5Py3+be
	+9VglFEBUH/dfVAxlOI5lpsTGShm45WFsrNCfzqI=
Received: by smtp.zohomail.com with SMTPS id 1792057049720968.5059406593228;
	Thu, 15 Oct 2026 02:37:29 -0700 (PDT)
Message-ID: <4e79ef12-5873-43ef-a763-47fb062dc77a@zohomail.com>
Date: Thu, 15 Oct 2026 17:37:26 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791949910.git.alison.schofield@intel.com>
 <ccb2c0974781ec3500c56e82c61eb3026c73d183.1791949910.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <ccb2c0974781ec3500c56e82c61eb3026c73d183.1791949910.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227bae211c651028a6a703458ca0000a0b5f7d6e17bd39399d5a97d6d4b704299408c65e2883c0405:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/14 12:17, Alison Schofield 写道:
> cxl_internal_send_cmd() validates mailbox payload sizes, translates device
> return codes to errnos, and checks returned output sizes. Existing cxl_test
> coverage does not exercise many of its error paths.
>
> Add a KUnit suite that replaces mbox_send() with a stub transport, allowing
> tests to control transport errors, device return codes, and output sizes.
>
> The suite covers command forwarding, payload size limits, transport errors,
> defined and unknown device return codes, background commands, and fixed
> versus variable output sizes.
>
> The unknown return code cases provide regression coverage for "cxl/mbox:
> Treat unknown device return codes as errors". Without that change, the
> tests fail and KASAN reports a global out-of-bounds read.
>
> The suite uses the existing CONFIG_CXL_KUNIT_TEST option, allowing it to
> run without additional configuration.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   Documentation/driver-api/cxl/testing.rst |   3 +
>   drivers/cxl/core/Makefile                |   1 +
>   drivers/cxl/core/tests/Makefile          |   5 +
>   drivers/cxl/core/tests/mbox_kunit.c      | 249 +++++++++++++++++++++++
>   4 files changed, 258 insertions(+)
>   create mode 100644 drivers/cxl/core/tests/Makefile
>   create mode 100644 drivers/cxl/core/tests/mbox_kunit.c
>
> diff --git a/Documentation/driver-api/cxl/testing.rst b/Documentation/driver-api/cxl/testing.rst
> index e3e2613172a2..8d1eb5722334 100644
> --- a/Documentation/driver-api/cxl/testing.rst
> +++ b/Documentation/driver-api/cxl/testing.rst
> @@ -103,6 +103,9 @@ A CXL KUnit test follows these rules:
>   
>   - Use exported interfaces where possible, importing the CXL symbol namespace as needed.
>   
> +For an example of testing mailbox command handling with a stub transport, see
> +drivers/cxl/core/tests/mbox_kunit.c.
> +
>   When to add a test
>   ==================
>   
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..b2627933b7fb 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_CXL_BUS) += cxl_core.o
>   obj-$(CONFIG_CXL_SUSPEND) += suspend.o
> +obj-$(CONFIG_CXL_KUNIT_TEST) += tests/
>   
>   ccflags-y += -I$(srctree)/drivers/cxl
>   CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
> diff --git a/drivers/cxl/core/tests/Makefile b/drivers/cxl/core/tests/Makefile
> new file mode 100644
> index 000000000000..08d97303d0d1
> --- /dev/null
> +++ b/drivers/cxl/core/tests/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +ccflags-y += -I$(srctree)/drivers/cxl
> +
> +obj-$(CONFIG_CXL_KUNIT_TEST) += cxl_core_mbox_kunit.o
> +cxl_core_mbox_kunit-y := mbox_kunit.o
> diff --git a/drivers/cxl/core/tests/mbox_kunit.c b/drivers/cxl/core/tests/mbox_kunit.c
> new file mode 100644
> index 000000000000..68f9fe87d743
> --- /dev/null
> +++ b/drivers/cxl/core/tests/mbox_kunit.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KUnit tests for cxl_internal_send_cmd() using a stub mailbox
> + * transport in place of hardware.
> + */
> +#include <kunit/test.h>
> +#include <cxl/mailbox.h>
> +#include "cxlmem.h"
> +
> +#define TEST_PAYLOAD_SIZE SZ_4K
> +
> +/*
> + * Stub transport state: what the "device" returns, and a record of
> + * what the core passed down.
> + */
> +struct mock_mbox {
> +	struct cxl_mailbox cxl_mbox;
> +	int send_rc;
> +	u16 return_code;
> +	size_t size_out;
> +	int calls;
> +	struct cxl_mbox_cmd seen;
> +};
> +
> +static int mock_mbox_send(struct cxl_mailbox *cxl_mbox,
> +			  struct cxl_mbox_cmd *cmd)
> +{
> +	struct mock_mbox *mock;
> +
> +	mock = container_of(cxl_mbox, struct mock_mbox, cxl_mbox);
> +	mock->calls++;
> +	mock->seen = *cmd;
> +	if (mock->send_rc)
> +		return mock->send_rc;
> +
> +	cmd->return_code = mock->return_code;
> +	cmd->size_out = mock->size_out;
> +	return 0;
> +}
> +
> +static int cxl_mbox_test_init(struct kunit *test)
> +{
> +	struct mock_mbox *mock;
> +
> +	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, mock);
> +
> +	mock->cxl_mbox.payload_size = TEST_PAYLOAD_SIZE;
> +	mock->cxl_mbox.mbox_send = mock_mbox_send;
> +	test->priv = mock;

How about adding a line "mock->return_code = CXL_MBOX_CMD_RC_SUCCESS" 
here to explicitly initialize mock->return_code? It makes easier for 
readers to see the default return_code is SUCCESS.

> +
> +	return 0;
> +}
> +
> +static void send_success(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +	u8 in[16], out[64];
> +	struct cxl_mbox_cmd cmd = {
> +		.opcode = CXL_MBOX_OP_IDENTIFY,
> +		.payload_in = in,
> +		.size_in = sizeof(in),
> +		.payload_out = out,
> +		.size_out = sizeof(out),
> +	};
> +
> +	mock->size_out = sizeof(out);
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
> +	KUNIT_EXPECT_EQ(test, mock->calls, 1);
> +
> +	/* The command reaches the transport as the caller built it */
> +	KUNIT_EXPECT_EQ(test, mock->seen.opcode, CXL_MBOX_OP_IDENTIFY);
> +	KUNIT_EXPECT_PTR_EQ(test, mock->seen.payload_in, (void *)in);
> +	KUNIT_EXPECT_EQ(test, mock->seen.size_in, sizeof(in));
> +	KUNIT_EXPECT_PTR_EQ(test, mock->seen.payload_out, (void *)out);
> +	KUNIT_EXPECT_EQ(test, mock->seen.size_out, sizeof(out));
> +}
> +
> +static void send_no_output(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +	struct cxl_mbox_cmd cmd = {};
> +
> +	/* No output was requested, so the returned size is not checked */
> +	mock->size_out = 0;
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
> +}
> +
> +static void send_size_in_too_big(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +	struct cxl_mbox_cmd cmd = {
> +		.size_in = TEST_PAYLOAD_SIZE + 1,
> +	};
> +
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
> +			-E2BIG);
> +	KUNIT_EXPECT_EQ(test, mock->calls, 0);
> +}
> +
> +static void send_size_out_too_big(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +	struct cxl_mbox_cmd cmd = {
> +		.size_out = TEST_PAYLOAD_SIZE + 1,
> +	};
> +
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
> +			-E2BIG);
> +	KUNIT_EXPECT_EQ(test, mock->calls, 0);
> +}
> +
> +static void send_full_payload(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +	struct cxl_mbox_cmd cmd = {
> +		.size_in = TEST_PAYLOAD_SIZE,
> +		.size_out = TEST_PAYLOAD_SIZE,
> +	};
> +
> +	mock->size_out = TEST_PAYLOAD_SIZE;
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
> +}
> +
> +static void send_transport_error(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +	struct cxl_mbox_cmd cmd = {};
> +
> +	mock->send_rc = -ETIMEDOUT;
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
> +			-ETIMEDOUT);
> +}
> +
> +static void send_device_error(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +
> +	/* Every defined error code fails the command */
> +	for (u16 code = CXL_MBOX_CMD_RC_INPUT;
> +	     code < ARRAY_SIZE(cxl_mbox_cmd_rctable); code++) {
> +		struct cxl_mbox_cmd cmd = {};
> +		int expect, rc;
> +
> +		switch (code) {
> +		case CXL_MBOX_CMD_RC_PADDR:
> +			expect = -EFAULT;
> +			break;
> +		case CXL_MBOX_CMD_RC_POISONLMT:
> +			expect = -EBUSY;
> +			break;
> +		default:
> +			expect = -ENXIO;
> +			break;
> +		}
> +
> +		mock->return_code = code;
> +		rc = cxl_internal_send_cmd(&mock->cxl_mbox, &cmd);
> +		KUNIT_EXPECT_EQ_MSG(test, rc, expect, "return_code=%#x", code);
> +	}
> +}
> +
> +static void send_unknown_return_code(struct kunit *test)
> +{
> +	static const u16 codes[] = { ARRAY_SIZE(cxl_mbox_cmd_rctable), 0x100,
> +				     0xffff };
> +	struct mock_mbox *mock = test->priv;
> +
> +	/* Codes the driver does not know are still device errors */
> +	for (int i = 0; i < ARRAY_SIZE(codes); i++) {
> +		struct cxl_mbox_cmd cmd = {};
> +		int rc;
> +
> +		mock->return_code = codes[i];
> +		rc = cxl_internal_send_cmd(&mock->cxl_mbox, &cmd);
> +		KUNIT_EXPECT_EQ_MSG(test, rc, -ENXIO, "return_code=%#x",
> +				    codes[i]);
> +		KUNIT_EXPECT_STREQ_MSG(test, cxl_mbox_cmd_rc2str(&cmd),
> +				       "unknown return code", "return_code=%#x",
> +				       codes[i]);
> +	}
> +}
Since we already have cxl_mbox_cmd_rctable here, should we also cover 
the existing return_codes that we know?
> +
> +static void send_background_started(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +	struct cxl_mbox_cmd cmd = {};
> +
> +	/* A background command that started is not an error */
> +	mock->return_code = CXL_MBOX_CMD_RC_BACKGROUND;
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
> +}
> +
> +static void send_short_fixed_output(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +	struct cxl_mbox_cmd cmd = {
> +		.size_out = 64,
> +	};
> +
> +	/* Without min_out, the full requested size is required */
> +	mock->size_out = 63;
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
> +			-EIO);
> +}
> +
> +static void send_variable_output(struct kunit *test)
> +{
> +	struct mock_mbox *mock = test->priv;
> +	struct cxl_mbox_cmd cmd;
> +
> +	/* Output at or above min_out is accepted */
> +	cmd = (struct cxl_mbox_cmd){ .size_out = 64, .min_out = 8 };
> +	mock->size_out = 8;
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd), 0);
> +
> +	/* Output below min_out is rejected */
> +	cmd = (struct cxl_mbox_cmd){ .size_out = 64, .min_out = 8 };
> +	mock->size_out = 7;
> +	KUNIT_EXPECT_EQ(test, cxl_internal_send_cmd(&mock->cxl_mbox, &cmd),
> +			-EIO);
> +}
> +
> +static struct kunit_case cxl_core_mbox_cases[] = {
> +	KUNIT_CASE(send_success),
> +	KUNIT_CASE(send_no_output),
> +	KUNIT_CASE(send_size_in_too_big),
> +	KUNIT_CASE(send_size_out_too_big),
> +	KUNIT_CASE(send_full_payload),
> +	KUNIT_CASE(send_transport_error),
> +	KUNIT_CASE(send_device_error),
> +	KUNIT_CASE(send_unknown_return_code),
> +	KUNIT_CASE(send_background_started),
> +	KUNIT_CASE(send_short_fixed_output),
> +	KUNIT_CASE(send_variable_output),
> +	{}
> +};
> +
> +static struct kunit_suite cxl_core_mbox_suite = {
> +	.name = "cxl_core_mbox",
> +	.init = cxl_mbox_test_init,
> +	.test_cases = cxl_core_mbox_cases,
> +};
> +
> +kunit_test_suite(cxl_core_mbox_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for the CXL mailbox command core");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("CXL");
