Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412E3E95BD
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720641; cv=none; b=oqJntZrNz6HBwrv9iXKaCr7XMFFCJMDvZ+oIBEdIWAPhYfx1iUuLvP1BfnzMFK6BmprXexKKMqfJKyBSOcf1UFsWxvcV3LY2oW+MK5LgTKMwX6C0mG7cRbjz6byAzMKaU+LQmRqGlFrqtxiHlOdOn0dlS0kmICho7tXXjCK1XzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720641; c=relaxed/simple;
	bh=+LByNfskc+x8hqHIhkCSzUPCEP23i5n6yTX+LXEdGyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V4P28FnohrKagscr5nIEq4CYMLi0X+GYxJ6KVtNUNrMs+eQeDX3LMHqGZbMXWUNC9b+/UnpbUrz2FL/ffsTiV783anuq/R3sHpVyo6RhLnasm/Wh3/gXoDgSciZfdXza0DrRBm7BpK+NeyepDsRB7FmKjB95T1uimt1vU1oQG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMX/5Qza; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMX/5Qza"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782720636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YfZ+eLRL94nE3BApW8xdPyWC54V3q52Zz68GpVEJjh8=;
	b=MMX/5QzauUULnhcGIrhD7j33jyswOE5J62VVZL3qcdOIcs6YIkJpOKtZRBcEq5bfIiIBo6
	wsaOXfuPudxpiTnr6mWIw1cc/RlHzZiHCvbxiY18Ms5Po3ryr+6DRzfdkqjQWmrKaPBwq3
	lz/oF/vmTVRKNJuNq83YjonUEO8PsvU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-475u1tAANz2f9edRMa_Ftw-1; Mon, 29 Jun 2026 04:10:35 -0400
X-MC-Unique: 475u1tAANz2f9edRMa_Ftw-1
X-Mimecast-MFC-AGG-ID: 475u1tAANz2f9edRMa_Ftw_1782720634
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37c9127e316so2023510a91.1
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 01:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782720634; x=1783325434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfZ+eLRL94nE3BApW8xdPyWC54V3q52Zz68GpVEJjh8=;
        b=CBKxfv/rrxv86M3Mpdf57QF8k+RXcxvTTvavQKN+pvEJi51rumsy233qde6Wge9H4j
         NhTvvHGq4CIeJM1AtjEGoQy1lcHSihl7KBsXOvZJMEFbYSsMqDqP1xLYpd3ICc5PHGhu
         dtJfVkLPJ811TXKi1Q6xFS03x74Y5V+4utt+0SS4uxLsbqfecab/GcogQGwv9b4TYHiv
         2EWoiFgQZHz4HM64gqaDQyqDbZ3wy6Z0dqN+T606chUJpqy1wjJv1Vim68EGk+X3rnmg
         wY6Qn7W2UzadRClDS682bAnpzoNW02t7MkR/0pUC5hPhin0OpB/kqU6ZxF9vu13hdy6i
         3XTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJYxifTDClFmu0y5zDQ2aH+Bv/KxuJORKxHjhMUw2DPYVmgkrhOFTpVAZAD3u7kJicSL9Tf1spX3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQwhGCsu7vG5h3a1qMOqUqnmRy6EWFbGt0cd4qjdUqwYk8sYbj
	j2YOqa1U8D0fjIDnb+s1pN7wdtLfnEyMQY5ub/7XUiuYQ3EUnExVf7YShdMc4EP9A6ek+8cjSay
	U4cYxbRlHfdueXyPoKP+0o3y4Z8MNKibyT7QQiV4k1jKGXVR5pbHD1q8FN+X9KQ==
