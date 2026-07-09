Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50753407CC1;
	Thu,  9 Jul 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591236; cv=none; b=UfzCRCFQU0EO9uztjEz3TZ1Q6ICX5BuYyqikyA3wQ2dowcvRRmXv1oJKPPLWI094e063/ZVJbsYo1Ch+wdOAo6gaM7h0sPhGylUNxlddRqgptYu8eI3Nf12KYF4PZimFGx8zNAbrVdElVUeG4B5+WcVVSlyNQqvEgvR7SK79/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591236; c=relaxed/simple;
	bh=TtSls4RJMTRW02sbrB59D+BwqjjW9jfsGu9sTPH4VhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLcFXbo5koRjxpeaq02G0Dr2HkBbwHjx5gnyQuCLy1C4xbWvcpUYFH4ClYZKqz9R+elc6ylN+zIsznKkAeo4Q6ZooTAFelcYwi1lrX9cb3H+ChnVDFYmZsO3cLC15KNkig/4CDjyNShFdMprJR/tT+EHw7CH+hoLH41L1dBZyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJXvbYVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJXvbYVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6104A1F00A3A;
	Thu,  9 Jul 2026 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783591232;
	bh=/kcgTbbFfpmWUtE4SfX2fSST1JjkBqdtSuXuj1zYDw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XJXvbYVVAtki6hsOpJBqZj9J8tg1yoyyixWgsIG5wVl/uo1Ebg+D2bN2HcqmkOGSo
	 FVkSZFWlru0vinmyI6YedT4U8enKr54YUeWVxo/sMbnweOz6vnd14LWgiM3+NI/hfN
	 1L7tTwZZbg+2M6BEihOIthbVbzGEJrHNCd094BYhGYsr5n7EpBvLpszIROKFxGqWGt
	 BnLU5G7QFL6dlbWT1xMgPjKYiQc+DADdDvriIJot6zOHiXu5l8DfeBWJcNMf6KnFSu
	 o+F6/qcs2R3G4EiQCAXzi6KDd8VLMI/8C0Yp/jtVtJgSYaWlY/okv/XrhBlcQQGaoc
	 8IE37ztRRAt0Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 09 Jul 2026 13:00:05 +0300
Subject: [PATCH v2 3/3] mm: split out vmalloc declarations from internal.h
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-internal-h-v2-3-695631425968@kernel.org>
References: <20260709-internal-h-v2-0-695631425968@kernel.org>
In-Reply-To: <20260709-internal-h-v2-0-695631425968@kernel.org>
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

Move declarations related to vmalloc to a new mm/vmalloc.h header.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
---
 MAINTAINERS                        |  1 +
 kernel/liveupdate/kexec_handover.c |  2 +-
 mm/execmem.c                       |  1 +
 mm/internal.h                      | 40 ---------------------------------
 mm/kmsan/hooks.c                   |  1 +
 mm/kmsan/shadow.c                  |  1 +
 mm/mm_init.c                       |  1 +
 mm/percpu-vm.c                     |  1 +
 mm/vmalloc.c                       |  1 +
 mm/vmalloc.h                       | 46 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c1aed067656..9665f360bed8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28815,6 +28815,7 @@ W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/linux/vmalloc.h
 F:	mm/vmalloc.c
+F:	mm/vmalloc.h
 F:	lib/test_vmalloc.c
 
 VME SUBSYSTEM
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index fe11cbf1006e..78ff267bf51e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -34,8 +34,8 @@
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
  */
-#include "../../mm/internal.h"
 #include "../../mm/mm_init.h"
+#include "../../mm/vmalloc.h"
 #include "../kexec_internal.h"
 #include "kexec_handover_internal.h"
 
diff --git a/mm/execmem.c b/mm/execmem.c
index 084a207e4278..74a178a87e75 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -20,6 +20,7 @@
 #include <asm/tlbflush.h>
 
 #include "internal.h"
+#include "vmalloc.h"
 
 static struct execmem_info *execmem_info __ro_after_init;
 static struct execmem_info default_execmem_info __ro_after_init;
diff --git a/mm/internal.h b/mm/internal.h
index a29a7dab2e6c..e5dcab69eb4f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1092,9 +1092,6 @@ static inline void mlock_new_folio(struct folio *folio) { }
 static inline bool need_mlock_drain(int cpu) { return false; }
 static inline void mlock_drain_local(void) { }
 static inline void mlock_drain_remote(int cpu) { }
-static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
-{
-}
 #endif /* !CONFIG_MMU */
 
 #define NODE_RECLAIM_NOSCAN	-2
