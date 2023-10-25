Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB0381A8
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WptEUWoc"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63495A1
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 15:37:44 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231025223743usoutp018c68b5949eec207aa661edb10ccc6576~RereWOBse2621526215usoutp01H;
	Wed, 25 Oct 2023 22:37:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231025223743usoutp018c68b5949eec207aa661edb10ccc6576~RereWOBse2621526215usoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698273463;
	bh=odAuDXQsvT431G+Tw0+mJeMGY8yQA23ymGSC7TDR9zI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=WptEUWocJSK9aoJJ36FHXKRXFL0Tf5brOkAhij8r0jiYWuYLyR7fSGGH7vlsIrxan
	 YWGtjcOFmBBUl1SB7PgLu6kZRsnseSoEwCuztrWuBsbxg4WGre3+EPzuTLHoisZp6D
	 wAOGfUogrUORkN0SyyVZzRqSnyHWt6jl+ZdlBwsI=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231025223743uscas1p1a2179d6715799357c803d5d76644e120~RereJT5Rx0947409474uscas1p1J;
	Wed, 25 Oct 2023 22:37:43 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id BD.74.62237.7B899356; Wed,
	25 Oct 2023 18:37:43 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231025223742uscas1p1d4bb879a51387b08811d5ea4916a0348~Rerdv1Z3f3013830138uscas1p1w;
	Wed, 25 Oct 2023 22:37:42 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-49-653998b78887
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 64.65.31410.6B899356; Wed,
	25 Oct 2023 18:37:42 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 25 Oct 2023 15:37:40 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	25 Oct 2023 15:37:40 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Refactor logic around check_last_peer()
Thread-Topic: [PATCH] cxl/region: Refactor logic around check_last_peer()
Thread-Index: AQHZ+7KD8XRbpEWITUunMxlNnk7zR7BaWciAgAFL44A=
Date: Wed, 25 Oct 2023 22:37:40 +0000
Message-ID: <ZTmYswn9afRy/SCF@ubuntu>
In-Reply-To: <6538824b52349_7258329466@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49BB492BC007DC4A837EF9F3D71DBC2B@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzrOd3tMyxTDXresFpMn3qB0eL8rFMs
	Dkwei/e8ZPL4vEkugCmKyyYlNSezLLVI3y6BK+PR7X7WgvsCFbeuHWVrYHzG3cXIySEhYCLx
	uPM4excjF4eQwEpGiRkfetggnFYmiRcbVjPBVDW/uM8CkVjDKPHvzzRGkISQwCdGiQlnWSES
	yxglTv8+yQ6SYBPQlPh1ZQ1Yt4iAtsTEOQeZQWxmAWuJ/tNnwWxhAQ+JY1tOQNV4Svz/AWNb
	SXzdMZkFxGYRUJWY/2UO2DJeIHv5981gNZxA9TdaN7KB2IwCYhLfT0HsYhYQl7j1ZD7U1YIS
	i2bvYYawxST+7XrIBmErStz//pIdol5HYsHuT2wQtp3E1lW3GSFsbYllC18zQ+wVlDg58wkL
	RK+kxMEVN8AhISEwlUNi18ydUAtcJB7M2s0KYUtLTF9zGaohW2Ll+g6ggziA7AKJhiNBEGFr
	iYV/1jNNYFSZheTsWUhOmoXkpFlITpqF5KQFjKyrGMVLi4tz01OLjfNSy/WKE3OLS/PS9ZLz
	czcxAtPJ6X+HC3Yw3rr1Ue8QIxMH4yFGCQ5mJRHeSB+LVCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8hrYnk4UE0hNLUrNTUwtSi2CyTBycUg1MvN/PGl69Wb6vjq1O8HXMymqnvHNB13vzP7sG
	a2dWM9xO4pXXPejXMFlx6rLIhSVH5WRvnD2Tls9xsEbF0DHUvu/Es2DzAw2tLNPX8iYeOi7K
	L3dmlluRwcdzxa6WadWBa/uX3fSJOVv8lG1CjtDp8s8adhe+7Pp/8mwa05e3iY9ZmZjaihZ+
	O3NfaQW79c+XbLIaP3Zl3nxyUonBpn/LjITPL90cJ96ac2X2zztutsul+B1uTOLc9yXxru3D
	vPDI23/uzf/6d+KsXdvvGL6ZwPG11dnyYozfSSOLVRFzVzTc1ErU//p81fWohv6DB4sfXTUM
	Cvd9nvyI5cA5VWapoHQew/ojip4Tl/x3fnauQomlOCPRUIu5qDgRAHHUnX6WAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWS2cDsrLtthmWqQfMaTYvpUy8wWpyfdYrF
	gclj8Z6XTB6fN8kFMEVx2aSk5mSWpRbp2yVwZTy63c9acF+g4ta1o2wNjM+4uxg5OSQETCSa
	X9xn6WLk4hASWMUo8fTAU0YI5xOjxJ9HZ6Eyyxgl1rzuYgJpYRPQlPh1ZQ2YLSKgLTFxzkFm
	EJtZwFqi//RZMFtYwEPi2JYTUDWeEv9/wNhWEl93TGYBsVkEVCXmf5nDCGLzAtnLv29mglj2
	nlHiZMN6sAQnUPON1o1sIDajgJjE91MQi5kFxCVuPZnPBPGDgMSSPeeZIWxRiZeP/7FC2IoS
	97+/ZIeo15FYsPsTG4RtJ7F11W1GCFtbYtnC18wQRwhKnJz5hAWiV1Li4IobLBMYJWYhWTcL
	yahZSEbNQjJqFpJRCxhZVzGKlxYX56ZXFBvnpZbrFSfmFpfmpesl5+duYgTG4+l/h2N2MN67
	9VHvECMTB+MhRgkOZiUR3kgfi1Qh3pTEyqrUovz4otKc1OJDjNIcLErivHcfaKQKCaQnlqRm
	p6YWpBbBZJk4OKUamMoVZn/1LeqY4WJm/Ks0ryzg/az8Xs5LhcVHtm1Q2BDGdObUpqOnrKqD
	1y/+4swoUcVXxhwvPlHOSeVqFYf4ir31i9qFs8tml+x7NutD7sMj94T264bHbKmasX1LqmsE
	wzf3naZP3yXumt6y74PKCtd7K0XnLvWXPJkXcceX7ZzPvZenGR9UfU33NZk44c41TicpznPF
	l7R3Woif487YcfJlMtOdZd8Y95blLlfwOPDkIWMB0y5BxQiDNtv5wkz3l1x8pCvO45BZvGnb
	o6ZjxbtOcDTwKbPkydgEXH8eqse97H3S9it+jNvUfHtOWc7+OzWjpP2HbcG+VYzPplmcP/L7
	x5OoMC+NaQsFFAoP/VRiKc5INNRiLipOBABIkMe6NgMAAA==
