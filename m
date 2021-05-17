Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0651C433ED
	for <linux-cxl@archiver.kernel.org>; Mon, 17 May 2021 12:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B1761285
	for <linux-cxl@archiver.kernel.org>; Mon, 17 May 2021 12:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhEQM0n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 May 2021 08:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235090AbhEQM0n (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 17 May 2021 08:26:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62B8261285
        for <linux-cxl@vger.kernel.org>; Mon, 17 May 2021 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621254327;
        bh=/Ard4IvklJPUPEjB/JOkbH9pE0HoHywpcisFNjrs8ls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LsdVhZF8DOISX2pspNrmwgVzhpldHroca+ZoobznmGMLzshJs8pbn91A903EEN1et
         VuIa8pJrXt8Ygm0CTDjAlxHn13c4ed1akb2XUGYG9366Q54HnujbS+yFmwKG7wnaRv
         NEz3Be/GjV+cyzmbxqGvdP25CZY1vChrrIqCBiE0g3GZISWOdVhXZzNFOhcPQ8W5On
         tcM0e2Ok20RrfMW7PzwL5/z4cHn8Wp5ZEzRZYRW9ZU2jDDk5LbMmsM66VdNEByfSK1
         4GvGb8XyvFGs+9/UJqeu6JhgPdf4ZzzWJte2ei0Bk+UbXAPHEAaMNFi8K7WNNCMFZN
         X2C058FOvfYwg==
Received: by mail-oi1-f178.google.com with SMTP id b25so6349534oic.0
        for <linux-cxl@vger.kernel.org>; Mon, 17 May 2021 05:25:27 -0700 (PDT)
X-Gm-Message-State: AOAM53172rBhTLV5S5WKcReR2d0izyHpDgCCQioW+3viWBBquJYFLlsU
        OmVIijFqZ6Hn3/7en/KxztqXU3zJi8B5y0I0/dE=
X-Google-Smtp-Source: ABdhPJx+jVswJaN0I0yQ1X4d7J1S+E+jKFQkzvgSxQ1XRHAH3h0oQsC1D/UnVniM1O56TXZMdd9nR76Rqd/X5Hc40Zk=
X-Received: by 2002:aca:4343:: with SMTP id q64mr1322965oia.33.1621254326722;
 Mon, 17 May 2021 05:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210517103319.5356-1-james.morse@arm.com> <20210517122701.00005e19@Huawei.com>
 <CAMj1kXHvQ1v7W8jdTaEmp9q-Vj+S9dz0P-Q4YZd5iNnqaBSf+A@mail.gmail.com> <20210517131725.00002068@Huawei.com>
In-Reply-To: <20210517131725.00002068@Huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 May 2021 14:25:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHg9bOWuKmiPLgAz44ezDrVoZrWBBepgqG3M8uB+kco7A@mail.gmail.com>
Message-ID: <CAMj1kXHg9bOWuKmiPLgAz44ezDrVoZrWBBepgqG3M8uB+kco7A@mail.gmail.com>
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

On Mon, 17 May 2021 at 14:19, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 17 May 2021 13:55:16 +0200
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Mon, 17 May 2021 at 13:30, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Mon, 17 May 2021 11:33:19 +0100
> > > James Morse <james.morse@arm.com> wrote:
> > >
> > > > Standards such as CXL allow memory on PCIe devices to be made
> > > > available to the operating system for use as regular memory.
> > > >
> > > > Document linux's expectations around the behaviour of memory as the
> > > > implementations of these new standards may need special treatment in
> > > > the OS, firmware or bootloader.
> > > >
> > > > Signed-off-by: James Morse <james.morse@arm.com>
> > >
> > > Hi James,
> > >
> > > +CC linux-cxl to pick up a few more interesting people who might loose
> > > this in the wash of linux-arm-kernel
> > >
> > > Good to see this description as there has been some confusion on this
> > > point. This basically looks like what I'd expect to see. Just a few
> > > comments around firmware description towards the end.
> > >
> > > > ---
> > > >  Documentation/arm64/memory.rst | 31 +++++++++++++++++++++++++++++++
> > > >  1 file changed, 31 insertions(+)
> > > >
> > > > diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
> > > > index 901cd094f4ec..951802aee55f 100644
> > > > --- a/Documentation/arm64/memory.rst
> > > > +++ b/Documentation/arm64/memory.rst
> > > > @@ -167,3 +167,34 @@ from a 52-bit space by enabling the following kernel config options:
> > > >
> > > >  Note that this option is only intended for debugging applications
> > > >  and should not be used in production.
> > > > +
> > > > +On device memory used as regular memory
> > > > +---------------------------------------
> > > > +Standards such as CXL allow memory on PCIe device to be made
> > > > +available to the operating system for use as regular memory.
> > > > +
> > > > +If memory is added to the UEFI memory map or DT, or discovered via ACPI's SRAT,
> > > > +linux expects it to function in the same way as the bulk DRAM. This section
> > >
> > > Linux
> > >
> > > > +terms this 'regular memory'.
> > > > +
> > > > +The kernel may use any attributes to map this memory, e.g. Device-nGnRnE or
> > > > +Normal Writeback-Cacheable. The kernel may not be in control of the attributes
> > > > +used, e.g. if the memory is used by a KVM guest.
> > > > +The kernel will perform cache maintenance to resolve mismatched attributes,
> > > > +e.g. invalidating clean stale lines after writing new data when the MMU is
> > > > +disabled.
> > > > +
> > > > +The memory may be used by any instruction supported by the CPUs.
> > > > +e.g. Even when the v8.1 LSE atomic instructions are supported, the v8.0
> > > > +exclusives are still used for the futex code, and conditional waits, and still
> > > > +used by existing user-space binaries. When the CPUs support features such as
> > > > +MTE, all regular memory must support MTE tags.
> > > > +
> > > > +On device memory that does not function in the same way as regular memory must
> > > > +not be added to the UEFI memory map or DT, or be discovered via ACPI's SRAT.
> > > > +
> > > > +On arm64, the kernel does not rewrite the UEFI memory map when memory is added
> > > > +or removed. On device memory that is present at boot, but must be removed later
> > >
> > > Might be worth giving an example of why memory 'must be removed'?  I'm not sure
> > > what you are getting at there.  Specific purpose memory?
> > >
> > > > +should be discovered via ACPI's SRAT to ensure it is not used for non-movable
> > > > +structures.
> > >
> > > Not sure I follow this part.  It could be of type EFI_MEMORY_SP.
> >
> > EFI_MEMORY_SP is an attribute, not a type.
>
> Good point.
>
> >
> > > It should be in SRAT as well, but the EFI type should be sufficient to avoid
> > > problems.
> > > "The SPM attribute serves as a hint to the OS to avoid allocating this memory
> > >  for core OS data or code that can not be relocated."
> > >
> > > Now I'm not sure the kernel is handling EFI_MEMORY_SP fully yet...  If
> > > we need to exclude this approach for now, then this text should perhaps
> > > call it out explicitly.
> > >
> >
> > The problem with EFI_MEMORY_SP is that it is not a type, but an
> > attribute,  which gives a hint to the OS about the nature of the
> > memory, which the OS is free to ignore.
>
> IIRC the way around that is to use the reserved type + EFI_MEMORY_SP.
> An unware bootloader or OS will then not use it and hence we are safe.
> An aware driver can then decide it is safe to "hotplug" said memory.
>

True, but then, what good does it do to describe this memory in the
UEFI memory map in the first place?

> >
> > The UEFI memory map is not only consumed by the OS, but by any driver
> > or OS loader that executes in the EFI boot environment, e.g., GPU
> > drivers or shim/grub bootloaders. If these are not enlightened and
> > understand what EFI_MEMORY_SP means, they may (and are entitled to)
> > treat this EFI_MEMORY_SP as if it were regular memory. If GRUB loads
> > the kernel into EFI_MEMORY_SP memory, it had better behave like
> > regular memory or things will fall apart.
>
> Two separate issues here. The 'broken' one where _SP or indeed
> hotplug flag is no use, and the one where it is 'must be removed later'
> and we just don't want to put unmovable allocations in it.
>

I am not sure I follow the 'must be removed' thing. Why is that needed?

> >
> > This means that EFI_MEMORY_SP is really only suitable to describe
> > aspects of the memory range that can be happily ignored. MTE or
> > atomics capability must be described in a different way.
> >
>
> That's indeed the intent. These are just hints and indeed not suitable for
> the cases where things are broken (MTE / Atomics).  In those you
> should not be claiming it is normal memory at all.  SRAT doesn't help
> you with that though.
>
> The hotplug flag is SRAT is also only a hint. OS doesn't have
> to take any notice or support it nor does any boot loader.  Things
> will 'work' with the exception of hot-remove.  If you definitely don't
> want your memory to be used by the OS for normal purposes, then
> don't present it in a form where it might be.
>

Agreed
