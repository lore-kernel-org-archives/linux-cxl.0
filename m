Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EB219FD
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ia8MWkwr"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE6E8E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 11:34:48 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231023183447usoutp0109ba69d7f89afbf734a5da82877aeca5~Q0EzHg6ra2390723907usoutp01j;
	Mon, 23 Oct 2023 18:34:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231023183447usoutp0109ba69d7f89afbf734a5da82877aeca5~Q0EzHg6ra2390723907usoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698086087;
	bh=4ruW/8YKdOn3Mvb4TtiEe3jNkFQmeNmAZYkaHfMQvkk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ia8MWkwrMMwnmhA4au0M5sB+6UwORI1dpcR4xu+aM9HOkt9b0agxFgNVTwUEFeD/u
	 MdxNlXZ70WtXK0i5WjhAT9KturAOeIidfRsdftDTAYKlnhCMBsm+DyizG0J/T7FZ+z
	 YH38TGcthTHrMsK6zaiuWv867nO9YSY7/ED0oD7k=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231023183447uscas1p16476c8ad7c7e3189588ab0bda81a9b99~Q0Ey8qu541381913819uscas1p1J;
	Mon, 23 Oct 2023 18:34:47 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id A7.61.50148.7CCB6356; Mon,
	23 Oct 2023 14:34:47 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231023183447uscas1p2287095d469b3c4d10375461fc791a61a~Q0EypU3MF1350113501uscas1p2t;
	Mon, 23 Oct 2023 18:34:47 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-c4-6536bcc74130
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 3C.0C.31410.6CCB6356; Mon,
	23 Oct 2023 14:34:47 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Mon, 23 Oct 2023 11:34:46 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
	23 Oct 2023 11:34:46 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: Re: [PATCH v2 2/3] cxl/region: Calculate a target position in a
 region interleave
Thread-Topic: [PATCH v2 2/3] cxl/region: Calculate a target position in a
	region interleave
