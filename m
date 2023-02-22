Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39FFC636D6
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 12:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBVMxd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 07:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBVMxd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 07:53:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D823C23DBF
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 04:53:31 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PMGDV18QQz6J6Xs;
        Wed, 22 Feb 2023 20:48:42 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 22 Feb
 2023 12:53:28 +0000
Date:   Wed, 22 Feb 2023 12:53:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 1/2] cxl/hdm: Fix double allocation of @cxlhdm
Message-ID: <20230222125327.00007f4b@huawei.com>
In-Reply-To: <167703067936.185722.7908921750127154779.stgit@dwillia2-xfh.jf.intel.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
        <167703067936.185722.7908921750127154779.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 21 Feb 2023 17:51:19 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> devm_cxl_setup_emulated_hdm() reallocates an instance of @cxlhdm that
> was already allocated at the start of devm_cxl_setup_hdm(). Only one is
> needed and devm_cxl_setup_emulated_hdm() does not do enough to warrant
> being an explicit helper.
> 
> Fixes: 4474ce565ee4 ("cxl/hdm: Create emulated cxl_hdm for devices that do not have HDM decoders")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c |   34 ++++++----------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 45deda18ed32..520814130928 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -101,27 +101,6 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>  				      BIT(CXL_CM_CAP_CAP_ID_HDM));
>  }
>  
> -static struct cxl_hdm *devm_cxl_setup_emulated_hdm(struct cxl_port *port,
> -						   struct cxl_endpoint_dvsec_info *info)
> -{
> -	struct device *dev = &port->dev;
> -	struct cxl_hdm *cxlhdm;
> -
> -	if (!info->mem_enabled)
> -		return ERR_PTR(-ENODEV);
> -
> -	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
> -	if (!cxlhdm)
> -		return ERR_PTR(-ENOMEM);
> -

> -	cxlhdm->decoder_count = info->ranges;
> -	cxlhdm->target_count = info->ranges;
> -	dev_set_drvdata(&port->dev, cxlhdm);
> -
> -	return cxlhdm;
> -}
> -
>  /**
>   * devm_cxl_setup_hdm - map HDM decoder component registers
>   * @port: cxl_port to map
> @@ -138,13 +117,14 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
>  	if (!cxlhdm)
>  		return ERR_PTR(-ENOMEM);

> -	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
> -	if (!crb) {
> -		if (info && info->mem_enabled)
> -			return devm_cxl_setup_emulated_hdm(port, info);
> +	dev_set_drvdata(dev, cxlhdm);
>  
> +	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
> +	if (!crb && info && info->mem_enabled) {
> +		cxlhdm->decoder_count = info->ranges;
> +		cxlhdm->target_count = info->ranges;
> +	} else if (!crb) {
>  		dev_err(dev, "No component registers mapped\n");
>  		return ERR_PTR(-ENXIO);
>  	}
> @@ -160,8 +140,6 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> -	dev_set_drvdata(dev, cxlhdm);
> -
>  	return cxlhdm;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
> 

