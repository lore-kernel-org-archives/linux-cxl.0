Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838321CD3F
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259088; cv=none; b=aIGWfmOmhHLqfxDqJTgTk7flH7a6Sl7rhrsP1fEBkjtn0xvbRluppvJg1tiPClhkYO1nnv2PHrliDa+sjt324gmX7J7AoETFVJRlJxVhrZBC2laJ3droaj8fMve0PhnTyDc0FyxdVosJVpD0wRsEPtT7/YCX7ad2UHmu6D1I/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259088; c=relaxed/simple;
	bh=5i7OZ0uWw65FzFtNSaWbXrkuq3MImjNQMB9Z0QNrhq8=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=F76JneEEDZP0+wdSQevE25wMFlxeaWWmvEv8LFe63R6PSnoCA8tGsIiMBQaJ701T/2XRzo8mTLqtsd39QGxP4o7O/MqI+vMWQAqA105yn+H6n7MsEGhD2UeyRFxXcVJKtJ94nToLz/sKXRHScXc7BhNlhibKFBLWqow3ByLOSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cVDZcy8D; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cVDZcy8D"
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240126085110epoutp02018c69ce5a484237dadd1a2ebe81f006~t2ZW729Gj1349413494epoutp02r
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 08:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240126085110epoutp02018c69ce5a484237dadd1a2ebe81f006~t2ZW729Gj1349413494epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706259071;
	bh=5i7OZ0uWw65FzFtNSaWbXrkuq3MImjNQMB9Z0QNrhq8=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=cVDZcy8DteS5DcjWI7MFdXH2rZKOyn5Z/IF9GsehOA7lzswqRKPofklmx+LSiV6Ch
	 ndZ1AzBci79AQfdC30qswctNDP2zyQERxm3H+uu/nsb3wXSX5dIPmUAQ1SziV/Fwkx
	 X6IpUzDKiXWBL+c32ETQ4JACD8Kc6ZWXPWUp6s74=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240126085110epcas2p3ea8ece45ba9f056dc12a927e108b30b4~t2ZWIfXok0234002340epcas2p3S;
	Fri, 26 Jan 2024 08:51:10 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.97]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TLryP3prgz4x9Px; Fri, 26 Jan
	2024 08:51:09 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-b2-65b3727d1ed8
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.9E.08648.D7273B56; Fri, 26 Jan 2024 17:51:09 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [RFC PATCH] cxl/region: Allow out of order assembly of
 autodiscovered regions
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: "alison.schofield@intel.com" <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Vishal
	Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
	Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, KyungSan Kim <ks0204.kim@samsung.com>, Hojin
	Nam <hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240113050421.1622533-1-alison.schofield@intel.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240126085108epcms2p8bd88403c60851f769dd7b3ccb0755f05@epcms2p8>
Date: Fri, 26 Jan 2024 17:51:08 +0900
X-CMS-MailID: 20240126085108epcms2p8bd88403c60851f769dd7b3ccb0755f05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmqW5t0eZUg6ZeSYu7jy+wWUyfeoHR
	4sTNRjaL1TfXMFp8ePOPxWL/0+csFqsWXmOzOLqHw+L8rFMsFrcmHGNy4PJoOfKW1WPxnpdM
	Hn1bVjF6TJ1d7/F5k1wAa1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5i
	bqqtkotPgK5bZg7QTUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLS
	vHS9vNQSK0MDAyNToMKE7IyWG+UF590rrl+8z9TA+NKli5GTQ0LAROLHwy3sXYxcHEICOxgl
	ps5eztLFyMHBKyAo8XeHMEiNsECMxKv9ZxhBbCEBOYm7t08xQcQ1Jd5MW8UCYrMJqEv86DwJ
	FhcRsJW4vH86E8hMZoGfTBIv7r1ggljGKzGj/SkLhC0tsX35VrChnAJOElffPGODiGtI/FjW
	ywxhi0rcXP2WHcZ+f2w+I4QtItF67yxUjaDEg5+7oeJSEl9P/AV7RkKgmVFi9bF+VgingVGi
	Y+ZhqM36Eo3X34Nt4xXwlXi3rQnMZhFQlVhw+hjUVBeJx8u2g01lFtCWWLbwNTMoVJiBXl6/
	Sx/ElBBQljhyiwWigk+i4/Bfdpgfd8x7AvWvksSUtiNQt0lINDRuhfrRQ+Lzr4NsExgVZyGC
	ehaSXbMQdi1gZF7FKJZaUJybnppsVGAIj9zk/NxNjODkqeW8g/HK/H96hxiZOBgPMUpwMCuJ
	8JqYbkwV4k1JrKxKLcqPLyrNSS0+xGgK9OVEZinR5Hxg+s4riTc0sTQwMTMzNDcyNTBXEue9
	1zo3RUggPbEkNTs1tSC1CKaPiYNTqoGJzVukJqq0jnn5quAEjjqVKTPelDYv1/iuzbau5Jhg
	wJbVnFOkW+YfadAqFU98vDN0CXdeeLvnvD1Hl208Ou9fQVSFqECpHr9q6+evjHyBMxl/6L3N
	XcMnwOnu7DrRsSFXYuKHw/Ha4vxMP7n+HqrI99R1W6DFP7H6+t2Trw22Wf+Zcry/+evsSXv1
	d/t/DkgOTv+oJB0QKCb1Y2pEjV9uVG2AS+CuxOUGH8t4Wp/Lnryver7rRficO1dT96Z5RpdN
	1/ga2BK2/yKTi5Ov6bP5atqXrzCo3Cr7EisZN0WtM6BLXE7giqDqvubJE8NtE+tM/eYIHHd/
	E8hdefKGHpOq7ZRJiu+ZAh685F3/TImlOCPRUIu5qDgRAD/Z7vMnBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240113050447epcas2p2097a5c49c1f0f9318ec4202843e169b8
