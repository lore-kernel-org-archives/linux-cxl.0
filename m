Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06BFC77B7A
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Jun 2023 15:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbjFGPMw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Jun 2023 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239756AbjFGPMq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Jun 2023 11:12:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262031734
        for <linux-cxl@vger.kernel.org>; Wed,  7 Jun 2023 08:12:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbrPW3Nvrz67mZc;
        Wed,  7 Jun 2023 23:10:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 7 Jun
 2023 16:12:24 +0100
Date:   Wed, 7 Jun 2023 16:12:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vikram Sethi <vsethi@nvidia.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: Questions about CXL device (type 3 memory) hotplug
Message-ID: <20230607161224.00004795@Huawei.com>
In-Reply-To: <BYAPR12MB3336E224E4B3DD50ABDA04B6BD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
        <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
        <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
        <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
        <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
        <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
        <BN8PR12MB3330831F2E666E9BB1319E66BD419@BN8PR12MB3330.namprd12.prod.outlook.com>
        <646e7f96f33e2_33fb3294c1@dwillia2-xfh.jf.intel.com.notmuch>
        <BYAPR12MB3336F5ADDEDBB6245BC2B48DBD489@BYAPR12MB3336.namprd12.prod.outlook.com>
        <647f9d082eb30_142af82944e@dwillia2-xfh.jf.intel.com.notmuch>
        <BYAPR12MB3336E224E4B3DD50ABDA04B6BD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 7 Jun 2023 01:06:05 +0000
Vikram Sethi <vsethi@nvidia.com> wrote:

> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Tuesday, June 6, 2023 3:55 PM
> > To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> > <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu)
> > <y-goto@fujitsu.com>; linux-cxl@vger.kernel.org;
> > catalin.marinas@arm.com; James Morse <james.morse@arm.com>
> > Cc: Natu, Mahesh <mahesh.natu@intel.com>
> > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > Vikram Sethi wrote:  
> > > Hi Dan,
> > > Apologies for the delayed response, was out for a few days.
> > >  
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > > Sent: Wednesday, May 24, 2023 4:20 PM
> > > > To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> > > > <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu)
> > > > <y-goto@fujitsu.com>; linux-cxl@vger.kernel.org;
> > > > catalin.marinas@arm.com; James Morse <james.morse@arm.com>
> > > > Cc: Natu, Mahesh <mahesh.natu@intel.com>
> > > > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > > > Vikram Sethi wrote:
> > > > [..]  
> > > > > > I don't understand this failure mode. Accelerator is added,
> > > > > > driver sets up an HDM decode range and triggers CPU cache
> > > > > > invalidation before mapping the memory into page tables.
> > > > > > Wouldn't the device, upon receiving an invalidation request,
> > > > > > just snoop its caches and say  
> > > > "nothing for me to do"?  
> > > > >
> > > > > Device's snoop filter is in a clean reset/power on state. It
> > > > > is not tracking anything checked out by the host CPU/peer.
> > > > > If it starts receiving writebacks or even CleanEvicts for its
> > > > > memory,  
> > > >
> > > > CleanEvict is a device-to-host request. We are talking about
> > > > host-to-device requests which is only SnpData, SnpInv, and
> > > > SnpCur,  
> > right?  
> > > >  
> > > I was referring to MemClnEvct which is a Host request to device
> > > (M2S req) as captured in table C-3 of the latest specification  
> > 
> > Ok, thanks for that clarification.
> >   
> > >  
> > > > > looks like an unexpected coherency message and i Know of at
> > > > > least one implementation that triggers an error interrupt in
> > > > > response. I don't know of a statement In the specification
> > > > > that this is expected and implementations should ignore. If
> > > > > there is such a statement, could you please point me to it?  
> > > >
> > > > All the specification says (CXL 3.0 3.2.4.4 Host to Device
> > > > Requests) is what to do *if* the device is holding that
> > > > cacheline.
> > > >
> > > > If a device fails when it gets one of those requests when it
> > > > does not hold a line then how can this work in the nominal case
> > > > of the device not owning any random cacheline?  
> > >
> > > I didn't understand. The line in question is owned by the device
> > > (it is device memory). The device has just been CXL reset or
> > > powered up and its snoop filter isn't tracking ANY of its lines
> > > as checked out by the host. The host tells the device it is
> > > dropping a line that the host had checked out (MemClnEvct) but
> > > per the device the host never checked anything out. Seems
> > > perfectly reasonable for the device to think it is an incorrect
> > > coherency message and flag an error. What is the nominal case
> > > that you think is broken?  
> > 
> > The case I was considering was a broadcast / anonymous invalidation
> > event, but now I see that MemClnEvct implies that the line was
> > previously in the Shared / Exclusive state, so now I see your
> > point. The host will not send MemClnEvct in the scenario I was
> > envisioning. 
> > > >  
> > > > > Remove memory needs a cache flush IMO, in a way that prevents
> > > > > speculative fetches.  This can be done in kernel with
> > > > > uncacheable mappings alone, if possible in the arch callback,
> > > > > or via FW call.  
> > > >
> > > > That assumes that the kernel owns all mappings. I worry about
> > > > mappings that the kernel cannot see like x86 SMM. That's why
> > > > it's currently an invalidate before next usage, but I am not
> > > > opposed to also flushing on remove if the current solution is
> > > > causing device-failures in  
> > practice.  
> > > >
> > > > Can you confirm that the current kernel arrangement is causing
> > > > failures in practice, or is this a theoretical concern? ...and
> > > > if it is happening in practice do you have the example patch
> > > > that fixes it?  
> > > Yes, it is causing error interrupts from the device around device
> > > reset if the host caches are not flushed before the reset.  It is
> > > currently being worked around via ACPI magic for the cache flush
> > > then reset, but kernel aware handling of the flush seems more
> > > appropriate for both hot plug and CXL reset (whether via direct
> > > flush or via FW calls from arch callbacks).  
> > 
> > Makes sense, and yikes "ACPI magic". My concern though as you note
> > above is the cache line immediately going back to the "Shared"
> > state from speculation before the HDM decoder space is shutdown. It
> > seems it would only be safe to invalidate sometime *after* all of
> > the page tables and HDM decode has been torn down, and suppress any
> > errors that result from unaccepted writes.  
> 
> I agree regarding cache flush after page table mappings removed, but
> not sure that HDM decode tear down is a requirement to prevent
> speculation. Are there architectures that can speculate to arbitrary
> PA without any PTE mappings to those PA? Would
> cxl_region_decode_reset be guaranteed to not have any page table
> mappings to the region and be a suitable place to also flush for a
> CXL reset type scenario?
> > 
> > I.e. would something like this solve the immediate problem? Or does
> > the architecture need to have the address range mapped into tables
> > and decode operational for the flush to succeed?  
> 

