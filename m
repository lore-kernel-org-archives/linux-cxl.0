Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E885C0015E
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 16:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjGYQ5I (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 12:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGYQ5H (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 12:57:07 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD021BE2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 09:57:02 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230725164643usoutp0190464a548ca591680819b8fade554011~1KivowJm51673316733usoutp01g;
        Tue, 25 Jul 2023 16:46:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230725164643usoutp0190464a548ca591680819b8fade554011~1KivowJm51673316733usoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690303603;
        bh=NtC7E3IsPPbWZ4bZyL31hB+sue0UH1FsmMZSovhBk8k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=oiCrKwacxdXTuBRCnSXvpgBYXWTSezB39FOnijDOMka+vDOxnn8VQoiKJSZ8W6Ov8
         tR9PmCtiyWqtUVK6d61Fm/i9qjkJQSE97btlKINQ6DMymBV9HTkp5tMDXnhWTn6mDi
         MzeSxJNllwf6ZvFRXtQ9GpJSCZzmS84cIpcuaUNA=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725164643uscas1p163da737305def4399ef8338fc3e8f1e8~1Kivg4Urd0668006680uscas1p1H;
        Tue, 25 Jul 2023 16:46:43 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id D8.0F.42611.27CFFB46; Tue,
        25 Jul 2023 12:46:42 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230725164642uscas1p28f95804a99db81ad000c5264f4d5d64d~1KivMCDbE2394423944uscas1p2k;
        Tue, 25 Jul 2023 16:46:42 +0000 (GMT)
X-AuditID: cbfec36f-249ff7000000a673-e6-64bffc72ebc1
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 27.12.38326.27CFFB46; Tue,
        25 Jul 2023 12:46:42 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 25 Jul 2023 09:46:41 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        25 Jul 2023 09:46:41 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK/KEtMAgAFwkACAABi5gA==
Date:   Tue, 25 Jul 2023 16:46:41 +0000
Message-ID: <20230725164633.GA2317647@bgt-140510-bm03>
In-Reply-To: <64bfe7b090843_12757b2945b@iweiny-mobl.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <47A323B06A1BED4EBF5A991C166C9338@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djXc7pFf/anGDyYZWPRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8a2z7MYC86pVyx6s5+1gfGMWhcjJ4eEgInEle+rWbsYuTiEBFYySsydsYMFwmll
        kmi6cJoVpmrr7OfsEIm1jBJ9TzeyQTifGCXaVm9hhnCWMUpcP/WCDaSFTUBRYl/XdjBbREBZ
        4vS/q2AdzAJXWCSuT13HBJIQFnCWmLz8BGMXIwdQkYvEpWd+EPVOEif2n2QEsVkEVCXuXXvE
        BFLCK2Am0b+0BCTMKWAjsfXEMbDxjAJiEt9PrQGbyCwgLnHryXwmiKsFJRbN3sMMYYtJ/Nv1
        kA3CVpS4//0lO8hIZgFNifW79CFa7STaLj1lh7AVJaZ0PwSzeYHGnJz5hAWiVVLi4IobUPZs
        TomXH81AxkgAHb9prwFEWFri6vWpzBDhZIlVH7kgwjkS85dsgeq0llj4Zz3TBEaVWUhunoVw
        zywk98xCcs8sJPcsYGRdxSheWlycm55abJSXWq5XnJhbXJqXrpecn7uJEZjsTv87nL+D8fqt
        j3qHGJk4GA8xSnAwK4nwGsbsSxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOa2h7MllIID2xJDU7
        NbUgtQgmy8TBKdXAxLjS4uE31SRu6a2OjYYP3YLXdiWdE3l8Tpq3QvL9hN6Uf00u8Q7pmya+
        9ZxkZ3tkw0R9V73g3rtW8/sbHIoKWs7pZf3c6rzoqemMV5xHt4gtNV+351Wj2OOwRXts2c+m
        Hbk6y2zbHotvP71XMDi3BcjxdKjIPX1eyjbfJq+4zsVJ4s7UqX8MxJT1D15cuy2G1byguWNz
        XJrKXmGbFeuqYo8+PczUFljcMaP63rv+Sj37qHmlR71CArQc/tr673l/9Huj55mEBaonD8ro
        rBSZf+XMwa0XdvMl5pRLvbrgHhG8ZcUyPsWNPzetXOfj07L58Lk9N3jE/cSWa5ktTldYtSM9
        0PPW1c4C/5xe3UkvlFiKMxINtZiLihMBk+pu7+UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWS2cA0Ubfoz/4Ugy2nVC26z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgytj2eRZjwTn1ikVv9rM2MJ5R62Lk5JAQMJHYOvs5excjF4eQwGpGiabTC1kgnE+M
        EufOT4ByljFK3NzaygrSwiagKLGvazsbiC0ioCxx+t9VNpAiZoErLBLXp65jAkkICzhLTF5+
        grGLkQOoyEXi0jM/iHoniRP7TzKC2CwCqhL3rj1iAinhFTCT6F9aArHrNaPErasHwHZxCthI
        bD1xDGwXo4CYxPdTa8DGMwuIS9x6Mp8J4gUBiSV7zjND2KISLx//Y4WwFSXuf3/JDjKfWUBT
        Yv0ufYhWO4m2S0/ZIWxFiSndD8FsXgFBiZMzn7BAtEpKHFxxg2UCo8QsJNtmIUyahWTSLCST
        ZiGZtICRdRWjeGlxcW56RbFhXmq5XnFibnFpXrpecn7uJkZgujj973DkDsajtz7qHWJk4mA8
        xCjBwawkwmsYsy9FiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+Q68R4IYH0xJLU7NTUgtQimCwT
        B6dUA9Ok6D3+21LU+1msz7N8m/PdfJ4h+459U74nLU+eJGg28VZIM+fCCcbxKcqMl2uKj7qY
        hfyxvHMjKr5+q+KDWu1jlnYl0/ZetDvwdNL99xy7beYff7U/T0Kk8eqNCS7tzkVqy9XO8qy3
        MqwSb+gQ01exEjPuWP9LeMlU3evzrn/LEVnFvuqaUIGih9pFs+KDDA+8e/0XHvHoDcx7+2iq
        Qzs/20PlWTPCnB2LVuTzcv9yCb05PcHosQBba6LA4qm5zf/v/3L8uGKDXpzKoekVnME+9XEP
        jh4rzvwk+SmzoqfgcfGrxrMX0jn7060fKGTPlrUTetq++86TZ4aZ5pM9QmOFl5cZf1s1Q6/r
        K/+5XUosxRmJhlrMRcWJAHgqyD+GAwAA
X-CMS-MailID: 20230725164642uscas1p28f95804a99db81ad000c5264f4d5d64d
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
        <20230511175609.2091136-1-fan.ni@samsung.com>
        <20230724171857.GA329893@bgt-140510-bm03>
        <64bfe7b090843_12757b2945b@iweiny-mobl.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMDg6MTg6MDhBTSAtMDcwMCwgSXJhIFdlaW55IHdyb3Rl
Og0KDQo+IEZhbiBOaSB3cm90ZToNCj4gPiBPbiBUaHUsIE1heSAxMSwgMjAyMyBhdCAwNTo1Njo0
MFBNICswMDAwLCBGYW4gTmkgd3JvdGU6DQo+ID4gDQo+ID4gRllJLg0KPiA+IA0KPiA+IEkgaGF2
ZSB1cGRhdGVkIHRoZSBwYXRjaCBzZXJpZXMgYW5kIHNlbnQgb3V0IGFnYWluLg0KPiA+IA0KPiA+
IEkgc3VnZ2VzdGVkIGFueW9uZSB3aG8gYXJlIGludGVyZXN0ZWQgaW4gRENEIGFuZCB1c2luZyB0
aGlzIHBhdGNoIHNlcmllcyB0bw0KPiA+IHVzZSB0aGUgbmV3IHNlcmllcy4gUXVpdGUgYSBmZXcg
dGhpbmdzIGhhcyBiZWVuIGZpeGVkLg0KPiA+IA0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMjAyMzA3MjQxNjIzMTMuMzQx
OTYtMS1mYW4ubmlAc2Ftc3VuZy5jb20vVC8qdF9fO0l3ISFFd1Z6cUdvVEtCcXYtMERXQUpCbSFW
OGtEVHBUNXlMVUF5V20zc0ZtN1hJZ04wUWROVXlRWVpkOXZZTEhqVVZrTWtoRFQxNEY4YXZnTkJo
MjNLUEF0c1NfZEdtMkxadUhKMTAybWdJZyQgDQo+ID4gDQo+ID4gQWxzbywgaWYgeW91IHdhbnQg
dG8gdXNlIHRoZSBjb2RlIHJlcG8gZGlyZWN0bHksIHlvdSBjYW4gdHJ5DQo+ID4gDQo+ID4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcHJvdGVjdDIuZmlyZWV5ZS5jb20vdjEv
dXJsP2s9MDYwMGZkNmItNjc4YmU4MjAtMDYwMTc2MjQtNzRmZTQ4NWZiMzA1LWY1MjkyNzkwNjJi
MDJiNzMmcT0xJmU9NWRmNjUwMTAtZTYyZi00MGExLTlhMjEtNjA5ZWIxNDAwOTIxJnU9aHR0cHMq
M0EqMkYqMkZnaXRodWIuY29tKjJGbW9raW5nKjJGcWVtdS1kY2QtcHJldmlldy1sYXRlc3QqMkZ0
cmVlKjJGZGNkLWRldl9fO0pTVWxKU1VsSlEhIUV3VnpxR29US0Jxdi0wRFdBSkJtIVY4a0RUcFQ1
eUxVQXlXbTNzRm03WElnTjBRZE5VeVFZWmQ5dllMSGpVVmtNa2hEVDE0RjhhdmdOQmgyM0tQQXRz
U19kR20yTFp1SEpwQjBTbU5zJCANCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGJyYW5jaCENCj4gDQo+
IEkgdG9vayBhIHF1aWNrIGxvb2sgYW5kIEkgZG9uJ3Qgc2VlIGEgcmVzb2x1dGlvbiB0byB0aGUg
cHJvYmxlbSBJDQo+IG1lbnRpb25lZCB3aXRoIG5vbiBEQ0QgZGV2aWNlcyBiZWluZyBzdXBwb3J0
ZWQuWzFdDQo+IA0KPiBbMV0gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC82NDgzOTQ2ZTgxNTJmX2YxMTMyMjk0YTJAaXdlaW55LW1vYmwubm90
bXVjaC9fXzshIUV3VnpxR29US0Jxdi0wRFdBSkJtIVY4a0RUcFQ1eUxVQXlXbTNzRm03WElnTjBR
ZE5VeVFZWmQ5dllMSGpVVmtNa2hEVDE0RjhhdmdOQmgyM0tQQXRzU19kR20yTFp1SEo0Z2VTRUFn
JCANCj4gDQo+IERpZCB5b3UgZml4IHRoaXMgaW4gYSBkaWZmZXJlbnQgd2F5PyAgSWYgSSBkb24n
dCBhZGQgREMgdG8gbXkgbWVtIGRldmljZXMgdGhleQ0KPiBkb24ndCBnZXQgcHJvYmVkIHByb3Bl
cmx5LiAgSSdtIHN0aWxsIGxvb2tpbmcgaW50byB0aGlzIHdpdGggeW91ciBuZXcgYnJhbmNoLA0K
PiBidXQgSSBkb24ndCB0aGluayBEQyBjb21tYW5kcyBzaG91bGQgYmUgaW4gdGhlIENFTCBpZiB0
aGUgZGV2aWNlIGRvZXMgbm90DQo+IHN1cHBvcnQgaXQuDQo+IA0KPiBBbHNvIEkgZ2V0IGEgYnVp
bGQgd2FybmluZyBvbiB0aGlzIGJyYW5jaCBJIGhhZCB0byBmaXhbM10gYXMgbXkgYnVpbGQgaXMN
Cj4gdHJlYXRpbmcgd2FybmluZ3MgYXMgZXJyb3JzLlsyXQ0KPiANCj4gSSBkb24ndCB0aGluayB0
aGlzIGZpeCBpcyB0ZWNobmljYWxseSBuZWNlc3NhcnkgYXMgJ2xpc3QnIHNob3VsZCBuZXZlciBi
ZSBOVUxMDQo+IHRoYXQgSSBjYW4gc2VlLiAgQnV0IG1pZ2h0IGJlIG5pY2UgdG8gY2hlY2sgb3Ig
anVzdCB1c2UgbXkgZml4Lg0KPiANCj4gSSdsbCB0cnkgYW5kIGdldCB0byBhIHJldmlldyBvbmNl
IEkgZ2V0IHRoZSBEQ0Qgc3R1ZmYgb3V0IG9uIHRoZSBsaXN0IGFnYWluLg0KPiANCj4gSXJhDQo+
IA0KDQpPaCwgSSBtaXNzZWQgeW91ciBwcmV2aW91cyBjb21tZW50cywgbGV0IG1lIGxvb2sgaW50
byBpdCBhbmQgZml4DQphY2NvcmRpbmdseSBhbmQgc2VuZCBvdXQgYSBuZXcgdmVyc2lvbi4NCg0K
QnR3LCB3aGVuIEkgZGlkIHRoZSBEQ0QgdGVzdCB3aXRoIHRoZSBsYXN0IERDRCBrZXJuZWwgY29k
ZSwgSSBmb3VuZA0Kc29tZSBpc3N1ZSB0aGVyZS4NCg0KV2hlbiBJIGFkZCBhIERDRCBleHRlbnQg
Zm9yIHRoZSBmaXJzdCB0aW1lLCBpdCB3aWxsIGJlIHJlY29nbml6ZWQgYXMNCnN5c3RlbSBSQU0g
YXV0b21hdGljYWxseSBhbmQgc2hvdyB1cCB3aXRoIGNvbW1hbmQgbHNtZW0uDQoNCkhvd2V2ZXIs
IHdoZW4gSSByZWxlYXNlIGl0IGFuZCB0cnkgdG8gcmUtYWRkIHRoZSBzYW1lIGV4dGVudCBhZ2Fp
bi4NClRoZSBhZGRpbmcgc2VlbXMgbm9ybWFsIGFuZCB0aGUgZGV2aWNlIHdpbGwgc2hvdyB1cCB1
bmRlciAvZGV2LyBhcw0KZGF4MC5YLiBCdXQgaXQgd2lsbCBub3Qgc2hvdyB1cCB3aXRoIGxzbWVt
IGNvbW1hbmQgYW5kIEkgaGF2ZSB0byB1c2UNCmRheGN0bCByZWNvbmZpZ3VyZSBjb21tYW5kIHRv
IHR1cm4gaXQgdG8gc3lzdGVtIHJhbSBhbmQgdGhlbiBpdCBjYW4NCnNob3cgdXAgd2l0aCBsc21l
bSBjb21tYW5kLiBJIHdvdWxkIGV4cGVjdCB0aGUgYmVoYXZpb3IgZm9yIHRoZQ0KZmlyc3QgYWRk
IGFuZCBzZWNvbmQgYWRkIGJlIHRoZSBzYW1lLg0KDQpGYW4uDQoNCg0KPiANCj4gWzJdDQo+IC4u
L2h3L21lbS9jeGxfdHlwZTMuYzogSW4gZnVuY3Rpb24g4oCYcW1wX2N4bF9wcm9jZXNzX2R5bmFt
aWNfY2FwYWNpdHlfZXZlbnQuY29uc3Rwcm9w4oCZOg0KPiAuLi9ody9tZW0vY3hsX3R5cGUzLmM6
MjA2MzoyODogZXJyb3I6IOKAmHJpZOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIFstV2Vy
cm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ICAyMDYzIHwgICAgIGRDYXAudXBkYXRlZF9yZWdp
b25faWQgPSByaWQ7DQo+ICAgICAgIHwgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Xn5+fn4N
Cj4gLi4vaHcvbWVtL2N4bF90eXBlMy5jOjE5ODc6MTM6IG5vdGU6IOKAmHJpZOKAmSB3YXMgZGVj
bGFyZWQgaGVyZQ0KPiAgMTk4NyB8ICAgICB1aW50OF90IHJpZDsNCj4gICAgICAgfCAgICAgICAg
ICAgICBefn4NCj4gY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4g
DQo+IFszXQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L21lbS9jeGxfdHlwZTMuYyBiL2h3L21lbS9j
eGxfdHlwZTMuYw0KPiBpbmRleCBlNjczMjg3ODA0MDcuLmQyNWU2MDY0ZjZjOSAxMDA2NDQNCj4g
LS0tIGEvaHcvbWVtL2N4bF90eXBlMy5jDQo+ICsrKyBiL2h3L21lbS9jeGxfdHlwZTMuYw0KPiBA
QCAtMTk4NCw3ICsxOTg0LDcgQEAgc3RhdGljIHZvaWQgcW1wX2N4bF9wcm9jZXNzX2R5bmFtaWNf
Y2FwYWNpdHlfZXZlbnQoY29uc3QgY2hhciAqcGF0aCwNCj4gICAgICBDWExEQ0V4dGVudFJlY29y
ZExpc3QgKmxpc3QgPSByZWNvcmRzOw0KPiAgICAgIENYTERDRXh0ZW50X3JhdyAqZXh0ZW50czsN
Cj4gICAgICB1aW50NjRfdCBkcGEsIGxlbjsNCj4gLSAgICB1aW50OF90IHJpZDsNCj4gKyAgICB1
aW50OF90IHJpZCA9IDA7DQo+ICAgICAgaW50IGk7DQo+ICANCj4gICAgICBpZiAoIW9iaikgew==
