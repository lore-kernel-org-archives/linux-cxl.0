Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B1AC677F1
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 09:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjAMJPq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 04:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241479AbjAMJOT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 04:14:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1A342E2D
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 01:12:17 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtbK23fwKz6J9Tw;
        Fri, 13 Jan 2023 17:12:06 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:12:14 +0000
Date:   Fri, 13 Jan 2023 09:12:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <20230113091213.00002146@Huawei.com>
In-Reply-To: <Y8CNw/fZT5fZJZcK@memverge.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
        <Y8AppXP+eP9cEz+i@memverge.com>
        <20230112172130.0000391b@Huawei.com>
        <Y8CNw/fZT5fZJZcK@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 12 Jan 2023 17:46:27 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Jan 12, 2023 at 05:21:30PM +0000, Jonathan Cameron wrote:
> > On Thu, 12 Jan 2023 10:39:17 -0500
> > Gregory Price <gregory.price@memverge.com> wrote:
> >   
> > > On Wed, Jan 11, 2023 at 02:24:32PM +0000, Jonathan Cameron via wrote:  
> > > > Gregory's patches were posted as part of his work on adding volatile support.
> > > > https://lore.kernel.org/linux-cxl/20221006233702.18532-1-gregory.price@memverge.com/
> > > > https://lore.kernel.org/linux-cxl/20221128150157.97724-2-gregory.price@memverge.com/
> > > > I might propose this for upstream inclusion this cycle, but testing is
> > > > currently limited by lack of suitable kernel support.    
> > > 
> > > fwiw the testing i've done suggests the problem isn't necessarily the
> > > implementation so much as either the EFI support or the ACPI tables.
> > > 
> > > For example, we see memory expanders come up no problem and turn into
> > > volatile memory on real hardware, with the same kernels with just a few
> > > commands.  My gut feeling is that either a mailbox command is missing or
> > > that the ACPI tables are missing/significantly different.
> > > 
> > > I haven't been able to investigate further at this point, but that's my
> > > current state with the voltile type-3 device testing.  
> > 
> > My assumption was that all shipping hardware platforms were doing the
> > enumeration and bring up of memory expanders in the BIOS / firmware.
> > Those are then presented to the OS already set up exactly as if they were
> > normal memory.  We could do the same on QEMU but that means a lot of
> > work in EDK2. Note that it makes no sense to do the enumeration and
> > creation of ACPI tables in QEMU itself though could hack it like that.
> > This stuff is done in firmware because that enables it for legacy
> > OSes. Everything is more or less presented to the OS like you would
> > present RAM (EFI memory map, ACPI tables etc).
> > 
> > Firmware enumeration doesn't typically support hotplug, so if we add
> > support for hotplug of volatile memory type 3 devices to the kernel
> > we will also be able to do 'cold plug' and have the kernel bring them up
> > in a similar fashion to what we do for non-volatile (for non volatile there
> > is typically no real support in firmware as there is a bunch of policy to
> > deal with that doesn't belong in firmware). (simplifying heavily ;)
> > 
> > So I don't think we are missing anything in the emulation, just in the
> > software layers above it.  Could be wrong though ;)
> > 
> > Jonathan
> > 
> >  
> 
> I'm not so sure something is missing so much as something seems
> incorrect in either the ACPI table structure definitions, the mailbox,
> or even the doe emulation.
> 
> I took your branch and reverted to just prior to the volatile patch
> refernce: 59a59ef725699e0efb3e9e31a7f8d246de7286ed
> 
> 
> QEMU configuration for boot (Please let me know if something is wrong)
> 
> sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
> -m 2G,slots=4,maxmem=4G \
> -smp 4 \
> -machine type=q35,accel=kvm,cxl=on \
> -enable-kvm \
> -nographic \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
> -object memory-backend-file,pmem=true,id=cxl-mem0,mem-path=/tmp/cxl-mem0,size=1G \
> -object memory-backend-file,pmem=true,id=lsa0,mem-path=/tmp/cxl-lsa0,size=1G \
> -device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> 
> After boot we find:
> 
> [root@fedora ~]# ls /sys/bus/cxl/devices/
> decoder0.0  decoder2.0  mem0            pmem0  root0
> decoder1.0  endpoint2   nvdimm-bridge0  port1
> 
> [root@fedora ~]# ls -al /sys/bus/dax/devices/
> total 0
> drwxr-xr-x. 2 root root 0 Jan 12 22:44 .
> drwxr-xr-x. 4 root root 0 Jan 12 22:44 ..
> 
> 
> During boot, I am seeing three separate call traces, all of which appear
> to be related to PCI DOE and/or getting CDAT information.

