Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42326B742;
	Thu, 21 Aug 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789327; cv=none; b=Yo3ShPSR+Kf1CZdgtM5CEuguRY6k4yoW7hpeE4uOauvP7rb3flE+0ZI+9LUh6otqus5waIiBACkdPb8Cch5ELrUs35gscc291O73gSskoEpfgO7NUnQASM0YALro6ozNlXXcbAu8cx5tJ3twEQ7FzJPNo1xLST8WwEoTFDLWOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789327; c=relaxed/simple;
	bh=oyiSzSw6thyYSPV3B+DgIM8qIrdPRhoZHXZ2GXVNeVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElGwgo2mOG/1RIn/jCE3YMbTkAtlFzG3zUeYkKRrDBGmAYpRlyHULMAdo4AK6wHTw5uXSU4y6G40m5Fmjwn863/cWB6U4JmxrcmOJ6Q+a6JwBrpfxT/jA7V1/Qh4GdhMkaPJnAc0IiDyXAaXTa6Eho35YTFCThXCW9HkFUhHAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJ/TfH5x; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJ/TfH5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755789326; x=1787325326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyiSzSw6thyYSPV3B+DgIM8qIrdPRhoZHXZ2GXVNeVA=;
  b=FJ/TfH5x9sdD3Owk44p31fpW5FzMXJtVbEJ4CtVeyPrIs5I6l/TuByCR
   djiCXRHD450ZWzLamC3QH8aQe0n0PdKmIUDwvzIBugJ+7Or7Zf2EAoqBM
   oR0P6mzDfc2ckdwrBI3KkjuZmobHMAb9ZFIt1aCawz2ksSc8+FVZvVzUo
   xSL0zEeAOkftt8kY7YLYVzE5P24Zu1gy8y1+9CgCMJQ85KWpC9bk5WvUF
   WGr4+MF1036vxiUbozo4DzIBSp/WJ7ShbOm1+6VhIcB3+PwTYzFMBdz7N
   7X9UBE6lKYsU+MbNyMJFzzOClH48Rug358DECIY+/kGA4xaQohjZ+0pf8
   Q==;
X-CSE-ConnectionGUID: S/2Dj3mCQyyW9561sj4cGQ==
X-CSE-MsgGUID: mqwArt1JRCe/3QqwBzWZHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60709799"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="60709799"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:15:25 -0700
X-CSE-ConnectionGUID: yoDi0J40Qni+HeqK0j/9rg==
X-CSE-MsgGUID: aLRRerNkSOCoF0nG1MnK9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="205611338"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:15:20 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] cxl/core: Enable Region creation on x86 with LMH
Date: Thu, 21 Aug 2025 17:15:16 +0200
Message-ID: <2992632.9hSmTKtgW7@fdefranc-mobl3>
In-Reply-To: <7dbbc289-f6be-4a57-aacd-77838b3d27ea@amd.com>
References:
 <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-4-fabio.m.de.francesco@linux.intel.com>
 <7dbbc289-f6be-4a57-aacd-77838b3d27ea@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, August 1, 2025 10:04:18=E2=80=AFPM Central European Summer Time =
