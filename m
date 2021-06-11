Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F96C48BE0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBC36124C
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 17:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFKRQk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhFKRQk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 13:16:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A1C061574
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 10:14:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g24so6042252pji.4
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlcdfrpHyXEdSc56Gt4yZRbLuUg/HUFSihGMYb52jHU=;
        b=MH1ryAJ/KCUBjJJGAepc/hcMRFTNrzweKQJsdPH3lQX0SkoTaJjsoVmmrjqxbBJlQw
         jkqG7B0MEN6aWS6BgEsA3RLW+YSDuqBTrjTGkQhWniyh4z003H5voL4KzbXn89VMWkT1
         exUuTfPHmZArKyfj+S1xXBPMhDpBcGt8s4yaZt5FyKEusynx+kbGMn4AV1sZpd6UgObv
         Yj5FdV0VM3M1LA0Xqi3WTvj/nVtJQqd9mvVyZP9yVMuy5k74VGtlu7RBGj4PIkHZ6mxs
         Xo0/9OM95ZFoaFTPPOyBPUUfOI5Rd6HEzR1bzGVcRIEzRz+bBcV3/ebNoPW9efvCNsS3
         qUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlcdfrpHyXEdSc56Gt4yZRbLuUg/HUFSihGMYb52jHU=;
        b=qSmpmhio9Jn9wUkwbbArpCX6/2g+U6hNmbt7q4rid8OC+54KKsTcbaA0c9uKctvMbE
         UKSqLDlcukE4olYLXXIdXt2EbIEP3e5nDMQuz5ThhY5I3tF+01pt1GwOrDrYMSEsfE4K
         sL5ZNm1sh0iGU9L5b0SLt960k18Ra8avQUurqlOy8n+L2LroERoxAd7aSHH8c8qg9W/H
         YsSPvP2ikH00qs+ggrqPeuabNKfMTTT/Oq0Qfz7Aj8Wennxm8WWsevFCEiDKTIXDS0I0
         NT5lixnVdlb8zLmJArHCvyM4Xv7WLfmooGkbRvy1ZyOFwQOM/F4iJ52lCtfRjaIdZUlU
         OqGw==
X-Gm-Message-State: AOAM532KOQa0RBQlRojOcozObHszdYEzKi1iWAGbLNPp6VV326DxU9BW
        4fUoFDawQggIqN/EJpliGPrB0ZA1PKT8U8DWsXV8vA==
X-Google-Smtp-Source: ABdhPJzbp763Ey1xtdhY565qNxirORuHjk+fAPP29U/IkBjWMwnfibAIhITF/NZ6naJK++f5BuQnVWef0icgviMbgEE=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr10206458pjb.13.1623431681948;
 Fri, 11 Jun 2021 10:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210611002224.1594913-1-ira.weiny@intel.com> <20210611002224.1594913-3-ira.weiny@intel.com>
In-Reply-To: <20210611002224.1594913-3-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 10:14:31 -0700
Message-ID: <CAPcyv4iZU3ZC9DWsXf1=MEjrftea_88+Adm-me8cuw9e4YkiGw@mail.gmail.com>
Subject: Re: [PATCH 2/3] cxl/mem: Report correct ram/pmem size in sysfs
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 10, 2021 at 5:22 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Memory devices may specify volatile only, persistent only, and
> partitionable space which when added together result in a total capacity.
>
> The partitionable space is configurable between volatile and persistent
> space.  To account for the dynamic partitionable space the correct ram
> and pmem size information is reported in the Get Partition Info device
> command.
>
> Define cxl_mem_get_partition() and call it to retrieve the correct
> ram and pmem ranges sizes.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/pci.c | 97 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9995f97d3b28..bcc2829e4475 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1455,6 +1455,62 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
>         return ret;
>  }
>
> +/**
> + * cxl_mem_get_partition_info - Set partition info
> + * @cxlm: The device to act on
> + * @active_volatile_cap_bytes: returned active volatile capacity; in bytes
> + * @active_persistent_cap_bytes: returned active persistent capacity; in bytes
> + * @next_volatile_cap_bytes: return next volatile capacity; in bytes
> + * @next_persistent_cap_bytes: return next persistent capacity; in bytes
> + *
> + * Retrieve the current partition info for the device specified.  The active
> + * values are the current capacity in bytes.  If not 0, the 'next' values are
> + * the pending values, in bytes, which take affect on next cold reset.
> + *
> + * Return: 0 if no error: or the result of the mailbox command.
> + *
> + * See CXL @8.2.9.5.2.1 Get Partition Info
> + */
> +int cxl_mem_get_partition_info(struct cxl_mem *cxlm,
> +                              u64 *active_volatile_cap_bytes,
> +                              u64 *active_persistent_cap_bytes,
> +                              u64 *next_volatile_cap_bytes,
> +                              u64 *next_persistent_cap_bytes)

Similar to how cxl_mem_identify() populates data in cxl_mem, I would
expect this routine to do the same.

> +{
> +       struct cxl_mbox_get_partition_info {
> +               u64 active_volatile_cap;
> +               u64 active_persistent_cap;
> +               u64 next_volatile_cap;
> +               u64 next_persistent_cap;
> +       } __packed pi;
> +       int rc;
> +
> +       /* On error report 0 */
> +       *active_volatile_cap_bytes = 0;
> +       *active_persistent_cap_bytes = 0;
> +       *next_volatile_cap_bytes = 0;
> +       *next_persistent_cap_bytes = 0;
> +
> +       rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_PARTITION_INFO,
> +                                  NULL, 0, &pi, sizeof(pi));
> +
> +       if (rc)
> +               return rc;
> +
> +       *active_volatile_cap_bytes = le64_to_cpu(pi.active_volatile_cap);
> +       *active_persistent_cap_bytes = le64_to_cpu(pi.active_persistent_cap);
> +       *next_volatile_cap_bytes = le64_to_cpu(pi.next_volatile_cap);
> +       *next_persistent_cap_bytes = le64_to_cpu(pi.next_volatile_cap);
> +
> +       *active_volatile_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +       *active_persistent_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +       *next_volatile_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +       *next_persistent_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_mem_get_partition_info);

Why is this exported? Only the PCI driver cares about this.