X-CMS-MailID: 20231025223742uscas1p1d4bb879a51387b08811d5ea4916a0348
CMS-TYPE: 301P
X-CMS-RootMailID: 20231010194652uscas1p18968f3a66d8cbe6d76dd444aa3ec50aa
References: <CGME20231010194652uscas1p18968f3a66d8cbe6d76dd444aa3ec50aa@uscas1p1.samsung.com>
	<169696721124.1190606.18028412676865061799.stgit@bgt-140510-bm03.eng.stellus.in>
	<6538824b52349_7258329466@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Oct 24, 2023 at 07:49:47PM -0700, Dan Williams wrote:
>=20
> It turns out this patch fails cxl-region-sysfs.sh.
>=20
>     test/cxl-region-sysfs.sh: failed at line 94
>    =20
>     [   38.367581] check_last_peer: cxl region8: cxl_host_bridge.0:port4:=
 mem5:decoder15.1 pos 4 mismatched peer mem7:decoder17.0
>    =20
> This patch looked so appetizing that I really wanted it to be a bug in
> the test and not a bug in this patch, but I think it is the latter.
>=20
> > @@ -1111,20 +1111,17 @@ static int cxl_port_setup_targets(struct cxl_po=
rt *port,
> > =20
> >       cxlsd =3D to_cxl_switch_decoder(&cxld->dev);
> >       if (cxl_rr->nr_targets_set) {
> > -             int i, distance;
> > +             int i;
> > =20
> >               /*
> > -              * Passthrough decoders impose no distance requirements b=
etween
> > -              * peers
> > +              * Check if this endpoint's dport is already in the
> > +              * switch decoder's target list, and if so check that
> > +              * it is positioned correctly based on the switch's
> > +              * interleave.
> >                */
> > -             if (cxl_rr->nr_targets =3D=3D 1)
> > -                     distance =3D 0;
> > -             else
> > -                     distance =3D p->nr_targets / cxl_rr->nr_targets;
>=20
> This calculation is essentially doing the "top-down" version of the
> "bottom-up" position calculation Alison introduced in her proposed region
> assembly fixes:
>=20
>     for_each_parent_port(...)
>         pos =3D pos * parent_ways + parent_pos
>=20
> So in a x8 region across 2x HBs with 2x switches per HB. The "distance"
> of peers at the switch level is 4. This change makes that 2.
>=20
> Maybe the right conceptual cleanup is to still ditch this distance
> calculation based on "p->nr_targets / cxl_rr->nr_targets" and walk up
> from this port and multiply the local ways by all the ancestral ways,
> but as is this gets the answer with less steps (modulo all the work to
> build up @ep and @cxl_rr).

Thanks Dan. I'll run with that and push out a v2.=
