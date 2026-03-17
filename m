Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEA285C88;
	Tue, 17 Mar 2026 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776933; cv=none; b=fBl5Qla35KIlwm/MHjEL46OX7koSxmch3o2+rJcBrn4RltEQ8nicqmZSBE2o1NtzuViYSgOQfYm9fEl0y7EaEQlLsQe3ewcqXhKZhIWT4o0Z/sTvyN/lQEpQ7O/gekRq6orgM/hf97GGNkMJ/cnzu3po+w53pugTt7NXf65N/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776933; c=relaxed/simple;
	bh=g5W03nIUJQ8AH7zq0zLLZ73bPV9N4HQkXCDIdzXVvP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvQHTK5XJK528htrdxVVOmJr/7lb9TKV0MAZb2EI5XmU7S8u6QViSuwhmp+NlbbX3GswNWCb6a6LrDCIgeoG9LDbHb1t+FlU9PHvNNoylawO6qF1+++7mKWAr98ptHQtMVne3rqEocJhcJN4ZX5gMTlUKbAiAsKZ5/IEUY0YNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJfUoC5i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJfUoC5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99217C4CEF7;
	Tue, 17 Mar 2026 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773776933;
	bh=g5W03nIUJQ8AH7zq0zLLZ73bPV9N4HQkXCDIdzXVvP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJfUoC5iPRJk6u771gEhRmH2sdePOmvBwKs9YVXG0awVVQfqY1WqyMEnCgmpJQdXC
	 Y+AwUe15L1y/xqHIVp7Xqei4JkqU+hu/H4ldbufeh2MEs3v8uzI6rhGRVrBxFXvSAT
	 QNNBmctW32KJRrjacwL0EpuEMj+UgbK/nKuwI8uAc0Ln9pxmBmj4+P6aXJmvbgNz3z
	 2WfZiY0lo6bnFRvaqkiveWAyUvwoPnW0J0Q81pjfvu5JVBdIyfCOTzle1yV35ZbLl3
	 gOxZNREDIAGEHS4N5iFZE+yprOUuRW7s67iE2MFXlhWf3yRX2LbrDm9QGYC6SXdt0V
	 pqeHiSBc2zC6w==
Date: Tue, 17 Mar 2026 19:48:51 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 09/14] mm/sparse: remove CONFIG_MEMORY_HOTPLUG-specific
 usemap allocation handling
Message-ID: <f23aa64a-d78f-4c57-a08b-5c589889b7fc@lucifer.local>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-10-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-10-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:47PM +0100, David Hildenbrand (Arm) wrote:
> In 2008, we added through commit 48c906823f39 ("memory hotplug: allocate
> usemap on the section with pgdat") quite some complexity to try
> allocating memory for the "usemap" (storing pageblock information
> per memory section) for a memory section close to the memory of the
> "pgdat" of the node.
>
> The goal was to make memory hotunplug of boot memory more likely to
> succeed. That commit also added some checks for circular dependencies
> between two memory sections, whereby two memory sections would contain
> each others usemap, turning bot memory sections un-removable.

Typo: bot -> both. Presumably you are not talking about memory a bot of some
kind allocated :P

>
> However, in 2010, commit a4322e1bad91 ("sparsemem: Put usemap for one node
> together") started allocating the usemap for multiple memory
> sections on the same node in one chunk, effectively grouping all usemap
> allocations of the same node in a single memblock allocation.
>
> We don't really give guarantees about memory hotunplug of boot memory, and
> with the change in 2010, it is pretty much impossible in practice to get
> any circular dependencies.

Pretty much impossible? :) We can probably go so far as to so impossible no?

>
> commit 48c906823f39 ("memory hotplug: allocate usemap on the section with
> pgdat") also added the comment:
>
> 	"Similarly, a pgdat can prevent a section being removed. If
> 	 section A contains a pgdat and section B
> 	 contains the usemap, both sections become inter-dependent."
>
> Given that we don't free the pgdat anymore, that comment (and handling)
> does not apply.

Isn't pgdat synonymous with a node and that's the data structure that describes
a node right? Confusingly typedef'd from pglist_data to pg_data_t but then
referred to as pgdat because all that makes so much sense :)

But I'm confused, does a section containing a pgdat mean a section having the
pgdat data structure literally allocated in it?

A usemap is... something that tracks pageblock metadata I think right?

Anyway I'm also confused by 'given we don't free the pgdat any more', but the
comment says a 'pgdat can prevent a section being removed' rather than anything
about it being removed?

I guess it means the OTHER section could be prevented from being removed even
after it's gone.. somehow?

Anyway! I think maybe this could be clearer, somehow :)

>
> So let's simply remove this complexity.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

I think what you've done in the patch is right though, we're not doing any of
these dances after a4322e1bad91 and pgdats sitting around mean we don't really
care about where the usemap goes anyway I don't think so...

I usemap and I find myself in a place where I give you a:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

!

