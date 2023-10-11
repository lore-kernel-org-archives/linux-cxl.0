Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E216AA4
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FTZ/JCRX"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A8692
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 07:51:34 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231011145132usoutp02cd29716b52278ffba92be745fe537b11~NFSc60hxv0629306293usoutp024;
	Wed, 11 Oct 2023 14:51:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231011145132usoutp02cd29716b52278ffba92be745fe537b11~NFSc60hxv0629306293usoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697035892;
	bh=n6PLo5y73SrWV/T9Hqq5wS+gs4mAFXjnG7ZU6PWUBWg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FTZ/JCRXzSOdEpcbIRVwxYRmcgDZgsZ2R47x/PJ2x7dJE78wpgGS2N9S7UbOSYIoa
	 QZZmIrDb2mzskfw6EJR77AGoCnrDBsSrkjX1pUpYslsD4g9MkCyks6IxvHOJU2eK3U
	 LOTaQHqRlsI5XQDwnw61gVRnuBsr09LCk5yp0xIo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231011145132uscas1p2ccca950254a592e62e5e82501d41faa3~NFScugkSq0590205902uscas1p2j;
	Wed, 11 Oct 2023 14:51:32 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 6C.5B.40279.476B6256; Wed,
	11 Oct 2023 10:51:32 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013~NFSccoPrq2384123841uscas1p1_;
	Wed, 11 Oct 2023 14:51:32 +0000 (GMT)
X-AuditID: cbfec36f-4cbfe70000009d57-f2-6526b6741948
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 93.11.31200.476B6256; Wed,
	11 Oct 2023 10:51:32 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 11 Oct 2023 07:51:31 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	11 Oct 2023 07:51:31 -0700
From: Jim Harris <jim.harris@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: [PATCH v2] cxl/region: don't try to cleanup after
 cxl_region_setup_targets() fails
Thread-Topic: [PATCH v2] cxl/region: don't try to cleanup after
	cxl_region_setup_targets() fails
Thread-Index: AQHZ/FJsHCzEUiok5USCGGYrUKwmDQ==
Date: Wed, 11 Oct 2023 14:51:31 +0000
Message-ID: <169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
In-Reply-To: <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <00288EF0763F06439161218DB6C0CC56@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzrOd2SbWqpBp/my1t8mNfKbjF96gVG
	i/OzTrE4MHss3vOSyePOtT1sHp83yQUwR3HZpKTmZJalFunbJXBlvP38lq3glEzFl4mz2BsY
	30h3MXJySAiYSLxv2cIMYgsJrGSUmNVm2sXIBWS3Mkl0rL3IBlN0dPNuNojEWkaJjrYvjBDO
	J0aJX1+PsEI4yxglLi89zA7SwiagKfHryhomkIQISMvt7mlgs4QFYiWenbwIViQikCTxfO4U
	NghbT6KxqRHsEBYBVYnra7czgti8AjES+7qWg9VwAtkblxwH62UUEJP4fgpkAScHs4C4xK0n
	85kgbhWUWDR7DzOELSbxb9dDqB8UJe5/fwnUywFUrymxfpc+hGknsX0bP8QURYkp3Q/ZIbYK
	Spyc+YQFolNS4uCKGywgr0gILOSQ6H9xFirhIvH10yGotdISf+8ug7KzJVau72ACmS8hUCDR
	cCQIImwtsfDPeqiL+ST+/nrEOIFReRaSB2YhHDcL4bhZSI6bheS4BYysqxjFS4uLc9NTi43y
	Usv1ihNzi0vz0vWS83M3MQKTy+l/h/N3MF6/9VHvECMTB+MhRgkOZiUR3keZKqlCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEeQ1tTyYLCaQnlqRmp6YWpBbBZJk4OKUamEyW5q/XPqBspuFafeK3
	mnKXhYDdAmcVRW0P3dlWynN7NIo4C84vEb6347Rj5f+pxlnhu0Tm5pXqmq39edpWb/FPdZmC
	juXaCuZ2yUceb75RFX5zJl/1k3eWU8oOFgac++CYo3hmbtr+qHTOD4F6rT38fHIxiiv+NEpu
	z/ixV5ltS8zL4/Ovd+bEX9jJdVNjhopGlHdN+suNHnW73s8NqOs4G+jz6vREp2PLzBP21ge8
	uebA+3NayL9X5yfM2DzfiOXUrEM8WTqhJXsrTObdCnwZ+S0w4P7ktrlftNQEHniVywpd1w/N
	4RN+LfS751PAy+lmX89q993gXbuggGVTUX2z1wuL91vMNk1bGvg/VYmlOCPRUIu5qDgRAC3C
	wBudAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWS2cA0Sbdkm1qqQessPosP81rZLaZPvcBo
	cX7WKRYHZo/Fe14yedy5tofN4/MmuQDmKC6blNSczLLUIn27BK6Mt5/fshWckqn4MnEWewPj
	G+kuRk4OCQETiaObd7OB2EICqxkljs+y6WLkArI/MUqs+beNCcJZxijxdkcrO0gVm4CmxK8r
	a8ASIgJrGSVud08DaxcWiJV4dvIiWJGIQJLE9aZrjBC2nkRjUyMziM0ioCpxfe12sDivQIzE
	vq7lQL0cQBuiJVZP0wMJcwKFNy45DjaGUUBM4vspkF2cHMwC4hK3nsxngrhaQGLJnvPMELao
	xMvH/1ghbEWJ+99fsoOMZAa6c/0ufQjTTmL7Nn6IKYoSU7ofskMcIChxcuYTFohOSYmDK26w
	TGAUn4Vk2SyEQbMQBs1CMmgWkkELGFlXMYqXFhfnplcUG+WllusVJ+YWl+al6yXn525iBMbf
	6X+Ho3cw3r71Ue8QIxMH4yFGCQ5mJRHeR5kqqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5d0y5
	mCIkkJ5YkpqdmlqQWgSTZeLglGpgmqIwRcFawEBt6dKWOVuTwjk7Fl5+OuVawoM+43thD/b8
	/Pfb06T22NYc87g7Cw/Uqt85xVZpeEXf7oDHn7i0d3Nmrc9eYtHfqt/AWiazzFZfvW3pkmRj
	i33d1hXhzNbtIbM7113pNF6xwW4ZV/nn8N1Si6wvTj95w7P6cGnP7G5NobMOq5p3ML883KT3
	QenM26fnBOwPR07cVnx3tmbUp9b/JdsvG93pWbX2xhS+v2JMesk3nNkZls48uaFBo/Ks0nNR
	5i7/lk1rf/c33P1ZsMo7suSQoq7gYofbe/J5pr67H79+C++t1rT1qfO+Fqevb3N+sX3TDO/D
	N3Zfyt/vlGp79d1r/6kFN4QCbQ4YhimxFGckGmoxFxUnAgBUjO3gLgMAAA==
