Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8E34DCC8;
	Fri, 20 Mar 2026 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044861; cv=none; b=baMI1L8SRWlGYrC716JI8NOHHEJdxy6bRTuJQeCAx6HIeR0wDbqALOaKFu45w2OphkOD3lJNbS8zK0N3QavuHj0t16zPQj7Rb15i/49jZMXUKozJdDJjUmbrulq3R8pH5iFu1iIq9QkwyVZkjflVRhzBiQPzccbdw5kmSQItKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044861; c=relaxed/simple;
	bh=Vtv/qpTDQk/7inFFI0u5qucQjzvddf+x5J6ke/XAmFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oR8drS/KJlKNGgfT9GqTT9uozSXDf7pZ/5LDIpz3XELfutFd+yX3jjYCkfn6rSGgJS+DvkCH1uDkMxicH4JrpIa9ffaicfn9++kHaELTQwH1u7fqpasnV2CVIYjw+6y0b7cCkhZkATuPGYORGDKfqQPcXLJN+aSD+okwpLSpsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/60OwKZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/60OwKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076F1C2BC9E;
	Fri, 20 Mar 2026 22:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044861;
	bh=Vtv/qpTDQk/7inFFI0u5qucQjzvddf+x5J6ke/XAmFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q/60OwKZJgZGnc4cuE408V8PndBf1ubURGRU3pC92Bz5GciFz+8dzq+3HsnIocd0n
	 gxzy4ohI3Ime2QOU8SrTS3Kw9GahO4smn/TxyBflFuU5M9GxtyE1t8d1tpjZ7wKhx3
	 Iuos+t8Rdy0j6ZwSK5llN27ldgM6i2wHL2f/4eYNoM92JypVg4++ZRszDwNpxWBpWo
	 K3XYvT9MoB0uuCrCf8OsJHhhnoc+FTuFI24fdT08ifh1HNPsxqtzBSaxC7e0oLpMBO
	 oRACyLlddYQzfCjcLx2utXgz9aRZIzmsdiqbULKAwd2U8r728s+/99zYbP9sf3IgQ3
	 9/vkIovCOHohQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:41 +0100
Subject: [PATCH v2 09/15] mm/sparse: remove sparse_decode_mem_map()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-9-096addc8800d@kernel.org>
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

section_deactivate() applies to CONFIG_SPARSEMEM_VMEMMAP only. So we can
just use pfn_to_page() (after making sure we have the start PFN of the
section), and remove sparse_decode_mem_map().

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/memory_hotplug.h |  2 --
 mm/sparse.c                    | 16 +---------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e77ef3d7ff73..815e908c4135 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -308,8 +308,6 @@ extern int sparse_add_section(int nid, unsigned long pfn,
 		struct dev_pagemap *pgmap);
 extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
 				  struct vmem_altmap *altmap);
-extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
-					  unsigned long pnum);
 extern struct zone *zone_for_pfn_range(enum mmop online_type,
 		int nid, struct memory_group *group, unsigned long start_pfn,
 		unsigned long nr_pages);
diff --git a/mm/sparse.c b/mm/sparse.c
index 875f718a4c79..b5825c9ee2f2 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -274,18 +274,6 @@ static unsigned long sparse_encode_mem_map(struct page *mem_map, unsigned long p
 	return coded_mem_map;
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-/*
- * Decode mem_map from the coded memmap
- */
-struct page *sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long pnum)
-{
-	/* mask off the extra low bits of information */
-	coded_mem_map &= SECTION_MAP_MASK;
-	return ((struct page *)coded_mem_map) + section_nr_to_pfn(pnum);
-}
-#endif /* CONFIG_MEMORY_HOTPLUG */
-
 static void __meminit sparse_init_one_section(struct mem_section *ms,
 		unsigned long pnum, struct page *mem_map,
 		struct mem_section_usage *usage, unsigned long flags)
@@ -754,8 +742,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 
 	empty = is_subsection_map_empty(ms);
 	if (empty) {
-		unsigned long section_nr = pfn_to_section_nr(pfn);
-
 		/*
 		 * Mark the section invalid so that valid_section()
 		 * return false. This prevents code from dereferencing
@@ -774,7 +760,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 			kfree_rcu(ms->usage, rcu);
 			WRITE_ONCE(ms->usage, NULL);
 		}
-		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
+		memmap = pfn_to_page(SECTION_ALIGN_DOWN(pfn));
 	}
 
 	/*

-- 
2.43.0

