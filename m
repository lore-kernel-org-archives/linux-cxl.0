Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4BF7EB
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662952; cv=none; b=DzhYz9zYu6ytaMtvQUF+5YOS+V5wJJqHBm+DEeZUT3/VZmCmej6RX7RtClSpksTag5PGLei0X+YQ3cnsGyOx5TxRo6elFgT3UkHLj5BnULebmyxL7+cwj2+6UyxVDSZtWNysupzgSdE3mu4uKNXi5xIIN2M1UXudG8c0Hn130rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662952; c=relaxed/simple;
	bh=JUhvKhiwhzkhnyxq2F8yB/L3Sb2BBoZZ6CNTZSKKxcE=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=sequtKu1+FVNoMXFYF1LrD/oryyr6BglRoYKo+ZxTSRX8/imGnTZhg1/+WJzEl26lBlvFP502Ic09MnsQN5OgNvdkNSqz25Gk+YGlvzcNvYDTQBnwhnDGFKSeiSmuKQenp1ejGjb1/4VG10lclomC6DCi+jBXK8uZb3T7T1IdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EaR0ACb5; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EaR0ACb5"
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240131010226epoutp01992ef0859f17421a858af8ed840fe24c~vSOhDuNI32438424384epoutp01X
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 01:02:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240131010226epoutp01992ef0859f17421a858af8ed840fe24c~vSOhDuNI32438424384epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706662946;
	bh=JUhvKhiwhzkhnyxq2F8yB/L3Sb2BBoZZ6CNTZSKKxcE=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=EaR0ACb5+UlApLF1TlVJLQv+5kwN3Wl9muQWTsza3PJA52Cam0HZuCW83HpgeH4A/
	 kIxS2rEJ/nOD2uRmhnpku6hAFKwUEYARkU/sHBmjztPh61Wa+/9fQG0iIF2NbNiaW9
	 xSizQsWojUD98LDQ2dE16hVDOriI5kiGpTcS7Qh4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240131010225epcas2p18cacc304afaaca89a6caa00ca6d49391~vSOgifnSQ0132201322epcas2p1X;
	Wed, 31 Jan 2024 01:02:25 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.89]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TPkKF0nclz4x9Q6; Wed, 31 Jan
	2024 01:02:25 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-14-65b99c21b3f7
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.8C.08648.12C99B56; Wed, 31 Jan 2024 10:02:25 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [RFC PATCH] cxl/region: Allow out of order assembly of
 autodiscovered regions
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Vishal
	Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
	Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, KyungSan Kim <ks0204.kim@samsung.com>, Hojin
	Nam <hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Zbh9BMbpjr/qtVjE@aschofie-mobl2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240131010224epcms2p859f54c3160adff7b18e57584dcc98aaa@epcms2p8>
Date: Wed, 31 Jan 2024 10:02:24 +0900
X-CMS-MailID: 20240131010224epcms2p859f54c3160adff7b18e57584dcc98aaa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmua7inJ2pBme/MFvcfXyBzWL61AuM
	FiduNrJZrL65htHiw5t/LBb7nz5nsVi18BqbxdE9HBbnZ51isbg14RiTA5dHy5G3rB6L97xk
	8ujbsorRY+rseo/Pm+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
	c1NtlVx8AnTdMnOAblJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX
	5qXr5aWWWBkaGBiZAhUmZGf0H3rDVnAtouL9jDbGBsa/IV2MnBwSAiYSy/ZuZAWxhQR2MEp8
	aJbrYuTg4BUQlPi7QxgkLCwQL7Fz5VkmiBI5ibu3TzFBxDUl3kxbxQJiswmoS/zoPMkE0ioi
	YCixYJpaFyMXB7PATyaJF/deMEGs4pWY0f6UBcKWlti+fCsjiM0poCex/tZ+qLiGxI9lvcwQ
	tqjEzdVv2WHs98fmM0LYIhKt985C1QhKPPi5GyouJfH1xF92kMUSAs2MEquP9bNCOA2MEh0z
	D0Nt0JdovP6eDcTmFfCV2LRgFtgkFgFViYtvzrKBfCAh4CKx/IUWSJhZQFti2cLXzCBhZqCH
	1+/Sh6hQljhyiwWigk+i4/BfdpgXd8x7AvWuksSUtiNQp0lINDRuZYOwPSQ+/zrINoFRcRYi
	oGch2TULYdcCRuZVjGKpBcW56anJRgWG8KhNzs/dxAhOnFrOOxivzP+nd4iRiYPxEKMEB7OS
	CO9KuZ2pQrwpiZVVqUX58UWlOanFhxhNgZ6cyCwlmpwPTN15JfGGJpYGJmZmhuZGpgbmSuK8
	91rnpggJpCeWpGanphakFsH0MXFwSjUwVdRl/kmdq8YuJZF+sH/T+j0PVv95GHvvyD8nkZJF
	cZfimmM2SypyfJxzPWTbpefdDZlzjeKlVmSxLSq+/6nD/c2Nn6xT7Z7Pdji2eHvjNDOXHz66
	Df+Pby9aeFvsp/bBoB3h8aYfNQ0qeG4sv9y4nv+7ddz0v0L7/87c133ifSz3GfHUk1XeTqE7
	ct6eYHI72f90sVFmIZ/v1HRhb5fNHjMlPHNnnH9ycxZrzPJK1nxTc7clbe/n/P0kLnNR+022
	WGLRwi8vIu6/nJTxff6FNJsZeR/WNMfr1XG/nfznaCsfc3oUy9HqM9dSC0wM/rVnHJRrn3fj
	+zup3Sc7p0+67pYuVn5J5OL1jemnDy+eeU+JpTgj0VCLuag4EQCjQwgbJQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240113050447epcas2p2097a5c49c1f0f9318ec4202843e169b8
