Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B08BC88CB2
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Aug 2023 11:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbjHYLsR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Aug 2023 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244181AbjHYLrt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Aug 2023 07:47:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E02106
        for <linux-cxl@vger.kernel.org>; Fri, 25 Aug 2023 04:47:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RXJ4N0lwvz6J78f;
        Fri, 25 Aug 2023 19:43:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 12:47:44 +0100
Date:   Fri, 25 Aug 2023 12:47:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/region: Try to add a region resource to a
 soft reserved parent
Message-ID: <20230825124743.00000aa7@Huawei.com>
In-Reply-To: <4cf018843ee9846c5b9907b8fc7140ab66b929b6.1692638817.git.alison.schofield@intel.com>
References: <cover.1692638817.git.alison.schofield@intel.com>
        <4cf018843ee9846c5b9907b8fc7140ab66b929b6.1692638817.git.alison.schofield@intel.com>
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

On Mon, 21 Aug 2023 11:14:36 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> During region autodiscovery, the region driver always inserts the
> region resource as a child of the root decoder, a CXL WINDOW. It
> has the effect of making a soft reserved resource, with an exactly
> matching address range, a child of the region resource.
> 
> It looks like this in /proc/iomem:
> 
> 2080000000-29dbfffffff : CXL Window 0
>   2080000000-247fffffff : region0
>     2080000000-247fffffff : Soft Reserved
> 
> Search for soft reserved resources that include the region resource
> and add the new region resource as a child of that found resource.
> If a soft reserved resource is not found, insert to the root decoder
> as usual.
> 
> With this change, it looks like this:
> 
> 2080000000-29dbfffffff : CXL Window 0
>   2080000000-247fffffff : Soft Reserved
>     2080000000-247fffffff : region0
> 
> This odd parenting only occurs when the resources are an exact match.
> When the region resource only uses part of a soft reserved resource,
> the parenting appears more logical like this:
> 
> 2080000000-29dbfffffff : CXL Window 0
>   2080000000-287fffffff : Soft Reserved
>     2080000000-247fffffff : region0
> 
> Aside from the more logical appearance, this change is in preparation
> for further cleanup in region teardown. A follow-on patch intends to
> find and free soft reserved resources upon region teardown.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
One trivial comment inline. Feel free to ignore.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 57 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..5c487aab15ad 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2709,6 +2709,31 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static int insert_resource_soft_reserved(struct resource *soft_res, void *arg)
> +{
> +	struct resource *parent, *new, *res = arg;
> +	bool found = false;
> +	int rc = 0;
> +
> +	parent = soft_res->parent;
> +	if (!parent)
> +		return 0;
> +
> +	/* Caller provides a copy of soft_res. Find the actual resource. */
> +	for (new = parent->child; new; new = new->sibling) {
> +		if (resource_contains(new, soft_res)) {
> +			rc = insert_resource(new, res);
> +			found = true;
> +			break;
> +		}
> +	}
> +	/* Caller handles failure to find or insert resource */
> +	if (!found || rc)
> +		return rc;

rc is only set in the found path, so could move this check up there to
simplify flow a tiny bit.  Not that important...

> +
> +	return 1;
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -2755,16 +2780,28 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> -	rc = insert_resource(cxlrd->res, res);
> -	if (rc) {
> -		/*
> -		 * Platform-firmware may not have split resources like "System
> -		 * RAM" on CXL window boundaries see cxl_region_iomem_release()
> -		 */
> -		dev_warn(cxlmd->dev.parent,
> -			 "%s:%s: %s %s cannot insert resource\n",
> -			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			 __func__, dev_name(&cxlr->dev));
> +
> +	/* Try inserting to a Soft Reserved parent. Fallback to root decoder */
> +	rc = walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, 0, res->start,
> +				 res->end, res, insert_resource_soft_reserved);
> +	if (!rc || rc == -EBUSY)
> +		dev_dbg(&cxlmd->dev,
> +			"insert %pr to soft reserved parent failed rc:%d\n",
> +			res, rc);
> +	if (rc != 1) {
> +		rc = insert_resource(cxlrd->res, res);
> +		if (rc) {
> +			/*
> +			 * Platform-firmware may not have split resources
> +			 * like "System RAM" on CXL window boundaries see
> +			 * cxl_region_iomem_release()
> +			 */
> +			dev_warn(cxlmd->dev.parent,
> +				 "%s:%s: %s %s cannot insert resource\n",
> +				 dev_name(&cxlmd->dev),
> +				 dev_name(&cxled->cxld.dev), __func__,
> +				 dev_name(&cxlr->dev));
> +		}
>  	}
>  
>  	p->res = res;

