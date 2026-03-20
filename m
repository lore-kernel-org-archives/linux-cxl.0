Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2EE2D3A60;
	Fri, 20 Mar 2026 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044849; cv=none; b=IZnZksdSky0vtxysphwXb/siAn8lYO5IjBuOLI6sQnDkPpmgl71gSPqpc6rdq5Eg1E3fqa3BPr7FLtrJNE3AkZgjwNlp0ddGiPcTzXI8zmrd0pmkj48uKcDcPjF4T2N6cctcPsQIJ2s4xsOHZixc2xMIzkXOivObIaDJVbiz5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044849; c=relaxed/simple;
	bh=nPM2xDzamc7ofaCScsG410PR/QQBsQ3DvwZZV+9GS1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfOjjm6Rvd9+A+H9dxkZ2UgkM5lugEA4MLYdV2lxX609jn0MPee7dEL49PwwBLcbzNVXNqzBCPqOrPkJt17KusxDRJPv30D9xokxXSQ0BL1r0qRtHEzJ57wIENaRtVT4lAlRwgTAUnAvkft0zBUm1AxKPi1CTXtG5IjftMC4pL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnHEJaPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnHEJaPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2FCC2BC87;
	Fri, 20 Mar 2026 22:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044849;
	bh=nPM2xDzamc7ofaCScsG410PR/QQBsQ3DvwZZV+9GS1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HnHEJaPxDsHVIvGrxzHc285TLNol1z8REyKULttk7LBtwRgQ91PH1mTrO85MXJHyY
	 WFH/wxwqXRjfho6tYaOu2/MfwuotmjfCmsEnGZtWR9t6ddUZxpBVOs9QOWmQvmwy0a
	 aFiJ6oT7939CIJexqKYA2dnTf44yStx0+tux37YlR4l3yBmoRPT7k27uWmfAUQuEcD
	 8geni0LfN+9k7qbtbxB0ex+mCUMy825GfgzDnLOwZ/nRtaXSOeBKYzFzhArxXXxAIu
	 Gh3l9X4y5slBiaPioaYF/8CdnkJvSUALoiieyOcpGKKd5h1bKtCyau0asJSb7OVFP4
	 OpoN99xFHbZpg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:38 +0100
Subject: [PATCH v2 06/15] mm/sparse: remove !CONFIG_SPARSEMEM_VMEMMAP
 leftovers for CONFIG_MEMORY_HOTPLUG
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-6-096addc8800d@kernel.org>
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

CONFIG_MEMORY_HOTPLUG now depends on CONFIG_SPARSEMEM_VMEMMAP. So
let's remove the !CONFIG_SPARSEMEM_VMEMMAP leftovers that are dead code.

Adjust the comment above fill_subsection_map() accordingly.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 69 ++-----------------------------------------------------------
 1 file changed, 2 insertions(+), 67 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 93252112860e..875f718a4c79 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -657,7 +657,6 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -729,73 +728,11 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 
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
- * To deactivate a memory region, there are 3 cases to handle across
- * two configurations (SPARSEMEM_VMEMMAP={y,n}):
+ * To deactivate a memory region, there are 3 cases to handle:
  *
- * 1. deactivation of a partial hot-added section (only possible in
- *    the SPARSEMEM_VMEMMAP=y case).
+ * 1. deactivation of a partial hot-added section:
  *      a) section was present at memory init.
  *      b) section was hot-added post memory init.
  * 2. deactivation of a complete hot-added section.
@@ -803,8 +740,6 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
  *
  * For 1, when subsection_map does not empty we will not be freeing the
  * usage map, but still need to free the vmemmap range.
- *
- * For 2 and 3, the SPARSEMEM_VMEMMAP={y,n} cases are unified
  */
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)

-- 
2.43.0

