Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B02BD037
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860387; cv=none; b=t9wXaNbxwX/crhv45C9JM00fKU6MIn/pZFldhBRW+TsuU3L9pT9WAZIKCSejoWl5MMdbZWhbl8JpG74EcYdo9us5uiwWkJbkOK5pW5FHoMeK8VLFn4YNaCJ/fCd+xT5vR9tbK6Zr7J2cCqmSHQVeAjcvS5PZpgTlkpUdTTlH6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860387; c=relaxed/simple;
	bh=R79nurTiLDz8uDcUSqmgM4MLmKYimgw4BmzygMGlkUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImXKAph1J92rG2gfb3penn9TYYVM/8ZV+3OFXhUNWOeezSEDrSZsUiHO/3MWfYUSMQhW6Sq1/7RBUtqD0klxBCs8OvIaRf9KzKnP9n1pbXMewCVD2/TEycjegcyqov6MzWZkyYiAGGNMNsMQu+oWNprEMKjvEACGwKq3nN2hLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHhJzRvS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHhJzRvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747860385; x=1779396385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R79nurTiLDz8uDcUSqmgM4MLmKYimgw4BmzygMGlkUw=;
  b=SHhJzRvSspY9ZyqaYA54ePiMWAfhVBryh7T+VvV92FgctZuTaLhMreCM
   tfIE3X9Qd6UZzvzMLdGqQs4WP+7nzUJRoiWLByAfRSHC2k0LfhzRRhCdj
   BHxfarkB6rFqwWTf4pCiT5fq5GdbI3+TDPOw/IHdLdalxbHG9KnvXaS7H
   HdO+nYRFJBkqjaALmMbxScLX+wKzmyohBXud3ab8ZSgjyK7tq6YIBLAoN
   rsTEdOkMvycwZIsEfgQKO1FC56ml/RZzDiXBaGA7PqVLXkpXPXNDUj2Ey
   W9ViLhmqLmdo7mUR1KmolgQJzL1mUy3ezCPzWqydPi+Un1hJVK7maZLri
   Q==;
