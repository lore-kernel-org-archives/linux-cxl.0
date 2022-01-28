Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE216C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 16:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiA1Qij (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiA1Qii (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 11:38:38 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B231C061714
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 08:38:38 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l25so11879793wrb.13
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=C4Ggj/gYiQ0JRxIpeEcODNj165LurJdj6zgn4gKVH28=;
        b=opBpVy4/+F9Wxe+Kn0TNRlXTKX+rTDhhUQRaxJ/TSdaR2HErtj8gSAhUMoDlpMV/FR
         uFrWv9rjSFN+NzSOf5eX3ozJv18QLh4rJDf6YIGbHHRxxz6SoxXJiHwEAMgyj5zmrUd/
         bJxhk97LRJXMy+7YOo8pYS2fLbDl7iFutxp4eiwQiGPW+C1fOmzhf5LBlyY/RF+vrH0p
         HkJZ1cl+SwiT1GAPX8SUqefEz9lKv+Tbr4oyebD+XM6TpIMx9bji6D4NmravFFyK9oQb
         DPbs2DGZdbGrVrzh5VKRFtPlWu2yWWGYAOZNQ7+0MNRZMDq9AhH3GZPnbmwOm8/dDFjW
         y3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=C4Ggj/gYiQ0JRxIpeEcODNj165LurJdj6zgn4gKVH28=;
        b=Q7TkkSniZyv+DXZGhteWHBNDUvxIhvTSnTR77VFqljpUU+D7IjZ432BkXV7tjeN6k6
         k0+2opQO8qZN4xa/GA4vYd2g8JMG1aCriOD9dDvqouBsVF7anSi9AWUdBcsHFbLC1D75
         UFo58RbCailt891d/3tl8b+V+wpe7+8M8GGPmtReKUEnb69betZawk0WPgV9Aoy+ZwXe
         SgIQ+UKBiUTZSJHju5yeixFRAHY4G3aSj3jiWo6HVmC0RTt/piATq8kMhaiU2cz3RAJw
         XeAWVLIKXd/mvDi2n2BUnJpAiUQIJHOE+u+nkBQ4Jr3/qgYUEolyZx4hCWGWHhEPLWNs
         Pq7w==
X-Gm-Message-State: AOAM531IsLGMNaIQRlX7eohGOM+MuyS6pgVnBiVsfGsbUfdoeVtNe/EM
        /EX6Q94JSqBKADnqOlDxc0yguQ==
X-Google-Smtp-Source: ABdhPJwHby4B8sxBZ1gBb/xW91TLcnBNy08WeKk3H5DAk/M6rUSpsWp0iKRw99IyMwII+yyBc0ljow==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr7426100wrx.336.1643387916970;
        Fri, 28 Jan 2022 08:38:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id n2sm5784725wrw.63.2022.01.28.08.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:38:35 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 3C2FC1FFB7;
        Fri, 28 Jan 2022 16:38:35 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-6-Jonathan.Cameron@huawei.com>
 <87tudqbbr7.fsf@linaro.org> <20220128151607.000022b7@huawei.com>
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
Date:   Fri, 28 Jan 2022 16:37:45 +0000
In-reply-to: <20220128151607.000022b7@huawei.com>
Message-ID: <87czkb95o4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Wed, 26 Jan 2022 18:17:12 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>>=20
>> > From: Ben Widawsky <ben.widawsky@intel.com>
>> >
>> > This implements all device MMIO up to the first capability. That
>> > includes the CXL Device Capabilities Array Register, as well as all of
>> > the CXL Device Capability Header Registers. The latter are filled in as
>> > they are implemented in the following patches.
>> >
>> > Endianness and alignment are managed by softmmu memory core.
>> >
>> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> > ---
>> >  hw/cxl/cxl-device-utils.c   | 105 ++++++++++++++++++++++++++++++++++++
>> >  hw/cxl/meson.build          |   1 +
>> >  include/hw/cxl/cxl_device.h |  28 +++++++++-
>> >  3 files changed, 133 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
>> > new file mode 100644
>> > index 0000000000..cb1b0a8217
>> > --- /dev/null
>> > +++ b/hw/cxl/cxl-device-utils.c
>> > @@ -0,0 +1,105 @@
>> > +/*
>> > + * CXL Utility library for devices
>> > + *
>> > + * Copyright(C) 2020 Intel Corporation.
>> > + *
>> > + * This work is licensed under the terms of the GNU GPL, version 2. S=
ee the
>> > + * COPYING file in the top-level directory.
>> > + */
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "qemu/log.h"
>> > +#include "hw/cxl/cxl.h"
>> > +
>> > +/*
>> > + * Device registers have no restrictions per the spec, and so fall ba=
ck to the
>> > + * default memory mapped register rules in 8.2:
>> > + *   Software shall use CXL.io Memory Read and Write to access memory=
 mapped
>> > + *   register defined in this section. Unless otherwise specified, so=
ftware
>> > + *   shall restrict the accesses width based on the following:
>> > + *   =E2=80=A2 A 32 bit register shall be accessed as a 1 Byte, 2 Byt=
es or 4 Bytes
>> > + *     quantity.
>> > + *   =E2=80=A2 A 64 bit register shall be accessed as a 1 Byte, 2 Byt=
es, 4 Bytes or 8
>> > + *     Bytes
>> > + *   =E2=80=A2 The address shall be a multiple of the access width, e=
.g. when
>> > + *     accessing a register as a 4 Byte quantity, the address shall be
>> > + *     multiple of 4.
>> > + *   =E2=80=A2 The accesses shall map to contiguous bytes.If these ru=
les are not
>> > + *     followed, the behavior is undefined
>> > + */
>> > +
>> > +static uint64_t caps_reg_read(void *opaque, hwaddr offset, unsigned s=
ize)
>> > +{
>> > +    CXLDeviceState *cxl_dstate =3D opaque;
>> > +
>> > +    return cxl_dstate->caps_reg_state32[offset / 4];
>> > +}
>> > +
>> > +static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned si=
ze)
>> > +{
>> > +    return 0;
>> > +}
>> > +
>> > +static const MemoryRegionOps dev_ops =3D {
>> > +    .read =3D dev_reg_read,
>> > +    .write =3D NULL, /* status register is read only */
>> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> > +    .valid =3D {
>> > +        .min_access_size =3D 1,
>> > +        .max_access_size =3D 8,
>> > +        .unaligned =3D false,
>> > +    },
>> > +    .impl =3D {
>> > +        .min_access_size =3D 1,
>> > +        .max_access_size =3D 8,
>> > +    },
>> > +};=20=20
>>=20
>> I think for >64 bit registers you need to use the read_with_attrs=20
>
> I don't follow this comment.  Max access to registers is 64 bits.
> A few are documented as 128 bit or indeed larger in the spec, but the
> access is as if they were multiple 64 bit registers accesses.
> It's not permissible to do a single 128bit access for example.

No that was my brain fart - of course 8 bytes =3D 64 bit which is fine for
the current accesses functions (unless you want bus faults).

>
> The F4 errata clarified that - previously it was rather unclear what
> the restrictions on access to the larger registers were.
>
> I've updated a few comments on this to reflect the errata.
>
> Thanks,
>
> Jonathan


--=20
Alex Benn=C3=A9e
