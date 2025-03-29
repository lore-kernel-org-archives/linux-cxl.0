Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9A11CA0;
	Sat, 29 Mar 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743243379; cv=none; b=t7n5cLAA56NxTJmm5Ws0oaHkHIQB7EhPQzfZ2HcdEfGUyZGUyiiL7L1X+HFnL19R0+NndN0EtI4keB2ZLbj76cZBqhqz7olHVxxZ9w7qakaxCN4IMU1DYY/Gn2hEBJyQYf1yxgIIQo7d8ioaKf5//7Dua79tYJRGVQl8NSlUYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743243379; c=relaxed/simple;
	bh=DUlll1Sn6RhUABXWceQkis59amWHUQXF0RZSHCEhWWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCSQL8xMOfS5h7oYxPm9RUqcKrueNug/OO8SwESQxs4AoL3Rb80qvrM9CUQZxbMZgbF8bnijYIC8bHSy8ZXaWB5no39n/nG2QVLSryKsv/JUYQf6eCNTsgavx9rwcJ3+I8mUdvNz97p3mJT3kB9rOhWq2T3VjPOf/O5eRmrUYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6fh39dh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6fh39dh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743243378; x=1774779378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DUlll1Sn6RhUABXWceQkis59amWHUQXF0RZSHCEhWWk=;
  b=C6fh39dhtvM46m7lg/zpdjWQBIuRPCu1NqZk8Q31yquA/KOt4wGwA7+o
   pytbz8NkvA/012DBSGMyYaCg6sGaABEdq2C2clOyoUWpTl6vrzbQ+EDaZ
   CNNazM8uAwglBL0p3FnSd+0bISN2BPAWifOrpkUAPiLeWsjma4ZtmZm9V
   4Mvu2j2bj5VrJBW+57/01JSxzIy38+BLlvov2MBH22nly3HlNpEyXsPbV
   puH8M2rnFhKxUwqB6mpuVeycuSc3fjhK7o2EZbuOdNwlWvrt8ZkZbyjFp
   KJGQwFVWIwIJW+h3febdAd6fOd1pMGAN2EZB/88SF2Hd1phIFK3SL73d/
   Q==;
X-CSE-ConnectionGUID: ZI7WpHTqSai6az8gZrCkkA==
X-CSE-MsgGUID: jTZNCNc5RAmBLkHA+DekZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44608445"
X-IronPort-AV: E=Sophos;i="6.14,285,1736841600"; 
   d="asc'?scan'208";a="44608445"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 03:16:16 -0700
X-CSE-ConnectionGUID: TdVktx+qQ8uHqt5GDqeqag==
X-CSE-MsgGUID: GoLkVAfpR/Wzyw6dnzyu8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,285,1736841600"; 
   d="asc'?scan'208";a="130505083"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.136])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 03:16:13 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Robert Richter <rrichter@amd.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 4/4 v3] cxl/test: Simulate an x86 Low Memory Hole for tests
Date: Sat, 29 Mar 2025 11:16:09 +0100
Message-ID: <3089527.UnXabflUDm@fdefranc-mobl3>
In-Reply-To: <67e7337f25c3a_1198729411@dwillia2-xfh.jf.intel.com.notmuch>
References:
 <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
 <67e7337f25c3a_1198729411@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3885345.vnuH1ECHvT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3885345.vnuH1ECHvT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 29 Mar 2025 11:16:00 +0100
Message-ID: <3089527.UnXabflUDm@fdefranc-mobl3>
MIME-Version: 1.0

On Saturday, March 29, 2025 12:40:47=E2=80=AFAM Central European Standard T=
ime Dan Williams wrote:
> Fabio M. De Francesco wrote:
> > Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> > mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range s=
izes
> > to 1GB.
> >=20
> > Since the auto-created region of cxl-test uses mock_cfmws[0], whose ran=
ge
> > base address is typically different from the one published by the BIOS =
on
> > real hardware, the driver would fail to create and attach CXL Regions if
> > it was run on the mock environment created by cxl-tests.
> >=20
> > Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match =
CXL
> > Root Decoders and Regions with Endpoint Decoders when the driver is run=
 on
