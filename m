Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206C2D030
	for <linux-cxl@vger.kernel.org>; Tue, 17 Oct 2023 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Iq60LEKI"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D8AB
	for <linux-cxl@vger.kernel.org>; Tue, 17 Oct 2023 10:24:48 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231017172447usoutp01221eafc7bc9f9d5495371e72fba6c52a~O9P9pX7Og2253822538usoutp011;
	Tue, 17 Oct 2023 17:24:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231017172447usoutp01221eafc7bc9f9d5495371e72fba6c52a~O9P9pX7Og2253822538usoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697563487;
	bh=w9dsz+IMzUfLNCjn2zM46jEdhiHTGHQ7o4pHQTIxSqg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Iq60LEKIBaBa9EEMtUsNPu0ZZKhIup5n2baLEQF5d28z7t8kgV5Teb2jps71LE4iO
	 vbQG0nlZPXd3QPz5EjzB2esF1OydLQiFNqvN+KZ6Gyx1d38zb9CiRlKzD7M+6g3peX
	 LRfpPVTG/cJ+txx5d+k/dBHirJMeMPAOVZPzBRdI=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231017172447uscas1p28922625ebad26a1c6bbeacd2d8ebce3d~O9P9cyMr20910509105uscas1p2h;
	Tue, 17 Oct 2023 17:24:47 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id F8.33.62237.E53CE256; Tue,
	17 Oct 2023 13:24:47 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231017172446uscas1p2dbf47b2cc196b8328b0ba1cbfb6d2de1~O9P9APG7l1981619816uscas1p2-;
	Tue, 17 Oct 2023 17:24:46 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-d5-652ec35e9390
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 15.48.31200.E53CE256; Tue,
	17 Oct 2023 13:24:46 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Tue, 17 Oct 2023 10:24:45 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
	17 Oct 2023 10:24:45 -0700
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
Thread-Index: AQHZ//ZioxMVLlTkYE+pVsAjGci0crBOoTqAgAARyoA=
Date: Tue, 17 Oct 2023 17:24:45 +0000
Message-ID: <BF2AFEEE-9A92-412E-A9D4-27D82EC6AB38@ssi.samsung.com>
In-Reply-To: <CDA18391-931B-4564-8B97-9DE92790C9CA@ssi.samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <265A0D60A070EB4EB6C9A02D48559D5A@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+917N++Wo+sUPS0JXFYoNbNCLmnRQ2pS5mMVYZFe9KLio7Gr
	PUzI6EGtDInE3Hq4Jqa2koy1CNGcJqnppDRz+ehdhhpziVS2cl4j//uex5fv58AhcalJICPT
	s3NYTTaTKReKiQctE50rE5sU7KpCPUYPvO8S0iXFXYh+2ndCSN/uMyF6yhpNN3z8TNDVhpdC
	2qZrI2h7UQu2UaQ81TwqUBrrhjFlsf640lm7OJZIEEeksJnph1hNyIYkcdprV5L6k+eRM0/f
	oAJU56lFIhKotdBXOCXQIjEppaoQvLd14HxxGoOxu6Xo39ZP45QHPzAhOHW/A+OLcQRt447Z
	SQUCp/bSjEVIBcHPbhPm1j7UenjRUDLjwKkhDLRXbk0XJOlNJYBRv4vf2QcjF0yI1+vg+YSb
	Q0QS1FIYMk8K3VpCbYbBZxaBW4uoLdBfPzSzgyhfmGzjs3DKD+wfbmA8thfc1NfhvPYF16O3
	Ql4HwNDksIcbAZ/mrHkUwls3wOVCkwevA+Dy+bcefKwXtJZ+IHjrQmisfEW4TwHqFQmjVy/O
	ZkVCd/HN2axF8HugYrafAVU1Z2fOBUoNBc3xfDscDFM1WBEK1M2h1v0n0s0h0s0h0s0hKkOC
	auSXy3FZqSy3Jps9rOCYLC43O1WRfDCrFk0/VLurSf0Q2e0OhRVhJLIiIHG5jyRVtYKVSlKY
	o3ms5mCiJjeT5axoEUnI/SSh61uTpVQqk8NmsKya1fybYqRIVoCZnSOMwileHPw1hlTd2+Gi
	07znXfUs2YmGA1VR88eTToZ6dQZXHLvRw7j8G+q/vNCoVFFWtXnQ8uNP1a9ekJNFOau/S+M3
	05a9A48jgmXa8+fCCkrzvjUyE3qbsj16WZn/O9PpbYY7DbYHkZ2NWzVdY+eizAPbLU71x9Et
	MsOVtqVP9u5XhFyojokL98WDzhxZmx/DttR8ud9qr3weG7+7nwgqp4QZ3HWzQuC4lh/Yc/dQ
	S7mxIiKpK3r/gSbvOFuiTvI4MixZOZjhMF4brt/62n+JQ9+/p7k9PcCxb6SyvWOsp+xY1KYn
	MkVrrddyJqF8dOeaMUv8gsreTwbrSTnBpTGhwbiGY/4CfKIcpr8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWS2cDsrBt3WC/VYOE+aYu7jy+wWUyfeoHR
	4sTNRjaL1TfXMFr8OeRrsf/pcxaLVQuvsVmcn3WKxeLWhGNMDpweLUfesnos3vOSyWPq7HqP
	z5vkAliiuGxSUnMyy1KL9O0SuDJu/0soeMZT0XbiAWMD4x6eLkZODgkBE4lfi/+wdzFycQgJ
	rGKUuLNvJSOE84lRounfdihnGaNEz7xbbCAtbAKaEr+urGECsUUEbCUu75/OBFLELHCfSaJr
	xnKwhLBAlMSf3jesEEXREhuWrGeEsK0kLn09ywxiswioStzf+h1sKK+Ak8S9M9tZIbYtZJKY
	Mu8O2CBOAWegm+6DNTAKiEl8PwWxmVlAXOLWk/lMEE8ISCzZc54ZwhaVePn4HyuErShx//tL
	oOc4gOo1Jdbv0odotZOY0ruGHcJWlJjS/ZAd4gZBiZMzn7BAtEpKHFxxg2UCo8QsJNtmIUya
	hWTSLCSTZiGZtICRdRWjeGlxcW56RbFRXmq5XnFibnFpXrpecn7uJkZghJ/+dzh6B+PtWx/1
	DjEycTAeYpTgYFYS4U0P1kkV4k1JrKxKLcqPLyrNSS0+xCjNwaIkznv3gUaqkEB6Yklqdmpq
	QWoRTJaJg1Oqganr8CdrwbUiGdzZ80pe7G36tjAl07p8wWkTq4cLU2OOrZ66W9SxZoNPasP7
	BoYvq9VNjvI95vwvenTBPfu4Q36/knb4yj5qPKS6tsSsXEzCaZ3HezGJjxM4v4XwSt5KO51Y
	n1W0LFFlrnPc/NOfdJbtvLRMb+vnCVo5Fct9Fh2yD+nb6BeztXbDEVb/l16yP659FmzkYPwd
	KpWbbrRe/Jr99NC0hy0N/6I75wtWBNSvM1L/NJmrXav8/9LJoWsK+KsOPl3JqDAjacuJ+W3L
	tXiKsm83OXsJMoff4BZWDwooXni726si8UXd2fpU61tvg/tW/38cF1U+78vEedKzHEQ155y/
	tXixwPyMWayrYpRYijMSDbWYi4oTAZQQ1LNfAwAA
