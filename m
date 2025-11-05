Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C6225408;
	Wed,  5 Nov 2025 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365785; cv=none; b=ETOXbJy1o8BuKD/llByJHq14G0SaH4p5RiCNZaDpNA/7CyVI52zO7MR67acZUXiAj6IK0R9VgqDDk10+gELjjamAmEFJHxrVkPMmVH9eiWNHg4A/i6u0lmqs4NYnTgoS0Iwdk/tPTOj9omHTZ5VB+PED+xkTllpeDBZJQHhRi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365785; c=relaxed/simple;
	bh=neSGDU255RNQS5Ebldb9NMJGcXmLZPRkci4Eeusewo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPFETjovxB1270UDCrrvK+1vgpv264ZkcekW23fSzS/JXhdFfi6DXp+RKVgbC/nrKi5lhX1pzMorgFuy91fZ/eT3Tcc0dO05QsvLijLYDlJfLS4By860MadM3sD4JovJqW+7Ze8Rg3k+9DpTtOR9BFoXkjj6q7kzPTyyBmPZUHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtg+HGYO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtg+HGYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762365784; x=1793901784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=neSGDU255RNQS5Ebldb9NMJGcXmLZPRkci4Eeusewo0=;
  b=mtg+HGYO9+KykXmFgPFHgIyXVmq+zmp9wHa5H76BpxPmPRqZ5S0GDTE4
   Tl1kQFGA/VawW54ZSp0tvOwbRWgIn9MrSjnHmQmkTvvmtVrR9pDTrKJv6
   4APtwdeVQBrDx0IkzLH+X2BKJOLj12mKGUsHL1AWSqzEJDm8a/04NkU8y
   DPEG3oZjtqnDEIPzPDwEoHLrgGw2zIBO1K9QVC+/CGb5At41lFI7tL6/x
   GjBGmaK+ovaUBzqL333Jy9ZHNyiuCfXXmiJm/ky9dirkEUnLawymWhJnx
   u+l3I+aqY9yyi62mpnKPKQZgmT2+1XycXxl2Ktn+r92L+uTqGSQ0gdHkG
   w==;
X-CSE-ConnectionGUID: zUfXrs/XS420pcKdCeerPg==
X-CSE-MsgGUID: gcCUGamTQgGFI0wFVC/Ycg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68348848"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="68348848"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:03:03 -0800
X-CSE-ConnectionGUID: NVqcURMnRxu5KGTce+GcGg==
X-CSE-MsgGUID: 42FW5LohTNai3JYkRmHRKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187189515"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.26])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:02:58 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 Robert Richter <rrichter@amd.com>,
 Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject:
 Re: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes on x86
Date: Wed, 05 Nov 2025 19:02:55 +0100
Message-ID: <13188657.hb0ThOEGa2@fdefranc-mobl3>
In-Reply-To: <aOco9dzjzcWJBNYh@aschofie-mobl2.lan>
References:
 <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
 <aOco9dzjzcWJBNYh@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, October 9, 2025 5:16:05=E2=80=AFAM Central European Standard T=
