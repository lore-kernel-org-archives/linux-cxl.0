Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6CEC433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Nov 2022 15:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKAPqc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKAPqb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Nov 2022 11:46:31 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88396F5BA
        for <linux-cxl@vger.kernel.org>; Tue,  1 Nov 2022 08:46:30 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221101154629usoutp029a453cb484fba965e13075866c8df17e~jgIOijH3x2630226302usoutp02H;
        Tue,  1 Nov 2022 15:46:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221101154629usoutp029a453cb484fba965e13075866c8df17e~jgIOijH3x2630226302usoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667317589;
        bh=F/XR+YRvViFUZKmk4R2VFxLcNV7TY4OFcM868H70Kms=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Uh5L6wiKKLU33pGCxTsEvsJzuDp8gsmIH6BZCIb1vV6J7vqxkvjf4ukazmcbDYheh
         SLfhFeKjDoQuCz70iVsimFXJgZ0aY4Ks0frI/vYs9hoHCE/hnDkFg+FolGrqnHx2Aa
         4r3L9sJhSa7fUrt6LIDv5pIGtXA7dz9WUuiWn56o=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221101154629uscas1p1b1ee34b3782a04772cbe7ac18a60f6f4~jgIOV9Rip1367213672uscas1p1f;
        Tue,  1 Nov 2022 15:46:29 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 97.FD.18126.55F31636; Tue, 
        1 Nov 2022 11:46:29 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221101154629uscas1p1e72203158da10702d4d2e1fc0cf4bf1f~jgIN31a2y2600826008uscas1p1q;
        Tue,  1 Nov 2022 15:46:29 +0000 (GMT)
X-AuditID: cbfec36f-ff9ff700000146ce-bb-63613f55974e
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id B5.D0.36264.45F31636; Tue, 
        1 Nov 2022 11:46:29 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 1 Nov 2022 08:46:28 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        1 Nov 2022 08:46:28 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <d.bueso@samsung.com>
Subject: Re: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Thread-Topic: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Thread-Index: AQHY6ykWpXsE/hQsVUualGBz0TCrfq4pOpIAgAF2qgA=
Date:   Tue, 1 Nov 2022 15:46:28 +0000
Message-ID: <20221101154628.GB78088@bgt-140510-bm03>
In-Reply-To: <20221031172530.jnywmbtjayfambb2@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9349A7A926084944A5C67A589C094784@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djX87qh9onJBvMvKFtMn3qB0WL1zTWM
        FudnnWKxuDXhGJMDi8fiPS+ZPKbOrvf4vEkugDmKyyYlNSezLLVI3y6BK2PPsTUsBSf5K240
        f2ZpYHzC08XIySEhYCLx9/crpi5GLg4hgZWMEmfOL2GHcFqZJA5OvsvSxcgBVrX8aj5EfC2j
        RNfZ2VBFHxklVk65xAjhLGWU+HKlkRlkLpuAosS+ru1sILaIgLrEvLW3wYqYBZqYJBZPeMoC
        khAWcJR49e0bE0SRk8TBJRugGqwk5sz7zwpiswioSMz9+gOsnhfojA2PNrCDnMQpYC7RsCoI
        JMwoICbx/dQasDHMAuISt57MZ4L4TVBi0ew9zBC2mMS/XQ/ZIGxFifvfX7JD1OtILNj9iQ3C
        tpP492kJI4StLbFs4WtmiLWCEidnPmGB6JWUOLjiBgvILxICWzgkDlz+yA6RcJH4M3MvVJG0
        xN+7y6COqJY403OOCaKhhVHiUuNmqIusJf51XmOfwKgyC8nhs5AcNQvJUbOQHDULyVELGFlX
        MYqXFhfnpqcWG+WllusVJ+YWl+al6yXn525iBKab0/8O5+9gvH7ro94hRiYOxkOMEhzMSiK8
        9Wejk4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzRs3QShYSSE8sSc1OTS1ILYLJMnFwSjUwlSRJ
        vqzau6z70eIUz2aOXotTs1fsZS1peCw90XbGjms3e47IXo5j0axIKTE/kf7joNTG5SJpEWyd
        a6pZRGRi7p36KpJRVLMxaN0EtaaSbVYVHBu3fLn872vG5tU5lem/XzF+vcl3c6KzyZYFpTVq
        V2Lf8idVnnlSklPF5FU779lhW8vK+tk/3ez3fLxge+MwW2vf+Zze7yVLgyQXRz+zN4lu6z79
        12FTW1aM+RylnPCtp8R+y7A+33DUqWFZc9cSu3+zVPea/z/uq1pU/GVPhu6qf7NaXnbPSLv/
        1mn1I4npcnsUBNe+OFsxu7PAzbV8dUFrmNSxc78DrHpEJZQtpzWaleva9ClP2K+Q9P6yEktx
        RqKhFnNRcSIA4cIwBaYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWS2cA0STfUPjHZYOU2NovpUy8wWqy+uYbR
        4vysUywWtyYcY3Jg8Vi85yWTx9TZ9R6fN8kFMEdx2aSk5mSWpRbp2yVwZew5toal4CR/xY3m
        zywNjE94uhg5OCQETCSWX83vYuTiEBJYzSjxpuMZM4TzkVHi8bwGKGcpo8TyLdOAHE4ONgFF
        iX1d29lAbBEBdYl5a28zghQxCzQxSSye8JQFJCEs4Cjx6ts3JogiJ4mDSzZANVhJzJn3nxXE
        ZhFQkZj79QdYPS/QGRsebWCH2LaDUWLx0ptMIPdxCphLNKwKAqlhFBCT+H5qDdhMZgFxiVtP
        5oPZEgICEkv2nGeGsEUlXj7+xwphK0rc//6SHaJeR2LB7k9sELadxL9PSxghbG2JZQtfM0Pc
        IChxcuYTFoheSYmDK26wTGCUmIVk3Swko2YhGTULyahZSEYtYGRdxSheWlycm15RbJSXWq5X
        nJhbXJqXrpecn7uJERipp/8djt7BePvWR71DjEwcjIcYJTiYlUR4689GJwvxpiRWVqUW5ccX
        leakFh9ilOZgURLnfRk1MV5IID2xJDU7NbUgtQgmy8TBKdXAFLO7/VNM7cTmvnqhuMhjYrs1
        Aj2C9ucc/cfyTTTCRGqz6F+B9o8C/saHG/mYtDb8znFr8urI+3rwQNzG7vBpZ28IdE0XT8rM
        fBLmPHt1zHu7T7wW/KsfxPwveOE06WWq6X07g8jw0qoDC9+t3PJlAydnRm3B0/15+36t7NkZ
        ZMV9wPpluYxZ1hc/hxv8cxzqT5uK3j546fb70lx11h3Fe25enTDzZxkzN/M+qW37D0t7RIS3
        HLh/ZA3vGba23cx3LRfoiwgc3ifw09ZYwWhJplhS/4W+lb9OO+uqXVeaz3Pb6OHErfHrY54a
        7l21wvpxfqAyq+E7M7OHmUdnR896tixohvXmfcxfBI7+Cju2W4mlOCPRUIu5qDgRACDqIZRD
        AwAA
