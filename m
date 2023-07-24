Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1927C001B0
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 17:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGXRKm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXRKl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 13:10:41 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7311B5
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 10:10:40 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230724171039usoutp01b1edc941c4034e8f8030152c6db70903~03OW5iekD1650516505usoutp01K;
        Mon, 24 Jul 2023 17:10:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230724171039usoutp01b1edc941c4034e8f8030152c6db70903~03OW5iekD1650516505usoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690218639;
        bh=Kefdy5121WJVwE96vMv6Foex3igWv8Ke7hJcNTtL3wQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Hlt3uW30xVM3rXFmSHlb0IRySVr1rPdeXj2MRtbOlDw+tKACcI0EfijPW6wbmRHtR
         5ltplYFpM8urIxQzdAj9f/OYSjJ+x+2Xs545mNd0BGxMRhJRyvHaoMje3jMYV4XmFy
         4uPYleCfzttndQAkdWJbrax+vjhbZclqx5DszaRM=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724171039uscas1p2773940407dc8dcb567e29c5631faedfb~03OWuFvSy1858918589uscas1p2w;
        Mon, 24 Jul 2023 17:10:39 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 45.7C.51475.F80BEB46; Mon,
        24 Jul 2023 13:10:39 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724171038uscas1p14c970be6ede7bbdef7cb397d20ee034c~03OWd2VpA1514415144uscas1p1x;
        Mon, 24 Jul 2023 17:10:38 +0000 (GMT)
X-AuditID: cbfec36d-8a3ff7000001c913-ed-64beb08ff9e6
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id C1.7C.38326.E80BEB46; Mon,
        24 Jul 2023 13:10:38 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 24 Jul 2023 10:10:38 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        24 Jul 2023 10:10:38 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: DCD region base address
