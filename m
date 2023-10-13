Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FF224DF
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k3TSFGFE"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F8DC9
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 15:57:34 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231013225733usoutp01a750cbe6b588ffa701d88ef3b7cea516~NzNXaz-vu3077130771usoutp01a;
	Fri, 13 Oct 2023 22:57:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231013225733usoutp01a750cbe6b588ffa701d88ef3b7cea516~NzNXaz-vu3077130771usoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697237853;
	bh=dFfSgZe6Ro8rAwGNn96foGW+yRf2CnMAIRP70MxFop0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=k3TSFGFERZfwbDd/fqoEMU8zf5dZREI/WBFCPTA48TjgJTgiezcnrhlmybK+BkG4z
	 psxIeezi7Sutkmu+M26NulOopeKjuK6ROi+RFQEJUcaqn7DJRbeiwJpYAtvpZ+1Kx+
	 kTCFNE+Ynzgi3wD8VYy+52cagoA/hnvTEskLg/KY=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231013225730uscas1p1bf5ffd28795cf0e7a31caa81f3a8d049~NzNUtgUs72120021200uscas1p1r;
	Fri, 13 Oct 2023 22:57:30 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 89.F0.50148.A5BC9256; Fri,
	13 Oct 2023 18:57:30 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231013225730uscas1p2ac184a4726e38e6fc3ea92a82c9a5c6d~NzNUZ-BTV2571925719uscas1p2Z;
	Fri, 13 Oct 2023 22:57:30 +0000 (GMT)
