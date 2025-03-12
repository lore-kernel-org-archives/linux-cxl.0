Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C442512C5
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792479; cv=none; b=i1daicWZQUuA6jxE8jju9p+O9GSXqbiX7eQr6BJTPhcBlwrKU5ApskKVu/aJnMBf8L9RwsB8FJb1eocOSKI/BU4WQpiSdFfPa7yEQ5uvfClKxMZvqyoqkhXRcdmEp+82PMgGYEsbFJpVHlKRxej225wmVRn7wV1XLMAoRjjBqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792479; c=relaxed/simple;
	bh=JZcsSKRxsI3dcoFQH9E2KW0rgnSPuiY5bIK3kZPDLVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCCnhRrbLHuYBVPXH+Um2r5UZ+F1SUY4YpWgRGz6tQ36/QeTdNkibGLb4AARkOn4Xz/JV2/9+GuniwGVzci5DdlVnhmTtctvMDUgJlTKQk7HNAxBNVO6rMh8o97NbtdLp/HYLM6bwYYSajA9WaxUHuUgt/IPzMTSPg567JL5PJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDcYK4fG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDcYK4fG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741792477; x=1773328477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JZcsSKRxsI3dcoFQH9E2KW0rgnSPuiY5bIK3kZPDLVc=;
  b=TDcYK4fG/vLr3pChfY2UMkHP4XEXNpEj+tH5VwC6iqJzXlVMSnHhdR4H
   4sTD0cP6Nbc0hYzu+rl0plrKoZA0WcXPslJsJ0ZEwYIqxDqgiOmb2hqRS
   M9C2qzZCTM+MZ68Z1ZVpIaaNm6EkB9G0bdUG6wYbJbDhwe+OXOcltcDne
   gMzM5Z72KCtarfXoxix9kgD1ZFYOMr9UvJcq9szyt7JsSvu6XezrqXkYe
   FeRa0o0hRM4aoYfJ++dfgGM3Si9X2PRemeoHO80+RZxCO8HUDHldgPIOO
   rKXXRQObd3P2F3XiLEwAheeWL4p5Zt31wU+warnf943h8QNDEcYIT2/rj
   w==;
X-CSE-ConnectionGUID: IVY9Paj2RYuP9jPi2TfElg==
X-CSE-MsgGUID: oYUw4nrgTSGCaFPE8AlfuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30460219"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="30460219"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:14:37 -0700
X-CSE-ConnectionGUID: /m0RSXgeT6aclrtDgmyTkw==
X-CSE-MsgGUID: FVA2GDbVQZur1NvIeNBmwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="157839737"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.108.8]) ([10.125.108.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:14:37 -0700
Message-ID: <2012e5eb-db6c-4982-9f0e-bced465d29c0@intel.com>
Date: Wed, 12 Mar 2025 08:14:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CXL -next issue on arm64
To: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <49A4B521-AB66-4037-A23D-1D0D7AF0F42F@linux.dev>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <49A4B521-AB66-4037-A23D-1D0D7AF0F42F@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/11/25 8:56 PM, Itaru Kitayama wrote:
> Hi Alison,
> I rebased onto the latest CXL kernel -next this morning and `modprobe cxl_test` triggers a NULL pointer dereference see below. I am building a kernel with ACPI_HMAT set to “y” but the FW doesn’t provide the table on my QEMU virt machine.
> 
> Thanks,
> Itaru.
>  
> 
> [  128.095189][  T552] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [  128.095629][  T552] Mem abort info:
> [  128.095703][  T552]   ESR = 0x0000000096000044
> [  128.095789][  T552]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  128.096320][  T552]   SET = 0, FnV = 0
> [  128.096655][  T552]   EA = 0, S1PTW = 0
> [  128.096733][  T552]   FSC = 0x04: level 0 translation fault
> [  128.096862][  T552] Data abort info:
> [  128.096939][  T552]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> [  128.097042][  T552]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> [  128.097149][  T552]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  128.097325][  T552] user pgtable: 4k pages, 52-bit VAs, pgdp=0000000103981600
> [  128.098312][  T552] [0000000000000000] pgd=080000010f5a6403, p4d=0000000000000000
> [  134.299341][  T552] Internal error: Oops: 0000000096000044 [#3] PREEMPT SMP
> [  134.299844][  T552] Modules linked in: cxl_mock_mem(O) cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O) cxl_mock(O) libnvdimm cxl_core(O) sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 button processor cfg80211 rfkill fuse drm backlight ip_tables x_tables ipv6
> [  134.302032][  T557] cxl_mock_mem cxl_rcd.10: CXL MCE unsupported
> [  134.302604][  T552] CPU: 1 UID: 0 PID: 552 Comm: kworker/u8:5 Tainted: G      D    O       6.14.0-rc1-00050-gb1eb9579d26a-dirty #103 09186677403f60ca5f8511de95b4969341ca485e
> [  134.303300][  T552] Tainted: [D]=DIE, [O]=OOT_MODULE
> [  134.304067][  T552] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> [  134.304209][  T552] Workqueue: async async_run_entry_fn
> [  134.304519][  T552] pstate: 61402005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [  134.304856][  T552] pc : cxl_mock_mbox_send+0x514/0x11dc [cxl_mock_mem]

