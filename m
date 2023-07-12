Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD2EB64D9
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jul 2023 12:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGLMdh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 08:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjGLMdg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 08:33:36 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA2AA0
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 05:33:34 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so48993445e9.2
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 05:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689165212; x=1691757212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2HnIU1Yxrvuo/k4uXLTIBHPq+engBSqFG6lxaLJYMQ=;
        b=SouBukjI/dLQ9waXvtkMV25kmPLky0Zs48OT4raZas5MFSbdegvvnK/MH7v+BTYKNQ
         HsElg6iEDrgexeFAo7sx9pU8mvpN1cID9HmIgEzt3uAeDNI4XoZQZFEdQsZxNuFkn1Kf
         0jy28I9loovJsaW4bM69AGR4MFGQcrRPVwA82f56GSCPZej9v1bGTE9pq8bUgpx5bHGS
         BMjCE4X1MWj3WzMXdd772WV7br3B2zz/uyUqcdGwrV7pPfPGIoqtb7i7oJPjI11ZWXo5
         77V61foIA65QSbfe2PRxnSWY7gOGnQEguMg3LRmOCPYzvlcDXuXrt/HjGrrz7Y6m0r0V
         /MeQ==
X-Gm-Message-State: ABy/qLZJl7L/Uxp4lI75qDDa1nSNqhuGQeI2btvlxui2pI/J5BAX5TBq
        DwDchMyF7jGQwBDbgsfjxmQMAPNdvtc=
X-Google-Smtp-Source: APBJJlFW6b4dry422TteLFgclOTWHH4vxNKahakpMHHwqgj+UhpB+3zuwDosvfPPjP0NM9++uGqONw==
X-Received: by 2002:a05:600c:204c:b0:3fb:c217:722e with SMTP id p12-20020a05600c204c00b003fbc217722emr16175935wmg.33.1689165211938;
        Wed, 12 Jul 2023 05:33:31 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc7d6000000b003fbcdba1a63sm4969304wmk.12.2023.07.12.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 05:33:31 -0700 (PDT)
Date:   Wed, 12 Jul 2023 05:33:29 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        ave.jiang@intel.com
Subject: Re: [PATCH v2] cxl/acpi: Release device after dev_err()
Message-ID: <ZK6dmYrWJrSrQb15@gmail.com>
References: <20230711161704.3033220-1-leitao@debian.org>
 <ZK2RdpFO3aEqyFY6@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK2RdpFO3aEqyFY6@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jul 11, 2023 at 10:29:26AM -0700, Alison Schofield wrote:
> On Tue, Jul 11, 2023 at 09:17:04AM -0700, Breno Leitao wrote:
> > Kfence detected an user-after-free in the CXL driver. This happens in
> > the cxl_decoder_add() fail path. Kfence drops this message:
> > 
> >   BUG: KFENCE: use-after-free read in resource_string
> > 
> > This is happening in cxl_parse_cfmws(), where put_device() is called,
> > releasing cxld->dev, and then, later, dev_err(cxld->dev) is called
> > referencing the released device.
> 
> Hi Breno,
> 
> How do you see the above happening? I don't see a dev_err(cxld->dev)
> after the put. There is a dev_name(&cxld->dev), but it can never be
> reached after the put, because we return before that line is reached.
> 
> Like I said in v1 - maybe the only problem here is that the resource
> is not freed.

The message seems to be clear that we are using a component on the
dev_err() that was freed before in device_put(). Let's get more data to
discover what exactly, if it is not the device structure.

