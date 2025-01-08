Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C842AA6;
	Wed,  8 Jan 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347726; cv=none; b=Ux6Y5yMYuWpoQmALNBMmwJwaboxLRYhhNzQvbDVWcNv+mkQyoArDF2TNOJSsl0c8abACnBQsYGQkqVndW+7Ifdo1tLUNs1iVBBvkHDUJFj+vdeldto2ClLKbXtmhuBR+N9f5TqLqZ9taYQvzXbHK75QoNYYtsstwUDrCM1RM1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347726; c=relaxed/simple;
	bh=fNNdrY0DJUMXu+yiklhrjGlOXzw1VOIxrG4yjBdrdOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9/Ymvae0QdXl6P+SYtTdKFTlhan8c7nrlfJuwjJ9R37eyq8LlYa9rrFU9GMDSCKzDWstMX1uRzp/Ozb6I5p5qbZBrmWjc1M30mXh7+OhGYCWcJ/hZ9RSFwmIDTESZ05DzBboPOn9H53U4xmpwGoz0tyVLs3Bow64TQI3VDbSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cL+lHmrC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cL+lHmrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736347724; x=1767883724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fNNdrY0DJUMXu+yiklhrjGlOXzw1VOIxrG4yjBdrdOE=;
  b=cL+lHmrC03gxvQrA5MrH7CeAw1GGy2AsmghKqlsZD3Icki87Ezx+Wm7B
   62sYy7fwbxXEDC+mi74gd+KMbsF+cPV6sIcVoevh0oAF5C1CILtxRoz9B
   ww2gq3LyzLtTp2hVcJ1GFhGOTWUMBx6EzEJ+D0WxC3lKrRy1yUs2lzdR1
   KxcPw5Mwa0btRrh+K/RreeE5vzDwmcUmTnjtqH/qkd41kwebYeNIatBfI
   O4KtJVA5d8IWfn38BVlAQtJKMYlLhCLGnNq/fo5KvQJeLDRgLMRH6/Rkx
   mN0R3h+L+3JU59HS6llHSSi3ugDpSuvKKH3djr0It5EvX1bO1g3Cud9qk
   g==;
X-CSE-ConnectionGUID: Ny1vWg5VRXCGEGkoe2zbQA==
X-CSE-MsgGUID: wvjtRQvtSo+/QLcGRx0F6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36796582"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="36796582"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 06:48:43 -0800
X-CSE-ConnectionGUID: QNCN1RBMQw+JpRntXBuVMw==
X-CSE-MsgGUID: uytxyBlaT86yiE9iWMPbAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107150499"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.245.138])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 06:48:38 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, linux-cxl@vger.kernel.org,
 Li Ming <ming4.li@outlook.com>
Subject:
 Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low Memory Hole
Date: Wed, 08 Jan 2025 15:48:34 +0100
Message-ID: <9930375.eNJFYEL58v@fdefranc-mobl3>
In-Reply-To: <Z2Cb4wZRk3bihXfr@rric.localdomain>
References:
 <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
 <Z2Cb4wZRk3bihXfr@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Robert,

