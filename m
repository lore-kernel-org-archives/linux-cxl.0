Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161353;
	b=0eA83y2CdDrP0kyaVMU073LievzOueSAXFhiUULYEMzhHGioINEDmfKS8d6MArDw4Ors
	 wUK3AGT9gU69lnCaLvaSl+ppi7gN+ETShFu+dtbr+YFBsoudse0hbyoo/3cYtcjleKfIA
	 x+UQsgnuKYa7yb2FLQNUs2qAyMOvc1ZswgjgdN/ZKKh70A9THkvXeXXWscp16CJdC4+W7
	 1uFPan+K7vtCZv4Gac05G0EI7kqyBibf1VPMEN1PVaY64Tah6VDfIc4x9tUNOq6VrEith
	 Bvv9yH543IT1HrkWBVgpZyPqe7VyUJZqwaY/ryOykPfBrhyntklWNM2bcfu4zk12oPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161353;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KJe1DnSL5I+ScvDr3zb529EygXW8khYJB6ts23Z9hAM=;
	b=1Mk92PprzNFuWtJgiLXe4a03B5+EX+xnIcASiy7ZFo+ldk/VEpu73XwZd0GXUYafcFJW
	 kgB0ne/mERoTulshFDicE0KpXOeFGBH51TyMLeyoqJ07ABGxEssBLvCz5IYNVkCa6IKPU
	 +VH/t0+CLSRd7X+AocT2bGyhC2RL9QBdCCYDcm5lvIw9jsmHgYT/jZWH/ryG3yncEwFpt
	 Tj480Iv9ZNOVYcgZj1GFpNHo1xx4NYaJTF0TxojtpwBN/VuWpRYBaVGOuivbJIgtrONNQ
	 NhaJFk0QIrzOzyVWvoUotKpOdnbJuKPP8r8byoyNnc397G5/0W+4KCjXR6kOVEcn/cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDPD8zXX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A33606A31A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDPD8zXX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4183C1F01828;
	Wed, 28 Oct 2026 04:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793161352;
	bh=KJe1DnSL5I+ScvDr3zb529EygXW8khYJB6ts23Z9hAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDPD8zXXytnUTyzxAqJY/nqLza35XK0CUR2IKGMTYIvpb4Cqs3TSqijASoj0hI1aJ
	 iHpKoxo9y9L1bDwOZhQ3JYNb2WgsJD6Kxu8HKT1znRG9oG1Xpc5r1zJuqx+Stz3txb
	 1F5jnB22/mj0Ld8rFIr0PVpw/NrzzX+/VZMFJaipyJ13pUfuwD8JG97uKpc2B5ba6m
	 ly2CpCqyWkjBAQXTwVSvVeFcIDwQOW/LwZAvZNCbawiiWxnQlcTs8v5yWqzP2BlMOU
	 5qep2HB8GbhceFiF27Kqy855JkRD84NSbHwSjB971cf46d2DzUy6DTiX5nLoRohjpk
	 OjsVlnfds4pbQ==
Message-ID: <sashiko-outbox-187473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] mm/compaction: wait for pfn walkers before
 poisoning offlined memmap
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com, david@kernel.org, ljs@kernel.org, liam@infradead.org, rppt@kernel.org, osalvador@suse.de, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com
In-Reply-To: <20261027042204.3741307-2-gourry@gourry.net>
References: <20261027042204.3741307-1-gourry@gourry.net>
 <20261027042204.3741307-2-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 04:22:30 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mm/compaction: clamping low_pfn in isolate_migratepages() loops fo=
rever
- [High] mm: race in pageblock_pfn_to_page() with move_pfn_range_to_zone() =
onlining
- [Medium] mm: pfn_walk_srcu is disabled when CONFIG_MEMORY_HOTREMOVE=3Dn
--

commit 6ad7c6454b21a8c91c2521a8135b38b5d2766881
Author: Gregory Price (Meta) <gourry@gourry.net>

mm/compaction: wait for pfn walkers before poisoning offlined memmap