I've enabled KASAN in the kernel (6.4.2) to give us more information on
what is happening, and I was able to decode the stack as well. It tells
us where the memory was allocated, freed and re-used later.

  [  265.369387] cxl root0: Failed to populate active decoder targets
  [  265.382953] ==================================================================
  [  265.398951] BUG: KASAN: slab-use-after-free in cxl_parse_cfmws (drivers/cxl/acpi.c:299)
  [  265.413953] Read of size 8 at addr ffff888311c90380 by task swapper/0/1
  [  265.421954]
  [  265.438960] Hardware name: Wiwynn Great Lake POC/Great Lake, BIOS Y35GLE03 06/09/2023
  [  265.457954] Call Trace:
  [  265.457954]  <TASK>
  [  265.457954] dump_stack_lvl (lib/dump_stack.c:107)
  [  265.486982] ? preempt_count_add (kernel/sched/core.c:5815)
  [  265.486982] ? show_regs_print_info (lib/dump_stack.c:98)
  [  265.503961] ? log_buf_vmcoreinfo_setup (kernel/printk/printk.c:2346)
  [  265.503961] ? _printk (kernel/printk/printk.c:2354)
  [  265.526956] print_report (mm/kasan/report.c:352 mm/kasan/report.c:462)
  [  265.535950] ? __virt_addr_valid (./include/linux/mmzone.h:1901 ./include/linux/mmzone.h:1997 arch/x86/mm/physaddr.c:65)
  [  265.544951] ? __phys_addr (arch/x86/mm/physaddr.h:7 arch/x86/mm/physaddr.c:28)
  [  265.551956] ? cxl_parse_cfmws (drivers/cxl/acpi.c:299)
  [  265.558953] kasan_report (mm/kasan/report.c:?)
  [  265.568961] ? cxl_parse_cfmws (drivers/cxl/acpi.c:299)
  [  265.568961] cxl_parse_cfmws (drivers/cxl/acpi.c:299)
  [  265.568961] ? cxl_acpi_lock_reset_class (drivers/cxl/acpi.c:199)
  [  265.568961] ? __devres_alloc_node (drivers/base/devres.c:120 drivers/base/devres.c:167)
  [  265.601954] ? acpi_os_signal_semaphore (drivers/acpi/osl.c:?)
  [  265.601954] ? acpi_ut_release_mutex (drivers/acpi/acpica/utmutex.c:?)
  [  265.601954] ? acpi_get_table (drivers/acpi/acpica/tbxface.c:340)
  [  265.634959] ? cxl_acpi_lock_reset_class (drivers/cxl/acpi.c:199)
  [  265.634959] acpi_table_parse_entries_array (drivers/acpi/tables.c:358 drivers/acpi/tables.c:417)
  [  265.634959] ? ipmi_platform_add (drivers/acpi/tables.c:394)
  [  265.667955] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4291)
  [  265.678956] ? print_irqtrace_events (kernel/locking/lockdep.c:4290)
  [  265.689951] acpi_table_parse_cedt (drivers/acpi/tables.c:444)
  [  265.698958] ? acpi_table_print_madt_entry (drivers/acpi/tables.c:443)
  [  265.710954] ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:104 ./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
  [  265.710954] ? cxl_acpi_lock_reset_class (drivers/cxl/acpi.c:199)
  [  265.710954] ? devres_log (drivers/base/trace.h:41 drivers/base/devres.c:70)
  [  265.710954] ? __list_add_valid (lib/list_debug.c:30)
  [  265.745954] cxl_acpi_probe (drivers/cxl/acpi.c:?)
  [  265.745954] ? trigger_poison_list_store (drivers/cxl/acpi.c:628)
  [  265.767959] ? kernfs_put (./include/linux/instrumented.h:96 ./include/linux/atomic/atomic-instrumented.h:576 fs/kernfs/dir.c:539)
  [  265.767959] platform_probe (drivers/base/platform.c:1404)
  [  265.767959] really_probe (drivers/base/dd.c:? drivers/base/dd.c:658)
  [  265.767959] driver_probe_device (drivers/base/dd.c:830)
  [  265.767959] __driver_attach (drivers/base/dd.c:1217)
  [  265.767959] bus_for_each_dev (drivers/base/bus.c:367)
  [  265.818964] ? driver_attach (drivers/base/dd.c:1157)
  [  265.826959] ? bus_remove_file (drivers/base/bus.c:356)
  [  265.835952] bus_add_driver (drivers/base/bus.c:674)
  [  265.843954] driver_register (drivers/base/driver.c:247)
  [  265.852957] do_one_initcall (init/main.c:1246)
  [  265.854953] ? cxl_mem_driver_init (drivers/cxl/acpi.c:724)
  [  265.854953] ? efi_enabled (init/main.c:1237)
  [  265.854953] ? preempt_count_sub (kernel/sched/core.c:5839)
  [  265.887953] ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:104 ./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
  [  265.892961] ? _raw_spin_unlock (kernel/locking/spinlock.c:193)
  [  265.899958] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:162)
  [  265.899958] ? _raw_spin_lock (kernel/locking/spinlock.c:161)
  [  265.899958] ? stack_trace_save (kernel/stacktrace.c:123)
  [  265.899958] ? stack_trace_snprint (kernel/stacktrace.c:114)
  [  265.899958] ? filter_irq_stacks (kernel/stacktrace.c:395)
  [  265.954957] ? __stack_depot_save (lib/stackdepot.c:441)
  [  265.963958] ? kasan_set_track (mm/kasan/common.c:52)
  [  265.972950] ? kasan_set_track (mm/kasan/common.c:46 mm/kasan/common.c:52)
  [  265.981960] ? __kasan_kmalloc (mm/kasan/common.c:383)
  [  265.989954] ? __kmalloc (./include/linux/kasan.h:196 mm/slab_common.c:966 mm/slab_common.c:979)
  [  265.996957] ? kernel_init_freeable (init/main.c:1329 init/main.c:1354 init/main.c:1571)
  [  265.998954] ? kernel_init (init/main.c:1464)
  [  265.998954] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
  [  266.019957] ? rcu_is_watching (./arch/x86/include/asm/atomic.h:29 ./include/linux/context_tracking.h:122 kernel/rcu/tree.c:695)
  [  266.031960] ? lock_release (kernel/locking/lockdep.c:116 kernel/locking/lockdep.c:5718)
  [  266.033954] ? read_lock_is_recursive (kernel/locking/lockdep.c:5673)
  [  266.033954] ? __might_resched (kernel/sched/core.c:10118)
  [  266.033954] ? next_arg (lib/cmdline.c:266)
  [  266.033954] ? skip_spaces (lib/string_helpers.c:853)
  [  266.033954] ? parse_args (kernel/params.c:180)
  [  266.082957] ? ethnl_default_set_doit (kernel/params.c:171)
  [  266.082957] ? __kmem_cache_alloc_node (mm/slub.c:3451 mm/slub.c:3490)
  [  266.104959] ? kernel_init_freeable (init/main.c:1329 init/main.c:1354 init/main.c:1571)
  [  266.114954] ? kernel_init_freeable (init/main.c:1329 init/main.c:1354 init/main.c:1571)
  [  266.124959] kernel_init_freeable (init/main.c:1318 init/main.c:1335 init/main.c:1354 init/main.c:1571)
  [  266.135041] ? repair_env_string (init/main.c:1544)
  [  266.142954] ? _raw_spin_lock_irq (kernel/locking/spinlock.c:171)
  [  266.145957] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:169)
  [  266.160959] ? _raw_spin_unlock_irq (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:77 ./include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
  [  266.160959] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4399)
  [  266.177955] ? rest_init (init/main.c:1454)
  [  266.177955] kernel_init (init/main.c:1464)
  [  266.177955] ? rest_init (init/main.c:1454)
  [  266.177955] ret_from_fork (arch/x86/entry/entry_64.S:314)
  [  266.208957]  </TASK>

