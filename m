Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E35C2BA4C
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 18:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiAZSTp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 13:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiAZSTo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jan 2022 13:19:44 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C38BC06161C
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 10:19:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l5so389603edv.3
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 10:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gUpEgoemwjD1v+eGiGE0TXEicDs+5v/D/6z4WQwDDMA=;
        b=qTyGJLXj0RBRSZpIYfRypJmXFOV5hUz6o6TosuGu088xp21Nv5tlW4Op/wRXzUF0qF
         wvU8V0ssD+8HuU1Lhbxb2FCwLzkXYx/chUILzR6hV/+Zle4/dz0TYDmq0COY5aEk2iWG
         1gu0jsGeXNKgifr+oOYDe0SNMSXBOEIAIka8QUwcjCz+UjqK1ME6apK2Wdl8Jx+3XkRa
         crxLcOAOZ7i8uTCL/8vHQetRNp2oNV+Uw2yFcj0lx8P2/F1T8wA3xIqD1gXMA7RHrIwL
         vOFwYh1I2T6xvHHsv8Vpn8m7q0TtTfkUSX2iuRTCK8hhgnmJ++M5nM9uUhAU/PvSzfKm
         hdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gUpEgoemwjD1v+eGiGE0TXEicDs+5v/D/6z4WQwDDMA=;
        b=wXiBRwyPFO1HWzrsIIYWb2DFwA3iENGbwPhmJzFIzEy93G2/zyJITL9QKTAPotSjR2
         w4mdBrJwdlO2DLn9gmrAWNcXOwoM/W12oCdQhC6OJ3AJeT/hzHdxNwZy0RtPLBPsDTe9
         Z3T/L4YJI/mDoe5IkkDvC5MDNI0C/r7G6i8DmZakW2ZeUmw5+LMkEMZ2EAMIfshLiz9S
         uzK+SBme36AnUDONWmsp1Ns72/lmQIHxnMCscHwHXpzU7iI1YMJPMcFPR3fzLLBnjenx
         zfyyGRp3P+gLgIJQKRksaMN7wnTmjTWYRzp9Ouam9XBCJCVOhFZYOMzhlA+AHL1x2+CQ
         zOLQ==
X-Gm-Message-State: AOAM5334i7mbi7wbK9fQWc6fl6EufxIThMOLy02ETUe8zAEUJA0LVC4Q
        nTfIvUIQB99M2L/XavL7eYiVDw==
X-Google-Smtp-Source: ABdhPJwRgSghi8ZKMP+QBJZKeH+HNhSnQkaOim4XnwXn14jGlm8lPwMecjUso2V8fp2dRtCzOc/x5w==
X-Received: by 2002:aa7:d4c1:: with SMTP id t1mr227514edr.207.1643221182498;
        Wed, 26 Jan 2022 10:19:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id v28sm10090847edw.95.2022.01.26.10.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:19:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id A08A41FFB7;
        Wed, 26 Jan 2022 18:19:40 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-6-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 05/42] hw/cxl/device: Implement the CAP array
 (8.2.8.1-2)
Date:   Wed, 26 Jan 2022 18:17:12 +0000
In-reply-to: <20220124171705.10432-6-Jonathan.Cameron@huawei.com>
Message-ID: <87tudqbbr7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> This implements all device MMIO up to the first capability. That
> includes the CXL Device Capabilities Array Register, as well as all of
> the CXL Device Capability Header Registers. The latter are filled in as
> they are implemented in the following patches.
>
> Endianness and alignment are managed by softmmu memory core.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-device-utils.c   | 105 ++++++++++++++++++++++++++++++++++++
>  hw/cxl/meson.build          |   1 +
>  include/hw/cxl/cxl_device.h |  28 +++++++++-
>  3 files changed, 133 insertions(+), 1 deletion(-)
>
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> new file mode 100644
> index 0000000000..cb1b0a8217
> --- /dev/null
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -0,0 +1,105 @@
> +/*
> + * CXL Utility library for devices
> + *
> + * Copyright(C) 2020 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See =
the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/cxl/cxl.h"
> +
> +/*
> + * Device registers have no restrictions per the spec, and so fall back =
to the
> + * default memory mapped register rules in 8.2:
> + *   Software shall use CXL.io Memory Read and Write to access memory ma=
pped
> + *   register defined in this section. Unless otherwise specified, softw=
are
> + *   shall restrict the accesses width based on the following:
> + *   =E2=80=A2 A 32 bit register shall be accessed as a 1 Byte, 2 Bytes =
or 4 Bytes
> + *     quantity.
> + *   =E2=80=A2 A 64 bit register shall be accessed as a 1 Byte, 2 Bytes,=
 4 Bytes or 8
> + *     Bytes
> + *   =E2=80=A2 The address shall be a multiple of the access width, e.g.=
 when
> + *     accessing a register as a 4 Byte quantity, the address shall be
> + *     multiple of 4.
> + *   =E2=80=A2 The accesses shall map to contiguous bytes.If these rules=
 are not
> + *     followed, the behavior is undefined
> + */
> +
> +static uint64_t caps_reg_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    CXLDeviceState *cxl_dstate =3D opaque;
> +
> +    return cxl_dstate->caps_reg_state32[offset / 4];
> +}
> +
> +static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static const MemoryRegionOps dev_ops =3D {
> +    .read =3D dev_reg_read,
> +    .write =3D NULL, /* status register is read only */
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +        .unaligned =3D false,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};

