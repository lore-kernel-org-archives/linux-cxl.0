Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5F2C77B6E
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 13:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjDNNQz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNNQy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 09:16:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B03A9C
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 06:16:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PycNX0tpxz6JFXG;
        Fri, 14 Apr 2023 21:14:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Apr
 2023 14:16:48 +0100
Date:   Fri, 14 Apr 2023 14:16:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dragan Stancevic <dragan@stancevic.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        <lsf-pc@lists.linux-foundation.org>,
        <nil-migration@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory
Message-ID: <20230414141647.000075a6@Huawei.com>
In-Reply-To: <253e7a73-be3c-44d4-1ca3-d0d060313517@stancevic.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
        <ZDCv3lxLbquITy8M@memverge.com>
        <9d22b56b-80ef-b36f-731b-4b3b588bc4bd@stancevic.com>
        <ZDS8WH+yViVfsuMi@memverge.com>
        <253e7a73-be3c-44d4-1ca3-d0d060313517@stancevic.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 13 Apr 2023 22:32:48 -0500
Dragan Stancevic <dragan@stancevic.com> wrote:

> Hi Gregory-
> 
> 
> On 4/10/23 20:48, Gregory Price wrote:
> > On Mon, Apr 10, 2023 at 07:56:01PM -0500, Dragan Stancevic wrote:  
> >> Hi Gregory-
> >>
> >> On 4/7/23 19:05, Gregory Price wrote:  
> >>> 3. This is changing the semantics of migration from a virtual memory
> >>>      movement to a physical memory movement.  Typically you would expect
> >>>      the RDMA process for live migration to work something like...
> >>>
> >>>      a) migration request arrives
> >>>      b) source host informs destination host of size requirements
> >>>      c) destination host allocations memory and passes a Virtual Address
> >>>         back to source host
> >>>      d) source host initates an RDMA from HostA-VA to HostB-VA
> >>>      e) CPU task is migrated
> >>>
> >>>      Importantly, the allocation of memory by Host B handles the important
> >>>      step of creating HVA->HPA mappings, and the Extended/Nested Page
> >>>      Tables can simply be flushed and re-created after the VM is fully
> >>>      migrated.
> >>>
> >>>      to long didn't read: live migration is a virtual address operation,
> >>>      and node-migration is a PHYSICAL address operation, the virtual
> >>>      addresses remain the same.
> >>>
> >>>      This is problematic, as it's changing the underlying semantics of the
> >>>      migration operation.  
> >>
> >> Those are all valid points, but what if you don't need to recreate HVA->HPA
> >> mappings? If I am understanding the CXL 3.0 spec correctly, then both
> >> virtual addresses and physical addresses wouldn't have to change.

That's implementation defined if we are talking DCD for this.  I would suggest making
it very clear which particular CXL options you are thinking of using.

A CXL 2.0 approach of binding LDs to different switch vPPB (virtual ports) probably doesn't
have this problem, but has it's own limitations and is a much heavier weight thing
to handle.

For DCD if we assuming sharing is used (I'd suggest ignoring other possibilities
for now as there are architectural gaps that I'm not going into and the same
issues will occur with them anyway)... 
Then what you get if you share on multiple LDs presented to multiple hosts is
a set of extents (each is a base + size, any number any size) that have sequence
numbers.

The device may, typically because of fragmentation of the DPA space exposed to
an LD (typically one of those from a device per host) decide to map what was created
in a particular DPA extents pattern (mapped via nice linear decoders into Host PA space)
in a different order and with different size extents.

So in general you can't assume a spec compliant CXL type 3 device (probably a multihead
device in initial deployments) will map anything to an particular location when moving
the memory between hosts.

So ultimately you'd need to translate between:
Page tables on source + DPA extents info.

and

Page table needed on destination to land the parts of the DPA extents (via HDM deoders
applying offsets etc) in the right place in GPA space so the guest gets the right
mapping.

So that will have some complexity and cost associated with it.  Not impossible but
not a simple reuse of tables from source on the destination. 

This is all PA to GPA translation though and in many cases I'd not expect that
to be particularly dynamic - so it's a step before you do any actual migration
hence I'm not sure it matters that might take a bit of maths.


> Because
> >> the fabric "virtualizes" host physical addresses and the translation is done
> >> by the G-FAM/GFD that has the capability to translate multi-host HPAs to
> >> it's internal DPAs. So if you have two hypervisors seeing device physical
> >> address as the same physical address, that might work?
> >>
> >>  
> > 
> > Hm.  I hadn't considered the device side translation (decoders), though
> > that's obviously a tool in the toolbox.  You still have to know how to
> > slide ranges of data (which you mention below).  
> 
> Hmm, do you have any quick thoughts on that?

HDM decoder programming is hard to do in a dynamic fashion (lots of limitations
on what you can do due to ordering restrictions in the spec). I'd ignore it
for this usecase beyond the fact that you get linear offsets from DPA to HPA
that need to be incorporated in your thinking.

> 
> 
> >>> The reference in this case is... the page tables.  You need to know how
> >>> to interpret the data in the CXL memory region on the remote host, and
> >>> that's a "relative page table translation" (to coin a phrase? I'm not
> >>> sure how to best describe it).  
> >>
> >> right, coining phrases... I have been thinking of a "super-page" (for the
> >> lack of a better word) a metadata region sitting on the switched CXL.mem
> >> device that would allow hypervisors to synchronize on various aspects, such
> >> as "relative page table translation", host is up, host is down, list of
> >> peers, who owns what etc... In a perfect scenario, I would love to see the
> >> hypervisors cooperating on switched CXL.mem device the same way cpus on
> >> different numa nodes cooperate on memory in a single hypervisor. If either
> >> host can allocate and schedule from this space then "NIL" aspect of
> >> migration is "free".
> >>
> >>  
> > 
> > The core of the problem is still that each of the hosts has to agree on
> > the location (physically) of this region of memory, which could be
> > problematic unless you have very strong BIOS and/or kernel driver
> > controls to ensure certain devices are guaranteed to be mapped into
> > certain spots in the CFMW.  
> 
> Right, true. The way I am thinking of it is that this would be a part of 
> data-center ops setup which at first pass would be a somewhat of a 
> manual setup same way as other pre-OS related setup. But later on down 
> the road perhaps this could be automated, either through some pre-agreed 
> auto-ranges detection or similar, it's not unusual for dc ops to name 
> hypervisors depending of where in dc/rack/etc they sit etc..
> 

You might be able to constrain particular devices to place nicely with such
a model, but that is out of the scope of the specification and I'd suggest
in Linux at least we'd write the code to deal with the general case then
maybe have a 'fast path' if the stars align.

Jonathan