Thread-Topic: DCD region base address
Thread-Index: AQHZvlHER+kTtfPgmE2GYmmetiymAg==
Date:   Mon, 24 Jul 2023 17:10:37 +0000
Message-ID: <20230724171029.GA301516@bgt-140510-bm03>
In-Reply-To: <20230724100342.00005c7b@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <095D31A3DABC0A4CB9B9F790A5F4127A@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzrOd3+DftSDFp/s1isWniNzeL8rFMs
        Fo+vX2R1YPZoOfKW1WPywovMHp83yQUwR3HZpKTmZJalFunbJXBlrN54nqVggVxFz+4LbA2M
        e2S7GDk5JARMJG60T2TtYuTiEBJYyShx+vkHJginlUni7vZNzDBV01dshqpayyhxZuVDZgjn
        E6PEzD0z2SCcZYwSkw53soG0sAkoSuzr2g5miwgYSVxZdpC9i5GDg1mgROL4QkmQsLCAisTa
        U99ZIEpUJX5/2MYOYetJLJp8BWwzC1D82IXvYGN4BUwlnv26wghicwoYSszc8osVxGYUEJP4
        fmoNE4jNLCAucevJfCaIqwUlFs3eA/WBmMS/XQ/ZIGxFifvfX0Kdoymxfpc+RKudxN39P9gh
        bEWJKd0P2SHWCkqcnPmEBaJVUuLgihssIO9KCKzkkFjetgxsjoSAi0TrCx6IGmmJq9enMkOE
        kyVWfeSCCOdIzF+yBWqMtcTCP+uZJjCqzEJy9CyEg2YhOWgWkoNmITloASPrKkbx0uLi3PTU
        YsO81HK94sTc4tK8dL3k/NxNjMDkcvrf4dwdjDtufdQ7xMjEwXiIUYKDWUmE1zBmX4oQb0pi
        ZVVqUX58UWlOavEhRmkOFiVxXkPbk8lCAumJJanZqakFqUUwWSYOTqkGppkl95slvmkeDpfl
        fBotIH9kxW39B8u27GB34ZLTThWdLbHFf5LevojeyGfeH5akRJ37nv8wJ2NZQs3EbZ4LZ7+T
        knXYIK8/VY6x93HapL6aB/kL/L4LnS/b3VzWXtT4QfB4yYFS1qtfykrOTPuodstQbGHdTgYb
        b+sOFqPFDCYftzzfniVsWi5mz3fueoe/qeu577zcEc9dBbm8E1RPlRnq6ofXr8mffPJYdF66
        +fXmMhYB0bf9VxuXX+7+3rrZ6RD31MlvVHPLNnOdTf6xg+WTvMztN1/3u20yimf4tHZGmUpX
        xLPfO1iXWRStrI1dd7d/IzuPuc7Ge601CSfjBCzmmbq1Lwvg1pthnpqpxFKckWioxVxUnAgA
        GyHq+Z0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWS2cA0Sbdvw74Ug3U3DCxWLbzGZnF+1ikW
        i8fXL7I6MHu0HHnL6jF54UVmj8+b5AKYo7hsUlJzMstSi/TtErgyVm88z1KwQK6iZ/cFtgbG
        PbJdjJwcEgImEtNXbGbtYuTiEBJYzShx584sJgjnE6PEp2MwmWWMEo3vj7KCtLAJKErs69rO
        BmKLCBhJXFl2kL2LkYODWaBE4vhCSZCwsICKxNpT31kgSlQlfn/Yxg5h60ksmnyFGcRmAYof
        u/AdbAyvgKnEs19XGEFsIYFmRonzc4RBbE4BQ4mZW36BrWUUEJP4fmoNE4jNLCAucevJfCaI
        DwQkluw5zwxhi0q8fPyPFcJWlLj//SXUaZoS63fpQ7TaSdzd/4MdwlaUmNL9kB3iBEGJkzOf
        sEC0SkocXHGDZQKjxCwk22YhTJqFZNIsJJNmIZm0gJF1FaN4aXFxbnpFsWFearlecWJucWle
        ul5yfu4mRmBsnv53OHIH49FbH/UOMTJxMB5ilOBgVhLhNYzZlyLEm5JYWZValB9fVJqTWnyI
        UZqDRUmcV8h1YryQQHpiSWp2ampBahFMlomDU6qByUhZbr0Hy7G795wr5rXX+YuJ6+Xf3vip
        4Jda+eJTJ4xiVHbG9tm3+nK8t5OfMWnF16+ipc1BK2X4NpmwJd37Y/g8+62za7DS3W07T9T6
        c21Vz9nqupRvTZK+WhUHq82/Z/J79ZJ0jn2S29V3rrfvzR/LDu/Dv5suKyzyY1ylwpDpuIhL
        adWTbX/Yl2+Y7+Ud5i7atzfsWpCW98egtfoSarYN96U6TXaYzWuKvPRabLNrSvKDDtP59x+Z
        vPj5bdVJh5j5TAu/blgxRZL9x+mDGd6nLsVYxX/50jNDdO2RTi6pHCa+rJi5xmt8y/TKdlvM
        Mtnz6eAyb7kcsSNpwovy15y4xdHAs9b2cfW+J/N1lViKMxINtZiLihMB1HqsgTwDAAA=
X-CMS-MailID: 20230724171038uscas1p14c970be6ede7bbdef7cb397d20ee034c
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724171038uscas1p14c970be6ede7bbdef7cb397d20ee034c
References: <DM6PR18MB2844A8A869CFB8932782DD67AF3EA@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230724100342.00005c7b@Huawei.com>
        <CGME20230724171038uscas1p14c970be6ede7bbdef7cb397d20ee034c@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMTA6MDM6NDJBTSArMDEwMCwgSm9uYXRoYW4gQ2FtZXJv
