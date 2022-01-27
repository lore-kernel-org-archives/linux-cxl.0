Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB695C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 14:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiA0OTc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiA0OTc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 09:19:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E2BC061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:19:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ka4so6075138ejc.11
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=laSX09zjoWy+fX5bh0LTSIhaA63oEaJIJhnoahkS044=;
        b=zweCcL7eIHPSmak/7XJLFo0yKVIJ/6jtD2up6kUPSY3pqCLJlhYmYpoaiVSEZd02GP
         adKSGRZlU7I56f03DPA+0gHfq/0gQBWrMt/9orITcMuYJlqLi/RNxt7NgY2KxEn2Mv5N
         C0W1Uxk5mZllLe9czbVGxJqcOsclyCZmTkJnKiterGu0De7v9X/r6UGAVBWwtxRXoIj+
         fidsZdRO84oFAaHbK0o06o18i1zEexAB0yU3mb9a9QaESx5qUW0uHGdY0y2g776xxIDx
         27MJO8e4VExlOTaVVQ+LFhRiHOXuIM4FjX7Urq88/4UzI7vXybFQviWkD86KgEhoiqyQ
         kzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=laSX09zjoWy+fX5bh0LTSIhaA63oEaJIJhnoahkS044=;
        b=rsPYGDsIChZAICEUzD3mXjEkAeXZZ58YbuJ3txLA+7htgRl8rc+EfWOI2v+zcuyEMs
         sYVMGdOTbbf9y/HA4BUx0SlYy3lxwz4mWqxN9tm2ymhQV8pSc7/YfhJP8imnGtjOWt1G
         u1f8Pbk1BpdzE6+j9NvlXWrpIxDLcODLysRWElSxAmaE0DjU7MtH+NiHCG69L2/x4nxs
         P1aRqasPexZQDSNYXb7E6zF+zAWUX1iTqWL/N633XrmL8vymr+00udBRrDWk5lcg2XQ8
         D+a4F9GupISy6WXTRj/T9xLa6GeBAEDO/3AawgiWHhq5t1OBgXSc06MjFmv/TV17R482
         6SfQ==
X-Gm-Message-State: AOAM533qRt3wX3IYrZkzpiTZ9+L5vEwtKDGlCkQ2kKqiPfMXW0dxDpoP
        myY97oXbAr794Ys8Miciqc2rlg==
X-Google-Smtp-Source: ABdhPJwCyZeGV1ho0a3IO39Dy6YHdA6P8rmNrMRrvlEyjt6W1BOwXubJYEfRWWheRNKak/vn4BSh4A==
X-Received: by 2002:a17:907:86a0:: with SMTP id qa32mr3137536ejc.336.1643293170193;
        Thu, 27 Jan 2022 06:19:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id lf16sm8649264ejc.25.2022.01.27.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 06:19:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 1F6DC1FFB7;
        Thu, 27 Jan 2022 14:19:28 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-18-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 17/42] cxl: Machine level control on whether CXL
 support is enabled
Date:   Thu, 27 Jan 2022 14:18:02 +0000
In-reply-to: <20220124171705.10432-18-Jonathan.Cameron@huawei.com>
Message-ID: <87wnil8dn3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> There are going to be some potential overheads to CXL enablement,
> for example the host bridge region reserved in memory maps.
> Add a machine level control so that CXL is disabled by default.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  hw/arm/virt.c        |  1 +
>  hw/core/machine.c    | 26 ++++++++++++++++++++++++++
>  hw/i386/microvm.c    |  1 +
>  hw/i386/pc.c         |  1 +
>  hw/ppc/spapr.c       |  1 +
>  include/hw/boards.h  |  2 ++
>  include/hw/cxl/cxl.h |  4 ++++
>  7 files changed, 36 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 2b6cc7aa9e..cbb18dcba6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2856,6 +2856,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
>      hc->unplug =3D virt_machine_device_unplug_cb;
>      mc->nvdimm_supported =3D true;
>      mc->smp_props.clusters_supported =3D true;
> +    mc->cxl_supported =3D false;

You should be able to do this in machine_class_init and then...

<snip>

just turn it on for pc

> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c8696ac01e..b6800a511a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1739,6 +1739,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
>      mc->nvdimm_supported =3D true;
>      mc->smp_props.dies_supported =3D true;
> +    mc->cxl_supported =3D true;
>      mc->default_ram_id =3D "pc.ram";
>=20=20
<snip>

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
