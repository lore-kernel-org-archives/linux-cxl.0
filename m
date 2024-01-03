Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F91BDDE
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jan 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Plfp/CSw"
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240103165307usoutp01ca3e8c008993698434e7904911310d98~m5Ik9UqNp3033730337usoutp01E;
	Wed,  3 Jan 2024 16:53:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240103165307usoutp01ca3e8c008993698434e7904911310d98~m5Ik9UqNp3033730337usoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704300787;
	bh=TTWyKOTtwwA3jsZbTiD+dIrTZlOHIU5NcfLCvDpj3Pw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Plfp/CSwWylScdPSX8kV0zfhwSOz3UybC2xgdmsROWwdO9AzaA+Nd3m2A/JhVeE7g
	 9e5MZ1NX4VUP06U6HjOFgMcZEiybq5EkpqoCZ5kJYhYzqakVZz4hYISTWRq2+ZMOQ5
	 51f1G7vwONd53j2da92nvHwv2f7WPUp3+EwDq2qk=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240103165306uscas1p17e843c0bf2d9a89d3912a7d9b86350a5~m5Ik1yp0k1488014880uscas1p1k;
	Wed,  3 Jan 2024 16:53:06 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id AB.86.09678.2F095956; Wed, 
	3 Jan 2024 11:53:06 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240103165306uscas1p2793a38b1136b2c7bec48b87e8ce4ce21~m5Iki3YFL1338513385uscas1p2b;
	Wed,  3 Jan 2024 16:53:06 +0000 (GMT)
X-AuditID: cbfec36d-acdff700000025ce-e4-659590f2a4da
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 23.9C.09813.2F095956; Wed, 
	3 Jan 2024 11:53:06 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 3 Jan 2024 08:53:05 -0800
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
	3 Jan 2024 08:53:05 -0800
From: Adam Manzanares <a.manzanares@samsung.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Dan J Williams <dan.j.williams@intel.com>, "vhache@rambus.com"
	<vhache@rambus.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, Jim Harris
	<jim.harris@samsung.com>
Subject: Re: [RFC] Do we need dedicated LSF/MM/BPF 2024 session for CXL
 memory?
Thread-Topic: [RFC] Do we need dedicated LSF/MM/BPF 2024 session for CXL
	memory?
