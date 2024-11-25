Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2F6F06D;
	Mon, 25 Nov 2024 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566937; cv=none; b=Y5980xQNWSIPxu9oJvwxL5eK2lYahpP3gj6zlsD3oQBAdntbGQgkABrBeV/e7fD1oWJzd0ThEoR2ttCEcDYuQvlY8ovMVX/9om1lgK5ECL0oUXlHaQhanuunCo3EEs6I1XwSAmJ2Raf3pB4QWwgL/LhYUzio+sOH8Bzu80LIckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566937; c=relaxed/simple;
	bh=Y6YA4KktF5H6tcRL/zjPvpw0CSNEjYnlni+1m1IgWsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtSQH4vbzRqtSCRC1bL4cjUnmL61lQZMzHvfaGAl1a4jAdmAIOt8lD2WqTicVm88gAQX/dDXrmKja/U1452P5diFJFqyhUO271RP9qsu4GUWmc41F4HYIu5m+PKYV1vb+VzwGfp5XURmxDAOve2smf5efmgNvP5YP1mvhM16xH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dc9E8gUI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dc9E8gUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732566935; x=1764102935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y6YA4KktF5H6tcRL/zjPvpw0CSNEjYnlni+1m1IgWsc=;
  b=Dc9E8gUIFYRVWZfkLHvO9lZSPZ47UsAjwbgGieRWYRfze06U85jMxfje
   LBNfTsRTDCXZoYaNL8lPm8obOzdaLyl+3b/aI9wz4yrLTlOqwukUzWdQh
   XDrkbp/lmdLf9pjAQ1UyUE5hMF82Hpt/3I9TFKRLuhJ9dT5L0iVGMxpZB
   Yq0PtMyurIKO8kzQsBam/uc2e+tWqxcaE4cMjRukvoAznJce5WwCeVFy3
   MITyOwsenSdRlvSW42yWgP5ZNQUjV/S2XIy8mZtJQo7iblErmpgrHNo/F
   dq+avNimiFIZI2VDV8gA/gMnXx2L3GEy/MLAoHRnye9szel8WMDYkmIdp
   Q==;
X-CSE-ConnectionGUID: JcyJCUtkRw66OEDMNCpQGg==
X-CSE-MsgGUID: WuLjbNzYSOGvLFCxr4UhKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="50106887"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="50106887"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:35:34 -0800
X-CSE-ConnectionGUID: KqY6nXP6QEGppkEuzY29Vw==
X-CSE-MsgGUID: GhryeVljRNiOboQ7Iz30BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91011823"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.188])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:35:33 -0800
Date: Mon, 25 Nov 2024 12:35:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
Message-ID: <Z0TflK-L788wPFja@aschofie-mobl2.lan>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>

On Fri, Nov 22, 2024 at 04:51:53PM +0100, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some cases the size
> of that hole is not compatible with the CXL hardware decoder constraint
> that the size is always aligned to 256M * Interleave Ways.
> 
> On those systems, BIOS publishes CFMWS which communicate the active System
> Physical Address (SPA) ranges that map to a subset of the Host Physical
> Address (HPA) ranges. The SPA range trims out the hole, and capacity in
> the endpoint is lost with no SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, cxl_add_to_region() fails and returns an error
> because it can't find any CXL Window that matches a given CXL Endpoint
> Decoder.
> 
> Detect Low Memory Holes by comparing Root Decoders and Endpoint Decoders
> ranges: both must start at physical address 0 and end below 4 GB, while
> the Root Decoder ranges end at lower addresses than the matching Endpoint
> Decoders which instead must always respect the above-mentioned CXL hardware
> decoders HPA alignment constraint.
> 
> Match misaligned CFMWS and CXL Regions with corresponding CXL Endpoint
> Decoders if driver detects Low Memory Holes.
> 
> Construct CXL Regions with HPA range's end trimmed by matching SPA.
> 
> Allow the attach target process to complete by relaxing Decoder constraints
> which would lead to failures.

This may be crisper in 2 patches so that we can separate
a) introducing a method to handle arch specific constraints in region creation 
from
b) use method a) to handle the x86 LMH specific constraint.

Sometimes with an add like this, we'll say your the first, so go for it,
and the next one will have to generic-ize. This time, we are aware that
other holes may be lurking, so perhaps we can driver that generic soln
from the start.

