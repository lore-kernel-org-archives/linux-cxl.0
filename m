Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C91C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 18:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiK3SY7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiK3SY7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 13:24:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4BB102B
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 10:24:58 -0800 (PST)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMnbg50v5z6HJ6B;
        Thu,  1 Dec 2022 02:21:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 19:24:55 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 18:24:55 +0000
Date:   Wed, 30 Nov 2022 18:24:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] tools/testing/cxl: Add XOR Math support to
 cxl_test
Message-ID: <20221130182454.00002270@Huawei.com>
In-Reply-To: <7293239bdf2f23f5d25b4019e3937dbf2547026c.1669153633.git.alison.schofield@intel.com>
References: <cover.1669153633.git.alison.schofield@intel.com>
        <7293239bdf2f23f5d25b4019e3937dbf2547026c.1669153633.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 22 Nov 2022 14:52:25 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Expand the cxl_test topology to include CFMWS's that use XOR math
> for interleave arithmetic, as defined in the CXL Specification 3.0.
> 
> With this expanded topology, cxl_test is useful for testing:
> x1,x2,x4 ways with XOR interleave arithmetic.
> 
> Define the additional XOR CFMWS entries to appear only with the
> module parameter interleave_arithmetic=1. The cxl_test default
> continues to be modulo math.
> 
> modprobe cxl_test interleave_arithmetic=1
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Trivial comments inline, but looks good to me and you can tidy those
up if it makes sense to you.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/cxl.c | 118 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 7edce12fd2ce..97849e9753f5 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -11,6 +11,8 @@
>  #include <cxlmem.h>
>  #include "mock.h"
>  
> +static int interleave_arithmetic;
> +
>  #define NR_CXL_HOST_BRIDGES 2
>  #define NR_CXL_SINGLE_HOST 1
>  #define NR_CXL_ROOT_PORTS 2
> @@ -122,6 +124,22 @@ static struct {
>  		struct acpi_cedt_cfmws cfmws;
>  		u32 target[1];
>  	} cfmws4;
> +	struct {
> +		struct acpi_cedt_cfmws cfmws;
> +		u32 target[1];
> +	} cfmws5;
> +	struct {
> +		struct acpi_cedt_cfmws cfmws;
> +		u32 target[2];
> +	} cfmws6;
> +	struct {
> +		struct acpi_cedt_cfmws cfmws;
> +		u32 target[4];
> +	} cfmws7;
> +	struct {
> +		struct acpi_cedt_cxims cxims;
> +		u64 xormap_list[2];
> +	} cxims0;
>  } __packed mock_cedt = {
>  	.cedt = {
>  		.header = {
> @@ -229,14 +247,89 @@ static struct {
>  		},
>  		.target = { 2 },
>  	},
> +	/* .cfmws5,6,7 use XOR Math (interleave_arithmetic == 1) */
> +	.cfmws5 = {
> +		.cfmws = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CFMWS,
> +				.length = sizeof(mock_cedt.cfmws5),
> +			},
> +			.interleave_arithmetic = 1,

Can we either use the defines from patch 1 directly, or carry a local copy in this
file so naming matches up etc?

> +			.interleave_ways = 0,
> +			.granularity = 4,
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> +			.qtg_id = 0,
> +			.window_size = SZ_256M * 8UL,
> +		},
> +		.target = { 0 },
consistency of trailing , 
Don't mind which but nice to do it the same here...
> +	},
> +	.cfmws6 = {
> +		.cfmws = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CFMWS,
> +				.length = sizeof(mock_cedt.cfmws6),
> +			},
> +			.interleave_arithmetic = 1,
> +			.interleave_ways = 1,
> +			.granularity = 0,
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> +			.qtg_id = 1,
> +			.window_size = SZ_256M * 8UL,
> +		},
> +		.target = { 0, 1, },
and here.

