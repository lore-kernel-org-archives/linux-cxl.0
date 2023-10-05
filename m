Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88817E7AD45
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Oct 2023 17:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjJERHp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjJERG0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Oct 2023 13:06:26 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3D4226
        for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 09:52:22 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231005165218usoutp01c065a2fe07eeb4b72a256e54fd4cf7a1~LRELLYD1w0169801698usoutp01J;
        Thu,  5 Oct 2023 16:52:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231005165218usoutp01c065a2fe07eeb4b72a256e54fd4cf7a1~LRELLYD1w0169801698usoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696524738;
        bh=w+V2gzCDmhGgrHf+2RMdoL/lJHJZT1RYD3wNOOPVRaA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=sjpHv32ZlqSmWX0siArlU4JV8LITc8muXWrCLRfylr7NQjb/0/aljbiYd0YpbXNBa
         RHRaXPgeBXqblgr5/lrQQnfuWgNQlPzRtTpxE8NimGo6emAJzH8VnhY9feQg+d/UFS
         1bnebnDMXufxE+BtrgL+VpM4SJzIadk9NW1u2nyo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231005165218uscas1p149dc85382f94d815bd5603e875a285f3~LRELHPg_R2040020400uscas1p1M;
        Thu,  5 Oct 2023 16:52:18 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 63.C0.40279.2C9EE156; Thu, 
        5 Oct 2023 12:52:18 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231005165218uscas1p112a19c154b62de08ad06e10ed228b759~LREK7Um4D1985019850uscas1p1L;
        Thu,  5 Oct 2023 16:52:18 +0000 (GMT)
X-AuditID: cbfec36f-241ff70000009d57-4b-651ee9c2a8e1
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 5B.F1.31200.1C9EE156; Thu, 
        5 Oct 2023 12:52:17 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 5 Oct 2023 09:52:17 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        5 Oct 2023 09:52:17 -0700
From:   Jim Harris <jim.harris@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jim Harris <jim.harris@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: set root decoder granularity based on region
 params
Thread-Topic: [PATCH] cxl: set root decoder granularity based on region
        params
