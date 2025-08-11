Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9B1531F9
	for <linux-cxl@vger.kernel.org>; Mon, 11 Aug 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928058; cv=none; b=gCxgL9VB/YQr07vFF0p4ZT0OFAwb2Dk6BzAfRMgLRXCdNAO0cAg3RIkQOaT67dO1+xqyclhXPAD34ZPHKYEc7tgv8RedUOGYDTNINgVYRCp4XUwRqKX1T/wV4aQ5xW7l0Js9CAdGpeai9vEWg81s1zZ6uXmM2es6djRP+DOOoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928058; c=relaxed/simple;
	bh=sIeE6Hp6b5Z41h7FSLiqTrG0LtdAByUclvSoyaQaGmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1YuBamzQ1tCd51f5P5R+0j7MP1dMEBAfPoS04tzIRnpTBrCpxG0ZXEYABew9RjYZlkoa0zY7d4gwuNkxcdGW8ESRMyTSMgQAFM89REtkqXqsun925pHKPW1wi2eQ5pcKGOaoSd97rGQHIBD8DrkvD8qzMopypY+3j+sDaD2tRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLp4WG2Z; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLp4WG2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754928056; x=1786464056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sIeE6Hp6b5Z41h7FSLiqTrG0LtdAByUclvSoyaQaGmQ=;
  b=gLp4WG2ZiMyZePp75VWNlJsDXZnZpBRGLCj7b/wg+2s3GDJMbcYeneLC
   0i576T1+r6RkU01fbwa93BBvkgBF0vGozdZkqzp1H5/rprXjWV0iiW27Z
   iNCTU/uJXca4/llwDZFhhjRGU6/VmhZjVrjQv2pAj7iVjfXdas0Tusn9g
   SrdYYLMeqXtImAuczHKsBSFWXxrzSD2lD2ctnV4SrGpv6AMn+5yJgNQh9
   By7K8b7qJ3obr6hwPGFkOIQ6A790/+vaRvCcCgm9CW8IVn2HJZbCBrzlg
   fbqQhWfvjxw37D+M8nuS+t86Pp9dCDPTceM4WWR4aYb++h6pKFwSr1W+A
   A==;
X-CSE-ConnectionGUID: GPMBexYZSuGEhk/GzvJN1A==
X-CSE-MsgGUID: t2N+x1mpR8G5hqiIc+Hhyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67894016"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="67894016"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:00:55 -0700
X-CSE-ConnectionGUID: P/AOQLW3ROK0hZSX4NNj6Q==
X-CSE-MsgGUID: ohy7RERwSdG4Q8BYQUkgxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165446718"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.140]) ([10.247.119.140])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:00:50 -0700
Message-ID: <04dbb916-f923-4bc7-82fb-7d1a98abff23@intel.com>
Date: Mon, 11 Aug 2025 09:00:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cxl/region: Refactor address translation funcs for
 testing
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1754291501.git.alison.schofield@intel.com>
 <d60d89dab66e1431bb2ff5cd7da1f0960bc2a057.1754291501.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <d60d89dab66e1431bb2ff5cd7da1f0960bc2a057.1754291501.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 1:52 AM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> In preparation for adding a test module that exercises the address
