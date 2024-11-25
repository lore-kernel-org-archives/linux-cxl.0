Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4CB2500CC
	for <linux-cxl@vger.kernel.org>; Mon, 25 Nov 2024 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565695; cv=none; b=YLYj9V7oE+mI/cUBnvQ5GydU260By52IzKwsWMbNmZhnhT/kjWGXSY2m5qYZTKyvo27t6g2+vgSXr4ZJ+yM/G3XxdWa4nanEYhaf5IPTk0QD51SUTTxNfch4cqJWJFDTinL4lBMEwDDmXPqRuAqc8U79lAnBzDwIbeiDFNstOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565695; c=relaxed/simple;
	bh=fPIjxkPn987tR/dUVK67TzE65vGpG5qpjmABFa1yB8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i+jTLOBXDwj2KoeKs0IXWRCDevzl3ndmGXYfcGUEV+pjim1zfmF2nwfSSS3u4rgxrCp5O7uFkDx8lG4QGx55BW32pyd4fmvfwJ/LfHRNSR24Nt24FMe1NMNfr6KS0rSHYI1PKQqxWZ3ED17O7CJfJ7qZCuChOFJ13MdMJunZGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XxxkM1rC3z6L6v2;
	Tue, 26 Nov 2024 04:14:19 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id DE31B140CF4;
	Tue, 26 Nov 2024 04:14:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 21:14:49 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 25 Nov 2024 21:14:49 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [RFC PATCH v2 05/20] cxl: Add Get Feature command support for
 user submission
Thread-Topic: [RFC PATCH v2 05/20] cxl: Add Get Feature command support for
 user submission
Thread-Index: AQHbN6U/rUm0Y9Xal02WbSG4drTRV7LB+uYAgAG7VYCABMTWwA==
Date: Mon, 25 Nov 2024 20:14:49 +0000
Message-ID: <6490e9f5ec354b64ad5141636bb53bba@huawei.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-6-dave.jiang@intel.com>
 <20241121174748.000046ce@huawei.com>
 <e461c96c-340e-47b5-9eb0-db2125ed01e2@intel.com>
