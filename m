Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BBGIq20L"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258B91
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:11:18 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231213161115usoutp0116e7b53157769eaed60cfa7b4cc7716b~gcBCjWpfr1901219012usoutp01G;
	Wed, 13 Dec 2023 16:11:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231213161115usoutp0116e7b53157769eaed60cfa7b4cc7716b~gcBCjWpfr1901219012usoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702483875;
	bh=xaPLP6ApnuwljIufXh2tki031wg5Y8seTBPK59LA0aU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BBGIq20LiVmzBvCRlMCK/6nawIROUFccaPiSNiLrLlAM4+g84PwjDKmFu6e8l/mFn
	 L6/eUHOJTaKhfrKmzWyoM80DgWFgg6CMQf27k0TQII4tzwbQ0U8wfFk5wi2ZGw01PF
	 m/fHrRanmBnKvSOrcbGxyrUq+i5PDWCtuudU8zrA=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231213161115uscas1p2cb376eba0642aa89be9cd2978af97ce2~gcBCQycKa0980209802uscas1p2o;
	Wed, 13 Dec 2023 16:11:15 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 4C.82.09760.3A7D9756; Wed,
	13 Dec 2023 11:11:15 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231213161115uscas1p1909966a964a3a5816fb516940c9be047~gcBB8Lj2x0889108891uscas1p1u;
	Wed, 13 Dec 2023 16:11:15 +0000 (GMT)
X-AuditID: cbfec36f-561ff70000002620-4e-6579d7a3cec5
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id FF.A0.09511.2A7D9756; Wed,
	13 Dec 2023 11:11:15 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 13 Dec 2023 08:11:14 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	13 Dec 2023 08:11:14 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Brice Goglin <Brice.Goglin@inria.fr>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: fix "x9"->"x6" interleaving in a comment
