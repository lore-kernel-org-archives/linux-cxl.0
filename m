Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C59C8EA
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l/ydYODs"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C04512F
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 08:48:41 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231025154837usoutp02b58c77bae18488cd3519f44d2c6185c8~RZGSXXp1o1148211482usoutp02k;
	Wed, 25 Oct 2023 15:48:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231025154837usoutp02b58c77bae18488cd3519f44d2c6185c8~RZGSXXp1o1148211482usoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698248917;
	bh=KE2U02SdHCI+VWtHD20T4eqkXyEzNruUH8Sz3iMvf+s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=l/ydYODsqNIiyjmuvRVoYbDJREIxrB4P9wESEffFcAqVn+qwGDE0/a8JYJ2PwXRUU
	 uriet9DUFLhFzOr8VDocJpksHXtsDtyhgy0t8gEgTZEBERzrkw8IhiSq1likbqVhk8
	 6l3zgX2jXlp6GJfypkn4yLYmhO9u0HZ5Cqvh2b4Q=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231025154837uscas1p1cae01f5448696cea649e5d35c4ca92ac~RZGSSQltT1023410234uscas1p1P;
	Wed, 25 Oct 2023 15:48:37 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 61.9B.40279.5D839356; Wed,
	25 Oct 2023 11:48:37 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231025154837uscas1p1069676433e4a72f44dcf15270b62b2f5~RZGR5TMCo1039310393uscas1p1U;
	Wed, 25 Oct 2023 15:48:37 +0000 (GMT)
X-AuditID: cbfec36f-4cbfe70000009d57-bf-653938d5de36
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id F3.30.31410.4D839356; Wed,
	25 Oct 2023 11:48:37 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 25 Oct 2023 08:48:36 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	25 Oct 2023 08:48:36 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: use region (not root decoder) granularity
 for calculations
Thread-Topic: [PATCH] cxl/region: use region (not root decoder) granularity
	for calculations
