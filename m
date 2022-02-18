Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D83CC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Feb 2022 19:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiBRTR6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:17:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiBRTR5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Feb 2022 14:17:57 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B921B7636
        for <linux-cxl@vger.kernel.org>; Fri, 18 Feb 2022 11:17:40 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id a6so4117632oid.9
        for <linux-cxl@vger.kernel.org>; Fri, 18 Feb 2022 11:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9geZ6V1OCH5IWuqEcnOKzRalIIo8ZYcKWBho59xOqw=;
        b=2zXw3BO6j3yVM7TM79UDrovnwoHpbyrRxm9V1HOLIextxCVpHv0yqygiYXkTcKqjkF
         E8qfumLWxz+NhWGkZFjpuonuVsZ1FiFd4+MVZX29UHWlF3HzjODh7Cah5cmPnRy/tVFA
         cD4tGn16dZbVUy+7/RdsfLlq+Ka9rZHk4LpOar+lebuAF/Cc8fLRrBRfpcKfF1SFE77U
         Tf8xOIEfTdAe4fQzokNOKCS5rXiAcool6/PJvq6TWvoX90gFASOQluIL9X8rgeIZ4CGb
         VbFFAkDvk9sXElx39g5NPsHp4qYGvrXuoXWOBDrv7ulxcOEoAOwQYkT1Iy4Di9nW0vEr
         9gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9geZ6V1OCH5IWuqEcnOKzRalIIo8ZYcKWBho59xOqw=;
        b=QgfImiCkOiuek87R9Vc/dAytAKm+sT3d+7L8RRnIDuulCEg7PZlQ96lE6GLZoaicIE
         cr/XDsv3hAEis1WGhvxUHjUyoJYTYI68wov2W83LyR+j2elKQdcbwpDJkmsVA6UchCQ3
         6WN1O6nw4bviH/u5A6VpcZUk5cPrYCTO1kWWdOTxoXAOXEVhKrky/0sh6JlzVdlSUoHc
         2ygy0nhMXUrirSH/v4LeN9E4M/OINsEnbVMbjKNKdhfBX15X3CZ8NQbunOtwwjg1tUqv
         Pn2vZr4iFb1tbk/YX4h8j/ksZYgbEEpHzUmotHd5FXj3HoypnAL6Pnbyzl5H05h3qTdG
         8WcQ==
X-Gm-Message-State: AOAM532fOUfOfHE184jMWiYlHC5d5N1usFV2HQOWmT1D4GNLv1w1DOTL
        p83ZQhBS4aMS1L2t+un1L1yvCDIcKKkn5ZgRXt8DQw==
X-Google-Smtp-Source: ABdhPJx2XZdVKoxu9zm+U2XcVUQ1AIWSITh9BllZe/C789i0yWRjU6koLQ66x68Zr5JHQW0cMWUW1wjHNbBTBdQ4kEw=
X-Received: by 2002:a54:4f9b:0:b0:2c9:852b:7bdf with SMTP id
 g27-20020a544f9b000000b002c9852b7bdfmr5686212oiy.52.1645211859803; Fri, 18
 Feb 2022 11:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-6-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-6-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Feb 2022 11:17:28 -0800
Message-ID: <CAPcyv4jq470iFeqXPVftSwomcf=aC_eLZUMhMK1JZkOxekkGxQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] cxl/acpi: Handle address space allocation
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Regions are carved out of an addresses space which is claimed by top
> level decoders, and subsequently their children decoders. Regions are

s/children/descendant/

> created with a size and therefore must fit, with proper alignment, in
> that address space. The support for doing this fitting is handled by the
> driver automatically.
>
> As an example, a platform might configure a top level decoder to claim
> 1TB of address space @ 0x800000000 -> 0x10800000000; it would be
> possible to create M regions with appropriate alignment to occupy that
> address space. Each of those regions would have a host physical address
> somewhere in the range between 32G and 1.3TB, and the location will be
> determined by the logic added here.
>
> The request_region() usage is not strictly mandatory at this point as
> the actual handling of the address space is done with genpools. It is
> highly likely however that the resource/region APIs will become useful
> in the not too distant future.

