Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679EC761A6
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 17:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjC3RCr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjC3RCq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 13:02:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA497E1AC
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 10:02:35 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnV830K1Dz6J7fD;
        Fri, 31 Mar 2023 01:01:55 +0800 (CST)
Received: from localhost (10.48.159.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 18:02:33 +0100
Date:   Thu, 30 Mar 2023 18:02:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Limit emulation to the number of range
 registers
Message-ID: <20230330180232.00004c84@Huawei.com>
In-Reply-To: <168012574932.221280.15944705098679646436.stgit@dwillia2-xfh.jf.intel.com>
References: <168012574932.221280.15944705098679646436.stgit@dwillia2-xfh.jf.intel.com>
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

On Wed, 29 Mar 2023 14:35:49 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Recall that range register emulation seeks to treat the 2 potential
> range registers as Linux CXL "decoder" objects. The number of range
> registers can be 1 or 2, while HDM decoder ranges can include more than
> 2.
> 
> Be careful not to confuse DVSEC range count with HDM capability decoder
> count. Commit to range register earlier in devm_cxl_setup_hdm().
> Otherwise, a device with more HDM decoders than range registers can set
> @cxlhdm->decoder_count to an invalid value.
> 
> Avoid introducing a forward declaration by just moving the definition of
> should_emulate_decoders() earlier in the file. should_emulate_decoders()
> is unchanged.
> 
> Tested-by: Dave Jiang <dave.jiang@intel.com>
> Fixes: d7a2153762c7 ("cxl/hdm: Add emulation when HDM decoders are not committed")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Seems reasonable.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c |   82 +++++++++++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index cc123996b1a4..9884b6d4d930 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -101,6 +101,42 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>  				      BIT(CXL_CM_CAP_CAP_ID_HDM));
>  }
>  
> +static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> +{
> +	struct cxl_hdm *cxlhdm;
> +	void __iomem *hdm;
> +	u32 ctrl;
> +	int i;
> +
> +	if (!info)
> +		return false;
> +
> +	cxlhdm = dev_get_drvdata(&info->port->dev);
> +	hdm = cxlhdm->regs.hdm_decoder;
> +
> +	if (!hdm)
> +		return true;
> +
> +	/*
> +	 * If HDM decoders are present and the driver is in control of
> +	 * Mem_Enable skip DVSEC based emulation
> +	 */
> +	if (!info->mem_enabled)
> +		return false;
> +
> +	/*
> +	 * If any decoders are committed already, there should not be any
> +	 * emulated DVSEC decoders.
> +	 */
> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  /**
>   * devm_cxl_setup_hdm - map HDM decoder component registers
>   * @port: cxl_port to map
> @@ -140,6 +176,16 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> +	/*
> +	 * Now that the hdm capability is parsed, decide if range
> +	 * register emulation is needed and fixup cxlhdm accordingly.
> +	 */
> +	if (should_emulate_decoders(info)) {
> +		dev_dbg(dev, "Fallback map %d range register%s\n", info->ranges,
> +			info->ranges > 1 ? "s" : "");
> +		cxlhdm->decoder_count = info->ranges;
> +	}
> +
>  	return cxlhdm;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
> @@ -717,42 +763,6 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>  	return 0;
>  }
>  
> -static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> -{
> -	struct cxl_hdm *cxlhdm;
> -	void __iomem *hdm;
> -	u32 ctrl;
> -	int i;
> -
> -	if (!info)
> -		return false;
> -
> -	cxlhdm = dev_get_drvdata(&info->port->dev);
> -	hdm = cxlhdm->regs.hdm_decoder;
> -
> -	if (!hdm)
> -		return true;
> -
> -	/*
> -	 * If HDM decoders are present and the driver is in control of
> -	 * Mem_Enable skip DVSEC based emulation
> -	 */
> -	if (!info->mem_enabled)
> -		return false;
> -
> -	/*
> -	 * If any decoders are committed already, there should not be any
> -	 * emulated DVSEC decoders.
> -	 */
> -	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
>  static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
> 

