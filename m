Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3476AEE3F00
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 18:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjILSIw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbjILSIv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 14:08:51 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA710E6
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 11:08:47 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230912180846usoutp02505cce85f3ca7c010b2383ad857c1896~EORXmK49D2333423334usoutp02E;
        Tue, 12 Sep 2023 18:08:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230912180846usoutp02505cce85f3ca7c010b2383ad857c1896~EORXmK49D2333423334usoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694542126;
        bh=jv0LV8utv1i7ApfFwqwNk7q1AKUz3NnBOj9mV7cQ+x0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hhOEgC2eVqGIoksPFw/7FDhSaebjeLTfVRKH5ruDh/7trA7KZfU1QiKAgIXE6mhmB
         OpScjnTggTrhFXMmGixP93FmbithuohN3LS8B7wXcvkxYxSV5w08nVvOyoeP0boH5f
         8BIamPuV3Tj7e8bNG1c/o5eDnklHzIjFE1YGu3TI=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230912180845uscas1p254803e01094846b2579cb1772dd47b15~EORXeX8ON0142701427uscas1p2B;
        Tue, 12 Sep 2023 18:08:45 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 70.9B.40279.D29A0056; Tue,
        12 Sep 2023 14:08:45 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230912180845uscas1p28e989eaff6b92939cfdb85886137354b~EORXQMVzD3243332433uscas1p2M;
        Tue, 12 Sep 2023 18:08:45 +0000 (GMT)
X-AuditID: cbfec36f-4cbfe70000009d57-b1-6500a92d93f4
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id F8.B9.31410.D29A0056; Tue,
        12 Sep 2023 14:08:45 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 12 Sep 2023 11:08:44 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        12 Sep 2023 11:08:44 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 4/4] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Thread-Topic: [PATCH v3 4/4] hw/cxl: Support 4 HDM decoders at all levels of
        topology
Thread-Index: AQHZ5KVz5ehTY0A1Q0y1rQVyt8XI/bAX9GMA
Date:   Tue, 12 Sep 2023 18:08:44 +0000
Message-ID: <20230912180844.GD319114@bgt-140510-bm03>
In-Reply-To: <20230911114313.6144-5-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5B1F8F0FB6CBEA4F930CE02189990A2A@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djXc7q6KxlSDdq/GlisWniNzeL8rFMs
        Foc3nmGy+P/rFavFmhXCFsd7d7A4sHm0HHnL6nHn2h42jyfXNjN5vN93lc3j8ya5ANYoLpuU
        1JzMstQifbsErozV6+4wF5zIrni0v4WlgXG/TxcjJ4eEgIlE29T9LF2MXBxCAisZJc51v2SF
        cFqZJC4/7WWFqVrbf58dIrGWUeLz5V+MEM4nRoneNaugnGWMEkfuHgdrYRNQlNjXtZ0NxBYR
        MJJ4d2MSWBGzQAOTxLV759hBEsICYRI93QuZIIrCJX5MaWSEaWiZuZwFxGYRUJV4dXcWWA2v
        gKlEy7XpYL2cAg4SZ161MIPYjAJiEt9PrQGrYRYQl7j1ZD4TxN2CEotm72GGsMUk/u16yAZh
        K0rc//6SHaJeT+LG1ClsELadxMv1y1khbG2JZQtfM0PsFZQ4OfMJC0SvpMTBFTfAISYhcIFD
        4lzbBmgguUgcufUbqkhaYvqay0A2B5CdLLHqIxdEOEdi/pItUCXWEgv/rGeawKgyC8nZs5Cc
        NAvJSbOQnDQLyUkLGFlXMYqXFhfnpqcWG+WllusVJ+YWl+al6yXn525iBKal0/8O5+9gvH7r
        o94hRiYOxkOMEhzMSiK8JYf+pgjxpiRWVqUW5ccXleakFh9ilOZgURLnNbQ9mSwkkJ5Ykpqd
        mlqQWgSTZeLglGpg4gxy8/JlNVzKciTtyNFYhfTgjcIquZvfFLi9MzrwOPaw16Svqinrj2uu
        7/vc/b/TbNK6mz6pOz5mGzRVbH4sJy7ldDvVouLFhLjQX48nSZvXHX7sXf8zzHDq9h/1/ZpL
        NWLuH3D0sL7Pz3ovu3VJ4QTrDJ2znKfV1Td80njhOjNLIz5NRHh6XKIow6kFvAt8eUu+zHlr
        rrF+5q/FBYpWFwONXy7zL2Wq/JfH5ZKXv4j38KvMZVI7lso8Pb1e9n6Fb+EjTbajEV5bX6j5
        ZZS/yKtv+8Z7WlRONSajMyLy/DbnuXYMm38tKqyTl5TeIfZ9a4Bghq3siad5Uk6Vjp0M/5Iq
        xRezykj4PAmdqKbEUpyRaKjFXFScCAAB8awPugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWS2cA0UVd3JUOqwb5f8harFl5jszg/6xSL
        xeGNZ5gs/v96xWqxZoWwxfHeHSwObB4tR96yety5tofN48m1zUwe7/ddZfP4vEkugDWKyyYl
        NSezLLVI3y6BK2P1ujvMBSeyKx7tb2FpYNzv08XIySEhYCKxtv8+excjF4eQwGpGibbj8xgh
        nE+MErfPNkA5yxgl9v6eygrSwiagKLGvazsbiC0iYCTx7sYksCJmgQYmidZ7RxlBEsICYRI9
        3QuZIIrCJX7dX8YO09AyczkLiM0ioCrx6u4ssBpeAVOJlmvTgWo4gLaVShzYHQ8S5hRwkDjz
        qoUZxGYUEJP4fmoNWDmzgLjErSfzmSBeEJBYsuc8M4QtKvHy8T9WCFtR4v73l+wQ9XoSN6ZO
        YYOw7SRerl/OCmFrSyxb+JoZ4gRBiZMzn7BA9EpKHFxxg2UCo8QsJOtmIRk1C8moWUhGzUIy
        agEj6ypG8dLi4tz0imLjvNRyveLE3OLSvHS95PzcTYzAiD7973DMDsZ7tz7qHWJk4mA8xCjB
        wawkwlty6G+KEG9KYmVValF+fFFpTmrxIUZpDhYlcd4dUy6mCAmkJ5akZqemFqQWwWSZODil
        GphEWot89n54djB8qvA/Lq4J1us+mLk0/j4vvHz6IeXM+/ct72qqmb+3vLVLadse0UuBknt2
        xYpX7Ux713stScLNUmXvAbubaw6Hi3Ve5p3z6vE3lbea9bK5fgw8WwOmvmJeprtsy8WG1JOC
        j314P5musZ73xvGbS/Ne/id3xSf/tJ7lu3iV59lP1/xe5CgWRZcv2/Ph8Jk3fFYRpmkfJtwN
        tLvC8Ouia8rTqNyzZ9UeT+Hz/PxASuzOhzvvL7TbGJncf+jzKX6389F5XtfPfP0mPaPuVpi2
        +FzF1EKV+jPzInx27P96f+d5bosjguWS3q//sm8Ib9OX+BfCoSYm5Wq1fr3buxfFZxk0NzRK
        ns3LVGIpzkg01GIuKk4EACBYQOhXAwAA
