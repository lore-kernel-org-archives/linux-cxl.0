Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE8208A6
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FmbPrY5B"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1875790
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 07:31:52 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231011143149usoutp020b7e92fbe25056f2621162ac6be70bc2~NFBPH-zSB2429524295usoutp02K;
	Wed, 11 Oct 2023 14:31:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231011143149usoutp020b7e92fbe25056f2621162ac6be70bc2~NFBPH-zSB2429524295usoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697034709;
	bh=FEQWoFMrNQIdXb368wNOnARQvfkckW2OvJsmeDcDL3w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=FmbPrY5BQWJA+BjRejtSwXycytl7MEpI2iv0qOYXo+SrUhxzA18ZFXPaPAOj5UYMU
	 GXXMJ7H61+RimjZvqDk2Sl+sXcvRR2HBbMqwtzJJML5zgModzeB9QvZSRBmtrKAZAU
	 wd73qno8psSdt4Uj8KWKIh+i+U+1gfVJFJynFgVA=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231011143149uscas1p1ac67d91e48adc92df236c9f42b7b7716~NFBO7JY472669226692uscas1p1_;
	Wed, 11 Oct 2023 14:31:49 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id BA.7F.62237.5D1B6256; Wed,
	11 Oct 2023 10:31:49 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231011143149uscas1p22a0c7bf455fd42d45b588990f1d39772~NFBOqkJ5L2802828028uscas1p2f;
	Wed, 11 Oct 2023 14:31:49 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-fc-6526b1d5a032
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 8F.83.28590.4D1B6256; Wed,
	11 Oct 2023 10:31:49 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 11 Oct 2023 07:31:48 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	11 Oct 2023 07:31:48 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jim Harris <jim.harris@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/region: don't try to cleanup after
 cxl_region_setup_targets() fails
Thread-Topic: [PATCH] cxl/region: don't try to cleanup after
	cxl_region_setup_targets() fails
