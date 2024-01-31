Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12318623
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725828; cv=none; b=j6gzqr+fNs8MU4nH3rfO+NmnO7razS2z4EDjyqvF73fauk1KdauQDKxXNoASFrVGBqLiBB9ktuc9f9zkwhsaK3ykNgsAOeeAziNElvBqOOLkRgKneRAywnv6IU5qjEfRMvAa7qiad5GLagQhWUhWKC50T9s2f7uNZIcdE/odiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725828; c=relaxed/simple;
	bh=Qv+KC82u3pANALxmK/T4Yp9a9UU5CTAy2q7VbZy6rCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=E3RjThGBFI3bmZuvGnGd+7lDMaNjL36EZgoXp2pHHSyfd0xyo2QO9ROWng5UxJA2+nHt0DmH5ypyU4KYB4J7yCiYK8Jfn00VMqQGZznWoZ9gd20wQNWeINC/ExJtRKNVGxCBQahvjG/KfxZZPs5dRRbEgw+weu7JSVjIJUMEmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HOblABcp; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HOblABcp"
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240131182506usoutp022c78c36ffd5d3d76454922e1169f527c~vgc47j1cT3094130941usoutp02e;
	Wed, 31 Jan 2024 18:25:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240131182506usoutp022c78c36ffd5d3d76454922e1169f527c~vgc47j1cT3094130941usoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706725506;
	bh=Qv+KC82u3pANALxmK/T4Yp9a9UU5CTAy2q7VbZy6rCM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=HOblABcpEzi48rAUOd4NIZbmfFhem6RnkNeSC88xkFK1H4cFxGipl7erqLpigSyZh
	 rxwUDeh4uGajNM9MGnAsi88ZfWW7JMvxpfFPyOc7dKO2qLBp0etfc1CsjsEF6kq3Er
	 JOkmYKLi/4AJSiqoCWSNMYFEdXRTqVcARMqKE11c=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240131182506uscas1p27bee614658f74f3761196c79887581b1~vgc4wa2Ww2641926419uscas1p2H;
	Wed, 31 Jan 2024 18:25:06 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 8D.D6.09678.2809AB56; Wed,
	31 Jan 2024 13:25:06 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240131182505uscas1p29be7e31ab0ee12c6830abe3ba81c21e1~vgc4V8Ds42638026380uscas1p2L;
	Wed, 31 Jan 2024 18:25:05 +0000 (GMT)
X-AuditID: cbfec36d-acdff700000025ce-f4-65ba908237f8
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id C3.3A.45319.1809AB56; Wed,
	31 Jan 2024 13:25:05 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 31 Jan 2024 10:25:05 -0800
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
	31 Jan 2024 10:25:05 -0800
From: Adam Manzanares <a.manzanares@samsung.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Dan J Williams <dan.j.williams@intel.com>, Vincent Hache
	<vhache@rambus.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, Jim Harris
	<jim.harris@samsung.com>
Subject: Re: [RFC] Do we need dedicated LSF/MM/BPF 2024 session for CXL
 memory?
Thread-Topic: [RFC] Do we need dedicated LSF/MM/BPF 2024 session for CXL
	memory?
