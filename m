Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2114F132;
	Sat, 11 Jan 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736587383; cv=none; b=sNxrLmUo85ukUG5muFKET4HmUW3e5CNlgucRS9PmJKDmR/VBMIxISXuiTJtId0dodYEWzVDmQ1rRIK3sOlddCt6jTiENjSeY+6YzMAy6mjgGLyuDwOxSf/neX504BeAajvm236Gn1bFlYxcmFHPhCqFj+j2ZnbOpt51L2hJ3YHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736587383; c=relaxed/simple;
	bh=M2gUoOcBjSXpn1wJD1mk34CyD36pqtZX62yMp4i60Oo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ioHj3A9p18wKctDbPEV1V+vtx1KvwYtOz+hfcUvfbSvi4FHYIepTWRVEhFt2z2vZ6SdJ9gArS7LFYdQc9SPTqABK1jiSHKtKBTmaxoicHyzC8BilSYn4TEaUO9W5aSAhE9lfcP6/ThI8GHnpJRyLUfrn0IWtYWji0t0vJGq1CKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YVXxh3wtQz6K9LR;
	Sat, 11 Jan 2025 17:18:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 015AD1403D2;
	Sat, 11 Jan 2025 17:23:00 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 11 Jan 2025 10:22:59 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Sat, 11 Jan 2025 10:22:59 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH v5 0/6] Update Event Records to CXL spec rev 3.1
Thread-Topic: [PATCH v5 0/6] Update Event Records to CXL spec rev 3.1
Thread-Index: AQHbY1alsZyFrQ7OeU6mHkMzrNfbP7MQG9mAgAAamgCAACumgIAA6x/Q
Date: Sat, 11 Jan 2025 09:22:59 +0000
Message-ID: <5a341e845e354c90ba699657dc0cbb86@huawei.com>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
	<20250110160645.00007b74@huawei.com>
	<1b090d80a49a47e7b220aca07dce4cae@huawei.com>
 <ba35a66c-2dcc-4bb6-a0bb-163f4209449e@intel.com>
