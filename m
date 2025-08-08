Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB827BF84
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670267; cv=none; b=GYN3QpqvTeXnNuG+fwufFNEl7bnHdrjmAF4FpDux0hLtBj3euIC8FlnpPoPK76oADqJVP3Ce0cdEpZWHJOgkgAnTKWDabC8lBQwpfd7Ri0Fo04qy1R92DPFx7koyaQqxF08fTMBPDeSM4WntNUvUfPq8O/VI7u9TK2KVftbGnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670267; c=relaxed/simple;
	bh=5abFuavUlGQwW/ncZtnzOiBV+txz4/oPjc5mQZcmUX8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmzX9ZVKl/Ln0z3vffQWZYO2Sg9NPNY6VXUs58UHRseahqbVPy9GCxrndhmLlyYz9TanrtBQYvlNfxX3yMx4MXMGuMwxKam+erh7HgjHaS5Jc5n13TWGiZ9csOMGas28oB2UVAUHMYjIe3sTsl4TtsGkSYGlHwB2T2t2vCgb3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz8PV1cj3z6L50y;
	Sat,  9 Aug 2025 00:19:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 65CEF14025A;
	Sat,  9 Aug 2025 00:24:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 18:24:20 +0200
Date: Fri, 8 Aug 2025 17:24:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/test: Add cxl_translate module for address
 translation testing
Message-ID: <20250808172419.00005642@huawei.com>
In-Reply-To: <227f16019ae731d75a916da1a3623b30506cbe7a.1754291501.git.alison.schofield@intel.com>
References: <cover.1754291501.git.alison.schofield@intel.com>
	<227f16019ae731d75a916da1a3623b30506cbe7a.1754291501.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon,  4 Aug 2025 01:52:41 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add a loadable test module that validates CXL address translation
