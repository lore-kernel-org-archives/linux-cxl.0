Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED8190496
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131768; cv=none; b=D2walz2ffNLVSTPJ+sW9XbJoKkAeZro2UIktg0kgDJDNSuia4xqz7u5zNBhOiGaLFYUlfBFRJjMxdY4rAIK3/G8hXw2Vip9NCgfDCX0arX7HtkfpkHW3gnIE5hWQr/tVwWHjRZ7+ivSiaG10droTNjJOfN+qaWAt0UgIXPdHZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131768; c=relaxed/simple;
	bh=barVuvVWK8KR6ESCkmFpcAZAOty3u4GD5RV7yz86z3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ero+6eYM6b+Fbe1k6e/hwfaVW9/WAut453mcG3lhDHxge5UxWM3OCphLEm4/EzYAEp+x0eo8HG7CR+uSmcshZ4cyy7vTWO0MzoLio+Y6PBP8bnuqnJldO8qZdVnKYCXuCVIIXejNFUlThNRTSF9WZj50fJlO5yeKWK6Jv5SVP20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lfdwOovR; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lfdwOovR"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b7a3773a95so6515276d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723131765; x=1723736565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVUhpkOPZqVQX3h1eHDFuE2aZCm6U3+B79UvbkAx6DA=;
        b=lfdwOovRrSuSVoz8FI3l0QABuA4NVYu9dYFsYpI/0fT5I2jLdXGHTbR8RgozsMrrQ5
         SIFcITwsar+8zDmfYpglSlrDd91l/gFspJWmLZ95zU+SkZG/TkpJC3RJT1XN+50NKDuf
         GoRCYiY6BMy9XSbcPphSCfCkc6UDhMeRiph9F/6gJgzRds3csSNcbZrLg6d6i0zNdNBf
         0zekTXsev8IE+/+iuXS0jUmLo890bKiy1wNENH1+QnJHe4s8Y22NIudk1GSLyvztwuwq
         Kw2xgjYqrz3EUyHxFSQM43YoKukvHMD9olgA4+pM+p4cfYZbUM8y1UxmBsjSSe8GXxqA
         Ha6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131765; x=1723736565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVUhpkOPZqVQX3h1eHDFuE2aZCm6U3+B79UvbkAx6DA=;
        b=Do2dEnlVh/OAM44jYWkqIjbcRdIymKqFxWW8bQLw8u+RoJmeO2hjIt7bFj4lSIkBiK
         N6Dvg838RSc6FxO0k+fX6edecVDsjv0+mYHd5W0wqc4zZXrxMiEhLTNDYv1dZQatq6aa
         tYJ6Ns1FQd9rExeyFA7Pj+DV6qZ6NeRow3k1WSJziE3zrad/PHkaaetXYnlLA2PQC5/6
         dEjj0IZpMh6ell3dELrsXS1Y2vvaSm3UMuQd2a2vHbZ+YnwbVdHvlJElX/4tULPS1l6K
         SYBRRk+vMnbxTjumi+b0+LMQRixMB7+HrD8s+UEVPVjV6fsT88D8hSHAVZzbZWcw942Z
         2Gkw==
X-Forwarded-Encrypted: i=1; AJvYcCXf1r5zJy7ReKp/9i+Bvxxa+PXKXEsHuCne8zuq1jmuzOq+zwHjeeDxxjmQ/cZRQN2YNchME1qsCwZ8FNGO0byHtKbqzVPTlf/k
X-Gm-Message-State: AOJu0Ywr1H9c7QzHB+2onqSDXQWg3E/O5D3t+a/hats5zfMkz92Im0sp
	8tKCWr+MJHIoJZGuakQA7tiNVWpZ3ACb+6hqyKYNz2p/G67yY+bEKJwU79YaA/BbydtofxlsRW4
	m
X-Google-Smtp-Source: AGHT+IHuyPvu08+JZDwV+1cdjbraCLK1a/zBKaZNVdpIAi6OHbeRHRlv6moOdjtW9Wgi7xkF2vcdiQ==
X-Received: by 2002:a05:6214:2f90:b0:6b9:5b0d:8c9b with SMTP id 6a1803df08f44-6bd6bd53e67mr31343756d6.43.1723131764981;
        Thu, 08 Aug 2024 08:42:44 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b72d9sm67160936d6.60.2024.08.08.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:42:44 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	dan.j.williams@intel.com,
	yi.zhang@redhat.com,
	alison.schofield@intel.com,
	david@redhat.com,
	yosryahmed@google.com
