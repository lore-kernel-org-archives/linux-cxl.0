Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A223C4FD;
	Wed, 10 Dec 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383829; cv=none; b=h/mR94EbFRO68gjFG/Qu4l1ufZevK9pyTsv7OTd7vabgl3CIIoCuQPgfca/Jzj3y24t9P2Gd4uYFtrSEpOG0HhQ6jBxBJE93SZzJ66WIkJnZPh5b+vSEHiLWtl3aEgcwxMcwCzdgQCZeI06I15QfgiTDiaVDZI0vBNCbQeMa0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383829; c=relaxed/simple;
	bh=UBp9ky9gpU5ZQWr67cEeCkr77va6ZZIWw4wC85As4S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qALxe4982z4g63rQC0s13kp0Nbdw80xi6NonQVQbrhk1N7VcRnlzcw8G4geGUW8DzkR/L8HJSRkb5izGGL5vQ3qJHSDbUvNNYZ3+aKV7ejh6o++sW6engsIcM1A1z/We/uyPjW7l/yYdiI0+ZYYlKQKMa3DFZL9IXzssxm3WdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wwrj52zh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wwrj52zh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765383827; x=1796919827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UBp9ky9gpU5ZQWr67cEeCkr77va6ZZIWw4wC85As4S0=;
  b=Wwrj52zhXaw7OxGZJLqMaPgLfwG3SDfZqcJs56+hrHiuZkybFDIxTv35
   JFhj9jEGpDaTm69swxhWB2v64+2tg4HY0waQUMn3hnjnOqx379jj8aqcH
   PbkdtSNZolwMALDEjGywNtjaxsbPPXpGhSUwh5pQxu5ipfrhqqNaNYRYM
   6yLWhHqb24OHyY31mu/N9hxg1QVEqiaoRGIlfOYPzn+II6PDZRpM1AyYc
   N7R2Q8sA13pbH8ge0mVY8pVqMmCPlPawQ1NmGcvl0VrRdF1LqnKUBThtx
   YMBQ0bj8HFV5DIbJyr9jSlJK9TihjhkZDR7ZnemRxpB0U7XrLqz/X6SOT
   A==;
X-CSE-ConnectionGUID: rNCUvPnBRtGhm1tRvzlQ7Q==
X-CSE-MsgGUID: FXngTfHrQvyxWdZh2AWmjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="92834688"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="92834688"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 08:23:45 -0800
X-CSE-ConnectionGUID: 3in+NhsxSjutrJ07NFY+Yw==
X-CSE-MsgGUID: /KUqW6WbRq+6CN45GJHpJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="196161496"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 08:23:45 -0800
Message-ID: <a143dda4-53b2-4962-8e30-ceae969fb93c@intel.com>
Date: Wed, 10 Dec 2025 09:23:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/13] cxl: Check if ULLONG_MAX was returned from
 translation functions
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251209180659.208842-1-rrichter@amd.com>
 <20251209180659.208842-13-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251209180659.208842-13-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/9/25 11:06 AM, Robert Richter wrote:
> The return address of translation functions is not consistently
> checked for a valid address. Check if ULLONG_MAX was returned.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/hdm.c                 |  2 +-
>  drivers/cxl/core/region.c              | 36 +++++++++++++++++++-------
>  tools/testing/cxl/test/cxl_translate.c |  4 +--
>  3 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1c5d2022c87a..8b50cdce4b29 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -530,7 +530,7 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  {
> -	resource_size_t base = -1;
> +	resource_size_t base = ULLONG_MAX;
>  
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	if (cxled->dpa_res)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c7ac78f1b644..2c070c7c7bfe 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3124,7 +3124,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> -	u64 dpa_offset, hpa_offset, hpa;
> +	u64 base, dpa_offset, hpa_offset, hpa;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3142,8 +3142,14 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	ways_to_eiw(p->interleave_ways, &eiw);
>  	granularity_to_eig(p->interleave_granularity, &eig);
>  
> -	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +	base = cxl_dpa_resource_start(cxled);
> +	if (base == ULLONG_MAX)
> +		return ULLONG_MAX;
> +
> +	dpa_offset = dpa - base;
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
> +	if (hpa_offset == ULLONG_MAX)
> +		return ULLONG_MAX;
>  
>  	/* Apply the hpa_offset to the region base address */
>  	hpa = hpa_offset + p->res->start + p->cache_size;
> @@ -3152,6 +3158,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	if (cxlrd->ops.hpa_to_spa)
>  		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
>  
> +	if (hpa == ULLONG_MAX)
> +		return ULLONG_MAX;
> +
>  	if (!cxl_resource_contains_addr(p->res, hpa)) {
>  		dev_dbg(&cxlr->dev,
>  			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> @@ -3176,10 +3185,11 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_endpoint_decoder *cxled;
> -	u64 hpa, hpa_offset, dpa_offset;
> +	u64 hpa_offset = offset;
> +	u64 dpa_base, dpa_offset;
>  	u16 eig = 0;
>  	u8 eiw = 0;
> -	int pos;
> +	int pos = -1;
>  
>  	lockdep_assert_held(&cxl_rwsem.region);
>  	lockdep_assert_held(&cxl_rwsem.dpa);
> @@ -3193,13 +3203,14 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	 * CXL HPA is assumed to equal SPA.
>  	 */
>  	if (cxlrd->ops.spa_to_hpa) {
> -		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> -		hpa_offset = hpa - p->res->start;
> -	} else {
> -		hpa_offset = offset;
> +		hpa_offset = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> +		if (hpa_offset != ULLONG_MAX)

Should it just return error here when hpa_offset == ULLONG_MAX?

> +			hpa_offset -= p->res->start;
>  	}>  
> -	pos = cxl_calculate_position(hpa_offset, eiw, eig);
> +	if (hpa_offset != ULLONG_MAX)

And this check won't be need if it returned earlier above

> +		pos = cxl_calculate_position(hpa_offset, eiw, eig);
> +
>  	if (pos < 0 || pos >= p->nr_targets) {
>  		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
>  			pos, p->nr_targets);
> @@ -3213,8 +3224,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  		cxled = p->targets[i];
>  		if (cxled->pos != pos)
>  			continue;
> +
> +		dpa_base = cxl_dpa_resource_start(cxled);
> +		if (dpa_base == ULLONG_MAX)
> +			continue;

If dpa_base is ULLONG_MAX, should it be an error and exit instead of continuing?

DJ
> +
>  		result->cxlmd = cxled_to_memdev(cxled);
> -		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
> +		result->dpa = dpa_base + dpa_offset;
>  
>  		return 0;
>  	}
> diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
> index 2200ae21795c..66f8270aacd8 100644
> --- a/tools/testing/cxl/test/cxl_translate.c
> +++ b/tools/testing/cxl/test/cxl_translate.c
> @@ -69,7 +69,7 @@ static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
>  	/* Calculate base HPA offset from DPA and position */
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
>  
> -	if (math == XOR_MATH) {
> +	if (hpa_offset != ULLONG_MAX && math == XOR_MATH) {
>  		cximsd->nr_maps = hbiw_to_nr_maps[hb_ways];
>  		if (cximsd->nr_maps)
>  			return cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
> @@ -262,7 +262,7 @@ static int test_random_params(void)
>  		reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
>  		reverse_pos = cxl_calculate_position(hpa, eiw, eig);
>  
> -		if (reverse_dpa != dpa || reverse_pos != pos) {
> +		if (hpa == ULLONG_MAX || reverse_dpa != dpa || reverse_pos != pos) {
>  			pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
>  			       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw,
>  			       eig);

