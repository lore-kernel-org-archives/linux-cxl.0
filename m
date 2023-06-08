Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E884C7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 13:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjFHNb7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFHNb6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 09:31:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33CEE4A;
        Thu,  8 Jun 2023 06:31:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcQ6k3MH4z688p7;
        Thu,  8 Jun 2023 21:29:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 14:31:54 +0100
Date:   Thu, 8 Jun 2023 14:31:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 3/4] tools/testing/cxl: Use named effects for the
 Command Effect Log
Message-ID: <20230608143153.00007ae1@Huawei.com>
In-Reply-To: <20230602-vv-fw_update-v2-3-e9e5cd5adb44@intel.com>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
        <20230602-vv-fw_update-v2-3-e9e5cd5adb44@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 05 Jun 2023 14:20:24 -0600
Vishal Verma <vishal.l.verma@intel.com> wrote:

> As more emulated mailbox commands are added to cxl_test, it is a pain
> point to look up command effect numbers for each effect. Replace the
> bare numbers in the mock driver with an enum that lists all possible
> effects.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
LGTM 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/mem.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 403cd3608772..68668d8df1cd 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -21,42 +21,56 @@
>  
>  static unsigned int poison_inject_dev_max = MOCK_INJECT_DEV_MAX;
>  
> +enum cxl_command_effects {
> +	CONF_CHANGE_COLD_RESET = 0,
> +	CONF_CHANGE_IMMEDIATE,
> +	DATA_CHANGE_IMMEDIATE,
> +	POLICY_CHANGE_IMMEDIATE,
> +	LOG_CHANGE_IMMEDIATE,
> +	SECURITY_CHANGE_IMMEDIATE,
> +	BACKGROUND_OP,
> +	SECONDARY_MBOX_SUPPORTED,
> +};
> +
> +#define CXL_CMD_EFFECT_NONE cpu_to_le16(0)
> +
>  static struct cxl_cel_entry mock_cel[] = {
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_IDENTIFY),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_LSA),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_PARTITION_INFO),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
> -		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
> +		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE) |
> +				      EFFECT(DATA_CHANGE_IMMEDIATE)),
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
> -		.effect = cpu_to_le16(EFFECT(2)),
> +		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
> -		.effect = cpu_to_le16(EFFECT(2)),
> +		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
>  	},
>  };
>  
> 

