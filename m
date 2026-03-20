Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64734B1A8;
	Fri, 20 Mar 2026 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044866; cv=none; b=rcibrkDHX9wCCDgEhKPeY2SHG8j0NdvbT43xn16nmI7lenn9vSm4ar7a6gRecpXpratn+pMwW1g5j5N1PVzrniJ3XRhxPVunfmTIl1f+tFU7p0WbIecOa/gJlWcTsPc5OVr6QdpCSqRta1TymAT03hdDNQWzAGt/9BjmvbykkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044866; c=relaxed/simple;
	bh=GbRJKi/UL19LjXb/zj2tspEF8IAz0ieC/2fklwT44sM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JW/CMW7G6Zc0o8MIKF7Mq0rHw5G/rkjI4mU51fIgnn7Mib+q6q/te5Cin7Pwk6uVyCLS5mltfijo3rwrByJeubF8FBz73mr1nqmh3f28LgztyJx4BB/9vKz0VidVrXBzEHFdwPwb+UhTUOELnRbRu10YN6NmY7URqZLgk//i0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5I2WfVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5I2WfVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A917C2BC9E;
	Fri, 20 Mar 2026 22:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044865;
	bh=GbRJKi/UL19LjXb/zj2tspEF8IAz0ieC/2fklwT44sM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g5I2WfVK3kWIJW4Y7drVtMvENCcnoLxj1B0PMuN70dK6hIX0GLgNOQLITSZrmehJu
	 eKLUowungftOUVOX4vo8v+M+qb4q74EIXld1PkuprCqDmAoednhpf2FjVWqYA8Sec0
	 64rQUWNlzhXHAAPTdNOSjB4TlKctYxJ1WeIgEpcmZRwNC1Wu0MiEEwaMnUgaZyIw2y
	 X7vltLf2qCsp/TOD5FRvRm9LJ59Jqnyi5VLa6mP2STHCoAARya4QfoZjTaLjndiZCC
	 9Z/btgNOBl5E9pR6v53StvvyO5c9y9Vge+kRCJmVqoP6AQfAtr8PnMK80mlX42rC83
	 IC4qzcyUWrMvA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:42 +0100
Subject: [PATCH v2 10/15] mm/sparse: remove CONFIG_MEMORY_HOTPLUG-specific
 usemap allocation handling
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-10-096addc8800d@kernel.org>
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
In-Reply-To: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, linux-riscv@lists.infradead.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

