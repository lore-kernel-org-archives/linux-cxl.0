Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C4EE3F08
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 17:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjILRoE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjILRoD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 13:44:03 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555EAC1
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 10:43:59 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230912174358usoutp0217327d70e0e1eacd2f2aee0db990881a~EN7t0-oFJ3242932429usoutp02O;
        Tue, 12 Sep 2023 17:43:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230912174358usoutp0217327d70e0e1eacd2f2aee0db990881a~EN7t0-oFJ3242932429usoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694540638;
        bh=pjtU60jdClyj/IR3qbP5jqlP3UIfwh7Pe57qJKVtXIE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=aUMSwAO4hRdTgdDM3XP7tB6olJuCXU6LiNCj4/VcbSgg3+f1T/U9epxsKEFVYSnA2
         asy/c2xSeUUd8oFUolb7FGBdIMq3mAGQrL/R9eMJVZmzJxlfzVVPau87F8HSQeimNT
         rL3GNmL9cEZD/YdfdVT/Lnm7o820LhlLAUVX15Nc=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230912174357uscas1p2fef12c143ae31f60d73908c1ddc90b1b~EN7twJw7z2852828528uscas1p21;
        Tue, 12 Sep 2023 17:43:57 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 25.A5.50148.D53A0056; Tue,
        12 Sep 2023 13:43:57 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230912174357uscas1p23b767b0b88830d2b8a7179439d224a9e~EN7tiusFJ2537225372uscas1p2f;
        Tue, 12 Sep 2023 17:43:57 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-c9-6500a35d2045
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 6B.E9.31200.D53A0056; Tue,
        12 Sep 2023 13:43:57 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 12 Sep 2023 10:43:56 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        12 Sep 2023 10:43:56 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 3/4] hw/cxl: Fix and use same calculation for HDM
 decoder block size everywhere
Thread-Topic: [PATCH v3 3/4] hw/cxl: Fix and use same calculation for HDM
        decoder block size everywhere
