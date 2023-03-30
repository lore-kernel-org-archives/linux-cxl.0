Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508CDC6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 17:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjC3RBL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjC3RBJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 13:01:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B967CE065
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 10:00:43 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnV4H2HJZz6J7SZ;
        Fri, 31 Mar 2023 00:58:39 +0800 (CST)
Received: from localhost (10.48.159.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 18:00:20 +0100
Date:   Thu, 30 Mar 2023 18:00:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <20230330180019.00001b7b@Huawei.com>
In-Reply-To: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.159.148]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 29 Mar 2023 14:35:55 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> One motivation for mapping range registers to decoder objects is
> to use those settings for region autodiscovery.
> 
> The need to map a region for devices programmed to use range registers
> is especially urgent now that the kernel no longer routes "Soft
> Reserved" ranges in the memory map to device-dax by default. The CXL
> memory range loses all access mechanisms.
> 
> Complete the implementation by filling out ways and granularity, marking
> the DPA reservation, and setting the endpoint-decoder state to signal
> autodiscovery.
> 
> Fixes: 09d09e04d2fc ("cxl/dax: Create dax devices for CXL RAM regions")
> Tested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c |   30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9884b6d4d930..5339c0719177 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -738,20 +738,26 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>  	return 0;
>  }
>  
> -static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
> -					    struct cxl_decoder *cxld, int which,
> -					    struct cxl_endpoint_dvsec_info *info)
> +static int cxl_setup_hdm_decoder_from_dvsec(
> +	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
> +	int which, struct cxl_endpoint_dvsec_info *info)
>  {
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range *range;
> +	int rc;
> +
>  	if (!is_cxl_endpoint(port))
>  		return -EOPNOTSUPP;
>  
> -	if (!range_len(&info->dvsec_range[which]))
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +	range = &info->dvsec_range[which];
> +	if (!range_len(range))

You call range_len(range) quite a few times in here.
I'd be tempted to suggest a more minor diff of

	u64 len;
	...

	len = range_len(&info->dvsec_range[which]);

then use that throughout and don't bother with
the local range variable.

range is a bit odd to keep in a local variable as
it's not immediately obvious it's an hpa range - obviously you
could call it hpa_range which would help, but feels like
the length is the important bit except in one place.

>  		return -ENOENT;
>  
>  	cxld->target_type = CXL_DECODER_EXPANDER;
>  	cxld->commit = NULL;
>  	cxld->reset = NULL;
> -	cxld->hpa_range = info->dvsec_range[which];
> +	cxld->hpa_range = *range;
>  
>  	/*
>  	 * Set the emulated decoder as locked pending additional support to
> @@ -760,6 +766,17 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>  	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
>  	port->commit_end = cxld->id;
>  
> +	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, range_len(range), 0);
> +	if (rc) {
> +		dev_err(&port->dev,
> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> +			port->id, cxld->id, *dpa_base,
> +			*dpa_base + range_len(range) - 1, rc);
> +		return rc;
> +	}
> +	*dpa_base += range_len(range);
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +
>  	return 0;
>  }
>  
> @@ -779,7 +796,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	} target_list;
>  
>  	if (should_emulate_decoders(info))
> -		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> +		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> +							which, info);
>  
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>  	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> 

