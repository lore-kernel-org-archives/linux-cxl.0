Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956E7C00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 12:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiHHMhd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbiHHMhd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 08:37:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE9BC14
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 05:37:31 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M1bLw110Wz67Qtq;
        Mon,  8 Aug 2022 20:37:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 14:37:28 +0200
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 8 Aug
 2022 13:37:28 +0100
Date:   Mon, 8 Aug 2022 13:37:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bobo WL <lmw.bobo@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <qemu-arm@nongnu.org>
Subject: Re: [BUG] cxl can not create region
Message-ID: <20220808133727.00001171@huawei.com>
In-Reply-To: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 5 Aug 2022 10:20:23 +0800
Bobo WL <lmw.bobo@gmail.com> wrote:

> Hi list
> 
> I want to test cxl functions in arm64, and found some problems I can't
> figure out.
Hi Bob,

Glad to see people testing this code.

> 
> My test environment:
> 
> 1. build latest bios from https://github.com/tianocore/edk2.git master
> branch(cc2db6ebfb6d9d85ba4c7b35fba1fa37fffc0bc2)
> 2. build latest qemu-system-aarch64 from git://git.qemu.org/qemu.git
> master branch(846dcf0ba4eff824c295f06550b8673ff3f31314). With cxl arm
> support patch: https://patchwork.kernel.org/project/cxl/cover/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
> 3. build Linux kernel from
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
> branch(65fc1c3d26b96002a5aa1f4012fae4dc98fd5683)
> 4. build latest ndctl tools from https://github.com/pmem/ndctl
> create_region branch(8558b394e449779e3a4f3ae90fae77ede0bca159)
> 
> And my qemu test commands:
> sudo $QEMU_BIN -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 \
>         -cpu max -smp 8 -nographic -no-reboot \
>         -kernel $KERNEL -bios $BIOS_BIN \
>         -drive if=none,file=$ROOTFS,format=qcow2,id=hd \
>         -device virtio-blk-pci,drive=hd -append 'root=/dev/vda1
> nokaslr dyndbg="module cxl* +p"' \
>         -object memory-backend-ram,size=4G,id=mem0 \
>         -numa node,nodeid=0,cpus=0-7,memdev=mem0 \
>         -net nic -net user,hostfwd=tcp::2222-:22 -enable-kvm \
>         -object
> memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa0.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa1.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M
> \
>         -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>         -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \

Probably not related to your problem, but there is a disconnect in QEMU /
kernel assumptionsaround the presence of an HDM decoder when a HB only
has a single root port. Spec allows it to be provided or not as an implementation choice.
Kernel assumes it isn't provide. Qemu assumes it is.

The temporary solution is to throw in a second root port on the HB and not
connect anything to it.  Longer term I may special case this so that the particular
decoder defaults to pass through settings in QEMU if there is only one root port.

>         -device cxl-upstream,bus=root_port0,id=us0 \
>         -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>         -device
> cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
>         -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>         -device
> cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1 \
>         -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
>         -device
> cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2 \
>         -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
>         -device
> cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3 \
>         -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> 
> And I have got two problems.
> 1. When I want to create x1 region with command: "cxl create-region -d
> decoder0.0 -w 1 -g 4096 mem0", kernel crashed with null pointer
> reference. Crash log:
> 
> [  534.697324] cxl_region region0: config state: 0
> [  534.697346] cxl_region region0: probe: -6

Seems odd this is up here.  But maybe fine.