References: <20240113050421.1622533-1-alison.schofield@intel.com>
	<CGME20240113050447epcas2p2097a5c49c1f0f9318ec4202843e169b8@epcms2p8>

Thank you for your quick response and sending the patch=21

I'm very sorry for the delay in replying to your mail. It took some time to
reproduce test and check the issue.

On Fri, Jan 12, 2024 at 09:04:21PM -0800, alison.schofield=40intel.com wrot=
e:
> From: Alison Schofield <alison.schofield=40intel.com>
>
> Wonjae Lee,
>
> Here is the RFC Patch I mentioned in this thread:
> https://lore.kernel.org/linux-cxl/20240112092201epcms2p577b3c979bdc694a37=
0e5952edc091f68=40epcms2p5/
>
> This passes the cxl-test suite, so hoping no regression, but it needs
> to be tested with the required config: 2 memdevs connected to the same
> port, each memdev belongs to a different auto-region. Repeated attempts
> should hit the test case and emit this debug message upon success:
>=C2=A0=20dev_dbg(&cxlr_a->dev,=20=22allow=20out=20of=20order=20region=20re=
f=20alloc=5Cn=22);=0D=0A>=0D=0A>=20Failure=20will=20be=20the=20HPA=20order=
=20violation=20message.=0D=0A>=0D=0A>=20All=20reviewers=20&=20testers=20wel=
comed.=0D=0A=0D=0AAfter=20applying=20your=20patch=20to=20base-commit,=20I=
=20ran=20the=20same=20test=20I=20mentioned=20in=0D=0Athe=20previous=20threa=
d,=20and=20during=20the=20boot=20process,=20a=20null=20pointer=20dereferenc=
e=0D=0Aoccurs=20as=20shown=20below:=0D=0A=0D=0Athread:=20https://lore.kerne=
l.org/linux-cxl/ZaFn0dfaJ8iOi1UW=40aschofie-mobl2/T/=23t=0D=0Abase-commit:=
=203601311593eb44d34f142b993cb6f38f9a7863b3=0D=0Admesg=20log:=0D=0A=5B=5D=
=20cxl=20region0:=20region=20sort=20successful=0D=0A=5B=5D=20cxl=20region0:=
=20mem1:endpoint6=20decoder6.0=20add:=20mem1:decoder6.0=20=40=200=20next:=
=20none=20nr_eps:=201=20nr_targets:=201=0D=0A=5B=5D=20cxl=20region0:=20pci0=
000:3d:port1=20decoder1.0=20add:=20mem1:decoder6.0=20=40=200=20next:=20mem1=
=20nr_eps:=201=20nr_targets:=201=0D=0A=5B=5D=20BUG:=20kernel=20NULL=20point=
er=20dereference,=20address:=2000000000000002e8=0D=0A...=0D=0A=5B=5D=20Call=
=20Trace:=0D=0A...=0D=0A=5B=5D=20=20?=20auto_order_ok+0x5f/0xb0=20=5Bcxl_co=
re=5D=0D=0A=5B=5D=20=20cxl_region_attach_position+0x379/0x860=20=5Bcxl_core=
=5D=0D=0A=5B=5D=20=20cxl_region_attach+0x466/0x8b0=20=5Bcxl_core=5D=0D=0A=
=20=0D=0A=20=0D=0ATo=20be=20specific,=20cxld_a=20in=20auto_order_ok()=20is=
=20NULL:=0D=0A=20=20=20=20cxld_a=20=3D=20cxl_region_find_decoder(port,=20cx=
lr_a);=20/*=20cxld_a=20=3D=3D=20NULL=20*/=0D=0A=20=0D=0AI've=20noticed=20th=
at=20if=20I=20pass=20cxled=20as=20a=20function=20argument=20appropriately,=
=20and=20get=0D=0Acxld_a=20as=20shown=20below,=20the=20region=20initializat=
ion=20succeeds=20with=20the=20log=20=22cxl=0D=0Aregion0:=20allow=20out=20of=
=20order=20region=20ref=20alloc=22=20as=20you=20mention.=0D=0A=20=0D=0A=40=
=40=20-756,8=20+756,8=20=40=40=20static=20struct=20cxl_decoder=20*cxl_regio=
n_find_decoder(struct=20cxl_port=20*port,=0D=0A=20=20=20=20=20=20=20=20retu=
rn=20to_cxl_decoder(dev);=0D=0A=20=7D=0D=0A-bool=20auto_order_ok(struct=20c=
xl_port=20*port,=20struct=20cxl_region=20*cxlr_a,=0D=0A-=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20struct=20cxl_region=20*cxlr_b)=0D=0A+bo=
ol=20auto_order_ok(struct=20cxl_port=20*port,=20struct=20cxl_endpoint_decod=
er=20*cxled,=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20st=
ruct=20cxl_region=20*cxlr_a,=20struct=20cxl_region=20*cxlr_b)=0D=0A=20=7B=
=0D=0A=20=20=20=20=20=20=20=20struct=20cxl_region_ref=20*cxl_rr;=0D=0A=20=
=20=20=20=20=20=20=20struct=20cxl_decoder=20*cxld_a,=20*cxld_b;=0D=0A=40=40=
=20-771,7=20+771,10=20=40=40=20bool=20auto_order_ok(struct=20cxl_port=20*po=
rt,=20struct=20cxl_region=20*cxlr_a,=0D=0A=20=20=20=20=20=20=20=20if=20(=21=
test_bit(CXL_REGION_F_AUTO,=20&cxlr_a->flags))=0D=0A=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20return=20false;=0D=0A=0D=0A-=20=20=20=20=20=20=
=20cxld_a=20=3D=20cxl_region_find_decoder(port,=20cxlr_a);=0D=0A+=20=20=20=
=20=20=20=20if=20(port=20=3D=3D=20cxled_to_port(cxled))=0D=0A+=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20cxld_a=20=3D=20&cxled->cxld;=0D=0A+=20=20=
=20=20=20=20=20else=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20cxld=
_a=20=3D=20cxl_region_find_decoder(port,=20cxlr_a);=0D=0A=0D=0AI=20hope=20t=
his=20helps.=0D=0A=0D=0AThanks,=0D=0AWonjae=0D=0A=0D=0A>=20Begin=20commit=
=20log:=0D=0A>=20Autodiscovered=20regions=20can=20fail=20to=20assemble=20if=
=20they=20are=20not=20discovered=0D=0A>=20in=20HPA=20decode=20order.=20The=
=20user=20will=20see=20failure=20messages=20like:=0D=0A>=0D=0A>=20=5B=5D=20=
cxl=20region0:=20endpoint5:=20HPA=20order=20violation=20region1=0D=0A>=20=
=5B=5D=20cxl=20region0:=20endpoint5:=20failed=20to=20allocate=20region=20re=
ference=0D=0A>=0D=0A>=20The=20check=20that=20is=20causing=20the=20failure=
=20helps=20the=20CXL=20driver=20enforce=0D=0A>=20a=20CXL=20spec=20mandate=
=20that=20decoders=20be=20committed=20in=20HPA=20order.=20The=0D=0A>=20chec=
k=20is=20needless=20for=20autodiscovered=20regions=20since=20their=20decode=
rs=0D=0A>=20are=20already=20programmed.=20Trying=20to=20enforce=20order=20i=
n=20the=20assembly=20of=0D=0A>=20these=20regions=20is=20useless=20because=
=20they=20are=20assembled=20once=20all=20their=0D=0A>=20member=20endpoints=
=20arrive,=20and=20there=20is=20no=20guarantee=20on=20the=20order=20in=0D=
=0A>=20which=20endpoints=20are=20discovered=20during=20probe.=0D=0A>=0D=0A>=
=20Keep=20the=20existing=20check,=20but=20for=20autodiscovered=20regions,=
=20allow=20the=0D=0A>=20out=20of=20order=20assembly=20after=20a=20sanity=20=
check=20that=20the=20lowered=20numbered=0D=0A>=20decoder=20has=20the=20lowe=
r=20HPA=20starting=20address.=0D=0A>=0D=0A>=20Signed-off-by:=20Alison=20Sch=
ofield=20<alison.schofield=40intel.com>=0D=0A>=20---=0D=0A>=C2=A0=20drivers=
/cxl/core/region.c=2034=20+++++++++++++++++++++++++++++++++-=0D=0A>=C2=A0=
=201=20file=20changed,=2033=20insertions(+),=201=20deletion(-)=0D=0A>=0D=0A=
>=20diff=20--git=20a/drivers/cxl/core/region.c=20b/drivers/cxl/core/region.=
c=0D=0A>=20index=200f05692bfec3..8770ebcae05d=20100644=0D=0A>=20---=20a/dri=
vers/cxl/core/region.c=0D=0A>=20+++=20b/drivers/cxl/core/region.c=0D=0A>=20=
=40=40=20-753,6=20+753,37=20=40=40=20static=20struct=20cxl_decoder=20*cxl_r=
egion_find_decoder(struct=20cxl_port=20*port,=0D=0A>=C2=A0=20return=20to_cx=
l_decoder(dev);=0D=0A>=C2=A0=20=7D=0D=0A>=0D=0A>=20+bool=20auto_order_ok(st=
ruct=20cxl_port=20*port,=20struct=20cxl_region=20*cxlr_a,=0D=0A>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20cxl_region=20*cxlr_b)=0D=0A>=20+=7B=
=0D=0A>=20+=20struct=20cxl_region_ref=20*cxl_rr;=0D=0A>=20+=20struct=20cxl_=
decoder=20*cxld_a,=20*cxld_b;=0D=0A>=20+=0D=0A>=20+=20/*=0D=0A>=20+=C2=A0=
=20*=20Allow=20the=20out=20of=20order=20assembly=20of=20auto-discovered=20r=
egions=20as=0D=0A>=20+=C2=A0=20*=20long=20as=20correct=20decoder=20programm=
ing=20order=20can=20be=20verified.=0D=0A>=20+=C2=A0=20*=0D=0A>=20+=C2=A0=20=
*=20Per=20CXL=20Spec=203.1=208.2.4.20.12=20Committing=20Decoder=20Programmi=
ng,=0D=0A>=20+=C2=A0=20*=20software=20must=20commit=20decoders=20in=20HPA=
=20order.=20Therefore=20it=20is=0D=0A>=20+=C2=A0=20*=20sufficient=20to=20sa=
nity=20check=20that=20the=20lowered=20number=20decoder=0D=0A>=20+=C2=A0=20*=
=20has=20the=20lower=20HPA=20starting=20address.=0D=0A>=20+=C2=A0=20*/=0D=
=0A>=20+=20if=20(=21test_bit(CXL_REGION_F_AUTO,=20&cxlr_a->flags))=0D=0A>=
=20+=C2=A0=20=C2=A0=20return=20false;=0D=0A>=20+=0D=0A>=20+=20cxld_a=20=3D=
=20cxl_region_find_decoder(port,=20cxlr_a);=0D=0A>=20+=20cxl_rr=20=3D=20cxl=
_rr_load(port,=20cxlr_b);=0D=0A>=20+=20cxld_b=20=3D=20cxl_rr->decoder;=0D=
=0A>=20+=0D=0A>=20+=20if=20(cxld_b->id=20>=20cxld_a->id)=20=7B=0D=0A>=20+=
=C2=A0=20=C2=A0=20dev_dbg(&cxlr_a->dev,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=22allow=20out=20of=20order=20region=20ref=20alloc=5Cn=22);=0D=
=0A>=20+=C2=A0=20=C2=A0=20return=20true;=0D=0A>=20+=20=7D=0D=0A>=20+=0D=0A>=
=20+=20return=20false;=0D=0A>=20+=7D=0D=0A>=20+=0D=0A>=C2=A0=20static=20str=
uct=20cxl_region_ref=20*alloc_region_ref(struct=20cxl_port=20*port,=0D=0A>=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20cxl_region=20*cxlr)=0D=
=0A>=C2=A0=20=7B=0D=0A>=20=40=40=20-767,7=20+798,8=20=40=40=20static=20stru=
ct=20cxl_region_ref=20*alloc_region_ref(struct=20cxl_port=20*port,=0D=0A>=
=C2=A0=20=C2=A0=20=C2=A0=20if=20(=21ip->res)=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20continue;=0D=0A>=0D=0A>=20-=C2=A0=20=C2=A0=20if=20(ip-=
>res->start=20>=20p->res->start)=20=7B=0D=0A>=20+=C2=A0=20=C2=A0=20if=20(ip=
->res->start=20>=20p->res->start=20&&=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20(=21auto_order_ok(port,=20cxlr,=20iter->region)))=20=7B=0D=0A>=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20dev_dbg(&cxlr->dev,=0D=0A>=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=22%s:=20HPA=20ord=
er=20violation=20%s:%pr=20vs=20%pr=5Cn=22,=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20dev_name(&port->dev),=0D=0A>=0D=0A>=
=20base-commit:=203601311593eb44d34f142b993cb6f38f9a7863b3=0D=0A>=20--=0D=
=0A>=202.37.3=0D=0A>