Cheatham, Benjamin wrote:
> On 7/24/2025 9:20 AM, Fabio M. De Francesco wrote:
> > The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Ho=
st
> > Physical Address (HPA) windows that are associated with each CXL Host
> > Bridge. Each window represents a contiguous HPA that may be interleaved
> > with one or more targets (CXL v3.1 - 9.18.1.3).
>=20
> Update to 3.2 spec? Sorry I forgot to mention it earlier, but you'll prob=
ably
> want to do this for the whole series.
>=20
Sure, thanks.
> >=20
> > The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> > memory to which systems cannot send transactions. In some cases the size
> > of that hole is not compatible with the CXL hardware decoder constraint
> > that the size is always aligned to 256M * Interleave Ways.
>=20
> Spec ref here.
>=20
Okay.
> >=20
> > On those systems, BIOS publishes CFMWS which communicate the active Sys=
tem
> > Physical Address (SPA) ranges that map to a subset of the Host Physical
> > Address (HPA) ranges. The SPA range trims out the hole, and capacity in
> > the endpoint is lost with no SPA to map to CXL HPA in that hole.
> >=20
> > In the early stages of CXL Regions construction and attach on platforms
> > with Low Memory Holes, cxl_add_to_region() fails and returns an error
> > because it can't find any CXL Window that matches a given CXL Endpoint
> > Decoder.
> >=20
> > Detect a Low Memory Hole by comparing Root Decoders and Endpoint Decode=
rs
> > ranges with the use of arch_match_{spa,region}() helpers.
> >=20
> > Match Root Decoders and CXL Regions with corresponding CXL Endpoint
> > Decoders. Currently a Low Memory Holes would prevent the matching funct=
ions
> > to return true.
> >=20
> > Construct CXL Regions with HPA range's end adjusted to the matching SPA.
> >=20
> > Allow the attach target process to complete by allowing Regions to not
> > fit with alignment constraints (i.e., alignment to NIW * 256M rule).
> >=20
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/cxl/core/region.c | 53 +++++++++++++++++++++++++++++++++------
> >  tools/testing/cxl/Kbuild  |  1 +
> >  2 files changed, 46 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f607e7f97184..b7fdf9c4393d 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/memory-tiers.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> > +#include "platform.h"
> >  #include "core.h"
> > =20
> >  /**
> > @@ -834,6 +835,8 @@ static int match_free_decoder(struct device *dev, c=
onst void *data)
> >  static bool region_res_match_cxl_range(const struct cxl_region_params =
*p,
> >  				       struct range *range)
> >  {
> > +	struct cxl_decoder *cxld;
> > +
> >  	if (!p->res)
> >  		return false;
> > =20
> > @@ -842,8 +845,15 @@ static bool region_res_match_cxl_range(const struc=
t cxl_region_params *p,
> >  	 * to be fronted by the DRAM range in current known implementation.
> >  	 * This assumption will be made until a variant implementation exists.
> >  	 */
> > -	return p->res->start + p->cache_size =3D=3D range->start &&
> > -		p->res->end =3D=3D range->end;
> > +	if (p->res->start + p->cache_size =3D=3D range->start &&
> > +	    p->res->end =3D=3D range->end)
> > +		return true;
> > +
> > +	cxld =3D container_of(range, struct cxl_decoder, hpa_range);
> > +	if (platform_region_contains(p, cxld))
> > +		return true;
> > +
> > +	return false;
>=20
> Can just return result of platform_region_contains() here.
>
Okay.
>=20
> >  }
> > =20
> >  static int match_auto_decoder(struct device *dev, const void *data)
> > @@ -1763,6 +1773,7 @@ static int match_switch_and_ep_decoders(struct de=
vice *dev, const void *data)
> >  {
> >  	const struct cxl_endpoint_decoder *cxled =3D data;
> >  	struct cxl_switch_decoder *cxlsd;
> > +	struct cxl_root_decoder *cxlrd;
> >  	const struct range *r1, *r2;
> > =20
> >  	if (!is_switch_decoder(dev))
> > @@ -1772,8 +1783,13 @@ static int match_switch_and_ep_decoders(struct d=
evice *dev, const void *data)
> >  	r1 =3D &cxlsd->cxld.hpa_range;
> >  	r2 =3D &cxled->cxld.hpa_range;
> > =20
> > -	if (is_root_decoder(dev))
> > -		return range_contains(r1, r2);
> > +	if (is_root_decoder(dev)) {
> > +		if (range_contains(r1, r2))
> > +			return 1;
> > +		cxlrd =3D to_cxl_root_decoder(dev);
> > +		if (platform_root_decoder_contains(cxlrd, cxled))
> > +			return 1;
> > +	}
>=20
> I don't think it's possible, but the way this is written allows falling t=
hrough
> to the return statement below.
>
It's possible. It can happen and it's harmless yet unnecessary.

> This if statement should probably be:=20
>=20
> 	if (is_root_decoder(dev)) {
> 		cxlrd =3D to_cxl_root_decoder(dev);
> 		return range_contains(r1, r2) || platform_root_decoder_contains(cxlrd, =
cxled));
> 	}
>=20
> >  	return (r1->start =3D=3D r2->start && r1->end =3D=3D r2->end);
> >  }
> > =20
And since it's unnecessary, I agree with you and rewrite it.

