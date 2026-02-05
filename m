Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77DD3A7F5D
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289096; cv=none; b=l2D+fXxeO745SpsKXBepAo2E/wOsSspcRTmXCCT4cnXlwCW9JLPoBbbnz9yc/rACuBfD3suwjJbwbxotcmtfdwRkVNUlBEe7qAhZ15wK/jjOV7/daLnG0q6qJEW9TwviNgx2bPjsHsyep/YJuVo6dMynavFFVk3xkwAhzu0oH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289096; c=relaxed/simple;
	bh=BEVWh06slrd7PUMmhQyXpKJiJlPgfaYZdqvAfnsFOcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4b276RcaYSzdteURZg8KkJo45t85o05ueWeq4VQ4dOrte9FYCACus6A8RHA1uHiaJNgiisAjKLjSFNM0mrd67/vKu0xeBZSg/Xwtp67wyqZAwuAxAOQ7fS2I4u7OD9IlYiRqnW9U1Hw1RgE9iwNJ0WjHpbGrb+WPrSZmu4A2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6Dh23fDCzJ46ly;
	Thu,  5 Feb 2026 18:57:22 +0800 (CST)
Received: from dubpeml100006.china.huawei.com (unknown [7.214.145.132])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FF2040570;
	Thu,  5 Feb 2026 18:58:13 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (7.214.146.94) by
 dubpeml100006.china.huawei.com (7.214.145.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 5 Feb 2026 10:58:12 +0000
Received: from dubpeml500008.china.huawei.com ([7.214.146.94]) by
 dubpeml500008.china.huawei.com ([7.214.146.94]) with mapi id 15.02.1544.011;
 Thu, 5 Feb 2026 10:58:12 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: Michael Tsirkin <mst@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, Linuxarm
	<linuxarm@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Ravi Shankar <venkataravis@micron.com>
Subject: RE: [PATCH qemu v4 3/5] hw/cxl/events: Updates for rev3.2 general
 media event record
Thread-Topic: [PATCH qemu v4 3/5] hw/cxl/events: Updates for rev3.2 general
 media event record
Thread-Index: AQHciTUr4LxvIobS5kmrIl1k4W36E7VzK8UAgADdjxA=
Date: Thu, 5 Feb 2026 10:58:12 +0000
Message-ID: <36df3469e1ac47d2a0474329a0f3c47c@huawei.com>
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
 <20260119111542.788389-4-Jonathan.Cameron@huawei.com>
 <CALa+Y15jKXUH=9k5aBveN4WN0AK1QW6VHGLHTVVgTF+-2hXvhA@mail.gmail.com>
In-Reply-To: <CALa+Y15jKXUH=9k5aBveN4WN0AK1QW6VHGLHTVVgTF+-2hXvhA@mail.gmail.com>
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJhdmkgSm9ubmFsYWdhZGRh
IDxyYXZpcy5vcGVuc3JjQGdtYWlsLmNvbT4NCj5TZW50OiAwNCBGZWJydWFyeSAyMDI2IDIxOjQy
DQo+VG86IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT4NCj5D
YzogTWljaGFlbCBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZzsgU2hpanUgSm9zZQ0KPjxzaGlqdS5qb3NlQGh1YXdlaS5jb20+OyBhcm1icnVAcmVkaGF0LmNv
bTsgTGludXhhcm0NCj48bGludXhhcm1AaHVhd2VpLmNvbT47IGxpbnV4LWN4bEB2Z2VyLmtlcm5l
bC5vcmc7IFJhdmkgU2hhbmthcg0KPjx2ZW5rYXRhcmF2aXNAbWljcm9uLmNvbT4NCj5TdWJqZWN0
OiBSZTogW1BBVENIIHFlbXUgdjQgMy81XSBody9jeGwvZXZlbnRzOiBVcGRhdGVzIGZvciByZXYz
LjIgZ2VuZXJhbA0KPm1lZGlhIGV2ZW50IHJlY29yZA0KPg0KPk9uIE1vbiwgSmFuIDE5LCAyMDI2
IGF0IDM6MjHigK9BTSBKb25hdGhhbiBDYW1lcm9uDQo+PEpvbmF0aGFuLkNhbWVyb25AaHVhd2Vp
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gRnJvbTogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWku
Y29tPg0KPj4NCj4+IENYTCBzcGVjIHJldjMuMiBzZWN0aW9uIDguMi4xMC4yLjEuMSBUYWJsZSA4
LTU3LCBnZW5lcmFsIG1lZGlhIGV2ZW50DQo+PiB0YWJsZSBoYXMgdXBkYXRlZCB3aXRoIGZvbGxv
d2luZyBuZXcgZmllbGRzLg0KPj4gMS4gQWR2YW5jZWQgUHJvZ3JhbW1hYmxlIENvcnJlY3RlZCBN
ZW1vcnkgRXJyb3IgVGhyZXNob2xkIEV2ZW50IEZsYWdzDQo+PiAyLiBDb3JyZWN0ZWQgTWVtb3J5
IEVycm9yIENvdW50IGF0IEV2ZW50IDMuIE1lbW9yeSBFdmVudCBTdWItVHlwZSA0Lg0KPj4gU3Vw
cG9ydCBmb3IgY29tcG9uZW50IElEIGluIHRoZSBQTERNIGZvcm1hdC4NCj4+DQo+PiBBZGQgdXBk
YXRlcyBmb3IgdGhlIGFib3ZlIHNwZWMgY2hhbmdlcyBpbiB0aGUgQ1hMIGdlbmVyYWwgbWVkaWEg
ZXZlbnQNCj4+IHJlcG9ydGluZyBhbmQgUU1QIGNvbW1hbmQgdG8gaW5qZWN0IGdlbmVyYWwgbWVk
aWEgZXZlbnQuDQo+Pg0KPj4gSW4gb3JkZXIgdG8gaGF2ZSBvbmUgY29uc2lzdGVudCBzb3VyY2Ug
b2YgcmVmZXJlbmNlcywgdXBkYXRlIGFsbCB0bw0KPj4gcmVmZXJlbmNlcyBmb3IgdGhpcyBjb21t
YW5kIHRvIENYTCByMy4yLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoaWp1IEpvc2UgPHNoaWp1
Lmpvc2VAaHVhd2VpLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpv
bmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4+IC0tLQ0KPj4gdjQ6IFVwZGF0ZSB0aGUgc3Bl
YyByZWZlcmVuY2UgaW4gdGhlIHJlbGF0ZWQgY29tbWFuZCB0byAzLjIgYXMgd2VsbC4NCj4+IChN
YXJrdXMpDQo+PiB2MzogVXBkYXRlIGFsbCByZWZlcmVuY2VzIHRvIDMuMiBmb3IgY29uc2lzdGVu
Y3kuDQo+PiAtLS0NCj4+ICBxYXBpL2N4bC5qc29uICAgICAgICAgICAgICAgfCAyOSArKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLQ0KPj4gIGluY2x1ZGUvaHcvY3hsL2N4bF9ldmVudHMuaCB8
ICA3ICsrKysrLS0NCj4+ICBody9tZW0vY3hsX3R5cGUzLmMgICAgICAgICAgfCAyOSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gIGh3L21lbS9jeGxfdHlwZTNfc3R1YnMuYyAgICB8
ICA2ICsrKysrKw0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3FhcGkvY3hsLmpzb24gYi9xYXBpL2N4bC5q
c29uIGluZGV4DQo+PiA4MjAwMWMwNTkxZDguLjRmZjY2ZmM2YzE2YyAxMDA2NDQNCj4+IC0tLSBh
L3FhcGkvY3hsLmpzb24NCj4+ICsrKyBiL3FhcGkvY3hsLmpzb24NCj4+DQo+PiAgICAgIHN0d19s
ZV9wKCZnZW0udmFsaWRpdHlfZmxhZ3MsIHZhbGlkX2ZsYWdzKTsNCj4+DQo+PiArICAgIGlmICho
YXNfY21lX2V2X2ZsYWdzKSB7DQo+PiArICAgICAgICBnZW0uY21lX2V2X2ZsYWdzID0gY21lX2V2
X2ZsYWdzOw0KPj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgZ2VtLmNtZV9ldl9mbGFncyA9
IDA7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaWYgKGhhc19jbWVfY291bnQpIHsNCj4+ICsg
ICAgICAgIGRlc2NyaXB0b3IgfD0gQ1hMX0dNRVJfRVZfREVTQ19USFJFU0hPTERfRVZFTlQ7DQo+
DQo+VGhlIG1vZGlmaWNhdGlvbiB0byAnZGVzY3JpcHRvcicgaGVyZSBpcyBub3Qgd3JpdHRlbiBi
YWNrIHRvIGdlbS5kZXNjcmlwdG9yIHdoaWNoDQo+d2FzIGFzc2lnbmVkIGVhcmxpZXIgaW4gdGhp
cyBmdW5jdGlvbi4NCj4NCj5TdWdnZXN0IG1vdmluZyBnZW0uZGVzY3JpcHRvciBhc3NpZ25tZW50
IGFmdGVyIHRoaXMgYmxvY2ssIHNpbWlsYXIgdG8gaG93DQo+dmFsaWRfZmxhZ3MgaXMgaGFuZGxl
ZCBpbiB0aGlzIHNhbWUgZnVuY3Rpb24uDQo+DQpUaGFua3MgUmF2aS4NCldpbGwgIGZpeC4NCg0K
Pj4gIHZvaWQgcW1wX2N4bF9pbmplY3RfZHJhbV9ldmVudChjb25zdCBjaGFyICpwYXRoLCBDeGxF
dmVudExvZyBsb2csDQo+PiAtLQ0KPj4gMi40OC4xDQo+Pg0KPj4NCg0KVGhhbmtzLA0KU2hpanUN
Cg==
