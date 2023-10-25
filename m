Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183817C6
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jYAQ1J0I"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D610D7
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 18:34:00 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231025013357usoutp020fd5947560047a4dcf3caea085201c69~RNcEBbHuI2226922269usoutp02M;
	Wed, 25 Oct 2023 01:33:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231025013357usoutp020fd5947560047a4dcf3caea085201c69~RNcEBbHuI2226922269usoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698197637;
	bh=J1ywjFDkbk64d2V2AN0Uz24+TmqNmlmI46a8EhEStqk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=jYAQ1J0IqyscRWAMnOaRxT3Ry9avRfO/cfX7NWcy9gexEMAPpygoGsTFh8vHfFJSz
	 H19uAi7T9XRL4XP4owbk4wecCBj4zscoDn+8DHkB/JTORQYQor/ExfvVFlPIervoIx
	 kMCgqnDAZthuuN9ImcazSC9WYnFD+ow+x5aBnKyA=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231025013357uscas1p26025cb61f6f33def14ca8b07cd95911a~RNcD3W3oi2753527535uscas1p2x;
	Wed, 25 Oct 2023 01:33:57 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id D7.9C.62237.58078356; Tue,
	24 Oct 2023 21:33:57 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231025013357uscas1p212a3e8598ce0d9d4081be57f0b1099ee~RNcDoBCqU2751127511uscas1p2m;
	Wed, 25 Oct 2023 01:33:57 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-22-65387085807e
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id BD.4A.31200.48078356; Tue,
	24 Oct 2023 21:33:57 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Tue, 24 Oct 2023 18:33:56 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
	24 Oct 2023 18:33:56 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: set root decoder granularity based on region
 params
Thread-Topic: [PATCH] cxl: set root decoder granularity based on region
	params
Thread-Index: AQHZ9xetppHioUpJEUacMqps7+5BAbA62tGAgAEE4wCAHmN3gIAACp0A
Date: Wed, 25 Oct 2023 01:33:56 +0000
Message-ID: <ZThwgJM2pSyTFaXQ@ubuntu>
In-Reply-To: <6538679925e75_72583294bb@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCF87EF587E23243BB4F033E7AE7F748@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djXc7qtBRapBls2iFhMn3qB0eL8rFMs
	Dkwei/e8ZPL4vEkugCmKyyYlNSezLLVI3y6BK+PskZWsBW1cFdMOb2BvYHzC2cXIySEhYCKx
	5eQb1i5GLg4hgZWMEv8uLWMGSQgJtDJJ/N2uAFP0/PEFqPgaRok3c7Mh7E+MEnPmF0M0L2OU
	mPB9PRNIgk1AU+LXlTVgtoiAtsTEOQfBmpkFrCX6T58Fs4UF/CWed59lgagJkOi7d5ANwnaT
	6GxfyNjFyMHBIqAqsfSyHkiYF8hcvqQVbCSngKfE+9YvYK2MAmIS309BrGIWEJe49WQ+E8TN
	ghKLZu9hhrDFJP7tesgGYStK3P/+kh1kPDPQmet36UO02kk8+radHcJWlJjS/ZAdYq2gxMmZ
	T1ggWiUlDq64wQLyroTATA6J1e2/WCESLhKnG/5D2dISf+8ug7ohW2Ll+g4mkF0SAgUSDUeC
	IMLWEgv/rGeawKgyC8nVsxAumoXkollILpqF5KIFjKyrGMVLi4tz01OLjfNSy/WKE3OLS/PS
	9ZLzczcxApPI6X+HC3Yw3rr1Ue8QIxMH4yFGCQ5mJRHeSB+LVCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK8hrYnk4UE0hNLUrNTUwtSi2CyTBycUg1Mcm/YV9xkVL5zwydJ6HOGDtP0itBNHDoh
	TxdkH5l05uu3ju2rZnaJLrl3Qvsd070NUxsNIptq5s79JBFf/S+lxeCs8duNvLVvTqa8CSiO
	k+x6oShYmbWu6buxuNV3aRXtLR+OqEv0eWjMPmB5umP/fblaV4ZHP1MKJ9lf2HDhi5TRIXsN
	14kv+eYG7+B+33yhder21q8iWS35LzzefjxaFCd/f83BqfwOF3cHfbxyyG/LHs8HJm5N5/XC
	XJd1yimFLnWfF9b94FfQ59J4obPTJibmpnw5yrY3PGL9N+YaBrVVzDJ5B/OTjkw8fyrZwV60
	6uwXHzsPjnMfy1/kFVet257Os0OLade8sg2fj53nVWIpzkg01GIuKk4EAIe/WnKRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWS2cDspNtaYJFqsHQRk8X0qRcYLc7POsXi
	wOSxeM9LJo/Pm+QCmKK4bFJSczLLUov07RK4Ms4eWcla0MZVMe3wBvYGxiecXYycHBICJhLP
	H19gBrGFBFYxSlxdmghhf2KU+H8gp4uRC8hexiix+eMTdpAEm4CmxK8ra5hAbBEBbYmJcw6C
	NTMLWEv0nz4LZgsL+EpMPnKWDaLGT2Ldi1Yo202is30hYxcjBweLgKrE0st6IGFeIHP5klYm
	iF3PmCQ2LFkLVs8p4CnxvvULC4jNKCAm8f0UxF5mAXGJW0/mM0E8ICCxZM95ZghbVOLl43+s
	ELaixP3vL9lBdjED3bx+lz5Eq53Eo2/b2SFsRYkp3Q/ZIW4QlDg58wkLRKukxMEVN1gmMErM
	QrJtFsKkWUgmzUIyaRaSSQsYWVcxipcWF+emVxQb5aWW6xUn5haX5qXrJefnbmIERuHpf4ej
	dzDevvVR7xAjEwfjIUYJDmYlEd5IH4tUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rx3H2ikCgmk
	J5akZqemFqQWwWSZODilGpiEuK7n3p2rcsFZ/qVY1/+v1Vt/PRK41PLYsM969SKOs6e3Lc34
	Hsix61yG9Gu26+LHn6gd3O8XePHVp9cbD07xVTCZtODZvQ4txYPtmnE/0wV33MiK8FjUUtqU
	pdfs9vjOvBOn2rVjv1WtkJT22qghMmUTY2zhBLlHyT+K+lyevjeOCYrRNm3hjXxuw7Hjxo6+
	+w//BMyIPTnjw7dnJ7I3StxytL2YE5XhYPRZee56E6F27yXrHHfPvdMr80/y9JUzu90WnJh1
	gW2SnkpRsVpGqqjz5napKXFJ56JvZ4nFxlpsNWV8+8bkcJjPPOZKq/Kj/Qk/vB5HPtp8KEUo
	+MnmI1cbPgvvzWNzkFt0luueEktxRqKhFnNRcSIAsTeiSjEDAAA=
