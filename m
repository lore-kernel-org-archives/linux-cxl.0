Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F574C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 14:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJJOnw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJJOnt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 10:43:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69C71708
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 07:43:46 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmM6N5QB1z67bJY;
        Mon, 10 Oct 2022 22:41:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:43:44 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 15:43:44 +0100
Date:   Mon, 10 Oct 2022 15:43:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <20221010154343.00007afd@huawei.com>
In-Reply-To: <Yz8QlQ9yLFrWxWsN@fedora>
References: <20221006000103.49542-1-gregory.price@memverge.com>
        <20221006094557.000035ab@huawei.com>
        <20221006095007.00001271@huawei.com>
        <Yz75ppPOwYCvNamy@fedora>
        <20221006174214.000059c7@huawei.com>
        <Yz8QlQ9yLFrWxWsN@fedora>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> 
> I was unaware that an SLD could be comprised of multiple regions
> of both persistent and volatile memory.  I was under the impression that
> it could only be one type of memory.  Of course that makes sense in the
> case of a memory expander that simply lets you plug DIMMs in *facepalm*
> 
> I see the reason to have separate backends in this case.
> 
> The reason to allow an array of backing devices is if we believe each
> individual DIMM plugged into a memexpander is likely to show up as
> (configurably?) individual NUMA nodes, or if it's likely to get
> classified as one numa node.

I'm not sure it would be each DIMM separately as there are likely to only
be a couple of types.

> 
> Maybe we should consider 2 new options:
> --persistent-memdevs=pm1 pm2 pm3
> --volatile-memdevs=vm1 vm2 vm3
> 
> etc, and deprecate --memdev, and go with your array of memdevs idea.
> 
> I think I could probably whip that up in a day or two.  Thoughts?

I wonder if we care to emulate beyond 1 volatile and 1 persistent.
Sure devices might exist, but if we can exercise all the code paths
with a simpler configuration, perhaps we don't need to handle the
more complex ones?

The sticky corner here is Set Partition Info 
CXL r3.0 8.2.9.8.2.1

Separation between volatile and non volatile is configurable at runtime.

> 
> 
> 
> > > 
> > > 2) EDK2 sets the memory area as a reserved, and the memory is not
> > > configured by the system as ram.  I'm fairly sure edk2 just doesn't
> > > support this yet, but there's a chicken/egg problem.  If the device
> > > isn't there, there's nothing to test against... if there's nothing to
> > > test against, no one will write the support.  So I figure we should kick
> > > start the process (probably by getting it wrong on the first go around!)  
> > 
> > Yup, if the bios left it alone, OS drivers need to treat it the same as
> > they would deal with hotplugged memory.  Note my strong suspicion is there
> > will be host vendors who won't ever handle volatile CXL memory in firmware.
> > They will just let the OS bring it up after boot. As long as you have DDR
> > as well on the system that will be fine.  Means there is one code path
> > to verify rather than two.  Not everyone will care about legacy OS support.
> >   
> 
> Presently i'm failing to bring up a region of memory even when this is
> set to persistent (even on upstream configuration).  The kernel is
> presently failing to set_size because the region is used.
> 
> I can't tell if this is a driver error or because EDK2 is marking the
> region as reserved.
> 
> relevant boot output:
> [    0.000000] BIOS-e820: [mem 0x0000000290000000-0x000000029fffffff] reserved
> [    1.229097] acpi ACPI0016:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    1.244082] acpi ACPI0016:00: _OSC: OS supports [CXL20PortDevRegAccess CXLProtocolErrorReporting CXLNativeHotPlug]
> [    1.261245] acpi ACPI0016:00: _OSC: platform does not support [LTR DPC]
> [    1.272347] acpi ACPI0016:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability]
> [    1.286092] acpi ACPI0016:00: _OSC: OS now controls [CXLMemErrorReporting]
> 
> The device is otherwise available for use
> 
> cli output
> # cxl list
> [
>   {
>     "memdev":"mem0",
>     "pmem_size":268435456,
>     "ram_size":0,
>     "serial":0,
>     "host":"0000:35:00.0"
>   }
> ]
> 
> but it fails to setup correctly
> 
> cxl create-region -m -d decoder0.0 -w 1 -g 256 mem0
> cxl region: create_region: region0: set_size failed: Numerical result out of range
> cxl region: cmd_create_region: created 0 regions
> 
> I tracked this down to this part of the kernel:
> 
> kernel/resource.c
> 
> static struct resource *get_free_mem_region(...)
> {
> 	... snip ...
> 	enumerate regions, fail to find a useable region
> 	... snip ...
> 	return ERR_PTR(-ERANGE);
> }
> 
> but i'm not sure of what to do with this info.  We have some proof
> that real hardware works with this no problem, and the only difference
> is that the EFI/bios/firmware is setting the memory regions as `usable`
> or `soft reserved`, which would imply the EDK2 is the blocker here
> regardless of the OS driver status.
> 
> But I'd seen elsewhere you had gotten some of this working, and I'm
> failing to get anything working at the moment.  If you have any input i
> would greatly appreciate the help.
> 
> QEMU config:
> 
> /opt/qemu-cxl2/bin/qemu-system-x86_64 \
> -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=d\
> -m 2G,slots=4,maxmem=4G \
> -smp 4 \
> -machine type=q35,accel=kvm,cxl=on \
> -enable-kvm \
> -nographic \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
> -object memory-backend-file,id=cxl-mem0,mem-path=/tmp/cxl-mem0,size=256M \
> -object memory-backend-file,id=lsa0,mem-path=/tmp/cxl-lsa0,size=256M \
> -device cxl-type3,bus=rp0,pmem=true,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=256M
> 
> I'd seen on the lists that you had seen issues with single-rp setups,
> but no combination of configuration I've tried (including all the ones
> in the docs and tests) lead to a successful region creation with
> `cxl create-region`

Hmm. Let me have a play.  I've not run x86 tests for a while so
perhaps something is missing there.

I'm carrying a patch to override check_last_peer() in
cxl_port_setup_targets() as that is wrong for some combinations,
but that doesn't look like it's related to what you are seeing.

> 
> > > 
> > > 3) Upstream linux drivers haven't touched ram configurations yet.  I
> > > just configured this with Dan Williams yesterday on IRC.  My
> > > understanding is that it's been worked on but nothing has been
> > > upstreamed, in part because there are only a very small set of devices
> > > available to developers at the moment.  
> > 
> > There was an offer of similar volatile memory QEMU emulation in the
> > session on QEMU CXL at Linux Plumbers.  That will look something like you have
> > here and maybe reflects that someone has hardware as well...
> >   
> 
> I saw that, and I figured I'd start the conversation by pushing
> something :].

