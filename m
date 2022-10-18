Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CEDC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Oct 2022 15:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJRPA3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Oct 2022 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJRPA1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Oct 2022 11:00:27 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E87FFA8
        for <linux-cxl@vger.kernel.org>; Tue, 18 Oct 2022 08:00:25 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so7569933ilq.8
        for <linux-cxl@vger.kernel.org>; Tue, 18 Oct 2022 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0G7EOk7akyA/Lb/Og3gO/ph3zGPd9aFNgixDueHRudM=;
        b=sIRzegFXNA4CgUaigluF0E/LuoOcQpozmVl/Y6DdfDLQkQw9W5UaFxJ+LivqHE76Ar
         srx3QdeXJnNNc9qANcxM+yj+27aaeN3N/BDuX0Yk5nuQ2dlxnU+Tm2frbys7iXmz7vbF
         4qb/KhYIfS1WiSomLtMOzfufthVeIkdesXjmjhhX1cMp5KkdAU3a0ehmdPZXfGbYR0Ob
         duatxxOoWV5q1DBBEuByOc5remWWljvxoDxhhL8HC1mA3iaFwY+M2IoKSHMGhpYxBogE
         B6RwIdXHjyzbDTEJS02f2FH3s6LAub9QXTuNqjngvo/9xJW9Ein64b2UKwK/ga8GQ4Fq
         aQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G7EOk7akyA/Lb/Og3gO/ph3zGPd9aFNgixDueHRudM=;
        b=WlCKQRGjrsv1rCcFRNtUh6hGaOP17r8NXuqKeWIQxmkbuLXGwplxnvlL9ZHYRylGGS
         MNMX/hhZP8kPKQbAZD/3WYyq2YqIvFKt+oZpm8Xyj/KiRGt4/+5iVOV6vaSfwawAyS1h
         10GlZqpj9vpNtYaZUOV/mhOdPyE6EWzTASEhJy1sFQj6Et6Rtz2EYCTsddAPLtLc21q7
         d+r2E1rEVtpIN+Q13NdxmI4UvzHJRzZJtYfS7B3dTtIBIF0sDf+g6AwvfaiuL7drSIwB
         zu+Z6jistYVUXqMB1CUumbG6AhVYgfPSxUorajW7zC8djLFVrFLJB7YeSA/pQoSQaFXb
         UtWg==
X-Gm-Message-State: ACrzQf3VkO/nb5o0HZHN1I1TNClKzQSACKxqgPgCpk5ZlIklfaDq3u0v
        NY93mp1byFChtvJha6+idZ8QjqGxYI5myEiX20DzoQ==
X-Google-Smtp-Source: AMsMyM5qA+yR7U+8Z2EOqcoLCkjEtJ0ZfUCV2vhO08dU7aJpkllyyeUuZAeGwaDVdqhp/5QRwjA+5tWCdEOy19CpMHQ=
X-Received: by 2002:a05:6e02:174d:b0:2fa:1b65:106e with SMTP id
 y13-20020a056e02174d00b002fa1b65106emr1972143ill.63.1666105224269; Tue, 18
 Oct 2022 08:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221017234001.53297-1-gregory.price@memverge.com>
 <CAARzgwxEO5rr=b_QjiG7RoEdV=9yOgj9gxUxNvuaUnNtUEnhtw@mail.gmail.com> <CAD3UvdTWLXf_OecWbtP9wfAvO2+xdWiAUjQHONrgB4AAAjwdHQ@mail.gmail.com>
In-Reply-To: <CAD3UvdTWLXf_OecWbtP9wfAvO2+xdWiAUjQHONrgB4AAAjwdHQ@mail.gmail.com>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Tue, 18 Oct 2022 20:30:13 +0530
Message-ID: <CAARzgwyCTaNoiqtVPS394Nk9LAS05116Dvc2GxifHpO01+ZN4g@mail.gmail.com>
Subject: Re: [BUG] hw/i386/pc.c: CXL Fixed Memory Window should not reserve
 e820 in bios
To:     Gregory Price <gourry.memverge@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
        imammedo@redhat.com, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

+Gerd Hoffmann