Thread-Index: AQHaNOkARQUJUPDPLEi0/9AZZUmXVLDI5umAgBJXRoCAGcO2gA==
Date: Wed, 31 Jan 2024 18:25:04 +0000
Message-ID: <a9b88177-7bbf-4ba1-9501-5f3d20f32c47@nmtadam.samsung>
In-Reply-To: <2A177BF8-36F9-4E7D-B353-404F1113ED0E@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <810860413756864183D3DEADD035A9D3@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djXc7pNE3alGrx8J2gxfeoFRovVN9cw
	WqxaeI3N4vysUywWn7bMZrJ4uUPVgc3j4Po3LB4tR96yeize85LJ4+O55yweU2fXe3zeJBfA
	FsVlk5Kak1mWWqRvl8CVsa3nFlPBOaGKky+OszQwThDqYuTgkBAwkfhxM7GLkYtDSGAlo8Sz
	J2fYIZxWJomZy7+wdTFyghU1bVzBCpFYwyjx/PsGdpCEkMAnRome2/IQ9jKg9h4xEJtNwEDi
	9/GNzCC2iICWxOx9U5hAmpkF1jBJTPy6nREkISwQKHFjwxeooiCJOX87GSFsJ4nHjfeYQGwW
	AVWJK48Pgi3jBYr/7XkHVsMpYC9x+8V5sDijgJjE91NrwOqZBcQlbj2ZzwRxtaDEotl7mCFs
	MYl/ux5CfaMocf/7S3aQ95kFNCXW79KHaLWTWLx0PguErSgxpfsh1FpBiZMzn7BAtEpKHFxx
	gwXkFwmBGxwSq55ugkq4SJy/v4UVwpaW+Ht3GdQN+RK72q5A3VAhcfV1N9QN1hIL/6xnmsCo
	MgvJ2bMQTpqF5KRZSE6aheSkBYysqxjFS4uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQLT0ul/
	h3N3MO649VHvECMTB+MhRgkOZiUR3pVyO1OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrankwW
	EkhPLEnNTk0tSC2CyTJxcEo1ME36OW/DrUc/Z6n3rlh4+YxF5u75OosZzr0LONVhZuB8qu2i
	llFQ2bITSy7+9H6jGNglFn40Pmf17dsLtnOuXNAavEnmUnZ/Zo3XekUxzTbBiZ3GMx+/k7P7
	fFkw4szPJC2BomC17c/UVzcWWR9Nyn3iHry47tS06ZPMJzxksr3Nlrzh9vniA63mz3ZWvdAW
	e5hl/urjGcfX3ZWfT+wRuaO+kfGAQny/vsTrKeyzapPkEm9zRthxpB80qL7hcCXz5WslT16x
	zR4e7GZsJuLrJrV58Ex77MBwW3gq4+kMlXNl/1ftFsnkjJsQcHHfqgK3atYDOWaHVmltbvyl
	3HezP24ec7VzbX79jedO/ZrnHyuxFGckGmoxFxUnAgC+m67uugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWS2cDsrNs4YVeqQeNXA4vpUy8wWqy+uYbR
	YtXCa2wW52edYrH4tGU2k8XLHaoObB4H179h8Wg58pbVY/Gel0weH889Z/GYOrve4/MmuQC2
	KC6blNSczLLUIn27BK6MbT23mArOCVWcfHGcpYFxglAXIyeHhICJRNPGFaxdjFwcQgKrGCVm
	L7nNDJIQEvjEKLF5pg1EYhmjRNv9mUwgCTYBA4nfxzeCFYkIaEnM3jeFCaSIWWANk8TEr9sZ
	QRLCAoESNzZ8gSoKkrj44hI7hO0k8bjxHtggFgFViSuPD4LFeYHif3veMUJsa2CSODvpIVgR
	p4C9xO0X58GKGAXEJL6fWgMWZxYQl7j1ZD4TxA8CEkv2nGeGsEUlXj7+xwphK0rc//4SqJcD
	qF5TYv0ufYhWO4nFS+ezQNiKElO6H0LdIChxcuYTFohWSYmDK26wTGCUmIVk2yyESbOQTJqF
	ZNIsJJMWMLKuYhQvLS7OTa8oNspLLdcrTswtLs1L10vOz93ECIzr0/8OR+9gvH3ro94hRiYO
	xkOMEhzMSiK8K+V2pgrxpiRWVqUW5ccXleakFh9ilOZgURLnvftAI1VIID2xJDU7NbUgtQgm
	y8TBKdXA5PErZP6Zd9HNZdtnzOw2Cf9k9unER9GH58Tffm+7xdrf5fHK9LZ/fanNvWUnNyWV
	HZs74/ufKd/EC8+0Km4OWzbtIqNHlNrPf83iszcvf/tha8vPWZk+rzmvVx54zKebYbZ0z0Wt
	09zbXpf1nPt9NZNtjX/HQ5Wd7tyPxUQ8heXvLE62mxwxV+2xjdmmm8qL2zbkNKirt95t3p1Z
	de7/rgu3pbsrdgTcvOTNcGTi1J2M4fer9rCJvhF+0t08SetDQtw15UuVnoYLOy2F/7/9+ivu
	88XGjGhOt9ZXavqTgjRKI98uW36Jo1xbJNf5h/08gU2/M9Z9id26/6T4+7M/854XCN/68OqQ
	jcQxx1t8+dOVWIozEg21mIuKEwH8/4o9WgMAAA==
X-CMS-MailID: 20240131182505uscas1p29be7e31ab0ee12c6830abe3ba81c21e1
CMS-TYPE: 301P
X-CMS-RootMailID: 20231222151028uscas1p1fa4d0282844f4aaa36b1133c5df17c9c
References: <CGME20231222151028uscas1p1fa4d0282844f4aaa36b1133c5df17c9c@uscas1p1.samsung.com>
	<42978BEA-D194-41F4-A619-BAF02CE8F4FF@dubeyko.com>
	<59dfe08b-cd17-410e-b549-7fb277340a21@nmtadam.samsung>
	<2A177BF8-36F9-4E7D-B353-404F1113ED0E@dubeyko.com>

