Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6504B5AE;
	Tue,  3 Jun 2025 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990370; cv=none; b=BfzDu8l47P/bM+jCL0VeWmlt4aTzN+JdWiO1jlQ1XLXuea/K/irhqh4yOAdGEdbwyo0ansl68BI7VH4L0yd9W+HedBNFKI7PZUT+GY3skRmQGrc47u/CLgrYsyAndgvdrmQQpi3VF1pt1mQLAJXpYSDZrUZvaY2ba6t0Zg2L1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990370; c=relaxed/simple;
	bh=DVBbmxIjry/eIkd9G9v1joTK+MoRInTFHzpy62nsXvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpJTy/IokiXMmuIFjr/6wtYnplozrdBB2pZzrRtTQxRFCkn/k8yk1UOr3rFhMyAFvJcQn6hSi9OgTNzCGEticphK3PqkRl0g90YMQWgM95GDHQmp5w9azbgm4F6b+IfbP9BL7L4/91O2xGk9hLuGzpF/0HpoGh8Q5ZeRYCErtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYc7FGr8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYc7FGr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748990369; x=1780526369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DVBbmxIjry/eIkd9G9v1joTK+MoRInTFHzpy62nsXvI=;
  b=NYc7FGr8TbAyCVVEhstYuQXaa5sAm4uOvmDZsIPKPGscd9UWQkH5udEZ
   BSznMR1fcOkB8FGlZApk5x7haWcMTrVS5qUHp3xnOVH5dOi5NAL+T4sOl
   hW2cAAArEihHdwxstuUazXDp8ev03mhgNx0DjRq5Kfb+q9DIFd3cf6eyw
   4XTB9xaKl6uJE9RvFuS5M9pv54eZhLIM2Hx+3NhgaLmsSzhfzyEhGtFtu
   tVG6BdVJex7zDb5he8yqCGJP7FOhrtSWcIX01Qhkw/Cjj32winW9V1ED7
   5HMkmt/ClIlboUdsJHWV3+FQhDtydxqAQAzUcOSBNoTzuKlgeoqiA5HJT
   w==;
X-CSE-ConnectionGUID: 1GDb9qq2Ruu29+Wfu4MslA==
X-CSE-MsgGUID: 8UUEs8KaSBaJk0SYOEH2Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51195135"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="51195135"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:39:28 -0700
X-CSE-ConnectionGUID: slVkNPJHT4mxaA3Ku5HC/A==
X-CSE-MsgGUID: 4xN63lyHTkiHMmFmiXAVUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="144964692"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:39:28 -0700
Message-ID: <e664212f-728b-44d3-b0da-ade53c088cb1@intel.com>
Date: Tue, 3 Jun 2025 15:39:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603104314.25569-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603104314.25569-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 3:43 AM, Li Ming wrote:
> When trying to update the scrub_cycle value of a cxl region, which means
> updating the scrub_cycle value of each memdev under a cxl region. cxl
> driver needs to guarantee the new scrub_cycle value is greater than the
> min_scrub_cycle value of a memdev, otherwise the updating operation will
> fail(Per Table 8-223 in CXL r3.2 section 8.2.10.9.11.1).
> 
> Current implementation logic of getting the min_scrub_cycle value of a
> cxl region is that getting the min_scrub_cycle value of each memdevs
> under the cxl region, then using the minimum min_scrub_cycle value as
> the region's min_scrub_cycle. Checking if the new scrub_cycle value is
> greater than this value. If yes, updating the new scrub_cycle value to
> each memdevs. The issue is that the new scrub_cycle value is possibly
> greater than the minimum min_scrub_cycle value of all memdevs but less
> than the maximum min_scrub_cycle value of all memdevs if memdevs have
> a different min_scrub_cycle value. The updating operation will always
> fail on these memdevs which have a greater min_scrub_cycle than the new
> scrub_cycle.
> 
> The correct implementation logic is to get the maximum value of these
> memdevs' min_scrub_cycle, check if the new scrub_cycle value is greater
> than the value. If yes, the new scrub_cycle value is fit for the region.
> 
> The change also impacts the result of
> cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
> minimum min_scrub_cycle value among all memdevs under the region before
> the change. The interface will return the maximum min_scrub_cycle value
> among all memdevs under the region with the change.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes from RFC:
> 1. Add more description about the max scrub cycle. (Alison)
> 2. Add more description about the min scrub cycle of a region. (Alison)
> 3. Drop RFC tag.
> 
> base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
> ---
>  drivers/cxl/core/edac.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 2cbc664e5d62..0ef245d0bd9f 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -103,10 +103,10 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
>  				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
>  {
>  	struct cxl_mailbox *cxl_mbox;
> -	u8 min_scrub_cycle = U8_MAX;
>  	struct cxl_region_params *p;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_region *cxlr;
> +	u8 min_scrub_cycle = 0;
>  	int i, ret;
>  
>  	if (!cxl_ps_ctx->cxlr) {
> @@ -133,8 +133,12 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
>  		if (ret)
>  			return ret;
>  
> +		/*
> +		 * The min_scrub_cycle of a region is the max of minimum scrub
> +		 * cycles supported by memdevs that back the region.
> +		 */
>  		if (min_cycle)
> -			min_scrub_cycle = min(*min_cycle, min_scrub_cycle);
> +			min_scrub_cycle = max(*min_cycle, min_scrub_cycle);
>  	}
>  
>  	if (min_cycle)