Thread-Index: AQHZ5KVhms968H7ZBUqB98KAVSv4jbAX7XUA
Date:   Tue, 12 Sep 2023 17:43:56 +0000
Message-ID: <20230912174356.GC319114@bgt-140510-bm03>
In-Reply-To: <20230911114313.6144-4-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F3A2C2B986F95543BF772050D163E002@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djX87qxixlSDfb1WlqsWniNzeL8rFMs
        Foc3nmGy+P/rFavFmhXCFsd7d7A4sHm0HHnL6nHn2h42jyfXNjN5vN93lc3j8ya5ANYoLpuU
        1JzMstQifbsEroytfV9YCppdKiadaGVuYNxn0sXIySEhYCIx6eJX1i5GLg4hgZWMEqvfXWKH
        cFqZJKbufs0GU3Vv6l8WiMRaRol5Hf+hnE+MEss7lkO1LGOU+HF8OyNIC5uAosS+ru1g7SIC
        RhLvbkxiBCliFmhgkrh27xw7SEJYIEPi8eK/TBBFmRI9f3azwDQcudEKNohFQFXi0v6TYPW8
        AqYS87b+Bqrn4OAUcJC4ND8GJMwoICbx/dQasDHMAuISt57MZ4I4W1Bi0ew9zBC2mMS/XQ+h
        3lGUuP/9JTtEvZ7EjalT2CBsO4l1b6exQtjaEssWvmaGWCsocXLmExaIXkmJgytugH0vIXCF
        Q+LStF2sEAkXiY69XVALpCX+3l0GdqeEQLLEqo9cEOEciflLtkDNsZZY+Gc90wRGlVlIzp6F
        5KRZSE6aheSkWUhOWsDIuopRvLS4ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwKZ3+dzh3B+OO
        Wx/1DjEycTAeYpTgYFYS4S059DdFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+h7clkIYH0xJLU
        7NTUgtQimCwTB6dUA5OTWsP+VYoxR8Uk9/S1M3LytbLflRTfdbv/V4FpTDzv+TbVc2+Onkv+
        67Hk63cl+yUVnxguTf5VNNk1wCLhviB/Hl/iy9auXY/1L7aWT+K7dpeT4ec/9pk6pYdexD74
        lSX5WVj1YK6mTWDIpqVLX09+n/Cw3K1z8vsCq9mnr+1oyCifkT9dqSLu1OSmU7e9uViW72uU
        qv36OrUos2a7/9IqfuG5fjHvr4idPzT/+IPOMEY+w5fXLFfF7Mm4cVrxRNCSU/KxF7pTftuJ
        7lEUi2yyVjBzjp/AUszOFDpzGkNimIOL1lXbD2677q1/cy41ZPZR9gn123Q+/9K9sSHKdOJ2
        +TC9LYuUtxz8bDvD/YISS3FGoqEWc1FxIgD95vZiuQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWS2cA0UTd2MUOqwZsWdYtVC6+xWZyfdYrF
        4vDGM0wW/3+9YrVYs0LY4njvDhYHNo+WI29ZPe5c28Pm8eTaZiaP9/uusnl83iQXwBrFZZOS
        mpNZllqkb5fAlbG17wtLQbNLxaQTrcwNjPtMuhg5OSQETCTuTf3L0sXIxSEksJpRovPfZiYI
        5xOjxMO/j9kgnGWMEp8/fmcBaWETUJTY17WdDcQWETCSeHdjEiNIEbNAA5NE672jjCAJYYEM
        iceL/zJBFGVKPH72kAWm4ciNVrAaFgFViUv7T7KD2LwCphLztv4GqxcSKJVofTQTKM7BwSng
        IHFpfgxImFFATOL7qTVgJcwC4hK3nsxngnhBQGLJnvPMELaoxMvH/1ghbEWJ+99fskPU60nc
        mDqFDcK2k1j3dhorhK0tsWzha2aIEwQlTs58wgLRKylxcMUNlgmMErOQrJuFZNQsJKNmIRk1
        C8moBYysqxjFS4uLc9Mrio3yUsv1ihNzi0vz0vWS83M3MQIj+vS/w9E7GG/f+qh3iJGJg/EQ
        owQHs5IIb8mhvylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeXdMuZgiJJCeWJKanZpakFoEk2Xi
        4JRqYMr49+V5C1+2sLy27cfko20G0+SX3F3C+/L7vEYe36/n1t3y5lbreO47ITLfSuB/7RRN
        rVLruO4Vq7yz/24PTbK9J33p8ZuPgrMc3y/3Tl8SteuOvkL43ISpBRUL6tXvs+d0L7j3eHVE
        UMyBHbPnWN5uym7eVnxobkvxufo1OXq/hB+liE691ajU/Pf8pTf9HoesnTlf6S77pnIh5g9/
        oyt/9UE7LYcfG/cr33347amzzCLuc+vilhXOdJnR42gZePVx+A2X3XGmHu2dn5KOKsxRPf9i
        5U2LF2UWxx91vApcobJDvMI9NWrdSz7uSFYt/9ulW6yKfjzbE7Ddb/GDha9ZEzd0VS89bh37
        qMxqyUolluKMREMt5qLiRAAUlFkoVwMAAA==
X-CMS-MailID: 20230912174357uscas1p23b767b0b88830d2b8a7179439d224a9e
CMS-TYPE: 301P
X-CMS-RootMailID: 20230912174357uscas1p23b767b0b88830d2b8a7179439d224a9e
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
        <20230911114313.6144-4-Jonathan.Cameron@huawei.com>
        <CGME20230912174357uscas1p23b767b0b88830d2b8a7179439d224a9e@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 11, 2023 at 12:43:12PM +0100, Jonathan Cameron wrote:

> In order to avoid having the size of the per HDM decoder register block
> repeated in lots of places, create the register definitions for HDM
> decoder 1 and use the offset between the first registers in HDM decoder 0=
 and
