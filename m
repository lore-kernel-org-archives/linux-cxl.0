Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79922DA756;
	Tue, 18 Nov 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763501813; cv=none; b=rs/2ntSEpmO12nWAAm0IuhP/s+e8blGn7CIHQexTPAkdHX/e9fxNGcDd/Fv6gI5guZXzeRtJbUiJgIElF1WjyrM1RJrbdPhkSuQFOPvC5lXbglIhoiLi/AhFO5BSepE4Vi+iQeuKZaYfg67WDZha0w1ozdak6RRNuUlqqY//Un0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763501813; c=relaxed/simple;
	bh=TzXFeI7LDWxbd2tx5ZRrERwSEZJp7Dq993Wp4KCx2+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlpKJu/0yK13q6V6yRj2t2Ia9r3x8WDGh6etIOCFPRFINkKiy56XWefu8po2B+DvuRvxjBK0BG4KY7reW6/woG6DYQLRUAyrxMNlU8KdAs2gP1+bHX6tZhhjOqJrw5NuL2x2/U0PM3jOUPnk7heCjqv9odnktScj3Znp6ja8hHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uzi2miBI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uzi2miBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763501811; x=1795037811;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TzXFeI7LDWxbd2tx5ZRrERwSEZJp7Dq993Wp4KCx2+k=;
  b=Uzi2miBI686rV31O13ldmj8M6HivCww4IIq5Vkvygz1bmszhq4g/c3Fz
   f/4s3lDvnBBO67MUng7Jp3F5WoXeVQBIy8Xt2r6tDAYDFm7BxJED9T6Fv
   aQIUNT0DjRP5nrdE50FfLY3Kh6jQ+gLmIJdGjXWL/+tLv+OM3kG3XfYNj
   dL3IQA2XSlGVLYI7FylxbtYzwwonfLvyiluH1Sgcr3swOREKCfxVoYMN3
   3nCH/ImWZKflXUoltC0wsRdIdlQIL+QGDdULFZRX1AX5oHDXtb7VzSpD9
   AQ0Cy6GCPvV5I1qoUqczMXyQDCibdiBpXSoO+mhWS4gokOQ6cASeA7m8G
   A==;
X-CSE-ConnectionGUID: IMV0skxUR1S0yKe1t5TpzQ==
X-CSE-MsgGUID: 5c4wYpKmTy2R44TeAmWADw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="75861910"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="75861910"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 13:36:50 -0800
X-CSE-ConnectionGUID: gGXREKVKSkqlD6sJSy87IA==
X-CSE-MsgGUID: IC1+wEddS5SPnavw4Q0jqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195801943"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.115]) ([10.125.109.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 13:36:49 -0800
Message-ID: <ec00c6c1-7073-49c4-b16c-5babc8198969@intel.com>
Date: Tue, 18 Nov 2025 14:36:48 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4 v6] cxl/core: Add helpers to detect Low Memory Holes
 on x86
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Robert Richter <rrichter@amd.com>,
 Cheatham Benjamin <benjamin.cheatham@amd.com>
References: <20251118194321.1773484-1-fabio.m.de.francesco@linux.intel.com>
 <20251118194321.1773484-3-fabio.m.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251118194321.1773484-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/25 12:43 PM, Fabio M. De Francesco wrote:
