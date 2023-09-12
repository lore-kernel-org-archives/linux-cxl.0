Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17A2CA0EF9
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 17:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjILRUM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjILRUM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 13:20:12 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AC710D9
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 10:20:08 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230912172007usoutp017f77180f11ab4977ba470917a73b2389~ENm5GsvY43050830508usoutp01z;
        Tue, 12 Sep 2023 17:20:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230912172007usoutp017f77180f11ab4977ba470917a73b2389~ENm5GsvY43050830508usoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694539207;
        bh=CIxYPRTkuFpoAChnuA/tH4z8/j7yUnW2sG8f8hgyxeA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Puiukjuz7onofxesLN4m45RcUQFHb1vfY6Ye86b3FSicjBIqUkM0thX79TbPwp3Qu
         7HG+I1qmoM3avcPPb8Ya4pAG1eskazJV+8JiWwH2tZXK2XjK1DbqFvG4v4LSwFE5ew
         5wNAcZ2ZYlcfFfdqabMp1RibCPx9jJVbc3V4T1Pc=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230912172006uscas1p2dfc0c64b49b2e7d42ccb360058282069~ENm4-EeSk0315503155uscas1p2I;
        Tue, 12 Sep 2023 17:20:06 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id C0.D1.50148.6CD90056; Tue,
        12 Sep 2023 13:20:06 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912172006uscas1p1f48a880aeaf7fad3400929d4bc919ae5~ENm4vrGDb3162831628uscas1p1u;
        Tue, 12 Sep 2023 17:20:06 +0000 (GMT)
X-AuditID: cbfec36d-7bdff7000002c3e4-f8-65009dc68c57
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id E7.D8.31200.6CD90056; Tue,
        12 Sep 2023 13:20:06 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 12 Sep 2023 10:20:05 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        12 Sep 2023 10:20:05 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 2/4] hw/cxl: Add utility functions decoder interleave
 ways and target count.
Thread-Topic: [PATCH v3 2/4] hw/cxl: Add utility functions decoder
        interleave ways and target count.
