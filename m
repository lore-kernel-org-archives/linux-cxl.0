Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5422C84C
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s96Y8rym"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF078CC
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 15:48:38 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231013224835usoutp02129a392789136820fc2d9a8d41bcf89f~NzFitjBgY1683216832usoutp02X;
	Fri, 13 Oct 2023 22:48:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231013224835usoutp02129a392789136820fc2d9a8d41bcf89f~NzFitjBgY1683216832usoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697237315;
	bh=YKYhW4MepTolfqJgRNgeXcVfTMXoPvcLAo/WuLYyzxI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=s96Y8rym0U2sEUQSjWndEt2Lp+/6U0r7IZ5aJA2E1USUC+DppxFrtJtLw1fJ3xE75
	 mt35fHdztI5G1yj5mZEQf82YHbT2PYZWxlpnJnzDV+8Z+lxFMtGDEqJKaYCrmUWbKc
	 uigf0NpmPMu1QyehBn5gYmQCxlUBqiXF5OYa/PMQ=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231013224835uscas1p1451fcd668fa91491957d4868801186e0~NzFiilQOZ0414204142uscas1p1D;
	Fri, 13 Oct 2023 22:48:35 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id B7.F8.62237.349C9256; Fri,
	13 Oct 2023 18:48:35 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231013224835uscas1p2701079349b87a67906ccb6a9adf98b59~NzFiT-16-0069600696uscas1p2n;
	Fri, 13 Oct 2023 22:48:35 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-88-6529c943dce1
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 99.5E.28590.349C9256; Fri,
	13 Oct 2023 18:48:35 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 13 Oct 2023 15:48:34 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	13 Oct 2023 15:48:34 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 1/2] cxl: Add cxl_decoders_committed() helper
