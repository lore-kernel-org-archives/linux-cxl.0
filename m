Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074937;
	b=CR40LGLJi/MK/g1ervXIuB25qJ793ZjEAZiZBr7B78PsM7hmcn4D/zosSoSzLRaEGzkP
	 cqOIwnnf4akt/7x+z+9UbkVtoVpzKXNeEoRFvaXwpfARq1GAW3mgMmGOjxUtXh+MjKq9U
	 qeNzZuw/NoCUBjnzTZ25zL5eI0Btr0bfEtCtyMqjlAoM6DjyUgodlJ7OEqVGE15i+bzkt
	 HrH2ykbfsoySlazGuCo1Y4sK0b6Bcc+6Au8aYn9wZkai/TfLtFZ8ZNJjGYhf3bCHb3qb+
	 Awq8MzF+XS2mzd3P+515BQFr9ssduTXAOa4ohTNu3gAKNbDdbgqE+kL9UiDv0ycSLnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CfcYGaJ4tkbNnhjQHfn5dtEgiZ6cd5xAnQKhOyf0Ms4=;
	b=XxcH1HXVZjem0EPl7vPXp9+4LYcYpCJd9WkFICK9BKKksb5JuPkgQcznmM3a5snVWjl/
	 c5HyKLNKE6StgGQ9QMC9SB6/datXkUyhVuIx0M/XIQSxnMlTtitIOgk+BFJfezEYZZpug
	 QIB9f9OCymmQ9hIvfpsn8mNtni9al/orRfC6KjGPccZu5w7w9rplERvJPkj5cOYp26Y4m
	 6UjdNs7vxKXW15VwWLLaoQOJCy+2KSKGCwTmiV3nFW2KcHcTo7RstjeCYBmeQxmHeiamP
	 IOX1OmFvSmsiyYt3iaTNZJ7PaDPplSWE4lmXZaBj2G22hyAdL/Q/Yzkub5L7BstdBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Y3gLtDpB;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239F606A321
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 04:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D239F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Y3gLtDpB
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c11468b5fso39619066d6.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 21:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793074936; x=1793679736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CfcYGaJ4tkbNnhjQHfn5dtEgiZ6cd5xAnQKhOyf0Ms4=;
        b=Y3gLtDpBr+M2FDm5quUn5gPRwaJ+fyy+Qctp/Xqq2lMD6UiJWzbPv9MlofyBKVv900
         6m1NdCDxkTiDqwSgh9vEt4LVmKHniUPhnAjTPT4WVA1CzqHelc6fFBfKcz8hxsUiltpc
         kBEpn5xRR4grlCDKkY+ZibHGqnK4DTxcLe0VUNj/Y4ouJt17aSmtj685hXExRr4cTTb+
         pA551bJ7Xbm+xIjMutL6A1H+BngA2tatnAWOsBrSpbdiGnD8ifrhMQFrTdHePnu7KOZ+
         iWTdzua/H0lxYN4pk1j6so712OOLxxT2AcP22qgzQXUHqvdIMVlLUq14b59nPsSYrClv
         2RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793074936; x=1793679736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CfcYGaJ4tkbNnhjQHfn5dtEgiZ6cd5xAnQKhOyf0Ms4=;
        b=J7dDL6fRxfAQUM9Shdf86prhwo2Lv4U3pqdfADAWZFeIJebSuuuSs9tdxxeHIQSMfh
         IshkFAKcuEOVPInoOD6Ci31QXRX6iVdTO35EkyUV39uPOoYSO1crcqvxmdnNIePnUw11
         BG6BSZ+FUbTDPw5YOXgRuUG4+MSU8JWrY6bYoS6NMtE61k9JMhCcEKMo/OK9C5FUH/88
         AQ6+kYiCQZtJid4pJ+PNuIjM08Rp0fkTBjz30HDZCOBKzS4EGIj/cmcoZKQ7ZnxC52aa
         sR05I8ZDR8ZMe+JxfGmQr7LzV6xyJ8wLq7PJW/eG8rJB30eeVH5BMh67a7DfVNcTuoLp
         eI2Q==
X-Forwarded-Encrypted: i=1; AKwUvByMEAqxjuAYbdZvuH9cXaTlO1O2gUb0gRh+yUROZW5AY4/Z/auG/Eyz3EVhdJYzrsR7pvFRidE2S6k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6xqsHlqpWNjz1BDk56heUzuS5qwL6cf9Bke/ZQNsmSGXBCScY
	jgAI9bl+wJPomoyRZG78GeLjzKO/KVTEjw2DBH+Ys2f+8aQGEAKuV3lo9cNhHiWPSrk=