X-CMS-MailID: 20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013
CMS-TYPE: 301P
X-CMS-RootMailID: 20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013
References: <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
	<CGME20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013@uscas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

UGF0Y2ggNWU0MmJjYmMgKCJjeGwvcmVnaW9uOiBkZWNyZW1lbnQgLT5ucl90YXJnZXRzIG9uIGVy
cm9yIGluCmN4bF9yZWdpb25fYXR0YWNoKCkiKSB0cmllZCB0byBhdm9pZCAnZWl3JyBpbml0aWFs
aXphdGlvbiBlcnJvcnMgd2hlbgotPm5yX3RhcmdldHMgZXhjZWVkZWQgMTYsIGJ5IGp1c3QgZGVj
cmVtZW50aW5nIC0+bnJfdGFyZ2V0cyB3aGVuCmN4bF9yZWdpb25fc2V0dXBfdGFyZ2V0cygpIGZh
aWxlZC4gUGF0Y2ggODY5ODdjNzYgKCJjeGwvcmVnaW9uOiBDbGVhbnVwCnRhcmdldCBsaXN0IG9u
IGF0dGFjaCBlcnJvciIpIGV4dGVuZGVkIHRoYXQgY2xlYW51cCB0byBhbHNvIGNsZWFyCmN4bGVk
LT5wb3MgYW5kIHAtPnRhcmdldHNbcG9zXS4KClRoZSBpbml0aWFsaXphdGlvbiBlcnJvciB3YXMg
aW5jaWRlbnRhbGx5IGZpeGVkIHNlcGFyYXRlbHkgYnkgcGF0Y2gKOGQ0Mjg1NDI1ICgiY3hsL3Jl
Z2lvbjogRml4IHBvcnQgc2V0dXAgdW5pbml0aWFsaXplZCB2YXJpYWJsZSB3YXJuaW5ncyIpCndo
aWNoIHdhcyBtZXJnZWQgYSBmZXcgZGF5cyBhZnRlciA1ZTQyYmNiYy4KCkJ1dCBub3cgdGhlIG9y
aWdpbmFsIGNsZWFudXAgd2hlbiBjeGxfcmVnaW9uX3NldHVwX3RhcmdldHMoKSBmYWlscwpwcmV2
ZW50cyBlbmRwb2ludCBhbmQgc3dpdGNoIGRlY29kZXIgcmVzb3VyY2VzIGZyb20gYmVpbmcgcmV1
c2VkOgoKMSkgdGhlIGNsZWFudXAgZG9lcyBub3Qgc2V0IHRoZSBkZWNvZGVyJ3MgcmVnaW9uIHRv
IE5VTEwsIHdoaWNoIHJlc3VsdHMKICAgaW4gZnV0dXJlIGRwYV9zaXplX3N0b3JlKCkgY2FsbHMg
cmV0dXJuaW5nIC1FQlVTWQoyKSB0aGUgZGVjb2RlciBpcyBub3QgcHJvcGVybHkgZnJlZWQsIHdo
aWNoIHJlc3VsdHMgaW4gZnV0dXJlIGNvbW1pdAogICBlcnJvcnMgYXNzb2NpYXRlZCB3aXRoIHRo
ZSB1cHN0cmVhbSBzd2l0Y2gKCk5vdyB0aGF0IHRoZSBpbml0aWFsaXphdGlvbiBlcnJvcnMgd2Vy
ZSBmaXhlZCBzZXBhcmF0ZWx5LCB0aGUgcHJvcGVyCmNsZWFudXAgZm9yIHRoaXMgY2FzZSBpcyB0
byBqdXN0IHJldHVybiBpbW1lZGlhdGVseS4gVGhlbiB0aGUgcmVzb3VyY2VzCmFzc29jaWF0ZWQg
d2l0aCB0aGlzIHRhcmdldCBnZXQgY2xlYW51cCB1cCBhcyBub3JtYWwgd2hlbiB0aGUgZmFpbGVk
CnJlZ2lvbiBpcyBkZWxldGVkLgoKVGhlIC0+bnJfdGFyZ2V0cyBkZWNyZW1lbnQgaW4gdGhlIGVy
cm9yIGNhc2UgYWxzbyBoZWxwZWQgcHJldmVudAphIHAtPnRhcmdldHNbXSBhcnJheSBvdmVyZmxv
dywgc28gYWRkIGEgbmV3IGNoZWNrIHRvIHByZXZlbnQgYWdhaW5zdAp0aGF0IG92ZXJmbG93LgoK
VGVzdGVkIGJ5IHRyeWluZyB0byBjcmVhdGUgYW4gaW52YWxpZCByZWdpb24gZm9yIGEgMiBzd2l0
Y2ggKiAyIGVuZHBvaW50CnRvcG9sb2d5LCBhbmQgdGhlbiBmb2xsb3dpbmcgdXAgd2l0aCBjcmVh
dGluZyBhIHZhbGlkIHJlZ2lvbi4KClNpZ25lZC1vZmYtYnk6IEppbSBIYXJyaXMgPGppbS5oYXJy
aXNAc2Ftc3VuZy5jb20+Ci0tLQogZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyB8ICAgMTQgKysr
KysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2RyaXZlcnMvY3hs
L2NvcmUvcmVnaW9uLmMKaW5kZXggNmQ2M2I4Nzk4YzI5Li4yYjNiM2M2MmQwYTcgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKKysrIGIvZHJpdmVycy9jeGwvY29yZS9yZWdp
b24uYwpAQCAtMTY1OCw2ICsxNjU4LDEyIEBAIHN0YXRpYyBpbnQgY3hsX3JlZ2lvbl9hdHRhY2go
c3RydWN0IGN4bF9yZWdpb24gKmN4bHIsCiAJCXJldHVybiAtRU5YSU87CiAJfQogCisJaWYgKHAt
Pm5yX3RhcmdldHMgPj0gcC0+aW50ZXJsZWF2ZV93YXlzKSB7CisJCWRldl9kYmcoJmN4bHItPmRl
diwgInJlZ2lvbiBhbHJlYWR5IGhhcyAlZCBlbmRwb2ludHNcbiIsCisJCQlwLT5ucl90YXJnZXRz
KTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCiAJZXBfcG9ydCA9IGN4bGVkX3RvX3BvcnQoY3hs
ZWQpOwogCXJvb3RfcG9ydCA9IGN4bHJkX3RvX3BvcnQoY3hscmQpOwogCWRwb3J0ID0gY3hsX2Zp
bmRfZHBvcnRfYnlfZGV2KHJvb3RfcG9ydCwgZXBfcG9ydC0+aG9zdF9icmlkZ2UpOwpAQCAtMTc1
MCw3ICsxNzU2LDcgQEAgc3RhdGljIGludCBjeGxfcmVnaW9uX2F0dGFjaChzdHJ1Y3QgY3hsX3Jl
Z2lvbiAqY3hsciwKIAlpZiAocC0+bnJfdGFyZ2V0cyA9PSBwLT5pbnRlcmxlYXZlX3dheXMpIHsK
IAkJcmMgPSBjeGxfcmVnaW9uX3NldHVwX3RhcmdldHMoY3hscik7CiAJCWlmIChyYykKLQkJCWdv
dG8gZXJyX2RlY3JlbWVudDsKKwkJCXJldHVybiByYzsKIAkJcC0+c3RhdGUgPSBDWExfQ09ORklH
X0FDVElWRTsKIAl9CiAKQEAgLTE3NjIsMTIgKzE3NjgsNiBAQCBzdGF0aWMgaW50IGN4bF9yZWdp
b25fYXR0YWNoKHN0cnVjdCBjeGxfcmVnaW9uICpjeGxyLAogCX07CiAKIAlyZXR1cm4gMDsKLQot
ZXJyX2RlY3JlbWVudDoKLQlwLT5ucl90YXJnZXRzLS07Ci0JY3hsZWQtPnBvcyA9IC0xOwotCXAt
PnRhcmdldHNbcG9zXSA9IE5VTEw7Ci0JcmV0dXJuIHJjOwogfQogCiBzdGF0aWMgaW50IGN4bF9y
ZWdpb25fZGV0YWNoKHN0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2RlciAqY3hsZWQpCgo=
