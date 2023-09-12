Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0EBEE3F34
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 21:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjILVXI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 17:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjILVXI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 17:23:08 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3253610CA
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 14:23:04 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230912212303usoutp014d96b8a55d6601fe26fec7994d390852~EQ7AiGjdL0625206252usoutp01N;
        Tue, 12 Sep 2023 21:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230912212303usoutp014d96b8a55d6601fe26fec7994d390852~EQ7AiGjdL0625206252usoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694553783;
        bh=8QiLjrsB6UXcOPsutDOKFdtaBK4AxNomT8fmeKQ+8zo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bpps66z9fSYmFelPNjl7Fq4b2GVaUAxYTXLKTmvC7IuaGDpRRBbGtYQXs1xKUqhYO
         lgiw25NjNZ2lUVrmIDHy24EReezn/tE5/WcMyDtWmmcEO3aK/+JtJeKCmwvQgLfItp
         5FA7ppTq6caHEM0HiPpxIHQAGWea97XiX3VmPxEY=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912212303uscas1p16e4a6e3e63a31d865de8ef0a37ab12c5~EQ7ASVhqz2091020910uscas1p1l;
        Tue, 12 Sep 2023 21:23:03 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 96.3B.50148.7B6D0056; Tue,
        12 Sep 2023 17:23:03 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912212302uscas1p193035f5b79733ff9f629818ac8af8563~EQ6-8VCGN0116101161uscas1p1B;
        Tue, 12 Sep 2023 21:23:02 +0000 (GMT)
X-AuditID: cbfec36d-7bdff7000002c3e4-e5-6500d6b7f171
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id A4.C2.31200.6B6D0056; Tue,
        12 Sep 2023 17:23:02 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 12 Sep 2023 14:23:02 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        12 Sep 2023 14:23:02 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Li Zhijian" <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH 2/4] hw/pci-bridge/cxl_upstream: Fix bandwidth entry
 base unit for SSLBIS
Thread-Topic: [PATCH 2/4] hw/pci-bridge/cxl_upstream: Fix bandwidth entry
        base unit for SSLBIS
