Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF453277AA;
	Thu, 21 Aug 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782716; cv=none; b=CDj+UToOW5f2PMwlrI6kP97nCky6QiGkmcvJhngJsr7OtZkx8j05+zOGmbNbQLyVJ1m4WAcYpbewfOMDUjCMGkISgOShpv3rWsFnSJWMKhuCs5c4ijZ0j+qnNZN/48naSlXNDHxgaOf/SfOK38h7n3dXJvADnay/CUoha8mVpI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782716; c=relaxed/simple;
	bh=mGvUSFSZCF0OOEX0aeXdQXcaJGu6pcS/A/OO6T1Hyy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDP6Z5pE2bnm9H/rhVXJtVJfuoSgwlGoWkmKD5189qOZ4DUJ23qM/Fzqk2VdPC4rcyzO/I8B8OfNxC21t+1Y8keACmHK/eOioRXQuFKi84lIB+ZReGy55ATdiyVSfGUnenhQ4qvjFFjHfzHJ6I6h4XogBFrm0I/zawYlvfFl9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKIkxKZU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKIkxKZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755782714; x=1787318714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mGvUSFSZCF0OOEX0aeXdQXcaJGu6pcS/A/OO6T1Hyy8=;
  b=fKIkxKZU+XRfj9ra4Kf6CIul/OsAxzucoimbrcxx8hmQNXkQDHE3sba9
   tm1LPG5u1pAb+4NpPlk+xNvubt3H7QBpRsAwLX9oJBOOQx1R8heXpekQ6
   1xkMaZeZVagnKv43xxELQOKXN8E3Lh5ARiijtJYWw1xqdEwDIDX+TB2gE
   2co/QshULIlHrvcsGNpEuqEWMRkAjzal2l6qWIDm8sN73w3wbtbANxAOz
   88AZWa92rjhK4nkzPacOzdmLi43SPCRCmoHMpdT2IolSx7Y8QNYmIhnf/
   OMXlvO/zEmkeqO2QK6iRukBDtHMKA77cSMy2M72rjZMyAWombrXOOkJ/9
   g==;
X-CSE-ConnectionGUID: koT6o3X6Q76iuxiLeZpKcA==
X-CSE-MsgGUID: 85GcqtoUTZu6qMfrMM4YEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57781739"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57781739"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:25:14 -0700
X-CSE-ConnectionGUID: AMbFKSLSR12xbutY7DtoEA==
X-CSE-MsgGUID: sq/pLG4fQGWLfz/uVqTk0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167919203"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:25:10 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 2/4 v4] cxl/core: Add helpers to detect Low Memory Holes on x86
Date: Thu, 21 Aug 2025 15:25:06 +0200
Message-ID: <5654082.UPlyArG6xL@fdefranc-mobl3>
In-Reply-To: <301195cf-dbb3-45cc-927d-ffd58988aa37@amd.com>
References:
 <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-3-fabio.m.de.francesco@linux.intel.com>
 <301195cf-dbb3-45cc-927d-ffd58988aa37@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, August 1, 2025 10:04:16=E2=80=AFPM Central European Summer Time =
