Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA128E0F
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LliCg5Oe"
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240104184333usoutp01b8557a99629a553f619802275eb973c5~nOSS8W-Z20311003110usoutp01k;
	Thu,  4 Jan 2024 18:43:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240104184333usoutp01b8557a99629a553f619802275eb973c5~nOSS8W-Z20311003110usoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704393813;
	bh=QbFHyHQVH4PHq9H02Ur9O5PmMvWjpd+AfoVfri1r5og=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=LliCg5OeYRfm8i36dEqoCSjc5TcnjBIkXGPjehiToOk/dyNzjrG0L8LeIIBW38sB3
	 dEI2pI5Ih6WFXIyXjqpxHDcypH5MzQXsYved/BY9R1oCrbc8TaniNd6bWt7seyilg8
	 ME7mYQktkcv++C/ZPluW6XS5TmcowlMhL14K3N/k=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240104184333uscas1p24078a45e39c24fda6f27aa783661b82f~nOSStQf172954229542uscas1p2i;
	Thu,  4 Jan 2024 18:43:33 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id 53.74.09550.55CF6956; Thu, 
	4 Jan 2024 13:43:33 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240104184333uscas1p1a644216d30002434c33ea57ff272fce8~nOSSeTnkG1628316283uscas1p1J;
	Thu,  4 Jan 2024 18:43:33 +0000 (GMT)
X-AuditID: cbfec370-933ff7000000254e-cb-6596fc55cb0f
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id F8.E9.09511.55CF6956; Thu, 
	4 Jan 2024 13:43:33 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Thu, 4 Jan 2024 10:43:32 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
	4 Jan 2024 10:43:32 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC] Add "uunit" unit testing framework for CXL code
Thread-Topic: [PATCH RFC] Add "uunit" unit testing framework for CXL code
Thread-Index: AQHaJujGLtImsgu5/E6TZ8871cwEbbDJ6SyAgACpwYCAAA5VgIAAEtyA
Date: Thu, 4 Jan 2024 18:43:32 +0000
Message-ID: <ZZb8U/FgJ2t1IqBT@ubuntu>
In-Reply-To: <ZZbsgXH8n7HgJ23N@aschofie-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC0B0975744ACB488C94C0587B238CAF@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzrOd3QP9NSDZ6/Uba4+/gCm8X0qRcY
	Lc7POsXiwOyxeM9LJo/Pm+QCmKK4bFJSczLLUov07RK4Mp4ceMpY0MtTcenFZ+YGxm2cXYzs
	HBICJhKbqrsYuTiEBFYySpxa8ZIVwmllkvh7diNTFyMHWM2TO1DxNYwS036fZoJwPjJKzHl2
	ihnCWcooseLkZcYuRk4ONgFNiV9X1oB1iwgYSiyYpgYSZhZIkzh85BgLiC0s4CFx6fhOJhBb
	RMBTYt6m2WwQtpvE83tbwWpYBFQkJvV0sYPYvAKqEhsWd7OAjOQU0JN48NAWJMwoICbx/dQa
	Jojx4hK3nswHsyUEBCUWzd7DDGGLSfzb9ZANwlaUuP/9JTtEvY7Egt2f2EBGMgvYSbzoEYUI
	a0ssW/iaGWKroMTJmU9YIFolJQ6uuMEC8q2EwFIOid9vvkLtcpE413QRqkhaYvqay1B2tsTK
	9R3QMCyQaDgSBBG2llj4Zz3TBEaVWUiunoXkolkIF81CctEsJBctYGRdxSheWlycm55abJyX
	Wq5XnJhbXJqXrpecn7uJEZhMTv87XLCD8datj3qHGJk4GA8xSnAwK4nwrl83OVWINyWxsiq1
	KD++qDQntfgQozQHi5I4r6HtyWQhgfTEktTs1NSC1CKYLBMHp1QD07R7Spcu31rSIWX1Ls54
	m+m8e003P/brPpGtLdj3a9V00+7EylvS/q9eBhz2rpjObuun/KKH5/OK0jbXo/HXm+fYnPRe
	1LNOvoCnf6a1QnnUVGuX8xeNNyZ7p39xu/KF6+vOr29sC1/Ni5IJFtz584yS9DPX9YcnuNZM
	07wYGXaXz6DgN1uRbZQqr+s6YSHuM+febe95Jhr9IfaCO+N0kZsSzZIxwbtZp295eixI/8b+
	My28W2pfMS+vei6eJ9MlnHqNO1Lt/BxHt+XmeQVrpiSkTFNY4FG2XnN9/N+QdUJvczVSWdjW
	8FV6SMYsqXJ0NbsYJbl794RZlQFqPZzfjv28PLHXNezfjBnXnI+eVWIpzkg01GIuKk4EAIFN
	C/eVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWS2cDsrBv6Z1qqwbQdIhZ3H19gs5g+9QKj
	xflZp1gcmD0W73nJ5PF5k1wAUxSXTUpqTmZZapG+XQJXxpMDTxkLenkqLr34zNzAuI2zi5GD
	Q0LAROLJHdYuRi4OIYFVjBK/P31lgnA+Mko0fbgMlVnKKHGmdTmQw8nBJqAp8evKGiaQbhEB
	Q4kF09RAwswCaRKHjxxjAbGFBTwkLh3fyQRiiwh4SszbNJsNwnaTeH5vK1gNi4CKxKSeLnYQ
	m1dAVWLD4m4WiF2TmSTOPF3GAjKfU0BP4sFDW5AaRgExie+n1jBB7BKXuPVkPpgtISAgsWTP
	eWYIW1Ti5eN/rBC2osT97y/ZIep1JBbs/sQGMpJZwE7iRY8oRFhbYtnC18wQJwhKnJz5hAWi
	VVLi4IobLBMYJWYh2TYLyaRZCJNmIZk0C8mkBYysqxjFS4uLc9Mrio3zUsv1ihNzi0vz0vWS
	83M3MQLj8fS/wzE7GO/d+qh3iJGJg/EQowQHs5II7/p1k1OFeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ8959oJEqJJCeWJKanZpakFoEk2Xi4JRqYNKXbNhzebu3t0izsCvfapfeZPuio28TZ9w4
	Z3Vwo1HO0g3na3fcqj8ps3WBp4Lgh/5v4dnGiyNvl/JJ8t9c5jJfu5iX/fe2HfeWLRZqK1ux
	1FzJW9em+qkNV839vHMLXXzXLQ7raJJ/JWztvdFk9+6s5ZPSmxtWC9Z8vV8puY2Xf/qUekH/
	nMq1S+LPNbteeeYTGSHitqErVPhk07b9GVcCSv//YliY9SXUrTzR7u2EPaUy/UeljTdVFMvf
	ijKuzP5y9VX3k54D51a0njz0Rtxj57Q7b2rmGnY7bNGpFfy29pFjudd2ptXmh5xzQif01SxL
	mcMUyOx998ec56zf8/4x5b6fr7vgca1bfXfefiWW4oxEQy3mouJEANUnAjk2AwAA
