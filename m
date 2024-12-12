Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE0222D4F
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018362; cv=none; b=bBbyUrgJ502Qfas+YI15WbZk1qOFU7qxQ5cmgACXLJ9qxP9GFBriS0HSeY91eL5RGCLycMUgBHPYI+9/n8bgBHi3qezCk0In0zo/QcTe3dxF2MxCylE1iRt+EmUSuWABZ7cywrgqJPwjWpJeq5t5S3XrS002ra07gBp2+jWROh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018362; c=relaxed/simple;
	bh=F48TjjrRg8+dR0akSWHWegFzneeLCR3aHZ4xwLYdCFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoTuFYxbjrg0VxQI4PYwDy49p2jmJkJjejiGxsjFJ05DDg+sbutQBAiYijFy2ZcDHUyWbI9LjL4cHfoYH9wNEsX9ytg4FYEQt+haIqF+qWx/mXyfqUGKUADjL1GqHNjBMqnDvs+AN5tMIPIIWq7I/prdnup8V79SnO1hnr4lzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1MuO7EK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1MuO7EK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734018360; x=1765554360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F48TjjrRg8+dR0akSWHWegFzneeLCR3aHZ4xwLYdCFI=;
  b=N1MuO7EK0O8mXQ2IBmEtFPrlpemGaMe7EljRq49d1qIltmFGAjJ9SHq9
   toKbtGyjDZFZTogoi+8vysP9h/obHdO6+bXbrdQSeEmTCoyovsuv1lWej
   3FFf4EI8BnKsgMWF/g0IpRWGrHbowcnrOhdXS9dLWyc7xrNKzx16TuP7I
   Hj6Rewlando49WJG+/b426eaBl4v99ub0RrBBznflR/xaYt3UOq8PPr2n
   bZXDzWYRIQLIQhbpSCPDASGH2J5QUg6lFBX9HAGm5TEua/HPaSCcE627M
   tgyFE/SoI6hyZafbB8095hd6gjG7qsCupfSeY88T2uwWiKPGkVvIK9SFG
   w==;
