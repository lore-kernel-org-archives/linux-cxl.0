Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E66A932;
	Sat, 29 Mar 2025 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743285698; cv=none; b=OOMpvXk2TNfeIsRRYNA2Oc+9RLmv/xOGLA86sun5asG6I3bmNnS6DXFkSNEfm6ptLAdzAz83uCEjno1d9Oc77FwT1yVLW4UEaw/BJg0E9zX8kgC/0DvATzGcjpgwmhSl9G6N+Vfzq4akH4LsnbKuudq44Ma7W5BPYOwLtSo+11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743285698; c=relaxed/simple;
	bh=Sfokc3Tw5ecAWdqXbna3wiAIP8dLWRw12ODKz97sn18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtxT2fev/IMwDT74kMdOTiFABBsX+YzYgMm/bCn8qhqpfze8ZfPw1ueLi5ci3Ev5Mo/9VET5aY0VnPaHcIfPLIyV/8aG6DqlHjhWOURu16ByRNzof8PjAr0fg/fp851lYSYX2RC8qz1kVcxHY0y3bY9pzgtqRR5jSGbHlujjIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkTiiIWR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkTiiIWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743285696; x=1774821696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Sfokc3Tw5ecAWdqXbna3wiAIP8dLWRw12ODKz97sn18=;
  b=VkTiiIWRp+o1AOoIwsT3SZ0jsSmGSddgJ5+BDugu9XK7IRz5eXI2gWXk
   C5eAngy+VokYLd/CF8JrdTCnAUytkv/oOfXNvnKniNjRJsTrUTeUba0aS
   PWlGMe/Q3hM+yzAjAsjv3WSQBqycKo37MShikzZZmXydP+I0LgIumUiw3
   3VTeXz+QeKITvQHHuziGopUp5gZpee7dHGh2ZBkRD2OL/ro8LNT+kzuFB
   yd/phiTjTJi7CA/PhFoaaL3YxxXiIIzef9ADxStBMBx3Y+zfKj629YuGf
   wd+Xi1Ozp4EVOUI1v9jXu7h+JNoj+0bP+RF6bYf4Vb/mKBon/WoOzQRrK
   w==;
X-CSE-ConnectionGUID: 9vJfNZsyTNKMSCNaOMkisA==
X-CSE-MsgGUID: uigq8LJhRFGD+Nh7mPHMvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11388"; a="44503791"
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="asc'?scan'208";a="44503791"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 15:01:35 -0700
X-CSE-ConnectionGUID: AgXsSuK0RlqkJkp/vrlLtA==
X-CSE-MsgGUID: zH/gvDX9RtqQeKC7tA13uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="asc'?scan'208";a="129872688"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.141])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 15:01:31 -0700
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
Date: Sat, 29 Mar 2025 23:01:28 +0100
Message-ID: <6370300.Zfb76A358L@fdefranc-mobl3>
In-Reply-To: <3089527.UnXabflUDm@fdefranc-mobl3>
References:
 <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <67e7337f25c3a_1198729411@dwillia2-xfh.jf.intel.com.notmuch>
 <3089527.UnXabflUDm@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2816299.fL8zNpBrTj";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2816299.fL8zNpBrTj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 29 Mar 2025 23:01:21 +0100
Message-ID: <6370300.Zfb76A358L@fdefranc-mobl3>
In-Reply-To: <3089527.UnXabflUDm@fdefranc-mobl3>
MIME-Version: 1.0

On Saturday, March 29, 2025 11:16:09=E2=80=AFAM Central European Standard T=
ime Fabio M. De Francesco wrote:
> On Saturday, March 29, 2025 12:40:47=E2=80=AFAM Central European Standard=
 Time Dan Williams wrote:
> > Fabio M. De Francesco wrote:
> > > Simulate an x86 Low Memory Hole for the CXL tests by changing the fir=
st
> > > mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range=
 sizes
> > > to 1GB.
> > >=20
> > > Since the auto-created region of cxl-test uses mock_cfmws[0], whose r=
ange
> > > base address is typically different from the one published by the BIO=
S on
> > > real hardware, the driver would fail to create and attach CXL Regions=
 if