I think for >64 bit registers you need to use the read_with_attrs=20

> +
> +static const MemoryRegionOps caps_ops =3D {
> +    .read =3D caps_reg_read,
> +    .write =3D NULL, /* caps registers are read only */
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +        .unaligned =3D false,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dst=
ate)
> +{
> +    /* This will be a BAR, so needs to be rounded up to pow2 for PCI spe=
c */
> +    memory_region_init(&cxl_dstate->device_registers, obj, "device-regis=
ters",
> +                       pow2ceil(CXL_MMIO_SIZE));
> +
> +    memory_region_init_io(&cxl_dstate->caps, obj, &caps_ops, cxl_dstate,
> +                          "cap-array", CXL_CAPS_SIZE);
> +    memory_region_init_io(&cxl_dstate->device, obj, &dev_ops, cxl_dstate,
> +                          "device-status", CXL_DEVICE_REGISTERS_LENGTH);
> +
> +    memory_region_add_subregion(&cxl_dstate->device_registers, 0,
> +                                &cxl_dstate->caps);
> +    memory_region_add_subregion(&cxl_dstate->device_registers,
> +                                CXL_DEVICE_REGISTERS_OFFSET,
> +                                &cxl_dstate->device);
> +}
> +
> +static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
> +
> +void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
> +{
> +    uint32_t *cap_hdrs =3D cxl_dstate->caps_reg_state32;
> +    const int cap_count =3D 1;
> +
> +    /* CXL Device Capabilities Array Register */
> +    ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
> +    ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
> +    ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY2, CAP_COUNT, cap_count);
> +
> +    cxl_device_cap_init(cxl_dstate, DEVICE, 1);
> +    device_reg_init_common(cxl_dstate);
> +}
> diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
> index 00c3876a0f..47154d6850 100644
> --- a/hw/cxl/meson.build
> +++ b/hw/cxl/meson.build
> @@ -1,3 +1,4 @@
>  softmmu_ss.add(when: 'CONFIG_CXL', if_true: files(
>    'cxl-component-utils.c',
> +  'cxl-device-utils.c',
>  ))
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 3b6ed745f0..4bdfa80eb4 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -63,6 +63,8 @@
>  #define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
>  #define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
>  #define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
> +#define CXL_CAPS_SIZE \
> +    (CXL_DEVICE_CAP_REG_SIZE * (CXL_DEVICE_CAPS_MAX + 1)) /* +1 for head=
er */
>=20=20
>  #define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above */
>  #define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */
> @@ -75,11 +77,18 @@
>  #define CXL_MAILBOX_REGISTERS_LENGTH \
>      (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
>=20=20
> +#define CXL_MMIO_SIZE                                           \
> +    (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_REGISTERS_LENGTH +    \
> +     CXL_MAILBOX_REGISTERS_LENGTH)
> +
>  typedef struct cxl_device_state {
>      MemoryRegion device_registers;
>=20=20
>      /* mmio for device capabilities array - 8.2.8.2 */
> -    MemoryRegion caps;
> +    struct {
> +        MemoryRegion caps;
> +        uint32_t caps_reg_state32[CXL_CAPS_SIZE / 4];
> +    };
>=20=20
>      /* mmio for the device status registers 8.2.8.3 */
>      MemoryRegion device;
> @@ -128,6 +137,23 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DE=
VICE_CAP_HDR1_OFFSET)
>  CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSE=
T + \
>                                                 CXL_DEVICE_CAP_REG_SIZE)
>=20=20
> +#define cxl_device_cap_init(dstate, reg, cap_id)                        =
   \
> +    do {                                                                =
   \
> +        uint32_t *cap_hdrs =3D dstate->caps_reg_state32;                =
     \
> +        int which =3D R_CXL_DEV_##reg##_CAP_HDR0;                       =
     \
> +        cap_hdrs[which] =3D                                             =
     \
> +            FIELD_DP32(cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0,       =
   \
> +                       CAP_ID, cap_id);                                 =
   \
> +        cap_hdrs[which] =3D FIELD_DP32(                                 =
     \
> +            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, 1); =
   \
> +        cap_hdrs[which + 1] =3D                                         =
     \
> +            FIELD_DP32(cap_hdrs[which + 1], CXL_DEV_##reg##_CAP_HDR1,   =
   \
> +                       CAP_OFFSET, CXL_##reg##_REGISTERS_OFFSET);       =
   \
> +        cap_hdrs[which + 2] =3D                                         =
     \
> +            FIELD_DP32(cap_hdrs[which + 2], CXL_DEV_##reg##_CAP_HDR2,   =
   \
> +                       CAP_LENGTH, CXL_##reg##_REGISTERS_LENGTH);       =
   \
> +    } while (0)
> +
>  REG32(CXL_DEV_MAILBOX_CAP, 0)
>      FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
>      FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
