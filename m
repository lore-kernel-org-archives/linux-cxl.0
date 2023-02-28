Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F1EC64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 17:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjB1RAf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 12:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1RAe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 12:00:34 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCBD2CC49
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 09:00:27 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230228170025usoutp012d5ca4fe26e677040d7901bb9a6228f7~IC5vtJC2a0932909329usoutp01g;
        Tue, 28 Feb 2023 17:00:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230228170025usoutp012d5ca4fe26e677040d7901bb9a6228f7~IC5vtJC2a0932909329usoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677603625;
        bh=IqScxJE99n4blcyyLCbXcS9MbXRjqVp9lQNIvPAfyXc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=M4VwuUwprPxy71FxQbyEwm6yLd4lZFUrAgoTegIL0s8F+GiGlh4g2o+hQxhEiWzl9
         UzCNpgEBwNXJ2vGgW/PpVSmB0Tgfe4na7pnz3QZA5XMsBFkvh4EXL3nnmfLQckwfiw
         un4pgFjq4wcqohWaXfXYUnez4XrY9Y2YK2/5hw9w=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228170025uscas1p234a9e8e6ee43bab7ae67bebc80cbe8ce~IC5vlCA7R1230812308uscas1p2p;
        Tue, 28 Feb 2023 17:00:25 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 6F.8D.06976.9233EF36; Tue,
        28 Feb 2023 12:00:25 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228170025uscas1p1c55a57da5ce4c235cfa2176d65b53123~IC5vScb7Z1704217042uscas1p1N;
        Tue, 28 Feb 2023 17:00:25 +0000 (GMT)
X-AuditID: cbfec36d-afdff70000011b40-ed-63fe33298f1e
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id CA.42.17110.8233EF36; Tue,
        28 Feb 2023 12:00:24 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 28 Feb 2023 09:00:23 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        28 Feb 2023 09:00:23 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH] MAINTAINERS: Add Fan Ni as Compute eXpress Link QEMU
 reviewer
Thread-Topic: [PATCH] MAINTAINERS: Add Fan Ni as Compute eXpress Link QEMU
        reviewer