Thread-Index: AQHaNOkARQUJUPDPLEi0/9AZZUmXVLDI5umA
Date: Wed, 3 Jan 2024 16:53:05 +0000
Message-ID: <59dfe08b-cd17-410e-b549-7fb277340a21@nmtadam.samsung>
In-Reply-To: <42978BEA-D194-41F4-A619-BAF02CE8F4FF@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AC346A4A765DE46BF439FCB7F9FBC5C@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djXc7qfJkxNNXg039xi+tQLjBarb65h
	tFi18BqbxflZp1gsPm2ZzWTxcoeqA5vHwfVvWDxajrxl9Vi85yWTx8dzz1k8ps6u9/i8SS6A
	LYrLJiU1J7MstUjfLoEro3fFSZaCJwIVE671MjcwrhHoYuTkkBAwkVj1bhZLFyMXh5DASkaJ
	ni8rWSGcViaJA7vussJUnVnyHCqxhlFi5Zx37BDOR0aJSf+mQTlLGSU+vb7DDNLCJmAg8fv4
	RjBbREBLYva+KUwgNrPAJiaJPW8DQGxhgUCJGxu+QNUEScz528kIYRtJzOn4zAJiswioSEw/
	/ZANxOYVcJJYtmg10DIODk4Be4lJi61AwowCYhLfT62BGi8ucevJfCaIqwUlFs3ewwxhi0n8
	2wUxRkJAUeL+95dgY5gFNCXW79KHaLWT2HDmORuErSgxpfshO8RWQYmTM5+wQLRKShxccQMc
	XBICNzgknh58BjXfRWJN/2KoImmJv3eXQd2QL7Gr7QpUTYXE1dfdUDdYSyz8s55pAqPKLCRn
	z0I4aRaSk2YhOWkWkpMWMLKuYhQvLS7OTU8tNsxLLdcrTswtLs1L10vOz93ECExMp/8dzt3B
	uOPWR71DjEwcjIcYJTiYlUR416+bnCrEm5JYWZValB9fVJqTWnyIUZqDRUmc19D2ZLKQQHpi
	SWp2ampBahFMlomDU6qBaXbs5MR/StI79n1ZX/X5avDGRuHbn0tPWCovv+m5W/vwtkt8Yo0X
	Ex1b9/NWpjKvLN/8srOlS987MmGpRvKm7TqlFjvzZ5u5HPtbezTyXPTKfjGfq9Mup1w1d3T8
	8GTKl+d6rSfKf7AHnXnW9btk+rOGeFdpi9YtRnw5E/2/dEb2sUU1a69uXtrct3jG2qhGfZbj
	dwMSJe+ZP1SsZvbwc9q6eaZ7yCsXjRz5kMr1zOJ35v432Nd/7Nr081s8vN8EW/TaT1f++EBz
	w8mXYZM0C7aHv/G2F15v2cWo9fzpmu+8u5MjlgZ52r07lGe8OaLs3MeXFWWLDDWfT1Rx+D7n
	7e7/87R3M81hbLPe5G+QrsRSnJFoqMVcVJwIALWbHoW7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTURzHO/feXe+GwmmaHi0El0IZqVnSsLAwkFFRmppWUK28qajTdn1V
	lKOiUil0bkhz+NoMH7PpihAdpWaJrzSrobMsc6gLLV8laGjNa+R/n985v+/n9zscCue/Ityo
	eEkqLZWIEwUkj4iX4Yd2zuYpab+bgwJhobIPCGsGdUBYXWYihb2qTkI4+7QIE1obvA6Sohb9
	JCG63TbFEWmMVkw082acECmLskRzBvdQ8jRvfwydGJ9OS32DzvPi7ld2ECkWmJlnuo/LgA7m
	AC6F4B7UrR3n5AAexYfVAGn1CpwtZgAqyL4F2KICoNHfhbgtQkI/tNRev8pO0BsVPVdgNsah
	AUPGqVAbO8IwNFA3v9ZzAr2d6Ldj2R+p780RNiagJyrsGiFt7ACD0aPymtUePpQD9L4kOAdQ
	FBceQHJNoO0YQGe00KlbG+WCzJYSjH0BRFpjL87yJmQdXeaw7IE+L1jtbBocbkf6Rl82GoTq
	usdJlj2QInfEjt1gI+p4aCHYqCtqqRwg8gBSrZum+m9SrTOp1plU60ylgFMNXNIYJik2k/GX
	0Bk+jDiJSZPE+lxMTjKAvz/dtfzyTAMYMs/4tAKMAq0AUbjAyUH/uIDmO8SIr1ylpcnnpGmJ
	NNMKNlOEwMXh05dtNB/GilPpBJpOoaX/bjGK6ybDLtpHdIWcnVbX/jg2ZQrufRrWaq8M0s1G
	IbmdrA407sgOGVM2kU53z8Pibu62HmP/h72m8PJS88tT4z+DA4ZfgKFHEy0gRWeNfNDcxFx6
	dkFQdcecPz0aWG/vufvI95XhKs2S+snrhI7kkOhfW3rmI7Uc8zfBGEEzmndHj4+kLjYOn4yO
	frywty+qgdDuu9z3VdAsUc3tzsjnHrHUnkuqvyYPbyrneHWrP8J0PU/IzES4Rcf61FqtyqxP
	vcWG63LS+Vi1Y2NZW4MMU95Ipx5WJDgGcGI66nM9je2HXY9n1BJVHBC52A9NoVWL5bkbJmMU
	KxVb3XlB78KyCq0CgokT7/LGpYz4D7D9kfhYAwAA
X-CMS-MailID: 20240103165306uscas1p2793a38b1136b2c7bec48b87e8ce4ce21
CMS-TYPE: 301P
X-CMS-RootMailID: 20231222151028uscas1p1fa4d0282844f4aaa36b1133c5df17c9c
References: <CGME20231222151028uscas1p1fa4d0282844f4aaa36b1133c5df17c9c@uscas1p1.samsung.com>
	<42978BEA-D194-41F4-A619-BAF02CE8F4FF@dubeyko.com>

