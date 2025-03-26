Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494BD19D07A;
	Wed, 26 Mar 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007654; cv=none; b=NytF4Xc7KogIk8RURSJtOrHZYbf77KPQe/uXHCd8BB7Z4y/nCU3hGi4/+srkynNkAxsGPqQPeWd+eqYLYitg8QtmdctNpV95MPuaUwHyLCHG+UDNSrziUi1RjnGQOhp34xGwN3RK6hhXixDw73xf51jpEZJ7kKP/5J6hczGDWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007654; c=relaxed/simple;
	bh=sOSsIyhjI4wpB49/7pxJneBZ/1MLJNlnrsTjQgMFDIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mP+o8zNfUleBGb3hVirrbaarwG6NTHbw49QAgLaRfy7l/eoE99V45ruY3/97vxWqsu8OMewfzowbFT6RZ48eWMVvpho07JVdOvm+EZTzct9l7a73cMwmNO8wA6xm3zkXNmJRB5GmzCjDsIrWl3XtkUn4SY7UfKVUj1+MrFtpxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPv+gsl8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPv+gsl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743007652; x=1774543652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sOSsIyhjI4wpB49/7pxJneBZ/1MLJNlnrsTjQgMFDIw=;
  b=IPv+gsl8XD0FrSz2FqhY6WS1ALSHTgQA0TmRUtN+HXTQbmS3u7/Bpc7u
   /40L1x1QIILGGnTSuE+11RSdbOxVeaD2B1+OKyuUMd2AK09wFpRxhXO3+
   s3suAa+r0ij5NvOntgfgkZ6ihSMAHweHdSHZj7tpsAvUlsNKXlpTGtBT7
   mnJPOWBEMj56U8nI4C1LBtqTAtIK+bVm/HyZkLUKlOuf3brgiSivijSWE
   KbKt0mzkdDrAU9xMgH9K+NqafBC4qYns2/h473AQkapPrPj/75Vo1kKe0
   S4kNtM6oYVix3v8BvGgRzhxex6/IykxQMZX3TBx2Xe1Y4JKUhbqDh1HYW
   A==;
X-CSE-ConnectionGUID: qaswatc5QXWwyLpXEKzheQ==
X-CSE-MsgGUID: fGKXzl0YQZ24AdAKCASQtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44409620"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="44409620"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:47:32 -0700
X-CSE-ConnectionGUID: e+r/9cLJTd++TskeRqsVSA==
X-CSE-MsgGUID: BJVhCgooS7qPH4LzQWC3MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129937683"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.239])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:47:29 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 2/4 v3] cxl/core: Add helpers to detect Low memory Holes on x86
Date: Wed, 26 Mar 2025 17:47:26 +0100
Message-ID: <8700175.W097sEU6C4@fdefranc-mobl3>
In-Reply-To: <Z909uPbvRVlZ_J1Z@rric.localdomain>
References:
 <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
 <Z909uPbvRVlZ_J1Z@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, March 21, 2025 11:21:44=E2=80=AFAM Central European Standard Tim=