X-CSE-ConnectionGUID: ZORIZTYcQJGinMJjUXl3+g==
X-CSE-MsgGUID: LlDMje0BTPqyF8SUWY9rNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="38224661"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="38224661"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 07:46:00 -0800
X-CSE-ConnectionGUID: B5li6jS/TICAXJLIPSfAcQ==
X-CSE-MsgGUID: HpIB5RBAQhyYdf7LyD8Fug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101370032"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.120]) ([10.125.110.120])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 07:45:58 -0800
Message-ID: <027059b4-fd8e-4477-8537-7865a977eefb@intel.com>
Date: Thu, 12 Dec 2024 08:45:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: read MEMDEV_STATUS register iff the device has it
To: Zhi Wang <zhiw@nvidia.com>, linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 acurrid@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 zhiwang@kernel.org
References: <20241212123959.68514-1-zhiw@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241212123959.68514-1-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/24 5:39 AM, Zhi Wang wrote:
> Before accessing the CXL device memory after reset/power-on, the driver
> needs to ensure the device memory media is ready.
> 
> However, not every CXL device implements the CXL memory device register
> groups. E.g. a CXL type-2 device. Thus calling cxl_await_media_ready()
> on these devcie will lead to a kernel panic. This problem was found when
> testing the emulated CXL type-2 device without a CXL memory device
> register.
> 
> [   97.662720] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   97.663963] #PF: supervisor read access in kernel mode
> [   97.664860] #PF: error_code(0x0000) - not-present page
> [   97.665753] PGD 0 P4D 0
> [   97.666198] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   97.667053] CPU: 8 UID: 0 PID: 7340 Comm: qemu-system-x86 Tainted: G            E      6.11.0-rc2+ #52
> [   97.668656] Tainted: [E]=UNSIGNED_MODULE
> [   97.669340] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   97.671243] RIP: 0010:cxl_await_media_ready+0x1ac/0x1d0
> [   97.672157] Code: e9 03 ff ff ff 0f b7 1d d6 80 31 01 48 8b 7d b8 89 da 48 c7 c6 60 52 c6 b0 e8 00 46 f6 ff e9 27 ff ff ff 49 8b 86 a0 00 00 00 <48> 8b 00 83 e0 0c 48 83 f8 04 0f 94 c0 0f b6 c0 8d 44 80 fb e9 0c
> [   97.675391] RSP: 0018:ffffb5bac7627c20 EFLAGS: 00010246
> [   97.676298] RAX: 0000000000000000 RBX: 000000000000003c RCX: 0000000000000000
> [   97.677527] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [   97.678733] RBP: ffffb5bac7627c70 R08: 0000000000000000 R09: 0000000000000000
> [   97.679951] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   97.681144] R13: ffff9ef9028a8000 R14: ffff9ef90c1d1a28 R15: 0000000000000000
> [   97.682370] FS:  00007386aa4f3d40(0000) GS:ffff9efa77200000(0000) knlGS:0000000000000000
> [   97.683721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   97.684703] CR2: 0000000000000000 CR3: 0000000169a14003 CR4: 0000000000770ef0
> [   97.685909] PKRU: 55555554
> [   97.686397] Call Trace:
> [   97.686819]  <TASK>
> [   97.687243]  ? show_regs+0x6c/0x80
> [   97.687840]  ? __die+0x24/0x80
> [   97.688391]  ? page_fault_oops+0x155/0x570
> [   97.689090]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.689973]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.690848]  ? __vunmap_range_noflush+0x420/0x4e0
> [   97.691700]  ? do_user_addr_fault+0x4b2/0x870
> [   97.692606]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.693502]  ? exc_page_fault+0x82/0x1b0
> [   97.694200]  ? asm_exc_page_fault+0x27/0x30
> [   97.694975]  ? cxl_await_media_ready+0x1ac/0x1d0
> [   97.695816]  vfio_cxl_core_enable+0x386/0x800 [vfio_cxl_core]
> [   97.696829]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.697685]  cxl_open_device+0xa6/0xd0 [cxl_accel_vfio_pci]
> [   97.698673]  vfio_df_open+0xcb/0xf0
> [   97.699313]  vfio_group_fops_unl_ioctl+0x294/0x720
> [   97.700149]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.701011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.701858]  __x64_sys_ioctl+0xa3/0xf0
> [   97.702536]  x64_sys_call+0x11ad/0x25f0
> [   97.703214]  do_syscall_64+0x7e/0x170
> [   97.703878]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.704726]  ? do_syscall_64+0x8a/0x170
> [   97.705425]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.706282]  ? kvm_device_ioctl+0xae/0x130 [kvm]
> [   97.707135]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.708001]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.708853]  ? syscall_exit_to_user_mode+0x4e/0x250
> [   97.709724]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.710609]  ? do_syscall_64+0x8a/0x170
> [   97.711300]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   97.712132]  ? exc_page_fault+0x93/0x1b0
> [   97.712839]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   97.713735] RIP: 0033:0x7386ab124ded
> [   97.714382] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [   97.717664] RSP: 002b:00007ffcda2a6480 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   97.718965] RAX: ffffffffffffffda RBX: 00006293226d9f20 RCX: 00007386ab124ded
> [   97.720222] RDX: 00006293226db730 RSI: 0000000000003b6a RDI: 0000000000000009
> [   97.721522] RBP: 00007ffcda2a64d0 R08: 00006293214e9010 R09: 0000000000000007
> [   97.722858] R10: 00006293226db730 R11: 0000000000000246 R12: 00006293226e0880
> [   97.724193] R13: 00006293226db730 R14: 00007ffcda2a7740 R15: 00006293226d94f0
> [   97.725491]  </TASK>
> [   97.725883] Modules linked in: cxl_accel_vfio_pci(E) vfio_cxl_core(E) vfio_pci_core(E) snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) qrtr(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E) binfmt_misc(E) kvm(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) i2c_i801(E) crypto_simd(E) cryptd(E) i2c_smbus(E) lpc_ich(E) joydev(E) input_leds(E) mac_hid(E) serio_raw(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) efi_pstore(E) dmi_sysfs(E) qemu_fw_cfg(E) autofs4(E) bochs(E) e1000e(E) drm_vram_helper(E) psmouse(E) drm_ttm_helper(E) ahci(E) ttm(E) libahci(E)
> [   97.736690] CR2: 0000000000000000
> [   97.737285] ---[ end trace 0000000000000000 ]---
> 
> Only read MEMDEV_STATUS register for ensuring media ready when the device
> has it.
> 
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I guess since this is unlikely to happen unless type2 support is added, no need to backport as fixes.

> ---
>  drivers/cxl/core/pci.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 51132a575b27..7a8ec4928da6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -203,9 +203,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  			return rc;
>  	}
>  
> -	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> -	if (!CXLMDEV_READY(md_status))
> -		return -EIO;
> +	if (cxlds->regs.memdev) {
> +		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +		if (!CXLMDEV_READY(md_status))
> +			return -EIO;
> +	}
>  
>  	return 0;
>  }