> The specific implementation does not require page table mappings to
> flush caches. I'm not sure that simply suppressing error interrupts
> for any writebacks or MemCleanEvict that happen after a device
> insertion/reset is good enough as devices could view that as a
> coherency error. 

If on an architecture that guarantees no clean write backs (or at least none
if they are ever visible - which should include this case) shouldn't be
a problem.

So who wants to point an laugh at anyone that does clean write backs that
can be observed?
:)

Even on archs that do allow for such write backs, I believe they are
not common as otherwise perf would be terrible: so just let the errors
through - they are flagging errors in PAs that aren't mapped so should
just generate a small amount of noise in the logs.

So flush before to make clean (or invalid but then potentially prefetched
so clean) - tear down the HDM decoders and flush again / invalidate so
nothing stale hanging around (or do it before bringing something new
up at that Host PA). Eat or log any errors and don't worry about it.

Maybe I'm missing some corners cases.

Jonathan

> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 543c4499379e..60d1b5ecf936 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -187,6 +187,15 @@ static int cxl_region_decode_commit(struct
> > cxl_region *cxlr)
> >         struct cxl_region_params *p = &cxlr->params;
> >         int i, rc = 0;
> > 
> > +       /*
> > +        * Before the new region goes active, and while the
> > physical address
> > +        * range is not mapped in any page tables invalidate any
> > previous cached
> > +        * lines in this physical address range.
> > +        */
> > +       rc = cxl_region_invalidate_memregion(cxlr);
> > +       if (rc)
> > +               return rc;
> > +
> >         for (i = 0; i < p->nr_targets; i++) {
> >                 struct cxl_endpoint_decoder *cxled = p->targets[i];
> >                 struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > @@ -3158,8 +3167,6 @@ static int cxl_region_probe(struct device
> > *dev) goto out;
> >         }
> > 
> > -       rc = cxl_region_invalidate_memregion(cxlr);
> > -
> >         /*
> >          * From this point on any path that changes the region's
> > state away from
> >          * CXL_CONFIG_COMMIT is also responsible for releasing the
> > driver. 
> 

