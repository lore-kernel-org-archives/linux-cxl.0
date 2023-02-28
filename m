Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD94C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 04:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjB1EOW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 23:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjB1EOV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 23:14:21 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E9B22021
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 20:14:20 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230228041419usoutp01a007b0742f8757e280b7145fa49b4beb~H4c2ZbiUE1359613596usoutp016;
        Tue, 28 Feb 2023 04:14:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230228041419usoutp01a007b0742f8757e280b7145fa49b4beb~H4c2ZbiUE1359613596usoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677557659;
        bh=AGDzX+qIjpiHkfk/sGvGhobxIWQy/XxC1an2DJtii4M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Z4qeDWza/Qh1vhwzRRx1zmVLB/cbQbSJ3gkXOqOZZT9BPsjszy7j/1IRMSDYEmoPb
         9f5qF8I5Gp3D1Uso8AS4d/9A9B9zWfGMzBHqw0onh3/uh86t0mMisIGcqJgcL73B++
         27dii+NZ7LW7S08ZTXtAOMdDBvmX863Uyi6yav80=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228041419uscas1p22aba74f86ec2bc87ec646f20129ae54b~H4c2SELn21227212272uscas1p2w;
        Tue, 28 Feb 2023 04:14:19 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 3B.EB.06976.B9F7DF36; Mon,
        27 Feb 2023 23:14:19 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228041419uscas1p1b9d933dc37c4b6369ef1dea03a54c9e4~H4c2Ev71i2103021030uscas1p12;
        Tue, 28 Feb 2023 04:14:19 +0000 (GMT)
X-AuditID: cbfec36d-afdff70000011b40-a4-63fd7f9b82c6
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 76.B9.11378.A9F7DF36; Mon,
        27 Feb 2023 23:14:18 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 27 Feb 2023 20:14:18 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        27 Feb 2023 20:14:18 -0800
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
Subject: Re: [PATCH v4 08/10] qemu/bswap: Add const_le64()
Thread-Topic: [PATCH v4 08/10] qemu/bswap: Add const_le64()
Thread-Index: AQHZSysgfxoOm0uIsUCJEp/Zj+u25Q==
Date:   Tue, 28 Feb 2023 04:14:18 +0000
Message-ID: <20230228041417.GH1339780@bgt-140510-bm03>
In-Reply-To: <20230206172816.8201-9-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <03187EE6F7FE864AA2CAF60663F126FD@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djX87qz6/8mG0w6zmPRPHkxo8WLP8+Z
        LPY/fc5isWrhNTaL87NOsVgc3niGyeL/r1esFmtWCFsc793B4sDpsXPWXXaPliNvWT0W73nJ
        5LFpVSebx51re9g8nlzbzOTxft9VNo/Pm+QCOKK4bFJSczLLUov07RK4MrbtPc9ccEuw4tmZ
        M0wNjL28XYycHBICJhIn2z8zgdhCAisZJU5Nte1i5AKyW5kkXs9cwtzFyAFWNGOGNkR8LaNE
        +5Z9TBDOJ0aJCa/nskE4yxglupaeYwUZxSagKLGvazsbiC0iYCTx7sYkRpAiZoEvTBJT725k
        AUkIC1hJLJrwiA1khYiAtURbnw5EvZ7Ew/U7wE5iEVCV2HL4Dlg5r4CZxKF1Z8Fmcgo4SFyd
        vZAdxGYUEJP4fmoNWD2zgLjErSfzmSBeE5RYNHsPM4QtJvFv10M2CFtR4v73l+wQ9XoSN6ZO
        YYOw7SROX73MCGFrSyxb+JoZYq+gxMmZT1ggeiUlDq64wQLyi4RAM6fEugfPoJa5SJyePpsV
        wpaWuHp9KjTokiVWfeSCCOdIzF+yBWqOtcTCP+uZJjCqzEJy9iwkJ81CctIsJCfNQnLSAkbW
        VYzipcXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIHJ7PS/w7k7GHfc+qh3iJGJg/EQowQHs5II
        78Lbf5KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrankwWEkhPLEnNTk0tSC2CyTJxcEo1MPVz
        pk1fduY6Y73SdZll9e53bxosl/G/Y3gz4cKanJmcHUef1WheUznx+dLDqtr6DIuqOQ63/75S
        uLtN2uTuy8Dl6gte8BxNMcqYNmumyob/yU9kq5knbNb1ZQ51dHmx/mRCddORbWtL/9Q+EmVe
        whe28FL96mIf1pMtc7M2frfxZuCS85i7Vq9i/6EVJvO/VEe+WaJw4KddD+PVw5rNT3alXM6c
        4GP49tT8Yyt2zeu/mXYx0qP0/etgy9eCSRZapS19950v1QVYT8nbFdbyiPlktUnp5P3esyUv
        O3RrPfYUfh7f1lGj51Op3Onz7mii3U/ZufNc69ZPK/DYlTBXx2cup4eCdlIgU+wvEev5Tkos
        xRmJhlrMRcWJAEdTDWvVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWS2cA0UXdW/d9kg0uLzCyaJy9mtHjx5zmT
        xf6nz1ksVi28xmZxftYpFovDG88wWfz/9YrVYs0KYYvjvTtYHDg9ds66y+7RcuQtq8fiPS+Z
        PDat6mTzuHNtD5vHk2ubmTze77vK5vF5k1wARxSXTUpqTmZZapG+XQJXxra955kLbglWPDtz
        hqmBsZe3i5GDQ0LARGLGDO0uRi4OIYHVjBK3W5YzQTifGCVWX/3I1sXICeQsY5TYe8ANxGYT
        UJTY17UdLC4iYCTx7sYkRpAGZoEvTBI3PnxnAUkIC1hJLJrwiA1kg4iAtURbnw5EvZ7Ew/U7
        mEBsFgFViS2H74CV8wqYSRxadxZqV6nE+d8f2UFsTgEHiauzF4LZjAJiEt9PrQHrZRYQl7j1
        ZD6YLSEgILFkz3lmCFtU4uXjf6wQtqLE/e8v2SHq9SRuTJ3CBmHbSZy+epkRwtaWWLbwNTPE
        DYISJ2c+YYHolZQ4uOIGywRGiVlI1s1CMmoWklGzkIyahWTUAkbWVYzipcXFuekVxYZ5qeV6
        xYm5xaV56XrJ+bmbGIGJ4PS/w5E7GI/e+qh3iJGJg/EQowQHs5II78Lbf5KFeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ8wq5TowXEkhPLEnNTk0tSC2CyTJxcEo1MPnP+dgl3OySsDy26V7y25f/
        gkqbDTL+XLksfqZq2jQG601Hb3Ha9k/i+bY1gV/lSOtX2Z3Xq7+/KF6+9IzX56OiMkfmPvm8
        6L/dlgnzItYpNV4pvM1rFMOb+VE5elZw0sIA7StrfL55TFk2p06LJ2PKnoupZ205Qjc9unVW
        zenVTK/jh6RP1B/hsT2a81S8pj2juvtwuAOb3qHJH0KUr8702Tk/PHj62poY441rIhY2nKn/
        Zrrh09FpJtU2DrddnS+u33bdrNNkqljtmcg3978/W5NY+ffU9n2Mt7zVtR7cMbPWT/jA/5vJ
        pumfjV1Gy8yHAVO2X7Wdcy+4ze3Wi3uiNn03OmObRbhdl9zdynxIiaU4I9FQi7moOBEAO13D
        TXMDAAA=
