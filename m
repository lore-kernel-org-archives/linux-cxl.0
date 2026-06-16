Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F272314A98;
	Tue, 16 Jun 2026 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642513; cv=none; b=bNth/3l7jzz/1oWsgdke6To8X2OYnzY0okrSd4Dxwe8IBtNGNT8iF6EYTZviMJqZcRW9Yq/lKr54PPzXLMiuv3SHd4iAupJ0Tk3J3npkc5Go8CuyyzOPVktCpiMLOPOwFI1cJaWY82nCBV8X9u7wOFLwLnD51Kv9HB4rycZaVEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642513; c=relaxed/simple;
	bh=CDSdQFV3qioaHqPl0tpkEmOlvuCgJgIFMTWdM6MV6kI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DlavyKvwoc3DN34c9xuDR0YwzxXVyOnYK1Ci2/64PRg+9xtcgpGJv57N/fCRrKTIeC6IWbQk5zQVtqtEghh+ZPgif3GyEVHLPwy/kOl9zsxb+pgSb42WXDkZECeo/CMcdVaw++CpN3h6SrG9vS1ft8O5S9ZD3vbx7UiYpTHL1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpWJIZ+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpWJIZ+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9579F1F00A3A;
	Tue, 16 Jun 2026 20:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781642512;
	bh=LsRWMCQ172Nctdls4C+Bu9r4tkyZ2inZmMtjh4z7S2s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bpWJIZ+BuPMkR2J0vB/CZ3qF/MCuUfNObgKkcn0bKJVn+oV8m/VYALZLOnf0IrY8f
	 a9BC1oCv37YK3wdxbF3FBDTKk4hUj9eeWnqZpMaB7phJ8V/pu7/lRnzrXKcLpzvTcY
	 D2LOrBP4MHx9QM9qn4Dlkfv54z+L8pbSjVlCox3l4hZ/H3JNF5sd54cK0xxNedV0tT
	 jk8qw8gMY9+AHi708scCcI2blC4YKM+IqKeVcimN6R/F/ue+CmaN1IdfvGVkWhk9/e
	 0IUSDfZ0SneN+BlmJxUkpCyzD/WILtD7/GluO6MuPYDFzeVvo1yrLn6k4kX4I96gJE
	 90OPcBDV3lHsQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D15ABF40075;
	Tue, 16 Jun 2026 16:41:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 16 Jun 2026 16:41:50 -0400
X-ME-Sender: <xms:DrUxah0cY6E79bhvw0oVb8_DhNzD6_8UvRV0uV08MTdFvTNgoLYXjQ>
    <xme:DrUxakDFdRz-kuQYnQZgPCtbXMksyjJO6-jIhpnT3C0uaXbSmFuK1w68bOtTh48fi
    yH2P3dkkHj_l4UWC6lkuVxIgmzTflHfnEaUoEC28CeLbKwyS9ng0A>
X-ME-Received: <xmr:DrUxaoAYPgfkeaNSn0xwjTlj2jzyiID54EAvEmeslqbAbuAFl1uTsZtthyEavgqnB-nPPIdLKMmCAGVyWqCxZjqmOBB88YnVubg>
X-ME-Proxy-Cause: dmFkZTGxjNUqEQ60KHr/fFpc4xYVhJD+L2nlX44w5XNMcuWuqDKG+MpaqNmPOgiEHlM1HA
    /51Cc9M6RJwRRKyJShiZo1jnOtkmKXVZ1iCOFJMOz1OH5EFP+qQY2ilSVGGVzJZz7l8KNT
    6NTqH2DMREMqq+BziRlbIJeZLTwcSiCe5bov77TMsj3k1CmOif5prpVjv67EioHXrgsFgK
    F4ElZJstZqFi0e3ZwyY9U7Lv9ObxIVIp3+kXTnfFLjjNSeoBoPuAhTxkEnPAPOj0GXr7fs
    WAlPdiBYN0Gu+XeViP4CF5uxzVY8bLUpeue3xr433h+3iuFLZ1SHUJFUauTgZ7niPUh4jD
    2LDx3dTeMwvbzcAwBpMICyl3SDesVckJ4eIet9hIDiCqHBiJcn3yvJLZQBaL93O4xwm4tt
    +AkGtUWNyHTJOfoCda1vvuClp53m9CHn+uPO5Vh29qR7J9cyr8nIpCycfo3aTIGTKNTiHE
    7zEZXCfg5bz1OjfSoEucmRiedrSCscU8njOdkqjAXwa7RPCbih2u1smPuao9qdvTqP5+lD
    PWt88bWCNoMgvVgU94FfBufD7QHVWeQZCt8bF2ov6kXQ6+Jh4b4g4g3mI2eO8FqGWwi9iw
    c/7b8Y4DQpBbQZMqmEorz5dDUWrZKwi6MtLE8zeJ2NXk4t5U2IJ2qd7jQymw
