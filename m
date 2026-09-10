Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CC2DEA89;
	Thu, 10 Sep 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051684; cv=none; b=X/WtlugcYOdacTXpjVji/Wp4i87WZg+5web6uKPJQ3PReIef19yPDis9jTlT7U0QnosSj+GoWOeO+/zpkYrJbL3iiOm7qBdZg5a8m0d8lRxOw6BCJlFF49QcPm7cBLYdI0vDlzif9v1DQAymgI+6KI+0aJ1+S7ZsyTzW4Jeg+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051684; c=relaxed/simple;
	bh=6wfsnoeAuoZ76WOMF5fx/DDG23jdmfWwK5WbNgWkOBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPchxcow5Qial+rUEIr86wgnNCFOaAN+xyRl+tBy9bbQ2KD9D5bLed5TdoK5vEKr+J6J0RgwgSx3b3lkXeEKUJqP4ABcfz09Ka8hUzMW1gu4SaQC187loAnehfC1NNk/FT1DFThAcYQklFKLCjViZjKZQ3t0LgpnB28XDJFojJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS2dzQ+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS2dzQ+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601061F000FF;
	Thu, 10 Sep 2026 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051683;
	bh=B8LvULR1C7zHsgbEpOUrhn3DOAKTICCIgCcp9Moo1AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZS2dzQ+Np0U4OAn0VVXIzCeZ5ieBiFxzuXO32HXGZjox2imU5YQqAvF8SDv3+HvpB
	 NxKzJ7t53F+QsLxd/CAKfh/ceBGbni9Duv70Wf65QpPhB0zouKNuCKjxwxHBz7Ulrb
	 YX/D12ZD9xp4XqsIIVhy+Pz4Q98Vhg7jVxbdMioUiDrhm08tGlgTlHSNBC5ULoSm7P
	 RjDqnY3JtId+Xe4grDputbR5RuXHVt8PwdzEvcy+eynCsYB2Ookav39t3u54y4bkvh
	 iX1Yd4WaL2lpHCK6hln10VYqPdfl55bipsdfB0oRiHwHmEfLJXIjbCAbdjH9fkO7ly
	 YP/fvHYNEODkg==
Date: Thu, 10 Sep 2026 15:47:52 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/12] mm/memory_hotplug: drop CONFIG_HAVE_ARCH_PFN_VALID
 handling from pfn_to_online_page()
Message-ID: <aqLB0Fe_bCRSph9E@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-12-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-12-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:33:05PM +0200, David Hildenbrand (Arm) wrote:
> Drop CONFIG_HAVE_ARCH_PFN_VALID handling, as CONFIG_HAVE_ARCH_PFN_VALID
> is never used with CONFIG_MEMORY_HOTPLUG, as the latter depends on
> CONFIG_SPARSEMEM_VMEMMAP. Make sure it stays that way.

So argument is:

mm/Makefile:

memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o

Is memory_hotplug.c even compiled at all?

mm/Kconfig:

menuconfig MEMORY_HOTPLUG
	bool "Memory hotplug"
	select MEMORY_ISOLATION
	depends on SPARSEMEM_VMEMMAP
	depends on ARCH_ENABLE_MEMORY_HOTPLUG
	depends on 64BIT
	select NUMA_KEEP_MEMINFO if NUMA

$ cd arch
$ rg HAVE_ARCH_PFN_VALID
Kconfig
1762:config HAVE_ARCH_PFN_VALID

arm/Kconfig
94:	select HAVE_ARCH_PFN_VALID

arm/mm/init.c
121:#ifdef CONFIG_HAVE_ARCH_PFN_VALID

arm/include/asm/page.h
178:#ifdef CONFIG_HAVE_ARCH_PFN_VALID

m68k/Kconfig.cpu
23:	select HAVE_ARCH_PFN_VALID
40:	select HAVE_ARCH_PFN_VALID

arc/Kconfig
463:	select HAVE_ARCH_PFN_VALID

All of arm, m68k and arc are 32-bit arches so by definition MEMORY_HOTPLUG
can't be selected.

>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

So LGTM and:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/memory_hotplug.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b428da66d279c..58ce35cb48f57 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -344,6 +344,8 @@ struct page *pfn_to_online_page(unsigned long pfn)
>  	struct dev_pagemap *pgmap;
>  	struct mem_section *ms;
>
> +	BUILD_BUG_ON(IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID));

Haha nicest way of removing some later code I've seen. Just make it not compile
if such a thing happens :)

> +
>  	if (nr >= NR_MEM_SECTIONS)
>  		return NULL;
>
> @@ -351,13 +353,6 @@ struct page *pfn_to_online_page(unsigned long pfn)
>  	if (!online_section(ms))
>  		return NULL;
>
> -	/*
> -	 * Save some code text when online_section() +
> -	 * pfn_section_valid() are sufficient.
> -	 */
> -	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
> -		return NULL;
> -
>  	if (!pfn_section_valid(ms, pfn))
>  		return NULL;
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