Thread-Index: AQHZ5KVVRlx6CQB570OdfIT+NsNCjbAX5syA
Date:   Tue, 12 Sep 2023 17:20:05 +0000
Message-ID: <20230912172005.GB319114@bgt-140510-bm03>
In-Reply-To: <20230911114313.6144-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <53B52ADF7766A545881FFEF2F17B3A21@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djX87rH5jKkGqycaWqxauE1Novzs06x
        WBzeeIbJ4v+vV6wWa1YIWxzv3cHiwObRcuQtq8eda3vYPJ5c28zk8X7fVTaPz5vkAlijuGxS
        UnMyy1KL9O0SuDIOfn3GWjBBqeLB3W+MDYxXJLsYOTgkBEwk9m1P72Lk4hASWMko0fOtnQXC
        aWWS+DLlN3sXIydY0ePTbxghEmsZJX6+eckE4XxilPjbtRkqs4xR4tfxFjaQFjYBRYl9XdvB
        bBEBI4l3NyaBFTELNDBJXLt3DmyusECqxNu53Wwgh4gIpEncOx4CU/9z6VUWEJtFQFXi24KT
        YOW8AqYSvVe3MYLYnAIOEucn/mcGsRkFxCS+n1rDBGIzC4hL3HoynwnibEGJRbP3MEPYYhL/
        dj1kg7AVJe5/f8kOUa8ncWPqFDYI207i/KJ7zBC2tsSyha+ZIfYKSpyc+YQFoldS4uCKG+Aw
        khA4wyGxrmMT1DIXicfrTkMtk5b4e3cZEySAkyVWfeSCCOdIzF+yBWqOtcTCP+uZJjCqzEJy
        9iwkJ81CctIsJCfNQnLSAkbWVYzipcXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIEp6fS/w7k7
        GHfc+qh3iJGJg/EQowQHs5IIb8mhvylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ1tTyYLCaQn
        lqRmp6YWpBbBZJk4OKUamLZrPMpdJ7U05lDqDWGJ1Cqe469XX+rc7iCxSfd4r1/KiUt9WQF7
        Z03zLr77/jWv4nT9xX9tVivy/zsfM1emX32mb8dr72DlPQ5XVjUIM15+eEev92jDkXifSPWz
        ApucbGOkfp64l6M1t/zZFgWO8peefzk++Wz5JRxd/1R5eurEd992NE7lvnLy+Y0dziKaqz8e
        9Z8UeehfgW53n6vNx7KovAunll0VVN+eXvB+lctb+U83HBtCDapf2z57zfc96+jvp99VLuuc
        DeWW6pyd79ZSu/TZ7nyLC06ryrw2r83d81v+s3kfz2OBZY+yZvE/uHp9dsTrTWcPvd3dbrz7
        7RSLk1PPPZe+unGnzyLnZJMwJZbijERDLeai4kQAS5yqo7gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWS2cA0SffYXIZUg81T5SxWLbzGZnF+1ikW
        i8MbzzBZ/P/1itVizQphi+O9O1gc2Dxajrxl9bhzbQ+bx5Nrm5k83u+7yubxeZNcAGsUl01K
        ak5mWWqRvl0CV8bBr89YCyYoVTy4+42xgfGKZBcjJ4eEgInE49NvGEFsIYHVjBLvzhVC2J8Y
        JdZd0uxi5AKylzFKzJ7UzQSSYBNQlNjXtZ0NxBYRMJJ4d2MSI0gRs0ADk0TrvaNgk4QFUiXe
        zu2GKkqT2DL1ATtMw8+lV1lAbBYBVYlvC06CxXkFTCV6r26DuqJUYubkz2A2p4CDxPmJ/5lB
        bEYBMYnvp9aAHcEsIC5x68l8JogPBCSW7DnPDGGLSrx8/I8VwlaUuP/9JTtEvZ7EjalT2CBs
        O4nzi+4xQ9jaEssWvmaGuEFQ4uTMJywQvZISB1fcYJnAKDELybpZSEbNQjJqFpJRs5CMWsDI
        uopRvLS4ODe9otgoL7Vcrzgxt7g0L10vOT93EyMwnk//Oxy9g/H2rY96hxiZOBgPMUpwMCuJ
        8JYc+psixJuSWFmVWpQfX1Sak1p8iFGag0VJnHfHlIspQgLpiSWp2ampBalFMFkmDk6pBqae
        /8zdb7+mfZz6Z9Hc9taTUivUGY8Lf+k5teGHw4t037X9RpJHLJMePXpjo/k1JvnA9YtZfXvM
        uI2mqCjln7AQOfRh9XY1rk0f1gk117z983360eDO7GlKuxbJKZRN8ih9vqnnukNloeyxU/d2
        vJfebDjJLML+tzKLz/VdVfxbn5o12e8pKTd9ZBqRMFVmqkznlVOqkyQP7E+c1X5bcs7egESf
        TjlRpueT4nTL3Ts6e85UP7v55ZtOlsprhYP7gh3q09Ye2WwRndezntlbbpH/p2dBxvxywbIv
        28//e7LK9t/9lbFWTNc0PLX/NzxiFg5elPAr+FT1ga1zSrWP3/JJO2d1637ujbzepTP+/2NU
        YinOSDTUYi4qTgQAWqBrnVYDAAA=
X-CMS-MailID: 20230912172006uscas1p1f48a880aeaf7fad3400929d4bc919ae5
CMS-TYPE: 301P
X-CMS-RootMailID: 20230912172006uscas1p1f48a880aeaf7fad3400929d4bc919ae5
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
        <20230911114313.6144-3-Jonathan.Cameron@huawei.com>
        <CGME20230912172006uscas1p1f48a880aeaf7fad3400929d4bc919ae5@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 11, 2023 at 12:43:11PM +0100, Jonathan Cameron wrote:

> As an encoded version of these key configuration parameters is available
> in a register, provide functions to extract it again so as to avoid
> the need for duplicating the storage.
>=20
> Whilst here update the _enc() function to include additional values
> as defined in the CXL 3.0 specification. Whilst they are not
> currently used in the emulation, they may be in future and it is
> easier to compare with the specification if all values are covered.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

LGTM. Only one minor comment inline.

Reviewed-by: Fan Ni <fan.ni@samsung.com>


> v3: No changes, picked up tags.
> v2: Thanks to Philippe Mathieu-Daud=E9
>  - Expand both enc() and dec() functions to include full set of values
>    defined in CXL r3.0
>  - Pushed implementation down into the .c file.
> ---
>  include/hw/cxl/cxl_component.h |  2 ++
>  hw/cxl/cxl-component-utils.c   | 59 ++++++++++++++++++++++++++++++----
>  2 files changed, 55 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_componen=
t.h
> index bdb3881a6b..ef9e033919 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -226,8 +226,10 @@ void cxl_component_create_dvsec(CXLComponentState *c=
xl_cstate,
>                                  uint16_t type, uint8_t rev, uint8_t *bod=
y);
> =20
>  int cxl_decoder_count_enc(int count);
> +int cxl_decoder_count_dec(int enc_cnt);
> =20
>  uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
> +int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp);
>  uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
> =20
>  hwaddr cxl_decode_ig(int ig);
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index ea2d4770ec..352d0dace2 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -13,15 +13,45 @@
>  #include "hw/pci/pci.h"
>  #include "hw/cxl/cxl.h"
> =20
> +/* CXL r3.0 Section 8.2.4.19.1 CXL HDM Decoder Capability Register */
>  int cxl_decoder_count_enc(int count)
>  {
>      switch (count) {
> -    case 1: return 0;
> -    case 2: return 1;
> -    case 4: return 2;
> -    case 6: return 3;
> -    case 8: return 4;
> -    case 10: return 5;
> +    case 1: return 0x0;
> +    case 2: return 0x1;
> +    case 4: return 0x2;
> +    case 6: return 0x3;
> +    case 8: return 0x4;
> +    case 10: return 0x5;
> +    /* Switches and Host Bridges may have more than 10 decoders */
> +    case 12: return 0x6;
> +    case 14: return 0x7;
> +    case 16: return 0x8;
> +    case 20: return 0x9;
> +    case 24: return 0xa;
> +    case 28: return 0xb;
> +    case 32: return 0xc;
> +    }
> +    return 0;
> +}
> +
> +int cxl_decoder_count_dec(int enc_cnt)
> +{
> +    switch (enc_cnt) {
> +    case 0x0: return 1;
> +    case 0x1: return 2;
> +    case 0x2: return 4;
> +    case 0x3: return 6;
> +    case 0x4: return 8;
> +    case 0x5: return 10;
> +    /* Switches and Host Bridges may have more than 10 decoders */
> +    case 0x6: return 12;
> +    case 0x7: return 14;
> +    case 0x8: return 16;
> +    case 0x9: return 20;
> +    case 0xa: return 24;
> +    case 0xb: return 28;
> +    case 0xc: return 32;
>      }
>      return 0;
>  }
> @@ -410,6 +440,23 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp=
)
>      }
>  }
> =20

Similar as decoder count dec/enc, maybe we want to add a line of comment be=
low.
/* CXL r3.0 Section 8.2.4.19.7 CXL HDM Decoder n Control Register */

Fan
> +int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp)
> +{
> +    switch (iw_enc) {
> +    case 0x0: return 1;
> +    case 0x1: return 2;
> +    case 0x2: return 4;
> +    case 0x3: return 8;
> +    case 0x4: return 16;
> +    case 0x8: return 3;
> +    case 0x9: return 6;
> +    case 0xa: return 12;
> +    default:
> +        error_setg(errp, "Encoded interleave ways: %d not supported", iw=
_enc);
> +        return 0;
> +    }
> +}
> +
>  uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp)
>  {
>      switch (gran) {
> --=20
> 2.39.2
>=20
> =