X-AuditID: cbfec36d-7bdff7000002c3e4-8a-6529cb5a3d3d
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id BC.6C.31200.95BC9256; Fri,
	13 Oct 2023 18:57:30 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 13 Oct 2023 15:57:29 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	13 Oct 2023 15:57:29 -0700
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
Thread-Index: AQHZ/hyy5QqP0fYlxU6WffpG9Jr0k7BIyluA
Date: Fri, 13 Oct 2023 22:57:29 +0000
Message-ID: <EA82FB5F-6C78-4DB7-853B-27DDC09AA1C8@ssi.samsung.com>
In-Reply-To: <169723270125.66903.9705024211129163971.stgit@djiang5-mobl3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <23FB75EB2E14FF44B7851BF743708686@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjlvbu73o0Gd1Pa46SiVZCSmqFxKZNRUVqBlfQlkS29beZHsrtl
	Hz9yoVEGsSILp9Q0XWrThcWqVVQrLWe0MvvQsg/S1GyWqaxWWl6vkf8O5znnPed5eEmBzCpU
	kOnZekaXrc5UEmLc0TjsCU9uDmXm91xR0B0fnxD0maIniH7YZiToi202RN/u6sbpmrIXBO0x
	u3G63dSIqcj4/PteYfz5m71YfFHJwfjB+ulr8WRxbBqTmb6H0UXGbRdrPU1eLOeNdK/tUjue
	hyzSQiQigYoGU0OlsBCJSRlVjWDU9wDnBjKqAIPDxtxCRI6L7rmDeboWge81zeu/I8i39EyY
	rQj8I6UBnIqgQsHfasM4HETNgXf2jwQnElCDGDz47kHcIJDaACceXhZyCUHURrg6kMLrF0Bz
	iVXIYXzM21bsHn9HQi2Fskb3OC+iEsDWXTBeFFFTwefmswSUHNo7z2H8ZlIoL7kp4PFUGHV+
	IHg8E975egO4WMFYT7szkrfGwY1nPiGPZ8KpYx8C+FgpNBV34rw1GO5WvcK5VYBqJWG43DiR
	tRw+fa2dyAqBkQ7rBJ8B1fYjGH/EHMi7v56nF0PZbztmQrPNk1qb/zcyT2pkntTIPKmRBQlr
	kNzAslkaho3KZnIjWHUWa8jWRKTuzqpHY1+pefRe1jV0rX0gwoUwErkQkAJlkKRk21xGJklT
	79vP6Han6AyZDOtCISSulEuiljSlyiiNWs9kMEwOo/s3xUiRIg+THrZ1iypj3ar+wS+1wzp3
	uVjquxGn0D/znvVZ7uzxu46WrkvsngJFeZ1Bz1vprxKvMTyhK1Vm9RsN1yPyDSeTelfNOGSK
	rWhI0/Q4iR+EqP5tX29VSB+GVbFlgJ/1BiTW1d5d/1K/UtiSsEO+QY8KTzu0iso1YUMtqh3l
	ixxX5z1P6VxYPboxZrb2lv+yxHOhP3rnQaeyrqvAEdwSLTrPbElIXjDg/aLSVv1aEo12pj9N
	a1McwPDb30JzUiKrCzbVrNacdmS8hwvBg0nFIW9n1SlGYt67YiyNzhUdQ3cqwj5Pa946tOKR
	anNDxuOfy4z7/nhsgfaoXWeeHpeblDirVUeFCXSs+i+xCCepuQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01RfSyUcRz3e17O48Qe779ojK2JFTGrZzKpZJi1ZmPrtHLLE1ccu8fl9DK0
	Wnn5w2vmuXIsbkJjKlOkvN45hEhODnF2o+nNMP5I3KPlv8/3+/l+Pp/vd18CtVZjjoRInEpL
	xMJENx4fE2UihUcE/R700YIGgtLND/Oo0pJhQKm1WTyqTlsPqHcLBoyqrRznUUOsBqMm83uR
	ICL0XvcyHvq0bREJLZFnhK40OZ/HBPyAODpRdIOWeAfG8hOG+paRlCkrWX3jJJYJKqxyAEFA
	0g92afbnAD5hTdYB+LxsFueK3wDqB1geVygB7F6bxnKAGcEjPeDmWD2yg23Jg3CmYd44hJIr
	CFT9HgI7hA0ZBQvUL3BuKBqWGDZ2Bb6wX6409rFtsbZMY+xbkKdhZa9mN3oKQPXbUSNhRobB
	esN9YzIg7eG6hktGSQc4qVcYMSRJWNU2hHLYDi7O/8E57Apn1hdNd+5Et7dueOPNSQNh6+g6
	zmFXWJz71ZTbwQr2lekxTrofdtRMYPkAsnvS2P9O7B4ndo8Tu8epAuC1wEHKMEnxMsZXTKd5
	McIkRiqO97qSnNQEtp/d/6crpgV8mfzl1QkQAnQCSKButhbyS4doa4s4YfpNWpJ8WSJNpJlO
	4ERgbg4WutltiowXptLXaTqFlvxjEcLMMRPxfc3POOA+1xa1Ikhjxk85CHJNFP75VLXybkSK
	bftI3rEHJ0QhcWtF2luqlsO65kHR2KNg1L1A8CwoHYvWDaTLV0+V60pX1dUmYXdkCz3lWRew
	kbN5LvvszU08T2bTma62Y1drTSOCP0e2nmRrq+TdKqJ1sPBDo4eqzPlxiAzTfPJzCVBe7DD1
	NHfx7LaUxqKWtA6z73ofGDTlk/0d4qwi6fvWhsIQL/2o9Y/ZsnlyM/vMdGN00V3lz00cURva
	i1P8rs10sK/C52wiX048qGnOup2F9/EDlMEqSQ973MnOhYpRtOk7vy0ti0uEU2z2j0Fl+LmH
	+iXrWKLXxw1jEoQ+nqiEEf4FmeQYo1sDAAA=
X-CMS-MailID: 20231013225730uscas1p2ac184a4726e38e6fc3ea92a82c9a5c6d
CMS-TYPE: 301P
X-CMS-RootMailID: 20231013213157uscas1p1f16d6c45d92a8af12d173a3f2978a174
References: <169723269532.66903.10556183191413240496.stgit@djiang5-mobl3>
	<CGME20231013213157uscas1p1f16d6c45d92a8af12d173a3f2978a174@uscas1p1.samsung.com>
	<169723270125.66903.9705024211129163971.stgit@djiang5-mobl3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCk9uIE9jdCAxMywgMjAyMywgYXQgMjozMeKAr1BNLCBEYXZlIEppYW5nIDxkYXZlLmppYW5n
