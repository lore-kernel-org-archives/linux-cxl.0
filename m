Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F916C6FD1C
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Mar 2023 16:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCVQWW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCVQVz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Mar 2023 12:21:55 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19C65135
        for <linux-cxl@vger.kernel.org>; Wed, 22 Mar 2023 09:21:29 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230322162128usoutp01aedbd7fb8c0e2bb5dd38a0b684f859fe~OykAwHCES2318023180usoutp01M;
        Wed, 22 Mar 2023 16:21:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230322162128usoutp01aedbd7fb8c0e2bb5dd38a0b684f859fe~OykAwHCES2318023180usoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679502088;
        bh=Kwz8Wkq/7jIG2zThbwuIVIn6RimhfQ9Shr0SyewOFQU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lRad1MxnBZqMTBTTLrkGbURvj1mUsRYdE89wU2bVOL640+80BWY3TcQ37Z+/bfmTh
         1G/coNa0T1J4NJ8CIgRemWX8CgDUCAmqdHc3DvObuKuVyrHKJeJlnOjcjQIP7H1IIC
         iMplX6U+dix8Vl78DNprZNhktfx9dnxM9CidWEUU=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230322162127uscas1p13cc660210a79c20809042af1a0ad663b~OykAnu1Me0270902709uscas1p1r;
        Wed, 22 Mar 2023 16:21:27 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id F4.E9.09634.70B2B146; Wed,
        22 Mar 2023 12:21:27 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230322162127uscas1p1d523e1976e51a18e7d426fb51bee60d0~OykAXcipA2429024290uscas1p1g;
        Wed, 22 Mar 2023 16:21:27 +0000 (GMT)
X-AuditID: cbfec36d-9b3ff700000025a2-2e-641b2b07fd46
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 8A.57.09515.70B2B146; Wed,
        22 Mar 2023 12:21:27 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 22 Mar 2023 09:21:26 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        22 Mar 2023 09:21:26 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [RESEND PATCH 2/2] hw/cxl: Fix incorrect reset of commit and
 associated clearing of committed.
Thread-Topic: [RESEND PATCH 2/2] hw/cxl: Fix incorrect reset of commit and
        associated clearing of committed.
