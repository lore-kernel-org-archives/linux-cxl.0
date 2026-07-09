Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F03D669E;
	Thu,  9 Jul 2026 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579332; cv=none; b=mKCJMnHEXgmB8SqSDEOoCeOzd7/sokgibPqJCKYiSopNr+WzuQLBHErT3um7rgWoCHEOaM1xGyrpNFuvnhW1gaCrmQshyrfPc+LWu8Tu8mcfJQEgmlXvj0N2G/lDnkcw83GP8lnSOq3HaYGfasQUr+Yv0YQtchcIkwVjlX2Gg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579332; c=relaxed/simple;
	bh=hhYoYxEG5AilehlGWMB4Lk7OgEGhWl1X1hqaWZvfe6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMHtpYOzZX2uAVw49keqk2ozYFyJXxWS9cbSgiNIJVm/OpUVVQ0FciC6CPer5yw0gqNA8pd0MM28PCvxbFn+TYBkb2Korcsww/YTX0YtoEGFdoYyB3P1K9k9786ugE0PefC6wH1JFjVV0ZLTiYzdFYeqegZzu+eRo7VrJ/f3lMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpKq0rX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpKq0rX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD371F000E9;
	Thu,  9 Jul 2026 06:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579329;
	bh=lk6NZKSyfvP8qY4wirUwcY/CWU1GrxzbQKJbKa4/tds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EpKq0rX7j2v6MtATxB+UWMtaxum0UBPfNHtUKOFC6l3Y+pu8mEO5XvDRFxYNOuXIx
	 RgZnflhXOiREfmPzwGfxsAH2d/iTNnT/BBdI3fEy9hVir3o24KZf1HcwfRQyG9vFmX
	 BOZ3npTlhD3nJ0Y95D0UtoS+w9nfKqcLqSyp3V208hVS2G2ptal4MazxYphmbe5QwQ
	 luIJYN1vnMUvGcVXhbejBGv6I4lT8IzswgZHIfqHDqlIO0XmnQbfZ7VCnScInGMu4t
	 UqmbLTJ+whhhgTL001YHj8fRCuVoRLmWqFQnh81hmVUD6EIvTpaDzuNpd2+srIQGdG
	 nsJI0BA+SOTiA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 09 Jul 2026 09:41:48 +0300
Subject: [PATCH 2/3] mm: split out sparse declarations from internal.h
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-internal-h-v1-2-956d5092782d@kernel.org>
References: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
In-Reply-To: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
 Alexander Potapenko <glider@google.com>, 
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>, 
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, kasan-dev@googlegroups.com, 
 kexec@lists.infradead.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

mm/internal.h becomes more and more bloated.

Move declarations related to SPARSE and SPARSE_VMEMMAP memory models to
a new mm/sparse.h header.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 MAINTAINERS         |  1 +
 mm/internal.h       | 52 -------------------------------------------
 mm/mm_init.c        |  1 +
 mm/sparse-vmemmap.c |  1 +
 mm/sparse.c         |  2 ++
 mm/sparse.h         | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 537dbfd01362..406ccfe63974 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16999,6 +16999,7 @@ F:	mm/pgtable-generic.c
 F:	mm/ptdump.c
 F:	mm/sparse-vmemmap.c
 F:	mm/sparse.c
+F:	mm/sparse.h
 F:	mm/util.c
 F:	mm/vmpressure.c
 F:	mm/vmstat.c
diff --git a/mm/internal.h b/mm/internal.h
index c514b17c61b8..860cd31c3da5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -807,58 +807,6 @@ static inline void init_compound_tail(struct page *tail,
 	prep_compound_tail(tail, head, order);
 }
 
-/*
- * mm/sparse.c
- */
-#ifdef CONFIG_SPARSEMEM
-void sparse_init(void);
-int sparse_index_init(unsigned long section_nr, int nid);
-
-static inline void sparse_init_one_section(struct mem_section *ms,
-		unsigned long pnum, struct page *mem_map,
-		struct mem_section_usage *usage, unsigned long flags)
-{
-	unsigned long coded_mem_map;
-
-	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
-
-	/*
-	 * We encode the start PFN of the section into the mem_map such that
-	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
-	 * from the page pointer to obtain the PFN.
-	 */
-	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(pnum));
-	VM_WARN_ON_ONCE(coded_mem_map & ~SECTION_MAP_MASK);
-
-	ms->section_mem_map &= ~SECTION_MAP_MASK;
-	ms->section_mem_map |= coded_mem_map;
-	ms->section_mem_map |= flags | SECTION_HAS_MEM_MAP;
-	ms->usage = usage;
-}
-
-static inline void __section_mark_present(struct mem_section *ms,
-		unsigned long section_nr)
-{
-	if (section_nr > __highest_present_section_nr)
-		__highest_present_section_nr = section_nr;
-
-	ms->section_mem_map |= SECTION_MARKED_PRESENT;
-}
-#else
-static inline void sparse_init(void) {}
-#endif /* CONFIG_SPARSEMEM */
-
-/*
- * mm/sparse-vmemmap.c
- */
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-void sparse_init_subsection_map(void);
-#else
-static inline void sparse_init_subsection_map(void)
-{
-}
-#endif /* CONFIG_SPARSEMEM_VMEMMAP */
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 39583c028e34..b557e5fe35f3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -35,6 +35,7 @@
 #include "internal.h"
 #include "mm_init.h"
 #include "page_alloc.h"
+#include "sparse.h"
 #include "slab.h"
 #include "shuffle.h"
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 10dd4a9b591b..458b0b9570ff 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -42,6 +42,7 @@
 
 #include "internal.h"
 #include "mm_init.h"
+#include "sparse.h"
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
diff --git a/mm/sparse.c b/mm/sparse.c
index 058ef9300367..4b21dd8c7dfb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -16,6 +16,8 @@
 #include <linux/bootmem_info.h>
 #include <linux/vmstat.h>
 #include "internal.h"
+#include "mm_init.h"
+#include "sparse.h"
 #include <asm/dma.h>
 
 /*
diff --git a/mm/sparse.h b/mm/sparse.h
new file mode 100644
index 000000000000..95aa031213f2
--- /dev/null
+++ b/mm/sparse.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * sparse.h:
+ *
+ * mm/ internal sparse and sparse-vmemmap declarations
+ */
+
+#ifndef __MM_SPARSE_H
+#define __MM_SPARSE_H
+
+#include <linux/mmzone.h>
+
+/*
+ * mm/sparse.c
+ */
+#ifdef CONFIG_SPARSEMEM
+void sparse_init(void);
+int sparse_index_init(unsigned long section_nr, int nid);
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
+	VM_WARN_ON_ONCE(coded_mem_map & ~SECTION_MAP_MASK);
+
+	ms->section_mem_map &= ~SECTION_MAP_MASK;
+	ms->section_mem_map |= coded_mem_map;
+	ms->section_mem_map |= flags | SECTION_HAS_MEM_MAP;
+	ms->usage = usage;
+}
+
+static inline void __section_mark_present(struct mem_section *ms,
+		unsigned long section_nr)
+{
+	if (section_nr > __highest_present_section_nr)
+		__highest_present_section_nr = section_nr;
+
+	ms->section_mem_map |= SECTION_MARKED_PRESENT;
+}
+#else
+static inline void sparse_init(void) {}
+#endif /* CONFIG_SPARSEMEM */
+
+/*
+ * mm/sparse-vmemmap.c
+ */
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+void sparse_init_subsection_map(void);
+#else
+static inline void sparse_init_subsection_map(void) {}
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+
+#endif /* __MM_SPARSE_H */

-- 
2.53.0