X-ME-Proxy: <xmx:DrUxalNHGZhaW2Gtw_oY7lM9vlGi8H2yA6s5pb9XzGGVO5gBfnH_yA>
    <xmx:DrUxaiOjG0BmeicE4digQ5BEmu5yQitOdGKBEXG9iEbmZoOVIvVTRA>
    <xmx:DrUxapuDwnu8T6reV99WSq8KWH7nofClnxyxj9XodiJKL8Nzd6ia5Q>
    <xmx:DrUxan9qkns6VrPKHt0EpbdQofV_cePysEuFD53nEST0FeqXRBemQg>
    <xmx:DrUxalEJNNoHcq7CanVFTHUsQHe4OAOiC6q3-DrMfiZE14aG_3o1u5RL>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 16:41:50 -0400 (EDT)
Date: Tue, 16 Jun 2026 13:41:49 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Richard Cheng <icheng@nvidia.com>, 
 dave@stgolabs.net, 
 jic23@kernel.org, 
 dave.jiang@intel.com, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 ira.weiny@intel.com, 
 djbw@kernel.org
Cc: shiju.jose@huawei.com, 
 ming.li@zohomail.com, 
 alucerop@amd.com, 
 linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 newtonl@nvidia.com, 
 kristinc@nvidia.com, 
 kaihengf@nvidia.com, 
 kobak@nvidia.com, 
 Richard Cheng <icheng@nvidia.com>
Message-ID: <6a31b50d3d5da_9b855100d9@djbw-dev.notmuch>
In-Reply-To: <20260611094546.31496-1-icheng@nvidia.com>
References: <20260611094546.31496-1-icheng@nvidia.com>
Subject: Re: [PATCH] cxl/mbox: Bound the output payload allocation to mailbox
 payload size
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Cheng wrote:
> CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
> size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
> kvzalloc(out.size). A large out.size drives a huge allocation, even
> above INT_MAX it WARNS and taints, on kernel with panic_on_warn=1, it
> will panic.
> The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
> to min(out.size, payload_size, device len), so the bound buffer is never
> written beyond payload_size. Clamp the allocation to payload_size too,
> matching the RAW path.

Patch looks good, just comments on Fixes and formatting:

> With the following reproducer[1] , we'll get error logs [2].
> [1]:
> """
[ .. snip reproducer, yes a new test would be welcome .. ]
> """
> [2]:

Trim reports to the relevant information, I usually drop timestamps and
all but the Call Trace:

>   WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x534/0x818,
>   CPU#131: cxl_repro_outsi/4668
>    Tainted: [W]=WARN
>    Call trace:
>     __kvmalloc_node_noprof+0x534/0x818 (P)
>     cxl_send_cmd+0x514/0x7e0
>     cxl_memdev_ioctl+0x7c/0xe0
>     __arm64_sys_ioctl+0x4a4/0xbc8
>     invoke_syscall.constprop.0+0xac/0x100
>     do_el0_svc+0x4c/0x100
>     el0_svc+0x50/0x2b0
>     el0t_64_sync_handler+0xc0/0x108
>     el0t_64_sync+0x1b8/0x1c0
>    ---[ end trace 0000000000000000 ]---
> 
> Fixes: 4faf31b43468 ("cxl/mbox: Move mailbox and other non-PCI specific infrastructure to the core")

Looks like the correct Fixes would be:

Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")

...as unbounded input was mistakenly allowed from the outset.