X-CMS-MailID: 20230912180845uscas1p28e989eaff6b92939cfdb85886137354b
CMS-TYPE: 301P
X-CMS-RootMailID: 20230912180845uscas1p28e989eaff6b92939cfdb85886137354b
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
        <20230911114313.6144-5-Jonathan.Cameron@huawei.com>
        <CGME20230912180845uscas1p28e989eaff6b92939cfdb85886137354b@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 11, 2023 at 12:43:13PM +0100, Jonathan Cameron wrote:

> Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> and CXL Type 3 end points.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> ---

One comment inline, other than that, looks good to me.


> v3: Factor out the hdm_inc changes to previous patch.
>     Fix use of encoded hdm count as if it were decoded in cxl-host.
>     Minor refactoring to make that path and one in cxl_type3.c
>     look more similar.
> ---
>  include/hw/cxl/cxl_component.h | 10 +++-
>  hw/cxl/cxl-component-utils.c   |  7 ++-
>  hw/cxl/cxl-host.c              | 67 ++++++++++++++++--------
>  hw/mem/cxl_type3.c             | 96 +++++++++++++++++++++++-----------
>  4 files changed, 124 insertions(+), 56 deletions(-)
>=20
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_componen=
t.h
> index 7c864d2044..3c795a6278 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -135,6 +135,10 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET =
+ 0x18)
>    REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                            =
       \
>          CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                   =
       \
>    REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                            =
       \
> +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)                   =
       \