Can you run scripts/faddr2line on this and see which line of code triggered it? Thanks!

Also a bisect vs 6.14-rc1 would be great if you can pin point which new commit is causing it. 

DJ

> [  134.305024][  T552] lr : cxl_internal_send_cmd+0x40/0x118 [cxl_core]
> [  134.305566][  T552] sp : ffff800082c5b9e0
> [  134.305671][  T552] x29: ffff800082c5b9e0 x28: fffeffb34bacd010 x27: fffeffb3434af390
> [  134.306215][  T552] x26: ffff800082c5bb57 x25: 0000000000000100 x24: 0000000000000001
> [  134.309335][  T552] x23: 0000000000000020 x22: fffeffb34bacd010 x21: fffeffb347f5e080
> [  134.311287][  T552] x20: fffeffb3434af080 x19: ffff800082c5bb58 x18: 00000000ffffffff
> [  134.312134][  T552] x17: 0000000000000000 x16: ffffa563f133a508 x15: fffeffb347e3ea1c
> [  134.313208][  T552] x14: ffffa563f31f4220 x13: 0000000000000040 x12: 0000000000000228
> [  134.313912][  T552] x11: 0000000000000000 x10: ffff5a4f60c1ec20 x9 : 0000000000000028
> [  134.314855][  T552] x8 : ffff800082c5bb98 x7 : 0000000000000003 x6 : 0000000000000003
> [  134.315033][  T552] x5 : fffeffb3437f3540 x4 : 0000000000000001 x3 : 0000000000001000
> [  134.318113][  T552] x2 : 0000000000000070 x1 : 0000000000000000 x0 : 0000000000000088
> [  134.318600][  T552] Call trace:
> [  134.318680][  T552]  cxl_mock_mbox_send+0x514/0x11dc [cxl_mock_mem 0d13b81331ab9470a26e7387d930d28978595994] (P)
> [  134.319019][  T552]  cxl_internal_send_cmd+0x40/0x118 [cxl_core 98e80007eca5dee8da38639ce9041c6e7bffd043]
> [  134.322029][  T552]  cxl_mem_get_records_log+0xb8/0x184 [cxl_core 98e80007eca5dee8da38639ce9041c6e7bffd043]
> [  134.322795][  T552]  cxl_mem_get_event_records+0xb0/0xb8 [cxl_core 98e80007eca5dee8da38639ce9041c6e7bffd043]
> [  134.323051][  T552]  cxl_mock_mem_probe+0x41c/0x46c [cxl_mock_mem 0d13b81331ab9470a26e7387d930d28978595994]
> [  134.323233][  T552]  platform_probe+0x68/0xdc
> [  134.323473][  T552]  really_probe+0xc0/0x388
> [  134.323967][  T552]  __driver_probe_device+0x7c/0x15c
> [  134.324085][  T552]  driver_probe_device+0x40/0x114
> [  134.324599][  T552]  __driver_attach_async_helper+0x50/0xec
> [  134.325234][  T552]  async_run_entry_fn+0x34/0x14c
> [  134.326457][  T552]  process_one_work+0x150/0x294
> [  134.326631][  T552]  worker_thread+0x2dc/0x3dc
> [  134.326729][  T552]  kthread+0x130/0x204
> [  134.326947][  T552]  ret_from_fork+0x10/0x20
> [  134.327113][  T552] Code: 540010a8 f9400a61 52801100 d2800e02 (a9007c3f)
> [  134.327240][  T552] ---[ end trace 0000000000000000 ]---
> [  134.619427][  T557] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [  134.633336][  T557] Mem abort info:
> [  134.644018][  T557]   ESR = 0x0000000096000044
> [  134.668786][  T557]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  134.672231][  T557]   SET = 0, FnV = 0
> [  134.701787][  T557]   EA = 0, S1PTW = 0
> [  134.705094][  T557]   FSC = 0x04: level 0 translation fault
> [  134.705227][  T557] Data abort info:
> [  134.705299][  T557]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> [  134.705562][  T557]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> [  134.723727][  T557]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  134.786343][  T557] user pgtable: 4k pages, 52-bit VAs, pgdp=0000000101734880
> [  134.791824][  T557] [0000000000000000] pgd=08000001019e9403, p4d=0000000000000000

