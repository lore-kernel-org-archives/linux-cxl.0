Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604427B4F5;
	Tue, 18 Nov 2025 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763503008; cv=none; b=GZ0YemIblHwg8YbiaztNLhcnymjZkWyvdq4YoSSzuM/ehQtVkR3pZTjiTRlrEnaJVK1L9A3UqiiDDEVOI+0xGqmnHnHX5vgViGBNY3hcG/Ssn7NZrUxxoDgTg+vpHZ4eqnljGeVDkeogkmk81ZVH4c+QlQeXoBJ5Iytwi2wiXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763503008; c=relaxed/simple;
	bh=mAA/nt7meDII0Rf3E+6FIqTKVte7FeKEquijdIx23S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blBE/9eJQU/4plkYWN8KZ/DWBLF9YZEKx0siHXf2K5PIc72v5hc/rbd4v+5l2ZfC5daaDizEy86ySncXUiNmNct5r1bXCBkWqS+gdPmvjwHB8BWbk7Km5MAC1qfp7ysBjEdjyGx1MYAGe3GYe9j8UVQ1f+RxaSSMdsZKFW7x5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvKcoOXP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvKcoOXP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763503007; x=1795039007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mAA/nt7meDII0Rf3E+6FIqTKVte7FeKEquijdIx23S4=;
  b=JvKcoOXPeRo9juMFs8CfyHR+Ow3uvijVr+7jJcDmQIiGE1WWcgbfo7on
   XslYh6JYINZ15vHCCHrZxO//YOk7PPEVnqUkvw7KxW9QUSh7bn8TVr9MH
   5oXo3WnoKFrc8b4yzyR2iBkSHmNib23JrdinEDSgZqwXxEB808amp1qYP
   OULNeaY/1oybxEwprZMqw0aYoFkijnbVrKp1BUMD7liIyAiDLU9iMTE73
   +hIAhwZlPWFmTjIcRCOkPvOn8Rew4qM9V/0Xayu8C1EAY35XCVEk8pUm+
   r8ujvAOjJnDsKtQgHIEKqcCWYQWHzWip1XULA2D5Lk2p5p26QIoBy/dTe
   g==;
X-CSE-ConnectionGUID: 3MpN2c6+Sw2r7RAnenf1pg==
X-CSE-MsgGUID: GwUDdLBoReilBXVOZAt7Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65478976"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65478976"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 13:56:46 -0800
X-CSE-ConnectionGUID: EkXdedNKTRu9K8FarJfpew==
X-CSE-MsgGUID: JhvozHWRTtehHF0NGF0oMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190527871"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.115]) ([10.125.109.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 13:56:44 -0800
Message-ID: <7a528c5a-1344-4504-9231-86d76634f47d@intel.com>
Date: Tue, 18 Nov 2025 14:56:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v6] cxl/core: Enable Region creation on x86 with LMH
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
 <20251118194321.1773484-4-fabio.m.de.francesco@linux.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251118194321.1773484-4-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/25 12:43 PM, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