biB3cm90ZToNCg0KPiBPbiBUaHUsIDIwIEp1bCAyMDIzIDAxOjQzOjM0ICswMDAwDQo+IFNoZXNo
YSBCaHVzaGFuIFNyZWVuaXZhc2FtdXJ0aHkgPHNoZXNoYXNAbWFydmVsbC5jb20+IHdyb3RlOg0K
PiANCj4gPiBIZWxsbyBBbGwsDQo+ID4gDQo+ID4gSSBhbSBhZGRpbmcgRk0tQVBJIHN1cHBvcnQg
dG8gYWRkIERDRCBleHRlbnRzIGluIFFFTVUuIFRoZSBjdXJyZW50IGNvZGUgaXMgbm90IG1ha2lu
ZyBzZW5zZSB0byBtZS7CoCBBY2NvcmRpbmcgdG8gQ1hMMy4wIHNwZWMgKFRhYmxlIDgtMTI2KSwg
cmVnaW9uX2Jhc2Ugc2hvdWxkIGJlIHRoZSBEUEEgYW5kIG5vdCB0aGUgc2l6ZSwgZGVjb2RlX2xl
bmd0aCBpcyB0aGUgdG90YWwgcmVnaW9uIGxlbmd0aCB3aGljaCBpcyB1c2VkIHRvIHByb2dyYW0g
SERNIGRlY29kZXJzLCByZWdpb25fbGVuIGlzIHRoZSB1c2FibGUgbGVuZ3RoIG1lYW5pbmcgYXMg
ZXh0ZW50cyBhcmUgYWRkZWQgdGhlIHJlZ2lvbl9sZW4gaW5jcmVhc2VzIHVwIHRvIGEgbWF4IG9m
wqBkZWNvZGVfbGVuZ3RoLiBTbyBzaG91bGQgYmUgMCBiZWZvcmUgd2UgYWRkIGFueSBleHRlbnRz
LsKgDQo+ID4gDQo+ID4gVGhpcyBpcyB3aGF0IGl0IHNob3VsZCBsb29rwqBsaWtlIGluIG15IG9w
aW5pb24uIEFtIEkgY29ycmVjdCA/DQo+ID4gDQo+ID4gLS0tIGh3L21lbS9jeGxfdHlwZTNfb2xk
LmPigILigILigILigIIyMDIzLTA3LTE5IDE4OjE4OjU0LjIxMTc0ODQ3NSAtMDcwMA0KPiA+ICsr
KyBody9tZW0vY3hsX3R5cGUzLmPigILigIIyMDIzLTA3LTE5IDE4OjI3OjEzLjQ2ODYwMjgyNSAt
MDcwMA0KPiA+IEBAIC03NDcsMTAgKzc0NywxMCBAQA0KPiA+IMKgc3RhdGljIGludCBjeGxfY3Jl
YXRlX3RveV9yZWdpb25zKENYTFR5cGUzRGV2ICpjdDNkKQ0KPiA+IMKgew0KPiA+IMKg4oCC4oCC
4oCC4oCC4oCCaW50IGk7DQo+ID4gLeKAguKAguKAguKAguKAgnVpbnQ2NF90IHJlZ2lvbl9iYXNl
ID0gY3QzZC0+aG9zdHZtZW0/Y3QzZC0+aG9zdHZtZW0tPnNpemUNCj4gPiAt4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCCOmN0M2QtPmhvc3RwbWVtLT5zaXplOw0KPiA+IC3igILigILi
gILigILigIJ1aW50NjRfdCByZWdpb25fbGVuID0gMTAyNCoxMDI0KjEwMjQ7DQo+ID4gLeKAguKA
guKAguKAguKAgnVpbnQ2NF90IGRlY29kZV9sZW4gPSA0OyAvKiA0KjI1Nk1CICovDQo+ID4gKyDC
oCDCoE1lbW9yeVJlZ2lvbiAqbXIgPSBob3N0X21lbW9yeV9iYWNrZW5kX2dldF9tZW1vcnkoY3Qz
ZC0+ZGMuaG9zdF9kYyk7DQo+ID4gKyDCoCDCoHVpbnQ2NF90IHJlZ2lvbl9iYXNlID0gKHVpbnQ2
NF90KW1lbW9yeV9yZWdpb25fZ2V0X3JhbV9wdHIobXIpOw0KPiA+ICvigILigILigILigILigIJ1
aW50NjRfdCByZWdpb25fbGVuID0gMDsNCj4gPiAr4oCC4oCC4oCC4oCC4oCCdWludDY0X3QgZGVj
b2RlX2xlbiA9IGN0M2QtPmRjLmhvc3RfZGMtPnNpemUgLyBjdDNkLT5kYy5udW1fcmVnaW9ucyAv
ICgyNTYqMTAyNCoxMDI0KTsNCj4gPiDCoOKAguKAguKAguKAguKAgnVpbnQ2NF90IGJsa19zaXpl
ID0gMioxMDI0KjEwMjQ7DQo+ID4gwqDigILigILigILigILigIJzdHJ1Y3QgQ1hMRENEX1JlZ2lv
biAqcmVnaW9uOw0KPiANCj4gV2hhdCBjb2RlIGFyZSB3ZSBsb29raW5nIGF0IGhlcmU/DQo+IA0K
PiBBbnlob3csIHRoZSBEUEEgaGVyZSBpcyByZWxhdGl2ZSB0byB0aGUgZGV2aWNlIHdoaWNoIGlz
bid0IGNvbm5lY3RlZCB0byB0aGUgUUVNVSBpbXBsZW1lbnRhdGlvbg0KPiBhdCBhbGwuICBUaGUg
YWRkcmVzcyBkZWNvZGVyIHN0dWZmIGluIFFFTVUgd2lsbCBtYXAgdG8gdGhlIHJpZ2h0IHJlZ2lv
biB3aGVyZXZlciBpdCBpcywgd2UNCj4ganVzdCBuZWVkIHRvIHByZXRlbmQgdGhlIGdvOg0KPiAN
Cj4gW1JBTSByZWdpb25dIFtQTWVtIFJlZ2lvbl0gW0RDIFJlZ2lvbl0NCj4gd2hlcmUgYW55IG9m
IHRoZXNlIGFyZSBvcHRpb25hbCBhbmQgd2hlcmUgdGhlIFFlbXUgZW11bGF0aW9uIGRvZXNuJ3Qg
Y3VycmVudGx5IHN1cHBvcnQNCj4gc2l6ZXMgdGhhdCByZXF1aXJlIGFueSBwYWRkaW5nLg0KPiAN
Cj4gU28gdGhlIG9mZnNldHMgYWJvdmUgbG9vayB3cm9uZyBhbnl3YXkgYXMgaXQgc2VlbXMgdG8g
YmUgYXNzdW1pbmcgd2UgZWl0aGVyIGhhdmUNCj4gdm9sYXRpbGUgb3IgcGVyc2lzdGVudCByZWdp
b25zIGJ1dCBub3QgYm90aC4NCj4gDQo+IEpvbmF0aGFuDQo+IA0KDQpGWUkuDQpUaGUgaXNzdWUg
d2FzIGZpeGVkIGluIHRoZSBuZXcgcGF0Y2ggYXMgYmVsb3c6DQoNCitzdGF0aWMgaW50IGN4bF9j
cmVhdGVfZGNfcmVnaW9ucyhDWExUeXBlM0RldiAqY3QzZCkNCit7DQorICAgIGludCBpOw0KKyAg
ICB1aW50NjRfdCByZWdpb25fYmFzZSA9IChjdDNkLT5ob3N0dm1lbSA/IGN0M2QtPmhvc3R2bWVt
LT5zaXplIDogMCkNCisgICAgICAgICsgKGN0M2QtPmhvc3RwbWVtID8gY3QzZC0+aG9zdHBtZW0t
PnNpemUgOiAwKTsNCisgICAgdWludDY0X3QgcmVnaW9uX2xlbiA9ICh1aW50NjRfdCkyICogMTAy
NCAqIDEwMjQgKiAxMDI0Ow0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMjAy
MzA3MjQxNjIzMTMuMzQxOTYtNS1mYW4ubmlAc2Ftc3VuZy5jb20vVC8jdQ0KDQpBbHNvLCBJIHN1
Z2dlc3QgdG8gdHJ5IHRoZSBuZXcgcGF0Y2hlcyBhcyBpdCBmaXhlZCBxdWl0ZSBhIGZldyB0aGlu
Z3MuDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMjAyMzA3MjQxNjIzMTMuMzQx
OTYtMS1mYW4ubmlAc2Ftc3VuZy5jb20vVC8jdA0KDQpGYW4=