@@ -1209,37 +1206,6 @@ struct migration_target_control {
 size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 			      struct folio *folio, loff_t fpos, size_t size);
 
-/*
- * mm/vmalloc.c
- */
-#ifdef CONFIG_MMU
-void __init vmalloc_init(void);
-int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-	pgprot_t prot, struct page **pages, unsigned int page_shift, gfp_t gfp_mask);
-unsigned int get_vm_area_page_order(struct vm_struct *vm);
-#else
-static inline void vmalloc_init(void)
-{
-}
-
-static inline
-int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-	pgprot_t prot, struct page **pages, unsigned int page_shift, gfp_t gfp_mask)
-{
-	return -EINVAL;
-}
-#endif
-
-void clear_vm_uninitialized_flag(struct vm_struct *vm);
-
-int __must_check __vmap_pages_range_noflush(unsigned long addr,
-			       unsigned long end, pgprot_t prot,
-			       struct page **pages, unsigned int page_shift);
-
-void vunmap_range_noflush(unsigned long start, unsigned long end);
-
-void __vunmap_range_noflush(unsigned long start, unsigned long end);
-
 static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & VM_SHARED)
@@ -1267,12 +1233,6 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 void free_zone_device_folio(struct folio *folio);
 int migrate_device_coherent_folio(struct folio *folio);
 
-struct vm_struct *__get_vm_area_node(unsigned long size,
-				     unsigned long align, unsigned long shift,
-				     unsigned long vm_flags, unsigned long start,
-				     unsigned long end, int node, gfp_t gfp_mask,
-				     const void *caller);
-
 /*
  * mm/gup.c
  */
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 8f22d1f22981..5f1b8053f9fa 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -21,6 +21,7 @@
 #include <linux/usb.h>
 
 #include "../internal.h"
+#include "../vmalloc.h"
 #include "../slab.h"
 #include "kmsan.h"
 
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 8fde939784a7..0c88d89bf0d6 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -17,6 +17,7 @@
 #include <linux/stddef.h>
 
 #include "../internal.h"
+#include "../vmalloc.h"
 #include "kmsan.h"
 
 #define shadow_page_for(page) ((page)->kmsan_shadow)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index b557e5fe35f3..711f821f7b3c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -38,6 +38,7 @@
 #include "sparse.h"
 #include "slab.h"
 #include "shuffle.h"
+#include "vmalloc.h"
 
 #include <asm/setup.h>
 
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 7ed216192fc0..509d8901835c 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -9,6 +9,7 @@
  * This is the default chunk allocator.
  */
 #include "internal.h"
+#include "vmalloc.h"
 
 static struct page *pcpu_chunk_page(struct pcpu_chunk *chunk,
 				    unsigned int cpu, int page_idx)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1191cda3b4e8..4b0362cbdf5a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -49,6 +49,7 @@
 
 #include "internal.h"
 #include "pgalloc-track.h"
+#include "vmalloc.h"
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 static unsigned int __ro_after_init ioremap_max_page_shift = BITS_PER_LONG - 1;
diff --git a/mm/vmalloc.h b/mm/vmalloc.h
new file mode 100644
index 000000000000..dcfe30eaa80c
--- /dev/null
+++ b/mm/vmalloc.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mm-internal APIs for vmalloc
+ */
+#ifndef __MM_VMALLOC_H
+#define __MM_VMALLOC_H
+
+#ifdef CONFIG_MMU
+void __init vmalloc_init(void);
+int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages,
+		unsigned int page_shift, gfp_t gfp_mask);
+unsigned int get_vm_area_page_order(struct vm_struct *vm);
+#else
+static inline void vmalloc_init(void) {}
+
+static inline
+int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages,
+		unsigned int page_shift, gfp_t gfp_mask)
+{
+	return -EINVAL;
+}
+
+static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
+{
+}
+#endif
+
+struct vm_struct *__get_vm_area_node(unsigned long size,
+		unsigned long align, unsigned long shift,
+		unsigned long vm_flags, unsigned long start,
+		unsigned long end, int node, gfp_t gfp_mask,
+		const void *caller);
+
+void clear_vm_uninitialized_flag(struct vm_struct *vm);
+
+int __must_check __vmap_pages_range_noflush(unsigned long addr,
+		unsigned long end, pgprot_t prot,
+		struct page **pages, unsigned int page_shift);
+
+void vunmap_range_noflush(unsigned long start, unsigned long end);
+
+void __vunmap_range_noflush(unsigned long start, unsigned long end);
+
+#endif /* __MM_VMALLOC_H */

-- 
2.53.0