On Tue, Oct 18, 2022 at 8:16 PM Gregory Price <gourry.memverge@gmail.com> wrote:
>
> This patch does not resolve the issue, reserved entries are still created.
>
> [    0.000000] BIOS-e820: [mem 0x0000000280000000-0x00000002800fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000290000000-0x000000029fffffff] reserved
>
> # cat /proc/iomem
> 290000000-29fffffff : CXL Window 0
>   290000000-29fffffff : Reserved
>
> # cxl create-region -m -d decoder0.0 -w 1 -g 256 mem0
> cxl region: create_region: region0: set_size failed: Numerical result out of range
> cxl region: cmd_create_region: created 0 regions
>
> On Tue, Oct 18, 2022 at 2:05 AM Ani Sinha <ani@anisinha.ca> wrote:
>>
>> On Tue, Oct 18, 2022 at 5:14 AM Gregory Price <gourry.memverge@gmail.com> wrote:
>> >
>> > Early-boot e820 records will be inserted by the bios/efi/early boot
>> > software and be reported to the kernel via insert_resource.  Later, when
>> > CXL drivers iterate through the regions again, they will insert another
>> > resource and make the RESERVED memory area a child.
>>
>> I have already sent a patch
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg882012.html .
>> When the patch is applied, there would not be any reserved entries
>> even with passing E820_RESERVED .
>> So this patch needs to be evaluated in the light of the above patch I
>> sent. Once you apply my patch, does the issue still exist?
>>
>> >
>> > This RESERVED memory area causes the memory region to become unusable,
>> > and as a result attempting to create memory regions with
>> >
>> >     `cxl create-region ...`
>> >
>> > Will fail due to the RESERVED area intersecting with the CXL window.
>> >
>> >
>> > During boot the following traceback is observed:
>> >
>> > 0xffffffff81101650 in insert_resource_expand_to_fit ()
>> > 0xffffffff83d964c5 in e820__reserve_resources_late ()
>> > 0xffffffff83e03210 in pcibios_resource_survey ()
>> > 0xffffffff83e04f4a in pcibios_init ()
>> >
>> > Which produces a call to reserve the CFMWS area:
>> >
>> > (gdb) p *new
>> > $54 = {start = 0x290000000, end = 0x2cfffffff, name = "Reserved",
>> >        flags = 0x200, desc = 0x7, parent = 0x0, sibling = 0x0,
>> >        child = 0x0}
>> >
>> > Later the Kernel parses ACPI tables and reserves the exact same area as
>> > the CXL Fixed Memory Window.  The use of `insert_resource_conflict`
>> > retains the RESERVED region and makes it a child of the new region.
>> >
>> > 0xffffffff811016a4 in insert_resource_conflict ()
>> >                       insert_resource ()
>> > 0xffffffff81a81389 in cxl_parse_cfmws ()
>> > 0xffffffff818c4a81 in call_handler ()
>> >                       acpi_parse_entries_array ()
>> >
>> > (gdb) p/x *new
>> > $59 = {start = 0x290000000, end = 0x2cfffffff, name = "CXL Window 0",
>> >        flags = 0x200, desc = 0x0, parent = 0x0, sibling = 0x0,
>> >        child = 0x0}
>> >
>> > This produces the following output in /proc/iomem:
>> >
>> > 590000000-68fffffff : CXL Window 0
>> >   590000000-68fffffff : Reserved
>> >
>> > This reserved area causes `get_free_mem_region()` to fail due to a check
>> > against `__region_intersects()`.  Due to this reserved area, the
>> > intersect check will only ever return REGION_INTERSECTS, which causes
>> > `cxl create-region` to always fail.
>> >
>> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
>> > ---
>> >  hw/i386/pc.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> > index 566accf7e6..5bf5465a21 100644
>> > --- a/hw/i386/pc.c
>> > +++ b/hw/i386/pc.c
>> > @@ -1061,7 +1061,6 @@ void pc_memory_init(PCMachineState *pcms,
>> >          hwaddr cxl_size = MiB;
>> >
>> >          cxl_base = pc_get_cxl_range_start(pcms);
>> > -        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);
>> >          memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
>> >          memory_region_add_subregion(system_memory, cxl_base, mr);
>> >          cxl_resv_end = cxl_base + cxl_size;
>> > @@ -1077,7 +1076,6 @@ void pc_memory_init(PCMachineState *pcms,
>> >                  memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
>> >                                        "cxl-fixed-memory-region", fw->size);
>> >                  memory_region_add_subregion(system_memory, fw->base, &fw->mr);
>> > -                e820_add_entry(fw->base, fw->size, E820_RESERVED);
>> >                  cxl_fmw_base += fw->size;
>> >                  cxl_resv_end = cxl_fmw_base;
>> >              }
>> > --
>> > 2.37.3
>> >