Allocation:

  [  266.208957] Allocated by task 1:
  [  266.225958] kasan_set_track (mm/kasan/common.c:46 mm/kasan/common.c:52)
  [  266.225958] __kasan_kmalloc (mm/kasan/common.c:383)
  [  266.245960] __kmalloc (./include/linux/kasan.h:196 mm/slab_common.c:966 mm/slab_common.c:979)
  [  266.253956] cxl_root_decoder_alloc (drivers/cxl/core/port.c:1599)
  [  266.263028] cxl_parse_cfmws (drivers/cxl/acpi.c:?)
  [  266.271963] acpi_table_parse_entries_array (drivers/acpi/tables.c:358 drivers/acpi/tables.c:417)
  [  266.278955] acpi_table_parse_cedt (drivers/acpi/tables.c:444)
  [  266.290958] cxl_acpi_probe (drivers/cxl/acpi.c:?)
  [  266.290958] platform_probe (drivers/base/platform.c:1404)
  [  266.290958] really_probe (drivers/base/dd.c:? drivers/base/dd.c:658)
  [  266.290958] driver_probe_device (drivers/base/dd.c:830)
  [  266.321954] __driver_attach (drivers/base/dd.c:1217)
  [  266.321954] bus_for_each_dev (drivers/base/bus.c:367)
  [  266.335959] bus_add_driver (drivers/base/bus.c:674)
  [  266.335959] driver_register (drivers/base/driver.c:247)
  [  266.354963] do_one_initcall (init/main.c:1246)
  [  266.354963] kernel_init_freeable (init/main.c:1318 init/main.c:1335 init/main.c:1354 init/main.c:1571)
  [  266.354963] kernel_init (init/main.c:1464)
  [  266.386951] ret_from_fork (arch/x86/entry/entry_64.S:314)

