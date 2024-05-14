Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F7219E8
	for <linux-cxl@vger.kernel.org>; Tue, 14 May 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689862; cv=none; b=CV4Fo2v2Xouzd7zaceWLq5No6d6HkNDAwO/b7aEJkGcLGJe0gjuFlpdsZvxXhI0jR8rNqzjwt04S1yfabJ9NERoMHN4NLtm4Yj4QkoeWBvUOuOapg2++1ButQurE4l/vhh/X9vzVU1CzQdECQf4gkrfy2PDPmDnVAjYG9MHO5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689862; c=relaxed/simple;
	bh=ZT8ajVFXrNSOhvGzGnPiGoGhqW2kdafZ41hLAy1iTzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=irNtK9t81io/2uGlmN/UPK67s21ntlpjbxrb6e4idYV4DVXVMH3qqS5wCOAtVC7etmc6zbqlmoRJNcDFF399FJiFyr4ipj98oAf4GBrBYPnCf26H79i9mWLqzyAiN7XiKGKHe8R8f4ctf1W/Xb5L9qAXGPyHNDWODQ3eRBQyJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GfoOPVJF; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GfoOPVJF"
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240514123053usoutp02d2ee1114dea0ba4f309110dd8dd556e2~PWtTSxoOz0542005420usoutp02C;
	Tue, 14 May 2024 12:30:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240514123053usoutp02d2ee1114dea0ba4f309110dd8dd556e2~PWtTSxoOz0542005420usoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715689853;
	bh=ZT8ajVFXrNSOhvGzGnPiGoGhqW2kdafZ41hLAy1iTzo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=GfoOPVJF0sW8rmQAaUTjeMRNOSuXXyQ5wnfIDdKEVJHkSu/j8l4aRBYTzlFnsqk92
	 hHWE5xMMcL7Mlx5HOj+Woa8EvZRQT7TA61ojr7Ow6AAQmY1+e4azjoIh02naGB2/ad
	 N8opcG6uSlbERjEq7XxTMkmfQp4yabEgjmrmm1nw=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240514123052uscas1p1b6c3ad98783cce36e53b0085d097d4dd~PWtS_SfrQ2209122091uscas1p1p;
	Tue, 14 May 2024 12:30:52 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id C0.D1.09749.C7953466; Tue,
	14 May 2024 08:30:52 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240514123052uscas1p181681f1e9a934a6ea4381bbbe9bfc5ff~PWtSqZM4I2213522135uscas1p1r;
	Tue, 14 May 2024 12:30:52 +0000 (GMT)
X-AuditID: cbfec36f-bebff70000002615-81-6643597cf86a
Received: from SSI-EX3.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 2D.EC.09521.C7953466; Tue,
	14 May 2024 08:30:52 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.35; Tue, 14 May 2024 05:30:51 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2507.035; Tue,
	14 May 2024 05:30:51 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Yiannis Nikolakopoulos <yi.nikolakop@gmail.com>, "mhocko@suse.com"
	<mhocko@suse.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Angelos Arelakis
	<angelos.arelakis@zptcorp.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"yiannis@zptcorp.com" <yiannis@zptcorp.com>
Subject: Re: [Resend LSF/MM/BPF TOPIC] A case of a CXL compressed memory
 tier
Thread-Topic: [Resend LSF/MM/BPF TOPIC] A case of a CXL compressed memory
	tier
