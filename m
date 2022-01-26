Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC6AC2BA4C
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 18:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbiAZSOQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 13:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiAZSOO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jan 2022 13:14:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18403C06161C
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 10:14:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m14so250199wrg.12
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZvgK+QZyvEmyj+Fvgogwj2AL6mx7jH4qhulJ7qAj6ek=;
        b=RIGuTtFIiPUyNgVsNjOvHCUzFqzp35njVHhWkktXeHeFPaEBhd3HyNDdKS8bzlxBLM
         LAJKTx6lsyVb7SbOrOHuQfRw8TJgEQclm1Tc8ZHyGM5fBup+H4wcitclaoX3AujEEcWg
         VqVVNI41yVl54fTa0XnhNyeND2oQusMt8H9i+7TW8Jyu8vkIwxOWMJGMJH1w23NNVQBg
         9omRtt8VQh5n9herSrwpuuug9rWobHj+y2lhaVtEPfiPIge44Uc2ymw3Kroa0pHL7MQ/
         ikf6VOvwAAzbh0pgzu1BpEcsTtErZfYWIAtl402ZJftjqsnVZOuTr35ctK0cPxfRXWE/
         5nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZvgK+QZyvEmyj+Fvgogwj2AL6mx7jH4qhulJ7qAj6ek=;
        b=UpNS5/55F1bToYZyFYM2diRiRkwU0jwuGEOknd0pudmRbVRaJJO5vJeUpUiQ+j5BLP
         KX8kMKnOSdIBXenRqzFeEtTU8jTL+ldxFb0cBODsdiEMEv1Wh0GehvIARTK/0/ww6Hom
         H7Yr3a2os0zf8RaRr3Eu20QZwueHy00fc8A6+EnaH7cgImnesbjHl31eTRT0t4IVIYwG
         UF93dOmjGaPIVUPu5DX1EqjmXQmaq++2xLXszPA0FV4SNbsKwsVc6b7fTTie8BD/VhQc
         aqn8+EEa4SO+V+gh+Y3s5endVumWuUKPCtz8TrgE7H+QrZDGJNm3UBwmNSVKi53LJv+o
         py3A==
X-Gm-Message-State: AOAM530l5EoWSKH9uP64ZsM0MeOxLZj6hdk4B+NajeYqpW+B6y9dLxD5
        OhKKZxMRlGH7hjtngI3+P38BnQ==
X-Google-Smtp-Source: ABdhPJwMfQjquNHwTOcO8VFQ4Dhxpdu9olsPZpYY6+9f3Oiz9lx1DkRiQET5sStDkIVAxLh3/3sbRQ==
X-Received: by 2002:a5d:47cf:: with SMTP id o15mr10833417wrc.583.1643220851518;
        Wed, 26 Jan 2022 10:14:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id m187sm3667998wme.25.2022.01.26.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:14:09 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 8A2311FFB7;
        Wed, 26 Jan 2022 18:14:08 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-5-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.6; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 04/42] hw/cxl/device: Introduce a CXL device (8.2.8)
Date:   Wed, 26 Jan 2022 18:07:40 +0000
In-reply-to: <20220124171705.10432-5-Jonathan.Cameron@huawei.com>
Message-ID: <87y232bc0f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> A CXL device is a type of CXL component. Conceptually, a CXL device
> would be a leaf node in a CXL topology. From an emulation perspective,
> CXL devices are the most complex and so the actual implementation is
> reserved for discrete commits.
>
> This new device type is specifically catered towards the eventual
> implementation of a Type3 CXL.mem device, 8.2.8.5 in the CXL 2.0
> specification.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl.h        |   1 +
>  include/hw/cxl/cxl_device.h | 157 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 158 insertions(+)
>
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 8c738c7a2b..b9d1ac3fad 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -12,5 +12,6 @@
>=20=20
>  #include "cxl_pci.h"
>  #include "cxl_component.h"
> +#include "cxl_device.h"
>=20=20
>  #endif
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> new file mode 100644
> index 0000000000..3b6ed745f0
> --- /dev/null
> +++ b/include/hw/cxl/cxl_device.h
> @@ -0,0 +1,157 @@
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
> + *
> + */

