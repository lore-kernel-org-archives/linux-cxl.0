Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8E4C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 20 Apr 2022 15:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380244AbiDTPfj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 20 Apr 2022 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380153AbiDTPfi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 20 Apr 2022 11:35:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825BE3EBB4
        for <linux-cxl@vger.kernel.org>; Wed, 20 Apr 2022 08:32:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so5286730pjb.2
        for <linux-cxl@vger.kernel.org>; Wed, 20 Apr 2022 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXE5rwL9G2A41ELB44LpkE3yJsmwyolaHB1ZPKjmFOQ=;
        b=0SXGd8Ae3eImiVBD6ABuD0fsXiFcFNvWy5KkdAeY/lHkDA49w+yQI4qNYa59bp6t+2
         283Pj4uoCOZDNM9TduFm0HdsIrwhdFs9enJ/s2rBqPUVx/cZ5WyaqYQd6VrLRNUp8Fj7
         2y2HF9Vn0OVAfc3pugwCMvw4w5sRTRCBGS5DdF8h6jBHBt17pBvouhWv63c/YzSqRban
         5+pG+xaDeA1nOixh/UJXeULk1dAOgfYfB5Zo7lan6SA5ifoiRoNjxVFu57fOcCVc1Tai
         XNGD1dYGFtFaCQcsJ/erjzWgGK0nynZfU5qeauO+TZuJ4oC4tZoYGjkN+TU4WsljBuIe
         96vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXE5rwL9G2A41ELB44LpkE3yJsmwyolaHB1ZPKjmFOQ=;
        b=zIs97JkLhY7niV8zmgzX9ppLKJDyMO/lON/I2rNkSXSLLu0IFzvrASLDkPSKPl/Skt
         ZLt9i0KORWdDANdUxZy7wwvHhZzGQNBT0g1hI5WIdHnMtWhrm1nDW5oHkPk6rOO3E7Zx
         wGl1eAi1Ssz7/twBwXciVvIHDW8fuSxvahgDU2lB9XnZgK2muN804/BwXr8ddLt+hjUd
         N1+fuFEkMF9hr5ypcnoT9omHyjT/aPlfhFiByHWmCtItZ/PlccdwgeTf603NeCuUv/4A
         kCD7Q2jzJdqM+8GjqBEjruR4aA3xWVnWxWuXdMpMFGnEBeOgg1KNgReAtZvvDy/EvjEF
         5erQ==
X-Gm-Message-State: AOAM533SXD4jQu5sqPrgX8yq3Wg+i2JGIWeNdrE44a7Yu1M9oXM9lw6X
        lmqvVsUQQXKps9Vw7AL/uvT3xsmSV6sUAsLaZvbBtZZgpH4=
X-Google-Smtp-Source: ABdhPJzxSLprMHwiebGFjIYgLqgnPEmnfHzZ+E1b9NgLe/j/RYYtesZJu7ti/Pt0NzfrUUWdkHUYvByBKWPEmHNRe0o=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr21203839pll.132.1650468771886; Wed, 20
 Apr 2022 08:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
 <20220413183720.2444089-6-ben.widawsky@intel.com> <CAPcyv4iM13nzCpnF5S4oHSWF769t4Av96gQM_3n4E=RAPSnSig@mail.gmail.com>
 <20220419164313.GT2120790@nvidia.com> <CAPcyv4hPBw0yJmu7qzSZ_gsbVuj+_R7-_r3+_W9-JsLTD6Uscw@mail.gmail.com>
 <CAPcyv4hyTRm7K8gu4wdL_gaMm2C+Agg1V2-BbnmJ8Kf0OH4sng@mail.gmail.com>
 <20220419230412.GU2120790@nvidia.com> <CAPcyv4i5MZcMcCq8V7sZQjqup6MPOoOj2Zuu8HEECADfFi2Tcg@mail.gmail.com>
 <20220420143406.GY2120790@nvidia.com>
In-Reply-To: <20220420143406.GY2120790@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Apr 2022 08:32:41 -0700
Message-ID: <CAPcyv4ju7vF7vaTgneVyPRX0SNncvsqz-BHkD9c8MhpAFAiNPw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/15] cxl/acpi: Reserve CXL resources from request_free_mem_region
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 20, 2022 at 7:35 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Apr 19, 2022 at 05:47:56PM -0700, Dan Williams wrote:
> > On Tue, Apr 19, 2022 at 4:04 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Tue, Apr 19, 2022 at 02:59:46PM -0700, Dan Williams wrote:
> > >
> > > > ...or are you suggesting to represent CXL free memory capacity in
> > > > iomem_resource and augment the FW list early with CXL ranges. That
> > > > seems doable, but it would only represent the free CXL ranges in
> > > > iomem_resource as the populated CXL ranges cannot have their resources
> > > > reparented after the fact, and there is plenty of code that expects
> > > > "System RAM" to be a top-level resource.
> > >
> > > Yes, something more like this. iomem_resource should represent stuff
> > > actually in use and CXL shouldn't leave behind an 'IOW' for address
> > > space it isn't actually able to currently use.
> >
> > So that's the problem, these gigantic windows need to support someone
> > showing up unannounced with a stack of multi-terabyte devices to add
> > to the system.
>
> In my experience PCIe hotplug is already extremely rare, you may need
> to do this reservation on systems with hotplug slots, but not
> generally. In PCIe world the BIOS often figures this out and bridge
> windows are not significantly over allocated on non-hotplug HW.
>
> (though even PCIe has the resizable bar extension and other things
> that are quite like hotplug and do trigger huge resource requirements)
>
> > > Your whole description sounds like the same problems PCI hotplug has
> > > adjusting the bridge windows.
> >
> > ...but even there the base bounds (AFAICS) are coming from FW (_CRS
> > entries for ACPI described PCIe host bridges). So if CXL follows that
> > model then the entire unmapped portion of the CXL ranges should be
> > marked as an idle resource in iomem_resource.
>
> And possibly yes, because part of the point of this stuff is to
> declare where HW is actually using the address space. So if FW has
> left a host bridge decoder setup to actually consume this space then
> it really has to be set aside to prevent hotplug of other bus types
> from trying to claim the same address space for their own usages.
>
> If no actual decoder is setup then it maybe it shouldn't be left as an
> IOW in the resource tree. In this case it might be better to teach the
> io resource allocator to leave gaps for future hotplug.

Yeah, it is the former. These CXL ranges are all actively decoded by
the CPU complex memory controller as "this range goes to DDR and this
other range is interleaved across this set of CXL host bridges". Even
if there is nothing behind those host bridges there is hardware
actively routing requests that fall into those ranges to those
downstream devices.

> > The improvement that offers over this current proposal is that it
> > allows for global visibility of CXL hotplug resources, but it does set
> > up a discontinuity between FW mapped and OS mapped CXL. FW mapped will
> > have top-level "System RAM" resources indistinguishable from typical
> > DRAM while OS mapped CXL will look like this:
>
> Maybe this can be reotractively fixed up in the resource tree?

I had been discouraged to go that route considering some code only
scans top-level iomem_resource entries, but it is probably better to
try to fix that legacy code to operate correctly when System RAM is
parented by a CXL Range.