> calculations using parameterized test vectors. The module tests both
> host to device and device to host address translations for Modulo and
> XOR interleave arithmetic.
> 
> Test vectors are provided as module parameters in the format:
> "dpa pos r_eiw r_eig hb_ways math expected_spa"
> 
> The module performs round-trip validation:
> 1. Translate a DPA and position to a SPA
> 2. Verify the result matches expected SPA
> 3. Translate that SPA back to a DPA and position
> 4. Verify round-trip consistency
> 
> The module accesses the refactored translation functions through the
> exports made available only to CXL test modules.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Nice little test.  Trivial comments inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  tools/testing/cxl/Kbuild               |   1 +
>  tools/testing/cxl/cxl_acpi_exports.c   |  13 ++
>  tools/testing/cxl/cxl_core_exports.c   |  11 +
>  tools/testing/cxl/test/Kbuild          |   2 +
>  tools/testing/cxl/test/cxl_translate.c | 298 +++++++++++++++++++++++++
>  5 files changed, 325 insertions(+)
>  create mode 100644 tools/testing/cxl/cxl_acpi_exports.c
>  create mode 100644 tools/testing/cxl/test/cxl_translate.c
> 
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index d07f14cb7aa4..8b16fbb44858 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -29,6 +29,7 @@ cxl_acpi-y := $(CXL_SRC)/acpi.o
>  cxl_acpi-y += mock_acpi.o
>  cxl_acpi-y += config_check.o
>  cxl_acpi-y += cxl_acpi_test.o
> +cxl_acpi-y += cxl_acpi_exports.o
>  
>  obj-m += cxl_pmem.o
>  
> diff --git a/tools/testing/cxl/cxl_acpi_exports.c b/tools/testing/cxl/cxl_acpi_exports.c
> new file mode 100644
> index 000000000000..ea00772ce74d
> --- /dev/null
> +++ b/tools/testing/cxl/cxl_acpi_exports.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +
> +#include <linux/acpi.h>
> +
> +/*
> + * Exporting of cxl_acpi (acpi.o) symbols that are only used by
> + * the test module cxl_translate.
> + */
> +
> +EXPORT_SYMBOL_NS_GPL(cxl_create_cxims_data, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_free_cxims_data, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_do_xormap_calc, "CXL");
> diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
> index f088792a8925..30c9284c26a5 100644
> --- a/tools/testing/cxl/cxl_core_exports.c
> +++ b/tools/testing/cxl/cxl_core_exports.c
> @@ -5,3 +5,14 @@
>  
>  /* Exporting of cxl_core symbols that are only used by cxl_test */
>  EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
> +
> +/*
> + * Exporting of cxl_core symbols used only by the cxl_translate module to test
> + * the CXL Region Drivers's address translation calculations.
> + *
> + * See tools/testing/cxl/cxl_translate.c
> + * See the CXL unit test cxl-translate.sh for usage
> + */
> +EXPORT_SYMBOL_NS_GPL(cxl_calculate_hpa_offset, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_calculate_dpa_offset, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_calculate_position, "CXL");
> diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
> index 6b1927897856..d55973e61fdd 100644
> --- a/tools/testing/cxl/test/Kbuild
> +++ b/tools/testing/cxl/test/Kbuild
> @@ -5,6 +5,8 @@ obj-m += cxl_test.o
>  obj-m += cxl_mock.o
>  obj-m += cxl_mock_mem.o
>  
> +obj-m += cxl_translate.o
> +
>  cxl_test-y := cxl.o
>  cxl_mock-y := mock.o
>  cxl_mock_mem-y := mem.o
> diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
> new file mode 100644
> index 000000000000..b163ebc4a82b
> --- /dev/null
> +++ b/tools/testing/cxl/test/cxl_translate.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2025 Intel Corporation. All rights reserved.
> +
> +#include <linux/moduleparam.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <cxlmem.h>
> +
> +/* Maximum number of test vectors and entry length */
> +#define MAX_TABLE_ENTRIES 128
> +#define MAX_ENTRY_LEN 128
> +
> +/* Expected number of parameters in each test vector */
> +#define EXPECTED_PARAMS 7
> +
> +/* Module parameters for test vectors */
> +static char *table[MAX_TABLE_ENTRIES];
> +static int table_num;
> +
> +/* Interleave Arithmetic */
> +#define MODULO_MATH 0
> +#define XOR_MATH 1
> +
> +/*
> + * XOR mapping configuration
> + * The test data sets all use the same set of xormaps. When additional
> + * data sets arrive for validation, this static setup will need to
> + * be changed to accept xormaps as additional parameters.
> + */
> +struct cxl_cxims_data *cximsd;
> +static u64 xormap_list[] = {
> +	0x2020900,
> +	0x4041200,
> +	0x1010400,
> +	0x800,
> +};
> +
> +static int nr_maps = ARRAY_SIZE(xormap_list);
> +
> +/*

Might as well make this kernel-doc even if nothing is going to
build these docs currently.  You can probably still point
the scripts at the file and to check docs are complete etc.

> + * to_hpa - translate a DPA offset and position to HPA offset
> + *
> + * @dpa_offset: device physical address offset
> + * @pos: devices position in interleave
> + * @r_eiw: region encoded interleave ways
> + * @r_eig: region encoded interleave granularity
> + * @hb_ways: host bridge interleave ways
> + * @math: interleave arithmetic (MODULO_MATH or XOR_MATH)
> + *
> + * Returns: host physical address offset
> + */
> +static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
> +		  u8 math)
> +{
> +	u64 hpa_offset;
> +
> +	/* Calculate base HPA offset from DPA and position */
> +	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
> +
> +	/* Apply XOR mapping if specified */
> +	if (math == XOR_MATH)
> +		hpa_offset = cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
> +
> +	return hpa_offset;
> +}
> +
> +/*
Likewise on kernel-doc /**

> + * to_dpa - Convert HPA offset to DPA offset
> + *
> + * @hpa_offset: host physical address offset
> + * @r_eiw: region encoded interleave ways
> + * @r_eig: region encoded interleave granularity
> + * @hb_ways: host bridge interleave ways
> + * @math: interleave arithmetic (MODULO_MATH or XOR_MATH)
> + *
> + * Returns: device physical address offset
> + */
> +static u64 to_dpa(u64 hpa_offset, u8 r_eiw, u16 r_eig, u8 hb_ways, u8 math)
> +{
> +	u64 offset = hpa_offset;
> +
> +	/* Reverse XOR mapping if specified */
> +	if (math == XOR_MATH)
> +		offset = cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
> +
> +	return cxl_calculate_dpa_offset(offset, r_eiw, r_eig);
> +}
> +
> +/**

Not sure why this one was special.

> + * to_pos - Convert HPA offset to interleave position
> + *
> + * @hpa_offset: host physical address offset
> + * @r_eiw: region encoded interleave ways
> + * @r_eig: region encoded interleave granularity
> + * @hb_ways: host bridge interleave ways
> + * @math: interleave arithmetic (MODULO_MATH or XOR_MATH)
> + *
> + * Returns: devices position in region interleave
> + */
> +static u64 to_pos(u64 hpa_offset, u8 r_eiw, u16 r_eig, u8 hb_ways, u8 math)
> +{
> +	u64 offset = hpa_offset;
> +
> +	/* Reverse XOR mapping if specified */
> +	if (math == XOR_MATH)
> +		offset = cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
> +
> +	return cxl_calculate_position(offset, r_eiw, r_eig);
> +}
> +
