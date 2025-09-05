Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5992DAFDF;
	Fri,  5 Sep 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110391; cv=none; b=RnCzbBkPrsqGr7J0ixK7Dveiy3zH2uXnK6npSacAvmaiSPHLxLMh0t0D2pI+kBCPaquVY13la+gkSW6gv/SBK2K5Rb3UCiQUPvuBS2CDO5ufBrN9fL5Lkxa7VUwUVVy0HfbD5N/x/21PSICleZkDQFsAvDMF1tgf3u9di/JroVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110391; c=relaxed/simple;
	bh=FbY/ngI099/RA78SjVi5datkLo/8Bi5j0CBNn+P3fgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MP+AieI471vPIrWNqwdeM4pmCPxTFA23Ymuudo2RoMdWedDuqMqZaUiLwRzcUME8qbNrdY9lQ3cFWcDoNJoT+ag8aFbB1bOwuaw/w9Ze4nWLzMCYbcQYXvjwxnHHhCChMU+liPmm9f3TBeX5Mg/C+9pTC3xVmWcX5VzMxjtNQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wv3LjOBD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wv3LjOBD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757110389; x=1788646389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FbY/ngI099/RA78SjVi5datkLo/8Bi5j0CBNn+P3fgA=;
  b=Wv3LjOBDNlA8g9b/jQ6gdLz4hz2xiV1zCjVKelSHf/nSbWkT8IQ+B1eR
   jNcPFmCKrVTDtNHNirnzISuhfL+cjIc0/PnYhIIHcrLQXHT1HD5y9srpl
   9shHYmAnBqUyJIWM9+iZrKkUVRrJRKQZpN7LtSc4jXOqhO55epzH8HG40
   dra8jskkJTZ69c7RPOUREDNkEyIEViZVoQ7OOf44CdmtsDrBHHUvdJy4E
   ECos2rSLWH/CZF1EUAHCRD3Gb+fNkEGPw3DTAMj3+Zo7m0djq/EDjymgS
   zp4w3Gihi/UNKSER8jT2YzxbaWR1C7umpgaFeqBkA+RiyVH0KWqn52jog
   w==;
X-CSE-ConnectionGUID: UbKftvOKRSWDsTJyttMUkg==
X-CSE-MsgGUID: VlBHCU3ESBi4J82llO6mWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="58501913"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="58501913"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 15:13:08 -0700
X-CSE-ConnectionGUID: R0hNNTmNRvm+s5dXsWeyUA==
X-CSE-MsgGUID: vove2p5PTfeR3CXBlswYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="171458641"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.110.53]) ([10.125.110.53])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 15:13:07 -0700
Message-ID: <7c11a5d6-0d4e-484f-827c-a93d0b8b0fb4@intel.com>
Date: Fri, 5 Sep 2025 15:13:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4 v4] cxl/core: Add helpers to detect Low Memory Holes
 on x86
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-3-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250724142144.776992-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/25 7:20 AM, Fabio M. De Francesco wrote:

s/Holes/Hole/ for subject. Only 1 right?

> In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe
> SPA ranges which are subsets of the corresponding CXL Endpoint Decoders> HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
> ranges are always guaranteed to align to the NIW * 256M rule.

On a x86 platform with a low memory hole (LHM), the BIOS may publish CFMWS that describes
SPA ranges. The SPA ranges are subsets of the corresponding CXL endpoint decoder's
HPA ranges because the CFMWS never intersects the LHM while the endpoint decoder's HPA
ranges are always guaranteed to align to the "NIW * 256M" rule.


> 
> In order to construct Regions and attach Decoders, the driver needs to
> match Root Decoders and Regions with Endpoint Decoders, but it fails and> the entire process returns errors because it doesn't expect to deal with
> SPA range lengths smaller than corresponding HPA's.

To construct regions and attach decoders, the driver needs to match root
decoders and regions with endpoint decoders. The process fails and returns
errors because it isn't expected to deal with SPA range smaller than the
corresponding HPA range.

> 
> Introduce functions that indirectly detect x86 LMH's by comparing SPA's

s/LMH's/LMH/
s/SPA/SPA range/

> with corresponding HPA's. They will be used in the process of Regions
s/HPA's/HPA range/
s/Regions/region/

> creation and Endpoint attachments to prevent driver failures in a few

s/Endpoint/endpoints/

> steps of the above-mentioned process.

s/above-mentioned process/the process mentioned above/