Thread-Index: AQHZ9xetppHioUpJEUacMqps7+5BAbA62tGAgAEE4wA=
Date:   Thu, 5 Oct 2023 16:52:17 +0000
Message-ID: <A9AA55AC-F925-4B7F-866B-7AB849CB6F36@ssi.samsung.com>
In-Reply-To: <651e0eddb7f6c_ae7e72946c@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B47786BCE8E3AA448556C4F24B9F7CE7@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djX87qHXsqlGiz8y2UxfeoFRovzs06x
        ODB5LN7zksnj8ya5AKYoLpuU1JzMstQifbsEroyul6fZCuaJVUxe84i1gfGKaBcjJ4eEgInE
        n7/v2LoYuTiEBFYySsxo/s0K4bQySbyb08cIU7Vj7myoxFpGie3Pf7JDOB8ZJR6fn8QCUiUk
        sJRR4uhcCxCbTUBT4teVNUwgtoiAtsTEOQeZQWxmgSSJ19ObwOqFBfwlnnefZYGoCZDou3eQ
        DcK2kvi3YglQLwcHi4CKxMyLOSBhXgEniStv2sDGcAp4SvzbNpEdxGYUEJP4fgpiFbOAuMSt
        J/OZII4WlFg0ew8zhC0m8W/XQzYIW1Hi/veX7CDjmYHOXL9LH6LVTuLEuwZ2CFtRYkr3Q3aI
        tYISJ2c+YYFolZQ4uOIGlD2XQ2Lz8ngI20Xiwaw37BC2tMTfu8ugTsiWWLm+A+wTCYECiYYj
        QRBha4mFf9YzTWBUmYXk6FkIB81CctAsJAfNQnLQAkbWVYzipcXFuempxUZ5qeV6xYm5xaV5
        6XrJ+bmbGIFp5PS/w/k7GK/f+qh3iJGJg/EQowQHs5IIb3qDTKoQb0piZVVqUX58UWlOavEh
        RmkOFiVxXkPbk8lCAumJJanZqakFqUUwWSYOTqkGppCmI1/N1Rt0ONS0rNf5P5m2Ouv8jQXr
        vxp+KZj/OSLldJQozx7NiZWOPg8frhVYweLxJOtm9BJ5YftF+zS+qC4WcCiQKfkvZ5nEM9Gq
        VIEpUfB7/o+Cz2bb3QsbKoLlVXoNJzXNt2s3ati9ietjxg53R6aHty5zs3jMn7Hv3oL9Usax
        D+aVW2w8ebNslTtPmvxZK8/YFA9bi11ezgbmxmt0pzH/nSsjHfXC1UBftV5/Zpa1lrr9lckW
        E406DJR9GFlc16+z8+r7e9Ti5sFDLonzz7lay2r/smnsN3o3K/bOLvfCQ1mr2F599D2qbPLq
        xLyvF6b96OKd4aO96TrjxZpzXy092KelKDZNeHxFiaU4I9FQi7moOBEAJZn7BZIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWS2cA0UffgS7lUgyn/LC2mT73AaHF+1ikW
        ByaPxXteMnl83iQXwBTFZZOSmpNZllqkb5fAldH18jRbwTyxislrHrE2MF4R7WLk5JAQMJHY
        MXc2axcjF4eQwGpGiZ+vb7FBOB8ZJb7+mMYI4SxllLh7dg8TSAubgKbErytrwGwRAW2JiXMO
        MoPYzAJJEq+nN7GA2MICvhKTj5xlg6jxk1j3ohXKtpL4t2IJUC8HB4uAisTMizkgYV4BJ4kr
        b9qYIXa9Y5Q4dKobbD6ngKfEv20T2UFsRgExie+nIPYyC4hL3HoynwniBQGJJXvOM0PYohIv
        H/9jhbAVJe5/f8kOsosZ6Ob1u/QhWu0kTrxrYIewFSWmdD9kh7hBUOLkzCcsEK2SEgdX3GCZ
        wCgxC8m2WQiTZiGZNAvJpFlIJi1gZF3FKF5aXJybXlFslJdarlecmFtcmpeul5yfu4kRGImn
        /x2O3sF4+9ZHvUOMTByMhxglOJiVRHjTG2RShXhTEiurUovy44tKc1KLDzFKc7AoifPumHIx
        RUggPbEkNTs1tSC1CCbLxMEp1cCU/DU5xjh0g8JlLb9lnTccTFa95+Z8JP3pqeoWzXrWc4nz
        n2bv3SHHq+745dVmkxo3Xte7itn3dVIPik41lVYx2ZkcEOQSXuw1+1rZtqD9BR65eVLJD1sF
        vn/c8VRkkhf7onMPvry9s49h+7TFQkqRjctFDab8vczpVHyJ6yBXyJSULJHq6iU9l2Ol9eO0
        yzwrRdjXSlkX+7b0SH/anvj8elNrbn7vgyJfy4vz+/8/uhM8vcVx3qSvK5fN7y187VOVK/3K
        wK7lzaWsTkXOWU1z01dMeXQi/0tgOYOu2Qv7ty22Cx8v+bjn3V22hHmil8Q1nTa77Oev5wtZ
        +S9jr2N6oHCDjaCnk8bvL/+6nymxFGckGmoxFxUnAgBhXYqFMwMAAA==
X-CMS-MailID: 20231005165218uscas1p112a19c154b62de08ad06e10ed228b759
CMS-TYPE: 301P
X-CMS-RootMailID: 20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f
References: <CGME20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f@uscas1p2.samsung.com>
        <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
        <651e0eddb7f6c_ae7e72946c@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

