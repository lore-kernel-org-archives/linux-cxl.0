Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B31607BF
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230630; cv=none; b=sHris7OxAXTcy2jD2O8VLK3ekeWtYSo0dW8N59SlcKE55FyrSRcFrUx9G+ayJZEwpqoZY4Jc1Abo+zKQJQLbdkFryz9Y83QMDW49U8Vn17TMx1EQaFwLI6hp5JXHYoRPGR49V213DNszTz5SYRom5lj0j5dyH7Gj3QyFTJbt3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230630; c=relaxed/simple;
	bh=6wosICAX5upSWdnUV4KS1ODEyn0GpvDE32NQy49q3CU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgdC8ZECT9w4+9V2hY76FwKAh3viCPJ1n/N25CJf5G7i77t/depCX9MWGU5swiuKWl+WhlUekQZe8zgJvWHiZmCafRM81pMqHoHJJx5yBlO3AOhNlGeSwXvIej8zDSP2chKv+Y4orsXuKeLtXpWYQUHinsZNyhQJtZ9HDeGbeq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=OIWcB6oe; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="OIWcB6oe"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d436c95fso153039585a.3
        for <linux-cxl@vger.kernel.org>; Fri, 09 Aug 2024 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723230627; x=1723835427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7scNbfOD3UNvIo9y0T+pYKNfJFgM2C7HW5kYHlU5U7s=;
        b=OIWcB6oek741WgmBJjIzKMySLERThB6hYMhFkIFUNkmyLk+nDygEeuyGvSo7ev4SLp
         vfI9+LsNESWRNkDWYVvnnCCE24D732QLNOb+/7IKHX1YUNFZMzLOYPThpnc959GE5iBf
         ELAGh9qlHi77mfPsxiOIT5t4jMycCsC0xui3HNFSWj3W2mYcb8gHQ5z0bDKDs47LsnTC
         khPdOMG8A2gD7cao3vad482NJlHJ2dNeGWeIDfI1sMndpanJatDHkBO5jviMqEyxDax+
         d9Qjx0/8H3sW/XgnUb64jHafzgEy4/SVaBDXHhIRcpTlNtNZsepmbjgCB4/sZ5toMVpv
         nksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230627; x=1723835427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7scNbfOD3UNvIo9y0T+pYKNfJFgM2C7HW5kYHlU5U7s=;
        b=QB+RxBI5GU8nufb0Ax66F0FiGuQn22cJKO27xPYHediVm+HNeYTLZLuL8Vx+io44Qm
         4tSR4JUD1CfEoKeoF17ofCWnT4ip5FqGpUR2X+q6o86YJ9GbpVHVW1cEj+98PVf9ZFvu
         z3iExVSyCVxyn1j+kCVjTost1fLGF1Tw49RcPOPhYET5Kqhv3oEQl6b9HtVKysCrBWB0
         PNo+TZxIWLd+4Fa6xvMY1lEqfx15T2kGqKksH8Yc85bnReyXnUJwaO70xP/0gXQfhTrN
         bfjmueBakMZd44LKg1YVhq0IffPDXFgv/N7AyshMnZz+b+uO9XqKiPqYc0Dj64/6Vvtl
         ViAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUA+eyeKaNyCEA15sx+OAJKstMmlIvimt3Ggj5XspgSrebBKi2UEXOFodc03eJQXw7CiGb3+LwGGy4gJyqpmMpIoyxDkkP9iJ4
X-Gm-Message-State: AOJu0YzX6gyasXyqjUstUiIl/uxfAEweEHzb4kjRCF+q6KKKb1ttJdx5
	LInMo6nOgEZVQpcMPLKMlL6dA9zDoujJRspI132yF8IXsw0XjY4MR91oAxiwNqU=