X-CMS-MailID: 20230228041419uscas1p1b9d933dc37c4b6369ef1dea03a54c9e4
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228041419uscas1p1b9d933dc37c4b6369ef1dea03a54c9e4
References: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
        <20230206172816.8201-9-Jonathan.Cameron@huawei.com>
        <CGME20230228041419uscas1p1b9d933dc37c4b6369ef1dea03a54c9e4@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 06, 2023 at 05:28:14PM +0000, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> Gcc requires constant versions of cpu_to_le* calls.
>=20
> Add a 64 bit version.
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> v2: Update comment (Philippe)
> ---
>  include/qemu/bswap.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 3cbe52246b..eb3bcf2520 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -129,11 +129,20 @@ CPU_CONVERT(le, 32, uint32_t)
>  CPU_CONVERT(le, 64, uint64_t)
> =20
>  /*
> - * Same as cpu_to_le{16,32}, except that gcc will figure the result is
> + * Same as cpu_to_le{16,32,64}, except that gcc will figure the result i=
s
>   * a compile-time constant if you pass in a constant.  So this can be
>   * used to initialize static variables.
>   */
>  #if HOST_BIG_ENDIAN
> +# define const_le64(_x)                          \
> +    ((((_x) & 0x00000000000000ffU) << 56) |      \
> +     (((_x) & 0x000000000000ff00U) << 40) |      \
> +     (((_x) & 0x0000000000ff0000U) << 24) |      \
> +     (((_x) & 0x00000000ff000000U) <<  8) |      \
> +     (((_x) & 0x000000ff00000000U) >>  8) |      \
> +     (((_x) & 0x0000ff0000000000U) >> 24) |      \
> +     (((_x) & 0x00ff000000000000U) >> 40) |      \
> +     (((_x) & 0xff00000000000000U) >> 56))
>  # define const_le32(_x)                          \
>      ((((_x) & 0x000000ffU) << 24) |              \
>       (((_x) & 0x0000ff00U) <<  8) |              \
> @@ -143,6 +152,7 @@ CPU_CONVERT(le, 64, uint64_t)
>      ((((_x) & 0x00ff) << 8) |                    \
>       (((_x) & 0xff00) >> 8))
>  #else
> +# define const_le64(_x) (_x)
>  # define const_le32(_x) (_x)
>  # define const_le16(_x) (_x)
>  #endif
> --=20
> 2.37.2
>=20
> =