DQoNCj4gT24gT2N0IDQsIDIwMjMsIGF0IDY6MTjigK9QTSwgRGFuIFdpbGxpYW1zIDxkYW4uai53
aWxsaWFtc0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gSmltIEhhcnJpcyB3cm90ZToNCj4+IA0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgYi9kcml2ZXJzL2N4bC9j
b3JlL3JlZ2lvbi5jDQo+PiBpbmRleCA2ZDYzYjg3OThjMjkuLmYxNDExMGUzNWY3OSAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4+ICsrKyBiL2RyaXZlcnMvY3hs
L2NvcmUvcmVnaW9uLmMNCj4+IEBAIC0xNjkxLDYgKzE2OTEsMTEgQEAgc3RhdGljIGludCBjeGxf
cmVnaW9uX2F0dGFjaChzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciwNCj4+IHJldHVybiAtRUlOVkFM
Ow0KPj4gfQ0KPj4gDQo+PiArIC8qIFNldCByb290IGRlY29kZXIncyBncmFudWxhcml0eSBub3cs
IHNvIHRoYXQgd2UgY2FuIHVzZSBpdCB0byBjYWxjdWxhdGUNCj4+ICsgKiBncmFudWxhcml0eSBm
b3IgdGhlIGRvd25zdHJlYW0gdGFyZ2V0cyBpbiBjeGxfcmVnaW9uX3NldHVwX3RhcmdldHMoKS4N
Cj4+ICsgKi8NCj4gDQo+IE1pbm9yLCBhbmQgSSBtZWFuIG1pbm9yLCBuaXQsIHRoZSBjeGwgc3Vi
c3lzdGVtIGlzIHVzaW5nOg0KPiANCj4gLyoNCj4gKiBDb21tZW50Li4uDQo+ICovDQo+IA0KPiAu
Li5ibG9jay1jb21tZW50IHN0eWxlLiBZZXMsIGl0IHZhcmllcyBhY3Jvc3Mgc3Vic3lzdGVtcywg
eWVzIGl0J3MNCj4gYXJiaXRyYXJ5LCBidXQgZ2VuZXJhbCBydWxlIGlzIGZvbGxvdyBsb2NhbCBj
dXN0b21zLg0KDQpBY2suDQoNCj4+ICsgY3hscmQtPmN4bHNkLmN4bGQuaW50ZXJsZWF2ZV9ncmFu
dWxhcml0eSA9IGN4bHItPnBhcmFtcy5pbnRlcmxlYXZlX2dyYW51bGFyaXR5Ow0KPj4gKw0KPiAN
Cj4gU28gSSB0aGluayB0aGlzIGlzIG9ubHkgdmFsaWQgaW4gdGhlIGN4bHJkLT5jeGxzZC5jeGxk
LmludGVybGVhdmVfd2F5cyA9PSAxDQo+IGNhc2UgYXMgaW50ZXJsZWF2ZV9ncmFudWxhcml0eV9z
dG9yZSgpIGZvcmJpZHMgcmVnaW9ucyB0aGF0IGRvIG5vdCBtYXRjaA0KPiB0aGUgZ3JhbnVsYXJp
dHkgb2YgdGhlIHJvb3QuDQoNClRoYXTigJlzIGNvcnJlY3QuIEFuZCBub3cgSSB0aGluayBpdOKA
mXMgYmV0dGVyIHRvIHB1dCB0aGlzIGFzc2lnbm1lbnQgaW4NCmludGVybGVhdmVfZ3JhbnVsYXJp
dHlfc3RvcmUoKSBpbnN0ZWFkIHNpbmNlIHdlIGFyZSBhbHJlYWR5IGRvaW5nDQpyb290IGRlY29k
ZXIgcmVsYXRlZCBjaGVja2luZyB0aGVyZSwgYW5kIHdlIHdvdWxkIHRoZW4ganVzdCBiZSBzZXR0
aW5nDQp0aGlzIGdyYW51bGFyaXR5IG9uY2UgaW5zdGVhZCBvZiBvbmNlIHBlciBtZW1kZXYuDQoN
Cj4gSWYgYSBCSU9TIHRyaWVzIHRvIHNoaXAgc3VjaCBhIGNvbmZpZyBpbiBwcm9kdWN0aW9uIHRo
YXQncyB3aGVuIEkgZXhwZWN0DQo+IHRoYXQgcG9saWN5IG5lZWRzIHRvIGJlIHJldmlzaXRlZCwg
YnV0IG91dHNpZGUgb2YgYmVpbmcgZm9yY2VkIHRvDQo+IHJlY29uc2lkZXIgdGhhdCBzdGFuY2Ug
dGhlIGNvbXBsZXhpdHkgcmVkdWN0aW9uIGlzIHRoZSBiZW5lZml0Lg0KPiANCj4gSW4gdGhlIG1l
YW50aW1lIG1heWJlIGFkZCBhbiAiZWZmZWN0aXZlIGdyYW51bGFyaXR5IiBjb25jZXB0IGZvciB4
MSByb290DQo+IGRlY29kZXJzIGFuZCB4MSBzd2l0Y2hlcyBzbyB0aGUgbWF0aCBjYW4gdXNlIHRo
YXQgdmFsdWU/DQoNCkFjay4gVXNlIOKAnGVmZmVjdGl2ZV9ncmFudWxhcml0eeKAnSAoRUcpIGZv
ciB0aGUgdG9wb2xvZ3kgbWF0aCBhbmQNCuKAnGludGVybGVhdmVfZ3JhbnVsYXJpdHnigJ0gKElH
KSBmb3IgcHJvZ3JhbW1pbmcgdGhlIGRlY29kZXJzLg0KDQpGb3IgdGhlIHgxIHN3aXRjaGVzLCBp
cyB5b3VyIGludGVudCBoZXJlIHRvIHNldCBJRyA9IDI1NiBzaW5jZSB0aGUgSUcgaXMNCnJlYWxs
eSBhIGRvbuKAmXQgY2FyZSBmcm9tIHRoZSBkZWNvZGVy4oCZcyBwZXJzcGVjdGl2ZT8gT3IgaXMg
dGhlcmUgYW5vdGhlcg0KcmVhc29uIHdlIHdvdWxkIG5lZWQgdG8gdHJhY2sgZGlmZmVyZW50IElH
IHYuIEVHIGZvciB4MSBzd2l0Y2hlcz8NCg0K