Thread-Index: AQHapfQEV+Ggqu/dk0G7B6LpHZshr7GXHocA
Date: Tue, 14 May 2024 12:30:51 +0000
Message-ID: <29803911-8566-4fa5-b1d1-7e3def541d7c@nmtadam.samsung>
In-Reply-To: <CA+CExOi4v_8KM1ZA=ou3uZjpJDnMrJSsCVoWJcoBqbAequzH0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <2050F6BF0A5A5C42A0E765B2CB64C395@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djXc7o1kc5pBic6dSzOtl1kt5g+9QKj
	xf6nz1kszs86xWJxb81/Vot9r/cyW9zvc7D4vKyL3eLrnT4mB06PnbPusnss3vOSyWPTp0ns
	HpNvLGf0WL/lKovH501yHr3rX7EFsEdx2aSk5mSWpRbp2yVwZfyesoel4ARfxbV5xxgbGGfw
	dTFyckgImEhs+bKerYuRi0NIYCWjxOK5newQTiuTxIqm/UwwVavnLgWzhQTWMEqcOBUOUfSJ
	UWL+h6dQHcsYJf5f/8UKUsUmYCDx+/hGZhBbRGAio8SpH5EgRcwCO5kkPvT8A0sIC/hL3G3/
	A1UUIPH80jp2CNtIouPsYxYQm0VAVWLa8TYwm1fASWLq99lg9ZwCgRLdPSvAljEKiEl8P7UG
	7DxmAXGJW0/mQ50tKLFo9h5mCFtM4t+uh2wQtqLE/e8vgXZxANVrSqzfpQ9h2kks36ECMUVR
	Ykr3Q3aIrYISJ2c+YYHolJQ4uOIGC8grEgJfOCQe/VgJNd5F4vvXTVBF0hJXr0+FiudL7Gq7
	AmVXSFx93Q11grXEwj/rmSYwqsxCcvUshItmIVw0C8lFs5BctICRdRWjeGlxcW56arFRXmq5
	XnFibnFpXrpecn7uJkZgAjv973D+Dsbrtz7qHWJk4mA8xCjBwawkwutQaJ8mxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnNfQ9mSykEB6YklqdmpqQWoRTJaJg1OqgUnWcsVEpVVvmJ+80rngdNHt
	b96COdqB8+eH8TCGcMdxmSgxLW902c51NYX5ljybZN38uj8JQk/lvC/5B6cIHN9mNpHnwqaM
	94fOXMwoWrtG/4+Tixjbj43p+17GPF4tOnfFlNkP322o1Z13+VqdTl5BrOXVG5bPhV+8mSxy
	ovbOr2u/l6yNjetv81ypsyn3nmTFxv5jTk/a7hTd/F0c94Y/1/n4Uk/GbcnXDTv4Ww36Iz06
	3+9mt9u54SWX8gaj/dOUc1Q7brqvfpWYa1zwY8a8xWqxuidnejVF5LwKnz+Xv1j6UM/x5b4u
	jG0K3aEf5z+ICN0VJmEUZrbL/tXtgEkNtid4w0uSfNcaOotu3KrEUpyRaKjFXFScCADMUv7a
	zwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWS2cDspFsT6ZxmsO+lqMXZtovsFtOnXmC0
	2P/0OYvF+VmnWCzurfnParHv9V5mi/t9Dhafl3WxW3y908fkwOmxc9Zddo/Fe14yeWz6NInd
	Y/KN5Ywe67dcZfH4vEnOo3f9K7YA9igum5TUnMyy1CJ9uwSujN9T9rAUnOCruDbvGGMD4wy+
	LkZODgkBE4nVc5cydTFycQgJrGKUeN3wgh3C+cQocX7FbzYIZxmjxP9r15hAWtgEDCR+H9/I
	DGKLCExklDj1IxKkiFlgJ5PE7TUT2UASwgK+Ej3/Wxkhivwk2pd1s0DYRhIdZx+D2SwCqhLT
	jreB2bwCThJTv89mhti2hFFi9mGIDZwCgRLdPStYQWxGATGJ76fWgF3BLCAucevJfCaIJwQk
	luw5zwxhi0q8fPyPFcJWlLj//SXQPxxA9ZoS63fpQ5h2Est3qEBMUZSY0v2QHeIEQYmTM5+w
	QHRKShxccYNlAqPELCTLZiEMmoUwaBaSQbOQDFrAyLqKUby0uDg3vaLYMC+1XK84Mbe4NC9d
	Lzk/dxMjMP5P/zscuYPx6K2PeocYmTgYDzFKcDArifA6FNqnCfGmJFZWpRblxxeV5qQWH2KU
	5mBREue9+0AjVUggPbEkNTs1tSC1CCbLxMEp1cCk1C+2RUyS69bkL77P4lT2T0+cviDH6t/+
	srL3143LljvJBBiKhUQtuvUzy92x4oSHhtrG6pIoaQnxd2Ks1XMnBHF+VnfJnNCxuf2RVHrw
	bY1pKYIVIn+l1Ddqh3QELlut7an3pH2GVpwd31qLZoNVl+LUGx5cF09906vXbHDob7Mkcyvb
	k4YVlhe+y4qvyayV65Hqvmb24MaBRSJ+Z2K+7fM3tlzSMEktYWsVX/cb978HeZ58niC7LKx3
	wzav8pC7y//Pfcv4mWdfvJSYvL/dzoKrcusEcpev+xfvZr/9XH4JS5Pm/Q1r/6x+c3bnjZ7N
	Ap82PVlqpHjwWQqbkbP/BM6JAT/tYgO4zdL3RymxFGckGmoxFxUnAgBO8s5NbgMAAA==
X-CMS-MailID: 20240514123052uscas1p181681f1e9a934a6ea4381bbbe9bfc5ff
CMS-TYPE: 301P
X-CMS-RootMailID: 20240514114400uscas1p1e3b27c6da724deb16bf86e4052f29fe4
References: <CGME20240514114400uscas1p1e3b27c6da724deb16bf86e4052f29fe4@uscas1p1.samsung.com>
	<CA+CExOi4v_8KM1ZA=ou3uZjpJDnMrJSsCVoWJcoBqbAequzH0g@mail.gmail.com>