X-Gm-Gg: AYBFou0ghjzephah9HWQ2lwN5CVlykTGGPwoae37ZyoH3w9RY9zTFvCUVBOrCvcWDpY
	y03V1qd4gZkImBw0Qo2x9tCqa8KxIBtiQHQo1eB3+aG0uxpeZJ0n+4a4LOONrHmbVL/XwdPXYPk
	i2wgrVKJUf9KxsZYCi2Y8e+r7NqQs+t5nNmV+Wj1OObvxkUMomtj4ow/3hYNW+28WJ+ut7XjWWx
	1n4K6ZYm+nHWEgS7p89UzaP3EZ7bs/ntGSrToSNBa373klIrMCcnRt1RCkqT/vK5+Dyw05IbyS5
	LciBiTEO5kBmTV8phUboR3hgMV8KGUpvLClyQ2S4pMLv9RG0wiGgSf3LQGcoQDBRUAQcb9Kt6gY
	9ZRHJZ8hCoKUCVOC/igXAXEBbcg1hGsNcPcQ2rBUzhlvvKUxyCsrXOxCgPRg2kqPJ9mwSQ8gXS0
	sP4YAp1JkvxIpS/oV7gJU3A8pUp0FZePhasDDc1QNb0RwbBdO6wo638VZaNJ4ZWo7T4m9v/vod1
	lmmtA3RP2kaxPxHxlY177vFIvVgp9Jb/TPiy1/ckGmHerdAx9y+eIIk6rwKBvPsVmHpqw1E70mR
	zq5qv6LxsEc3cf4zxo4OmUOiT00ki0wOUnoHMjw0gA==
X-Received: by 2002:ad4:5c8d:0:b0:917:92c7:ce45 with SMTP id 6a1803df08f44-91c48e5705dmr159481776d6.37.1793074935786;
        Mon, 26 Oct 2026 21:22:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd01cdsm91139676d6.7.2026.10.26.21.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:22:13 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	osalvador@suse.de,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH 1/6] mm/compaction: wait for pfn walkers before poisoning offlined memmap
Date: Tue, 27 Oct 2026 00:21:59 -0400
Message-ID: <20261027042204.3741307-2-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027042204.3741307-1-gourry@gourry.net>
References: <20261027042204.3741307-1-gourry@gourry.net>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compaction checks that a pageblock is online, then uses its pages across
lock drops and sleeps.  If offline poisons the memmap meanwhile, a
DEBUG_VM kernel faults:

  CPU 1 (compaction)                  CPU 2 (offline_pages)
  pageblock_pfn_to_page()
    block is online
  isolate_migratepages_block()
    cond_resched()
                                      offline_mem_sections()
                                      remove_pfn_range_from_zone()
                                        page_init_poison()
    set_pageblock_skip(valid_page)
      reads the zone of a poisoned page

  Oops: general protection fault, probably for non-canonical address 0xdffffc00000006a2
  RIP: 0010:set_pfnblock_bit+0xa6/0x2b0
   isolate_migratepages_block+0x2456/0x3c80
   compact_zone+0x1638/0x3900
   compact_node+0x12a/0x1f0
   sysctl_compaction_handler+0xec/0x160

The free scanner faults the same way.  A contiguous zone skips the
online check, since offline clears zone->contiguous only after
poisoning.

Hold an SRCU-fast read section (pfn_walk) from the block check to the
last use of its pages, and make remove_pfn_range_from_zone() clear
zone->contiguous and wait for it before poisoning.  Offline pays one
grace period per range.

Scanner positions outlive the section, and offline can shrink the zone
meanwhile, so take the contiguous fast path only inside the current
span, publish zone->contiguous with release, and keep the migrate
scanner inside the zone.

With a kprobe parking the migrate scanner across the offline, base
faults in 3 of 3 runs and this patch in none.  Unforced offline/online
cycling under compaction faults in 8 of 24 runs on base and 0 of 12 with
this patch.