Thread-Index: AQHZ+6j8MpVLjV1hUUCWKxMwxFDyyrBFFdKAgAAHfgA=
Date: Wed, 11 Oct 2023 14:31:48 +0000
Message-ID: <6AEE1954-A5E0-4026-BCD3-3603362215FF@ssi.samsung.com>
In-Reply-To: <f3b613eb-b948-498d-bdda-9038c7cf595c@kadam.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DDAA4C05617CA4184B40566E9D81F89@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzred2rG9VSDTbOkLH4MK+V3WL61AuM
	FudnnWJxYPZYvOclk8eda3vYPD5vkgtgjuKySUnNySxLLdK3S+DKOPz6AHvBL+GKa50XmRoY
	dwh3MXJwSAiYSMw/b9vFyMUhJLCSUeLFtU5WCKeVSeL5u9lsXYycYEVPDn5ih0isZZQ48mYi
	VNUnRom1z1+yQTjLGCUufH0E1sImoCnx68oaJhBbREBH4t/fySwgRcwCsxklru1+ywqSEBaI
	k7i95DgzRFG8xIc1X6BsK4knh2+CNbMIqEpMWbuUFeRYXgEniZMTM0DCnEBmx9W9YLsYBcQk
	vp+C2MUsIC5x68l8JoizBSUWzd7DDGGLSfzb9RDqHUWJ+99fsoOMZAa6c/0ufYhWO4lZ6zez
	Q9iKElO6H4LZvEBjTs58wgLRKilxcMUNsFckBNZySLw8fBhqvovE8n3HGCFsaYmr16dCxbMl
	Vq7vYIKEdYFEw5EgiLC1xMI/65kmMKrMQnL1LISLZiG5aBaSi2YhuWgBI+sqRvHS4uLc9NRi
	47zUcr3ixNzi0rx0veT83E2MwPRy+t/hgh2Mt2591DvEyMTBeIhRgoNZSYT3UaZKqhBvSmJl
	VWpRfnxRaU5q8SFGaQ4WJXFeQ9uTyUIC6YklqdmpqQWpRTBZJg5OqQamHZOCw4+1LHz/bo+7
	W8CNlBf+lmqBi5tddudMn1YwuXEF67ogZ72O+83C//h1X0erTWaS/aNbqLPgrJT2/Wl9f0XX
	nmc6fMKrJYjxUV/UxCPrmHuupAQ/75oxXeBK5jqhBbParfQOrl7Q+zT3+sIbhuy/HL62XLh4
	fnvULMXS0+Y+979NiQwwXf3pj5ZBtVS95JJzbk8+syUKvVfpsincNvWY9PXk5QvuF7uw3Vmy
	eX35QQPeAA7PqJ7KuVedNJIn8j22drlVK3ld/6KmkXlRRqL1N/1Zewv2OWxfyrt6hcPG7ML0
	9CUHOS6sV9PekHxG5OacSRwiUwsL790S+aO8yOanfMBWxkOZMr2Mp84+UGIpzkg01GIuKk4E
	ABnXljqeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWS2cA0SffqRrVUg/dfOC0+zGtlt5g+9QKj
	xflZp1gcmD0W73nJ5HHn2h42j8+b5AKYo7hsUlJzMstSi/TtErgyDr8+wF7wS7jiWudFpgbG
	HcJdjJwcEgImEk8OfmLvYuTiEBJYzSixf/ZMKOcTo8Sd6T+YIZxljBIzPq5iBGlhE9CU+HVl
	DROILSKgI/Hv72QWkCJmgdmMEtd2v2UFSQgLxEncXnKcGaIoXqL5wANWCNtK4snhm2DNLAKq
	ElPWLgWKc3DwCjhJnJyYAbHsOaPEy/c/wWo4geIdV/eygdiMAmIS309BLGYWEJe49WQ+E8QP
	AhJL9pxnhrBFJV4+/scKYStK3P/+kh1kPjPQ0et36UO02knMWr+ZHcJWlJjS/RDM5hUQlDg5
	8wkLRKukxMEVN1gmMErMQrJtFsKkWUgmzUIyaRaSSQsYWVcxipcWF+emVxQb5qWW6xUn5haX
	5qXrJefnbmIExufpf4cjdzAevfVR7xAjEwfjIUYJDmYlEd5HmSqpQrwpiZVVqUX58UWlOanF
	hxilOViUxHl3TLmYIiSQnliSmp2aWpBaBJNl4uCUamAyDH/twf9fd+9+zy1fTEJZdZ/KG8RG
	7AjbI+YwKYY1blvqxe+P5J8slv7Aelg4ZsfLP5lp/d2Puu6dvulmse3Lk+X7zF4ZPfUIYvsq
	0W19tfbEy7+JTu0sZyIKDnuYrupu7+t/dFrnwNyTLN2ut06xpPxVuZjoHGr4lslV+D7HsdRd
	y1P22vsVHTrvM9veQ593ncKS8x37aq9vluB+VqOYu1n+4ekm6ch7kqlLHJQCdq9vW7Wotab7
	ttrzZ5ar11s2m8g2fJh+/aax97Z0yVfMjeUn1AJl38dqBj18z2vTwellenxWveI6e7dNNYKz
	j9vlLfx0MSy41twt5qPE/qUecZ7vLVbuWj1tdTPj6kAlluKMREMt5qLiRADhInyRPgMAAA==
X-CMS-MailID: 20231011143149uscas1p22a0c7bf455fd42d45b588990f1d39772
CMS-TYPE: 301P
X-CMS-RootMailID: 20231010183840uscas1p294532ae60e6014508efd897fef14fffd
References: <CGME20231010183840uscas1p294532ae60e6014508efd897fef14fffd@uscas1p2.samsung.com>
	<169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
	<f3b613eb-b948-498d-bdda-9038c7cf595c@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDExLCAyMDIzLCBhdCA3OjA04oCvQU0sIERhbiBDYXJwZW50ZXIgPGRhbi5j
