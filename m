Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4332188
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m1D54o1C"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FEC8E
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 12:46:56 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231010194652usoutp01ffc569c0b85556c65795bc457b42df6c~M1rBqGQOy0461504615usoutp015
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 19:46:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231010194652usoutp01ffc569c0b85556c65795bc457b42df6c~M1rBqGQOy0461504615usoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1696967212;
	bh=DKulgDOhqDGb2LvRUqQ4oXC0DPFqc7debbS8avsAYFE=;
	h=From:To:Subject:Date:References:From;
	b=m1D54o1CjHXJJc/2eceOpzBNU5Zo5QH8j8u1HQWULAsuKPvXZDNrY9vVEX/Xd8M1I
	 ksCUG5ILfZLXBedwXVLStTfhhV8ADnVcROL6gLFGwcWZLUDnJcUMVFrh2FWTSArXGv
	 5q14dLSnN+f84Rl8cICwdxd+UnZzx8G0aKoXwQJg=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231010194652uscas1p106d23afab737b076da6eb7ae43578e58~M1rBjnQV81430314303uscas1p1K
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 19:46:52 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id BF.00.62237.C2AA5256; Tue,
	10 Oct 2023 15:46:52 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231010194652uscas1p18968f3a66d8cbe6d76dd444aa3ec50aa~M1rBUbGkI2995229952uscas1p1R
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 19:46:52 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-ee-6525aa2c0bf7
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 14.79.31410.C2AA5256; Tue,
	10 Oct 2023 15:46:52 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Tue, 10 Oct 2023 12:46:51 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
	10 Oct 2023 12:46:51 -0700