Thread-Index: AQHZ//ZjoNEZoDoeNUe9qKDefgdX87BOtZGAgAl4Q4CAAAbHAA==
Date: Mon, 23 Oct 2023 18:34:46 +0000
Message-ID: <ZTa8xNpBybwUXyc/@ubuntu>
In-Reply-To: <ZTa3FTfSGEDHotqG@aschofie-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B6A1477ACB96E48B65095DA5B615EB8@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djX87rH95ilGvy8I25x9/EFNovpUy8w
	Wpy42chmsfrmGkaLP4d8LfY/fc5isWrhNTaL87NOsVjcmnCMyYHTo+XIW1aPxXteMnlMnV3v
	8XmTXABLFJdNSmpOZllqkb5dAlfGp6tn2QquCVd8PrmDqYFxinAXIyeHhICJxLdvM9m7GLk4
	hARWMkqsvLueFcJpZZJY92shSxcjB1jV0XXqEPE1jBI3DjYxQjifGCU2be5hg3CWMUpcmDmX
	GWQum4CmxK8ra5hAukUEDCUWTFMDqWEWuM8k0TVjORNIjbBAjER7z2owW0QgVuLizb+sELaT
	xI3da8DiLAKqEgsvvQWL8wLZLUu3gtmcAnoSX9tOgNUwCohJfD8FUc8sIC5x68l8JojfBCUW
	zd7DDGGLSfzb9ZANwlaUuP/9JTvIbcxAd67fpQ/RaifReqadHcJWlJjS/ZAdYq2gxMmZT1gg
	WiUlDq64wQLyi4TAHQ6J6Z/OsUMkXCR699yBmi8tMX3NZaiGbImV6zuYIKFYINFwJAgibC2x
	8M96pgmMKrOQXD0L4aJZSC6aheSiWUguWsDIuopRvLS4ODc9tdgwL7Vcrzgxt7g0L10vOT93
	EyMwQZ3+dzh3B+OOWx/1DjEycTAeYpTgYFYS4Z0dbpIqxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nNfQ9mSykEB6YklqdmpqQWoRTJaJg1OqgYn3w1XvCXVRPRcCPFjC1Wzqw9RFLctn52dlMUmE
	sllcXT49/CrD6xNrH6Y+XpVn+C+ELeUn0/qTpnuzw69UTrXZX1bwSe7/B9u0dhudLynnzp5b
	dPzc7YV8vjHOn46b9HHfnZs4S2JNwcMvrgK355myLm4QWv08/9rZlperDWTYY1LPLK05+GhN
	78Q7zwun5DmL5MV8Vb7PsbEi4drxZ+tW3U3ympG8+FQV56RHbm4dkvY75/8/wxjOLXxi6Y5H
	UZpXJfeH8L06ZfeLY4PWb6cbc04lCuY3ve3tvXUtY8d9t/CUea/kTxWqvu1L+9RRffRiyUpz
	xQeict+7KybzfejbeGD+w75gr/8sZgnB1+2VWIozEg21mIuKEwGv8YADvwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWS2cDspHt8j1mqwctrzBZ3H19gs5g+9QKj
	xYmbjWwWq2+uYbT4c8jXYv/T5ywWqxZeY7M4P+sUi8WtCceYHDg9Wo68ZfVYvOclk8fU2fUe
	nzfJBbBEcdmkpOZklqUW6dslcGV8unqWreCacMXnkzuYGhinCHcxcnBICJhIHF2n3sXIxSEk
	sIpRonl5LyOE84lR4tak9VDOMkaJVRc2sXYxcnKwCWhK/LqyhgmkW0TAUGLBNDWQGmaB+0wS
	XTOWM4HUCAvESLT3rAazRQRiJR58PscOYTtJ3Ni9BizOIqAqsfDSW7CZvEB2y9KtrBDLjjJJ
	3L40ASzBKaAn8bXtBFgDo4CYxPdTEM3MAuISt57MB7MlBAQkluw5zwxhi0q8fPyPFcJWlLj/
	/SU7yKHMQEev36UP0Won0XqmnR3CVpSY0v2QHeIGQYmTM5+wQLRKShxccYNlAqPELCTbZiFM
	moVk0iwkk2YhmbSAkXUVo3hpcXFuekWxcV5quV5xYm5xaV66XnJ+7iZGYHyf/nc4ZgfjvVsf
	9Q4xMnEwHmKU4GBWEuGdHW6SKsSbklhZlVqUH19UmpNafIhRmoNFSZz37gONVCGB9MSS1OzU
	1ILUIpgsEwenVAPT9AmzhJ2d98p+DrYzPawuvM3i1ozilPXFiv9VT9evkrWbcX3+9T9iYjnM
	3G9CDiQUsJ61yjB5ERt64MyZHXlMORzvxZL+iEzL8fp/hu3Tostpqyd/LGswPLtb30BRof3Z
	0pZlFxe7Mq3hfbhdo2mLVUmYvJmPrbDx3LUvw9T/7j/yXtjtWl5jx06D4hc/3dsfT2qsvlHw
	uN9zq9cejfKvKtLPJRUfCk6RSFRTY7lcZBDbsmqHX7p3QNgkUY0pazlunb9xXyQuM7JwPjNn
	Ip8Is/yZ9bZfTh8P+DKzynphbNyewIuhbDF23wUMXO1XlCqsfabBUM/udazD/Pszq7echau2
	u2TvzFExyrhTyK7EUpyRaKjFXFScCACRtR4VXgMAAA==
X-CMS-MailID: 20231023183447uscas1p2287095d469b3c4d10375461fc791a61a
CMS-TYPE: 301P
X-CMS-RootMailID: 20231016060245uscas1p23496329ae374b981eaa6df84ac740624
References: <cover.1697433770.git.alison.schofield@intel.com>
	<CGME20231016060245uscas1p23496329ae374b981eaa6df84ac740624@uscas1p2.samsung.com>
	<80f80f0d26e73cd6941d8530163a4bbd731d50ec.1697433770.git.alison.schofield@intel.com>
	<07EBD33E-B7F5-4B77-A91F-6C81D9F759B7@ssi.samsung.com>
	<ZTa3FTfSGEDHotqG@aschofie-mobl2>

