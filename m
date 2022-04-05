Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B931C43217
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Apr 2022 09:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiDEJyw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345325AbiDEJW0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Apr 2022 05:22:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6F427EA
        for <linux-cxl@vger.kernel.org>; Tue,  5 Apr 2022 02:10:27 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXhcM3vlKz67hFv;
        Tue,  5 Apr 2022 17:07:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 5 Apr 2022 11:10:25 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 10:10:24 +0100
Date:   Tue, 5 Apr 2022 10:10:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-D?= =?ISO-8859-1?Q?aud=E9?= 
        <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Tong Zhang <t.zhang2@samsung.com>,
        "k.jensen@samsung.com" <k.jensen@samsung.com>,
        Heekwon Park <heekwon.p@samsung.com>,
        Jaemin Jung <j.jaemin@samsung.com>,
        Jongmin Gim <gim.jongmin@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v8 04/46] hw/cxl/device: Introduce a CXL device (8.2.8)
Message-ID: <20220405101022.00003f06@huawei.com>
In-Reply-To: <20220404151500.GA57759@bgt-140510-bm01>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-5-Jonathan.Cameron@huawei.com>
        <CGME20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd@uscas1p2.samsung.com>
        <20220329181353.GA59203@bgt-140510-bm01>
        <20220330184848.000027f7@huawei.com>
        <20220331221319.GA2411@bgt-140510-bm01>
        <20220401143034.0000015f@huawei.com>
        <20220404151500.GA57759@bgt-140510-bm01>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

...

> > > > > 
> > > > > Can we switch this to mem_size and drop the persistent comment? It is my 
> > > > > understanding that HDM is independent of persistence.    
> > > > 
> > > > Discussed in the other branch of this thread.  Short answer is we don't
> > > > support non persistent yet but it's on the todo list.  What exactly
> > > > that looks like is to be determined.  One aspect of that is there
> > > > isn't currently a software stack to test volatile memory.    
> > > 
> > > If you can elaborate more here on what is needed to test the volatile memory 
> > > stack we may be able to help out.  
> > 
> > There are a bunch of different ways this could be done - ultimate we probably
> > want to do all of them.
> > 
> > https://urldefense.com/v3/__https://cdrdv2.intel.com/v1/dl/getContent/643805?wapkw=CXL*20memory*20device*20sw*20guide__;JSUlJQ!!EwVzqGoTKBqv-0DWAJBm!HzD_Dh_I9m9MydppOSSyhuzvwTawlg7LE77bEYiZ1i3AMgxV_YOI56VeZgkg-KuX7XMA$ 
> > has some suggestions (though no one is obliged to follow them!) See 2.4
> > 
> > First assumption is that for volatile devices, a common approach will be to do
> > all the setup in firmware before the OS boots and just present normal SRAT, HMAT
> > and memory tables as if it were any other memory.  If we want to go that way
> > for testing purposes then we'd need an open source firmware to implement
> > setup similar to that done in Linux - probably EDK2.
> > 
> > Of course, volatile memory might be hot added, in which case the OS may be involved.
> > In that case I think the main missing part would be actually doing the final memory
> > hotplug event to expose it to the OS + the necessary dynamic updating of the
> > OS numa description etc. There is work on going to get the information needed
> > but I think we are still some way off actually tying everything together.
> > 
> > Dan / Ben and team may be able to share more status information.  
> 
> Great, thanks for all of the information. We will start planning out our next
> steps. I'll add Luis on cc since he has chatted with me about setting up a 
> test framework for the CXL kernel code that will rely on QEMU.
> 
> >   
> > >   
> > > >     
> > > > >     
> > > > > > +} CXLDeviceState;
> > > > > > +
> > > > > > +/* Initialize the register block for a device */
> > > > > > +void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);  
> > 
> > ...
> >   
> > > > > +cc Dave, Klaus, Tong
> > > > > Other than the minor issues raised.
> > > > > 
> > > > > Looks good.
> > > > > 
> > > > > Reviewed by: Adam Manzanares <a.manzanares@samsung.com>    
> > > > 
> > > > Btw I haven't accepted all changes, but have been picking up
> > > > your RB.  Shout if that's not fine with you.    
> > > 
> > > Definitely fine with me and was my intention. Let us know how we can help move
> > > the work forward. I am kick starting reviewing and will try to bring others in.  
> > 
> > Great.  For various reasons I'll not bother mention here (see my employer ;)
> > I need to keep any discussions on mailing list or in a 'published' form.
> > So discussion on mailing list + at conferences works best for me but we can
> > organize some suitably hosted public calls if needed to align plans.
> > There is a plan for uconf at Plumbers this year which will hopefully let  
> 
> We would also prefer to keep discussions in the public domain. We have plans to
> attend Plumbers this year, so we look forward to discussing in person. 

Excellent.  If it's useful to have a public discussion before plumbers then the nice
folk at Linaro have been kind enough to host similar discussion in the
past (and deal with posting recordings etc afterwards for those who missed
the live call) and I expect they'd help us out again (Hi Alex ;)

> 
> > us do any longer term planning.  Shorter term my aims around QEMU side of things
> > are:
> > 
> > 1) Get the initial support upstream as I'm getting bored of rebasing :)
> >    I think we are in a fairly good state for doing that once qemu 7.0 is
> >    out.
> > 2) Improved tests so it doesn't break when no one is paying attention.  
> 
> Luis may have some thoughts here. 

Excellent. A testing expert is always useful. It would be nice to think about
getting something beyond a basic 'does it boot' test into the qemu CI but
I've not really looked into how one might do that.

> 
> > 3) Expand out the feature set to keep up with what is going on Linux kernel
> >    wise (personally no other OS of interest, but it would be great if anyone
> >    wanted to help deal with other operating systems that care).
> >   * RAS
> >   * CDAT for switches etc, host table updates for generic port definition
> >    - What ever else I've missed recently.  When the region code finalizes
> >      I suspect we'll want to add a load more tests to stress various corners
> >      of that.
> >   * Alison may help with partitioning support.
> > 4) Expand features where we have currently taken a short cut such as enabling
> >    multiple HDM decoders.
> > 5) Use it as a path for testing spec features before publication (obviously can't
> >    talk about that on list but I've open in appropriate venue about that).
> > 
> > Happy to have help on any of the above, but 'features' that are reasonably separate
> > such as RAS support might be a good place for contributions that won't be
> > greatly affected by any other refactoring going on.
> > 
> > I've pushed all but SPDM support and stuff for which the spec isn't public yet up on
> > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/commits/cxl-v9-draft-1__;!!EwVzqGoTKBqv-0DWAJBm!HzD_Dh_I9m9MydppOSSyhuzvwTawlg7LE77bEYiZ1i3AMgxV_YOI56VeZgkg-EMwmPTV$ 
> > (as you can see CI found a segfault today so I'll push the fix out for that
> >  shortly - that also highlighted a build breakage mid series that I've fixed up.).
> >   
> 
> Once again thanks for all of the pointers. 

You are welcome. It's nice to see this work gain traction :)

Anyhow, v9 is on it's way (slowly) through our firewall (got log anti spam
send rate limits) so fingers crossed we are nearly ready with this first bit
of support to build more fun stuff on top of.

Jonathan

> 
> > Jonathan


