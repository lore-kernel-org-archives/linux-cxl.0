Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8BAC4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 21:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F53360F46
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 21:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhHKVEK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhHKVEJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Aug 2021 17:04:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD99C061765
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 14:03:45 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso11687380pjb.2
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ybc4jUcAV5clqts0B9J8UJRkV53JdF5Vkv/DPk2GVPg=;
        b=KjO+t4jzJCyCVdvnhiqxTwsgLK2/dSY3XA9WkGuPOzGhmA7iJZXw3/y1fzcu2K/EDJ
         66QqD9EiYLLjX3In4xLpCriiw9VkSkYeLYIywwWvDekGtpsw077fdz0noj6nEB2EsELv
         VKLAlby6LzEN4eAMjW/Av1qsHCFv/dRtN3KB6g+/+a/9EroqYTc+Xw8DBZPW6Wnhqr1+
         +z4nnZKQo+xU1ujX9PRACdC6m0ZX2xuM1iaV/52p7M1luvZevrSVCFglu2/buOVHfQEX
         UtYIjjiV+E3x93KWOtfprLMT4jkx7fCbZkRbzyynH4mSMs2ooisg5xIDnwOH8PCN54iP
         WWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ybc4jUcAV5clqts0B9J8UJRkV53JdF5Vkv/DPk2GVPg=;
        b=Y+/ihJdWbLSCBEX95JhY3R+JjxSn6MdR05+2390jX1txIUJCGousGb6BlWfx/NbSrg
         h7gJHpYp1vM6HmTX3zB0Cevh7zKVKxFSV0caJZ62gqPt2BySSrPsIXBKECD5pH/vujGk
         zb4dvML9olmS0nclC/RZxvfYaq0+wemZw/Ov66f5XwJgufehXCC1fJgZIXEvGBtpmOv0
         cJ0ebtdVStjbJLYYTko4bAj5M+bdOaywfm0YF6dvjILxqJghfWBXMhEvS3DJhMqWFrFc
         TNT8ST8JMtYgjytLTZxX3IPcHm1CEvQvDZCWAY/6v+tfzWJswqWKLKjX/QK2S20TwAKJ
         3YrQ==
X-Gm-Message-State: AOAM5318zjQaus4SBTVp8QNNSY2Zpvbh44AqP2dochoRFBl4+Z9EECgc
        Z3QYpU5ANetADzLI4W1/7z2t24MitEFii90Vw9as2w==
X-Google-Smtp-Source: ABdhPJz8o0UM3Bkp4XYJBCnY2fyMn4syGZJgnj9nGVg3mUCzpi0aChK3fv6+ux85gDWGvAQh/PEd657vfPXhc+WLdI8=
X-Received: by 2002:a17:902:ab91:b029:12b:8dae:b1ff with SMTP id
 f17-20020a170902ab91b029012b8daeb1ffmr666502plr.52.1628715825514; Wed, 11 Aug
 2021 14:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162854817382.1980150.11827836438841211401.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210810215734.qb4ik65uangytvbm@intel.com> <CAPcyv4hc_=7s4dwrfw89B0cdAQAALZ5Yhiuo6xehB6TJQjekog@mail.gmail.com>
 <xp0k4.l2r85dw1p7do@intel.com>
