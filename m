Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D0B7F9
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734059830; cv=pass; b=iCGw3/tnscleMt3W/Mk+Xd5Dz9Txnv4RuqVXEYTbkobgcdK94oxzGayDhFbxJPIfjB1vysKZx6+Wgmq7sFgdv4Y/CJxG1KnzgqhB1Bpw85OWZ5sMiMNhgVuw5B5AcZiYAzQsBv7sjFVzOodjhHh02vlAAmTinke1J4kLplTYews=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734059830; c=relaxed/simple;
	bh=OUFRZzuR5IGTWIzp1HDBD5J9M23k4THhkJ8uegjPM6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyfovOu4/dDp/L5dTSpf2ZYHji9jGg+94C2BH3/r2vlQ/SaKJnwOEX6YT/AtaaS8gQE1KFuF7Fl7WkfstAszzoDBn7WfQ85FJquMadDBE2rf9qFZd+/vmnMAGCmjZYmaIi8+kibgJ8Dt5vzl+mcvGEM4LLHKvc79LX6de+1iUls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CMYP8vhZ; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CMYP8vhZ"
ARC-Seal: i=1; a=rsa-sha256; t=1734059807; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c4ziE2srahhKGzwAPkKWAPnjm8RtaUQG6DaMMViBB30CkI59ebY/CnQjqxj+WgNYYKCt0+BH/kkQ1B5g35BqUSFfVNtLP5tywEdLDatCIo3fhQEHYTiYHaf6U6+HihrBQMfds43xekWm98pv1k3cSybbIaS3DDL0z0SBSPvgoBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734059807; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OUFRZzuR5IGTWIzp1HDBD5J9M23k4THhkJ8uegjPM6o=; 
	b=ZtwL5ECtekh+9PS2ysf3TrIDHLzMIFE5lmpbxqBXGVgN9YK2vo60HsW98Cdi05l6fxJyjZJpWE49Ll31eoxxWOMC6xW41SRZprlK1mCqQSlL0g8rng6nLAhonagMPGYwT67ovjuWWc0I9RA5Rp+VItmm9ZnAZfz9Qt1yLv66AXM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734059807;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=OUFRZzuR5IGTWIzp1HDBD5J9M23k4THhkJ8uegjPM6o=;
	b=CMYP8vhZvG+uvGqOgJJQUpVuxjWDpsSDjOrkm8tVhGERCSPNoGhaxn1fFWeR2Nul
	ivvjUNQ5Ll5YvqDk0TK5TXgqgVZQG382O/X7aVDZvxFzSKWKy6e+UQ/jiXC2cxwTWo/
	10C7HXgK/gFOtZwu6tJms10/W/mUF61Y+sPh/9DM=
Received: by mx.zohomail.com with SMTPS id 1734059805388919.392995362785;
	Thu, 12 Dec 2024 19:16:45 -0800 (PST)
Message-ID: <a0063e49-d30f-49e0-8176-493866cf0920@zohomail.com>
Date: Fri, 13 Dec 2024 11:16:39 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: read MEMDEV_STATUS register iff the device has it
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, Zhi Wang <zhiw@nvidia.com>,
 linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 acurrid@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 zhiwang@kernel.org
References: <20241212123959.68514-1-zhiw@nvidia.com>
 <027059b4-fd8e-4477-8537-7865a977eefb@intel.com>
 <d8772cf9-cdc6-448b-b6b9-be5370b0770b@zohomail.com>
 <02f5b9ba-82b5-4a7b-852f-f693e53c738b@intel.com>
 <44788824-eab2-6aa6-1092-54bce1d2937a@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <44788824-eab2-6aa6-1092-54bce1d2937a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112278de4c105958b7bb29bf3b2520000e0f56b056e950d65a91bff6f29b5de2f0d1b3082a26e293196:zu080112279b4bdeebe3ab7c8d9d9f6f4d0000ec53a1fc85ce31e35087bf58c2862cf53bdf404474856cc44c:rf0801122badfc299ec2d4e337fc7e50980000176b5c2624e5c6270702e2af7cadffa568bb7af3331bf8cc0500b1c6c0:ZohoMail
X-ZohoMailClient: External