> > mock devices.
> >=20
> > Since the auto-created region of cxl-test uses mock_cfmws[0], the
> > LMH path in the CXL Driver will be exercised every time the cxl-test
> > module is loaded. Executing unit test: cxl-topology.sh, confirms the
> > region created successfully with a LMH.
> >=20
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.=
com>
> > ---
> >  drivers/cxl/core/lmh.c               | 35 ++++++++++++++++++++++++----
> >  drivers/cxl/core/lmh.h               |  2 ++
> >  tools/testing/cxl/cxl_core_exports.c |  2 ++
> >  tools/testing/cxl/test/cxl.c         | 10 ++++++++
> >  4 files changed, 45 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> > index 2e32f867eb94..9c55670c1c84 100644
> > --- a/drivers/cxl/core/lmh.c
> > +++ b/drivers/cxl/core/lmh.c
> > @@ -1,11 +1,28 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > =20
> >  #include <linux/range.h>
> > +#include <linux/pci.h>
> > +
> >  #include "lmh.h"
> > =20
> >  /* Start of CFMWS range that end before x86 Low Memory Holes */
> >  #define LMH_CFMWS_RANGE_START 0x0ULL
> > =20
> > +static u64 mock_cfmws0_range_start =3D ULLONG_MAX;
> > +
> > +void set_mock_cfmws0_range_start(const u64 start)
> > +{
> > +	mock_cfmws0_range_start =3D start;
> > +}
> > +
> > +static u64 get_cfmws_range_start(const struct device *dev)
> > +{
> > +	if (dev_is_pci(dev))
> > +		return LMH_CFMWS_RANGE_START;
> > +
> > +	return mock_cfmws0_range_start;
> > +}
> > +
>=20
> cxl_test should never result in "mock" infrastructure appearing outside
> of tools/testing/cxl/
>=20
> >  /*
> >   * Match CXL Root and Endpoint Decoders by comparing SPA and HPA range=
s.
> >   *
> > @@ -19,14 +36,19 @@ bool arch_match_spa(const struct cxl_root_decoder *=
cxlrd,
> >  		    const struct cxl_endpoint_decoder *cxled)
> >  {
> >  	const struct range *r1, *r2;
> > +	u64 cfmws_range_start;
> >  	int niw;
> > =20
> > +	cfmws_range_start =3D get_cfmws_range_start(&cxled->cxld.dev);
> > +	if (cfmws_range_start =3D=3D ULLONG_MAX)
> > +		return false;
> > +
> >  	r1 =3D &cxlrd->cxlsd.cxld.hpa_range;
> >  	r2 =3D &cxled->cxld.hpa_range;
> >  	niw =3D cxled->cxld.interleave_ways;
> > =20
> > -	if (r1->start =3D=3D LMH_CFMWS_RANGE_START && r1->start =3D=3D r2->st=
art &&
> > -	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
> > +	if (r1->start =3D=3D cfmws_range_start && r1->start =3D=3D r2->start =
&&
> > +	    r1->end < (cfmws_range_start + SZ_4G) && r1->end < r2->end &&
> >  	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> >  		return true;
> > =20
> > @@ -40,9 +62,14 @@ bool arch_match_region(const struct cxl_region_param=
s *p,
> >  	const struct range *r =3D &cxld->hpa_range;
> >  	const struct resource *res =3D p->res;
> >  	int niw =3D cxld->interleave_ways;
> > +	u64 cfmws_range_start;
> > +
> > +	cfmws_range_start =3D get_cfmws_range_start(&cxld->dev);
> > +	if (cfmws_range_start =3D=3D ULLONG_MAX)
> > +		return false;
> > =20
> > -	if (res->start =3D=3D LMH_CFMWS_RANGE_START && res->start =3D=3D r->s=
tart &&
> > -	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
> > +	if (res->start =3D=3D cfmws_range_start && res->start =3D=3D r->start=
 &&
> > +	    res->end < (cfmws_range_start + SZ_4G) && res->end < r->end &&
> >  	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> >  		return true;
>=20
> Someone should be able to read the straight line CXL driver code and
> never know that an alternate implementation exists for changing these
> details.
>=20
> So, the mock interface for this stuff should intercept at the
> arch_match_spa() and arch_match_region() level.
>=20
> To me that looks like mark these implementations with the __mock
> attribute, similar to to_cxl_host_bridge(). Then define strong versions
> in tools/testing/cxl/mock_lmh.c.
>=20
> The strong versions would apply memory hole semantics to both windows
> starting at zero and whatever cxl_test window you choose.
>=20
I thought the same and wanted to use the strong/weak mechanism, but then=20
I noticed that the strong version (in tools/testing/cxl/mock_lmh.c) was nev=
er
called. I think it never happens because of the weak version is called from=
=20
cxl_core. I think that all functions called from cxl_core can't be override
from cxl_test.=20

Is that deduction unfounded? Am I missing something?

Thanks,

=46abio

P.S.: Please notice that to_cxl_host_bridge() is never used in cxl_core.
--nextPart3885345.vnuH1ECHvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEPKnol7Erd70tN+Lb50DaXiQpiWEFAmfnyGAACgkQ50DaXiQp
iWFHAggAjb3GlLvIwMT9y4dkfCLe1PxhLuxd3WbXrnplIEeslD7EaQs5GBtiEi66
FuQ58gjhCJ3OCuTDQ5vc5KIRZo8FQhyPbEKvQy5d6fVUISU+k6ZzHkNaRAwhzIO3
Y/vyD/fGPplCnnjGHCEroY0UDQLrV6eKGwSbMK78/DZYWkSi1vUroNCUtnAliSP7
HrPR+yOiAztYAM/t0QALqypFMB4Qiy0z9n9M9/o+RYIkSeAIWE1LjhRrUrRvXbJe
hc/FPRZJxJ+8wOZ6e0HZu1q5QLfQc7IuLRbJdUR9aAhocaLaccHD2f81qIsRx9ap
lN//K4GlRULoIZmpcckMfESEwA59Rw==
=5E5v
-----END PGP SIGNATURE-----

--nextPart3885345.vnuH1ECHvT--



