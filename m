Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BF27280C;
	Fri, 12 Sep 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711411; cv=none; b=M7NbLrJl+rvguoL0fnkN7pgUIQRgtBdOMceBmStcKVgBO2VF2NbfO9IuuabNywYtKYj7ddKTxKI17/HCZfjCpaPe0eWSuFFEsgE4IYG5y6NV+k7FUdQuI1tScURLVyASfvjQasMFVJv8LmzWiFL5YpGQ+j5+sWRcuEYtBHvOg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711411; c=relaxed/simple;
	bh=RdVRenqde6tKtbAWWyAHuu47t4tBwDWB8bWLsQadw+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jR2j6kAri16joEgIzp4G27BWFFmngiXQRc1DDkaE17KoBzVzAYqDTwQvxWtIJwsBawa8peYKRnwfOMYsedhLZd9fE1tFG5jY3BLB3ma9Xluq5R4XNNx3ako7L+6nRXrThADcDRa16313VY7/H5TLS5ZBtMtPXD97YtgiAuDliP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FajGy1lF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FajGy1lF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757711410; x=1789247410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RdVRenqde6tKtbAWWyAHuu47t4tBwDWB8bWLsQadw+A=;
  b=FajGy1lFGMke6s9cUm3qPuxUS628dZCFORj7qmZm77vBQyU5y5nGmrc5
   rJV9icTep93aP8ImGOGf43qGOH8c2s6c497HxMx+LI8Yi5jmhV7pywf6j
   VqSTY9VMnSYip76EoO0pAoIzHRSqvaGBbV28dDbdjRcRymt9znVGqDZWh
   zwEK6Mb5lu/WmJYPD9PoBEbBdggZX6q+au6t0weNnr4vBpvl1dmekt8Ln
   chhojH31HXv+hs8f4Zr9vLLxnlC+1T8+8djCK8tbKCstAYYLvGcWjHhQT
   19v/5iwyGQ/2dNLpLlEsPjx8PJ5Axea6KX5yh5WwWdd5Z8N0mNzRhwucG
   Q==;
X-CSE-ConnectionGUID: +r4SjhH7RQC79LGrUzWoag==
X-CSE-MsgGUID: XwjKfN2ASnKt7LcuHcwCsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60208941"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="60208941"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 14:10:09 -0700
X-CSE-ConnectionGUID: v9s3Ryi6R1e2zHl4p9shSA==
X-CSE-MsgGUID: DtftzBUjRC+xjnGEJdAhVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="179251799"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 14:10:09 -0700
Message-ID: <3d44af04-f7d6-4625-b07d-40173bc95c35@intel.com>
Date: Fri, 12 Sep 2025 14:10:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] cxl/region: Separate region parameter setup and
 region construction
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-7-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250912144514.526441-7-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 7:45 AM, Robert Richter wrote:
> To construct a region, the region parameters such as address range and
> interleaving config need to be determined. This is done while
> constructing the region by inspecting the endpoint decoder
> configuration. The endpoint decoder is passed as a function argument.
> 
> With address translation the endpoint decoder data is no longer
> sufficient to extract the region parameters as some of the information
> is obtained using other methods such as using firmware calls.
> 
> In a first step, separate code to determine and setup the region
> parameters from the region construction. Temporarily store all the
> data to create the region in the new struct cxl_region_context. Add a
> new function setup_region_parameters() to fill that struct and later
> use it to construct the region. This simplifies the extension of the
> function to support other methods needed, esp. to support address
> translation.
> 
> Patch is a prerequisite to implement address translation.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 50 +++++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 106692f1e310..57697504410b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3414,6 +3414,26 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> +struct cxl_region_context {
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
> +	struct range hpa_range;
> +	int interleave_ways;
> +	int interleave_granularity;
> +};
> +
> +static int setup_region_params(struct cxl_endpoint_decoder *cxled,
> +			       struct cxl_region_context *ctx)
> +{
> +	ctx->cxled = cxled;
> +	ctx->cxlmd = cxled_to_memdev(cxled);
> +	ctx->hpa_range = cxled->cxld.hpa_range;
> +	ctx->interleave_ways = cxled->cxld.interleave_ways;
> +	ctx->interleave_granularity = cxled->cxld.interleave_granularity;

You can init like this:

	*ctx = (struct cxl_region_context) {
		.cxled = cxled,
		.cxlmd = cxled_to_memdev(cxled),
		.hpa_range = cxled->cxld.hpa_range,
		.interleave_ways = cxled->cxld.interleave_ways,
		.interleave_granularity = cxled->cxld.interleave_granularity,
	};


> +
> +	return 0;

Can probably make this function void if no expected errors and only assignments.

DJ

> +}
> +
>  static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  					    struct resource *res)
>  {
> @@ -3453,11 +3473,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  }
>  
>  static int __construct_region(struct cxl_region *cxlr,
> -			      struct cxl_endpoint_decoder *cxled)
> +			      struct cxl_region_context *ctx)
>  {
> +	struct cxl_endpoint_decoder *cxled = ctx->cxled;
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct range *range = &cxled->cxld.hpa_range;
> +	struct cxl_memdev *cxlmd = ctx->cxlmd;
> +	struct range *range = &ctx->hpa_range;
>  	struct cxl_region_params *p;
>  	struct resource *res;
>  	int rc;
> @@ -3506,8 +3527,8 @@ static int __construct_region(struct cxl_region *cxlr,
>  	}
>  
>  	p->res = res;
> -	p->interleave_ways = cxled->cxld.interleave_ways;
> -	p->interleave_granularity = cxled->cxld.interleave_granularity;
> +	p->interleave_ways = ctx->interleave_ways;
> +	p->interleave_granularity = ctx->interleave_granularity;
>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
> @@ -3527,9 +3548,10 @@ static int __construct_region(struct cxl_region *cxlr,
>  
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +					   struct cxl_region_context *ctx)
>  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_endpoint_decoder *cxled = ctx->cxled;
> +	struct cxl_memdev *cxlmd = ctx->cxlmd;
>  	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	int rc, part = READ_ONCE(cxled->part);
> @@ -3548,7 +3570,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  		return cxlr;
>  	}
>  
> -	rc = __construct_region(cxlr, cxled);
> +	rc = __construct_region(cxlr, ctx);
>  	if (rc) {
>  		devm_release_action(port->uport_dev, unregister_region, cxlr);
>  		return ERR_PTR(rc);
> @@ -3572,13 +3594,17 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *range)
>  
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *range = &cxled->cxld.hpa_range;
> +	struct cxl_region_context ctx;
>  	struct cxl_region_params *p;
>  	bool attach = false;
>  	int rc;
>  
> +	rc = setup_region_params(cxled, &ctx);
> +	if (rc)
> +		return rc;
> +
>  	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
> -		cxl_find_root_decoder(cxled, range);
> +		cxl_find_root_decoder(cxled, &ctx.hpa_range);
>  	if (!cxlrd)
>  		return -ENXIO;
>  
> @@ -3589,9 +3615,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =
> -		cxl_find_region_by_range(cxlrd, range);
> +		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
>  	if (!cxlr)
> -		cxlr = construct_region(cxlrd, cxled);
> +		cxlr = construct_region(cxlrd, &ctx);
>  	mutex_unlock(&cxlrd->range_lock);
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);

