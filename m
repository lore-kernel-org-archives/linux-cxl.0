Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BD8C6FD1D
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Apr 2023 09:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjDDJTY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Apr 2023 05:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjDDJTW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 4 Apr 2023 05:19:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D41982
        for <linux-cxl@vger.kernel.org>; Tue,  4 Apr 2023 02:19:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrMYD6lxdz67YXJ;
        Tue,  4 Apr 2023 17:15:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Apr
 2023 10:19:10 +0100
Date:   Tue, 4 Apr 2023 10:19:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [PATCH v2] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <20230404101909.0000695a@Huawei.com>
In-Reply-To: <168056315526.436217.14417826023537916154.stgit@dwillia2-xfh.jf.intel.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
        <168056315526.436217.14417826023537916154.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 03 Apr 2023 16:06:14 -0700
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
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Link: https://lore.kernel.org/r/168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes since v1:
> - Swap out the local @range variable which was mostly only used for the
>   mapping length with a @len variable for that purpose (Jonathan)
> 
>  drivers/cxl/core/hdm.c |   27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9884b6d4d930..02cc2c38b44b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -738,14 +738,20 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
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
> +	u64 len;
> +	int rc;
> +
>  	if (!is_cxl_endpoint(port))
>  		return -EOPNOTSUPP;
>  
> -	if (!range_len(&info->dvsec_range[which]))
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +	len = range_len(&info->dvsec_range[which]);
> +	if (!len)
>  		return -ENOENT;
>  
>  	cxld->target_type = CXL_DECODER_EXPANDER;
> @@ -760,6 +766,16 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>  	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
>  	port->commit_end = cxld->id;
>  
> +	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
> +	if (rc) {
> +		dev_err(&port->dev,
> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> +			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
> +		return rc;
> +	}
> +	*dpa_base += len;
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +
>  	return 0;
>  }
>  
> @@ -779,7 +795,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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