snip
> 
> diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c

snip

> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +		    struct cxl_endpoint_decoder *cxled)
> +{
> +	struct range *r1, *r2;
> +	int niw;
> +
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +	niw = cxled->cxld.interleave_ways;
> +
> +	if (r1->start == MISALIGNED_CFMWS_RANGE_BASE &&
> +	    r1->start == r2->start && r1->end < r2->end &&
> +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> +		return true;

space before final return please

> +	return false;
> +}
> +
> +/* Similar to arch_match_spa(), it matches regions and decoders */
> +bool arch_match_region(struct cxl_region_params *p,
> +		       struct cxl_decoder *cxld)
> +{
> +	struct range *r = &cxld->hpa_range;
> +	struct resource *res = p->res;
> +	int niw = cxld->interleave_ways;
> +
> +	if (res->start == MISALIGNED_CFMWS_RANGE_BASE &&
> +	    res->start == r->start && res->end < r->end &&
> +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> +		return true;

space before final return please

> +	return false;
> +}
> +
> +void arch_trim_hpa_by_spa(struct resource *res,
> +			  struct cxl_root_decoder *cxlrd)
> +{
> +	res->end = cxlrd->res->end;
> +}

I'm not so sure about the above function name.

trim_by_spa implies to me that the hpa is trimmed by the amount of the spa.
The hpa is trimmed to align with the spa and that is special to this LMH
case.

Would something completely generic suffice here, like:
arch_adjust_region_resource()


> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c

snip

> @@ -3270,6 +3291,22 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> +
> +	/*
> +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> +	 * platform
> +	 */
> +	if (arch_match_spa(cxlrd, cxled)) {
> +		struct range *range = &cxlrd->cxlsd.cxld.hpa_range;
> +
> +		arch_trim_hpa_by_spa(res, cxlrd);
> +		dev_dbg(cxlmd->dev.parent,
> +			"%s: Trim HPA (%s: %pr) by SPA (%s: %pr)\n",
> +			__func__,
> +			dev_name(&cxlrd->cxlsd.cxld.dev), range,
> +			dev_name(&cxled->cxld.dev), hpa);
> +	}

no need for __func__ as the dev_dbg() includes that.

%pr works for struct resource, like the HPA, but not struct range.
I'm guessing you'll v2 after v6.13-rc1 is out and then you can
use the new struct range print format Ira added.

When I tried this out I spew'd more. I'm not suggesting you print all
I printed but maybe find a hint in here of what someone debugging will
want to know. Maybe some of the debug should emit from the the lmh.c
function so that it can be more LMH special>

[] cxl_core:construct_region:3302: cxl region0: LMH: res was [mem 0xf010000000-0xf04fffffff flags 0x200]
[] cxl_core:construct_region:3306: cxl region0: LMH: res now trimmed to [mem 0xf010000000-0xf03fffffff flags 0x200]
[] cxl_core:construct_region:3307: cxl region0: LMH: res now matches root decoder decoder0.0 [0xf010000000 - 0xf03fffffff]
[] cxl_core:construct_region:3309: cxl region0: LMH: res does not match endpoint decoder decoder15.0 [0xf010000000 - 0xf04fffffff]

I wonder if we are overdoing the HPA SPA language to the point of confusion
(maybe just me). By this point we've decided the root decoder range is good
so we are trimming the region resource (typically derived from the endpoint
decoder range) to match the root decoder range.

snip

> +#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +		    struct cxl_endpoint_decoder *cxled);
> +bool arch_match_region(struct cxl_region_params *p,
> +		       struct cxl_decoder *cxld);
> +void arch_trim_hpa_by_spa(struct resource *res,
> +			  struct cxl_root_decoder *cxlrd);
> +#else
> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +		    struct cxl_endpoint_decoder *cxled)
> +{
> +	return false;
> +}
> +
> +bool arch_match_region(struct cxl_region_params *p,
> +		       struct cxl_decoder *cxld)
> +{
> +	return false;
> +}
> +
> +void arch_trim_hpa_by_spa(struct resource *res,
> +			  struct cxl_root_decoder *cxlrd)
> +{ }
> +#endif /* CXL_ARCH_LOW_MEMORY_HOLE */

Some longish lines are needlessly split.
git clang-format can help with that.

-- Alison

snip to end.
> 
