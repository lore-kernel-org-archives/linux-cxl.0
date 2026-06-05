Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC50E224F3;
	Fri,  5 Jun 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673459; cv=none; b=OdPpELJxB1EAoVZ7DvxmOQ14EIpJcsNOaJWl/bTRnNAIBdgUMt+leZHEco1Yf+Pq1X2ECuvIo8bgIY+GfHyd2D36zlURrDXE9fvsNyoX/0je9J1vZ4y05vx3yb0N4XTM3obpOGS324M6emnH24KOzVD6+gCe+rnDx2fhacqMMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673459; c=relaxed/simple;
	bh=HBcrq+sbr4SBnxlTvGfguCT9R+SSAPjCdf42JmOk/qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cl5xuEONZWhYbziYzKbaNSMUZx4vig7N1NiUxYoT6jyQBl6rdPfC+AN92IKGON1de427n+a4l1R6qPnMRwVf66LiNfcfaolJkOag649m8OoBq0U/Ga3MK4BGZO5u8kMxPOkF/ySuXk+8vrmSEp4aqaE051xDOKvw6bNfSyJuwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bp1fciTC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bp1fciTC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780673458; x=1812209458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HBcrq+sbr4SBnxlTvGfguCT9R+SSAPjCdf42JmOk/qs=;
  b=Bp1fciTC2q0YhuzGWOW4h+Tksr16Cs3b3DMBzuTUkDGJg/5pVQMiACzE
   uL6Zwl0X0vAQcUYGCdGGGsxHvaFvYEnyt33Erd1TloOOL+jY7vTCCW6Er
   9uimjPqF/6jnagI3a2CMFgXMLYFXQ7KaOoCy25YWNJfCC4tBlp45xAwj6
   42eWSEQLISCz5DYN078TD2ztXtR98PCfWOA2ufYfyHo5YbDoerEPg0E4d
   i3VXVY3Rq4ctE7Yaeq/nnyFOfFq3hOjUdLUIDbdM+XLXIJZMT/+5qgeVT
   uA//x5WDHHX36dDelS9ScjxrJ6NUR//R3GkXfahl2GLPlkmXLIrj7GmCf
   Q==;
X-CSE-ConnectionGUID: JUenrUO+Ra2bYj4iakcGtA==
X-CSE-MsgGUID: +8MOBrNLTDS4YH57i8UqnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81542340"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="81542340"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:30:57 -0700
X-CSE-ConnectionGUID: oZQm9QfiR7epOcnkAhfUkg==
X-CSE-MsgGUID: D8AE27UPTKSUEoPrT5iBJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="244932408"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.36]) ([10.125.109.36])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:30:56 -0700
Message-ID: <951d3e9b-f9f4-4d16-8119-1543ed9e44f1@intel.com>
Date: Fri, 5 Jun 2026 08:30:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Fix out-of-bounds read of the RAS Header Log
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com,
 kobak@nvidia.com, smadhavan@nvidia.com, vaslot@nvidia.com
References: <20260605041602.37944-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260605041602.37944-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/26 9:16 PM, Richard Cheng wrote:
> The CXL RAS Header Log is 64 bytes, but CXL_HEADERLOG_SIZE is SZ_512,
> which is 512 bytes, not 512 bits, so the kernel treats it as 8x times
> bigger.
> 
> header_log_copy() reads 448 bytes of MMIO past the register, and
> cxl_*_aer_uncorrectable_error() tracepoints memcpy 512 bytes from the
> 64-byte header log. On the CPER path the source is a heap object, so the
> copy runs 448 bytes past it and leaks kernel memory into a trace record
> that userspace can read:

I think Terry raised the same issue and this [1] is what Dan suggested for the fix as there's rasdaemon (user) impact.

[1]: https://lore.kernel.org/linux-cxl/6a0e33507e961_1717cc100f6@djbw-dev.notmuch/

DJ