X-CMS-MailID: 20231017172446uscas1p2dbf47b2cc196b8328b0ba1cbfb6d2de1
CMS-TYPE: 301P
X-CMS-RootMailID: 20231016060244uscas1p15e15e2d44388f12511a67c003dc2bff5
References: <cover.1697433770.git.alison.schofield@intel.com>
	<CGME20231016060244uscas1p15e15e2d44388f12511a67c003dc2bff5@uscas1p1.samsung.com>
	<8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
	<CDA18391-931B-4564-8B97-9DE92790C9CA@ssi.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDE3LCAyMDIzLCBhdCA5OjIw4oCvQU0sIEppbSBIYXJyaXMgPGppbS5oYXJy
aXNAc2Ftc3VuZy5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gT2N0IDE1LCAyMDIzLCBh
dCAxMTowMuKAr1BNLCBhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbSB3cm90ZToNCj4+IA0KPj4g
RnJvbTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb20+DQo+PiAN
Cj4+IA0KPj4gLXN0YXRpYyBpbnQgZGVjb2Rlcl9tYXRjaF9yYW5nZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHZvaWQgKmRhdGEpDQo+PiArc3RhdGljIGludCBtYXRjaF9zd2l0Y2hfZGVjb2Rlcl9ieV9y
YW5nZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpDQo+PiB7DQo+PiAtIHN0cnVjdCBj
eGxfZW5kcG9pbnRfZGVjb2RlciAqY3hsZWQgPSBkYXRhOw0KPj4gKyBzdHJ1Y3QgcmFuZ2UgKnIx
LCAqcjIgPSBkYXRhOw0KPj4gc3RydWN0IGN4bF9zd2l0Y2hfZGVjb2RlciAqY3hsc2Q7DQo+PiAN
Cj4+IGlmICghaXNfc3dpdGNoX2RlY29kZXIoZGV2KSkNCj4+IHJldHVybiAwOw0KPj4gDQo+PiBj
eGxzZCA9IHRvX2N4bF9zd2l0Y2hfZGVjb2RlcihkZXYpOw0KPj4gLSByZXR1cm4gcmFuZ2VfY29u
dGFpbnMoJmN4bHNkLT5jeGxkLmhwYV9yYW5nZSwgJmN4bGVkLT5jeGxkLmhwYV9yYW5nZSk7DQo+
PiArIHIxID0gJmN4bHNkLT5jeGxkLmhwYV9yYW5nZTsNCj4+ICsgcmV0dXJuIHJhbmdlX2NvbnRh
aW5zKHIxLCByMik7DQo+PiArfQ0KPiANCj4gSGkgQWxpc29uLA0KPiANCj4gVGhpcyBzdHJheSBj
bG9zaW5nIGJyYWNlIG5lZWRzIHRvIGJlIHJlbW92ZWQgZnJvbSB0aGlzIHBhdGNoLg0KPiANCj4g
UmVzdCBvZiB0aGUgcGF0Y2ggbG9va3MgZ29vZCwgSSBhZ3JlZSB0aGUgbmFtaW5nIGlzIG11Y2gg
YmV0dGVyIHdpdGggdGhlc2UNCj4gY2hhbmdlcy4NCj4gDQo+IFJldmlld2VkLWJ5OiBKaW0gSGFy
cmlzIDxqaW0uaGFycmlzQHNhbXN1bmcuY29tPg0KPiANCg0KTG9va2luZyBhdCB0aGlzIGFnYWlu
LCBJIHRoaW5rIHRoaXMgYWxzbyBuZWVkcyB0byBjaGVjayBpZiB0aGUgc3dpdGNoDQpkZWNvZGVy
IGlzIGFjdGl2ZS4gTm9uLWFjdGl2ZSBkZWNvZGVycyB3aWxsIGhhdmUgcmFuZ2UgMCB0byBVSU5U
NjRfTUFYDQp3aGljaCB3b3VsZCBwYXNzIHRoZSByYW5nZV9jb250YWlucygpIGNoZWNrLg0KDQo=
