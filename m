Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5712AC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Apr 2022 13:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbiDANca convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Apr 2022 09:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiDANc3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Apr 2022 09:32:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1982826ECA0
        for <linux-cxl@vger.kernel.org>; Fri,  1 Apr 2022 06:30:39 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KVLZf3Fxzz67mDY;
        Fri,  1 Apr 2022 21:27:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 1 Apr 2022 15:30:36 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 14:30:35 +0100
Date:   Fri, 1 Apr 2022 14:30:34 +0100
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
        Jongmin Gim <gim.jongmin@samsung.com>
Subject: Re: [PATCH v8 04/46] hw/cxl/device: Introduce a CXL device (8.2.8)
Message-ID: <20220401143034.0000015f@huawei.com>
In-Reply-To: <20220331221319.GA2411@bgt-140510-bm01>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-5-Jonathan.Cameron@huawei.com>
        <CGME20220329181401uscas1p2b229afdbb479a012e140f84367c35ccd@uscas1p2.samsung.com>
        <20220329181353.GA59203@bgt-140510-bm01>
        <20220330184848.000027f7@huawei.com>
        <20220331221319.GA2411@bgt-140510-bm01>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 31 Mar 2022 22:13:20 +0000
Adam Manzanares <a.manzanares@samsung.com> wrote:

> On Wed, Mar 30, 2022 at 06:48:48PM +0100, Jonathan Cameron wrote:
> > On Tue, 29 Mar 2022 18:13:59 +0000
> > Adam Manzanares <a.manzanares@samsung.com> wrote:
> >   
> > > On Fri, Mar 18, 2022 at 03:05:53PM +0000, Jonathan Cameron wrote:  
> > > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > > 
> > > > A CXL device is a type of CXL component. Conceptually, a CXL device
> > > > would be a leaf node in a CXL topology. From an emulation perspective,
> > > > CXL devices are the most complex and so the actual implementation is
> > > > reserved for discrete commits.
> > > > 
> > > > This new device type is specifically catered towards the eventual
> > > > implementation of a Type3 CXL.mem device, 8.2.8.5 in the CXL 2.0
> > > > specification.
> > > > 
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>  
> > 
> > ...
> >   
> > > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > > new file mode 100644
> > > > index 0000000000..b2416e45bf
> > > > --- /dev/null
> > > > +++ b/include/hw/cxl/cxl_device.h
> > > > @@ -0,0 +1,165 @@
> > > > +/*
> > > > + * QEMU CXL Devices
> > > > + *
> > > > + * Copyright (c) 2020 Intel
> > > > + *
> > > > + * This work is licensed under the terms of the GNU GPL, version 2. See the
> > > > + * COPYING file in the top-level directory.
> > > > + */
> > > > +
> > > > +#ifndef CXL_DEVICE_H
> > > > +#define CXL_DEVICE_H
> > > > +
> > > > +#include "hw/register.h"
> > > > +
> > > > +/*
> > > > + * The following is how a CXL device's MMIO space is laid out. The only
> > > > + * requirement from the spec is that the capabilities array and the capability
> > > > + * headers start at offset 0 and are contiguously packed. The headers themselves
> > > > + * provide offsets to the register fields. For this emulation, registers will
> > > > + * start at offset 0x80 (m == 0x80). No secondary mailbox is implemented which
> > > > + * means that n = m + sizeof(mailbox registers) + sizeof(device registers).    
> > > 
> > > What is n here, the start offset of the mailbox registers, this question is 
> > > based on the figure below?  
> > 
> > I'll expand on this to say
> > 
> > means that the offset of the start of the mailbox payload (n) is given by
> > n = m + sizeof....
> > 
> > Which means the diagram below is wrong as should align with top
> > of mailbox registers.
> >   
> > >   
> > > > + *
> > > > + * This is roughly described in 8.2.8 Figure 138 of the CXL 2.0 spec  
> > I'm going drop this comment as that figure appears unrelated to me.
> >   
> > > > + *
> > > > + *                       +---------------------------------+
> > > > + *                       |                                 |
> > > > + *                       |    Memory Device Registers      |
> > > > + *                       |                                 |
> > > > + * n + PAYLOAD_SIZE_MAX  -----------------------------------
> > > > + *                  ^    |                                 |
> > > > + *                  |    |                                 |
> > > > + *                  |    |                                 |
> > > > + *                  |    |                                 |
> > > > + *                  |    |                                 |
> > > > + *                  |    |         Mailbox Payload         |
> > > > + *                  |    |                                 |
> > > > + *                  |    |                                 |
> > > > + *                  |    |                                 |
> > > > + *                  |    -----------------------------------
> > > > + *                  |    |       Mailbox Registers         |
> > > > + *                  |    |                                 |
> > > > + *                  n    -----------------------------------
> > > > + *                  ^    |                                 |
> > > > + *                  |    |        Device Registers         |
> > > > + *                  |    |                                 |
> > > > + *                  m    ---------------------------------->
> > > > + *                  ^    |  Memory Device Capability Header|
> > > > + *                  |    -----------------------------------
> > > > + *                  |    |     Mailbox Capability Header   |
> > > > + *                  |    -------------- --------------------
> > > > + *                  |    |     Device Capability Header    |
> > > > + *                  |    -----------------------------------
> > > > + *                  |    |                                 |
> > > > + *                  |    |                                 |
> > > > + *                  |    |      Device Cap Array[0..n]     |
> > > > + *                  |    |                                 |
> > > > + *                  |    |                                 |
> > > > + *                       |                                 |
> > > > + *                  0    +---------------------------------+    
> > > 
> > > Would it make sense to add CXL cap header register to the diagram?  
> > 
> > Too many similar names in the CXL spec. I'm not sure which one you mean,
> > could you let me have a reference?  If you mean the one that is
> > at the start of the CXL.cache and CXL.mem registers that whole region
> > isn't covered by this diagram and might be in a different BAR.
> > Here we are only dealing with the Memory Device Registers.  I'll
> > add statement to the initial comment block to make that clear
> > as it definitely isn't currently!  
> 
> 
> I was thinking 0 in your figure is the device capabilities array register, 
> which tells us how many capabilites that are in the array. This would be 
> 8.2.8.1. After that comes 8.2.8.2 with n capability header registers which 
> point to the device registers.

Got it.  See below.

> 
> >   
> > > n also 
> > > seems to be the size of the cap array, but it is also an offset so that could
> > > be clarified.  
> > 
> > Ah. Letter reuse. good point. Looking more closely it isn't an array anyway
> > in the diagram (the array would have to include the Device Capability Header
> > and Mailbox Capability headers.  Renamed as simply Device Cap Array Register

As mentioned here, the array is misleading anyway because we have the
actual entries listed directly above it rather than 'inside' the array.
Hence the change described above.

> >   
> > >   
> > > > + *
> > > > + */
> > > > +
> > > > +#define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
> > > > +#define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
> > > > +#define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
> > > > +
> > > > +#define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above */    
> > > 
> > > Is this to plan for future capabilities? If we have CAPS MAX doesn't this 
> > > allow us to remove the slack space. 
I missed replying to this before.

