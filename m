Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B7EB8
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J71oAm2L"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8707C94
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 11:38:42 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231010183840usoutp02ff48670a35442226fa6d9978e3219830~M0ver2uOD0393103931usoutp02m;
	Tue, 10 Oct 2023 18:38:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231010183840usoutp02ff48670a35442226fa6d9978e3219830~M0ver2uOD0393103931usoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1696963120;
	bh=oI/sb+3jq9rk/RWEqZp07XuknPPe93xMN9P+8IT8/J4=;
	h=From:To:Subject:Date:References:From;
	b=J71oAm2LctkjVk0CHQXsNKv+ZYisxSY2kjIlcoPDkrzBANDbRPd0KX9ohz9nwa3G3
	 1kExt4TAV5qPlHKLhJzoO7NWn+uN7z2UQ51IMqE8cZgCcEgZSHQ4Z8T0fY8BD6SelK
	 EHsxx+JvFuZ71V+c1sQV/LR5FxhB/BrCL/oQWrrI=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231010183840uscas1p23505231b5d68d67ce5bdaf1c7e3f90cb~M0vebigm53057530575uscas1p2h;
	Tue, 10 Oct 2023 18:38:40 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 2A.B9.50148.03A95256; Tue,
	10 Oct 2023 14:38:40 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231010183840uscas1p294532ae60e6014508efd897fef14fffd~M0veH-OwN1308913089uscas1p2c;
	Tue, 10 Oct 2023 18:38:40 +0000 (GMT)
X-AuditID: cbfec36d-7bdff7000002c3e4-a2-65259a30e016
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id E2.E7.31200.F2A95256; Tue,
	10 Oct 2023 14:38:40 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Tue, 10 Oct 2023 11:38:39 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
	10 Oct 2023 11:38:39 -0700
From: Jim Harris <jim.harris@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: [PATCH] cxl/region: don't try to cleanup after
 cxl_region_setup_targets() fails
Thread-Topic: [PATCH] cxl/region: don't try to cleanup after
	cxl_region_setup_targets() fails
Thread-Index: AQHZ+6j8MpVLjV1hUUCWKxMwxFDyyg==
Date: Tue, 10 Oct 2023 18:38:39 +0000
Message-ID: <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <39A9F2973CCB7C47A6D18365657E3A34@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzreV2DWaqpBp0t0hYf5rWyW0yfeoHR
	4vysUywOzB6L97xk8rhzbQ+bx+dNcgHMUVw2Kak5mWWpRfp2CVwZB09vYC94IlYx88B39gbG
	GWJdjJwcEgImEm13fzB2MXJxCAmsZJQ4OncCO4TTyiRxet8vVpiqm+/uMkMk1jJK/Pv/jw3C
	+cQosebTKyYIZxmjxPbfxxhBWtgENCV+XVkDlhABabndPY0NJCEsECUxa8MDZhBbRCBe4sOa
	L1C2nsSunyuYQGwWAVWJNY1t7CA2r0C0xJ2Vu8CGMgqISXw/tQashllAXOLWk/lMEPcJSiya
	vYcZwhaT+LfrIRuErShx//tLoDkcQPWaEut36UO02kmc+N7KDmErSkzpfgi1SlDi5MwnLBCt
	khIHV9xgAblfQqCTQ+LnvnPMIHMkBFwkTt5ihKiRlvh7dxnUCdkSK9d3MEGUFEg0HAmCCFtL
	LPyzHupiPom/vx4xQpTwSnS0CU1gVJqF5JdZCHfOQnLnLCR3zkJy5wJG1lWM4qXFxbnpqcWG
	eanlesWJucWleel6yfm5mxiB6eX0v8O5Oxh33Pqod4iRiYPxEKMEB7OSCO+jTJVUId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4ryGtieThQTSE0tSs1NTC1KLYLJMHJxSDUxt6tLnZu1Y+YAzIvPy
	N/HaAxf7ZhyTcW3SfRhrNt1EOHpV58NlM9bU7anMEH+xSzehsPaba1S+oa7LMTeVk2tMd/33
	P8pzVkovzvby6t70aKW6c4WFYUGbz87vqehXCctmSJn8JXBO0qRlae8Mr0oaf94Xu+Tg0T37
	5q9MNUrV3nPr4st9UmuNU1MlXwTNX3tCR+vHHnMxyw9t6nKz5bWPeEkKGaoITZlYs/XkhUdF
	M7YILlZsWP3MuMgsYVHHzVt9UT7aj8xD1k3UT5xx+dW6nPTL+smdoduyPl/5lK3ndElccsLC
	Ut+AGwXmExgvs6mWH5MuVTn8Iirwc8ur0ylmDq5740w3e+1OWNOz4aQSS3FGoqEWc1FxIgDA
	x0zFngMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LJbGCapGswSzXV4HcDi8WHea3sFtOnXmC0
	OD/rFIsDs8fiPS+ZPO5c28Pm8XmTXABzFJdNSmpOZllqkb5dAlfGwdMb2AueiFXMPPCdvYFx
	hlgXIyeHhICJxM13d5m7GLk4hARWM0rsX/SABcL5xChxY+k9qMwyRolb/7eyg7SwCWhK/Lqy
	hgkkISKwllHidvc0NpCEsECUxKwND5hBbBGBeInmAw9YIWw9iV0/VzCB2CwCqhJrGtvABvEK
	REvcWbmLEcRmFBCT+H5qDVgNs4C4xK0n85kg7hOQWLLnPDOELSrx8vE/VghbUeL+95dAcziA
	6jUl1u/Sh2i1kzjxvZUdwlaUmNL9EGqVoMTJmU9YIFolJQ6uuMEygVF0FpJtsxAmzUIyaRaS
	SbOQTFrAyLqKUby0uDg3vaLYKC+1XK84Mbe4NC9dLzk/dxMjMK5O/zscvYPx9q2PeocYmTgY
	DzFKcDArifA+ylRJFeJNSaysSi3Kjy8qzUktPsQozcGiJM67Y8rFFCGB9MSS1OzU1ILUIpgs
	EwenVANTT+01EcV73DZCgvmh4fWcmQEKkuEmWddPvcgLnzg/fiEL//UZgl1Hl2gZvOxZGXTj
	x4rjDsv4b2241FZ/LO5W/7l1Xa8U4pveeiWIJyyQ0evguMfn3/Onm+PN+2VCZQuXf0p/83KC
	qOvSq9teHEyorrZak/xFvbBy16OuYq/P7x4wiV2IEeZu+hpvPm31QePoe8vWsvO7s3wXSLO4
	/Ygv/rdBCLOj66xvBh7vbtWuUFm7TswjvFmlrEbWrSLxzapVe0z6f98uOn9hV2XHN+8Cj3a1
	BZaCWnuPK6z+t0j2xKF/YbsWv7zhdJbj5eJ7WSftfz7wbb08f0uKTFbf29WMiROnlsz+PEFl
	3XfBQ4IPlFiKMxINtZiLihMB7Qhl9xoDAAA=