In 2008, we added through commit 48c906823f39 ("memory hotplug: allocate
usemap on the section with pgdat") quite some complexity to try
allocating memory for the "usemap" (storing pageblock information
per memory section) for a memory section close to the memory of the
"pgdat" of the node.

The goal was to make memory hotunplug of boot memory more likely to
succeed. That commit also added some checks for circular dependencies
between two memory sections, whereby two memory sections would contain
each others usemap, turning both boot memory sections un-removable.

However, in 2010, commit a4322e1bad91 ("sparsemem: Put usemap for one node
together") started allocating the usemap for multiple memory
sections on the same node in one chunk, effectively grouping all usemap
allocations of the same node in a single memblock allocation.

We don't really give guarantees about memory hotunplug of boot memory, and
with the change in 2010, it is impossible in practice to get any circular
dependencies.

So let's simply remove this complexity.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 100 +-----------------------------------------------------------
 1 file changed, 1 insertion(+), 99 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index b5825c9ee2f2..e2048b1fbf5f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -294,102 +294,6 @@ size_t mem_section_usage_size(void)
 	return sizeof(struct mem_section_usage) + usemap_size();
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
-static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
-{
-#ifndef CONFIG_NUMA
-	VM_BUG_ON(pgdat != &contig_page_data);
-	return __pa_symbol(&contig_page_data);
-#else
-	return __pa(pgdat);
-#endif
-}
-
-static struct mem_section_usage * __init
-sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
-					 unsigned long size)
-{
-	struct mem_section_usage *usage;
-	unsigned long goal, limit;
-	int nid;
-	/*
-	 * A page may contain usemaps for other sections preventing the
-	 * page being freed and making a section unremovable while
-	 * other sections referencing the usemap remain active. Similarly,
-	 * a pgdat can prevent a section being removed. If section A
-	 * contains a pgdat and section B contains the usemap, both
-	 * sections become inter-dependent. This allocates usemaps
-	 * from the same section as the pgdat where possible to avoid
-	 * this problem.
-	 */
-	goal = pgdat_to_phys(pgdat) & (PAGE_SECTION_MASK << PAGE_SHIFT);
-	limit = goal + (1UL << PA_SECTION_SHIFT);
-	nid = early_pfn_to_nid(goal >> PAGE_SHIFT);
-again:
-	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
-	if (!usage && limit) {
-		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
-		goto again;
-	}
-	return usage;
-}
-
-static void __init check_usemap_section_nr(int nid,
-		struct mem_section_usage *usage)
-{
-	unsigned long usemap_snr, pgdat_snr;
-	static unsigned long old_usemap_snr;
-	static unsigned long old_pgdat_snr;
-	struct pglist_data *pgdat = NODE_DATA(nid);
-	int usemap_nid;
-
-	/* First call */
-	if (!old_usemap_snr) {
-		old_usemap_snr = NR_MEM_SECTIONS;
-		old_pgdat_snr = NR_MEM_SECTIONS;
-	}
-
-	usemap_snr = pfn_to_section_nr(__pa(usage) >> PAGE_SHIFT);
-	pgdat_snr = pfn_to_section_nr(pgdat_to_phys(pgdat) >> PAGE_SHIFT);
-	if (usemap_snr == pgdat_snr)
-		return;
-
-	if (old_usemap_snr == usemap_snr && old_pgdat_snr == pgdat_snr)
-		/* skip redundant message */
-		return;
-
-	old_usemap_snr = usemap_snr;
-	old_pgdat_snr = pgdat_snr;
-
-	usemap_nid = sparse_early_nid(__nr_to_section(usemap_snr));
-	if (usemap_nid != nid) {
-		pr_info("node %d must be removed before remove section %ld\n",
-			nid, usemap_snr);
-		return;
-	}
-	/*
-	 * There is a circular dependency.
-	 * Some platforms allow un-removable section because they will just
-	 * gather other removable sections for dynamic partitioning.
-	 * Just notify un-removable section's number here.
-	 */
-	pr_info("Section %ld and %ld (node %d) have a circular dependency on usemap and pgdat allocations\n",
-		usemap_snr, pgdat_snr, nid);
-}
-#else
-static struct mem_section_usage * __init
-sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
-					 unsigned long size)
-{
-	return memblock_alloc_node(size, SMP_CACHE_BYTES, pgdat->node_id);
-}
-
-static void __init check_usemap_section_nr(int nid,
-		struct mem_section_usage *usage)
-{
-}
-#endif /* CONFIG_MEMORY_HOTREMOVE */
-
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 unsigned long __init section_map_size(void)
 {
@@ -486,7 +390,6 @@ void __init sparse_init_early_section(int nid, struct page *map,
 				      unsigned long pnum, unsigned long flags)
 {
 	BUG_ON(!sparse_usagebuf || sparse_usagebuf >= sparse_usagebuf_end);
-	check_usemap_section_nr(nid, sparse_usagebuf);
 	sparse_init_one_section(__nr_to_section(pnum), pnum, map,
 			sparse_usagebuf, SECTION_IS_EARLY | flags);
 	sparse_usagebuf = (void *)sparse_usagebuf + mem_section_usage_size();
@@ -497,8 +400,7 @@ static int __init sparse_usage_init(int nid, unsigned long map_count)
 	unsigned long size;
 
 	size = mem_section_usage_size() * map_count;
-	sparse_usagebuf = sparse_early_usemaps_alloc_pgdat_section(
-				NODE_DATA(nid), size);
+	sparse_usagebuf = memblock_alloc_node(size, SMP_CACHE_BYTES, nid);
 	if (!sparse_usagebuf) {
 		sparse_usagebuf_end = NULL;
 		return -ENOMEM;

-- 
2.43.0

