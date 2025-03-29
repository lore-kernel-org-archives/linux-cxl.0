Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BD70807;
	Sat, 29 Mar 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743242729; cv=none; b=Tu757WXbYCtcu6WzURjtKe55CHPH63McxUAcCRTZ1Rplz78Npwno2zp/3ORP6YdR4SJSxXhJIppYsQcVW4wBeTJbKTN56sXqDissbh3PjDPaTY4FXWHSjmelmjLTZLLlT+gSLMbxOHBTuUgPwLN6Eepc3cPka/WTBi9sVA/H9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743242729; c=relaxed/simple;
	bh=5OzxuyPYXCVlGprQPvC0QQq6AG0p6FibJk7WQO3UK1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEGW/a4ObGCVlHjfG1astqCJu+Sx8wltIYhV0uCu0BsK64FRD2JGBNu6FuErVgshqOhn5cZUt77ZbLI1QgBk67IuelpGvYN/kLIXAPDitispS7kxuVQr1uGjFZHKXje4T9o/diuq/bmtPMXaVNcyMMdPkmRzkJ1E32KU6RS1ZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKduBr1w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKduBr1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743242728; x=1774778728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5OzxuyPYXCVlGprQPvC0QQq6AG0p6FibJk7WQO3UK1I=;
  b=lKduBr1wen25TqGUMggLFgFtqN5/RTybLVCV26t9AuIKC+J0S7rLJAMd
   O36naz2H/oAfSicJU33kelaHxuIfuhYgsBt61uu93PX/mnavsFhS19+MH
   26aqwQJQ4AnrkDHrwFCzrFYmC1ZWberr4oJDEU3gj9+o/CwTf40a4wj3o
   WHt9Utl1wcCnsutAd1X64U6LuXHA2Yqxxspnzkw4yZ+t4ZqPh6cGzkAnO
   Ay9fnFt/HDrnV29e6PBjYQMXI1thuhOKujzhsg/Wfjg+DiTXXnAaVV7Iy
   6ZcfcbAE0r5xa3CtFz4pW6vo9nZgZey1qeoQ8pIyjpKL4L4Kj2C/eb5Io
   w==;
X-CSE-ConnectionGUID: 8vq4+wAzQbCYqp4pfzojfQ==
X-CSE-MsgGUID: 5NV31hW9Sse1XGGeAeD8Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="48261055"
X-IronPort-AV: E=Sophos;i="6.14,285,1736841600"; 
   d="asc'?scan'208";a="48261055"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 03:05:27 -0700
X-CSE-ConnectionGUID: UgG6fmExQXmW1vaR3hTlbQ==
X-CSE-MsgGUID: bFdL671UQIWCq1XMztHo0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,285,1736841600"; 
   d="asc'?scan'208";a="130876992"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.136])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 03:05:23 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 2/4 v3] cxl/core: Add helpers to detect Low memory Holes on x86
Date: Sat, 29 Mar 2025 11:05:19 +0100
Message-ID: <3503779.obQ9GjlxrE@fdefranc-mobl3>
In-Reply-To: <67e73372737bf_201f0294e8@dwillia2-xfh.jf.intel.com.notmuch>
References:
 <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
 <67e73372737bf_201f0294e8@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3483319.sy0gbHreEd";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3483319.sy0gbHreEd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 29 Mar 2025 11:05:12 +0100
Message-ID: <3503779.obQ9GjlxrE@fdefranc-mobl3>
MIME-Version: 1.0

On Saturday, March 29, 2025 12:40:34=E2=80=AFAM Central European Standard T=
ime Dan Williams wrote:
> Fabio M. De Francesco wrote:
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
> > +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +void arch_adjust_region_resource(struct resource *res,
> > +				 struct cxl_root_decoder *cxlrd)
> > +{
> > +	res->end =3D cxlrd->res->end;
> > +}
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
>=20
> I would have expected the default match routines to do the default
> matching, not return false.
>=20
> This can document the common expectation on architectures that do not
> need to account for decoders not aligning to window boundaries due to
> holes.
>=20
Hi Dan,

A typical example of arch_match_spa() use is from match_root_decoder_by_ran=
ge()
which returns false on platforms that don't enable support for the low memo=
ry hole.
Therefore, the default behavior is failing the matching by returning false.

This is how arch_match_spa() is used to detect a hole and allow the matchin=
g:

static int match_root_decoder_by_range(struct device *dev,
                                       const void *data)
{
        const struct cxl_endpoint_decoder *cxled =3D data;
        struct cxl_root_decoder *cxlrd;
        const struct range *r1, *r2;

        if (!is_root_decoder(dev))
                return 0;

        cxlrd =3D to_cxl_root_decoder(dev);
        r1 =3D &cxlrd->cxlsd.cxld.hpa_range;
        r2 =3D &cxled->cxld.hpa_range;

        if (range_contains(r1, r2))
                return true;
        if (arch_match_spa(cxlrd, cxled))
                return true;

        return false;
}

Currently the default behavior is for match_root_decoder_by_range() to
not match root and endpoint decoders. I left that default unchanged for
all platforms and architectures that don't enable LMH support.=20

Thanks,

=46abio
--nextPart3483319.sy0gbHreEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEPKnol7Erd70tN+Lb50DaXiQpiWEFAmfnxdgACgkQ50DaXiQp
iWHbmwf+Mo7E4aS3Yzp2MBV0BM9z8V21fAbAQLXzm73RiBWn2JQygCccmmcLbQAd
/mslTClNnhpEXSQVIdk6hzemupcDL+tdh0EP/vFlnh9g/z7BBodAreQJhmIFz2gI
eCiJhc1OXntQBhGU1bRTQfzC4tY95tnHQRVJ4VF6fhAc4RTnYLrn86QqJ7cRYVY3
ARoQ+8vMU2P0p79/w/YJwR3dx/GizwnAX/tV1xpnARbr/hN+6TMGd2jvfv7GX3DI
gLCI79HicckRr2GQdEJn7cF0jLIkjBv7YvolDQEKWwQKM51Bro5ud4nrUKreEdkK
cJgMF8WVL6QuOmJ4hrM3AVrI36pVTw==
=p+Sr
-----END PGP SIGNATURE-----

--nextPart3483319.sy0gbHreEd--



