Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB461DFD1
	for <linux-cxl@vger.kernel.org>; Sun, 15 Dec 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734269433; cv=pass; b=MON6jCUBKoon+iZyPX1e83V3zCoq3c6XC16mTmoMcq0uI/49fPC9bhPTT8e+dllNCSTR5WPEEKtLHRrc2ZiW7wQBDlz1snyCgMVMTqLgwJfBTNdL7ZQltBSYb3Jj/DOGn/sEyiz4mcIa8OM0QzJ+R3xgFapYgzdrQmgz4KNqJ4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734269433; c=relaxed/simple;
	bh=6NLl8pvGMNxLqW1kZTu5Y7Kwdfzr4UsjGbnrSSFF/dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/z3N9TtEj4M6BZAsZCZeF/hC1ybzoVM2rk7Rpq5WHfPOcTF74COSiF3qVXb1P8JrK8Mva523zRwkujtyqGUrxtegHr1wgaFmRG0LkFRjp+tCNE4oFo1PHQ50TunX+tWIXuXrrloH3Rur++zBMaIyA4Eq7E2MTdUOFQ0KZX2boM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Bd/2xtOS; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Bd/2xtOS"
ARC-Seal: i=1; a=rsa-sha256; t=1734269409; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g9d9uCpBrRE9w5LLxTV+X8jUkVRCvG6vDo9u+u48DFyywDW5gnCJWGyfNmWkirCp23x88hNh706n33qvf1DaSRqtCzbk7iHL+DHgsuBFUN9xIBeOIWfpEeyTQCDTWF8aUkyqfTz5hpb1mo9o7KuMCwFlCLp28G4JcLJ+AXaO8lk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734269409; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4ejJRkf1EJ3dJCYZTcpGaC5pEIcltCkxiBsYuP3yZpk=; 
	b=VxA6Slh7mn2M86uy0+dWuvyTF/SXj6vpBw2cMeo0itKwMPg+uDvTONr5MZCypyYvkcyydv4XiZhh0UMOX0VHKDYV4nyGW3EUsuy78PSsM2oUHQcSn6iVXSNP9rcC+mKwGhP7UVqo+e5OiReHk4dyBbz36Jyg/3QcYVNxnt69on4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734269409;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=4ejJRkf1EJ3dJCYZTcpGaC5pEIcltCkxiBsYuP3yZpk=;
	b=Bd/2xtOSamoixh7QfkPhmReNnkW+vt7fm5QuCmMSHnE6h55t2KT8INqwocPt+Yau
	yk8UhiW7qHWcPZKBQOJHEVtc8cW3oCgALE+WHeOUDW87ReS1RGcz5S2/m7MFtKyGDD3
	cu9xOgOvKSCxqE4LSRgqlcvtxsMMl/zk8QW+7GlQ=
Received: by mx.zohomail.com with SMTPS id 1734269407609911.6117185562584;
	Sun, 15 Dec 2024 05:30:07 -0800 (PST)
Message-ID: <30cec6f1-4170-46f6-86a5-3eb37ee5a327@zohomail.com>
Date: Sun, 15 Dec 2024 21:29:59 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: factor out cxl_await_range_active() and
 cxl_media_ready()
To: Zhi Wang <zhiw@nvidia.com>, linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com, dan.j.williams@intel.com,
 dave.jiang@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, acurrid@nvidia.com,
 cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, zhiwang@kernel.org
References: <20241213103906.378950-1-zhiw@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20241213103906.378950-1-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112277b841e9da56c0425bda209e10000528abd7d754b29adbb4d102eeff38031198b46a0650c56d9e8:zu08011227340dc76138b49d31b59d32580000f32088c7ef9e784510b7a314e2588b3536f40ac6185d14a01e:rf0801122ba989e8b86615647372c3bcaa00000d13f070dde2cd3a86b66ea6275d82ab8d100f8a96de548b9c0986e714:ZohoMail
X-ZohoMailClient: External

On 12/13/2024 6:39 PM, Zhi Wang wrote:
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
> Factor out cxl_await_range_active() and cxl_media_ready(). Type-3 device
> should call both for ensuring media ready while type-2 device should only
> call cxl_await_range_active().
>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Li Ming <ming.li@zohomail.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>


Thanks

Ming

> ---
> v1 -> v2:
> - factor out routines for different CXL-type devices to call. (Dan)
>
> v1: https://lore.kernel.org/all/20241212123959.68514-1-zhiw@nvidia.com/T/
>
>  drivers/cxl/core/pci.c | 18 +++++++++++-------
>  drivers/cxl/cxlmem.h   |  3 ++-
>  drivers/cxl/pci.c      |  3 +--
>  3 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 51132a575b27..d4ce9cb578ff 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -177,12 +177,11 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>   * Wait up to @media_ready_timeout for the device to report memory
>   * active.
>   */
> -int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +int cxl_await_range_active(struct cxl_dev_state *cxlds)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	int rc, i, hdm_count;
> -	u64 md_status;
>  	u16 cap;
>  
>  	rc = pci_read_config_word(pdev,
> @@ -203,13 +202,18 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  			return rc;
>  	}
>  
> -	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> -	if (!CXLMDEV_READY(md_status))
> -		return -EIO;
> -
>  	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_await_range_active, CXL);
> +
> +int cxl_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	u64 md_status;
> +
> +	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +	return CXLMDEV_READY(md_status) ? 0 : -EIO;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_media_ready, CXL);
>  
>  static int wait_for_valid(struct pci_dev *pdev, int d)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index afb53d058d62..6aba6d39d82b 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -817,7 +817,8 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> -int cxl_await_media_ready(struct cxl_dev_state *cxlds);
> +int cxl_await_range_active(struct cxl_dev_state *cxlds);
> +int cxl_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4be35dc22202..6fbbaae4a79c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -846,8 +846,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> -	rc = cxl_await_media_ready(cxlds);
> -	if (rc == 0)
> +	if (!cxl_await_range_active(cxlds) && !cxl_media_ready(cxlds))
>  		cxlds->media_ready = true;
>  	else
>  		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);


