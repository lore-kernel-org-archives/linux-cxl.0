Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F70C04A6A
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Aug 2023 14:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjHGOYS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjHGOYQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Aug 2023 10:24:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA7170A
        for <linux-cxl@vger.kernel.org>; Mon,  7 Aug 2023 07:24:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKJNK0TYsz6HJc0;
        Mon,  7 Aug 2023 22:19:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 15:24:08 +0100
Date:   Mon, 7 Aug 2023 15:24:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/region: Try to add a region resource to a
 soft reserved parent
Message-ID: <20230807152407.000070e6@Huawei.com>
In-Reply-To: <6cd07222f169d951921486306187e87951853035.1691176651.git.alison.schofield@intel.com>
References: <cover.1691176651.git.alison.schofield@intel.com>
        <6cd07222f169d951921486306187e87951853035.1691176651.git.alison.schofield@intel.com>
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

On Fri,  4 Aug 2023 12:31:39 -0700
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
> Search for soft reserved resources that include the region resource,
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

Hi Alison

A comment and a question inline.

Thanks,

Jonathan

> ---
>  drivers/cxl/core/region.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..36c0c0dd5697 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2709,6 +2709,28 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static int insert_resource_soft_reserved(struct resource *soft_res, void *arg)
> +{
> +	struct resource *parent, *new, *res = arg;
> +	bool found = false;
> +
> +	parent = soft_res->parent;
> +	if (!parent)
> +		return 0;
> +
> +	/* Caller provides a copy of soft_res. Find the actual resource. */
> +	for (new = parent->child; new; new = new->sibling) {
> +		if (resource_contains(new, soft_res)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (found)
> +		return insert_resource(new, res) == 0;

Why not do this in the the if above then directly return there?
Also, should we get an error here, does it make sense to carry on?
(I don't think we can get an error, but if that's the case we shouldn't
 be checking for one)  If it's a corner we aren't sure about, good
to add a comment on what the error case might be and what we are doing
as a result.

> +
> +	return 0;
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -2719,7 +2741,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	struct resource *res;
> -	int rc;
> +	int rc = 0;
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -2755,7 +2777,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> -	rc = insert_resource(cxlrd->res, res);
> +
> +	/* Try inserting to a Soft Reserved parent, fallback to root decoder */
> +	if (walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, 0,
> +				res->start, res->end, res,
> +				insert_resource_soft_reserved) != 1)
> +		rc = insert_resource(cxlrd->res, res);
> +
>  	if (rc) {
>  		/*
>  		 * Platform-firmware may not have split resources like "System

