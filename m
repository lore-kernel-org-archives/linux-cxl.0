Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D928685
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gOo+kGgJ"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1634E9E
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 09:22:01 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231006162200usoutp0249d246864cc42763ec2e2897cbc62ae6~LkTAFhn002937729377usoutp02-
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 16:22:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231006162200usoutp0249d246864cc42763ec2e2897cbc62ae6~LkTAFhn002937729377usoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1696609320;
	bh=m+7lNOVrTM41r4nKf3Mtqzz4slqL3SQUg/PU5tWzNyw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gOo+kGgJP/5T/b6xsm5o7+R0aVBk28Jk3loXQZNT1JcFdV+fCvTZ0F7p1Vf0rV3rr
	 m+k2ugSBW8H9Rj2BdpjwYHurc32vGrWT04tnrrad5etBpF106zYbm4ikQGQU9EQf99
	 oZ5udrfGDjIrSLFcOC3igS9TmDrJzou3kkd+5H2o=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231006162159uscas1p1851542549bf73833123e7664572e87b4~LkS--gBzj0210602106uscas1p1g
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 16:21:59 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 73.21.50148.72430256; Fri, 
	6 Oct 2023 12:21:59 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231006162159uscas1p2b3ca1cd7a8371c20ac30b38cd70d65e7~LkS-qn_Pj1602216022uscas1p2i
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 16:21:59 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-fb-6520342786af
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 30.DB.31410.72430256; Fri, 
	6 Oct 2023 12:21:59 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 6 Oct 2023 09:21:58 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	6 Oct 2023 09:21:58 -0700
From: Jim Harris <jim.harris@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: [PATCH] cxl/region: use region (not root decoder) granularity for
 calculations
Thread-Topic: [PATCH] cxl/region: use region (not root decoder) granularity
	for calculations
Thread-Index: AQHZ+HE60VRkQwelP0mqMgNoFwajUg==
Date: Fri, 6 Oct 2023 16:21:58 +0000
Message-ID: <169660931834.684402.2774329392272976121.stgit@bgt-140510-bm03.eng.stellus.in>
In-Reply-To: <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <704F5F7021D6FF4596348A4EB43D0104@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djX87rqJgqpBpdmG1ucn3WKxYHR4/Mm
	uQDGKC6blNSczLLUIn27BK6MJZeuMRWsEanYebOPqYHxhXAXIyeHhICJxPPDE1m6GLk4hARW
	Mko8fLqQDcJZyiTx4ddEpi5GDrCqCZctIeJrGSXaXy9ih3A+Mkp8WbwZpoNRYmVzGwvIXDYB
	TYlfV9YwgdgiAtYSExqWsIHYwgKREleWvmOEiMdJfJ/2lQ3C1pPoXgVhswioSMx6ugtsDq9A
	lMS7R0fA4pwCMRJ9rY1gMxkFxCS+n4KYzywgLnHryXwmiH8EJRbN3sMMYYtJ/Nv1kA3CVpS4
	//0lO8g3zEC3rd+lD9FqJ/F50VpWCFtRYkr3Q3aItYISJ2c+YYFolZQ4uOIGOIgkBP6yS5y7
	tosdIuEicevTUyhbWmL6mstQDdkSK9d3QEOuQKLhSBBE2Fpi4Z/1UCfzSfz99YhxAqPyLCQf
	zEK4bhaS62YhuW4WkusWMLKuYhQvLS7OTU8tNsxLLdcrTswtLs1L10vOz93ECEwbp/8dzt3B
	uOPWR71DjEwcjIcYJTiYlUR40xtkUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGtqeTBYSSE8s
	Sc1OTS1ILYLJMnFwSjUwiVflJDJt/mh38MksN/WMJTdUnP9eEIw+rrvQP2inshaDi0zXh4jl
	M+f8Flpv+CQtUvOA7d/Kj0tXJ52ftFe95sl+9oRnrXOnJ6nc0H6ofnWZo5TthLcr1F62/a33
	/vgjIMHbbtOerSdXfz5iHvXJ1Cn/8K8tk0V2+qeabdEuafq8sSD91QvL3we3VvnvWSZ7KKng
	RY2Bzbfl3261tl07qOe8j/X2r2cZAdfC5s/w/54847tizmbmQskV/UrzP+6yO/j4Ykf7nKY4
	3xMZ6gm3jdaoXJqvIs1r4GfnceUO74+FUdlP1qgHxS6yexQ9/d6tHc0NAQJCjznW1RyrP/5W
	+3Cei3tF5QP5vRa6W9+ESiqxFGckGmoxFxUnAgA3KjCiigMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LJbGCapKtuopBq8Ou1lMX5WadYHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4MpYcukaU8EakYqdN/uYGhhfCHcxcnBICJhITLhs2cXIxSEksJpR
	YsaZz0wQzkdGidOfvkM5SxklnrZcZOli5ORgE9CU+HVlDROILSJgLTGhYQkbiC0sEClxZek7
	Roh4nMSX3wehbD2J7lVfwWpYBFQkZj3dBTaHVyBK4t2jI2BxIYFoiQVv+sBmcgrESPS1NoLZ
	jAJiEt9PQexiFhCXuPVkPpgtISAgsWTPeWYIW1Ti5eN/rBC2osT97y/ZQT5jBrpz/S59iFY7
	ic+L1rJC2IoSU7ofskOcIChxcuYTFohWSYmDK26wTGAUn4Vk2yyESbOQTJqFZNIsJJMWMLKu
	YhQvLS7OTa8oNs5LLdcrTswtLs1L10vOz93ECIyt0/8Ox+xgvHfro94hRiYOxkOMEhzMSiK8
	6Q0yqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5d0y5mCIkkJ5YkpqdmlqQWgSTZeLglGpgqhVi
	sDGesGSHEb+48r/q++uzm49rq//f2zp70XKB4xcutZ1y3bvZ/9+UP2kfD1tbeZa2neDvfbem
	X1YpMeHX9JaT/98K3bK3Prh+zsxZVb9SSl+LPd4vuFajpGnK/G/r9JZPE/eUFD8qsMxw14G7
	m0KChPb5yGz60nG1XU632++nQ6JGVwqHaP7d04rGbz3sFHoD9h07qzoxV/7Lg9qlIl+2VX38
	WG/ud0dknt5F78UfeRzrfJ9PZj9/9vA9ixPBcWv3T5rLM8dFJbLYSKt9S45QdKJB/fsZjfrV
	dYvfRyhVqy9pzpv2mUvubn7zmYpfTgc7mawst52/dD736K2ZaV1Swhr9OjunpCfO+bH0jhJL
	cUaioRZzUXEiABtc02ccAwAA
