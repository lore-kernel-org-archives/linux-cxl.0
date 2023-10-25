Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF28C8EA
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WmKHAYYv"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F260399
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 08:48:56 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231025154856usoutp02dbb73215487407fffcc8e24ed773b2f5~RZGju1DKg1241412414usoutp02K;
	Wed, 25 Oct 2023 15:48:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231025154856usoutp02dbb73215487407fffcc8e24ed773b2f5~RZGju1DKg1241412414usoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698248936;
	bh=QMgFUOuOzGo+YkpE2zQ5Pxq9bPQTM38YaTs8425M1uM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WmKHAYYvVcp/17C8YXtaMrBovYUkoHW53XwB+jQMCiMgxhFdhjxyjh21IHhlUd1f0
	 FY7/f6cgciIVmlpK2QqI5U9clTfkkH7GPRTPOVg0hzGEKC4Jvi/MddIVCw70msHxoZ
	 uBk3VbfOVQXj3IhDvu9Y61hPOV2RGNVIkeh/7e4M=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231025154856uscas1p2e4f58ae7df06d6995480243ffd9e8e5e~RZGjmtKuD1685016850uscas1p2q;
	Wed, 25 Oct 2023 15:48:56 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id F8.F8.50148.8E839356; Wed,
	25 Oct 2023 11:48:56 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231025154855uscas1p2102cef0c09d3cd68e8f2040ca2264f00~RZGjU0z5j2151821518uscas1p2Y;
	Wed, 25 Oct 2023 15:48:55 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-b4-653938e8cab1
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 94.30.31410.7E839356; Wed,
	25 Oct 2023 11:48:55 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 25 Oct 2023 08:48:55 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	25 Oct 2023 08:48:55 -0700
From: Jim Harris <jim.harris@samsung.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: [PATCH v2] cxl/region: use region (not root decoder) granularity
 for calculations
Thread-Topic: [PATCH v2] cxl/region: use region (not root decoder)
	granularity for calculations
Thread-Index: AQHaB1rCfAj9TB4myEWLhxXUjosmcA==
Date: Wed, 25 Oct 2023 15:48:54 +0000
Message-ID: <169824893473.1403938.16110924262989774582.stgit@bgt-140510-bm03.eng.stellus.in>
In-Reply-To: <169660931834.684402.2774329392272976121.stgit@bgt-140510-bm03.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B6987E49DEA774AA1ABBCD12DFB2580@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzrOd0XFpapBks+sFtMn3qB0eL8rFMs
	Dkwei/e8ZPL4vEkugCmKyyYlNSezLLVI3y6BK+PD5nbGgnXiFW3bpzE2MD4Q62Lk5JAQMJG4
	/2EDWxcjF4eQwEpGiW2T57FDOK1MEo++XGeHqdq+5B0TRGINo0T7vHeMEM4nRonejdOgWpYx
	SmxofALWwiagKfHryhqgFg4OEYESiWenbUDCwgIxEu1bZrCA2CICiRJ3lh9kgrD1JPr2bQZr
	ZRFQlTj+cRJYnBeo/tXRLjYQm1MgWmLiknusIDajgJjE91NrwGqYBcQlbj2ZzwRxqaDEotl7
	mCFsMYl/ux6yQdiKEve/v2QHOYcZ6LT1u/QhWu0k2p5uY4ewFSWmdD9kh1grKHFy5hMWiFZJ
	iYMrbrCAvCghMJFD4uaCFqj5LhJ3lr6ChpC0xPQ1l6EasiVWru8Ae11CoECi4UgQRNhaYuGf
	9VAn80n8/fWIcQKj8iwkH8xCuG4WkutmIbluFpLrFjCyrmIULy0uzk1PLTbMSy3XK07MLS7N
	S9dLzs/dxAhMJaf/Hc7dwbjj1ke9Q4xMHIyHGCU4mJVEeCN9LFKFeFMSK6tSi/Lji0pzUosP
	MUpzsCiJ8xrankwWEkhPLEnNTk0tSC2CyTJxcEo1MIUwRAZM3mzgvXTlruVVByT1D5UfqVX9
	9U46VTlwvirfHm5ZJsHzGwwzX9+JicxuWe/U0itt1vcy1Mp8teQX3rtah8VMuOSm+CnFrZOR
	OiB4VsytRmjiKuXIvcvv50+of+ax9YyVHrNU1gn5YLbvyYcUNsXOXGd2ivFG3WL5mHl2T/fw
	PflYFTB5x4qYw3YnQu+KvN6pV3Ooxpjrmsm/vXdV5qVLr5tzVmjiuovR2sWRibeELV+ImKvd
	Paa/KbVl8cZJibMcfTc8iZdnLr7VU/LkYO/Ck982L5W5MPEf415+Vq4zqoy3b8TY6k92nSy4
	bevxpZLaFkyikwRzb6SvXPtwa7pnpt1t27rarv8rVimxFGckGmoxFxUnAgDD/JiOlAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWS2cDspPvcwjLV4NBafYvpUy8wWpyfdYrF
	gclj8Z6XTB6fN8kFMEVx2aSk5mSWpRbp2yVwZXzY3M5YsE68om37NMYGxgdiXYycHBICJhLb
	l7xj6mLk4hASWMUoMXPZGmYI5xOjRO+On+wQzjJGidOvjjGBtLAJaEr8urIGyObgEBEokXh2
	2gbEFBaIkVjyyR+kQkQgUeLCq34mCFtPom/fZnYQm0VAVeL4x0lgcV6g8ldHu9hAbCGBKIkZ
	N28yg9icAtESE5fcYwWxGQXEJL6fWgNWzywgLnHryXwmiKMFJJbsOc8MYYtKvHz8jxXCVpS4
	//0lO8g5zEBXrt+lD9FqJ9H2dBs7hK0oMaX7ITvECYISJ2c+YYFolZQ4uOIGywRG8VlIts1C
	mDQLyaRZSCbNQjJpASPrKkbx0uLi3PSKYuO81HK94sTc4tK8dL3k/NxNjMBoO/3vcMwOxnu3
	PuodYmTiYDzEKMHBrCTCG+ljkSrEm5JYWZValB9fVJqTWnyIUZqDRUmc9+4DjVQhgfTEktTs
	1NSC1CKYLBMHp1QDU56NZEZ48+Rtmt4zVgrFR6e9aGNR4uMOFdONb1i+ecekpyL3pj5Qu3vE
	qOWB2OT5Hy468PTr+DIs7DSJnVr3binr3Nk6a8KPGXJskbjA5hwxVeJbjeDa44sdr/a8O1K0
	gO2k+Itb5jYeq0T9/nGFWNwJXyMTwFzrN+dQeu+q/6eefj1zzkVW82OX0qyA+i0KP0+Epq/S
	X7bKRcbuqJLF8znSQtGb8xitp/604eeJnlZlKtKvkmD0OkclVKu6ykSrQfPNCtGDMy3neX3Q
	WH19Tjmfql/ZvMvaXSb17k4PxG12TPimbdw82+PY1E9xlpNia9x04gvaJLTsYz/NvPbylndl
	uMiO0/XBMjdWPChVYinOSDTUYi4qTgQAnqv3YiUDAAA=