On Monday, December 16, 2024 10:30:11=E2=80=AFPM GMT+1 Robert Richter wrote:
> Hi Fabio,
>=20
> On 22.11.24 16:51:53, Fabio M. De Francesco wrote:
> > The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Ho=
st
> > Physical Address (HPA) windows that are associated with each CXL Host
> > Bridge. Each window represents a contiguous HPA that may be interleaved
> > with one or more targets (CXL v3.1 - 9.18.1.3).
> >=20
> > The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> > memory to which systems cannot send transactions. In some cases the size
> > of that hole is not compatible with the CXL hardware decoder constraint
> > that the size is always aligned to 256M * Interleave Ways.
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
> > Detect Low Memory Holes by comparing Root Decoders and Endpoint Decoders
> > ranges: both must start at physical address 0 and end below 4 GB, while
> > the Root Decoder ranges end at lower addresses than the matching Endpoi=
nt
> > Decoders which instead must always respect the above-mentioned CXL hard=
ware
> > decoders HPA alignment constraint.
> >=20
> > Match misaligned CFMWS and CXL Regions with corresponding CXL Endpoint
> > Decoders if driver detects Low Memory Holes.
> >=20
> > Construct CXL Regions with HPA range's end trimmed by matching SPA.
> >=20
> > Allow the attach target process to complete by relaxing Decoder constra=
ints
> > which would lead to failures.
>=20
> I am implementing an address translation series and will post the
> patches in a couple of days. It solves a similar problem to remap
> (zero-based) endpoint address ranges to a different SPA range. I
> implemented a generic approach that can easily be reused here. With
> only a few changes to your series it could be integrated there (I
> could rebase my code onto your's then in a later version of my
> series).
>=20
> The change I suggest to your series will also significantly simplify
> your code and the function interface. The general idea is to have a
> .spa_range attribute in struct cxl_endpoint_decoder:
>=20
> @@ -428,6 +428,7 @@ struct cxl_endpoint_decoder {
>         struct cxl_decoder cxld;
>         struct cxl_root_decoder *cxlrd;
>         struct resource *dpa_res;
> +       struct range spa_range;
>         resource_size_t skip;
>         enum cxl_decoder_mode mode;
>         enum cxl_decoder_state state;
>=20
> Now, then an endpoint is detected, the spa_range is assigned,
> typically this is cxled->spa_range =3D cxled->cxld.hpa_range (SPA =3D=3D
> HPA). Whenever a port is added, a function cxl_port_platform_setup()
> is called which could also contain a call to
> cxl_port_setup_intel_lmh() or so.
>=20
> @@ -865,6 +870,8 @@ static int cxl_port_add(struct cxl_port *port,
>                         return rc;
>         }
> =20
> +       cxl_port_platform_setup(port);
> +
>         rc =3D device_add(dev);
>         if (rc)
>                 return rc;
>=20
> cxl_port_setup_intel_lmh() does all the platform checks and
> recalculates the spa_range for the endpoints based on the code you
> already have.=20
>
> The endpoint's SPA address range (instead of hpa_range)
> is now used to construct the region by changing
> match_region_by_range() accordingly. This avoids the instrumentation
> of all the other checks you needed to add in this patch (use of
> arch_match_region() and arch_match_spa() etc.).
>=20
> The only function that needs to be exported is
> cxl_port_setup_intel_lmh() then. Everything else is generic code. This
> is also a good encapsulation to other archs, vendors, platforms etc. I
> think that would really improve your series. Let me know if you have
> questions.
>
Sorry for this late reply. I just come back from vacation :)

It's too early for asking questions. I'll wait until I read your series.
I just saw you posted it yesterday.

I'll rework my series and just export cxl_port_setup_intel_lmh() as you
suggested, if it would result into a better solution.

