Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667CB72639;
	Fri,  5 Sep 2025 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114069; cv=none; b=tLmraJqLDel6EpUEVpKjPrfALX6riXdaGc0cj3Bxotr3t7jA9RxICmDI4hG1TyNskZUI+fTwtferZKVO9wVAUSiAha/aZ98raTNSLg63oQd6IfT01WsdvdlTROvazQCyJ1XNs+FR1KkJvVrdkO2p6zjl7ef+aT19zCoZlvP635A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114069; c=relaxed/simple;
	bh=DaiHb5W0p0wpge94mD4GAYQ0Wzc+6VFHQVac9m3RIFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbK8PJIuj6Rbx+a82Q8djttsESnWgmUSZmvwE5OaWN+KbL80yiTbWgIHt9akqV5SDWFytlZwSbZhv6FAZ6wCWYSyYaJO68qVo2x/8qUj2iRJN9XOzbp3KCDz52+ZJ/ZkKN3lbLMx8t559tWJByqn0HNKS39Zdot79F0Md1yInmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWXbgZKX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWXbgZKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757114068; x=1788650068;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DaiHb5W0p0wpge94mD4GAYQ0Wzc+6VFHQVac9m3RIFo=;
  b=XWXbgZKXRT3H+drdiQdRl9jzuhZEgEc1c2KHLPL75BhZIgrWQq2RDuvF
   2rOyuilWz2AMwS77KQZ8VnTkHxxcQLFmSY+3Rv3y56AkIrKIipIg/dans
   fFivxWQLbPS4Jk7RelaUDKiEK9+9rJzwUkvHkBrBLp3vdLEFZMZQQc0+H
   o8WO21uWyIGugVjUUZkXbjeuZJLwY+v1tQLxJmtTU0qhwVx/yOzCq0HCy
   rC6M+f3dX5e93Cs9dKyo35ImOH+p8d2y+H1xqhjao3CaMZ25hN6ZCCz8r
   6EGSjRYmGwnqeUNRq1oTZlzFwxzhyYIbootyVdH04QkjfWSHHRTQBnZZZ
   g==;
X-CSE-ConnectionGUID: ygGRUZ/9QW2V8noAbfwWug==
X-CSE-MsgGUID: MS7N2Ze8TQuRos9ISruBmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70087052"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="70087052"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 16:14:27 -0700
X-CSE-ConnectionGUID: XG0gzFs+TTewIzAeNqQs1Q==
X-CSE-MsgGUID: /03cYrhnR9SwpOW+aJ8DNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="176361987"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.110.53]) ([10.125.110.53])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 16:14:25 -0700
Message-ID: <41617b52-8416-43b4-a13b-b8ddc6e30249@intel.com>
Date: Fri, 5 Sep 2025 16:14:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v4] cxl/core: Enable Region creation on x86 with LMH
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-4-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250724142144.776992-4-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/25 7:20 AM, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).

Should bump it to the latest spec available (r3.2)

> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some cases the size

s/cases/cases, /

> of that hole is not compatible with the CXL hardware decoder constraint
> that the size is always aligned to 256M * Interleave Ways.
> 
> On those systems, BIOS publishes CFMWS which communicate the active System

s/BIOS/the BIOS/

> Physical Address (SPA) ranges that map to a subset of the Host Physical
> Address (HPA) ranges. The SPA range trims out the hole, and capacity in

s/capacity/the capacity/

> the endpoint is lost with no SPA to map to CXL HPA in that hole.
s/with/because there is/

> 
> In the early stages of CXL Regions construction and attach on platforms
s/Regions/region/

> with Low Memory Holes, cxl_add_to_region() fails and returns an error
s/Low Memory Holes/LMH/

> because it can't find any CXL Window that matches a given CXL Endpoint
s/CXL Window/CFMWS range/ I think?

> Decoder.
s/Endpoint Decoder/endpoint decoder HPA range/


> 
> Detect a Low Memory Hole by comparing Root Decoders and Endpoint Decoders
s/Low Memory Hole/LMH/
s/Root Decoders/root decoder HPA range/
s/Endpoint Decoders/endpoint decoder HPA range/

> ranges with the use of arch_match_{spa,region}() helpers.
> 
> Match Root Decoders and CXL Regions with corresponding CXL Endpoint
> Decoders. Currently a Low Memory Holes would prevent the matching functions
> to return true.
s/Root Decoders/root decoder HPA range/
s/Regions/region/
s/Endpoint Decoders/endpoint decoder HPA range/
s/Low Memory Hole/LMH/

> 
> Construct CXL Regions with HPA range's end adjusted to the matching SPA.

Construct CXL region with the end of its HPA range adjusted to the matching SPA.

