Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2C288C9F
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746731140; cv=none; b=EIn8RFP/WQMzuL4UGIcjS2i7erdP2sgYSLlKjK4UQl+dpco3rzJqaopg0/slByryCTeAm9eybhuOpS3kxVqDIrhXBjRtZ7eBUk8w1or8HcI96MWSo4CDgUudw60sp6qT10RBVB08rHTyuM4qN6taTtqVj9C1XiW3oSR3MoUcPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746731140; c=relaxed/simple;
	bh=biMNSP/bdxNNFW5bzbcf+buTVHtCwvrQCqB1icyNYio=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KXkfpJQhkZuss8NBzj0uaddIPJLkPzOSwG2j5PaswWgXTwAvxqEbNiPuxnxLRn8mocNMxajr5RZvz+5sYBTyR5TZ2/ckWtaGBdKbGsiSfN1EFRAfTciYwY1iswnBmgl9LQ6M1Uyms2TDNx8pCCRmyQ5BaHr5yLAT49B0tGEs20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJbcvajU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJbcvajU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746731139; x=1778267139;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=biMNSP/bdxNNFW5bzbcf+buTVHtCwvrQCqB1icyNYio=;
  b=KJbcvajU3IrXQrArD5yRDoFzE976opMyMUSI06NwTlpKMOd97FZkCXfi
   V/TMDf0cyRSsy2diBCtWRDWSckVyFS0JOWbDUa4DJwzF/AW1wSzoZ/EoB
   97o6k8NwCPtyQUOw8B6ZW3bapm72hUeeaWwn0geObYR18zb49qhnYiifB
   go3fX6vuDnJGvbO3hGEmHF2nbDwrLg6yno6GgsE3QqCkuhIW+TmBogJ+g
   NI2k9Plb7yhLpCJug7Y6ESrIvk4fdBt4u0IgIpHlkWF8uPDEXwDBX+Vsh
   d3hVGrob3r3sqBohf9PfOVLBa0pwwbrDVILaMf9YfR1NOb7H807/Sgu2p
   A==;
X-CSE-ConnectionGUID: CrKq7VggS6+bTXuoVRPjkQ==
X-CSE-MsgGUID: unv2P4utSmG7/0Nh3Rufsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52350322"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="52350322"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:05:38 -0700
X-CSE-ConnectionGUID: OycW6NkTS7miIQDrbD5AAg==
X-CSE-MsgGUID: WSMagU/uSmODY73ebWCd8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="136781932"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.128]) ([10.125.108.128])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:05:35 -0700
Message-ID: <eb1afba3-0f8f-4c15-98e2-b189566060ca@intel.com>
Date: Thu, 8 May 2025 12:05:32 -0700
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
 <a31b071b-e683-4da1-9c5a-2578978bd768@intel.com>
 <PH7PR84MB1582994FDF33F104B050F68E888BA@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <PH7PR84MB1582994FDF33F104B050F68E888BA@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/25 7:27 AM, Parthasarathy, Mohan (Compute) wrote:
> Dave, all, I could make this work by disabling CONFIG_FORTIFY_SOURCE. There is a memcpy in the CXL setup features code that may need to be revisited to
> see if it is a bug with the CXL code or the fortify verifications.

Thanks for the new info. I'm still not able to reproduce after turning on CONFIG_FORTIFY_SOURCE. I may need the qemu that supports features. Which qemu version are you using?

DJ