YXJwZW50ZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE9jdCAxMCwgMjAyMyBh
dCAwNjozODozOVBNICswMDAwLCBKaW0gSGFycmlzIHdyb3RlOg0KPj4gUGF0Y2ggNWU0MmJjYmMg
KCJjeGwvcmVnaW9uOiBkZWNyZW1lbnQgLT5ucl90YXJnZXRzIG9uIGVycm9yIGluDQo+PiBjeGxf
cmVnaW9uX2F0dGFjaCgpIikgdHJpZWQgdG8gYXZvaWQgJ2VpdycgaW5pdGlhbGl6YXRpb24gZXJy
b3JzIHdoZW4NCj4+IC0+bnJfdGFyZ2V0cyBleGNlZWRlZCAxNiwgYnkganVzdCBkZWNyZW1lbnRp
bmcgLT5ucl90YXJnZXRzIHdoZW4NCj4+IGN4bF9yZWdpb25fc2V0dXBfdGFyZ2V0cygpIGZhaWxl
ZC4NCj4gDQo+IEkgbWVhbiB0aGF0J3Mgd2hhdCBJIHdyb3RlIGJ1dCBJIGZhaXJseSBzdXJlIHRo
YXQgSSB3YXMgY29uY2VybmVkIGFib3V0DQo+IC0+bnJfdGFyZ2V0cyBnZXR0aW5nIGluY3JlbWVu
dGVkIHRvIGFuIGludmFsaWQgdmFsdWUuDQo+IA0KPiBkcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5j
DQo+ICAxNzQ2ICAgICAgICAgIHAtPnRhcmdldHNbcG9zXSA9IGN4bGVkOw0KPiAgICAgICAgICAg
ICAgICBeXl5eXl5eXl5eXl5eXl4NCj4gVGhpcyBhcnJheSBoYXMgQ1hMX0RFQ09ERVJfTUFYX0lO
VEVSTEVBVkUgKDE2KSBlbGVtZW50cy4NCg0KQWdyZWVkLCB3ZSBuZWVkIHRvIGd1YXJkIGFnYWlu
c3QgdGhlIGFycmF5IG92ZXJmbG93IHRvby4NCg0KPiANCj4gQnV0IEkgd2FzIGp1c3QgZ29pbmcg
ZnJvbSBzdGF0aWMgYW5hbHlzaXMgYW5kIGNvZGUgcmV2aWV3IGFuZCBub3QNCj4gdGVzdGluZyBh
bmQgb2J2aW91c2x5IHlvdSBoYXZlIHRlc3RlZCB0aGlzLiAgQSBzaW1wbGUgZml4IGZvciBteQ0K
PiBjb25jZXJuIHdvdWxkIGJlIHRvIGRvIHRoaXM6DQo+IA0KPiByZWdhcmRzLA0KPiBkYW4gY2Fy
cGVudGVyDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2Ry
aXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gaW5kZXggNmQ2M2I4Nzk4YzI5Li41OTQ4YzRhMDE3
NDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gKysrIGIvZHJp
dmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiBAQCAtMTY0OSw2ICsxNjQ5LDExIEBAIHN0YXRpYyBp
bnQgY3hsX3JlZ2lvbl9hdHRhY2goc3RydWN0IGN4bF9yZWdpb24gKmN4bHIsDQo+IHJldHVybiAt
RU5PREVWOw0KPiB9DQo+IA0KPiArIGlmIChwLT5ucl90YXJnZXRzID49IHAtPmludGVybGVhdmVf
d2F5cykgew0KPiArIGRldl9kYmcoJmN4bHItPmRldiwgIiVzIHRvbyBtYW55IHJlZ2lvbnNcbiIs
IGRldl9uYW1lKCZjeGxlZC0+Y3hsZC5kZXYpKTsNCj4gKyByZXR1cm4gLUVJTlZBTDsNCj4gKyB9
DQo+ICsNCj4gLyogYWxsIGZ1bGwgb2YgbWVtYmVycywgb3IgaW50ZXJsZWF2ZSBjb25maWcgbm90
IGVzdGFibGlzaGVkPyAqLw0KPiBpZiAocC0+c3RhdGUgPiBDWExfQ09ORklHX0lOVEVSTEVBVkVf
QUNUSVZFKSB7DQo+IGRldl9kYmcoJmN4bHItPmRldiwgInJlZ2lvbiBhbHJlYWR5IGFjdGl2ZVxu
4oCdKTsNCg0KSeKAmWxsIHB1c2ggYSB2Mi4NCg0KSSBoYWQgdG8gY29udmluY2UgbXlzZWxmIHRo
YXQgd2UgZGlkbuKAmXQgYWxzbyBuZWVkIGEgY29tcGFyaXNvbiBhZ2FpbnN0DQpDWExfREVDT0RF
Ul9NQVhfSU5URVJMRUFWRS4gQnV0IGludGVybGVhdmVfd2F5c19zdG9yZSgpIHdpbGwgZmFpbCB3
aXRoDQphIHZhbHVlID4gMTYgdmlhIHRoZSB3YXlzX3RvX2VpdygpIGNhbGwsIHNvIHRoZSBwLT5p
bnRlcmxlYXZlX3dheXMgY2hlY2sNCmlzIHN1ZmZpY2llbnQuDQoNCg0K
