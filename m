Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B1C61DA4
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 16:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBVQ5R (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 11:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBVQ5Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 11:57:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E3434016
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677085036; x=1708621036;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=TT9tFKZF5KFXDO58UtfrFr9qbPBF+iOQeEXn6xPbgOI=;
  b=oLBnoiFJIFX2JgWq+RONRZqxOrlZkYH7VKSY5h57oP09A/2Y9ygAd6Ri
   SzDr7xyf6QNEzMsBDZZQctKR5RKnV+o0qHR/WFl17zKeLoy2ev/Ns0WRZ
   +oGWCQNkmKvxdSa92/7PAYzwIt5W7pk0FWFEd8zSWdEgcavBvfozYvAff
   7eh8KUjTTK2ej4S7ZLnZuyDICb8jTjxb7zdCINJtjddQCJ/YV3LaZKdiH
   LAtx5GleP8QOtvVfXE0rw8KWKZIkk46wwJpnzfZLaubCQUECdphLWwH0T
   iDxXfoipVXQ0qBBie71UyoKnkjwrd9X4jdlLsKLB45xazagmj4oyfyTW5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="332978248"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="332978248"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 08:57:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="740890621"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="740890621"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.50.122]) ([10.212.50.122])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 08:57:13 -0800
Message-ID: <bd3d3821-a861-be0a-8d55-80136217495a@intel.com>
Date:   Wed, 22 Feb 2023 09:57:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cxl/hdm: Fix double allocation of @cxlhdm
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
 <167703067936.185722.7908921750127154779.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167703067936.185722.7908921750127154779.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/21/23 6:51 PM, Dan Williams wrote:
> devm_cxl_setup_emulated_hdm() reallocates an instance of @cxlhdm that
> was already allocated at the start of devm_cxl_setup_hdm(). Only one is
> needed and devm_cxl_setup_emulated_hdm() does not do enough to warrant
> being an explicit helper.
> 
> Fixes: 4474ce565ee4 ("cxl/hdm: Create emulated cxl_hdm for devices that do not have HDM decoders")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/hdm.c |   34 ++++++----------------------------
>   1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 45deda18ed32..520814130928 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -101,27 +101,6 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>   				      BIT(CXL_CM_CAP_CAP_ID_HDM));
>   }
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
> -	cxlhdm->port = port;
> -	cxlhdm->decoder_count = info->ranges;
> -	cxlhdm->target_count = info->ranges;
> -	dev_set_drvdata(&port->dev, cxlhdm);
> -
> -	return cxlhdm;
> -}
> -
>   /**
>    * devm_cxl_setup_hdm - map HDM decoder component registers
>    * @port: cxl_port to map
> @@ -138,13 +117,14 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>   	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
>   	if (!cxlhdm)
>   		return ERR_PTR(-ENOMEM);
> -
>   	cxlhdm->port = port;
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
>   		dev_err(dev, "No component registers mapped\n");
>   		return ERR_PTR(-ENXIO);
>   	}
> @@ -160,8 +140,6 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>   		return ERR_PTR(-ENXIO);
>   	}
>   
> -	dev_set_drvdata(dev, cxlhdm);
> -
>   	return cxlhdm;
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
> 