T24gVHVlLCBNYXkgMTQsIDIwMjQgYXQgMDE6NDM6MjlQTSArMDIwMCwgWWlhbm5pcyBOaWtvbGFr
b3BvdWxvcyB3cm90ZToNCj4gSGVsbG8gYWxsLA0KPiANCj4gVGhpcyBpcyBhbG1vc3QgbGl0ZXJh
bGx5IGxhc3QgbWludXRlIGFuZCB0aGUgd29yayBpdHNlbGYgaXMgb25seQ0KPiBnZXR0aW5nIHN0
YXJ0ZWQuIEJ1dCBzaW5jZSBJJ20gdmlydHVhbGx5IGF0dGVuZGluZywgSSB0aG91Z2h0IHRvIGdp
dmUNCj4gaXQgYSBzaG90IGluIGNhc2UgaXQgaXMgb2YgaW50ZXJlc3QuDQo+IA0KPiBCYWNrZ3Jv
dW5kOiBhdCBaZXJvUG9pbnQgVGVjaG5vbG9naWVzIHdlIGFyZSBkZXZlbG9waW5nIGlubGluZSBt
ZW1vcnkNCj4gY29tcHJlc3Npb24gSVAuIEN1cnJlbnRseSB3ZSBhcmUgZm9jdXNpbmcgb24gQ1hM
IHR5cGUgMyBkZXZpY2VzDQo+IChtZW1vcnkgZXhwYW5kZXJzKSwgZWZmZWN0aXZlbHkgaW50cm9k
dWNpbmcgYSBjb21wcmVzc2VkIG1lbW9yeSB0aWVyDQo+IChpLmUuIGZ1bGZpbGxpbmcgdGhlIE9D
UCBzcGVjaWZpY2F0aW9uICZxdW90O0h5cGVyc2NhbGUgQ1hMIFRpZXJlZCBNZW1vcnkNCj4gRXhw
YW5kZXIgU3BlY2lmaWNhdGlvbuKAnSkuDQo+IA0KPiBUbyB1dGlsaXplIHRoZSBtZW1vcnkgc2F2
ZWQgZHVlIHRvIGNvbXByZXNzaW9uLCB3ZSBvdmVyc3Vic2NyaWJlIHRoZQ0KPiBEZXZpY2UgUGh5
c2ljYWwgQWRkcmVzcyBTcGFjZSAoRFBBKSBpbiBhZGRpdGlvbiB0byBzb21lIGN1c3RvbSAuaW8N
Cj4gaW50ZXJmYWNlcy4gSWYgdGhlcmUgaXMgaW50ZXJlc3QsIEkgd291bGQgYmUgZ2xhZCB0byBw
cmVzZW50IHRoZXNlDQo+IEFQSXMgYW5kIGhvdyB0aGUgaG9zdCdzIHBvaW50IG9mIHZpZXcgY2hh
bmdlcyBjb21wYXJlZCB0byBhICZxdW90O3R5cGljYWwmcXVvdDsNCj4gbWVtb3J5IHRpZXJpbmcg
c3lzdGVtLiBUaGUgZ29hbCB3b3VsZCBiZSB0byBnZXQgc29tZSBlYXJseSBmZWVkYmFjaw0KPiBh
bmQgZGlyZWN0aW9uIGZvciBvdXIgdXBzdHJlYW0gZHJpdmVyIGRldmVsb3BtZW50LCBiZWZvcmUg
d2Ugc3RhcnQNCj4gcHVzaGluZyB0aGUgZmlyc3QgUkZDcy4NCg0KSSBhbSBpbnRlcmVzdGVkIGlu
IHVuZGVyc3RhbmRpbmcgdGhlIGludGVyZmFjZXMgYW5kIGhvdyB0aGUgbWVtb3J5IHdpbGwgYmUN
CmNvbnN1bWVkIGFuZCBwcmVzZW50ZWQgYnkgdGhlIE1NIHN1YnN5c3RlbS4gSXQgaXMgbXkgdW5k
ZXJzdGFuZGluZyB0aGF0DQp3ZSBoYXZlIGEgMzAgbWluIHNsb3QgZm9yIENYTCByZWxhdGVkIHRv
cGljcyBvcGVuIHRoaXMgbW9ybmluZy4gSSB0aGluayB0aGlzIA0Kd291bGQgYmUgYSBnb29kIGZp
dC4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBZaWFubmlzIE5pa29sYWtvcG91bG9z