X-Gm-Gg: AfdE7cmWW+kUQsfoU8LU7Y/W2ejTIXcGTT/KbyWEwk/TD4nMoiUY1CFg7gtbvxosB6G
	4lqVqlbI9WyOSy4g/PZLTJubBI2wFZ7kXcEB6L9qha+xC6NiH5O/JQBiiQ5GLH7UhCAHaxV9lkT
	E2lDN3d1Y5vx0bFyqQZbxK9DgextXxAYWpJ7Pk9Y5wInzhNdpbBz7CNvTji6Ajq/6VCBEc9n91L
	WyutxXbi7SxpMbfvQsBuOjamziCQIAr+iIYXPphTthyC5NrmovierDrB9f09ZSoarTxhImJd4fw
	kfiBRV+3Hl8kgloxWwgGfz5Ic+DiOdWq0FCNyjKWzomwOYOhX0DzoQdTVgIJDQB0QHPM2K6RUbs
	giDB3DRgMpLJtGDU4UxzdsSbwyVPT/bmG
X-Received: by 2002:a17:90b:1a8b:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-37df9d55f51mr14591055a91.0.1782720633635;
        Mon, 29 Jun 2026 01:10:33 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8b:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-37df9d55f51mr14591002a91.0.1782720633020;
        Mon, 29 Jun 2026 01:10:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37ec8b2fea5sm2343101a91.0.2026.06.29.01.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:10:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 04:10:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
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
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <20260629033608-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <akHUboUaYi-OJHFu@firstfloor.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <akHUboUaYi-OJHFu@firstfloor.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XRgnvIgWC0QwaCr8c5_4D20YiHPYy16yWyI_oZjMzqA_1782720634
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 28, 2026 at 07:11:58PM -0700, Andi Kleen wrote:
> On Sun, Jun 28, 2026 at 05:45:22PM -0400, Michael S. Tsirkin wrote:
> > This series fixes the race by:
> > 
> > 1. Having memory_failure() call synchronize_rcu() + retry after
> >    setting HWPoison, so that any in-flight non-atomic RMW that
> >    read the old flags value completes before we proceed.
> >
> > 2. Wrapping all non-atomic page flag operations in
> >    rcu_read_lock/rcu_read_unlock (CONFIG_MEMORY_FAILURE only),
> >    so that synchronize_rcu() actually drains them.
> 
> It wouldn't surprise me if your underlying performance assumptions 
> -- an non contended atomic is cheaper than a rcu_read_lock/unlock --
> are not true in various CPU/kernel configuration combinations.
> 
> Modern CPUs have fast atomics when uncontended in normal circumstances.
> But it probably doesn't matter much either way because the difference
> shouldn't be very much.


Hmm. It's a bit silly that I didn't try. Seemed clear to me, but,
on this old xeon...

                                   insns/iter    cycles/iter
     -------------------------------------------------------
       base                       12238 +/- 1.0    17889 +/- 97.9
       rcu_read_lock              12251 +/- 7.3    17991 +/-191.6
       atomic ops                 12233 +/- 1.9    17733 +/-136.5


The diff in the noise.

And old, slow CPUs maybe don't have MF at all.

So maybe just atomics instead of all this mess.




>  It seems very complicated for something that
> could be much simpler.
> 
> But I guess it's fine.
> 
> -Andi

Indeed. David already said he's gonnu look at this himself, but here's what I
tested, maybe helpful for whoever wants to try this approach:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7223f6f4e2b4..8f0940cf2f29 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -404,6 +404,44 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
 #define FOLIO_HEAD_PAGE		0
 #define FOLIO_SECOND_PAGE	1
 
+/*
+ * When CONFIG_MEMORY_FAILURE is enabled, non-atomic page flag operations
+ * must be atomic to prevent clobbering concurrent TestSetPageHWPoison()
+ * in memory_failure().  Otherwise, use the cheaper non-atomic versions.
+ */
+#ifdef CONFIG_MEMORY_FAILURE
+#define __pf_set_bit		set_bit
+#define __pf_clear_bit		clear_bit
+
+static __always_inline void page_flags_clear(unsigned long *flags,
+					     unsigned long mask)
+{
+	atomic_long_andnot(mask, (atomic_long_t *)flags);
+}
+
+static __always_inline void page_flags_set(unsigned long *flags,
+					   unsigned long mask)
+{
+	atomic_long_or(mask, (atomic_long_t *)flags);
+}
+
+#else /* !CONFIG_MEMORY_FAILURE */
+#define __pf_set_bit		__set_bit
+#define __pf_clear_bit		__clear_bit
+
+static __always_inline void page_flags_clear(unsigned long *flags,
+					     unsigned long mask)
+{
+	*flags &= ~mask;
+}
+
+static __always_inline void page_flags_set(unsigned long *flags,
+					   unsigned long mask)
+{
+	*flags |= mask;
+}
+#endif /* CONFIG_MEMORY_FAILURE */
+
 /*
  * Macros to create function definitions for page flags
  */
