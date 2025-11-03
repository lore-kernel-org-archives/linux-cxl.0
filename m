Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178223D7F4
	for <linux-cxl@vger.kernel.org>; Mon,  3 Nov 2025 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213709; cv=none; b=n7cqRgZTPZhw+MwcAPEnJYMK9LvUW1rCZUEuBemJ8SJOk43vjQm7dcgPSrRS4Ls1seTaZrCmclJ/aUMMa3zTGUCoOrYU29vNyNgD23Iqsyoi1x2MWrR3+8SfgXUkLBIFxS2idhmeY+vGdRwuk2wwpoU1WKVR9yXH95/rsSi8zZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213709; c=relaxed/simple;
	bh=w5UCx56kftZr3bUWegX4fwli4cgeeMxIKU+/Srbpikg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PuTEnpCiQ2UbZ9A3aN/gaVcYWxZAEx2i75AB48HmFiFt/F+kUVaUiLZXIQ7kCb7KmoI+vdAvFVI2HU7Dj8WWOPC3lySN7SzjZ2juQ5pugiUJwwuE6KJf2muI45vvZ+k6TVTczv1Fx+Zs0bvWYYtP+r9nZAqjDS4rSftV94Gvj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xn/nO8/1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xn/nO8/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213708; x=1793749708;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=w5UCx56kftZr3bUWegX4fwli4cgeeMxIKU+/Srbpikg=;
  b=Xn/nO8/1aBXfLRSHADao6ZMMA+MowcQLbeGZYhWrIWHyQPdV8/BplwrP
   EKzElvWXkxcj6rMEtMO0+++MIZk+K/YXy3b0Qaz7pUrNadP+8iGBEg7Bd
   2WSmywNW+dO6FSrJjutudwvUwxwHwExvkPIgS8Lw8jdtmY5Dg9mRGi/p+
   z2eaRQWYYYAOk4IinFTl+9j9C+QW/2+r76IqbJYeS3x70Z+582LBe+j0J
   wdjeIjwkMDcCbllqmDCfhBDzi3KURk3lXNBevWqYHVIYGu1AsZVqPImAu
   92/Lu08vCfSlN49hR2pSDwjlbV9KuQWfuzSt72b0Y3wC2tLm8Q8OTyB8I
   w==;
X-CSE-ConnectionGUID: NyZmm3CyTI29mgTCg8h0vg==
X-CSE-MsgGUID: 4jxX6mOhSty8puHAtpxlwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64451703"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64451703"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:48:28 -0800
X-CSE-ConnectionGUID: iBA7lTDdQa6O9m1OKgaJkw==
X-CSE-MsgGUID: rFHRS2t3TvGtCcVBG7poug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186679160"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:48:26 -0800
Message-ID: <5798e07c-dc3f-4664-97bd-6fa196ff1f87@intel.com>
Date: Mon, 3 Nov 2025 16:48:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Adjust extended linear cache failure emission in
 cxl_acpi
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251003185509.3215900-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251003185509.3215900-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/3/25 11:55 AM, Dave Jiang wrote:
> The cxl_acpi module spams "Extended linear cache calculation failed"
> when the hmat memory target is not found for a node. This is normal
> when the memory target does not contain extended linear cache
> attributes. Adjust cxl_acpi_set_cache_size() to just return 0 if error
> is returned from hmat_get_extended_linear_cache_size(). That is the
> only error returned from hmat_get_extended_linear_cache_size() as
> -ENOENT.
> 
> Also remove the check for -EOPNOTSUPP in cxl_setup_extended_linear_cache()
> since that errno is never returned by cxl_acpi_set_cache_size().
> 
> Suggeted-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
f0c5d3bc2830f04a72087f45d15807943eabfa10

> 
> ---
> v2:
> - Rename subject line to reflect new changes.
> - Further analysis of the code and determined this is the correct
>   change.
> ---
>  drivers/cxl/acpi.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d7a5539d07d4..cc4d7bf381d3 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -353,7 +353,7 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
>  
>  	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
>  	if (rc)
> -		return rc;
> +		return 0;
>  
>  	/*
>  	 * The cache range is expected to be within the CFMWS.
> @@ -381,15 +381,13 @@ static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
>  	if (!rc)
>  		return;
>  
> -	if (rc != -EOPNOTSUPP) {
> -		/*
> -		 * Failing to support extended linear cache region resize does not
> -		 * prevent the region from functioning. Only causes cxl list showing
> -		 * incorrect region size.
> -		 */
> -		dev_warn(cxlrd->cxlsd.cxld.dev.parent,
> -			 "Extended linear cache calculation failed rc:%d\n", rc);
> -	}
> +	/*
> +	 * Failing to retrieve extended linear cache region resize does not
> +	 * prevent the region from functioning. Only causes cxl list showing
> +	 * incorrect region size.
> +	 */
> +	dev_warn(cxlrd->cxlsd.cxld.dev.parent,
> +		 "Extended linear cache retrieval failed rc:%d\n", rc);
>  
>  	/* Ignoring return code */
>  	cxlrd->cache_size = 0;
> 
> base-commit: 46037455cbb748c5e85071c95f2244e81986eb58

