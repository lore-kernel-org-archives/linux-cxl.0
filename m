Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4995CC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 20 May 2022 17:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiETRfU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 May 2022 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiETRfU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 May 2022 13:35:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F5187DAB
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 10:35:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so7914430plk.8
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITJIWCytwVe1ES2GmpHpzZyTmpiHEe1tf/s+lxlySWQ=;
        b=r7655LU3IwTkh+Yrrs737LqxhPROP7W9KFeYT30S3DOI4S/QoTSvu2I5gASaFcTvpI
         mu0nFXSpQuipwl4bADcDpaQZZThnt2xEm3MjqzD256zC/GhPU3eI5fZMuzRSu+tobP1v
         EUw8gYk/cySV2VhTZWg7B+vKZbIVR3nahejGUV6SDiEMyTRJoMfcD7cXFjHTuR9S/JOS
         GuLVM0MMCVS1kLoyRytgEK7Wz5DjWiIe5OnVgnE5kYH62t+7J/WvERwtamJoGZON2lVj
         EArriq7WA6nwduSo52yH3yUgRhzrnS59cllLKF7cawnY8HeXnc9h65lZwI2VZAfUeqQ5
         g7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITJIWCytwVe1ES2GmpHpzZyTmpiHEe1tf/s+lxlySWQ=;
        b=kGR/KDSMYPTylZ16bkv0mbGfSo/REYRVOVVwyx2GJiRCad/jdo/wBjY/rZfP9n2+8T
         mvZtEH4DnKncdVkXGG9TBbwJL+hZRlpoqLNYtMr4Y7pW5SnH4AEDEqg32w0SrQ0g+utH
         w62oKWxfLrEYEJHCAbNwW7Fjk6kNtrznNmC/IofvNJvQnA7M/IdNUQEn8SkZVg8j93Hy
         4XBprnaV4Jx9Dp794xq6/k+5hMdGbrFhjqiViOJ/PeCs/DC8s0M7nQC50APvy4gWO0bZ
         bRN9onxM/qadN0Rpe/m346Cgdp6drkbPjSMSHceGAkEj+3G0A0+NuenhGFzOFpb1US08
         SwXg==
X-Gm-Message-State: AOAM532hIykFxgTqkpxEiyZN0mHJXkK+OBgqP5GCpJvU9V1EFayMWnXa
        ZCc7vlyYUGwUM0uXYeRpEuimYuYQYE+8YEF27sL+Tw==
X-Google-Smtp-Source: ABdhPJxEMdPpmm3jAn+PKRSfqYzcYOh+B81VADkHeVJDTfz/IKR6s6xx3ohkOP+3rzx+WPruw2uHmWXBFueoIottqMo=
X-Received: by 2002:a17:902:da8b:b0:15e:c0e8:d846 with SMTP id
 j11-20020a170902da8b00b0015ec0e8d846mr10888193plx.34.1653068118993; Fri, 20
 May 2022 10:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <165291692286.1426646.10683669594268317024.stgit@dwillia2-xfh>
 <165299979159.2207134.5045405239146790589.stgit@dwillia2-xfh> <20220520160956.00000602@huawei.com>
In-Reply-To: <20220520160956.00000602@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 May 2022 10:35:08 -0700
Message-ID: <CAPcyv4gFX7azG6x=eyd_-QSzneApKbaTGfK0DQg3siet_jwKtw@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] cxl/port: Enable HDM Capability after validating
 DVSEC Ranges
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ariel Sibley <ariel.sibley@microchip.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, May 20, 2022 at 8:10 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 19 May 2022 15:38:56 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > CXL memory expanders that support the CXL 2.0 memory device class code
> > include an "HDM Decoder Capability" mechanism to supplant the "CXL DVSEC
> > Range" mechanism originally defined in CXL 1.1. Both mechanisms depend
> > on a "mem_enable" bit being set in configuration space before either
> > mechanism activates. When the HDM Decoder Capability is enabled the CXL
> > DVSEC Range settings are ignored.
> >
> > Previously, the cxl_mem driver was relying on platform-firmware to set
> > "mem_enable". That is an invalid assumption as there is no requirement
> > that platform-firmware sets the bit before the driver sees a device,
> > especially in hot-plug scenarios. Additionally, ACPI-platforms that
> > support CXL 2.0 devices also support the ACPI CEDT (CXL Early Discovery
> > Table). That table outlines the platform permissible address ranges for
> > CXL operation. So, there is a need for the driver to set "mem_enable",
> > and there is information available to determine the validity of the CXL
> > DVSEC Ranges.
> >
> > Arrange for the driver to optionally enable the HDM Decoder Capability
> > if "mem_enable" was not set by platform firmware, or the CXL DVSEC Range
> > configuration was invalid. Be careful to only disable memory decode if
> > the kernel was the one to enable it. In other words, if CXL is backing
> > all of kernel memory at boot the device needs to maintain "mem_enable"
> > and "HDM Decoder enable" all the way up to handoff back to platform
> > firmware (e.g. ACPI S5 state entry may require CXL memory to stay
> > active).
> >
> > Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > [dan: fix early terminiation of range-allowed loop]
> > Cc: Ariel Sibley <ariel.sibley@microchip.com>
> > [ariel: Memory_size must be non-zero]
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Link: https://lore.kernel.org/r/165291692286.1426646.10683669594268317024.stgit@dwillia2-xfh
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hi Dan,
>
> ...
>
> >
> > +     /*
> > +      * The current DVSEC values are moot if the memory capability is
> > +      * disabled, and they will remain moot after the HDM Decoder
> > +      * capability is enabled.
> > +      */
> >       info.mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
> >       if (!info.mem_enabled)
> > -             return 0;
> > +             return __cxl_hdm_decode_init(cxlds, cxlhdm, &info);
>
>  __cxl_hdm_decode_init() returns bool whereas
> cxl_hdm_decode_init() return 0 on success negative on error.
>
> Leads to odd situation of getting a probe failed with a return value
> of 1.

Ugh, yes, thanks. You seem to have identified that I only tested this
on setups that enable mem_enable by default. Fix inbound.