> 
> Regards,
> Mohan
> 
> 
> -----Original Message-----
> From: Dave Jiang <dave.jiang@intel.com>
> Sent: Monday, May 5, 2025 8:49 PM
> To: Parthasarathy, Mohan (Compute) <mohan_parthasarathy@hpe.com>; linux-cxl@vger.kernel.org; Shiju Jose <shiju.jose@huawei.com>
> Subject: Re: Request for help on CXL kernel panic with recent QEMU/Linux
> 
> 
> 
> On 5/4/25 1:22 AM, Parthasarathy, Mohan (Compute) wrote:
>> Hi all,
>>
>> Can anyone take a look and see if this a known issue ? Also, any tips on whether the issue is likely with my Linux version or QEMU ? I can share more details if required but just wanted to know if this looks obvious to expert eyes.
> 
> kernel version?
> 
> Also running ./scripts/faddr2line on cxl_internal_send_cmd+0x3c/0xf0 and devm_cxl_setup_features.cold+0x43/0x43 would be helpful.
> 
> I've not seen that on my qemu setup with 6.15-rc4. I'm also using upstream qemu. So your kernel version and qemu version and passed in parameters would be helpful.
> 
> Shiju,
> Have you encountered anything like this with your Features testing with RAS on qemu?
> 
>>
>> Regards,
>> Mohan
>>
>>
>>
>> [   57.988032] ------------[ cut here ]------------
>> [   57.990637] memcpy: detected buffer overflow: 96 byte write of buffer size 0
>> [   57.994123] WARNING: CPU: 0 PID: 46 at lib/string_helpers.c:1032 __fortify_report+0x55/0xa0
>> [   58.001055] Modules linked in: cxl_pci i2c_i801(+) irqbypass vfat pcspkr fat i2c_smbus mctp_i2c(+) parport_pc(+) cxl_acpi i2c_mux parport cxl_port cxl_core e1000e einj lpc_ich bochs loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram vmw_vmci qemu_fw_cfg serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse
>> [   58.016135] CPU: 0 UID: 0 PID: 46 Comm: kworker/u16:2 Not tainted 6.15.0-rc4-mohan+ #4 PREEMPT(voluntary)
>> [   58.021711] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> [   58.025755] Workqueue: async async_run_entry_fn
>> [   58.029028] RIP: 0010:__fortify_report+0x55/0xa0
>> [   58.032915] Code: 01 48 8b 34 c5 20 1f 73 b9 48 c7 c1 06 58 f2 b9 48 c7 c0 fc 57 f2 b9 48 0f 44 c8 4c 89 ca 48 c7 c7 d8 ef e3 b9 e8 bb 2e 80 ff <0f> 0b 48 83 c4 20 c3 cc cc cc cc 48 89 74 24 10 48 89 c6 89 7c 24
>> [   58.039451] RSP: 0018:ffffd248801a3a38 EFLAGS: 00010246
>> [   58.047157] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
>> [   58.053599] RDX: ffff88abbbc1ca88 RSI: 0000000000000001 RDI: ffff88abbbc1ca80
>> [   58.059967] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffd248801a38d8
>> [   58.064773] R10: ffffffffba939ac8 R11: 00000000ffffdfff R12: 0000000000000000
>> [   58.075635] R13: 0000000000000000 R14: ffff88ab4007c800 R15: 0000000000000002
>> [   58.084667] FS:  0000000000000000(0000) GS:ffff88ac0052b000(0000) knlGS:0000000000000000
>> [   58.096028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   58.106050] CR2: 00007fbd45b4b058 CR3: 0000000115109000 CR4: 00000000000006f0
>> [   58.117482] Call Trace:
>> [   58.121907]  <TASK>
>> [   58.129551]  ? cxl_internal_send_cmd+0x3c/0xf0 [cxl_core]
>> [   58.139570]  __fortify_panic+0xd/0xf
>> [   58.146273]  devm_cxl_setup_features.cold+0x43/0x43 [cxl_core]
>> [   58.153161]  cxl_pci_probe+0x431/0xa90 [cxl_pci]
>> [   58.158287]  ? kernfs_xattr_get+0x3b/0x70
>> [   58.161167]  ? selinux_kernfs_init_security+0x74/0x250
>> [   58.167922]  ? try_to_wake_up+0x7f/0x760
>> [   58.170137]  local_pci_probe+0x42/0x90
>> [   58.172399]  pci_device_probe+0xda/0x2b0
>> [   58.177444]  ? sysfs_do_create_link_sd+0x6d/0xd0
>> [   58.182205]  really_probe+0xde/0x340
>> [   58.190234]  ? pm_runtime_barrier+0x55/0x90
>> [   58.192903]  __driver_probe_device+0x78/0x140
>> [   58.197956]  driver_probe_device+0x1f/0xa0
>> [   58.203673]  __driver_attach_async_helper+0x5e/0xe0
>> [   58.208474]  async_run_entry_fn+0x34/0x130
>> [   58.217941]  process_one_work+0x18e/0x350
>> [   58.221932]  worker_thread+0x25a/0x3a0
>> [   58.223804]  ? __pfx_worker_thread+0x10/0x10
>> [   58.229040]  kthread+0xfc/0x240
>> [   58.237142]  ? __pfx_kthread+0x10/0x10
>> [   58.246321]  ret_from_fork+0x34/0x50
>> [   58.253927]  ? __pfx_kthread+0x10/0x10
>> [   58.261905]  ret_from_fork_asm+0x1a/0x30
>> [   58.267821]  </TASK>
>> [   58.269775] ---[ end trace 0000000000000000 ]---
>> [   58.274065] ------------[ cut here ]------------
>> [   58.282586] kernel BUG at lib/string_helpers.c:1040!
>> [   58.293976] Oops: invalid opcode: 0000 [#1] SMP NOPTI
>> [   58.299430] audit: type=1130 audit(1746252020.305:32): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-random-seed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>> [   58.299474] CPU: 0 UID: 0 PID: 46 Comm: kworker/u16:2 Tainted: G        W           6.15.0-rc4-mohan+ #4 PREEMPT(voluntary)
>> [   58.313086] Tainted: [W]=WARN
>> [   58.317049] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> [   58.322714] Workqueue: async async_run_entry_fn
>> [   58.329051] RIP: 0010:__fortify_panic+0xd/0xf
>> [   58.332500] Code: e9 dc d9 95 00 e9 02 da 95 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 d3 f2 95 00 <0f> 0b 48 8b 54 24 10 48 8b 74 24 08 4c 89 e1 48 c7 c7 90 2e ef b9
>> [   58.339956] RSP: 0018:ffffd248801a3a60 EFLAGS: 00010282
>> [   58.348114] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
>> [   58.356607] RDX: ffff88abbbc1ca88 RSI: 0000000000000001 RDI: ffff88abbbc1ca80
>> [   58.360981] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffd248801a38d8
>> [   58.366267] R10: ffffffffba939ac8 R11: 00000000ffffdfff R12: 0000000000000000
>> [   58.369804] R13: 0000000000000000 R14: ffff88ab4007c800 R15: 0000000000000002
>> [   58.376177] FS:  0000000000000000(0000) GS:ffff88ac0052b000(0000) knlGS:0000000000000000
>> [   58.380150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   58.384364] CR2: 00007fbd45b4b058 CR3: 0000000115109000 CR4: 00000000000006f0
>> [   58.387660] Call Trace:
>> [   58.390086]  <TASK>
>> [   58.392804]  devm_cxl_setup_features.cold+0x43/0x43 [cxl_core]
>> [   58.395791]  cxl_pci_probe+0x431/0xa90 [cxl_pci]
>> [   58.409127]  ? kernfs_xattr_get+0x3b/0x70
>> [   58.415392]  ? selinux_kernfs_init_security+0x74/0x250
>> [   58.420775]  ? try_to_wake_up+0x7f/0x760
>> [   58.423879]  local_pci_probe+0x42/0x90
>> [   58.429026]  pci_device_probe+0xda/0x2b0
>> [   58.433175]  ? sysfs_do_create_link_sd+0x6d/0xd0
>> [   58.438630]  really_probe+0xde/0x340
>> [   58.440769]  ? pm_runtime_barrier+0x55/0x90
>> [   58.442846]  __driver_probe_device+0x78/0x140
>> [   58.445598]  driver_probe_device+0x1f/0xa0
>> [   58.448532]  __driver_attach_async_helper+0x5e/0xe0
>> [   58.451848]  async_run_entry_fn+0x34/0x130
>> [   58.456739]  process_one_work+0x18e/0x350
>> [   58.462118]  worker_thread+0x25a/0x3a0
>> [   58.467050]  ? __pfx_worker_thread+0x10/0x10
>> [   58.470596]  kthread+0xfc/0x240
>> [   58.474475]  ? __pfx_kthread+0x10/0x10
>> [   58.477836]  ret_from_fork+0x34/0x50
>> [   58.480791]  ? __pfx_kthread+0x10/0x10
>> [   58.484168]  ret_from_fork_asm+0x1a/0x30
>> [   58.487363]  </TASK>
>> [   58.490697] Modules linked in: cxl_pci i2c_i801 irqbypass vfat pcspkr fat i2c_smbus mctp_i2c parport_pc(+) cxl_acpi i2c_mux parport cxl_port cxl_core e1000e einj lpc_ich bochs loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram vmw_vmci qemu_fw_cfg serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse
>> [   58.505259] ---[ end trace 0000000000000000 ]---
>> [   58.509396] RIP: 0010:__fortify_panic+0xd/0xf
>> [   58.512731] Code: e9 dc d9 95 00 e9 02 da 95 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 d3 f2 95 00 <0f> 0b 48 8b 54 24 10 48 8b 74 24 08 4c 89 e1 48 c7 c7 90 2e ef b9
>> [   58.520925] RSP: 0018:ffffd248801a3a60 EFLAGS: 00010282
>> [   58.524495] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
>> [   58.528365] RDX: ffff88abbbc1ca88 RSI: 0000000000000001 RDI: ffff88abbbc1ca80
>> [   58.532956] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffd248801a38d8
>> [   58.536365] R10: ffffffffba939ac8 R11: 00000000ffffdfff R12: 0000000000000000
>> [   58.540179] R13: 0000000000000000 R14: ffff88ab4007c800 R15: 0000000000000002
>> [   58.546765] FS:  0000000000000000(0000) GS:ffff88ac0052b000(0000) knlGS:0000000000000000
>> [   58.550843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   58.554470] CR2: 00007fbd45b4b058 CR3: 0000000115109000 CR4: 00000000000006f0
>> [   59.773090] iTCO_vendor_support: vendor-support=0
>>
> 