QGludGVsLmNvbT4gd3JvdGU6DQoNClRoaXMgYXR0cmlidXRlIGFsbG93cyBjeGwtY2xpIHRvIGRl
dGVybWluZSB3aGV0aGVyIHRoZXJlIGFyZSBkZWNvZGVycw0KY29tbWl0dGVkIHRvIGEgbWVtZGV2
LiAgVGhpcyBpcyBvbmx5IGEgc25hcHNob3Qgb2YgdGhlIHN0YXRlLCBhbmQNCmRvZXNuJ3Qgb2Zm
ZXIgYW55IHByb3RlY3Rpb24gb3Igc2VyaWFsaXphdGlvbiBhZ2FpbnN0IGEgY29uY3VycmVudA0K
ZGlzYWJsZS1yZWdpb24gb3BlcmF0aW9uLg0KDQpTdWdnZXN0ZWQtYnk6IERhbiBXaWxsaWFtcyA8
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogRGF2ZSBKaWFuZyA8ZGF2
ZS5qaWFuZ0BpbnRlbC5jb20+DQoNCi0tLQ0KdjI6DQotIFVzZSBjeGxfcmVnaW9uX3J3c2VtIHRv
IHByb3RlY3QgcmVhZGluZyBvZiBkZWNvZGVyIGluZm8uIChEYW4pDQotLS0NCmRyaXZlcnMvY3hs
L2NvcmUvcG9ydC5jIHwgICAyNSArKysrKysrKysrKysrKysrKysrKysrKysrDQoxIGZpbGUgY2hh
bmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9w
b3J0LmMgYi9kcml2ZXJzL2N4bC9jb3JlL3BvcnQuYw0KaW5kZXggZmQxY2MzMDc3NTlmLi5hNDQ4
ZTE0MzliNjggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3BvcnQuYw0KKysrIGIvZHJp
dmVycy9jeGwvY29yZS9wb3J0LmMNCkBAIC01MzQsOCArNTM0LDMzIEBAIHN0YXRpYyB2b2lkIGN4
bF9wb3J0X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQ0Ka2ZyZWUocG9ydCk7DQp9DQoNCitz
dGF0aWMgc3NpemVfdCBkZWNvZGVyc19jb21taXR0ZWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYs
DQorICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQorew0K
KyBzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQgPSB0b19jeGxfcG9ydChkZXYpOw0KKyBpbnQgcmM7DQor
DQorIGRvd25fcmVhZCgmY3hsX3JlZ2lvbl9yd3NlbSk7DQorIHJjID0gc3lzZnNfZW1pdChidWYs
ICIlZFxuIiwgY3hsX2RlY29kZXJzX2NvbW1pdHRlZChwb3J0KSk7DQorIHVwX3JlYWQoJmN4bF9y
ZWdpb25fcndzZW0pOw0KKw0KKyByZXR1cm4gcmM7DQorfQ0KKw0KK3N0YXRpYyBERVZJQ0VfQVRU
Ul9STyhkZWNvZGVyc19jb21taXR0ZWQpOw0KKw0KK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpj
eGxfcG9ydF9hdHRyc1tdID0gew0KKyAmZGV2X2F0dHJfZGVjb2RlcnNfY29tbWl0dGVkLmF0dHIs
DQorIE5VTEwsDQorfTsNCisNCitzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBjeGxfcG9y
dF9hdHRyaWJ1dGVfZ3JvdXAgPSB7DQorIC5hdHRycyA9IGN4bF9wb3J0X2F0dHJzLA0KK307DQor
DQpzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCAqY3hsX3BvcnRfYXR0cmlidXRl
X2dyb3Vwc1tdID0gew0KJmN4bF9iYXNlX2F0dHJpYnV0ZV9ncm91cCwNCisgJmN4bF9wb3J0X2F0
dHJpYnV0ZV9ncm91cCwNCk5VTEwsDQp9Ow0KDQoNCg0KUmV2aWV3ZWQtYnk6IEppbSBIYXJyaXMg
PGppbS5oYXJyaXNAc2Ftc3VuZy5jb208bWFpbHRvOmppbS5oYXJyaXNAc2Ftc3VuZy5jb20+Pg0K
DQo=
