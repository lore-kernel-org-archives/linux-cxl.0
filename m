Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB494E9C1D
	for <linux-cxl@vger.kernel.org>; Thu, 15 Oct 2026 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055792; cv=pass; b=qGTk4TpUzem3aLKiwy9O8ta+qibyf3Yb9094dWwiFCjvqJMOLDql7VEN020P+ITgEDhIm2q6WWFLKOjLkpLu3R1Da4+sNMrjWjw7/06Yv3pGfek0LKBDbgCqfek6sgeLoxrfNWvkUKSI4FLszLt+VP7NBTzRnIQj4nAVoQQVIao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055792; c=relaxed/simple;
	bh=q9sw55r+zwfdzDWRN1MpGx53mNSScOPCZR50e9LYOjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0stb5m7K5uhgCnjlbAe5A7q/kYvhbYW/BAanuzwDvG/SWSSVGJBCdgjxjiLVRTRGnPs8kz9jQO38RUbMlSStGn9X0HYWlSHLvD9xn9Jai/kbxS0JSNB+YOjTxqyPBY4K7jHATUonpKpvU91Mb1bgxvUYoxWrt/CEmzsUfono5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=TZAIDkhD; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="TZAIDkhD"
ARC-Seal: i=1; a=rsa-sha256; t=1792055775; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c0K7TBX5jzOY5YN30V6lv2ya/WMnwNXhn8wy1yiejf3D9yz8s66Q50k78zXzQSWBFC/cw0kjz8oAGI74c+7gK5KUYiHGBS2VJyMXJjBwIn9DN2QXzaAkuAUqQ2oBHqvh6Tr7C7LgueWHrv478isLgbfYKkL7IdtGwui5bgM6r4M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792055775; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ys5WN3nrsHKbxlF89PnUJ/dQFziYI+WxNxpRLqVLjTA=; 
	b=Fgjvday1/QmJLy/KO0WaEpuXqhoL6vqfQYlPRkmOQGBMJV0zZw3Xjhz0BgxLHs/UJ38Cv3/jgUYn40QRVik9nzNy3PvJXz8z6N5Rel0AJ3MZpMjrZe5EEH1dSYSbnWYoBYGLjzL86RH0xZ/w+Yof9WOZhTC6/7mNQH2wX296cAw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792055775;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ys5WN3nrsHKbxlF89PnUJ/dQFziYI+WxNxpRLqVLjTA=;
	b=TZAIDkhDhxFN6/XabnVfhbGHYumEDDCCCdLaYtVlF8Q382Tuq9OSlM3ilzQD6ZeL
	/67f+gglGDMXVsponq8l/I+cYj+nXBF0VyfW6R5dEnrocw4DqLwkK+6ATgsK+UiIL14
	DpeJNog6K+ue+8B29WRDCB2+89lsnTPQsQ+tA/mc=
Received: by smtp.zohomail.com with SMTPS id 1792055773801203.36050762878267;
	Thu, 15 Oct 2026 02:16:13 -0700 (PDT)
Message-ID: <42aa1d45-113d-4239-aebe-8b4e0d0744a5@zohomail.com>
Date: Thu, 15 Oct 2026 17:16:08 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cxl: Add KUnit tests for HDM decoder encoding helpers
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791949910.git.alison.schofield@intel.com>
 <73af16d29561eec944e128af116783e20b990dae.1791949910.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <73af16d29561eec944e128af116783e20b990dae.1791949910.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112270aca9d1f75fc95225aa3078c000004a90e47b62313a53030a825efe1ee0a23d021ee00cf306953:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/14 12:17, Alison Schofield 写道:
