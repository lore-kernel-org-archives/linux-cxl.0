Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1B7FD
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238620; cv=none; b=qRRqkL9hmUAzTse4GzYDwH3vTRun28Xqtl6MXCeO73W2t4cK6rLz5azXkhQ4fzQ01V3uMl1dBmRs1+wL5ukZ3xvUdR8K/eXy+67DwCWhJE6S+xmfzQ9tTGv2SdfzbBsA7NvasIfIFKVQdltpDjWMT4KD74MS3VomTg5xkFEmukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238620; c=relaxed/simple;
	bh=MEF1JEOWds5f8jCuS3fKQM4bh4Au7JCWZ0OmQHj/+fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX7LEbCllMjVHiHkoSc9IOsfPpcVnfEzFHTrrCr0FUBmDD9+cP3KVl0mY3YMy4xWVOqTCE/nNmQS/KHXU7ewO4USRq7Yx5kHK0N8wdZxIftPs0mnoNiCNQTd+G9V7dvF9MkqQnEPxoE1dEBW0oHKBIiGXYpULT4Q6DRz7H1MT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WK43Hogz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WK43Hogz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718238618; x=1749774618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MEF1JEOWds5f8jCuS3fKQM4bh4Au7JCWZ0OmQHj/+fg=;
  b=WK43HogzAmuvk0TTpAvN3SyITa0bdoPxcfqWZHUfd5J9cp2rVegXQcm/
   wohw+Ch09dlgVs+dZNmlV/4W06D/ixLFrfyh6H598/NHCZXO7jtDcJtcl
   ytUrl5O+ttJcjG/cit6uYt9sQcUvmm2wbPfMzlU+wcioefBXAQ8LSk6Ds
   wqycQWKLjXHZH7d1J+LNhL+x0vNKrzyi1z84qMiBr7aDxwYxtRlGDI1Qe
   69fjARyLfd+prl5/FrvMsBkORisjEa1Jczuc7AnkRki5kbwQcNl3fftR8
   5XUUrJbrSoxNOiXdPAmStxw9amMs9PMN1U3W8cPPdjCKD0RVtBngv4Y4H
   Q==;
X-CSE-ConnectionGUID: ctoUw+aLT3m+KZJLb9W+cA==
X-CSE-MsgGUID: dC8hpLTYT7a3yogJD0f7EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32517420"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32517420"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 17:30:17 -0700
X-CSE-ConnectionGUID: cGhdNz54THmeJ9WfNNWjNw==
X-CSE-MsgGUID: x7XqIjU9Q6WRD6uLDz5n8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40430203"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.20.178])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 17:30:16 -0700
Date: Wed, 12 Jun 2024 17:30:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH] cxl/region: Remove soft reserve resource at region
 construction
Message-ID: <Zmo9ltXuf5G7/pwi@aschofie-mobl2>
References: <20240612205905.1209448-1-nathan.fontenot@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612205905.1209448-1-nathan.fontenot@amd.com>

On Wed, Jun 12, 2024 at 03:59:05PM -0500, Nathan Fontenot wrote:
> Systems with a BIOS that creates soft reserve iomem resources
> for memory ranges covered by CXL devices, the soft reserve resource
> needs to be removed when hotplugging a CXL device. Without doing
> so a new soft reserve for the memory range cannot be created
> during hotplug add.

Is a new soft reserved ever created?  I think the reason is to
free up the memory for the new region creation, period. If the
SR exists, userspace cannot 'replace' the region.

> 
> The previous approach from Alison [1] was to fix up the soft
> reserve resource at region release so it longer covers the
> memory range for the region being removed.
> 
> Instead of waiting for region removal, remove the soft reserve
> resource when constructing a region. This is done by walking the
> children of the region's parent's resources, finding a soft
> reserve resource (if it exists) containing the memory range
> for the region and removing the soft reserve prior to inserting
> the resource for the region being constructed.

Is it OK to remove the entire Soft Reserved when that first region
is constructed?  ie. in this setup that removes the soft reserved
before region1 is constructed.

100-600 : CXL Window 0
  100-600 : Soft Reserved
    100-200 : region0
    200-300 : region1


one bit below...


> 
> [1] https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> ---
>  drivers/cxl/core/region.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 00a9f0eef8dd..90e5c84230a5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3096,6 +3096,34 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static int cxl_insert_resource(struct device *dev, struct resource *parent,
> +			       struct resource *res)
> +{
> +	struct resource *soft;
> +	int rc;
> +
> +	/*
> +	 * Find and attempt to remove the SOFT_RESERVED resource
> +	 * (if it exists) that includes the range of the new
> +	 * resource we're inserting.
> +	 */
> +	for (soft = parent->child; soft; soft = soft->sibling) {
> +		if (soft->desc != IORES_DESC_SOFT_RESERVED)
> +			continue;
> +
> +		if (soft->start <= res->start && soft->end >= res->end) {
> +			rc = remove_resource(soft);
> +			if (rc)
> +				dev_warn(dev,
> +					 "Couldn't remove %s resource %llx - %llx\n",

Use %pr format for struct resource.

> +					 soft->name, soft->start, soft->end);
> +			break;
> +		}
> +	}
> +
> +	return insert_resource(parent, res);
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3142,7 +3170,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> -	rc = insert_resource(cxlrd->res, res);
> +	rc = cxl_insert_resource(cxlmd->dev.parent, cxlrd->res, res);
>  	if (rc) {
>  		/*
>  		 * Platform-firmware may not have split resources like "System
> -- 
> 2.34.1
> 
