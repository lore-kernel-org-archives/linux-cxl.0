Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90CBE4F
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aBVnjH4E"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1803EB
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 10:03:41 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231006170340usoutp02813ef1a94344ce8ad4159c0b1110f2c0~Lk3Y_mpyv0408704087usoutp02l
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:03:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231006170340usoutp02813ef1a94344ce8ad4159c0b1110f2c0~Lk3Y_mpyv0408704087usoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1696611820;
	bh=3ThDriuG8zINOfnQ9DPOOEKX2kcs0V63BuySaeHd9Is=;
	h=From:To:Subject:Date:References:From;
	b=aBVnjH4EP0vFEd2/Lr7ssoeooD1Qk8y5TxHbrmA4QStNTJXWCTNdOtDm2djv1bb+e
	 9udbO5d4BHoPo28hkSshdbTUvJsKe135x6k7Gf69Rg2ZOLYf3IDjRZrfSuoetz/uGt
	 LTAb8ha1n4EntJ24Ks8R508AZbqmWfvA7eNeE3Cg=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231006170340uscas1p193babcb4e72bf78f68f3da0402bf6850~Lk3Y6cmVy2034420344uscas1p1t
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:03:40 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id 08.A1.62237.CED30256; Fri, 
	6 Oct 2023 13:03:40 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231006170340uscas1p1cb7a65c371984266b3fe06ffce9d7d55~Lk3YpPZ122411224112uscas1p1o
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:03:40 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-4c-65203dec4cad
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 0C.5E.28590.CED30256; Fri, 
	6 Oct 2023 13:03:40 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 6 Oct 2023 10:03:39 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	6 Oct 2023 10:03:39 -0700
From: Jim Harris <jim.harris@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: [PATCH ndctl] libcxl: don't calculate max_available_extent when
 start == ULLONG_MAX
Thread-Topic: [PATCH ndctl] libcxl: don't calculate max_available_extent
	when start == ULLONG_MAX
Thread-Index: AQHZ+HcNJ3f5Nhx0J0CNVMPUROcjHA==
Date: Fri, 6 Oct 2023 17:03:39 +0000
Message-ID: <169661181914.694957.3925873284580708486.stgit@bgt-140510-bm03.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C338EE2BE693446884855C0028693E0@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXfOtuNyclwrn2akjggUnEoFgSYFsSQSvGQfBKvTPExzzrWp
	XQiaRLGsoOZEPGpeMHKhaEaZVuC8sjSnXbzF0ImpI7u51sTKap1Ffvs//+f2e15eAhO5cQmR
	oy6gtWpKJeUJ8Ef9blvU0t4wOmbOELbHxjzH96FEV9u2ZJQhiM+iVTlFtDY64YQg2/zejmlM
	AWffeuZ5erS0oQT5E0DuAkfPDF6CBISINCOobi7lssEdDpQ3G/j/qgY6niE20YygfdjIZ4Mv
	COy9s77gDoIug4XrbeGREbD6uonj1WIyDm7qG3gliCA2ksfAtXCStRVQXXqL47XFpAw6jIle
	Gye3w/yHMZ5XC8kMqHS7kVcjcjN4nrMTMTIYpuZqOCxcENRXPsVYvRnWOh08VofDtMfJ947H
	/tC0dEazrQmg/zDEZ3U4mK45+OyqILBWzOFs6xawNE78fRUgnXzoHbX6Egfg7a8fvvkh8Ga8
	zLc3F8wthr+nAKkBfW8qa8dB3Y8WH3Ig/FydRWyJEAxXRDeRlFl3DPMflFkHyqwDZdaB1iLu
	PRRcqNPlKWndTjV9Rqaj8nSFaqVMkZ/Xhv78jMG1Hs1jNDX1RdaNOATqRkBgUrFQqd9Ki4RZ
	1LnztDb/uLZQReu6UQiBS4OFsXutChGppAroXJrW0Np/WQ7hL9FzWq1l7a9n2obk9tsR6a2u
	U/6jAlf4L1Pid+Vcmj4l3nnJ1V4hwfoPGOWT8tnqrqZ3jtVnbwYuCr6dHRs6c/1qelb5IcMa
	WZB5YXmwQk0xwzw/G9CBGTtMiXX1XUm1PcmTVJHDFLLovj8gHYmb5InxKk9d4cguVW/L/rSd
	86kpGlJy5Mgxc9XDSgUzSh0t1xjLvi49qDn4tfHy6eSOx/kTPSWhkuLJk+N9I2aFeXxZvSiN
	yeS7Ug876yz2nOLUmoDx7Aa/h9iLTR+tn6P6LJl3IwZFphttfraF/US9PenJ7uBPYTe4oUUv
	Xyk9KyuyaPcpGfNIfr1xumaCSo+U4rpsKjYS0+qo389GlEuIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWS2cA0SfeNrUKqwYoXvBbnZ51icWD0+LxJ
	LoAxissmJTUnsyy1SN8ugStj5eu7zAVTeCpuf3/G1sD4hruLkZNDQsBE4vjOvYxdjFwcQgKr
	GSW2LN7ADuF8ZJQ4fOEkM4SzlFHiSdtfVpAWNgFNiV9X1jCB2CIC1hITGpawgdjCAnESuxq2
	sEHEkyUu3ToF1MwBZOtJ7JzkARJmEVCRePb2GlgJr0CUxOyvXxlBbEYBMYnvpyBGMguIS9x6
	Mp8J4joBiSV7zjND2KISLx//Y4WwFSXuf3/JDjKeGeic9bv0IVrtJBrenmGHsBUlpnQ/ZIdY
	JShxcuYTFohWSYmDK26wTGAUnYVk2yyESbOQTJqFZNIsJJMWMLKuYhQvLS7OTa8oNsxLLdcr
	TswtLs1L10vOz93ECIyV0/8OR+5gPHrro94hRiYOxkOMEhzMSiK86Q0yqUK8KYmVValF+fFF
	pTmpxYcYpTlYlMR5d0y5mCIkkJ5YkpqdmlqQWgSTZeLglGpgUt5bwq19+l7vwQ2W6sEtJ/j/
	Bn9xzT7kIfxoGcOOFYeMPoTvCBSYLHAjZubFwsSQuaaLj2s6CAXsUV4lzZN1IPXWhaOFElGK
	PPOWL1x7zzVvHt/156msS1xmmO1Tk7jgMu/giXh2+TLmY2f6Xn5g93aefP680+yKM1MO6z3p
	a3ygXiZYlT/5oIDqpaWuefKHdFQL4j3PxVdlba9abWvad9VI+tTONYedEmuKSpPs34XWS5ye
	utno2LuVtkZMhVNm/bn5t3DrZS5esS+N884/754usVTop4Zd0cnN+wR5xRd+52vwZ/UqOqWr
	e+uXt+dbrdMfVq4oc8/dG/QyqWje9ePhjA3Hkl67rntpIrauWImlOCPRUIu5qDgRAGvKt7IE
	AwAA