T24gRnJpLCBEZWMgMjIsIDIwMjMgYXQgMDY6MTA6MjFQTSArMDMwMCwgVmlhY2hlc2xhdiBEdWJl
eWtvIHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+IERvIHdlIG5lZWQgZGVkaWNhdGVkIExTRi9NTS9C
UEYgMjAyNCBzZXNzaW9uIGZvciBDWEwgbWVtb3J5Pw0KPiBBbnkgY29tbWVudHM/DQoNCldlIGFy
ZSBzdGFydGluZyB0byBzcGVuZCBhIGJpdCBtb3JlIHRpbWUgbG9va2luZyBiZXlvbmQgdGhlDQpD
WEwgZHJpdmVyIGNvZGUsIHNwZWNpZmljYWxseSBpbnRlcmxlYXZpbmcgYW5kIHRpZXJpbmcgaW4N
CnRoZSBjb250ZXh0IG9mIENYTCBhdHRhY2hlZCBtZW1vcnkuIEl0IHdvdWxkIGJlIGdyZWF0IHRv
IA0KY2FydmUgb3V0IHRpbWUgdG8gZ2V0IGludGVyZXN0ZWQgcGFydGllcyBpbiB0aGUgc2FtZSBy
b29tLg0KDQo+IA0KPiBIaSBEYW4sDQo+IA0KPiBJIGJlbGlldmUgd2UgbmVlZCBzb21lIHRhbGsg
dG8gc3VtbWFyaXplOg0KPiAoMSkgd2hhdCB3ZSBhY2hpZXZlZCBkdXJpbmcgMjAyMyB5ZWFyLA0K
PiAoMikgd2hhdCBUT0RPcyB3ZSBoYXZlDQo+ICgzKSBldGMuDQo+IA0KPiBXaGF0IGRvIHlvdSB0
aGluaz8NCj4gDQo+IEhpIEFkYW0sDQo+IA0KPiBJIGFzc3VtZSBpdCB3aWxsIGJlIGdvb2QgdG8g
aGVhciB3aGF0IGlzIGNvb2tpbmcgb24gaGFyZHdhcmUgdmVuZG9y4oCZcyBzaWRlDQo+IGluIHRo
ZSBDWEwgbWVtb3J5IGFyZWEuIENvdWxkIHdlIGhhdmUgc29tZSBzdW1tYXJ5IHJlbGF0ZWQgdG8g
dGhpcw0KPiAob2YgY291cnNlLCB3aGF0IGNhbiBiZSBzaGFyZWQgd2l0aCBvcGVuLXNvdXJjZSBj
b21tdW5pdHkpPyBIb3cgZG8geW91DQo+IGZlZWwgYWJvdXQgaXQ/DQoNCkkgd291bGQgYmUgbW9y
ZSB0aGFuIGhhcHB5IHRvIGdpdmUgYW4gdXBkYXRlIGZyb20gYSBkZXZpY2UgdmVuZG9yIHBlcnNw
ZWN0aXZlLiANClRoZXJlIHdlcmUgc2V2ZXJhbCBwdWJsaWMgZGVtb25zdHJhdGlvbnMgb2YgQ1hM
IGRldmljZXMgaW4gdGhlIHBhc3QgeWVhciBhbmQNCml0IHdvdWxkIGJlIGdyZWF0IGlmIHdlIGNv
dWxkIGdldCByZXByZXNlbnRhdGlvbiBmcm9tIG90aGVyIENYTCBkZXZpY2UgdmVuZG9ycw0KdG8g
c2hhcmUgdXBkYXRlcyB3aXRoIHRoZSBjb21tdW5pdHkuDQoNCj4gDQo+IEhpIFZpbmNlbnQsDQo+
IA0KPiBJdCB3aWxsIGJlIGdyZWF0IHRvIGhlYXIgd2hhdCBpcyBnb2luZyBvbiB3aXRoIENYTCBz
cGVjaWZpY2F0aW9uIGFuZCB3aGljaCBhY3Rpdml0eQ0KPiBoYXMgdGFrZW4gcGxhY2UgaW4gQ1hM
IENvbnNvcnRpdW0uIEhvdyBkbyB5b3UgZmVlbCB0byBzaGFyZSBzb21lIDIwMjMgeWVhcg0KPiBz
dW1tYXJ5Pw0KPiANCj4gSGkgSm9uYXRoYW4sDQo+IA0KPiBJIHRoaW5rIFFFTVUgaXMgaW1wb3J0
YW50IGFyZWEgb2YgQ1hMIG1lbW9yeSBlbXVsYXRpb24gYW5kIHRlc3RpbmcuDQo+IFNvLCBJIGFz
c3VtZSB3ZSBjb3VsZCBoYXZlIGludGVyZXN0aW5nIHRvcGljcyBhbmQgZGlzY3Vzc2lvbnMgaGVy
ZS4NCj4gQW55IHN1Z2dlc3Rpb25zIGZvciB0aGlzPyBXaGF0IGRvIHlvdSB0aGluaz8NCj4gDQo+
IFRoYW5rcywNCj4gU2xhdmEuDQo+IA0KPiANCj4g