Thread-Topic: [PATCH v2 1/2] cxl: Add cxl_decoders_committed() helper
Thread-Index: AQHZ/hywe5bjGg0EskC+zr/KkoYz9LBIx90A
Date: Fri, 13 Oct 2023 22:48:34 +0000
Message-ID: <3CD88963-27CD-45F7-BB00-616F44D39EF2@ssi.samsung.com>
In-Reply-To: <169723269532.66903.10556183191413240496.stgit@djiang5-mobl3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <37C25FC615E238459317FDA1FD0B026A@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djXc7rOJzVTDfaeU7S4+/gCm8X0qRcY
	LU7cbGSzWH1zDaPF/qfPWSxWLbzGZnF+1ikWi1sTjjE5cHi0HHnL6rF4z0smj6mz6z0+b5IL
	YInisklJzcksSy3St0vgymh8cYKpoEW2YvHSrSwNjEtkuhg5OSQETCSWNU1h72Lk4hASWMko
	0dW9EcppZZK4eWMLC0zV0hUnWCASaxglTr49xwjhfGKUePRyIVTLMkaJvVc6mEBa2AQ0JX5d
	WQNmiwioStxf/5gNpIhZ4DOTxPFP5xlBEsICLhIvTy9hgShylVj6bR6QzQFkG0kc2moKEmYB
	6l2+dAoTSJhXwEmif442SJhTwEti04f7YOMZBcQkvp+CWMUsIC5x68l8JoirBSUWzd7DDGGL
	Sfzb9ZANwlaUuP/9JTvISGagM9fv0odotZPo2bedEcJWlJjS/ZAdxOYFGnNy5hNoQEhKHFxx
	AxwQEgI3OCSmzV/NDpFwkfh9+CTUfGmJq9enQu3Nlli5vgPsfAmBAomGI0EQYWuJhX/WM01g
	VJmF5OpZCBfNQnLRLCQXzUJy0QJG1lWM4qXFxbnpqcXGeanlesWJucWleel6yfm5mxiBien0
	v8MFOxhv3fqod4iRiYPxEKMEB7OSCO/sOI1UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGtieT
	hQTSE0tSs1NTC1KLYLJMHJxSDUxKV96vlj0txsMl6+Gu2/N767TOsrMOLzoze9cvZZ7r+mXy
	uoO3z+4vuBLS9qvbvXCKFec5U5fMbIGIT8lVjkp/Ii7/nfnp8v7vXO8b5vaWKNfbb58QfeGf
	YcjMfP4NF6pnesVsyNygfPPgsTD7uV3+ok5OebfmbeBMWbLH4HPMPVVlRhGv2S5lJm71zAfu
	6V28a2T6ZP+NTdXf1ok8ZOWZvvC+0Dz9xGXbNhgy8P/kdD55V3TngwKtLsvZb4pcfXwlpR35
	kxu6iy74HFC+XVGq//dUdH3F5ArT7U8rb1xaeiXxEpdVf1bvDv+VAo8a/KKizbe6Mf9YMeuJ
	1XJfp8Rr1eWJz5NWnrARucPU9l+JpTgj0VCLuag4EQB+Yi6LuwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWS2cDspOt8UjPV4P5PIYu7jy+wWUyfeoHR
	4sTNRjaL1TfXMFrsf/qcxWLVwmtsFudnnWKxuDXhGJMDh0fLkbesHov3vGTymDq73uPzJrkA
	ligum5TUnMyy1CJ9uwSujMYXJ5gKWmQrFi/dytLAuESmi5GTQ0LARGLpihMsXYxcHEICqxgl
	Zjc+g3I+MUqc2zyJEcJZxiixpb+PDaSFTUBT4teVNUwgtoiAqsT99Y/ZQIqYBT4zSRz/dJ4R
	JCEs4CLx8vQSFogiV4ml3+YB2RxAtpHEoa2mIGEWoN7lS6cwgYR5BZwk+udoQ+yayyhx9sUO
	dpAaTgEviU0f7oPtYhQQk/h+CmIvs4C4xK0n85kgXhCQWLLnPDOELSrx8vE/VghbUeL+95fs
	IPOZgW5ev0sfotVOomffdkYIW1FiSvdDsFW8AoISJ2c+YYFolZQ4uOIGywRGiVlIts1CmDQL
	yaRZSCbNQjJpASPrKkbx0uLi3PSKYsO81HK94sTc4tK8dL3k/NxNjMC4Pv3vcOQOxqO3Puod
	YmTiYDzEKMHBrCTCOztOI1WINyWxsiq1KD++qDQntfgQozQHi5I4790HQCmB9MSS1OzU1ILU
	IpgsEwenVAMTz6TdDG4lNxRm3Qr+GRb86TabOb/ak4zkjCnf1/gWzSt9u5Xj7WftTc0ZbCbb
	Hk0QjPJp3Dv95AOTmu0/FI7/+ya+64fhOtk7s79Obt2VFr03YYlZRv2q3LK3H8PUljveuuJq
	dy/i5YH8NztefhbsfVO7Ss2/TuNi5E2bjzbvTQ4bqolPVK+rOROTVntx+cw+faGdeR7fcr9N
	sZTeIdVx/IDIk8sBYs/P1/Vk+DG+6+ufGVlt1PGxSzAjVEhpkuRlM9sIoUuWt97aHHz++fwD
	05A/6sucZ9TZ6XGuKfJyE+u+IJXwVi+v94iXZltkbsyakH0hv364pKh6X9FLSj5Zyyc48UtQ
	9Zvd3G4NLlZKLMUZiYZazEXFiQDSEodRWgMAAA==
X-CMS-MailID: 20231013224835uscas1p2701079349b87a67906ccb6a9adf98b59
CMS-TYPE: 301P
X-CMS-RootMailID: 20231013213154uscas1p2995ce0b20ceed38023c42ace0b6db096
References: <CGME20231013213154uscas1p2995ce0b20ceed38023c42ace0b6db096@uscas1p2.samsung.com>
	<169723269532.66903.10556183191413240496.stgit@djiang5-mobl3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL21ib3guYyBiL2RyaXZlcnMvY3hsL2Nv