X-CMS-MailID: 20231006170340uscas1p1cb7a65c371984266b3fe06ffce9d7d55
CMS-TYPE: 301P
X-CMS-RootMailID: 20231006170340uscas1p1cb7a65c371984266b3fe06ffce9d7d55
References: <CGME20231006170340uscas1p1cb7a65c371984266b3fe06ffce9d7d55@uscas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

YGN4bCBsaXN0YCBjYW4gYmUgcnVuIGFzIG5vbi1yb290LCBidXQgc29tZSBzeXNmcyBlbnRyaWVz
IHN1Y2ggYXMKZGVjb2RlclguWS9zdGFydCBhcmUgb25seSByb290LXJlYWRhYmxlLiBJbiB0aGlz
IGNhc2UsIGRlY29kZXItPnN0YXJ0CmdldHMgc2V0IHRvIFVMTE9OR19NQVggYW5kIGN4bF9kZWNv
ZGVyX21heF9hdmFpbGFibGVfZXh0ZW50KCkgd291bGQKdHJ5IHRvIGNhbGN1bGF0ZSBhIHNpemUg
YmFzZWQgb24gdGhlIHZhbHVlLiBUaGlzIHdvdWxkIHJlc3VsdCBpbgphIHZhbHVlIHNsaWdodGx5
IGxlc3MgdGhhbiBVTExPTkdfTUFYIHdoaWNoIHdvdWxkIGVtaXQgb2RkIChhbmQKb2J2aW91c2x5
IGluY29ycmVjdCkgdmFsdWVzIGZvciBtYXhfYXZhaWxhYmxlX2V4dGVudC4KCklmIHdlIGp1c3Qg
cmV0dXJuIFVMTE9OR19NQVggaW4gdGhpcyBjYXNlLCB0aGUgbWF4X2F2YWlsYWJsZV9leHRlbnQK
aXMgbm90IGVtaXR0ZWQgd2hpY2ggaXMgdGhlIGRlc2lyYWJsZSBiZWhhdmlvciBpbiB0aGlzIGNh
c2UuIElmIHVzZXJzCm5lZWQgdGhlIHZhbHVlLCB0aGV5IGNhbiBydW4gYGN4bCBsaXN0YCBhcyBy
b290LgoKU2lnbmVkLW9mZi1ieTogSmltIEhhcnJpcyA8amltLmhhcnJpc0BzYW1zdW5nLmNvbT4K
LS0tCiBjeGwvbGliL2xpYmN4bC5jIHwgICAgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9jeGwvbGliL2xpYmN4bC5jIGIvY3hsL2xpYi9saWJjeGwu
YwppbmRleCBhZjRjYTQ0Li5lYjljY2YxIDEwMDY0NAotLS0gYS9jeGwvbGliL2xpYmN4bC5jCisr
KyBiL2N4bC9saWIvbGliY3hsLmMKQEAgLTIwMDIsNiArMjAwMiw5IEBAIGN4bF9kZWNvZGVyX2Nh
bGNfbWF4X2F2YWlsYWJsZV9leHRlbnQoc3RydWN0IGN4bF9kZWNvZGVyICpkZWNvZGVyKQogCQly
ZXR1cm4gVUxMT05HX01BWDsKIAl9CiAKKwlpZiAoZGVjb2Rlci0+c3RhcnQgPT0gVUxMT05HX01B
WCkKKwkJcmV0dXJuIFVMTE9OR19NQVg7CisKIAkvKgogCSAqIFByZWxvYWQgcHJldl9lbmQgd2l0
aCBhbiBpbWFnaW5hcnkgcmVnaW9uIHRoYXQgZW5kcyBqdXN0IGJlZm9yZQogCSAqIHRoZSBkZWNv
ZGVyJ3Mgc3RhcnQsIHNvIHRoYXQgdGhlIGV4dGVudCBjYWxjdWxhdGlvbiBmb3IgdGhlCgo=