@@ -421,11 +459,11 @@ static __always_inline void folio_clear_##name(struct folio *folio)	\
 
 #define __FOLIO_SET_FLAG(name, page)					\
 static __always_inline void __folio_set_##name(struct folio *folio)	\
-{ __set_bit(PG_##name, folio_flags(folio, page)); }
+{ __pf_set_bit(PG_##name, folio_flags(folio, page)); }
 
 #define __FOLIO_CLEAR_FLAG(name, page)					\
 static __always_inline void __folio_clear_##name(struct folio *folio)	\
-{ __clear_bit(PG_##name, folio_flags(folio, page)); }
+{ __pf_clear_bit(PG_##name, folio_flags(folio, page)); }
 
 #define FOLIO_TEST_SET_FLAG(name, page)					\
 static __always_inline bool folio_test_set_##name(struct folio *folio)	\
@@ -458,12 +496,12 @@ static __always_inline void ClearPage##uname(struct page *page)		\
 #define __SETPAGEFLAG(uname, lname, policy)				\
 __FOLIO_SET_FLAG(lname, FOLIO_##policy)					\
 static __always_inline void __SetPage##uname(struct page *page)		\
-{ __set_bit(PG_##lname, &policy(page, 1)->flags.f); }
+{ __pf_set_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
 __FOLIO_CLEAR_FLAG(lname, FOLIO_##policy)				\
 static __always_inline void __ClearPage##uname(struct page *page)	\
-{ __clear_bit(PG_##lname, &policy(page, 1)->flags.f); }
+{ __pf_clear_bit(PG_##lname, &policy(page, 1)->flags.f); }
 
 #define TESTSETFLAG(uname, lname, policy)				\
 FOLIO_TEST_SET_FLAG(lname, FOLIO_##policy)				\
@@ -806,7 +844,7 @@ static inline bool PageUptodate(const struct page *page)
 static __always_inline void __folio_mark_uptodate(struct folio *folio)
 {
 	smp_wmb();
-	__set_bit(PG_uptodate, folio_flags(folio, 0));
+	__pf_set_bit(PG_uptodate, folio_flags(folio, 0));
 }
 
 static __always_inline void folio_mark_uptodate(struct folio *folio)
@@ -1162,14 +1200,14 @@ static __always_inline void ClearPageAnonExclusive(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(!PageAnonNotKsm(page), page);
 	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
-	clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags.f);
+	__pf_clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags.f);
 }
 
 static __always_inline void __ClearPageAnonExclusive(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
 	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
-	__clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags.f);
+	__pf_clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags.f);
 }
 
 #ifdef CONFIG_MMU
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 06bbe9eba636..931dfc84319f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2343,7 +2343,7 @@ int folio_xchg_last_cpupid(struct folio *folio, int cpupid);
 
 static inline void page_cpupid_reset_last(struct page *page)
 {
-	page->flags.f |= LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT;
+	page_flags_set(&page->flags.f, LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT);
 }
 #endif /* LAST_CPUPID_NOT_IN_PAGE_FLAGS */
 
@@ -2503,8 +2503,8 @@ static inline struct zone *folio_zone(const struct folio *folio)
 #ifdef SECTION_IN_PAGE_FLAGS
 static inline void set_page_section(struct page *page, unsigned long section)
 {
-	page->flags.f &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
-	page->flags.f |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+	page_flags_clear(&page->flags.f, SECTIONS_MASK << SECTIONS_PGSHIFT);
+	page_flags_set(&page->flags.f, (section & SECTIONS_MASK) << SECTIONS_PGSHIFT);
 }
 
 static inline unsigned long memdesc_section(memdesc_flags_t mdf)
@@ -2719,14 +2719,14 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 
 static inline void set_page_zone(struct page *page, enum zone_type zone)
 {
-	page->flags.f &= ~(ZONES_MASK << ZONES_PGSHIFT);
-	page->flags.f |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
+	page_flags_clear(&page->flags.f, ZONES_MASK << ZONES_PGSHIFT);
+	page_flags_set(&page->flags.f, (zone & ZONES_MASK) << ZONES_PGSHIFT);
 }
 
 static inline void set_page_node(struct page *page, unsigned long node)
 {
-	page->flags.f &= ~(NODES_MASK << NODES_PGSHIFT);
-	page->flags.f |= (node & NODES_MASK) << NODES_PGSHIFT;
+	page_flags_clear(&page->flags.f, NODES_MASK << NODES_PGSHIFT);
+	page_flags_set(&page->flags.f, (node & NODES_MASK) << NODES_PGSHIFT);
 }
 
 static inline void set_page_links(struct page *page, enum zone_type zone,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..100226f59490 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3624,8 +3624,8 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 * unreferenced sub-pages of an anonymous THP: we can simply drop
 		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
 		 */
-		new_folio->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
-		new_folio->flags.f |= (folio->flags.f &
+		page_flags_clear(&new_folio->flags.f, PAGE_FLAGS_CHECK_AT_PREP);
+		page_flags_set(&new_folio->flags.f, folio->flags.f &
 				((1L << PG_referenced) |
 				 (1L << PG_swapbacked) |
 				 (1L << PG_swapcache) |
diff --git a/mm/memremap.c b/mm/memremap.c
index 053842d45cb1..194ca2f04a87 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -494,7 +494,7 @@ void zone_device_page_init(struct page *page, struct dev_pagemap *pgmap,
 		 * blindly clear bits which could have set my order field here,
 		 * including page head.
 		 */
-		new_page->flags.f &= ~0xffUL;	/* Clear possible order, page head */
+		page_flags_clear(&new_page->flags.f, 0xffUL);	/* Clear possible order, page head */
 
 #ifdef NR_PAGES_IN_LARGE_FOLIO
 		/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d49c254174da..a3447124a725 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1359,7 +1359,7 @@ __always_inline bool __free_pages_prepare(struct page *page,
 		int i;
 
 		if (compound) {
-			page[1].flags.f &= ~PAGE_FLAGS_SECOND;
+			page_flags_clear(&page[1].flags.f, PAGE_FLAGS_SECOND);
 #ifdef NR_PAGES_IN_LARGE_FOLIO
 			folio->_nr_pages = 0;
 #endif
@@ -1373,7 +1373,7 @@ __always_inline bool __free_pages_prepare(struct page *page,
 					continue;
 				}
 			}
-			(page + i)->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+			page_flags_clear(&(page + i)->flags.f, PAGE_FLAGS_CHECK_AT_PREP);
 		}
 	}
 	if (folio_test_anon(folio)) {
@@ -1392,7 +1392,7 @@ __always_inline bool __free_pages_prepare(struct page *page,
 	}
 
 	page_cpupid_reset_last(page);
-	page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page_flags_clear(&page->flags.f, PAGE_FLAGS_CHECK_AT_PREP);
 	page->private = 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
diff --git a/mm/slub.c b/mm/slub.c
index a2bf3756ca7d..a55199f642d3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -617,7 +617,7 @@ static inline void slab_set_pfmemalloc(struct slab *slab)
 
 static inline void __slab_clear_pfmemalloc(struct slab *slab)
 {
-	__clear_bit(SL_pfmemalloc, &slab->flags.f);
+	__pf_clear_bit(SL_pfmemalloc, &slab->flags.f);
 }
 
 /*