ime Alison Schofield wrote:
> On Mon, Oct 06, 2025 at 05:58:05PM +0200, Fabio M. De Francesco wrote:
> > On a x86 platform with a low memory hole (LHM), the BIOS may publish
> > CFMWS that describes a system physical address (SPA) range that
> > typically is only a subset of the corresponding CXL intermediate switch
> > and endpoint decoder's host physical address (HPA) ranges. The CFMWS
> > range never intersects the LHM and so the driver instantiates a root
> > decoder whose HPA range size doesn't fully contain the matching switch
> > and endpoint decoders' HPA ranges.[1]
> >=20
> > To construct regions and attach decoders, the driver needs to match root
> > decoders and regions with endpoint decoders. The process fails and
> > returns errors because the driver is not designed to deal with SPA
> > ranges which are smaller than the corresponding hardware decoders HPA
> > ranges.
> >=20
> > Introduce two functions that indirectly detect the presence of x86 LMH
> > and allow the matching between a root decoder or an already constructed
> > region with a corresponding intermediate switch or endpoint decoder to
> > enable the construction of a region and the subsequent attachment of the
> > same decoders to that region.
> >=20
> > These functions return true when SPA/HPA misalignments due to LMH's are
> > detected under specific conditions:
> >=20
> > - Both the SPA and HPA ranges must start at LMH_CFMWS_RANGE_START (i.e.,
> >   0x0 on x86 with LMH's).
> > - The SPA range's size is less than HPA's.
> > - The SPA range's size is less than 4G.
> > - The HPA range's size is aligned to the NIW * 256M rule.
> >=20
> > Also introduce a function that adjusts the range end of a region to be
> > constructed and the DPA range's end of the endpoint decoders that will
> > be later attached to that region.
>=20
> Hi Fabio,
>=20
> Your getting some fresh eyes on some of this with my review.
> The adjustment of resources is what caught my eye, and I looked at
> platform_res_adjust() in this patch and it's usage in the next patch.
>=20
Hi Alison,

Thanks for looking at this version with fresh eyes.=20

As always, your reviews catch details that others miss and go well beyond=20
what's typical - providing working code and demonstrating the results is=20
very helpful.
> >=20
> > [1] commit 7a81173f3 ("cxl: Documentation/driver-api/cxl: Describe the =
x86 Low Memory Hole solution")
> >=20
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/cxl/Kconfig                |  4 ++
> >  drivers/cxl/core/Makefile          |  1 +
> >  drivers/cxl/core/platform_quirks.c | 99 ++++++++++++++++++++++++++++++
> >  drivers/cxl/core/platform_quirks.h | 33 ++++++++++
> >  4 files changed, 137 insertions(+)
> >  create mode 100644 drivers/cxl/core/platform_quirks.c
> >  create mode 100644 drivers/cxl/core/platform_quirks.h
> >=20
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 48b7314afdb8..03c0583bc9a3 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -211,6 +211,10 @@ config CXL_REGION
> > =20
> >  	  If unsure say 'y'
> > =20
> > +config CXL_PLATFORM_QUIRKS
> > +	def_bool y
> > +	depends on CXL_REGION
> > +
>=20
> Why no help text for the new CONFIG option?
>
Good catch. Below I'll show you the help text I'm thinking to add. =20
>
> That text will probably answer my next question: why do we have the
> option?
>
=46or now, PLATFORM_QUIRKS enables only region creation and endpoint
attachment support on x86 with LMH. In the future, it's intended to be
selected by other platforms that need quirks.[1]

I think we should allow users to choose whether to enable it - they can
leave it disabled, or select it if they know it's needed or are unsure
about potential platform issues. The overhead from running quirks should
be minimal.

All that said, how about this?

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 03c0583bc9a3..5ab8d5c23187 100644
=2D-- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -212,8 +212,15 @@ config CXL_REGION
          If unsure say 'y'
=20
 config CXL_PLATFORM_QUIRKS
=2D       def_bool y
+       bool "CXL: Region Platform Quirks"
        depends on CXL_REGION
+       help
+         Enable support for the following platform quirks:
+
+               - Region creation / Endpoint Decoders attach in x86 with Low
+                 Memory Holes (Documentation/driver-api/cxl/conventions.rs=
t).
+
+         If unsure say 'y'
=20
 config CXL_REGION_INVALIDATION_TEST
        bool "CXL: Region Cache Management Bypass (TEST)"

>=20
> I have comments for the callsites of platform_res_adjust() in the next
> patch, but I'll pull some of that back into this patch to keep it all
> in one, more logical, place.
>=20
> There are 2 callsites, and one passes in NULL for 'res' because
> at that site we know that the regions struct res has been adjusted.
> I felt that was subtle, and that it may be better to just pass in
> the 'res' all the time and let the function adjust if needed,
> ignore if not needed.
>
I'll implement your suggestion in v6.
> =20
> The name platform_res_adjust() suggested that the 'res' as in the
> region 'res' was getting adjusted. This is adjusting multiple resources
> - the region resource and the endpoint decoder dpa resource. If it's
> meant to be kind of opaque, that's ok, but by using _res_ it sure sounds
> like it's adjusting the the region resource (when viewed from the call si=
te).
>=20
> I might have done this in 2 helpers for crispness:
> res =3D platform_adjust_region_resource()
> cxled =3D platform_adjust_endpoint_decoder()
>=20
> Then you could adjust the region resource once when the region
> is constructed, and the endpoint regions every time in=20
> cxl_add_to_region().
>=20
> If you are settled with one adjust routine, perhaps just a=20
> rename to platform_adjust_resources() will make it sound as
> broad as it is.
>
I prefer not to introduce more than one platform_adjust_*(), so I'll rename=
=20
platform_res_adjust() to platform_adjust_resources().
>=20
> > +void platform_res_adjust(struct resource *res,
> > +			 struct cxl_endpoint_decoder *cxled,
> > +			 const struct cxl_root_decoder *cxlrd)
> > +{
> > +	if (!platform_cxlrd_matches_cxled(cxlrd, cxled))
> > +		return;
> > +
> > +	guard(rwsem_write)(&cxl_rwsem.dpa);
> > +	dev_dbg(cxled_to_memdev(cxled)->dev.parent,
> > +		"Low Memory Hole detected. Resources were (%s: %pr, %pr)\n",
> > +		dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
> > +	if (res) {
> > +		/* Trim region resource overlap with LMH */
> > +		res->end =3D cxlrd->res->end;
> > +	}
>=20
> Prefer dev_info so always appears.
> Prefer to see the region name.
>
Okay to both suggestions.
>
> I'm guessing the dev_dbg() above and the dev_info() below are written
> with the idea that we want the before view only in dev_dbg() and the
> after view only in dev_info().
>=20
> Looks like this now:
> [] cxl_core:platform_res_adjust:90: cxl_mock_mem cxl_mem.0: Low Memory Ho=
le detected. Resources were (decoder12.0: [mem 0x3ff010000000-0x3ff04ffffff=
f flags 0x200], [mem 0x00000000-0x1fffffff flags 0x80000200])
> [] cxl_mock_mem cxl_mem.0: Resources have been adjusted for LMH (decoder1=
2.0: [mem 0x3ff010000000-0x3ff03fffffff flags 0x200], [mem 0x00000000-0x17f=
fffff flags 0x80000200])
> [] cxl_core:platform_res_adjust:90: cxl_mock_mem cxl_mem.4: Low Memory Ho=
le detected. Resources were (decoder13.0: (null), [mem 0x00000000-0x1ffffff=
f flags 0x80000200])
> [] cxl_mock_mem cxl_mem.4: Resources have been adjusted for LMH (decoder1=
3.0: (null), [mem 0x00000000-0x17ffffff flags 0x80000200])
>=20
> I'll suggest this to emit explicitly what is changing:
> [] cxl region0: LMH Low memory hole trims region resource [mem 0x3ff01000=
0000-0x3ff04fffffff flags 0x200] to [mem 0x3ff010000000-0x3ff03fffffff flag=
s 0x200])
> [] cxl decoder13.0: LMH Low memory hole trims DPA resource [mem 0x0000000=
0-0x1fffffff flags 0x80000200] to [mem 0x00000000-0x17ffffff flags 0x800002=
00])
> [] cxl decoder17.0: LMH Low memory hole trims DPA resource [mem 0x0000000=
0-0x1fffffff flags 0x80000200] to [mem 0x00000000-0x17ffffff flags 0x800002=
00])
>
I'll make platform_adjust_resources() output the messages you just showed.=
=20
>=20
> > +	/* Match endpoint decoder's DPA resource to root decoder's */
> A 'Match' would be if the the endpoint and root decoder resource were
> same. This is more of adjustment or recalculation of the DPA length.
>=20
> > +	cxled->dpa_res->end =3D
> > +		cxled->dpa_res->start +
> > +		resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;
>=20
> I'm cautious about the use of division and suggest this as the more
> bullet-proof kernel style:
>=20
> 	slice =3D div_u64(resource_size(cxlrd->res), cxled->cxld.interleave_ways=
);
> 	cxled->dpa_res->end =3D cxled->dpa_res->start + slice - 1;
>=20
div_u64() is the safer choice. =20
>=20
> > +	dev_info(cxled_to_memdev(cxled)->dev.parent,
> > +		 "Resources have been adjusted for LMH (%s: %pr, %pr)\n",
> > +		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
> > +}
>=20
> Here's the diff showing how I emmited the that messaging above. I really
> wanted to have that region name to emit. This was done keeping the
> adjust in one function, but maybe you'll choose to split :)
>
Thank you,

