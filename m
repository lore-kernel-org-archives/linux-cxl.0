Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DD18C932;
	Wed, 16 Oct 2024 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058792; cv=none; b=Ww5lR/hJwaHESpjOk1Px84rJIqtAzeV8BUlfdlLpNqvxjnpwtsFECJvXr3S+5tC+OCJwR7bn/wBoZa4smS8WMaKCiPom0+y2IztKtCEjy1ok4CYRGRLhZ7T/HAx1XuoRJfsJkWNhJaLBoR9BQjNXTwQaD0XadcexxSIK+oUg+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058792; c=relaxed/simple;
	bh=yH+onESiJsPDoF11czz2NHxvcfAqzirJr83WIvmwbM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g38LYObbrpMhOyueJEqisq8lUg4U542WKVjSjiIcBM8ze9Ml5NgIjGcAUgAu81vEbc1EHmN+DLk7Hu+UqEO7KOdD7/h2T7nuiloBaN5ls0idjbpg0RIF20rN4K8MyUzHnsHd4JQZltL9OOpzRwKgo2ln+tDAbIsCJJgkCzVOjfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRISqYkL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRISqYkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729058790; x=1760594790;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yH+onESiJsPDoF11czz2NHxvcfAqzirJr83WIvmwbM0=;
  b=CRISqYkL2kzXoGD2ZsByQCaDIbaPhwExU9u+tYeV9uc0gNkQTQur949v
   Qz0mrvFIdnGD4T+DO6gLfG3GAzQ6mJV4SLnswkyBN4RU9TI+oKH4wo/5a
   OU1lno6RCvJeEbcxKILyHhn1pRZy+FLWj7gBs/oB46oLNZ5dE2VOstgZ4
   nZ/ryHRouxKgfsZ7fku/rVV/4fcYCSW8+DPo0gtEE/AmIfXmgh4bexm76
   L0r0tY5f/eOAuMTHgor9K0QbZEHx921ZaLw9U1/ijC4dkySinROQgiS+I
   kX7RbyQRE6NWI26kaaEdRNRpP9elqNDGNi814SJEd+9yAEHjOfWWz3Doe
   A==;
X-CSE-ConnectionGUID: wEkTIY3eRQ6PSIfAR65iRA==
X-CSE-MsgGUID: i6bIHwTHS6SjaoybTBYorw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39609543"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39609543"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 23:06:29 -0700
X-CSE-ConnectionGUID: 7lfOfdlYTqWcuyB6E1V97A==
X-CSE-MsgGUID: v6SpD88yRQKnnFAEJ+r8Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82093840"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 23:06:27 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-cxl@vger.kernel.org,  Davidlohr Bueso <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Alison Schofield <alison.schofield@intel.com>,
  Vishal Verma <vishal.l.verma@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Dan Williams <dan.j.williams@intel.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on
 platform device
In-Reply-To: <20241016015213.900985-1-lizhijian@fujitsu.com> (Li Zhijian's
	message of "Wed, 16 Oct 2024 09:52:13 +0800")
References: <20241016015213.900985-1-lizhijian@fujitsu.com>
Date: Wed, 16 Oct 2024 14:02:53 +0800
Message-ID: <87o73k7fg2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Zhijian,

Li Zhijian <lizhijian@fujitsu.com> writes:

> The cxl_region_shared_upstream_bandwidth_update() in clx_core works on
> PCI/PCIe CXL device only while cxl_test was implemeneted by platform
> device.
>
> Mock a cxl_region_shared_upstream_bandwidth_update() which does nothing
> for cxl_core so that the cxl_test goes well.
>
> Abuse cxl_region_shared_upstream_bandwidth_update() on platform device
> will cause a kernel panic with calltrace:
>  platform cxl_host_bridge.3: host supports CXL (restricted)
>  Oops: general protection fault, probably for non-canonical address 0x3ef17856fcae4fbd: 0000 [#1] PREEMPT SMP PTI
>  CPU: 1 UID: 0 PID: 9167 Comm: cxl Kdump: loaded Tainted: G           OE      6.12.0-rc3-master+ #66
>  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>  Hardware name: LENOVO 90CXCTO1WW/, BIOS FCKT70AUS 04/23/2015
>  RIP: 0010:pci_bus_read_config_word+0x1c/0x60
>  Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 b8 87 00 00 00 48 83 ec 08 c7 44 24 04 00 00 00 00 f6 c2 01 75 29 <48> 8b 87 c0 00 00 00 48 89 cb 4c 8d 44 24 04 b9 02 00 00 00 48 8b
>  RSP: 0018:ffffa115034dfbb8 EFLAGS: 00010246
>  RAX: 0000000000000087 RBX: 0000000000000012 RCX: ffffa115034dfbfe
>  RDX: 0000000000000016 RSI: 000000006f4e2f4e RDI: 3ef17856fcae4efd
>  RBP: ffff8cc229121b48 R08: 0000000000000010 R09: 0000000000000000
>  R10: 0000000000000001 R11: ffff8cc225434360 R12: ffffa115034dfbfe
>  R13: 0000000000000000 R14: ffff8cc2f119a080 R15: ffffa115034dfc50
>  FS:  00007f31d93537c0(0000) GS:ffff8cc510a80000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f31d95f3370 CR3: 00000001163ea001 CR4: 00000000001726f0
>  Call Trace:
>   <TASK>
>   ? __die_body.cold+0x19/0x27
>   ? die_addr+0x38/0x60
>   ? exc_general_protection+0x1f5/0x4b0
>   ? asm_exc_general_protection+0x22/0x30
>   ? pci_bus_read_config_word+0x1c/0x60
>   pcie_capability_read_word+0x93/0xb0
>   pcie_link_speed_mbps+0x18/0x50
>   cxl_pci_get_bandwidth+0x18/0x60 [cxl_core]
>   cxl_endpoint_gather_bandwidth.constprop.0+0xf4/0x230 [cxl_core]
>   ? xas_store+0x54/0x660
>   ? preempt_count_add+0x69/0xa0
>   ? _raw_spin_lock+0x13/0x40
>   ? __kmalloc_cache_noprof+0xe7/0x270
>   cxl_region_shared_upstream_bandwidth_update+0x9c/0x790 [cxl_core]
>   cxl_region_attach+0x520/0x7e0 [cxl_core]
>   store_targetN+0xf2/0x120 [cxl_core]
>   kernfs_fop_write_iter+0x13a/0x1f0
>   vfs_write+0x23b/0x410
>   ksys_write+0x53/0xd0
>   do_syscall_64+0x62/0x180
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> And Ying also reported a KASAN error with similar calltrace.
>
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/linux-cxl/87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com/
> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

This fixes the KASAN error report in my test too.  Thanks!  Feel free to
add

Tested-by: "Huang, Ying" <ying.huang@intel.com>

--
Best Regards,
Huang, Ying
