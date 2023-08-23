Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C12C3DA6F
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Aug 2023 16:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjHWQ7Q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHWQ7P (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Aug 2023 12:59:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BA2E68
        for <linux-cxl@vger.kernel.org>; Wed, 23 Aug 2023 09:59:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RWC4k1FDMz67XMQ;
        Thu, 24 Aug 2023 00:55:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 17:59:11 +0100
Date:   Wed, 23 Aug 2023 17:59:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shreyas Shah <shreyas.shah@elastics.cloud>
CC:     Maverickk 78 <maverickk1778@gmail.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: CXL volatile memory is not listed
Message-ID: <20230823175910.00001b81@Huawei.com>
In-Reply-To: <IA1PR12MB6236E18350FFCB8916E32E86E81BA@IA1PR12MB6236.namprd12.prod.outlook.com>
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
        <20230810113512.00000516@Huawei.com>
        <CALfBBTud4Y7qxKB8nkZ5Lo5sQs-7-F9Rkso+iQGvLO07VyRcDA@mail.gmail.com>
        <20230811145458.000029c7@Huawei.com>
        <CALfBBTsMLP8_eTfmFt5mB+ywF1D0WTR7m=PBqUVzhhvcwC+zYA@mail.gmail.com>
        <IA1PR12MB6236E18350FFCB8916E32E86E81BA@IA1PR12MB6236.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 18 Aug 2023 11:30:55 +0000
Shreyas Shah <shreyas.shah@elastics.cloud> wrote:

> Once the cxl memory is online, how does Operating system know whether to malloc in the cxl memory or socket attached DDR memory?

If you've brought the memory up as 'normal memory' via kmem rather than the other dax options
then it'll be a separate NUMA node.  Hence you can control allocations using same tools
used on multiple numa node systems.

Jonathan

> 
> 
> 
> [https://static1.squarespace.com/static/60dbbd6d597c966b91a3b27b/t/6104415e6177af1589fb05e4/1627668830393/elastics-cloud-logo-120.png]<https://www.elastics.cloud/>
> Shreyas Shah
> Founder, CTO and Chief Scientist, Elastics.cloud, Inc.
> 1730 North First Street, 5th Floor, San Jose, CA 95112
> t: 408 476 3100<tel:408%20476%203100> | e: email: shreyas.shah@elastics.cloud
> 
> ________________________________
> From: Maverickk 78 <maverickk1778@gmail.com>
> Sent: Thursday, August 17, 2023 10:18 PM
> To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Cameron via <qemu-devel@nongnu.org>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>
> Subject: Re: CXL volatile memory is not listed
> 
> Hi Jonathan,
> 
> The use case of CXL switch will always need some sort of management
> agent + FM configuring the available CXL memory connected.
> 
> In most cases it would be bmc controller configuring MLD/MHD's to
> host, and in very rare scenarios it may be one of the host interacting
> with FM firmware inside the switch which would do the trick.
> 
> Another use case is static hardcoding between CXL memory & host in
> built in cxl switch
> 
> There is no scenario where one of the host BIOS can push the select
> CXL memory to itself.
> 
> 
> Is my understanding correct?
> 
> 
> 
> On Fri, 11 Aug 2023 at 19:25, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 11 Aug 2023 08:04:26 +0530
> > Maverickk 78 <maverickk1778@gmail.com> wrote:
> >  
> > > Jonathan,
> > >  
> > > > More generally for the flow that would bring the memory up as system ram
> > > > you would typically need the bios to have done the CXL enumeration or
> > > > a bunch of scripts in the kernel to have done it.  In general it can't
> > > > be fully automated, because there are policy decisions to make on things like
> > > > interleaving.  
> > >
> > > BIOS CXL enumeration? is CEDT not enough? or BIOS further needs to
> > > create an entry
> > > in the e820 table?  
> > On intel platforms 'maybe' :)  I know how it works on those that just
> > use the nice standard EFI tables - less familiar with the e820 stuff :)
> >
> > CEDT says where to find the the various bits of system related CXL stuff.
> > Nothing in there on the configuration that should be used such as interleaving
> > as that depends on what the administrator wants. Or on what the BIOS has
> > decided the users should have.
> >  
> > >  
> > > >
> > > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > > to rely on the same kernel paths as for persistent memory - manual configuration
> > > > etc in the kernel.
> > > >  
> > > Manual works with "cxl create regiton"  :)  
> > Great.
> >
> > Jonathan
> >  
> > >
> > > On Thu, 10 Aug 2023 at 16:05, Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > On Wed, 9 Aug 2023 04:21:47 +0530
> > > > Maverickk 78 <maverickk1778@gmail.com> wrote:
> > > >  
> > > > > Hello,
> > > > >
> > > > > I am running qemu-system-x86_64
> > > > >
> > > > > qemu-system-x86_64 --version
> > > > > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> > > > >  
> > > > +Cc linux-cxl as the answer is more todo with linux than qemu.
> > > >  
> > > > > qemu-system-x86_64 \
> > > > > -m 2G,slots=4,maxmem=4G \
> > > > > -smp 4 \
> > > > > -machine type=q35,accel=kvm,cxl=on \
> > > > > -enable-kvm \
> > > > > -nographic \
> > > > > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > > > > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > > > > -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
> > > > > -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> > > > > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G  
> > > >
> > > > There are some problems upstream at the moment (probably not cxl related but
> > > > I'm digging). So today I can't boot an x86 machine. (goody)
> > > >
> > > >
> > > > More generally for the flow that would bring the memory up as system ram
> > > > you would typically need the bios to have done the CXL enumeration or
> > > > a bunch of scripts in the kernel to have done it.  In general it can't
> > > > be fully automated, because there are policy decisions to make on things like
> > > > interleaving.
> > > >
> > > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > > to rely on the same kernel paths as for persistent memory - manual configuration
> > > > etc in the kernel.
> > > >
> > > > There is support in ndctl for those enabling flows, so I'd look there
> > > > for more information
> > > >
> > > > Jonathan
> > > >
> > > >  
> > > > >
> > > > >
> > > > > I was expecting the CXL memory to be listed in "System Ram", the lsmem
> > > > > shows only 2G memory which is System RAM, it's not listing the CXL
> > > > > memory.
> > > > >
> > > > > Do I need to pass any particular parameter in the kernel command line?
> > > > >
> > > > > Is there any documentation available? I followed the inputs provided in
> > > > >
> > > > > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> > > > >
> > > > > Is there any documentation/blog listed?  
> > > >  
> >  
> 