Cheatham, Benjamin wrote:
> On 7/24/2025 9:20 AM, Fabio M. De Francesco wrote:
> > In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe
>=20
> s/publishes/publish
>=20
> > SPA ranges which are subsets of the corresponding CXL Endpoint Decoders
> > HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
> > ranges are always guaranteed to align to the NIW * 256M rule.
>=20
> s/to align to/to align due to/
>=20
> Also a spec reference for the rule would be helpful (same with next patch=
).
>=20
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
> maybe sub "that in x86 with LMH's is 0x0" with "0x0 on x86 with LMH's" al=
so
> s/SPA range sizes/SPA range's size/.
>=20
> > be less than HPA's, SPA's range's size be less than 4G, HPA's size be
> > aligned to the NIW * 256M rule.
>=20
> s/be/is/ in above list.
>=20
I'll change the lines you corrected. Thank you.
> >=20
> > Also introduce a function to adjust the range end of the Regions to be
> > created on x86 with LMH's.
> >=20
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/cxl/Kconfig         |  5 +++
> >  drivers/cxl/core/Makefile   |  1 +
> >  drivers/cxl/core/platform.c | 85 +++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/platform.h | 32 ++++++++++++++
> >  4 files changed, 123 insertions(+)
> >  create mode 100644 drivers/cxl/core/platform.c
> >  create mode 100644 drivers/cxl/core/platform.h
> >=20
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 48b7314afdb8..eca90baeac10 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -211,6 +211,11 @@ config CXL_REGION
> > =20
> >  	  If unsure say 'y'
> > =20
> > +config CXL_PLATFORM_QUIRKS
> > +	def_bool y
> > +	depends on CXL_REGION
> > +	depends on X86
> > +
>=20
> I'm confused on the intention behind this symbol. The naming suggests it'=
s for all platform quirks,
> but the code and dependencies make this x86-specific.
>
I'll remove this dependence on X86; it's neither needed nor wanted.=20
>=20
> I'm going to suggest making this x86-specific for now. I'm not aware of a=
ny other platforms with quirks
> (someone correct me if I'm wrong), so making this x86-specific is fine fo=
r now. I would rename this
> symbol to CXL_X86_QUIRKS, leave dependencies as-is, and rename platform.c=
 to something like platform_x86.c.
> Then, if someone comes along with other platform quirks they can do their=
 own symbol and file (or come
> up with a generic scheme).
>
Dan suggested this approach and I agree with him.[1]
>=20
> >  config CXL_REGION_INVALIDATION_TEST
> >  	bool "CXL: Region Cache Management Bypass (TEST)"
> >  	depends on CXL_REGION
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 79e2ef81fde8..4be729fb7d64 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -18,6 +18,7 @@ cxl_core-y +=3D ras.o
> >  cxl_core-y +=3D acpi.o
> >  cxl_core-$(CONFIG_TRACING) +=3D trace.o
> >  cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
> > +cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) +=3D platform.o
> >  cxl_core-$(CONFIG_CXL_MCE) +=3D mce.o
> >  cxl_core-$(CONFIG_CXL_FEATURES) +=3D features.o
> >  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) +=3D edac.o
> > diff --git a/drivers/cxl/core/platform.c b/drivers/cxl/core/platform.c
> > new file mode 100644
> > index 000000000000..8202750742d0
> > --- /dev/null
> > +++ b/drivers/cxl/core/platform.c
> > @@ -0,0 +1,85 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/range.h>
> > +#include "platform.h"
> > +#include "cxlmem.h"
> > +#include "core.h"
> > +
> > +/* Start of CFMWS range that end before x86 Low Memory Holes */
> > +#define LMH_CFMWS_RANGE_START 0x0ULL
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
>=20
> Where does the SZ_4G restraint come from?
>=20
The hole is in low memory.
>
> Also, might as well make this a kdoc comment since you've already done th=
e majority of the work.
>=20
> > +bool platform_root_decoder_contains(const struct cxl_root_decoder *cxl=
rd,
> > +				    const struct cxl_endpoint_decoder *cxled)
> > +{
>=20
> Assuming you take renaming suggestion above, these functions should proba=
bly be start with
> "platform_x86_*" instead.
>=20
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
> > +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * Similar to platform_root_decoder_contains(), it matches regions and
> > + * decoders
> > + */
> > +bool platform_region_contains(const struct cxl_region_params *p,
> > +			      const struct cxl_decoder *cxld)
> > +{
> > +	const struct range *r =3D &cxld->hpa_range;
> > +	const struct resource *res =3D p->res;
> > +	int niw =3D cxld->interleave_ways;
> > +
> > +	if (res->start =3D=3D LMH_CFMWS_RANGE_START && res->start =3D=3D r->s=
tart &&
> > +	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
> > +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> > +		return true;
> > +
>=20
> This if condition could probably move into its own helper function that t=
akes the ranges and
> interleave ways. My only hang up is that these functions become 2-3 lines=
 each after doing so.
>=20
> You could also get rid of these two functions and just export the "helper=
" function instead.
> It would probably add some bloat to patch 3/4, so it's your call here.
>
I'd rather leave these functions as they are.
>=20
> > +	return false;
> > +}
> > +
> > +void platform_res_adjust(struct resource *res,
> > +			 struct cxl_endpoint_decoder *cxled,
> > +			 const struct cxl_root_decoder *cxlrd)
> > +{
> > +	if (!platform_root_decoder_contains(cxlrd, cxled))
> > +		return;
> > +
> > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> > +	dev_info(cxled_to_memdev(cxled)->dev.parent,
> > +		 "(LMH) Resources were (%s: %pr, %pr)\n",
> > +		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
> > +	if (res) {
> > +		/*
> > +		 * A region must be constructed with Endpoint Decoder's
> > +		 * HPA range end adjusted to Root Decoder's resource end
> > +		 */
>=20
> This comment (and one below) are confusing to me. I'd reword as "Trim reg=
ion resource
> overlap with LMH".
>
Okay, thanks.
>=20
> > +		res->end =3D cxlrd->res->end;
> > +	}
> > +	/*
> > +	 * The Endpoint Decoder's dpa_res->end must be adjusted with Root
> > +	 * Decoder's resource end
> > +	 */
>=20
> and reword this one to "Match endpoint decoder's DPA resource to root dec=
oder's". You could
> also leave out this comment altogether, the below is self-explanatory IMO.
>
Okay.
> =20
> > +	cxled->dpa_res->end =3D
> > +		cxled->dpa_res->start +
> > +		resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;
> > +	dev_info(cxled_to_memdev(cxled)->dev.parent,
> > +		 "(LMH) Resources have been adjusted (%s: %pr, %pr)\n",
> > +		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
>=20
> I think this function is a bit too noisy. I'd recommend having just this =
print and
> have it say something like "Low memory hole overlap detected, trimmed DPA=
 to %pr".
> You could also include the amount trimmed, but that may not be very usefu=
l info.
>=20
> I'd make the first print a dev_dbg() and spell out LMH at the very least.=
 If it's a
> dev_info() it should be relatively easy to tell what's going on for a lay=
man.
>
I'm using dev_info() according to what Alison suggested.[2]
>=20
> > +}
> > diff --git a/drivers/cxl/core/platform.h b/drivers/cxl/core/platform.h
> > new file mode 100644
> > index 000000000000..0baa39938729
> > --- /dev/null
> > +++ b/drivers/cxl/core/platform.h
>=20
> This is a new file so that these functions can hook into cxl_test, right?
> If not, I'd move the below into cxl/core/core.h and remove this file.
>=20
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#include "cxl.h"
> > +
> > +#ifdef CONFIG_CXL_PLATFORM_QUIRKS
> > +bool platform_root_decoder_contains(const struct cxl_root_decoder *cxl=
rd,
> > +				    const struct cxl_endpoint_decoder *cxled);
> > +bool platform_region_contains(const struct cxl_region_params *p,
> > +			      const struct cxl_decoder *cxld);
> > +void platform_res_adjust(struct resource *res,
> > +			 struct cxl_endpoint_decoder *cxled,
> > +			 const struct cxl_root_decoder *cxlrd);
> > +#else
> > +static bool
> > +platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> > +			       const struct cxl_endpoint_decoder *cxled)
> > +{
> > +	return false;
> > +}
> > +
> > +static bool platform_region_contains(const struct cxl_region_params *p,
> > +				     const struct cxl_decoder *cxld)
> > +{
> > +	return false;
> > +}
> > +
> > +void platform_res_adjust(struct resource *res,
> > +			 struct cxl_endpoint_decoder *cxled,
> > +			 const struct cxl_root_decoder *cxlrd)
> > +{
> > +}
>=20
> Don't these need "inline" in the function signatures?
>
Yes, sure. They'll be inline in the next version.
>=20
> > +#endif /* CONFIG_CXL_PLATFORM_QUIRKS */
>=20
Thank you,

=46abio

[1] https://lore.kernel.org/linux-cxl/67ee07cd4f8ec_1c2c6294d5@dwillia2-xfh=
=2Ejf.intel.com.notmuch
[2] https://lore.kernel.org/linux-cxl/Z9xaBaM8Mzc8rQ90@aschofie-mobl2.lan/




