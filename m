Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810959;
	b=S9QKBw+YzBza0QLrEeHLVPGoQydDA5WAk0t3/SYbCaDndt2RrTNM0VpvJsgNv6pq47cY
	 JCklx/7jX+oCvTcwWsE1psGi9b1CzWOaxBeDpl04fWErcPDvqei+Zwt44Cvs1r+BeQmtu
	 dc3gJHqmMr2ocAJai4ftuuqTgjtNc77p3Q+UmNztW9apnjK79cx+nkuB0IMeK9W8BuiPF
	 bmB/lYT2VoV7xwnZYZpsxdjjl7/HRsw2sI4tScXNQ+WlR1C9Weu+A4VYq54YsE8dj3DZq
	 MJhkRaNuUvKZqJOuCqIcP9gDTtIYxhqhpKyoy5CU2biPPK3tZQ4boZYsjtLODOmSuOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810959;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=3t5gZnFzYyDaoysWoNJjSYJ1AOCHhlgJaCaGteCanKw=;
	b=Lf9+7+OeByq6r3P2NGdvpL5iWvYSPm59ynV0nYJMmrh0RBh+WLh5xMjzsFy2C1RN4uad
	 uuM7Nt4ancXwh2diABtAlvH6ttr+FlEsTdHQVwyX/yqyYDRtag2gl1YQF0zWQp3TeHluk
	 fU77Jj1pipwFfWLGSiW/hCoedr9Mm2T9914t3NbchM3dlmuoYYuDiZCKrbhhp47bW3uTd
	 DQvr9AviY4BWxd2NqaCS65Hl7SRU6JiVr3cCj480ad/hpyBoqn1jMGlUMnvx68gmOQGOb
	 YDMK4Pjm/SWtx48wHU8IpemkmJzFMFUMTcAsOW8vNRlHFLT8WFjRgdGfyYHudWYEetA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fda2vQl0;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D119606EEA5;
	Wed,  4 Nov 2026 16:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D119606EEA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fda2vQl0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=3t5gZnFzYyDaoysWoNJjSYJ1AOCHhlgJaCaGteCanKw=; b=fda2vQl0h857qXb9fNWH5Si5t4
	RpUTAaDbdY2GispkX1TXqZnWHns/xIs8W5tEJNccrb48oXzkJbbyO9ElZjwEP8x0KFeLE12kFSRlZ
	kEnX36cEE2s9UZhO5TxHdmEbwtQODdEOdaTsDbQfpmlXxXT5I1OXHWMoso8qjZxax6K0q68xVjt/U
	dmPpRLxRJA1pVsavc0QDv3AheaEBkIXAEpRJrmYodVuVkza0oFlshQsXa236sHnd3bVtnFWXR/vpp
	nPsV4Gtnrz2csUGF1I0nJreNr2BUuRAuRTbwXoS3HppY406956CJJTlEGO56Sxz0Zjy1K+ExPHqPa
	RmEP9m4Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOeA8-007rju-0S;
	Wed, 04 Nov 2026 16:48:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 04 Nov 2026 08:45:34 -0800
Subject: [PATCH] mm: split out memory-failure declarations from internal.h
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-memory-failure-split-v1-1-3b0a85f0b7e7@debian.org>
X-B4-Tracking: v=1; b=H4sIADNh62oC/x3MWwqDMBAF0K0M8+1AImIhWxE/YnK1A76YtKKIe
 y/0LODcXGCKwoFuNhxadFs5kK+I0zuuE0QzB+La1a33rpEFy2aXjFHnr0HKPutHmvSKA/IAlxN
 XxLth1PPfdv3z/AAvfczSZgAAAA==