I just wanted, out of my personal preference, to highlight that calls
of platform_root_decoder_contains() happen only to allow the driver=20
to succeed also on a less common case, that is on platforms with LMH. =20
>
> > @@ -1990,7 +2006,7 @@ static int cxl_region_attach(struct cxl_region *c=
xlr,
> >  	}
> > =20
> >  	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_siz=
e !=3D
> > -	    resource_size(p->res)) {
> > +	    resource_size(p->res) && !platform_root_decoder_contains(cxlrd, c=
xled)) {
> >  		dev_dbg(&cxlr->dev,
> >  			"%s:%s-size-%#llx * ways-%d + cache-%#llx !=3D region-size-%#llx\n",
> >  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > @@ -3230,7 +3246,12 @@ static int match_root_and_ep_decoders(struct dev=
ice *dev, const void *data)
> >  	r1 =3D &cxlrd->cxlsd.cxld.hpa_range;
> >  	r2 =3D &cxled->cxld.hpa_range;
> > =20
> > -	return range_contains(r1, r2);
> > +	if (range_contains(r1, r2))
> > +		return true;
> > +	if (platform_root_decoder_contains(cxlrd, cxled))
> > +		return true;
> > +
> > +	return false;
>=20
> Can just return the || of the two above if statements.
>=20
Sure, as it is going to be with the other function.
> >  }
> > =20
> >  static struct cxl_decoder *
> > @@ -3277,8 +3298,12 @@ static int match_region_and_ep_decoder(struct de=
vice *dev, const void *data)
> >  	p =3D &cxlr->params;
> > =20
> >  	guard(rwsem_read)(&cxl_region_rwsem);
> > -	if (p->res && p->res->start =3D=3D r->start && p->res->end =3D=3D r->=
end)
> > -		return 1;
> > +	if (p->res) {
> > +		if (p->res->start =3D=3D r->start && p->res->end =3D=3D r->end)
> > +			return 1;
> > +		if (platform_region_contains(p, &cxled->cxld))
> > +			return 1;
> > +	}
>=20
> Same thing here.
>=20
> > =20
> >  	return 0;
> >  }
> > @@ -3355,6 +3380,12 @@ static int __construct_region(struct cxl_region =
*cxlr,
> >  	*res =3D DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> >  				    dev_name(&cxlr->dev));
> > =20
> > +	/*
> > +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> > +	 * platform
> > +	 */
> > +	platform_res_adjust(res, cxled, cxlrd);
> > +
> >  	rc =3D cxl_extended_linear_cache_resize(cxlr, res);
> >  	if (rc && rc !=3D -EOPNOTSUPP) {
> >  		/*
> > @@ -3464,6 +3495,12 @@ int cxl_add_to_region(struct cxl_endpoint_decode=
r *cxled)
> >  		cxl_find_region_by_range(cxlrd, cxled);
> >  	if (!cxlr)
> >  		cxlr =3D construct_region(cxlrd, cxled);
> > +	else
> > +		/*
> > +		 * Adjust the Endpoint Decoder's dpa_res to fit the Region which
> > +		 * it has to be attached to
> > +		 */
> > +		platform_res_adjust(NULL, cxled, cxlrd);
>=20
> I'm 50/50 on whether these comments are unnecessary. The routine is prett=
y well documented
> and also has an explanatory comment above the definition in platform.c. I=
 think you
> can probably remove them, but I'll defer to your/someone else's judgement=
 here.
>=20
I'll think about it. Anyway, I wanted to clarify that the two call sites=20
serve two different purposes (i.e., for already constructed regions we may=
=20
still need to adjust dpa_res).

Thanks,

=46abio
>
> Thanks,
> Ben
>=20





