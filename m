Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5243CECAAA1
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Oct 2022 10:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiJ0K7X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Oct 2022 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiJ0K7R (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Oct 2022 06:59:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512B794108
        for <linux-cxl@vger.kernel.org>; Thu, 27 Oct 2022 03:59:14 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MyjLw6Nrvz6HJPp;
        Thu, 27 Oct 2022 18:57:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 12:59:11 +0200
Received: from localhost (10.48.135.72) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 11:59:08 +0100
Date:   Thu, 27 Oct 2022 11:58:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Adam Manzanares <a.manzanares@samsung.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "ani@anisinha.ca" <ani@anisinha.ca>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for CXL
 Type-3 Devices
Message-ID: <20221027115854.00001f76@huawei.com>
In-Reply-To: <Y1mc1mvxsGS+7JBp@memverge.com>
References: <CGME20221026004835uscas1p1d37255ba8daaba8fc7e16e5129cb94b5@uscas1p1.samsung.com>
        <20221026004737.3646-1-gregory.price@memverge.com>
        <20221026201318.GA308524@bgt-140510-bm01>
        <Y1mc1mvxsGS+7JBp@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.135.72]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 26 Oct 2022 16:47:18 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Wed, Oct 26, 2022 at 08:13:24PM +0000, Adam Manzanares wrote:
> > On Tue, Oct 25, 2022 at 08:47:33PM -0400, Gregory Price wrote:  
> > > Submitted as an extention to the multi-feature branch maintained
> > > by Jonathan Cameron at:
> > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-2022-10-24__;!!EwVzqGoTKBqv-0DWAJBm!RyiGL5B1XmQnVFwgxikKJeosPMKtoO1cTr61gIq8fwqfju8l4cbGZGwAEkKXIJB-Dbkfi_LNN2rGCbzMISz65cTxpAxI9pQ$   
> > > 
> > > 
> > > Summary of Changes:
> > > 1) E820 CFMW Bug fix.  
> > > 2) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
> > > 3) Multi-Region and Volatile Memory support for CXL Type-3 Devices
> > > 4) CXL Type-3 SRAT Generation when NUMA node is attached to memdev

+CC Dan for a question on status of Generic Ports ACPI code first ECN.
Given that was done on the mailing list I can find any public tracking
of whether it was accepted or not - hence whether we can get on with
implementation.  There hasn't been a release ACPI spec since before
that was proposed so we need that confirmation of the code first proposal
being accepted to get things moving.

> > > 
> > > 
> > > Regarding the E820 fix
> > >   * This bugfix is required for memory regions to work on x86
> > >   * input from Dan Williams and others suggest that E820 entry for
> > >     the CFMW should not exist, as it is expected to be dynamically
> > >     assigned at runtime.  If this entry exists, it instead blocks
> > >     region creation by nature of the memory region being marked as
> > >     reserved.  
> > 
> > For CXL 2.0 it is my understanding that volatile capacity present at boot will
> > be advertised by the firmware. In the absence of EFI I would assume this would
> > be provided in the e820 map.   

Whilst this is one option, it is certainly not the case that all CXL 2.0
platforms will decide to do any setup of CXL memory (volatile or not) in the
firmware.  They can leave it entirely to the OS, so a cold plug flow.
Early platforms will do the setup in BIOS to support unware OSes, once
that's not a problem any more the only reason you'd want to do this is if
you don't have other RAM to boot the system, or for some reason you want
your host kernel etc in the CXL attached memory.

I'd expect to see BIOS having OS managed configuration as an option in the
intermediate period where some OSes are aware, others not.
OS knows more about usecase / policy so can make better choices on interleaving
etc of volatile CXL type 3 memory (let alone the fun corner of devices
where you can dynamically change the mix of volatile and non volatile
memory).


> 
> The issue in this case is very explicitly that a double-mapping occurs
> for the same region.  An E820 mapping for RESERVED is set *and* the
> region driver allocates a CXL CFMW mapping.  As a result the region
> drive straight up fails to allocate regions.
> 
> So in either case - at least from my view - the entry added as RESERVED
> is just wrong.
> 
> This is separate from type-3 device SRAT entries and default mappings
> for volatile regions.  For this situation, if you explicitly assign the
> memdev backing a type-3 device to a numa node, then an SRAT area is
> generated and an explicit e820 entry is generated and marked usable -
> though I think there are likely issues with this kind of
> double-referencing.

