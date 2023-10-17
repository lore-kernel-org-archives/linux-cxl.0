Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4244498
	for <linux-cxl@vger.kernel.org>; Tue, 17 Oct 2023 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lnK2svwP"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EEFA4
	for <linux-cxl@vger.kernel.org>; Tue, 17 Oct 2023 09:21:09 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231017162107usoutp02d2fee7bf18da81298746b3806a1a4da4~O8YYihrZ60365503655usoutp02y;
	Tue, 17 Oct 2023 16:21:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231017162107usoutp02d2fee7bf18da81298746b3806a1a4da4~O8YYihrZ60365503655usoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697559668;
	bh=ljk24YHKjeW2aEI2+IG8dn6LGYbSOORKAbUUM1UhMfY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=lnK2svwPnyqP8Jow1iUwgvHMewHEapBDSXdAeOaz9igq3DV+MUSaQjD3itlwbAqVc
	 EfapnGzmwgjqf7FYrA4rrtNe577qvQN6Ze4/ExcsL4dU0tV+1rhJOJoSNMKK93/MZG
	 U8pPVj5zdXlk6FxvKDT3MHDRjM+38vOJ6/yc6wF0=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231017162107uscas1p2942d51ccf00aec6ccb2b7830bbb38bb6~O8YX8x_6S1916819168uscas1p27;
	Tue, 17 Oct 2023 16:21:07 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id FC.09.62237.374BE256; Tue,
	17 Oct 2023 12:21:07 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231017162107uscas1p17a6b930720fe792af636dcf90853b476~O8YXrX0yv1859518595uscas1p1P;
	Tue, 17 Oct 2023 16:21:07 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-22-652eb473c307
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 2C.89.28590.274BE256; Tue,
	17 Oct 2023 12:21:06 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Tue, 17 Oct 2023 09:21:06 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
	17 Oct 2023 09:21:06 -0700
From: Jim Harris <jim.harris@samsung.com>
To: "alison.schofield@intel.com" <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: Re: [PATCH v2 1/3] cxl/region: Prepare the decoder match range
 helper for reuse
Thread-Topic: [PATCH v2 1/3] cxl/region: Prepare the decoder match range
	helper for reuse