Free:

  [  266.398959] Freed by task 1:
  [  266.405955] kasan_set_track (mm/kasan/common.c:46 mm/kasan/common.c:52)
  [  266.413958] kasan_save_free_info (./include/linux/kasan.h:59 mm/kasan/generic.c:523)
  [  266.422954] ____kasan_slab_free (mm/kasan/common.c:238)
  [  266.430954] __kmem_cache_free (mm/slub.c:1807 mm/slub.c:3786 mm/slub.c:3799)
  [  266.430954] device_release (drivers/base/core.c:2488)
  [  266.430954] kobject_put (lib/kobject.c:687 lib/kobject.c:714 ./include/linux/kref.h:65 lib/kobject.c:731)
  [  266.430954] cxl_parse_cfmws (drivers/cxl/acpi.c:?)
  [  266.465954] acpi_table_parse_entries_array (drivers/acpi/tables.c:358 drivers/acpi/tables.c:417)
  [  266.465954] acpi_table_parse_cedt (drivers/acpi/tables.c:444)
  [  266.483958] cxl_acpi_probe (drivers/cxl/acpi.c:?)
  [  266.494971] platform_probe (drivers/base/platform.c:1404)
  [  266.494971] really_probe (drivers/base/dd.c:? drivers/base/dd.c:658)
  [  266.494971] driver_probe_device (drivers/base/dd.c:830)
  [  266.519092] __driver_attach (drivers/base/dd.c:1217)
  [  266.525962] bus_for_each_dev (drivers/base/bus.c:367)
  [  266.538961] bus_add_driver (drivers/base/bus.c:674)
  [  266.546958] driver_register (drivers/base/driver.c:247)
  [  266.555952] do_one_initcall (init/main.c:1246)
  [  266.562953] kernel_init_freeable (init/main.c:1318 init/main.c:1335 init/main.c:1354 init/main.c:1571)
  [  266.572957] kernel_init (init/main.c:1464)
  [  266.574954] ret_from_fork (arch/x86/entry/entry_64.S:314)
  [  266.588962]
  [  266.588962] The buggy address belongs to the object at ffff888311c90000
  [  266.588962]  which belongs to the cache kmalloc-2k of size 2048
  [  266.613962] The buggy address is located 896 bytes inside of
  [  266.613962]  freed 2048-byte region [ffff888311c90000, ffff888311c90800)
  [  266.613962]
  [  266.613962] The buggy address belongs to the physical page:
  [  266.652959] page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x311c90
  [  266.683955] head:(____ptrval____) order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
  [  266.701958] flags: 0xbfffe0000010200(slab|head|node=0|zone=2|lastcpupid=0x1ffff)
  [  266.716961] page_type: 0xffffffff()
  [  266.718953] raw: 0bfffe0000010200 ffff88828004d200 dead000000000122 0000000000000000
  [  266.718953] raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
  [  266.753954] page dumped because: kasan: bad access detected
  [  266.753954]
  [  266.753954] Memory state around the buggy address:
  [  266.781963]  ffff888311c90280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [  266.781963]  ffff888311c90300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [  266.808959] >ffff888311c90380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [  266.834953]                    ^
  [  266.841955]  ffff888311c90400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [  266.855954]  ffff888311c90480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  [  266.862954] ==================================================================
  [  266.890372] cxl_acpi ACPI0017:00: Failed to add decode range [0x4080000000 - 0x2baffffffff]
  [  266.908904] cxl root0: Failed to populate active decoder targets
  [  266.921887] cxl_acpi ACPI0017:00: Failed to add decode range [0x2bb00000000 - 0x5357fffffff]
  [  266.940899] cxl root0: Failed to populate active decoder targets
  [  266.953884] cxl_acpi ACPI0017:00: Failed to add decode range [0x53580000000 - 0x7afffffffff]
  [  266.972954] cxl root0: Failed to populate active decoder targets
  [  266.985963] cxl_acpi ACPI0017:00: Failed to add decode range [0x7b000000000 - 0xf1fffffffff]