e Robert Richter wrote:
> On 14.03.25 12:36:31, Fabio M. De Francesco wrote:
> > In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe
> > SPA ranges which are subsets of the corresponding CXL Endpoint Decoders
> > HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
> > ranges are always guaranteed to align to the NIW * 256M rule.
> >=20
> > In order to construct Regions and attach Decoders, the driver needs to
> > match Root Decoders and Regions with Endpoint Decoders, but it fails and
> > the entire process returns errors because it doesn't expect to deal with
> > SPA range lengths smaller than corresponding HPA's.
> >=20
> > Introduce functions that indirectly detect x86 LMH's by comparing SPA's
> > with corresponding HPA's. They will be used in the process of Regions
> > creation and Endpoint attachments to prevent driver failures in a few
> > steps of the above-mentioned process.
> >=20
> > The helpers return true when HPA/SPA misalignments are detected under
> > specific conditions: both the SPA and HPA ranges must start at
> > LMH_CFMWS_RANGE_START (that in x86 with LMH's is 0x0), SPA range sizes
>=20
> "... that for Intel with LMHs is 0x0", not true for AMD.
>=20
> > be less than HPA's, SPA's range's size be less than 4G, HPA's size be
> > aligned to the NIW * 256M rule.
> >=20
> > Also introduce a function to adjust the range end of the Regions to be
> > created on x86 with LMH's.
> >=20
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/cxl/core/lmh.c | 56 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/lmh.h | 29 ++++++++++++++++++++++
>=20
> The split of the code in patch #2 and #3 does not make sense. The
> "interface" you introduce here is out of context which is patch #3.
> And in patch #3 the functions are actually used, so you need to switch
> back to this one. Other than that, the code is not enabled here at
> all, it is even not built.
>=20
I prefer to split the introduction of helpers and the use of them in
separate patches.
>
> >  2 files changed, 85 insertions(+)
> >  create mode 100644 drivers/cxl/core/lmh.c
> >  create mode 100644 drivers/cxl/core/lmh.h
> >=20
> > diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> > new file mode 100644
> > index 000000000000..2e32f867eb94
> > --- /dev/null
> > +++ b/drivers/cxl/core/lmh.c
> > @@ -0,0 +1,56 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/range.h>
> > +#include "lmh.h"
> > +
> > +/* Start of CFMWS range that end before x86 Low Memory Holes */
> > +#define LMH_CFMWS_RANGE_START 0x0ULL
>=20
> This looks arbitrary. An endpoint decoder's zero base address could
> have other reasons too, e.g. the need of address translation. So you
> need a different check for the mem hole.
>=20
> In my previous review comment I have requested a platform check for
> this code to enable.
>=20
> > +
> > +/*
> > + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA range=
s.
> > + *
> > + * On x86, CFMWS ranges never intersect memory holes while endpoint de=
coders
> > + * HPA range sizes are always guaranteed aligned to NIW * 256MB; there=
fore,
> > + * the given endpoint decoder HPA range size is always expected aligne=
d and
> > + * also larger than that of the matching root decoder. If there are LM=
H's,
> > + * the root decoder range end is always less than SZ_4G.
> > + */
> > +bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
> > +		    const struct cxl_endpoint_decoder *cxled)
> > +{
> > +	const struct range *r1, *r2;
> > +	int niw;
> > +
> > +	r1 =3D &cxlrd->cxlsd.cxld.hpa_range;
> > +	r2 =3D &cxled->cxld.hpa_range;
> > +	niw =3D cxled->cxld.interleave_ways;
> > +
> > +	if (r1->start =3D=3D LMH_CFMWS_RANGE_START && r1->start =3D=3D r2->st=
art &&
> > +	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
>=20
> How about removing LMH_CFMWS_RANGE_START at all? It is zero anyway and
> would make this check much easier.
>
I think that in the next version I'll check that the range start is a multi=
ple=20
of Number of Interleave Ways * 256M (it would include 0x0).
> =20
> Can this being modified to reuse this codes for "holes" other than
> below 4G?
>=20
This series enables CXL Regions creation and Endpoints attach for x86 LOW=20
Memory Holes. I prefer not to enable regions on platforms with memory holes=
=20
beyond 4G until I'm sure it's needed. arch_match_spa() and arch_match_regio=
n()
can be easily modified if in future they need to be.
>
> > +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +/* Similar to arch_match_spa(), it matches regions and decoders */
> > +bool arch_match_region(const struct cxl_region_params *p,
> > +		       const struct cxl_decoder *cxld)
> > +{
> > +	const struct range *r =3D &cxld->hpa_range;
> > +	const struct resource *res =3D p->res;
> > +	int niw =3D cxld->interleave_ways;
> > +
> > +	if (res->start =3D=3D LMH_CFMWS_RANGE_START && res->start =3D=3D r->s=
tart &&
> > +	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
>=20
> Same here.
>=20
> > +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> > +		return true;
> > +
> > +	return false;
> > +}
>=20
> Right now the default check is:
>=20
>   (p->res->start =3D=3D r->start && p->res->end =3D=3D r->end)
>=20
> Can't we just calculate a matching spa range for the decoder and
> region and then check if both match? Both match functions would be
> obsolete then.
>=20
I prefer to keep the design untouched. Anyway, I'll check for other aligned=
=20
res->start, as said above.
>
> > +
> > +void arch_adjust_region_resource(struct resource *res,
> > +				 struct cxl_root_decoder *cxlrd)
> > +{
> > +	res->end =3D cxlrd->res->end;
> > +}
>=20
> This should be squashed with arch_match_spa(): same style and
> interface as for cxl_extended_linear_cache_resize(). Please generalize
> the interface of cxl_extended_linear_cache_resize() first.
>=20
Do you mean that arch_match_spa() should adjust res->end? I don't think
it should.
>
> > diff --git a/drivers/cxl/core/lmh.h b/drivers/cxl/core/lmh.h
> > new file mode 100644
> > index 000000000000..16746ceac1ed
> > --- /dev/null
> > +++ b/drivers/cxl/core/lmh.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#include "cxl.h"
> > +
> > +#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
> > +bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
> > +		    const struct cxl_endpoint_decoder *cxled);
> > +bool arch_match_region(const struct cxl_region_params *p,
> > +		       const struct cxl_decoder *cxld);
> > +void arch_adjust_region_resource(struct resource *res,
> > +				 struct cxl_root_decoder *cxlrd);
> > +#else
> > +static bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> > +			   struct cxl_endpoint_decoder *cxled)
> > +{
> > +	return false;
> > +}
> > +
> > +static bool arch_match_region(struct cxl_region_params *p,
> > +			      struct cxl_decoder *cxld)
> > +{
> > +	return false;
> > +}
> > +
> > +static void arch_adjust_region_resource(struct resource *res,
> > +					struct cxl_root_decoder *cxlrd)
> > +{
> > +}
> > +#endif /* CXL_ARCH_LOW_MEMORY_HOLE */
>=20
> I don't think we will need all this helpers if there are platform
> specific callbacks as suggested in a comment to v1.
>=20
> -Robert
>=20
As said in a reply to 0/4, I'm not yet aware of issues that would interfere
with non Intel x86. Anyway, I'll think a bit more about using platform
specific callbacks, even if currently I don't think they are necessary.=20
>=20
Thanks,

=46abio



