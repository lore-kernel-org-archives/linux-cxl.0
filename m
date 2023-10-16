Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC82C843
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qT/f0GBH"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA513F2
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 08:55:33 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231016155533usoutp01d188169b098f90673a275be9c1ca04b1~OoYw05szP1812818128usoutp01M;
	Mon, 16 Oct 2023 15:55:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231016155533usoutp01d188169b098f90673a275be9c1ca04b1~OoYw05szP1812818128usoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697471733;
	bh=LvHDFR+vuMRH5rLZNmzG+Xrwka71lW37zhCpZYx4rmM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=qT/f0GBHy60wotEmQPg29iVsZNa+1ZJjBx/ncEDQXmZ6hyk4Zun0r/0I/+NYV5XWc
	 jThXvyVOUi//8TbFmHmAm6Nyk0aFBIq/YJBewPumCn0MJ4bYFCAWIoq9MUN78qSGoO
	 eY6hZ6IMW+5aEvqYjZzJms/7tGseF2elthqJqVKk=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231016155532uscas1p1ed905ba13660afe8a5e6aa3be0b63afb~OoYwrYT3m0161101611uscas1p1U;
	Mon, 16 Oct 2023 15:55:32 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 6A.9B.40279.4FC5D256; Mon,
	16 Oct 2023 11:55:32 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231016155532uscas1p20f8e9f29f22b4a9a1f5a5fcf476e0d86~OoYwcLlck0361303613uscas1p2Q;
	Mon, 16 Oct 2023 15:55:32 +0000 (GMT)
