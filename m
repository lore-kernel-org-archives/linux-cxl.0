Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466BAC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Apr 2022 08:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiD0IjZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359454AbiD0IjL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 27 Apr 2022 04:39:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645534474F
        for <linux-cxl@vger.kernel.org>; Wed, 27 Apr 2022 01:35:57 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KpBn446n1z67xW6;
        Wed, 27 Apr 2022 16:31:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 27 Apr 2022 10:35:54 +0200
Received: from localhost (10.81.200.74) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 09:35:53 +0100
Date:   Wed, 27 Apr 2022 09:35:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: CXL type 3 which doesn't have cxl mem enabled.
Message-ID: <20220427093552.0000376e@Huawei.com>
In-Reply-To: <CAPcyv4jsd=mWOU0ftgxBzwD6KhZ1oMCRVDm5WTYStfbF7_jBTA@mail.gmail.com>
References: <20220426180832.00005f0b@Huawei.com>
        <CAPcyv4i+=ArjE7uH_jKGS+B9-dLJ3An_T+NgWB2xqC-7Zh-VYA@mail.gmail.com>
        <20220426190615.000063ed@Huawei.com>
        <CAPcyv4gjn7MAo-kzW40EAc9J6zQaOKh0a-42GyV1X5Efac_W_Q@mail.gmail.com>
        <20220426203850.00006538@Huawei.com>
        <CAPcyv4jsd=mWOU0ftgxBzwD6KhZ1oMCRVDm5WTYStfbF7_jBTA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.74]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 26 Apr 2022 13:02:09 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Apr 26, 2022 at 12:39 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 26 Apr 2022 12:00:41 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > On Tue, Apr 26, 2022 at 11:06 AM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > On Tue, 26 Apr 2022 10:19:55 -0700
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > >  
> > > > > On Tue, Apr 26, 2022 at 10:09 AM Jonathan Cameron
> > > > > <Jonathan.Cameron@huawei.com> wrote:  
> > > > > >
> > > > > > Hi All,
> > > > > >
> > > > > > I ran into this whilst debugging why on the current QEMU code
> > > > > > we now get a probe failure for CXL mem due to the range 1 size being
> > > > > > non 0.
> > > > > >
> > > > > > The conditions for whether we have legacy ranges programmed don't
> > > > > > take into account if Mem_Enable = 1.  That is if the
> > > > > > DVSEC CXL Control Mem_Enable bit is set on the type 3 device.
> > > > > > If it's not then there is no existing user of the CXL memory
> > > > > > setup by firmware or similar so we can switch over to HDM
> > > > > > decoders and it doesn't matter what is in the range registers.
> > > > > >
> > > > > > Unfortunately the QEMU code was bringing the device up with
> > > > > > Mem_Enabled already set.  So I fixed that.  After all default
> > > > > > value of that bit should be 0.
> > > > > >
> > > > > > A few problems then showed up.
> > > > > >
> > > > > > 1. Nothing in the Linux code actually sets Mem_Enabled to 1.  
> > > >
> > > > Sorry - my mistake, that should be Mem_Enable. Though that doesn't
> > > > actually clarify things much...
> > > >  
> > > > >
> > > > > That's because the device is supposed to, I though, set it of its own
> > > > > accord as a result of link training. It's an RO field in the spec, so
> > > > > Linux can't set it:
> > > > >
> > > > > 8.2.1.3.3 DVSEC Flex Bus Port Status (Offset 0Eh)
> > > > > "Mem_Enabled: When set, indicates that CXL.mem protocol operation has
> > > > > been enabled as a result of PCIe alternate protocol negotiation for
> > > > > Flex Bus."  
> > > >
> > > > Agreed with that statement.
> > > >
> > > > Ah. Nothing like confusing register field names that are very similar....
> > > > A Mem_Enable is in DVSEC for CXL Device 8.1.3.2 and is RWL.
> > > > Just for giggles there is also a Mem_Enable in the Flex Bus Port Control
> > > > but the range registers comment isn't about that one (I hope anyway!).  
> > >
> > > Not sure whether to laugh or cry at that, sorry for the mix up on my part.
> > >  
> > > > The kernel currently sets the value of info->mem_enabled using
> > > > the Mem_Enable field of the DVSEC for CXL Device.
> > > > https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/pci.c#L501
> > > >
> > > > So I think wrong name and wrong DVSEC for that particular condition.  
> > >
> > > Yeah, I don't even see a need to cache that value, so something like
> > > the attached? Note that the intent was to only have cxl_mem worry
> > > about MMIO mapped register details and not require the 'struct
> > > pci_dev' which makes things easier for cxl_test in the near term.
> > >  
> > Hi Dan,
> >
> > That fixes this problem (I'll test tomorrow but it looks right), but...
> >
> > I think we still run into the problem I was debugging in the
> > first place which is whether the Device DVSEC Range 1 size is non 0.
> > https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/pci.c#L541
> > (ranges ends up > 0 and hence we conclude firmware already programmed the
> >  device and fail the probe).
> >
> > As far as I can tell a CXL 2.0 type 3 device is allowed to provide
> > the option to use ranges or HDM decoders (or it can be HDM decoder only).
> > See the comment at end of 8.1.3.8.4 :
> >
> > "A CXL.mem capable device that implements CXL HDM Decoder Capability registers
> > follows the above behavior as long as HDM Decoder Enable bit in CXL HDM Decoder
> > Global Control register is zero."
> >
> > As such we can't use the range size alone to check if
> > the Range registers are in use (it's a RO value, not something previously
> > configured)  We need to perform the full check as described which
> > includes checking Mem_Enable (which is in the above behavior that comment
> > is directing us towards).
> >
> > As the below patch has already set Mem_Enable hardware field unconditionally
> > we don't have the necessary info by the time we reach the relevant code.
> > https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/mem.c#L107
> >
> > So you could cache the current value (perhaps with a more meaningful
> > name than the spec gives it!) of Device DVSEC Mem_Enable
> > at the point where you have it written in this patch and add a check
> > on the cached value at the point in the reference above.
> >
> > That's still a little ugly as ideally we shouldn't transition through
> > a somewhat invalid state - though it is harmless as no traffic
> > will be sent by the host (probably - though I suspect hardware folk
> > would tell me we can't assume it...).  
> 
> ...and there is also the worry about malicious devices, but I don't
> know how to determine the difference between valid config, invalid
> config, and malicious device claiming a range that it shouldn't.
> Perhaps this needs at a minimum cross validation with the CFMWS?
> 
> > The invalid state being:
> > - Mem_Enable set
> > - Range registers in use because global HDM Decoder enable not yet set.
> > - Range registers were programmed by firmware to something that actually
> >   works but not enabled for some odd reason. I think they might even be
> >   technically valid with the defaults even though the base is 0 (imagine
> >   a very large CXL memory - some of it might overlap with a region being
> >   routed by the host to the CXL host bridges).  
> 
> Oh yuck, yes the default init state of any device is that it will
> decode the first 256MB of memory as long as mem_enabled is set, and
> devices are "trusted" to not decode anything that they shouldn't.
> 
> I'm wondering if Linux should take a more draconian approach and
> mandate that all devices that advertise the CXL 2.0 Class Code
> capability must boot in HDM decoder enabled mode, or Mem_enable=0
> mode. Any CXL 2.0 device found to have Mem_enable=1 without HDM
> decoders enabled will have HDM decoder operation forced upon them so
> that Linux can trust that nothing is being decoded by accident, if
> that breaks the system, that's a BIOS bug, not a Linux bug. Of course,
> could have a module parameter to override that policy while the BIOS
> update is in-flight to the target system.

I'm not sure it is technically a BIOS bug. Using the range approach with
everything fully set up - e.g. with Memory also in the EFI memory map
and other appropriate places is fine.  We should just ignore those
devices.  Hopefully they also have the lock set.

We could make what you suggest a Linux 'boot standard' though...
We'd want to communicate that strongly to various BIOS teams though.
Even better if we can get other OSVs on side.

I'll check with our BIOS team whether they'd mind this restriction.

> 
> > Ideally we wouldn't set that Mem_Enable until we have switched
> > to the HDM decoders.  To avoid that we probably need another callback
> > from cxl_mem into cxl_pci.  
> 
> Either another callback, or move more validation out of cxl_mem and
> into cxl_pci. I am leaning towards the latter.
Sure. That should work.

Jonathan
> 
> > Agreed on the laughing or crying. I'm off to find a beer.  
> 
> Cheers!

