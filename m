Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3AFC432BE
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Aug 2021 21:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE3E60FDC
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Aug 2021 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbhHZVpB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbhHZVpA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Aug 2021 17:45:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C174C061757
        for <linux-cxl@vger.kernel.org>; Thu, 26 Aug 2021 14:44:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g184so4185775pgc.6
        for <linux-cxl@vger.kernel.org>; Thu, 26 Aug 2021 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsrE+l6v43JUTOc2rsZx1wz8k6+U1lHPn8MXZvNHQV0=;
        b=s1W8dUn2L5rnyZW36Ur13cGesc9RS6FzCtCCtEEzj2JcB5/bHTLUSkq4BTPAUIy5xq
         /sCjTyRqC5BTCSw1uKSX5geFamic416yexmVowdTRx7hhB42LVngJv27Aniu01yQyL06
         HmGxQ3xh6e295kn701efNIwzACoq8HUv3+8BTa0BkQW01NztlCLxQtve045R/AVpqzPQ
         RTfNg/gU4IRaZWuJDUqa7MykgL+yYDACS2sAF3/KH5l3h5w1fqO+v8ylBA7PR2UKGpUJ
         PjkvhRdoxwGA+motKULfqwf722C3rPMmYslYd2bEFg3gVMAcWf9QYDIvvF2hWYTr00B7
         v/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsrE+l6v43JUTOc2rsZx1wz8k6+U1lHPn8MXZvNHQV0=;
        b=ODNrsQ8SVqsSTQ/PFo6EJ5QanBHf5PGYT2GlSQNxy0swlN25SWAnomvRBa3d8PIMHA
         5Vd01YSqCVAlKh+nqVXR5GjiI5qZvANDDpC1sej3eDLXFXtYbURS8jai+unx7iY//1LB
         y1X3J9umAjNYewA0MCQ4nz/STCEu2No6gI791bP5kl9GkLxvyAz3+tl5zJbPEc0IGUQA
         LO8NPJ9dhiXv3vf6wdHzB6M8glXbVnt1l4AeiuFz/uW8xGxDdsGADoVeqKYb66lOHDSs
         GyDUvaHb+EdGyc0ssSbMxtzqXENoVURPPqC1G4Dg7Omw59bG6HrzgZBWG8TY8RgdbtOd
         cFjg==
X-Gm-Message-State: AOAM530BvxuazJe2HU7tBaqS0SAo+2M53UQFA1nnEaBUmBGLceDkGt/v
        bH8fqDt7c3uoLzj3C8AhwG0e1y28G2OsZET1PBxzSg==
X-Google-Smtp-Source: ABdhPJyaaBaR8a+mRVdK6/O33hsGEg6W3fDaKgyOYESzYEDXE9hPSXl73xyu4V6CLG5bLwt5Bj2ue/i6FxBpTreJfd4=
X-Received: by 2002:a63:dd0e:: with SMTP id t14mr5044374pgg.279.1630014252146;
 Thu, 26 Aug 2021 14:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210723210623.114073-1-ben.widawsky@intel.com>
 <20210723210623.114073-13-ben.widawsky@intel.com> <CAPcyv4g_VBTAo1VQ5V_rFCJT=30_ujqOqnpPMdhZKmOonMbp3Q@mail.gmail.com>
 <20210826210138.qf5ck3sdg2ka33p6@intel.com>
In-Reply-To: <20210826210138.qf5ck3sdg2ka33p6@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 26 Aug 2021 14:44:01 -0700
Message-ID: <CAPcyv4h2bvbYU-NSADUzXbwX_qjqCYeKDbrvAKmUZtaCYNF17w@mail.gmail.com>
Subject: Re: [PATCH 12/23] cxl/region: Add region creation ABI
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Aug 26, 2021 at 2:01 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-08-13 19:19:28, Dan Williams wrote:
> > On Fri, Jul 23, 2021 at 2:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Regions are created as a child of the decoder that encompasses an
> > > address space with constraints. Regions only exist for persistent
> > > capacities.
> >
> > Maybe I am misinterpreting, but regions need to exist for volatile
> > capacities too, otherwise what's the interface for enumerating and
> > reconfiguring volatile interleaves? The only difference is one is
> > recorded in labels.
>
> You mean for hotplugged volatile regions? I thought for static volatile regions,
> BIOS will always set it up and we'll get just a chunk of address space via EFI
> memory map. What would we be reconfiguring?

While the BIOS must set up CXL memory that it advertises as
Conventional Memory to the OS, there is no requirement that the BIOS
sets up *all* volatile memory present at boot. I expect that the BIOS
might do things like setup direct host-bridge attached CXL, or
whatever the OEM expects to be present. I also expect there will be
BIOS implementations that punt on configuring after-market add-on
devices, or ones that are deeper in a switch topology. Regardless
there will be CXL regions that the BIOS sets up that consume CFMWS
space and the driver needs to account for those and provide address
translation. The mechanism for kernel services and resource management
for CXL to operate is to establish CXL regions for them.



> > Perhaps before creating regions we should write the code to enumerate
> > volatile regions that might be present since boot. We'll need that
> > anyway to determine how much CFMWS space is available for dynamic
> > creation. Once happy with the read side then proceed to the write
> > side. Thoughts?
>
> I'm fine either way. I started writing a tool to generate fake labels for this,
> but then we switched course. I think since you sent this email, we've kind of
> decided to do both at the same time.

Yeah, both at the same time works for me.

[..]
> > > +/**
> > > + * struct cxl_region - CXL region
> > > + * @dev: This region's device.
> > > + * @id: This regions id. Id is globally unique across all regions.
> > > + * @res: Address space consumed by this region.
> > > + * @requested_size: Size of the region determined from LSA or userspace.
> > > + * @uuid: The UUID for this region.
> > > + * @list: Node in decoders region list.
> > > + * @eniw: Number of interleave ways this region is configured for.
> > > + * @targets: The memory devices comprising the region.
> > > + */
> > > +struct cxl_region {
> > > +       struct device dev;
> > > +       int id;
> > > +       struct resource *res;
> > > +       u64 requested_size;
> >
> > Why requested_size, and not size? Perhaps this instead should be a
> > pointer to a 'struct cxl_region_label' where the LSA data is cached.
>
> I'd been thinking that regions could be rounded up in size by the driver. It
> could point to a region label too. I hadn't been touching any label creation yet
> because I thought you're bringing that up from the other side. If there's some
> pointer I should use for this, I'm game. Which one?

'struct cxl_region_label' is currently in drivers/nvdimm/label.h it
would need to be moved to common location in include/. I am roughly
expecting that drivers/cxl/ calls into drivers/nvdimm/ to manipulate
the label area.

>
> >
> > I think we'll want struct cxl_volatile_region and struct
> > cxl_persistent_region wrapping a common struct cxl_region.
> >
>
> Reserving the right to change my mind, I think one region struct should be fine,
> it's just one needs to be serialized to the LSA, and the other is ephemeral.

It can be like nvdimm nd_region's where it's one data-structure object
with varying 'struct device_type' types.
