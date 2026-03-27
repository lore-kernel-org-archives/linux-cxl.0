Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBD34028F;
	Fri, 27 Mar 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580297; cv=none; b=BNGyZX3vbBwsipMdmtth//nmMK/ltp+DzOhghp//pZOhu9tO6rHvO0Q+1O07PtMA+7+aCB0ZAgUUP+e4BGRAeYcICPM7oAtFuEfXf/OzfM3E7mQZY44bZIS+v6hj315C0nSbEechKM56dJQS/qV9Cre3bK/SGJ7GKVjDhJK/BlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580297; c=relaxed/simple;
	bh=ZpNIEcUffsRq1bL9mSuUjHcLakM3o1+hxG4crvmOh68=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fseCBUJ84GycXfXkH9Gudexg0lWjT/6saP0XJ9a99E9sf/Vy4UrqdD4kp4N+4bPbso3rFans2bQoyYpfN3O26bGsVlW/NQ8LRvlnF2AeWi7dHBMmZzCnOosazuLZqUJvgAk14kPMuohRB6zUyjFr8iwc8sFeDOdlBFi0iwvpmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=j/Vo3ys2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="j/Vo3ys2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30C0C116C6;
	Fri, 27 Mar 2026 02:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774580297;
	bh=ZpNIEcUffsRq1bL9mSuUjHcLakM3o1+hxG4crvmOh68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/Vo3ys2nroHY54igrcUEcoYgsxYsT3vxeiCyy/aOfXJa1yRgskAMVRG73QbfSFFf
	 JM5nLEh474y06NHY6UPYTi/omXySC/awZK0BmobSkQgM8axUdCr4bD26qAKb/5n4XZ
	 I6MCP8QNv6Ig+O/3PIioVHSyf2KK920H2p86r6uA=
Date: Thu, 26 Mar 2026 19:58:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 00/15] mm: memory hot(un)plug and SPARSEMEM cleanups
Message-Id: <20260326195816.60110f50cd464d0076aad0ff@linux-foundation.org>
In-Reply-To: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 23:13:32 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Some cleanups around memory hot(un)plug and SPARSEMEM. In essence,
> we can limit CONFIG_MEMORY_HOTPLUG to CONFIG_SPARSEMEM_VMEMMAP,
> remove some dead code, and move all the hotplug bits over to
> mm/sparse-vmemmap.c.
> 
> Some further/related cleanups around other unnecessary code
> (memory hole handling and complicated usemap allocation).

Sorry, for some (age-related) reason I've been sitting on v1 for nearly
a week.

Thanks, I've updated mm-unstable to this version.

Lorenzo, I've assumed that your conditional R-b on [01/15] is now
unconditional.

> v1 -> v2:
> * Added "mm/memory_hotplug: fix possible race in scan_movable_pages()"
> * Update the comment above section_deactivate()
> * Reordered the flags in sparse_init_one_section()
> * Patch description improvements

Here's how v2 altered mm.git:


 mm/internal.h       |    2 +-
 mm/memory_hotplug.c |   11 ++++++++---
 mm/sparse-vmemmap.c |    8 ++------
 3 files changed, 11 insertions(+), 10 deletions(-)

--- a/mm/internal.h~b
+++ a/mm/internal.h
@@ -985,7 +985,7 @@ static inline void sparse_init_one_secti
 
 	ms->section_mem_map &= ~SECTION_MAP_MASK;
 	ms->section_mem_map |= coded_mem_map;
-	ms->section_mem_map |= SECTION_HAS_MEM_MAP | flags;
+	ms->section_mem_map |= flags | SECTION_HAS_MEM_MAP;
 	ms->usage = usage;
 }
 
--- a/mm/memory_hotplug.c~b
+++ a/mm/memory_hotplug.c
@@ -1738,6 +1738,7 @@ static int scan_movable_pages(unsigned l
 	unsigned long pfn;
 
 	for (pfn = start; pfn < end; pfn++) {
+		unsigned long nr_pages;
 		struct page *page;
 		struct folio *folio;
 
@@ -1754,9 +1755,9 @@ static int scan_movable_pages(unsigned l
 		if (PageOffline(page) && page_count(page))
 			return -EBUSY;
 
-		if (!PageHuge(page))
-			continue;
 		folio = page_folio(page);
+		if (!folio_test_hugetlb(folio))
+			continue;
 		/*
 		 * This test is racy as we hold no reference or lock.  The
 		 * hugetlb page could have been free'ed and head is no longer
@@ -1766,7 +1767,11 @@ static int scan_movable_pages(unsigned l
 		 */
 		if (folio_test_hugetlb_migratable(folio))
 			goto found;
-		pfn |= folio_nr_pages(folio) - 1;
+		nr_pages = folio_nr_pages(folio);
+		if (unlikely(nr_pages < 1 || nr_pages > MAX_FOLIO_NR_PAGES ||
+			     !is_power_of_2(nr_pages)))
+			continue;
+		pfn |= nr_pages - 1;
 	}
 	return -ENOENT;
 found:
--- a/mm/sparse-vmemmap.c~b
+++ a/mm/sparse-vmemmap.c
@@ -725,11 +725,9 @@ static int fill_subsection_map(unsigned
 }
 
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
@@ -737,8 +735,6 @@ static int fill_subsection_map(unsigned
  *
  * For 1, when subsection_map does not empty we will not be freeing the
  * usage map, but still need to free the vmemmap range.
- *
- * For 2 and 3, the SPARSEMEM_VMEMMAP={y,n} cases are unified
  */
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
_