Fixes: d33695b16a9f ("mm/memory_hotplug: poison memmap in remove_pfn_range_from_zone()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/compaction.c     |  8 ++++++++
 mm/internal.h       | 41 +++++++++++++++++++++++++++++++++++++++++
 mm/memory_hotplug.c | 14 ++++++++++++--
 mm/mm_init.c        |  4 ++--
 mm/page_alloc.h     |  7 ++++++-
 5 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index f1b2060eb2016..2aeb18b6d54dd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -360,6 +360,7 @@ static void __reset_isolation_suitable(struct zone *zone)
 	if (!zone->compact_blockskip_flush)
 		return;
 
+	guard(pfn_walk)();
 	zone->compact_blockskip_flush = false;
 
 	/*
@@ -716,6 +717,7 @@ isolate_freepages_range(struct compact_control *cc,
 	unsigned long isolated, pfn, block_start_pfn, block_end_pfn;
 	int order;
 
+	guard(pfn_walk)();
 	for (order = 0; order < NR_PAGE_ORDERS; order++)
 		INIT_LIST_HEAD(&cc->freepages[order]);
 
@@ -1340,6 +1342,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
 	unsigned long pfn, block_start_pfn, block_end_pfn;
 	int ret = 0;
 
+	guard(pfn_walk)();
 	/* Scan block by block. First and last block may be incomplete */
 	pfn = start_pfn;
 	block_start_pfn = pageblock_start_pfn(pfn);
@@ -1732,6 +1735,7 @@ static void isolate_freepages(struct compact_control *cc)
 	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan */
 	unsigned int stride;
 
+	guard(pfn_walk)();
 	/* Try a small search of the free lists for a candidate */
 	fast_isolate_freepages(cc);
 	if (cc->nr_freepages)
@@ -2099,6 +2103,7 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 		(cc->mode != MIGRATE_SYNC ? ISOLATE_ASYNC_MIGRATE : 0);
 	bool fast_find_block;
 
+	guard(pfn_walk)();
 	/*
 	 * Start at where we last stopped, or beginning of the zone as
 	 * initialized by compact_zone(). The first failure will use
@@ -2116,6 +2121,9 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 	 */
 	fast_find_block = low_pfn != cc->migrate_pfn && !cc->fast_search_fail;
 
+	/* Offline may have shrunk the zone start past an old migrate_pfn */
+	low_pfn = max(low_pfn, block_start_pfn);
+
 	/* Only scan within a pageblock boundary */
 	block_end_pfn = pageblock_end_pfn(low_pfn);
 
diff --git a/mm/internal.h b/mm/internal.h
index d497c35ee7833..8a2faa74403b5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -18,6 +18,7 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/leafops.h>
+#include <linux/srcu.h>
 #include <linux/tracepoint-defs.h>
 
 /* Internal core VMA manipulation functions. */
@@ -1206,6 +1207,46 @@ struct tlbflush_unmap_batch;
  */
 extern struct workqueue_struct *mm_percpu_wq;
 
+/*
+ * Compaction checks that a pageblock is online and then uses its pages,
+ * possibly across sleeps.  remove_pfn_range_from_zone() waits for these
+ * readers before it poisons the memmap of a range taken offline.
+ */
+#ifdef CONFIG_MEMORY_HOTREMOVE
+extern struct srcu_struct pfn_walk_srcu;
+
+static inline struct srcu_ctr __percpu *pfn_walk_lock(void)
+{
+	return srcu_read_lock_fast(&pfn_walk_srcu);
+}
+
+static inline void pfn_walk_unlock(struct srcu_ctr __percpu *scp)
+{
+	srcu_read_unlock_fast(&pfn_walk_srcu, scp);
+}
+
+static inline void pfn_walk_synchronize(void)
+{
+	synchronize_srcu(&pfn_walk_srcu);
+}
+#else
+static inline struct srcu_ctr __percpu *pfn_walk_lock(void)
+{
+	return NULL;
+}
+
+static inline void pfn_walk_unlock(struct srcu_ctr __percpu *scp)
+{
+}
+
+static inline void pfn_walk_synchronize(void)
+{
+}
+#endif
+
+DEFINE_LOCK_GUARD_0(pfn_walk, _T->scp = pfn_walk_lock(),
+		    pfn_walk_unlock(_T->scp), struct srcu_ctr __percpu *scp)
+
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 796af1028ee23..b5d9e367b893d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -543,6 +543,16 @@ void remove_pfn_range_from_zone(struct zone *zone,
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	unsigned long pfn, cur_nr_pages;
 
+	/*
+	 * The range is offline, but compaction may still use pages it found
+	 * online.  Make new scans check the online state instead of trusting
+	 * zone->contiguous, and wait for the old ones before poisoning.
+	 */
+	if (!zone_is_zone_device(zone)) {
+		clear_zone_contiguous(zone);
+		pfn_walk_synchronize();
+	}
+
 	/* Poison struct pages because they are now uninitialized again. */
 	for (pfn = start_pfn; pfn < end_pfn; pfn += cur_nr_pages) {
 		cond_resched();
@@ -563,8 +573,6 @@ void remove_pfn_range_from_zone(struct zone *zone,
 	if (zone_is_zone_device(zone))
 		return;
 
-	clear_zone_contiguous(zone);
-
 	shrink_zone_span(zone, start_pfn, start_pfn + nr_pages);
 	update_pgdat_span(pgdat);
 
@@ -1783,6 +1791,8 @@ bool mhp_range_allowed(u64 start, u64 size, bool need_mapping)
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 
+DEFINE_SRCU_FAST(pfn_walk_srcu);
+
 static int check_no_memblock_for_node_cb(struct memory_block *mem, void *arg)
 {
 	int nid = *(int *)arg;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 01ced0553ce9b..db610ddc37398 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2270,8 +2270,8 @@ void set_zone_contiguous(struct zone *zone)
 		cond_resched();
 	}
 
-	/* We confirm that there is no hole */
-	zone->contiguous = true;
+	/* We confirm that there is no hole; pairs with pageblock_pfn_to_page() */
+	smp_store_release(&zone->contiguous, true);
 }
 
 /*
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 53df6b8a0c00a..7e185326b80ab 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -216,7 +216,12 @@ extern struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
 				unsigned long end_pfn, struct zone *zone)
 {
-	if (zone->contiguous)
+	/*
+	 * Offline can shrink the zone under a caller's old pfns and then set
+	 * zone->contiguous again, so only trust it inside the current span.
+	 */
+	if (smp_load_acquire(&zone->contiguous) &&
+	    zone_spans_pfn(zone, start_pfn) && zone_spans_pfn(zone, end_pfn - 1))
 		return pfn_to_page(start_pfn);
 
 	return __pageblock_pfn_to_page(start_pfn, end_pfn, zone);
-- 
2.53.0-Meta