> +	},
> +	.cfmws7 = {
> +		.cfmws = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CFMWS,
> +				.length = sizeof(mock_cedt.cfmws7),
> +			},
> +			.interleave_arithmetic = 1,
> +			.interleave_ways = 2,
> +			.granularity = 0,
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> +			.qtg_id = 0,
> +			.window_size = SZ_256M * 16UL,
> +		},
> +		.target = { 0, 1, 0, 1, },
> +	},
> +	.cxims0 = {
> +		.cxims = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CXIMS,
> +				.length = sizeof(mock_cedt.cxims0),
> +			},
> +			.hbig = 0,
> +			.nr_xormaps = 2,
> +		},
> +		.xormap_list = { 0x404100, 0x808200 },
> +	},
>  };
>  
> -struct acpi_cedt_cfmws *mock_cfmws[] = {
> +struct acpi_cedt_cfmws *mock_cfmws[8] = {
>  	[0] = &mock_cedt.cfmws0.cfmws,
>  	[1] = &mock_cedt.cfmws1.cfmws,
>  	[2] = &mock_cedt.cfmws2.cfmws,
>  	[3] = &mock_cedt.cfmws3.cfmws,
>  	[4] = &mock_cedt.cfmws4.cfmws,
> +	/* Modulo Math above, XOR Math below */
> +	[5] = &mock_cedt.cfmws5.cfmws,
> +	[6] = &mock_cedt.cfmws6.cfmws,
> +	[7] = &mock_cedt.cfmws7.cfmws,
> +};
> +
> +static int cfmws_start;
> +static int cfmws_end;
> +#define CFMWS_MOD_ARRAY_START 0
> +#define CFMWS_MOD_ARRAY_END   4
> +#define CFMWS_XOR_ARRAY_START 5
> +#define CFMWS_XOR_ARRAY_END   7
> +
> +struct acpi_cedt_cxims *mock_cxims[1] = {
> +	[0] = &mock_cedt.cxims0.cxims,
>  };
>  
>  struct cxl_mock_res {
> @@ -308,7 +401,7 @@ static int populate_cedt(void)
>  		chbs->length = size;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(mock_cfmws); i++) {
> +	for (i = cfmws_start; i <= cfmws_end; i++) {
>  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
>  
>  		res = alloc_mock_res(window->window_size);
> @@ -351,12 +444,19 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
>  		}
>  
>  	if (id == ACPI_CEDT_TYPE_CFMWS)
> -		for (i = 0; i < ARRAY_SIZE(mock_cfmws); i++) {
> +		for (i = cfmws_start; i <= cfmws_end; i++) {
>  			h = (union acpi_subtable_headers *) mock_cfmws[i];
>  			end = (unsigned long) h + mock_cfmws[i]->header.length;
>  			handler_arg(h, arg, end);
>  		}
>  
> +	if (id == ACPI_CEDT_TYPE_CXIMS)
> +		for (i = 0; i < ARRAY_SIZE(mock_cxims); i++) {
> +			h = (union acpi_subtable_headers *)mock_cxims[i];
> +			end = (unsigned long)h + mock_cxims[i]->header.length;
> +			handler_arg(h, arg, end);
> +		}
> +
>  	return 0;
>  }
>  
> @@ -897,6 +997,16 @@ static __init int cxl_test_init(void)
>  	if (rc)
>  		goto err_gen_pool_add;
>  
> +	if (interleave_arithmetic == 1) {
> +		cfmws_start = CFMWS_XOR_ARRAY_START;
> +		cfmws_end = CFMWS_XOR_ARRAY_END;
> +		dev_dbg(NULL, "cxl_test loading xor math option\n");
> +	} else {
> +		cfmws_start = CFMWS_MOD_ARRAY_START;
> +		cfmws_end = CFMWS_MOD_ARRAY_END;
> +		dev_dbg(NULL, "cxl_test loading modulo math option\n");
> +	}
> +
>  	rc = populate_cedt();
>  	if (rc)
>  		goto err_populate;
> @@ -1073,6 +1183,8 @@ static __exit void cxl_test_exit(void)
>  	unregister_cxl_mock_ops(&cxl_mock_ops);
>  }
>  
> +module_param(interleave_arithmetic, int, 0000);
> +MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");