> 
> """
> [  297.704020] BUG: KASAN: slab-out-of-bounds in trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
> [  297.704032] Read of size 512 at addr ffff0000dd6ee118 by task bash/3078
> 
> [  297.704038] CPU: 116 UID: 0 PID: 3078 Comm: bash Not tainted 7.1.0-rc6+ #1 PREEMPT(full)
> [  297.704041] Hardware name:  , BIOS buildbrain-gcid-sbios-45660680 Wed May 27 08:27:58 AM UTC 2026
> [  297.704042] Call trace:
> [  297.704043]  show_stack+0x24/0x50 (C)
> [  297.704049]  dump_stack_lvl+0x80/0x140
> [  297.704053]  print_report+0x100/0x630
> [  297.704057]  kasan_report+0xb8/0x130
> [  297.704059]  kasan_check_range+0x15c/0x240
> [  297.704061]  __asan_memcpy+0x40/0xc8
> [  297.704064]  trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
> [  297.704066]  __traceiter_cxl_port_aer_uncorrectable_error+0x90/0x108
> [  297.704068]  cxl_ras_inject_set+0x278/0x3d0
> [  297.704070]  simple_attr_write_xsigned.isra.0+0x198/0x298
> [  297.704074]  simple_attr_write+0x44/0x88
> [  297.704076]  debugfs_attr_write+0x78/0xd0
> [  297.704080]  vfs_write+0x1f4/0x960
> [  297.704083]  ksys_write+0x100/0x220
> [  297.704085]  __arm64_sys_write+0x78/0xc8
> [  297.704087]  invoke_syscall.constprop.0+0x150/0x200
> [  297.704090]  do_el0_svc+0xd0/0x210
> [  297.704091]  el0_svc+0x44/0x138
> [  297.704095]  el0t_64_sync_handler+0xc0/0x108
> [  297.704097]  el0t_64_sync+0x1b8/0x1c0
> 
> [  297.704100] Allocated by task 3078:
> [  297.704102]  kasan_save_stack+0x40/0x80
> [  297.704104]  kasan_save_track+0x24/0x58
> [  297.704105]  kasan_save_alloc_info+0x44/0x88
> [  297.704107]  __kasan_kmalloc+0x108/0x110
> [  297.704108]  __kmalloc_cache_noprof+0x1bc/0x588
> [  297.704111]  cxl_ras_inject_set+0xcc/0x3d0
> [  297.704112]  simple_attr_write_xsigned.isra.0+0x198/0x298
> [  297.704114]  simple_attr_write+0x44/0x88
> [  297.704116]  debugfs_attr_write+0x78/0xd0
> [  297.704117]  vfs_write+0x1f4/0x960
> [  297.704119]  ksys_write+0x100/0x220
> [  297.704120]  __arm64_sys_write+0x78/0xc8
> [  297.704122]  invoke_syscall.constprop.0+0x150/0x200
> [  297.704123]  do_el0_svc+0xd0/0x210
> [  297.704124]  el0_svc+0x44/0x138
> [  297.704125]  el0t_64_sync_handler+0xc0/0x108
> [  297.704127]  el0t_64_sync+0x1b8/0x1c0
> 
> [  297.704129] The buggy address belongs to the object at ffff0000dd6ee100
>                 which belongs to the cache kmalloc-rnd-09-96 of size 96
> [  297.704132] The buggy address is located 24 bytes inside of
>                 allocated 88-byte region [ffff0000dd6ee100, ffff0000dd6ee158)
> 
> [  297.704135] The buggy address belongs to the physical page:
> [  297.704138] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15d6e
> [  297.704140] flags: 0x17fffc000000000(node=0|zone=2|lastcpupid=0x1ffff)
> [  297.704143] page_type: f5(slab)
> [  297.704147] raw: 017fffc000000000 ffff00008001c1c0 dead000000000100 dead000000000122
> [  297.704148] raw: 0000000000000000 0000000802000200 00000000f5000000 0000000000000000
> [  297.704149] page dumped because: kasan: bad access detected
> 
> [  297.704150] Memory state around the buggy address:
> [  297.704151]  ffff0000dd6ee000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  297.704152]  ffff0000dd6ee080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  297.704153] >ffff0000dd6ee100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> [  297.704154]                                                     ^
> [  297.704155]  ffff0000dd6ee180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  297.704155]  ffff0000dd6ee200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  297.704156] =================================================================
> """
> 
> Define CXL_HEADERLOG_SIZE as SZ_64. The trace record's header_log field
> shrinks from 128 to 16 dwords, but only those 16 were ever real data,
> the rest was always junk.
> 
> Fixes: 2f6e9c305127 ("cxl/pci: add tracepoint events for CXL RAS")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/cxl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..f322d7c79ed2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -158,8 +158,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
>  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
>  #define CXL_RAS_CAPABILITY_LENGTH 0x58
> -#define CXL_HEADERLOG_SIZE SZ_512
> -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
> +#define CXL_HEADERLOG_SIZE SZ_64
> +#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))
>  
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
> 
> base-commit: 6f3ed7fec72fc8979b2a8c7219c0a9fcfc8d07b5

