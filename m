Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF03F65FE;
	Tue, 17 Mar 2026 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766645; cv=none; b=ccXs2JWeXDbrP9gS6JX1urUaiJb8eIC3P2SDb8sS/MgJmx4N9LSbMCR2Zy+QvVxgr6o5vgRqbFIKcgEN2MKeOrpIdyDFiPU2EeNkIEHLN67aM12TQVKzewG44lf1MxjApdKl9XpdLucm0fLRVRRY378UJA09Untt+ilfZaNcfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766645; c=relaxed/simple;
	bh=H5NeGoGk7dbqwybjxssVKWZK8p0cPYZ7svk3+pfmI+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPEi8Y0rOPhhASE5BCii00d4K1DENcSplA5TNddYQlpzC03mti5a0o2J7JIlZfFSszJfALnIK2s6OJVl+68ZWYzhJ+wYCVCewwlXtGfKfD4u6NWDnCzNXnA0i/JJGR7O13Cn1b72mktVASpA6S6NTKgYEkdcBuaWMkTtRYgbrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfqEnA3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfqEnA3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A106C19424;
	Tue, 17 Mar 2026 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766645;
	bh=H5NeGoGk7dbqwybjxssVKWZK8p0cPYZ7svk3+pfmI+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfqEnA3RRI2GR64AaLDZJghUOrYprRGXpJO4o+UpvkWcZmVSarEz8k8fpIJgG5QbS
	 D3VfKBHRKbBTr10pB/oOmHUFA7qQ2HBQyjfDS4UeSFVudgrF/w9vGSBSY28mDGCoja
	 +rDJ2tlgF5D3Y1YwOyS1HyxhCqpw9M3zND73l+ZGBKrkOjCpRTa9OkDOtd/XwUFZ/S
	 eGr6wJTAX3t69ECmcsJkKl9IMoWP4xi5JQHPB31BQyWKRiUjD96q/i2/rmnEs3r/tk
	 z9xCdDVNjkeLWMBWrp1LMzDrZ0/fGKYSOaRd+QznYwA30aeGOAEz+vKwdBhEAShFBa
	 oT5ZjdLYAvaYQ==
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
Subject: [PATCH 06/14] mm/bootmem_info: remove handling for !CONFIG_SPARSEMEM_VMEMMAP
Date: Tue, 17 Mar 2026 17:56:44 +0100
Message-ID: <20260317165652.99114-7-david@kernel.org>
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

It is not immediately obvious that CONFIG_HAVE_BOOTMEM_INFO_NODE is
only selected from CONFIG_MEMORY_HOTREMOVE, which itself depends on
CONFIG_MEMORY_HOTPLUG that ... depends on CONFIG_SPARSEMEM_VMEMMAP.

Let's remove the !CONFIG_SPARSEMEM_VMEMMAP leftovers.

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

