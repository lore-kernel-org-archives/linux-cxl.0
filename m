Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11258344025;
	Tue, 28 Oct 2025 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667105; cv=none; b=orF9jeZnNGJFOrYM0FMM0a3vgF1kn6iHRbx3p9w6o1xM3Q0MGXdbQ4wNjYBplFmyoHMp4GX0r0z8FrJFte22y489Pf5HMVPQjX67oku0pp27iIgYlmDoayzGPfWJm3jtbqznCBPMxbp0QdtIE5vaLXFC6uCDU+Pus1L3sAEwRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667105; c=relaxed/simple;
	bh=lyCYgFwWPJURKsOfRYtiF8tVB5dNes6lcF/XpjiZIcc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJGs/xEE94S6Cms1/pmQBf/i/ZNxRquyY8TGylq6m/hKUhNrbE+BUjWsT7YlMAvfZl9jbqgp8rKIX+53fo7cORY9hUvdzS5Sl8Q9zVJWE939OfptakmKKIFtuhqSDatlwEIKm1bUHYuDgNaNMiLepbTUG7Y2zcEEU3lmsCYi5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cww4S0MQSzHnH4s;
	Tue, 28 Oct 2025 15:57:28 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id DCB4F140157;
	Tue, 28 Oct 2025 23:58:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 15:58:17 +0000
Date: Tue, 28 Oct 2025 15:58:16 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Robert Richter" <rrichter@amd.com>, Cheatham Benjamin
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes
 on x86
Message-ID: <20251028155816.00003161@huawei.com>
In-Reply-To: <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
	<20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon,  6 Oct 2025 17:58:05 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> On a x86 platform with a low memory hole (LHM), the BIOS may publish
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
> [1] commit 7a81173f3 ("cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution")
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
A few minor comments from me.

> diff --git a/drivers/cxl/core/platform_quirks.c b/drivers/cxl/core/platform_quirks.c
> new file mode 100644
> index 000000000000..7e76e392b1ae
> --- /dev/null
> +++ b/drivers/cxl/core/platform_quirks.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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
> +	align = cxled->cxld.interleave_ways * SZ_256M;
> +
> +	if (rd_r->start == LMH_CFMWS_RANGE_START &&
> +	    rd_r->start == sd_r->start && rd_r->end < sd_r->end &&
> +	    rd_r->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
> +	    IS_ALIGNED(range_len(sd_r), align))
> +		return true;
> +
> +	return false;
Similar to below.  Simply returning the boolean statement can be simpler

	return rd_r->start == LMH_CFMWS_RANGE_START &&
	       rd_r->start == sd_r->start &&
	       rd_r->end < sd_r->end &&
	       rd_r->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
	       IS_ALIGNED(range_len(sd_r), align);


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
> +	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
> +	    res->end < r->end && res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
> +	    IS_ALIGNED(range_len(r), align))
> +		return true;

Dave commented on line break up here, but I'd go further.

	return res->start == LMH_CFMWS_RANGE_START &&
	       res->start == r->start &&
	       res->end < r->end &&
	       res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
	       IS_ALIGNED(range_len(r), align);

> +
> +	return false;
> +}

> diff --git a/drivers/cxl/core/platform_quirks.h b/drivers/cxl/core/platform_quirks.h
> new file mode 100644
> index 000000000000..a15592b4e90e
> --- /dev/null
> +++ b/drivers/cxl/core/platform_quirks.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "cxl.h"
> +
> +#ifdef CONFIG_CXL_PLATFORM_QUIRKS
> +bool platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> +				  const struct cxl_endpoint_decoder *cxled);
> +bool platform_region_matches_cxld(const struct cxl_region_params *p,
> +				  const struct cxl_decoder *cxld);
> +void platform_res_adjust(struct resource *res,
> +			 struct cxl_endpoint_decoder *cxled,
> +			 const struct cxl_root_decoder *cxlrd);
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
> +inline void platform_res_adjust(struct resource *res,
static 
> +				struct cxl_endpoint_decoder *cxled,
> +				const struct cxl_root_decoder *cxlrd)
> +{
> +}
> +#endif /* CONFIG_CXL_PLATFORM_QUIRKS */

