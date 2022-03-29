Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57547C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Mar 2022 18:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiC2SP5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiC2SPz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 14:15:55 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6C3BBFD
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 11:14:06 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220329181402usoutp0130f7cf50f610b057e6e88591072f3ceb~g7KGFeQvP0789207892usoutp01E;
        Tue, 29 Mar 2022 18:14:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220329181402usoutp0130f7cf50f610b057e6e88591072f3ceb~g7KGFeQvP0789207892usoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648577642;
        bh=wPCdolKMzxdipJhRXDbJxj0vhU+yYmPd9EIJLEuMKxs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Ga+63xPsODIoGUgxKRlg2wlrXUMVxRYvTro1Yk9ICjG2PzshjoDv8zRDt4c0PuLwu
         4hZ7yO+j7JqZRYmbiRhPNQYwlWCDeE1zQxTOg+aGPOmBJyitehbzVbpts2z5vBzfL7
         8KyrhA8lPnDFly8Bm42QVmo6f613pVte4lWT9dGo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220329181401uscas1p144404e0070b810516abfad05aa57345b~g7KFoy4Qs2954629546uscas1p1Z;
        Tue, 29 Mar 2022 18:14:01 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 80.A6.09642.96C43426; Tue,
        29 Mar 2022 14:14:01 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd~g7KFMQIjZ2124721247uscas1p29;
        Tue, 29 Mar 2022 18:14:01 +0000 (GMT)
X-AuditID: cbfec36f-c15ff700000025aa-74-62434c69e3d4
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 6F.A6.09665.86C43426; Tue,
        29 Mar 2022 14:14:00 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Tue, 29 Mar 2022 11:14:00 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Tue, 29 Mar 2022 11:13:59 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Tong Zhang <t.zhang2@samsung.com>,
        "k.jensen@samsung.com" <k.jensen@samsung.com>
