Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B823B895D
	for <linux-cxl@vger.kernel.org>; Sun, 28 Jun 2026 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683144; cv=none; b=Z+cS4ofBIHPzkUfEH/+jxOdkgWugNCZL+Th13YUJuYoX5kHavnWAq2IIiPjj+1t49+Zkbp71hpdR5/HvZofhfCz8tElBRNOvU+qgl1oq7Esm+pw0Fi0xMk4hBxHEAKSr/nL5Kb3ylyFH90dyN8hYnTEjn83T5Vi4u13U895sJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683144; c=relaxed/simple;
	bh=5CwmCIIwBRF4rJtSkO3fSv7EygQhsTSRrEO6W+X+9sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pHZL3giWQ79iwaxe1Ipfa1BKkqAL1o5Xs9Q7lPHA0xUOmFCVt0Vxcy9HKEMgng7VVDhiULPlQb3A4jylwMXU0kevqjS6ifiZ2ZDq82RRxwGFSlnGwzTmsG+lolcoss1Px+e0bSFk9IOC+/YGrFxTisPqjnBZ6zRbC0bicg/HbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+ENvOwz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+ENvOwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782683141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O2PF+qcJ3m8N9rKs3G2/wBo9RivbDKiHiu3dT3I/elw=;
	b=E+ENvOwzwwUUMafu8CTREtaI9oKS2lE91NVC07mdf6HT5lt7gnT3UlUdcQS3f0D24njkwp
	J12jQ01Cf4KVleqbLcVFHHmCGZmGQ7LTcjopghu5tXcHeLHuQneb28rbntQ/2PAWlFPkr1
	W+7OB3xtETwkJ313qqb+iTMPobN1Epo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-OqHviVyfOpmHu38Rq3eESw-1; Sun, 28 Jun 2026 17:45:38 -0400
X-MC-Unique: OqHviVyfOpmHu38Rq3eESw-1
X-Mimecast-MFC-AGG-ID: OqHviVyfOpmHu38Rq3eESw_1782683137
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4740be00302so66893f8f.2
        for <linux-cxl@vger.kernel.org>; Sun, 28 Jun 2026 14:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683137; x=1783287937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2PF+qcJ3m8N9rKs3G2/wBo9RivbDKiHiu3dT3I/elw=;
        b=svnqQ/kOXfVH8qS/2UhSo1xVOY2x9Qn1ho2uFx9DNS1/MEdwCLVR4zY300kUoWCLka
         hKkyhTC4fzQlxTmqpi4vgCRQmIDBtQuvnAyfyGLUDrgU/eeBlPITvzA0STCrEOPQlzxq
         yaedsTsr+CsxsXSX2/1yQPmgl2sY8m1Cng/HCz5WgiM8ncKhZGllr1hPharWa+GWM9Mt
         RMI1ziusnAKwbw1POKAnaespjFG9Fg/wZbnB+owriic3dcX6Q+zHjOeEujq3DqNoT5PT
         zLG9B2vxiG0PTWbrWNRc45SezFaQ7C9gDOK9GUGuSMDWtQlErs968E3vZ0Ir26UxeTh9
         OTOA==
X-Forwarded-Encrypted: i=1; AHgh+RoMeriAFTha58OM2lx7cPN+KZGWlh3N7vq+z2FWxnxAA1I5qqNkGh2GJZFXMG887GbzsFRdAMVHkOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoe2W96OJFEFB2inWwLvTOF/2tVH/9Ggbi3u/Ooy+/FweR6M2J
	gPwPjZ8vuanLyjWpgXDhOPU9lt4ed0T5kzK/LeUC+cF897vr/lohEeaYcbgogz+VcPe49Gx0mLH
	3JhTgJWtT5DqbbHr7svh5W2fl+748ESD+Hkot1cacw2BM6bJr+/uEuUHumeySiw==
X-Gm-Gg: AfdE7cmmIPvPtUH0b28PKDapoTufdiPTEFWUJaInBuEWwBvlWzAsRQlGRiYC6R4W1tj
	hDtJi0MPh5q7QfFUtiALW8d9zC37aI3EAsGaSWXgi81SoKdbJBeW3KWUpgd5R/pZFpfkV/EIC0i
	pLgq5cGQQ2vEUBGkIhwhNBLmamPhSBgkcuIwpXY1QRqNVjG4t//bhtO60DjQSs+JgCtOAs9/Dzf
	V5nOwWsfEoCeTR+LsJA2h9PmhoahmAc7HIwdWi2Sbpg0FpS/5EBZyZC+VOAOpdGfvXUG7a8QbON
	7W2F4tUlaDNsaCMCs9CNyk1JfGNKcVaNIg3Kpv57C7k9cqA68pKB80Nvf1hq+4S0Glc6wJc2jKD
	Q