Thread-Topic: [PATCH] cxl/region: fix "x9"->"x6" interleaving in a comment
Thread-Index: AQHaLd3W7lG41JQyfEmfUfXnLK6KvLCnFjqA
Date: Wed, 13 Dec 2023 16:11:14 +0000
Message-ID: <ZXknWzn13YG/6GKC@ubuntu>
In-Reply-To: <99e72815-2078-47e0-9276-4a6a9e8e82f9@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E6472B2A3AB726479BE44ABD0E03AA76@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzred3F1ytTDa4dU7D4dKOF2eL8rFMs
	Dkwek14cYvH4vEkugCmKyyYlNSezLLVI3y6BK+Pt8S0sBds4Kr50fWVuYGxh72Lk4JAQMJHY
	u7Soi5GLQ0hgJaNE39/3rBBOK5PEr92XGLsYOcGKVu7oZoJIrGGUuL9zCjuE84lRYsfkjewg
	VUICyxglpm0IALHZBDQlfl1ZwwRiiwhoSGx7+ZoNxGYWsJboP32WGcQWFvCUWPX8HTNEjZfE
	3aWPoOqNJI6d+g02k0VAVWL/z3YWkFN5gexJ/3JAwpwCNhL/Lv9lAbEZBcQkvp+CWMUsIC5x
	68l8JoijBSUWzd7DDGGLSfzb9ZANwlaUuP/9JTtEvZ7EjalToE6zk/h/djErhK0tsWzha7Be
	XqA5J2c+YYHolZQ4uOIGC8jvEgJzOSQ2HH7KCpFwkVj1fwrUAmmJ6WsuQzVkS6xc38EECeoC
	iYYjQRBha4mFf9YzTWBUmYXk7FlITpqF5KRZSE6aheSkBYysqxjFS4uLc9NTi43yUsv1ihNz
	i0vz0vWS83M3MQJTyel/h/N3MF6/9VHvECMTB+MhRgkOZiUR3pM7ylOFeFMSK6tSi/Lji0pz
	UosPMUpzsCiJ8xrankwWEkhPLEnNTk0tSC2CyTJxcEo1MHkvkvuc7eWfNn+RVkPmIYNA5eMy
	L46WruRfva9/Wtyna+dK9gsxZTa2HH40eVVXvWel9Y12tder9s91/nPpfE/fhInqZ41l/kUo
	d1ev/rzQteTeV2mtLzzqqrFS1Vp7l06aU8M5be+Zs4cNCw2PHnl1SUBvvTsni8E1BjGHWGGh
	1pYXleuP3/8UGy2rzcHXVOLyMvLl3zTLM3aNuYFmOUeTjLtW+DiqJB9s/LBj8nFvi+X15Vvu
	Cm6Y/s5X2atvIZvcnk+TXHRUuc7ae+ssEl12xlb7DftanYT+n4/sZRpjti+RSTj4W/r0hlm1
	6aztjoK1ItMTXkT5iAY/eMf74nlHTR6/iNBXZ4OSj0cdlFiKMxINtZiLihMBxn6iOpQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWS2cDspLv4emWqwenD7BafbrQwW5yfdYrF
	gclj0otDLB6fN8kFMEVx2aSk5mSWpRbp2yVwZbw9voWlYBtHxZeur8wNjC3sXYycHBICJhIr
	d3QzdTFycQgJrGKUeLxhATOE84lRov3BPnYIZxmjxKrLhxhBWtgENCV+XVnDBGKLCGhIbHv5
	mg3EZhawlug/fZYZxBYW8JRY9fwdM0SNl8TdpY+g6o0kjp36DbaaRUBVYv/PdpYuRg4OXiB7
	0r8ckLAQ0Jjjk5+BjeQUsJH4d/kvC4jNKCAm8f0UxFpmAXGJW0/mM0F8ICCxZM95ZghbVOLl
	43+sELaixP3vL9kh6vUkbkydAnWmncT/s4tZIWxtiWULX4P18goISpyc+YQFoldS4uCKGywT
	GCVmIVk3C8moWUhGzUIyahaSUQsYWVcxipcWF+emVxQb56WW6xUn5haX5qXrJefnbmIExuLp
	f4djdjDeu/VR7xAjEwfjIUYJDmYlEd6TO8pThXhTEiurUovy44tKc1KLDzFKc7AoifPefaCR
	KiSQnliSmp2aWpBaBJNl4uCUamCKq7ge0zZ5loFKSfbNhZwej1afvGAt/1enWSksV/yPxjS1
	PbvvxJ3adSbg4wZD/SbXrTE5UtvSeTouHlzS9Pa4ptvj6esn220/eM2/0femfb2+os8Pp7g/
	526+Pvqy9oea7gpjVbvvnkcuHH0YfPN0wP93ncGfHmzskbB3usPayTRDSc4zx9xGNXCu4lof
	PobEeZGKe5hefrD+/FpN+9qtMw9KIyymivBNL6+o3uBxebt//RnLIrElO4rU7vs/KThdphB7
	9es1j1vBq9uMVinN3HnyTgJbv2VL4vyO1zEeN9Xe1qaxWSixJHcKCGS/C/0f6ryse6HFh6Ux
	uwx0J5xmLE00ulHnvO+/WMHeIw+VWIozEg21mIuKEwGN4TwkNAMAAA==
X-CMS-MailID: 20231213161115uscas1p1909966a964a3a5816fb516940c9be047
CMS-TYPE: 301P
X-CMS-RootMailID: 20231213161115uscas1p1909966a964a3a5816fb516940c9be047
References: <99e72815-2078-47e0-9276-4a6a9e8e82f9@inria.fr>
	<CGME20231213161115uscas1p1909966a964a3a5816fb516940c9be047@uscas1p1.samsung.com>

On Wed, Dec 13, 2023 at 05:02:35PM +0100, Brice Goglin wrote:
> Signed-off-by: Brice Goglin <Brice.Goglin@inria.fr>
> ---
> =A0drivers/cxl/core/region.c | 2 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 56e575c79bb4..d99f6698168d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -397,7 +397,7 @@ static ssize_t interleave_ways_store(struct device *d=
ev,
> =A0=A0=A0=A0 =A0=A0=A0 return rc;
>=20
> =A0=A0=A0=A0 /*
> -=A0=A0=A0 =A0* Even for x3, x9, and x12 interleaves the region interleav=
e must be a
> +=A0=A0=A0 =A0* Even for x3, x6, and x12 interleaves the region interleav=
e must be a
> =A0=A0=A0=A0 =A0* power of 2 multiple of the host bridge interleave.
> =A0=A0=A0=A0 =A0*/
> =A0=A0=A0=A0 if (!is_power_of_2(val / cxld->interleave_ways) ||
> --=20
> 2.42.0
>=20
>=20

I've pushed this same patch out a few weeks ago.

https://lore.kernel.org/linux-cxl/169904271254.204936.8580772404462743630.s=
tgit@ubuntu/

Jim=