> 
> The helpers return true when HPA/SPA misalignments are detected under
> specific conditions: both the SPA and HPA ranges must start at
> LMH_CFMWS_RANGE_START (that in x86 with LMH's is 0x0), SPA range sizes
> be less than HPA's, SPA's range's size be less than 4G, HPA's size be
> aligned to the NIW * 256M rule.

I would make it clearer to read by listing them:
1. ....
2. ....

> 
> Also introduce a function to adjust the range end of the Regions to be

s/Regions/region/ singular right?

> created on x86 with LMH's.

s/LMH's/LMH/

> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/Kconfig         |  5 +++
>  drivers/cxl/core/Makefile   |  1 +
>  drivers/cxl/core/platform.c | 85 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/platform.h | 32 ++++++++++++++
>  4 files changed, 123 insertions(+)
>  create mode 100644 drivers/cxl/core/platform.c
>  create mode 100644 drivers/cxl/core/platform.h
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..eca90baeac10 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -211,6 +211,11 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +config CXL_PLATFORM_QUIRKS
> +	def_bool y
> +	depends on CXL_REGION
> +	depends on X86
> +
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..4be729fb7d64 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -18,6 +18,7 @@ cxl_core-y += ras.o
>  cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += platform.o

Given that you are creating a quirk, make the object obvious it's a quirk.

platform_quirks.o

>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> diff --git a/drivers/cxl/core/platform.c b/drivers/cxl/core/platform.c
> new file mode 100644
> index 000000000000..8202750742d0
> --- /dev/null
> +++ b/drivers/cxl/core/platform.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/range.h>
> +#include "platform.h"
> +#include "cxlmem.h"
> +#include "core.h"
> +
> +/* Start of CFMWS range that end before x86 Low Memory Holes */
> +#define LMH_CFMWS_RANGE_START 0x0ULL
> +
> +/*
> + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
> + *
> + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
> + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
> + * the given endpoint decoder HPA range size is always expected aligned and
> + * also larger than that of the matching root decoder. If there are LMH's,
> + * the root decoder range end is always less than SZ_4G.
> + */
> +bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +				    const struct cxl_endpoint_decoder *cxled)
> +{
> +	const struct range *r1, *r2;
> +	int niw;
> +
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;

I would name it rd_r and ed_r so it's easier to remember which is which below when you do compare below.

> +	niw = cxled->cxld.interleave_ways;

Just make this 'align', and you can just do:
	align = cxled->cxld.interleave_ways * SZ_256M;
That way it's cleaner below when you do compare.

> +
> +	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&

May as well make it 'r2->start == LMH_CFMWS_RANGE_START'?

> +	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
> +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> +		return true;

Maybe have 1 conditional per line to make it easier to read since this is a big one

> +
> +	return false;
> +}
> +
> +/*
> + * Similar to platform_root_decoder_contains(), it matches regions and
> + * decoders
> + */
> +bool platform_region_contains(const struct cxl_region_params *p,
> +			      const struct cxl_decoder *cxld)
> +{
> +	const struct range *r = &cxld->hpa_range;
> +	const struct resource *res = p->res;
> +	int niw = cxld->interleave_ways;
> +
> +	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
> +	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
> +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> +		return true;

similar comments as the previous function

> +
> +	return false;
> +}
> +
> +void platform_res_adjust(struct resource *res,
> +			 struct cxl_endpoint_decoder *cxled,
> +			 const struct cxl_root_decoder *cxlrd)
> +{
> +	if (!platform_root_decoder_contains(cxlrd, cxled))
> +		return;
> +
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	dev_info(cxled_to_memdev(cxled)->dev.parent,
> +		 "(LMH) Resources were (%s: %pr, %pr)\n",
> +		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
> +	if (res) {

Do you ever expect a scenario where the 'res' passed in is NULL?

> +		/*
> +		 * A region must be constructed with Endpoint Decoder's
> +		 * HPA range end adjusted to Root Decoder's resource end
> +		 */
> +		res->end = cxlrd->res->end;
> +	}
> +	/*
> +	 * The Endpoint Decoder's dpa_res->end must be adjusted with Root
> +	 * Decoder's resource end
> +	 */
> +	cxled->dpa_res->end =
> +		cxled->dpa_res->start +
> +		resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;
> +	dev_info(cxled_to_memdev(cxled)->dev.parent,
> +		 "(LMH) Resources have been adjusted (%s: %pr, %pr)\n",
> +		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);

If the res passed in is ever NULL, this line would crash when accessing res here.

> +}
> diff --git a/drivers/cxl/core/platform.h b/drivers/cxl/core/platform.h
> new file mode 100644
> index 000000000000..0baa39938729
> --- /dev/null
> +++ b/drivers/cxl/core/platform.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "cxl.h"
> +
> +#ifdef CONFIG_CXL_PLATFORM_QUIRKS
> +bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +				    const struct cxl_endpoint_decoder *cxled);
> +bool platform_region_contains(const struct cxl_region_params *p,
> +			      const struct cxl_decoder *cxld);
> +void platform_res_adjust(struct resource *res,
> +			 struct cxl_endpoint_decoder *cxled,
> +			 const struct cxl_root_decoder *cxlrd);
> +#else
> +static bool
> +platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +			       const struct cxl_endpoint_decoder *cxled)
> +{
> +	return false;
> +}
> +
> +static bool platform_region_contains(const struct cxl_region_params *p,
> +				     const struct cxl_decoder *cxld)
> +{
> +	return false;
> +}
> +
> +void platform_res_adjust(struct resource *res,
> +			 struct cxl_endpoint_decoder *cxled,
> +			 const struct cxl_root_decoder *cxlrd)
> +{
> +}

these need inline

> +#endif /* CONFIG_CXL_PLATFORM_QUIRKS */