X-Received: by 2002:a05:6000:5c8:b0:472:8343:7f5b with SMTP id ffacd0b85a97d-472834380bcmr5815599f8f.17.1782683136878;
        Sun, 28 Jun 2026 14:45:36 -0700 (PDT)
X-Received: by 2002:a05:6000:5c8:b0:472:8343:7f5b with SMTP id ffacd0b85a97d-472834380bcmr5815569f8f.17.1782683136320;
        Sun, 28 Jun 2026 14:45:36 -0700 (PDT)
Received: from redhat.com ([31.187.78.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-473563c2df7sm5812233f8f.24.2026.06.28.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:45:35 -0700 (PDT)
Date: Sun, 28 Jun 2026 17:45:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 2/2] mm: wrap non-atomic page flag ops in RCU for HWPoison
 safety
Message-ID: <bc054e5b94ba75fd1c044eece47b8cf6a9fec75d.1782676497.git.mst@redhat.com>
References: <cover.1782676497.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1782676497.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GO_hclyv39MLVvNekB4Cge2UxIJ4HDc1mGDL7TVmZZQ_1782683137
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Wrap all non-atomic page flag operations in rcu_read_lock/rcu_read_unlock
so that synchronize_rcu() in memory_failure() can drain in-flight
callers.  This completes the RCU-based protection introduced in the
previous patch.

Add hwpoison_safe_set_bit/clear_bit wrappers in page-flags.h that
bracket __set_bit/__clear_bit with rcu_read_lock/rcu_read_unlock.
Convert all __SETPAGEFLAG/__CLEARPAGEFLAG macros and direct flag
manipulation sites (page_alloc.c, huge_memory.c, memremap.c,
mm_init.c, slub.c, mm.h) to use these wrappers.

For batched flag clearing paths (page_alloc.c order > 0), use
hwpoison_rcu_lock/unlock around the entire loop rather than
per-operation locking.

When !CONFIG_MEMORY_FAILURE, all wrappers compile to the bare
operations with no overhead.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Cursor:gpt-5.4-xhigh-fast
---
 include/linux/mm.h         |  7 ++++
 include/linux/page-flags.h | 81 +++++++++++++++++++++++++++++++++++---
 mm/huge_memory.c           |  2 +
 mm/memremap.c              |  6 ++-
 mm/mm_init.c               |  2 +
 mm/page_alloc.c            |  4 ++
 mm/slub.c                  |  2 +-
 7 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 06bbe9eba636..d52a5e90cad6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2341,6 +2341,7 @@ static inline int folio_last_cpupid(struct folio *folio)
 
 int folio_xchg_last_cpupid(struct folio *folio, int cpupid);
 
+/* Caller must hold hwpoison_rcu_lock() */
 static inline void page_cpupid_reset_last(struct page *page)
 {
 	page->flags.f |= LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT;
@@ -2503,8 +2504,10 @@ static inline struct zone *folio_zone(const struct folio *folio)
 #ifdef SECTION_IN_PAGE_FLAGS
 static inline void set_page_section(struct page *page, unsigned long section)
 {
+	hwpoison_rcu_lock_flags(&page->flags.f);
 	page->flags.f &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
 	page->flags.f |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+	hwpoison_rcu_unlock_flags(&page->flags.f);
 }
 
 static inline unsigned long memdesc_section(memdesc_flags_t mdf)
@@ -2719,14 +2722,18 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 
 static inline void set_page_zone(struct page *page, enum zone_type zone)
 {
+	hwpoison_rcu_lock_flags(&page->flags.f);
 	page->flags.f &= ~(ZONES_MASK << ZONES_PGSHIFT);
 	page->flags.f |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
+	hwpoison_rcu_unlock_flags(&page->flags.f);
 }
 
 static inline void set_page_node(struct page *page, unsigned long node)
 {
+	hwpoison_rcu_lock_flags(&page->flags.f);
 	page->flags.f &= ~(NODES_MASK << NODES_PGSHIFT);
 	page->flags.f |= (node & NODES_MASK) << NODES_PGSHIFT;
+	hwpoison_rcu_unlock_flags(&page->flags.f);
 }
 
 static inline void set_page_links(struct page *page, enum zone_type zone,
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7223f6f4e2b4..25eb5a77c92f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <linux/mmdebug.h>
+#include <linux/rcupdate.h>
 #ifndef __GENERATING_BOUNDS_H
 #include <linux/mm_types.h>
 #include <generated/bounds.h>
@@ -404,6 +405,68 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
 #define FOLIO_HEAD_PAGE		0
 #define FOLIO_SECOND_PAGE	1
 
+/*
+ * Non-atomic page flag operations (__set_bit, __clear_bit, flags &= ~mask)
+ * can race with atomic TestSetPageHWPoison() in memory_failure().
+ * Wrap non-atomic ops in rcu_read_lock/rcu_read_unlock so that
+ * synchronize_rcu() in memory_failure() drains in-flight callers.
+ */
+#ifdef CONFIG_MEMORY_FAILURE
+static __always_inline void
+hwpoison_safe_set_bit(unsigned long nr, unsigned long *addr)
+{
+	rcu_read_lock();
+	__set_bit(nr, addr);
+	rcu_read_unlock();
+}
+
+static __always_inline void
+hwpoison_safe_clear_bit(unsigned long nr, unsigned long *addr)
+{
+	rcu_read_lock();
+	__clear_bit(nr, addr);
+	rcu_read_unlock();
+}
+
+static __always_inline void hwpoison_rcu_lock_flags(unsigned long *addr)
+{
+	rcu_read_lock();
+}
+
+static __always_inline void hwpoison_rcu_unlock_flags(unsigned long *addr)
+{
+	rcu_read_unlock();
+}
+
+static __always_inline void hwpoison_rcu_lock(void)
+{
+	rcu_read_lock();
+}
+
+static __always_inline void hwpoison_rcu_unlock(void)
+{
+	rcu_read_unlock();
+}
+
+#else /* !CONFIG_MEMORY_FAILURE */
+static inline void
+hwpoison_safe_set_bit(unsigned long nr, unsigned long *addr)
+{
+	__set_bit(nr, addr);
+}
+
+static inline void
+hwpoison_safe_clear_bit(unsigned long nr, unsigned long *addr)
+{
+	__clear_bit(nr, addr);
+}
+
+static inline void hwpoison_rcu_lock_flags(unsigned long *addr) { }
+static inline void hwpoison_rcu_unlock_flags(unsigned long *addr) { }
+static inline void hwpoison_rcu_lock(void) { }
+static inline void hwpoison_rcu_unlock(void) { }
+#endif
+
 /*
  * Macros to create function definitions for page flags
  */
@@ -421,11 +484,11 @@ static __always_inline void folio_clear_##name(struct folio *folio)	\
 
 #define __FOLIO_SET_FLAG(name, page)					\
 static __always_inline void __folio_set_##name(struct folio *folio)	\
-{ __set_bit(PG_##name, folio_flags(folio, page)); }
+{ hwpoison_safe_set_bit(PG_##name, folio_flags(folio, page)); }
 
 #define __FOLIO_CLEAR_FLAG(name, page)					\
 static __always_inline void __folio_clear_##name(struct folio *folio)	\
-{ __clear_bit(PG_##name, folio_flags(folio, page)); }
+{ hwpoison_safe_clear_bit(PG_##name, folio_flags(folio, page)); }
 
 #define FOLIO_TEST_SET_FLAG(name, page)					\
 static __always_inline bool folio_test_set_##name(struct folio *folio)	\
@@ -458,12 +521,12 @@ static __always_inline void ClearPage##uname(struct page *page)		\
 #define __SETPAGEFLAG(uname, lname, policy)				\
 __FOLIO_SET_FLAG(lname, FOLIO_##policy)					\
 static __always_inline void __SetPage##uname(struct page *page)		\
-{ __set_bit(PG_##lname, &policy(page, 1)->flags.f); }
+{ hwpoison_safe_set_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
 __FOLIO_CLEAR_FLAG(lname, FOLIO_##policy)				\
 static __always_inline void __ClearPage##uname(struct page *page)	\
-{ __clear_bit(PG_##lname, &policy(page, 1)->flags.f); }
+{ hwpoison_safe_clear_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define TESTSETFLAG(uname, lname, policy)				\
 FOLIO_TEST_SET_FLAG(lname, FOLIO_##policy)				\
@@ -806,7 +869,7 @@ static inline bool PageUptodate(const struct page *page)
 static __always_inline void __folio_mark_uptodate(struct folio *folio)
 {
 	smp_wmb();
-	__set_bit(PG_uptodate, folio_flags(folio, 0));
+	hwpoison_safe_set_bit(PG_uptodate, folio_flags(folio, 0));
 }
 
 static __always_inline void folio_mark_uptodate(struct folio *folio)
@@ -1166,6 +1229,14 @@ static __always_inline void ClearPageAnonExclusive(struct page *page)
 }
 
 static __always_inline void __ClearPageAnonExclusive(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
+	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	hwpoison_safe_clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags.f);
+}
+
+/* Caller must hold hwpoison_rcu_lock() */
+static __always_inline void ___ClearPageAnonExclusive(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
 	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..99f600459964 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3624,6 +3624,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 * unreferenced sub-pages of an anonymous THP: we can simply drop
 		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
 		 */
+		hwpoison_rcu_lock_flags(&new_folio->flags.f);
 		new_folio->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		new_folio->flags.f |= (folio->flags.f &
 				((1L << PG_referenced) |
@@ -3643,6 +3644,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 #endif
 				 (1L << PG_dirty) |
 				 LRU_GEN_MASK | LRU_REFS_MASK));
+		hwpoison_rcu_unlock_flags(&new_folio->flags.f);
 
 		if (handle_hwpoison &&
 		    page_range_has_hwpoisoned(new_head, new_nr_pages))
diff --git a/mm/memremap.c b/mm/memremap.c
index 053842d45cb1..5c769dc4930c 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -425,8 +425,10 @@ void free_zone_device_folio(struct folio *folio)
 	mem_cgroup_uncharge(folio);
 
 	if (folio_test_anon(folio)) {
+		hwpoison_rcu_lock();
 		for (i = 0; i < nr; i++)
-			__ClearPageAnonExclusive(folio_page(folio, i));
+			___ClearPageAnonExclusive(folio_page(folio, i));
+		hwpoison_rcu_unlock();
 	}
 
 	/*
@@ -494,7 +496,9 @@ void zone_device_page_init(struct page *page, struct dev_pagemap *pgmap,
 		 * blindly clear bits which could have set my order field here,
 		 * including page head.
 		 */
+		hwpoison_rcu_lock_flags(&new_page->flags.f);
 		new_page->flags.f &= ~0xffUL;	/* Clear possible order, page head */
+		hwpoison_rcu_unlock_flags(&new_page->flags.f);
 
 #ifdef NR_PAGES_IN_LARGE_FOLIO
 		/*
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..881574dd14da 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -596,7 +596,9 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
 	atomic_set(&page->_mapcount, -1);
+	hwpoison_rcu_lock_flags(&page->flags.f);
 	page_cpupid_reset_last(page);
+	hwpoison_rcu_unlock_flags(&page->flags.f);
 	page_kasan_tag_reset(page);
 
 	INIT_LIST_HEAD(&page->lru);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d49c254174da..60a4697ecb9a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1358,6 +1358,7 @@ __always_inline bool __free_pages_prepare(struct page *page,
 	if (unlikely(order)) {
 		int i;
 
+		hwpoison_rcu_lock();
 		if (compound) {
 			page[1].flags.f &= ~PAGE_FLAGS_SECOND;
 #ifdef NR_PAGES_IN_LARGE_FOLIO
@@ -1375,6 +1376,7 @@ __always_inline bool __free_pages_prepare(struct page *page,
 			}
 			(page + i)->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
+		hwpoison_rcu_unlock();
 	}
 	if (folio_test_anon(folio)) {
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
@@ -1391,8 +1393,10 @@ __always_inline bool __free_pages_prepare(struct page *page,
 			return false;
 	}
 
+	hwpoison_rcu_lock_flags(&page->flags.f);
 	page_cpupid_reset_last(page);
 	page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	hwpoison_rcu_unlock_flags(&page->flags.f);
 	page->private = 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
diff --git a/mm/slub.c b/mm/slub.c
index a2bf3756ca7d..fdfb3019b562 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -617,7 +617,7 @@ static inline void slab_set_pfmemalloc(struct slab *slab)
 
 static inline void __slab_clear_pfmemalloc(struct slab *slab)
 {
-	__clear_bit(SL_pfmemalloc, &slab->flags.f);
+	hwpoison_safe_clear_bit(SL_pfmemalloc, &slab->flags.f);
 }
 
 /*
-- 
MST