X-CMS-MailID: 20231010183840uscas1p294532ae60e6014508efd897fef14fffd
CMS-TYPE: 301P
X-CMS-RootMailID: 20231010183840uscas1p294532ae60e6014508efd897fef14fffd
References: <CGME20231010183840uscas1p294532ae60e6014508efd897fef14fffd@uscas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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
CnJlZ2lvbiBpcyBkZWxldGVkLgoKVGVzdGVkIGJ5IHRyeWluZyB0byBjcmVhdGUgYW4gaW52YWxp
ZCByZWdpb24gZm9yIGEgMiBzd2l0Y2ggKiAyIGVuZHBvaW50CnRvcG9sb2d5LCBhbmQgdGhlbiBm
b2xsb3dpbmcgdXAgd2l0aCBjcmVhdGluZyBhIHZhbGlkIHJlZ2lvbi4KClNpZ25lZC1vZmYtYnk6
IEppbSBIYXJyaXMgPGppbS5oYXJyaXNAc2Ftc3VuZy5jb20+Ci0tLQogZHJpdmVycy9jeGwvY29y
ZS9yZWdpb24uYyB8ICAgIDggKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5j
IGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYwppbmRleCA2ZDYzYjg3OThjMjkuLjMxNWNhMTY0
MGUwNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYworKysgYi9kcml2ZXJz
L2N4bC9jb3JlL3JlZ2lvbi5jCkBAIC0xNzUwLDcgKzE3NTAsNyBAQCBzdGF0aWMgaW50IGN4bF9y
ZWdpb25fYXR0YWNoKHN0cnVjdCBjeGxfcmVnaW9uICpjeGxyLAogCWlmIChwLT5ucl90YXJnZXRz
ID09IHAtPmludGVybGVhdmVfd2F5cykgewogCQlyYyA9IGN4bF9yZWdpb25fc2V0dXBfdGFyZ2V0
cyhjeGxyKTsKIAkJaWYgKHJjKQotCQkJZ290byBlcnJfZGVjcmVtZW50OworCQkJcmV0dXJuIHJj
OwogCQlwLT5zdGF0ZSA9IENYTF9DT05GSUdfQUNUSVZFOwogCX0KIApAQCAtMTc2MiwxMiArMTc2
Miw2IEBAIHN0YXRpYyBpbnQgY3hsX3JlZ2lvbl9hdHRhY2goc3RydWN0IGN4bF9yZWdpb24gKmN4
bHIsCiAJfTsKIAogCXJldHVybiAwOwotCi1lcnJfZGVjcmVtZW50OgotCXAtPm5yX3RhcmdldHMt
LTsKLQljeGxlZC0+cG9zID0gLTE7Ci0JcC0+dGFyZ2V0c1twb3NdID0gTlVMTDsKLQlyZXR1cm4g
cmM7CiB9CiAKIHN0YXRpYyBpbnQgY3hsX3JlZ2lvbl9kZXRhY2goc3RydWN0IGN4bF9lbmRwb2lu
dF9kZWNvZGVyICpjeGxlZCkKCg==
