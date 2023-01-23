Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC19C38142
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 15:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjAWP2y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjAWP2x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 10:28:53 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951002364F
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 07:28:34 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0v726XPyz686q6;
        Mon, 23 Jan 2023 23:25:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 15:28:31 +0000
Date:   Mon, 23 Jan 2023 15:28:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] tools/testing/cxl: Add a param to test poison
 injection limits
Message-ID: <20230123152831.000065e5@Huawei.com>
In-Reply-To: <25a3d2a144a9dcc8ce1da241a72917eb7d6ad3f2.1674101475.git.alison.schofield@intel.com>
References: <cover.1674101475.git.alison.schofield@intel.com>
        <25a3d2a144a9dcc8ce1da241a72917eb7d6ad3f2.1674101475.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 18 Jan 2023 21:00:21 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices may report a maximum number of addresses that a device
> allows to be poisoned using poison injection. When cxl_test creates
> mock CXL memory devices, it uses MOCK_INJECT_DEV_MAX (8) for all
> mocked memdevs.
> 
> Add a module parameter, param_inject_dev_max to module cxl_mock_mem
> so that testers can set custom injection limits.
> 
> Example: Set MOCK_INJECT_DEV_MAX to 7
> $ echo 7 > /sys/module/cxl_mock_mem/parameters/param_inject_dev_max
> 
> A simple usage model is to set it before running a test in order to
> emulate a device's poison handling. Changing the max value in the
> midst of inject, clear, and get poison flows, needs to be carefully
> managed by the user.
> 
> For example, if the max is reduced after more than max errors are
> injected, those errors will remain in the poison list and may need
> to be cleared out even though a request to read the poison list will
> not show more than max. The driver does not clear out the errors that
> are over max when this parameter changes.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Seems sensible. I was thinking of doing something similar in the QEMU
code as it's tedious injecting lots of errors just to make it overflow.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I did some basic testing of the non mock parts of this against my
latest qemu branch.   Mostly works fine but I need to think a little
about how to handle clears of part of a larger poison entry and potential
to trigger list overflow on a clear.
You avoid that problem here by only dealing with 64 byte entries which
is sensible for the mocking driver.

> ---
>  tools/testing/cxl/test/mem.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 14d74bfb3124..5b938283c1d7 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -17,6 +17,8 @@
>  #define MOCK_INJECT_DEV_MAX 8
>  #define MOCK_INJECT_TEST_MAX 128
>  
> +int param_inject_dev_max = MOCK_INJECT_DEV_MAX;
> +
>  static struct cxl_cel_entry mock_cel[] = {
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
> @@ -155,7 +157,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
>  		.total_capacity =
>  			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
> -		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_DEV_MAX),
> +		.inject_poison_limit = cpu_to_le16(param_inject_dev_max),
>  	};
>  
>  	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
> @@ -589,7 +591,7 @@ static struct cxl_mbox_poison_payload_out
>  	int nr_records = 0;
>  	u64 dpa;
>  
> -	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
> +	po = kzalloc(struct_size(po, record, param_inject_dev_max), GFP_KERNEL);
>  	if (!po)
>  		return NULL;
>  
> @@ -604,7 +606,7 @@ static struct cxl_mbox_poison_payload_out
>  		po->record[nr_records].address = cpu_to_le64(dpa);
>  		po->record[nr_records].length = cpu_to_le32(1);
>  		nr_records++;
> -		if (nr_records == MOCK_INJECT_DEV_MAX)
> +		if (nr_records == param_inject_dev_max)
>  			break;
>  	}
>  
> @@ -638,7 +640,7 @@ static bool mock_poison_dev_max_injected(struct cxl_dev_state *cxlds)
>  		if (mock_poison_list[i].cxlds == cxlds)
>  			count++;
>  	}
> -	return (count >= MOCK_INJECT_DEV_MAX);
> +	return (count >= param_inject_dev_max);
>  }
>  
>  static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
> @@ -909,6 +911,9 @@ static struct platform_driver cxl_mock_mem_driver = {
>  	},
>  };
>  
> +module_param(param_inject_dev_max, int, 0644);
> +MODULE_PARM_DESC(param_inject_dev_max, "Maximum number of physical addresses that can be poisoned in the mock device. The default is 8. The cxl_test driver limit is 128 across all mock devices.");
Perhaps: Maximum number of 64 byte blocks that can be poisoned...
> +
>  module_platform_driver(cxl_mock_mem_driver);
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);