Subject: Re: [PATCH v8 04/46] hw/cxl/device: Introduce a CXL device (8.2.8)
Thread-Topic: [PATCH v8 04/46] hw/cxl/device: Introduce a CXL device (8.2.8)
Thread-Index: AQHYQ5jDAh0o55BFMkO81MsYMsoB9Q==
Date:   Tue, 29 Mar 2022 18:13:59 +0000
Message-ID: <20220329181353.GA59203@bgt-140510-bm01>
In-Reply-To: <20220318150635.24600-5-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <80E657C1F441FF4FAD9F37A07E34D5BE@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/v82sNq9Ujc9hVa1qKrazZhZ/QVOgjrzqfU0ji4zv6oOZ+Q
        YkM3+WFdtQQUhpMZzZ0jA5Jh6tTxIyCOE2Us4ocBl0ywEZSgIQ2nQhw/whjPvOO/1+c+7/f3
        Xp+7L42HVlLhdJp2H6fTqtJllJCo/3m656W0La/vjOo8IkUFIwaAys4NE8h4sxhHRT1OgKyW
        XoDODjoAmr4wh6Nfai7jqMtdgKMzFR4K9dg6CeSq7sZQobuYRIYOLXowd5tELfWLJPq2e4RA
        dS3/ClC7qZFAvX1nCWT6Y4FADf0HSFRdb6Fek7CX/q4QsL0lZpJ1FE5gbKl/CmPz2nwkOzaU
        K2CtJxZw9mTzOMZ6Pc0UO+qpxdg7F/sp1lL6JXu/5qltoh3CV3dx6WlZnG5d/IfC3YOH28g9
        +dtyhouOkgZgjTGCEBoy62HD74O4EQjpUOY0gNOn+ih+yMfgbb8Bf5i6eiKP5BfnAJyxn8f4
        4S6ARXUDwf4lAE2t4yBQoZgoON9evVwPY5RwcuBrEAjhTAsNT3vPL4eeYDbDkntlJB/aAj1t
        U8GCAubZfyKMgKYJ5jloMm4MoGhJ49hwdCARwiTCbl8RFWDAiOFMpwMLMM5I4PXRMoy3XgW/
        L20OXiCGi01/Ujw/A4dnxgV8XgEHLN9QPMfDXEMjzrMcVlVMLLNo6Z2O46ME310NL/8wQARO
        gcxBITRUDgn4xRvQZ3YBniOg1fFbMHQIQL/5IskPZgC9vtmgRhxcLPQIzCDStsLctsLKtsLK
        tsLKtsKqHJBngCRTr9ekcnqllstW6FUafaY2VaHO0NSApY/ctejKaATXrt9VtAKMBq0A0rgs
        TCS9krAzVLRLtf9TTpfxgS4zndO3ggiakElEVWlOVSiTqtrHfcJxezjdwy1Gh4QbMBiSUOHu
        OyRs2N72xYVjTWvejpSPh9M7rqDyd5617H8wJV93K5l0fjd/NUmWbdXegJv7Sq1/1W5Q/hO/
        3pCE1Il7lagkaz7m0Y+N2hGvo6jLppbatz5/L8J51HTywFTv1rWMpU0SnehQ33/z/c/HbsbW
        StUjyVn4k1Gj3Sm2uLh8aPduGooUp0yumv0sVj47OHn8rXcTfk1a/YoazI9lR0d0+k2dM35D
        fW6xfuTHDdcicrL6ldKcl33I1d5wJ65g8ZGN/x3+Slx+65TGVdcst1cdfKwyZtb5wuNrqjj3
        WKOmK3cyLNPOxHRsX7DE3pCJU7gjH0UONe192u1KXlvz3sScjNDvVkW/iOv0qv8Buh4h4TcE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWS2cA0UTfTxznJYGeKRceDBkaL+Wvvs1h0
        Petntug+v4HRYvrUC4wWq2+uYbT4uv4Xs8WJTQeZLU4f7WC2WLXwGpvF+VmnWCwObzzDZNF5
        tJ/VouFknsX/X69YLfZv+8dqMefMAxaLLfu/sVsc793BYnHh4moWi957f1gstl9tYrXYuG0q
        m4O4x4EXC9k9LkyewOqxpvM1k8fsD1+YPFqOvGX1eHq3md1j+tw/zB6L97xk8rhzbQ+bx5Nr
        m5k83u+7yuYxdXa9x+dNcgG8UVw2Kak5mWWpRfp2CVwZN3uOsBa0BlTc757I2sA43ayLkZND
        QsBE4srcFtYuRi4OIYHVjBKdp+4ygSSEBD4ySvw6GQ6ROMAoMaX9ITNIgk3AQOL38Y1gtoiA
        kcS7G5MYQYqYBfZzSKy8s44RJCEs4C0x+dN8VogiH4lrR75ANehJtCzdydLFyMHBIqAq0dvl
        BGLyAl0x7b4hxN5yidYpH9hBbE4BR4kzb7vZQGxGATGJ76fWgN3GLCAucevJfCaIBwQkluw5
        zwxhi0q8fPyPFcJWlLj//SU7RL2exI2pU9ggbDuJ5oYdzBC2tsSyha/BbF4BQYmTM5+wQPRK
        ShxccYNlAqPELCTrZiEZNQvJqFlIRs1CMmoBI+sqRvHS4uLc9Ipi47zUcr3ixNzi0rx0veT8
        3E2MwBR2+t/hmB2M92591DvEyMTBeIhRgoNZSYRX9qx9khBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXFej9iJ8UIC6YklqdmpqQWpRTBZJg5OqQYmJ46pxVPvd6T8v7xh2qMH5wT9eMx7j/Ow6aou
        4b5Q0ito9LbWSew3j/GffQqlz9N27LNwOHL5Vcs/9vSnBueaVvLMSZqr8FnWV/GD0Uzuv8X2
        TOuXq0wP5v68WTym1GGJgNnilSrZKVOkbr+y1eY8z3c+uM3owgY+zmyh9iBD1k3cUgFcl9Uj
        ataIO3sLb5S9dOXx5w8nfh5+vv1z1g+DY+Wuxz121rsb/DBV6P/v92n7vpyuRVtX/ysr5LGa
        f0Ji09Sm0t5/5w5Mfvz9wmSf9fVvZt4V7r6+QlzrweKm+8ujI8omnQ+Zo3H6dKy9GuPOFzLy
        G+/fbhJWn9LIrvbNqZhlUvCnkLL2dae2+gofVWIpzkg01GIuKk4EAF4arnTQAwAA
X-CMS-MailID: 20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd
CMS-TYPE: 301P
X-CMS-RootMailID: 20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-5-Jonathan.Cameron@huawei.com>
        <CGME20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 18, 2022 at 03:05:53PM +0000, Jonathan Cameron wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