This patch introduces an SRCU-fast read section around compaction PFN walks
and waits for readers in remove_pfn_range_from_zone() before poisoning
offlined memmap pages. It also updates pageblock_pfn_to_page() and
isolate_migratepages() to handle zone span changes across memory offlining.

> diff --git a/mm/compaction.c b/mm/compaction.c
> index f1b2060eb2016..2aeb18b6d54dd 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c

[ ... ]

> @@ -2116,6 +2121,9 @@ static isolate_migrate_t isolate_migratepages(struc=
t compact_control *cc)
>  	 */
>  	fast_find_block =3D low_pfn !=3D cc->migrate_pfn && !cc->fast_search_fa=
il;
> =20
> +	/* Offline may have shrunk the zone start past an old migrate_pfn */
> +	low_pfn =3D max(low_pfn, block_start_pfn);
> +
>  	/* Only scan within a pageblock boundary */
>  	block_end_pfn =3D pageblock_end_pfn(low_pfn);

[Severity: High]
Can clamping low_pfn to block_start_pfn without updating cc->migrate_pfn
cause compact_zone() to enter an unbounded infinite loop?

If memory offlining shrinks cc->zone->zone_start_pfn upward via
offline_pages() -> remove_pfn_range_from_zone() -> shrink_zone_span() while
compaction is running, cc->migrate_pfn can sit below the new
cc->zone->zone_start_pfn while cc->free_pfn is either also in the offlined
lower range (with cc->migrate_pfn < cc->free_pfn) or in the first pageblock
of the new zone start (where block_end_pfn > cc->free_pfn).

