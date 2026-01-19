Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7234329363
	for <linux-cxl@vger.kernel.org>; Mon, 19 Jan 2026 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837385; cv=none; b=qX2yh4QRyx04Tl6X1YbuHhINcMqwKIrqaemD5CQfCVHNA6BAvQYGdCG3Mgd9hVT4e/VfidDzFYDGrPX5keB6K0r8WWep70mpJvf6L3nTDtbeRgeUpoFszHeNQuPq2W4XRHyeRyVy1t19YZ5ytNyXnM2gp+qEhLHQW8Xo7MQCzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837385; c=relaxed/simple;
	bh=gxZaPilTjhs9bDSFM/2nyBh26VVLPJ9kGxdqoai12AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHBakrcV6DsvlYcH8PE2W7R0khiCX9YX/1DuXdciMnJkZCR+gG4hfNoG5QKhna04+pUHXRgX1iJNTO5ufF4BIBp13n/Wa94l1yAvDejx8vhwicGhfRtG92GIzjSmGTzvVdQmofd3kK15wa6f4T+CoJVNxw8vOJaSsSQcejBHCZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4zTFekE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4zTFekE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768837383; x=1800373383;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gxZaPilTjhs9bDSFM/2nyBh26VVLPJ9kGxdqoai12AY=;
  b=I4zTFekEhyhgmy7N+1KQSiwxRWcEzo+7ukeAW20J9yfUuYYfJbC+0tf4
   BEv+J31vlnMPuLh0cLKoUOWNMZQnq8YVjlQYlBZ5eMx9/9DTHoepNqkzf
   7SV99cDfDJph4Egk6IFQTh7Il9/CwkCAZVM6wQYApLiIsrXHcn9J9THTW
   qwTxjhDyDYlpf8UYCzD2EvV9Pec4kHT3akiwKKAO8juES+f/fKHgvxZqu
   cMuxjf2Dcn67vkm0itLQNY2pOXEMc+Zm4OCbVB7+cymLo5sSrsjs99Kg1
   aqcEoe0jqeu2CiObB/KUtfE1gOhiiOKn9DI8c59OzKdHa/bpDWrAwRcsX
   g==;
X-CSE-ConnectionGUID: uib3+joMSQ+5f7Yiq5tMuQ==
X-CSE-MsgGUID: hFIFLZGCTiiMTKKipZ1zDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73904701"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="73904701"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 07:43:02 -0800
X-CSE-ConnectionGUID: dOTlLu5USPC9DCmF7HBKaQ==
X-CSE-MsgGUID: 2iX2hJMKTSmrm0leeWc3Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205684669"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.111.244]) ([10.125.111.244])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 07:43:01 -0800
Message-ID: <b7b6a2df-651b-4944-b15f-bdae7fac77b5@intel.com>
Date: Mon, 19 Jan 2026 08:43:00 -0700
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

Applied to cxl/next
345f23df5d08fe58fb865cd17b696cd345455224

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