=46abio

[1] https://lore.kernel.org/linux-cxl/67ee07cd4f8ec_1c2c6294d5@dwillia2-xfh=
=2Ejf.intel.com.notmuch/
>=20
> ---
>  drivers/cxl/core/platform_quirks.c | 32 ++++++++++++++++++------------
>  drivers/cxl/core/platform_quirks.h |  6 ++++--
>  drivers/cxl/core/region.c          | 15 ++++++++------
>  3 files changed, 32 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/cxl/core/platform_quirks.c b/drivers/cxl/core/platfo=
rm_quirks.c
> index aecd376f2766..aa25770c088a 100644
> --- a/drivers/cxl/core/platform_quirks.c
> +++ b/drivers/cxl/core/platform_quirks.c
> @@ -81,24 +81,30 @@ EXPORT_SYMBOL_NS_GPL(__platform_region_matches_cxld, =
"CXL");
> =20
>  void platform_res_adjust(struct resource *res,
>  			 struct cxl_endpoint_decoder *cxled,
> -			 const struct cxl_root_decoder *cxlrd)
> +			 const struct cxl_root_decoder *cxlrd,
> +			 const struct device *region_dev)
>  {
> +	struct resource dpa_res_orig =3D *cxled->dpa_res;
> +	u64 slice;
> +
>  	if (!platform_cxlrd_matches_cxled(cxlrd, cxled))
>  		return;
> =20
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	dev_dbg(cxled_to_memdev(cxled)->dev.parent,
> -		"Low Memory Hole detected. Resources were (%s: %pr, %pr)\n",
> -		dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
> -	if (res) {
> -		/* Trim region resource overlap with LMH */
> +
> +	/* Region resource will need a trim at first endpoint attach only */
> +	if ((res) && (res->end !=3D cxlrd->res->end)) {
> +		dev_info(region_dev,
> +			 "LMH Low memory hole trims region resource %pr to %pr)\n",
> +			 res, cxlrd->res);
>  		res->end =3D cxlrd->res->end;
>  	}
> -	/* Match endpoint decoder's DPA resource to root decoder's */
> -	cxled->dpa_res->end =3D
> -		cxled->dpa_res->start +
> -		resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;
> -	dev_info(cxled_to_memdev(cxled)->dev.parent,
> -		 "Resources have been adjusted for LMH (%s: %pr, %pr)\n",
> -		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
> +
> +	/* Adjust the endpoint decoder DPA resource end */
> +	slice =3D div_u64(resource_size(cxlrd->res), cxled->cxld.interleave_way=
s);
> +	cxled->dpa_res->end =3D cxled->dpa_res->start + slice - 1;
> +
> +	dev_info(&cxled->cxld.dev,
> +		 "LMH Low memory hole trims DPA resource %pr to %pr)\n",
> +		 &dpa_res_orig, cxled->dpa_res);
>  }
> diff --git a/drivers/cxl/core/platform_quirks.h b/drivers/cxl/core/platfo=
rm_quirks.h
> index bdea00365dad..55647711cdb4 100644
> --- a/drivers/cxl/core/platform_quirks.h
> +++ b/drivers/cxl/core/platform_quirks.h
> @@ -17,7 +17,8 @@ bool __platform_region_matches_cxld(const struct cxl_re=
gion_params *p,
>  				    const struct cxl_decoder *cxld);
>  void platform_res_adjust(struct resource *res,
>  			 struct cxl_endpoint_decoder *cxled,
> -			 const struct cxl_root_decoder *cxlrd);
> +			 const struct cxl_root_decoder *cxlrd,
> +			 const struct device *region_dev);
>  #else
>  static inline bool
>  platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
> @@ -35,7 +36,8 @@ platform_region_matches_cxld(const struct cxl_region_pa=
rams *p,
> =20
>  inline void platform_res_adjust(struct resource *res,
>  				struct cxl_endpoint_decoder *cxled,
> -				const struct cxl_root_decoder *cxlrd)
> +				const struct cxl_root_decoder *cxlrd,
> +				const struct device *region_dev);
>  {
>  }
>  #endif /* CONFIG_CXL_PLATFORM_QUIRKS */
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9a499bfca23d..d4298a61b912 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3502,7 +3502,7 @@ static int __construct_region(struct cxl_region *cx=
lr,
>  	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
>  	 * platform
>  	 */
> -	platform_res_adjust(res, cxled, cxlrd);
> +	platform_res_adjust(res, cxled, cxlrd, &cxlr->dev);
> =20
>  	rc =3D cxl_extended_linear_cache_resize(cxlr, res);
>  	if (rc && rc !=3D -EOPNOTSUPP) {
> @@ -3611,14 +3611,17 @@ int cxl_add_to_region(struct cxl_endpoint_decoder=
 *cxled)
>  	mutex_lock(&cxlrd->range_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =3D
>  		cxl_find_region_by_range(cxlrd, cxled);
> -	if (!cxlr)
> +	if (!cxlr) {
>  		cxlr =3D construct_region(cxlrd, cxled);
> -	else
> +	} else {
>  		/*
> -		 * Adjust the Endpoint Decoder's dpa_res to fit the Region which
> -		 * it has to be attached to
> +		 * Platform adjustments are done in construct_region()
> +		 * for first target, and here for additional targets.
>  		 */
> -		platform_res_adjust(NULL, cxled, cxlrd);
> +		p =3D &cxlr->params;
> +		platform_res_adjust(p->res, cxled, cxlrd, &cxlr->dev);
> +	}
> +
>  	mutex_unlock(&cxlrd->range_lock);
> =20
>  	rc =3D PTR_ERR_OR_ZERO(cxlr);
> --=20
> 2.37.3
>=20
> >=20
>=20




