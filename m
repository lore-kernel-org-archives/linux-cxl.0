Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F4FC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 18:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F8861104
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 18:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbhIBS6D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 14:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhIBS56 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Sep 2021 14:57:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4380DC061575
        for <linux-cxl@vger.kernel.org>; Thu,  2 Sep 2021 11:57:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v123so2382617pfb.11
        for <linux-cxl@vger.kernel.org>; Thu, 02 Sep 2021 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKVK9ap/fmp923yqi9CXRY5pNUSdpusSR2WICESY2RE=;
        b=JzALAEgl4Z34I6ia/RWpo+fTdTrlNcuIVS6Prqeox0nfo0pwF3/bGWJHPgP2g+pUjp
         50hkJ9W+1fyBv6i2IS/oDcr5KZ+v9oO4zvbLneMh4QNhNx/c0C/wBPP/gFsMCEZSCoaZ
         MaPVSxHCJzM4BKnKRWMfnI/VWH+h0o76AUWFAhJXG0nNQZR3Lwvmk028uoP+mKbXF8z1
         3v9k2f6RoaGL/9lXRqbQd0WI7FQGK/rD1aUnIia+aUYzj1BPeqIwvsCXRY2SOh4/VI3e
         qLRhZd20UzQudEMPEVo/fljO4nYP+XJlKb/29l9bo7NI6rP4Tt0MufEGAGsZKrfu18Pr
         hF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKVK9ap/fmp923yqi9CXRY5pNUSdpusSR2WICESY2RE=;
        b=P1orKyPti3orb/ON6tglZpKXuEhP69UE08sxhKFHgK2FwstwhrNI0cB27YHH1KDISi
         8hPaX2VTHL+SDo4XkPAYb7L9bDuvHqVYBfxb5o76q5jBriVIbAT6AzHOvInFMrBeMtiT
         HH9FWhrawNVQ+lahnPElwdfgKfHDLVMZXuO85Qt1/OE5sv/YwWsxmscC6zehGRBjP9nM
         Y0aOw2G2BH2W8alLiNIOC3Hga2n7Sl8+CECdahmn9XjfTVKq400/R6laswdbEJo8A8KQ
         UPbRXx2RIXqwgy+/wizMzubDIVp+oyZsVxjYp/Cc6IOrQHpAAGxL/AbmpRFaTucVum5n
         nWMQ==
X-Gm-Message-State: AOAM530ke+07IvzYwOVVoqI/C/NQaGiKyCyI8io9yLYej2C4ZHf5iQDr
        9EMS+6zamXd2oUY2IHLwEBTwoNbUscAxpzaeoH9gwQ==
X-Google-Smtp-Source: ABdhPJzKMF6gZn/V8+OxJOmkmVlyVHNXAtbB9ZTinqKf7P+p97Wq+pBeZTn9mbQ7wSHLMfx4SXHoOpkXlPtXosXh6ow=
X-Received: by 2002:a65:6642:: with SMTP id z2mr4543930pgv.240.1630609019657;
 Thu, 02 Sep 2021 11:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162982121720.1124374.4630115550776741892.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210902185606.0000731b@Huawei.com>
In-Reply-To: <20210902185606.0000731b@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Sep 2021 11:56:48 -0700
Message-ID: <CAPcyv4h8O80TN6MtV1ThFW5NZOJ+yixkm40J2puLacfefhMMOQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/28] cxl/mbox: Move mailbox and other non-PCI
 specific infrastructure to the core
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        kernel test robot <lkp@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 2, 2021 at 10:56 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 24 Aug 2021 09:06:57 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Now that the internals of mailbox operations are abstracted from the PCI
> > specifics a bulk of infrastructure can move to the core.
> >
> > The CXL_PMEM driver intends to proxy LIBNVDIMM UAPI and driver requests
> > to the equivalent functionality provided by the CXL hardware mailbox
> > interface. In support of that intent move the mailbox implementation to
> > a shared location for the CXL_PCI driver native IOCTL path and CXL_PMEM
> > nvdimm command proxy path to share.
> >
> > A unit test framework seeks to implement a unit test backend transport
> > for mailbox commands to communicate mocked up payloads. It can reuse all
> > of the mailbox infrastructure minus the PCI specifics, so that also gets
> > moved to the core.
> >
> > Finally with the mailbox infrastructure and ioctl handling being
> > transport generic there is no longer any need to pass file
> > file_operations to devm_cxl_add_memdev(). That allows all the ioctl
> > boilerplate to move into the core for unit test reuse.
> >
> > No functional change intended, just code movement.
>
> This didn't give me the warm fuzzy feeling of a straight forward move patch.
> A few oddities below, but more generally can you break this up a bit.
> That "Finally" for examples feels like it could be done as a precursor to this.
>
> This also has the updated docs thing I commented on in an earlier patch
> that needs moving back to that patch.

