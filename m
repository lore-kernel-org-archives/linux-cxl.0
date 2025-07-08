Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0133993;
	Tue,  8 Jul 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016304; cv=none; b=HnLxzW3XEWCknmhnJqNwR4EjiYOhSmPsYfO3hKHdubnUPwL3HlWYPwK91BSCYacjNF25N00/nX0On/3yc7DPrQBucMHt6nAbFDs4PQyBPEBndguYtkssnlLjW/UliwprjJgjQcjV2Z+Z4qW7AgVf7AYxo9iyBB6xisbt5HK5vPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016304; c=relaxed/simple;
	bh=fwtIxX8pPhyFgQGmXsIjwPQSX3mRr5fjfe25sEtG5yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdqqmW1oD88za/gwmtq0SpxjBrDuBCajr8T+5AwVLyjF+plnzXkG7w7eUCwFk4JHGpZxzbMH9fLJFdzHPONPTRHDbh45aD6wSEyDVRPYDGFuwvOqgUo3bnXMdp0sWvlL0o7uEN12mTS2pzroz6UxxRnuOFuXBALcRtfnlsGxEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOO3TJl7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOO3TJl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016303; x=1783552303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fwtIxX8pPhyFgQGmXsIjwPQSX3mRr5fjfe25sEtG5yE=;
  b=SOO3TJl72+aNN+AXrLVQi2Qej506reNUYPUDDLJgdwKg3l3XJNnDIM4H
   dDb3PvCMQchNpscblx9pq4JoREN83j6gBi3XqeU5poTw/a+4SxjNfDGNA
   qhpRqUceOGwZ5xDrKP4USskgwhjLOG0FSWyVj9UI9AYu7dtadY+1Hwf7v
   +65UYNcgXlHDLXCun2li6PNwI7YDGcA2aeJNl7wosoVTR9c2/UR3Br4vR
   oHvqgj3mUxZw6DlU9zUABREnWZNRWRH4/Jgvt6ks7mF4tC3AAq0iiU+Mg
   i1x0s0EcC9mtqDu+20qkE7wcOq/2brGmzvqLyFTETpmH6/0BJXzbrojZf
   Q==;
X-CSE-ConnectionGUID: wnE5dzT7Q2iyUFaLEso8nQ==
X-CSE-MsgGUID: L2L5WB/YQnugZmOIg3mKpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65329732"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="65329732"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:43 -0700
X-CSE-ConnectionGUID: wGANfn44Sx6Y7yjLIDKraA==
X-CSE-MsgGUID: Iz+EVoIwSIWf8Jq+ldwgeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155244064"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.152]) ([10.125.110.152])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:41 -0700
Message-ID: <734637c5-1e3f-45bc-b07f-77d5592c102c@intel.com>
Date: Tue, 8 Jul 2025 16:11:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cxl/core: Using resource_contains_addr() to check
 address availability
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: andriy.shevchenko@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250708051536.92119-1-ming.li@zohomail.com>
 <20250708051536.92119-4-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250708051536.92119-4-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/25 10:15 PM, Li Ming wrote:
> Helper function resource_contains_addr() can be used to check if a
> resource range contains an input address. Use it to replace all
> code that checks whether a resource range contains the input
> DPA/HPA/SPA.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/edac.c   | 4 ++--
>  drivers/cxl/core/memdev.c | 2 +-
>  drivers/cxl/core/region.c | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 1cf65b1538b9..a3c19ec8033f 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1523,7 +1523,7 @@ static int cxl_mem_sparing_set_dpa(struct device *dev, void *drv_data, u64 dpa)
>  	struct cxl_memdev *cxlmd = ctx->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
> +	if (!resource_contains_addr(&cxlds->dpa_res, dpa))
>  		return -EINVAL;
>  
>  	ctx->dpa = dpa;
> @@ -1892,7 +1892,7 @@ static int cxl_ppr_set_dpa(struct device *dev, void *drv_data, u64 dpa)
>  	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
> +	if (!resource_contains_addr(&cxlds->dpa_res, dpa))
>  		return -EINVAL;
>  
>  	cxl_ppr_ctx->dpa = dpa;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f88a13adf7fa..4a5dc1d93af1 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -267,7 +267,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>  		dev_dbg(cxlds->dev, "device has no dpa resource\n");
>  		return -EINVAL;
>  	}
> -	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> +	if (!resource_contains_addr(&cxlds->dpa_res, dpa)) {
>  		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
>  			dpa, &cxlds->dpa_res);
>  		return -EINVAL;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..79d8211f8ed0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2847,7 +2847,7 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
>  	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
>  		return 0;
>  
> -	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
> +	if (!resource_contains_addr(cxled->dpa_res, dpa))
>  		return 0;
>  
>  	/*
> @@ -2959,7 +2959,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	if (cxlrd->hpa_to_spa)
>  		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
>  
> -	if (hpa < p->res->start || hpa > p->res->end) {
> +	if (!resource_contains_addr(p->res, hpa)) {
>  		dev_dbg(&cxlr->dev,
>  			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
>  		return ULLONG_MAX;
> @@ -3499,7 +3499,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
>  	xa_for_each(&endpoint->regions, index, iter) {
>  		struct cxl_region_params *p = &iter->region->params;
>  
> -		if (p->res->start <= spa && spa <= p->res->end) {
> +		if (resource_contains_addr(p->res, spa)) {
>  			if (!p->cache_size)
>  				return ~0ULL;
>  

