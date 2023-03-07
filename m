Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B8C6FD1E
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 19:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCGTkX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCGTkE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 14:40:04 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A17A83B3
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 11:26:44 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230307192643usoutp01c4485ccbdf3b0727dd0b61aee12aaf24~KOaeVn6Zn1554315543usoutp01D;
        Tue,  7 Mar 2023 19:26:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230307192643usoutp01c4485ccbdf3b0727dd0b61aee12aaf24~KOaeVn6Zn1554315543usoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678217203;
        bh=lUX1ayC2fNqx0+eHThRvMUZ7J5vqH7EAwhomf8db8H8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ktwko/B5rwVQzp32B0/S69Fvup/X+n0NGPkQVBbvqiwluBuFNYM/2WGXwwM1EyX8l
         q1qu8sDUOqwNZGAXS3of3DH9Fzzx7odxKWaZGBlUkAXETRihKIOu1FJ2U2Bx6e3IXs
         qW3J07de05frSgVupKCWN5NAbvl6F6lrpZlRQcug=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230307192642uscas1p1c61ada2ff457c06eff0a5114d8ac20ed~KOaeKrHtI0960309603uscas1p1y;
        Tue,  7 Mar 2023 19:26:42 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 7E.D0.12196.2FF87046; Tue, 
        7 Mar 2023 14:26:42 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230307192642uscas1p15caa7ff372247e96544265fbd031d83e~KOadzGAmf0962809628uscas1p1v;
        Tue,  7 Mar 2023 19:26:42 +0000 (GMT)
X-AuditID: cbfec370-83dfe70000012fa4-66-64078ff28be0
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 89.0B.11378.2FF87046; Tue, 
        7 Mar 2023 14:26:42 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 7 Mar 2023 11:26:41 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        7 Mar 2023 11:26:41 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [RESEND PATCH v6 8/8] hw/mem/cxl_type3: Add CXL RAS Error
 Injection Support.
Thread-Topic: [RESEND PATCH v6 8/8] hw/mem/cxl_type3: Add CXL RAS Error
        Injection Support.