X-CMS-MailID: 20221101154629uscas1p1e72203158da10702d4d2e1fc0cf4bf1f
CMS-TYPE: 301P
X-CMS-RootMailID: 20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b
References: <CGME20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b@uscas1p1.samsung.com>
        <20221028235705.32890-1-fan.ni@samsung.com>
        <20221031172530.jnywmbtjayfambb2@offworld>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Oct 31, 2022 at 10:25:30AM -0700, Davidlohr Bueso wrote:

Thanks David. I will include the fix of the typos you mentioned
in the next patch.

Fan
> On Fri, 28 Oct 2022, Fan Ni wrote:
>=20
> > The function for retrieving firmware version is named
> > `cxl_memdev_get_firmware_verison`, updated to
> > `cxl_memdev_get_firmware_version'.
> > keeping `cxl_memdev_get_firmware_verison` for library compatibility.
> >=20
>=20
> Yikes, good catch!
>=20
> While at it there are a few other typos (not abi, fortunately :)
>=20
> diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/lib=
cxl.txt
> index fd2962ad78b5..66c1d14ec5e9 100644
> --- a/Documentation/cxl/lib/libcxl.txt
> +++ b/Documentation/cxl/lib/libcxl.txt
> @@ -110,7 +110,7 @@ may appear in the topology that were not previously e=
numerable.
>=20
>  NOTE: cxl_memdev_disable_invalidate() will force disable the memdev
>  regardless of whether the memory provided by the device is in active use
> -by the operating system. Callers take responisbility for assuring that
> +by the operating system. Callers take responsibility for assuring that
>  it is safe to disable the memory device. Otherwise, this call can be as
>  destructive as ripping a DIMM out of a running system. Like all other
>  libcxl calls that mutate the system state or divulge security sensitive
> @@ -327,7 +327,7 @@ const char *cxl_dport_get_physical_node(struct cxl_dp=
ort *dport);
>  int cxl_dport_get_id(struct cxl_dport *dport);
>  bool cxl_dport_maps_memdev(struct cxl_dport *dport, struct cxl_memdev *m=
emdev);
>  ----
> -The id of a dport is the hardware idenfifier used by an upstream port to
> +The id of a dport is the hardware identifier used by an upstream port to
>  reference a downstream port. The physical node of a dport is only
>  available for platform firmware defined downstream ports and alias the
>  companion object, like a PCI host bridge, in the PCI device hierarchy.=