X-Google-Smtp-Source: AGHT+IG+izZuVqrrLECU59ZUsz/j/pq6H+/mhN6LagU3A3JWt/ctLE0qFWvHYBV7BwQjZPC1c0cfJA==
X-Received: by 2002:a05:620a:2456:b0:79d:5f67:a836 with SMTP id af79cd13be357-7a4c17aafddmr317308185a.26.1723230627259;
        Fri, 09 Aug 2024 12:10:27 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7df5a55sm5522085a.86.2024.08.09.12.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:10:26 -0700 (PDT)
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
Subject: [PATCH v5 3/3] mm: don't account memmap per-node
Date: Fri,  9 Aug 2024 19:10:20 +0000
Message-ID: <20240809191020.1142142-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240809191020.1142142-1-pasha.tatashin@soleen.com>
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix invalid access to pgdat during hot-remove operation:
ndctl users reported a GPF when trying to destroy a namespace:
$ ndctl destroy-namespace all -r all -f
 Segmentation fault
 dmesg:
 Oops: general protection fault, probably for
 non-canonical address 0xdffffc0000005650: 0000 [#1] PREEMPT SMP KASAN
 PTI
 KASAN: probably user-memory-access in range
 [0x000000000002b280-0x000000000002b287]
 CPU: 26 UID: 0 PID: 1868 Comm: ndctl Not tainted 6.11.0-rc1 #1
 Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
 2.20.1 09/13/2023
 RIP: 0010:mod_node_page_state+0x2a/0x110

cxl-test users report a GPF when trying to unload the test module:
$ modrpobe -r cxl-test
 dmesg
 BUG: unable to handle page fault for address: 0000000000004200
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 0 UID: 0 PID: 1076 Comm: modprobe Tainted: G O N 6.11.0-rc1 #197
 Tainted: [O]=OOT_MODULE, [N]=TEST
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/15
 RIP: 0010:mod_node_page_state+0x6/0x90

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

Also, while we are here rename nr_memmap to nr_memmap_pages, and
nr_memmap_boot to nr_memmap_boot_pages to be self explanatory that the
units are in page count.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
Reported-by: Alison Schofield <alison.schofield@intel.com>
Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl2/#t

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h |  2 --
 include/linux/vmstat.h |  7 ++++---
 mm/hugetlb_vmemmap.c   |  8 ++++----
 mm/mm_init.c           |  3 +--
 mm/page_alloc.c        |  1 -
 mm/page_ext.c          | 18 ++++-------------
 mm/sparse-vmemmap.c    | 11 ++++------
 mm/sparse.c            |  5 ++---
 mm/vmstat.c            | 46 ++++++++++++++++++++----------------------
 9 files changed, 41 insertions(+), 60 deletions(-)

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
index 9ab4fa5e09b5..9eb77c9007e6 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -38,6 +38,8 @@ struct reclaim_stat {
 enum vm_stat_item {
 	NR_DIRTY_THRESHOLD,
 	NR_DIRTY_BG_THRESHOLD,
+	NR_MEMMAP_PAGES,	/* page metadata allocated through buddy allocator */
+	NR_MEMMAP_BOOT_PAGES,	/* page metadata allocated through boot allocator */
 	NR_VM_STAT_ITEMS,
 };
 
@@ -618,7 +620,6 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
 	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
 }
 
-void __meminit mod_node_early_perpage_metadata(int nid, long delta);
-void __meminit store_early_perpage_metadata(void);
-
+void memmap_boot_pages_add(long delta);
+void memmap_pages_add(long delta);
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4f51e0596197..0c3f56b3578e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -185,11 +185,11 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 static inline void free_vmemmap_page(struct page *page)
 {
 	if (PageReserved(page)) {
+		memmap_boot_pages_add(-1);
 		free_bootmem_page(page);
-		mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
 	} else {
+		memmap_pages_add(-1);
 		__free_page(page);
-		mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
 	}
 }
 
@@ -341,7 +341,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, vmemmap_pages);
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, 1);
+		memmap_pages_add(1);
 	}
 
 	/*
@@ -396,7 +396,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 			goto out;
 		list_add(&page->lru, list);
 	}
-	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
+	memmap_pages_add(nr_pages);
 
 	return 0;
 out:
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..f9a60ffc5532 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1623,8 +1623,7 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 		panic("Failed to allocate %ld bytes for node %d memory map\n",
 		      size, pgdat->node_id);
 	pgdat->node_mem_map = map + offset;
-	mod_node_early_perpage_metadata(pgdat->node_id,
-					DIV_ROUND_UP(size, PAGE_SIZE));
+	memmap_boot_pages_add(DIV_ROUND_UP(size, PAGE_SIZE));
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
index c191e490c401..641d93f6af4c 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -214,8 +214,7 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
-	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
-			    DIV_ROUND_UP(table_size, PAGE_SIZE));
+	memmap_boot_pages_add(DIV_ROUND_UP(table_size, PAGE_SIZE));
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
+		memmap_pages_add(DIV_ROUND_UP(size, PAGE_SIZE));
 
 	return addr;
 }
@@ -323,25 +320,18 @@ static void free_page_ext(void *addr)
 {
 	size_t table_size;
 	struct page *page;
-	struct pglist_data *pgdat;
 
 	table_size = page_ext_size * PAGES_PER_SECTION;
+	memmap_pages_add(-1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 
 	if (is_vmalloc_addr(addr)) {
-		page = vmalloc_to_page(addr);
-		pgdat = page_pgdat(page);
 		vfree(addr);
 	} else {
 		page = virt_to_page(addr);
-		pgdat = page_pgdat(page);
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
-
-	mod_node_page_state(pgdat, NR_MEMMAP,
-			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
-
 }
 
 static void __free_page_ext(unsigned long pfn)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 1dda6c53370b..edcc7a6b0f6f 100644
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
+		memmap_boot_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
+	else
+		memmap_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
 
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index e4b830091d13..0f018c6f9ec5 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -463,7 +463,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
-	mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE));
+	memmap_boot_pages_add(DIV_ROUND_UP(size, PAGE_SIZE));
 #endif
 }
 
@@ -643,8 +643,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
-			    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
+	memmap_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6f8aa4766f16..e875f2a4915f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1033,6 +1033,24 @@ unsigned long node_page_state(struct pglist_data *pgdat,
 }
 #endif
 
+/*
+ * Count number of pages "struct page" and "struct page_ext" consume.
+ * nr_memmap_boot_pages: # of pages allocated by boot allocator
+ * nr_memmap_pages: # of pages that were allocated by buddy allocator
+ */
+static atomic_long_t nr_memmap_boot_pages = ATOMIC_LONG_INIT(0);
+static atomic_long_t nr_memmap_pages = ATOMIC_LONG_INIT(0);
+
+void memmap_boot_pages_add(long delta)
+{
+	atomic_long_add(delta, &nr_memmap_boot_pages);
+}
+
+void memmap_pages_add(long delta)
+{
+	atomic_long_add(delta, &nr_memmap_pages);
+}
+
 #ifdef CONFIG_COMPACTION
 
 struct contig_page_info {
@@ -1255,11 +1273,11 @@ const char * const vmstat_text[] = {
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
-	"nr_memmap",
-	"nr_memmap_boot",
 	/* system-wide enum vm_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
+	"nr_memmap_pages",
+	"nr_memmap_boot_pages",
 
 #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
 	/* enum vm_event_item counters */
@@ -1827,6 +1845,8 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
 			    v + NR_DIRTY_THRESHOLD);
+	v[NR_MEMMAP_PAGES] = atomic_long_read(&nr_memmap_pages);
+	v[NR_MEMMAP_BOOT_PAGES] = atomic_long_read(&nr_memmap_boot_pages);
 	v += NR_VM_STAT_ITEMS;
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
@@ -2285,25 +2305,3 @@ static int __init extfrag_debug_init(void)
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

