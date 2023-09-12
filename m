Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8218ECA0EEB
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 16:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjILQOs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 12:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjILQOr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 12:14:47 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAC10E5
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 09:14:43 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230912161442usoutp02493718226df949e658d1937e2f808bde~EMtxnM12p1898418984usoutp02P;
        Tue, 12 Sep 2023 16:14:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230912161442usoutp02493718226df949e658d1937e2f808bde~EMtxnM12p1898418984usoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694535282;
        bh=wGkaSqDWm/FewYay7BQYkQVtoGPehXvrZCwE9w9U9Os=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=tF63ZyNIyWlJX8AA8dr6f27ABFi1cLV5enyJ8hZjFWGJBJMiEHL7KOvEVwNh7eDoK
         eQrHOXuAT3AFfV6bpElxhHQVnmTnllYfq4hlRzGcSa3KqNgEu7s3YXidAsxVb8GwXQ
         yRRdKjxItHoFDKkHxLUgiSI9N08dsHzEuIn1YH3g=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912161441uscas1p1ffa5f81cf76a1208bb751a1653bb8c91~EMtxhZLjJ3000230002uscas1p12;
        Tue, 12 Sep 2023 16:14:41 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 4C.30.62237.17E80056; Tue,
        12 Sep 2023 12:14:41 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912161441uscas1p11618b32cdd50462c8267f12e1518e590~EMtxQHJb30825908259uscas1p1L;
        Tue, 12 Sep 2023 16:14:41 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-d5-65008e711c6f
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 10.97.28590.17E80056; Tue,
        12 Sep 2023 12:14:41 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 12 Sep 2023 09:14:40 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        12 Sep 2023 09:14:40 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 1/4] hw/cxl: Push cxl_decoder_count_enc() and
 cxl_decode_ig() into .c
Thread-Topic: [PATCH v3 1/4] hw/cxl: Push cxl_decoder_count_enc() and
        cxl_decode_ig() into .c
Thread-Index: AQHZ5KU8sJTQo84yaEm3U62/PXpD0bAX1HyA
Date:   Tue, 12 Sep 2023 16:14:40 +0000
Message-ID: <20230912161343.GA319114@bgt-140510-bm03>
In-Reply-To: <20230911114313.6144-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F6D7216C74B1BD4CA04EE2AD18F3AD8E@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djX87qFfQypBptvG1isWniNzeL8rFMs
        Foc3nmGy+P/rFavFmhXCFsd7d7A4sHm0HHnL6nHn2h42jyfXNjN5vN93lc3j8ya5ANYoLpuU
        1JzMstQifbsEroxTJ0+zFKwUqeho/cTewHiAv4uRk0NCwETi44WHLF2MXBxCAisZJc50ToZy
        Wpkk3jZ+Z4epmtGwAyqxllHixdIDbBDOJ0aJpf+boZxljBL3t3axgrSwCShK7OvazgZiiwgY
        Sby7MYkRpIhZoIFJ4tq9c2BzhQXiJM5cO8gOURQvsXvRUaAdHGANx1tkQcIsAqoS2/ZPZAGx
        eQVMJRZfP8QMUsIp4CBx64QKSJhRQEzi+6k1TCA2s4C4xK0n85kgrhaUWDR7DzOELSbxb9dD
        NghbUeL+95fsEPV6EjemTmGDsO0kbk2dBWVrSyxb+JoZYq2gxMmZT1ggeiUlDq64AQ4JCYEr
        HBK/drRAg8hF4tyvmawQtrTE1etTwe6UEEiWWPWRCyKcIzF/yRaoOdYSC/+sZ5rAqDILydmz
        kJw0C8lJs5CcNAvJSQsYWVcxipcWF+empxYb56WW6xUn5haX5qXrJefnbmIEpqTT/w4X7GC8
        deuj3iFGJg7GQ4wSHMxKIrwlh/6mCPGmJFZWpRblxxeV5qQWH2KU5mBREuc1tD2ZLCSQnliS
        mp2aWpBaBJNl4uCUamDa9jw7j3mZWUTH1jVT3Zf96N/SaVXhrPHmtCfT9f1vHu4r/MjMdius
        duuplb7vD+2337S+Z4b+7ffzl9dpbb/bbrqtKZ9zHs+lpFVe06V1/fYEcJhukJEykv53KUX2
        6baWCVeyLbvD7tjX596zsIjeJ7fEOGN63II1mV3fdJet4zEOnFfLyn3WI9TasGBhM+d/zr07
        1nNkbW1Zv73oSWbKGz6W1RHcSzz/zq0pb7K7c2VRxSwJt9lLggU6d96IFIy+oSwtpvXLlLl+
        wZuYWYtOB02aX5uyiZf7zyPuZat3e07ma9vG4bpCc8es+ECx77POTNn6bLteXl9qlhR3zx2l
        WP3w6D3/523ZsijGov6PEktxRqKhFnNRcSIAsXt9J7gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWS2cA0SbewjyHVYMNfWYtVC6+xWZyfdYrF
        4vDGM0wW/3+9YrVYs0LY4njvDhYHNo+WI29ZPe5c28Pm8eTaZiaP9/uusnl83iQXwBrFZZOS
        mpNZllqkb5fAlXHq5GmWgpUiFR2tn9gbGA/wdzFyckgImEjMaNjB0sXIxSEksJpRYvnNWewQ
        zidGiQ99k5khnGWMEvsvPGcBaWETUJTY17WdDcQWETCSeHdjEiNIEbNAA5NE672jjCAJYYE4
        iTPXDrJDFMVL/HszGaiZA6zheIssSJhFQFVi2/6JYDN5BUwlFl8/xAxiCwmUSqzavogNpJxT
        wEHi1gkVkDCjgJjE91NrmEBsZgFxiVtP5jNBfCAgsWTPeWYIW1Ti5eN/rBC2osT97y/ZIer1
        JG5MncIGYdtJ3Jo6C8rWlli28DUzxAmCEidnPmGB6JWUOLjiBssERolZSNbNQjJqFpJRs5CM
        moVk1AJG1lWM4qXFxbnpFcWGeanlesWJucWleel6yfm5mxiB8Xz63+HIHYxHb33UO8TIxMF4
        iFGCg1lJhLfk0N8UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rw7plxMERJITyxJzU5NLUgtgsky
        cXBKNTCderpq88OVMsyOfhxXpT6yRPVmnEjfP+nGefYzu/Ztf6Qh9sko53uBlPaJj/6fvO/8
        EE7fks718fWftS1Z8zamFWSsiFnw4s/Gjx1m/NyVrXfDNqo3zjy5xJhz/5a5FlOvNpbrrTiY
        mbYsVFk3PTP/udBfRiWOgNPSxuI26VfPrnzNGDNJ2fNUi5nC27Dba4X5Ot7xXk38bfVuvVIx
        76HHYQxH/mRrLr9xqbjyhLFsy+bDrRGhh7tv+7244XYwoCg096fSUQ+WgIiGdFYbrZ4ogeDY
        l0UBPhHzKgLtP57+d7nhG+fH38GBLPvPHeH7ebclq10wkl8yKm+y5NOlcnp3ZkV/Xvj6oLRC
        iK/Jrr1KLMUZiYZazEXFiQDx5aYWVgMAAA==
