Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B882A34575A;
	Fri, 20 Mar 2026 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044853; cv=none; b=FLUvxR2PVgSObVUtxID6lZTvJTlYghqr6iQ8Hm/+X2xDNyLdeB7z0+nrALOzL3RVy9p/6BVktaqopqhrX0DmFWYUhRFH0irLOHNT0nuEpTyrW5dpCu1pFPS2eZvmF56kk1vE1gJ5aS/f++/COSuRD1iiSby4MpncVrddBG/mTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044853; c=relaxed/simple;
	bh=QZECcZOo9XU6VE0O+G1ptFNqIVCOuWAko6C1OasJr/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5r9+5KCvkKHwOA5rmbT+3+4PR9d/Iw6+XxNMKBWiQxTaaX5bohE2qNm25W/2haWECvHu2GeFNA6Dn8p67So1pyjNWULqw0+wzYst1huHbDT690KsBSWlbI79uAuUo52z/DJ6pLL3l0tjY0BAo5fAMyW1H+3J6eWK3TDDa3/EwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYJKP7zl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYJKP7zl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD735C2BCB6;
	Fri, 20 Mar 2026 22:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044853;
	bh=QZECcZOo9XU6VE0O+G1ptFNqIVCOuWAko6C1OasJr/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BYJKP7zlv4jBTvu80a24WL8Ct5aU4DcbuPl7DomVKZQywcFSHmDul15sUSZzpOS9w
	 VGpkVDDKudEKjzp330WynQpTZJarltWaw0dHJ3u7eeAic+bRO3z2vaoJXKeKE8CzXJ
	 Hlir4vVzCgO/f2OKDKqS8rRg5eQw0Vi39t7NMLD4x1kMCvNqs1ghvWraXEpRmdgbkJ
	 ouDmSeYe65LVeauMLiEz99LE6nUEBfU2ntRObRZhG73T8ceIv43bw4PDm71NWkHgYS
	 M2POdUrqX1hIGxGX4jWTxYwJH7i/lYl4bma2SJk/M0epQ5B85WZGwtmdA9RUsRNrzD
	 BZVwwK53Fv3qA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:39 +0100
Subject: [PATCH v2 07/15] mm/bootmem_info: remove handling for
 !CONFIG_SPARSEMEM_VMEMMAP
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-7-096addc8800d@kernel.org>
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

It is not immediately obvious that CONFIG_HAVE_BOOTMEM_INFO_NODE is
only selected from CONFIG_MEMORY_HOTREMOVE, which itself depends on
CONFIG_MEMORY_HOTPLUG that ... depends on CONFIG_SPARSEMEM_VMEMMAP.

Let's remove the !CONFIG_SPARSEMEM_VMEMMAP leftovers that are dead code.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index b0e2a9fa641f..e61e08e24924 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -40,42 +40,6 @@ void put_page_bootmem(struct page *page)
 	}
 }
 
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
-static void __init register_page_bootmem_info_section(unsigned long start_pfn)
-{
-	unsigned long mapsize, section_nr, i;
-	struct mem_section *ms;
-	struct page *page, *memmap;
-	struct mem_section_usage *usage;
-
-	section_nr = pfn_to_section_nr(start_pfn);
-	ms = __nr_to_section(section_nr);
-
-	/* Get section's memmap address */
-	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-
-	/*
-	 * Get page for the memmap's phys address
-	 * XXX: need more consideration for sparse_vmemmap...
-	 */
-	page = virt_to_page(memmap);
-	mapsize = sizeof(struct page) * PAGES_PER_SECTION;
-	mapsize = PAGE_ALIGN(mapsize) >> PAGE_SHIFT;
-
-	/* remember memmap's page */
-	for (i = 0; i < mapsize; i++, page++)
-		get_page_bootmem(section_nr, page, SECTION_INFO);
-
-	usage = ms->usage;
-	page = virt_to_page(usage);
-
-	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
-
-	for (i = 0; i < mapsize; i++, page++)
-		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
-
-}
-#else /* CONFIG_SPARSEMEM_VMEMMAP */
 static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 {
 	unsigned long mapsize, section_nr, i;
@@ -100,7 +64,6 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 	for (i = 0; i < mapsize; i++, page++)
 		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
 }
-#endif /* !CONFIG_SPARSEMEM_VMEMMAP */
 
 void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
 {

-- 
2.43.0

