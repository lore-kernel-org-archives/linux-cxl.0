Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A238A9A1
	for <linux-cxl@vger.kernel.org>; Mon, 19 Jan 2026 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835835; cv=none; b=gWP58dsJkQ9jJvdTvJIdeEPvmPiz3Hy+77s6tgQG3GqGWfR8y1Vvb2cS6/Dnc36OsGwr6pJrlAzpYb9gO5Vaa1+5cLYPhqYoq2xSVOLaEwT4HcahG68mX/bBCN+xeBlRqLvwX0/nxTybh/OLEtij3N8woG+Sr4QGQ7ycezTF0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835835; c=relaxed/simple;
	bh=aflEQYEQd+RlX5ynqtQzgWC65O8SdpWGCEh3rAZtWdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRVyKv/8d/xSSn6N405GpxVQGT6xLP35/stSI9Ibqcj6ik+TSV8a5U4mNB1tIq0Bh3Ijzo0VJkm7oMSncDSf+kdybZrqm+sArUQnhlDQ4K3eWP1BAWDaajR+OAUieNW8mBZyVuhopdvxLiq4ZROY7y+ILtaRidhxDfyiLb8Gxaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5g/crvN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5g/crvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768835826; x=1800371826;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aflEQYEQd+RlX5ynqtQzgWC65O8SdpWGCEh3rAZtWdU=;
  b=L5g/crvNTTaf3WlL/xAAPHqEiHhPkLsU8LqrrFbbaazc5k1TlPNJycJr
   xDLISZTuZ0ixl5EyDz3eCVkGz+lQavXoknAj2vKwSms78w7qAXTF8RGkE
   SJK1vu0yQKn2qb3z03MBPBumxPO0l3jOf8Y3hipLTqne6mUHtIHsNrCkH
   EvWbF7f6LhtaCyPEaq3J02BE0RCzOBqubUXXJuZxo3e3kBRBYt3oSNHzH
   IoVXpeMAcPFYJU1VMalWYmZni2CoB1Vl+j89w2BsXdND4YZZ91el+hCxz
   bw9DGpSchkfde0Fq8lSPlNB1s49clGK6ZjThA3fqj/huA5yOGUmV4Vh5s
   g==;
X-CSE-ConnectionGUID: 6HRfPbfARA+bS4wYxp5Ubw==
X-CSE-MsgGUID: vP//FfwOQn6C02KVyZx7Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73908606"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="73908606"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 07:17:05 -0800
X-CSE-ConnectionGUID: S89TLF2qQzmNY6eR0l+6DQ==
X-CSE-MsgGUID: jLZ6PsFqT7GPM79VZa7b8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="237164014"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.111.244]) ([10.125.111.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 07:17:04 -0800
Message-ID: <301d09af-7fd2-47e2-b66a-d362bf8a9690@intel.com>
Date: Mon, 19 Jan 2026 08:17:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Use do_div() for 64-bit modulo operation
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20260117044732.567831-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260117044732.567831-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/16/26 9:47 PM, Alison Schofield wrote:
> div64_u64_rem() was the wrong choice for doing a modulo operation
> and it was used incorrectly, causing a kernel oops by passing NULL
> as the remainder parameter. Replace it with the do_div() helper
> that does the intended math (gran_offset = offset % gran) and is
> architecture safe.
> 
> This bug appeared during testing of unaligned address translations.
> The visibility to userspace would be limited to folks doing poison
> injection or clear by HPA on unaligned regions.
> 
> Fixes: 78b50b598462 ("cxl/region: Translate HPA to DPA and memdev in unaligned regions")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks Alison. I'll get this applied to next
> ---
>  drivers/cxl/core/region.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d5979000fba1..96888d87a8df 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3324,6 +3324,7 @@ static int unaligned_region_offset_to_dpa_result(struct cxl_region *cxlr,
>  	u64 interleave_width, interleave_index;
>  	u64 gran, gran_offset, dpa_offset;
>  	u64 hpa = p->res->start + offset;
> +	u64 tmp = offset;
>  
>  	/*
>  	 * Unaligned addresses are not algebraically invertible. Calculate
> @@ -3333,7 +3334,7 @@ static int unaligned_region_offset_to_dpa_result(struct cxl_region *cxlr,
>  	gran = cxld->interleave_granularity;
>  	interleave_width = gran * cxld->interleave_ways;
>  	interleave_index = div64_u64(offset, interleave_width);
> -	gran_offset = div64_u64_rem(offset, gran, NULL);
> +	gran_offset = do_div(tmp, gran);
>  
>  	dpa_offset = interleave_index * gran + gran_offset;
>  
> 
> base-commit: 78b50b5984629d362f826e9615ce4599f429716e

