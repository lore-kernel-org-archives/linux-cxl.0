Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA3C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Oct 2022 06:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJRGFq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Oct 2022 02:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJRGFp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Oct 2022 02:05:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E4FA4BA9
        for <linux-cxl@vger.kernel.org>; Mon, 17 Oct 2022 23:05:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id u2so6975225ilv.6
        for <linux-cxl@vger.kernel.org>; Mon, 17 Oct 2022 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gcQvgbhx0qt7pa6W5Oz0mXkhhAvpCTYW9MZ4Lpc/vsU=;
        b=cZzP0iWYfBdpoelbxjjHwg8kfgGLFfDRbZYRJ+tuq342+yXYxm4C32nTb6lNJ+RQ04
         8ZjSfOu6ySx0lPZlpSA908hKPbwIav7JuRoBLaaU7f9AaM5GKA8R9IEWddP5EhAwn7pV
         0xdwJB4Qf5AVq9E/6g2O0Os3AygLyvSVec6PM4rCRkYlJ9+zfitODTw5wVV0zng9ffQK
         Pvt1oYDKNJYtSqgvVLEzJgSiBi/oOV8k+zWJf1xb7dAAZ8ATPKVZGpOPuN0Dc5tBt2Ax
         o0jfSGkyyEafayeMzorncOZKTJjopM77D6/oetI4G3mAsUqur9g5Ic1Z5y5fJW9icXs1
         Q1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcQvgbhx0qt7pa6W5Oz0mXkhhAvpCTYW9MZ4Lpc/vsU=;
        b=QW4k/9LDjiPtSj6/joxyWZ83Nm998ixfb97jxdNV5bwt5dRWJ0xvLTccV68X/6wwgu
         nFZ3G5tb40t0YV6ehX76PqwQm95Y6Im08mHiu7RjDaH5/E3Ub8m+hhx3y8XgV5YU4Aaf
         HBf73+YcMavQHZmJDmlMzdcGJNvuw3jWqkygq7SwX+rhRC3RQStsF0Bh2eOQo+ybaSfe
         BD4MHC4kd7FR6pc7l/71OEKMSVvBvWVJgoVal0A154jAcU74Me43uzGf08cgoBh3vLJE
         +RvpseB+xUxZdXSc6bHP7yiKUmWzIPyWg9iRE+/YMWr6IAzZsO3ptr1wxDhJYzGrntvR
         BtnA==
X-Gm-Message-State: ACrzQf18XQorl6O9H40sO9KeESCtIhMZMcWEw9/brq2KW+5uKJWh2ILK
        44vM9kiBMi26X7p8vk/CqPpJUYEzKGMD24yuaVLZfw==
X-Google-Smtp-Source: AMsMyM6j9cglm4P7WBYc5NvSAakP+sVHnPVcmO0RGCnfiOWvLWa9Ak9zFcpwAgV7iK0miI7oUJnVIQFO8VtCQj1Hi2M=
X-Received: by 2002:a92:2601:0:b0:2fc:48be:e77a with SMTP id
 n1-20020a922601000000b002fc48bee77amr972287ile.202.1666073143236; Mon, 17 Oct
 2022 23:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221017234001.53297-1-gregory.price@memverge.com>
In-Reply-To: <20221017234001.53297-1-gregory.price@memverge.com>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Tue, 18 Oct 2022 11:35:31 +0530
Message-ID: <CAARzgwxEO5rr=b_QjiG7RoEdV=9yOgj9gxUxNvuaUnNtUEnhtw@mail.gmail.com>
Subject: Re: [BUG] hw/i386/pc.c: CXL Fixed Memory Window should not reserve
 e820 in bios
To:     Gregory Price <gourry.memverge@gmail.com>
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

On Tue, Oct 18, 2022 at 5:14 AM Gregory Price <gourry.memverge@gmail.com> wrote:
>
> Early-boot e820 records will be inserted by the bios/efi/early boot
> software and be reported to the kernel via insert_resource.  Later, when
> CXL drivers iterate through the regions again, they will insert another
> resource and make the RESERVED memory area a child.

I have already sent a patch
https://www.mail-archive.com/qemu-devel@nongnu.org/msg882012.html .
When the patch is applied, there would not be any reserved entries
even with passing E820_RESERVED .
So this patch needs to be evaluated in the light of the above patch I
sent. Once you apply my patch, does the issue still exist?

>
> This RESERVED memory area causes the memory region to become unusable,
> and as a result attempting to create memory regions with
>
>     `cxl create-region ...`
>
> Will fail due to the RESERVED area intersecting with the CXL window.
>
>
> During boot the following traceback is observed:
>
> 0xffffffff81101650 in insert_resource_expand_to_fit ()
> 0xffffffff83d964c5 in e820__reserve_resources_late ()
> 0xffffffff83e03210 in pcibios_resource_survey ()
> 0xffffffff83e04f4a in pcibios_init ()
>
> Which produces a call to reserve the CFMWS area:
>
> (gdb) p *new
> $54 = {start = 0x290000000, end = 0x2cfffffff, name = "Reserved",
>        flags = 0x200, desc = 0x7, parent = 0x0, sibling = 0x0,
>        child = 0x0}
>
> Later the Kernel parses ACPI tables and reserves the exact same area as
> the CXL Fixed Memory Window.  The use of `insert_resource_conflict`
> retains the RESERVED region and makes it a child of the new region.
>
> 0xffffffff811016a4 in insert_resource_conflict ()
>                       insert_resource ()
> 0xffffffff81a81389 in cxl_parse_cfmws ()
> 0xffffffff818c4a81 in call_handler ()
>                       acpi_parse_entries_array ()
>
> (gdb) p/x *new
> $59 = {start = 0x290000000, end = 0x2cfffffff, name = "CXL Window 0",
>        flags = 0x200, desc = 0x0, parent = 0x0, sibling = 0x0,
>        child = 0x0}
>
> This produces the following output in /proc/iomem:
>
> 590000000-68fffffff : CXL Window 0
>   590000000-68fffffff : Reserved
>
> This reserved area causes `get_free_mem_region()` to fail due to a check
> against `__region_intersects()`.  Due to this reserved area, the
> intersect check will only ever return REGION_INTERSECTS, which causes
> `cxl create-region` to always fail.
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  hw/i386/pc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 566accf7e6..5bf5465a21 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1061,7 +1061,6 @@ void pc_memory_init(PCMachineState *pcms,
>          hwaddr cxl_size = MiB;
>
>          cxl_base = pc_get_cxl_range_start(pcms);
> -        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);
>          memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
>          memory_region_add_subregion(system_memory, cxl_base, mr);
>          cxl_resv_end = cxl_base + cxl_size;
> @@ -1077,7 +1076,6 @@ void pc_memory_init(PCMachineState *pcms,
>                  memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
>                                        "cxl-fixed-memory-region", fw->size);
>                  memory_region_add_subregion(system_memory, fw->base, &fw->mr);
> -                e820_add_entry(fw->base, fw->size, E820_RESERVED);
>                  cxl_fmw_base += fw->size;
>                  cxl_resv_end = cxl_fmw_base;
>              }
> --
> 2.37.3
>