More on this below, but I think resource APIs are critical for the
pre-existing / BIOS created region case and I have a feeling gen_pool
is not a good fit.

> All decoders manage a host physical address space while active. Only the
> root decoder has constraints on location and size. As a result, it makes
> most sense for the root decoder to be responsible for managing the
> entire address space, and mid-level decoders and endpoints can ask the
> root decoder for suballocations.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/acpi.c | 30 ++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h  |  2 ++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d6dcb2b6af48..74681bfbf53c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/platform_device.h>
> +#include <linux/genalloc.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -73,6 +74,27 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>         return 0;
>  }
>
> +/*
> + * Every decoder while active has an address space that it is decoding. However,
> + * only the root level decoders have fixed host physical address space ranges.
> + */
> +static int cxl_create_cfmws_address_space(struct cxl_decoder *cxld,
> +                                         struct acpi_cedt_cfmws *cfmws)
> +{
> +       const int order = ilog2(SZ_256M * cxld->interleave_ways);
> +       struct device *dev = &cxld->dev;
> +       struct gen_pool *pool;
> +
> +       pool = devm_gen_pool_create(dev, order, NUMA_NO_NODE, dev_name(dev));

The cxld dev is not a suitable devm host.

Moreover, the address space is a generic property of root decoders, it
belongs in the core not in cxl_acpi.

As for the data structure / APIs to manage the address space I'm not
sure gen_pool is the right answer, because the capacity tracking will
be done in terms of __request_region() and resource trees. The
infrastructure to keep the gen_pool aligned with the resource tree
drops away if there was an interface for allocating free space out of
a resource tree to augment the base API of requesting space with known
addresses. In fact, there is already the request_free_mem_region()
helper. Did you consider that vs gen_pool? Otherwise, how to solve the
problem of pre-populating the busy areas of the gen_pool relative to
capacity that the BIOS may have consumed out of the decoder range?
That comes for free with just walking decoders at boot and doing
__request_region() against the root decoders. Then the allocation
helper can just walk that free space similar to
request_free_mem_region().

> +       if (IS_ERR(pool))
> +               return PTR_ERR(pool);
> +
> +       cxld->address_space = pool;
> +
> +       return gen_pool_add(cxld->address_space, cfmws->base_hpa,
> +                           cfmws->window_size, NUMA_NO_NODE);
> +}
> +
>  struct cxl_cfmws_context {
>         struct device *dev;
>         struct cxl_port *root_port;
> @@ -113,6 +135,14 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>         cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
>         cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
>
> +       rc = cxl_create_cfmws_address_space(cxld, cfmws);
> +       if (rc) {
> +               dev_err(dev,
> +                       "Failed to create CFMWS address space for decoder\n");
> +               put_device(&cxld->dev);
> +               return 0;
> +       }
> +
>         rc = cxl_decoder_add(cxld, target_map);
>         if (rc)
>                 put_device(&cxld->dev);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d1a8ca19c9ea..b300673072f5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -251,6 +251,7 @@ enum cxl_decoder_type {
>   * @flags: memory type capabilities and locking
>   * @target_lock: coordinate coherent reads of the target list
>   * @region_ida: allocator for region ids.
> + * @address_space: Used/free address space for regions.
>   * @nr_targets: number of elements in @target
>   * @target: active ordered target list in current decoder configuration
>   */
> @@ -267,6 +268,7 @@ struct cxl_decoder {
>         unsigned long flags;
>         seqlock_t target_lock;
>         struct ida region_ida;
> +       struct gen_pool *address_space;
>         int nr_targets;
>         struct cxl_dport *target[];
>  };
> --
> 2.35.0
>
