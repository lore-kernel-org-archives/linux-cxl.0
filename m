Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB61C3F65F7;
	Tue, 17 Mar 2026 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766641; cv=none; b=suF41W6815c61XJLKGFTfFsSfvwevAlSn0a8a9dZc41MCLMPMxLvVQztDMlpMVpOnYX2G5XdWJxaiCoAUSLpsaOSGt0jekHwn//SgqPcuajDioVUZfPa2XrgMwhB+/sYsOQeLXiBOFLfHjkf0dOKsSxlF+7QGp4bqwEx1Tpr9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766641; c=relaxed/simple;
	bh=c1O1NRiO8RPTnZL/oHNtjrDswcxNKxRxDOqUVt5f2o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8q16L5/bhusriD1gdPZZOczcV7VtTaE5eOgvtxO9HIfE3gyrXOgTzT9nKvHCgSVfPfqQYVKKiSurnhk3fzWMkes4Enz/W3mSzJJXvLQA/UZdao7Xz/3FTSjA1MUVyI+XenI4+h/ZHayEH5G2qHRLx/1sQ5RhexgVzGjs3ckEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAWwrGlr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAWwrGlr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE21C4CEF7;
	Tue, 17 Mar 2026 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766641;
	bh=c1O1NRiO8RPTnZL/oHNtjrDswcxNKxRxDOqUVt5f2o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAWwrGlrXhf6PR29TmnxH1XIh06squZG430WQjfXPZ9K5+UQvscSFqIBaceND290b
	 pABBgZdbP8DrGPOJ+eQYbpA/t8yzeNuQrKx1Z8VYJQJmOi+R6And+umGWDJe7jtWG2
	 11EC/Pf6TwUgCeNqvuPDeXGF5LS4nTQkQhA7J5uszWYQBznPLaF757+7Hh3tZO9nHV
	 hATV7yIvULtcnd00gAb1mhHJOaArLtc9YbpEPt9bF18MEzd1MFw9VrEG02lCa7ltxA
	 uuOWjjVTsrwaIzfYuDVa1RN2D+74d/6sqdc9+aKBm2mBnek7BoE0E0gaRlZAaSNRQO
	 a3NE+ODhyklrw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 05/14] mm/sparse: remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG
Date: Tue, 17 Mar 2026 17:56:43 +0100
Message-ID: <20260317165652.99114-6-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317165652.99114-1-david@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_MEMORY_HOTPLUG now depends on CONFIG_SPARSEMEM_SPARSEMEM. So
let's remove the !CONFIG_SPARSEMEM_VMEMMAP leftovers.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 61 -----------------------------------------------------
 1 file changed, 61 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 93252112860e..636a4a0f1199 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -657,7 +657,6 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -729,66 +728,6 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 
 	return rc;
 }
-#else
-static struct page * __meminit populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
-		struct dev_pagemap *pgmap)
-{
-	return kvmalloc_node(array_size(sizeof(struct page),
-					PAGES_PER_SECTION), GFP_KERNEL, nid);
-}
-
-static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap)
-{
-	kvfree(pfn_to_page(pfn));
-}
-
-static void free_map_bootmem(struct page *memmap)
-{
-	unsigned long maps_section_nr, removing_section_nr, i;
-	unsigned long type, nr_pages;
-	struct page *page = virt_to_page(memmap);
-
-	nr_pages = PAGE_ALIGN(PAGES_PER_SECTION * sizeof(struct page))
-		>> PAGE_SHIFT;
-
-	for (i = 0; i < nr_pages; i++, page++) {
-		type = bootmem_type(page);
-
-		BUG_ON(type == NODE_INFO);
-
-		maps_section_nr = pfn_to_section_nr(page_to_pfn(page));
-		removing_section_nr = bootmem_info(page);
-
-		/*
-		 * When this function is called, the removing section is
-		 * logical offlined state. This means all pages are isolated
-		 * from page allocator. If removing section's memmap is placed
-		 * on the same section, it must not be freed.
-		 * If it is freed, page allocator may allocate it which will
-		 * be removed physically soon.
-		 */
-		if (maps_section_nr != removing_section_nr)
-			put_page_bootmem(page);
-	}
-}
-
-static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
-{
-	return 0;
-}
-
-static bool is_subsection_map_empty(struct mem_section *ms)
-{
-	return true;
-}
-
-static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
-{
-	return 0;
-}
-#endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 /*
  * To deactivate a memory region, there are 3 cases to handle across
-- 
2.43.0

