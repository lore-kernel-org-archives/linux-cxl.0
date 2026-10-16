Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E33AC0EE
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153585; cv=none; b=lRjM7DKCzJzqDovG7zwRrWRl6ax0QSemnj4hxlpottrTL+vUeVWrZJBhV9P0PDz85XI3GBKatkWMA1f5km49DbU10AkefjVeeoKOjX7NHFu8sJ+kxWyoZCrEKqDykzaRnqwnQ5rW0/+uHYGisG5epqTRA+9fwEKkkkqrPcgrLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153585; c=relaxed/simple;
	bh=iQS1iD21s/x9cUb3mlyEkKEUuiUiFCD3Xv0ik/q6HEM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=L3chBw0iWTauUoPIwMOrLSrkVNMlYpJGrUqBcy0UifZlfX6N9atz7LU/ohHNO+CxDCXWGWexkIOvzqh/xXegwuvS1+ua2l+b7giw5Z1wnF3GeKYQv0KxJEG9S0+s49iHhpyl/jAM4GDmmundGIV8ZW32MJZJQD52MEBNAJw5a+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtUa5dwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtUa5dwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C434C1F000C4;
	Fri, 16 Oct 2026 12:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153584;
	bh=r94udATsTqE4t9F27ISFlWwCGEbjRz+khcg0VfuhkOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QtUa5dwY9T4dfdspJLT2JeY6Xa2TFOhd7PiNvrphSq8yUguegmLkEqROCUkhsOyzn
	 3H7Dm9uqKPYv6UEDpa75M5eW0nJOE9fOdrlqDi2fJay+hxjCFTW4aMf2996Kf5LAtH
	 zsNsUoK5gtgedQaiI5IjObvQJNWAdTSjrxHbECX6gs6i1SfcGH186AMqtwjiNbgYVX
	 Uh7Bju+MxPkRomtLDfbuxObNFUV+nAGkvDikL+NZeDDC6wsLzL6ghuEUR9qQry5Em/
	 Vv4UZsOkh7pqv6mH2vhCsKC97n2ts8RujcYtq09av5KoQcUVxaUt2ZdA3mnn2fqZr0
	 M8Hw93ceu/VOA==
Message-ID: <sashiko-outbox-174292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/7] mm/memblock: add a reserved-region flag for
 poisoned frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, kas@kernel.org, kexec@lists.infradead.org, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, shakeel.butt@linux.dev
Cc: linux-cxl@vger.kernel.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, kernel-team@meta.com
In-Reply-To: <20261016-hwpoison-kho-v6-4-f304255147da@debian.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-4-f304255147da@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:26:22 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: page-level sharing detection fails due to unaligned base check
--

commit 91f3abf246b482e4b3339361ad3572545e8e83f6
Author: Breno Leitao <leitao@debian.org>

mm/memblock: add a reserved-region flag for poisoned frames

This commit adds the MEMBLOCK_RSRV_HWPOISON flag to memblock to reserve
hardware-poisoned frames found by an earlier kernel. It introduces
memblock_reserve_hwpoison() to handle these reservations while attempting
to avoid overlap with existing reserved regions. Additionally, it ensures
these frames are flagged with PG_hwpoison instead of PG_reserved during
initialization.

> diff --git a/mm/memblock.c b/mm/memblock.c
> index 31961ed628b0a..d20d99972a4db 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c

[ ... ]

> @@ -1015,6 +1018,55 @@ int __init_memblock __memblock_reserve(phys_addr_t=
 base, phys_addr_t size,
>  	return memblock_add_range(&memblock.reserved, base, size, nid, flags);
>  }
> =20
> +int __init memblock_reserve_hwpoison(phys_addr_t base, phys_addr_t size)
> +{
> +	phys_addr_t end =3D base + size;
> +	bool reserved =3D false;
> +	int err =3D 0;
> +
> +	while (base < end) {
> +		phys_addr_t next =3D end;
> +		struct memblock_region *r;
> +		bool covered =3D false;
> +
> +		for_each_reserved_mem_region(r) {
> +			if (r->base + r->size <=3D base)
> +				continue;
> +			if (r->base >=3D end)
> +				break;
> +			if (PAGE_ALIGN_DOWN(r->base) <=3D base) {

[Severity: High]
Does this byte-level check cause the loop to skip regions that share
the same page but end before the new reservation's base?

The commit message states that a page shared with an earlier reservation
stays with it, so no page is flagged twice. However, if an existing
reservation spans 0x1000-0x1100 and the new HWPOISON reservation requests
0x1800-0x1900 (both in the same 4KB page), 0x1100 <=3D 0x1800 is true.
This causes the loop to skip the region and bypass the subsequent
PAGE_ALIGN_DOWN overlap check, leading to the new region being reserved
alongside the old one.

If the prior reservation was a KERNEL reservation, the page erroneously
receives both PG_reserved and PG_hwpoison.

[ ... ]

> +/*
> + * Frames an earlier kernel found poisoned end up as a frame poisoned by=
 this
> + * kernel would: PG_hwpoison, not PG_reserved. Holes in the range stay r=
eserved.
> + */
> +static void __init memmap_init_hwpoison_range(phys_addr_t start,
> +					      phys_addr_t end, int nid)
> +{
> +	unsigned long pfn;
> +
> +	for_each_valid_pfn(pfn, PFN_DOWN(start), PFN_UP(end)) {
> +		struct page *page =3D pfn_to_page(pfn);
> +
> +		init_deferred_page(pfn, nid);
> +
> +		if (memblock_is_map_memory(PFN_PHYS(pfn)))
> +			hwpoison_boot_page(page);

[Severity: High]
Can this path execute multiple times for the same PFN when a page contains
multiple unmerged HWPOISON fragments?

Because of the unaligned base check bypass above,
memmap_init_reserved_pages() will process the same page twice. Since
hwpoison_boot_page() lacks a TestSetPageHWPoison() guard, it unconditionally
increments num_poisoned_pages and calls adjust_managed_page_count(page, 1)
on every invocation.

This artificially inflates both the global poisoned page count and the
zone's managed page count, potentially leading to page allocator
underflows and corrupted VM statistics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-hwpoison-k=
ho-v6-0-f304255147da@debian.org?part=3D4