So far CAPS MAX covers everything in the spec. (room for secondary mailbox
+ the 3 we have implemented). 
We don't support migration etc yet (and I'm not sure we ever will)
anyway so I'm not hugely bothered about backwards compatibility.
Hence we can just move things if needed later.

> > >   
> > > > +#define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */    
> > > 
> > > Should we add status to the name here, or would it get too long?
> > >   
> > > > +
> > > > +#define CXL_MAILBOX_REGISTERS_OFFSET \
> > > > +    (CXL_DEVICE_REGISTERS_OFFSET + CXL_DEVICE_REGISTERS_LENGTH)
> > > > +#define CXL_MAILBOX_REGISTERS_SIZE 0x20 /* 8.2.8.4, Figure 139 */
> > > > +#define CXL_MAILBOX_PAYLOAD_SHIFT 11    
> > > 
> > > I see 20 in the spec.  
> > 
> > It's an implementation choice between 8 and 20. For now, this code goes
> > with 11 for no particularly strong reason.  
> 
> Got it.
> 
> >   
> > >   
> > > > +#define CXL_MAILBOX_MAX_PAYLOAD_SIZE (1 << CXL_MAILBOX_PAYLOAD_SHIFT)
> > > > +#define CXL_MAILBOX_REGISTERS_LENGTH \
> > > > +    (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
> > > > +
> > > > +typedef struct cxl_device_state {
> > > > +    MemoryRegion device_registers;
> > > > +
> > > > +    /* mmio for device capabilities array - 8.2.8.2 */
> > > > +    MemoryRegion device;
> > > > +    MemoryRegion caps;
> > > > +
> > > > +    /* mmio for the mailbox registers 8.2.8.4 */
> > > > +    MemoryRegion mailbox;
> > > > +
> > > > +    /* memory region for persistent memory, HDM */
> > > > +    uint64_t pmem_size;    
> > > 
> > > Can we switch this to mem_size and drop the persistent comment? It is my 
> > > understanding that HDM is independent of persistence.  
> > 
> > Discussed in the other branch of this thread.  Short answer is we don't
> > support non persistent yet but it's on the todo list.  What exactly
> > that looks like is to be determined.  One aspect of that is there
> > isn't currently a software stack to test volatile memory.  
> 
> If you can elaborate more here on what is needed to test the volatile memory 
> stack we may be able to help out.

There are a bunch of different ways this could be done - ultimate we probably
want to do all of them.

https://cdrdv2.intel.com/v1/dl/getContent/643805?wapkw=CXL%20memory%20device%20sw%20guide
has some suggestions (though no one is obliged to follow them!) See 2.4

First assumption is that for volatile devices, a common approach will be to do
all the setup in firmware before the OS boots and just present normal SRAT, HMAT
and memory tables as if it were any other memory.  If we want to go that way
for testing purposes then we'd need an open source firmware to implement
setup similar to that done in Linux - probably EDK2.

Of course, volatile memory might be hot added, in which case the OS may be involved.
In that case I think the main missing part would be actually doing the final memory
hotplug event to expose it to the OS + the necessary dynamic updating of the
OS numa description etc. There is work on going to get the information needed
but I think we are still some way off actually tying everything together.

Dan / Ben and team may be able to share more status information.

> 
> >   
> > >   
> > > > +} CXLDeviceState;
> > > > +
> > > > +/* Initialize the register block for a device */
> > > > +void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);