X-CMS-MailID: 20231025154855uscas1p2102cef0c09d3cd68e8f2040ca2264f00
CMS-TYPE: 301P
X-CMS-RootMailID: 20231025154855uscas1p2102cef0c09d3cd68e8f2040ca2264f00
References: <169660931834.684402.2774329392272976121.stgit@bgt-140510-bm03.eng.stellus.in>
	<CGME20231025154855uscas1p2102cef0c09d3cd68e8f2040ca2264f00@uscas1p2.samsung.com>

Um9vdCBkZWNvZGVyIGdyYW51bGFyaXR5IG11c3QgbWF0Y2ggdmFsdWUgZnJvbSBDRldNUywgd2hp
Y2ggbWF5IG5vdApiZSB0aGUgcmVnaW9uJ3MgZ3JhbnVsYXJpdHkgZm9yIG5vbi1pbnRlcmxlYXZl
ZCByb290IGRlY29kZXJzLgoKU28gd2hlbiBjYWxjdWxhdGluZyBncmFudWxhcml0aWVzIGZvciBo
b3N0IGJyaWRnZSBkZWNvZGVycywgdXNlIHRoZQpyZWdpb24ncyBncmFudWxhcml0eSBpbnN0ZWFk
IG9mIHRoZSByb290IGRlY29kZXIncyBncmFudWxhcml0eSB0byBlbnN1cmUKdGhlIGNvcnJlY3Qg
Z3JhbnVsYXJpdGllcyBhcmUgc2V0IGZvciB0aGUgaG9zdCBicmlkZ2UgZGVjb2RlcnMgYW5kIGFu
eQpkb3duc3RyZWFtIHN3aXRjaCBkZWNvZGVycy4KClRlc3QgY29uZmlndXJhdGlvbiBpcyAxIGhv
c3QgYnJpZGdlICogMiBzd2l0Y2hlcyAqIDIgZW5kcG9pbnRzIHBlciBzd2l0Y2guCgpSZWdpb24g
Y3JlYXRlZCB3aXRoIDIwNDggZ3JhbnVsYXJpdHkgdXNpbmcgZm9sbG93aW5nIGNvbW1hbmQgbGlu
ZToKCmN4bCBjcmVhdGUtcmVnaW9uIC1tIC1kIGRlY29kZXIwLjAgLXcgNCBtZW0wIG1lbTIgbWVt
MSBtZW0zIFwKCQkgIC1nIDIwNDggLXMgMjA0OE0KClVzZSAiY3hsIGxpc3QgLVBERSB8IGdyZXAg
Z3JhbnVsYXJpdHkiIHRvIGdldCBhIHZpZXcgb2YgdGhlIGdyYW51bGFyaXR5CnNldCBhdCBlYWNo
IGxldmVsIG9mIHRoZSB0b3BvbG9neS4KCkJlZm9yZSB0aGlzIHBhdGNoOgogICAgICAgICJpbnRl
cmxlYXZlX2dyYW51bGFyaXR5IjoyMDQ4LAogICAgICAgICJpbnRlcmxlYXZlX2dyYW51bGFyaXR5
IjoyMDQ4LAogICAgImludGVybGVhdmVfZ3JhbnVsYXJpdHkiOjUxMiwKICAgICAgICAiaW50ZXJs
ZWF2ZV9ncmFudWxhcml0eSI6MjA0OCwKICAgICAgICAiaW50ZXJsZWF2ZV9ncmFudWxhcml0eSI6
MjA0OCwKICAgICJpbnRlcmxlYXZlX2dyYW51bGFyaXR5Ijo1MTIsCiJpbnRlcmxlYXZlX2dyYW51
bGFyaXR5IjoyNTYsCgpBZnRlcjoKICAgICAgICAiaW50ZXJsZWF2ZV9ncmFudWxhcml0eSI6MjA0
OCwKICAgICAgICAiaW50ZXJsZWF2ZV9ncmFudWxhcml0eSI6MjA0OCwKICAgICJpbnRlcmxlYXZl
X2dyYW51bGFyaXR5Ijo0MDk2LAogICAgICAgICJpbnRlcmxlYXZlX2dyYW51bGFyaXR5IjoyMDQ4
LAogICAgICAgICJpbnRlcmxlYXZlX2dyYW51bGFyaXR5IjoyMDQ4LAogICAgImludGVybGVhdmVf
Z3JhbnVsYXJpdHkiOjQwOTYsCiJpbnRlcmxlYXZlX2dyYW51bGFyaXR5IjoyMDQ4LAoKU2lnbmVk
LW9mZi1ieTogSmltIEhhcnJpcyA8amltLmhhcnJpc0BzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJz
L2N4bC9jb3JlL3JlZ2lvbi5jIHwgICAgOSArKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3Jl
L3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYwppbmRleCA2ZDYzYjg3OThjMjku
LmMyNWJlMjZkMGJkZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYworKysg
Yi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jCkBAIC0xMTMzLDcgKzExMzMsMTQgQEAgc3RhdGlj
IGludCBjeGxfcG9ydF9zZXR1cF90YXJnZXRzKHN0cnVjdCBjeGxfcG9ydCAqcG9ydCwKIAl9CiAK
IAlpZiAoaXNfY3hsX3Jvb3QocGFyZW50X3BvcnQpKSB7Ci0JCXBhcmVudF9pZyA9IGN4bHJkLT5j
eGxzZC5jeGxkLmludGVybGVhdmVfZ3JhbnVsYXJpdHk7CisJCS8qCisJCSAqIFJvb3QgZGVjb2Rl
ciBJRyBpcyBhbHdheXMgc2V0IHRvIHZhbHVlIGluIENGTVdTIHdoaWNoCisJCSAqIG1heSBiZSBk
aWZmZXJlbnQgdGhhbiB0aGlzIHJlZ2lvbidzIElHLiAgV2UgY2FuIHVzZSB0aGUKKwkJICogcmVn
aW9uJ3MgSUcgaGVyZSBzaW5jZSBpbnRlcmxlYXZlX2dyYW51bGFyaXR5X3N0b3JlKCkKKwkJICog
ZG9lcyBub3QgYWxsb3cgaW50ZXJsZWF2ZWQgaG9zdC1icmlkZ2VzIHdpdGgKKwkJICogcm9vdCBJ
RyAhPSByZWdpb24gSUcuCisJCSAqLworCQlwYXJlbnRfaWcgPSBwLT5pbnRlcmxlYXZlX2dyYW51
bGFyaXR5OwogCQlwYXJlbnRfaXcgPSBjeGxyZC0+Y3hsc2QuY3hsZC5pbnRlcmxlYXZlX3dheXM7
CiAJCS8qCiAJCSAqIEZvciBwdXJwb3NlcyBvZiBhZGRyZXNzIGJpdCByb3V0aW5nLCB1c2UgcG93
ZXItb2YtMiBtYXRoIGZvcgoK