> [  534.697368] cxl_acpi ACPI0017:00: decoder0.0: created region0
> [  534.699115] cxl region0: mem0:endpoint3 decoder3.0 add:
> mem0:decoder3.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> [  534.699149] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem0:decoder3.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
> [  534.699167] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem0:decoder3.0 @ 0 next: 0000:0d:00.0 nr_eps: 1 nr_targets: 1
> [  534.699176] cxl region0: ACPI0016:00:port1 iw: 1 ig: 256
> [  534.699182] cxl region0: ACPI0016:00:port1 target[0] = 0000:0c:00.0
> for mem0:decoder3.0 @ 0
> [  534.699189] cxl region0: 0000:0d:00.0:port2 iw: 1 ig: 256
> [  534.699193] cxl region0: 0000:0d:00.0:port2 target[0] =
> 0000:0e:00.0 for mem0:decoder3.0 @ 0
> [  534.699405] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [  534.701474] Mem abort info:
> [  534.701994]   ESR = 0x0000000086000004
> [  534.702653]   EC = 0x21: IABT (current EL), IL = 32 bits
> [  534.703616]   SET = 0, FnV = 0
> [  534.704174]   EA = 0, S1PTW = 0
> [  534.704803]   FSC = 0x04: level 0 translation fault
> [  534.705694] user pgtable: 4k pages, 48-bit VAs, pgdp=000000010144a000
> [  534.706875] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [  534.709855] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> [  534.710301] Modules linked in:
> [  534.710546] CPU: 7 PID: 331 Comm: cxl Not tainted
> 5.19.0-rc3-00064-g65fc1c3d26b9-dirty #11
> [  534.715393] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [  534.717179] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  534.719190] pc : 0x0
> [  534.719928] lr : commit_store+0x118/0x2cc
> [  534.721007] sp : ffff80000aec3c30
> [  534.721793] x29: ffff80000aec3c30 x28: ffff0000da62e740 x27: ffff0000c0c06b30
> [  534.723875] x26: 0000000000000000 x25: ffff0000c0a2a400 x24: ffff0000c0a29400
> [  534.725440] x23: 0000000000000003 x22: 0000000000000000 x21: ffff0000c0c06800
> [  534.727312] x20: 0000000000000000 x19: ffff0000c1559800 x18: 0000000000000000
> [  534.729138] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffd41fe838
> [  534.731046] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [  534.732402] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [  534.734432] x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff0000c0906e80
> [  534.735921] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80000aec3bf0
> [  534.737437] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c155a000
> [  534.738878] Call trace:
> [  534.739368]  0x0
> [  534.739713]  dev_attr_store+0x1c/0x30
> [  534.740186]  sysfs_kf_write+0x48/0x58
> [  534.740961]  kernfs_fop_write_iter+0x128/0x184
> [  534.741872]  new_sync_write+0xdc/0x158
> [  534.742706]  vfs_write+0x1ac/0x2a8
> [  534.743440]  ksys_write+0x68/0xf0
> [  534.744328]  __arm64_sys_write+0x1c/0x28
> [  534.745180]  invoke_syscall+0x44/0xf0
> [  534.745989]  el0_svc_common+0x4c/0xfc
> [  534.746661]  do_el0_svc+0x60/0xa8
> [  534.747378]  el0_svc+0x2c/0x78
> [  534.748066]  el0t_64_sync_handler+0xb8/0x12c
> [  534.748919]  el0t_64_sync+0x18c/0x190
> [  534.749629] Code: bad PC value
> [  534.750169] ---[ end trace 0000000000000000 ]---
> 
> 2. When I want to create x4 region with command: "cxl create-region -d
> decoder0.0 -w 4 -g 4096 -m mem0 mem1 mem2 mem3". I got below errors:
> 
> cxl region: create_region: region0: failed to set target3 to mem3
> cxl region: cmd_create_region: created 0 regions
> 
> And kernel log as below:
> [   60.536663] cxl_region region0: config state: 0
> [   60.536675] cxl_region region0: probe: -6
> [   60.536696] cxl_acpi ACPI0017:00: decoder0.0: created region0
> [   60.538251] cxl region0: mem0:endpoint3 decoder3.0 add:
> mem0:decoder3.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> [   60.538278] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem0:decoder3.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
> [   60.538295] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem0:decoder3.0 @ 0 next: 0000:0d:00.0 nr_eps: 1 nr_targets: 1
> [   60.538647] cxl region0: mem1:endpoint4 decoder4.0 add:
> mem1:decoder4.0 @ 1 next: none nr_eps: 1 nr_targets: 1
> [   60.538663] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem1:decoder4.0 @ 1 next: mem1 nr_eps: 2 nr_targets: 2
> [   60.538675] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem1:decoder4.0 @ 1 next: 0000:0d:00.0 nr_eps: 2 nr_targets: 1
> [   60.539311] cxl region0: mem2:endpoint5 decoder5.0 add:
> mem2:decoder5.0 @ 2 next: none nr_eps: 1 nr_targets: 1
> [   60.539332] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem2:decoder5.0 @ 2 next: mem2 nr_eps: 3 nr_targets: 3
> [   60.539343] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem2:decoder5.0 @ 2 next: 0000:0d:00.0 nr_eps: 3 nr_targets: 1
> [   60.539711] cxl region0: mem3:endpoint6 decoder6.0 add:
> mem3:decoder6.0 @ 3 next: none nr_eps: 1 nr_targets: 1
> [   60.539723] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem3:decoder6.0 @ 3 next: mem3 nr_eps: 4 nr_targets: 4
> [   60.539735] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem3:decoder6.0 @ 3 next: 0000:0d:00.0 nr_eps: 4 nr_targets: 1
> [   60.539742] cxl region0: ACPI0016:00:port1 iw: 1 ig: 256
> [   60.539747] cxl region0: ACPI0016:00:port1 target[0] = 0000:0c:00.0
> for mem0:decoder3.0 @ 0
> [   60.539754] cxl region0: 0000:0d:00.0:port2 iw: 4 ig: 512

This looks like off by 1 that should be fixed in the below mentioned
cxl/pending branch.  That ig should be 256.  Note the fix was
for a test case with a fat HB and no switch, but certainly looks
like this is the same issue.

> [   60.539758] cxl region0: 0000:0d:00.0:port2 target[0] =
> 0000:0e:00.0 for mem0:decoder3.0 @ 0
> [   60.539764] cxl region0: ACPI0016:00:port1: cannot host mem1:decoder4.0 at 1
> 
> I have tried to write sysfs node manually, got same errors.
When stepping through by hand, which sysfs write triggers the crash above?

Not sure it's related, but I've just sent out a fix to the
target register handling in QEMU. 

https://lore.kernel.org/linux-cxl/20220808122051.14822-1-Jonathan.Cameron@huawei.com/T/#m47ff985412ce44559e6b04d677c302f8cd371330

I did have one instance last week of triggering what looked to be a race condition but
the stack trace doesn't looks related to what you've hit.

It will probably be a few days before I have time to take a look at replicating
what you have seen.

If you have time, try using the kernel.org cxl/pending branch as there are
a few additional fixes on there since you sent this email.  Optimistic to hope
this is covered by one of those, but at least it will mean we are trying to replicate
on same branch.

Jonathan


> 
> Hope I can get some helps here.
> 
> Bob

