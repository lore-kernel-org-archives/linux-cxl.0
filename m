Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18207BE4F
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LyJ6Cvti"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14446DE
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 10:09:56 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231006170953usoutp01dbc70d06e5e2a47c9f8b64a9d08eb8e2~Lk8z10GGt3082230822usoutp01N
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:09:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231006170953usoutp01dbc70d06e5e2a47c9f8b64a9d08eb8e2~Lk8z10GGt3082230822usoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1696612193;
	bh=X2xUb6d2rnUnMHxHdSL/6bN7g3XpQBv7gNO2W1CBVCs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=LyJ6CvtiA1J5pGi3P7R0uJuX6A8BUABvg2mG+PFSxakwZzGJOznfFBmmBcldf9qDf
	 LthaK80NsMO5dTWyh6rcW96J34GqafK+FzjEiL/KViDOIk3I8yI4+GzwNuiYpGAR/y
	 hoF7xMe8YQYsU4bZWrLZet+0na6h3KcAupsjVWLQ=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231006170952uscas1p1a90ecba3c398ef1fbe808e44b2938814~Lk8zp6uAt0982409824uscas1p1Q
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:09:52 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 1A.FB.40279.06F30256; Fri, 
	6 Oct 2023 13:09:52 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231006170952uscas1p204c0db1931674a83db0cb29a49a18680~Lk8zfm5aX1092310923uscas1p2p
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:09:52 +0000 (GMT)
X-AuditID: cbfec36f-241ff70000009d57-7f-65203f60cffb
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id C7.6E.28590.06F30256; Fri, 
	6 Oct 2023 13:09:52 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 6 Oct 2023 10:09:51 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	6 Oct 2023 10:09:51 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Jim Harris <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH ndctl] libcxl: don't calculate max_available_extent when
 start == ULLONG_MAX
Thread-Topic: [PATCH ndctl] libcxl: don't calculate max_available_extent
	when start == ULLONG_MAX
