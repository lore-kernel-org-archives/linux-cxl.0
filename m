Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADBAC27C40
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Aug 2023 16:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjHWQvJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjHWQvI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Aug 2023 12:51:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A863E77
        for <linux-cxl@vger.kernel.org>; Wed, 23 Aug 2023 09:51:03 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RWBvH340gz6J7mt;
        Thu, 24 Aug 2023 00:46:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 17:50:57 +0100
Date:   Wed, 23 Aug 2023 17:50:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sajjan Rao <sajjanr@gmail.com>
CC:     Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: qemu cxl memory expander shows numa_node -1
Message-ID: <20230823175056.00001a84@Huawei.com>
In-Reply-To: <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
        <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
        <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
        <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
        <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 23 Aug 2023 16:43:13 +0530
Sajjan Rao <sajjanr@gmail.com> wrote:

> Thank you Dimitrios. That worked!
> 
> On Mon, Aug 21, 2023 at 4:23 PM Dimitrios Palyvos
> <dimitrios.palyvos@zptcorp.com> wrote:
> >
> > Hi,
> >
> > Ah yes, I believe you need to enable the kernel config option
> > CONFIG_CXL_REGION_INVALIDATION_TEST for the region creation to work in
> > QEMU. The help entry of that config option gives more info on the why.
> >
> > Hope that helps!
> >
> > Kind regards,
> > Dimitris
> >
> >
> > On Mon, Aug 21, 2023 at 12:01 PM Sajjan Rao <sajjanr@gmail.com> wrote:  
> > >
> > > Hello Dimitrios,
> > >
> > > Thank you for the pointers. I have the 6.4.10 kernel and modified the
> > > qemu options, but now I see an error creating the region.
> > > Is there anything else I missed?
> > >
> > > [root@cxl-test /]# cxl create-region -d decoder0.0 -s 268435456 -t ram
> > > [ 4144.982608] cxl region0: Failed to synchronize CPU cache state
> > > cxl region: create_region: region0: failed to commit decode: No such
> > > device or address
> > >
> > > Thanks,
> > > Sajjan
> > >
> > > -- qemu
> > >
> > > qemu-system-x86_64 \
> > >  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > >  -machine type=q35,cxl=on \
> > >  -m 4G \
> > >  -smp cpus=2 \
> > >  -accel tcg,thread=single \
> > >  -object memory-backend-ram,size=4G,id=m0 \
> > >  -object memory-backend-ram,size=256M,id=cxl-mem1 \
> > >  -numa node,memdev=m0,cpus=0-1,nodeid=0 \
> > >  -netdev user,id=net0,net=192.168.0.0/24,dhcpstart=192.168.0.9  \
> > >  -device virtio-net-pci,netdev=net0 \
> > >  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > >  -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
> > >  -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-mem1 \
> > >  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
> > >  -nographic
> > >
> > > -----
> > >
> > > [root@cxl-test /]# uname -r
> > > 6.4.10-200.fc38.x86_64
> > > [root@cxl-test /]# cxl list
> > > [
> > >   {
> > >     "memdev":"mem0",
> > >     "ram_size":268435456,
> > >     "serial":0,
> > >     "host":"0000:0d:00.0"
> > >   }
> > > ]
> > > [root@cxl-test /]# cxl create-region -d decoder0.0 -s 268435456 -t ram
> > > [ 4144.982608] cxl region0: Failed to synchronize CPU cache state
> > > cxl region: create_region: region0: failed to commit decode: No such
> > > device or address
> > >
> > > [root@cxl-test /]#
> > >
> > > On Fri, Aug 18, 2023 at 8:31 PM Dimitrios Palyvos
> > > <dimitrios.palyvos@zptcorp.com> wrote:  
> > > >
> > > > Hi,
> > > >
> > > > I am not an expert (and not 100% sure if that's what you want to do),
> > > > but here's one way to get your configuration to work:
> > > > 1. Disable KVM.

Just to second this - don't use KVM and expect it to work with CXL emulation
if you are trying to use kmem to present it as normal memory - it should be fine
as long as you never run instructions resident in that memory.

It will crash in nasty ways due to various issues with instruction emulation
where it is running out of memory behind the emulated interleave decoders.

So far we haven't cared enough to add the complexity that would be needed
to make that work.

TCG is the way to go for now.

Jonathan

> > > > 2. Remove the CXL NUMA node from the QEMU command.
> > > > 3. Use the ndctl utilities in the guest to initialize your CXL memory
> > > > and associated NUMA node.
> > > >
> > > > More specifically, I changed your QEMU command as follows:
> > > >
> > > >     qemu-system-x86_64 \
> > > >      -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > >      -machine type=q35,cxl=on \
> > > >      -m 8G \
> > > >      -smp cpus=8 \
> > > >      -object memory-backend-ram,size=4G,id=m0 \
> > > >      -object memory-backend-ram,size=4G,id=m1 \
> > > >      -object memory-backend-ram,size=2G,id=cxl-mem1 \
> > > >      -numa node,memdev=m0,cpus=0-3,nodeid=0 \
> > > >      -numa node,memdev=m1,cpus=4-7,nodeid=1 \
> > > >      -netdev user,id=net0,net=192.168.0.0/24,dhcpstart=192.168.0.9  \
> > > >      -device virtio-net-pci,netdev=net0 \
> > > >      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > > >      -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
> > > >      -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-mem1 \
> > > >      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
> > > >      -nographic
> > > >
> > > > In the guest, install ndctl: https://github.com/pmem/ndctl
> > > >
> > > > After that, you should be able to see the CXL memory:
> > > >     root@cxl-img:~# cxl list
> > > >     [
> > > >       {
> > > >         "memdev":"mem0",
> > > >         "ram_size":2147483648,
> > > >         "serial":0,
> > > >         "host":"0000:0d:00.0"
> > > >       }
> > > >     ]
> > > >
> > > > And initialize it as RAM:
> > > >     root@cxl-img:~# cxl create-region -d decoder0.0 -s 2147483648 -t ram
> > > >     ...
> > > >
> > > > root@cxl-img:~# lsmem --output-all
> > > >     RANGE                                  SIZE  STATE REMOVABLE BLOCK
> > > > NODE  ZONES
> > > >     0x0000000000000000-0x0000000007ffffff  128M online       yes     0
> > > >    0   None
> > > >     0x0000000008000000-0x000000007fffffff  1.9G online       yes  1-15
> > > >    0  DMA32
> > > >     0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> > > >    0 Normal
> > > >     0x0000000180000000-0x000000027fffffff    4G online       yes 48-79
> > > >    1 Normal
> > > >     0x0000000290000000-0x000000030fffffff    2G online       yes 82-97
> > > >    2 Normal
> > > >
> > > >     Memory block size:       128M
> > > >     Total online memory:      10G
> > > >     Total offline memory:      0B
> > > >
> > > >
> > > >     root@cxl-img:~# cat /proc/iomem
> > > >     ...
> > > >     290000000-38fffffff : CXL Window 0
> > > >       290000000-30fffffff : region0
> > > >         290000000-30fffffff : dax0.0
> > > >           290000000-30fffffff : System RAM (kmem)
> > > >
> > > >
> > > > Then you can generate traffic in the CXL NUMA node, for example:
> > > >
> > > >     root@cxl-img:~# numactl --membind 2 ls
> > > >
> > > > Note: The above is with linux v6.4.11.
> > > >
> > > > Hope that helps!
> > > >
> > > > Kind regards,
> > > > Dimitris
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > On Fri, Aug 18, 2023 at 11:39 AM Sajjan Rao <sajjanr@gmail.com> wrote:  
> > > > >
> > > > > Hello,
> > > > >
> > > > > I have a qemu + cxl configuration coming up with one configured type 3
> > > > > device. My goal is to generate some cxl.mem traffic in this
> > > > > configuration.
> > > > > However the numa_node is always showing as -1. I have tried various
> > > > > qemu command line parameters including to explicitly set numa_node for
> > > > > cxl devices.
> > > > >
> > > > > Here is my qemu command line
> > > > > --------
> > > > > qemu-system-x86_64 \
> > > > >  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > > >  -machine type=q35,accel=kvm,cxl=on \
> > > > >  -m 10G \
> > > > >  -smp cpus=8 \
> > > > >  -object memory-backend-ram,size=4G,id=m0 \
> > > > >  -object memory-backend-ram,size=4G,id=m1 \
> > > > >  -object memory-backend-ram,size=2G,id=cxl-mem1 \
> > > > >  -numa node,memdev=m0,cpus=0-1,nodeid=0 \
> > > > >  -numa node,memdev=m1,cpus=2-3,nodeid=1 \
> > > > >  -numa node,memdev=cxl-mem1,cpus=4-7,nodeid=2 \
> > > > >  -netdev user,id=net0,net=192.168.0.0/24,dhcpstart=192.168.0.9  \
> > > > >  -device virtio-net-pci,netdev=net0 \
> > > > >  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > > > >  -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
> > > > >  -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-mem1 \
> > > > >  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
> > > > >  -enable-kvm \
> > > > >  -nographic
> > > > > -----
> > > > >
> > > > > I see that the cxl device is listed in lspci output
> > > > > ------
> > > > > #lspci | grep -i cxl
> > > > > 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> > > > >
> > > > > #lspci -s 0d:00.0 -vvv | grep -i numa
> > > > > #
> > > > >
> > > > > -------
> > > > >
> > > > > sysfs output
> > > > > ----------
> > > > > #cat /sys/bus/cxl/devices/mem0/numa_node
> > > > > -1
> > > > > --------
> > > > >
> > > > > numactl output
> > > > >
> > > > > ------------------
> > > > > #numactl -H
> > > > > available: 3 nodes (0-2)
> > > > > node 0 cpus: 0 1
> > > > > node 0 size: 3910 MB
> > > > > node 0 free: 3776 MB
> > > > > node 1 cpus: 2 3
> > > > > node 1 size: 4031 MB
> > > > > node 1 free: 3927 MB
> > > > > node 2 cpus: 4 5 6 7
> > > > > node 2 size: 2011 MB
> > > > > node 2 free: 1785 MB
> > > > > node distances:
> > > > > node   0   1   2
> > > > >   0:  10  20  20
> > > > >   1:  20  10  20
> > > > >   2:  20  20  10
> > > > > -------------------
> > > > >
> > > > > The numa_node 2 is expected to be mapped to a CXL device, I do see
> > > > > some activity in numastat output, but it's unclear if this is really
> > > > > mapped to the CXL device since the device itself says numa_node is -1
> > > > > (expected to show 2).
> > > > >
> > > > > Has anybody seen this behavior? Any help will be greatly appreciated.
> > > > >
> > > > > Thanks,
> > > > > Sajjan  
> > > >
> > > > --
> > > > **CONFIDENTIALITY NOTICE:*
> > > > *
> > > > *The contents of this email message and any
> > > > attachments are intended solely for the addressee(s) and may contain
> > > > confidential and/or privileged information and may be legally protected
> > > > from disclosure. If you are not the intended recipient of this message or
> > > > their agent, or if this message has been addressed to you in error, please
> > > > immediately alert the sender by reply email and then delete this message
> > > > and any attachments. If you are not the intended recipient, you are hereby
> > > > notified that any use, dissemination, copying, or storage of this message
> > > > or its attachments is strictly prohibited. *  
> >
> >
> >
> > --
> >
> > Dimitrios Payvos-Giannas, PhD
> >
> > Software Engineer
> >
> > ZeroPoint Technologies
> >
> > Remove the waste.
> >
> > Release the power.
> >
> > --
> > **CONFIDENTIALITY NOTICE:*
> > *
> > *The contents of this email message and any
> > attachments are intended solely for the addressee(s) and may contain
> > confidential and/or privileged information and may be legally protected
> > from disclosure. If you are not the intended recipient of this message or
> > their agent, or if this message has been addressed to you in error, please
> > immediately alert the sender by reply email and then delete this message
> > and any attachments. If you are not the intended recipient, you are hereby
> > notified that any use, dissemination, copying, or storage of this message
> > or its attachments is strictly prohibited. *  