T24gTW9uLCBKYW4gMTUsIDIwMjQgYXQgMTE6NTg6MDNBTSArMDMwMCwgVmlhY2hlc2xhdiBEdWJl
eWtvIHdyb3RlOg0KPiANCj4gDQo+ID4gT24gSmFuIDMsIDIwMjQsIGF0IDc6NTMgUE0sIEFkYW0g
TWFuemFuYXJlcyA8YS5tYW56YW5hcmVzQHNhbXN1bmcuY29tPiB3cm90ZToNCj4gPiANCj4gPiBP
biBGcmksIERlYyAyMiwgMjAyMyBhdCAwNjoxMDoyMVBNICswMzAwLCBWaWFjaGVzbGF2IER1YmV5
a28gd3JvdGU6DQo+ID4+IEhlbGxvLA0KPiA+PiANCj4gPj4gRG8gd2UgbmVlZCBkZWRpY2F0ZWQg
TFNGL01NL0JQRiAyMDI0IHNlc3Npb24gZm9yIENYTCBtZW1vcnk/DQo+ID4+IEFueSBjb21tZW50
cz8NCj4gPiANCj4gPiBXZSBhcmUgc3RhcnRpbmcgdG8gc3BlbmQgYSBiaXQgbW9yZSB0aW1lIGxv
b2tpbmcgYmV5b25kIHRoZQ0KPiA+IENYTCBkcml2ZXIgY29kZSwgc3BlY2lmaWNhbGx5IGludGVy
bGVhdmluZyBhbmQgdGllcmluZyBpbg0KPiA+IHRoZSBjb250ZXh0IG9mIENYTCBhdHRhY2hlZCBt
ZW1vcnkuIEl0IHdvdWxkIGJlIGdyZWF0IHRvIA0KPiA+IGNhcnZlIG91dCB0aW1lIHRvIGdldCBp
bnRlcmVzdGVkIHBhcnRpZXMgaW4gdGhlIHNhbWUgcm9vbS4NCj4gPiANCj4gPj4gDQo+ID4+IEhp
IERhbiwNCj4gPj4gDQo+ID4+IEkgYmVsaWV2ZSB3ZSBuZWVkIHNvbWUgdGFsayB0byBzdW1tYXJp
emU6DQo+ID4+ICgxKSB3aGF0IHdlIGFjaGlldmVkIGR1cmluZyAyMDIzIHllYXIsDQo+ID4+ICgy
KSB3aGF0IFRPRE9zIHdlIGhhdmUNCj4gPj4gKDMpIGV0Yy4NCj4gPj4gDQo+ID4+IFdoYXQgZG8g
eW91IHRoaW5rPw0KPiA+PiANCj4gPj4gSGkgQWRhbSwNCj4gPj4gDQo+ID4+IEkgYXNzdW1lIGl0
IHdpbGwgYmUgZ29vZCB0byBoZWFyIHdoYXQgaXMgY29va2luZyBvbiBoYXJkd2FyZSB2ZW5kb3Li
gJlzIHNpZGUNCj4gPj4gaW4gdGhlIENYTCBtZW1vcnkgYXJlYS4gQ291bGQgd2UgaGF2ZSBzb21l
IHN1bW1hcnkgcmVsYXRlZCB0byB0aGlzDQo+ID4+IChvZiBjb3Vyc2UsIHdoYXQgY2FuIGJlIHNo
YXJlZCB3aXRoIG9wZW4tc291cmNlIGNvbW11bml0eSk/IEhvdyBkbyB5b3UNCj4gPj4gZmVlbCBh
Ym91dCBpdD8NCj4gPiANCj4gPiBJIHdvdWxkIGJlIG1vcmUgdGhhbiBoYXBweSB0byBnaXZlIGFu
IHVwZGF0ZSBmcm9tIGEgZGV2aWNlIHZlbmRvciBwZXJzcGVjdGl2ZS4gDQo+ID4gVGhlcmUgd2Vy
ZSBzZXZlcmFsIHB1YmxpYyBkZW1vbnN0cmF0aW9ucyBvZiBDWEwgZGV2aWNlcyBpbiB0aGUgcGFz
dCB5ZWFyIGFuZA0KPiA+IGl0IHdvdWxkIGJlIGdyZWF0IGlmIHdlIGNvdWxkIGdldCByZXByZXNl
bnRhdGlvbiBmcm9tIG90aGVyIENYTCBkZXZpY2UgdmVuZG9ycw0KPiA+IHRvIHNoYXJlIHVwZGF0
ZXMgd2l0aCB0aGUgY29tbXVuaXR5Lg0KPiANCj4gTWF5YmUsIGRvIHdlIG5lZWQgdG8gc2hhcmUg
dGhpcyBhcyBhIHNwZWNpYWwgdG9waWM/IFdoYXQgZG8geW91IHRoaW5rPyBMZXTigJlzIGVsYWJv
cmF0ZQ0KPiBzb21lIGJldHRlciBleHBsYW5hdGlvbiBvZiBzdWdnZXN0ZWQgZGlzY3Vzc2lvbi4N
Cj4NCg0KU2VlIHRoZSBmb2xsb3dpbmcgdGhyZWFkOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzJiMjlkZDNkLWJiMmMtNmE4Yy05NGQyLWQ1YzJlMDM1NTE2YUBnb29nbGUuY29tL1QvDQoN
Ckl0IGNvdmVycyBtYW55IGFyZWFzIG9mIGNvbmNlcm4gZnJvbSB0aGUgbW0gcGVyc3BlY3RpdmUu
DQoNCg0KPiBUaGFua3MsDQo+IFNsYXZhLg0KPiA=
