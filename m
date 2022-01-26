Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E29BC28CF5
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 13:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiAZNij (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbiAZNig (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jan 2022 08:38:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B622C061747
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 05:38:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h21so8299183wrb.8
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 05:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=a3rlzrnMxQWEHzs43vAHpuycpDir02GN8STqlzZ29+M=;
        b=qTHyxnx/iVIhPCuamQp7y/tmw8ApuiZvxTuaJADsJHEU69017Ylkrb7DI3SoSr3K1L
         9HnGrnxXldjB9cfXerAug99XkYkXsHdg+MfTwzH6dhl7WYMsj6X+D+K7qoVPnMah858M
         YDw4m03nUMfRxdPhvRri51p9JCxr3n/G74bz6wdAItczUmSRdzGdAMiHT4Xcyno3q9ok
         Oj87Qc1UYN3JzcKV5JfiA88pxz8sIYxrNLX2DF6GlYMcFN+7JEbQXXM8UBTmVPckKN6j
         WxT2gL5kXRlHwqc05F0bzMb9hXvrVmwjKonwGa2smqbzEp7I46n2SOuQ8vQueVDbz7qF
         NtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=a3rlzrnMxQWEHzs43vAHpuycpDir02GN8STqlzZ29+M=;
        b=bgXDiQcONfBy9Zy0pD0DiteAQ5b2nuEXQufJQbkGrfZaZjmf0JiwgmHh4Mj3WYKcsm
         a+K+vIYfG9ogOpHX1sBnzHxTqEoOPAQ96zYV9+aAlmsEkIIid9CohYB475ZVrpjJAH7y
         Fs32aXHPB2DyAldtCElLiGwymvDtDvK3dZ/gw6kgMd3DHGgoAd/yrg5yjMllL86mFPR0
         uAaNn6ps4CFf0CV36MTI+qKWG7+cLW3zm4ES/nsQ6g4V09U0CvQq4rGyZyUD5K31fyX6
         syFDkhZIoVRwEDpuMxXs5ySKmkCorOXqrGn9VYxfSopV8/gpS88EEbb+ctATv7KgrRJV
         nJCQ==
X-Gm-Message-State: AOAM531feR2Q0+kQUlpkkadokxK8P0XnNw9PUEse8EhHwX6VeYZMBMAu
        CyMpfSwwY8Up/b+OsdTEnxB8Mg==
X-Google-Smtp-Source: ABdhPJwdx8niq8bQBx5f24veJb5BVYFxCQtc7q89Qx07irlTE0maar0brsdm7/M7maCIFEyyZCjlVA==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr22286969wrx.178.1643204314695;
        Wed, 26 Jan 2022 05:38:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id d7sm6381658wri.117.2022.01.26.05.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:38:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id DAC111FFB7;
        Wed, 26 Jan 2022 13:38:32 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-3-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 02/42] hw/cxl/component: Introduce CXL components
 (8.1.x, 8.2.5)
Date:   Wed, 26 Jan 2022 12:32:01 +0000
In-reply-to: <20220124171705.10432-3-Jonathan.Cameron@huawei.com>
Message-ID: <87bkzyd3c7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> A CXL 2.0 component is any entity in the CXL topology. All components
> have a analogous function in PCIe. Except for the CXL host bridge, all
> have a PCIe config space that is accessible via the common PCIe
> mechanisms. CXL components are enumerated via DVSEC fields in the
> extended PCIe header space. CXL components will minimally implement some
> subset of CXL.mem and CXL.cache registers defined in 8.2.5 of the CXL
> 2.0 specification. Two headers and a utility library are introduced to
> support the minimum functionality needed to enumerate components.
>
> The cxl_pci header manages bits associated with PCI, specifically the
> DVSEC and related fields. The cxl_component.h variant has data
> structures and APIs that are useful for drivers implementing any of the
> CXL 2.0 components. The library takes care of making use of the DVSEC
> bits and the CXL.[mem|cache] registers. Per spec, the registers are
> little endian.
>
> None of the mechanisms required to enumerate a CXL capable hostbridge
> are introduced at this point.
>
> Note that the CXL.mem and CXL.cache registers used are always 4B wide.
> It's possible in the future that this constraint will not hold.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/Kconfig                     |   1 +
>  hw/cxl/Kconfig                 |   3 +
>  hw/cxl/cxl-component-utils.c   | 212 +++++++++++++++++++++++++++++++++
>  hw/cxl/meson.build             |   3 +
>  hw/meson.build                 |   1 +
>  include/hw/cxl/cxl.h           |  16 +++
>  include/hw/cxl/cxl_component.h | 196 ++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_pci.h       | 138 +++++++++++++++++++++
>  8 files changed, 570 insertions(+)
>
> diff --git a/hw/Kconfig b/hw/Kconfig
> index ad20cce0a9..50e0952889 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -6,6 +6,7 @@ source audio/Kconfig
>  source block/Kconfig
>  source char/Kconfig
>  source core/Kconfig
> +source cxl/Kconfig
>  source display/Kconfig
>  source dma/Kconfig
>  source gpio/Kconfig
> diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
> new file mode 100644
> index 0000000000..8e67519b16
> --- /dev/null
> +++ b/hw/cxl/Kconfig
> @@ -0,0 +1,3 @@
> +config CXL
> +    bool
> +    default y if PCI_EXPRESS
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> new file mode 100644
> index 0000000000..5007b29ebb
> --- /dev/null
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -0,0 +1,212 @@
> +/*
> + * CXL Utility library for components
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
> +#include "hw/pci/pci.h"
> +#include "hw/cxl/cxl.h"
> +
> +static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
> +                                       unsigned size)
> +{
> +    CXLComponentState *cxl_cstate =3D opaque;
> +    ComponentRegisters *cregs =3D &cxl_cstate->crb;
> +
> +    assert(size =3D=3D 4);

You assert here but bellow:

> +
> +/*
> + * 8.2.3
> + *   The access restrictions specified in Section 8.2.2 also apply to CX=
L 2.0
> + *   Component Registers.
> + *
> + * 8.2.2
> + *   =E2=80=A2 A 32 bit register shall be accessed as a 4 Bytes quantity=
. Partial
> + *   reads are not permitted.
> + *   =E2=80=A2 A 64 bit register shall be accessed as a 8 Bytes quantity=
. Partial
> + *   reads are not permitted.
> + *
> + * As of the spec defined today, only 4 byte registers exist.
> + */
> +static const MemoryRegionOps cache_mem_ops =3D {
> +    .read =3D cxl_cache_mem_read_reg,
> +    .write =3D cxl_cache_mem_write_reg,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 8,
> +        .unaligned =3D false,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};

You have constrained the access to 4 so you will only see 4 bytes
accesses. If it is valid for the guest to access 64bit words then it
would be better to no-op that case and maybe LOG_UNIMP the fact.

Otherwise the rest looks ok to me:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