Thread-Index: AQHZTQy6tnVmlhJrrkmE6uv1o1dswK7wQX+A
Date:   Tue, 7 Mar 2023 19:26:41 +0000
Message-ID: <20230307192641.GH1489326@bgt-140510-bm03>
In-Reply-To: <20230302133709.30373-9-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3806ED75C44F7148BC81B9E9728E852B@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djX87qf+tlTDPa2G1ncfXyBzWL+2vss
        Fm/erGGyOHGzkc1i4tv1rBb7nz5nsVi18BqbxflZp1gsDm88w2SxoK2d1WLN/UOsFr/XPmay
        +P/rFZC7QtjieO8OFouVx2wcBDxaL/1l89g56y67R8uRt6wei/e8ZPK4c20Pm8eTa5uZPN7v
        u8rm8XmTXABHFJdNSmpOZllqkb5dAlfGq96Kgo8nGCuWzb/F2sC4YTJjFyMnh4SAicTFhW/Y
        uhi5OIQEVjJK/P+wiBXCaWWSODX/IwtM1bLvG5khEmsZJV6t7ISq+sgosW7OdEYIZymjxLPf
        K1lBWtgEFCX2dW1nA7FFBIwk3t2YBFbELLCHVeLjjPnsIAlhgWiJY7vesUAUxUjse7ocqIgD
        rKHvUSVImEVARWL1t6VMIDavgJnE/a9HwGZyCjhKTJvYDtbKKCAm8f3UGrAaZgFxiVtP5jNB
        nC0osWj2HmYIW0zi366HbBC2osT97y/ZIer1JG5MncIGYdtJzPw+HSquLbFs4WtmiL2CEidn
        PoEGhaTEwRU3WEB+kRBYzSlx5tZWqGUuEt97H0EtkJa4en0qM8gvEgLJEqs+ckGEcyTmL9kC
        NcdaYuGf9UwTGFVmITl7FpKTZiE5aRaSk2YhOWkBI+sqRvHS4uLc9NRi47zUcr3ixNzi0rx0
        veT83E2MwLR4+t/hgh2Mt2591DvEyMTBeIhRgoNZSYT37Tu2FCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8hrYnk4UE0hNLUrNTUwtSi2CyTBycUg1MQtdPTJ1787LU64WXzKx/hCfU7f3Z6WL+
        wJez/taF4z5tNgVnl5zjNw2Tv3jh9+fcxW1aE21yVN8cSF3JMrn7zuspm+1j9yV/WWB0pcJK
        TC5m7UP+8sOW2l93//7u2HJMdcOiHPF23dqS5edmhoapahQeKton5Kn5iJ1T+fNrlbr82lWr
        5x2Iib7rf/CWWwnz6TnnH8mEbkus9jzbbfT77p5Y31X/D25efZ1Vt0k1ddpDpotvqpemRa9x
        FnqR4nm70s9/XerTLQ+K0gUVZlnuz7nqlPFm1b57c2NvdLCUP1+ouubExJiEHtf/XSWreayW
        qe6Xeadx6aKfyKqrR2JMa+2PPU4umTGr3XHG8UV9PUosxRmJhlrMRcWJAP4n3uP6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTURjGOd9t3yTxa1meVBLFgpS2LIkTmFkorD+MqKAsoa32pSudujkv
        ETkpMzRvZZeNaJrNyilzBl1UtLbSylAJMrNkkYZTp6XR1JaZ8zPYf8/7Ps/zO+fAoXFBAelP
        yxWZrFIhTQmhvAi5BruyabqMJ9tsn16DBod6KaRvsBHI4ajH0KuP+RSqmDCRqP3bCIHqqvso
        1KN7QyCr+S2Gqi4WkqjeZiGRq2EIQwu/xxbH+6tQZ8kTAj3oiIphxAXv5inxU90gT3zhxQQp
        rmkdxcSf+1op8XDfQ0z8ve09Jf7ZtG4ffcQrSsamyLNYpSha4pU8VpKTPvUK5NTqB0gNaLwK
        igCfhkwkrJ0x40XAixYwRgCtzx0EN0wBqLnUsuwYAHRqLaS7QjHBsK3oMeXWvswWONl/BbhD
        ONNMwiHDCM9trGKOwo7mSYILJcJ7zpuLJHqpUPo1170mmFBodBowt/ZmtkHbrxdLTAGTDcdu
        m3C35jO74PWKwiUMYNbAmTf1S3mc8YMDw3qMewID77b24JxeDUeH/pKcDoa2mVEelxfC/muV
        FKejoXbmxvI+HNZWj+PcHVbC19phguuuhc/v9xPlAOo8jtN5oHQeKJ0HSueBqgJkHfBTq1Sp
        STmqCAWbLVRJU1VqRZLwRFpqE1j8KV1/rQlPwMuBKaEFYDSwAEjjIb7eE5OUTOAtk+aeYZVp
        x5TqFFZlAQE0EeLnLYirOCZgkqSZ7GmWTWeV/12M5vtrsEelW285DLJTpg+7gsK2+owfj5/+
        FRExgs+aCtCm9pg8Z76JOJO48Lju24r4WMy3lpKsba4sUwRsCFVkRbYYXdTBvJj0DGI6g58s
        yhrfaBR175C4vs6Z+WFamzWvpi4/ITjwIn1ot4H9FJu5P+2AeVZpUJ+M7/uMMiL3dFqzc1dg
        WOjBs+fnRN2K8C/lW7q6tvd+qST3Gcft3/GGa64PessD46jfHaP9srq0zX5DJrOf23D72c44
        JjDcdbqYbgkKvtldXvWD7vgjP1w9n+CoqaZ6k3z8C3zU63s6B0XpPGGxvRHp5ys0h1wgQT77
        KT5qr7ZdXyaRfXz0zJkYQqiSpRFhuFIl/QfZZcwwmAMAAA==
X-CMS-MailID: 20230307192642uscas1p15caa7ff372247e96544265fbd031d83e
CMS-TYPE: 301P
X-CMS-RootMailID: 20230307192642uscas1p15caa7ff372247e96544265fbd031d83e
References: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
        <20230302133709.30373-9-Jonathan.Cameron@huawei.com>
        <CGME20230307192642uscas1p15caa7ff372247e96544265fbd031d83e@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 02, 2023 at 01:37:09PM +0000, Jonathan Cameron wrote:
> CXL uses PCI AER Internal errors to signal to the host that an error has
> occurred. The host can then read more detailed status from the CXL RAS
> capability.
>=20
> For uncorrectable errors: support multiple injection in one operation
> as this is needed to reliably test multiple header logging support in an
> OS. The equivalent feature doesn't exist for correctable errors, so only
> one error need be injected at a time.
>=20
> Note:
>  - Header content needs to be manually specified in a fashion that
>    matches the specification for what can be in the header for each
>    error type.
>=20
> Injection via QMP:
> { "execute": "qmp_capabilities" }
> ...
> { "execute": "cxl-inject-uncorrectable-errors",
>   "arguments": {
>     "path": "/machine/peripheral/cxl-pmem0",
>     "errors": [
>         {
>             "type": "cache-address-parity",
>             "header": [ 3, 4]
>         },
>         {
>             "type": "cache-data-parity",
>             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,=
20,21,22,23,24,25,26,27,28,29,30,31]
>         },
>         {
>             "type": "internal",
>             "header": [ 1, 2, 4]
>         }
>         ]
>   }}
> ...
> { "execute": "cxl-inject-correctable-error",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-pmem0",
>         "type": "physical"
>     } }
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

One minor thing, see below in "typedef struct CXLError".

> v6: (Thanks to Philippe Mathieu-Daud=E9)
> - Add Since entries in cxl.json
> - Add error prints in the stub functions so that if they are called witho=
ut
>   CONFIG_CXL_MEM_DEVICE then we get a useful print rather than just silen=
tly
>   eating them.
>=20
> ---
>  hw/cxl/cxl-component-utils.c   |   4 +-
>  hw/mem/cxl_type3.c             | 281 +++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c       |  17 ++
>  hw/mem/meson.build             |   2 +
>  include/hw/cxl/cxl_component.h |  26 +++
>  include/hw/cxl/cxl_device.h    |  11 ++
>  qapi/cxl.json                  | 128 +++++++++++++++
>  qapi/meson.build               |   1 +
>  qapi/qapi-schema.json          |   1 +
>  9 files changed, 470 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 737b4764b9..b665d4f565 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -142,16 +142,18 @@ static void ras_init_common(uint32_t *reg_state, ui=
nt32_t *write_msk)
>       * be handled as RO.
>       */
>      stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, 0);
> +    stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_STATUS, 0x1cfff);
>      /* Bits 12-13 and 17-31 reserved in CXL 2.0 */
>      stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
>      stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
>      stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
>      stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
>      stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, 0);
> +    stl_le_p(write_msk + R_CXL_RAS_COR_ERR_STATUS, 0x7f);
>      stl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK, 0x7f);
>      stl_le_p(write_msk + R_CXL_RAS_COR_ERR_MASK, 0x7f);
>      /* CXL switches and devices must set */
> -    stl_le_p(reg_state + R_CXL_RAS_ERR_CAP_CTRL, 0x00);
> +    stl_le_p(reg_state + R_CXL_RAS_ERR_CAP_CTRL, 0x200);
>  }
> =20
>  static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6cdd988d1d..abe60b362c 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1,6 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-commands-cxl.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/pci/pci.h"
> @@ -323,6 +324,66 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, in=
t which)
>      ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
>  }
> =20
> +static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
> +{
> +    switch (qmp_err) {
> +    case CXL_UNCOR_ERROR_TYPE_CACHE_DATA_PARITY:
> +        return CXL_RAS_UNC_ERR_CACHE_DATA_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_CACHE_ADDRESS_PARITY:
> +        return CXL_RAS_UNC_ERR_CACHE_ADDRESS_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_CACHE_BE_PARITY:
> +        return CXL_RAS_UNC_ERR_CACHE_BE_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_CACHE_DATA_ECC:
> +        return CXL_RAS_UNC_ERR_CACHE_DATA_ECC;
> +    case CXL_UNCOR_ERROR_TYPE_MEM_DATA_PARITY:
> +        return CXL_RAS_UNC_ERR_MEM_DATA_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_MEM_ADDRESS_PARITY:
> +        return CXL_RAS_UNC_ERR_MEM_ADDRESS_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_MEM_BE_PARITY:
> +        return CXL_RAS_UNC_ERR_MEM_BE_PARITY;
> +    case CXL_UNCOR_ERROR_TYPE_MEM_DATA_ECC:
> +        return CXL_RAS_UNC_ERR_MEM_DATA_ECC;
> +    case CXL_UNCOR_ERROR_TYPE_REINIT_THRESHOLD:
> +        return CXL_RAS_UNC_ERR_REINIT_THRESHOLD;
> +    case CXL_UNCOR_ERROR_TYPE_RSVD_ENCODING:
> +        return CXL_RAS_UNC_ERR_RSVD_ENCODING;
> +    case CXL_UNCOR_ERROR_TYPE_POISON_RECEIVED:
> +        return CXL_RAS_UNC_ERR_POISON_RECEIVED;
> +    case CXL_UNCOR_ERROR_TYPE_RECEIVER_OVERFLOW:
> +        return CXL_RAS_UNC_ERR_RECEIVER_OVERFLOW;
> +    case CXL_UNCOR_ERROR_TYPE_INTERNAL:
> +        return CXL_RAS_UNC_ERR_INTERNAL;
> +    case CXL_UNCOR_ERROR_TYPE_CXL_IDE_TX:
> +        return CXL_RAS_UNC_ERR_CXL_IDE_TX;
> +    case CXL_UNCOR_ERROR_TYPE_CXL_IDE_RX:
> +        return CXL_RAS_UNC_ERR_CXL_IDE_RX;
> +    default:
> +        return -EINVAL;
> +    }
> +}
> +
> +static int ct3d_qmp_cor_err_to_cxl(CxlCorErrorType qmp_err)
> +{
> +    switch (qmp_err) {
> +    case CXL_COR_ERROR_TYPE_CACHE_DATA_ECC:
> +        return CXL_RAS_COR_ERR_CACHE_DATA_ECC;
> +    case CXL_COR_ERROR_TYPE_MEM_DATA_ECC:
> +        return CXL_RAS_COR_ERR_MEM_DATA_ECC;
> +    case CXL_COR_ERROR_TYPE_CRC_THRESHOLD:
> +        return CXL_RAS_COR_ERR_CRC_THRESHOLD;
> +    case CXL_COR_ERROR_TYPE_RETRY_THRESHOLD:
> +        return CXL_RAS_COR_ERR_RETRY_THRESHOLD;
> +    case CXL_COR_ERROR_TYPE_CACHE_POISON_RECEIVED:
> +        return CXL_RAS_COR_ERR_CACHE_POISON_RECEIVED;
> +    case CXL_COR_ERROR_TYPE_MEM_POISON_RECEIVED:
> +        return CXL_RAS_COR_ERR_MEM_POISON_RECEIVED;
> +    case CXL_COR_ERROR_TYPE_PHYSICAL:
> +        return CXL_RAS_COR_ERR_PHYSICAL;
> +    default:
> +        return -EINVAL;
> +    }
> +}
> +
>  static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>                             unsigned size)
>  {
> @@ -341,6 +402,83 @@ static void ct3d_reg_write(void *opaque, hwaddr offs=
et, uint64_t value,
>          should_commit =3D FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMI=
T);
>          which_hdm =3D 0;
>          break;
> +    case A_CXL_RAS_UNC_ERR_STATUS:
> +    {
> +        uint32_t capctrl =3D ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL=
);
> +        uint32_t fe =3D FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL, FIRST_=
ERROR_POINTER);
> +        CXLError *cxl_err;
> +        uint32_t unc_err;
> +
> +        /*
> +         * If single bit written that corresponds to the first error
> +         * pointer being cleared, update the status and header log.
> +         */
> +        if (!QTAILQ_EMPTY(&ct3d->error_list)) {
> +            if ((1 << fe) ^ value) {
> +                CXLError *cxl_next;
> +                /*
> +                 * Software is using wrong flow for multiple header reco=
rding
> +                 * Following behavior in PCIe r6.0 and assuming multiple
> +                 * header support. Implementation defined choice to clea=
r all
> +                 * matching records if more than one bit set - which cor=
responds
> +                 * closest to behavior of hardware not capable of multip=
le
> +                 * header recording.
> +                 */
> +                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node, cx=
l_next) {
> +                    if ((1 << cxl_err->type) & value) {
> +                        QTAILQ_REMOVE(&ct3d->error_list, cxl_err, node);
> +                        g_free(cxl_err);
> +                    }
> +                }
> +            } else {
> +                /* Done with previous FE, so drop from list */
> +                cxl_err =3D QTAILQ_FIRST(&ct3d->error_list);
> +                QTAILQ_REMOVE(&ct3d->error_list, cxl_err, node);
> +                g_free(cxl_err);
> +            }
> +
> +            /*
> +             * If there is another FE, then put that in place and update
> +             * the header log
> +             */
> +            if (!QTAILQ_EMPTY(&ct3d->error_list)) {
> +                uint32_t *header_log =3D &cache_mem[R_CXL_RAS_ERR_HEADER=
0];
> +                int i;
> +
> +                cxl_err =3D QTAILQ_FIRST(&ct3d->error_list);
> +                for (i =3D 0; i < CXL_RAS_ERR_HEADER_NUM; i++) {
> +                    stl_le_p(header_log + i, cxl_err->header[i]);
> +                }
> +                capctrl =3D FIELD_DP32(capctrl, CXL_RAS_ERR_CAP_CTRL,
> +                                     FIRST_ERROR_POINTER, cxl_err->type)=
;
> +            } else {
> +                /*
> +                 * If no more errors, then follow recomendation of PCI s=
pec
> +                 * r6.0 6.2.4.2 to set the first error pointer to a stat=
us
> +                 * bit that will never be used.
> +                 */
> +                capctrl =3D FIELD_DP32(capctrl, CXL_RAS_ERR_CAP_CTRL,
> +                                     FIRST_ERROR_POINTER,
> +                                     CXL_RAS_UNC_ERR_CXL_UNUSED);
> +            }
> +            stl_le_p((uint8_t *)cache_mem + A_CXL_RAS_ERR_CAP_CTRL, capc=
trl);
> +        }
> +        unc_err =3D 0;
> +        QTAILQ_FOREACH(cxl_err, &ct3d->error_list, node) {
> +            unc_err |=3D 1 << cxl_err->type;
> +        }
> +        stl_le_p((uint8_t *)cache_mem + offset, unc_err);
> +
> +        return;
> +    }
> +    case A_CXL_RAS_COR_ERR_STATUS:
> +    {
> +        uint32_t rw1c =3D value;
> +        uint32_t temp =3D ldl_le_p((uint8_t *)cache_mem + offset);
> +        temp &=3D ~rw1c;
> +        stl_le_p((uint8_t *)cache_mem + offset, temp);
> +        return;
> +    }
>      default:
>          break;
>      }
> @@ -404,6 +542,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **e=
rrp)
>      unsigned short msix_num =3D 1;
>      int i, rc;
> =20
> +    QTAILQ_INIT(&ct3d->error_list);
> +
>      if (!cxl_setup_memory(ct3d, errp)) {
>          return;
>      }
> @@ -631,6 +771,147 @@ static void set_lsa(CXLType3Dev *ct3d, const void *=
buf, uint64_t size,
>       */
>  }
> =20
> +/* For uncorrectable errors include support for multiple header recordin=
g */
> +void qmp_cxl_inject_uncorrectable_errors(const char *path,
> +                                         CXLUncorErrorRecordList *errors=
,
> +                                         Error **errp)
> +{
> +    Object *obj =3D object_resolve_path(path, NULL);
> +    static PCIEAERErr err =3D {};
> +    CXLType3Dev *ct3d;
> +    CXLError *cxl_err;
> +    uint32_t *reg_state;
> +    uint32_t unc_err;
> +    bool first;
> +
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +
> +    err.status =3D PCI_ERR_UNC_INTN;
> +    err.source_id =3D pci_requester_id(PCI_DEVICE(obj));
> +    err.flags =3D 0;
> +
> +    ct3d =3D CXL_TYPE3(obj);
> +
> +    first =3D QTAILQ_EMPTY(&ct3d->error_list);
> +    reg_state =3D ct3d->cxl_cstate.crb.cache_mem_registers;
> +    while (errors) {
> +        uint32List *header =3D errors->value->header;
> +        uint8_t header_count =3D 0;
> +        int cxl_err_code;
> +
> +        cxl_err_code =3D ct3d_qmp_uncor_err_to_cxl(errors->value->type);
> +        if (cxl_err_code < 0) {
> +            error_setg(errp, "Unknown error code");
> +            return;
> +        }
> +
> +        /* If the error is masked, nothing to do here */
> +        if (!((1 << cxl_err_code) &
> +              ~ldl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK))) {
> +            errors =3D errors->next;
> +            continue;
> +        }
> +
> +        cxl_err =3D g_malloc0(sizeof(*cxl_err));
> +        if (!cxl_err) {
> +            return;
> +        }
> +
> +        cxl_err->type =3D cxl_err_code;
> +        while (header && header_count < 32) {
> +            cxl_err->header[header_count++] =3D header->value;
> +            header =3D header->next;
> +        }
> +        if (header_count > 32) {
> +            error_setg(errp, "Header must be 32 DWORD or less");
> +            return;
> +        }
> +        QTAILQ_INSERT_TAIL(&ct3d->error_list, cxl_err, node);
> +
> +        errors =3D errors->next;
> +    }
> +
> +    if (first && !QTAILQ_EMPTY(&ct3d->error_list)) {
> +        uint32_t *cache_mem =3D ct3d->cxl_cstate.crb.cache_mem_registers=
;
> +        uint32_t capctrl =3D ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL=
);
> +        uint32_t *header_log =3D &cache_mem[R_CXL_RAS_ERR_HEADER0];
> +        int i;
> +
> +        cxl_err =3D QTAILQ_FIRST(&ct3d->error_list);
> +        for (i =3D 0; i < CXL_RAS_ERR_HEADER_NUM; i++) {
> +            stl_le_p(header_log + i, cxl_err->header[i]);
> +        }
> +
> +        capctrl =3D FIELD_DP32(capctrl, CXL_RAS_ERR_CAP_CTRL,
> +                             FIRST_ERROR_POINTER, cxl_err->type);
> +        stl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL, capctrl);
> +    }
> +
> +    unc_err =3D 0;
> +    QTAILQ_FOREACH(cxl_err, &ct3d->error_list, node) {
> +        unc_err |=3D (1 << cxl_err->type);
> +    }
> +    if (!unc_err) {
> +        return;
> +    }
> +
> +    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, unc_err);
> +    pcie_aer_inject_error(PCI_DEVICE(obj), &err);
> +
> +    return;
> +}
> +
> +void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType =
type,
> +                                      Error **errp)
> +{
> +    static PCIEAERErr err =3D {};
> +    Object *obj =3D object_resolve_path(path, NULL);
> +    CXLType3Dev *ct3d;
> +    uint32_t *reg_state;
> +    uint32_t cor_err;
> +    int cxl_err_type;
> +
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +
> +    err.status =3D PCI_ERR_COR_INTERNAL;
> +    err.source_id =3D pci_requester_id(PCI_DEVICE(obj));
> +    err.flags =3D PCIE_AER_ERR_IS_CORRECTABLE;
> +
> +    ct3d =3D CXL_TYPE3(obj);
> +    reg_state =3D ct3d->cxl_cstate.crb.cache_mem_registers;
> +    cor_err =3D ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS);
> +
> +    cxl_err_type =3D ct3d_qmp_cor_err_to_cxl(type);
> +    if (cxl_err_type < 0) {
> +        error_setg(errp, "Invalid COR error");
> +        return;
> +    }
> +    /* If the error is masked, nothting to do here */
> +    if (!((1 << cxl_err_type) & ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_=
MASK))) {
> +        return;
> +    }
> +
> +    cor_err |=3D (1 << cxl_err_type);
> +    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, cor_err);
> +
> +    pcie_aer_inject_error(PCI_DEVICE(obj), &err);
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> new file mode 100644
> index 0000000000..d574c58f9a
> --- /dev/null
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -0,0 +1,17 @@
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-cxl.h"
> +
> +void qmp_cxl_inject_uncorrectable_errors(const char *path,
> +                                         CXLUncorErrorRecordList *errors=
,
> +                                         Error **errp)
> +{
> +    error_setg(errp, "CXL Type 3 support is not compiled in");
> +}
> +
> +void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType =
type,
> +                                      Error **errp)
> +{
> +    error_setg(errp, "CXL Type 3 support is not compiled in");
> +}
> diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> index 609b2b36fc..56c2618b84 100644
> --- a/hw/mem/meson.build
> +++ b/hw/mem/meson.build
> @@ -4,6 +4,8 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c=
'))
>  mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
>  mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
>  mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
> +softmmu_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3=
_stubs.c'))
> +softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))
> =20
>  softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
> =20
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_componen=
t.h
> index 692d7a5507..ec4203b83f 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -65,11 +65,37 @@ CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
>  #define CXL_RAS_REGISTERS_OFFSET 0x80
>  #define CXL_RAS_REGISTERS_SIZE   0x58
>  REG32(CXL_RAS_UNC_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET)
> +#define CXL_RAS_UNC_ERR_CACHE_DATA_PARITY 0
> +#define CXL_RAS_UNC_ERR_CACHE_ADDRESS_PARITY 1
> +#define CXL_RAS_UNC_ERR_CACHE_BE_PARITY 2
> +#define CXL_RAS_UNC_ERR_CACHE_DATA_ECC 3
> +#define CXL_RAS_UNC_ERR_MEM_DATA_PARITY 4
> +#define CXL_RAS_UNC_ERR_MEM_ADDRESS_PARITY 5
> +#define CXL_RAS_UNC_ERR_MEM_BE_PARITY 6
> +#define CXL_RAS_UNC_ERR_MEM_DATA_ECC 7
> +#define CXL_RAS_UNC_ERR_REINIT_THRESHOLD 8
> +#define CXL_RAS_UNC_ERR_RSVD_ENCODING 9
> +#define CXL_RAS_UNC_ERR_POISON_RECEIVED 10
> +#define CXL_RAS_UNC_ERR_RECEIVER_OVERFLOW 11
> +#define CXL_RAS_UNC_ERR_INTERNAL 14
> +#define CXL_RAS_UNC_ERR_CXL_IDE_TX 15
> +#define CXL_RAS_UNC_ERR_CXL_IDE_RX 16
> +#define CXL_RAS_UNC_ERR_CXL_UNUSED 63 /* Magic value */
>  REG32(CXL_RAS_UNC_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x4)
>  REG32(CXL_RAS_UNC_ERR_SEVERITY, CXL_RAS_REGISTERS_OFFSET + 0x8)
>  REG32(CXL_RAS_COR_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET + 0xc)
> +#define CXL_RAS_COR_ERR_CACHE_DATA_ECC 0
> +#define CXL_RAS_COR_ERR_MEM_DATA_ECC 1
> +#define CXL_RAS_COR_ERR_CRC_THRESHOLD 2
> +#define CXL_RAS_COR_ERR_RETRY_THRESHOLD 3
> +#define CXL_RAS_COR_ERR_CACHE_POISON_RECEIVED 4
> +#define CXL_RAS_COR_ERR_MEM_POISON_RECEIVED 5
> +#define CXL_RAS_COR_ERR_PHYSICAL 6
>  REG32(CXL_RAS_COR_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x10)
>  REG32(CXL_RAS_ERR_CAP_CTRL, CXL_RAS_REGISTERS_OFFSET + 0x14)
> +    FIELD(CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER, 0, 6)
> +REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
> +#define CXL_RAS_ERR_HEADER_NUM 32
>  /* Offset 0x18 - 0x58 reserved for RAS logs */
> =20
>  /* 8.2.5.10 - CXL Security Capability Structure */
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 7e5ad65c1d..d589f78202 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -232,6 +232,14 @@ REG64(CXL_MEM_DEV_STS, 0)
>      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
>      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
> =20
> +typedef struct CXLError {
> +    QTAILQ_ENTRY(CXLError) node;
> +    int type; /* Error code as per FE definition */
> +    uint32_t header[32];
Instead of using 32 here, would it be better to use
CXL_RAS_ERR_HEADER_NUM?
> +} CXLError;
> +
> +typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -248,6 +256,9 @@ struct CXLType3Dev {
> =20
>      /* DOE */
>      DOECap doe_cdat;
> +
> +    /* Error injection */
> +    CXLErrorList error_list;
>  };
> =20
>  #define TYPE_CXL_TYPE3 "cxl-type3"
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> new file mode 100644
> index 0000000000..4be7d46041
> --- /dev/null
> +++ b/qapi/cxl.json
> @@ -0,0 +1,128 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=3Dpython
> +
> +##
> +# =3D CXL devices
> +##
> +
> +##
> +# @CxlUncorErrorType:
> +#
> +# Type of uncorrectable CXL error to inject. These errors are reported v=
ia
> +# an AER uncorrectable internal error with additional information logged=
 at