Thread-Index: AQHZ+HcNJ3f5Nhx0J0CNVMPUROcjHLA9dDSA
Date: Fri, 6 Oct 2023 17:09:51 +0000
Message-ID: <7E451734-01DA-4B90-B9C9-18FF21D3B7CB@ssi.samsung.com>
In-Reply-To: <169661181914.694957.3925873284580708486.stgit@bgt-140510-bm03.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <49F61406A944A241A0AFF4786A88FE07@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djX87oJ9gqpBsebLCzOzzrF4sDo8XmT
	XABjFJdNSmpOZllqkb5dAlfGm43v2QruMVWsPvCDpYHxClMXIyeHhICJxLv+TYwgtpDASkaJ
	Wftduxi5gOylTBJbN65jhym6uukeC0RiLaPEnpf9TBDOR0aJhj09UJmljBJXlj9mBmlhE9CU
	+HVlDdgOEQF1ib/9y8HizALWEv2nzwLZHBzCAkkS5545QJQkS8ydPBGq3Ehix9cuMJtFQEVi
	Wf96MJtXwEni/fEOsFM5BaIl/v3bBnYdo4CYxPdTEKuYBcQlbj2ZD/WaoMSi2XuYIWwxiX+7
	HrJB2IoS97+/ZAc5gRnozPW79CFa7STWNjayQNiKElO6H7JDrBWUODnzCQtEq6TEwRU3wN6V
	EOjlkNh19Q8rRMJF4vju9VDzpSWuXp8KtTdbYuX6DiaQXRICBRINR4IgwtYSC/+sZ5rAqDIL
	ydWzEC6aheSiWUgumoXkogWMrKsYxUuLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECk8bpf4fz
	dzBev/VR7xAjEwfjIUYJDmYlEd70BplUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGtieThQTS
	E0tSs1NTC1KLYLJMHJxSDUy5R2eVHtoQO2v2y9KizZM373VolptnzvWow1h1D8PC8xXnd8Tu
	Crv2pL/fY8P1C4+l+dyE673FcnJdVJcqPyw1v/VeIIVxL/dssbnlabcn83NU7RU4Ktdd/zut
	ddexX/NfnZkurXBA7lcWb1lnkkx8To/7t5V7bZqKK+7Miu4S/pf9Lihy7cyLvFI3fZXyNzzv
	37tl+tafvV1nv5w/wfX96KnWmS7qgslGV0Q4S2Olspevd5C7KMu4x9D4+NZNQQcrdt27Vlpy
	VZ/75622d4cPNctyf5h4IjLs7pJwg8uvTl9mMXvTM/FDXf9ujtJU4aXXKh9P0LuSZuIpG34z
	m6EwxSuOc/6R0ww/ns1iK45TYinOSDTUYi4qTgQAJEMM2okDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWS2cA0UTfBXiHV4F6vmsX5WadYHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mp4s/E9W8E9porVB36wNDBeYepi5OSQEDCRuLrpHksXIxeHkMBq
	Rol7r5exQjgfGSWeTXjIBlIlJLCUUeJIgx6IzSagKfHryhqwbhEBdYm//cuZQWxmAWuJ/tNn
	gWwODmGBJIlzzxwgSpIlLt06xQxhG0ns+NoF1soioCKxrH89mM0r4CTx/ngHI8TedYwS305/
	ZgVJcApES/z7t40dxGYUEJP4fgpiL7OAuMStJ/OhPhCQWLLnPDOELSrx8vE/VghbUeL+95fs
	IPcwA928fpc+RKudxNrGRhYIW1FiSvdDdogbBCVOznzCAtEqKXFwxQ2WCYwSs5Bsm4UwaRaS
	SbOQTJqFZNICRtZVjOKlxcW56RXFhnmp5XrFibnFpXnpesn5uZsYgTF3+t/hyB2MR2991DvE
	yMTBeIhRgoNZSYQ3vUEmVYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvjikXU4QE0hNLUrNTUwtS
	i2CyTBycUg1MK9X8q+JDme1X+oj9lZUWtV+Xo9Ei9GDbgqnKM04ya2sGGAV83//sSZ1WhvRh
	yxkGkS3SEa0FH9+v8K6VuNlqy7a40sz5WMfeLUkvRNW7IuMVq21WZm07KepWPXcjX9jid7W7
	/myyMsmY/OSV4IEFltM05nhbnLQSsHD6d/ncr20OJguKNm4J3+Sz0e+Z5qlb0bN5JE82moQt
	y3H9U7P7bZbG8W3dsaqLPs3KD/rjXzrPu8Ojl+0jz/xXl8zmzJ72yrdwme+0u/+2H2n2D1fu
	UPSuNegTyApke6VbWqgvufifie3ax8otMtINsrxS9/j5vLg8nqanPdr2cFLvXXefw1a7LM4e
	OyajevJi3x8lluKMREMt5qLiRAD9/YMeKAMAAA==
X-CMS-MailID: 20231006170952uscas1p204c0db1931674a83db0cb29a49a18680
CMS-TYPE: 301P
X-CMS-RootMailID: 20231006170340uscas1p1cb7a65c371984266b3fe06ffce9d7d55
References: <CGME20231006170340uscas1p1cb7a65c371984266b3fe06ffce9d7d55@uscas1p1.samsung.com>
	<169661181914.694957.3925873284580708486.stgit@bgt-140510-bm03.eng.stellus.in>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SSBzZWUgSSBzaG91bGQgaGF2ZSBzZW50IOKAnG5kY3RsIiBhcyBhIHByZWZpeCBpbnN0ZWFkIG9m
IHZlcnNpb24uIExldCBtZSBrbm93IGlmDQphIHNob3VsZCBzZW5kIGEgdjIgd2l0aCB0aGUgY29y
cmVjdGVkLCBvdGhlcndpc2UgSeKAmWxsIHVzZSB0aGUgcHJlZml4IG5leHQgdGltZQ0KYXJvdW5k
Lg0KDQo+IE9uIE9jdCA2LCAyMDIzLCBhdCAxMDowM+KAr0FNLCBKaW0gSGFycmlzIDxqaW0uaGFy
cmlzQHNhbXN1bmcuY29tPiB3cm90ZToNCg0K
