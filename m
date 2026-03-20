Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2D34B1A8;
	Fri, 20 Mar 2026 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044870; cv=none; b=THE824UjPlDxeBoRWI8JfogKPQKRXoq9Hvr8xEIyLrGz6qvzCBM4sqKrvamqf9hgt0BIC/XKMHJkfaeCVx6Xy2UNAuLCWSuLUi3W1pWrifNlaZVw00GYYeRWWqSjnx40oHhSqX76i7obn+wgC/r1/ZkISLsxBla24PnQQGICdS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044870; c=relaxed/simple;
	bh=96Y5hAnwqjZz29h98raybd4EwBxokxu/LgenBd+sLbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYPXydDzWo1Va3wCVfR1ksvZYR16yJspGqBv3cYYo2SwmsHnQMYtz6ePVn01rX+U7fZS+2gQwqdyqx/deTKivSD8EmRSrCb1kY5ZfGQOliJ3q1aJg/mOwNn6q5DQ9knfKFNgZfZDEXB3AeUAvfOFe5NTRE3PUNUeZky7TeugOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHLJ7uy8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHLJ7uy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBCBC2BC87;
	Fri, 20 Mar 2026 22:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044870;
	bh=96Y5hAnwqjZz29h98raybd4EwBxokxu/LgenBd+sLbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IHLJ7uy8oSWAv0WFrwtVAb5aqpsuUpirtjWzxOOeikkn8Cnj9WwzIvvRij484C45D
	 sDFL5mLdqScUm2fzsvdEC1JdLzvfsyk36kWc35PHmbWLs9cVbdiJLPGF62cKICafDO
	 FvnFCZhQ8o637F4GYescmIZk/JpTP9gIjiPNGg/V4UZUriDHGypjOdxwvdW0FCR0K/
	 1WFbCMNsgJnoktrK7x7yyswl4f1lMAvZ7eR9vfmwjEr8qzpMoFgMx8wbw1VC/InmpH
	 XRuHYmRJ+fUci09hGRGZwOpykKU7rmJk/cRic01Os9XnQTPnJfW0X7UsPtpQ+w+21D
	 OWMtzKPIBKBBg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:43 +0100
Subject: [PATCH v2 11/15] mm: prepare to move subsection_map_init() to
 mm/sparse-vmemmap.c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-11-096addc8800d@kernel.org>
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

We want to move subsection_map_init() to mm/sparse-vmemmap.c.

To prepare for getting rid of subsection_map_init() in mm/sparse.c
completely, use a static inline function for !CONFIG_SPARSEMEM_VMEMMAP.

While at it, move the declaration to internal.h and rename it to
"sparse_init_subsection_map()".

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mmzone.h |  3 ---
 mm/internal.h          | 12 ++++++++++++
 mm/mm_init.c           |  2 +-
 mm/sparse.c            |  6 +-----
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7bd0134c241c..b694c69dee04 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2002,8 +2002,6 @@ struct mem_section_usage {
 	unsigned long pageblock_flags[0];
 };
 
-void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
-
 struct page;
 struct page_ext;
 struct mem_section {
@@ -2396,7 +2394,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 #define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
 #define sparse_vmemmap_init_nid_late(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
-#define subsection_map_init(_pfn, _nr_pages) do {} while (0)
 #endif /* CONFIG_SPARSEMEM */
 
 /*
diff --git a/mm/internal.h b/mm/internal.h
index f98f4746ac41..5f5c45d80aca 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -960,12 +960,24 @@ void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
 		unsigned long, enum meminit_context, struct vmem_altmap *, int,
 		bool);
 
+/*
+ * mm/sparse.c
+ */
 #ifdef CONFIG_SPARSEMEM
 void sparse_init(void);
 #else
 static inline void sparse_init(void) {}
 #endif /* CONFIG_SPARSEMEM */
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+void sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages);
+#else
+static inline void sparse_init_subsection_map(unsigned long pfn,
+		unsigned long nr_pages)
+{
+}
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 969048f9b320..3c5f18537cd1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1898,7 +1898,7 @@ static void __init free_area_init(void)
 		pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
 			(u64)start_pfn << PAGE_SHIFT,
 			((u64)end_pfn << PAGE_SHIFT) - 1);
-		subsection_map_init(start_pfn, end_pfn - start_pfn);
+		sparse_init_subsection_map(start_pfn, end_pfn - start_pfn);
 	}
 
 	/* Initialise every node */
diff --git a/mm/sparse.c b/mm/sparse.c
index e2048b1fbf5f..c96ac5e70c22 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -185,7 +185,7 @@ static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 	bitmap_set(map, idx, end - idx + 1);
 }
 
-void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
+void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages)
 {
 	int end_sec_nr = pfn_to_section_nr(pfn + nr_pages - 1);
 	unsigned long nr, start_sec_nr = pfn_to_section_nr(pfn);
@@ -207,10 +207,6 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
 		nr_pages -= pfns;
 	}
 }
-#else
-void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
-{
-}
 #endif
 
 /* Record a memory area against a node. */

-- 
2.43.0