> The CXL subsystem has no KUnit infrastructure for testing self-contained
> logic.
>
> Introduce CONFIG_CXL_KUNIT_TEST and drivers/cxl/.kunitconfig, along with
> an initial suite for the HDM decoder interleave encoding helpers. The
> suite checks valid and invalid encodings and round-trip conversions.
>
> Use a single Kconfig option for all CXL KUnit suites, with each suite
> built as a separate module. This allows new suites to be added without
> requiring additional configuration options.
>
> The HDM decoder helpers provide a starting point for establishing the
> location, naming, and configuration conventions for future CXL KUnit tests.
>
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/.kunitconfig               |   4 +
>   drivers/cxl/Kconfig                    |  16 +++
>   drivers/cxl/Makefile                   |   1 +
>   drivers/cxl/tests/Makefile             |   5 +
>   drivers/cxl/tests/hdm_encoding_kunit.c | 156 +++++++++++++++++++++++++
>   5 files changed, 182 insertions(+)
>   create mode 100644 drivers/cxl/.kunitconfig
>   create mode 100644 drivers/cxl/tests/Makefile
>   create mode 100644 drivers/cxl/tests/hdm_encoding_kunit.c
>
> diff --git a/drivers/cxl/.kunitconfig b/drivers/cxl/.kunitconfig
> new file mode 100644
> index 000000000000..4fee684f5ff6
> --- /dev/null
> +++ b/drivers/cxl/.kunitconfig
> @@ -0,0 +1,4 @@
> +CONFIG_KUNIT=y
> +CONFIG_PCI=y
> +CONFIG_CXL_BUS=y
> +CONFIG_CXL_KUNIT_TEST=y
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd..fdd57a4118db 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -243,4 +243,20 @@ config CXL_ATL
>   	depends on CXL_REGION
>   	depends on ACPI_PRMT && AMD_NB
>   
> +config CXL_KUNIT_TEST
> +	tristate "KUnit tests for CXL" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the KUnit tests for the CXL subsystem. When built
> +	  as a module, each test suite is its own cxl_<name>_kunit
> +	  module. This one option covers every CXL KUnit test, so new
> +	  tests need no new configuration.
> +
> +	  For more information on KUnit and unit tests in general,
> +	  please refer to the KUnit documentation in
> +	  Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>   endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 2caa90fa4bf2..d57fb0e9e7da 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>   obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>   obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>   obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> +obj-$(CONFIG_CXL_KUNIT_TEST) += tests/
>   
>   cxl_port-y := port.o
>   cxl_acpi-y := acpi.o
> diff --git a/drivers/cxl/tests/Makefile b/drivers/cxl/tests/Makefile
> new file mode 100644
> index 000000000000..aa5e4f8e3638
> --- /dev/null
> +++ b/drivers/cxl/tests/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +ccflags-y += -I$(srctree)/drivers/cxl
> +
> +obj-$(CONFIG_CXL_KUNIT_TEST) += cxl_hdm_encoding_kunit.o
> +cxl_hdm_encoding_kunit-y := hdm_encoding_kunit.o
> diff --git a/drivers/cxl/tests/hdm_encoding_kunit.c b/drivers/cxl/tests/hdm_encoding_kunit.c
> new file mode 100644
> index 000000000000..54a7cb078a06
> --- /dev/null
> +++ b/drivers/cxl/tests/hdm_encoding_kunit.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KUnit tests for the HDM decoder interleave encode/decode helpers
> + * in drivers/cxl/cxl.h
> + */
> +#include <kunit/test.h>
> +#include "cxl.h"
> +
> +struct eiw_case {
> +	u8 eiw;
> +	int ways;
> +};
> +
> +/* Encodings of the IW field in the HDM Decoder n Control Register */
> +static const struct eiw_case valid_eiw[] = {
> +	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 }, { 4, 16 },
> +	{ 8, 3 }, { 9, 6 }, { 10, 12 },
> +};
> +
> +static const u8 invalid_eiw[] = { 5, 6, 7, 11, 12, 13, 14, 15, 0xff };
> +
> +static const unsigned int invalid_ways[] = {
> +	0, 5, 7, 9, 10, 11, 13, 14, 15, 17, 24, 32,
> +};
> +
> +static void eiw_to_ways_valid(struct kunit *test)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(valid_eiw); i++) {
> +		int ways = 0;
> +
> +		KUNIT_EXPECT_EQ_MSG(test, eiw_to_ways(valid_eiw[i].eiw, &ways),
> +				    0, "eiw=%u", valid_eiw[i].eiw);
> +		KUNIT_EXPECT_EQ_MSG(test, ways, valid_eiw[i].ways, "eiw=%u",
> +				    valid_eiw[i].eiw);
> +	}
> +}
> +
> +static void eiw_to_ways_invalid(struct kunit *test)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(invalid_eiw); i++) {
> +		int ways;
> +
> +		KUNIT_EXPECT_EQ_MSG(test, eiw_to_ways(invalid_eiw[i], &ways),
> +				    -EINVAL, "eiw=%u", invalid_eiw[i]);
> +	}
> +}
> +
> +static void ways_to_eiw_valid(struct kunit *test)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(valid_eiw); i++) {
> +		u8 eiw = 0xff;
> +
> +		KUNIT_EXPECT_EQ_MSG(test, ways_to_eiw(valid_eiw[i].ways, &eiw),
> +				    0, "ways=%d", valid_eiw[i].ways);
> +		KUNIT_EXPECT_EQ_MSG(test, eiw, valid_eiw[i].eiw, "ways=%d",
> +				    valid_eiw[i].ways);
> +	}
> +}
> +
> +static void ways_to_eiw_invalid(struct kunit *test)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(invalid_ways); i++) {
> +		u8 eiw;
> +
> +		KUNIT_EXPECT_EQ_MSG(test, ways_to_eiw(invalid_ways[i], &eiw),
> +				    -EINVAL, "ways=%u", invalid_ways[i]);
> +	}
> +}
> +
> +static void eig_to_granularity_valid(struct kunit *test)
> +{
> +	for (u16 eig = 0; eig <= CXL_DECODER_MAX_ENCODED_IG; eig++) {
> +		int gran = 0;
> +		u16 back = 0xffff;
> +
> +		KUNIT_EXPECT_EQ_MSG(test, eig_to_granularity(eig, &gran), 0,
> +				    "eig=%u", eig);
> +		KUNIT_EXPECT_EQ_MSG(test, gran, 256 << eig, "eig=%u", eig);
> +
> +		/* Round trip back to the encoding */
> +		KUNIT_EXPECT_EQ_MSG(test, granularity_to_eig(gran, &back), 0,
> +				    "gran=%d", gran);
> +		KUNIT_EXPECT_EQ_MSG(test, back, eig, "gran=%d", gran);
> +	}
> +}
> +
> +static void eig_to_granularity_invalid(struct kunit *test)
> +{
> +	static const u16 invalid_eig[] = { 7, 8, 15, 0xffff };
> +
> +	for (int i = 0; i < ARRAY_SIZE(invalid_eig); i++) {
> +		int gran;
> +
> +		KUNIT_EXPECT_EQ_MSG(test,
> +				    eig_to_granularity(invalid_eig[i], &gran),
> +				    -EINVAL, "eig=%u", invalid_eig[i]);
> +	}
> +}
> +
> +static void granularity_to_eig_invalid(struct kunit *test)
> +{
> +	static const int invalid_gran[] = {
> +		0, 1, 128, 255, 257, 384, 768, SZ_32K, -256,
> +	};
> +
> +	for (int i = 0; i < ARRAY_SIZE(invalid_gran); i++) {
> +		u16 eig;
> +
> +		KUNIT_EXPECT_EQ_MSG(test,
> +				    granularity_to_eig(invalid_gran[i], &eig),
> +				    -EINVAL, "gran=%d", invalid_gran[i]);
> +	}
> +}
> +
> +/* Decoder Count field of the CXL HDM Decoder Capability Register */
> +static void hdm_decoder_count(struct kunit *test)
> +{
> +	static const int expect[16] = {
> +		1, 2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32,
> +		-ENXIO, -ENXIO, -ENXIO,
> +	};
> +
> +	for (u32 val = 0; val < ARRAY_SIZE(expect); val++) {
> +		u32 cap = FIELD_PREP(CXL_HDM_DECODER_COUNT_MASK, val);
> +
> +		KUNIT_EXPECT_EQ_MSG(test, cxl_hdm_decoder_count(cap),
> +				    expect[val], "count field=%u", val);
> +	}
> +
> +	/* Bits outside the count field are ignored */
> +	KUNIT_EXPECT_EQ(test,
> +			cxl_hdm_decoder_count((u32)~CXL_HDM_DECODER_COUNT_MASK),
> +			1);
> +}
> +
> +static struct kunit_case cxl_hdm_encoding_cases[] = {
> +	KUNIT_CASE(eiw_to_ways_valid),
> +	KUNIT_CASE(eiw_to_ways_invalid),
> +	KUNIT_CASE(ways_to_eiw_valid),
> +	KUNIT_CASE(ways_to_eiw_invalid),
> +	KUNIT_CASE(eig_to_granularity_valid),
> +	KUNIT_CASE(eig_to_granularity_invalid),
> +	KUNIT_CASE(granularity_to_eig_invalid),
> +	KUNIT_CASE(hdm_decoder_count),
> +	{}
> +};
> +
> +static struct kunit_suite cxl_hdm_encoding_suite = {
> +	.name = "cxl_hdm_encoding",
> +	.test_cases = cxl_hdm_encoding_cases,
> +};
> +
> +kunit_test_suite(cxl_hdm_encoding_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for CXL HDM decoder encoding helpers");
> +MODULE_LICENSE("GPL");
