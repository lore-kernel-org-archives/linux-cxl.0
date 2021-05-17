Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33484C433B4
	for <linux-cxl@archiver.kernel.org>; Mon, 17 May 2021 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1375961242
	for <linux-cxl@archiver.kernel.org>; Mon, 17 May 2021 11:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhEQL4p (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 May 2021 07:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236841AbhEQL4o (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 17 May 2021 07:56:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45CA5611BE
        for <linux-cxl@vger.kernel.org>; Mon, 17 May 2021 11:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621252528;
        bh=uIoQoIgPnpAwdPDApbGeTveFi8jF/skYt5vPnOGpM/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tjdOBslW7m8IZOJG/c6ATIPjBydocPnnBRQwqej32qwFQRnw+wYA+5eVSJCaP9kNr
         AzHlknjGEUChYb+Onb9pMzOgLZdpg7Npp400nM4V8Ea/B44EZPgG9RUBwm40LDIE1P
         Ppvb9tSpCOll4mXpy9KNoA0xSHc+0803vogYqK1HVD9k2YKD06vVqpD/hBnLRfoaRG
         AmoGFbdMXaBCTOc24Fb3FQbqRCnoPY/t+u/wCAZIIHlbLtPj4u271z71iWGSaKow0Y
         ZpczU+MeJR7M2uTimqS8FnOC8QLwQoAr4XMJjOci/VGPh4W4i1Hm7/mgk0uA8jvMyN
         5aUfgDvWEiBOw==
Received: by mail-ot1-f52.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so5258502otc.12
        for <linux-cxl@vger.kernel.org>; Mon, 17 May 2021 04:55:28 -0700 (PDT)
X-Gm-Message-State: AOAM530Y4XBmgcSe2UjGHaigKxGwhU/ClPR0zf6hh4zwjBC6/+5fxrIV
        i2ZZmKpKpW3oG5x3T8tCp4IKUiFelRNT/jQKzIs=
X-Google-Smtp-Source: ABdhPJwL3QPnx0++puyjBYesLxk+46tfJHomPRp2+/17gwe0d+w13QFRrA8PFF1c1s0kEE0lllaEFpDdiATybz2jN6Q=
X-Received: by 2002:a9d:69c5:: with SMTP id v5mr49097151oto.108.1621252527604;
 Mon, 17 May 2021 04:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210517103319.5356-1-james.morse@arm.com> <20210517122701.00005e19@Huawei.com>
In-Reply-To: <20210517122701.00005e19@Huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 May 2021 13:55:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHvQ1v7W8jdTaEmp9q-Vj+S9dz0P-Q4YZd5iNnqaBSf+A@mail.gmail.com>
Message-ID: <CAMj1kXHvQ1v7W8jdTaEmp9q-Vj+S9dz0P-Q4YZd5iNnqaBSf+A@mail.gmail.com>
Subject: Re: [RFC PATCH] Documentation/arm64: describe the kernel's
 expectations of 'memory'
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 17 May 2021 at 13:30, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 17 May 2021 11:33:19 +0100
> James Morse <james.morse@arm.com> wrote:
>
> > Standards such as CXL allow memory on PCIe devices to be made
> > available to the operating system for use as regular memory.
> >
> > Document linux's expectations around the behaviour of memory as the
> > implementations of these new standards may need special treatment in
> > the OS, firmware or bootloader.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
>
> Hi James,
>
> +CC linux-cxl to pick up a few more interesting people who might loose
> this in the wash of linux-arm-kernel
>
> Good to see this description as there has been some confusion on this
> point. This basically looks like what I'd expect to see. Just a few
> comments around firmware description towards the end.
>
> > ---
> >  Documentation/arm64/memory.rst | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
> > index 901cd094f4ec..951802aee55f 100644
> > --- a/Documentation/arm64/memory.rst
> > +++ b/Documentation/arm64/memory.rst
> > @@ -167,3 +167,34 @@ from a 52-bit space by enabling the following kernel config options:
> >
> >  Note that this option is only intended for debugging applications
> >  and should not be used in production.
> > +
> > +On device memory used as regular memory
> > +---------------------------------------
> > +Standards such as CXL allow memory on PCIe device to be made
> > +available to the operating system for use as regular memory.
> > +
> > +If memory is added to the UEFI memory map or DT, or discovered via ACPI's SRAT,
> > +linux expects it to function in the same way as the bulk DRAM. This section
>
> Linux
>
> > +terms this 'regular memory'.
> > +
> > +The kernel may use any attributes to map this memory, e.g. Device-nGnRnE or
> > +Normal Writeback-Cacheable. The kernel may not be in control of the attributes
> > +used, e.g. if the memory is used by a KVM guest.
> > +The kernel will perform cache maintenance to resolve mismatched attributes,
> > +e.g. invalidating clean stale lines after writing new data when the MMU is
> > +disabled.
> > +
> > +The memory may be used by any instruction supported by the CPUs.
> > +e.g. Even when the v8.1 LSE atomic instructions are supported, the v8.0
> > +exclusives are still used for the futex code, and conditional waits, and still
> > +used by existing user-space binaries. When the CPUs support features such as
> > +MTE, all regular memory must support MTE tags.
> > +
> > +On device memory that does not function in the same way as regular memory must
> > +not be added to the UEFI memory map or DT, or be discovered via ACPI's SRAT.
> > +
> > +On arm64, the kernel does not rewrite the UEFI memory map when memory is added
> > +or removed. On device memory that is present at boot, but must be removed later
>
> Might be worth giving an example of why memory 'must be removed'?  I'm not sure
> what you are getting at there.  Specific purpose memory?
>
> > +should be discovered via ACPI's SRAT to ensure it is not used for non-movable
> > +structures.
>
> Not sure I follow this part.  It could be of type EFI_MEMORY_SP.

EFI_MEMORY_SP is an attribute, not a type.

> It should be in SRAT as well, but the EFI type should be sufficient to avoid
> problems.
> "The SPM attribute serves as a hint to the OS to avoid allocating this memory
>  for core OS data or code that can not be relocated."
>
> Now I'm not sure the kernel is handling EFI_MEMORY_SP fully yet...  If
> we need to exclude this approach for now, then this text should perhaps
> call it out explicitly.
>

The problem with EFI_MEMORY_SP is that it is not a type, but an
attribute,  which gives a hint to the OS about the nature of the
memory, which the OS is free to ignore.

The UEFI memory map is not only consumed by the OS, but by any driver
or OS loader that executes in the EFI boot environment, e.g., GPU
drivers or shim/grub bootloaders. If these are not enlightened and
understand what EFI_MEMORY_SP means, they may (and are entitled to)
treat this EFI_MEMORY_SP as if it were regular memory. If GRUB loads
the kernel into EFI_MEMORY_SP memory, it had better behave like
regular memory or things will fall apart.

This means that EFI_MEMORY_SP is really only suitable to describe
aspects of the memory range that can be happily ignored. MTE or
atomics capability must be described in a different way.



> > +e.g. the kernel text, page tables or the GIC ITS Pending Table.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