Just to check, are these different from the on stack problem you reported
previously?  Doesn't look like the fix for that has made it upstream yet.

What kernel are you running?


> 
> [    3.916900] Call Trace:
> [    3.916906]  <TASK>
> [    3.931217]  pci_doe_submit_task+0x5d/0xd0
> [    3.936609]  pci_doe_discovery+0xb4/0x100
> [    3.936627]  ? pci_doe_xa_destroy+0x10/0x10
> [    3.942675]  pcim_doe_create_mb+0x219/0x290
> [    3.950506]  cxl_pci_probe+0x192/0x430
> [    3.960248]  local_pci_probe+0x41/0x80
> [    3.966564]  pci_device_probe+0xb3/0x220
> [    3.966579]  really_probe+0xde/0x380
> [    3.966583]  ? pm_runtime_barrier+0x50/0x90
> [    3.969158]  __driver_probe_device+0x78/0x170
> [    3.969167]  driver_probe_device+0x1f/0x90
> [    3.978264]  __driver_attach_async_helper+0x5c/0xe0
> [    3.983953]  async_run_entry_fn+0x30/0x130
> [    3.991084]  process_one_work+0x294/0x5b0
> [    4.004458]  worker_thread+0x4f/0x3a0
> [    4.012612]  ? process_one_work+0x5b0/0x5b0
> [    4.019114]  kthread+0xf5/0x120
> [    4.025133]  ? kthread_complete_and_exit+0x20/0x20
> [    4.031327]  ret_from_fork+0x22/0x30
> [    4.038969]  </TASK>
> 
> [   16.047704]  pci_doe_submit_task+0x5d/0xd0
> [   16.047713]  cxl_cdat_get_length+0xb8/0x110
> [   16.047779]  ? dvsec_range_allowed+0x60/0x60
> [   16.047803]  read_cdat_data+0xaf/0x1a0
> [   16.047814]  cxl_port_probe+0x80/0x120
> [   16.047824]  cxl_bus_probe+0x17/0x50
> [   16.047830]  really_probe+0xde/0x380
> [   16.047835]  ? pm_runtime_barrier+0x50/0x90
> [   16.047843]  __driver_probe_device+0x78/0x170
> [   16.047851]  driver_probe_device+0x1f/0x90
> [   16.047858]  __device_attach_driver+0x85/0x110
> [   16.047881]  ? driver_allows_async_probing+0x70/0x70
> [   16.047884]  bus_for_each_drv+0x7a/0xb0
> [   16.047896]  __device_attach+0xb3/0x1d0
> [   16.047907]  bus_probe_device+0x9f/0xc0
> [   16.047913]  device_add+0x41e/0x9b0
> [   16.047918]  ? kobject_set_name_vargs+0x6d/0x90
> [   16.047928]  ? dev_set_name+0x4b/0x60
> [   16.047944]  devm_cxl_add_port+0x27b/0x3b0
> [   16.047970]  devm_cxl_add_endpoint+0x82/0x130
> [   16.047982]  cxl_mem_probe+0xc4/0x11d [cxl_mem]
> [   16.047997]  cxl_bus_probe+0x17/0x50
> [   16.048003]  really_probe+0xde/0x380
> [   16.048007]  ? pm_runtime_barrier+0x50/0x90
> [   16.048014]  __driver_probe_device+0x78/0x170
> [   16.048022]  driver_probe_device+0x1f/0x90
> [   16.048029]  __driver_attach+0xd5/0x1d0
> [   16.048036]  ? __device_attach_driver+0x110/0x110
> [   16.048040]  bus_for_each_dev+0x76/0xa0
> [   16.048051]  bus_add_driver+0x1b1/0x200
> [   16.048061]  driver_register+0x89/0xe0
> [   16.048066]  ? 0xffffffffc056e000
> [   16.048070]  do_one_initcall+0x6e/0x320
> [   16.048091]  do_init_module+0x4a/0x200
> [   16.048099]  __do_sys_init_module+0x16a/0x1a0
> [   16.048132]  do_syscall_64+0x5b/0x80
> [   16.048138]  ? lock_is_held_type+0xe8/0x140
> [   16.048148]  ? asm_exc_page_fault+0x22/0x30
> [   16.048156]  ? lockdep_hardirqs_on+0x7d/0x100
> [   16.048162]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [   16.054601]  pci_doe_submit_task+0x5d/0xd0
> [   16.054610]  cxl_cdat_read_table.isra.0+0x141/0x190
> [   16.054660]  ? dvsec_range_allowed+0x60/0x60
> [   16.054685]  read_cdat_data+0xfc/0x1a0
> [   16.054695]  cxl_port_probe+0x80/0x120
> [   16.054706]  cxl_bus_probe+0x17/0x50
> [   16.054712]  really_probe+0xde/0x380
> [   16.054717]  ? pm_runtime_barrier+0x50/0x90
> [   16.054725]  __driver_probe_device+0x78/0x170
> [   16.054733]  driver_probe_device+0x1f/0x90
> [   16.054739]  __device_attach_driver+0x85/0x110
> [   16.054747]  ? driver_allows_async_probing+0x70/0x70
> [   16.054751]  bus_for_each_drv+0x7a/0xb0
> [   16.054767]  __device_attach+0xb3/0x1d0
> [   16.054782]  bus_probe_device+0x9f/0xc0
> [   16.054791]  device_add+0x41e/0x9b0
> [   16.054798]  ? kobject_set_name_vargs+0x6d/0x90
> [   16.054811]  ? dev_set_name+0x4b/0x60
> [   16.054831]  devm_cxl_add_port+0x27b/0x3b0
> [   16.054843]  devm_cxl_add_endpoint+0x82/0x130
> [   16.054854]  cxl_mem_probe+0xc4/0x11d [cxl_mem]
> [   16.054869]  cxl_bus_probe+0x17/0x50
> [   16.054875]  really_probe+0xde/0x380
> [   16.054879]  ? pm_runtime_barrier+0x50/0x90
> [   16.054887]  __driver_probe_device+0x78/0x170
> [   16.054894]  driver_probe_device+0x1f/0x90
> [   16.054901]  __driver_attach+0xd5/0x1d0
> [   16.054908]  ? __device_attach_driver+0x110/0x110
> [   16.054912]  bus_for_each_dev+0x76/0xa0
> [   16.054923]  bus_add_driver+0x1b1/0x200
> [   16.055204]  driver_register+0x89/0xe0
> [   16.055211]  ? 0xffffffffc056e000
> [   16.055215]  do_one_initcall+0x6e/0x320
> [   16.055237]  do_init_module+0x4a/0x200
> [   16.055245]  __do_sys_init_module+0x16a/0x1a0
> [   16.055277]  do_syscall_64+0x5b/0x80
> [   16.055283]  ? lock_is_held_type+0xe8/0x140
> [   16.055294]  ? asm_exc_page_fault+0x22/0x30
> [   16.055301]  ? lockdep_hardirqs_on+0x7d/0x100
> [   16.055307]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

