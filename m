Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0436699
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 09:35:50 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sr2dq74Hfz67QZL
	for <linux-cxl@vger.kernel.org>; Thu, 14 Dec 2023 01:33:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E944F1400D5
	for <linux-cxl@vger.kernel.org>; Thu, 14 Dec 2023 01:35:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 17:35:47 +0000
Date: Wed, 13 Dec 2023 17:35:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sajjan Rao <sajjanr@gmail.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: Kernel panic when creating interleaved region
Message-ID: <20231213173546.00004265@Huawei.com>
In-Reply-To: <CAAg4PapN_SEUEo+OCwiMYtNpzcJPJDZ10gA2=ZOdc-mPyLPfQQ@mail.gmail.com>
References: <CAAg4PapN_SEUEo+OCwiMYtNpzcJPJDZ10gA2=ZOdc-mPyLPfQQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 1 Dec 2023 16:33:37 +0530
Sajjan Rao <sajjanr@gmail.com> wrote:

> I am trying to set up 2 memory devices in a CXL switch configuration
> with a 2k interleave. I am using the 6.4.11 kernel.
> When I create the region, the kernel panics after a few seconds. Has
> anyone seen this?
> Is there anything wrong with my QEMU configuration?

Using KVM?  Might not be the issue, but KVM is very much not compatible with
using the memory for instructions.

The trace doesn't look related but I thought I'd check.

Which QEMU version are you using for this so I can attempt to replicate?
Unfortunately we don't yet have CI up and running so could well be a problem
hiding. Also, what arch?

Busy time of year though, so not certain when I'll get to this.

Jonathan