> +# the CXL device.
> +#
> +# @cache-data-parity: Data error such as data parity or data ECC error C=
XL.cache
> +# @cache-address-parity: Address parity or other errors associated with =
the
> +#                        address field on CXL.cache
> +# @cache-be-parity: Byte enable parity or other byte enable errors on CX=
L.cache
> +# @cache-data-ecc: ECC error on CXL.cache
> +# @mem-data-parity: Data error such as data parity or data ECC error on =
CXL.mem
> +# @mem-address-parity: Address parity or other errors associated with th=
e
> +#                      address field on CXL.mem
> +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.=
mem.
> +# @mem-data-ecc: Data ECC error on CXL.mem.
> +# @reinit-threshold: REINIT threshold hit.
> +# @rsvd-encoding: Received unrecognized encoding.
> +# @poison-received: Received poison from the peer.
> +# @receiver-overflow: Buffer overflows (first 3 bits of header log indic=
ate which)
> +# @internal: Component specific error
> +# @cxl-ide-tx: Integrity and data encryption tx error.
> +# @cxl-ide-rx: Integrity and data encryption rx error.
> +#
> +# Since: 8.0
> +##
> +
> +{ 'enum': 'CxlUncorErrorType',
> +  'data': ['cache-data-parity',
> +           'cache-address-parity',
> +           'cache-be-parity',
> +           'cache-data-ecc',
> +           'mem-data-parity',
> +           'mem-address-parity',
> +           'mem-be-parity',
> +           'mem-data-ecc',
> +           'reinit-threshold',
> +           'rsvd-encoding',
> +           'poison-received',
> +           'receiver-overflow',
> +           'internal',
> +           'cxl-ide-tx',
> +           'cxl-ide-rx'
> +           ]
> + }
> +
> +##
> +# @CXLUncorErrorRecord:
> +#
> +# Record of a single error including header log.
> +#
> +# @type: Type of error
> +# @header: 16 DWORD of header.
> +#
> +# Since: 8.0
> +##
> +{ 'struct': 'CXLUncorErrorRecord',
> +  'data': {
> +      'type': 'CxlUncorErrorType',
> +      'header': [ 'uint32' ]
> +  }
> +}
> +
> +##
> +# @cxl-inject-uncorrectable-errors:
> +#
> +# Command to allow injection of multiple errors in one go. This allows t=
esting
> +# of multiple header log handling in the OS.
> +#
> +# @path: CXL Type 3 device canonical QOM path
> +# @errors: Errors to inject
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-inject-uncorrectable-errors',
> +  'data': { 'path': 'str',
> +             'errors': [ 'CXLUncorErrorRecord' ] }}
> +
> +##
> +# @CxlCorErrorType:
> +#
> +# Type of CXL correctable error to inject
> +#
> +# @cache-data-ecc: Data ECC error on CXL.cache
> +# @mem-data-ecc: Data ECC error on CXL.mem
> +# @crc-threshold: Component specific and applicable to 68 byte Flit mode=
 only.