X-CMS-MailID: 20231006162159uscas1p2b3ca1cd7a8371c20ac30b38cd70d65e7
CMS-TYPE: 301P
X-CMS-RootMailID: 20231006162159uscas1p2b3ca1cd7a8371c20ac30b38cd70d65e7
References: <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
	<CGME20231006162159uscas1p2b3ca1cd7a8371c20ac30b38cd70d65e7@uscas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
L2N4bC9jb3JlL3JlZ2lvbi5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24u
YyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKaW5kZXggNmQ2M2I4Nzk4YzI5Li43MGY3YzY2
ZWUyY2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKKysrIGIvZHJpdmVy
cy9jeGwvY29yZS9yZWdpb24uYwpAQCAtMTEzMyw3ICsxMTMzLDcgQEAgc3RhdGljIGludCBjeGxf
cG9ydF9zZXR1cF90YXJnZXRzKHN0cnVjdCBjeGxfcG9ydCAqcG9ydCwKIAl9CiAKIAlpZiAoaXNf
Y3hsX3Jvb3QocGFyZW50X3BvcnQpKSB7Ci0JCXBhcmVudF9pZyA9IGN4bHJkLT5jeGxzZC5jeGxk
LmludGVybGVhdmVfZ3JhbnVsYXJpdHk7CisJCXBhcmVudF9pZyA9IHAtPmludGVybGVhdmVfZ3Jh
bnVsYXJpdHk7CiAJCXBhcmVudF9pdyA9IGN4bHJkLT5jeGxzZC5jeGxkLmludGVybGVhdmVfd2F5
czsKIAkJLyoKIAkJICogRm9yIHB1cnBvc2VzIG9mIGFkZHJlc3MgYml0IHJvdXRpbmcsIHVzZSBw
b3dlci1vZi0yIG1hdGggZm9yCgo=