In isolate_migratepages() in mm/compaction.c, clamping low_pfn to
block_start_pfn advances block_end_pfn =3D pageblock_end_pfn(low_pfn) past
cc->free_pfn, so the pageblock loop is skipped completely:

	for (; block_end_pfn <=3D cc->free_pfn;
			fast_find_block =3D false,
			cc->migrate_pfn =3D low_pfn =3D block_end_pfn,
			block_start_pfn =3D block_end_pfn,
			block_end_pfn +=3D pageblock_nr_pages) {

Because the loop does not execute, isolate_migratepages() returns
ISOLATE_NONE without advancing cc->migrate_pfn or calling cond_resched().

Back in compact_zone(), compact_finished() -> __compact_finished() checks
compact_scanners_met(cc):

static inline bool compact_scanners_met(struct compact_control *cc)
{
	return (cc->free_pfn >> pageblock_order)
		<=3D (cc->migrate_pfn >> pageblock_order);
}

Since cc->migrate_pfn was never updated to low_pfn, compact_scanners_met(cc)
remains false and __compact_finished() returns COMPACT_CONTINUE (even
before checking fatal_signal_pending(current) when is_via_compact_memory()
or !pageblock_aligned(cc->migrate_pfn) holds), causing compact_zone() to
spin forever on ISOLATE_NONE without rescheduling.

Should cc->migrate_pfn also be updated when low_pfn is clamped to
block_start_pfn?

> diff --git a/mm/internal.h b/mm/internal.h
> index 3a402e735dbe2..fdc83a7aafb51 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -18,6 +18,7 @@
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
>  #include <linux/leafops.h>
> +#include <linux/srcu.h>
>  #include <linux/tracepoint-defs.h>
> =20
>  /* Internal core VMA manipulation functions. */
> @@ -1208,6 +1209,46 @@ struct tlbflush_unmap_batch;
>   */
>  extern struct workqueue_struct *mm_percpu_wq;
> =20
> +/*
> + * Compaction checks that a pageblock is online and then uses its pages,
> + * possibly across sleeps.  remove_pfn_range_from_zone() waits for these
> + * readers before it poisons the memmap of a range taken offline.
> + */
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +extern struct srcu_struct pfn_walk_srcu;

[Severity: Medium]
Should pfn_walk_srcu be guarded by CONFIG_MEMORY_HOTPLUG rather than
CONFIG_MEMORY_HOTREMOVE?

When CONFIG_MEMORY_HOTPLUG=3Dy, CONFIG_MHP_MEMMAP_ON_MEMORY=3Dy, and
CONFIG_MEMORY_HOTREMOVE=3Dn, pfn_walk_lock(), pfn_walk_unlock(), and
pfn_walk_synchronize() compile to no-ops.

However, during memory_block_online() in drivers/base/memory.c:

	if (nr_vmemmap_pages) {
		ret =3D mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
		if (ret)
			goto out;
	}

	ret =3D online_pages(start_pfn + nr_vmemmap_pages,
			   nr_pages - nr_vmemmap_pages, zone, mem->group);
	if (ret) {
		if (nr_vmemmap_pages)
			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
		goto out;
	}

If nr_vmemmap_pages >=3D PAGES_PER_SECTION, mhp_init_memmap_on_memory() in
mm/memory_hotplug.c marks full vmemmap sections online via
online_mem_sections() before online_pages() runs. If online_pages() then
fails, mhp_deinit_memmap_on_memory() calls offline_mem_sections() and
remove_pfn_range_from_zone(), which poisons the struct pages without waiting
for concurrent compaction pfn_walk readers when CONFIG_MEMORY_HOTREMOVE=3Dn.

[ ... ]

> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index 2b1017a91928c..3446a2ebdd0f2 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -216,7 +216,12 @@ extern struct page *__pageblock_pfn_to_page(unsigned=
 long start_pfn,
>  static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
>  				unsigned long end_pfn, struct zone *zone)
>  {
> -	if (zone->contiguous)
> +	/*
> +	 * Offline can shrink the zone under a caller's old pfns and then set
> +	 * zone->contiguous again, so only trust it inside the current span.
> +	 */
> +	if (smp_load_acquire(&zone->contiguous) &&
> +	    zone_spans_pfn(zone, start_pfn) && zone_spans_pfn(zone, end_pfn - 1=
))
>  		return pfn_to_page(start_pfn);
> =20
>  	return __pageblock_pfn_to_page(start_pfn, end_pfn, zone);

[Severity: High]
Can pageblock_pfn_to_page() race with move_pfn_range_to_zone() during memory
onlining and return poisoned struct pages through the zone->contiguous fast
path?

When a boundary range is offlined by remove_pfn_range_from_zone(), its
struct pages are poisoned, the zone span shrinks, and set_zone_contiguous()
sets zone->contiguous =3D true for the remaining span.

When that range (or a newly hot-added range) is later onlined via
online_pages() -> move_pfn_range_to_zone() in mm/memory_hotplug.c:

	clear_zone_contiguous(zone);

	if (zone_is_empty(zone))
		init_currently_empty_zone(zone, start_pfn, nr_pages);
	resize_zone_range(zone, start_pfn, nr_pages);
	resize_pgdat_range(pgdat, start_pfn, nr_pages);
	...
	memmap_init_range(nr_pages, nid, zone_idx(zone), start_pfn, 0,
			 MEMINIT_HOTPLUG, altmap, migratetype,
			 isolate_pageblock);

move_pfn_range_to_zone() clears zone->contiguous first (with a plain store
and no barrier or grace period) and then expands zone->zone_start_pfn and
zone->spanned_pages in resize_zone_range() before memmap_init_range()
reinitializes the poisoned struct pages and before the sections are marked
online.

Because pageblock_pfn_to_page() also loads zone->contiguous first and checks
zone_spans_pfn() second, a concurrent reader in pageblock_pfn_to_page() can
load zone->contiguous =3D=3D true right before clear_zone_contiguous(zone),=
 and
then observe the newly expanded zone_start_pfn / spanned_pages from
resize_zone_range() while memmap_init_range() is still running (or observe
the stores out of order on weakly ordered architectures), bypassing
__pageblock_pfn_to_page() on offline poisoned pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027042204.3741=
307-1-gourry@gourry.net?part=3D1