All good feedback here. It's also of the variety that is not suitable
to address incrementally. Right now I am leaning towards respin and if
the respin looks good and soaks ok over the weekend still attempt to
get this in for v5.15. It does mean that cxl.git/next needs to rebase.

...although, I reserve the right to lose my nerve about reflowing
patches *in* the merge window and delay this set until v5.16.

Comment replies below.

>
> Jonathan
>
>
> >
> > Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/driver-api/cxl/memory-devices.rst |    3
> >  drivers/cxl/core/Makefile                       |    1
> >  drivers/cxl/core/bus.c                          |    4
> >  drivers/cxl/core/core.h                         |    8
> >  drivers/cxl/core/mbox.c                         |  834 ++++++++++++++++++++
> >  drivers/cxl/core/memdev.c                       |   81 ++
> >  drivers/cxl/cxlmem.h                            |   81 ++
> >  drivers/cxl/pci.c                               |  941 -----------------------
> >  8 files changed, 987 insertions(+), 966 deletions(-)
> >  create mode 100644 drivers/cxl/core/mbox.c
>
>
>
> >
> >  #endif /* __CXL_CORE_H__ */
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > new file mode 100644
> > index 000000000000..706fe007c8d6
> > --- /dev/null
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -0,0 +1,834 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/security.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pci.h>
>
> Given stated aim is to have this pci free, I doubt this header is required!

Good catch, that header came along for the copy/paste ride.

>
> > +#include <cxlmem.h>
> > +#include <cxl.h>
> > +
> > +#include "core.h"
> > +
> > +static bool cxl_raw_allow_all;
> > +
> > +/**
> > + * DOC: cxl mbox
> > + *
> > + * Core implementation of the CXL 2.0 Type-3 Memory Device Mailbox. The
> > + * implementation is used by the cxl_pci driver to initialize the device
> > + * and implement the cxl_mem.h IOCTL UAPI. It also implements the
> > + * backend of the cxl_pmem_ctl() transport for LIBNVDIMM.
> > + *
>
> Trivial: No need for the last blank line.

Sure.

>
> > + */
> > +
> > +#define cxl_for_each_cmd(cmd)                                                  \
> > +     for ((cmd) = &cxl_mem_commands[0];                                     \
> > +          ((cmd)-cxl_mem_commands) < ARRAY_SIZE(cxl_mem_commands); (cmd)++)
>
> Spaces around the -

Interesting that git-clang-format injected that problem and checkpatch
didn't catch it.

