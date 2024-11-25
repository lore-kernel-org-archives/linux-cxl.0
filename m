Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915C192D6C;
	Mon, 25 Nov 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555342; cv=none; b=gt00S1j0wyZkFPX/B5J68SwyBlUG3fNcdfBNfT1yT4Bzqj/NorN4fWZnWj2Q6tcXpMG7cJzN4KBuECvRdIhBEpZbfmSA6mgYQTPphO51WUZ7S952DMTXRgI7G6AR+92Q8NHsPktu8EunOZlOyzHP/fCeqzuOsexWBfiQqmgCwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555342; c=relaxed/simple;
	bh=wYrQc0AJgqkX4tikh0PPvpVXYoC9tC30Ibs+bh7pOQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjgjbd+vuAY1+cpz9B53NEh5fjxaP/BT+S7KGyTczc3Spi3ic6dnEeaJbUVJpfQUNoHCHWT2/FpuyaiMJx21LS3DmZYhbHyaZS/Fo/MIpaA7uFXvo+4VfQgVI2jL8tWPniTZx4feQdFjBVLFe7EpuqyFAR3rdVv17VxrXoqT9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blfYrke8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blfYrke8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732555340; x=1764091340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wYrQc0AJgqkX4tikh0PPvpVXYoC9tC30Ibs+bh7pOQM=;
  b=blfYrke8FakQQqoLVh/WRNsue20quH0E8oDlEA4gOLfO/oggmKHNRje8
   sA33bEM9u6cV2craD4zxdBGHhDPuRM84Py3tlBB2y4DNS9o05TyNyra7t
   oC1hLrk9BlB3dJwmjszLBXWv5WOr8DMXebh7nqy9RchooRPLS64YjZiMw
   ldvJZ40hkxz3r0yoXyNke3ZtIc7oIZGgaDnsmUVR5nN04bDA0I50rM6Tp
   ILomce8YyeMCbXIBJBiIU3DwTnpywRQiCuVGyNBx6JAuhNb2eRPJUV66v
   OxphoeTskZ06gkxLkoxQ6MsniJo0YIbTmxDCD5sSfA+9o7Ls/wslUEzw2
   w==;
X-CSE-ConnectionGUID: FmCIHH32Q5mAQJNtmIDn8Q==
X-CSE-MsgGUID: mWdbo0BdSJ2hpktuJYfcBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="20266379"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="20266379"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 09:22:18 -0800
X-CSE-ConnectionGUID: 0yGp6o/hS4CFkmNmfvrLXA==
X-CSE-MsgGUID: N2CWbztGRC2FI7ONa6lEbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="95426734"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.245.82])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 09:22:14 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Li Ming <ming4.li@intel.com>, Li Ming <ming4.li@outlook.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Huang Ying <ying.huang@intel.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Subject:
 Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low Memory Hole
Date: Mon, 25 Nov 2024 18:22:10 +0100
Message-ID: <2791149.btlEUcBR6m@fdefranc-mobl3>
In-Reply-To:
 <VI1PR10MB2016115B9C59CA9A74312092CE2E2@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
References:
 <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
 <VI1PR10MB2016115B9C59CA9A74312092CE2E2@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, November 25, 2024 9:42:56=E2=80=AFAM GMT+1 Li Ming wrote:
>=20
> On 11/22/2024 11:51 PM, Fabio M. De Francesco wrote:
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
>=20
> Hi Fabio,
>=20
> Here mentions that the end address must be below 4GB, but I don't find an=
y checking about that in the implementation, is it not needed?
>=20
Hi Ming,

Good question, thanks!

While a first version of arch_match_spa() had a check of 'r2->end < SZ_4G',
I dropped it for the final one. It ended up out of sync with the commit mes=
sage.

I think that we don't want that check. I'll rework the commit message for v=
2.

If the hardware decoders HPA ranges extended beyond the end of Low=20
Memory, the LMH would still need to be detected and the decoders capacity=20
would still need to be trimmed to match their corresponding CFMWS range end=
=2E=20
>
> [snip]
>=20
>=20
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
>=20
> I think that it is better to check LMH cases before checking (p->res->sta=
rt =3D=3D r->start && p->res->end =3D=3D r->end).
> Per the changelog and the implementation of arch_match_region(), below ca=
se should fails but current checking will succeed:
> the value of 'p->res->start' is MISALIGNED_CFMWS_RANGE_BASE and the the v=
alue of 'p->res->end' is equals to the value of 'r->end'.
>=20
I think that the expected "normal" case should always come first. In the ex=
pected
scenarios the driver deals either with SPA range =3D=3D HPA range=20
(e.g, in match_auto_decoder()) or with SPA range that fully contains the HP=
A range
(match_decoder_by_range()).=20

If either one of those two cases holds, arch_match_*() helper doesn't need =
to be
called and the match must succeed.=20

Besides, other architectures are free to define holes with many constraints=
 that=20
the driver doesn't want to check first if the expected case is already met.
>=20
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
>=20
> Same as above, what will happen if the root decoder's address range still=
 contains endpoint decoder's address range in LMH cases? should fails or su=
cceed?
>=20
If r1 contains r2, there is no LMH and the driver is dealing with the regul=
ar,=20
expected, case. It must succeed.

Think of the arch_match_*() helpers like something that avoid unwanted
failures if arch permits exceptions. Before returning errors when the "norm=
al"
tests fail, check if the arch allows any exceptions and make the driver
ignore that "strange" SPA/HPA misalignment.
>
> [snip]
>
Thanks,

=46abio





