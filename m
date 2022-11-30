Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A32C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 16:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiK3Qmk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 11:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiK3Qmj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 11:42:39 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA2DC0D
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 08:42:38 -0800 (PST)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMlNh0HMgz6H6jY;
        Thu,  1 Dec 2022 00:42:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 17:42:36 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 16:42:36 +0000
Date:   Wed, 30 Nov 2022 16:42:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/region: Check addr trans at pmem region create
 (debug only)
Message-ID: <20221130164235.000064a5@Huawei.com>
In-Reply-To: <48b8ab49a54597d56b1732fc4e2955b5e726d4c9.1669153711.git.alison.schofield@intel.com>
References: <cover.1669153711.git.alison.schofield@intel.com>
        <48b8ab49a54597d56b1732fc4e2955b5e726d4c9.1669153711.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 22 Nov 2022 15:07:49 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> At the time of region creation, device physical addresses (DPA)
> are mapped to host physical addresses (HPA). The CXL driver
> translates DPA's to HPA's for user space consumption. In order
> to prove and exercise that translation functionality, perform
> a small sample of DPA to HPA translations whenever a pmem region
> is created in a debug kernel.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
I'd drop this patch - it isn't doing a particularly useful check
as it only checks the resulting HPA is in range, not that it's
actually correct.


> ---
>  drivers/cxl/core/region.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c847517e766c..32216b5fe450 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1945,6 +1945,36 @@ u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
>  	return hpa;
>  }
>  
> +static bool cxl_check_addrtrans(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled;
> +	u64 start, end, dpa;
> +
> +	/*
> +	 * Translate a few DPAs (start,mid,end) to HPAs
> +	 * for each contributing endpoint decoder.
> +	 */
> +	for (int i = 0; i <  p->nr_targets; i++) {
> +		cxled = p->targets[i];
> +		start = cxl_dpa_resource_start(cxled);
> +		end = start + cxl_dpa_size(cxled) - 1;
> +
> +		dpa = start;
> +		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
> +			return false;
Hmm. This verifies they are in range, but not that the
address is right.  Not sure that is particularly helpful.
Also - in theory, hpa address 0 is valid value, or does something
stop people putting a CFMWS at HPA 0 onwards?
Sure it's unlikely anyone will do so, but not impossible...

> +
> +		dpa = start + cxl_dpa_size(cxled) / 2;
> +		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
> +			return false;
> +
> +		dpa = end;
> +		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
> +			return false;
Maybe more useful to check 1 higher and trip the 'out of range'
return?
> +	}
> +	return true;
> +}
> +
>  /**
>   * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
>   * @cxlr: parent CXL region for this pmem region bridge device
> @@ -1973,8 +2003,10 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>  		dev_name(dev));
>  
> +	dev_dbg(&cxlr->dev, "Address translation check: %s\n",
> +		cxl_check_addrtrans(cxlr) ? "Pass" : "Fail");
> +
>  	return devm_add_action_or_reset(&cxlr->dev, cxlr_pmem_unregister, dev);
> -

stray change

>  err:
>  	put_device(dev);
>  	return rc;

