Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60005E936EB
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 23:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjJDXIg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 19:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjJDXIg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 19:08:36 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B522C6
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 16:08:28 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231004230826usoutp01a070fca62a2cd1d4cc5ee8a6fea5f894~LCjTgFG0H2181121811usoutp01L
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 23:08:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231004230826usoutp01a070fca62a2cd1d4cc5ee8a6fea5f894~LCjTgFG0H2181121811usoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696460906;
        bh=6XIMs5ksVYQU25zcB4YaojuBPMXTguzbzrPVcArNu8w=;
        h=From:To:Subject:Date:References:From;
        b=fdftlMoCeUs6YHYeQYjlIOwb3VJcFRZfIcNHwEMyCufLnhVvnZ8C3IIIDnYXj0xTa
         kux3uWV+HAWuUUZOChrfBJz6AET7TWmVpD3TFIM7ESCHFZK3EIrDIQeyEGYBfZq1xk
         mh9gD3YvlKH7pY2vCtnnTDpA1C+vHmn/RIUB2C4M=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231004230826uscas1p282c44798b0afab9b0d90e1ac8b17b41d~LCjTbB0aY1895418954uscas1p2F
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 23:08:26 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 6A.CC.40279.A60FD156; Wed, 
        4 Oct 2023 19:08:26 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f~LCjTLiWqq0758807588uscas1p2L
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 23:08:26 +0000 (GMT)
X-AuditID: cbfec36f-241ff70000009d57-84-651df06a98f0
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 85.FA.31410.A60FD156; Wed, 
        4 Oct 2023 19:08:26 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 4 Oct 2023 16:08:25 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        4 Oct 2023 16:08:25 -0700
From:   Jim Harris <jim.harris@samsung.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: [PATCH] cxl: set root decoder granularity based on region params
Thread-Topic: [PATCH] cxl: set root decoder granularity based on region
        params
