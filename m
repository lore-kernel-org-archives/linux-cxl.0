Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339025D549
	for <linux-cxl@vger.kernel.org>; Mon,  5 May 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458322; cv=none; b=XSMnRMNTJgOpbJFK+M7TKOYyn/sbu0nXNReqZ1y0RnT/KuR1VY5z2lBLv84RFt3zpzlTLh7GggOV+3M/Kt1oFK6eF5njeXL/hiT0RtdNPG9bZzR0LoVNWrr/U11ITL8YKfJhm6N/vp1Zvngo3jUq6nKi095qdGt4gEl1JZHdnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458322; c=relaxed/simple;
	bh=KJAM/F/GAWHknM7yF+EGxGOASDGY/+3DqH6t/EcCpGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HpeBgFNeK3Rda1Xs1c6W4mY2ef1ECQHG97ca3q7HZ1w4LABHWFOc1gqJPVN+BsokGVA3bHEPPQcgPExKWw2ADfqNt5ol1NgT7Zjen8Gg+zuH0p1qP4ldFLHjhwXIkZ1wvRA2A63v5pWPrCnp24sI27Ati0ApfRhkL6Wat+PChEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxK7PTmd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxK7PTmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746458319; x=1777994319;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=KJAM/F/GAWHknM7yF+EGxGOASDGY/+3DqH6t/EcCpGU=;
  b=KxK7PTmd9aoVlf4ThmBZxjDHbQ6AYJguiL3eBJmPCtFOs0wvHdIqrfvz
   ClUcRWZI0jdtE+s6V6uLXcyTEahgDwL7g8RyDBPBehR7UykWecHbytwEM
   xgXtEDbxEMid1eXQ/+oWZzusZU75m7HPAct2ta++u5O1EdlxY/dfQl82q
   5t05AmI0xoFN6/74sz3WsrYAz0k+QPyzlgL38ZAPVdTcQp8bqNbX9MP8a
   VLdabFakWKCru3wrNaUOv96YinUbH2enR0mp13UbzlaZaf6+6w4x5uqkR
   D7mCWR1ijvWgY3+ogwWmvOQa3CntbpCoPWYx53UrQxrro864SMg4tWAJ4
   A==;
X-CSE-ConnectionGUID: 7/J0mZfnSzC02HCb6JPMAg==
X-CSE-MsgGUID: E3mpexA6S8ipuBxWXf9ulA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51724465"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="51724465"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 08:18:39 -0700
X-CSE-ConnectionGUID: IJWNGtt5TPqhOp7ouTZZFQ==
X-CSE-MsgGUID: RgDVhi9FTvCblifVtJShYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="140074584"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.111.34]) ([10.125.111.34])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 08:18:38 -0700
Message-ID: <a31b071b-e683-4da1-9c5a-2578978bd768@intel.com>
Date: Mon, 5 May 2025 08:18:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request for help on CXL kernel panic with recent QEMU/Linux
To: "Parthasarathy, Mohan (Compute)" <mohan_parthasarathy@hpe.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Shiju Jose <shiju.jose@huawei.com>
References: <PH7PR84MB1582216A28E1632187113016888F2@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <PH7PR84MB1582216A28E1632187113016888F2@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/4/25 1:22 AM, Parthasarathy, Mohan (Compute) wrote:
> Hi all,
> 
> Can anyone take a look and see if this a known issue ? Also, any tips on whether the issue is likely with my Linux version or QEMU ? I can share more details if required but just wanted to know if this looks obvious to expert eyes.

kernel version?

Also running ./scripts/faddr2line on cxl_internal_send_cmd+0x3c/0xf0 and devm_cxl_setup_features.cold+0x43/0x43 would be helpful.

I've not seen that on my qemu setup with 6.15-rc4. I'm also using upstream qemu. So your kernel version and qemu version and passed in parameters would be helpful. 

Shiju,
Have you encountered anything like this with your Features testing with RAS on qemu?