Thread-Index: AQHZXKmujIlz4WS9f0mIzLNeB1EbPa8HcLWA
Date:   Wed, 22 Mar 2023 16:21:26 +0000
Message-ID: <20230322162120.GA1641485@bgt-140510-bm03>
In-Reply-To: <20230322103300.4278-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <581F0A053552CF41B79CDC76660ECB19@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djXc7rs2tIpBrs6jC1O3Gxks1h9cw2j
        xaqF19gszs86xWJxeOMZJov/v16xWhzv3cHiwO7RcuQtq8fiPS+ZPJ5c28zk8X7fVTaPqbPr
        PT5vkgtgi+KySUnNySxLLdK3S+DK+LJwKVPBB7WKV9e3MjYw7pPrYuTgkBAwkbi8yr6LkYtD
        SGAlo8SZzdPYIJxWJok9dx+wdzFyghV9er2MGSKxllGit2M/O4TziVFiS+9NRghnGaPEsoZW
        FpAWNgFFiX1d29lAbBEBI4l3NyaBFTEL7GWSOH1tDRNIQlggV+JM81lmiKI8iauzb7PDNHy6
        /wVsEIuAqsSU4w1gcV4BM4nuVbNYQWxOAQeJbS1rGUFsRgExie+nIGYyC4hL3HoynwnibkGJ
        RbP3MEPYYhL/dj1kg7AVJe5/f8kOUa8jsWD3JzYI205i3aIPUHFtiWULXzND7BWUODnzCQtE
        r6TEwRU3WECekRB4wCHRv/cV1DIXiYMTf0ItkJaYvuYyCySEkyVWfeSCCOdIzF+yBWqOtcTC
        P+uZJjCqzEJy9iwkJ81CctIsJCfNQnLSAkbWVYzipcXFuempxYZ5qeV6xYm5xaV56XrJ+bmb
        GIGJ6vS/w7k7GHfc+qh3iJGJg/EQowQHs5IIrxuzRIoQb0piZVVqUX58UWlOavEhRmkOFiVx
        XkPbk8lCAumJJanZqakFqUUwWSYOTqkGJhu2riczVKKedW++/PR/2A2G45LB8azs0S//T322
        PnGVh8LBY9eNQo1j2lfk7DvrnBo23cn1qqqCUQzX3DVLr3xeNO27yRLJRXJuG+tq9kzlkFXv
        1V75I5+biXlO6MbzejXzhV89TloclPG2Zffv/Qfbn5a2Ly94f6ErYA1H/q2LStYK98uE6oLn
        lJ224NGQdrlks9tJeHuiavlmhzsr5myc1G8U+Pl+k/yaBPGkvc481+eIvz374G2k0Y/lRnt2
        f2I2qjuplBLfPfWAf2ZVxC5Bp5/HWhmb/axuW5rMbb5tNqXQJUrM3fLB3z9sPoVsDZsUK93f
        vSnRZLq660mhnvnLmwsm2E3V/t6eal3wUomlOCPRUIu5qDgRAMOKqozDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWS2cA0SZddWzrF4PE5RYsTNxvZLFbfXMNo
        sWrhNTaL87NOsVgc3niGyeL/r1esFsd7d7A4sHu0HHnL6rF4z0smjyfXNjN5vN93lc1j6ux6
        j8+b5ALYorhsUlJzMstSi/TtErgyvixcylTwQa3i1fWtjA2M++S6GDk5JARMJD69XsbcxcjF
        ISSwmlFi/dJVrBDOJ0aJ/XfesoBUCQksY5T4Pl8PxGYTUJTY17WdDcQWETCSeHdjEiNIA7PA
        XiaJ09fWMIEkhAVyJc40n2WGKMqT+DXnAytMw6f7X8CGsgioSkw53sAOYvMKmEl0r5rFCrHs
        JKPElz9+IDangIPEtpa1jCA2o4CYxPdTEPOZBcQlbj2ZzwTxgoDEkj3nmSFsUYmXj/+xQtiK
        Eve/v2SHqNeRWLD7ExuEbSexbtEHqLi2xLKFr5khbhCUODnzCQtEr6TEwRU3WCYwSsxCsm4W
        klGzkIyahWTULCSjFjCyrmIULy0uzk2vKDbOSy3XK07MLS7NS9dLzs/dxAiM8tP/DsfsYLx3
        66PeIUYmDsZDjBIczEoivG7MEilCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeT1iJ8YLCaQnlqRm
        p6YWpBbBZJk4OKUamIysIvjY60zm7Z4h/XdTZam0mRrzZjYVi9wp9ZziRydeX3t4xn6trX37
        Ar4xf0yqOcGqtlRcKnDL55VbN65+cSbh1pObr2a53Pu0m4PDuZtb16Ht946fx8IbzS+vOXnn
        uXFGuGrPf8HIxk03G6Paemdd3Rzad8HwwEaNWxu5GCbOvhZfHGK9/ZxRfXJg3mZ+ERvekCzV
        W36Zz7IdJbO+qcVuf6BluorL6jvD2teBbI7aX5xS1R33TrASX5entYpB/sXntasTzmZFrPV2
        XvDV3nWfyP/ZM+//r+2NL70XveH0qkXeKufmzNo0YbvNfGaFddlf4tadvn3wzbnXzzU8Oj24
        czgWPTBbucmX+5+ow2slluKMREMt5qLiRABVsE6lYQMAAA==
X-CMS-MailID: 20230322162127uscas1p1d523e1976e51a18e7d426fb51bee60d0
CMS-TYPE: 301P
X-CMS-RootMailID: 20230322103301uscas1p1fec17ee01b4fac9aaa8669f9c5d87e6a
References: <20230322102731.4219-1-Jonathan.Cameron@huawei.com>
        <CGME20230322103301uscas1p1fec17ee01b4fac9aaa8669f9c5d87e6a@uscas1p1.samsung.com>
        <20230322103300.4278-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 22, 2023 at 10:33:00AM +0000, Jonathan Cameron wrote:
> The hardware clearing the commit bit is not spec compliant.
> Clearing of committed bit when commit is cleared is not specifically
> stated in the CXL spec, but is the expected (and simplest) permitted
> behaviour so use that for QEMU emulation.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>


The patch passed the tests as shown in previous mailing list discussion:
https://lore.kernel.org/linux-cxl/640276695c8e8_5b27929473@dwillia2-xfh.jf.=
intel.com.notmuch/T/#m0afcfc21d68c84c07f2e9e3194f587c2ffa82d6d
The following two topologies are tested:
1. one HB with one root port and a direct attached memdev.
2. one HB with 2 root ports and a memdev is directly attached to a CXL swit=
ch
which is attached to one root port.

One minor thing below.

>  hw/cxl/cxl-component-utils.c |  6 +++++-
>  hw/mem/cxl_type3.c           | 21 ++++++++++++++++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index a3e6cf75cf..378f1082ce 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -38,19 +38,23 @@ static void dumb_hdm_handler(CXLComponentState *cxl_c=
state, hwaddr offset,
>      ComponentRegisters *cregs =3D &cxl_cstate->crb;
>      uint32_t *cache_mem =3D cregs->cache_mem_registers;
>      bool should_commit =3D false;
> +    bool should_uncommit =3D false;
> =20
>      switch (offset) {
>      case A_CXL_HDM_DECODER0_CTRL:
>          should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMI=
T);
> +        should_uncommit =3D !should_commit;
This will cause committed always reset if COMMIT is 0, not only
1->0. No issue for now, just point out to make sure it is what we
want.
>          break;
>      default:
>          break;
>      }
> =20
>      if (should_commit) {
> -        value =3D FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
>          value =3D FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, ERR, 0);
>          value =3D FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 1)=
;
> +    } else if (should_uncommit) {
> +        value =3D FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, ERR, 0);
> +        value =3D FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 0)=
;
>      }
>      stl_le_p((uint8_t *)cache_mem + offset, value);
>  }
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 846089ccda..9598d584ac 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -320,13 +320,28 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, i=
nt which)
> =20
>      ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
>      /* TODO: Sanity checks that the decoder is possible */
> -    ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
>      ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
>      ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
> =20
>      stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
>  }
> =20
> +static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
> +{
> +    ComponentRegisters *cregs =3D &ct3d->cxl_cstate.crb;
> +    uint32_t *cache_mem =3D cregs->cache_mem_registers;
> +    uint32_t ctrl;
> +
> +    assert(which =3D=3D 0);
> +
> +    ctrl =3D ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
> +
> +    ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
> +    ctrl =3D FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
> +
> +    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
> +}
> +
>  static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
>  {
>      switch (qmp_err) {
> @@ -395,6 +410,7 @@ static void ct3d_reg_write(void *opaque, hwaddr offse=
t, uint64_t value,
>      CXLType3Dev *ct3d =3D container_of(cxl_cstate, CXLType3Dev, cxl_csta=
te);
>      uint32_t *cache_mem =3D cregs->cache_mem_registers;
>      bool should_commit =3D false;
> +    bool should_uncommit =3D false;
>      int which_hdm =3D -1;
> =20
>      assert(size =3D=3D 4);
> @@ -403,6 +419,7 @@ static void ct3d_reg_write(void *opaque, hwaddr offse=
t, uint64_t value,
>      switch (offset) {
>      case A_CXL_HDM_DECODER0_CTRL:
>          should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMI=
T);
> +        should_uncommit =3D !should_commit;
>          which_hdm =3D 0;
>          break;
>      case A_CXL_RAS_UNC_ERR_STATUS:
> @@ -489,6 +506,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offse=
t, uint64_t value,
>      stl_le_p((uint8_t *)cache_mem + offset, value);
>      if (should_commit) {
>          hdm_decoder_commit(ct3d, which_hdm);
> +    } else if (should_uncommit) {
> +        hdm_decoder_uncommit(ct3d, which_hdm);
>      }
>  }
> =20
> --=20
> 2.37.2
> =
