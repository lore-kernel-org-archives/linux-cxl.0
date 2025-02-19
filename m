Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAA20E6F9;
	Wed, 19 Feb 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985893; cv=none; b=s4ixSisqy8cO3aeZDQgOQ21zZSjG8IzNYRmXxgfF/LVb4/myAapsZaF6Tozxjj+yen6LQ/usf57Mz6SrusInR9Jj7rDEgOPyC5dMHSzn36QIMobdRIjZ7My5zxqEcMX3HzRW5swoTjokkoadX3Dch/fPntLmxxMKtzcuqH+McbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985893; c=relaxed/simple;
	bh=4zbsz1fjaHsLbK4aRx1S+C3TaO1gYP/gaDkgLiYhaTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4wuqCUeSY/J5+20YrWY4Ovi/GetZlTOKxTbV/gt8tsG/i04AzYAFtAetxyCtcSPftJSJ4kP6Bie9WDAmQwKwoymOUIXAOu430Ve1kRQEiIWCcebWbb90LsvHLXA1oh+j6iNTES9SrNGObDPX8Ky8Zbd4kKRiUYL0JzhL9OnorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1SEali3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1SEali3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739985891; x=1771521891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4zbsz1fjaHsLbK4aRx1S+C3TaO1gYP/gaDkgLiYhaTU=;
  b=G1SEali3rdTmQDWcTcGgMqqS+HyAOqa0igAXNZxKC0ZjbOWNc4cPW/SK
   BWCj0WUa/We8zCT33LxUMoyDMXArbX1FC8lXOMPvtWsTwtt7K0CmWZFjt
   z4wDsO4EO4bWjHkSWSW8K+Y7sWPgwGPHqEvZohqIZ1vcPVXDRQoirlq9o
   uBBPXnmql+zjtHWTdKl2sbc32DCxBD96OncxcICsgMgirE99zNkZhSY0Z
   gORcOKeqmV23s67fetyrsqQx5sxQMiCl46FHC0G+yLlGyi/SIOVUCsCkj
   DGAxQSpjUzHUwqldgEw34aphT1mZ01Sa7ziyIQURZsAN5PxD4nNjkVWCG
   g==;
X-CSE-ConnectionGUID: 3vQvTSZjQsKKhBGubjos2A==
X-CSE-MsgGUID: ThT3w46lReKqRYNf0oyKZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44382707"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44382707"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:24:50 -0800
X-CSE-ConnectionGUID: wrExgqd1R8yjf7dpiYwP2Q==
X-CSE-MsgGUID: m4sAUlNOTVe6V952FSwHBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115257008"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:24:42 -0800
Message-ID: <4e30257f-5535-4333-abf5-d424436ee853@intel.com>
Date: Wed, 19 Feb 2025 10:24:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] cxl/region: Drop goto pattern of
 construct_region()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-8-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250217144828.30651-8-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 7:48 AM, Li Ming wrote:
> Some operations need to be protected by the cxl_region_rwsem in
> construct_region(). Currently, construct_region() uses down_write() and
> up_write() for the cxl_region_rwsem locking, so there is a goto pattern
> after down_write() invoked to release cxl_region_rwsem.
> 
> construct region() can be optimized to remove the goto pattern. The
> changes are creating a new function called construct_auto_region() which
> will include all checking and operations protected by the
> cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
> and up_write() in construct_auto_region().
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v2:
> - Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)
> ---
>  drivers/cxl/core/region.c | 71 +++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 320a3f218131..7a9e51aba9f4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3216,49 +3216,31 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static int construct_auto_region(struct cxl_region *cxlr,
> +				 struct cxl_root_decoder *cxlrd,
> +				 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
> -	struct cxl_region *cxlr;
>  	struct resource *res;
>  	int rc;
>  
> -	do {
> -		cxlr = __create_region(cxlrd, cxled->mode,
> -				       atomic_read(&cxlrd->region_id));
> -	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
> -
> -	if (IS_ERR(cxlr)) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			__func__, PTR_ERR(cxlr));
> -		return cxlr;
> -	}
> -
> -	down_write(&cxl_region_rwsem);
> +	guard(rwsem_write)(&cxl_region_rwsem);
>  	p = &cxlr->params;
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s: %s autodiscovery interrupted\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__);
> -		rc = -EBUSY;
> -		goto err;
> +		return -EBUSY;
>  	}
>  
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
> -	if (!res) {
> -		rc = -ENOMEM;
> -		goto err;
> -	}
> +	if (!res)
> +		return -ENOMEM;
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> @@ -3281,7 +3263,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>  	if (rc)
> -		goto err;
> +		return rc;
>  
>  	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
>  		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
> @@ -3290,14 +3272,39 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	/* ...to match put_device() in cxl_add_to_region() */
>  	get_device(&cxlr->dev);
> -	up_write(&cxl_region_rwsem);
>  
> -	return cxlr;
> +	return 0;
> +}
>  
> -err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> -	return ERR_PTR(rc);
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	do {
> +		cxlr = __create_region(cxlrd, cxled->mode,
> +				       atomic_read(&cxlrd->region_id));
> +	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
> +
> +	if (IS_ERR(cxlr)) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s failed assign region: %ld\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			__func__, PTR_ERR(cxlr));
> +		return cxlr;
> +	}
> +
> +	rc = construct_auto_region(cxlr, cxlrd, cxled);
> +	if (rc) {
> +		devm_release_action(port->uport_dev, unregister_region, cxlr);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return cxlr;
>  }
>  
>  int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)

