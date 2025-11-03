Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F253135979;
	Mon,  3 Nov 2025 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207535; cv=none; b=iJUWnJVV60QeF4xOJf9qCOoMIuRKX15x+TxfkJBCXF7e4Iixl8Vp0WIPjIRxitDQeNVLwPvWM29H3aRFdR3klthQE7XFjmn/p3VOyYu3NssgbuOGKJgK7oKPTMgX0nXKs9/FSJPu4j9TTrw2T19TIer1oWGz2gTzqMoOWKaaHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207535; c=relaxed/simple;
	bh=QDPxJ9N8vtxL1d3jAIfPzRZFKdZ2M2MkD9AhJ27JSgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7xlUhoFTrSbRgjZV2ou9ZigCopEtv8+V6yy+GjUeR7O+fC2NVKuDoE8Z23ePSRq1VWGAb4aPc4icUqPirWWJdfEY4f3OVJyITlufljXJBcxzekQIjlkRuZc95uuNqvybduXn2w5r+JmROx02JEO9wn4yh7ZrP8c3XUS7iROC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFFc1+ic; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFFc1+ic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762207531; x=1793743531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QDPxJ9N8vtxL1d3jAIfPzRZFKdZ2M2MkD9AhJ27JSgk=;
  b=PFFc1+icOfOxggNfXi6UYCgrT6rK7YwOW5N/zBkDaV5QVU3v/CUawTmd
   X/Mo2KdMma2yraRkfDM9QQbIDdgCmoK35F4cDwNtlh2pWorPAt3T9Cg8j
   wyEs7Mt0sIi0vFF68NeRCf3z/SMBGi3BQMtg7o+op2aw/dTAPkd2qEv+w
   wUfROqYcRZFPoDocRBt1p7IshOMmaHysoCXF+378p0R/IkqXtlz1jVSYv
   kZxpoAJ8rUoUCkCqkG/loZAs59o1n9pT4S3y/MTJGWQ9kxuyoQC/hCqd4
   4bVyeuGB93wwnxEPTR4xVpqDN7Pk9E/cYiz5hzDmAax7sflrUvcH10qaT
   Q==;
X-CSE-ConnectionGUID: wdyO3IqnQeWKROnqdhsJvw==
X-CSE-MsgGUID: cleNHtTdRGiiRgQmO9eD9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63306839"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="63306839"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:05:31 -0800
X-CSE-ConnectionGUID: Lj/TDkb7RVyVYtDWQc5AYw==
X-CSE-MsgGUID: z2TAkmj7QeKWiuNN8AD5mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186660860"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:05:29 -0800
Message-ID: <d34130ca-83fb-4f9d-b724-007b549f6f34@intel.com>
Date: Mon, 3 Nov 2025 15:05:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/14] cxl/region: Separate region parameter setup and
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
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-7-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251103184804.509762-7-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 11:47 AM, Robert Richter wrote:
> To construct a region, the region parameters such as address range and
> interleaving config need to be determined. This is done while
> constructing the region by inspecting the endpoint decoder
> configuration. The endpoint decoder is passed as a function argument.
> 
> With address translation the endpoint decoder data is no longer
> sufficient to extract the region parameters as some of the information
> is obtained using other methods such as using firmware calls.
> 
> In a first step, separate code to determine the region parameters from
> the region construction. Temporarily store all the data to create the
> region in the new struct cxl_region_context. Once the region data is
> determined and struct cxl_region_context is filled, construct the
> region.
> 
> Patch is a prerequisite to implement address translation. The code
> separation helps to later extend it to determine region parameters
> using other methods as needed, esp. to support address translation.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Just a small thing below, otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/core.h   |  9 +++++++++
>  drivers/cxl/core/region.c | 32 +++++++++++++++++++++-----------
>  2 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1fb66132b777..2bc37f3aee21 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -19,6 +19,15 @@ enum cxl_detach_mode {
>  };
>  
>  #ifdef CONFIG_CXL_REGION
> +
> +struct cxl_region_context {
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;

cxlmd may not be needed.

struct cxl_memdev *cxlmd = cxled_to_memdev(cxlr_ctx->cxled);

which you used later on in this patch to init the cxlmd member :)

DJ

> +	struct range hpa_range;
> +	int interleave_ways;
> +	int interleave_granularity;
> +};
> +
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
>  extern struct device_attribute dev_attr_delete_region;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d3557d9d5b0f..2cfc29a2b588 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3448,11 +3448,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  }
>  
>  static int __construct_region(struct cxl_region *cxlr,
> -			      struct cxl_endpoint_decoder *cxled)
> +			      struct cxl_region_context *ctx)
>  {
> +	struct cxl_endpoint_decoder *cxled = ctx->cxled;
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct range *hpa_range = &cxled->cxld.hpa_range;
> +	struct cxl_memdev *cxlmd = ctx->cxlmd;
> +	struct range *hpa_range = &ctx->hpa_range;
>  	struct cxl_region_params *p;
>  	struct resource *res;
>  	int rc;
> @@ -3501,8 +3502,8 @@ static int __construct_region(struct cxl_region *cxlr,
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
> @@ -3522,9 +3523,10 @@ static int __construct_region(struct cxl_region *cxlr,
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
> @@ -3543,7 +3545,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  		return cxlr;
>  	}
>  
> -	rc = __construct_region(cxlr, cxled);
> +	rc = __construct_region(cxlr, ctx);
>  	if (rc) {
>  		devm_release_action(port->uport_dev, unregister_region, cxlr);
>  		return ERR_PTR(rc);
> @@ -3568,11 +3570,19 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
>  
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa_range = &cxled->cxld.hpa_range;
> +	struct cxl_region_context ctx;
>  	struct cxl_region_params *p;
>  	bool attach = false;
>  	int rc;
>  
> +	ctx = (struct cxl_region_context) {
> +		.cxled = cxled,
> +		.cxlmd = cxled_to_memdev(cxled),
> +		.hpa_range = cxled->cxld.hpa_range,
> +		.interleave_ways = cxled->cxld.interleave_ways,
> +		.interleave_granularity = cxled->cxld.interleave_granularity,
> +	};
> +
>  	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
>  		cxl_find_root_decoder(cxled);
>  	if (!cxlrd)
> @@ -3585,9 +3595,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =
> -		cxl_find_region_by_range(cxlrd, hpa_range);
> +		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
>  	if (!cxlr)
> -		cxlr = construct_region(cxlrd, cxled);
> +		cxlr = construct_region(cxlrd, &ctx);
>  	mutex_unlock(&cxlrd->range_lock);
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);