...

> > > +cc Dave, Klaus, Tong
> > > Other than the minor issues raised.
> > > 
> > > Looks good.
> > > 
> > > Reviewed by: Adam Manzanares <a.manzanares@samsung.com>  
> > 
> > Btw I haven't accepted all changes, but have been picking up
> > your RB.  Shout if that's not fine with you.  
> 
> Definitely fine with me and was my intention. Let us know how we can help move
> the work forward. I am kick starting reviewing and will try to bring others in.

Great.  For various reasons I'll not bother mention here (see my employer ;)
I need to keep any discussions on mailing list or in a 'published' form.
So discussion on mailing list + at conferences works best for me but we can
organize some suitably hosted public calls if needed to align plans.
There is a plan for uconf at Plumbers this year which will hopefully let
us do any longer term planning.  Shorter term my aims around QEMU side of things
are:

1) Get the initial support upstream as I'm getting bored of rebasing :)
   I think we are in a fairly good state for doing that once qemu 7.0 is
   out.
2) Improved tests so it doesn't break when no one is paying attention.
3) Expand out the feature set to keep up with what is going on Linux kernel
   wise (personally no other OS of interest, but it would be great if anyone
   wanted to help deal with other operating systems that care).
  * RAS
  * CDAT for switches etc, host table updates for generic port definition
   - What ever else I've missed recently.  When the region code finalizes
     I suspect we'll want to add a load more tests to stress various corners
     of that.
  * Alison may help with partitioning support.
4) Expand features where we have currently taken a short cut such as enabling
   multiple HDM decoders.
5) Use it as a path for testing spec features before publication (obviously can't
   talk about that on list but I've open in appropriate venue about that).

Happy to have help on any of the above, but 'features' that are reasonably separate
such as RAS support might be a good place for contributions that won't be
greatly affected by any other refactoring going on.

I've pushed all but SPDM support and stuff for which the spec isn't public yet up on
https://gitlab.com/jic23/qemu/-/commits/cxl-v9-draft-1
(as you can see CI found a segfault today so I'll push the fix out for that
 shortly - that also highlighted a build breakage mid series that I've fixed up.).

Jonathan

 
> 
> > 
> > Thanks.
> > 
> > Jonathan
> >  