>=20
> A CXL device is a type of CXL component. Conceptually, a CXL device
> would be a leaf node in a CXL topology. From an emulation perspective,
> CXL devices are the most complex and so the actual implementation is
> reserved for discrete commits.
>=20
> This new device type is specifically catered towards the eventual
> implementation of a Type3 CXL.mem device, 8.2.8.5 in the CXL 2.0
> specification.
>=20
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  include/hw/cxl/cxl.h        |   1 +
>  include/hw/cxl/cxl_device.h | 165 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 166 insertions(+)
>=20
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 8c738c7a2b..b9d1ac3fad 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -12,5 +12,6 @@
> =20
>  #include "cxl_pci.h"
>  #include "cxl_component.h"
> +#include "cxl_device.h"
> =20
>  #endif
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> new file mode 100644
> index 0000000000..b2416e45bf
> --- /dev/null
> +++ b/include/hw/cxl/cxl_device.h
> @@ -0,0 +1,165 @@
> +/*
> + * QEMU CXL Devices
> + *
> + * Copyright (c) 2020 Intel
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See =
the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef CXL_DEVICE_H
> +#define CXL_DEVICE_H
> +
> +#include "hw/register.h"
> +
> +/*
> + * The following is how a CXL device's MMIO space is laid out. The only
> + * requirement from the spec is that the capabilities array and the capa=
bility
> + * headers start at offset 0 and are contiguously packed. The headers th=
emselves
> + * provide offsets to the register fields. For this emulation, registers=
 will
> + * start at offset 0x80 (m =3D=3D 0x80). No secondary mailbox is impleme=
nted which
> + * means that n =3D m + sizeof(mailbox registers) + sizeof(device regist=
ers).

What is n here, the start offset of the mailbox registers, this question is=
=20
based on the figure below?

> + *
> + * This is roughly described in 8.2.8 Figure 138 of the CXL 2.0 spec.
> + *
> + *                       +---------------------------------+
> + *                       |                                 |
> + *                       |    Memory Device Registers      |
> + *                       |                                 |
> + * n + PAYLOAD_SIZE_MAX  -----------------------------------
> + *                  ^    |                                 |
> + *                  |    |                                 |
> + *                  |    |                                 |
> + *                  |    |                                 |
> + *                  |    |                                 |
> + *                  |    |         Mailbox Payload         |
> + *                  |    |                                 |
> + *                  |    |                                 |
> + *                  |    |                                 |
> + *                  |    -----------------------------------
> + *                  |    |       Mailbox Registers         |
> + *                  |    |                                 |
> + *                  n    -----------------------------------
> + *                  ^    |                                 |
> + *                  |    |        Device Registers         |
> + *                  |    |                                 |
> + *                  m    ---------------------------------->
> + *                  ^    |  Memory Device Capability Header|
> + *                  |    -----------------------------------
> + *                  |    |     Mailbox Capability Header   |
> + *                  |    -------------- --------------------
> + *                  |    |     Device Capability Header    |
> + *                  |    -----------------------------------
> + *                  |    |                                 |
> + *                  |    |                                 |
> + *                  |    |      Device Cap Array[0..n]     |
> + *                  |    |                                 |
> + *                  |    |                                 |
> + *                       |                                 |
> + *                  0    +---------------------------------+

Would it make sense to add CXL cap header register to the diagram? n also=20
seems to be the size of the cap array, but it is also an offset so that cou=
ld
be clarified.

> + *
> + */
> +
> +#define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
> +#define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
> +#define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
> +
> +#define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above */

Is this to plan for future capabilities? If we have CAPS MAX doesn't this=20
allow us to remove the slack space.=20

> +#define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */

Should we add status to the name here, or would it get too long?

> +
> +#define CXL_MAILBOX_REGISTERS_OFFSET \
> +    (CXL_DEVICE_REGISTERS_OFFSET + CXL_DEVICE_REGISTERS_LENGTH)
> +#define CXL_MAILBOX_REGISTERS_SIZE 0x20 /* 8.2.8.4, Figure 139 */
> +#define CXL_MAILBOX_PAYLOAD_SHIFT 11

I see 20 in the spec.

