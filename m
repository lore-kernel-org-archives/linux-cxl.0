Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A82AB54
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cnWALdia"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FA1106
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 12:46:08 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231016194605usoutp01135b903aeb960bd6edcc9029897b62d6~OriDaNFL-1426714267usoutp01l;
	Mon, 16 Oct 2023 19:46:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231016194605usoutp01135b903aeb960bd6edcc9029897b62d6~OriDaNFL-1426714267usoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697485565;
	bh=d9D7us3K37jWi9bb0GF0SroEhxoBROBzhEgeYp99FGU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=cnWALdiai/97RqFfmpB7ymNxmuWGrWTUEGEmbj3xPF+uCey1O+6uk9KDcb54YQeJh
	 c2aR2KBTvHCogk711x8PQMtqLT6ZbyA1iZpF2jzZQmBOmlcN9Q4QT9q1xLA0s3sLXl
	 ZRAHQWoJGvSfRpsX1hdCfTA91NNPqMHqDCVHVr9g=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231016194605uscas1p2a9d432bd0d9901fa780648e3445f712e~OriDPnwAE0982009820uscas1p2_;
	Mon, 16 Oct 2023 19:46:05 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id FA.C8.62237.DF29D256; Mon,
	16 Oct 2023 15:46:05 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231016194605uscas1p2ac08745283fc25e8ffa0e47bc89b47aa~OriDBnqXK3016630166uscas1p2m;
	Mon, 16 Oct 2023 19:46:05 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-5c-652d92fd52e4
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id F9.5F.31410.CF29D256; Mon,
	16 Oct 2023 15:46:05 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Mon, 16 Oct 2023 12:46:04 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
	16 Oct 2023 12:46:04 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>
