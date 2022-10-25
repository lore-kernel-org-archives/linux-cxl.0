Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B11AC04A95
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 10:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJYK4y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJYK4w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 06:56:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A627CD9
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 03:56:50 -0700 (PDT)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxTL829bmz68B2F;
        Tue, 25 Oct 2022 18:52:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:56:18 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 11:56:18 +0100
Date:   Tue, 25 Oct 2022 11:56:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>, <ira.weiny@intel.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v9 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <20221025115617.000035b6@huawei.com>
In-Reply-To: <Y1bOniJliOFszvIK@memverge.com>
References: <20221014151045.24781-1-Jonathan.Cameron@huawei.com>
        <20221014151045.24781-5-Jonathan.Cameron@huawei.com>
        <Y1bOniJliOFszvIK@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 24 Oct 2022 13:42:54 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Oct 14, 2022 at 04:10:44PM +0100, Jonathan Cameron wrote:
> > From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > 
> > The CDAT can be specified in two ways. One is to add ",cdat=<filename>"
> > in "-device cxl-type3"'s command option. The file is required to provide
> > the whole CDAT table in binary mode. The other is to use the default
> > that provides some 'reasonable' numbers based on type of memory and
> > size.
> > 
> > The DOE capability supporting CDAT is added to hw/mem/cxl_type3.c with
> > capability offset 0x190. The config read/write to this capability range
> > can be generated in the OS to request the CDAT data.
> > 
> > Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > Signed-off-by: Chris Browy <cbrowy@avery-design.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> 
> In reviewing this patch under a debug kernel, I'm discovering some
> warnings / tracebacks that I want to get a sanity check on.  They appear
> to be warnings, but i'm not 100% sure what to make of them.
> 
> I get the following stack traces during boot (on the x86 machine).
> 
> Removing the type-3 device from the configuration prevents the traceback
> from occurring, suggesting it's something to do with that code in
> particular (which tracks with the patch here)

Thanks Gregory,

We have an INIT_WORK() in pci_doe_submit_task()
that in the pci_doe_discovery() call is based a work structure that is
on the stack.  As such should be INIT_WORK_ONSTACK()

This is a little tricky becaues there is no particular reason to assume
all struct pci_doe_task instances will be on the stack though they are
today.  We don't really want to break the layering as would be necessary
to have this init at the locations where we otherwise initialize the
containing structure.

My first thought is add an 'onstack' bool to either the pci_doe_submit_task()
or perhaps better would be to add it to the pci_doe_task() and have
macros like DECLARE_CDAT_DOE_TASK_ONSTACK() set it appropriately so we
can call the right INIT_WORK_*() variant later.

Ira / others, which way to go to fix this?

I'll also reply to the last version of that series to make sure people see
this discussion.

Jonathan