> +# @cache-poison-received: Received poison from a peer on CXL.cache.
> +# @mem-poison-received: Received poison from a peer on CXL.mem
> +# @physical: Received error indication from the physical layer.
> +#
> +# Since: 8.0
> +##
> +{ 'enum': 'CxlCorErrorType',
> +  'data': ['cache-data-ecc',
> +           'mem-data-ecc',
> +           'crc-threshold',
> +           'retry-threshold',
> +           'cache-poison-received',
> +           'mem-poison-received',
> +           'physical']
> +}
> +
> +##
> +# @cxl-inject-correctable-error:
> +#
> +# Command to inject a single correctable error.  Multiple error injectio=
n
> +# of this error type is not interesting as there is no associated header=
 log.
> +# These errors are reported via AER as a correctable internal error, wit=
h
> +# additional detail available from the CXL device.
> +#
> +# @path: CXL Type 3 device canonical QOM path
> +# @type: Type of error.
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-inject-correctable-error',
> +  'data': { 'path': 'str',
> +            'type': 'CxlCorErrorType'
> +  }
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index fbdb442fdf..73c3c8c31a 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -31,6 +31,7 @@ qapi_all_modules =3D [
>    'compat',
>    'control',
>    'crypto',
> +  'cxl',
>    'dump',
>    'error',
>    'introspect',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index f000b90744..079f2a402a 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -95,3 +95,4 @@
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }
> +{ 'include': 'cxl.json' }
> --=20
> 2.37.2
>=20
> =