> HDM decoder 1 to establish the offset.
>=20
> Calculate in each function as this is more obvious and leads to shorter
> line lengths than a single #define which would need a long name
> to be specific enough.
>=20
> Note that the code currently only supports one decoder, so the bugs this
> fixes don't actually affect anything. Previously the offset didn't
> take into account that the write_msk etc are 4 byte fields.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> --
> v3:
> New patch to separate this out from the addition of HDM decoders.
> ---
>  include/hw/cxl/cxl_component.h |  2 ++
>  hw/cxl/cxl-component-utils.c   | 19 +++++++++++--------
>  hw/cxl/cxl-host.c              |  4 +++-
>  hw/mem/cxl_type3.c             | 24 +++++++++++++++---------
>  4 files changed, 31 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_componen=
t.h
> index ef9e033919..7c864d2044 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -148,6 +148,8 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTE=
RS_OFFSET + 4)
>      FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
> =20
>  HDM_DECODER_INIT(0);
> +/* Only used for HDM decoder registers block address increment */
> +HDM_DECODER_INIT(1);
> =20
>  /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex o=
nly) */
>  #define EXTSEC_ENTRY_MAX        256
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 352d0dace2..aa011a8f34 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -210,6 +210,7 @@ static void hdm_init_common(uint32_t *reg_state, uint=
32_t *write_msk,
>                              enum reg_type type)
>  {
>      int decoder_count =3D 1;
> +    int hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE=
_LO;
>      int i;
> =20
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUN=
T,
> @@ -222,19 +223,21 @@ static void hdm_init_common(uint32_t *reg_state, ui=
nt32_t *write_msk,
>                       HDM_DECODER_ENABLE, 0);
>      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] =3D 0x3;
>      for (i =3D 0; i < decoder_count; i++) {
> -        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20] =3D 0xf0000000;
> -        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20] =3D 0xffffffff;
> -        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] =3D 0xf0000000;
> -        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] =3D 0xffffffff;
> -        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] =3D 0x13ff;
> +        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc] =3D 0xf00000=
00;
> +        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] =3D 0xffffff=
ff;
> +        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc] =3D 0xf00000=
00;
> +        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] =3D 0xffffff=
ff;
> +        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] =3D 0x13ff;
>          if (type =3D=3D CXL2_DEVICE ||
>              type =3D=3D CXL2_TYPE3_DEVICE ||
>              type =3D=3D CXL2_LOGICAL_DEVICE) {
> -            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] =3D =
0xf0000000;
> +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
=3D
> +                0xf0000000;
>          } else {
> -            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] =3D =
0xffffffff;
> +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
=3D
> +                0xffffffff;
>          }
> -        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] =3D 0xff=
ffffff;
> +        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * hdm_inc] =3D 0=
xffffffff;
>      }
>  }
> =20
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index f0920da956..73c5426476 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -101,12 +101,14 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Err=
or **errp)
>  static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
>                                  uint8_t *target)
>  {
> +    int hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE=
_LO;
>      uint32_t ctrl;
>      uint32_t ig_enc;
>      uint32_t iw_enc;
>      uint32_t target_idx;
> +    int i =3D 0;
> =20
> -    ctrl =3D cache_mem[R_CXL_HDM_DECODER0_CTRL];
> +    ctrl =3D cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
>      if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
>          return false;
>      }
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4e314748d3..cd92813436 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -377,34 +377,36 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> =20
>  static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
>  {
> +    int hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE=
_LO;
>      ComponentRegisters *cregs =3D &ct3d->cxl_cstate.crb;
>      uint32_t *cache_mem =3D cregs->cache_mem_registers;
>      uint32_t ctrl;
> =20
>      assert(which =3D=3D 0);
> =20
> -    ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
> +    ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_=
inc);
>      /* TODO: Sanity checks that the decoder is possible */
>      ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
>      ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
> =20
> -    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
> +    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl=
);
>  }
> =20
>  static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
>  {
> +    int hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE=
_LO;
>      ComponentRegisters *cregs =3D &ct3d->cxl_cstate.crb;
>      uint32_t *cache_mem =3D cregs->cache_mem_registers;
>      uint32_t ctrl;
> =20
>      assert(which =3D=3D 0);
> =20
> -    ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
> +    ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_=
inc);
> =20
>      ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
>      ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
> =20
> -    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
> +    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl=
);
>  }
> =20
>  static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
> @@ -761,26 +763,30 @@ static void ct3_exit(PCIDevice *pci_dev)
>  /* TODO: Support multiple HDM decoders and DPA skip */
>  static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t =
*dpa)
>  {
> +    int hdm_inc =3D R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE=
_LO;
>      uint32_t *cache_mem =3D ct3d->cxl_cstate.crb.cache_mem_registers;
>      uint64_t decoder_base, decoder_size, hpa_offset;
>      uint32_t hdm0_ctrl;
>      int ig, iw;
> +    int i =3D 0;
> =20
> -    decoder_base =3D (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] <=
< 32) |
> -                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
> +    decoder_base =3D
> +        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] =
<< 32) |
> +                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc])=
;
>      if ((uint64_t)host_addr < decoder_base) {
>          return false;
>      }
> =20
>      hpa_offset =3D (uint64_t)host_addr - decoder_base;
> =20
> -    decoder_size =3D ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI] <<=
 32) |
> -        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO];
> +    decoder_size =3D
> +        ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] <=
< 32) |
> +        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc];
>      if (hpa_offset >=3D decoder_size) {
>          return false;
>      }
> =20
> -    hdm0_ctrl =3D cache_mem[R_CXL_HDM_DECODER0_CTRL];
> +    hdm0_ctrl =3D cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
>      iw =3D FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IW);
>      ig =3D FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IG);
> =20
> --=20
> 2.39.2
>=20
> =
