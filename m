Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F67F
	for <linux-cxl@vger.kernel.org>; Wed,  1 Nov 2023 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nSDpIuc7"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E124DA
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 22:12:50 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231101051248usoutp02fb0986fbc366b00a916ce40e475ae090~TZ8JBiTWK3232832328usoutp02F;
	Wed,  1 Nov 2023 05:12:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231101051248usoutp02fb0986fbc366b00a916ce40e475ae090~TZ8JBiTWK3232832328usoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698815568;
	bh=izXK6UGCnJMDSJ2epngJocc+stynRg6lBTVVF+oBodE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=nSDpIuc7p/3ZHrt/rwDHKvqK0nL90r33BSuk4Xfe634ZlBwQX75l3x4JBbL/uqFkf
	 1C0gQf5hjWUlYj9jaOpVtrIl9Br6+YALVwdJ3shmpZaoK4qFMOFwZhARYeuAtASHCT
	 wfpJ6aiM5w6N+11c+EGhI2GHHuk1MWAm6YEec2Fg=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231101051247uscas1p1a06ca1388d64884aabde1d4a1478916f~TZ8IaA5v_1365613656uscas1p1F;
	Wed,  1 Nov 2023 05:12:47 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id F5.30.62237.F4ED1456; Wed, 
	1 Nov 2023 01:12:47 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231101051247uscas1p1bd4fd16062fbeb6eb65eb87381254cbf~TZ8Hu4cqb1365613656uscas1p1E;
	Wed,  1 Nov 2023 05:12:47 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-85-6541de4f42c5
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 1B.3E.28590.E4ED1456; Wed, 
	1 Nov 2023 01:12:46 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Tue, 31 Oct 2023 22:12:46 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
	31 Oct 2023 22:12:46 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Refactor logic around check_last_peer()
Thread-Topic: [PATCH] cxl/region: Refactor logic around check_last_peer()
Thread-Index: AQHZ+7KD8XRbpEWITUunMxlNnk7zR7BaWciAgAFL44CACdxfAA==
Date: Wed, 1 Nov 2023 05:12:46 +0000
Message-ID: <ZUHeTLZb+od8q4EE@ubuntu>
In-Reply-To: <ZTmYswn9afRy/SCF@ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C36EBD6E21D5148BD15FE1215E6FF54@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzreV3/e46pBg1fNCymT73AaHF+1ikW
	ByaPxXteMnl83iQXwBTFZZOSmpNZllqkb5fAlfH93THmgsdiFVe/fmNtYNwh0MXIySEhYCLx
	b8lD5i5GLg4hgZWMEiu6b7NAOK1MEu82LATKcIBVtTzQgIivYZRYunkVVMcnRolNe08xg4wS
	EljGKDFrjymIzSagKfHryhomEFtEQFti4pyDYDXMAtYS/afPgtnCAh4Sx7acgKrxlPj/A8Z2
	klg7eSqYzSKgInFt8UEmkCN4BVQlXk7WAQlzCqhJ7P8+nRHEZhQQk/h+CmIVs4C4xK0n85kg
	PhOUWDR7DzOELSbxb9dDNghbUeL+95fsEPU6Egt2f2KDsO0kzt19wAhha0ssW/garJcXaM7J
	mU9YIHolJQ6uuAEOIAmBuRwSNx51QSVcJM61/mWFsKUlrl6fCrU4W2Ll+g4mSCAWSDQcCYII
	W0ss/LOeaQKjyiwkZ89CctIsJCfNQnLSLCQnLWBkXcUoXlpcnJueWmycl1quV5yYW1yal66X
	nJ+7iRGYSk7/O1ywg/HWrY96hxiZOBgPMUpwMCuJ8B42dUgV4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzmtoezJZSCA9sSQ1OzW1ILUIJsvEwSnVwDTLaH1GzQszael7EZOc6q9H+0xa1XvxxsLQ
	+jJ5QcuF1UyR+75X+rI+advoq/fwj1fYciU2q53xkk82s6TXTDaxKjx78dG7DQ1m+ld/7Pk5
	3dtR4pPBfN/kfL+EbQdUb/m6l2yauSR6Fzfn7wP2wRmvSucnJEqsi3lXqFj+8Ca/9YnWT4sY
	dlkr37qxd7vDI+N/DIslT1Y88LmzuIT5lE3sqvcd87+mPonvbosXYl2z8b6LePXN22tE+nuj
	WuSu35988PD0H3UTek/l7yy0YVt8x2LDNt0NUzbuWFqZUaBikzwn8MOtoxkxlkZaHs+f6c3f
	9eN03hmVwzeLvh++1/2NrZqNadVtZeGeG4oHdLqUWIozEg21mIuKEwGaqYWjlAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWS2cDspOt3zzHVYNMhK4vpUy8wWpyfdYrF
	gclj8Z6XTB6fN8kFMEVx2aSk5mSWpRbp2yVwZXx/d4y54LFYxdWv31gbGHcIdDFycEgImEi0
	PNDoYuTiEBJYxSix/NwsdgjnE6PEvhuX2SCcZYwS+xecZO1i5ORgE9CU+HVlDROILSKgLTFx
	zkFmEJtZwFqi//RZMFtYwEPi2JYTUDWeEv9/wNhOEmsnTwWzWQRUJK4tPsgEcgWvgKrEy8k6
	ELu6mSSmbv7KBlLDKaAmsf/7dEYQm1FATOL7KYi9zALiEreezAezJQQEJJbsOc8MYYtKvHz8
	jxXCVpS4//0lO0S9jsSC3Z/YIGw7iXN3HzBC2NoSyxa+BuvlFRCUODnzCQtEr6TEwRU3WCYw
	SsxCsm4WklGzkIyahWTULCSjFjCyrmIULy0uzk2vKDbMSy3XK07MLS7NS9dLzs/dxAiMxdP/
	DkfuYDx666PeIUYmDsZDjBIczEoivIdNHVKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8959oJEq
	JJCeWJKanZpakFoEk2Xi4JRqYJo695GQYlUFZyPzwtj7zAXlhtGGEkE305XYr4vsFoz6dVW+
	8vzEzL3XJoVqBt65/WvL+zfH5y0JsV4kKCG56+rcyymHTj654LRaO67xKOfXrMmlsyS+PPPt
	dbx9c++9zElpsyR8zlka2k/lM1+/0vi1C5fvimWMm7S/ZWqdaZpuO4G1TmuD/j+tM7wbl891
	/H9u2YVNay2v/Q+c5Gwd4CCoLVetEbAg3NtscoBs4qFvrMfUSyR43O9MfFkf4pTTzcJzpvXK
	z+3sBkrCxvu0Dx33ecG4yLK4m9up89vNRUefT/F6uHUKM9dlW53zQb/r5z1Y9sWzLGjf4zJt
	5tiA25WyUgKHzbbN0tVIuGJ5TV+JpTgj0VCLuag4EQBi3tuqNAMAAA==
