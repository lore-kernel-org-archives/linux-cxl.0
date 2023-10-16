Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CB30CE0
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iCpVfNYs"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0D83
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 09:00:48 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231016160047usoutp01e76b9cfb0eacf21f209e2852f227b365~OodVb64J22305323053usoutp01T;
	Mon, 16 Oct 2023 16:00:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231016160047usoutp01e76b9cfb0eacf21f209e2852f227b365~OodVb64J22305323053usoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697472047;
	bh=F8JUA+IvQBiWpD40PFpfH6c7O55spZ+S/rg82qUU874=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=iCpVfNYs6kcTBO5aufrNh6DN05FzP1KuT8F2m/2Vh30XeofwtNMJMMVw9hjxXyt7O
	 MKvVKhLXSJBCdV8df/jUn6zNg1b5ATsJkEgVSVW9HL1sK9flHZTkjlWs0K2VF5c8YI
	 X8FsXX7lKF3SI19JTFqgD+LVsZGoMZk4zkQOr6nQ=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231016160047uscas1p138667a2d35decfd9a88b3e714334e286~OodVStxrP0389103891uscas1p1w;
	Mon, 16 Oct 2023 16:00:47 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id AF.42.62237.F2E5D256; Mon,
	16 Oct 2023 12:00:47 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231016160046uscas1p18a2a85cfde8937c6449db7067d224678~OodVGPPUy0402404024uscas1p1u;
	Mon, 16 Oct 2023 16:00:46 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-51-652d5e2f8ef6
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 70.CC.28590.E2E5D256; Mon,
	16 Oct 2023 12:00:46 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Mon, 16 Oct 2023 09:00:46 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
	16 Oct 2023 09:00:46 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/2] cxl: Add decoders_committed sysfs attribute to
 cxl_port
Thread-Topic: [PATCH v2 2/2] cxl: Add decoders_committed sysfs attribute to
	cxl_port