Thread-Index: AQHZ//ZioxMVLlTkYE+pVsAjGci0crBOoTqA
Date: Tue, 17 Oct 2023 16:21:06 +0000
Message-ID: <CDA18391-931B-4564-8B97-9DE92790C9CA@ssi.samsung.com>
In-Reply-To: <8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ED3E1A32823FE40BC574A2F8004204D@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djX87rFW/RSDf7e47G4+/gCm8X0qRcY
	LU7cbGSzWH1zDaPFn0O+FvufPmexWLXwGpvF+VmnWCxuTTjG5MDp0XLkLavH4j0vmTymzq73
	+LxJLoAlissmJTUnsyy1SN8ugSvjaPMkxoIvShUHdy1jb2BsUOpi5OSQEDCReLDrJ3MXIxeH
	kMBKRomf576zQDitTBKtK/+xwFR1LeiCSqxhlNhyvY0VwvnEKNGx6D47hLOMUeLN8sNgLWwC
	mhK/rqxhArFFBGwlLu+fzgRSxCxwn0mia8ZyIIeDQ1ggSmLx7BCImmiJNz1rGCFsI4m+ljNg
	NouAqsTK9nWsIDavgJPEybuN7CA2p0CixN6rZ8BsRgExie+nIHYxC4hL3HoynwnibEGJRbP3
	MEPYYhL/dj1kg7AVJe5/f8kOcgIz0J3rd+lDtNpJ3Pm4lh3CVpSY0v2QHWKtoMTJmU+gISEp
	cXDFDXBISAg84JBYtquZFSLhIvF51X2oXdISV69PhbKzJVau7wB7V0KgQKLhSBBE2Fpi4Z/1
	TBMYVWYhuXoWwkWzkFw0C8lFs5BctICRdRWjeGlxcW56arFxXmq5XnFibnFpXrpecn7uJkZg
	ijr973DBDsZbtz7qHWJk4mA8xCjBwawkwpserJMqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfQ
	9mSykEB6YklqdmpqQWoRTJaJg1Oqgal+75Oargk3wgsT6qtCz73c5Dbre1qvQe/i9r/ZZy8v
	uOii8+9yWMjNbL6J0TX2P8zOaFTFMVxU3e06J9+s9mVgv+6mle1Ru67tDal/dWrJzBn2T9j6
	JfXNPll8/s+5pavSuCs6KcKvkeWIjIf50r6itCO3zy3JVXqx7YTkFdNtQQJefh1MXx7Fc7kz
	FjCrXTIxumNmPduIuWWv2M4Xxz8w6Cou/zgv5T47w94JDHtvxO/8Exf5RGjGBpfN09SWWyxf
	yNhwduHnN0/axJs+Oq+e8ylXYbfGj9kXNlrYPnhnIGhk4ZzYnfvN8+zWTufSacdbrAMjubi0
	4uvTDhtUiCi+X2u0lUs8vkjMsOmAshJLcUaioRZzUXEiAGxC2WPAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWS2cDsrFu0RS/VoGGRhcXdxxfYLKZPvcBo
	ceJmI5vF6ptrGC3+HPK12P/0OYvFqoXX2CzOzzrFYnFrwjEmB06PliNvWT0W73nJ5DF1dr3H
	501yASxRXDYpqTmZZalF+nYJXBlHmycxFnxRqji4axl7A2ODUhcjJ4eEgIlE14Iuli5GLg4h
	gVWMEivnLYZyPjFKnHt2jBXCWcYo8ejOAVaQFjYBTYlfV9YwgdgiArYSl/dPZwIpYha4zyTR
	NWM5WEJYIEriT+8bVoiiaIkNS9YzQthGEn0tZ8BsFgFViZXt68BqeAWcJE7ebWSH2PaCUeLi
	jBfMIAlOgUSJvVfPsIPYjAJiEt9PQWxmFhCXuPVkPhPEEwISS/acZ4awRSVePv7HCmErStz/
	/hKolwOoXlNi/S59iFY7iTsf17JD2IoSU7ofskPcIChxcuYTFohWSYmDK26wTGCUmIVk2yyE
	SbOQTJqFZNIsJJMWMLKuYhQvLS7OTa8oNsxLLdcrTswtLs1L10vOz93ECIzx0/8OR+5gPHrr
	o94hRiYOxkOMEhzMSiK86cE6qUK8KYmVValF+fFFpTmpxYcYpTlYlMR57z7QSBUSSE8sSc1O
	TS1ILYLJMnFwSjUwXa+4bzDjxvHAYvY5W+QXqKevOHfuuEGxJN/q86/FPH9Pm9G+oUb8wI91
	S/sD9xpfv51Z9ORH8IFTUgpLLN7nMwrF/3lQsH/Xa/PH8Sbf7jmkf2CXU1i5Q3OxkIm59M0z
	Z89sW/ngzDy7ydv3cfC2zDu6vUTO+MIaJ7eTqX/lv61becSZy8FjZ/zvvuq7q7IE76zf/eWL
	XnRjxMEs3Xfn1x4VnFh9ed7Ba+nzN91xFdl0M21HW7ebsp7VuSzJJSp31n/aOVFPKlVS2vQ2
	989Pny0b+NJuHjks9rw9seWbWxfDjgDxP4HlOYrvb79ceCzL4c+XO7feyL3wZjbxWSZ3+v/G
	r8WWNfaOWaFst4ubHy1SYinOSDTUYi4qTgQAYPyEUGADAAA=
X-CMS-MailID: 20231017162107uscas1p17a6b930720fe792af636dcf90853b476
CMS-TYPE: 301P
X-CMS-RootMailID: 20231016060244uscas1p15e15e2d44388f12511a67c003dc2bff5
References: <cover.1697433770.git.alison.schofield@intel.com>
	<CGME20231016060244uscas1p15e15e2d44388f12511a67c003dc2bff5@uscas1p1.samsung.com>
	<8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDE1LCAyMDIzLCBhdCAxMTowMuKAr1BNLCBhbGlzb24uc2Nob2ZpZWxkQGlu