> +  REG32(CXL_HDM_DECODER##n##_DPA_SKIP_LO,                               =
       \
> +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                   =
       \
> +  REG32(CXL_HDM_DECODER##n##_DPA_SKIP_HI,                               =
       \
>          CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)
> =20
>  REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
> @@ -147,9 +151,13 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGIST=
ERS_OFFSET + 4)
>      FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
>      FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
> =20
> +/* Support 4 decoders at all levels of topology */
> +#define CXL_HDM_DECODER_COUNT 4
> +
>  HDM_DECODER_INIT(0);
> -/* Only used for HDM decoder registers block address increment */
>  HDM_DECODER_INIT(1);
> +HDM_DECODER_INIT(2);
> +HDM_DECODER_INIT(3);
> =20
>  /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex o=
nly) */
>  #define EXTSEC_ENTRY_MAX        256
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index aa011a8f34..3ecdad4a5e 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -90,6 +90,9 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cst=
ate, hwaddr offset,
> =20
>      switch (offset) {
>      case A_CXL_HDM_DECODER0_CTRL:
> +    case A_CXL_HDM_DECODER1_CTRL:
> +    case A_CXL_HDM_DECODER2_CTRL:
> +    case A_CXL_HDM_DECODER3_CTRL:
>          should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMI=
T);
>          should_uncommit =3D !should_commit;

So for the commit/uncommit flag, we always check decoder 0 control
register? Or i read it wrong? I thought the commit bit is per control regis=
ter
thing?

Fan

>          break;
> @@ -129,7 +132,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwa=
ddr offset, uint64_t value,
>      }
> =20
>      if (offset >=3D A_CXL_HDM_DECODER_CAPABILITY &&
> -        offset <=3D A_CXL_HDM_DECODER0_TARGET_LIST_HI) {
> +        offset <=3D A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
>          dumb_hdm_handler(cxl_cstate, offset, value);
>      } else {
>          cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_reg=
isters)] =3D value;
> @@ -209,7 +212,7 @@ static void ras_init_common(uint32_t *reg_state, uint=
32_t *write_msk)
>  static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>                              enum reg_type type)
>  {
> -    int decoder_count =3D 1;
> +    int decoder_count =3D CXL_HDM_DECODER_COUNT;
>      int hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE=
_LO;
>      int i;
> =20
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 73c5426476..2aa776c79c 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -97,35 +97,58 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error=
 **errp)
>      }
>  }
> =20
> -/* TODO: support, multiple hdm decoders */
>  static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
>                                  uint8_t *target)
>  {
>      int hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE=
_LO;
> -    uint32_t ctrl;
> -    uint32_t ig_enc;
> -    uint32_t iw_enc;
> -    uint32_t target_idx;
> -    int i =3D 0;
> -
> -    ctrl =3D cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
> -    if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> -        return false;
> -    }
> -
> -    ig_enc =3D FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
> -    iw_enc =3D FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
> -    target_idx =3D (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
> +    unsigned int hdm_count;
> +    bool found =3D false;
> +    int i;
> +    uint32_t cap;
> +
> +    cap =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
> +    hdm_count =3D cxl_decoder_count_dec(FIELD_EX32(cap,
> +                                                 CXL_HDM_DECODER_CAPABIL=
ITY,
> +                                                 DECODER_COUNT));
> +    for (i =3D 0; i < hdm_count; i++) {
> +        uint32_t ctrl, ig_enc, iw_enc, target_idx;
> +        uint32_t low, high;
> +        uint64_t base, size;
> +
> +        low =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hd=
m_inc);
> +        high =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * h=
dm_inc);
> +        base =3D (low & 0xf0000000) | ((uint64_t)high << 32);
> +        low =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hd=
m_inc);
> +        high =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * h=
dm_inc);
> +        size =3D (low & 0xf0000000) | ((uint64_t)high << 32);
> +        if (addr < base || addr >=3D base + size) {
> +            continue;
> +        }
> =20
> -    if (target_idx < 4) {
> -        *target =3D extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_L=
O],
> -                            target_idx * 8, 8);
> -    } else {
> -        *target =3D extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_H=
I],
> -                            (target_idx - 4) * 8, 8);
> +        ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_=
inc);
> +        if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> +            return false;
> +        }
> +        found =3D true;
> +        ig_enc =3D FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
> +        iw_enc =3D FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +        target_idx =3D (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
> +
> +        if (target_idx < 4) {
> +            uint32_t val =3D ldl_le_p(cache_mem +
> +                                    R_CXL_HDM_DECODER0_TARGET_LIST_LO +
> +                                    i * hdm_inc);
> +            *target =3D extract32(val, target_idx * 8, 8);
> +        } else {
> +            uint32_t val =3D ldl_le_p(cache_mem +
> +                                    R_CXL_HDM_DECODER0_TARGET_LIST_HI +
> +                                    i * hdm_inc);
> +            *target =3D extract32(val, (target_idx - 4) * 8, 8);
> +        }
> +        break;
>      }
> =20
> -    return true;
> +    return found;
>  }
> =20
>  static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index cd92813436..1658e0cc59 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -382,8 +382,6 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int=
 which)