X-CMS-MailID: 20231101051247uscas1p1bd4fd16062fbeb6eb65eb87381254cbf
CMS-TYPE: 301P
X-CMS-RootMailID: 20231010194652uscas1p18968f3a66d8cbe6d76dd444aa3ec50aa
References: <CGME20231010194652uscas1p18968f3a66d8cbe6d76dd444aa3ec50aa@uscas1p1.samsung.com>
	<169696721124.1190606.18028412676865061799.stgit@bgt-140510-bm03.eng.stellus.in>
	<6538824b52349_7258329466@dwillia2-xfh.jf.intel.com.notmuch>
	<ZTmYswn9afRy/SCF@ubuntu>

On Wed, Oct 25, 2023 at 10:37:40PM +0000, Jim Harris wrote:
> On Tue, Oct 24, 2023 at 07:49:47PM -0700, Dan Williams wrote:
> >=20
> > It turns out this patch fails cxl-region-sysfs.sh.
> >=20
> >     test/cxl-region-sysfs.sh: failed at line 94
> >    =20
> >     [   38.367581] check_last_peer: cxl region8: cxl_host_bridge.0:port=
4: mem5:decoder15.1 pos 4 mismatched peer mem7:decoder17.0
> >    =20
> > This patch looked so appetizing that I really wanted it to be a bug in
> > the test and not a bug in this patch, but I think it is the latter.
> >=20
> > > @@ -1111,20 +1111,17 @@ static int cxl_port_setup_targets(struct cxl_=
port *port,
> > > =20
> > >       cxlsd =3D to_cxl_switch_decoder(&cxld->dev);
> > >       if (cxl_rr->nr_targets_set) {
> > > -             int i, distance;
> > > +             int i;
> > > =20
> > >               /*
> > > -              * Passthrough decoders impose no distance requirements=
 between
> > > -              * peers
> > > +              * Check if this endpoint's dport is already in the
> > > +              * switch decoder's target list, and if so check that
> > > +              * it is positioned correctly based on the switch's
> > > +              * interleave.
> > >                */
> > > -             if (cxl_rr->nr_targets =3D=3D 1)
> > > -                     distance =3D 0;
> > > -             else
> > > -                     distance =3D p->nr_targets / cxl_rr->nr_targets=
;
> >=20
> > This calculation is essentially doing the "top-down" version of the
> > "bottom-up" position calculation Alison introduced in her proposed regi=
on
> > assembly fixes:
> >=20
> >     for_each_parent_port(...)
> >         pos =3D pos * parent_ways + parent_pos
> >=20
> > So in a x8 region across 2x HBs with 2x switches per HB. The "distance"
> > of peers at the switch level is 4. This change makes that 2.
> >=20
> > Maybe the right conceptual cleanup is to still ditch this distance
> > calculation based on "p->nr_targets / cxl_rr->nr_targets" and walk up
> > from this port and multiply the local ways by all the ancestral ways,
> > but as is this gets the answer with less steps (modulo all the work to
> > build up @ep and @cxl_rr).
>=20
> Thanks Dan. I'll run with that and push out a v2.

I played around with this idea. Walking up from this port is easy, but we
need the port's decoder to get the interleave_ways. That's easy too, we
can get the decoder by doing an xa_load() on the port's regions xarray
with the region pointer. Except that we don't attach region_refs to the
root decoder.

I have a locally-tested patch that attaches region_refs to the root decoder=
,
but it didn't seem warranted for just refactoring this function. So I pushe=
d
out a v2 that just renames "distance" to "ancestral_ways" and moved all
of the related calculations into check_last_peer() itself.=
