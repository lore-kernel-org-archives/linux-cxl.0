Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B20C7EE24
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 14:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbjFFOaM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbjFFOaJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 10:30:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A77410C6
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 07:29:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbCXB373Tz6J6r5;
        Tue,  6 Jun 2023 22:28:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 15:29:15 +0100
Date:   Tue, 6 Jun 2023 15:29:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 11/19] cxl/region: Factor out construct_region_{begin,
 end} and drop_region() for reuse
Message-ID: <20230606152914.0000610f@Huawei.com>
In-Reply-To: <168592155858.1948938.18413203801464814822.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592155858.1948938.18413203801464814822.stgit@dwillia2-xfh.jf.intel.com>
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

On Sun, 04 Jun 2023 16:32:38 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for constructing regions from newly allocated HPA, factor
> out some helpers that can be shared with the existing kernel-internal
> region construction from BIOS pre-allocated regions. Handle acquiring a
> new region object under the region rwsem, and optionally tearing it down
> if the region assembly process fails.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Nasty diff to read! :)  When will some add some AI magic to git diff so
we get easier code to review?

I 'think' it ends up fine. Comments are about the usual balance
of keeping opencoded side effect removal code in error handers (making it
easier to review) vs small amount of code duplication.

Jonathan

> ---
>  drivers/cxl/core/region.c |   73 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 52 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c7170d92f47f..bd3c3d4b2683 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2191,19 +2191,25 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>  	return to_cxl_region(region_dev);
>  }
>  
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport, unregister_region, cxlr);
> +}
> +
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> -	struct cxl_port *port = to_cxl_port(dev->parent);
>  	struct cxl_region *cxlr;
>  
>  	cxlr = cxl_find_region_by_name(cxlrd, buf);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
> -
> -	devm_release_action(port->uport, unregister_region, cxlr);
> +	drop_region(cxlr);
>  	put_device(&cxlr->dev);
>  
>  	return len;
> @@ -2664,17 +2670,19 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static void construct_region_end(void)
> +{
> +	up_write(&cxl_region_rwsem);
> +}
> +
> +static struct cxl_region *
> +construct_region_begin(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> -	struct resource *res;
> -	int rc;
> +	int err = 0;
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -2693,19 +2701,41 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	p = &cxlr->params;
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s autodiscovery interrupted\n",
> +			"%s:%s: %s region setup interrupted\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__);
> -		rc = -EBUSY;
> -		goto err;
> +		err = -EBUSY;
> +	}
> +
> +	if (err) {
> +		construct_region_end();

Unless you are going to add more in construct_region_end()
later I'd be tempted to just have the up_write() here as it
can clearly match against the down_write() earlier in the function.

> +		drop_region(cxlr);

Hmm. I'm int two minds about this vs opencoding it for readability.
Given drop_region matches with construct_region() I'd slightly prefer this
open coded as well so I can do nice easy matches on what it's unwinding.

> +		return ERR_PTR(err);
>  	}
> +	return cxlr;
> +}
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
>  
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
>  	if (!res) {
>  		rc = -ENOMEM;
> -		goto err;
> +		goto out;
>  	}
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> @@ -2722,6 +2752,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  			 __func__, dev_name(&cxlr->dev));
>  	}
>  
> +	p = &cxlr->params;
>  	p->res = res;
>  	p->interleave_ways = cxled->cxld.interleave_ways;
>  	p->interleave_granularity = cxled->cxld.interleave_granularity;
> @@ -2729,7 +2760,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>  	if (rc)
> -		goto err;
> +		goto out;
>  
>  	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
>  		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
> @@ -2738,14 +2769,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	/* ...to match put_device() in cxl_add_to_region() */
>  	get_device(&cxlr->dev);
> -	up_write(&cxl_region_rwsem);
>  
> +out:
> +	construct_region_end();
> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
>  	return cxlr;
> -
> -err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport, unregister_region, cxlr);
> -	return ERR_PTR(rc);
>  }
>  
>  int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
> 

