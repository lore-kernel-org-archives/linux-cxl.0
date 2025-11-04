Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7DA3314B8;
	Tue,  4 Nov 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277205; cv=none; b=owr6dYpLMFbaGEb3YxWSsqEpHRK1cMtC/ucwMDaHaPzhlszayFxOy717eO2ltFCzZ07rhrISWbPTM7YVL2+kPGi+lMxbnldKEPloorh/PuGzjZbyypokt7WrPyLBLt5iIG0KcyT5+D8mXOHq5qTtdQfONfFTA4mx60YWyQ8Zvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277205; c=relaxed/simple;
	bh=ggtgql8MvrqO772gcZSBlCsr2TAziVOolbcA6Gf1Khw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jee3qA8Um4xgW18pR2kpyyYur272ahHUCscehAsBuvtn5OpmX56zkkpScWAhI4mSbf7nKm8sXBRSkLuaP655FQTBpWMf4klJJJK89fbs5lrR8Of7waonJLZINO8hdoKVH+4JJNcuzqgljf4TIMkOgXBIq9EgnYFvZBCOJY3eWCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/BVjjZG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/BVjjZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762277204; x=1793813204;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ggtgql8MvrqO772gcZSBlCsr2TAziVOolbcA6Gf1Khw=;
  b=V/BVjjZGvsN5he35/ahiiN/XCeC5eYcQ697WYiphyOPnImv71sNlOd5y
   ZLM2vmebE8lS1ZlcbE9K5XTI4YaZqVuylGmezqOB0BojZgjIvVvl1zhG3
   6QY3d8vTLDOjoE9hmCxoVXSP+iBX8vzH0aiLwE5K2k4/wVsPywCHAsl6X
   Zl9bM/iFktbK8Zh+OumF1FhQitp42bdXgfXquEro8V9RFcy9YVL2smGvD
   lan0GXc52tFnNNzj6eYj6ajKVxTofG24fvbAo8/i3thnBEe4fpFkUxlLm
   Bf/c/tdEpD9qMvSjwwnTiFQqwI1TViakRdeQbnrt6I0y5UV6593RJb71y
   Q==;
X-CSE-ConnectionGUID: A9568X9USOaPpK2yeBMb/g==
X-CSE-MsgGUID: SqpPYA4ATE+djI3R1EHl2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64528998"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64528998"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:26:43 -0800
X-CSE-ConnectionGUID: 1dm5TmczRimHLbwI6aYaBw==
X-CSE-MsgGUID: D1NbHidORDGipKTE5F11Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187163175"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:26:42 -0800
Message-ID: <13e2a2f3-0e2b-490a-ab82-af28d6e8c76e@intel.com>
Date: Tue, 4 Nov 2025 10:26:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/14] cxl: Simplify cxl_rd_ops allocation and handling
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-13-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251103184804.509762-13-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 11:47 AM, Robert Richter wrote:
> A root decoder's callback handlers are collected in struct cxl_rd_ops.
> The structure is dynamically allocated, though it contains only a few
> pointers in it. This also requires to check two pointes to check for
> the existance of a callback.
> 
> Simplify the allocation, release and handler check by embedding the
> ops statical in struct cxl_root_decoder.
> 
> Implementation is equivalent to how struct cxl_root_ops handles the
> callbacks.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I think this can be split out send ahead. It's not tied to this series right?

> ---
>  drivers/cxl/acpi.c        |  8 ++------
>  drivers/cxl/core/region.c | 20 +++++---------------
>  drivers/cxl/cxl.h         |  2 +-
>  3 files changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index f9bbc77f3ec2..778ee29430ea 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -471,12 +471,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	cxlrd->qos_class = cfmws->qtg_id;
>  
>  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
> -		cxlrd->ops = kzalloc(sizeof(*cxlrd->ops), GFP_KERNEL);
> -		if (!cxlrd->ops)
> -			return -ENOMEM;
> -
> -		cxlrd->ops->hpa_to_spa = cxl_apply_xor_maps;
> -		cxlrd->ops->spa_to_hpa = cxl_apply_xor_maps;
> +		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
> +		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
>  	}
>  
>  	rc = cxl_decoder_add(cxld);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 379a67cc8e31..dec003084521 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2932,16 +2932,6 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
>  	return false;
>  }
>  
> -static bool has_hpa_to_spa(struct cxl_root_decoder *cxlrd)
> -{
> -	return cxlrd->ops && cxlrd->ops->hpa_to_spa;
> -}
> -
> -static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
> -{
> -	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
> -}
> -
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa)
>  {
> @@ -2996,8 +2986,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	hpa = hpa_offset + p->res->start + p->cache_size;
>  
>  	/* Root decoder translation overrides typical modulo decode */
> -	if (has_hpa_to_spa(cxlrd))
> -		hpa = cxlrd->ops->hpa_to_spa(cxlrd, hpa);
> +	if (cxlrd->ops.hpa_to_spa)
> +		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
>  
>  	if (!cxl_resource_contains_addr(p->res, hpa)) {
>  		dev_dbg(&cxlr->dev,
> @@ -3006,7 +2996,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	}
>  
>  	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
> -	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
> +	if (!cxlrd->ops.hpa_to_spa && !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
>  		return ULLONG_MAX;
>  
>  	return hpa;
> @@ -3041,8 +3031,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
>  	 * CXL HPA is assumed to equal SPA.
>  	 */
> -	if (has_spa_to_hpa(cxlrd)) {
> -		hpa = cxlrd->ops->spa_to_hpa(cxlrd, p->res->start + offset);
> +	if (cxlrd->ops.spa_to_hpa) {
> +		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
>  		hpa_offset = hpa - p->res->start;
>  	} else {
>  		hpa_offset = offset;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0af46d1b0abc..75fd45ddca38 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -451,7 +451,7 @@ struct cxl_root_decoder {
>  	void *platform_data;
>  	struct mutex range_lock;
>  	int qos_class;
> -	struct cxl_rd_ops *ops;
> +	struct cxl_rd_ops ops;
>  	struct cxl_switch_decoder cxlsd;
>  };
>  