cmUvbWJveC5jDQo+IGluZGV4IDY3YWVjNTdjYzEyZi4uNmU2YTg3YWJmYTljIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2N4bC9jb3JlL21ib3guYw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL21i
b3guYw0KPiBAQCAtMTIwMCw3ICsxMjAwLDcgQEAgaW50IGN4bF9tZW1fc2FuaXRpemUoc3RydWN0
IGN4bF9tZW1kZXYgKmN4bG1kLCB1MTYgY21kKQ0KPiAqIFJlcXVpcmUgYW4gZW5kcG9pbnQgdG8g
YmUgc2FmZSBvdGhlcndpc2UgdGhlIGRyaXZlciBjYW4gbm90DQo+ICogYmUgc3VyZSB0aGF0IHRo
ZSBkZXZpY2UgaXMgdW5tYXBwZWQuDQo+ICovDQo+IC0gaWYgKGVuZHBvaW50ICYmIGVuZHBvaW50
LT5jb21taXRfZW5kID09IC0xKQ0KPiArIGlmIChlbmRwb2ludCAmJiAhY3hsX2RlY29kZXJzX2Nv
bW1pdHRlZChlbmRwb2ludCkpDQoNCkhpIERhdmUsDQoNCk1heWJlIGNvbXBhcmUgdG8gMCBpbnN0
ZWFkPyBUaGlzIGF2b2lkcyBtaXNpbnRlcnByZXRhdGlvbiBvbiB3aGV0aGVyDQpjeGxfZGVjb2Rl
cnNfY29tbWl0dGVkKCkgcmV0dXJucyBpbnQgb3IgYm9vbCAoaS5lLiDigJxhcmUgdGhlcmUgY3hs
DQpkZWNvZGVycyBjb21taXR0ZWQ/4oCdKSB3aXRob3V0IHJlZmVycmluZyB0byB0aGUgZnVuY3Rp
b24gaXRzZWxmLg0KDQpjeGxfbnVtX2RlY29kZXJzX2NvbW1pdHRlZCgpIHdvdWxkIGFsc28gbWFr
ZSB0aGF0IG1vcmUgY2xlYXIuDQoNCg0KPiByYyA9IF9fY3hsX21lbV9zYW5pdGl6ZShtZHMsIGNt
ZCk7DQo+IGVsc2UNCj4gcmMgPSAtRUJVU1k7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9j
b3JlL21lbWRldi5jIGIvZHJpdmVycy9jeGwvY29yZS9tZW1kZXYuYw0KPiBpbmRleCBmZWQ5NTcz
Y2YzNTUuLjc4YjZlNThlMGEzMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9tZW1k
ZXYuYw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL21lbWRldi5jDQo+IEBAIC0yMzEsNyArMjMx
LDcgQEAgaW50IGN4bF90cmlnZ2VyX3BvaXNvbl9saXN0KHN0cnVjdCBjeGxfbWVtZGV2ICpjeGxt
ZCkNCj4gaWYgKHJjKQ0KPiByZXR1cm4gcmM7DQo+IA0KPiAtIGlmIChwb3J0LT5jb21taXRfZW5k
ID09IC0xKSB7DQo+ICsgaWYgKCFjeGxfZGVjb2RlcnNfY29tbWl0dGVkKHBvcnQpKSB7DQo+IC8q
IE5vIHJlZ2lvbnMgbWFwcGVkIHRvIHRoaXMgbWVtZGV2ICovDQo+IHJjID0gY3hsX2dldF9wb2lz
b25fYnlfbWVtZGV2KGN4bG1kKTsNCj4gfSBlbHNlIHsNCj4gQEAgLTI4Miw3ICsyODIsNyBAQCBz
dGF0aWMgc3RydWN0IGN4bF9yZWdpb24gKmN4bF9kcGFfdG9fcmVnaW9uKHN0cnVjdCBjeGxfbWVt
ZGV2ICpjeGxtZCwgdTY0IGRwYSkNCj4gLmRwYSA9IGRwYSwNCj4gfTsNCj4gcG9ydCA9IGN4bG1k
LT5lbmRwb2ludDsNCj4gLSBpZiAocG9ydCAmJiBpc19jeGxfZW5kcG9pbnQocG9ydCkgJiYgcG9y
dC0+Y29tbWl0X2VuZCAhPSAtMSkNCj4gKyBpZiAocG9ydCAmJiBpc19jeGxfZW5kcG9pbnQocG9y
dCkgJiYgY3hsX2RlY29kZXJzX2NvbW1pdHRlZChwb3J0KSkNCj4gZGV2aWNlX2Zvcl9lYWNoX2No
aWxkKCZwb3J0LT5kZXYsICZjdHgsIF9fY3hsX2RwYV90b19yZWdpb24pOw0KPiANCj4gcmV0dXJu
IGN0eC5jeGxyOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9wb3J0LmMgYi9kcml2
ZXJzL2N4bC9jb3JlL3BvcnQuYw0KPiBpbmRleCA1YmE2MDZjNmUwM2YuLmZkMWNjMzA3NzU5ZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9wb3J0LmMNCj4gKysrIGIvZHJpdmVycy9j
eGwvY29yZS9wb3J0LmMNCj4gQEAgLTM3LDYgKzM3LDEzIEBAIERFQ0xBUkVfUldTRU0oY3hsX3Jl
Z2lvbl9yd3NlbSk7DQo+IHN0YXRpYyBERUZJTkVfSURBKGN4bF9wb3J0X2lkYSk7DQo+IHN0YXRp
YyBERUZJTkVfWEFSUkFZKGN4bF9yb290X2J1c2VzKTsNCj4gDQo+ICtpbnQgY3hsX2RlY29kZXJz
X2NvbW1pdHRlZChzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQpDQo+ICt7DQo+ICsgbG9ja2RlcF9hc3Nl
cnRfaGVsZCgmY3hsX3JlZ2lvbl9yd3NlbSk7DQo+ICsNCj4gKyByZXR1cm4gcG9ydC0+Y29tbWl0
X2VuZCArIDE7DQo+ICt9DQo+ICsNCj4gc3RhdGljIHNzaXplX3QgZGV2dHlwZV9zaG93KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ICAgIGNoYXIg
KmJ1ZikNCj4gew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY3hsLmggYi9kcml2ZXJzL2N4
bC9jeGwuaA0KPiBpbmRleCA3NmQ5MjU2MWFmMjkuLjI3Mjg3MDBkOGIzMyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9jeGwvY3hsLmgNCj4gKysrIGIvZHJpdmVycy9jeGwvY3hsLmgNCj4gQEAgLTY3
OSw2ICs2NzksNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfY3hsX3Jvb3Qoc3RydWN0IGN4bF9w
b3J0ICpwb3J0KQ0KPiByZXR1cm4gcG9ydC0+dXBvcnRfZGV2ID09IHBvcnQtPmRldi5wYXJlbnQ7
DQo+IH0NCj4gDQo+ICtpbnQgY3hsX2RlY29kZXJzX2NvbW1pdHRlZChzdHJ1Y3QgY3hsX3BvcnQg
KnBvcnQpOw0KPiBib29sIGlzX2N4bF9wb3J0KGNvbnN0IHN0cnVjdCBkZXZpY2UgKmRldik7DQo+
IHN0cnVjdCBjeGxfcG9ydCAqdG9fY3hsX3BvcnQoY29uc3Qgc3RydWN0IGRldmljZSAqZGV2KTsN
Cj4gc3RydWN0IHBjaV9idXM7DQo+IA0KPiANCj4gDQoNCg==