Thread-Index: AQHZ3zPM+ZgJWEgcE0KcpE9kV6yXi7AYNY+A
Date:   Tue, 12 Sep 2023 21:23:02 +0000
Message-ID: <20230912212301.GB2859961@sjcvldevvm72>
In-Reply-To: <20230904132806.6094-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <21E094BC17AA594394703E39FC90162F@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djX87rbrzGkGnTN4bU4cbORzWLVwmts
        FudnnWKxOLzxDJPFulv/WS3+/3rFarFmhbDF8d4dLA4cHv8PTmL2aDnyltVj8Z6XTB53ru1h
        83hybTOTx/t9V9k8Pm+SC2CP4rJJSc3JLEst0rdL4MpY+/EIc8EtrooXnX9YGhjXc3QxcnJI
        CJhIbL3bww5iCwmsZJRYvFu3i5ELyG5lklg85QwrTNGzO13sEIm1jBJ3p/5kg3A+MUo0zpnI
        DOEsY5S4vPEsI0gLm4CixL6u7WwgtoiAkcS7G5PA4swC55gkGtaYgdjCAvEScybOYIeoSZBo
        PL2OHab+YcstFhCbRUBVomXLRCYQm1fAWOL2hgfMIDangIPE++ePwGxGATGJ76fWMEHMF5e4
        9WQ+E8TZghKLZu9hhrDFJP7tesgGYStK3P/+kh2iXk/ixtQpbBC2ncTxSWdYIGxtiWULXzND
        7BWUODnzCQtEr6TEwRU3WEAelhB4wSHxb8EqqGUuEpd7e6CWSUv8vbsMKM4BZCdLrPrIBRHO
        kZi/ZAvUHGuJhX/WM01gVJmF5OxZSE6aheSkWUhOmoXkpAWMrKsYxUuLi3PTU4sN81LL9YoT
        c4tL89L1kvNzNzECU9fpf4dzdzDuuPVR7xAjEwfjIUYJDmYlEd6SQ39ThHhTEiurUovy44tK
        c1KLDzFKc7AoifMa2p5MFhJITyxJzU5NLUgtgskycXBKNTAt71cqPeSqfS83m6NnSrrk1wXv
        oi5mXAt4+r72yjHeBv8Lz6W9pZj2b1q9crH16q8HakQmeSrz77lmJHXK8bzvAem4wxf6ir9e
        51z/aoYxa/E21rOz43kqlicrVghdSuPzmMQocFpe+tf32bkKGs/Ndmgq7ajS+Xazm3HPib5D
        YnYl0Y1pT9+vCOU98qh23eXnm+S6LmnWr77wOEjnl/HVZat0Vnzx9mC5eEjX1enpMt64Kgle
        /k6967cNGptCN91ds0NQaimrZ11O/Hx2v++WG/SbD6/VLtDfVSYxPT4lX3GlSyznW0lr74dB
        hf5hQt+YnXZHyrO9jv+wNrNN/MVuzX6VpeuX7v8aZHwo5IwSS3FGoqEWc1FxIgAxh7i7zAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWS2cA0UXfbNYZUg2UtBhYnbjayWaxaeI3N
        4vysUywWhzeeYbJYd+s/q8X/X69YLdasELY43ruDxYHD4//BScweLUfesnos3vOSyePOtT1s
        Hk+ubWbyeL/vKpvH501yAexRXDYpqTmZZalF+nYJXBlrPx5hLrjFVfGi8w9LA+N6ji5GTg4J
        AROJZ3e62LsYuTiEBFYzSizZ8IANwvnEKDGl+TwzhLOMUWJeywxGkBY2AUWJfV3b2UBsEQEj
        iXc3JoHFmQXOMUk0rDEDsYUF4iX2TZ/IClGTIPG8cx8LTP3DlltgNouAqkTLlolMIDavgLHE
        7Q0PoJadZJRYdHYNWIJTwEHi/fNHzCA2o4CYxPdTEHFmAXGJW0/mM0H8ICCxZM95ZghbVOLl
        43+sELaixP3vL9kh6vUkbkydwgZh20kcn3SGBcLWlli28DUzxBGCEidnPmGB6JWUOLjiBssE
        RolZSNbNQjJqFpJRs5CMmoVk1AJG1lWM4qXFxbnpFcVGeanlesWJucWleel6yfm5mxiBsX/6
        3+HoHYy3b33UO8TIxMF4iFGCg1lJhLfk0N8UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rw7plxM
        ERJITyxJzU5NLUgtgskycXBKNTBxK1QtV7HrmLU093J1htBhCft9Eq7JRQwh2Tf/rNFS+pz0
        ovn8K/044eg7zFcEg/r/np5W5rAg4qtmXUXsT69zezxeXQ2Rky8RVJLbP/OSxsLczBuLJdgf
        Cs47bRFn8vDm7Za6tM0L06P9WmdX+s/QKRYwefrq3tanYndXLeFMnH3KyctgpmNbSt3/eQpH
        PKv9rFvmHNYq9/S+fuKRUVGk1hH3y0GRlqWv/ZNaWmatyNX49ldY+dF5zy+8mn9yzSPMJoUE
        Ml9S5bp+abLl7hW+BSv38/3v44hrWKqfFnxw6bRJ7dbzjFsWv7/xQPP3zB0Shb2mN14svLao
        0eGMT/JW1sd6X85+TC2ruvm700eJpTgj0VCLuag4EQAxvS38bAMAAA==
X-CMS-MailID: 20230912212302uscas1p193035f5b79733ff9f629818ac8af8563
CMS-TYPE: 301P
X-CMS-RootMailID: 20230904132912uscas1p29dfa643f4f9aeb9397cc17e05800e55c
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
        <CGME20230904132912uscas1p29dfa643f4f9aeb9397cc17e05800e55c@uscas1p2.samsung.com>
        <20230904132806.6094-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 04, 2023 at 02:28:04PM +0100, Jonathan Cameron wrote:
> From: Dave Jiang <dave.jiang@intel.com>
>=20
> According to ACPI spec 6.5 5.2.28.4 System Locality Latency and Bandwidth
> Information Structure, if the "Entry Base Unit" is 1024 for BW and the
> matrix entry has the value of 100, the BW is 100 GB/s. So the
> entry_base_unit should be changed from 1000 to 1024 given the comment not=
es
> it's 16GB/s for .latency_bandwidth.
>=20
> Fixes: 882877fc359d ("hw/pci-bridge/cxl-upstream: Add a CDAT table access=
 DOE")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/pci-bridge/cxl_upstream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 9159f48a8c..2b9cf0cc97 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -262,7 +262,7 @@ static int build_cdat_table(CDATSubHeader ***cdat_tab=
le, void *priv)
>                  .length =3D sslbis_size,
>              },
>              .data_type =3D HMATLB_DATA_TYPE_ACCESS_BANDWIDTH,
> -            .entry_base_unit =3D 1000,
> +            .entry_base_unit =3D 1024,
>          },
>      };
> =20
> --=20
> 2.39.2
> =