Thread-Index: AQHZS2lgeMHM3Cd7ME6AU/PeNBpw6q7lG5AA
Date:   Tue, 28 Feb 2023 17:00:23 +0000
Message-ID: <20230228170007.GA1344259@bgt-140510-bm03>
In-Reply-To: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <079B2C711B434043BB8C0C9B8D7C71E5@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djXc7qaxv+SDfomCVvMX3ufxWL1zTWM
        FqsWXmOzOD/rFIvF4Y1nmCz+/3rFanG8dweLA7tHy5G3rB5Prm1m8ni/7yqbx9TZ9R6fN8kF
        sEZx2aSk5mSWpRbp2yVwZRyeu4Kl4DtnxYIPT1kaGBdwdDFyckgImEhs2HuRsYuRi0NIYCWj
        xKzju5kgnFYmiXMLvjLCVDV+Ps8CkVjLKNH59jhUyydGibNHm1ghnGWMEpeXP2ABaWETUJTY
        17WdDcQWETCSeHdjElgHs8B+Jol3u28xgSSEBUIknjZfY4QoCpVounmSFabh+4FFYDUsAqoS
        b6e8AIvzCphJPOycA2ZzCjhKbDkEUcMoICbx/dQaMJtZQFzi1pP5TBB3C0osmr2HGcIWk/i3
        6yEbhK0ocf/7S3aIeh2JBbs/sUHYdhJ7t61ggbC1JZYtfM0MsVdQ4uTMJywQvZISB1fcAIeF
        hMAVDonmv5OAHA4gx0Xi/nVXiBppib93lzFBhJMlVn3kggjnSMxfsgVqjLXEwj/rmSYwqsxC
        cvUsJBfNQnLRLCQXzUJy0QJG1lWM4qXFxbnpqcWGeanlesWJucWleel6yfm5mxiB6en0v8O5
        Oxh33Pqod4iRiYPxEKMEB7OSCO/C23+ShXhTEiurUovy44tKc1KLDzFKc7AoifMa2p5MFhJI
        TyxJzU5NLUgtgskycXBKNTDx+mgvU025xW/VJjbv2v7EVOm2GalhRXedv1i6z1+4Pu26j/OR
        a+pRn1oPLF6nJCj03Hjh4ehpwvzewc13eY37I42Sgsw3Ti/ct1tun7SN+8Zu+d6ks+f8dQ7+
        XcjwQfo0r3ye5ba7m813yPrcq961T2aCVbVWzLt+3YliS75xvr5j8IBp8vwZs8s/7f/0xmTt
        vq2T1qSE3nH1rrifZhgpPdXnvsvEW2xVl3h2SR7bkOkdkv24rWN6241ctZmh1x5crctLebZH
        9Z1by7u3k07c2Cu1nuXglDONdzdNP7dA9nCh/9ZTVxcE7dv8K1oyZfffdR27n/FVc1g91noY
        Gt3Ptl3K7nJB8u+r5rOOmn6RVGIpzkg01GIuKk4EAOZ336O+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWS2cA0SVfD+F+yQdsJa4v5a++zWKy+uYbR
        YtXCa2wW52edYrE4vPEMk8X/X69YLY737mBxYPdoOfKW1ePJtc1MHu/3XWXzmDq73uPzJrkA
        1igum5TUnMyy1CJ9uwSujMNzV7AUfOesWPDhKUsD4wKOLkZODgkBE4nGz+dZQGwhgdWMEitf
        23YxcgHZnxglur/1MEM4yxgltjQtZgepYhNQlNjXtZ0NxBYRMJJ4d2MSI0gRs8B+Jol3u28x
        gSSEBUIknjZfY4QoCpXY/GwVO0zD9wOLwGpYBFQl3k55wQpi8wqYSTzsnMMKsW0Ko0T77Edg
        N3EKOEpsOQTRwCggJvH91Bowm1lAXOLWk/lMED8ISCzZc54ZwhaVePn4HyuErShx//tLdoh6
        HYkFuz+xQdh2Enu3rWCBsLUlli18zQxxhKDEyZlPWCB6JSUOrrjBMoFRYhaSdbOQjJqFZNQs
        JKNmIRm1gJF1FaN4aXFxbnpFsVFearlecWJucWleul5yfu4mRmB0n/53OHoH4+1bH/UOMTJx
        MB5ilOBgVhLhXXj7T7IQb0piZVVqUX58UWlOavEhRmkOFiVx3pdRE+OFBNITS1KzU1MLUotg
        skwcnFINTFxFrB8ajT1FS1vsj+3/ZLfAPPZogFD9saNf9rBIKfLLHkmY46/7oyEvZ9kRdm7V
        TQaqXv9Ffsl/3f0/b/pGzh+8sS//PZI5OfG7xV2Nt/bb57MUvruxpHiBTtOh0sP8jassTqzc
        +P1u18mWiYy7vUwTLu57ItmjLtatNP1uvMvSSe/ufmhNkPfjnyGgeTVo1l57xnsTuLfHrNgT
        LaZRO7/pGcu5G/znfW9mcU5YdN5P7YTGm8yQF+sTPq+bns7JclD2jHNL/jYlJ9FP5zL/zVph
        3f52caXY7DNxq66zxQbkxmw/zN4tXaq79C+zf/IWp4eOqaoftNdHv+a1Mf7idm6GRXmzhNuO
        dVHmbI+Dq5RYijMSDbWYi4oTASfw61NdAwAA
X-CMS-MailID: 20230228170025uscas1p1c55a57da5ce4c235cfa2176d65b53123
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228113930uscas1p1ee175978a900da78cf499695e7701e0f
References: <CGME20230228113930uscas1p1ee175978a900da78cf499695e7701e0f@uscas1p1.samsung.com>
        <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 28, 2023 at 11:39:26AM +0000, Jonathan Cameron wrote:
> Fan Ni has offered to help out with QEMU CXL emulation reviewing.
> Add him as a designated reviewer.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20

Acked-by: Fan Ni <fan.ni@samsung.com>

> --
> Thanks to Fan for stepping up after I requested help following Ben
> stepping down as co-maintainer. Fan base been active in testing
> and review recently so great to have Fan on board.
>=20
> Based on patch [PATCH] MAINTAINERS: Remove CXL maintainer Ben Widawsky
>=20
> Based-of: Message-id: 20230220212437.1462314-1-armbru@redhat.com
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ea56c6ccc..838e1a91a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2633,6 +2633,7 @@ T: git https://urldefense.com/v3/__https://gitlab.c=
om/vsementsov/qemu.git__;!!EwVzqGoTKBqv-0DWAJBm!UcJW-DGImFKtSoRVFI1IzD3TFOp=
kBbeSwsmRlUdUKPdhiOMXbTFOABJvxDRBLgLAEt0RvW0cdBG19HgqiR_VceRIA91N$  block
> =20
>  Compute Express Link
>  M: Jonathan Cameron <jonathan.cameron@huawei.com>
> +R: Fan Ni <fan.ni@samsung.com>
>  S: Supported
>  F: hw/cxl/
>  F: hw/mem/cxl_type3.c
> --=20
> 2.37.2
> =