> > > it was run on the mock environment created by cxl-tests.
> > >=20
> > > Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to matc=
h CXL
> > > Root Decoders and Regions with Endpoint Decoders when the driver is r=
un on
> > > mock devices.
> > >=20
> > > Since the auto-created region of cxl-test uses mock_cfmws[0], the
> > > LMH path in the CXL Driver will be exercised every time the cxl-test
> > > module is loaded. Executing unit test: cxl-topology.sh, confirms the
> > > region created successfully with a LMH.
> > >=20
> > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.inte=
l.com>
> > > ---
> > >  drivers/cxl/core/lmh.c               | 35 ++++++++++++++++++++++++--=
=2D-
> > >  drivers/cxl/core/lmh.h               |  2 ++
> > >  tools/testing/cxl/cxl_core_exports.c |  2 ++
> > >  tools/testing/cxl/test/cxl.c         | 10 ++++++++
> > >  4 files changed, 45 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> > > index 2e32f867eb94..9c55670c1c84 100644
> > > --- a/drivers/cxl/core/lmh.c
> > > +++ b/drivers/cxl/core/lmh.c
> > > @@ -1,11 +1,28 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > > =20
> > >  #include <linux/range.h>
> > > +#include <linux/pci.h>
> > > +
> > >  #include "lmh.h"
> > > =20
> > >  /* Start of CFMWS range that end before x86 Low Memory Holes */
> > >  #define LMH_CFMWS_RANGE_START 0x0ULL
> > > =20
> > > +static u64 mock_cfmws0_range_start =3D ULLONG_MAX;
> > > +
> > > +void set_mock_cfmws0_range_start(const u64 start)
> > > +{
> > > +	mock_cfmws0_range_start =3D start;
> > > +}
> > > +
> > > +static u64 get_cfmws_range_start(const struct device *dev)
> > > +{
> > > +	if (dev_is_pci(dev))
> > > +		return LMH_CFMWS_RANGE_START;
> > > +
> > > +	return mock_cfmws0_range_start;
> > > +}
> > > +
> >=20
> > cxl_test should never result in "mock" infrastructure appearing outside
> > of tools/testing/cxl/
> >=20
> > >  /*
> > >   * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ran=
ges.
> > >   *
> > > @@ -19,14 +36,19 @@ bool arch_match_spa(const struct cxl_root_decoder=
 *cxlrd,
> > >  		    const struct cxl_endpoint_decoder *cxled)
> > >  {
> > >  	const struct range *r1, *r2;
> > > +	u64 cfmws_range_start;
> > >  	int niw;
> > > =20
> > > +	cfmws_range_start =3D get_cfmws_range_start(&cxled->cxld.dev);
> > > +	if (cfmws_range_start =3D=3D ULLONG_MAX)
> > > +		return false;
> > > +
> > >  	r1 =3D &cxlrd->cxlsd.cxld.hpa_range;
> > >  	r2 =3D &cxled->cxld.hpa_range;
> > >  	niw =3D cxled->cxld.interleave_ways;
> > > =20
> > > -	if (r1->start =3D=3D LMH_CFMWS_RANGE_START && r1->start =3D=3D r2->=
start &&
> > > -	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end =
&&
> > > +	if (r1->start =3D=3D cfmws_range_start && r1->start =3D=3D r2->star=
t &&
> > > +	    r1->end < (cfmws_range_start + SZ_4G) && r1->end < r2->end &&
> > >  	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> > >  		return true;
> > > =20
> > > @@ -40,9 +62,14 @@ bool arch_match_region(const struct cxl_region_par=
ams *p,
> > >  	const struct range *r =3D &cxld->hpa_range;
> > >  	const struct resource *res =3D p->res;
> > >  	int niw =3D cxld->interleave_ways;
> > > +	u64 cfmws_range_start;
> > > +
> > > +	cfmws_range_start =3D get_cfmws_range_start(&cxld->dev);
> > > +	if (cfmws_range_start =3D=3D ULLONG_MAX)
> > > +		return false;
> > > =20
> > > -	if (res->start =3D=3D LMH_CFMWS_RANGE_START && res->start =3D=3D r-=
>start &&
> > > -	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end=
 &&
> > > +	if (res->start =3D=3D cfmws_range_start && res->start =3D=3D r->sta=
rt &&
> > > +	    res->end < (cfmws_range_start + SZ_4G) && res->end < r->end &&
> > >  	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> > >  		return true;
> >=20
> > Someone should be able to read the straight line CXL driver code and
> > never know that an alternate implementation exists for changing these
> > details.
> >=20
> > So, the mock interface for this stuff should intercept at the
> > arch_match_spa() and arch_match_region() level.
> >=20
> > To me that looks like mark these implementations with the __mock
> > attribute, similar to to_cxl_host_bridge(). Then define strong versions
> > in tools/testing/cxl/mock_lmh.c.
> >=20
> > The strong versions would apply memory hole semantics to both windows
> > starting at zero and whatever cxl_test window you choose.
> >=20
> I thought the same and wanted to use the strong/weak mechanism, but then=
=20
> I noticed that the strong version (in tools/testing/cxl/mock_lmh.c) was n=
ever
> called. I think it never happens because of the weak version is called fr=
om=20
> cxl_core. I think that all functions called from cxl_core can't be overri=
de
> from cxl_test.=20
>=20
> Is that deduction unfounded? Am I missing something?
>=20
> Thanks,
>=20
> Fabio
>=20
> P.S.: Please notice that to_cxl_host_bridge() is never used in cxl_core.
>=20
I mistakenly thought you were suggesting something like the wrap approach
that is not possible if the caller of the wrapped function is internal to=20
the CXL core.[1]

=46abio

[1] https://lore.kernel.org/all/6711b7c0c0b53_3ee2294a6@dwillia2-xfh.jf.int=
el.com.notmuch/

=20
--nextPart2816299.fL8zNpBrTj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEPKnol7Erd70tN+Lb50DaXiQpiWEFAmfobbEACgkQ50DaXiQp
iWG02AgAoXUQW0X+Fg383LF7mU7u2GPAXfpaCO6HOteZMUB3pZL1IjgRYNi5CW6m
jdLazPad27dWPYzZkVNEZlEmsgULm+SxrbS58A7D9wHMZFTZe8rvM9ZXAAdYtIrW
7ZFTrQGcdxKOIKN1OfdlBpz5aLADJQEZ10By/5qyYs4czMlH6DoL2Jc5CBNw7gdv
91oU0cW0Z2mBRF6l01cKwcoVanTAunVwNHV3spSXdseoyg60FSvNx9gDf/twTTt6
na18kcljhMVrLGHFravfoaHJMrp8uV0qE+3vzqiCq1x7G+aokFDnUQRqT0/C0tdk
wRWptApBG7xfv4EgJIFrxFmRt5yN+Q==
=6r9L
-----END PGP SIGNATURE-----

--nextPart2816299.fL8zNpBrTj--