I can't yet easily figure out how to detect an LMH while still in cxl_port_=
add(),
I'll think about it.
>  =20
> See also inline below, I have some questions and comments.
>=20
> >=20
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/cxl/Kconfig       |  5 ++++
> >  drivers/cxl/core/Makefile |  1 +
> >  drivers/cxl/core/lmh.c    | 53 +++++++++++++++++++++++++++++++++++++
>=20
> Could you name this file intel.c and have necessary Kconfig options?
>
I named it x86.c, but in internal review Dan asked to rename it lmh.c
>=20
> If code should be reused later we still can move it to common.c or
> similar. It would be good to guard that having a pci_device_id check
> to a root port or a vendor cpu check.
>=20
> See my comment no enablement above.
>=20
> >  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++++++-------
> >  drivers/cxl/cxl.h         | 25 ++++++++++++++++++
> >  5 files changed, 130 insertions(+), 9 deletions(-)
> >  create mode 100644 drivers/cxl/core/lmh.c
> >=20
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 876469e23f7a..07b87f217e59 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -128,6 +128,11 @@ config CXL_REGION
> > =20
> >  	  If unsure say 'y'
> > =20
> > +config CXL_ARCH_LOW_MEMORY_HOLE
> > +	def_bool y
> > +	depends on CXL_REGION
> > +	depends on X86
> > +
> >  config CXL_REGION_INVALIDATION_TEST
> >  	bool "CXL: Region Cache Management Bypass (TEST)"
> >  	depends on CXL_REGION
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 9259bcc6773c..6e80215e8444 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -15,4 +15,5 @@ cxl_core-y +=3D hdm.o
> >  cxl_core-y +=3D pmu.o
> >  cxl_core-y +=3D cdat.o
> >  cxl_core-$(CONFIG_TRACING) +=3D trace.o
> > +cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) +=3D lmh.o
> >  cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
> > diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> > new file mode 100644
> > index 000000000000..da76b2a534ec
> > --- /dev/null
> > +++ b/drivers/cxl/core/lmh.c
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/range.h>
> > +#include "cxl.h"
> > +
> > +/* In x86 with memory hole, misaligned CFMWS range starts at 0x0 */
> > +#define MISALIGNED_CFMWS_RANGE_BASE 0x0
>=20
> Could you more elaborate on this? Why is the base zero?
>=20
I know it because I saw it's zero in all configurations showed by and discu=
ssed with=20
BIOS engineers.
>
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
> > + * also larger than that of the matching root decoder
> > + */
> > +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> > +		    struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct range *r1, *r2;
> > +	int niw;
> > +
> > +	r1 =3D &cxlrd->cxlsd.cxld.hpa_range;
> > +	r2 =3D &cxled->cxld.hpa_range;
> > +	niw =3D cxled->cxld.interleave_ways;
> > +
> > +	if (r1->start =3D=3D MISALIGNED_CFMWS_RANGE_BASE &&
> > +	    r1->start =3D=3D r2->start && r1->end < r2->end &&
> > +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> > +		return true;
> > +	return false;
> > +}
> > +
> > +/* Similar to arch_match_spa(), it matches regions and decoders */
> > +bool arch_match_region(struct cxl_region_params *p,
> > +		       struct cxl_decoder *cxld)
> > +{
> > +	struct range *r =3D &cxld->hpa_range;
> > +	struct resource *res =3D p->res;
> > +	int niw =3D cxld->interleave_ways;
> > +
> > +	if (res->start =3D=3D MISALIGNED_CFMWS_RANGE_BASE &&
> > +	    res->start =3D=3D r->start && res->end < r->end &&
> > +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> > +		return true;
>=20
> This basically means that the region base is zero?
>
Yes, it is.=20
>
> How do you
> determine the actual base address of the range then? The cxl test
> patch contains a non-zero address.
>
Next version of this series is going to use 0x0 for real hardware and=20
mock_cfmws[0]->base_hpa for the topology created by cxl tests.
>
> this trimmed mem hole regions? Could you share a snippet of a CFMWS
> entry for this?
>
Sorry, I don't have it because no real hardware was required to make and te=
st
my series.=20
>=20
> Thanks,
>=20
> -Robert
>=20
> > +	return false;
> > +}
> > +
> > +void arch_trim_hpa_by_spa(struct resource *res,
> > +			  struct cxl_root_decoder *cxlrd)
> > +{
> > +	res->end =3D cxlrd->res->end;
> > +}
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index ac2c486c16e9..3cb5a69e9731 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -836,8 +836,12 @@ static int match_auto_decoder(struct device *dev, =
void *data)
> >  	cxld =3D to_cxl_decoder(dev);
> >  	r =3D &cxld->hpa_range;
> > =20
> > -	if (p->res && p->res->start =3D=3D r->start && p->res->end =3D=3D r->=
end)
> > -		return 1;
> > +	if (p->res) {
> > +		if (p->res->start =3D=3D r->start && p->res->end =3D=3D r->end)
> > +			return 1;
> > +		if (arch_match_region(p, cxld))
> > +			return 1;
> > +	}
> > =20
> >  	return 0;
> >  }
> > @@ -1414,7 +1418,8 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
> >  		if (cxld->interleave_ways !=3D iw ||
> >  		    cxld->interleave_granularity !=3D ig ||
> >  		    cxld->hpa_range.start !=3D p->res->start ||
> > -		    cxld->hpa_range.end !=3D p->res->end ||
> > +		    (cxld->hpa_range.end !=3D p->res->end &&
> > +		     !arch_match_region(p, cxld)) ||
> >  		    ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)) {
> >  			dev_err(&cxlr->dev,
> >  				"%s:%s %s expected iw: %d ig: %d %pr\n",
> > @@ -1726,6 +1731,7 @@ static int match_switch_decoder_by_range(struct d=
evice *dev, void *data)
> >  {
> >  	struct cxl_endpoint_decoder *cxled =3D data;
> >  	struct cxl_switch_decoder *cxlsd;
> > +	struct cxl_root_decoder *cxlrd;
> >  	struct range *r1, *r2;
> > =20
> >  	if (!is_switch_decoder(dev))
> > @@ -1735,8 +1741,13 @@ static int match_switch_decoder_by_range(struct =
device *dev, void *data)
> >  	r1 =3D &cxlsd->cxld.hpa_range;
> >  	r2 =3D &cxled->cxld.hpa_range;
> > =20
> > -	if (is_root_decoder(dev))
> > -		return range_contains(r1, r2);
> > +	if (is_root_decoder(dev)) {
> > +		if (range_contains(r1, r2))
> > +			return 1;
> > +		cxlrd =3D to_cxl_root_decoder(dev);
> > +		if (arch_match_spa(cxlrd, cxled))
> > +			return 1;
> > +	}
> >  	return (r1->start =3D=3D r2->start && r1->end =3D=3D r2->end);
> >  }
> > =20
> > @@ -1943,7 +1954,7 @@ static int cxl_region_attach(struct cxl_region *c=
xlr,
> >  	}
> > =20
> >  	if (resource_size(cxled->dpa_res) * p->interleave_ways !=3D
> > -	    resource_size(p->res)) {
> > +	    resource_size(p->res) && !arch_match_spa(cxlrd, cxled)) {
> >  		dev_dbg(&cxlr->dev,
> >  			"%s:%s: decoder-size-%#llx * ways-%d !=3D region-size-%#llx\n",
> >  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > @@ -3199,7 +3210,13 @@ static int match_root_decoder_by_range(struct de=
vice *dev, void *data)
> >  	r1 =3D &cxlrd->cxlsd.cxld.hpa_range;
> >  	r2 =3D &cxled->cxld.hpa_range;
> > =20
> > -	return range_contains(r1, r2);
> > +	if (range_contains(r1, r2))
> > +		return true;
> > +
> > +	if (arch_match_spa(cxlrd, cxled))
> > +		return true;
> > +
> > +	return false;
> >  }
> > =20
> >  static int match_region_by_range(struct device *dev, void *data)
> > @@ -3217,8 +3234,12 @@ static int match_region_by_range(struct device *=
dev, void *data)
> >  	p =3D &cxlr->params;
> > =20
> >  	down_read(&cxl_region_rwsem);
> > -	if (p->res && p->res->start =3D=3D r->start && p->res->end =3D=3D r->=
end)
> > -		rc =3D 1;
> > +	if (p->res) {
> > +		if (p->res->start =3D=3D r->start && p->res->end =3D=3D r->end)
> > +			rc =3D 1;
> > +		if (arch_match_region(p, &cxled->cxld))
> > +			rc =3D 1;
> > +	}
> >  	up_read(&cxl_region_rwsem);
> > =20
> >  	return rc;
> > @@ -3270,6 +3291,22 @@ static struct cxl_region *construct_region(struc=
t cxl_root_decoder *cxlrd,
> > =20
> >  	*res =3D DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> >  				    dev_name(&cxlr->dev));
> > +
> > +	/*
> > +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> > +	 * platform
> > +	 */
> > +	if (arch_match_spa(cxlrd, cxled)) {
> > +		struct range *range =3D &cxlrd->cxlsd.cxld.hpa_range;
> > +
> > +		arch_trim_hpa_by_spa(res, cxlrd);
> > +		dev_dbg(cxlmd->dev.parent,
> > +			"%s: Trim HPA (%s: %pr) by SPA (%s: %pr)\n",
> > +			__func__,
> > +			dev_name(&cxlrd->cxlsd.cxld.dev), range,
> > +			dev_name(&cxled->cxld.dev), hpa);
> > +	}
> > +
> >  	rc =3D insert_resource(cxlrd->res, res);
> >  	if (rc) {
> >  		/*
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 5406e3ab3d4a..a5ad4499381e 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -902,6 +902,31 @@ void cxl_coordinates_combine(struct access_coordin=
ate *out,
> > =20
> >  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> > =20
> > +#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
> > +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> > +		    struct cxl_endpoint_decoder *cxled);
> > +bool arch_match_region(struct cxl_region_params *p,
> > +		       struct cxl_decoder *cxld);
> > +void arch_trim_hpa_by_spa(struct resource *res,
> > +			  struct cxl_root_decoder *cxlrd);
> > +#else
> > +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> > +		    struct cxl_endpoint_decoder *cxled)
> > +{
> > +	return false;
> > +}
> > +
> > +bool arch_match_region(struct cxl_region_params *p,
> > +		       struct cxl_decoder *cxld)
> > +{
> > +	return false;
> > +}
> > +
> > +void arch_trim_hpa_by_spa(struct resource *res,
> > +			  struct cxl_root_decoder *cxlrd)
> > +{ }
> > +#endif /* CXL_ARCH_LOW_MEMORY_HOLE */
> > +
> >  /*
> >   * Unit test builds overrides this to __weak, find the 'strong' version
> >   * of these symbols in tools/testing/cxl/.
>=20
>=20




