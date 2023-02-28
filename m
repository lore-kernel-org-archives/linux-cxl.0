Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B20C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 04:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjB1EKs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 23:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1EKr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 23:10:47 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1A1E5FD
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 20:10:46 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230228041045usoutp02b5055c46b95d63e697473106018915df~H4Zvo45gd0129701297usoutp02k;
        Tue, 28 Feb 2023 04:10:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230228041045usoutp02b5055c46b95d63e697473106018915df~H4Zvo45gd0129701297usoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677557446;
        bh=fWjaXWmW4auDU60FiKF9NicTpGBgHK+A/AQBQrzipbM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=IHYoEsqD+xBWXGrILOgxEEn+KfdpfWe+Qm2u/fqMGKCqkG1N0cT+L7jF1MiMacDpu
         IGVGuiwlwvG1iq90fZ7W1QZgiUW44HQOvs1ItPhu6jNkECVy1RBEKREnmP5R2eFK9h
         Fo/AtgiEEg7A8WFxVAbiR9AGqd4gSqC8hLOsjGos=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228041045uscas1p1f3372fd70d3e7c440dc0398b9187d375~H4ZvBXcBy2639726397uscas1p1x;
        Tue, 28 Feb 2023 04:10:45 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id A9.A8.49129.5CE7DF36; Mon,
        27 Feb 2023 23:10:45 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228041044uscas1p1dfa4b92cb69b2f3c37d33c484521b491~H4ZuZUbxQ0410104101uscas1p1D;
        Tue, 28 Feb 2023 04:10:44 +0000 (GMT)
X-AuditID: cbfec36f-167fe7000001bfe9-ab-63fd7ec52737
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 89.99.11378.4CE7DF36; Mon,
        27 Feb 2023 23:10:44 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 27 Feb 2023 20:10:43 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        27 Feb 2023 20:10:43 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 02/10] hw/pci-bridge/cxl_downstream: Fix type naming
 mismatch
Thread-Topic: [PATCH v4 02/10] hw/pci-bridge/cxl_downstream: Fix type naming
        mismatch