Subject: Re: [PATCH v3 1/2] cxl: Add cxl_decoders_committed() helper
Thread-Topic: [PATCH v3 1/2] cxl: Add cxl_decoders_committed() helper
Thread-Index: AQHaAFpOKb1sROiTIUePBf3M5zwR7rBNR2MA
Date: Mon, 16 Oct 2023 19:46:04 +0000
Message-ID: <A8AE1FD2-944C-4379-80CF-53F0EC8E3C89@ssi.samsung.com>
In-Reply-To: <169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF350684993E1943957AE028B2192F26@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djXc7p/J+mmGkz8JGlx9/EFNovpUy8w
	Wpy42chmsfrmGkaL/U+fs1isWniNzeL8rFMsFrcmHGNy4PBoOfKW1WPxnpdMHlNn13t83iQX
	wBLFZZOSmpNZllqkb5fAlfF/YidLwSyWilO7NrI0MPawdDFyckgImEic2fyKvYuRi0NIYCWj
	xIoHM5ggnFYmiS2ffrPBVP3qXswMkVjDKDF7dwMLhPOJUWLN171Q/csYJWYd2MAE0sImoCnx
	68oaMFtEQFXi/vrHbCBFzAKfmSSOfzrPCJIQFnCRmLGtnQWiyFVibtMkVgjbSOLWg0dgNSxA
	zQc7ZoHV8Ao4SfTO6wcbyingJXHvxlywOKOAmMT3UxDLmAXEJW49mc8EcbegxKLZe5ghbDGJ
	f7seQv2jKHH/+0ugqzmA6jUl1u/Sh2i1k7i3aS3UGEWJKd0P2SHWCkqcnPkEGmCSEgdX3AD7
	XkLgCodEx4qPUDNdJDb2zocqkpaYvuYylJ0tsXJ9BxPILgmBAomGI0EQYWuJhX/WM01gVJmF
	5OpZCBfNQnLRLCQXzUJy0QJG1lWM4qXFxbnpqcXGeanlesWJucWleel6yfm5mxiByen0v8MF
	Oxhv3fqod4iRiYPxEKMEB7OSCG96sE6qEG9KYmVValF+fFFpTmrxIUZpDhYlcV5D25PJQgLp
	iSWp2ampBalFMFkmDk6pBibHr0LSp6Nynyz2VD6/b6Vro55k9f7Ks7K6d35+2/z2ocI71Qmq
	E5a4m8eFLZ7WNyvkYZLYr0s7b5ZMFtTk2fHHXkt42/TDX07+s9d7sCP5o8eir9KfODb8if9X
	caB34u81i174pZS0b/0Q11s/89flQgm/ktqNO++Eq+w3CVXmaHzRfiu1inPfhRN/WRgnTNP/
	ItKW+uDW+d+HwxOeLQ71V3rZmHOj2MBSVkTP/lzVGaPvk5dGy300WRPUIF0RXxO54qXDdEuh
	bO70q/5MUorynZYrGF99ejWredNCzd6cfc18Ojm//+38/Lf7vdvmSjmVya++71AUOPbt35F3
	jca2E2y/fuT2mrhpTmr79FpLJZbijERDLeai4kQAAnplyb0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWS2cDspPt3km6qQUsPp8XdxxfYLKZPvcBo
	ceJmI5vF6ptrGC32P33OYrFq4TU2i/OzTrFY3JpwjMmBw6PlyFtWj8V7XjJ5TJ1d7/F5k1wA
	SxSXTUpqTmZZapG+XQJXxv+JnSwFs1gqTu3ayNLA2MPSxcjJISFgIvGrezFzFyMXh5DAKkaJ
	fwe3QTmfGCVONm1jg3CWMUrMvruHGaSFTUBT4teVNUwgtoiAqsT99Y/BipgFPjNJHP90nhEk
	ISzgIjFjWzsLRJGrxNymSawQtpHErQePwGpYgJoPdswCq+EVcJLondfPBLFtLqPEsbXzwBo4
	Bbwk7t2YC1bEKCAm8f0UxGZmAXGJW0/mM0E8ISCxZM95ZghbVOLl43+sELaixP3vL9m7GDmA
	6jUl1u/Sh2i1k7i3aS3UGEWJKd0P2SFuEJQ4OfMJNFwkJQ6uuMEygVFiFpJtsxAmzUIyaRaS
	SbOQTFrAyLqKUby0uDg3vaLYOC+1XK84Mbe4NC9dLzk/dxMjMLZP/zscs4Px3q2PeocYmTgY
	DzFKcDArifCmB+ukCvGmJFZWpRblxxeV5qQWH2KU5mBREue9+0AjVUggPbEkNTs1tSC1CCbL
	xMEp1cB0jO+UmbG54h+v12zXlmnFuEQW6TvM0pjU1/r6IeefP8pP/rw/N29i0Je/72rCehM9
	fuX1mM/8u9Xx/irPva8+7olekLTT4PFK7g1icvsrTxbcTH3x6qerzusFav/KJnzQvCS+O3XT
	vBr3te+zTc4bi27TsVGrD67uvNB9SYBviaWrxV6lnRq/2TM0fbNO1Z+qSFBa3pclNfmbb0Z9
	+qzm9vOJVnM1K8WMnl9aoTO7s7xY0+2EyhLJgMQ9j1ecr9zQeUxAaW6r9sq/DYq57AG5J2b1
	vnx4N/JJ+sPNE9bIt4lHTN7DfeG6y7+VKhJzzzzxPlwav//a+89liwK0T0ooT9hbxSR0xNY0
	dIm7a3C3EktxRqKhFnNRcSIApF1BVFwDAAA=
X-CMS-MailID: 20231016194605uscas1p2ac08745283fc25e8ffa0e47bc89b47aa
CMS-TYPE: 301P
X-CMS-RootMailID: 20231016175800uscas1p2cdf5532581e564f356b36c0126d2a25f
References: <CGME20231016175800uscas1p2cdf5532581e564f356b36c0126d2a25f@uscas1p2.samsung.com>
	<169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDE2LCAyMDIzLCBhdCAxMDo1N+KAr0FNLCBEYXZlIEppYW5nIDxkYXZlLmpp
YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBBZGQgYSBoZWxwZXIgdG8gcmV0cmlldmUgdGhl
IG51bWJlciBvZiBkZWNvZGVycyBjb21taXR0ZWQgZm9yIHRoZSBwb3J0Lg0KPiBSZXBsYWNlIGFs
bCB0aGUgb3BlbiBjb2Rpbmcgb2YgdGhlIGNhbGN1bGF0aW9uIHdpdGggdGhlIGhlbHBlci4NCj4g
DQo+IFN1Z2dlc3RlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KDQpS
ZXZpZXdlZC1ieTogSmltIEhhcnJpcyA8amltLmhhcnJpc0BzYW1zdW5nLmNvbT4NCg0K