> 
> configuration:
> 
> qemu-system-x86_64 -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
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
> ==== trace 1 ====
> 
> [   30.607343] WARNING: CPU: 0 PID: 23 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
> [   30.688367] Modules linked in:
> [   30.703848] CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 #1
> [   30.794232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   30.862301] Workqueue: events_unbound async_run_entry_fn
> [   30.890460] RIP: 0010:__debug_object_init.cold+0x18/0x183
> [   30.917120] Code: 0b 48 89 fe 48 c7 c7 e0 a7 9a b6 e8 50 74 fd ff 0f 0b 83 c0 01 48 89 ee 48 c7 c7 d8 a9 9a b6 89 05 f9 d7 bd 03 e8 36 74 fd 0
> [   31.019141] RSP: 0018:ffffbffb800c3a90 EFLAGS: 00010246
> [   31.043604] RAX: 0000000000000050 RBX: ffff9bbec8f7c1b8 RCX: 0000000000000000
> [   31.103764] RDX: 0000000000000001 RSI: 00000000ffffdfff RDI: 00000000ffffffff
> [   31.134239] RBP: ffffbffb800c3bb0 R08: 0000000000000000 R09: ffffbffb800c3938
> [   31.188841] R10: 0000000000000003 R11: ffffffffb7366368 R12: ffffffffb6440940
> [   31.218418] R13: 0000000000130b50 R14: ffffffffb9c33b58 R15: ffffffffb9c33b50
> [   31.273389] FS:  0000000000000000(0000) GS:ffff9bbf3da00000(0000) knlGS:0000000000000000
> [   31.315480] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.352369] CR2: 00007fcd1cd57c08 CR3: 0000000049228000 CR4: 00000000000006f0
> [   31.397279] Call Trace:
> [   31.412605]  <TASK>
> [   31.424189]  pci_doe_submit_task+0x5d/0xd0
> [   31.459591]  pci_doe_discovery+0xb4/0x100
> [   31.478560]  ? pci_doe_xa_destroy+0x10/0x10
> [   31.499449]  pcim_doe_create_mb+0x219/0x290
> [   31.516835]  cxl_pci_probe+0x192/0x430
> [   31.532501]  local_pci_probe+0x41/0x80
> [   31.549181]  pci_device_probe+0xb3/0x220
> [   31.587266]  really_probe+0xde/0x380
> [   31.601778]  ? pm_runtime_barrier+0x50/0x90
> [   31.618854]  __driver_probe_device+0x78/0x170
> [   31.656184]  driver_probe_device+0x1f/0x90
> [   31.675865]  __driver_attach_async_helper+0x5c/0xe0
> [   31.692896]  async_run_entry_fn+0x30/0x130
> [   31.707297]  process_one_work+0x294/0x5b0
> [   31.722375]  worker_thread+0x4f/0x3a0
> [   31.741028]  ? process_one_work+0x5b0/0x5b0
> [   31.757448]  kthread+0xf5/0x120
> [   31.770179]  ? kthread_complete_and_exit+0x20/0x20
> [   31.806496]  ret_from_fork+0x22/0x30
> [   31.831317]  </TASK>
> [   31.840206] irq event stamp: 1597
> [   31.853893] hardirqs last  enabled at (1611): [<ffffffffb518e8de>] __up_console_sem+0x5e/0x70
> [   31.908805] hardirqs last disabled at (1624): [<ffffffffb518e8c3>] __up_console_sem+0x43/0x70
> [   31.965293] softirqs last  enabled at (354): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
> [   32.000551] softirqs last disabled at (345): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
> [   32.121265] ---[ end trace 0000000000000000 ]---
> 
> 
> ==== trace 2 ====
> 
> [   99.902268] WARNING: CPU: 0 PID: 530 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
> [   99.921567] Modules linked in: i2c_i801(+) cxl_mem(+) bochs(+) pcspkr(+) drm_vram_helper i2c_smbus drm_ttm_helper ttm parport_pc(+) lpc_ich pg
> [   99.956391] CPU: 0 PID: 530 Comm: systemd-udevd Tainted: G        W         -------  ---  6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 1
> [   99.978561] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [  100.000618] RIP: 0010:__debug_object_init.cold+0x18/0x183
> [  100.011232] Code: 0b 48 89 fe 48 c7 c7 e0 a7 9a b6 e8 50 74 fd ff 0f 0b 83 c0 01 48 89 ee 48 c7 c7 d8 a9 9a b6 89 05 f9 d7 bd 03 e8 36 74 fd 0
> [  100.047919] RSP: 0018:ffffbffb80c6b770 EFLAGS: 00010246
> [  100.060167] RAX: 0000000000000050 RBX: ffff9bbec9448b40 RCX: 0000000000000000
> [  100.080397] RDX: 0000000000000001 RSI: ffffffffb698ef83 RDI: 00000000ffffffff
> [  100.099485] RBP: ffffbffb80c6b918 R08: 0000000000000000 R09: ffffbffb80c6b618
> [  100.116927] R10: 0000000000000003 R11: ffffffffb7366368 R12: ffffffffb6440940
> [  100.134762] R13: 00000000000ec680 R14: ffffffffb9bef688 R15: ffffffffb9bef680
> [  100.151144] FS:  00007f485962c580(0000) GS:ffff9bbf3da00000(0000) knlGS:0000000000000000
> [  100.168115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  100.181757] CR2: 000055f120bfa028 CR3: 0000000009598000 CR4: 00000000000006f0
> [  100.196873] Call Trace:
> [  100.205142]  <TASK>
> [  100.211998]  pci_doe_submit_task+0x5d/0xd0
> [  100.225314]  cxl_cdat_get_length+0xb8/0x110
> [  100.237607]  ? dvsec_range_allowed+0x60/0x60
> [  100.251315]  read_cdat_data+0xaf/0x1a0
> [  100.259359]  cxl_port_probe+0x80/0x120
> [  100.270131]  cxl_bus_probe+0x17/0x50
> [  100.280874]  really_probe+0xde/0x380
> [  100.290308]  ? pm_runtime_barrier+0x50/0x90
> [  100.301589]  __driver_probe_device+0x78/0x170
> [  100.313626]  driver_probe_device+0x1f/0x90
> [  100.338204]  __device_attach_driver+0x85/0x110
> [  100.357875]  ? driver_allows_async_probing+0x70/0x70
> [  100.367909]  bus_for_each_drv+0x7a/0xb0
> [  100.376261]  __device_attach+0xb3/0x1d0
> [  100.384565]  bus_probe_device+0x9f/0xc0
> [  100.403420]  device_add+0x41e/0x9b0
> [  100.424240]  ? kobject_set_name_vargs+0x6d/0x90
> [  100.437082]  ? dev_set_name+0x4b/0x60
> [  100.452290]  devm_cxl_add_port+0x27b/0x3b0
> [  100.477464]  devm_cxl_add_endpoint+0x82/0x130
> [  100.506916]  cxl_mem_probe+0xc4/0x11d [cxl_mem]
> [  100.525895]  cxl_bus_probe+0x17/0x50
> [  100.556013]  really_probe+0xde/0x380
> [  100.567388]  ? pm_runtime_barrier+0x50/0x90
> [  100.604187]  __driver_probe_device+0x78/0x170
> [  100.623848]  driver_probe_device+0x1f/0x90
> [  100.643793]  __driver_attach+0xd5/0x1d0
> [  100.655270]  ? __device_attach_driver+0x110/0x110
> [  100.668906]  bus_for_each_dev+0x76/0xa0
> [  100.684247]  bus_add_driver+0x1b1/0x200
> [  100.694768]  driver_register+0x89/0xe0
> [  100.706379]  ? 0xffffffffc03e7000
> [  100.715846]  do_one_initcall+0x6e/0x320
> [  100.726612]  do_init_module+0x4a/0x200
> [  100.738882]  __do_sys_init_module+0x16a/0x1a0
> [  100.752941]  do_syscall_64+0x5b/0x80
> [  100.766652]  ? do_syscall_64+0x67/0x80
> [  100.779569]  ? asm_exc_page_fault+0x22/0x30
> [  100.794089]  ? lockdep_hardirqs_on+0x7d/0x100
> [  100.813769]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  100.829029] RIP: 0033:0x7f485991253e
> [  100.840991] Code: 48 8b 0d e5 58 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 8
> [  100.904842] RSP: 002b:00007ffd96d322b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> [  100.936376] RAX: ffffffffffffffda RBX: 000055f120b724b0 RCX: 00007f485991253e
> [  100.971138] RDX: 00007f4859f9643c RSI: 0000000000002dbe RDI: 000055f120bdd000
> [  101.016019] RBP: 00007f4859f9643c R08: 000055f120bd47f0 R09: 00007ffd96d2ef1e
> [  101.042435] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000020000
> [  101.073437] R13: 000055f120bd4530 R14: 0000000000000000 R15: 000055f120bd4860
> [  101.120278]  </TASK>
> [  101.132024] irq event stamp: 102985
> [  101.153401] hardirqs last  enabled at (102999): [<ffffffffb518e8de>] __up_console_sem+0x5e/0x70
> [  101.184098] hardirqs last disabled at (103014): [<ffffffffb518e8c3>] __up_console_sem+0x43/0x70
> [  101.236473] softirqs last  enabled at (101888): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
> [  101.294275] softirqs last disabled at (101757): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
> 
> 
> ==== trace 3 ====
> 
> [  111.356606] WARNING: CPU: 0 PID: 530 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
> [  111.366842] Modules linked in: iTCO_wdt ppdev intel_pmc_bxt iTCO_vendor_support cxl_pmem libnvdimm snd_pcm snd_timer snd e1000e soundcore joyg
> [  111.396404] CPU: 0 PID: 530 Comm: systemd-udevd Tainted: G        W         -------  ---  6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 1
> [  111.410199] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [  111.422370] RIP: 0010:__debug_object_init.cold+0x18/0x183
> [  111.429086] Code: 0b 48 89 fe 48 c7 c7 e0 a7 9a b6 e8 50 74 fd ff 0f 0b 83 c0 01 48 89 ee 48 c7 c7 d8 a9 9a b6 89 05 f9 d7 bd 03 e8 36 74 fd 0
> [  111.453462] RSP: 0000:ffffbffb80c6b748 EFLAGS: 00010246
> [  111.463194] RAX: 0000000000000050 RBX: ffff9bbec84818e8 RCX: 0000000000000000
> [  111.472081] RDX: 0000000000000001 RSI: ffffffffb698ef83 RDI: 00000000ffffffff
> [  111.481240] RBP: ffffbffb80c6b908 R08: 0000000000000000 R09: ffffbffb80c6b5f0
> [  111.490230] R10: 0000000000000003 R11: ffffffffb7366368 R12: ffffffffb6440940
> [  111.499437] R13: 00000000000ec680 R14: ffffffffb9bef688 R15: ffffffffb9bef680
> [  111.507544] FS:  00007f485962c580(0000) GS:ffff9bbf3da00000(0000) knlGS:0000000000000000
> [  111.518473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  111.529110] CR2: 000055ea819dc228 CR3: 0000000009598000 CR4: 00000000000006f0
> [  111.539622] Call Trace:
> [  111.543604]  <TASK>
> [  111.547146]  pci_doe_submit_task+0x5d/0xd0
> [  111.553235]  cxl_cdat_read_table.isra.0+0x141/0x190
> [  111.559888]  ? dvsec_range_allowed+0x60/0x60
> [  111.566950]  read_cdat_data+0xfc/0x1a0
> [  111.572438]  cxl_port_probe+0x80/0x120
> [  111.579219]  cxl_bus_probe+0x17/0x50
> [  111.586051]  really_probe+0xde/0x380
> [  111.592435]  ? pm_runtime_barrier+0x50/0x90
> [  111.598580]  __driver_probe_device+0x78/0x170
> [  111.604947]  driver_probe_device+0x1f/0x90
> [  111.610825]  __device_attach_driver+0x85/0x110
> [  111.616997]  ? driver_allows_async_probing+0x70/0x70
> [  111.623939]  bus_for_each_drv+0x7a/0xb0
> [  111.629126]  __device_attach+0xb3/0x1d0
> [  111.634907]  bus_probe_device+0x9f/0xc0
> [  111.641211]  device_add+0x41e/0x9b0
> [  111.650591]  ? kobject_set_name_vargs+0x6d/0x90
> [  111.659416]  ? dev_set_name+0x4b/0x60
> [  111.665160]  devm_cxl_add_port+0x27b/0x3b0
> [  111.671486]  devm_cxl_add_endpoint+0x82/0x130
> [  111.677424]  cxl_mem_probe+0xc4/0x11d [cxl_mem]
> [  111.684237]  cxl_bus_probe+0x17/0x50
> [  111.690079]  really_probe+0xde/0x380
> [  111.695487]  ? pm_runtime_barrier+0x50/0x90
> [  111.702526]  __driver_probe_device+0x78/0x170
> [  111.710317]  driver_probe_device+0x1f/0x90
> [  111.716468]  __driver_attach+0xd5/0x1d0
> [  111.721786]  ? __device_attach_driver+0x110/0x110
> [  111.728178]  bus_for_each_dev+0x76/0xa0
> [  111.736175]  bus_add_driver+0x1b1/0x200
> [  111.741584]  driver_register+0x89/0xe0
> [  111.747214]  ? 0xffffffffc03e7000
> [  111.753161]  do_one_initcall+0x6e/0x320
> [  111.759145]  do_init_module+0x4a/0x200
> [  111.773055]  __do_sys_init_module+0x16a/0x1a0
> [  111.782164]  do_syscall_64+0x5b/0x80
> [  111.788480]  ? do_syscall_64+0x67/0x80
> [  111.795108]  ? asm_exc_page_fault+0x22/0x30
> [  111.803255]  ? lockdep_hardirqs_on+0x7d/0x100
> [  111.811142]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  111.818426] RIP: 0033:0x7f485991253e
> [  111.824120] Code: 48 8b 0d e5 58 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 8
> [  111.873034] RSP: 002b:00007ffd96d322b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> [  111.888776] RAX: ffffffffffffffda RBX: 000055f120b724b0 RCX: 00007f485991253e
> [  111.913156] RDX: 00007f4859f9643c RSI: 0000000000002dbe RDI: 000055f120bdd000
> [  111.931096] RBP: 00007f4859f9643c R08: 000055f120bd47f0 R09: 00007ffd96d2ef1e
> [  111.945030] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000020000
> [  111.959393] R13: 000055f120bd4530 R14: 0000000000000000 R15: 000055f120bd4860
> [  111.987474]  </TASK>
> [  112.002511] irq event stamp: 104291
> [  112.011044] hardirqs last  enabled at (104307): [<ffffffffb518e8de>] __up_console_sem+0x5e/0x70
> [  112.046936] hardirqs last disabled at (104320): [<ffffffffb518e8c3>] __up_console_sem+0x43/0x70
> [  112.066433] softirqs last  enabled at (103208): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
> [  112.086461] softirqs last disabled at (103183): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
> [  112.107575] ---[ end trace 0000000000000000 ]---

