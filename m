Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E452153C3;
	Thu, 20 Feb 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070109; cv=none; b=LNWdild+LO0nGlsejjJ/5ICOVNb7/mhDvFS/tEpzn3sxWTKvomI5rUOCw8SaSJBYpoLEvUxhYzZJ3OgApQ+DIdRJWL+asCInCGuoGsa+DvLsmp8iLytJNDZSIR6RY4I5KOn4WnFZhZQ5Sf1xGhJz+vPhSIyP+EwqKHrLEq7CBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070109; c=relaxed/simple;
	bh=mV1gERHgHiEeuJzc5j6UMyr/UVr3dy4CIKZMVkmnQX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6jCe2Z9Cj24InBUGdNaXlxaFBtuofzAlYuuMCIbyJ5heYoifVIFe1dQ/mrl+nTdh06TzDOofKX0lBVAxwlxoh0Y+S5ND/cpoZEtz5SWNBjXmgQ5W3LtZsKwRmJJxhcQp5fy+wtpVdmzTHNvYKT8M/Xd3+lnbcuH6kkw1An4X3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWBvfszC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWBvfszC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740070106; x=1771606106;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mV1gERHgHiEeuJzc5j6UMyr/UVr3dy4CIKZMVkmnQX4=;
  b=UWBvfszCeBlb8NIX6mHbakdvGH3e2f3UD/Pn7K07D/j3ZjuOU/+bFjta
   S+D7VzhWXaQducVVFUvKnQ+plAAsNRZcZrUL/rwaoepEISTx/q1+phSxR
   WPGqunzwvhxY6kHJFAfI+lIhdFsJlsa0UAIu4wPCvnJI05HogHwuplNQl
   R08wOX7dkFk9hfIrEt2joIKk9NKfedmh54V4QbXe3n/0TcprR5iO8YQOJ
   sAv3iEbibRGaXaK3WmFvqLGeANlLNUeImMK+Ri8VCAP1N0pe8WRvs4uWS
   xeukj0RawCSLdGrgpgqfwpDfZxjn7GhZReE84bJQY4gyJMaM10qJNhId5
   Q==;
X-CSE-ConnectionGUID: CM9luoYxSWq5ZApwJi7Ocg==
X-CSE-MsgGUID: BvZSy3nPRxmFFTvtGhtmhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="58268534"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="58268534"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:48:25 -0800
X-CSE-ConnectionGUID: YytAqhmdTkiXsXhJ71sr0g==
X-CSE-MsgGUID: JodJtwBTSwe3ylisuwb02Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="119707884"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:48:24 -0800
Message-ID: <7ea607c2-b769-4077-9df0-79f79bb0415e@intel.com>
Date: Thu, 20 Feb 2025 09:48:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/18] cxl/region: Factor out code to find the root
 decoder
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-10-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-10-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine the root
> decoder associated to an endpoint decoder. Factor out that code for
> later reuse. This has the benefit of reducing cxl_add_to_region()'s
> function complexity.
> 
> The reference of cxlrd_dev can be freed earlier. Since the root
> decoder exists as long as the root port exists and the endpoint
> already holds a reference to the root port, this additional reference
> is not needed. Though it looks obvious to use __free() for the
> reference of cxlrd_dev here too, this is done in a later rework. So
> just move the code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0e38bcb43be6..c641c8922455 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3203,6 +3203,38 @@ static int match_root_decoder_by_range(struct device *dev,
>  	return range_contains(r1, r2);
>  }
>  
> +static struct cxl_root_decoder *
> +cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct range *hpa = &cxld->hpa_range;
> +	struct device *cxlrd_dev;
> +
> +	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
> +				      match_root_decoder_by_range);
> +	if (!cxlrd_dev) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s no CXL window for range %#llx:%#llx\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> +			cxld->hpa_range.start, cxld->hpa_range.end);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * device_find_child() created a reference to the root
> +	 * decoder. Since the root decoder exists as long as the root
> +	 * port exists and the endpoint already holds a reference to
> +	 * the root port, this additional reference is not needed.
> +	 * Free it here.
> +	 */
> +	put_device(cxlrd_dev);
> +
> +	return to_cxl_root_decoder(cxlrd_dev);
> +}
> +
>  static int match_region_by_range(struct device *dev, const void *data)
>  {
>  	struct cxl_region_params *p;
> @@ -3314,29 +3346,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxled_to_port(cxled);
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct range *hpa = &cxled->cxld.hpa_range;
> -	struct cxl_decoder *cxld = &cxled->cxld;
> -	struct device *cxlrd_dev, *region_dev;
> +	struct device *region_dev;
>  	struct cxl_root_decoder *cxlrd;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	bool attach = false;
>  	int rc;
>  
> -	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
> -				      match_root_decoder_by_range);
> -	if (!cxlrd_dev) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s no CXL window for range %#llx:%#llx\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> +	cxlrd = cxl_find_root_decoder(cxled);
> +	if (!cxlrd)
>  		return -ENXIO;
> -	}
> -
> -	cxlrd = to_cxl_root_decoder(cxlrd_dev);
>  
>  	/*
>  	 * Ensure that if multiple threads race to construct_region() for @hpa
> @@ -3354,7 +3374,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
>  
> @@ -3375,8 +3395,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	}
>  
>  	put_device(region_dev);
> -out:
> -	put_device(cxlrd_dev);
> +
>  	return rc;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");