> 
> My QEMU command line looks like this...
> 
>  -object memory-backend-ram,size=4G,id=m0 \
>  -object memory-backend-ram,size=256M,id=cxl-mem1 \
>  -object memory-backend-ram,size=256M,id=cxl-mem2 \
>  -numa node,memdev=m0,cpus=0-3,nodeid=0 \
>  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>  -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>  -device cxl-upstream,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
>  -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
>  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=8 \
>  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem1,id=cxl-vmem1 \
>  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem2,id=cxl-vmem2 \
>  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=512M,cxl-fmw.0.interleave-granularity=2k
> \
> 
> 
> # cxl list
> [
>   {
>     "memdev":"mem2",
>     "ram_size":268435456,
>     "serial":0,
>     "host":"0000:0f:00.0"
>   },
>   {
>     "memdev":"mem1",
>     "ram_size":268435456,
>     "serial":0,
>     "host":"0000:10:00.0"
>   }
> ]
> 
> 
> # cxl list -D
> [
>   {
>     "decoder":"decoder0.0",
>     "resource":6710886400,
>     "size":536870912,
>     "interleave_ways":1,
>     "max_available_extent":536870912,
>     "pmem_capable":true,
>     "volatile_capable":true,
>     "accelmem_capable":true,
>     "nr_targets":1
>   }
> ]
> [root@cxl-test ~]#
> 
> # cxl create-region -d decoder0.0 -m mem1 mem2 -w 2 -g 2048 -t ram
> [  447.515379] cxl region0: Bypassing cpu_cache_invalidate_memregion()
> for testing!
> {
>   "region":"region0",
>   "resource":"0x190000000",
>   "size":"512.00 MiB (536.87 MB)",
>   "type":"ram",
>   "interleave_ways":2,
>   "interleave_granularity":2048,
>   "decode_state":"commit",
>   "mappings":[
>     {
>       "position":1,
>       "memdev":"mem2",
>       "decoder":"decoder4.0"
>     },
>     {
>       "position":0,
>       "memdev":"mem1",
>       "decoder":"decoder3.0"
>     }
>   ]
> }
> cxl region: cmd_create_region: created 1 region
> [root@cxl-test ~]# [  447.948621] Fallback order for Node 1: 1 0
> [  447.950007] Built 1 zonelists, mobility grouping on.  Total pages: 973350
> [  447.950386] Policy zone: Normal
> [  448.007461] Fallback order for Node 0: 0 1
> [  448.007572] Fallback order for Node 1: 1 0
> [  448.011462] Built 2 zonelists, mobility grouping on.  Total pages: 1006118
> [  448.014883] Policy zone: Normal
> [  448.433721] general protection fault, probably for non-canonical
> address 0xfff788a01001ba00: 0000 [#1] PREEMPT SMP NOPTI
> [  448.433721] CPU: 1 PID: 1 Comm: systemd Tainted: G           O
>  6.4.11 #4
> [  448.433721] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  448.433721] RIP: 0010:__kmem_cache_alloc_node+0x1bc/0x310
> [  448.433721] Code: 2b 14 25 28 00 00 00 0f 85 68 01 00 00 48 83 c4
> 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 41 8b 47 28 4d 8b 07
> 48 01 f8 <48> 8b 18 48 89 c1 49 33 9f b8 00 00 00 48 89 f8 48 0f c9b
> [  448.433721] RSP: 0018:ffffa9dc80013d40 EFLAGS: 00000286
> [  448.433721] RAX: fff788a01001ba00 RBX: 0000000000000dc0 RCX: 0000000000000310
> [  448.433721] RDX: 0000000000bce001 RSI: 0000000000000dc0 RDI: fff788a01001b800
> [  448.433721] RBP: 0000000000000dc0 R08: 0000000000039160 R09: ffff889f8020ca10
> [  448.433721] R10: ffff889fbf7b5020 R11: 65732e302e307861 R12: 0000000000000000
> [  448.433721] R13: 00000000ffffffff R14: 0000000000000310 R15: ffff889f80042b00
> [  448.433721] FS:  00007fc881294940(0000) GS:ffff889ffbc80000(0000)
> knlGS:0000000000000000
> [  448.433721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  448.433721] CR2: fff788a01001ba00 CR3: 000000010254e000 CR4: 00000000000006e0
> [  448.433721] Call Trace:
> [  448.433721]  <TASK>
> [  448.433721]  ? die_addr+0x36/0x90
> [  448.433721]  ? exc_general_protection+0x1c5/0x430
> [  448.433721]  ? sidtab_context_to_sid+0x3b/0x410
> [  448.433721]  ? asm_exc_general_protection+0x26/0x30
> [  448.433721]  ? __kmem_cache_alloc_node+0x1bc/0x310
> [  448.433721]  ? psi_cgroup_alloc+0x29/0xb0
> [  448.433721]  kmalloc_trace+0x2a/0xa0
> [  448.433721]  psi_cgroup_alloc+0x29/0xb0
> [  448.447603]  cgroup_mkdir+0x1f0/0x470
> [  448.447603]  kernfs_iop_mkdir+0x5b/0x80
> [  448.447603]  vfs_mkdir+0x191/0x240
> [  448.447603]  do_mkdirat+0x146/0x170
> [  448.447603]  __x64_sys_mkdir+0x49/0x70
> [  448.447603]  do_syscall_64+0x60/0x90
> [  448.447603]  ? __irq_exit_rcu+0x4b/0xf0
> [  448.447603]  entry_SYSCALL_64_after_hwframe+0x77/0xe1
> [  448.447603] RIP: 0033:0x7fc881522d6b
> [  448.450700] Code: 8b 05 a1 30 0d 00 bb ff ff ff ff 64 c7 00 16 00
> 00 00 e9 62 ff ff ff e8 e3 1b 02 00 0f 1f 00 f3 0f 1e fa b8 53 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 69 30 0d8
> [  448.450700] RSP: 002b:00007ffc4bc7c228 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000053
> [  448.450700] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc881522d6b
> [  448.450700] RDX: 0000000000000000 RSI: 00000000000001ed RDI: 0000557aec888aa0
> [  448.450700] RBP: 00007ffc4bc7c260 R08: 00000000ffffff9c R09: 00007ffc4bc7c090
> [  448.450700] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc8818aeb03
> [  448.450700] R13: 0000557aec685200 R14: 0000000000000002 R15: 00000000000000a0
> [  448.450700]  </TASK>
> [  448.450700] Modules linked in: kmem device_dax dax_cxl nft_fib_inet
> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nfg
> [  448.490411] ---[ end trace 0000000000000000 ]---
> [  448.499413] RIP: 0010:__kmem_cache_alloc_node+0x1bc/0x310
> [  448.506716] Code: 2b 14 25 28 00 00 00 0f 85 68 01 00 00 48 83 c4
> 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 41 8b 47 28 4d 8b 07
> 48 01 f8 <48> 8b 18 48 89 c1 49 33 9f b8 00 00 00 48 89 f8 48 0f c9b
> [  448.519131] RSP: 0018:ffffa9dc80013d40 EFLAGS: 00000286
> [  448.525319] RAX: fff788a01001ba00 RBX: 0000000000000dc0 RCX: 0000000000000310
> [  448.531528] RDX: 0000000000bce001 RSI: 0000000000000dc0 RDI: fff788a01001b800
> [  448.538945] RBP: 0000000000000dc0 R08: 0000000000039160 R09: ffff889f8020ca10
> [  448.545020] R10: ffff889fbf7b5020 R11: 65732e302e307861 R12: 0000000000000000
> [  448.552119] R13: 00000000ffffffff R14: 0000000000000310 R15: ffff889f80042b00
> [  448.558219] FS:  00007fc881294940(0000) GS:ffff889ffbc80000(0000)
> knlGS:0000000000000000
> [  448.565881] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  448.572137] CR2: fff788a01001ba00 CR3: 000000010254e000 CR4: 00000000000006e0
> [  448.582019] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [  448.582580] Kernel Offset: 0x20000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  448.582580] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
> 