Thread-Index: AQHZSyqgwjbj8OwVb0+dL9EHlI49eA==
Date:   Tue, 28 Feb 2023 04:10:43 +0000
Message-ID: <20230228041043.GB1339780@bgt-140510-bm03>
In-Reply-To: <20230206172816.8201-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <116F39B0ECA0AA479AB2EB44811023EA@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djXc7pH6/4mG2xeyWXRPHkxo8WLP8+Z
        LPY/fc5isWrhNTaL87NOsVgc3niGyeL/r1esFmtWCFsc793B4sDpsXPWXXaPliNvWT0W73nJ
        5LFpVSebx51re9g8nlzbzOTxft9VNo/Pm+QCOKK4bFJSczLLUov07RK4Mpac2c5ecJqjYkHn
        XeYGxtnsXYycHBICJhLNjX/Yuhi5OIQEVjJK7LnexgLhtDJJXJ3YxwxTdbthLSNEYi2jxJ+J
        F1ghnE+MEs8u9kBlljFKrFl2lQ2khU1AUWJf13YwW0TASOLdjUlgRcwCX5gkpt7dyAKSEBYI
        k/gyfTYrRFG4xNITOxghbD2JnT0fwS5kEVCV6P/WyARi8wqYSTR1bwer5xRwkJj6fxLYAkYB
        MYnvp9aA1TALiEvcejKfCeJuQYlFs/dA/SAm8W/XQzYIW1Hi/veX7BD1ehI3pk5hg7DtJDZd
        28MKYWtLLFv4mhlir6DEyZlPWCB6JSUOrrgBDiQJgf8cEm8WQhwkIeAiseDBXyhbWuLq9alA
        zRxAdrLEqo9cEOEciflLtkDNsZZY+Gc90wRGlVlIzp6F5KRZSE6aheSkWUhOWsDIuopRvLS4
        ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwpZ3+dzh/B+P1Wx/1DjEycTAeYpTgYFYS4V14+0+y
        EG9KYmVValF+fFFpTmrxIUZpDhYlcV5D25PJQgLpiSWp2ampBalFMFkmDk6pBqb+nTsnpisJ
        nbnw6X5qQd2afXO/rC9e+tbn4ooCW4/Fl7Oex/Jo8C265v9Q9V3AF724FVtdmtkOyfR6XTr1
        ferNCQ7ZIn23c9/57bmY9ZHfb1L3xC1Rn760vzvVmG2+8l6j9Wqrya93Kf7PNJsiEHqCJ9Cx
        U3fxXX4v3tXL323v0H1mUCe4TDbl/GleBYOlcXZ+TIeeL2XNrvq+iMcmqsvSLqew5M2DJuXY
        pIdiP4tKguK7feRSk5ZNPPf81Vy1ry3sLAumvOCPuC38f4X8n+qfruezvfsC+GyL2FMXael5
        Tn11T4JL3UU+KyPywO25ul13rwQElzgz71VqTBKL3PGG20Fg8q8X5316ps2e26fEUpyRaKjF
        XFScCACX1cnL2AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWS2cA0UfdI3d9kg6M35S2aJy9mtHjx5zmT
        xf6nz1ksVi28xmZxftYpFovDG88wWfz/9YrVYs0KYYvjvTtYHDg9ds66y+7RcuQtq8fiPS+Z
        PDat6mTzuHNtD5vHk2ubmTze77vK5vF5k1wARxSXTUpqTmZZapG+XQJXxpIz29kLTnNULOi8
        y9zAOJu9i5GTQ0LAROJ2w1rGLkYuDiGB1YwSdxqWskA4nxglutrfMkM4yxgl1s5cCdbCJqAo
        sa9rOxuILSJgJPHuxiSwdmaBL0wSNz58ZwFJCAuESXyZPpsVoihcYu/Wp8wQtp7Ezp6PYINY
        BFQl+r81MoHYvAJmEk3d28HqhQRKJRp+ngOLcwo4SEz9PwlsGaOAmMT3U2vA4swC4hK3nsxn
        gvhBQGLJnvPMELaoxMvH/1ghbEWJ+99fskPU60ncmDqFDcK2k9h0bQ8rhK0tsWzha2aIGwQl
        Ts58wgLRKylxcMUNlgmMErOQrJuFZNQsJKNmIRk1C8moBYysqxjFS4uLc9Mrig3zUsv1ihNz
        i0vz0vWS83M3MQLTwel/hyN3MB699VHvECMTB+MhRgkOZiUR3oW3/yQL8aYkVlalFuXHF5Xm
        pBYfYpTmYFES5xVynRgvJJCeWJKanZpakFoEk2Xi4JRqYLKxFZtUfnzLiuvLpeedCH7+LvIC
        88/HN9e9srB+Uvf2v9yr0Dhn8aa8NF7m5tyk7Jo4U9cfQYf2eU82NLh1d8Vfvc1l6jKRKT+3
        fA09/uGN8g3nk4qrxAM7+fj1Piy/J3iN+YzbdPbeqkK5ni8PNt7t5XD3Vn7FfdZc6cm90rui
        aubfHz38tGPBmU7pox/kf7k0vZPXjG3dHHzSqb34fdCvmhUvM24eW8FfYLyU+4lSXQPLu64S
        edcTE8sqvzMUXC+z48zIu+OZnavY7zVpXdtCO+n0HSn/+iY4pktN/iIe6b9tX+7HgumLNj8W
        YRO/Kn1Z3zRPwmjDcUGFrvvbXvOrPso+tsXo8tnn98X0XyixFGckGmoxFxUnAgCN2SubdgMA
        AA==
X-CMS-MailID: 20230228041044uscas1p1dfa4b92cb69b2f3c37d33c484521b491
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228041044uscas1p1dfa4b92cb69b2f3c37d33c484521b491
References: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
        <20230206172816.8201-3-Jonathan.Cameron@huawei.com>
        <CGME20230228041044uscas1p1dfa4b92cb69b2f3c37d33c484521b491@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 06, 2023 at 05:28:08PM +0000, Jonathan Cameron wrote:
> Fix capitalization difference between struct name and typedef.
>=20
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/pci-bridge/cxl_downstream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstrea=
m.c
> index 3d4e6b59cd..54f507318f 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -15,7 +15,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "qapi/error.h"
> =20
> -typedef struct CXLDownStreamPort {
> +typedef struct CXLDownstreamPort {
>      /*< private >*/
>      PCIESlot parent_obj;
> =20
> --=20
> 2.37.2
>=20
> =