From: Jim Harris <jim.harris@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: [PATCH] cxl/region: Refactor logic around check_last_peer()
Thread-Topic: [PATCH] cxl/region: Refactor logic around check_last_peer()
Thread-Index: AQHZ+7KD8XRbpEWITUunMxlNnk7zRw==
Date: Tue, 10 Oct 2023 19:46:51 +0000
Message-ID: <169696721124.1190606.18028412676865061799.stgit@bgt-140510-bm03.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFAABC49F0DF6743AFFCCF69703C18AA@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djX87o6q1RTDXouqVmcn3WKxYHR4/Mm
	uQDGKC6blNSczLLUIn27BK6MOwsnMBackqvYMvUVYwPjE9kuRg4OCQETieZjUl2MXBxCAisZ
	JQ5u3MoE4Sxlkmjdv5Sxi5ETrOjInLNsEIm1jBJvvl1lgXA+MUocezKLBaRKSGAZo0TLIwkQ
	m01AU+LXlTVMILaIgLXEhIYlbCC2sICLxMX9O1gh4p4S/3+cgKrRk/jf+xNsG4uAqsSHQyuY
	QWxegRiJuzu2gMUZBcQkvp+CmMksIC5x68l8JojrBCUWzd7DDGGLSfzb9ZANwlaUuP/9JTvI
	m8xA96zfpQ/RaiexcPldFghbUWJK90N2iFWCEidnPmGBaJWUOLjiBtiPEgIv2SW2/t4MDQkX
	iU3XH7JC2NIS09dchmrIlli5voMJEqQFEg1HgiDC1hIL/6yHOplP4u+vR4wQJbwSHW1CExiV
	ZiF5ZhbCobOQHDoLyaGzkBy6gJF1FaN4aXFxbnpqsXFearlecWJucWleul5yfu4mRmDKOP3v
	cMEOxlu3PuodYmTiYDzEKMHBrCTC+yhTJVWINyWxsiq1KD++qDQntfgQozQHi5I4r6HtyWQh
	gfTEktTs1NSC1CKYLBMHp1QDU1WL7vqIIuamg54rIi++5kzfZGucrLru+MTSRw+OprE52aqf
	/nPi0cOLV4w2Td61eun5tqymdRW3qy6EzghQXiKhKbv15Mqve+3vxznbPbtQrL9lRrUPr/TK
	82FT7BS3hFzZ0crA+yes7umKb5skZ/alJ/LyvUqsyF277qvhDt61P9+LL+XUM62/vPTN5Sb3
	rxs4f5xfqh3zoeJtftCWb4x3De8+1ki/OnvW5qZ9niyTyjbu/9vpcjV7ydmSNsVNnaf8PqvX
	CKhcufDz/Bm9I5v/yGg6WpYINE5juPa2wnbRfJ/K8F+HLhnfnKrUuuTFQgaWssXvBRpqTql7
	rKiSbdgSF1lgJDQrx+dhnsudi0JKLMUZiYZazEXFiQCFhi+PiAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWS2cA0SVdnlWqqwaebIhbnZ51icWD0+LxJ
	LoAxissmJTUnsyy1SN8ugSvjzsIJjAWn5Cq2TH3F2MD4RLaLkZNDQsBE4sics2xdjFwcQgKr
	GSWW7nrLCuF8YpT4dXEHK0iVkMAyRommJVogNpuApsSvK2uYQGwRAWuJCQ1L2EBsYQEXiYv7
	IepFBDwl/v84AVWjJ/G/9ycjiM0ioCrx4dAKZhCbVyBG4u6OLWBxRgExie+nIGYyC4hL3Hoy
	nwniOgGJJXvOM0PYohIvH/9jhbAVJe5/f8nexcgBVK8psX6XPkSrncTC5XdZIGxFiSndD9kh
	VglKnJz5hAWiVVLi4IobLBMYRWch2TYLYdIsJJNmIZk0C8mkBYysqxjFS4uLc9Mrio3zUsv1
	ihNzi0vz0vWS83M3MQJj5fS/wzE7GO/d+qh3iJGJg/EQowQHs5II76NMlVQh3pTEyqrUovz4
	otKc1OJDjNIcLErivDumXEwREkhPLEnNTk0tSC2CyTJxcEo1MDmfOe1XMdfITKL81WYG14vc
	F2NYWhtsri04/sRa/rS8/ZlPb25fyT+yqIKh5HrItxT+zk7uHWWX5/su9GjI4BUqe6al3GK1
	LJKD2zDyd1SaaDfbjb0i995O1ovPDpvraGQdzXDxQV2ctoyxefKRC7llFS9++by8/u/wbMEH
	G6/tiTc/U3nfMbtvwrylt8Rr51RpVilUCLB2zlit+tuJXeLcvwPcV1hc2ISOnO3YO+HXX8ce
	dZ9nDx79W3jA2Jf93+MUreDZbEbcm0LyJzJuus3y5vgV/ZsJJo3BRtOkfzxe5PpNtvrr9BWz
	2G2qwpelTb5zc3r7nHlBVdmx8SUVdb1mIc+Y7lzS+vBYdaHoPSWW4oxEQy3mouJEAOLFM90E
	AwAA
X-CMS-MailID: 20231010194652uscas1p18968f3a66d8cbe6d76dd444aa3ec50aa
CMS-TYPE: 301P
X-CMS-RootMailID: 20231010194652uscas1p18968f3a66d8cbe6d76dd444aa3ec50aa
References: <CGME20231010194652uscas1p18968f3a66d8cbe6d76dd444aa3ec50aa@uscas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