References: <Zbh9BMbpjr/qtVjE@aschofie-mobl2>
	<20240113050421.1622533-1-alison.schofield@intel.com>
	<20240126085108epcms2p8bd88403c60851f769dd7b3ccb0755f05@epcms2p8>
	<CGME20240113050447epcas2p2097a5c49c1f0f9318ec4202843e169b8@epcms2p8>

On Mon, Jan 29, 2024 at 08:37:24PM -0800, Alison Schofield wrote:
> On Fri, Jan 26, 2024 at 05:51:08PM +0900, Wonjae Lee wrote:
> > Thank you for your quick response and sending the patch=21
> >
> > I'm very sorry for the delay in replying to your mail. It took some tim=
e to
> > reproduce test and check the issue.
> >
> > On Fri, Jan 12, 2024 at 09:04:21PM -0800, alison.schofield=40intel.com =
wrote:
> > > From: Alison Schofield <alison.schofield=40intel.com>
> > >
> > > Wonjae Lee,
> > >
> > > Here is the RFC Patch I mentioned in this thread:
> > > https://lore.kernel.org/linux-cxl/20240112092201epcms2p577b3c979bdc69=
4a370e5952edc091f68=40epcms2p5/
> > >
> > > This passes the cxl-test suite, so hoping no regression, but it needs
> > > to be tested with the required config: 2 memdevs connected to the sam=
e
> > > port, each memdev belongs to a different auto-region. Repeated attemp=
ts
> > > should hit the test case and emit this debug message upon success:
> > >=C2=A0=20dev_dbg(&cxlr_a->dev,=20=22allow=20out=20of=20order=20region=
=20ref=20alloc=5Cn=22);=0D=0A>=20>=20>=0D=0A>=20>=20>=20Failure=20will=20be=
=20the=20HPA=20order=20violation=20message.=0D=0A>=20>=20>=0D=0A>=20>=20>=
=20All=20reviewers=20&=20testers=20welcomed.=0D=0A>=20>=0D=0A>=20>=20After=
=20applying=20your=20patch=20to=20base-commit,=20I=20ran=20the=20same=20tes=
t=20I=20mentioned=20in=0D=0A>=20>=20the=20previous=20thread,=20and=20during=
=20the=20boot=20process,=20a=20null=20pointer=20dereference=0D=0A>=20>=20oc=
curs=20as=20shown=20below:=0D=0A>=20>=0D=0A>=20>=20thread:=20https://lore.k=
ernel.org/linux-cxl/ZaFn0dfaJ8iOi1UW=40aschofie-mobl2/T/=23t=0D=0A>=20>=20b=
ase-commit:=203601311593eb44d34f142b993cb6f38f9a7863b3=0D=0A>=20>=20dmesg=
=20log:=0D=0A>=20>=20=5B=5D=20cxl=20region0:=20region=20sort=20successful=
=0D=0A>=20>=20=5B=5D=20cxl=20region0:=20mem1:endpoint6=20decoder6.0=20add:=
=20mem1:decoder6.0=20=40=200=20next:=20none=20nr_eps:=201=20nr_targets:=201=
=0D=0A>=20>=20=5B=5D=20cxl=20region0:=20pci0000:3d:port1=20decoder1.0=20add=
:=20mem1:decoder6.0=20=40=200=20next:=20mem1=20nr_eps:=201=20nr_targets:=20=
1=0D=0A>=20>=20=5B=5D=20BUG:=20kernel=20NULL=20pointer=20dereference,=20add=
ress:=2000000000000002e8=0D=0A>=20>=20...=0D=0A>=20>=20=5B=5D=20Call=20Trac=
e:=0D=0A>=20>=20...=0D=0A>=20>=20=5B=5D=20=20?=20auto_order_ok+0x5f/0xb0=20=
=5Bcxl_core=5D=0D=0A>=20>=20=5B=5D=20=20cxl_region_attach_position+0x379/0x=
860=20=5Bcxl_core=5D=0D=0A>=20>=20=5B=5D=20=20cxl_region_attach+0x466/0x8b0=
=20=5Bcxl_core=5D=0D=0A>=20>=0D=0A>=20>=0D=0A>=20>=20To=20be=20specific,=20=
cxld_a=20in=20auto_order_ok()=20is=20NULL:=0D=0A>=20>=20=20=20=20=20cxld_a=
=20=3D=20cxl_region_find_decoder(port,=20cxlr_a);=20/*=20cxld_a=20=3D=3D=20=
NULL=20*/=0D=0A>=20>=0D=0A>=20>=20I've=20noticed=20that=20if=20I=20pass=20c=
xled=20as=20a=20function=20argument=20appropriately,=20and=20get=0D=0A>=20>=
=20cxld_a=20as=20shown=20below,=20the=20region=20initialization=20succeeds=
=20with=20the=20log=20=22cxl=0D=0A>=20>=20region0:=20allow=20out=20of=20ord=
er=20region=20ref=20alloc=22=20as=20you=20mention.=0D=0A>=20>=0D=0A>=20>=20=
=40=40=20-756,8=20+756,8=20=40=40=20static=20struct=20cxl_decoder=20*cxl_re=
gion_find_decoder(struct=20cxl_port=20*port,=0D=0A>=20>=20=20=20=20=20=20=
=20=20=20return=20to_cxl_decoder(dev);=0D=0A>=20>=20=20=7D=0D=0A>=20>=20-bo=
ol=20auto_order_ok(struct=20cxl_port=20*port,=20struct=20cxl_region=20*cxlr=
_a,=0D=0A>=20>=20-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20str=
uct=20cxl_region=20*cxlr_b)=0D=0A>=20>=20+bool=20auto_order_ok(struct=20cxl=
_port=20*port,=20struct=20cxl_endpoint_decoder=20*cxled,=0D=0A>=20>=20+=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20struct=20cxl_region=20*c=
xlr_a,=20struct=20cxl_region=20*cxlr_b)=0D=0A>=20>=20=20=7B=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20struct=20cxl_region_ref=20*cxl_rr;=0D=0A>=20>=20=20=
=20=20=20=20=20=20=20struct=20cxl_decoder=20*cxld_a,=20*cxld_b;=0D=0A>=20>=
=20=40=40=20-771,7=20+771,10=20=40=40=20bool=20auto_order_ok(struct=20cxl_p=
ort=20*port,=20struct=20cxl_region=20*cxlr_a,=0D=0A>=20>=20=20=20=20=20=20=
=20=20=20if=20(=21test_bit(CXL_REGION_F_AUTO,=20&cxlr_a->flags))=0D=0A>=20>=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20false;=0D=0A>=
=20>=0D=0A>=20>=20-=20=20=20=20=20=20=20cxld_a=20=3D=20cxl_region_find_deco=
der(port,=20cxlr_a);=0D=0A>=20>=20+=20=20=20=20=20=20=20if=20(port=20=3D=3D=
=20cxled_to_port(cxled))=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20cxld_a=20=3D=20&cxled->cxld;=0D=0A>=20>=20+=20=20=20=20=20=20=20el=
se=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20cxld_a=20=3D=
=20cxl_region_find_decoder(port,=20cxlr_a);=0D=0A>=20>=0D=0A>=20>=20I=20hop=
e=20this=20helps.=0D=0A>=0D=0A>=20Yes,=20this=20is=20very=20helpful=21=20Gl=
ad=20to=20have=20you=20trying=20it=20out.=0D=0A>=0D=0A>=20I=20think=20at=20=
this=20point=20we=20can=20call=20alloc_region_ref()=20with=20a=20known=20cx=
led=0D=0A>=20of=20this=20port=20and=20simply=20pass=20it=20on.=20I'm=20goin=
g=20to=20skip=20this=20if...else=20pattern,=0D=0A>=20and=20simply=20get=20c=
xld_a=20=3D=20&cxled->cxld;=0D=0A>=0D=0A>=20I=20think=20there=20may=20be=20=
opportunity=20for=20refinements=20in=20cxl_region_find_decoder()=0D=0A>=20a=
nd=20it's=20descendants,=20but=20it's=20not=20directly=20tied=20to=20this=
=20patch.=0D=0A>=0D=0A>=20Thanks,=0D=0A>=20Alison=0D=0A=0D=0AI'm=20glad=20i=
t=20was=20useful.=20I=20agree=20to=20change=20it=20in=20the=20direction=20y=
ou=20said.=0D=0ALooking=20forward=20to=20the=20patch=20:)=0D=0A=0D=0AThanks=
,=0D=0AWonjae=0D=0A=0D=0A>=0D=0A>=20>=0D=0A>=20>=20Thanks,=0D=0A>=20>=20Won=
jae=0D=0A>=20>=0D=0A>=20>=20>=20Begin=20commit=20log:=0D=0A>=20>=20>=20Auto=
discovered=20regions=20can=20fail=20to=20assemble=20if=20they=20are=20not=
=20discovered=0D=0A>=20>=20>=20in=20HPA=20decode=20order.=20The=20user=20wi=
ll=20see=20failure=20messages=20like:=0D=0A>=20>=20>=0D=0A>=20>=20>=20=5B=
=5D=20cxl=20region0:=20endpoint5:=20HPA=20order=20violation=20region1=0D=0A=
>=20>=20>=20=5B=5D=20cxl=20region0:=20endpoint5:=20failed=20to=20allocate=
=20region=20reference=0D=0A>=20>=20>=0D=0A>=20>=20>=20The=20check=20that=20=
is=20causing=20the=20failure=20helps=20the=20CXL=20driver=20enforce=0D=0A>=
=20>=20>=20a=20CXL=20spec=20mandate=20that=20decoders=20be=20committed=20in=
=20HPA=20order.=20The=0D=0A>=20>=20>=20check=20is=20needless=20for=20autodi=
scovered=20regions=20since=20their=20decoders=0D=0A>=20>=20>=20are=20alread=
y=20programmed.=20Trying=20to=20enforce=20order=20in=20the=20assembly=20of=
=0D=0A>=20>=20>=20these=20regions=20is=20useless=20because=20they=20are=20a=
ssembled=20once=20all=20their=0D=0A>=20>=20>=20member=20endpoints=20arrive,=
=20and=20there=20is=20no=20guarantee=20on=20the=20order=20in=0D=0A>=20>=20>=
=20which=20endpoints=20are=20discovered=20during=20probe.=0D=0A>=20>=20>=0D=
=0A>=20>=20>=20Keep=20the=20existing=20check,=20but=20for=20autodiscovered=
=20regions,=20allow=20the=0D=0A>=20>=20>=20out=20of=20order=20assembly=20af=
ter=20a=20sanity=20check=20that=20the=20lowered=20numbered=0D=0A>=20>=20>=
=20decoder=20has=20the=20lower=20HPA=20starting=20address.=0D=0A>=20>=20>=
=0D=0A>=20>=20>=20Signed-off-by:=20Alison=20Schofield=20<alison.schofield=
=40intel.com>=0D=0A>=20>=20>=20---=0D=0A>=20>=20>=C2=A0=20drivers/cxl/core/=
region.c=2034=20+++++++++++++++++++++++++++++++++-=0D=0A>=20>=20>=C2=A0=201=
=20file=20changed,=2033=20insertions(+),=201=20deletion(-)=0D=0A>=20>=20>=
=0D=0A>=20>=20>=20diff=20--git=20a/drivers/cxl/core/region.c=20b/drivers/cx=
l/core/region.c=0D=0A>=20>=20>=20index=200f05692bfec3..8770ebcae05d=2010064=
4=0D=0A>=20>=20>=20---=20a/drivers/cxl/core/region.c=0D=0A>=20>=20>=20+++=
=20b/drivers/cxl/core/region.c=0D=0A>=20>=20>=20=40=40=20-753,6=20+753,37=
=20=40=40=20static=20struct=20cxl_decoder=20*cxl_region_find_decoder(struct=
=20cxl_port=20*port,=0D=0A>=20>=20>=C2=A0=20return=20to_cxl_decoder(dev);=
=0D=0A>=20>=20>=C2=A0=20=7D=0D=0A>=20>=20>=0D=0A>=20>=20>=20+bool=20auto_or=
der_ok(struct=20cxl_port=20*port,=20struct=20cxl_region=20*cxlr_a,=0D=0A>=
=20>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20cxl_region=20*cxlr=
_b)=0D=0A>=20>=20>=20+=7B=0D=0A>=20>=20>=20+=20struct=20cxl_region_ref=20*c=
xl_rr;=0D=0A>=20>=20>=20+=20struct=20cxl_decoder=20*cxld_a,=20*cxld_b;=0D=
=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=20/*=0D=0A>=20>=20>=20+=C2=A0=20*=20All=
ow=20the=20out=20of=20order=20assembly=20of=20auto-discovered=20regions=20a=
s=0D=0A>=20>=20>=20+=C2=A0=20*=20long=20as=20correct=20decoder=20programmin=
g=20order=20can=20be=20verified.=0D=0A>=20>=20>=20+=C2=A0=20*=0D=0A>=20>=20=
>=20+=C2=A0=20*=20Per=20CXL=20Spec=203.1=208.2.4.20.12=20Committing=20Decod=
er=20Programming,=0D=0A>=20>=20>=20+=C2=A0=20*=20software=20must=20commit=
=20decoders=20in=20HPA=20order.=20Therefore=20it=20is=0D=0A>=20>=20>=20+=C2=
=A0=20*=20sufficient=20to=20sanity=20check=20that=20the=20lowered=20number=
=20decoder=0D=0A>=20>=20>=20+=C2=A0=20*=20has=20the=20lower=20HPA=20startin=
g=20address.=0D=0A>=20>=20>=20+=C2=A0=20*/=0D=0A>=20>=20>=20+=20if=20(=21te=
st_bit(CXL_REGION_F_AUTO,=20&cxlr_a->flags))=0D=0A>=20>=20>=20+=C2=A0=20=C2=
=A0=20return=20false;=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=20cxld_a=20=3D=
=20cxl_region_find_decoder(port,=20cxlr_a);=0D=0A>=20>=20>=20+=20cxl_rr=20=
=3D=20cxl_rr_load(port,=20cxlr_b);=0D=0A>=20>=20>=20+=20cxld_b=20=3D=20cxl_=
rr->decoder;=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=20if=20(cxld_b->id=20>=
=20cxld_a->id)=20=7B=0D=0A>=20>=20>=20+=C2=A0=20=C2=A0=20dev_dbg(&cxlr_a->d=
ev,=0D=0A>=20>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=22allow=20out=20=
of=20order=20region=20ref=20alloc=5Cn=22);=0D=0A>=20>=20>=20+=C2=A0=20=C2=
=A0=20return=20true;=0D=0A>=20>=20>=20+=20=7D=0D=0A>=20>=20>=20+=0D=0A>=20>=
=20>=20+=20return=20false;=0D=0A>=20>=20>=20+=7D=0D=0A>=20>=20>=20+=0D=0A>=
=20>=20>=C2=A0=20static=20struct=20cxl_region_ref=20*alloc_region_ref(struc=
t=20cxl_port=20*port,=0D=0A>=20>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20struct=20cxl_region=20*cxlr)=0D=0A>=20>=20>=C2=A0=20=7B=0D=0A>=20>=20>=
=20=40=40=20-767,7=20+798,8=20=40=40=20static=20struct=20cxl_region_ref=20*=
alloc_region_ref(struct=20cxl_port=20*port,=0D=0A>=20>=20>=C2=A0=20=C2=A0=
=20=C2=A0=20if=20(=21ip->res)=0D=0A>=20>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20continue;=0D=0A>=20>=20>=0D=0A>=20>=20>=20-=C2=A0=20=C2=A0=
=20if=20(ip->res->start=20>=20p->res->start)=20=7B=0D=0A>=20>=20>=20+=C2=A0=
=20=C2=A0=20if=20(ip->res->start=20>=20p->res->start=20&&=0D=0A>=20>=20>=20=
+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20(=21auto_order_ok(port,=20cxlr,=20iter=
->region)))=20=7B=0D=0A>=20>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20dev_dbg(&cxlr->dev,=0D=0A>=20>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=22%s:=20HPA=20order=20violation=20%s:%pr=20vs=
=20%pr=5Cn=22,=0D=0A>=20>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20dev_name(&port->dev),=0D=0A>=20>=20>=0D=0A>=20>=20>=20bas=
e-commit:=203601311593eb44d34f142b993cb6f38f9a7863b3=0D=0A>=20>=20>=20--=0D=
=0A>=20>=20>=202.37.3=0D=0A>=20>=20>=0D=0A>=0D=0A
