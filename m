Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21813AD0F
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821546; cv=none; b=XQDLJvjY1a559sBQHbVsHHU4aSFWTts2P3pqxWEh1oGSekhM+1HEh+/8AQuQLPixj6iQUYNIEJoFC6fn7YJ+7RIiDuYYeIhgd9yGJjuQKjcV+4qz9/lRzJ/KtDuHRDfUKdHDf2odA2SCgD+3lZ5qLUEuBsA8/duaFGqxOZeGSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821546; c=relaxed/simple;
	bh=8Ka6tBAdUFNelH6Are1e0Y+WlpH7yLwqjstb2Zyebvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL3bnzciDJyXwVQiFtOPWgWVUQeYs3LtAFYwe/HtiZOgq7x/3fD7j+v/i8RYWFsLOR2a9RyEsDmf1C9T7j0074932KKbhDa2mh9hX1jtWlORu+zvca6Z/5UieSoE4U0XYUwnyX5mBd68LebFYstN3CUJY5ITsesB8EumGFAqKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=guBeRJSF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guBeRJSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730821544; x=1762357544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Ka6tBAdUFNelH6Are1e0Y+WlpH7yLwqjstb2Zyebvs=;
  b=guBeRJSFAlfQUNELh9rlZsD75ThBEAxGycmNktfOIE1shQ/qmGcjlCNc
   hD3zSK05QVBV8y6SO32P3ayGrFtZlfNvCEzuzl1NnE28PQ92KovduH6H2
   Tse5BDgwgxDGbHvY7CI7xZk0noBMwN6QYgMCxRRsFKtPXQbgJkmnSX3l3
   UXSc8CJvJpP0tRTE78JywCkYZS0eDd8f5VJ6ZskGsYdbbMry7NJqnNudq
   rt8iTbHE4Zf4/2mmbacSdnqcBEnP4lK1mH229DG+E5ar6GX3WOeX42TXz
   3LuRJ5p3Tb63BHENwm5TvwY+3XBXp5QW6g0RXrbY3Qfo9cmhG112Z6o6G
   Q==;
X-CSE-ConnectionGUID: tb1qgPMXSUiS4WlebYiyXw==
X-CSE-MsgGUID: 6d+PbFXaTYCobj2wlhyGVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48038099"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48038099"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:45:43 -0800
X-CSE-ConnectionGUID: eYuUo53hR8OQMW+CTE26pA==
X-CSE-MsgGUID: iuyQrAz9QJ+VM3uEV5Qa9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84459844"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.109.253]) ([10.125.109.253])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:45:42 -0800
Message-ID: <432ff3ea-e851-4665-bbe0-c0e0b78a1fd4@intel.com>
Date: Tue, 5 Nov 2024 08:45:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH v2 2/6] ndctl/cxl/region: Report max size for region
 creation
To: Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
 Jonathan Cameron <jonathan.cameron@Huawei.com>, Fan Ni <fan.ni@samsung.com>,
 Navneet Singh <navneet.singh@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev
References: <20241104-dcd-region2-v2-0-be057b479eeb@intel.com>
 <20241104-dcd-region2-v2-2-be057b479eeb@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241104-dcd-region2-v2-2-be057b479eeb@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/24 7:10 PM, Ira Weiny wrote:
> When creating a region if the size exceeds the max an error is printed.
> However, the max available space is not reported which makes it harder
> to determine what is wrong.
> 
> Add the max size available to the output error.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 96aa5931d2281c7577679b7f6165218964fa0425..207cf2d003148992255c715f286bc0f38de2ca84 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -677,8 +677,8 @@ static int create_region(struct cxl_ctx *ctx, int *count,
>  	}
>  	if (!default_size && size > max_extent) {
>  		log_err(&rl,
> -			"%s: region size %#lx exceeds max available space\n",
> -			cxl_decoder_get_devname(p->root_decoder), size);
> +			"%s: region size %#lx exceeds max available space (%#lx)\n",
> +			cxl_decoder_get_devname(p->root_decoder), size, max_extent);
>  		return -ENOSPC;
>  	}
>  
> 