X-Change-ID: 20261104-memory-failure-split-4c7abedbe0dc
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Xu Xin <xu.xin@linux.dev>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7064; i=leitao@debian.org;
 h=from:subject:message-id; bh=97QsAhXEXasX8L5kE2woL1ZCVS1R/w1KRvEzjNHsGk0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq62Hdh6XbNBL2Gt0nR7OxBlZBElTlVb5WZerUK
 sSEEvhdfRKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCauth3QAKCRA1o5Of/Hh3
 bWcYD/wPU0JCmJNtWaxHa8xKkYF5Qao3UN7r3U9phBYB8voeL5giFzNdXHw1Fg/2bv8fRNU3MPA
 i0uKAAuZN9VvcpdomAU4pPpfO3xqXv0NkZ4Qz+qC4y08BNBQKiNbGTvGu5sv0kwyiggZ/wFD5tF
 nLkBb1oUtbHUw37otSPvvLltT5f01nlDKVGWr4rqXNTUiJHAQ4lO4Pp49fMR/HI/bVawBNi9BN/
 BqXAi9LL29JcIFPwSQ3tcOn9gV6HgDF5fZqgm2YoW+dpYrUSxvTZhRrWI0WJ3h0M05dwiB1xb3U
 VMiyHa/coRZHcwFSByuznrKMfZ1IKsGjk/DqZs6mpq7wrNm2yfleH7/LaQUruBpZE+6BKMSSwS8
 3vXc89RUwjCGK77OCKDWjM6q2tZ06Ok7N5BNAMPHbf/LGNgZbrNOXKHJPj4rXnJetTDdx4ULU8s
 jFaX4peLSk5M69VjECesa7bw00aXOzZ+xCD+1gGB2LCiXUwZdcIQhGaYg60ZwJJ1tc3EB45TQOU
 3UsPXa6gPqfDKvmzxCPVBxF2ac+O3fW9rBLXW+BIM1ILvXXA3mNUkJgvuFAHTgTodoWzuDRlAAS
 GAPTDV/e8YgMJeL+F+unxuCwLxOzR/nuKCGF60XmdbzrNxdedbmRQU3/hc7tN5omOfd8WZb4OF2
 +9c61wtB6BGg3Sw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

mm/internal.h carries the memory failure declarations, but only seven
of the 81 .c files that include it use them.

Move memory failure declarations to a new mm/memory-failure.h and
include that from those seven files that need them.

Move the block as is, including take_page_off_buddy(),
put_page_back_buddy() and page_mapped_in_vma(): they live in
page_alloc.c and page_vma_mapped.c, but are built only for
CONFIG_MEMORY_FAILURE and called only from memory-failure.c.

Keep the declarations private to mm/.

No functional change.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Link: https://lore.kernel.org/all/aumt-4kfGGtoXuh-@kernel.org/
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 MAINTAINERS          |  1 +
 mm/hwpoison-inject.c |  1 +
 mm/internal.h        | 29 -----------------------------
 mm/ksm.c             |  1 +
 mm/memory-failure.c  |  1 +
 mm/memory-failure.h  | 36 ++++++++++++++++++++++++++++++++++++
 mm/memory_hotplug.c  |  1 +
 mm/page_alloc.c      |  1 +
 mm/page_vma_mapped.c |  1 +
 mm/vmscan.c          |  1 +
 10 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27d5b599558ae7..cc973903fda09d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12441,6 +12441,7 @@ F:	include/linux/memory-failure.h
 F:	include/trace/events/memory-failure.h
 F:	mm/hwpoison-inject.c
 F:	mm/memory-failure.c
+F:	mm/memory-failure.h
 F:	tools/testing/selftests/mm/memory-failure.c
 
 HYCON HY46XX TOUCHSCREEN SUPPORT
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index a11222572f9789..07032ec63080e8 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -10,6 +10,7 @@
 #include <linux/page-flags.h>
 #include <linux/memcontrol.h>
 #include "internal.h"
+#include "memory-failure.h"
 
 static u32 hwpoison_filter_enable;
 static u32 hwpoison_filter_dev_major = ~0U;
diff --git a/mm/internal.h b/mm/internal.h
index 3e15dcdd8af768..b9278329f9a239 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1196,35 +1196,6 @@ static inline bool node_reclaim_enabled(void)
 	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
 }
 