SRAT setup for CXL type 3 devices is to my mind is a job for a full BIOS,
not QEMU level of faking a few things. That BIOS should also
be doing the full configuration (HDM Decoders and all the rest).  ARM has
a prototype for one of the fixed virtual platforms that does this (talk
at Plumbers Uconf), we should look to do the same if we want to test
those flows using QEMU via appropriate changes in EDK2 to walk topology
and configure everything.  Until the devices are configured there is no
way to configure the SLIT, HMAT entries that align with the SRAT ones
(in theory those can be updated at runtime via _SLI, _HMA but in 
practice, I'm fairly sure Linux doesn't support doing that.)


> 
> > 
> > Is the region driver meant to cover volatile capacity present at boot? I was
> > under the impression that it would be used for hot added volatile memory. It
> > would be good to cover all of these assumptions for the e820 fix.  
> 
> This region appears to cover hotplug memory behind the CFMW.  The
> problem is that this e820 RESERVED mapping blocks the CFMW region from
> being used at all.
> 
> Without this, you can't use a type-3 persistent region, even with
> support, let alone a volatile region.  In attempting to use a persistent
> region as volatile via ndctl and friends, I'm seeing further issues (it
> cannot be assigned to a numa node successfully), but that's a separate
> issue.
For the Numa node bit...

So far, the CDAT table isn't used in Linux (read out for debug purposes
is supported only).  That all needs to be added yet to get the NUMA node
allocations to work correctly.  It shouldn't have anything to do with SRAT
unless the BIOS has done the full full configuration (same way CXL will work
with a legacy OS).  Come to think of it, that should definitely be on the
priority list for kernel support (don't think it was on the list on Tuesday?)

> 
> > 
> > Lastly it is my understanding that the region driver does not have support for
> > volatile memory. It would be great to add that functionality if we make this
> > change in QEMU.
> >   
> 
> Right now this is true, but it seems a bit of a chicken/egg scenario.
> Nothing to test against vs no support.  Nudging this along such that we
> can at least report an (unusable) hot-add volatile memory region would
> provide someone working with the region driver something to poke and
> prod at.

Agreed. This is same place as Ben's original CXL QEMU work on non volatile.
Need something to develop against so we'll at least have QEMU patches
available whilst the kernel side is in development (hopefully this cycle)
> 
> > > Regarding SRAT Generation for Type-3 Devices
> > >   * Co-Developed by Davidlohr Bueso.  Built from his base patch and
> > >     extended to work with both volatile and persistent regions.
> > >   * This can be used to demonstrate static type-3 device mapping and
> > >     testing numa-access to type-3 device memory regions.  
> 
> Regarding "volatile memory present at boot" - there is still two ways
> for that memory to be onlined: Statically (entered as an explicit e820
> region after reading the SRAT), or Dynamically (hot-add by the region
> driver).
> 
> This patch would at least allow an SRAT to be generated if you
> explicitly add a NUMA node mapping to it.  Although I concede that I'm
> not entirely sure what is "correct" here.

For hotplug, needs to be the region driver, not here (or BIOS if you
are doing a BIOS driven flow - in which case the whole topology is
discovered and mostly configured by the BIOS before the OS reaches it
- including filling in SRAT, SLIT, HMAT etCc).
> 
> What this ends up looking like is mapping a memdev to both a numa node
> and to a type-3 device.  Though that seems wrong.
> 
> After further testing it seems like creating a CPU-less, Memory-less
> NUMA node with the intent of mapping volatile memory regions to it is
> not supported (yet?).

Yup, and I doubt it ever will be for reasons above. 

BIOS does it all, or OS does it all.  Mixing and matching is a mess
(there is an exception - Generic Port entries in SRAT - those we do
need for the OS driven flow and possibly also the BIOS flow
- patches welcome! I'd forgotten that on my list of QEMU stuff that
needs doing.)

https://lore.kernel.org/all/e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com/

If anyone is implementing that, also good to do Generic Initiators
as they are very similar.

Jonathan
 