In-Reply-To: <e461c96c-340e-47b5-9eb0-db2125ed01e2@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFu
Z0BpbnRlbC5jb20+DQo+U2VudDogMjIgTm92ZW1iZXIgMjAyNCAyMDoxNQ0KPlRvOiBKb25hdGhh
biBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+DQo+Q2M6IGxpbnV4LWN4bEB2
Z2VyLmtlcm5lbC5vcmc7IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgaXJhLndlaW55QGludGVs
LmNvbTsNCj52aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGFsaXNvbi5zY2hvZmllbGRAaW50ZWwu
Y29tOyBkYXZlQHN0Z29sYWJzLm5ldDsNCj5qZ2dAbnZpZGlhLmNvbTsgU2hpanUgSm9zZSA8c2hp
anUuam9zZUBodWF3ZWkuY29tPjsgU2hpanUgSm9zZQ0KPjxzaGlqdS5qb3NlQGh1YXdlaS5jb20+
DQo+U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMDUvMjBdIGN4bDogQWRkIEdldCBGZWF0dXJl
IGNvbW1hbmQgc3VwcG9ydCBmb3INCj51c2VyIHN1Ym1pc3Npb24NCj4NCj4NCj4NCj5PbiAxMS8y
MS8yNCAxMDo0NyBBTSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4+IE9uIEZyaSwgMTUgTm92
IDIwMjQgMTQ6MjU6MzggLTA3MDANCj4+IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29t
PiB3cm90ZToNCj4+DQo+Pj4gQWRkIGVudW1lcmF0aW9uIG9mIEdldCBGZWF0dXJlIG1haWxib3gg
Y29tbWFuZCBmb3IgdGhlIGtlcm5lbCB0bw0KPj4+IHJlY29nbml6ZSB0aGUgY29tbWFuZCBiZWlu
ZyBwYXNzZWQgaW4gZnJvbSB1c2VyIHNwYWNlLg0KPj4+DQo+Pj4gQ1hMIHNwZWMgcjMuMSA4LjIu
OS42LjIgR2V0IEZlYXR1cmUgKE9wY29kZSAwNTAxaCkNCj4+Pg0KPj4+IFRoZSBmZWF0dXJlIHJl
cXVlc3RlZCBpcyBpZGVudGlmaWVkIGJ5IHNwZWNpZmljIFVVSUQuDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4+IEhtbS4gU2hvdWxk
IHdlIHB1c2ggdGhpcyBpbnRvIFNoaWp1J3Mgc2VyaWVzIGlmIHRob3VnaHQgaXMgdGhhdCB3aWxs
DQo+PiBsYW5kIGZpcnN0PyAgU2VlbXMgaGFybWxlc3MgYnV0IEkgZmluZCBpdCBoYXJkIHRvIGNh
cmUgdGhhdCBtdWNoIDspDQo+DQo+WWVzIGlmIFNoaWp1IGNhbiBmb2xkIHRoaXMgaW50byBoaXMg
Z2V0IGZlYXR1cmUgcGF0Y2ggdGhhdCdkIGJlIGdyZWF0Lg0KPg0KPkF0IHNvbWUgcG9pbnQgd2Ug
c2hvdWxkIHN0YWJpbGl6ZSB0aGUgY29tbW9uIHBhdGNoZXMgYmV0d2VlbiB0aGUgdHdvIHNlcmll
cw0KPmFuZCBnZXQgdGhhdCBjb21taXR0ZWQgdG8gY3hsL25leHQuDQoNCkhpIERhdmUsDQpJIG1l
cmdlZCB0aGlzIHBhdGNoIHRvIHRoZSBnZXQgZmVhdHVyZSBwYXRjaC4NClRoZSByZWFycmFuZ2Vk
IHYxNyBwYXRjaGVzIGZvciBDWEwgZmVhdHVyZSBjb21tYW5kcyggaW5jbHVkaW5nIHRoZSBtZXJn
ZWQgcGF0Y2gpDQphbmQgYXJlIGF2YWlsYWJsZSBoZXJlLCANCihuZXh0IHZlcnNpb24gbWF5IGJl
IHNlbmQgYWZ0ZXIgcmVjZWl2aW5nIGZlZWRiYWNrcyBmcm9tIEJvcmlzbGF2IG9uIEVEQUMgcGF0
Y2hlcykuDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9zaGlqdWpvc2U0L2xpbnV4LmdpdA0KQnJhbmNo
OiBlZGFjLWVuaGFuY2VtZW50LXJhcy1mZWF0dXJlc192MTdfdXBkYXRlZA0KDQpUaGFua3MsDQpT
aGlqdQ0KPg0KPj4NCj4+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5D
YW1lcm9uQGh1YXdlaS5jb20+DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvY3hsL2NvcmUvbWJveC5j
ICAgICAgfCAxICsNCj4+PiAgaW5jbHVkZS91YXBpL2xpbnV4L2N4bF9tZW0uaCB8IDEgKw0KPj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY3hsL2NvcmUvbWJveC5jIGIvZHJpdmVycy9jeGwvY29yZS9tYm94LmMgaW5kZXgN
Cj4+PiBmNzBiZDdkMjhmZjguLmY0OTY2NWQzYjRkNiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJz
L2N4bC9jb3JlL21ib3guYw0KPj4+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvbWJveC5jDQo+Pj4g
QEAgLTY4LDYgKzY4LDcgQEAgc3RhdGljIHN0cnVjdCBjeGxfbWVtX2NvbW1hbmQNCj5jeGxfbWVt
X2NvbW1hbmRzW0NYTF9NRU1fQ09NTUFORF9JRF9NQVhdID0gew0KPj4+ICAJQ1hMX0NNRChHRVRf
U0NBTl9NRURJQV9DQVBTLCAweDEwLCAweDQsIDApLA0KPj4+ICAJQ1hMX0NNRChHRVRfVElNRVNU
QU1QLCAwLCAweDgsIDApLA0KPj4+ICAJQ1hMX0NNRChHRVRfU1VQUE9SVEVEX0ZFQVRVUkVTLCAw
eDgsIENYTF9WQVJJQUJMRV9QQVlMT0FELA0KPjApLA0KPj4+ICsJQ1hMX0NNRChHRVRfRkVBVFVS
RSwgMHgxNSwgQ1hMX1ZBUklBQkxFX1BBWUxPQUQsIDApLA0KPj4+ICB9Ow0KPj4+DQo+Pj4gIC8q
DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9jeGxfbWVtLmgNCj4+PiBiL2lu
Y2x1ZGUvdWFwaS9saW51eC9jeGxfbWVtLmggaW5kZXggYmQyNTM1OTYyZjcwLi45MGRjYjk3MjM5
OTcNCj4+PiAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvY3hsX21lbS5oDQo+
Pj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2N4bF9tZW0uaA0KPj4+IEBAIC01MSw2ICs1MSw3
IEBADQo+Pj4gIAlfX19DKENMRUFSX0xPRywgIkNsZWFyIExvZyIpLAkJCQkJICBcDQo+Pj4gIAlf
X19DKEdFVF9TVVBfTE9HX1NVQkxJU1QsICJHZXQgU3VwcG9ydGVkIExvZ3MgU3ViLUxpc3QiKSwJ
ICBcDQo+Pj4gIAlfX19DKEdFVF9TVVBQT1JURURfRkVBVFVSRVMsICJHZXQgU3VwcG9ydGVkIEZl
YXR1cmVzIiksDQo+CSAgXA0KPj4+ICsJX19fQyhHRVRfRkVBVFVSRSwgIkdldCBGZWF0dXJlIiks
CQkJCSAgXA0KPj4+ICAJX19fQyhNQVgsICJpbnZhbGlkIC8gbGFzdCBjb21tYW5kIikNCj4+Pg0K
Pj4+ICAjZGVmaW5lIF9fX0MoYSwgYikgQ1hMX01FTV9DT01NQU5EX0lEXyMjYQ0KPj4NCj4NCg0K
