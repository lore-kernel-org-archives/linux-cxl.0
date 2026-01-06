Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A25357A33;
	Tue,  6 Jan 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721544; cv=none; b=QhCO169a1Qww9CD+l3mixzEo34b/eKN+DHWdHnlgzGx/7Qewr6yNIIBRAkOcVC7dhbkQIyC+gtBc0+G2lcNOrXzq3YuSOA+l8bPb2fPFoHukCRXENlHzt1t77k//dy06QBpsSfDDRBN3ltu5e74QHxgvEEv+DCulNGkARF9o8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721544; c=relaxed/simple;
	bh=frFOd7qGeVWcehJRzlUdxiYOq6BxR+26ILtDRwbTZc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B04g2HnlSshUT77slgL9X++EnJFx8ke0JNO04Wx/uVSYbezIoQ5dgSW35Fl3fNKV1cXKmno/qxNGmOoZ7ot2i7nd7hYamm8S9UtYBFcRq1wZBMQ0Xi6IrLgV2xD8SYXPT/6M3m90lqjj83ZaqANFaNbEU6DiJDmvJDtyZeyVlP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MRk9HNVF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRk9HNVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767721535; x=1799257535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=frFOd7qGeVWcehJRzlUdxiYOq6BxR+26ILtDRwbTZc8=;
  b=MRk9HNVF+WaK7NLb4hzw67BW5LSO7nExspNzeJZKQYPIGjwlkJw/n7n+
   MVHRfx4nlHwCfSxesTOnfgP+ehlhcJBwTQte4DP8+n3tOTQyHyfVKbsFy
   jTFNMpLir6MlRl8sOI9wZpQG8/p64AulRDlqmw2U6dx5SNblAa8wsCCyj
   SyistsU279yPIf0w/iAt7gm6gM9z6V/tE/yyn1UfHf7lREt4XW91nWRxm
   NbHhFMVw3EfgldJ5qweWzV2+iKvALnVn7L66aaTdQ2r22w7wNmrtQmVqa
   +Iwd8CeBMwTowLbfuFmCY1DKVz5Ilwc6zwNEJMcJFO5kKbn034ANUTB+J
   g==;
X-CSE-ConnectionGUID: VsfoNBpwQSeO9z9zmDp1jg==
X-CSE-MsgGUID: Ahd1IEBzQTegv+0KALRKDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="68287385"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="68287385"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 09:45:34 -0800
X-CSE-ConnectionGUID: siH+Uvu7RZ6AN1AwbCalXg==
X-CSE-MsgGUID: bmqGESl/TOa2Y/xxzqRhtQ==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.101]) ([10.125.109.101])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 09:45:33 -0800
Message-ID: <fa557c8b-0394-4f48-9ef4-6ffe7755ae00@intel.com>
Date: Tue, 6 Jan 2026 10:45:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Check for invalid addresses returned from
 translation functions on errors
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260106172358.350724-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260106172358.350724-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/6/26 10:23 AM, Robert Richter wrote:
> Translation functions may return an invalid address in case of errors.
> If the address is not checked the further use of the invalid value
> will cause an address corruption.
> 
> Consistently check for a valid address returned by translation
> functions. Use RESOURCE_SIZE_MAX to indicate an invalid address for
> type resource_size_t. Depending on the type either RESOURCE_SIZE_MAX
> or ULLONG_MAX is used to indicate an address error.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v2:
>  * separated from this patch series (Alison):
>    [PATCH v8 00/13] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
>  * improved error handling logic and early return on error in
>    region_offset_to_dpa_result() (Dave),
>  * use RESOURCE_SIZE_MAX to indicate an invalid address for
>    resource_size_t types (Alison, kernel test robot),
>  * improved patch description (Alison),
>  * added line wrap for code >80 chars.
> ---
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/hdm.c                 |  2 +-
>  drivers/cxl/core/region.c              | 34 ++++++++++++++++++++------
>  tools/testing/cxl/test/cxl_translate.c |  5 ++--
>  3 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1c5d2022c87a..031672e92b0b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -530,7 +530,7 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  {
> -	resource_size_t base = -1;
> +	resource_size_t base = RESOURCE_SIZE_MAX;
>  
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	if (cxled->dpa_res)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index fc36a5413d3f..5bd1213737fa 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3118,7 +3118,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> -	u64 dpa_offset, hpa_offset, hpa;
> +	u64 base, dpa_offset, hpa_offset, hpa;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3136,8 +3136,14 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	ways_to_eiw(p->interleave_ways, &eiw);
>  	granularity_to_eig(p->interleave_granularity, &eig);
>  
> -	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +	base = cxl_dpa_resource_start(cxled);
> +	if (base == RESOURCE_SIZE_MAX)
> +		return ULLONG_MAX;
> +
> +	dpa_offset = dpa - base;
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
> +	if (hpa_offset == ULLONG_MAX)
> +		return ULLONG_MAX;
>  
>  	/* Apply the hpa_offset to the region base address */
>  	hpa = hpa_offset + p->res->start + p->cache_size;
> @@ -3146,6 +3152,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	if (cxlrd->ops.hpa_to_spa)
>  		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
>  
> +	if (hpa == ULLONG_MAX)
> +		return ULLONG_MAX;
> +
>  	if (!cxl_resource_contains_addr(p->res, hpa)) {
>  		dev_dbg(&cxlr->dev,
>  			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> @@ -3170,7 +3179,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_endpoint_decoder *cxled;
> -	u64 hpa, hpa_offset, dpa_offset;
> +	u64 hpa_offset = offset;
> +	u64 dpa, dpa_offset;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3187,10 +3197,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	 * CXL HPA is assumed to equal SPA.
>  	 */
>  	if (cxlrd->ops.spa_to_hpa) {
> -		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> -		hpa_offset = hpa - p->res->start;
> -	} else {
> -		hpa_offset = offset;
> +		hpa_offset = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> +		if (hpa_offset == ULLONG_MAX) {
> +			dev_dbg(&cxlr->dev, "HPA not found for %pr offset %#llx\n",
> +				p->res, offset);
> +			return -ENXIO;
> +		}
> +		hpa_offset -= p->res->start;
>  	}
>  
>  	pos = cxl_calculate_position(hpa_offset, eiw, eig);
> @@ -3207,8 +3220,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  		cxled = p->targets[i];
>  		if (cxled->pos != pos)
>  			continue;
> +
> +		dpa = cxl_dpa_resource_start(cxled);
> +		if (dpa != RESOURCE_SIZE_MAX)
> +			dpa += dpa_offset;
> +
>  		result->cxlmd = cxled_to_memdev(cxled);
> -		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
> +		result->dpa = dpa;
>  
>  		return 0;
>  	}
> diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
> index 2200ae21795c..c2af918b853e 100644
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
> @@ -262,7 +262,8 @@ static int test_random_params(void)
>  		reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
>  		reverse_pos = cxl_calculate_position(hpa, eiw, eig);
>  
> -		if (reverse_dpa != dpa || reverse_pos != pos) {
> +		if (hpa == ULLONG_MAX || reverse_dpa != dpa ||
> +		    reverse_pos != pos) {
>  			pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
>  			       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw,
>  			       eig);
> 
> base-commit: 88c72bab77aaf389beccf762e112828253ca0564