> +#define CXL_MAILBOX_MAX_PAYLOAD_SIZE (1 << CXL_MAILBOX_PAYLOAD_SHIFT)
> +#define CXL_MAILBOX_REGISTERS_LENGTH \
> +    (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
> +
> +typedef struct cxl_device_state {
> +    MemoryRegion device_registers;
> +
> +    /* mmio for device capabilities array - 8.2.8.2 */
> +    MemoryRegion device;
> +    MemoryRegion caps;
> +
> +    /* mmio for the mailbox registers 8.2.8.4 */
> +    MemoryRegion mailbox;
> +
> +    /* memory region for persistent memory, HDM */
> +    uint64_t pmem_size;

Can we switch this to mem_size and drop the persistent comment? It is my=20
understanding that HDM is independent of persistence.

> +} CXLDeviceState;
> +
> +/* Initialize the register block for a device */
> +void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);
> +
> +/* Set up default values for the register block */
> +void cxl_device_register_init_common(CXLDeviceState *dev);
> +
> +/*
> + * CXL 2.0 - 8.2.8.1 including errata F4
> + * Documented as a 128 bit register, but 64 bit accesses and the second
> + * 64 bits are currently reserved.
> + */
> +REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64 byt=
e accesses */
> +    FIELD(CXL_DEV_CAP_ARRAY, CAP_ID, 0, 16)
> +    FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
> +    FIELD(CXL_DEV_CAP_ARRAY, CAP_COUNT, 32, 16)
> +
> +/*
> + * Helper macro to initialize capability headers for CXL devices.
> + *
> + * In the 8.2.8.2, this is listed as a 128b register, but in 8.2.8, it s=
ays:
> + * > No registers defined in Section 8.2.8 are larger than 64-bits wide =
so that
> + * > is the maximum access size allowed for these registers. If this rul=
e is not
> + * > followed, the behavior is undefined
> + *
> + * CXL 2.0 Errata F4 states futher that the layouts in the specification=
 are
> + * shown as greater than 128 bits, but implementations are expected to
> + * use any size of access up to 64 bits.
> + *
> + * Here we've chosen to make it 4 dwords. The spec allows any pow2 multi=
ple
> + * access to be used for a register up to 64 bits.
> + */
> +#define CXL_DEVICE_CAPABILITY_HEADER_REGISTER(n, offset)  \
> +    REG32(CXL_DEV_##n##_CAP_HDR0, offset)                 \
> +        FIELD(CXL_DEV_##n##_CAP_HDR0, CAP_ID, 0, 16)      \
> +        FIELD(CXL_DEV_##n##_CAP_HDR0, CAP_VERSION, 16, 8) \
> +    REG32(CXL_DEV_##n##_CAP_HDR1, offset + 4)             \
> +        FIELD(CXL_DEV_##n##_CAP_HDR1, CAP_OFFSET, 0, 32)  \
> +    REG32(CXL_DEV_##n##_CAP_HDR2, offset + 8)             \
> +        FIELD(CXL_DEV_##n##_CAP_HDR2, CAP_LENGTH, 0, 32)
> +
> +CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DEVICE_CAP_HDR1_OFFSET=
)
> +CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSE=
T + \
> +                                               CXL_DEVICE_CAP_REG_SIZE)
> +

Fig139 for the following registers.

8.2.8.4.3
> +REG32(CXL_DEV_MAILBOX_CAP, 0)
> +    FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
> +    FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
> +    FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
> +    FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
> +

8.2.8.4.4=20
> +REG32(CXL_DEV_MAILBOX_CTRL, 4)
> +    FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
> +    FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
> +    FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
> +

8.2.8.4.5 + 8.2.9
> +REG64(CXL_DEV_MAILBOX_CMD, 8)
> +    FIELD(CXL_DEV_MAILBOX_CMD, COMMAND, 0, 8)
> +    FIELD(CXL_DEV_MAILBOX_CMD, COMMAND_SET, 8, 8)
> +    FIELD(CXL_DEV_MAILBOX_CMD, LENGTH, 16, 20)
> +

8.2.8.4.6
> +REG64(CXL_DEV_MAILBOX_STS, 0x10)
> +    FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
> +    FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
> +    FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
> +

8.2.8.4.7
> +REG64(CXL_DEV_BG_CMD_STS, 0x18)
> +    FIELD(CXL_DEV_BG_CMD_STS, BG, 0, 16)

Should we call this OP since it is implied that we are BG given the registe=
r?

> +    FIELD(CXL_DEV_BG_CMD_STS, DONE, 16, 7)

NUM_DONE? since this is a percentage.

> +    FIELD(CXL_DEV_BG_CMD_STS, ERRNO, 32, 16)

Isn't this a RET_CODE since it is only valid if previous field is 100%

> +    FIELD(CXL_DEV_BG_CMD_STS, VENDOR_ERRNO, 48, 16)

VENDOR_RET_CODE since the same rule for the previous field applies here.

> +
> +REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
> +
> +#endif
> --=20
> 2.32.0
>=20
>=20

+cc Dave, Klaus, Tong
Other than the minor issues raised.

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