> On a x86 platform with a low memory hole (LMH), the BIOS may publish
> CFMWS that describes a system physical address (SPA) range that
> typically is only a subset of the corresponding CXL intermediate switch
> and endpoint decoder's host physical address (HPA) ranges. The CFMWS
> range never intersects the LHM and so the driver instantiates a root
> decoder whose HPA range size doesn't fully contain the matching switch
> and endpoint decoders' HPA ranges.[1]
> 
> To construct regions and attach decoders, the driver needs to match root
> decoders and regions with endpoint decoders. The process fails and
> returns errors because the driver is not designed to deal with SPA
> ranges which are smaller than the corresponding hardware decoders HPA
> ranges.
> 
> Introduce two functions that indirectly detect the presence of x86 LMH
> and allow the matching between a root decoder or an already constructed
> region with a corresponding intermediate switch or endpoint decoder to
> enable the construction of a region and the subsequent attachment of the
> same decoders to that region.
> 
> These functions return true when SPA/HPA misalignments due to LMH's are
> detected under specific conditions:
> 
> - Both the SPA and HPA ranges must start at LMH_CFMWS_RANGE_START (i.e.,
>   0x0 on x86 with LMH's).
> - The SPA range's size is less than HPA's.
> - The SPA range's size is less than 4G.
> - The HPA range's size is aligned to the NIW * 256M rule.
> 
> Also introduce a function that adjusts the range end of a region to be
> constructed and the DPA range's end of the endpoint decoders that will
> be later attached to that region.
> 
> [1] commit c5dca38633da ("cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution")
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

minor nits below

> ---
>  drivers/cxl/Kconfig                |  11 +++
>  drivers/cxl/core/Makefile          |   1 +
>  drivers/cxl/core/platform_quirks.c | 103 +++++++++++++++++++++++++++++
>  drivers/cxl/core/platform_quirks.h |  36 ++++++++++
>  4 files changed, 151 insertions(+)
>  create mode 100644 drivers/cxl/core/platform_quirks.c
>  create mode 100644 drivers/cxl/core/platform_quirks.h
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..5ab8d5c23187 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -211,6 +211,17 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +config CXL_PLATFORM_QUIRKS
> +	bool "CXL: Region Platform Quirks"
> +	depends on CXL_REGION
> +	help
> +	  Enable support for the following platform quirks:
> +
> +		- Region creation / Endpoint Decoders attach in x86 with Low
> +		  Memory Holes (Documentation/driver-api/cxl/conventions.rst).
> +
> +	  If unsure say 'y'
> +
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 5ad8fef210b5..1684e46b8709 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,6 +17,7 @@ cxl_core-y += cdat.o
>  cxl_core-y += ras.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += platform_quirks.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> diff --git a/drivers/cxl/core/platform_quirks.c b/drivers/cxl/core/platform_quirks.c
> new file mode 100644
> index 000000000000..be57b9666c9b
> --- /dev/null
> +++ b/drivers/cxl/core/platform_quirks.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2025 Intel Corporation
> +
> +#include <linux/range.h>
> +#include "platform_quirks.h"
> +#include "cxlmem.h"
> +#include "core.h"
> +
> +/* Start of CFMWS range that end before x86 Low Memory Holes */
> +#define LMH_CFMWS_RANGE_START 0x0ULL
> +
> +/**
> + * platform_cxlrd_matches_cxled() - Platform quirk to match CXL Root and
> + * Endpoint Decoders. It allows matching on platforms with LMH's.
> + * @cxlrd: The Root Decoder against which @cxled is tested for matching.
> + * @cxled: The Endpoint Decoder to be tested for matching @cxlrd.
> + *
> + * platform_cxlrd_matches_cxled() is typically called from the
> + * match_*_by_range() functions in region.c. It checks if an endpoint decoder
> + * matches a given root decoder and returns true to allow the driver to succeed
> + * in the construction of regions where it would otherwise fail for the presence
> + * of a Low Memory Hole (see Documentation/driver-api/cxl/conventions.rst).
> + *
> + * In x86 platforms with LMH's, the CFMWS ranges never intersect the LMH, the
> + * endpoint decoder's HPA range size is always guaranteed aligned to NIW*256MB
> + * and also typically larger than the matching root decoder's, and the root
> + * decoder's range end is at an address that is necessarily less than SZ_4G
> + * (i.e., the Hole is in Low Memory - this function doesn't deal with other
> + * kinds of holes).
> + *
> + * Return: true if an endpoint matches a root decoder, else false.
> + */
> +bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				  const struct cxl_endpoint_decoder *cxled)
> +{
> +	const struct range *rd_r, *sd_r;
> +	int align;
> +
> +	rd_r = &cxlrd->cxlsd.cxld.hpa_range;
> +	sd_r = &cxled->cxld.hpa_range;

I think it should be ed_r instead of sd_r since it's endpoint decoder and not switch decoder right?

DJ

> +	align = cxled->cxld.interleave_ways * SZ_256M;
> +
> +	return rd_r->start == LMH_CFMWS_RANGE_START &&
> +	       rd_r->start == sd_r->start &&
> +	       rd_r->end < sd_r->end &&
> +	       rd_r->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
> +	       IS_ALIGNED(range_len(sd_r), align);
> +}
> +
> +/**
> + * platform_region_matches_cxld() - Platform quirk to match a CXL Region and a
> + * Switch or Endpoint Decoder. It allows matching on platforms with LMH's.
> + * @p: Region Params against which @cxled is matched.
> + * @cxld: Switch or Endpoint Decoder to be tested for matching @p.
> + *
> + * Similar to platform_cxlrd_matches_cxled(), it matches regions and
> + * decoders on platforms with LMH's.
> + *
> + * Return: true if a Decoder matches a Region, else false.
> + */
> +bool platform_region_matches_cxld(const struct cxl_region_params *p,
> +				  const struct cxl_decoder *cxld)
> +{
> +	const struct range *r = &cxld->hpa_range;
> +	const struct resource *res = p->res;
> +	int align = cxld->interleave_ways * SZ_256M;
> +
> +	return res->start == LMH_CFMWS_RANGE_START &&
> +	       res->start == r->start &&
> +	       res->end < r->end &&
> +	       res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
> +	       IS_ALIGNED(range_len(r), align);
> +}
> +
> +void platform_adjust_resources(struct resource *res,
> +			       struct cxl_endpoint_decoder *cxled,
> +			       const struct cxl_root_decoder *cxlrd,
> +			       const struct device *region_dev)
> +{
> +	struct resource dpa_res_orig = *cxled->dpa_res;
> +	u64 slice;
> +
> +	if (!platform_cxlrd_matches_cxled(cxlrd, cxled))
> +		return;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +
> +	/* Region resource will need a trim at first endpoint attach only */
> +	if (res && res->end != cxlrd->res->end) {
> +		dev_info(region_dev,
> +			 "LMH Low memory hole trims region resource %pr to %pr)\n",
> +			 res, cxlrd->res);
> +		res->end = cxlrd->res->end;
> +	}
> +
> +	/* Adjust the endpoint decoder DPA resource end */
> +	slice = div_u64(resource_size(cxlrd->res), cxled->cxld.interleave_ways);
> +	cxled->dpa_res->end = cxled->dpa_res->start + slice - 1;
> +
> +	dev_info(&cxled->cxld.dev,
> +		 "LMH Low memory hole trims DPA resource %pr to %pr)\n",
> +		 &dpa_res_orig, cxled->dpa_res);
> +}
> diff --git a/drivers/cxl/core/platform_quirks.h b/drivers/cxl/core/platform_quirks.h
> new file mode 100644
> index 000000000000..fce376232c16
> --- /dev/null
> +++ b/drivers/cxl/core/platform_quirks.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2025 Intel Corporation */
> +
> +#include "cxl.h"
> +
> +#ifdef CONFIG_CXL_PLATFORM_QUIRKS
> +bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				  const struct cxl_endpoint_decoder *cxled);
> +bool platform_region_matches_cxld(const struct cxl_region_params *p,
> +				  const struct cxl_decoder *cxld);
> +void platform_adjust_resources(struct resource *res,
> +			       struct cxl_endpoint_decoder *cxled,
> +			       const struct cxl_root_decoder *cxlrd,
> +			       const struct device *region_dev);
> +#else
> +static inline bool
> +platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +			       const struct cxl_endpoint_decoder *cxled)
> +{
> +	return false;
> +}
> +
> +static inline bool
> +platform_region_matches_cxld(const struct cxl_region_params *p,
> +			     const struct cxl_decoder *cxld)
> +{
> +	return false;
> +}
> +
> +static inline void
> +platform_adjust_resources(struct resource *res,
> +			  struct cxl_endpoint_decoder *cxled,
> +			  const struct cxl_root_decoder *cxlrd,
> +			  const struct device *region_dev)
> +{ }
> +#endif /* CONFIG_CXL_PLATFORM_QUIRKS */