T24gTW9uLCBPY3QgMjMsIDIwMjMgYXQgMTE6MTA6MjlBTSAtMDcwMCwgQWxpc29uIFNjaG9maWVs
ZCB3cm90ZToNCj4gT24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMDU6MzM6NTRQTSArMDAwMCwgSmlt
IEhhcnJpcyB3cm90ZToNCj4gPiANCj4gPiA+IE9uIE9jdCAxNSwgMjAyMywgYXQgMTE6MDLigK9Q
TSwgYWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb20gd3JvdGU6DQo+ID4gPiANCj4gPiA+ICsgaWYg
KHAtPm5yX3RhcmdldHMgIT0gcC0+aW50ZXJsZWF2ZV93YXlzKQ0KPiA+ID4gKyByZXR1cm4gMDsN
Cj4gPiANCj4gPiBUaGVyZSBpcyBjb2RlIGp1c3QgYmVmb3JlIHRoaXMgdGhhdCBjb21wYXJlcyBu
cl90YXJnZXRzIGFuZCBpbnRlcmxlYXZlX3dheXMNCj4gPiBiZWZvcmUgY2FsbGluZyBjeGxfcmVn
aW9uX3NldHVwX3RhcmdldHMoKS4NCj4gPiANCj4gPiBEZWNvZGVyIGZpZWxkcyBhcmUgc2V0IGJl
dHdlZW4gdGhhdCBjb21wYXJpc29uIGFuZCBoZXJlLCBidXQgSSBzZWUgbm8gcmVhc29uDQo+ID4g
dGhlc2UgZmllbGRzIHNob3VsZG7igJl0IGJlIHNldCBiZWZvcmUgdGhhdCBlYXJsaWVyIGNvbXBh
cmlzb24uIEl0IGFjdHVhbGx5DQo+ID4gbWFrZXMgdGhlIGNvZGUgbW9yZSBjb25zaXN0ZW50LCBv
dGhlcndpc2UgaW4gdGhlIGNhc2Ugd2hlcmUNCj4gPiBjeGxfcmVnaW9uX3NldHVwX3RhcmdldHMo
KSBmYWlscywgdGhlIGZpcnN0IG4tMSBkZWNvZGVycyBoYXZlIHRoZWlyIGZpZWxkcw0KPiA+IHNl
dCwgYnV0IHRoZSBsYXN0IG9uZSB3b3VsZCBub3QuDQo+ID4gDQo+ID4gVGhlbiB0aGlzIHJldHVy
biAwIGNhbiBqdXN0IGJlIGFuIGVsc2UgY2xhdXNlIG9uIHRoZSBlYXJsaWVyIGNvbXBhcmlzb24u
DQo+ID4gDQo+IA0KPiBJIHNlZSB3aGF0IHlvdSBtZWFuIGFuZCBteSBmaXJzdCB0aG91Z2h0IHdh
cyAnc3VyZSB0aGlzIGNvdWxkIGJlIGEgbGl0dGxlDQo+IGNsZWFudXAgYmVmb3JlIHRoaXMgcGF0
Y2gnLCBidXQgdGhlbiBJIHN0cnVnZ2xlIHRvIGp1c3RpZnkgaXQuIFRob3NlIGZpcnN0DQo+IG4t
MSBkZWNvZGVycyBoYXZlIGl3LGlnLGhwYSBmaWVsZHMgc2V0IGJlY2F1c2Ugd2UgaGFkIGhvcGUg
dGhhdCB0aGlzIHJlZ2lvbg0KPiB3b3VsZCBjcmVhdGUuIE9uIHRoZSBsYXN0IGRlY29kZXIsIGlz
IHRoZXJlIGFueSB2YWx1ZSBpbiBzZXR0aW5nIHVwIHRoZQ0KPiBkZWNvZGVyIHdoZW4gd2Uga25v
dyBpdCdzIGEgZmFpbGVkIHNldHVwPw0KPiANCj4gDQoNCkkgaGF2ZSBhIHBhdGNoIG91dHN0YW5k
aW5nIGluIHRoaXMgc2FtZSBhcmVhLCB3aGljaCBtYXkgcHJvdmlkZSBzb21lDQphZGRpdGlvbmFs
IGNvbnRleHQuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8xNjk3MDM1ODkx
MjAuMTIwMjAzMS4xNDY5NjEwMDg2NjUxODA4MzgwNi5zdGdpdEBiZ3QtMTQwNTEwLWJtMDMuZW5n
LnN0ZWxsdXMuaW4vDQoNCkkgdGhpbmsgdGhlIHZhbHVlIGlzIHRoYXQgdGhlIGFsbCBvZiB0aGUg
ZGVjb2RlcnMgZ2V0IHRyZWF0ZWQgdGhlIHNhbWUuDQpOb3RlIHRoYXQgYmVmb3JlIHRoZSBucl90
YXJnZXRzID09IGludGVybGVhdmVfd2F5cyBjaGVjaywgaXQgc2V0cw0KY3hsZWQtPnBvcywgYXMg
d2VsbCBhcyBwdXQgdGhlIGRlY29kZXIgaW4gdGhlIHRhcmdldHMgYXJyYXkgYW5kDQppbmNyZW1l
bnRzIHRoZSBucl90YXJnZXRzLg0KDQpCdXQgdWx0aW1hdGVseSBteSBzdWdnZXN0ZWQgY2hhbmdl
cyBwcm9iYWJseSBiZWxvbmcgbW9yZSBpbiBteSBwYXRjaA0KKG9yIGEgZm9sbG93LXVwIHRvIG15
IHBhdGNoKSwgc28gSSB0aGluayBpdCdzIGZpbmUgdG8gc2tpcCBteQ0KZmVlZGJhY2sgb24gdGhp
cyBwYXJ0Lg0KDQpKaW0=
