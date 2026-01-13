Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF925A2DE;
	Tue, 13 Jan 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319481; cv=none; b=hJFmfvGTWIVegt9OBKDmsoiwQyQyjcNmJXXsM0+slX+p1blY1SLkHcCauvJky4pgs5ePCNIsPAn2rfIJOzoyf5ZHsx2uvpJE2hhGqaWJKvD0NuYaughrxgZMOr5Wc9Vs1TZx+3jSNSvtFAuWa9lAVePR+gmv3aqrOdSPn3P6944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319481; c=relaxed/simple;
	bh=3Q+2/XTpXOVR8lUvp3LX3ItzOXiTp530yStawPiLk4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTM1QKjlJX8OcZNKerNS6bPld68btxkwviqii+wk4BKOvUsTxeXaM3mAIPr7JxzGH7BYVZD9+7+ROI5IeTduz+yZSN7UIDlkUh72VgX6TGqCGMYZapCzeakgZeZEtfaPwQbI+VHMPoo8PEYi9999aT3nBKWRZrBhSyh7s+Wti0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUWUOSEx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUWUOSEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768319479; x=1799855479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3Q+2/XTpXOVR8lUvp3LX3ItzOXiTp530yStawPiLk4Y=;
  b=EUWUOSExy5lTRIEeXFY3aStGdZAtW+OmN0ZAfjC197QRfklhfXC2hY6E
   3OaaQr1/JB6SVEKn0nHXXmC6apeI1gI7zWbmnUnDRkIVi/53QaeJfX4pN
   W6/m7s4o/O4oX/RJaJNWg0HoBDQyjG6eMHb6u7TqGuIZqHF6y3VrtLobb
   OJ8Z4BQV46p8bhBkQDxJcvdwATjqYAkbXukrXtLF6ZE9z7CmT646mbVkn
   BTGPBUytBsR2ibVg1ubdUFW/oyDmaROyjySHQ+h3QNjixKSWTekuKOzxc
   64atIJ5pvZwHhm6mSyj/V9ULrX7IOQdYSel2ZMvUnC+ir02Y2Q92+YOR0
   A==;
X-CSE-ConnectionGUID: /2ZXBJNyQemHOOII45L5AA==
X-CSE-MsgGUID: jG63Yyr9Qf+od6HWga0KYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="92276544"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="92276544"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 07:51:18 -0800
X-CSE-ConnectionGUID: QFOdMYGQS0OhGUMEMx18Cg==
X-CSE-MsgGUID: aJM5psViRT+dBtCk1C4SOQ==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 07:51:16 -0800
Message-ID: <3dbe036d-608d-486a-bc5a-b55b690d8347@intel.com>
Date: Tue, 13 Jan 2026 08:51:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl: Check for invalid addresses returned from
 translation functions on errors
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260107120544.410993-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260107120544.410993-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/7/26 5:05 AM, Robert Richter wrote:
> Translation functions may return an invalid address in case of errors.
> If the address is not checked the further use of the invalid value
> will cause an address corruption.
> 
> Consistently check for a valid address returned by translation
> functions. Use RESOURCE_SIZE_MAX to indicate an invalid address for
> type resource_size_t. Depending on the type either RESOURCE_SIZE_MAX
> or ULLONG_MAX is used to indicate an address error.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v3:
>  * updated sob-chain,
>  * changed error handling flow in test/cxl_translate.c (Alison),
> 
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
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Applied to cxl/fixes
8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c

Added user impact statement and fixed up tab formatting reported by checkpatch.


> ---
>  drivers/cxl/core/hdm.c                 |  2 +-
>  drivers/cxl/core/region.c              | 34 ++++++++++++++++++++------
>  tools/testing/cxl/test/cxl_translate.c | 30 ++++++++++++++---------
>  3 files changed, 45 insertions(+), 21 deletions(-)
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
> index 2200ae21795c..2d9b75b30dbc 100644
> --- a/tools/testing/cxl/test/cxl_translate.c
> +++ b/tools/testing/cxl/test/cxl_translate.c
> @@ -68,6 +68,8 @@ static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
>  
>  	/* Calculate base HPA offset from DPA and position */
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
> +	if (hpa_offset == ULLONG_MAX)
> +		return ULLONG_MAX;
>  
>  	if (math == XOR_MATH) {
>  		cximsd->nr_maps = hbiw_to_nr_maps[hb_ways];
> @@ -258,19 +260,23 @@ static int test_random_params(void)
>  		pos = get_random_u32() % ways;
>  		dpa = get_random_u64() >> 12;
>  
> +		reverse_dpa = ULLONG_MAX;
> +		reverse_pos = -1;
> +
>  		hpa = cxl_calculate_hpa_offset(dpa, pos, eiw, eig);
> -		reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
> -		reverse_pos = cxl_calculate_position(hpa, eiw, eig);
> -
> -		if (reverse_dpa != dpa || reverse_pos != pos) {
> -			pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
> -			       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw,
> -			       eig);
> -
> -			if (failures++ > 10) {
> -				pr_err("test random too many failures, stop\n");
> -				break;
> -			}
> +		if (hpa != ULLONG_MAX) {
> +			reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
> +			reverse_pos = cxl_calculate_position(hpa, eiw, eig);
> +			if (reverse_dpa == dpa && reverse_pos == pos)
> +				continue;
> +		}
> +
> +		pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
> +			i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw, eig);
> +
> +		if (failures++ > 10) {
> +			pr_err("test random too many failures, stop\n");
> +			break;
>  		}
>  	}
>  	pr_info("..... test random: PASS %d FAIL %d\n", i - failures, failures);
> 
> base-commit: 88c72bab77aaf389beccf762e112828253ca0564