> translation calculations, extract the core calculations into stand-
> alone functions that operate on base parameters without dependencies
> on struct cxl_region.
> 
> This refactoring enables unit testing of the address translation logic
> with controlled inputs, while maintaining identical functionality in
> the existing code paths.
> 
> The moved code has only one change. In the new cxl_calculate_position()
> eiw_to_ways(eiw, &ways) replaces the prior usage of p->interleave_ways,
> since the new function cannot depend upon struct cxl_region_params.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 145 +++++++++++++++++++++++---------------
>  drivers/cxl/cxl.h         |   3 +
>  2 files changed, 90 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 281a31df686f..ccee5049d700 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2929,13 +2929,91 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
>  	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
>  }
>  
> +u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig)
> +{
> +	u64 dpa_offset, bits_lower, bits_upper, temp;
> +
> +	/*
> +	 * DPA offset: CXL Spec 3.2 Section 8.2.4.20.13
> +	 * Lower bits [IG+7:0] pass through unchanged
> +	 * (eiw < 8)
> +	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
> +	 *	Clear the position bits to isolate upper section, then
> +	 *	reverse the left shift by eiw that occurred during DPA->HPA

May be easier to read if listing the steps instead of continued sentence:
	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
	 *	1. Clear the position bits to isolate upper section.
	 *	2. Reverse the left shift by eiw that occurred during DPA->HPA


> +	 * (eiw >= 8)
> +	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
> +	 *	Extract upper bits from the correct bit range and divide by 3
> +	 *	to recover the original DPA upper bits

same here as above

DJ

> +	 */
> +	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
> +	if (eiw < 8) {
> +		temp = hpa_offset &= ~((u64)GENMASK(eig + eiw + 8 - 1, 0));
> +		dpa_offset = temp >> eiw;
> +	} else {
> +		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
> +		dpa_offset = bits_upper << (eig + 8);
> +	}
> +	dpa_offset |= bits_lower;
> +
> +	return dpa_offset;
> +}
> +
> +int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig)
> +{
> +	unsigned int ways = 0;
> +	u64 shifted, rem;
> +	int pos;
> +
> +	/*
> +	 * Interleave position: CXL Spec 3.2 Section 8.2.4.20.13
> +	 * eiw < 8
> +	 *	Position is in the IW bits at HPA_OFFSET[IG+8+IW-1:IG+8].
> +	 *	Per spec "remove IW bits starting with bit position IG+8"
> +	 * eiw >= 8
> +	 *	Position is not explicitly stored in HPA_OFFSET bits. It is
> +	 *	derived from the modulo operation of the upper bits using
> +	 *	the total number of interleave ways.
> +	 */
> +	if (eiw < 8) {
> +		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
> +	} else {
> +		shifted = hpa_offset >> (eig + 8);
> +		eiw_to_ways(eiw, &ways);
> +		div64_u64_rem(shifted, ways, &rem);
> +		pos = rem;
> +	}
> +
> +	return pos;
> +}
> +
> +u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig)
> +{
> +	u64 mask_upper, hpa_offset, bits_upper;
> +
> +	mask_upper = GENMASK_ULL(51, eig + 8);
> +
> +	if (eiw < 8) {
> +		hpa_offset = (dpa_offset & mask_upper) << eiw;
> +		hpa_offset |= pos << (eig + 8);
> +	} else {
> +		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> +		bits_upper = bits_upper * 3;
> +		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> +	}
> +
> +	/* The lower bits remain unchanged */
> +	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> +
> +	return hpa_offset;
> +}
> +
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> -	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> +	u64 dpa_offset, hpa_offset, hpa;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -2965,19 +3043,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	/* Remove the dpa base */
>  	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
>  
> -	mask_upper = GENMASK_ULL(51, eig + 8);
> -
> -	if (eiw < 8) {
> -		hpa_offset = (dpa_offset & mask_upper) << eiw;
> -		hpa_offset |= pos << (eig + 8);
> -	} else {
> -		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> -		bits_upper = bits_upper * 3;
> -		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> -	}
> -
> -	/* The lower bits remain unchanged */
> -	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> +	/* this chunk was moved, maybe move comment too */
> +	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
>  
>  	/* Apply the hpa_offset to the region base address */
>  	hpa = hpa_offset + p->res->start + p->cache_size;
> @@ -3011,8 +3078,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_endpoint_decoder *cxled;
>  	u64 hpa, hpa_offset, dpa_offset;
> -	u64 bits_upper, bits_lower;
> -	u64 shifted, rem, temp;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3034,50 +3099,14 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	} else {
>  		hpa_offset = offset;
>  	}
> -	/*
> -	 * Interleave position: CXL Spec 3.2 Section 8.2.4.20.13
> -	 * eiw < 8
> -	 *	Position is in the IW bits at HPA_OFFSET[IG+8+IW-1:IG+8].
> -	 *	Per spec "remove IW bits starting with bit position IG+8"
> -	 * eiw >= 8
> -	 *	Position is not explicitly stored in HPA_OFFSET bits. It is
> -	 *	derived from the modulo operation of the upper bits using
> -	 *	the total number of interleave ways.
> -	 */
> -	if (eiw < 8) {
> -		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
> -	} else {
> -		shifted = hpa_offset >> (eig + 8);
> -		div64_u64_rem(shifted, p->interleave_ways, &rem);
> -		pos = rem;
> -	}
> -	if (pos < 0 || pos >= p->nr_targets) {
> -		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
> -			pos, p->nr_targets);
> +
> +	pos = cxl_calculate_position(hpa_offset, eiw, eig);
> +	if (pos < 0 || pos >= p->nr_targets)
>  		return -ENXIO;
> -	}
>  
> -	/*
> -	 * DPA offset: CXL Spec 3.2 Section 8.2.4.20.13
> -	 * Lower bits [IG+7:0] pass through unchanged
> -	 * (eiw < 8)
> -	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
> -	 *	Clear the position bits to isolate upper section, then
> -	 *	reverse the left shift by eiw that occurred during DPA->HPA
> -	 * (eiw >= 8)
> -	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
> -	 *	Extract upper bits from the correct bit range and divide by 3
> -	 *	to recover the original DPA upper bits
> -	 */
> -	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
> -	if (eiw < 8) {
> -		temp = hpa_offset &= ~((u64)GENMASK(eig + eiw + 8 - 1, 0));
> -		dpa_offset = temp >> eiw;
> -	} else {
> -		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
> -		dpa_offset = bits_upper << (eig + 8);
> -	}
> -	dpa_offset |= bits_lower;
> +	dpa_offset = cxl_calculate_dpa_offset(hpa_offset, eiw, eig);
> +	if (dpa_offset == ULLONG_MAX)
> +		return -ENXIO;
>  
>  	/* Look-up and return the result: a memdev and a DPA */
>  	for (int i = 0; i < p->nr_targets; i++) {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f87628a22852..151a8ce698c5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -731,6 +731,9 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  	return port->uport_dev == port->dev.parent;
>  }
>  
> +u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig);
> +u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig);
> +int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig);
>  int cxl_num_decoders_committed(struct cxl_port *port);
>  bool is_cxl_port(const struct device *dev);
>  struct cxl_port *to_cxl_port(const struct device *dev);

