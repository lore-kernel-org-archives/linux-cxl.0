Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C31CCA553C
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 16:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjIMQcI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 12:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMQcI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 12:32:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27DB19A7
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 09:32:03 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm5XT2Dzgz67n5j;
        Thu, 14 Sep 2023 00:30:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 17:32:00 +0100
Date:   Wed, 13 Sep 2023 17:31:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/region: Match auto-discovered region decoders by
 HPA range
Message-ID: <20230913173159.00007124@Huawei.com>
In-Reply-To: <20230905211007.256385-1-alison.schofield@intel.com>
References: <20230905211007.256385-1-alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue,  5 Sep 2023 14:10:07 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Currently, when the region driver attaches a region to a port, it
> selects the ports next available decoder to program.
> 
> With the addition of auto-discovered regions, a port decoder has
> already been programmed so grabbing the next available decoder can
> be a mismatch when there is more than one region using the port.
> 
> The failure appears like this with CXL DEBUG enabled:
> 
> [] cxl_core:alloc_region_ref:754: cxl region0: endpoint9: HPA order violation region0:[mem 0x14780000000-0x1478fffffff flags 0x200] vs [mem 0x880000000-0x185fffffff flags 0x200]
> [] cxl_core:cxl_port_attach_region:972: cxl region0: endpoint9: failed to allocate region reference
> 
> When CXL DEBUG is not enabled, there is no failure message. The region
> just never materializes. Users can suspect this issue if they know their
> firmware has programmed decoders so that more than one region is using
> a port. Note that the problem may appear intermittently, ie not on
> every reboot.
> 
> Add a matching method for auto-discovered regions that finds a decoder
> based on an HPA range. The decoder range must exactly match the region
> resource parameter.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
LGTM as addressed only thing I found in v2.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> Changes in v3:
> - Update match_auto_decoder() to simply return 1 if found, 0 if not found.
>   Conflict resolution is already done in cxl_rr_alloc_decoder()
>   (Jonathan, Dan)
> - Add Reviewed-by tags (DaveJ, Davidlohr)
> - v2: https://lore.kernel.org/linux-cxl/20230822014303.110509-1-alison.schofield@intel.com/
> 
> Changes in v2:
> - Use cxlr->params for HPA match rather than requiring cxled (Dan)
> - dev_warn() if decoder already assigned to a region (Dan)
> - Add failure footprint to commit log (Dan)
> - Add Fixes Tag (Dan)
> - v1: https://lore.kernel.org/linux-cxl/20230804213004.1669658-1-alison.schofield@intel.com/
> 
> 
>  drivers/cxl/core/region.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..b4c6a749406f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -717,13 +717,35 @@ static int match_free_decoder(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static int match_auto_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_region_params *p = data;
> +	struct cxl_decoder *cxld;
> +	struct range *r;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxld = to_cxl_decoder(dev);
> +	r = &cxld->hpa_range;
> +
> +	if (p->res && p->res->start == r->start && p->res->end == r->end)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
>  						   struct cxl_region *cxlr)
>  {
>  	struct device *dev;
>  	int id = 0;
>  
> -	dev = device_find_child(&port->dev, &id, match_free_decoder);
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +		dev = device_find_child(&port->dev, &cxlr->params,
> +					match_auto_decoder);
> +	else
> +		dev = device_find_child(&port->dev, &id, match_free_decoder);
>  	if (!dev)
>  		return NULL;
>  	/*
> 
> base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9