On 12/13/2024 2:04 AM, Alejandro Lucero Palau wrote:
>
> On 12/12/24 17:55, Dave Jiang wrote:
>>
>> On 12/12/24 10:14 AM, Li Ming wrote:
>>> On 12/12/2024 11:45 PM, Dave Jiang wrote:
>>>> On 12/12/24 5:39 AM, Zhi Wang wrote:
>>>>> Before accessing the CXL device memory after reset/power-on, the driver
>>>>> needs to ensure the device memory media is ready.
>>>>>
>>>>> However, not every CXL device implements the CXL memory device register
>>>>> groups. E.g. a CXL type-2 device. Thus calling cxl_await_media_ready()
>>>>> on these devcie will lead to a kernel panic. This problem was found when
>>>>> testing the emulated CXL type-2 device without a CXL memory device
>>>>> register.
>>>>>
>>>>> [   97.662720] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>> [   97.663963] #PF: supervisor read access in kernel mode
>>>>> [   97.664860] #PF: error_code(0x0000) - not-present page
>>>>> [   97.665753] PGD 0 P4D 0
>>>>> [   97.666198] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>>> [   97.667053] CPU: 8 UID: 0 PID: 7340 Comm: qemu-system-x86 Tainted: G            E      6.11.0-rc2+ #52
>>>>> [   97.668656] Tainted: [E]=UNSIGNED_MODULE
>>>>> [   97.669340] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>>>> [   97.671243] RIP: 0010:cxl_await_media_ready+0x1ac/0x1d0
>>>>> [   97.672157] Code: e9 03 ff ff ff 0f b7 1d d6 80 31 01 48 8b 7d b8 89 da 48 c7 c6 60 52 c6 b0 e8 00 46 f6 ff e9 27 ff ff ff 49 8b 86 a0 00 00 00 <48> 8b 00 83 e0 0c 48 83 f8 04 0f 94 c0 0f b6 c0 8d 44 80 fb e9 0c
>>>>> [   97.675391] RSP: 0018:ffffb5bac7627c20 EFLAGS: 00010246
>>>>> [   97.676298] RAX: 0000000000000000 RBX: 000000000000003c RCX: 0000000000000000
>>>>> [   97.677527] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>>>> [   97.678733] RBP: ffffb5bac7627c70 R08: 0000000000000000 R09: 0000000000000000
>>>>> [   97.679951] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>>>> [   97.681144] R13: ffff9ef9028a8000 R14: ffff9ef90c1d1a28 R15: 0000000000000000
>>>>> [   97.682370] FS:  00007386aa4f3d40(0000) GS:ffff9efa77200000(0000) knlGS:0000000000000000
>>>>> [   97.683721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [   97.684703] CR2: 0000000000000000 CR3: 0000000169a14003 CR4: 0000000000770ef0
>>>>> [   97.685909] PKRU: 55555554
>>>>> [   97.686397] Call Trace:
>>>>> [   97.686819]  <TASK>
>>>>> [   97.687243]  ? show_regs+0x6c/0x80
>>>>> [   97.687840]  ? __die+0x24/0x80
>>>>> [   97.688391]  ? page_fault_oops+0x155/0x570
>>>>> [   97.689090]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.689973]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.690848]  ? __vunmap_range_noflush+0x420/0x4e0
>>>>> [   97.691700]  ? do_user_addr_fault+0x4b2/0x870
>>>>> [   97.692606]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.693502]  ? exc_page_fault+0x82/0x1b0
>>>>> [   97.694200]  ? asm_exc_page_fault+0x27/0x30
>>>>> [   97.694975]  ? cxl_await_media_ready+0x1ac/0x1d0
>>>>> [   97.695816]  vfio_cxl_core_enable+0x386/0x800 [vfio_cxl_core]
>>>>> [   97.696829]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.697685]  cxl_open_device+0xa6/0xd0 [cxl_accel_vfio_pci]
>>>>> [   97.698673]  vfio_df_open+0xcb/0xf0
>>>>> [   97.699313]  vfio_group_fops_unl_ioctl+0x294/0x720
>>>>> [   97.700149]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.701011]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.701858]  __x64_sys_ioctl+0xa3/0xf0
>>>>> [   97.702536]  x64_sys_call+0x11ad/0x25f0
>>>>> [   97.703214]  do_syscall_64+0x7e/0x170
>>>>> [   97.703878]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.704726]  ? do_syscall_64+0x8a/0x170
>>>>> [   97.705425]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.706282]  ? kvm_device_ioctl+0xae/0x130 [kvm]
>>>>> [   97.707135]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.708001]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.708853]  ? syscall_exit_to_user_mode+0x4e/0x250
>>>>> [   97.709724]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.710609]  ? do_syscall_64+0x8a/0x170
>>>>> [   97.711300]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [   97.712132]  ? exc_page_fault+0x93/0x1b0
>>>>> [   97.712839]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>> [   97.713735] RIP: 0033:0x7386ab124ded
>>>>> [   97.714382] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>>>>> [   97.717664] RSP: 002b:00007ffcda2a6480 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>>>> [   97.718965] RAX: ffffffffffffffda RBX: 00006293226d9f20 RCX: 00007386ab124ded
>>>>> [   97.720222] RDX: 00006293226db730 RSI: 0000000000003b6a RDI: 0000000000000009
>>>>> [   97.721522] RBP: 00007ffcda2a64d0 R08: 00006293214e9010 R09: 0000000000000007
>>>>> [   97.722858] R10: 00006293226db730 R11: 0000000000000246 R12: 00006293226e0880
>>>>> [   97.724193] R13: 00006293226db730 R14: 00007ffcda2a7740 R15: 00006293226d94f0
>>>>> [   97.725491]  </TASK>
>>>>> [   97.725883] Modules linked in: cxl_accel_vfio_pci(E) vfio_cxl_core(E) vfio_pci_core(E) snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) qrtr(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E) binfmt_misc(E) kvm(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) i2c_i801(E) crypto_simd(E) cryptd(E) i2c_smbus(E) lpc_ich(E) joydev(E) input_leds(E) mac_hid(E) serio_raw(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) efi_pstore(E) dmi_sysfs(E) qemu_fw_cfg(E) autofs4(E) bochs(E) e1000e(E) drm_vram_helper(E) psmouse(E) drm_ttm_helper(E) ahci(E) ttm(E) libahci(E)
>>>>> [   97.736690] CR2: 0000000000000000
>>>>> [   97.737285] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> Only read MEMDEV_STATUS register for ensuring media ready when the device
>>>>> has it.
>>>>>
>>>>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>
>>>> I guess since this is unlikely to happen unless type2 support is added, no need to backport as fixes.
>>> Hi Zhi and Dave,
>>>
>>>
>>> Do you know if memory device status registers are necessary for CXL type2 device?
>> Type-2 can be a memory device since it can implement optional host-managed device memory. But I believe it's optional vs type-3 it's mandatory. So failing on failure of regs.memdev discovery may not be suitable for type 2. At least that is my understanding.
>
>
> That's correct and what Type2 patchset addresses. Only Type2 mandatory capabilities not found are implying a discovery error, although it depends on the device driver specifying the expected capabilities adding some optional to the mandatory set.
>
Thank you all for your explanation.


>
>>> I only found Table 8-35 in CXL r3.1 section 8.2.8.5 which mentions that memory device status registers are mandatory for all CXL memory devices.  But I am not sure if this rule applies to CXL type-2 device.
>>>
>>> If CXL type-2 device should have memory device status registers, maybe cxl_await_media_ready() returnning an error if 'cxlds->regs.memdev' is invalid makes more sense?
>>>
>>>
>>> Thanks
>>>
>>> Ming
>>>
>>>>> ---
>>>>>   drivers/cxl/core/pci.c | 8 +++++---
>>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>>> index 51132a575b27..7a8ec4928da6 100644
>>>>> --- a/drivers/cxl/core/pci.c
>>>>> +++ b/drivers/cxl/core/pci.c
>>>>> @@ -203,9 +203,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>>>>>               return rc;
>>>>>       }
>>>>>   -    md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>>>>> -    if (!CXLMDEV_READY(md_status))
>>>>> -        return -EIO;
>>>>> +    if (cxlds->regs.memdev) {
>>>>> +        md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>>>>> +        if (!CXLMDEV_READY(md_status))
>>>>> +            return -EIO;
>>>>> +    }
>>>>>         return 0;
>>>>>   }
>>