Excellent diagram ;-)

> +
> +#define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
> +#define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
> +#define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
> +
> +#define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above */
> +#define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */
> +
> +#define CXL_MAILBOX_REGISTERS_OFFSET \
> +    (CXL_DEVICE_REGISTERS_OFFSET + CXL_DEVICE_REGISTERS_LENGTH)
> +#define CXL_MAILBOX_REGISTERS_SIZE 0x20 /* 8.2.8.4, Figure 139 */
> +#define CXL_MAILBOX_PAYLOAD_SHIFT 11
> +#define CXL_MAILBOX_MAX_PAYLOAD_SIZE (1 << CXL_MAILBOX_PAYLOAD_SHIFT)
> +#define CXL_MAILBOX_REGISTERS_LENGTH \
> +    (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
> +
> +typedef struct cxl_device_state {
> +    MemoryRegion device_registers;
> +
> +    /* mmio for device capabilities array - 8.2.8.2 */
> +    MemoryRegion caps;
> +
> +    /* mmio for the device status registers 8.2.8.3 */
> +    MemoryRegion device;
> +
> +    /* mmio for the mailbox registers 8.2.8.4 */
> +    MemoryRegion mailbox;
> +
> +    /* memory region for persistent memory, HDM */
> +    uint64_t pmem_size;
> +} CXLDeviceState;
> +
> +/* Initialize the register block for a device */
> +void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);
> +
> +/* Set up default values for the register block */
> +void cxl_device_register_init_common(CXLDeviceState *dev);
> +
> +/* CXL 2.0 - 8.2.8.1 */
> +REG32(CXL_DEV_CAP_ARRAY, 0) /* 48b!?!?! */

What does this comment mean? A 48 bit register stuffed in a 32 bit one?
Doesn't seem right.

> +    FIELD(CXL_DEV_CAP_ARRAY, CAP_ID, 0, 16)
> +    FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
> +REG32(CXL_DEV_CAP_ARRAY2, 4) /* We're going to pretend it's 64b */
> +    FIELD(CXL_DEV_CAP_ARRAY2, CAP_COUNT, 0, 16)

I'm confused why you don't treat it as a single register it is in the
spec.

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
> + * Here we've chosen to make it 4 dwords. The spec allows any pow2 multi=
ple
> + * access to be used for a register (2 qwords, 8 words, 128 bytes).
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
> +CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DEVICE_CAP_HDR1_OFFSET)
> +CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSE=
T + \
> +                                               CXL_DEVICE_CAP_REG_SIZE)
> +
> +REG32(CXL_DEV_MAILBOX_CAP, 0)
> +    FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
> +    FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
> +    FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
> +    FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
> +
> +REG32(CXL_DEV_MAILBOX_CTRL, 4)
> +    FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
> +    FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
> +    FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
> +
> +/* XXX: actually a 64b register */
> +REG32(CXL_DEV_MAILBOX_STS, 0x10)
> +    FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
> +    FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
> +    FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
> +
> +/* XXX: actually a 64b register */
> +REG32(CXL_DEV_BG_CMD_STS, 0x18)
> +    FIELD(CXL_DEV_BG_CMD_STS, BG, 0, 16)
> +    FIELD(CXL_DEV_BG_CMD_STS, DONE, 16, 7)
> +    FIELD(CXL_DEV_BG_CMD_STS, ERRNO, 32, 16)
> +    FIELD(CXL_DEV_BG_CMD_STS, VENDOR_ERRNO, 48, 16)

Again is there a reason not to use REG64? I can see the need to split
128 bit registers but not 64 bit ones.

> +
> +REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
> +
> +#endif

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
