Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E820E6F9;
	Wed, 19 Feb 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985795; cv=none; b=pEXYYJxnBCIVUPgSjY4Py+OJxri6j83R32wZDz2WHrDQjCjCFVo6V0Z+fDO1aDkalhLnJu0u9tVuE70vakLR1enmYKc5XrX3LzcjYYNZQbFecie7r00fRZgFlAIJD8mqAcAPmrofdZsWFcMQ5cvlZ5TckPddULJQWXquoYQYT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985795; c=relaxed/simple;
	bh=YpqD/2RNhKSTvzdaWKryDCLiVoHvYEhNXe3Yxf6NceU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7h85++Xn5UJ+1hCBqnlFOp46AP+zoBkZKoQiZrc8VP/XjUxTvRkVPBtO7KGWih/K1uv1oTaHmCulKA01pdJMVsIaaxwBQHR/g8IL9j+XcnoMhUFB8s+Hb5kxwIHDbNDveaBjR+xb7OCVFDU77QEEGjzUBGj7ghcvX5gzLVsjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVi2y6ni; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVi2y6ni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739985792; x=1771521792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YpqD/2RNhKSTvzdaWKryDCLiVoHvYEhNXe3Yxf6NceU=;
  b=cVi2y6nieWcxIs8xwIFKYCubgWvnG90LiPxKWpm0J9R5ri1g0+XGrVm9
   IViTZbr+NryilKN95SazLycW0lVywDXbYkrNGI2X+Jd1hlKgZaDkmPtp3
   2VfS7Y0hykifXoih+bqaqmXL+AYRFPTBB428TJua/Z1za9cuJeyJ+Jp3c
   xTvvOWPhV0nl5phIeHnLj3sD6WGVK3/ZgE3Q9+NQvoy0IRIXIXWs8kG8Z
   BsOjPOTLedkWAxB6rbvYDRU/vwZEx1khqNcmLIENnxghe/jYExv2XLdeX
   +WluZ65r3OWCkf9XQeNgIvv2kF22UP2Xz3ZYiwOrwwOFDE8rB/EVoB/jJ
   A==;
X-CSE-ConnectionGUID: JMLXBUgORWSlh2JknJMf+w==
X-CSE-MsgGUID: AhameNDAQWGXDMqmy94Uyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44382578"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44382578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:23:12 -0800
X-CSE-ConnectionGUID: LrOTcfd6Qy29I64ToWCOHw==
X-CSE-MsgGUID: 0XMICjJsQQOTttwlrVJxXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115256755"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:23:12 -0800
Message-ID: <d3e99ce2-b2c4-42d5-95da-3711b27fd5de@intel.com>
Date: Wed, 19 Feb 2025 10:23:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] cxl/region: Drop goto pattern in
 cxl_dax_region_alloc()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-7-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250217144828.30651-7-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 7:48 AM, Li Ming wrote:
> In cxl_dax_region_alloc(), there is a goto pattern to release the rwsem
> cxl_region_rwsem when the function returns, the down_read() and up_read
> can be replaced by a guard(rwsem_read) then the goto pattern can be
> removed.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d8a71f9f9fa5..320a3f218131 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3038,17 +3038,13 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  	struct cxl_dax_region *cxlr_dax;
>  	struct device *dev;
>  
> -	down_read(&cxl_region_rwsem);
> -	if (p->state != CXL_CONFIG_COMMIT) {
> -		cxlr_dax = ERR_PTR(-ENXIO);
> -		goto out;
> -	}
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return ERR_PTR(-ENXIO);
>  
>  	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
> -	if (!cxlr_dax) {
> -		cxlr_dax = ERR_PTR(-ENOMEM);
> -		goto out;
> -	}
> +	if (!cxlr_dax)
> +		return ERR_PTR(-ENOMEM);
>  
>  	cxlr_dax->hpa_range.start = p->res->start;
>  	cxlr_dax->hpa_range.end = p->res->end;
> @@ -3061,8 +3057,6 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  	dev->parent = &cxlr->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_dax_region_type;
> -out:
> -	up_read(&cxl_region_rwsem);
>  
>  	return cxlr_dax;
>  }