> ---
>  mm/sparse.c | 100 +---------------------------------------------------
>  1 file changed, 1 insertion(+), 99 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 2a1f662245bc..b57c81e99340 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -294,102 +294,6 @@ size_t mem_section_usage_size(void)
>  	return sizeof(struct mem_section_usage) + usemap_size();
>  }
>
> -#ifdef CONFIG_MEMORY_HOTREMOVE
> -static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
> -{
> -#ifndef CONFIG_NUMA
> -	VM_BUG_ON(pgdat != &contig_page_data);
> -	return __pa_symbol(&contig_page_data);
> -#else
> -	return __pa(pgdat);
> -#endif
> -}
> -
> -static struct mem_section_usage * __init
> -sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
> -					 unsigned long size)
> -{
> -	struct mem_section_usage *usage;
> -	unsigned long goal, limit;
> -	int nid;
> -	/*
> -	 * A page may contain usemaps for other sections preventing the
> -	 * page being freed and making a section unremovable while
> -	 * other sections referencing the usemap remain active. Similarly,
> -	 * a pgdat can prevent a section being removed. If section A
> -	 * contains a pgdat and section B contains the usemap, both
> -	 * sections become inter-dependent. This allocates usemaps
> -	 * from the same section as the pgdat where possible to avoid
> -	 * this problem.
> -	 */
> -	goal = pgdat_to_phys(pgdat) & (PAGE_SECTION_MASK << PAGE_SHIFT);
> -	limit = goal + (1UL << PA_SECTION_SHIFT);
> -	nid = early_pfn_to_nid(goal >> PAGE_SHIFT);
> -again:
> -	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
> -	if (!usage && limit) {
> -		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
> -		goto again;
> -	}
> -	return usage;
> -}
> -
> -static void __init check_usemap_section_nr(int nid,
> -		struct mem_section_usage *usage)
> -{
> -	unsigned long usemap_snr, pgdat_snr;
> -	static unsigned long old_usemap_snr;
> -	static unsigned long old_pgdat_snr;
> -	struct pglist_data *pgdat = NODE_DATA(nid);
> -	int usemap_nid;
> -
> -	/* First call */
> -	if (!old_usemap_snr) {
> -		old_usemap_snr = NR_MEM_SECTIONS;
> -		old_pgdat_snr = NR_MEM_SECTIONS;
> -	}
> -
> -	usemap_snr = pfn_to_section_nr(__pa(usage) >> PAGE_SHIFT);
> -	pgdat_snr = pfn_to_section_nr(pgdat_to_phys(pgdat) >> PAGE_SHIFT);
> -	if (usemap_snr == pgdat_snr)
> -		return;
> -
> -	if (old_usemap_snr == usemap_snr && old_pgdat_snr == pgdat_snr)
> -		/* skip redundant message */
> -		return;
> -
> -	old_usemap_snr = usemap_snr;
> -	old_pgdat_snr = pgdat_snr;
> -
> -	usemap_nid = sparse_early_nid(__nr_to_section(usemap_snr));
> -	if (usemap_nid != nid) {
> -		pr_info("node %d must be removed before remove section %ld\n",
> -			nid, usemap_snr);
> -		return;
> -	}
> -	/*
> -	 * There is a circular dependency.
> -	 * Some platforms allow un-removable section because they will just
> -	 * gather other removable sections for dynamic partitioning.
> -	 * Just notify un-removable section's number here.
> -	 */
> -	pr_info("Section %ld and %ld (node %d) have a circular dependency on usemap and pgdat allocations\n",
> -		usemap_snr, pgdat_snr, nid);
> -}
> -#else
> -static struct mem_section_usage * __init
> -sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
> -					 unsigned long size)
> -{
> -	return memblock_alloc_node(size, SMP_CACHE_BYTES, pgdat->node_id);
> -}
> -
> -static void __init check_usemap_section_nr(int nid,
> -		struct mem_section_usage *usage)
> -{
> -}
> -#endif /* CONFIG_MEMORY_HOTREMOVE */
> -
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>  unsigned long __init section_map_size(void)
>  {
> @@ -486,7 +390,6 @@ void __init sparse_init_early_section(int nid, struct page *map,
>  				      unsigned long pnum, unsigned long flags)
>  {
>  	BUG_ON(!sparse_usagebuf || sparse_usagebuf >= sparse_usagebuf_end);
> -	check_usemap_section_nr(nid, sparse_usagebuf);
>  	sparse_init_one_section(__nr_to_section(pnum), pnum, map,
>  			sparse_usagebuf, SECTION_IS_EARLY | flags);
>  	sparse_usagebuf = (void *)sparse_usagebuf + mem_section_usage_size();
> @@ -497,8 +400,7 @@ static int __init sparse_usage_init(int nid, unsigned long map_count)
>  	unsigned long size;
>
>  	size = mem_section_usage_size() * map_count;
> -	sparse_usagebuf = sparse_early_usemaps_alloc_pgdat_section(
> -				NODE_DATA(nid), size);
> +	sparse_usagebuf = memblock_alloc_node(size, SMP_CACHE_BYTES, nid);

I guess nid here is the same node as the pgdat?

>  	if (!sparse_usagebuf) {
>  		sparse_usagebuf_end = NULL;
>  		return -ENOMEM;
> --
> 2.43.0
>

This is quite the simplification :)

Cheers, Lorenzo
