Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C735A925;
	Fri, 20 Mar 2026 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044878; cv=none; b=DI7Z/iEzyJ5q21uTDOonO7dfBf4Og5GrKI3gg8bZmG5eiJaf+1IlOQrVAYNQ1wQZzoepRm+hhRDc8pIG+XVmzD3QU5uIysSnLE7kHkLBZgGcdcjJflSvdgHsjHSvzJlTf/DKg1qNKqTCjNvh6NroMZpbMQf8GktAASPtpqUUYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044878; c=relaxed/simple;
	bh=y3sgZkTrQ7ucF18Vg7qRa+O7aPCnDHgstTSd5M9UBOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXqjvE/bj9nqxXcZKHF/v7b1vIQy3pRlSyxkx6jDffqN4owTLtC/jRp5s1M5aYDldawV5vlWOH+EVDiiadL/6GmkPvi8rfFSH0QRn0yLIKZx5dSV945uTuS8Se1UhddK3QXnnd5fo+ice0OdOQg3nBIXnA5KgeI2YLCEhJliCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TslszDhS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TslszDhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B066CC4CEF7;
	Fri, 20 Mar 2026 22:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044878;
	bh=y3sgZkTrQ7ucF18Vg7qRa+O7aPCnDHgstTSd5M9UBOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TslszDhSAzMDVRIyuMv6paGVgSsd2CzTi2m+XDZauLL+oMPD8nN2y19WOg5QAxcN8
	 MJkxnPJI13xWM/TQBuUVFa8i2WBfcrPqP1pN4JyiIYxzvSpK68kow0YUXzxMwjLIvA
	 PZfMcLRp38aeBp/XZ/scY6XOVW8u6R2Vl2bxg7ZCjPYl5+Zw1cWeOJK9ueZjsjOuBI
	 /f+WZSPbGmI8Ms+0wdaf/gI3Ef6Dwbp58ZS76mf9o54sv2J4dxehoWLmTRoayHRyve
	 UXsBVGWUjpn8Bff33KBzLTvQ6RK33x76NgUJDEqM9svExTt2X8h0wOTNQ+4FrOCJLF
	 6X7zc7Xpdr5tg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:45 +0100
Subject: [PATCH v2 13/15] mm/sparse: move sparse_init_one_section() to
 internal.h
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-13-096addc8800d@kernel.org>
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

While at it, convert the BUG_ON to a VM_WARN_ON_ONCE, avoid long lines, and
merge sparse_encode_mem_map() into its only caller
sparse_init_one_section().

Clarify the comment a bit, pointing at page_to_pfn().

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mmzone.h |  2 +-
 mm/internal.h          | 22 ++++++++++++++++++++++
 mm/sparse.c            | 24 ------------------------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b694c69dee04..dcbbf36ed88c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2008,7 +2008,7 @@ struct mem_section {
 	/*
 	 * This is, logically, a pointer to an array of struct
 	 * pages.  However, it is stored with some other magic.
-	 * (see sparse.c::sparse_init_one_section())
+	 * (see sparse_init_one_section())
 	 *
 	 * Additionally during early boot we encode node id of
 	 * the location of the section here to guide allocation.
diff --git a/mm/internal.h b/mm/internal.h
index 5f5c45d80aca..2f188f7702f7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -965,6 +965,28 @@ void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
  */
 #ifdef CONFIG_SPARSEMEM
 void sparse_init(void);
+
+static inline void sparse_init_one_section(struct mem_section *ms,
+		unsigned long pnum, struct page *mem_map,
+		struct mem_section_usage *usage, unsigned long flags)
+{
+	unsigned long coded_mem_map;
+
+	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
+
+	/*
+	 * We encode the start PFN of the section into the mem_map such that
+	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
+	 * from the page pointer to obtain the PFN.
+	 */
+	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(pnum));
+	VM_WARN_ON(coded_mem_map & ~SECTION_MAP_MASK);
+
+	ms->section_mem_map &= ~SECTION_MAP_MASK;
+	ms->section_mem_map |= coded_mem_map;
+	ms->section_mem_map |= flags | SECTION_HAS_MEM_MAP;
+	ms->usage = usage;
+}
 #else
 static inline void sparse_init(void) {}
 #endif /* CONFIG_SPARSEMEM */
diff --git a/mm/sparse.c b/mm/sparse.c
index 5c9cad390282..ed5de1a25f04 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -256,30 +256,6 @@ static void __init memblocks_present(void)
 		memory_present(nid, start, end);
 }
 
-/*
- * Subtle, we encode the real pfn into the mem_map such that
- * the identity pfn - section_mem_map will return the actual
- * physical page frame number.
- */
-static unsigned long sparse_encode_mem_map(struct page *mem_map, unsigned long pnum)
-{
-	unsigned long coded_mem_map =
-		(unsigned long)(mem_map - (section_nr_to_pfn(pnum)));
-	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
-	BUG_ON(coded_mem_map & ~SECTION_MAP_MASK);
-	return coded_mem_map;
-}
-
-static void __meminit sparse_init_one_section(struct mem_section *ms,
-		unsigned long pnum, struct page *mem_map,
-		struct mem_section_usage *usage, unsigned long flags)
-{
-	ms->section_mem_map &= ~SECTION_MAP_MASK;
-	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum)
-		| SECTION_HAS_MEM_MAP | flags;
-	ms->usage = usage;
-}
-
 static unsigned long usemap_size(void)
 {
 	return BITS_TO_LONGS(SECTION_BLOCKFLAGS_BITS) * sizeof(unsigned long);

-- 
2.43.0

