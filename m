Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB367C7EE25
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 10:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjFHKgi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFHKgh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 06:36:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7FB2720
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 03:36:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcLDh3Q3yz67NsF;
        Thu,  8 Jun 2023 18:34:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 11:36:32 +0100
Date:   Thu, 8 Jun 2023 11:36:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "<\"qemu-devel@nongnu.org\"" <qemu-devel@nongnu.org>
Subject: Re: Concept of LD-ID in QEMU
Message-ID: <20230608113631.00007a53@Huawei.com>
In-Reply-To: <20230608113153.000033ef@Huawei.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
        <20230607221651.2454764-15-terry.bowman@amd.com>
        <DM6PR18MB2844C099FB0671E864AA953DAF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230608113153.000033ef@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Shesha,

You've sent an email with the 'In-reply-to' set to one of Terry's patches.
Please check why that happened and make sure you don't do that in future as
it hides your unrelated thread in email clients and the archives!

See
https://lore.kernel.org/linux-cxl/20230607221651.2454764-1-terry.bowman@amd.com/T/#t 
for example

Jonathan

On Thu, 8 Jun 2023 11:31:53 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 7 Jun 2023 23:01:11 +0000
> Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:
> 
> > Hi,
> > For DCD sideband there needs to be LD-ID. Is the following approach acceptable?  
> 
> QEMU question so +CC qemu-devel
> 
> > 
> >  -device cxl-type3,bus=swport0,volatile-memdev=vmem0,dc-memdev=vmem1,id=cxl-vmem0,num-dc-regions=2,ldid=0 \
> >  -device cxl-type3,bus=swport0,volatile-memdev=vmem1,dc-memdev=vmem2,id=cxl-vmem1,num-dc-regions=2,ldid=1 \  
> 
> Those will be PCI functions at this level so you can't do this until we have more advanced switch support
> (it has to know about multiple VHs - right now we only support fixed config switches).  You could connect them
> to different switch ports - effectively that will be what it looks like when we do emulate a configurable switch.
> 
> >  -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=24,target=cxl-vmem0,cxl-vmem1")
> > 
> > With this configuration, the same i2c device is handing both LDs and in FMAPI commands we use the LDID specified above.  
> 
> This effectively becomes a partial implementation of either an MLD or an MH-SLD
> To manage the actual memory access, those will almost certainly need a bunch of other shared
> infrastructure.  So I'd ultimately expect the i2c_mctp_cxl device to target whatever
> device represents that shared infrastructure - it might be a separate device or a 'lead' type 3 device.
> 
> So I'm not sure how this will fit together longer term.  We need same infrastructure
> to work for a mailbox CCI on a MH-SLD/MLD as well and in that case there isn't a separate
> device to which we can provide multiple targets as you've done in your proposal here.
> 
> So I think we need to work out how to handle all of (I've probably forgotten something)
> X marks done or in progress.
> 
> X 1) i2c_mctp_cxl to an SLD (no PCI Mailbox definition for this one)
>   2) i2c_mctp_cxl directly to an MLD (your case)
> X 3) i2c_mctp_cxl to a fixed config switch (single fixed VH no MLD capable ports)
> X 4) PCI mailbox via switch CCI device that fixed config switch (no MLD capable ports)
> 	Even with this simple design some fun things you can do.
>   5) i2c_mctp_cxl to a configurable switch (probably a separate as yet to be defined management interface - that messes with hotplug)
>   6) PCI mailbox via switch CCI to configurable switch (again to defined management interface).
>   7) i2c_mctp_cxl to an MH-SLD - probably to which ever device also has support for
>      tunneling to the FM owned LD via the PCI mailbox.
> X 8) PCI mailbox on MH-SLD tunneling to the FM owned LD.
>   9) i2c_mctp_cxl to an MH-MLD - similar to above - this one isn't that much more complex than MH-SLD case.
> X 10) PCI mailbox to MH-MLD - similar to above.
>   11) Tunneling via the switch CCI (then over PCI-VDM - though that detail isn't visible in QEMU) to an SLD
>   12) Tunneling via the switch CCI (then PCI-VDM) to an MH-SLD and on to he FM owned LD.
>   13) Tunneling via the switch CCI (then over PCI-VDM) to an MLD / MH-MLD
>  
> Current i2c_mctp_cxl covers 1 and 3
> I'm part way through the tunnelling support for (8 and 100) - need to revisit and wire up the switch CCI PoC
> properly which will give us 4.
> 
> 2 needs MLD support in general which we could maybe make work with a static binding in a switch but that
>   would be odd - so we probably need to emulate a configurable switch for that
> 5,6 need configurable switch
> 7 needs same as 2 plus tunneling part similar to 4
> 9 again probably configurable switch for the MLD part to make sense
> 11 is fairly straight forward - but not done yet.
> 12 also not too bad, but needs the MH-SLD part to be fleshed out (some work on going )
> 13 needs pretty much everything defined.
> 
> Trying to get the command line interface and device model right until we have PoC code
> for a few more cases is going to be at most a draft of what it might look like.
> 
> So in short, lots to do.  For now feel free to hack whatever you need in to be able
> to test the FM-API side of things, we can move that towards a clean command line definition
> once we have one figured out!
> 
> Jonathan
> 
> 
> > 
> > Thanks,
> > Shesha.  
> 
> 