Thread-Index: AQHZ+HE60VRkQwelP0mqMgNoFwajUrBaVbaAgADkKwA=
Date: Wed, 25 Oct 2023 15:48:36 +0000
Message-ID: <ZTk40lwwUPDjswqx@ubuntu>
In-Reply-To: <6538796bcd4cf_72583294d3@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DE473C001EEB0419D60734E8B858B8A@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzred2rFpapBu9vylhMn3qB0eL8rFMs
	Dkwei/e8ZPL4vEkugCmKyyYlNSezLLVI3y6BK2PvpCPsBbe5Krbd38TSwPiQo4uRk0NCwERi
	2+2pzF2MXBxCAisZJX4s/MQC4bQySXSv2M8KU7Vscz9UYg2jxL2WdVDOJ0aJG/unsIFUCQks
	Y5R4uckLxGYT0JT4dWUNE4gtIqAtMXHOQWYQm1nAWqL/9FkwW1ggVmLpiQPsEDVxEt+nfWWD
	sK0kVn5fBGazCKhKfFyxhQXE5gWyn364DRbnFPCUmHL9HFgvo4CYxPdTELuYBcQlbj2ZzwRx
	taDEotl7mCFsMYl/ux6yQdiKEve/v2SHqNeRWLD7ExuEbScx+9hZKFtbYtnC18wQewUlTs58
	wgLRKylxcMUNsOclBGZySKxu2Q0MIg4gx0Xiz91AiBppielrLkPVZ0usXN/BBFFSINFwJAgi
	bC2x8M96pgmMKrOQXD0LyUWzkFw0C8lFs5BctICRdRWjeGlxcW56arFRXmq5XnFibnFpXrpe
	cn7uJkZgMjn973D+Dsbrtz7qHWJk4mA8xCjBwawkwhvpY5EqxJuSWFmVWpQfX1Sak1p8iFGa
	g0VJnNfQ9mSykEB6YklqdmpqQWoRTJaJg1OqgYlN54VIwjVRIXtem/9r8vuZzvQ4tu24dMt/
	76vsFfPCu3p6nxx8/9bBYVnhCdnPPB6/2G9u2n3F8U9x1dv3uoZpqw8mXunNODrbhnehaMpH
	2dPtAYYWEd7OsW7B5Tb1DFpf9hheMOa1+9Y0kc1rPUNCkS77yUgeycNsHSol65nabVYX/N3Y
	nsiQHyeYLtb1csF7LutGkauBG976ij6tVJzy7EOfmFbcLpO1TGcO315WvPUSvzY7+zoBkzkb
	2rJ3TnXo3bVxRqF++jn2rSoJ751UmHOm3DS9FyVjHGj+vKTk3SOLnZsnbDvF2/rVmt2HW79i
	zyRLnpS9jW8qpZ1Xnk//yxsaOvmzmJObkN4sJZbijERDLeai4kQA8p42aZUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWS2cDsrHvVwjLV4NUJNovpUy8wWpyfdYrF
	gclj8Z6XTB6fN8kFMEVx2aSk5mSWpRbp2yVwZeyddIS94DZXxbb7m1gaGB9ydDFyckgImEgs
	29zP0sXIxSEksIpR4ujzLWwQzidGie2Nu9hAqoQEljFK/O7KArHZBDQlfl1ZwwRiiwhoS0yc
	c5AZxGYWsJboP30WzBYWiJU4fmQzO0RNnMSX3wcZIWwriZXfF4HNZBFQlfi4YgsLiM0LZD/9
	cBtq8X4miYVX94MVcQp4Sky5fg5sEKOAmMT3UxCLmQXEJW49mc8E8YKAxJI955khbFGJl4//
	sULYihL3v79kh6jXkViw+xMbhG0nMfvYWShbW2LZwtfMEEcISpyc+YQFoldS4uCKGywTGCVm
	IVk3C8moWUhGzUIyahaSUQsYWVcxipcWF+emVxQb56WW6xUn5haX5qXrJefnbmIERuPpf4dj
	djDeu/VR7xAjEwfjIUYJDmYlEd5IH4tUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rx3H2ikCgmk
	J5akZqemFqQWwWSZODilGpisUv9vaiuTeSD62/jnqxmNKt2Kz1/fUww1mTvl7SnN+jXVF53N
	K7ZMnuls811V+QHnAo38gHXzZ5/ZNn3frOajOx6L+yX9drOKc0z1UBGb9U6G5amydvGaw6nl
	m+ecnL5JMeR9WcxytdclUd/z3Bj/Fz16uzyTYWVB7NkZcSYWOZdz/kQGTY0/ab3qFftr57cc
	64Ql70pyHzDS+HiWt22br46XZ4Di191rJk8UOlQ6c711kGlwM3Os+1weZSHOGyrHX1RanF6Q
	zKUktO4q/7JDdQpydR2527kLOe92xz1P81jJ1+t8p7T/WDSb6pmVPNJnDDuuqHhunetuap21
	TdU/f7H79v82DOUcn8IObFBiKc5INNRiLipOBADLoRCINQMAAA==
X-CMS-MailID: 20231025154837uscas1p1069676433e4a72f44dcf15270b62b2f5
CMS-TYPE: 301P
X-CMS-RootMailID: 20231006162159uscas1p2b3ca1cd7a8371c20ac30b38cd70d65e7
References: <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
	<CGME20231006162159uscas1p2b3ca1cd7a8371c20ac30b38cd70d65e7@uscas1p2.samsung.com>
	<169660931834.684402.2774329392272976121.stgit@bgt-140510-bm03.eng.stellus.in>
	<6538796bcd4cf_72583294d3@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Oct 24, 2023 at 07:11:55PM -0700, Dan Williams wrote:
>=20
> So the reason I went looking for the interleave_granularity_store()
> version of the patch was only because this one when viewed in isolation
> has the problem that the root-decoder granularity can only be overridden
> to the region granularity when root-decoder interleave ways is 1.=20
>=20
> Is this assumed safe because interleave_granularity_store() is enforcing
> that regions must match root-decoder granularity? If "yes", then this
> likely wants a "/* See interleave_granularity_store() ... */" like
> comment to describe why this override is safe, if "no" then I am missing
> something.
=20
The answer is "yes". I'll add a comment in the v2.

> What I liked about the idea of putting this in
> interleave_granularity_store() is keeping all the simplification
> shortcuts and commentary in one place, in case the region interleave !=3D
> root-decoder interleave ban is lifted.
>=20
> I don't mind doing this fixup in cxl_port_setup_targets(), but would
> want the comment per above.

I also debated this after identifiying the 1-line code fix. This new
approach avoids the whole "effective_granularity" special case for the
root decoders for now at least. It would need to be revisited if we
support interleaved host-bridges with region IG < root IG in the future.=
