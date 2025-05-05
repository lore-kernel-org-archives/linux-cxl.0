Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24C42A97
	for <linux-cxl@vger.kernel.org>; Mon,  5 May 2025 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746419613; cv=none; b=Tn/a3JhSxyYA2rh/4n4yvudFWM0Q77JIoQ3kG3ZmVFghePPpnE3mW9lddUE+JVPmSI3wlcuVekGDoqzdVO9M3+bKe0c8K04y7Y0d6QxjD+/M4zz2ns4yodtH1M+6bu/8alLqdRvZW7tijnXMC+GJ8fnCaQJwOmCmCz6/EdMLELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746419613; c=relaxed/simple;
	bh=wYrsr5eykOoHdCR4aGbuNES0RHhOWBOTHAvr6xT/ORk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFuxQrDjrlhEYXpzHDi+6iI8gNCCXeB1e1DwIn3gyPvxtL3yeTTz+Y7OH2OAYnrVGoBVOOv9WteViMtMTJW1zslXVXI6rqBx8JRdzt5ZrDmBXUXiMlr/qdkvjGoCCxAcNgYm15JpgKoNbCsv0nqRGzrQEMuSor5G/alKc+Djd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPR7npmO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPR7npmO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33677183so45461155ad.2
        for <linux-cxl@vger.kernel.org>; Sun, 04 May 2025 21:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746419611; x=1747024411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wnogAiqQ98cz/XFI4NNcH9qZp6bLzlYWVH7sHZUujhc=;
        b=YPR7npmOJP0hKwP07kHvgzdfoIPQPcVeZ1uRlvzVS9uXi7g5HP3BlfO0OZe9K9WCd1
         sU0As69K/GG2mPco/ij5HG6V0dWitc1q0PWDFfBh5VwDr9bQam+F3ZUp1xT8z7sORyUO
         /9NIcHwGHjZwGKzXrti8nUOU7Diu4Lt3OFTTWY+CZQVVPTJfD3HocWaBO5/mj94qHsJT
         1d9FUVsa84HMRtNTdfWUNfwZUMjCtkMhpumaj+s+fsIbUwAfCcOK/eIabzLHo+YnHVIu
         qFfSt/EfO8SPvzBvYFGfRmCDQ5u/pzYwt4sucvxnUjiliCP8q4bvCLlnRR7zMgxMh8BQ
         XDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746419611; x=1747024411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnogAiqQ98cz/XFI4NNcH9qZp6bLzlYWVH7sHZUujhc=;
        b=xVHHjiSawtEstakv0lEPgZsT0xaBeJ63odCwrKWJjPdr4fgdYhJet225TgicBMhWpb
         3EHUfpKQ2GpGPyysRJjmQJhF7+fLNBQe4uinbfwPibt7LQXG0krkkbv0yrhT2p1T0O7o
         TstpuUPc/856oo4W3fJwFBslspDd7gDpIxtQmSFOZTFFP7hjZ8RUKhbHQOq/Anyvyyx3
         pf++2oU33KtezgXX46lHc793fe/4DUu0YTGoRWjt3OMeQ6jJUploqe8MvkeggblHLPoI
         Xej6sJgY7f0M51Xf3sXF9SNUah4MX7kQpd59+mgJOGDSiZEyKJPUKlsp8H3rSKW/7Ps3
         LtLw==
X-Gm-Message-State: AOJu0YxxQq4rUQAwITq3AONMrYwzLii+R+WtEau8TBJqXC/s7eel/vaq
	5AFq01Pze5wa/dbXsV4vl0a57pa9zWG9qqRIH+oxBjs9O/kv2xt4efIwQw==
X-Gm-Gg: ASbGnctKJOkB+Lmal2xQ6yNcFDmG02V3LBQ9Lk0UHhursXQDSola8dmlwMhNyPvH+Rf
	trAH8RYtSxlPCryFrKxNSclbZXjPdWjZKDyuiQRusWDZDZ1uAybtEYK3MGoURMza/WmXvUovx7E
	kj67enIPoJALoAvoo2pmigvA7vGP0GBQ1RcfKypc/V7yc3MGPhIOxLmNAcaoPhTkH13BUMHyBk+
	jA72YgQARK/MnmqwN3q90krxlL+0bFCji/BY6no5BO++vLEbvtHKGlhIvFdpRIWQCr5bxweTm1P
	XcB4LbdKemmwFF/8D8JHO+7MLWdywg==
X-Google-Smtp-Source: AGHT+IH6zKWTyPWfAep8oxOCAadhLTLFX7Hr+vgO2ULd7d70CIP8rFoJpDqFF3lRNBqaPCot9FsYsw==
X-Received: by 2002:a17:903:250:b0:220:e924:99dd with SMTP id d9443c01a7336-22e1eae4211mr96513905ad.34.1746419611263;
        Sun, 04 May 2025 21:33:31 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:278b:f4fe:66d9:a6d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b7bbd0sm3760269a12.37.2025.05.04.21.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 21:33:30 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Sun, 4 May 2025 21:33:28 -0700
To: "Parthasarathy, Mohan (Compute)" <mohan_parthasarathy@hpe.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Request for help on CXL kernel panic with recent QEMU/Linux
Message-ID: <aBg_mPgbdcXDaypR@lg>
References: <PH7PR84MB1582216A28E1632187113016888F2@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR84MB1582216A28E1632187113016888F2@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>

On Sun, May 04, 2025 at 08:22:04AM +0000, Parthasarathy, Mohan (Compute) wrote:
> Hi all,
> 
> Can anyone take a look and see if this a known issue ? Also, any tips on whether the issue is likely with my Linux version or QEMU ? I can share more details if required but just wanted to know if this looks obvious to expert eyes.
> 
Hi Mohan,

It would be better if you can share your qemu and kernel setup details so
people who can help look into to it can reproduce your issue and
analyze. 

Fan


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

-- 
Fan Ni
