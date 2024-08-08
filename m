Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B1185E7A
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097613; cv=none; b=TjoHATkC6f/uoQpu4oEFQTK9h3eyhTVs556CJ6TTA1KKdrx0vXRAq8vsy3CMSA6Hwu+6n5ou1eVjHaKfpuO8hnNw9wzXny7N2jqPgjD6u17ATdZP+wqor43korQQOPHplLGKQ8VyOXXlOqk+ih2kUZ56YJ/eIvKFeorjOTnlV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097613; c=relaxed/simple;
	bh=KTEXZ4RSpnB3t5fJM71c9Uxi6diTSGcubMy40yHB1jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j8sDmeAbHrgODN7t1wS8yUjvAXLK85IJ7cxmnFOPgeBPUw9xH85Wf8llgm6TUye3xX6NlKUApCBw4Lzo3LWc3TZze1cbkxtaoJSWg342RhctI+DzBOe/mAKFUoqdCjIqEo8rxu4/LuNbHsAR+mdXymWFsT8MBrTpkQ3U9PuT3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BU4y0Lrs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BU4y0Lrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723097611; x=1754633611;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KTEXZ4RSpnB3t5fJM71c9Uxi6diTSGcubMy40yHB1jU=;
  b=BU4y0LrsdNPY540r0OLyapWK4Qou0oxOoYCKeFSTTg1HuM0DKmo5LsqB
   hSk5Z9Nhq6NnQ4KwDDkfLoaOQUBWZrRkfxBnqD2KWlHvgfLA/wdncgF3P
   2uymO9D9KJpbdaemY0cr94xyADVg0pMwRQIo5uvcrsQEPATDnzp8N4Gb2
   k3qb+OxGfEokrfZRJ+Nt1HI6HsGlwa3fnHCw9EbEMTfOCsh66oHd5pAO9
   r7RIE621X2Humd9S3/aJhjBqMe92NrkqSxjXeJsq4NX4UpJGTltFkvJU0
   4vWtko1D86VsyDrmqNCbD3GSEpdiKur/RaYEsi9szQpJCxIeSjS2edlkE
   w==;
X-CSE-ConnectionGUID: xOrasmSMQiuhVq5Q/qs/GA==
X-CSE-MsgGUID: 5gvgwI6NQcWnUIxqq7DJ8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32610123"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="32610123"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 23:13:29 -0700
X-CSE-ConnectionGUID: /joBH+fRRH2KolJwS90kZQ==
X-CSE-MsgGUID: 6vMUJMFjQ2mRDot6NyGdFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57070458"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 23:13:26 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Alison Schofield <alison.schofield@intel.com>,
  Vishal Verma <vishal.l.verma@intel.com>,  Lukas Wunner
 <lukas.wunner@intel.com>,  "Zanussi, Tom" <tom.zanussi@intel.com>,
  linux-cxl@vger.kernel.org,  linux-mm@vger.kernel.org
Subject: Re: Odd lockdep splat involving mt_adistance_algorithm
In-Reply-To: <66b44389e7b5f_71e8129499@iweiny-mobl.notmuch> (Ira Weiny's
	message of "Wed, 7 Aug 2024 23:03:21 -0500")
References: <66b44389e7b5f_71e8129499@iweiny-mobl.notmuch>
Date: Thu, 08 Aug 2024 14:09:53 +0800
Message-ID: <87wmkrzgsu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Ira,

Ira Weiny <ira.weiny@intel.com> writes:

> Ying,
>
> I'm working on the CXL DCD support[0].  After rebasing to v6.11-rc1+ I'm
> starting to see the following lockdep splat[1] in my testing.
>
> I don't understand how lockdep thinks there is a dependency between
> (mt_adistance_algorithms).rwsem and cxl_dax_region_key (the
> cxl_region->dev mutex).

IIUC cxl_dax_region_key is for cxl_dax_region->dev mutex.

> Do you have any insight into how the notifier rwsem gets associated with
> other locks?  I just don't see how the association in this splat is
> made.