In-Reply-To: <ba35a66c-2dcc-4bb6-a0bb-163f4209449e@intel.com>
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
Z0BpbnRlbC5jb20+DQo+U2VudDogMTAgSmFudWFyeSAyMDI1IDIwOjE4DQo+VG86IFNoaWp1IEpv
c2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj48am9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tPg0KPkNjOiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IGFsaXNv
bi5zY2hvZmllbGRAaW50ZWwuY29tOyBuaWZhbi5jeGxAZ21haWwuY29tOw0KPnZpc2hhbC5sLnZl
cm1hQGludGVsLmNvbTsgaXJhLndlaW55QGludGVsLmNvbTsgZGF2ZUBzdGdvbGFicy5uZXQ7IGxp
bnV4LQ0KPmN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IExpbnV4YXJtDQo+PGxpbnV4YXJtQGh1YXdlaS5jb20+OyB0YW54aWFvZmVpIDx0YW54aWFvZmVp
QGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKQ0KPjxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+DQo+
U3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzZdIFVwZGF0ZSBFdmVudCBSZWNvcmRzIHRvIENYTCBz
cGVjIHJldiAzLjENCj4NCj4NCj4NCj5PbiAxLzEwLzI1IDk6NDYgQU0sIFNoaWp1IEpvc2Ugd3Jv
dGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBKb25hdGhhbiBD
YW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+DQo+Pj4gU2VudDogMTAgSmFudWFy
eSAyMDI1IDE2OjA3DQo+Pj4gVG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4N
Cj4+PiBDYzogZGF2ZS5qaWFuZ0BpbnRlbC5jb207IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsN
Cj4+PiBhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbTsgbmlmYW4uY3hsQGdtYWlsLmNvbTsNCj4+
PiB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGlyYS53ZWlueUBpbnRlbC5jb207IGRhdmVAc3Rn
b2xhYnMubmV0Ow0KPj4+IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IExpbnV4YXJtDQo+Pj4gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyB0YW54
aWFvZmVpIDx0YW54aWFvZmVpQGh1YXdlaS5jb20+OyBaZW5ndGFvDQo+Pj4gKEIpIDxwcmltZS56
ZW5nQGhpc2lsaWNvbi5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzZdIFVwZGF0
ZSBFdmVudCBSZWNvcmRzIHRvIENYTCBzcGVjIHJldiAzLjENCj4+Pg0KPj4+IE9uIEZyaSwgMTAg
SmFuIDIwMjUgMTE6NTU6NTAgKzAwMDANCj4+PiA8c2hpanUuam9zZUBodWF3ZWkuY29tPiB3cm90
ZToNCj4+Pg0KPj4+PiBGcm9tOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+
Pj4+DQo+Pj4+IEFkZCB1cGRhdGVzIGluIHRoZSBDWEwgZXZlbnRzIHJlY29yZHMgYW5kIENYTCB0
cmFjZSBldmVudHMNCj4+Pj4gaW1wbGVtZW50YXRpb25zIGZvciB0aGUgY2hhbmdlcyBpbiBDWEwg
c3BlYyByZXYgMy4xLg0KPj4+Pg0KPj4+PiBTaGlqdSBKb3NlICg2KToNCj4+Pj4gICBjeGwvZXZl
bnRzOiBVcGRhdGUgQ29tbW9uIEV2ZW50IFJlY29yZCB0byBDWEwgc3BlYyByZXYgMy4xDQo+Pj4+
ICAgY3hsL2V2ZW50czogQWRkIENvbXBvbmVudCBJZGVudGlmaWVyIGZvcm1hdHRpbmcgZm9yIENY
TCBzcGVjIHJldiAzLjENCj4+Pj4gICBjeGwvZXZlbnRzOiBVcGRhdGUgR2VuZXJhbCBNZWRpYSBF
dmVudCBSZWNvcmQgdG8gQ1hMIHNwZWMgcmV2IDMuMQ0KPj4+PiAgIGN4bC9ldmVudHM6IFVwZGF0
ZSBEUkFNIEV2ZW50IFJlY29yZCB0byBDWEwgc3BlYyByZXYgMy4xDQo+Pj4+ICAgY3hsL2V2ZW50
czogVXBkYXRlIE1lbW9yeSBNb2R1bGUgRXZlbnQgUmVjb3JkIHRvIENYTCBzcGVjIHJldiAzLjEN
Cj4+Pj4gICBjeGwvdGVzdDogVXBkYXRlIHRlc3QgY29kZSBmb3IgZXZlbnQgcmVjb3JkcyB0byBD
WEwgc3BlYyByZXYgMy4xDQo+Pj4+DQo+Pj4+IENoYW5nZXM6DQo+Pj4+IFY0IC0+IFY1DQo+Pj4+
IDEuIFJldmVydGVkIGNoYW5nZXMgbWFkZSBpbiB2NCBmb3Igb3ZlcmNvbWluZyBwYXJzaW5nIGVy
cm9yIHdoZW4NCj4+Pj4gbGlidHJhY2VldmVudCBpbiB1c2Vyc3BhY2UgcGFyc2VzIHRoZSBDWEwg
dHJhY2UgZXZlbnRzLCBmb3IgcmFzZGFlbW9uLg0KPj4+PiBUaGlzIHdhcyBkdWUgdG8gdHJhY2Ug
ZXZlbnQncyBmb3JtYXQgZmlsZSBpcyBsYXJnZXIgdGhhbiBQQUdFX1NJWkUsDQo+Pj4+IG5vdCBz
dXBwb3J0ZWQgcmVhZGluZyBjb21wbGV0ZSBmb3JtYXQgZmlsZSBpbiBvbmUgZ28gaW4gdGhlIGtl
cm5lbA0KPj4+PiBhbmQgdGh1cyBmaXhlZCBpbiB0aGUgcmFzZGFlbW9uLg0KPj4+DQo+Pj4gR3Jl
YXQgdG8gc2VlIHRoYXQgcmVzb2x2ZWQuDQo+Pj4NCj4+Pj4gMi4gUmViYXNlZCB0byB2Ni4xMy1y
YzUuDQo+Pj4NCj4+PiBTaG91bGQgcHJvYmFibHkgc2F5IHdoeSB3aGVuIGRvaW5nIGEgcmViYXNl
IHRvIHNvbWV0aGluZyBvdGhlciB0aGFuIHJjMS4NCj4+PiBJbiB0aGlzIGNhc2UgdGhpcyBpcyB3
aGF0IGN4bC5naXQvbmV4dCBpcyBiYXNlZCBvbiBhZnRlciBzb21lIGZpeGVzDQo+Pj4gZWFybGll
ciBpbiB0aGUgY3ljbGUgc28gYSBzZW5zaWJsZSBjaG9pY2UgZm9yIHRoaXMgc2V0Lg0KPj4NCj4+
IEkgY2hlY2tlZC4gVGhlc2UgcGF0Y2hlcyBhcHBsaWVkIGNsZWFubHkgaW4gY3hsLmdpdC9uZXh0
IGFuZCBidWlkIG9rYXkuDQo+DQo+SGkgU2hpanUsDQo+Q2FuIHlvdSBwbGVhc2UgYXBwbHkgSXJh
J3Mgc3VnZ2VzdGlvbnMgYW5kIHJlc3BpbiBhIHY2PyBUaGFua3MhDQoNCkhpICBEYXZlLA0KDQpT
dXJlLiBJIGFkZGVkIElyYSdzIHN1Z2dlc3Rpb25zIGFuZCBwbGVhc2UgZmluZCB2NiBvZiB0aGUg
c2VyaWVzIGhlcmUuDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAxMTEwOTE3NTYu
MTY4Mi0xLXNoaWp1Lmpvc2VAaHVhd2VpLmNvbS8NCg0KVGhhbmtzLA0KU2hpanUNCg0KPg0KWy4u
Ll0NCj4NCg0K
