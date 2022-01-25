Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A7C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jan 2022 22:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiAYWyi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiAYWy3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jan 2022 17:54:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B107C06161C
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 14:54:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id s5so34091029ejx.2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 14:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gkppOC4VY2xWuXqxRaYvfe6Vvnw7Z11qsylHLooU/Bo=;
        b=ac1y6DrH/JtZyB3SiPmBbvbwAV4v1AR1G4oyGFpDD+UOJsJfi3PGhKL96RzSBKo+A7
         f+9SA1CBgeOQXTFLcE/lemZjIPsvrkuzxHQWnuC/9/fZ+H3EJmOYc+zYtK4n5DFwtwYX
         +qcymtj/KoPXPC6P1ZDKZdmoqrM0zgyqqCddMawLyGnmzYZVFIHOlV9svDmXhPM3qCej
         G8aaYreuf168zZIwo46tNr+rCiCvbSin93K7Ir/i/mCeWyg8F3TiJa0Q9gw/3/j/8iKw
         O7+d33n47LX3eLZqo2JlVDJrK9Pyt0VJANZdOKitAn8t45JzTTyrX7twTPG/7Nj/BXcU
         curw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gkppOC4VY2xWuXqxRaYvfe6Vvnw7Z11qsylHLooU/Bo=;
        b=l+qMq95ncMBzjun2CyaolEPQHfpUm7tFgA00ldhg4XoBaQ5T4VdIJsllOxJD/9b4y8
         Z2jKI5QZLF+oNpgJy726srw2nCEA3dMo1yhsUFqvbEX0Hy0Pr3lupqDSLiUzz0oKuhmW
         eCVPm/gj85jskcHZ8oYd7dJk1iIYX4cdFyugZHrx2nEs5cQBgKhYa2RckG63f/ue/QiR
         nmY/OvKVOt4q9po7cK2wnsAn6N0MPW3A1xwr4egXKYU5Np9vJNuqDoYIlWe3l4dQN8i3
         ASlfwi67P5iM2xASEYQSx6xXMxL8hmMfZxxRzm71SANYw7VwslTtikUEiuUcO9atrW2S
         LFUQ==
X-Gm-Message-State: AOAM533LmGzkcxnN0hAE19ovfCiL4idWQ3CWazvuVMnBrXrdtDfXQuhG
        KPPsX77GsUBSJB1ybgG8G8N+KQ==
X-Google-Smtp-Source: ABdhPJwgf3YpmTqsgDZdqAnbslFXTyWqRikz8rtdK9ZfCVF9FXlrZeDTC/0HogSFW6Dfkn+ah7MF/Q==
X-Received: by 2002:a17:907:2d90:: with SMTP id gt16mr17111390ejc.581.1643151267708;
        Tue, 25 Jan 2022 14:54:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id z5sm6656797eja.20.2022.01.25.14.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:54:26 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 37F7D1FFB7;
        Tue, 25 Jan 2022 22:54:26 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-30-Jonathan.Cameron@huawei.com>
 <87sftbd9y9.fsf@linaro.org> <20220125175130.00005a46@Huawei.com>
User-agent: mu4e 1.7.6; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
Subject: Re: [PATCH v4 29/42] hw/cxl/host: Add support for CXL Fixed Memory
 Windows.
Date:   Tue, 25 Jan 2022 22:53:06 +0000
In-reply-to: <20220125175130.00005a46@Huawei.com>
Message-ID: <87k0enctp9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue, 25 Jan 2022 17:02:32 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>>=20
>> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> >
>> > The concept of these is introduced in [1] in terms of the
>> > description the CEDT ACPI table. The principal is more general.
>> > Unlike once traffic hits the CXL root bridges, the host system
>> > memory address routing is implementation defined and effectively
>> > static once observable by standard / generic system software.
>> > Each CXL Fixed Memory Windows (CFMW) is a region of PA space
>> > which has fixed system dependent routing configured so that
>> > accesses can be routed to the CXL devices below a set of target
>> > root bridges. The accesses may be interleaved across multiple
>> > root bridges.=20=20
>>=20
>> This breaks the linux-user builds...
>> > diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
>> > index 0eca715d10..27dff3868b 100644
>> > --- a/hw/cxl/meson.build
>> > +++ b/hw/cxl/meson.build
>> > @@ -1,5 +1,9 @@
>> > -softmmu_ss.add(when: 'CONFIG_CXL', if_true: files(
>> > -  'cxl-component-utils.c',
>> > -  'cxl-device-utils.c',
>> > -  'cxl-mailbox-utils.c',
>> > +specific_ss.add(when: 'CONFIG_CXL', if_true: files(
>> > +      'cxl-component-utils.c',
>> > +      'cxl-device-utils.c',
>> > +      'cxl-mailbox-utils.c',
>> > +      'cxl-host.c',
>> > +))
>> > +specific_ss.add(when: 'CONFIG_CXL', if_false: files(
>> > +      'cxl-host-stubs.c',
>> >  ))=20=20
>>=20
>> I think you want this:
>>=20
>>   softmmu_ss.add(when: 'CONFIG_CXL',
>>                  if_true: files(
>>                    'cxl-component-utils.c',
>>                    'cxl-device-utils.c',
>>                    'cxl-mailbox-utils.c',
>>                    'cxl-host.c'),
>>                  if_false: files(
>>                    'cxl-host-stubs.c',
>>                  ))
>>=20
>>   # This is required as well:
>>   softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
>
> Ah.  I'd started with the first block and got incomprehensible error
> message.  Second block fixes it.

  https://qemu.readthedocs.io/en/latest/devel/build-system.html#stage-2-mes=
on

documents some of this although we could probably do a better job of
sign posting the bits in the root meson file.

>
> I'll not pretend to understand the 'why' :)
>
> Thanks,
>
> Jonathan
>
>>=20
>>=20


--=20
Alex Benn=C3=A9e
