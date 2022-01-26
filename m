Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86625C28CF5
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 12:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiAZMaZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 07:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241319AbiAZMaX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jan 2022 07:30:23 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE0FC06161C
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 04:30:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id s5so38603199ejx.2
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 04:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7vGCzUobSetru7RGXX/4Zwru6QRMwWkcRcEYx4djq7Q=;
        b=XjOKkR5bFQff5CnWxnKwLQU/ryEUXW7gwipCw7oxYXnwdtHDAOZqVRAc+r13lRZ02R
         nXxnB82Jz7XzS97MGkCtaufLCeaKc+bp/ViHI2rso0JZCrLMxeDH42ofPIOsBJtiaAio
         ao8P0l4TL4MNd6vRlOXlw+irnNuTD2s57SzCmD0ComcW/kCic2QtggF4qlB/KydS/w5q
         NrlVM7/ZPq+Ad9/gZ/zd7c6Jax4dYWT95kgeB1CGS11M4Ki3O4NcF89y5u/0TnFDjTQn
         9Eib8JljdNcekLE6mWEFCvXM/LClZyl1Mw3k8JNX0GfLkBkJmOc4EkCdQbIILhVXtiNt
         p1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7vGCzUobSetru7RGXX/4Zwru6QRMwWkcRcEYx4djq7Q=;
        b=J2DL6/bEt+PkHGNAG18uKW+Ik1osZhdDKvaihcf9zawb9t/l8v0HoJ2FL5JW+BWKij
         urShFJa5J43nJ+YOaY3rWgmNBNBJIA9Gw8C5cKy8j74RTqoVP3tjlPtjR/5QFxuaVkIq
         C02aF43CsSv9R3fMg7Pvj21tNRPoDJDbNWNQs/QT2MU1ez2zDbHZj74W+aLcA62jm9tg
         CClaxO9Es85z3HFZRlzSJavuMjlhS/t/ZG63gygD0rdxCSaO+VL3dhT3+ePjT5xTyVFY
         moFr7MHstB17xx8bMIMZG7DS7LiPvd9B2v2zQv8HeXO4ZdV0se+GuocbycTo9JC902Lg
         cE8g==
X-Gm-Message-State: AOAM533Tbsm+NlTo9tJZdq2TRhaqosodx1EuKVdtvCXdEaUXBP3nkfYN
        jH/aV8oJ+3dCj+5UUiNld5k2cw==
X-Google-Smtp-Source: ABdhPJwjmPoBp6/sIRkU8gkVpcXeK0RDtYnX9fLvwkViDPEMua8MaU7sxGcEqJC/uAphRfG1/kALTw==
X-Received: by 2002:a17:907:a41f:: with SMTP id sg31mr11483690ejc.472.1643200221864;
        Wed, 26 Jan 2022 04:30:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id k4sm9270052edo.55.2022.01.26.04.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 04:30:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id EC3B71FFB7;
        Wed, 26 Jan 2022 12:30:19 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-32-Jonathan.Cameron@huawei.com>
 <87o83zd99r.fsf@linaro.org> <20220125181313.0000209c@huawei.com>
User-agent: mu4e 1.7.6; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paolo Bonzini <bonzini@gnu.org>
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
Subject: Re: [PATCH v4 31/42] hw/pci-host/gpex-acpi: Add support for dsdt
 construction for pxb-cxl
Date:   Wed, 26 Jan 2022 12:24:02 +0000
In-reply-to: <20220125181313.0000209c@huawei.com>
Message-ID: <87fspad6hw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Tue, 25 Jan 2022 17:15:58 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>>=20
>> > This adds code to instantiate the slightly extended ACPI root port
>> > description in DSDT as per the CXL 2.0 specification.
>> >
>> > Basically a cut and paste job from the i386/pc code.=20=20
>>=20
>> This fails to build on all machines:
>>=20
>>   FAILED: qemu-system-mips64el=20
>>   c++ -m64 -mcx16 -o qemu-system-mips64el
<snip>
>> /usr/lib/x86_64-linux-gnu/libssh.so -lstdc++ -Wl,--end-group
>>   /usr/bin/ld: /lib/x86_64-linux-gnu/libtirpc.so.3: warning: common of `=
rpc_createerr@@GLIBC_2.2.5' overridden by definition from /lib/x86_64-linux=
-gnu/libc.so.6
>>   /usr/bin/ld: libcommon.fa.p/hw_pci-host_gpex-acpi.c.o: in function `ac=
pi_dsdt_add_gpex':
>>   /home/alex/lsrc/qemu.git/builds/all/../../hw/pci-host/gpex-acpi.c:191:=
 undefined reference to `build_cxl_osc_method'
>>   collect2: error: ld returned 1 exit status
>>   [1600/2203] Linking target qemu-system-or1k
<snip>
>> > @@ -175,7 +187,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXCo=
nfig *cfg)
>> >                              cfg->pio.base, 0, 0, 0);
>> >              aml_append(dev, aml_name_decl("_CRS", crs));
>> >=20=20
>> > -            acpi_dsdt_add_pci_osc(dev);
>> > +            if (is_cxl) {
>> > +                build_cxl_osc_method(dev);=20=20
>>=20
>> Either we need an #ifdef gate on CONFIG_ACPI_CXL
>
>  error: attempt to use poisoned "CONFIG_ACPI_CXL"

Hmm I'm not sure why that happened. We generally poison symbols to stop
making configuration changes objects that are shared between binaries. I
guess softmmu_ss must be shared then. Paolo?

>
>> or possibly a stub
>> implementation (with a g_assert_not_reached()).
> That works.
>
> Turns out I was too lazy thinking riscv was enough to exercise the
> not CXL support case.
>
> Lesson learned - mips64el now in my standard config :)
> I'd not realized there were ACPI supporting MIPS machines...

It's worth making sure your gitlab account is setup to run the CI loop
because it's the first thing I do when I review a series ;-)

  https://gitlab.com/stsquad/qemu/-/pipelines/456700583

--=20
Alex Benn=C3=A9e
