Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09A3C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 19:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350817AbiA1TTA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 14:19:00 -0500
Received: from mailout2.w2.samsung.com ([211.189.100.12]:61612 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiA1TTA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 14:19:00 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jan 2022 14:18:59 EST
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220128190921usoutp02d392c4a7e7e5347a5091d7fe389d4c68~OhNRsN9wr0316703167usoutp02H;
        Fri, 28 Jan 2022 19:09:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220128190921usoutp02d392c4a7e7e5347a5091d7fe389d4c68~OhNRsN9wr0316703167usoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643396961;
        bh=490fKE/436Z1zE49KKBMYmg61fbE0c5GyZ2Y4d0sOS4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=tr3mmXB6Dp+aLBKIJNWb/clItG31+SRbYVIOOrRD3cwd62o6FxvvWKp2ZwPiuY2Ii
         qs0iB3O0Yz7lUuFf7Kt4u4FcehNKc4lUEQM6afzNN0hek4tneiMlaWhWghQI2mCSaK
         mLEeeUEJkgmfmQJULOCB5jV2PoPVeSfWztGx4ibM=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220128190921uscas1p1af529e4ada3c428bd51c3c7a8d69f39a~OhNRht28P0880108801uscas1p1X;
        Fri, 28 Jan 2022 19:09:21 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 19.3C.09687.16F34F16; Fri,
        28 Jan 2022 14:09:21 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220128190921uscas1p16271f93f5a80ba263f629286b21ff9c3~OhNRNCp551507715077uscas1p1X;
        Fri, 28 Jan 2022 19:09:21 +0000 (GMT)
X-AuditID: cbfec370-9c5ff700000025d7-b5-61f43f61e56d
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id C7.22.10042.E7F34F16; Fri,
        28 Jan 2022 14:09:50 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 28 Jan 2022 11:09:10 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Fri, 28 Jan 2022 11:09:10 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     "Treon, Justin" <justin.treon@advantest.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Treating CXL Type 3 device as a block device
Thread-Topic: Treating CXL Type 3 device as a block device
Thread-Index: AdgT1EtILrDrPlH6R52tS4rhimYvGwA6VImA
Date:   Fri, 28 Jan 2022 19:09:10 +0000
Message-ID: <20220128190914.GA277680@bgt-140510-bm01>
In-Reply-To: <SA1PR05MB8015E5AC7D6F6D028D5FD8F48C219@SA1PR05MB8015.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
x-exchange-save: DSA
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <968D64E5611FB3419A2ED24D818E0136@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzred1E+y+JBlcmSFg8PtzNanF+1ikW
        ByaPRU2GHp83yQUwRXHZpKTmZJalFunbJXBlfGxuYinYy1bxZNtPpgbGXtYuRk4OCQETiSkv
        G5m7GLk4hARWMkq0fu9jhHBamSSapy1kg6m63XUdKrGWUWL/k99QLR8ZJSYffsoO4RxglFg+
        5SVYC5uAgcTv4xuZQWwRIPv9ohuMIDazgLVE/+mzYHFhAUuJrde3sEHUWEks7tnKBGEbSayf
        1sQOYrMIqEo8/gcR5xUwlTiweA/YHE6BWIlF8+aB2YwCYhLfT61hgpgvLnHryXwmiLMFJRbN
        3sMMYYtJ/Nv1EOodRYn731+yQ9giEuu+v2WD6NWTuDF1CpRtJ/Hs5huomdoSyxa+Zoa4QVDi
        5MwnLBC9khIHV9xgAXleQmAuh8SK3jtQC1wkdnd8gYawtMTfu8uYIIpWMUpM+dbGDuFsZpSY
        8esC0wRG1VlILp+F5JJZSC6ZheSSWUguWcDIuopRvLS4ODc9tdg4L7Vcrzgxt7g0L10vOT93
        EyMwqZz+d7hgB+OtWx/1DjEycTAeYpTgYFYS4Z2x6VOiEG9KYmVValF+fFFpTmrxIUZpDhYl
        cd5lmRsShQTSE0tSs1NTC1KLYLJMHJxSDUxGuzbt4vhnUaey/Bjv3AXPJsU8mvThYfmF+O7T
        2/orHqTZRvUVrHr18vFb9rX/PbW8JUNFmRsuRC874hxm6hT/uL3aQEk5Liv77EJxtsC1BsVu
        DFwMR+V1pL3OTZ7Rf+v0iuJ7Z8TmS9b2+9RO3Rx5app0bMjTb09WBOXu4ZJ4cM5SS33ToR2B
        AlLBinM+npGoa3n/m/3/jRo348vfUk7LXzwdoam7S7l3Gbu/QOLGzMVVAdy8tyR8+JZa/o1Y
        w/p3zg5Wy5sqW3t+tWb2hlhrB/l9DVYuWtxkYNJb9GtSySHjLx+uZ8QYFJUrNehei1iorlQY
        njY9NFlb1iQl6enVgJRNa6UuFvy3bG21U2Ipzkg01GIuKk4EAN5/rtSZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWS2cA0SbfO/kuiwcrrihaPD3ezWpyfdYrF
        gcljUZOhx+dNcgFMUVw2Kak5mWWpRfp2CVwZH5ubWAr2slU82faTqYGxl7WLkZNDQsBE4nbX
        dcYuRi4OIYHVjBILz75kAUkICXxklFje7QiROMAocWPSCmaQBJuAgcTv4xvBbBEg+/2iG4wg
        NrOAtUT/6bNgcWEBS4mt17ewQdRYSSzu2coEYRtJrJ/WxA5iswioSjz+BxHnFTCVOLB4D9QV
        Gxgljiz4DpbgFIiVWDRvHtgCRgExie+n1jBBLBOXuPVkPhPECwISS/acZ4awRSVePv4H9Zqi
        xP3vL9khbBGJdd/fskH06kncmDoFyraTeHbzDdRMbYllC18zQxwkKHFy5hMWiF5JiYMrbrBM
        YJSchWT1LCSjZiEZNQvJqFlIRi1gZF3FKF5aXJybXlFslJdarlecmFtcmpeul5yfu4kRGKOn
        /x2O3sF4+9ZHvUOMTByMhxglOJiVRHhnbPqUKMSbklhZlVqUH19UmpNafIhRmoNFSZz3ZdTE
        eCGB9MSS1OzU1ILUIpgsEwenVAOT9tqKCRLWjxymi0Zzfgw+bfLBtlOr/nVL+esQ59maktuY
        Yr+fnC8g4OARdaRqcp978A/G6/d+adimnDQ89T3Q/mqM4r5nV9Niv9/01Oc6v+ij5fQ9zQ2F
        /y1m6Rm/PhWmxO1j9er0nyLDOIOdXf+u90ar7VM9K+r3QGV1VL8Ek4hLa6nF/t8zDjquW/FL
        3C1s2fuky0e/G8X9+bKcOUU0xvk8j7YYh8TBwH2B0pOEnk1nOc/ssdm++OLa5tLr/jui3Nhe
        3aviUj2daTzn99+3SQcPR9xZ0CVdoPJG/02c1Gq1vgOBXYdZFi2+0mHB82BFhPXqmostLCox
        /86qZPXfv9BXfqKl4b2rRnTI2mdKLMUZiYZazEXFiQC+s8qUQAMAAA==
X-CMS-MailID: 20220128190921uscas1p16271f93f5a80ba263f629286b21ff9c3
CMS-TYPE: 301P
X-CMS-RootMailID: 20220127234003uscas1p2190dbe483026e9a7a94e84803fb1a2b1
References: <CGME20220127234003uscas1p2190dbe483026e9a7a94e84803fb1a2b1@uscas1p2.samsung.com>
        <SA1PR05MB8015E5AC7D6F6D028D5FD8F48C219@SA1PR05MB8015.namprd05.prod.outlook.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 27, 2022 at 11:39:54PM +0000, Treon, Justin wrote:
> The pmem.io blog lists directions to make block device from pmem with 'nd=
ctl=A0create-namespace -v --type=3Dpmem=A0--mode=3Dfsdax'  Is it possible t=
o use ndctl to create a block device from a CXL type 3 device with volatile=
 memory to so tools like fio can be used for testing?
>=20
> Is the 5.16 or 5.17 kernel required or can the 5.15 kernel be used?
>=20
> Is there another way to make a cxl block device?

I would assume for a type 3 device, where the memory ends up as a cpu-less =
numa=20
node you could create a block ram disk using numactl parameters specifying =
the
numa node associated with the type 3 device.

I don't think ndctl is necessary to achieve this, interested in hearing oth=
er=20
opinions.

>=20
>=20
>=20
> =