> Host Physical Address (HPA) windows that are associated with each CXL
> Host Bridge. Each window represents a contiguous HPA that may be
> interleaved with one or more targets (CXL v3.2 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some case the size
> of that hole is not compatible with the constraint that the CFMWS size
> shall be multiple of Interleave Ways * 256 MB. (CXL v3.2 - Table 9-22).
> 
> On those systems, the BIOS publishes CFMWS which communicate the active
> System Physical Address (SPA) ranges that map to a subset of the Host
> Physical Address (HPA) ranges. The SPA range trims out the hole, and the
> capacity in the endpoint is lost with no SPA to map to CXL HPA in that
> hole.
> 
> In the early stages of CXL regions construction and attach on platforms
> that have Low Memory Holes, cxl_add_to_region() fails and returns an
> error for it can't find any CFMWS range that matches a given endpoint
> decoder.
> 
> Detect an LMH by comparing root decoder and endpoint decoder range.
> Match root decoders HPA range and constructed region with the
> corresponding endpoint decoders. Construct CXL region with the end of
> its HPA ranges end adjusted to the matching SPA and adjust the DPA
> resource end of the hardware decoders to fit the region.  Allow the
> attach target process to complete by allowing regions and decoders to
> bypass the constraints that don't hold when an LMH is present.[1]
> 
> [1] commit c5dca38633da ("cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution")
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++++++++++-------
>  tools/testing/cxl/Kbuild  |  1 +
>  2 files changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 315481444eb0..173a4b2d4baa 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -14,6 +14,7 @@
>  #include <linux/string_choices.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> +#include "platform_quirks.h"
>  #include "core.h"
>  
>  /**
> @@ -872,6 +873,8 @@ static int match_free_decoder(struct device *dev, const void *data)
>  static bool spa_maps_hpa(const struct cxl_region_params *p,
>  			 const struct range *range)
>  {
> +	struct cxl_decoder *cxld;
> +
>  	if (!p->res)
>  		return false;
>  
> @@ -880,8 +883,13 @@ static bool spa_maps_hpa(const struct cxl_region_params *p,
>  	 * where the SPA maps equal amounts of DRAM and CXL HPA capacity with
>  	 * CXL decoders at the high end of the SPA range.
>  	 */
> -	return p->res->start + p->cache_size == range->start &&
> -		p->res->end == range->end;
> +	if (p->res->start + p->cache_size == range->start &&
> +	    p->res->end == range->end)
> +		return true;
> +
> +	cxld = container_of(range, struct cxl_decoder, hpa_range);

I'm a bit concerned with this line. It makes the assumption that the range passed to this function is always a decoder's range member. If that is the assumption to be made, then it should pass in 'struct cxl_decoder' rather than a 'struct range'. Otherwise just blindly assume that the range is part of the cxld can lead to memory corruption when the range passed in is not part of cxld. You probably should have a prep patch to change the parameter before this patch if you are changing it to a decoder from range.

DJ 

> +
> +	return platform_region_matches_cxld(p, cxld);
>  }
>  
>  static int match_auto_decoder(struct device *dev, const void *data)
> @@ -1812,6 +1820,7 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
>  {
>  	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
>  	const struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
> @@ -1821,8 +1830,13 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
>  	r1 = &cxlsd->cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	if (is_root_decoder(dev))
> -		return range_contains(r1, r2);
> +	if (is_root_decoder(dev)) {
> +		if (range_contains(r1, r2))
> +			return 1;
> +		cxlrd = to_cxl_root_decoder(dev);
> +		if (platform_cxlrd_matches_cxled(cxlrd, cxled))
> +			return 1;
> +	}
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> @@ -2039,7 +2053,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	}
>  
>  	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
> -	    resource_size(p->res)) {
> +	    resource_size(p->res) && !platform_cxlrd_matches_cxled(cxlrd, cxled)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s-size-%#llx * ways-%d + cache-%#llx != region-size-%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> @@ -3472,7 +3486,8 @@ static int match_cxlrd_to_cxled_by_range(struct device *dev, const void *data)
>  	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	return range_contains(r1, r2);
> +	return (range_contains(r1, r2)) ||
> +		(platform_cxlrd_matches_cxled(cxlrd, cxled));
>  }
>  
>  static struct cxl_decoder *
> @@ -3591,6 +3606,12 @@ static int __construct_region(struct cxl_region *cxlr,
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
>  
> +	/*
> +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> +	 * platform
> +	 */
> +	platform_adjust_resources(res, cxled, cxlrd, &cxlr->dev);
> +
>  	rc = cxl_extended_linear_cache_resize(cxlr, res);
>  	if (rc && rc != -EOPNOTSUPP) {
>  		/*
> @@ -3702,8 +3723,16 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	mutex_lock(&cxlrd->range_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =
>  		cxl_find_region_by_range(cxlrd, cxled);
> -	if (!cxlr)
> +	if (!cxlr) {
>  		cxlr = construct_region(cxlrd, cxled);
> +	} else {
> +		/*
> +		 * Platform adjustments are done in construct_region()
> +		 * for first target, and here for additional targets.
> +		 */
> +		p = &cxlr->params;
> +		platform_adjust_resources(p->res, cxled, cxlrd, &cxlr->dev);
> +	}>  	mutex_unlock(&cxlrd->range_lock);
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 68b38863605b..2241abbac91f 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -61,6 +61,7 @@ cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>  cxl_core-y += $(CXL_CORE_SRC)/ras.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
> +cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += $(CXL_CORE_SRC)/platform_quirks.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o

