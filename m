Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C83C456B;
	Mon, 21 Sep 2026 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020764; cv=none; b=BP1vNRQlwfgjzGuZWk+LmFQ0PTPB0/xaM7zQiTnJVjHmjJ1kruyQaAisg3PmELjT6i18o81RxrggM9kvVCY7UJHbLhkTDnITZWBXBHKx7cuTBjKpgGIjrmuEFQdpwFW3aIT8YVOdvEQHAyBRWWJbLh0coi0jNCwOyUiGFKCxkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020764; c=relaxed/simple;
	bh=RDUKgR4Zh55foA1PVaXPqBWcOHxguZt1tds+dCAcB5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiiy013jrT7Z9UY2n/TRr2r4qcPtKspMLt7eJh9lJXvdH6T0b5tpsTPt4SBaULK1BsDQD7uCtYv9kszo8j3/s9BDRjZYxEVfYE2y21UAo4IqxA2xuqIEba0iwBqbTkCkyGcIj5Qi26PdG1CGI2AkxTxAHZxqLuUE0bjYEOHgN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goOJO+Ju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goOJO+Ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907511F00898;
	Mon, 21 Sep 2026 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020762;
	bh=f3OLDjTedsbgC3rcZhdOQN0X2zBug4ET6xkZFH6DZFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=goOJO+JucOQyVJhwBfpMh557Mt7X9EpUqiE/EPsXm4eYLVfpDHY4Sz7us7rwrdmnQ
	 Bfe9PXXPxI2rtkVy5TKC1kpPBhNLS0Dfks+8osZBKG+2uxCn93k+LsvLN55gPfnomd
	 4HcmAsTeQgH22E7n2fE/ONBJ6/4uD9CmmdAep74u34s6N+wXG4C7Wx7N0YyhxML3nn
	 nHXmHNHxzhBBZCOy63EBsxd4Sq90Vlm7Vfz/L/J2QJTZenlQBdgLulgN1JQQDYH3fP
	 U9RH3bGbIYac9um1zcYtRfW35E3dnGxbfY5n/IBwFi+RPzRAEMMBRrUOaGCqgxviVb
	 B2Z/oHF0sdVVg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:58:53 +0200
Subject: [PATCH v2 01/13] mm/sparse: move mem_section init to
 sparse_extreme_init()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-1-54d81d65e125@kernel.org>
References: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
In-Reply-To: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=david@kernel.org;
 h=from:subject:message-id; bh=RDUKgR4Zh55foA1PVaXPqBWcOHxguZt1tds+dCAcB5o=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rQqTbnO8DPl8RKB1sUK0hNk3s8y2fL9/Szpe6K7H
 Nadqok61FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEkvwY/kr/UXzOzb2/r9fs
 yu09Wm8rfa8/a+vamDFbU0OUfd+FlemMDP+jP+p8mDLpZB93zpJFEi3mBRu03Q1VzZ0Fj9xLrq4
 tZwIA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's just avoid another pair of ifdef inside a function. While at it,
switch to INTERNODE_CACHE_BYTES by just defining a fallback in cache.h
as well, given that the x86 variant already provides one.

Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/cache.h |  1 +
 mm/sparse.c           | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index e69768f50d532..b6e857b985bca 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -89,6 +89,7 @@
  */
 #ifndef INTERNODE_CACHE_SHIFT
 #define INTERNODE_CACHE_SHIFT L1_CACHE_SHIFT
+#define INTERNODE_CACHE_BYTES (1 << INTERNODE_CACHE_SHIFT)
 #endif
 
 #if !defined(____cacheline_internodealigned_in_smp)
diff --git a/mm/sparse.c b/mm/sparse.c
index b75921c622ede..8cd2b06b231ac 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -103,11 +103,22 @@ int __meminit sparse_index_init(unsigned long section_nr, int nid)
 
 	return 0;
 }
+
+static void __init sparse_extreme_init(void)
+{
+	const unsigned long size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
+
+	mem_section = memblock_alloc_or_panic(size, INTERNODE_CACHE_BYTES);
+}
 #else /* !SPARSEMEM_EXTREME */
 int __meminit sparse_index_init(unsigned long section_nr, int nid)
 {
 	return 0;
 }
+
+static void __init sparse_extreme_init(void)
+{
+}
 #endif
 
 /*
@@ -196,13 +207,7 @@ void __init sparse_sections_init(void)
 	unsigned long start, end;
 	int i, nid;
 
-#ifdef CONFIG_SPARSEMEM_EXTREME
-	unsigned long size, align;
-
-	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
-	align = 1 << (INTERNODE_CACHE_SHIFT);
-	mem_section = memblock_alloc_or_panic(size, align);
-#endif
+	sparse_extreme_init();
 
 	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
 		memory_present(nid, start, end);

-- 
2.43.0