Thread-Index: AQHZ/hyy5QqP0fYlxU6WffpG9Jr0k7BNDOuA
Date: Mon, 16 Oct 2023 16:00:45 +0000
Message-ID: <9C248C39-5EFC-402A-BCE3-4FD8FD74EB61@ssi.samsung.com>
In-Reply-To: <169723270125.66903.9705024211129163971.stgit@djiang5-mobl3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <02AF02641689B8479CAE3BC8129282B4@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djXc7r6cbqpBt//s1rcfXyBzWL61AuM
	FiduNrJZrL65htFi/9PnLBarFl5jszg/6xSLxa0Jx5gcODxajrxl9Vi85yWTx9TZ9R6fN8kF
	sERx2aSk5mSWpRbp2yVwZfTs+cNc8EqoovP8O/YGxjVCXYycHBICJhKz27czdjFycQgJrGSU
	aOzczAzhtDJJ7P96hRmm6tSWTewQiTWMEh/234aq+sQocfTpAaj+ZYwSf1v7wVrYBDQlfl1Z
	wwRiiwioStxf/5gNpIhZ4DOTxPFP5xlBEsICoRITT2xm7WLkACoKk9j+MR6i3kjiztwn7CA2
	C1Bv38EJYHN4BZwk3u1ZxwJicwp4Sqx53gpmMwqISXw/BbGLWUBc4taT+UwQZwtKLJq9B+oF
	MYl/ux6yQdiKEve/v2QHWcsMdOf6XfoQrXYSTw79YYSwFSWmdD9kh1grKHFy5hMWiFZJiYMr
	brCAvCIhcIND4tzDC2DnSwi4SMw8aAVRIy1x9fpUqLXZEivXdzBBlBRINBwJgghbSyz8s55p
	AqPKLCRHz0I4aBaSg2YhOWgWkoMWMLKuYhQvLS7OTU8tNs5LLdcrTswtLs1L10vOz93ECExM
	p/8dLtjBeOvWR71DjEwcjIcYJTiYlUR404N1UoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGtqe
	TBYSSE8sSc1OTS1ILYLJMnFwSjUwrdVc0bHpgfKNa2XTc7tM/2swc2hxCxukH7ZgusCoOj86
	V4I56JSAocTNKd/zDz4Qy/y1waSxJTb7UvqK8MnJr1W57P8Gl0v9rNRx1Td9u3iC4+T08Ni9
	z5k5nOxO83hZWa0zF82TrhLbzDW/VLCpOYnl+lbnvBw995pMxuQpO9R3r7z7RVwgylrtjOOR
	0Ep3uQU7VJmqc8x8ekNTzBYe0mdaz8bfecks99KUFZIVxs7fOedsLDtw/dPJ+mcO1eY8m1fH
	G935e3x68P+Oao7WGX9+8r8P3KUsYXb/NVOIaOSejDPsZxZyPLTs6Vp1/CzLfzPJHob3nZya
	r0/d2PMg5FPBzX8zfye+C1nC9kuJpTgj0VCLuag4EQBpL7eIuwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWS2cDspKsXp5tqcGOxscXdxxfYLKZPvcBo
	ceJmI5vF6ptrGC32P33OYrFq4TU2i/OzTrFY3JpwjMmBw6PlyFtWj8V7XjJ5TJ1d7/F5k1wA
	SxSXTUpqTmZZapG+XQJXRs+eP8wFr4QqOs+/Y29gXCPUxcjJISFgInFqyyb2LkYuDiGBVYwS
	P1dsYYVwPjFKPD7VyAhSJSSwjFHi7PYCEJtNQFPi15U1TCC2iICqxP31j9lAGpgFPjNJHP90
	HqxBWCBUYuKJzawQRWESU5//hGowkrgz9wk7iM0C1Nx3cAJYnFfASeLdnnUsEJvvMEqc2HsZ
	LMEp4Cmx5nkrC4jNKCAm8f0UxGZmAXGJW0/mM0H8ICCxZM95ZghbVOLl43+sELaixP3vL4GW
	cQDVa0qs36UP0Won8eTQH0YIW1FiSvdDdogbBCVOznzCAtEqKXFwxQ2WCYwSs5Bsm4UwaRaS
	SbOQTJqFZNICRtZVjOKlxcW56RXFhnmp5XrFibnFpXnpesn5uZsYgZF9+t/hyB2MR2991DvE
	yMTBeIhRgoNZSYQ3PVgnVYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv3QcaqUIC6YklqdmpqQWp
	RTBZJg5OqQamS9FctscCbsordk1uW6bgPWHTnbOxYrYrP33bJFxqHsJfP3eXGI/YUzcr11Uh
	83Y29f/R3fZCvnLrRzfGCcpCH4yqtRa8fihV9WKx7Mmyv1OWXjFOmqnLl2R7826p9xnlliWK
	xVv1xG+3flm2YILjzMJFrMXTz7vkRi5fdXNRQ5639IWDe8N/OX85r3T4eOCD89w+SbPk+19r
	97nW5YoHZkeLNi9k+culbDVlx+cLl0Tzj1y/d/S7m8aURY77vd0qzdk3W0runTl/Rd5VHVft
	O97fDxXp1h20l18aYegV+0NBpT15tlC3QepRw0Op6x++rnlkVtjLYGVx6OrlryZXrxvNFmJh
	nntbWVPji6+QEktxRqKhFnNRcSIA2OLF9VsDAAA=
X-CMS-MailID: 20231016160046uscas1p18a2a85cfde8937c6449db7067d224678
CMS-TYPE: 301P
X-CMS-RootMailID: 20231013213157uscas1p1f16d6c45d92a8af12d173a3f2978a174
References: <169723269532.66903.10556183191413240496.stgit@djiang5-mobl3>
	<CGME20231013213157uscas1p1f16d6c45d92a8af12d173a3f2978a174@uscas1p1.samsung.com>
	<169723270125.66903.9705024211129163971.stgit@djiang5-mobl3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDEzLCAyMDIzLCBhdCAyOjMx4oCvUE0sIERhdmUgSmlhbmcgPGRhdmUuamlh
bmdAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IFRoaXMgYXR0cmlidXRlIGFsbG93cyBjeGwtY2xp
IHRvIGRldGVybWluZSB3aGV0aGVyIHRoZXJlIGFyZSBkZWNvZGVycw0KPiBjb21taXR0ZWQgdG8g
YSBtZW1kZXYuICBUaGlzIGlzIG9ubHkgYSBzbmFwc2hvdCBvZiB0aGUgc3RhdGUsIGFuZA0KPiBk
b2Vzbid0IG9mZmVyIGFueSBwcm90ZWN0aW9uIG9yIHNlcmlhbGl6YXRpb24gYWdhaW5zdCBhIGNv
bmN1cnJlbnQNCj4gZGlzYWJsZS1yZWdpb24gb3BlcmF0aW9uLg0KPiANCj4gU3VnZ2VzdGVkLWJ5
OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IA0KPiAtLS0NCj4gdjI6DQo+
IC0gVXNlIGN4bF9yZWdpb25fcndzZW0gdG8gcHJvdGVjdCByZWFkaW5nIG9mIGRlY29kZXIgaW5m
by4gKERhbikNCj4gLS0tDQo+IGRyaXZlcnMvY3hsL2NvcmUvcG9ydC5jIHwgICAyNSArKysrKysr
KysrKysrKysrKysrKysrKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9wb3J0LmMgYi9kcml2ZXJzL2N4bC9j
b3JlL3BvcnQuYw0KPiBpbmRleCBmZDFjYzMwNzc1OWYuLmE0NDhlMTQzOWI2OCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9jeGwvY29yZS9wb3J0LmMNCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9w
b3J0LmMNCj4gQEAgLTUzNCw4ICs1MzQsMzMgQEAgc3RhdGljIHZvaWQgY3hsX3BvcnRfcmVsZWFz
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IGtmcmVlKHBvcnQpOw0KPiB9DQo+IA0KPiArc3RhdGlj
IHNzaXplX3QgZGVjb2RlcnNfY29tbWl0dGVkX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiAr
ICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQo+ICt7DQo+
ICsgc3RydWN0IGN4bF9wb3J0ICpwb3J0ID0gdG9fY3hsX3BvcnQoZGV2KTsNCj4gKyBpbnQgcmM7
DQo+ICsNCj4gKyBkb3duX3JlYWQoJmN4bF9yZWdpb25fcndzZW0pOw0KPiArIHJjID0gc3lzZnNf
ZW1pdChidWYsICIlZFxuIiwgY3hsX2RlY29kZXJzX2NvbW1pdHRlZChwb3J0KSk7DQo+ICsgdXBf
cmVhZCgmY3hsX3JlZ2lvbl9yd3NlbSk7DQo+ICsNCj4gKyByZXR1cm4gcmM7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBERVZJQ0VfQVRUUl9STyhkZWNvZGVyc19jb21taXR0ZWQpOw0KPiArDQo+ICtz
dGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqY3hsX3BvcnRfYXR0cnNbXSA9IHsNCj4gKyAmZGV2X2F0
dHJfZGVjb2RlcnNfY29tbWl0dGVkLmF0dHIsDQo+ICsgTlVMTCwNCj4gK307DQo+ICsNCj4gK3N0
YXRpYyBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGN4bF9wb3J0X2F0dHJpYnV0ZV9ncm91cCA9IHsN
Cj4gKyAuYXR0cnMgPSBjeGxfcG9ydF9hdHRycywNCj4gK307DQo+ICsNCj4gc3RhdGljIGNvbnN0
IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKmN4bF9wb3J0X2F0dHJpYnV0ZV9ncm91cHNbXSA9IHsN
Cj4gJmN4bF9iYXNlX2F0dHJpYnV0ZV9ncm91cCwNCj4gKyAmY3hsX3BvcnRfYXR0cmlidXRlX2dy
b3VwLA0KPiBOVUxMLA0KPiB9Ow0KPiANCg0KVGhpcmQgdGltZeKAmXMgYSBjaGFybT8NCg0KUmV2
aWV3ZWQtYnk6IEppbSBIYXJyaXMgPGppbS5oYXJyaXNAc2Ftc3VuZy5jb20+DQoNCg==