> 
> Allow the attach target process to complete by allowing Regions to not
s/Regions/regions/

> fit with alignment constraints (i.e., alignment to NIW * 256M rule).

s/to not fit with/to bypass the/ ?

> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/region.c | 53 +++++++++++++++++++++++++++++++++------
>  tools/testing/cxl/Kbuild  |  1 +
>  2 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f607e7f97184..b7fdf9c4393d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -12,6 +12,7 @@
>  #include <linux/memory-tiers.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> +#include "platform.h"
>  #include "core.h"
>  
>  /**
> @@ -834,6 +835,8 @@ static int match_free_decoder(struct device *dev, const void *data)
>  static bool region_res_match_cxl_range(const struct cxl_region_params *p,
>  				       struct range *range)
>  {
> +	struct cxl_decoder *cxld;
> +
>  	if (!p->res)
>  		return false;
>  
> @@ -842,8 +845,15 @@ static bool region_res_match_cxl_range(const struct cxl_region_params *p,
>  	 * to be fronted by the DRAM range in current known implementation.
>  	 * This assumption will be made until a variant implementation exists.
>  	 */
> -	return p->res->start + p->cache_size == range->start &&
> -		p->res->end == range->end;
> +	if (p->res->start + p->cache_size == range->start &&
> +	    p->res->end == range->end)
> +		return true;

Have you thought through the scenario where extended linear cache exists and covers LMH? You may need to extend the math for platform_region_contains() maybe?

> +
> +	cxld = container_of(range, struct cxl_decoder, hpa_range);
> +	if (platform_region_contains(p, cxld))
> +		return true;
> +
> +	return false;

return platform_region_contains(p, cxld);

>  }
>  
>  static int match_auto_decoder(struct device *dev, const void *data)
> @@ -1763,6 +1773,7 @@ static int match_switch_and_ep_decoders(struct device *dev, const void *data)
>  {
>  	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
>  	const struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
> @@ -1772,8 +1783,13 @@ static int match_switch_and_ep_decoders(struct device *dev, const void *data)
>  	r1 = &cxlsd->cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	if (is_root_decoder(dev))
> -		return range_contains(r1, r2);
> +	if (is_root_decoder(dev)) {
> +		if (range_contains(r1, r2))
> +			return 1;
> +		cxlrd = to_cxl_root_decoder(dev);
> +		if (platform_root_decoder_contains(cxlrd, cxled))
> +			return 1;
> +	}
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> @@ -1990,7 +2006,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	}
>  
>  	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
> -	    resource_size(p->res)) {
> +	    resource_size(p->res) && !platform_root_decoder_contains(cxlrd, cxled)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s-size-%#llx * ways-%d + cache-%#llx != region-size-%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> @@ -3230,7 +3246,12 @@ static int match_root_and_ep_decoders(struct device *dev, const void *data)
>  	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	return range_contains(r1, r2);
> +	if (range_contains(r1, r2))
> +		return true;
> +	if (platform_root_decoder_contains(cxlrd, cxled))
> +		return true;
> +
> +	return false;

return range_contais(...) || platform_root_decoder_contains(...);

DJ

>  }
>  
>  static struct cxl_decoder *
> @@ -3277,8 +3298,12 @@ static int match_region_and_ep_decoder(struct device *dev, const void *data)
>  	p = &cxlr->params;
>  
>  	guard(rwsem_read)(&cxl_region_rwsem);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			return 1;
> +		if (platform_region_contains(p, &cxled->cxld))
> +			return 1;
> +	}
>  
>  	return 0;
>  }
> @@ -3355,6 +3380,12 @@ static int __construct_region(struct cxl_region *cxlr,
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
>  
> +	/*
> +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> +	 * platform
> +	 */
> +	platform_res_adjust(res, cxled, cxlrd);
> +
>  	rc = cxl_extended_linear_cache_resize(cxlr, res);
>  	if (rc && rc != -EOPNOTSUPP) {
>  		/*
> @@ -3464,6 +3495,12 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  		cxl_find_region_by_range(cxlrd, cxled);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
> +	else
> +		/*
> +		 * Adjust the Endpoint Decoder's dpa_res to fit the Region which
> +		 * it has to be attached to
> +		 */
> +		platform_res_adjust(NULL, cxled, cxlrd);
>  	mutex_unlock(&cxlrd->range_lock);
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 31a2d73c963f..77e392c4b541 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -65,6 +65,7 @@ cxl_core-y += $(CXL_CORE_SRC)/ras.o
>  cxl_core-y += $(CXL_CORE_SRC)/acpi.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
> +cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += $(CXL_CORE_SRC)/platform.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o