X-CMS-MailID: 20230912161441uscas1p11618b32cdd50462c8267f12e1518e590
CMS-TYPE: 301P
X-CMS-RootMailID: 20230912161441uscas1p11618b32cdd50462c8267f12e1518e590
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
        <20230911114313.6144-2-Jonathan.Cameron@huawei.com>
        <CGME20230912161441uscas1p11618b32cdd50462c8267f12e1518e590@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 11, 2023 at 12:43:10PM +0100, Jonathan Cameron wrote:

> There is no strong justification for keeping these in the header
> so push them down into the associated cxl-component-utils.c file.
>=20
> Suggested-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_component.h | 18 ++----------------
>  hw/cxl/cxl-component-utils.c   | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_componen=
t.h
> index 42c7e581a7..bdb3881a6b 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -225,26 +225,12 @@ void cxl_component_create_dvsec(CXLComponentState *=
cxl_cstate,
>                                  enum reg_type cxl_dev_type, uint16_t len=
gth,
>                                  uint16_t type, uint8_t rev, uint8_t *bod=
y);
> =20
> -static inline int cxl_decoder_count_enc(int count)
> -{
> -    switch (count) {
> -    case 1: return 0;
> -    case 2: return 1;
> -    case 4: return 2;
> -    case 6: return 3;
> -    case 8: return 4;
> -    case 10: return 5;
> -    }
> -    return 0;
> -}
> +int cxl_decoder_count_enc(int count);
> =20
>  uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
>  uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
> =20
> -static inline hwaddr cxl_decode_ig(int ig)
> -{
> -    return 1ULL << (ig + 8);
> -}
> +hwaddr cxl_decode_ig(int ig);
> =20
>  CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
>  bool cxl_get_hb_passthrough(PCIHostState *hb);
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 378f1082ce..ea2d4770ec 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -13,6 +13,24 @@
>  #include "hw/pci/pci.h"
>  #include "hw/cxl/cxl.h"
> =20
> +int cxl_decoder_count_enc(int count)
> +{
> +    switch (count) {
> +    case 1: return 0;
> +    case 2: return 1;
> +    case 4: return 2;
> +    case 6: return 3;
> +    case 8: return 4;
> +    case 10: return 5;
> +    }
> +    return 0;
> +}
> +
> +hwaddr cxl_decode_ig(int ig)
> +{
> +    return 1ULL << (ig + 8);
> +}
> +
>  static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
>                                         unsigned size)
>  {
> --=20
> 2.39.2
>=20
> =