>
> > +
> > +#define cxl_doorbell_busy(cxlm)                                                \
> > +     (readl((cxlm)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
> > +      CXLDEV_MBOX_CTRL_DOORBELL)
>
> I think we now have two copies of this which isn't ideal.
> Something gone wrong with moving this?
>
> > +
> > +/* CXL 2.0 - 8.2.8.4 */
> > +#define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
>
> Also this which still seems to be in pci.c

Just sloppiness on my part as far as I can see.

>
> ...
>
> > +/**
> > + * cxl_mem_get_partition_info - Get partition info
> > + * @cxlm: The device to act on
> > + * @active_volatile_bytes: returned active volatile capacity; in bytes
> > + * @active_persistent_bytes: returned active persistent capacity; in bytes
> > + * @next_volatile_bytes: return next volatile capacity; in bytes
> > + * @next_persistent_bytes: return next persistent capacity; in bytes
> > + *
> > + * Retrieve the current partition info for the device specified.  The active
> > + * values are the current capacity in bytes.  If not 0, the 'next' values are
>
> No problem with the updated comment, but shouldn't be in this patch without
> at least being called out.
>

Yes.

> > + * the pending values, in bytes, which take affect on next cold reset.
> > + *
> > + * Return: 0 if no error: or the result of the mailbox command.
> > + *
> > + * See CXL @8.2.9.5.2.1 Get Partition Info
> > + */
> > +static int cxl_mem_get_partition_info(struct cxl_mem *cxlm)
> > +{
> > +     struct cxl_mbox_get_partition_info {
> > +             __le64 active_volatile_cap;
> > +             __le64 active_persistent_cap;
> > +             __le64 next_volatile_cap;
> > +             __le64 next_persistent_cap;
> > +     } __packed pi;
> > +     int rc;
> > +
> > +     rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_PARTITION_INFO,
> > +                                NULL, 0, &pi, sizeof(pi));
> > +
> > +     if (rc)
> > +             return rc;
> > +
> > +     cxlm->active_volatile_bytes =
> > +             le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> > +     cxlm->active_persistent_bytes =
> > +             le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
> > +     cxlm->next_volatile_bytes =
> > +             le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> > +     cxlm->next_persistent_bytes =
> > +             le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>
> I'd have kept this bit of cleanup separate. For a code move patch I don't want
> to have to spot the places where things weren't just a move. Same in other places.
>
> Not a bit thing though so if you don't want to pull these out separately then
> I don't mind that much.

Sure, should have been noted as a minimum.

>
> > +
> > +     return 0;
> > +}
>
> > +
> > +struct cxl_mem *cxl_mem_create(struct device *dev)
>
> The parameter change from struct pci_dev * is a bit more than I'd
> expect in a code move patch. I would have done that in a precursor if possible.

Agree.

>
> > +{
> > +     struct cxl_mem *cxlm;
> > +
> > +     cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
> > +     if (!cxlm)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     mutex_init(&cxlm->mbox_mutex);
> > +     cxlm->dev = dev;
> > +     cxlm->enabled_cmds =
> > +             devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
> > +                                sizeof(unsigned long),
> > +                                GFP_KERNEL | __GFP_ZERO);
> > +     if (!cxlm->enabled_cmds)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     return cxlm;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_mem_create);
> > +
>
> ...
>
>
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index a56d8f26a157..b7122ded3a04 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -2,6 +2,7 @@
> >  /* Copyright(c) 2020-2021 Intel Corporation. */
> >  #ifndef __CXL_MEM_H__
> >  #define __CXL_MEM_H__
> > +#include <uapi/linux/cxl_mem.h>
> >  #include <linux/cdev.h>
> >  #include "cxl.h"
> >
> > @@ -28,21 +29,6 @@
> >       (FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
> >        CXLMDEV_RESET_NEEDED_NOT)
> >
>
> ...
>
> >  /**
> > - * struct mbox_cmd - A command to be submitted to hardware.
> > + * struct cxl_mbox_cmd - A command to be submitted to hardware.
>
> Ah. Here it is ;)  Move to earlier patch.

Yes.

>
> >   * @opcode: (input) The command set and command submitted to hardware.
> >   * @payload_in: (input) Pointer to the input payload.
> >   * @payload_out: (output) Pointer to the output payload. Must be allocated by
> > @@ -147,4 +132,62 @@ struct cxl_mem {
> >
> >       int (*mbox_send)(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd);
> >  };
> >  #endif /* __CXL_MEM_H__ */
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index a211b35af4be..b8075b941a3a 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -1,17 +1,12 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > -#include <uapi/linux/cxl_mem.h>
> > -#include <linux/security.h>
> > -#include <linux/debugfs.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/module.h>
> >  #include <linux/sizes.h>
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> > -#include <linux/cdev.h>
> > -#include <linux/idr.h>
>
> Why was this here in the first place?
> If it's unrelated, then separate patch ideally.

Yeah, those headers were invalidated by the earlier move of the memdev
code into drivers/cxl/core/memdev.c. Will fold these deletions there.
