Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DC255F2C;
	Sat, 11 Jul 2026 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782884; cv=none; b=bh+s+7mtgFiS+MmlUS2U14/HFBHSnDF9hF/txoDPpGsTBHvG801RvbdiLpQnVhzZrqU3o5Kfxlz3Gq8Ged7qnWJ/roJ4zFQ0aTEA/L4T9NJVPg2n0xMSTcy/mwq5wdFLK4nAJT9HUr/dYZItU9WBDlj/OedW3/BamNXdBChctxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782884; c=relaxed/simple;
	bh=i7akukZptPtk6aiifFjpyemsrleSwGrcBxhA0yKHCB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K62anKIGxJmvI506Ca0UDNkxaJKFlnBi3kGLAy/rO1nQ11nf6QLZ6LtbSkX9MdNKorQWBfaQtYaDaHio2+dwIR0egI59z9dbblWkHybqNshcTd2PA65BchjwpBxEgVJBb5T7vPk98BTQzxvSaqMyi4RkyR2y8GAYNNpaXtKjd4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMIBSAEC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMIBSAEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDD31F000E9;
	Sat, 11 Jul 2026 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783782882;
	bh=+i9jhfHQV1VkWghZMio3vOJdKYg4IgTadReMoiZhHKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mMIBSAECnhdy980IyBb6poTmknYhaPSfK+ERRvz+wMgwMhwfBBfGPp5OyPotggFer
	 44sbv97BGTlcIlDx1I6rhtltZ7E6DNeTIiK07sVyDjMrsDoF8s0yfAwRTsknH30Tnt
	 SZFL7ajAvWYKXpHgRCUgaZGuTbVyQS4bAihgZTW8i26DJiGdrFs9l/XP0rhPNxfosV
	 IHCM5oTlAifUgFaBvO+VX6JmSegFMXquTJ39DLYNt4u+946/8eQ888SPigdAX2oZAy
	 M/kypSWCYukINHsPihbEqHqtnHfYsjfQ7c1aoAfwx4w1YEoDCj3qI62hgwFw8ZvrYt
	 gsSYzcsaeMjcw==
Date: Sat, 11 Jul 2026 18:14:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Alexander Potapenko <glider@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Marco Elver <elver@google.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>,
	kasan-dev@googlegroups.com, kexec@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: split out mm_init and memblock declarations
 from internal.h
Message-ID: <alJd1BLypyK9Mpaw@kernel.org>
References: <20260709-internal-h-v2-0-695631425968@kernel.org>
 <20260709-internal-h-v2-1-695631425968@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-internal-h-v2-1-695631425968@kernel.org>

On Thu, Jul 09, 2026 at 01:00:03PM +0300, Mike Rapoport (Microsoft) wrote:
> mm/internal.h becomes more and more bloated.
> 
> Move declarations for related to mm/mm_init.c and mm/memblock.c to a new
> mm/mm_init.h header.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> ---
>  MAINTAINERS                        |   1 +
>  kernel/liveupdate/kexec_handover.c |   1 +
>  mm/cma.c                           |   1 +
>  mm/hugetlb.c                       |   1 +
>  mm/internal.h                      |  91 ----------------------------
>  mm/memblock.c                      |   1 +
>  mm/memory_hotplug.c                |   1 +
>  mm/mm_init.c                       |   1 +
>  mm/mm_init.h                       | 120 +++++++++++++++++++++++++++++++++++++
>  mm/page_alloc.c                    |   1 +
>  mm/sparse-vmemmap.c                |   1 +
>  mm/sparse.c                        |   1 +
>  12 files changed, 130 insertions(+), 91 deletions(-)

As always I forgot to update the memblock tests :(

Andrew, can you please merge this as a fixup:

From 4724f0868aa5ab6bc1c054d0be1cca2067533c22 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 11 Jul 2026 18:11:13 +0300
Subject: [PATCH] memblock tests: split stubfs from internal.h to mm_init.h

Following the split of declarations from mm/internal.h to mm/mm_init.h
update memblock tests to match the kernel core, otherwise they fail to
build.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 tools/testing/memblock/internal.h | 20 --------------------
 tools/testing/memblock/mm_init.h  | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/memblock/mm_init.h

diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index b6b1d147fd75..4168e646af09 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -28,22 +28,6 @@ static inline struct page *virt_to_page(void *virt)
 	return virt;
 }
 
-void memblock_free_pages(unsigned long pfn, unsigned int order)
-{
-}
-
-static inline void accept_memory(phys_addr_t start, unsigned long size)
-{
-}
-
-unsigned long free_reserved_area(void *start, void *end, int poison, const char *s);
-void free_reserved_page(struct page *page);
-
-static inline bool deferred_pages_enabled(void)
-{
-	return false;
-}
-
 #define for_each_valid_pfn(pfn, start_pfn, end_pfn)			 \
 	for ((pfn) = (start_pfn); (pfn) < (end_pfn); (pfn)++)
 
@@ -60,10 +44,6 @@ static inline bool __is_kernel(unsigned long addr)
 #define for_each_valid_pfn(pfn, start_pfn, end_pfn)                     \
        for ((pfn) = (start_pfn); (pfn) < (end_pfn); (pfn)++)
 
-static inline void init_deferred_page(unsigned long pfn, int nid)
-{
-}
-
 #define __SetPageReserved(p)	((void)(p))
 
 #endif
diff --git a/tools/testing/memblock/mm_init.h b/tools/testing/memblock/mm_init.h
new file mode 100644
index 000000000000..95bc5f2e8ed8
--- /dev/null
+++ b/tools/testing/memblock/mm_init.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __MM_MM_INIT_H
+#define __MM_MM_INIT_H
+
+void memblock_free_pages(unsigned long pfn, unsigned int order)
+{
+}
+
+static inline void accept_memory(phys_addr_t start, unsigned long size)
+{
+}
+
+unsigned long free_reserved_area(void *start, void *end, int poison, const char *s);
+void free_reserved_page(struct page *page);
+
+static inline bool deferred_pages_enabled(void)
+{
+	return false;
+}
+
+static inline void init_deferred_page(unsigned long pfn, int nid)
+{
+}
+#endif /* __MM_MM_INIT_H */
-- 
2.53.0


-- 
Sincerely yours,
Mike.