X-CMS-MailID: 20231025013357uscas1p212a3e8598ce0d9d4081be57f0b1099ee
CMS-TYPE: 301P
X-CMS-RootMailID: 20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f
References: <CGME20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f@uscas1p2.samsung.com>
	<169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
	<651e0eddb7f6c_ae7e72946c@dwillia2-xfh.jf.intel.com.notmuch>
	<A9AA55AC-F925-4B7F-866B-7AB849CB6F36@ssi.samsung.com>
	<6538679925e75_72583294bb@dwillia2-xfh.jf.intel.com.notmuch>

T24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgMDU6NTU6NTNQTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdy
b3RlOg0KPiBKaW0gSGFycmlzIHdyb3RlOg0KPiBbLi5dDQo+ID4gPiBTbyBJIHRoaW5rIHRoaXMg
aXMgb25seSB2YWxpZCBpbiB0aGUgY3hscmQtPmN4bHNkLmN4bGQuaW50ZXJsZWF2ZV93YXlzID09
IDENCj4gPiA+IGNhc2UgYXMgaW50ZXJsZWF2ZV9ncmFudWxhcml0eV9zdG9yZSgpIGZvcmJpZHMg
cmVnaW9ucyB0aGF0IGRvIG5vdCBtYXRjaA0KPiA+ID4gdGhlIGdyYW51bGFyaXR5IG9mIHRoZSBy
b290Lg0KPiA+IA0KPiA+IFRoYXTigJlzIGNvcnJlY3QuIEFuZCBub3cgSSB0aGluayBpdOKAmXMg
YmV0dGVyIHRvIHB1dCB0aGlzIGFzc2lnbm1lbnQgaW4NCj4gPiBpbnRlcmxlYXZlX2dyYW51bGFy
aXR5X3N0b3JlKCkgaW5zdGVhZCBzaW5jZSB3ZSBhcmUgYWxyZWFkeSBkb2luZw0KPiA+IHJvb3Qg
ZGVjb2RlciByZWxhdGVkIGNoZWNraW5nIHRoZXJlLCBhbmQgd2Ugd291bGQgdGhlbiBqdXN0IGJl
IHNldHRpbmcNCj4gPiB0aGlzIGdyYW51bGFyaXR5IG9uY2UgaW5zdGVhZCBvZiBvbmNlIHBlciBt
ZW1kZXYuDQo+IA0KPiBEaWQgeW91IGV2ZXIgc2VuZCB0aGUgaW50ZXJsZWF2ZV9ncmFudWxhcml0
eV9zdG9yZSgpIHZlcnNpb24gb2YgdGhpcw0KPiBwYXRjaD8gSSBjYW4ndCBzZWVtIHRvIGZpbmQg
aXQuDQoNCkkgZm91bmQgYSB0aGlyZCBhcHByb2FjaCB0aGF0IHdhcyBtdWNoIHNpbXBsZXIgdGhh
biB0aGUgZWZmZWN0aXZlX2dyYW51bGFyaXR5DQphcHByb2FjaC4gSXQncyBpbiB0aGlzIHRocmVh
ZCB3aXRoIGEgY29tcGxldGVseSBkaWZmZXJlbnQgdGl0bGUuDQoNClNob3VsZCBJIGhhdmUgc3Rp
bGwgbWFya2VkIGl0IHYyLCBldmVuIHRob3VnaCB0aGUgY29tbWl0IHRpdGxlIGFuZCBwYXRjaCB3
YXMNCnJhZGljYWxseSBkaWZmZXJlbnQ/DQo=