In-Reply-To: <xp0k4.l2r85dw1p7do@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Aug 2021 14:03:34 -0700
Message-ID: <CAPcyv4jo6s9qz260K6oSpsZbKCdDvqcYxkxk=4PHLVVjzBSm2w@mail.gmail.com>
Subject: Re: [PATCH 20/23] tools/testing/cxl: Introduce a mocked-up CXL port hierarchy
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Alison <alison.schofield@intel.com>, Ira <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 11, 2021 at 1:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote=
:
>
> On Tue, 10 Aug 2021 15:40, Dan Williams <dan.j.williams@intel.com> wrote:
>
> [snip]
>
> >
> >The rationale is to be able to run cxl_test on a system that might
> >also have real CXL. For example I run this alongside the current QEMU
> >CXL model, and that results in the cxl_acpi driver attaching to 2
> >devices:
> >
> ># tree /sys/bus/platform/drivers/cxl_acpi
> >/sys/bus/platform/drivers/cxl_acpi
> >=E2=94=9C=E2=94=80=E2=94=80 ACPI0017:00 -> ../../../../devices/platform/=
ACPI0017:00
> >=E2=94=9C=E2=94=80=E2=94=80 bind
> >=E2=94=9C=E2=94=80=E2=94=80 cxl_acpi.0 -> ../../../../devices/platform/c=
xl_acpi.0
> >=E2=94=9C=E2=94=80=E2=94=80 module -> ../../../../module/cxl_acpi
> >=E2=94=9C=E2=94=80=E2=94=80 uevent
> >=E2=94=94=E2=94=80=E2=94=80 unbind
> >
> >When the device is ACPI0017 this code is walking the ACPI bus looking
> >for  ACPI0016 devices. A real ACPI0016 will fall through
> >is_mock_port() to the original to_cxl_host_bridge() logic that just
> >reads the ACPI device HID. In the mock case the cxl_acpi driver has
> >instead been tricked into walk the platform bus which has real
> >platform devices, and the fake cxl_test ones:
> >
> >/sys/bus/platform/devices/
> >=E2=94=9C=E2=94=80=E2=94=80 ACPI0012:00 -> ../../../devices/platform/ACP=
I0012:00
> >=E2=94=9C=E2=94=80=E2=94=80 ACPI0017:00 -> ../../../devices/platform/ACP=
I0017:00
> >=E2=94=9C=E2=94=80=E2=94=80 alarmtimer.0.auto -> ../../../devices/pnp0/0=
0:04/rtc/rtc0/alarmtimer.0.auto
> >=E2=94=9C=E2=94=80=E2=94=80 cxl_acpi.0 -> ../../../devices/platform/cxl_=
acpi.0
> >=E2=94=9C=E2=94=80=E2=94=80 cxl_host_bridge.0 -> ../../../devices/platfo=
rm/cxl_host_bridge.0
> >=E2=94=9C=E2=94=80=E2=94=80 cxl_host_bridge.1 -> ../../../devices/platfo=
rm/cxl_host_bridge.1
> >=E2=94=9C=E2=94=80=E2=94=80 cxl_host_bridge.2 -> ../../../devices/platfo=
rm/cxl_host_bridge.2
> >=E2=94=9C=E2=94=80=E2=94=80 cxl_host_bridge.3 -> ../../../devices/platfo=
rm/cxl_host_bridge.3
> >=E2=94=9C=E2=94=80=E2=94=80 e820_pmem -> ../../../devices/platform/e820_=
pmem
> >=E2=94=9C=E2=94=80=E2=94=80 efi-framebuffer.0 -> ../../../devices/platfo=
rm/efi-framebuffer.0
> >=E2=94=9C=E2=94=80=E2=94=80 efivars.0 -> ../../../devices/platform/efiva=
rs.0
> >=E2=94=9C=E2=94=80=E2=94=80 Fixed MDIO bus.0 -> ../../../devices/platfor=
m/Fixed MDIO bus.0
> >=E2=94=9C=E2=94=80=E2=94=80 i8042 -> ../../../devices/platform/i8042
> >=E2=94=9C=E2=94=80=E2=94=80 iTCO_wdt.1.auto -> ../../../devices/pci0000:=
00/0000:00:1f.0/iTCO_wdt.1.auto
> >=E2=94=9C=E2=94=80=E2=94=80 kgdboc -> ../../../devices/platform/kgdboc
> >=E2=94=9C=E2=94=80=E2=94=80 pcspkr -> ../../../devices/platform/pcspkr
> >=E2=94=9C=E2=94=80=E2=94=80 PNP0103:00 -> ../../../devices/platform/PNP0=
103:00
> >=E2=94=9C=E2=94=80=E2=94=80 QEMU0002:00 -> ../../../devices/pci0000:00/Q=
EMU0002:00
> >=E2=94=9C=E2=94=80=E2=94=80 rtc-efi.0 -> ../../../devices/platform/rtc-e=
fi.0
> >=E2=94=94=E2=94=80=E2=94=80 serial8250 -> ../../../devices/platform/seri=
al8250
> >
> >...where is_mock_port() filters out those real platform devices. Note
> >that ACPI devices are atypical in that they get registered on the ACPI
> >bus and some get a companion device with the same name registered on
> >the platform bus.
>
> More relevant to endpoints, but here too... Will we be able to have an
> interleave region comprised of a QEMU emulated device and a mock device? =
I think
> folks that are using QEMU for the hardware development purposes would rea=
lly
> like that functionality.

I guess never say "never", but my intent was that the 2 bus-types were
distinct and the streams never crossed.