Thread-Index: AQHZ9xetppHioUpJEUacMqps7+5BAQ==
Date:   Wed, 4 Oct 2023 23:08:25 +0000
Message-ID: <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <60BC53EC75501242A0EA47C1503163A4@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djXc7pZH2RTDb5M1rE4P+sUiwOjx+dN
        cgGMUVw2Kak5mWWpRfp2CVwZfUfvsxZcEqqY9uQRSwPjFKEuRk4OCQETidfTTzB3MXJxCAms
        ZJSYfmEyG0hCSGApk8TUFjmYok93WpkgitYySizeuAiq4yOjxPI5S2A6GCXaF5iC2GwCmhK/
        rqxhArFFBKwlJjRA1AgLeEqsmTCTGSIeINF37yAbhK0n0bL7KAuIzSKgIjFx32N2EJtXIFri
        3N6DjCA2o4CYxPdTEDOZBcQlbj2ZzwRxnaDEotl7mCFsMYl/ux6yQdiKEve/vwSawwFUrymx
        fpc+RKudxJf166HGKEpM6X4ItUpQ4uTMJywQrZISB1fcYAH5UULgEbvEtJfXGSESLhKfrt6A
        2istMX3NZaiGbImV6zuYQHZJCBRINBwJgghbSyz8A7OLT+Lvr0eMECW8Eh1tQhMYlWYheWYW
        wqGzkBw6C8mhs5AcuoCRdRWjeGlxcW56arFRXmq5XnFibnFpXrpecn7uJkZgyjj973D+Dsbr
        tz7qHWJk4mA8xCjBwawkwpveIJMqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfQ9mSykEB6Yklq
        dmpqQWoRTJaJg1OqgWnypSXPprMw7CxeWrcmSkes54LUhk1+u3T+m52TkGq52mPdEaR9S2ba
        E/u934MWx7U77zFqnS2sYnw/6HnLvomrHpkek/qtlHXRcZuqy5ENHPkvMt1/y31aMr9b4b3Y
        vGDOPLat7t/EvmqLTrJ/+y309OZVt/PfJL/cKO6vuvWku7lIhPrcrdvOLfTpO21vtH3x2gVn
        KzR7bt7yVTdfETtj9zXzuu6CpzsUGpPyg2bfVvRIS5xvwvb5RKyoxLfX5wxUL76yt7r3lYFx
        08TatP9F/Ne3VRQqrJ5wYVW10koxk4NNB/mnza07npKQyuBUHXEg31Sy5XRMg6lB2x3pt5nl
        OyWETuQu3RVQm9L0RkCJpTgj0VCLuag4EQBss/jMiAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWS2cA0STfrg2yqQctXMYvzs06xODB6fN4k
        F8AYxWWTkpqTWZZapG+XwJXRd/Q+a8EloYppTx6xNDBOEepi5OSQEDCR+HSnlamLkYtDSGA1
        o8S994eYIZyPjBKPTvRAZZYySjStusoG0sImoCnx68oaJhBbRMBaYkLDErC4sICnxJoJM5kh
        4n4S6160skHYehItu4+ygNgsAioSE/c9ZgexeQWiJc7tPcgIYjMKiEl8PwUxk1lAXOLWk/lM
        EOcJSCzZc54ZwhaVePn4HyuErShx//tLoDkcQPWaEut36UO02kl8Wb8eaoyixJTuh1CrBCVO
        znzCAtEqKXFwxQ2WCYyis5Bsm4UwaRaSSbOQTJqFZNICRtZVjOKlxcW56RXFxnmp5XrFibnF
        pXnpesn5uZsYgdFy+t/hmB2M92591DvEyMTBeIhRgoNZSYQ3vUEmVYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjjvjikXU4QE0hNLUrNTUwtSi2CyTBycUg1MeQKSGVohkcuCgthzdZcd3ton3u3j
        bBhcceqveZ9mn9BCvq83OIPfCUp8/f0kMn6puZ56ZIlGdJFrvK8RR25zf0GLwDaOI+8M013+
        pHPOfzejIoLJ7U4zk9/ayUGBpnOnGm5kXbUtX9nS9CXzO71bC256bomKqp3Psv79IoONcx9+
        TGDfoPBfaKfURDO/K1kvSt5dfcagzih8d+nX7sTN4k+5xf7W5O419mNbMf2+/Zo/gu1+H/f9
        vHzT70Pf7U9/440a3/r5/hYzvbyjO+3RE9st731O/LJKrRGefujqzFaO6tnXzO1ur56yh8f2
        34LFgq5Sx1gnRnEceG648ED2/tl91/k0p086//Yk9+ECJZbijERDLeai4kQAsV9piwUDAAA=
X-CMS-MailID: 20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f
CMS-TYPE: 301P
X-CMS-RootMailID: 20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f
References: <CGME20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