-/*
- * mm/memory-failure.c
- */
-#ifdef CONFIG_MEMORY_FAILURE
-int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
-void shake_folio(struct folio *folio);
-typedef int hwpoison_filter_func_t(struct page *p);
-void hwpoison_filter_register(hwpoison_filter_func_t *filter);
-void hwpoison_filter_unregister(void);
-
-#define MAGIC_HWPOISON	0x48575053U	/* HWPS */
-void SetPageHWPoisonTakenOff(struct page *page);
-void ClearPageHWPoisonTakenOff(struct page *page);
-bool take_page_off_buddy(struct page *page);
-bool put_page_back_buddy(struct page *page);
-struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
-void add_to_kill_ksm(struct task_struct *tsk, const struct page *p,
-		     struct vm_area_struct *vma, struct list_head *to_kill,
-		     unsigned long ksm_addr);
-unsigned long page_mapped_in_vma(const struct page *page,
-		struct vm_area_struct *vma);
-
-#else
-static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
-{
-	return -EBUSY;
-}
-#endif
-
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
diff --git a/mm/ksm.c b/mm/ksm.c
index d24b129932bf79..623a2cdb392428 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -44,6 +44,7 @@
 
 #include <asm/tlbflush.h>
 #include "internal.h"
+#include "memory-failure.h"
 #include "mm_slot.h"
 
 #define CREATE_TRACE_POINTS
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b215312f261b83..78f0a13349cb3e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -68,6 +68,7 @@
 #include "swap.h"
 #include "page_alloc.h"
 #include "internal.h"
+#include "memory-failure.h"
 
 static int sysctl_memory_failure_early_kill __read_mostly;
 
diff --git a/mm/memory-failure.h b/mm/memory-failure.h
new file mode 100644
index 00000000000000..153aea6c610c03
--- /dev/null
+++ b/mm/memory-failure.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mm/ internal memory failure declarations
+ */
+#ifndef __MM_MEMORY_FAILURE_H
+#define __MM_MEMORY_FAILURE_H
+
+#include <linux/mm.h>
+
+#ifdef CONFIG_MEMORY_FAILURE
+int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
+void shake_folio(struct folio *folio);
+typedef int hwpoison_filter_func_t(struct page *p);
+void hwpoison_filter_register(hwpoison_filter_func_t *filter);
+void hwpoison_filter_unregister(void);
+
+#define MAGIC_HWPOISON	0x48575053U	/* HWPS */
+void SetPageHWPoisonTakenOff(struct page *page);
+void ClearPageHWPoisonTakenOff(struct page *page);
+bool take_page_off_buddy(struct page *page);
+bool put_page_back_buddy(struct page *page);
+struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
+void add_to_kill_ksm(struct task_struct *tsk, const struct page *p,
+		     struct vm_area_struct *vma, struct list_head *to_kill,
+		     unsigned long ksm_addr);
+unsigned long page_mapped_in_vma(const struct page *page,
+		struct vm_area_struct *vma);
+
+#else
+static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
+{
+	return -EBUSY;
+}
+#endif
+
+#endif /* __MM_MEMORY_FAILURE_H */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 41fcdc04e54042..b0971404f0ac0a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -40,6 +40,7 @@
 #include <asm/tlbflush.h>
 
 #include "internal.h"
+#include "memory-failure.h"
 #include "mm_init.h"
 #include "page_alloc.h"
 #include "shuffle.h"
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index abebfb1f202e9b..b6d9f2c9cdef53 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -57,6 +57,7 @@
 #include <linux/pgalloc_tag.h>
 #include <asm/div64.h>
 #include "internal.h"
+#include "memory-failure.h"
 #include "mm_init.h"
 #include "page_alloc.h"
 #include "shuffle.h"
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e6b6170c2f4f72..d45d52436f99a0 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -6,6 +6,7 @@
 #include <linux/leafops.h>
 
 #include "internal.h"
+#include "memory-failure.h"
 
 static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50c352e9ffefc4..3db2db65319c00 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -67,6 +67,7 @@
 #include <linux/sched/sysctl.h>
 
 #include "internal.h"
+#include "memory-failure.h"
 #include "page_alloc.h"
 #include "swap.h"
 

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261104-memory-failure-split-4c7abedbe0dc

Best regards,
--  
Breno Leitao <leitao@debian.org>

