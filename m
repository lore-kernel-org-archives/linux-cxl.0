Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C52DC38A2D
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 20:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiJZUeK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiJZUeJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 16:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B264A573B
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666816444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xDK9SpcJnRkQ5dTXycF8Cb/E18YCPCYXacs1p51bQak=;
        b=gpYRTdjgdm2TNvfjNhrq1Y/stA7eSrNyR31UdJ4GCgPRuJhCrTY1iOtj3GfZx1cpbfhoFZ
        i5DDKX8PwKa2ljywRFOLlnkQ7XS1Ro8R5jlMtXtuk0wj0BA4OuI73tXXOUZzm1f+mJRW9D
        5HTzl+pCcgfe0NNqmZ0AWvrfKl1piSA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-3XEfFuYdMJ2HC2mhIiCB6Q-1; Wed, 26 Oct 2022 16:34:03 -0400
X-MC-Unique: 3XEfFuYdMJ2HC2mhIiCB6Q-1
Received: by mail-wm1-f70.google.com with SMTP id f1-20020a1cc901000000b003cf475763b6so809418wmb.3
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDK9SpcJnRkQ5dTXycF8Cb/E18YCPCYXacs1p51bQak=;
        b=sfXlqKKa1xIoSdfxVp4Tq8qRVwAhPYpY7kWB9cqP0T0bhBbCoaFd+vlkd+0wUzzGY0
         q+HGzVEbJQYDMEVO8KGXfMMz1hvst9qU8UuvT13z4pIIyLGkAtURbxtqk1er0/Ya4U5Z
         lOjOMF7RWc693p67s2HfEqUJ+xxVP7EvfHeBaoop4Ne4c/bR/EifQaB5NnjgeF+g+KMQ
         j0Sng57odI6ztYC0p1jueKbWc0Z++GxsuP3mjtkeWJdm/J0pzAOZLhZDytWSmGliXZdl
         x7elo7umUSqwtjBAUgjtbBHNnaplVU91hNbmNf5TSKGDhxmpgeUgueOAaq2kZNR1Rb1A
         3LDg==
X-Gm-Message-State: ACrzQf3Ty/OtsT0bUozSzhpbhShX6YYl8Y6jcT/dqW9fQAk0sYDq0nAf
        d8cFvoj9/ekHAPC760D5fJm0pDczlA2EN2DzZi9cgSpF8XMcB8xBGQjQTvzEry6P3GRCMfCwTjq
        LPZ2z7X9S+15hpwYD+iw9
X-Received: by 2002:a5d:6887:0:b0:236:8ead:47ab with SMTP id h7-20020a5d6887000000b002368ead47abmr2753406wru.372.1666816440680;
        Wed, 26 Oct 2022 13:34:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5GmenqTPA7iRI0ZDrJomr1ijVzSUIu6/rEK7vvw1vz1m3nBfwuc2A/W2Cg6xK15egWeXwPrQ==
X-Received: by 2002:a5d:6887:0:b0:236:8ead:47ab with SMTP id h7-20020a5d6887000000b002368ead47abmr2753389wru.372.1666816440453;
        Wed, 26 Oct 2022 13:34:00 -0700 (PDT)
Received: from redhat.com ([2.52.15.7])
        by smtp.gmail.com with ESMTPSA id bi15-20020a05600c3d8f00b003b497138093sm2589298wmb.47.2022.10.26.13.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:33:59 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:33:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, marcel.apfelbaum@gmail.com,
        imammedo@redhat.com, ani@anisinha.ca, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: Re: [PATCH 1/4] hw/i386/pc.c: CXL Fixed Memory Window should not
 reserve e820 in bios
Message-ID: <20221026163336-mutt-send-email-mst@kernel.org>
References: <20221026004737.3646-1-gregory.price@memverge.com>
 <20221026004737.3646-2-gregory.price@memverge.com>
MIME-Version: 1.0
In-Reply-To: <20221026004737.3646-2-gregory.price@memverge.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 25, 2022 at 08:47:34PM -0400, Gregory Price wrote:
> Early-boot e820 records will be inserted by the bios/efi/early boot
> software and be reported to the kernel via insert_resource.  Later, when
> CXL drivers iterate through the regions again, they will insert another
> resource and make the RESERVED memory area a child.
> 
> This RESERVED memory area causes the memory region to become unusable,
> and as a result attempting to create memory regions with
> 
>     `cxl create-region ...`
> 
> Will fail due to the RESERVED area intersecting with the CXL window.
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
> the CXL Fixed Memory Window:
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


Do we want this as a bugfix, separate from the rest of the
patchset?

> ---
>  hw/i386/pc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 768982ae9a..203c90fedb 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1062,7 +1062,6 @@ void pc_memory_init(PCMachineState *pcms,
>          hwaddr cxl_size = MiB;
>  
>          cxl_base = pc_get_cxl_range_start(pcms);
> -        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);
>          memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
>          memory_region_add_subregion(system_memory, cxl_base, mr);
>          cxl_resv_end = cxl_base + cxl_size;
> @@ -1078,7 +1077,6 @@ void pc_memory_init(PCMachineState *pcms,
>                  memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
>                                        "cxl-fixed-memory-region", fw->size);
>                  memory_region_add_subregion(system_memory, fw->base, &fw->mr);
> -                e820_add_entry(fw->base, fw->size, E820_RESERVED);
>                  cxl_fmw_base += fw->size;
>                  cxl_resv_end = cxl_fmw_base;
>              }
> -- 
> 2.37.3