VGhlIGdyYW51bGFyaXR5IGZvciBkb3duc3RyZWFtIHRhcmdldHMgaXMgYWxsIGJhc2VkIG9uIGRl
c2NlbmRpbmcgdGhlCnRvcG9sb2d5IGZyb20gdGhlIHJvb3QuIFNvIHdlIG5lZWQgdG8gc2V0IHRo
ZSByb290IGRlY29kZXIncyBncmFudWxhcml0eQpiYXNlZCBvbiB0aGUgcmVnaW9uIHBhcmFtcy4K
ClRlc3QgY29uZmlndXJhdGlvbiBpcyAxIGhvc3QgYnJpZGdlICogMiBzd2l0Y2hlcyAqIDIgZW5k
cG9pbnRzIHBlciBzd2l0Y2guCgpSZWdpb24gY3JlYXRlZCB3aXRoIDIwNDggZ3JhbnVsYXJpdHkg
dXNpbmcgZm9sbG93aW5nIGNvbW1hbmQgbGluZToKCmN4bCBjcmVhdGUtcmVnaW9uIC1tIC1kIGRl
Y29kZXIwLjAgLXcgNCBtZW0wIG1lbTIgbWVtMSBtZW0zIFwKCQkgIC1nIDIwNDggLXMgMjA0OE0K
ClVzZSAiY3hsIGxpc3QgLVBERSB8IGdyZXAgZ3JhbnVsYXJpdHkiIHRvIGdldCBhIHZpZXcgb2Yg
dGhlIGdyYW51bGFyaXR5CnNldCBhdCBlYWNoIGxldmVsIG9mIHRoZSB0b3BvbG9neS4KCkJlZm9y
ZToKICAgICAgICAiaW50ZXJsZWF2ZV9ncmFudWxhcml0eSI6MjA0OCwKICAgICAgICAiaW50ZXJs
ZWF2ZV9ncmFudWxhcml0eSI6MjA0OCwKICAgICJpbnRlcmxlYXZlX2dyYW51bGFyaXR5Ijo1MTIs
CiAgICAgICAgImludGVybGVhdmVfZ3JhbnVsYXJpdHkiOjIwNDgsCiAgICAgICAgImludGVybGVh
dmVfZ3JhbnVsYXJpdHkiOjIwNDgsCiAgICAiaW50ZXJsZWF2ZV9ncmFudWxhcml0eSI6NTEyLAoi
aW50ZXJsZWF2ZV9ncmFudWxhcml0eSI6MjU2LAoKQWZ0ZXI6CiAgICAgICAgImludGVybGVhdmVf
Z3JhbnVsYXJpdHkiOjIwNDgsCiAgICAgICAgImludGVybGVhdmVfZ3JhbnVsYXJpdHkiOjIwNDgs
CiAgICAiaW50ZXJsZWF2ZV9ncmFudWxhcml0eSI6NDA5NiwKICAgICAgICAiaW50ZXJsZWF2ZV9n
cmFudWxhcml0eSI6MjA0OCwKICAgICAgICAiaW50ZXJsZWF2ZV9ncmFudWxhcml0eSI6MjA0OCwK
ICAgICJpbnRlcmxlYXZlX2dyYW51bGFyaXR5Ijo0MDk2LAoiaW50ZXJsZWF2ZV9ncmFudWxhcml0
eSI6MjA0OCwKClNpZ25lZC1vZmYtYnk6IEppbSBIYXJyaXMgPGppbS5oYXJyaXNAc2Ftc3VuZy5j
b20+Ci0tLQogZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyB8ICAgIDUgKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3Jl
Z2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYwppbmRleCA2ZDYzYjg3OThjMjkuLmYx
NDExMGUzNWY3OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYworKysgYi9k
cml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jCkBAIC0xNjkxLDYgKzE2OTEsMTEgQEAgc3RhdGljIGlu
dCBjeGxfcmVnaW9uX2F0dGFjaChzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciwKIAkJcmV0dXJuIC1F
SU5WQUw7CiAJfQogCisJLyogU2V0IHJvb3QgZGVjb2RlcidzIGdyYW51bGFyaXR5IG5vdywgc28g
dGhhdCB3ZSBjYW4gdXNlIGl0IHRvIGNhbGN1bGF0ZQorCSAqIGdyYW51bGFyaXR5IGZvciB0aGUg
ZG93bnN0cmVhbSB0YXJnZXRzIGluIGN4bF9yZWdpb25fc2V0dXBfdGFyZ2V0cygpLgorCSAqLwor
CWN4bHJkLT5jeGxzZC5jeGxkLmludGVybGVhdmVfZ3JhbnVsYXJpdHkgPSBjeGxyLT5wYXJhbXMu
aW50ZXJsZWF2ZV9ncmFudWxhcml0eTsKKwogCWlmICh0ZXN0X2JpdChDWExfUkVHSU9OX0ZfQVVU
TywgJmN4bHItPmZsYWdzKSkgewogCQlpbnQgaTsKIAoK