Subject: [PATCH v3 4/4] mm: don't account memmap per-node
Date: Thu,  8 Aug 2024 15:42:37 +0000
Message-ID: <20240808154237.220029-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240808154237.220029-1-pasha.tatashin@soleen.com>
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when memory is hot-plugged or hot-removed the accounting is
done based on the assumption that memmap is allocated from the same node
as the hot-plugged/hot-removed memory, which is not always the case.

In addition, there are challenges with keeping the node id of the memory
that is being remove to the time when memmap accounting is actually
performed: since this is done after remove_pfn_range_from_zone(), and
also after remove_memory_block_devices(). Meaning that we cannot use
pgdat nor walking though memblocks to get the nid.

Given all of that, account the memmap overhead system wide instead.

For this we are going to be using global atomic counters, but given that
memmap size is rarely modified, and normally is only modified either
during early boot when there is only one CPU, or under a hotplug global
mutex lock, therefore there is no need for per-cpu optimizations.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
Reported-by: Alison Schofield <alison.schofield@intel.com>
Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl2/#t

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/mmzone.h |  2 --
 include/linux/vmstat.h |  7 ++++---
 mm/hugetlb_vmemmap.c   |  8 ++++----
 mm/mm_init.c           |  3 +--
 mm/page_alloc.c        |  1 -
 mm/page_ext.c          | 15 +++++---------
 mm/sparse-vmemmap.c    | 11 ++++-------
 mm/sparse.c            |  5 ++---
 mm/vmstat.c            | 45 ++++++++++++++++++++----------------------
 9 files changed, 41 insertions(+), 56 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 41458892bc8a..1dc6248feb83 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -220,8 +220,6 @@ enum node_stat_item {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
-	NR_MEMMAP, /* page metadata allocated through buddy allocator */
-	NR_MEMMAP_BOOT, /* page metadata allocated through boot allocator */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 9ab4fa5e09b5..596c050ed492 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -38,6 +38,8 @@ struct reclaim_stat {
 enum vm_stat_item {
 	NR_DIRTY_THRESHOLD,
 	NR_DIRTY_BG_THRESHOLD,
+	NR_MEMMAP,	/* page metadata allocated through buddy allocator */
+	NR_MEMMAP_BOOT,	/* page metadata allocated through boot allocator */
 	NR_VM_STAT_ITEMS,
 };
 
@@ -618,7 +620,6 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
 	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
 }
 
-void __meminit mod_node_early_perpage_metadata(int nid, long delta);
-void __meminit store_early_perpage_metadata(void);
-
+void mod_memmap_boot(long delta);
+void mod_memmap(long delta);
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 70027869d844..60a5faa1f341 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -185,10 +185,10 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 static inline void free_vmemmap_page(struct page *page)
 {
 	if (PageReserved(page)) {
-		mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
+		mod_memmap_boot(-1);
 		free_bootmem_page(page);
 	} else {
-		mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
+		mod_memmap(-1);
 		__free_page(page);
 	}
 }
@@ -341,7 +341,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, vmemmap_pages);
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, 1);
+		mod_memmap(1);
 	}
 
 	/*
@@ -396,7 +396,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 			goto out;
 		list_add(&page->lru, list);
 	}
-	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
+	mod_memmap(nr_pages);
 
 	return 0;
 out:
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..29677274e74e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1623,8 +1623,7 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 		panic("Failed to allocate %ld bytes for node %d memory map\n",
 		      size, pgdat->node_id);
 	pgdat->node_mem_map = map + offset;
-	mod_node_early_perpage_metadata(pgdat->node_id,
-					DIV_ROUND_UP(size, PAGE_SIZE));
+	mod_memmap_boot(DIV_ROUND_UP(size, PAGE_SIZE));
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 		 __func__, pgdat->node_id, (unsigned long)pgdat,
 		 (unsigned long)pgdat->node_mem_map);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 28f80daf5c04..875d76e8684a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5755,7 +5755,6 @@ void __init setup_per_cpu_pageset(void)
 	for_each_online_pgdat(pgdat)
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
-	store_early_perpage_metadata();
 }
 
 __meminit void zone_pcp_init(struct zone *zone)
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 962d45eee1f8..a4b485b39330 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -214,8 +214,7 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
-	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
-			    DIV_ROUND_UP(table_size, PAGE_SIZE));
+	mod_memmap_boot(DIV_ROUND_UP(table_size, PAGE_SIZE));
 	return 0;
 }
 
@@ -275,10 +274,8 @@ static void *__meminit alloc_page_ext(size_t size, int nid)
 	else
 		addr = vzalloc_node(size, nid);
 
-	if (addr) {
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
-				    DIV_ROUND_UP(size, PAGE_SIZE));
-	}
+	if (addr)
+		mod_memmap(DIV_ROUND_UP(size, PAGE_SIZE));
 
 	return addr;
 }
@@ -330,14 +327,12 @@ static void free_page_ext(void *addr)
 	if (is_vmalloc_addr(addr)) {
 		page = vmalloc_to_page(addr);
 		pgdat = page_pgdat(page);
-		mod_node_page_state(pgdat, NR_MEMMAP,
-				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
+		mod_memmap(-1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		vfree(addr);
 	} else {
 		page = virt_to_page(addr);
 		pgdat = page_pgdat(page);
-		mod_node_page_state(pgdat, NR_MEMMAP,
-				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
+		mod_memmap(-1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 1dda6c53370b..307f6fe83598 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,13 +469,10 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
-	if (system_state == SYSTEM_BOOTING) {
-		mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(end - start,
-								  PAGE_SIZE));
-	} else {
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
-				    DIV_ROUND_UP(end - start, PAGE_SIZE));
-	}
+	if (system_state == SYSTEM_BOOTING)
+		mod_memmap_boot(DIV_ROUND_UP(end - start, PAGE_SIZE));
+	else
+		mod_memmap(DIV_ROUND_UP(end - start, PAGE_SIZE));
 
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index e4b830091d13..9cc80ba1f7c1 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -463,7 +463,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
-	mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE));
+	mod_memmap_boot(DIV_ROUND_UP(size, PAGE_SIZE));
 #endif
 }
 
@@ -643,8 +643,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
-			    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
+	mod_memmap(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6f8aa4766f16..896f9a2ace8a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1033,6 +1033,23 @@ unsigned long node_page_state(struct pglist_data *pgdat,
 }
 #endif
 
+/*
+ * Count number of pages "struct page" and "struct page_ext" consume.
+ * nr_memmap_boot: # of pages allocated by boot allocator & not part of MemTotal
+ * nr_memmap: # of pages that were allocated by buddy allocator
+ */
+static atomic_long_t nr_memmap_boot, nr_memmap;
+
+void mod_memmap_boot(long delta)
+{
+	atomic_long_add(delta, &nr_memmap_boot);
+}
+
+void mod_memmap(long delta)
+{
+	atomic_long_add(delta, &nr_memmap);
+}
+
 #ifdef CONFIG_COMPACTION
 
 struct contig_page_info {
@@ -1255,11 +1272,11 @@ const char * const vmstat_text[] = {
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
-	"nr_memmap",
-	"nr_memmap_boot",
 	/* system-wide enum vm_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
+	"nr_memmap",
+	"nr_memmap_boot",
 
 #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
 	/* enum vm_event_item counters */
@@ -1827,6 +1844,8 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
 			    v + NR_DIRTY_THRESHOLD);
+	v[NR_MEMMAP_BOOT] = atomic_long_read(&nr_memmap_boot);
+	v[NR_MEMMAP] = atomic_long_read(&nr_memmap);
 	v += NR_VM_STAT_ITEMS;
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
@@ -2285,25 +2304,3 @@ static int __init extfrag_debug_init(void)
 module_init(extfrag_debug_init);
 
 #endif
-
-/*
- * Page metadata size (struct page and page_ext) in pages
- */
-static unsigned long early_perpage_metadata[MAX_NUMNODES] __meminitdata;
-
-void __meminit mod_node_early_perpage_metadata(int nid, long delta)
-{
-	early_perpage_metadata[nid] += delta;
-}
-
-void __meminit store_early_perpage_metadata(void)
-{
-	int nid;
-	struct pglist_data *pgdat;
-
-	for_each_online_pgdat(pgdat) {
-		nid = pgdat->node_id;
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
-				    early_perpage_metadata[nid]);
-	}
-}
-- 
2.46.0.76.ge559c4bf1a-goog