> 
> Regards,
> Mohan
> 
> 
> 
> [   57.988032] ------------[ cut here ]------------
> [   57.990637] memcpy: detected buffer overflow: 96 byte write of buffer size 0
> [   57.994123] WARNING: CPU: 0 PID: 46 at lib/string_helpers.c:1032 __fortify_report+0x55/0xa0
> [   58.001055] Modules linked in: cxl_pci i2c_i801(+) irqbypass vfat pcspkr fat i2c_smbus mctp_i2c(+) parport_pc(+) cxl_acpi i2c_mux parport cxl_port cxl_core e1000e einj lpc_ich bochs loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram vmw_vmci qemu_fw_cfg serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse
> [   58.016135] CPU: 0 UID: 0 PID: 46 Comm: kworker/u16:2 Not tainted 6.15.0-rc4-mohan+ #4 PREEMPT(voluntary)
> [   58.021711] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   58.025755] Workqueue: async async_run_entry_fn
> [   58.029028] RIP: 0010:__fortify_report+0x55/0xa0
> [   58.032915] Code: 01 48 8b 34 c5 20 1f 73 b9 48 c7 c1 06 58 f2 b9 48 c7 c0 fc 57 f2 b9 48 0f 44 c8 4c 89 ca 48 c7 c7 d8 ef e3 b9 e8 bb 2e 80 ff <0f> 0b 48 83 c4 20 c3 cc cc cc cc 48 89 74 24 10 48 89 c6 89 7c 24
> [   58.039451] RSP: 0018:ffffd248801a3a38 EFLAGS: 00010246
> [   58.047157] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
> [   58.053599] RDX: ffff88abbbc1ca88 RSI: 0000000000000001 RDI: ffff88abbbc1ca80
> [   58.059967] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffd248801a38d8
> [   58.064773] R10: ffffffffba939ac8 R11: 00000000ffffdfff R12: 0000000000000000
> [   58.075635] R13: 0000000000000000 R14: ffff88ab4007c800 R15: 0000000000000002
> [   58.084667] FS:  0000000000000000(0000) GS:ffff88ac0052b000(0000) knlGS:0000000000000000
> [   58.096028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   58.106050] CR2: 00007fbd45b4b058 CR3: 0000000115109000 CR4: 00000000000006f0
> [   58.117482] Call Trace:
> [   58.121907]  <TASK>
> [   58.129551]  ? cxl_internal_send_cmd+0x3c/0xf0 [cxl_core]
> [   58.139570]  __fortify_panic+0xd/0xf
> [   58.146273]  devm_cxl_setup_features.cold+0x43/0x43 [cxl_core]
> [   58.153161]  cxl_pci_probe+0x431/0xa90 [cxl_pci]
> [   58.158287]  ? kernfs_xattr_get+0x3b/0x70
> [   58.161167]  ? selinux_kernfs_init_security+0x74/0x250
> [   58.167922]  ? try_to_wake_up+0x7f/0x760
> [   58.170137]  local_pci_probe+0x42/0x90
> [   58.172399]  pci_device_probe+0xda/0x2b0
> [   58.177444]  ? sysfs_do_create_link_sd+0x6d/0xd0
> [   58.182205]  really_probe+0xde/0x340
> [   58.190234]  ? pm_runtime_barrier+0x55/0x90
> [   58.192903]  __driver_probe_device+0x78/0x140
> [   58.197956]  driver_probe_device+0x1f/0xa0
> [   58.203673]  __driver_attach_async_helper+0x5e/0xe0
> [   58.208474]  async_run_entry_fn+0x34/0x130
> [   58.217941]  process_one_work+0x18e/0x350
> [   58.221932]  worker_thread+0x25a/0x3a0
> [   58.223804]  ? __pfx_worker_thread+0x10/0x10
> [   58.229040]  kthread+0xfc/0x240
> [   58.237142]  ? __pfx_kthread+0x10/0x10
> [   58.246321]  ret_from_fork+0x34/0x50
> [   58.253927]  ? __pfx_kthread+0x10/0x10
> [   58.261905]  ret_from_fork_asm+0x1a/0x30
> [   58.267821]  </TASK>
> [   58.269775] ---[ end trace 0000000000000000 ]---
> [   58.274065] ------------[ cut here ]------------
> [   58.282586] kernel BUG at lib/string_helpers.c:1040!
> [   58.293976] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [   58.299430] audit: type=1130 audit(1746252020.305:32): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-random-seed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   58.299474] CPU: 0 UID: 0 PID: 46 Comm: kworker/u16:2 Tainted: G        W           6.15.0-rc4-mohan+ #4 PREEMPT(voluntary)
> [   58.313086] Tainted: [W]=WARN
> [   58.317049] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   58.322714] Workqueue: async async_run_entry_fn
> [   58.329051] RIP: 0010:__fortify_panic+0xd/0xf
> [   58.332500] Code: e9 dc d9 95 00 e9 02 da 95 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 d3 f2 95 00 <0f> 0b 48 8b 54 24 10 48 8b 74 24 08 4c 89 e1 48 c7 c7 90 2e ef b9
> [   58.339956] RSP: 0018:ffffd248801a3a60 EFLAGS: 00010282
> [   58.348114] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
> [   58.356607] RDX: ffff88abbbc1ca88 RSI: 0000000000000001 RDI: ffff88abbbc1ca80
> [   58.360981] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffd248801a38d8
> [   58.366267] R10: ffffffffba939ac8 R11: 00000000ffffdfff R12: 0000000000000000
> [   58.369804] R13: 0000000000000000 R14: ffff88ab4007c800 R15: 0000000000000002
> [   58.376177] FS:  0000000000000000(0000) GS:ffff88ac0052b000(0000) knlGS:0000000000000000
> [   58.380150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   58.384364] CR2: 00007fbd45b4b058 CR3: 0000000115109000 CR4: 00000000000006f0
> [   58.387660] Call Trace:
> [   58.390086]  <TASK>
> [   58.392804]  devm_cxl_setup_features.cold+0x43/0x43 [cxl_core]
> [   58.395791]  cxl_pci_probe+0x431/0xa90 [cxl_pci]
> [   58.409127]  ? kernfs_xattr_get+0x3b/0x70
> [   58.415392]  ? selinux_kernfs_init_security+0x74/0x250
> [   58.420775]  ? try_to_wake_up+0x7f/0x760
> [   58.423879]  local_pci_probe+0x42/0x90
> [   58.429026]  pci_device_probe+0xda/0x2b0
> [   58.433175]  ? sysfs_do_create_link_sd+0x6d/0xd0
> [   58.438630]  really_probe+0xde/0x340
> [   58.440769]  ? pm_runtime_barrier+0x55/0x90
> [   58.442846]  __driver_probe_device+0x78/0x140
> [   58.445598]  driver_probe_device+0x1f/0xa0
> [   58.448532]  __driver_attach_async_helper+0x5e/0xe0
> [   58.451848]  async_run_entry_fn+0x34/0x130
> [   58.456739]  process_one_work+0x18e/0x350
> [   58.462118]  worker_thread+0x25a/0x3a0
> [   58.467050]  ? __pfx_worker_thread+0x10/0x10
> [   58.470596]  kthread+0xfc/0x240
> [   58.474475]  ? __pfx_kthread+0x10/0x10
> [   58.477836]  ret_from_fork+0x34/0x50
> [   58.480791]  ? __pfx_kthread+0x10/0x10
> [   58.484168]  ret_from_fork_asm+0x1a/0x30
> [   58.487363]  </TASK>
> [   58.490697] Modules linked in: cxl_pci i2c_i801 irqbypass vfat pcspkr fat i2c_smbus mctp_i2c parport_pc(+) cxl_acpi i2c_mux parport cxl_port cxl_core e1000e einj lpc_ich bochs loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram vmw_vmci qemu_fw_cfg serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse
> [   58.505259] ---[ end trace 0000000000000000 ]---
> [   58.509396] RIP: 0010:__fortify_panic+0xd/0xf
> [   58.512731] Code: e9 dc d9 95 00 e9 02 da 95 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 d3 f2 95 00 <0f> 0b 48 8b 54 24 10 48 8b 74 24 08 4c 89 e1 48 c7 c7 90 2e ef b9
> [   58.520925] RSP: 0018:ffffd248801a3a60 EFLAGS: 00010282
> [   58.524495] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
> [   58.528365] RDX: ffff88abbbc1ca88 RSI: 0000000000000001 RDI: ffff88abbbc1ca80
> [   58.532956] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffd248801a38d8
> [   58.536365] R10: ffffffffba939ac8 R11: 00000000ffffdfff R12: 0000000000000000
> [   58.540179] R13: 0000000000000000 R14: ffff88ab4007c800 R15: 0000000000000002
> [   58.546765] FS:  0000000000000000(0000) GS:ffff88ac0052b000(0000) knlGS:0000000000000000
> [   58.550843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   58.554470] CR2: 00007fbd45b4b058 CR3: 0000000115109000 CR4: 00000000000006f0
> [   59.773090] iTCO_vendor_support: vendor-support=0
> 

