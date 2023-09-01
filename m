Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CD1CA0FE1
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 09:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjIAJFX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Sep 2023 05:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjIAJFX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Sep 2023 05:05:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74CF91
        for <linux-cxl@vger.kernel.org>; Fri,  1 Sep 2023 02:05:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RcX6v38F3z6FGLT;
        Fri,  1 Sep 2023 17:00:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 10:05:17 +0100
Date:   Fri, 1 Sep 2023 10:05:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>,
        <kwangjin.ko@sk.com>
Subject: Re: [PATCH 3/4] cxl/type3: minimum MHD cci support
Message-ID: <20230901100514.0000074b@Huawei.com>
In-Reply-To: <ZPDG7EKSXmMSAiJa@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
        <20230721163505.1910-4-gregory.price@memverge.com>
        <20230807155609.000055db@Huawei.com>
        <ZPDG7EKSXmMSAiJa@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 31 Aug 2023 12:59:24 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Mon, Aug 07, 2023 at 03:56:09PM +0100, Jonathan Cameron wrote:
> > On Fri, 21 Jul 2023 12:35:08 -0400
> > Gregory Price <gourry.memverge@gmail.com> wrote:
> >   
> > > Implement the MHD GET_INFO cci command and add a shared memory
> > > region to the type3 device to host the information.
> > > 
> > > Add a helper program to initialize this shared memory region.
> > > 
> > > Add a function pointer to type3 devices for future work that
> > > will allow an mhd device to provide a hook to validate whether
> > > a memory access is valid or not.
> > > 
> > > For now, limit the number of LD's to the number of heads. Later,
> > > this limitation will need to be lifted for MH-MLDs.
> > > 
> > > Intended use case:
> > > 
> > > 1. Create the shared memory region
> > > 2. Format the shared memory region
> > > 3. Launch QEMU with `is_mhd=true,mhd_head=N,mhd_shmid=$shmid`  
> > 
> > I'd definitely like some feedback from experienced QEMU folk on
> > how to model this sort of cross QEMU instance sharing.
> > 
> > My instinct is a socket would be more flexible as it lets us
> > potentially emulate the machines on multiple hosts (assuming they
> > can see some shared backend storage).
> >   
> 
> I'd considered a socket, but after mulling it over, I realized the
> operations I was trying to implement amounted to an atomic compare
> and swap.  I wanted to avoid locks and serialization if at all
> possible to avoid introducing that into the hot-path of memory
> accesses.  Maybe there is a known pattern for this kind of
> multi-instance QEMU coherency stuff, but that seemed the simplest path.

I'd definitely like some input from others on this if possible as I've
no idea if this problem has really been tackled in the past.
> 
> This obviously has the downside of limiting emulation of MHD system to
> a local machine, but the use of common files/memory to back CXL memory
> already does that (i think).

Files should be fine I think on a suitable sharing aware file system.

> 
> ¯\_(ツ)_/¯ feedback welcome.  I'll leave it for now unless there are
> strong opinions.
> 
> > else not needed if we returned in previous leg.
> > 
> > 	if (ct3d->is_mhd && ...
> >   
> > > +               (!ct3d->mhd_shmid || (ct3d->mhd_head == ~(0)))) {  
> > 
> > How does mhd_head equal that? Default is 0. I'm not sure there is a reason
> > to require it.
> >   
> 
> Good catch, the default should be ~(0).  Updated in the field
> initialization section.
> 
> > > +    /* For now, limit the number of heads to the number of LD's (SLD) */  
> > 
> > Feels backwards.  Number of heads never going to be bigger than numbre of
> > LDs.  Other way around is possible of course.
> >   
> > > +    if (ct3d->mhd_state->nr_heads <= ct3d->mhd_head) {  
> > 
> > mhd head needs to be out of range?  Confused.
> >   
> 
> Woops, yes this should be mhd_head >= nr_heads. Wording is backwards and
> so is the code.  fixed.
> 
> > > +    if (ct3d->mhd_state) {
> > > +        shmdt(ct3d->mhd_state);
> > > +    }  
> > 
> > Reverse order of realize - so I think this wants to be earlier.
> >   
> > >  }  
> 
> Just to be clear you *don't* want the reverse order, correct?  If so
> i'll swap it.

I do want reverse order.   Generally speaking it's much easier to
review precisely matching reverse order as then mostly the ordering is
fine in a way that it isn't in any other ordering.

> 
> > >  
> > > +    if (ct3d->is_mhd && ct3d->mhd_access_valid) {
> > > +        if (!ct3d->mhd_access_valid(ct3d, dpa_offset, size))
> > > +            return MEMTX_ERROR;  
> > 
> > Brackets for inner block.
> > Arguably could just add the ct3d->is_mhd check in the place where
> > mhd_access_valid is set and hence only need to check that here.
> > Maybe that makes it slightly harder to follow though.
> > 
> > Also could just unset is_mhd if mhd_access_valid not present..
> >  
> 
> I'm going to change the next patch to fully inherit CXLType3Dev into
> Niagara as you suggested.  I will have to see what falls out when i do
> that, but my feeling was being more explicit when checking pointers is
> better.  If you prefer to to drop the is_mhd check i'm ok with that
> simply because mhd_access_valid should always be NULL when is_mhd is
> false.  Either way the result is the same.

Minimizing redundant checks is always good as long as a reviewer can
easily see they are redundant. I think that's true here.

Jonathan

> 
> ~Gregory