X-CMS-MailID: 20240104184333uscas1p1a644216d30002434c33ea57ff272fce8
CMS-TYPE: 301P
X-CMS-RootMailID: 20231204193337uscas1p24b1959cf528b02b8172736a61807fff1
References: <CGME20231204193337uscas1p24b1959cf528b02b8172736a61807fff1@uscas1p2.samsung.com>
	<170171841563.162223.2230646078958595847.stgit@ubuntu>
	<65965214f008e_8dc68294d0@dwillia2-xfh.jf.intel.com.notmuch>
	<ZZbgewv5l5LMmrTk@ubuntu> <ZZbsgXH8n7HgJ23N@aschofie-mobl2>

On Thu, Jan 04, 2024 at 09:36:01AM -0800, Alison Schofield wrote:
> On Thu, Jan 04, 2024 at 04:44:57PM +0000, Jim Harris wrote:
>=20
> Hi Jim,
>=20
> Looks really useful, cutting to the part about the individual unit tests.=
...
>=20
>=20
> > > > 4) Improve cxl_region tests to cover error conditions and add exten=
sive
> > > >    comments explaining how the topology is being built. This overla=
ps with #3.
> > >=20
> > > Some comments on the simple tests would help too just to get folks
> > > ramped about what's going on.
> >=20
> > Ack. The comments are absolutely critical and I should have added them =
in the
> > v1. They'll be in the v2.
>=20
> As you might imagine, the first thing I'd like to do with this is try
> to spin up a simple unit test that matches something I do with cxl_test,
> then grow from there.
>=20
> Coming to this with cxl_test experience, it would be helpful if you
> can draw, comment on some parallels - even to the point of showing,
> here' what cxl/test: cxl-topology.sh (or similar) looks like in CUunit.
>=20
> It would be helpful to separate into multiple patches showing what needed
> to be done to add a specific unit test. I'm assuming to add core_region_u=
t.c
> support was added elsewhere in cxl/uunit/*.  Separate patches would make
> that dependeny clear and help in mimicing the process of adding a new
> test.
>=20
> I'll try it out on next posting!
> Thanks,
> Alison
=20
Good idea Alison. I'll take a look at this before I send out the next rev.

-Jim=