X-CSE-ConnectionGUID: OP+9foSUQA6O0B3tT8w4ug==
X-CSE-MsgGUID: cjprEvIbQaOJbrKLCnZKKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60519727"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="60519727"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:46:25 -0700
X-CSE-ConnectionGUID: tjXAEDIgRYG7BfmIFNWf+Q==
X-CSE-MsgGUID: bmd5HTEERqWadWxKdnH9Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="141142236"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.106]) ([10.125.109.106])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:46:24 -0700
Message-ID: <71238a94-361f-4264-a5e4-510d428f5f66@intel.com>
Date: Wed, 21 May 2025 13:46:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Internal error: Oops: 0000000096000044 [#11] SMP
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: linux-cxl@vger.kernel.org
References: <aC2RKceK4HqYEQo/@vm4>
 <96235d4d-2bb7-4743-b519-0c35a9a21749@intel.com>
 <98DE3B2C-1393-4ED8-BB6A-E72D6131F97A@linux.dev>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <98DE3B2C-1393-4ED8-BB6A-E72D6131F97A@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/25 1:38 PM, Itaru Kitayama wrote:
> Dave
> 
>> On May 22, 2025, at 0:31, Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 5/21/25 1:39 AM, Itaru Kitayama wrote:
>>> Hi,
>>> On arm64/virt QEMU, the cxl/next (as of today) kernel prints out Internal errors:
>>>
>>> [   80.968299] [     T48] Internal error: Oops: 0000000096000044 [#11]
>>> SMP
>>> [   80.989250] [     T48] Modules linked in: cxl_mock_mem(O) cfg80211
>>> rfkill cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O)
>>> cxl_mock(O) libnvdimm encrypted_keys trusted caam_jr caam asn1_encoder
>>> caamhash_desc caamalg_desc error crypto_engine authenc libdes fuse drm
>>> backlight ip_tables x_tables sm3_ce sm3 sha3_ce sha512_ce sha512_arm64
>>> cxl_core(O) fwctl btrfs blake2b_generic xor xor_neon raid6_pq
>>> zstd_compress ipv6
>>> [   80.992210] [     T48] CPU: 1 UID: 0 PID: 48 Comm: kworker/u8:2
>>> Tainted: G      D    O        6.15.0-rc4-00040-g128ad8fa385b #40 PREEMPT
>>> [   80.992791] [     T48] Tainted: [D]=DIE, [O]=OOT_MODULE
>>> [   80.993039] [     T48] Hardware name: QEMU QEMU Virtual Machine, BIOS
>>> 2025.02-3ubuntu2 04/04/2025
>>> [   80.993400] [     T48] Workqueue: async async_run_entry_fn
>>> [   80.994718] [     T48] pstate: 61402005 (nZCv daif +PAN -UAO -TCO
>>> +DIT -SSBS BTYPE=--)
>>> [   80.995329] [     T48] pc : cxl_mock_mbox_send+0xec/0x12c0
>>> [cxl_mock_mem]
>>
>> Can you do this in your kernel tree?
>> ./scripts/faddr2line tools/testing/cxl/test/cxl_mock_mem.ko cxl_mock_mbox_send+0xec/0x12c0
> 
> realm@machine-1:~/projects/cxl$ ./scripts/faddr2line tools/testing/cxl/test/cxl_mock_mem.ko cxl_mock_mbox_send+0xec/0x12c0
> cxl_mock_mbox_send+0xec/0x12c0:
> mock_get_event at /home/realm/projects/cxl/tools/testing/cxl/test/mem.c:277
> (inlined by) cxl_mock_mbox_send at /home/realm/projects/cxl/tools/testing/cxl/test/mem.c:1571
> 
>>
>> I've not see this issue on x86 running cxl/next. How consistently can you reproduce this? If it's every time, is it possible for you to do a git bisect on the kernel and see which commit causes this please? Thanks!
> 
> Fairly reliably (100% of the boot time, and cx/fixes did not change this BTW, which branch is seen as stable for you folks?), yes, I should try git bisect.

The current cxl/next is based on 6.15-rc4, which should have everything that was in cxl/fixes. And you do not see this with 6.14-final? git bisect would be very helpful. Thank you!

> 
> Itaru.
> 
>>
>> DJ
>>
>>> [   80.995691] [     T48] lr : cxl_internal_send_cmd+0x40/0x104
>>> [cxl_core]
>>> [   80.996189] [     T48] sp : ffff800080d0b9f0
>>> [   80.996380] [     T48] x29: ffff800080d0ba70 x28: fff0000008dd2410
>>> x27: fff00000088fb390
>>> [   80.996714] [     T48] x26: ffff800080d0bb07 x25: 0000000000000100
>>> x24: 0000000000000003
>>> [   80.997135] [     T48] x23: 0000000000000020 x22: fff0000008dd2410
>>> x21: 0000000000000002
>>> [   80.998119] [     T48] x20: fff00000088fb080 x19: ffff800080d0bb08
>>> x18: 00000000ffffffff
>>> [   80.998419] [     T48] x17: 0000000000000000 x16: ffffa8d169128748
>>> x15: ffff800080d0b5ad
>>> [   80.999243] [     T48] x14: ffff800080d0b400 x13: ffff800080d0b5b8
>>> x12: fff000006f7a0000
>>> [   81.000519] [     T48] x11: 0000000000000058 x10: 0000000000000018 x9
>>> : fff000006f7a0000
>>> [   81.001337] [     T48] x8 : ffff800080d0bb48 x7 : fff0000074fa0000 x6
>>> : fff0000074fa0000
>>> [   81.002497] [     T48] x5 : fff000007f937508 x4 : 0000000000000001 x3
>>> : 0000000000001000
>>> [   81.003993] [     T48] x2 : 0000000000001000 x1 : 0000000000000000 x0
>>> : 0000000000000088
>>> [   81.004223] [     T48] Call trace:
>>> [   81.004795] [     T48]  cxl_mock_mbox_send+0xec/0x12c0 [cxl_mock_mem]
>>> (P)
>>> [   81.005136] [     T48]  cxl_internal_send_cmd+0x40/0x104 [cxl_core]
>>> [   81.005520] [     T48]  cxl_mem_get_records_log+0xbc/0x198 [cxl_core]
>>> [   81.006042] [     T48]  cxl_mem_get_event_records+0xb0/0xc0
>>> [cxl_core]
>>> [   81.006246] [     T48]  cxl_mock_mem_probe+0x568/0x6f0 [cxl_mock_mem]
>>> [   81.006417] [     T48]  platform_probe+0x68/0xd8
>>> [   81.008340] [     T48]  really_probe+0xc0/0x39c
>>> [   81.008885] [     T48]  __driver_probe_device+0xd0/0x14c
>>> [   81.009539] [     T48]  driver_probe_device+0x3c/0x120
>>> [   81.010239] [     T48]  __driver_attach_async_helper+0x50/0xec
>>> [   81.011130] [     T48]  async_run_entry_fn+0x34/0x14c
>>> [   81.011276] [     T48]  process_one_work+0x148/0x284
>>> [   81.011420] [     T48]  worker_thread+0x2c4/0x3e0
>>> [   81.011552] [     T48]  kthread+0x12c/0x204
>>> [   81.011693] [     T48]  ret_from_fork+0x10/0x20
>>> [   81.011840] [     T48] Code: 54001b28 a90c6bf9 52801100 f9400a61
>>> (a9007c3f)
>>> [   81.013772] [     T48] ---[ end trace 0000000000000000 ]---
>>>
>>> How serious is this?
>>>
>>> Thanks,
>>> Itaru.
> 
> 