In v6.11-rc1, a new dependency is added between cxl_dax_region_key and
(mt_adistance_algorithms).rwsem via commit 643e8e3e6529 ("cxl/region:
Support to calculate memory tier abstract distance").

When probe cxl_dax_region device, cxl_dax_region->dev mutex will be
acquired, then dev_dax_kmem_probe() will call
mt_calc_adistance() -> acquire (mt_adistance_algorithms).rwsem ->
cxl_region_calculate_adistance() -> cxl_region_nid() -> acquire
cxl_region_rwsem.

In your new code, cxl_dax_region->dev mutex may be acquired when
cxl_region_rwsem is held in the following call stack,

  cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core] <- cxl_dax_region_key
  cxled_add_extent+0x376/0x400 [cxl_core]
  cxl_mem_get_records_log+0x586/0x760 [cxl_core] <- cxl_region_rwsem cxl_handle_dcd_event_records()
  cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
  log_dc_event+0xc5/0x180 [cxl_mock_mem]
  __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
  kernfs_fop_write_iter+0x141/0x1f0
  vfs_write+0x262/0x500
  ksys_write+0x59/0xd0
  do_syscall_64+0x75/0x190
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

--
Best Regards,
Huang, Ying

> Thanks,
> Ira
>
> [0] https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-08-07
> [1] <splat>
>
> [   25.691773] ======================================================
> [   25.692509] WARNING: possible circular locking dependency detected
> [   25.693222] 6.11.0-rc1ira+ #20 Tainted: G           O     N
> [   25.693888] ------------------------------------------------------
> [   25.694599] bash/1161 is trying to acquire lock:
> [   25.695194] ffff888022ece0e8 (&cxl_dax_region_key){+.+.}-{4:4}, at: cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> [   25.696122] 
>                but task is already holding lock:
> [   25.697145] ffffffffa101fd70 (cxl_region_rwsem){++++}-{4:4}, at: cxl_mem_get_records_log+0x27f/0x760 [cxl_core]
> [   25.698069] 
>                which lock already depends on the new lock.
>
> [   25.699536] 
>                the existing dependency chain (in reverse order) is:
> [   25.700618] 
>                -> #3 (cxl_region_rwsem){++++}-{4:4}:
> [   25.701643]        down_read+0x2d/0x170
> [   25.702204]        cxl_region_calculate_adistance+0x20/0x90 [cxl_core]
> [   25.702922]        notifier_call_chain+0x40/0x100
> [   25.703526]        blocking_notifier_call_chain+0x41/0x60
> [   25.704158]        dev_dax_kmem_probe+0x40/0x380 [kmem]
> [   25.704778]        dax_bus_probe+0x6b/0xa0
> [   25.705351]        really_probe+0xd6/0x390
> [   25.705872]        __driver_probe_device+0x78/0x150
> [   25.706463]        driver_probe_device+0x1f/0x90
> [   25.707003]        __driver_attach+0xd2/0x1c0
> [   25.707547]        bus_for_each_dev+0x66/0xa0
> [   25.708067]        bus_add_driver+0x111/0x240
> [   25.708574]        driver_register+0x55/0x100
> [   25.709069]        0xffffffffa1172050
> [   25.709557]        do_one_initcall+0x60/0x2c0
> [   25.710060]        do_init_module+0x60/0x230
> [   25.710555]        init_module_from_file+0x75/0xa0
> [   25.711095]        idempotent_init_module+0xf9/0x270
> [   25.711643]        __x64_sys_finit_module+0x5a/0xb0
> [   25.712164]        do_syscall_64+0x75/0x190
> [   25.712651]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   25.713225] 
>                -> #2 ((mt_adistance_algorithms).rwsem){++++}-{4:4}:
> [   25.714117]        down_read+0x2d/0x170
> [   25.714567]        blocking_notifier_call_chain+0x27/0x60
> [   25.715095]        dev_dax_kmem_probe+0x40/0x380 [kmem]
> [   25.715610]        dax_bus_probe+0x6b/0xa0
> [   25.716043]        really_probe+0xd6/0x390
> [   25.716481]        __driver_probe_device+0x78/0x150
> [   25.716956]        driver_probe_device+0x1f/0x90
> [   25.717397]        __device_attach_driver+0x85/0x110
> [   25.717864]        bus_for_each_drv+0x6f/0xb0
> [   25.718296]        __device_attach+0xb0/0x1b0
> [   25.718703]        bus_probe_device+0x94/0xb0
> [   25.719119]        device_add+0x646/0x860
> [   25.719518]        __devm_create_dev_dax+0x19f/0x470
> [   25.719954]        devm_create_dev_dax+0x1d/0x40
> [   25.720393]        cxl_dax_region_probe+0xc8/0x110 [dax_cxl]
> [   25.720867]        cxl_bus_probe+0x17/0x50 [cxl_core]
> [   25.721329]        really_probe+0xd6/0x390
> [   25.721720]        __driver_probe_device+0x78/0x150
> [   25.722145]        driver_probe_device+0x1f/0x90
> [   25.722569]        __device_attach_driver+0x85/0x110
> [   25.723009]        bus_for_each_drv+0x6f/0xb0
> [   25.723414]        __device_attach+0xb0/0x1b0
> [   25.723809]        bus_probe_device+0x94/0xb0
> [   25.724206]        device_add+0x646/0x860
> [   25.724573]        cxl_region_probe+0x5ae/0x7c0 [cxl_core]
> [   25.725025]        cxl_bus_probe+0x17/0x50 [cxl_core]
> [   25.725465]        really_probe+0xd6/0x390
> [   25.725840]        __driver_probe_device+0x78/0x150
> [   25.726247]        driver_probe_device+0x1f/0x90
> [   25.726655]        __device_attach_driver+0x85/0x110
> [   25.727073]        bus_for_each_drv+0x6f/0xb0
> [   25.727463]        __device_attach+0xb0/0x1b0
> [   25.727838]        cxl_add_to_region+0x2ef/0x5b0 [cxl_core]
> [   25.728302]        discover_region+0x4b/0x80 [cxl_port]
> [   25.728726]        device_for_each_child+0x48/0x70
> [   25.729137]        cxl_port_probe+0x160/0x220 [cxl_port]
> [   25.729565]        cxl_bus_probe+0x17/0x50 [cxl_core]
> [   25.729984]        really_probe+0xd6/0x390
> [   25.730361]        __driver_probe_device+0x78/0x150
> [   25.730776]        driver_probe_device+0x1f/0x90
> [   25.731177]        __device_attach_driver+0x85/0x110
> [   25.731600]        bus_for_each_drv+0x6f/0xb0
> [   25.731982]        __device_attach+0xb0/0x1b0
> [   25.732378]        bus_probe_device+0x94/0xb0
> [   25.732770]        device_add+0x646/0x860
> [   25.733141]        devm_cxl_add_port+0x43d/0x760 [cxl_core]
> [   25.733595]        cxl_mem_probe+0x23f/0x350 [cxl_mem]
> [   25.734025]        cxl_bus_probe+0x17/0x50 [cxl_core]
> [   25.734453]        really_probe+0xd6/0x390
> [   25.734821]        __driver_probe_device+0x78/0x150
> [   25.735220]        driver_probe_device+0x1f/0x90
> [   25.735611]        __device_attach_driver+0x85/0x110
> [   25.736025]        bus_for_each_drv+0x6f/0xb0
> [   25.736412]        __device_attach+0xb0/0x1b0
> [   25.736788]        bus_rescan_devices_helper+0x39/0x80
> [   25.737207]        bus_rescan_devices+0x46/0x80
> [   25.737611]        cxl_bus_rescan_queue+0x11/0x30 [cxl_core]
> [   25.738080]        process_one_work+0x1f8/0x660
> [   25.738478]        worker_thread+0x1ca/0x3a0
> [   25.738861]        kthread+0xe0/0x110
> [   25.739209]        ret_from_fork+0x30/0x50
> [   25.739575]        ret_from_fork_asm+0x1a/0x30
> [   25.739958] 
>                -> #1 (dax_region_rwsem){+.+.}-{4:4}:
> [   25.740573]        down_write+0x2a/0xc0
> [   25.740930]        devm_create_dev_dax+0x15/0x40
> [   25.741322]        cxl_dax_region_probe+0xc8/0x110 [dax_cxl]
> [   25.741776]        cxl_bus_probe+0x17/0x50 [cxl_core]
> [   25.742201]        really_probe+0xd6/0x390
> [   25.742580]        __driver_probe_device+0x78/0x150
> [   25.743003]        driver_probe_device+0x1f/0x90
> [   25.743403]        __driver_attach+0xd2/0x1c0
> [   25.743780]        bus_for_each_dev+0x66/0xa0
> [   25.744167]        bus_add_driver+0x111/0x240
> [   25.744545]        driver_register+0x55/0x100
> [   25.744930]        do_one_initcall+0x60/0x2c0
> [   25.745308]        do_init_module+0x60/0x230
> [   25.745679]        init_module_from_file+0x75/0xa0
> [   25.746093]        idempotent_init_module+0xf9/0x270
> [   25.746499]        __x64_sys_finit_module+0x5a/0xb0
> [   25.746907]        do_syscall_64+0x75/0x190
> [   25.747277]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   25.747716] 
>                -> #0 (&cxl_dax_region_key){+.+.}-{4:4}:
> [   25.748351]        __lock_acquire+0x15a0/0x2320
> [   25.748750]        lock_acquire+0xd0/0x2e0
> [   25.749108]        __mutex_lock+0x7b/0xb60
> [   25.749479]        cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> [   25.749949]        cxled_add_extent+0x376/0x400 [cxl_core]
> [   25.750400]        cxl_mem_get_records_log+0x586/0x760 [cxl_core]
> [   25.750877]        cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
> [   25.751360]        log_dc_event+0xc5/0x180 [cxl_mock_mem]
> [   25.751788]        __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
> [   25.752333]        kernfs_fop_write_iter+0x141/0x1f0
> [   25.752742]        vfs_write+0x262/0x500
> [   25.753108]        ksys_write+0x59/0xd0
> [   25.753484]        do_syscall_64+0x75/0x190
> [   25.753851]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   25.754297] 
>                other info that might help us debug this:
>
> [   25.755143] Chain exists of:
>                  &cxl_dax_region_key --> (mt_adistance_algorithms).rwsem --> cxl_region_rwsem
>
> [   25.756258]  Possible unsafe locking scenario:
>
> [   25.756878]        CPU0                    CPU1
> [   25.757314]        ----                    ----
> [   25.757706]   rlock(cxl_region_rwsem);
> [   25.758067]                                lock((mt_adistance_algorithms).rwsem);
> [   25.758631]                                lock(cxl_region_rwsem);
> [   25.759126]   lock(&cxl_dax_region_key);
> [   25.759502] 
>                 *** DEADLOCK ***
>
> [   25.760242] 5 locks held by bash/1161:
> [   25.760619]  #0: ffff888008d7f3f8 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x59/0xd0
> [   25.761197]  #1: ffff888009589088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xf7/0x1f0
> [   25.761858]  #2: ffff88820881c9a8 (kn->active#154){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1f0
> [   25.762533]  #3: ffff8880170dd788 (&mds->event.log_lock){+.+.}-{4:4}, at: cxl_mem_get_records_log+0x5b/0x760 [cxl_core]
> [   25.763297]  #4: ffffffffa101fd70 (cxl_region_rwsem){++++}-{4:4}, at: cxl_mem_get_records_log+0x27f/0x760 [cxl_core]
> [   25.764050] 
>                stack backtrace:
> [   25.764621] CPU: 2 UID: 0 PID: 1161 Comm: bash Tainted: G           O     N 6.11.0-rc1ira+ #20
> [   25.765274] Tainted: [O]=OOT_MODULE, [N]=TEST
> [   25.765709] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-7.fc39 02/14/2024
> [   25.766389] Call Trace:
> [   25.766717]  <TASK>
> [   25.767013]  dump_stack_lvl+0x8f/0xe0
> [   25.767400]  check_noncircular+0x130/0x140
> [   25.767807]  __lock_acquire+0x15a0/0x2320
> [   25.768204]  lock_acquire+0xd0/0x2e0
> [   25.768588]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> [   25.769101]  ? __dynamic_dev_dbg+0x166/0x1d0
> [   25.769530]  __mutex_lock+0x7b/0xb60
> [   25.769913]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> [   25.770433]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> [   25.770939]  ? mark_held_locks+0x40/0x70
> [   25.771341]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> [   25.771867]  cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> [   25.772362]  ? __devm_add_action+0xbd/0xe0
> [   25.772796]  cxled_add_extent+0x376/0x400 [cxl_core]
> [   25.773269]  cxl_mem_get_records_log+0x586/0x760 [cxl_core]
> [   25.773780]  cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
> [   25.774273]  log_dc_event+0xc5/0x180 [cxl_mock_mem]
> [   25.774742]  __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
> [   25.775284]  kernfs_fop_write_iter+0x141/0x1f0
> [   25.775731]  vfs_write+0x262/0x500
> [   25.776124]  ksys_write+0x59/0xd0
> [   25.776511]  do_syscall_64+0x75/0x190
> [   25.776904]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   25.777385] RIP: 0033:0x7f5c0fb3bee4
> [   25.777771] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 74 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> [   25.779190] RSP: 002b:00007ffec4c72e48 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [   25.779815] RAX: ffffffffffffffda RBX: 0000000000000023 RCX: 00007f5c0fb3bee4
> [   25.780415] RDX: 0000000000000023 RSI: 000055ceeac88cd0 RDI: 0000000000000001
> [   25.781005] RBP: 00007ffec4c72e70 R08: 0000000000001428 R09: 0000000100000000
> [   25.781604] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000023
> [   25.782196] R13: 000055ceeac88cd0 R14: 00007f5c0fc0c5c0 R15: 00007f5c0fc09f20
> [   25.782813]  </TASK>