>      uint32_t *cache_mem =3D cregs->cache_mem_registers;
>      uint32_t ctrl;
> =20
> -    assert(which =3D=3D 0);
> -
>      ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_=
inc);
>      /* TODO: Sanity checks that the decoder is possible */
>      ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
> @@ -399,8 +397,6 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, i=
nt which)
>      uint32_t *cache_mem =3D cregs->cache_mem_registers;
>      uint32_t ctrl;
> =20
> -    assert(which =3D=3D 0);
> -
>      ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_=
inc);
> =20
>      ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
> @@ -489,6 +485,21 @@ static void ct3d_reg_write(void *opaque, hwaddr offs=
et, uint64_t value,
>          should_uncommit =3D !should_commit;
>          which_hdm =3D 0;
>          break;
> +    case A_CXL_HDM_DECODER1_CTRL:
> +        should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMI=
T);
> +        should_uncommit =3D !should_commit;
> +        which_hdm =3D 1;
> +        break;
> +    case A_CXL_HDM_DECODER2_CTRL:
> +        should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMI=
T);
> +        should_uncommit =3D !should_commit;
> +        which_hdm =3D 2;
> +        break;
> +    case A_CXL_HDM_DECODER3_CTRL:
> +        should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMI=
T);
> +        should_uncommit =3D !should_commit;
> +        which_hdm =3D 3;
> +        break;
>      case A_CXL_RAS_UNC_ERR_STATUS:
>      {
>          uint32_t capctrl =3D ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL=
);
> @@ -760,40 +771,63 @@ static void ct3_exit(PCIDevice *pci_dev)
>      }
>  }
> =20
> -/* TODO: Support multiple HDM decoders and DPA skip */
>  static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t =
*dpa)
>  {
>      int hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE=
_LO;
>      uint32_t *cache_mem =3D ct3d->cxl_cstate.crb.cache_mem_registers;
> -    uint64_t decoder_base, decoder_size, hpa_offset;
> -    uint32_t hdm0_ctrl;
> -    int ig, iw;
> -    int i =3D 0;
> -
> -    decoder_base =3D
> -        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] =
<< 32) |
> -                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc])=
;
> -    if ((uint64_t)host_addr < decoder_base) {
> -        return false;
> -    }
> -
> -    hpa_offset =3D (uint64_t)host_addr - decoder_base;
> -
> -    decoder_size =3D
> -        ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] <=
< 32) |
> -        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc];
> -    if (hpa_offset >=3D decoder_size) {
> -        return false;
> -    }
> +    unsigned int hdm_count;
> +    uint32_t cap;
> +    uint64_t dpa_base =3D 0;
> +    int i;
> =20
> -    hdm0_ctrl =3D cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
> -    iw =3D FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> -    ig =3D FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IG);
> +    cap =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
> +    hdm_count =3D cxl_decoder_count_dec(FIELD_EX32(cap,
> +                                                 CXL_HDM_DECODER_CAPABIL=
ITY,
> +                                                 DECODER_COUNT));
> +
> +    for (i =3D 0; i < hdm_count; i++) {
> +        uint64_t decoder_base, decoder_size, hpa_offset, skip;
> +        uint32_t hdm_ctrl, low, high;
> +        int ig, iw;
> +
> +        low =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hd=
m_inc);
> +        high =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * h=
dm_inc);
> +        decoder_base =3D ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +        low =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hd=
m_inc);
> +        high =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * h=
dm_inc);
> +        decoder_size =3D ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +        low =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
> +                       i * hdm_inc);
> +        high =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
> +                        i * hdm_inc);
> +        skip =3D ((uint64_t)high << 32) | (low & 0xf0000000);
> +        dpa_base +=3D skip;
> +
> +        hpa_offset =3D (uint64_t)host_addr - decoder_base;
> +
> +        hdm_ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * =
hdm_inc);
> +        iw =3D FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +        ig =3D FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IG);
> +        if (!FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> +            return false;
> +        }
> +        if (((uint64_t)host_addr < decoder_base) ||
> +            (hpa_offset >=3D decoder_size)) {
> +            dpa_base +=3D decoder_size /
> +                cxl_interleave_ways_dec(iw, &error_fatal);
> +            continue;
> +        }
> =20
> -    *dpa =3D (MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> -        ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset) >=
> iw);
> +        *dpa =3D dpa_base +
> +            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> +             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offs=
et)
> +              >> iw));
> =20
> -    return true;
> +        return true;
> +    }
> +    return false;
>  }
> =20
>  static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> --=20
> 2.39.2
>=20
> =