X-AuditID: cbfec36f-4cbfe70000009d57-e1-652d5cf472e3
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 20.2C.31410.4FC5D256; Mon,
	16 Oct 2023 11:55:32 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Mon, 16 Oct 2023 08:55:31 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
	16 Oct 2023 08:55:31 -0700
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
Thread-Index: AQHZ/hyy5QqP0fYlxU6WffpG9Jr0k7BNC3SA
Date: Mon, 16 Oct 2023 15:55:31 +0000
Message-ID: <95CCA841-8704-40F2-9827-38E03A847229@ssi.samsung.com>
In-Reply-To: <169723270125.66903.9705024211129163971.stgit@djiang5-mobl3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED4A29CB5237BE4F854964D8469C41C4@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djX87pfYnRTDd5OM7e4+/gCm8X0qRcY
	LU7cbGSzWH1zDaPF/qfPWSxWLbzGZnF+1ikWi1sTjjE5cHi0HHnL6rF4z0smj6mz6z0+b5IL
	YInisklJzcksSy3St0vgyvj79TV7wQHhinnvdBoYG4S7GDk4JARMJLrW+HUxcnEICaxklHg5
	/wobhNPKJPHh4TvmLkZOsKLbq0+yQyTWMEpcWf2KFcL5xCjR27iKGcJZxijR1nuOBaSFTUBT
	4teVNUwgtoiAqsT99Y/B5jILfGaSOP7pPCNIQlggVGLiic2sIIeICIRJbP8YD1FvJLFy3S6w
	OSxAvesWHGEHsXkFnCRW/tkENpNTwFNizfNWsBpGATGJ76cgdjELiEvcejKfCeJsQYlFs/dA
	vSAm8W/XQzYIW1Hi/veX7CBrmYHuXL9LH6LVTqL90x0WCFtRYkr3Q6i1ghInZz5hgWiVlDi4
	4gYLyCsSAlc4JCZ/+g8100Vi1YPLUEXSEtPXwNjZEivXdzBBwrpAouFIEETYWmLhn/VMExhV
	ZiG5ehbCRbOQXDQLyUWzkFy0gJF1FaN4aXFxbnpqsVFearlecWJucWleul5yfu4mRmBaOv3v
	cP4Oxuu3PuodYmTiYDzEKMHBrCTCmx6skyrEm5JYWZValB9fVJqTWnyIUZqDRUmc19D2ZLKQ
	QHpiSWp2ampBahFMlomDU6qBycZt9sZ/HIL+vMKRmbzTIyb6/LjdYvFwf0jZvFVp8iVndq/T
	KP2pnSB4cGvH/DrHo7W2m+TWZnxtUkj7fnfr68oj4e0mW9P5xeSzBaer59il1IkeY7nz7alm
	n3zkL043tTW9KUmef1ZsejQ7bOn+Q+zujYoP+F5uXbsi61HB9WZxw5u8s+cpJ+2TjglKTJzO
	di6UJ+OsxcybExYyzNIq2sda+sJcLreBpe3tdGWDuodBZrWX3ZWDF4YeX5RXa3+gMjqCl/Oc
	1uMjD8SSOlLTjF68X67FW562rio5bd3WX7Ns/yhmFonOOWckkLHrlfSHY5/PmL47md7+IJjt
	Wv1E1U1qAhoR1X4llxeUmYUqsRRnJBpqMRcVJwIAUPh9pboDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWS2cDsrPslRjfV4NwpFYu7jy+wWUyfeoHR
	4sTNRjaL1TfXMFrsf/qcxWLVwmtsFudnnWKxuDXhGJMDh0fLkbesHov3vGTymDq73uPzJrkA
	ligum5TUnMyy1CJ9uwSujL9fX7MXHBCumPdOp4GxQbiLkZNDQsBE4vbqk+xdjFwcQgKrGCV6
	rr9jhHA+MUrMbHjCAuEsY5RYubSLHaSFTUBT4teVNUwgtoiAqsT99Y/ZQIqYBT4zSRz/dJ4R
	JCEsECox8cRmVoiiMImpz39CNRhJrFy3iwXEZgFqXrfgCNhQXgEniZV/NjFBbLvDKHFi72Ww
	Bk4BT4k1z1vBGhgFxCS+n4LYzCwgLnHryXwmiCcEJJbsOc8MYYtKvHz8jxXCVpS4//0l0AIO
	oHpNifW79CFa7STaP91hgbAVJaZ0P4S6QVDi5MwnLBCtkhIHV9xgmcAoMQvJtlkIk2YhmTQL
	yaRZSCYtYGRdxSheWlycm15RbJyXWq5XnJhbXJqXrpecn7uJERjZp/8djtnBeO/WR71DjEwc
	jIcYJTiYlUR404N1UoV4UxIrq1KL8uOLSnNSiw8xSnOwKInz3n2gkSokkJ5YkpqdmlqQWgST
	ZeLglGpgOv9ur3tAyae/uyaKbREyUVF2i+26eOug/99+/5xFXYvvsgYwLLPeocl+a5p7pIVs
	j4DrrJldoQv7d/xaJ6HaLhMpVaB91PrezrW758zfsnmH+/6fP92rgrrZeiIWTxesN/ebfKV8
	88IVD/p32x3Lvp/0sKXNpvXy1dKjC/JsT3b2XRV4ULnxi5a3TUVjUD7f6caK4g/GQp0nP6+a
	8v1Eoe93u+kseW8bA/bPvMMwO4lZ6uT7GbJ6Ene0DzHXZBxeMX3SUdXU17btLE+i7vkef5bS
	2em9m2nSea46mc7yi9uXeWUaHLwgUnHlB7/+730Khve7RRyVrDv9+bu0Kjccs53l9teN5Ssr
	e73FCYV1SizFGYmGWsxFxYkANI/AoVsDAAA=
X-CMS-MailID: 20231016155532uscas1p20f8e9f29f22b4a9a1f5a5fcf476e0d86
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
b3VwLA0KPiBOVUxMLA0KPiB9Ow0KPiANCj4gDQo+IA0KPiANCg0KTGV04oCZcyB0cnkgdG8gc2Vu
ZCBpdCBjb3JyZWN0bHkgdGhpcyB0aW1lLg0KDQpSZXZpZXdlZC1ieTogSmltIEhhcnJpcyA8amlt
LmhhcnJpc0BzYW1zdW5nLmNvbSA8bWFpbHRvOmppbS5oYXJyaXNAc2Ftc3VuZy5jb20+Pg0KDQo=