J2Rpc3RhbmNlJyBpcyBlcXVpdmFsZW50IHRvIHRoZSBpbnRlcmxlYXZlX3dheXMgb2YgdGhlIHN3
aXRjaCBkZWNvZGVyCm9mIHRoZSBwb3J0IHdlIGFyZSBzZXR0aW5nIHVwIGluIGN4bF9wb3J0X3Nl
dHVwX3RhcmdldHMoKS4KCldlIGNhbiBhbHNvIGVsaW1pbmF0ZSB0aGUgc3BlY2lhbCBjYXNlIGZv
ciBwYXNzdGhyb3VnaCBkZWNvZGVycyAoaS5lLgppbnRlcmxlYXZlX3dheXMgPT0gMSkgLSBjaGVj
a19sYXN0X3BlZXIoKSB3aWxsIGp1c3QgY29tcGFyZSB0aGlzCmVuZHBvaW50J3MgZHBvcnQgd2l0
aCB0aGUgZHBvcnQgb2YgdGhlIGltbWVkaWF0ZWx5IHByZWNlZGluZyBlbmRwb2ludApiYXNlZCBv
biBwb3NpdGlvbi4KClNpZ25lZC1vZmYtYnk6IEppbSBIYXJyaXMgPGppbS5oYXJyaXNAc2Ftc3Vu
Zy5jb20+Ci0tLQogZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyB8ICAgMjUgKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDE0IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgYi9kcml2ZXJz
L2N4bC9jb3JlL3JlZ2lvbi5jCmluZGV4IDZkNjNiODc5OGMyOS4uMGRjMWM3ODc3MmYxIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jCisrKyBiL2RyaXZlcnMvY3hsL2NvcmUv
cmVnaW9uLmMKQEAgLTEwNDMsMTAgKzEwNDMsMTAgQEAgc3RhdGljIHZvaWQgY3hsX3BvcnRfZGV0
YWNoX3JlZ2lvbihzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQsCiB9CiAKIHN0YXRpYyBpbnQgY2hlY2tf
bGFzdF9wZWVyKHN0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2RlciAqY3hsZWQsCi0JCQkgICBzdHJ1
Y3QgY3hsX2VwICplcCwgc3RydWN0IGN4bF9yZWdpb25fcmVmICpjeGxfcnIsCi0JCQkgICBpbnQg
ZGlzdGFuY2UpCisJCQkgICBzdHJ1Y3QgY3hsX2VwICplcCwgc3RydWN0IGN4bF9yZWdpb25fcmVm
ICpjeGxfcnIpCiB7CiAJc3RydWN0IGN4bF9tZW1kZXYgKmN4bG1kID0gY3hsZWRfdG9fbWVtZGV2
KGN4bGVkKTsKKwlpbnQgc3dpdGNoX2l3ID0gY3hsX3JyLT5kZWNvZGVyLT5pbnRlcmxlYXZlX3dh
eXM7CiAJc3RydWN0IGN4bF9yZWdpb24gKmN4bHIgPSBjeGxfcnItPnJlZ2lvbjsKIAlzdHJ1Y3Qg
Y3hsX3JlZ2lvbl9wYXJhbXMgKnAgPSAmY3hsci0+cGFyYW1zOwogCXN0cnVjdCBjeGxfZW5kcG9p
bnRfZGVjb2RlciAqY3hsZWRfcGVlcjsKQEAgLTEwNTcsMTYgKzEwNTcsMTYgQEAgc3RhdGljIGlu
dCBjaGVja19sYXN0X3BlZXIoc3RydWN0IGN4bF9lbmRwb2ludF9kZWNvZGVyICpjeGxlZCwKIAog
CS8qCiAJICogSWYgdGhpcyBwb3NpdGlvbiB3YW50cyB0byBzaGFyZSBhIGRwb3J0IHdpdGggdGhl
IGxhc3QgZW5kcG9pbnQgbWFwcGVkCi0JICogdGhlbiB0aGF0IGVuZHBvaW50LCBhdCBpbmRleCAn
cG9zaXRpb24gLSBkaXN0YW5jZScsIG11c3QgYWxzbyBiZQorCSAqIHRoZW4gdGhhdCBlbmRwb2lu
dCwgYXQgaW5kZXggJ3Bvc2l0aW9uIC0gc3dpdGNoX2l3JywgbXVzdCBhbHNvIGJlCiAJICogbWFw
cGVkIGJ5IHRoaXMgZHBvcnQuCiAJICovCi0JaWYgKHBvcyA8IGRpc3RhbmNlKSB7CisJaWYgKHBv
cyA8IHN3aXRjaF9pdykgewogCQlkZXZfZGJnKCZjeGxyLT5kZXYsICIlczolczogY2Fubm90IGhv
c3QgJXM6JXMgYXQgJWRcbiIsCiAJCQlkZXZfbmFtZShwb3J0LT51cG9ydF9kZXYpLCBkZXZfbmFt
ZSgmcG9ydC0+ZGV2KSwKIAkJCWRldl9uYW1lKCZjeGxtZC0+ZGV2KSwgZGV2X25hbWUoJmN4bGVk
LT5jeGxkLmRldiksIHBvcyk7CiAJCXJldHVybiAtRU5YSU87CiAJfQotCWN4bGVkX3BlZXIgPSBw
LT50YXJnZXRzW3BvcyAtIGRpc3RhbmNlXTsKKwljeGxlZF9wZWVyID0gcC0+dGFyZ2V0c1twb3Mg
LSBzd2l0Y2hfaXddOwogCWN4bG1kX3BlZXIgPSBjeGxlZF90b19tZW1kZXYoY3hsZWRfcGVlcik7
CiAJZXBfcGVlciA9IGN4bF9lcF9sb2FkKHBvcnQsIGN4bG1kX3BlZXIpOwogCWlmIChlcC0+ZHBv
cnQgIT0gZXBfcGVlci0+ZHBvcnQpIHsKQEAgLTExMTEsMjAgKzExMTEsMTcgQEAgc3RhdGljIGlu
dCBjeGxfcG9ydF9zZXR1cF90YXJnZXRzKHN0cnVjdCBjeGxfcG9ydCAqcG9ydCwKIAogCWN4bHNk
ID0gdG9fY3hsX3N3aXRjaF9kZWNvZGVyKCZjeGxkLT5kZXYpOwogCWlmIChjeGxfcnItPm5yX3Rh
cmdldHNfc2V0KSB7Ci0JCWludCBpLCBkaXN0YW5jZTsKKwkJaW50IGk7CiAKIAkJLyoKLQkJICog
UGFzc3Rocm91Z2ggZGVjb2RlcnMgaW1wb3NlIG5vIGRpc3RhbmNlIHJlcXVpcmVtZW50cyBiZXR3
ZWVuCi0JCSAqIHBlZXJzCisJCSAqIENoZWNrIGlmIHRoaXMgZW5kcG9pbnQncyBkcG9ydCBpcyBh
bHJlYWR5IGluIHRoZQorCQkgKiBzd2l0Y2ggZGVjb2RlcidzIHRhcmdldCBsaXN0LCBhbmQgaWYg
c28gY2hlY2sgdGhhdAorCQkgKiBpdCBpcyBwb3NpdGlvbmVkIGNvcnJlY3RseSBiYXNlZCBvbiB0
aGUgc3dpdGNoJ3MKKwkJICogaW50ZXJsZWF2ZS4KIAkJICovCi0JCWlmIChjeGxfcnItPm5yX3Rh
cmdldHMgPT0gMSkKLQkJCWRpc3RhbmNlID0gMDsKLQkJZWxzZQotCQkJZGlzdGFuY2UgPSBwLT5u
cl90YXJnZXRzIC8gY3hsX3JyLT5ucl90YXJnZXRzOwogCQlmb3IgKGkgPSAwOyBpIDwgY3hsX3Jy
LT5ucl90YXJnZXRzX3NldDsgaSsrKQogCQkJaWYgKGVwLT5kcG9ydCA9PSBjeGxzZC0+dGFyZ2V0
W2ldKSB7Ci0JCQkJcmMgPSBjaGVja19sYXN0X3BlZXIoY3hsZWQsIGVwLCBjeGxfcnIsCi0JCQkJ
CQkgICAgIGRpc3RhbmNlKTsKKwkJCQlyYyA9IGNoZWNrX2xhc3RfcGVlcihjeGxlZCwgZXAsIGN4
bF9ycik7CiAJCQkJaWYgKHJjKQogCQkJCQlyZXR1cm4gcmM7CiAJCQkJZ290byBvdXRfdGFyZ2V0
X3NldDsKCg==
