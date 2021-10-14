Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6AEC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 00:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6996603E8
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 00:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhJNAoS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhJNAoS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Oct 2021 20:44:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58AC061570
        for <linux-cxl@vger.kernel.org>; Wed, 13 Oct 2021 17:42:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id a73so3966135pge.0
        for <linux-cxl@vger.kernel.org>; Wed, 13 Oct 2021 17:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfRQr6k/obvRQOFOLfCvUc1bWyG7SZdHPNEjDYyZAU0=;
        b=xwczeQaxlMGZ0jWMa9b3KY2JPb5Ofq9AtcxWnu3TT1XfFCYt1yIP09dg5AyqSt8+rx
         5xxunVtJyHs9UynWDKL9gfsVgKpuKNJvHn4kVbBNoLN2A0O8phbB2S0A/i2RLL/dtcYl
         CtwITbalr2DB7Uj6/XwmVOM0fQ5T9qIRtPJ9BQP1FbGeUzNOW3+jWC+fjgug9TWyBn4H
         jaOiFsQwkXbhrpVSHrev2F8PF/NiGQ0KrbN5z9IxqHq+VWEKP1BGot69FpY38iVpPJm2
         TN+Sy6/lWfPdpIvTwj4mBgS1b5UkAzkyy6S00R8W1IUn2Y0YGPtRj+xudp7K/HEhYmNk
         m5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfRQr6k/obvRQOFOLfCvUc1bWyG7SZdHPNEjDYyZAU0=;
        b=ctlyAHS1WYWtDsEzNjJ6B7mgGWmuaSClEaV02rLXZS7zcHkvS2UsQeWz91DBySusrt
         /5+721oWsGz3LZ6r9+ZOF2c6uq0U+tygsSJAKNeJeAdM+QWlNtSuHSLlx+CoMfrBEWEP
         s21dSmzz0JB0mmLJg0DJhJDjmLYSi/xMyz8THqL6DJ3VfOPBliOKNBMzMpzJYHp6lTlS
         HTbHKOtxC95Bg8bEzH7Ttu7HtUr23sv3kS7BJys3P2y9YoYYyoo2R5oho2ehxz9DyzHm
         qwkm+6u4T6DRR7X+Mf+uvCYhzzZJr+0dzrhRAotO8WunuL1Wa+lkZJpXAA6q0COMPIkV
         myVg==
X-Gm-Message-State: AOAM530FD+mofbrJftr14UTH6M70NlZUNpmqkaK18dolvMKrqUgxCI49
        gWI/z4BNwgCciLYh1z6r1CQIqfdXso8RuD4jO4RFCA==
X-Google-Smtp-Source: ABdhPJxKjYnAd1Fh3LVRDgPct38ouf3VzXJ3ltR5B1gtzdYovpJ5E7HdS/lzy82UdCal1jomrOs6qP6BJ6mo3JfoY7Q=
X-Received: by 2002:a63:1262:: with SMTP id 34mr1941726pgs.356.1634172134068;
 Wed, 13 Oct 2021 17:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211009015339.400383-1-alison.schofield@intel.com>
 <20211011171315.GL3114988@iweiny-DESK2.sc.intel.com> <20211011220053.GA412964@alison-desk>
In-Reply-To: <20211011220053.GA412964@alison-desk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Oct 2021 17:42:03 -0700
Message-ID: <CAPcyv4juNdTn2uVOw1H0-BdVus0XpCwoYShTV2THi5V33Bo_VA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Oct 11, 2021 at 2:52 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> Thanks for the review Ira!
>
> On Mon, Oct 11, 2021 at 10:13:16AM -0700, Ira Weiny wrote:
> > On Fri, Oct 08, 2021 at 06:53:39PM -0700, Schofield, Alison wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > > subtable may be assigned to a NUMA node. Since there is no
> > > requirement that the SRAT be comprehensive for CXL memory another
> > > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > > in the SRAT.
> > >
> > > Use the CXL Fixed Memory Window Structure's (CFMWS) of the ACPI CXL
> > > Early Discovery Table (CEDT) to find all CXL memory ranges. Create a
> > > NUMA node for each range that is not already assigned to a NUMA node.
> > > Add a memblk attaching its host physical address range to the node.
> > >
> > > Note that these ranges may not actually map any memory at boot time.
> > > They may describe persistent capacity or may be present to enable
> > > hot-plug.
> > >
> > > Consumers can use phys_to_target_node() to discover the NUMA node.
> > >
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/acpi/numa/srat.c | 58 ++++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/acpi.c       |  8 +++---
> > >  2 files changed, 63 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > index b8795fc49097..568e033e6c3f 100644
> > > --- a/drivers/acpi/numa/srat.c
> > > +++ b/drivers/acpi/numa/srat.c
> > > @@ -300,6 +300,61 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> > >  }
> > >  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
> > >
> > > +/* Add a NUMA node and memblk for each node-less CFMWS */
> >
> > IMO this comment does not make sense for a function called 'parse cfmws'.  I
> > would just drop it.
> >
>
> Agree. Dropping comment.
>
> You made me stare at this func name more, and it can be better.
> I'll try this: acpi_cxl_cfmws_init()
> to be more like the others in this file, doing similar work.
>
> > > +static int __init acpi_parse_cfmws(struct acpi_table_header *acpi_cedt)
> > > +{
>
> snip
>
>
> > > +           if (numa_add_memblk(node, start, end) < 0) {
> > > +                   pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> > > +                           node, start, end);
> >
> > Is there anything which could go wrong if the block is not added to the numa
> > node?
> >
> > Ira
> >
>
> I intended, but failed, to mimic the adding of nodes & memblocks based
> on the SRAT Memory Affinity table. There, a failure from numa_add_memblk()
> causes the entire SRAT parsing to fail, and IIUC entire acpi_numa init fails.
>
> FYI: numa_add_memblk() only completely fails (-EINVAL) if we've used up all
> the NR_NODE_MEMBLKS (which is set to MAX_NUMNODE*2)

If you're bumping up against that limit then this would have already
failed above at the acpi_map_pxm_to_node() call, right?

> My first guess would be to follow the pattern and fail the entire
> acpi_numa init. ie make acpi_numa = -1; I'll pursue that.

I think CFMWS ranges for future hotplug are in a different class than
memory currently present and marked online by the SRAT. So as long as
this implementation can determine that the range is for future
hotplug, which I believe the phys_to_target_node() pre-check handles,
then I think it is safe to note the failure and continue. With the
expectation that the CXL driver needs to handle the NUMA_NO_NODE case
at memory hot-add time.

> Now, back to your specific question: "Is there anything which could
> go wrong if the block is not added to the numa node?"
>
> numa_add_memblk(_to) can actually return success without adding a memblock.
> Like this:
> /* whine about and ignore invalid blks */
> if (start > end || nid < 0 || nid >= MAX_NUMNODES) {
>         pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
>                 nid, start, end - 1);
>         return 0;
> }
>
> So, I'm going to make an assumption that it can be handled, and see if
> someone else chimes in here with more knowledge of why we can quietly
> ignore.

I wouldn't say quietly ignore as the failure here means that the
system cannot accurately place CXL memory for best performance.
There's already so many other ways that CXL memory dynamic setup can
go sideways that the lack of a dedicated NUMA node is not necessarily
fatal... in my opinion. It is a judgment call, but I think Robustness
Principle nudges it towards: "continue and try to make the best of
it".
