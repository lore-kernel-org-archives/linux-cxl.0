Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BCE1624DF;
	Mon,  9 Jun 2025 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502115; cv=none; b=T9p+urrgy1PKJ9KtoHta1ExbaOjpMona/5k1axqSRfjkOgZM0yX1jIVXstJin8dIoHyEV4J5FlJMPslhTYiefDZSUhjXZUbEFBy8cbhD3WcikIedD1hwaUd0YIxkcTtHYSCre/Xj8TJu8UkAQI5M1hG3kP8CgnqxG5stiHqTQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502115; c=relaxed/simple;
	bh=Cf4DSQp3oAKhqHq4IyLu+NFvMCScLsyVxykgVagauOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGjFJwrojLeJmKJt2o50CctRwYtYD2UsdVmvBPYhxUBgARd9gUiMpP1Cc+Se5CtJblFkKh+cAknGCOqzZHCyYRW/iJfslZq0tf577Tzo/Zgy12tdc6LTvQolnunPM3qNStq6uVHstL6ZcEDzVP4WEigbNSmB1jb/yiYletquJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaAZ60Bf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaAZ60Bf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749502113; x=1781038113;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cf4DSQp3oAKhqHq4IyLu+NFvMCScLsyVxykgVagauOA=;
  b=EaAZ60BfLY1oPN5iqJg+Ur36bbWV77jTdZaaikeuXAtQeWE6gxPTVfSD
   Qiz3uw/GQ1hVkJVnVh6+S2Sk8ZQeAhSC0fxL5SzRVbitsabu1lzEinTwH
   uQKhtQiwCpoPddp44siWsTp0FPkenTcDv/1cn4mD96QSFdKPgahr7WJCQ
   fKzRQ1v45HvqLNyvAFWKTgxtHxEbPeuTzMGAN+o0dsaD+R4ogat1QAegG
   kXt7Ucnd7O7Cs0HtnMH3eFiUNtqD6/tc75OI8vuG3K1p/OAEg2ivgmf2j
   nZ17uwjpGqnDpLLg0E1HOXwqGP1eaPwUBtIGO6zWpsck4oKKc0Mh0AHC5
   g==;
X-CSE-ConnectionGUID: IfC4efbpQ9OXNlDu6n7YIA==
X-CSE-MsgGUID: JJba1irtQk2Iy7SB71AEFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51503885"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="51503885"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:48:31 -0700
X-CSE-ConnectionGUID: z6Q7glW8TZWwX4fC8z4Yqg==
X-CSE-MsgGUID: 50jpc8UfQb6SzBl41Hchfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="147135248"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:48:30 -0700
Message-ID: <1ea79803-a219-4297-9343-aa5b0a737abc@intel.com>
Date: Mon, 9 Jun 2025 13:48:29 -0700
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

Both patches applied to cxl/next

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