dGVsLmNvbSB3cm90ZToNCj4gDQo+IEZyb206IEFsaXNvbiBTY2hvZmllbGQgPGFsaXNvbi5zY2hv
ZmllbGRAaW50ZWwuY29tPg0KPiANCj4gbWF0Y2hfZGVjb2Rlcl9ieV9yYW5nZSgpIGFuZCBkZWNv
ZGVyX21hdGNoX3JhbmdlKCkgYm90aCBkZXRlcm1pbmUNCj4gaWYgYW4gSFBBIHJhbmdlIG1hdGNo
ZXMgYSBkZWNvZGVyLiBUaGUgZmlyc3QgZG9lcyBpdCBmb3Igcm9vdA0KPiBkZWNvZGVycyBhbmQg
dGhlIHNlY29uZCBvbmUgb3BlcmF0ZXMgb24gc3dpdGNoIGRlY29kZXJzLg0KPiANCj4gVGlkeSB0
aGVzZSB1cCB3aXRoIGNsZWFyIG5hbWluZyBhbmQgbWFrZSB0aGUgc3dpdGNoIGhlbHBlciBtb3Jl
DQo+IGxpa2UgdGhlIHJvb3QgZGVjb2RlciBoZWxwZXIgaW4gc3R5bGUgYW5kIGZ1bmN0aW9uYWxp
dHkuIE1ha2UgaXQNCj4gdGFrZSB0aGUgYWN0dWFsIHJhbmdlLCByYXRoZXIgdGhhbiBhbiBlbmRw
b2ludCBkZWNvZGVyIGZyb20gd2hpY2gNCj4gaXQgZXh0cmFjdHMgdGhlIHJhbmdlLg0KPiANCj4g
QXNpZGUgZnJvbSBhZXN0aGV0aWNzIGFuZCBtYWludGFpbmFiaWxpdHksIHRoaXMgaXMgaW4gcHJl
cGFyYXRpb24NCj4gZm9yIHJldXNlLg0KPiANCj4gRml4ZXM6IGEzMjMyMGI3MWYwOCAoImN4bC9y
ZWdpb246IEFkZCByZWdpb24gYXV0b2Rpc2NvdmVyeSIpDQo+IFJlcG9ydGVkLWJ5OiBEbXl0cm8g
QWRhbWVua28gPGRteXRyby5hZGFtZW5rb0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFs
aXNvbiBTY2hvZmllbGQgPGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1i
eTogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBKb25h
dGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiBkcml2
ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIHwgMTYgKysrKysrKysrKy0tLS0tLQ0KPiAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0K
PiBpbmRleCA2ZDYzYjg3OThjMjkuLjY0MjA2ZmM0ZDk5YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9jeGwvY29yZS9yZWdpb24uYw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+
IEBAIC0xNDg3LDE2ICsxNDg3LDE5IEBAIHN0YXRpYyBzdHJ1Y3QgY3hsX3BvcnQgKm5leHRfcG9y
dChzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQpDQo+IHJldHVybiBwb3J0LT5wYXJlbnRfZHBvcnQtPnBv
cnQ7DQo+IH0NCj4gDQo+IC1zdGF0aWMgaW50IGRlY29kZXJfbWF0Y2hfcmFuZ2Uoc3RydWN0IGRl
dmljZSAqZGV2LCB2b2lkICpkYXRhKQ0KPiArc3RhdGljIGludCBtYXRjaF9zd2l0Y2hfZGVjb2Rl
cl9ieV9yYW5nZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpDQo+IHsNCj4gLSBzdHJ1
Y3QgY3hsX2VuZHBvaW50X2RlY29kZXIgKmN4bGVkID0gZGF0YTsNCj4gKyBzdHJ1Y3QgcmFuZ2Ug
KnIxLCAqcjIgPSBkYXRhOw0KPiBzdHJ1Y3QgY3hsX3N3aXRjaF9kZWNvZGVyICpjeGxzZDsNCj4g
DQo+IGlmICghaXNfc3dpdGNoX2RlY29kZXIoZGV2KSkNCj4gcmV0dXJuIDA7DQo+IA0KPiBjeGxz
ZCA9IHRvX2N4bF9zd2l0Y2hfZGVjb2RlcihkZXYpOw0KPiAtIHJldHVybiByYW5nZV9jb250YWlu
cygmY3hsc2QtPmN4bGQuaHBhX3JhbmdlLCAmY3hsZWQtPmN4bGQuaHBhX3JhbmdlKTsNCj4gKyBy
MSA9ICZjeGxzZC0+Y3hsZC5ocGFfcmFuZ2U7DQo+ICsgcmV0dXJuIHJhbmdlX2NvbnRhaW5zKHIx
LCByMik7DQo+ICt9DQoNCkhpIEFsaXNvbiwNCg0KVGhpcyBzdHJheSBjbG9zaW5nIGJyYWNlIG5l
ZWRzIHRvIGJlIHJlbW92ZWQgZnJvbSB0aGlzIHBhdGNoLg0KDQpSZXN0IG9mIHRoZSBwYXRjaCBs
b29rcyBnb29kLCBJIGFncmVlIHRoZSBuYW1pbmcgaXMgbXVjaCBiZXR0ZXIgd2l0aCB0aGVzZQ0K
Y2hhbmdlcy4NCg0KUmV2aWV3ZWQtYnk6IEppbSBIYXJyaXMgPGppbS5oYXJyaXNAc2Ftc3VuZy5j
b20+DQoNCj4gKw0KPiB9DQo+IA0KPiBzdGF0aWMgdm9pZCBmaW5kX3Bvc2l0aW9ucyhjb25zdCBz
dHJ1Y3QgY3hsX3N3aXRjaF9kZWNvZGVyICpjeGxzZCwNCj4gQEAgLTE1NjUsNyArMTU2OCw4IEBA
IHN0YXRpYyBpbnQgY21wX2RlY29kZV9wb3MoY29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikN
Cj4gZ290byBlcnI7DQo+IH0NCj4gDQo+IC0gZGV2ID0gZGV2aWNlX2ZpbmRfY2hpbGQoJnBvcnQt
PmRldiwgY3hsZWRfYSwgZGVjb2Rlcl9tYXRjaF9yYW5nZSk7DQo+ICsgZGV2ID0gZGV2aWNlX2Zp
bmRfY2hpbGQoJnBvcnQtPmRldiwgJmN4bGVkX2EtPmN4bGQuaHBhX3JhbmdlLA0KPiArIG1hdGNo
X3N3aXRjaF9kZWNvZGVyX2J5X3JhbmdlKTsNCj4gaWYgKCFkZXYpIHsNCj4gc3RydWN0IHJhbmdl
ICpyYW5nZSA9ICZjeGxlZF9hLT5jeGxkLmhwYV9yYW5nZTsNCj4gDQo+IEBAIC0yNjk2LDcgKzI3
MDAsNyBAQCBzdGF0aWMgaW50IGRldm1fY3hsX2FkZF9kYXhfcmVnaW9uKHN0cnVjdCBjeGxfcmVn
aW9uICpjeGxyKQ0KPiByZXR1cm4gcmM7DQo+IH0NCj4gDQo+IC1zdGF0aWMgaW50IG1hdGNoX2Rl
Y29kZXJfYnlfcmFuZ2Uoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpkYXRhKQ0KPiArc3RhdGlj
IGludCBtYXRjaF9yb290X2RlY29kZXJfYnlfcmFuZ2Uoc3RydWN0IGRldmljZSAqZGV2LCB2b2lk
ICpkYXRhKQ0KPiB7DQo+IHN0cnVjdCByYW5nZSAqcjEsICpyMiA9IGRhdGE7DQo+IHN0cnVjdCBj
eGxfcm9vdF9kZWNvZGVyICpjeGxyZDsNCj4gQEAgLTI4MjcsNyArMjgzMSw3IEBAIGludCBjeGxf
YWRkX3RvX3JlZ2lvbihzdHJ1Y3QgY3hsX3BvcnQgKnJvb3QsIHN0cnVjdCBjeGxfZW5kcG9pbnRf
ZGVjb2RlciAqY3hsZWQpDQo+IGludCByYzsNCj4gDQo+IGN4bHJkX2RldiA9IGRldmljZV9maW5k
X2NoaWxkKCZyb290LT5kZXYsICZjeGxkLT5ocGFfcmFuZ2UsDQo+IC0gICAgICBtYXRjaF9kZWNv
ZGVyX2J5X3JhbmdlKTsNCj4gKyAgICAgIG1hdGNoX3Jvb3RfZGVjb2Rlcl9ieV9yYW5nZSk7DQo+
IGlmICghY3hscmRfZGV2KSB7DQo+IGRldl9lcnIoY3hsbWQtPmRldi5wYXJlbnQsDQo+ICIlczol
cyBubyBDWEwgd2luZG93IGZvciByYW5nZSAlI2xseDolI2xseFxuIiwNCj4gLS0gDQo+IDIuMzcu
Mw0KPiANCj4gDQoNCg==
