Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C631C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 09:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiLPJcO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 04:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLPJbu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 04:31:50 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B52125E
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 01:31:42 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NYP075TFMz6HJW1;
        Fri, 16 Dec 2022 17:27:51 +0800 (CST)
Received: from localhost (10.45.152.125) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Dec
 2022 09:31:39 +0000
Date:   Fri, 16 Dec 2022 09:31:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] hw/cxl/device: Add Flex Bus Port DVSEC
Message-ID: <20221216093136.000026c3@Huawei.com>
In-Reply-To: <Y5tZPiiJQm4el40t@iweiny-desk3>
References: <20221213-ira-flexbus-port-v2-1-eaa48d0e0700@intel.com>
        <20221215171633.00000ac8@Huawei.com>
        <Y5tZPiiJQm4el40t@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.152.125]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 15 Dec 2022 09:28:30 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Dec 15, 2022 at 05:16:33PM +0000, Jonathan Cameron wrote:
> > On Wed, 14 Dec 2022 12:54:11 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > The Flex Bus Port DVSEC was missing on type 3 devices which was blocking
> > > RAS checks.[1]
> > > 
> > > Add the Flex Bus Port DVSEC to type 3 devices as per CXL 3.0 8.2.1.3.
> > > 
> > > [1] https://lore.kernel.org/linux-cxl/167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com/
> > > 
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Ben Widawsky <bwidawsk@kernel.org>
> > > Cc: qemu-devel@nongnu.org
> > > Cc: linux-cxl@vger.kernel.org
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > Looks good to me.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > As Michael wasn't cc'd on patch posting, so might not get this directly I'll add
> > it to the front of the series adding the RAS event emulation on basis that's the
> > first time we'll see a failure in Linux (I think?)  
> 
> Ah thanks!
> 
> Sorry, I thought you were the 'maintainer' of the CXL stuff for qemu.

Ah I am, but so far the CXL stuff has routed through Michael as PCI maintainer
because of the high level of overlap. So far I've done that by grouping up
patches and send them in sets to Michael. This one is more of a fix, so maybe
wants to move quicker than I will.

This gives me a good opportunity to ask Michael:

How do you want us to handle this in future? I'd expect the overlap with the PCI
core stuff to reduce going forwards, as most of the infrastructure is now in
place and obviously would want you to look at anything that does touch core PCI
code, but for the rest of it, would you prefer that I send pull requests going
forwards?  I'm more than happy to keep dumping this stuff on you, but seems
rather mean!

If we do move to pull requests, what scope of stuff do you want us to seek your
review on?  If things go according to plan there will be a bunch of stuff related
to the switch ports in the near future, some of which is going to add complex
PCI topologies and new forms of hotplug so I'll definitely want your input on
that, but we also have a bunch of stuff around memory error reporting etc which
I'm thinking may be of less interest to you. Obviously I'd love it if you have
time to review everything but don't want to impose unnecessarily.

Jonathan


> 
> > 
> > Michael, if you want to pick this up directly that's great too!  
> 
> Should I send directly to Michael in future?
> 
> > 
> > As a side note the WTF? is because we made up a hardware related time delay
> > number having no idea whatsoever on what a realistic value was. Cut and paste
> > from the instances of this structure in the root port and the switch ports.
> >   
> 
> Yep I just followed that based off the other code.
> 
> Ira
> 
> > Jonathan
> > 
> > 
> >   
> > > ---
> > > Changes in v2:
> > >         Jonathan                                                            
> > >                 type 3 device does not support CACHE                        
> > >                 Comment the 68B bit                                         
> > > 
> > > - Link to v1: https://lore.kernel.org/r/20221213-ira-flexbus-port-v1-1-86afd4f30be6@intel.com
> > > ---
> > >  hw/mem/cxl_type3.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index 0317bd96a6fb..e6beac143fc1 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -416,6 +416,17 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> > >      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> > >                                 GPF_DEVICE_DVSEC_LENGTH, GPF_DEVICE_DVSEC,
> > >                                 GPF_DEVICE_DVSEC_REVID, dvsec);
> > > +
> > > +    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> > > +        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
> > > +        .ctrl                    = 0x02, /* IO always enabled */
> > > +        .status                  = 0x26, /* same as capabilities */
> > > +        .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
> > > +    };
> > > +    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> > > +                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
> > > +                               PCIE_FLEXBUS_PORT_DVSEC,
> > > +                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
> > >  }
> > >  
> > >  static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
> > > 
> > > ---
> > > base-commit: e11b57108b0cb746bb9f3887054f34a2f818ed79
> > > change-id: 20221213-ira-flexbus-port-ce526de8111d
> > > 
> > > Best regards,  
> >   

