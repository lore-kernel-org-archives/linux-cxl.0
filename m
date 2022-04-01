Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9026C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Apr 2022 21:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352792AbiDAVgm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351493AbiDAVgl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Apr 2022 17:36:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552E763A7
        for <linux-cxl@vger.kernel.org>; Fri,  1 Apr 2022 14:34:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so3721384pjm.0
        for <linux-cxl@vger.kernel.org>; Fri, 01 Apr 2022 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=882z1skVPVrX6JxDUqDucT+CHxsblmX+I1O0oabkTz4=;
        b=wxh4rGzfAQmQHYTuP+p9XhmOy7drMPxKMKk5diG9xXe4n3a44hg0KD7n+4aAs+oU2b
         yzjsWnAnbjqk7bCcG9MVzDXQNcJGGhbCUyUr/4dZ1OGJQAo6zVeivXL6K5/Se4zkO+UJ
         N0zn7G7AkkwDBMEkRtqqRCINNf6QR1CGqavfO6Y/HR7ZYBo0biDDRtoyP85NifE4d8h6
         vngnkdkr4xbi3qH3ND16MzCMawyIbKGzNJaHCd5OO/LshN9Bdapc1EqePHzlxtJiEZ5X
         LnjVFAZI0IMdVjRbbSMH7iy6MtopQyQChDhQiNPzuDQrxkRb+8vwhZwbQBEVY1LlqzeV
         9kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=882z1skVPVrX6JxDUqDucT+CHxsblmX+I1O0oabkTz4=;
        b=bDUAkC+yDoLEVxNzXk2p7WkqOTPGFhOeJDOoqNN7RlJRYY+RV6gbqKHRcUlB5SGCs4
         1DB9DIrivpgLJqOp87ZNfLUo7YOZ+dQp+Z9SiNhvm89zMTtHo9VlMAZk3Z65VB3CtgyC
         viGVlA2oHf5SOJFoF++fIIVVULpvoC0xJ3WhtTT5RyG1Al0+edCt9CzZXXHgBglzGg3s
         XBnRJikVGEpVC4ZXnmeN2g+VaeQPLWmSCpXLwkBD9i0l4vfgOp4x8q1veE4OF3iXD3VR
         0/QkTJ6TNE15t7ArmBV4GpxU5FXmk+it7FgZSN4e/Ol1XFrlOvrMCLXEo7lCGEjRptoB
         M8bQ==
X-Gm-Message-State: AOAM5308iYcQ5uzGDkOivSyEHFtAWIWsDTPtNrMmPdy24A+wD3wRpNKU
        y+8VpoMhYfEuXRzzGczRRhwLuSdP+2dgA+YiObj8fw==
X-Google-Smtp-Source: ABdhPJwfj+RSvxQDoYuS28pfHAKx6Y2BH+koHOBy4kcEcxUYv7LWtMHxoh8KL4bmiIJ4R0y1hSLv9n7EXBnBflKyQ2A=
X-Received: by 2002:a17:90a:ca:b0:1ca:5253:b625 with SMTP id
 v10-20020a17090a00ca00b001ca5253b625mr840636pjd.220.1648848888811; Fri, 01
 Apr 2022 14:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220331202022.1823174-1-vishal.l.verma@intel.com>
 <20220331202022.1823174-4-vishal.l.verma@intel.com> <20220401204014.khgozoeu6biirknu@offworld>
In-Reply-To: <20220401204014.khgozoeu6biirknu@offworld>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Apr 2022 14:34:37 -0700
Message-ID: <CAPcyv4iGtgO6tqLV_UjOsORmC0q-Kw0y5yvstXd=OO8vQ=9XoQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PCI/ACPI: negotiate CXL _OSC
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 1, 2022 at 1:40 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Thu, 31 Mar 2022, Vishal Verma wrote:
>
> >The CXL specification does not define any additional constraints on
> >the hotplug flow beyond PCIe native hotplug, so a kernel that supports
> >native PCIe hotplug, supports CXL hotplug.
>
> Hmm but from a Linux-pov does it make sense to allow hotplug
> support if the MM cannot handle it?

I would say yes, i.e. do not consider CONFIG_MEMORY_HOTPLUG for
OSC_CXL_NATIVE_HP_SUPPORT, but see below and poke holes in my
argument...

>
> @@ -531,7 +518,8 @@ static u32 calculate_cxl_support(void)
>         support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
>         if (pci_aer_available())
>                 support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
> -       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
> +           IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>                 support |= OSC_CXL_NATIVE_HP_SUPPORT;
>
>         return support;
>
> After all, per the CXL 2.0 Type 3 device Hot-Add flow:
>
> ""
> 7. CXL aware software notifies OS memory manager about the new memory and its
> attributes such as latency and bandwidth. Memory manager processes a request
> and adds the new memory to its allocation pool.
> ""

If I look at ACPI hotplug it is true that CONFIG_ACPI_HOTPLUG_MEMORY
depends on CONFIG_MEMORY_HOTPLUG. However, it is also true that there
is no existing _OSC for memory hotplug support. The reason is that
ACPI memory hotplug requires the OS to acknowledge / coordinate with
memory plug events via a scan handler. On the CXL side the equivalent
would be if Linux supported the Mechanical Retention Lock [1], or
otherwise had some coordination for the driver of a PCI device
undergoing hotplug to be consulted on whether the hotplug should
proceed or not.

The concern is that if Linux says no to supporting CXL hotplug then
the BIOS may say no to giving the OS hotplug control of any other PCIe
device. So the question here is not whether hotplug is enabled, it's
whether it is handled natively by the at all OS, and if
CONFIG_HOTPLUG_PCI_PCIE is enabled then the answer is "yes".

Otherwise, the plan for CXL coordinated remove, since the kernel does
not support blocking hotplug, is to require the memory device to be
disabled before hotplug is attempted. When CONFIG_MEMORY_HOTPLUG is
disabled that step will fail and the remove attempt cancelled. by the
user. If that is not honored and the card is removed anyway then it
does not matter if CONFIG_MEMORY_HOTPLUG is enabled or not, it will
cause a crash and other badness.

Long story short, just say yes, to CXL hotplug and require removal to
be coordinated by userspace unless and until the kernel grows better
mechanisms for doing "managed" removal of devices in consultation with
the driver.

[1]: https://lore.kernel.org/all/20201122014203.4706-1-ashok.raj@intel.com/
