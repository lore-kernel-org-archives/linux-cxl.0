Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B603F54D1;
	Tue, 17 Mar 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766671; cv=none; b=UHFHTwwMDijbEVwtYTIzaEDpEeT2WcXr2eRzrcodM3mv7Kmh664eDtJPm9Uoi5cZU2eDu0tKLV8VV4fWz7xmf8VMBS20WPED/qapJoC7mtJ01lH7bvTnxuuJm0jLlyzlDcn3zfNmOqGSHbSlJMLaIQZnNqOdyON9YTsAbSxfgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766671; c=relaxed/simple;
	bh=Bip5aS2Q/tCY3dJyBk4Fs5dKG63YEPL2XgTfzOnLk/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKWtgp+KSaWPjxc7QIvjhZ9Ze2a1Jt1XbJDUY+h6DCJf4OxxQeBfsJTi+b8DGRu45JCTSxLLRJVbgHFuotD++m01neKy5Gw+foGUHNyuQleyYuh3Z1A+HK17YAhIM3/ahAhK+Marq0VTXmo2cYrDDPDHUMD9qEBoUXwyH+SfDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFaMp8J3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFaMp8J3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7784CC2BCB3;
	Tue, 17 Mar 2026 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766671;
	bh=Bip5aS2Q/tCY3dJyBk4Fs5dKG63YEPL2XgTfzOnLk/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFaMp8J3h6JOzr7rbOeTOYOK/GYkvLK8VsApl75PUwJtmsISNYD4yXcM1jTlZtOyS
	 6QUsA6N4pt6A0vyltmwEuqpd0PVsjYB8DN+FfJE/RI1AEOUn746O2LL48LlOxm2jHi
	 LkEqSb2ywOlAiDfBzi9Px/MxwS6Lk8ofbJkl0CibC48PbNuFIeBjGnbDBjhxhYFJdL
	 dS7+rCrenGPGw1k1gzHlX9qyAutHDQfjbciY3bY9j8Yt/9XqHc456BsUvXjs7NUvSU
	 3Kke/jH0KX9ggRX+MNKpMGzCEbVEp/Us+6guRKZrJIs5QIkEXp+3oD39j8g5uPrQHn
	 L96mGSXBg5mBA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 12/14] mm/sparse: move sparse_init_one_section() to internal.h
Date: Tue, 17 Mar 2026 17:56:50 +0100
Message-ID: <20260317165652.99114-13-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317165652.99114-1-david@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While at it, convert the BUG_ON to a WARN_ON, avoid long lines, and merge
sparse_encode_mem_map() into sparse_init_one_section().

Clarify the comment a bit, pointing at page_to_pfn().

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mmzone.h |  2 +-
 mm/internal.h          | 22 ++++++++++++++++++++++
 mm/sparse.c            | 24 ------------------------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b694c69dee04..dcbbf36ed88c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2008,7 +2008,7 @@ struct mem_section {
 	/*
 	 * This is, logically, a pointer to an array of struct
 	 * pages.  However, it is stored with some other magic.
-	 * (see sparse.c::sparse_init_one_section())
+	 * (see sparse_init_one_section())
 	 *
 	 * Additionally during early boot we encode node id of
 	 * the location of the section here to guide allocation.
diff --git a/mm/internal.h b/mm/internal.h
index 5f5c45d80aca..bcf4df97b185 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -965,6 +965,28 @@ void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
  */
 #ifdef CONFIG_SPARSEMEM
 void sparse_init(void);
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
+	VM_WARN_ON(coded_mem_map & ~SECTION_MAP_MASK);
+
+	ms->section_mem_map &= ~SECTION_MAP_MASK;
+	ms->section_mem_map |= coded_mem_map;
+	ms->section_mem_map |= SECTION_HAS_MEM_MAP | flags;
+	ms->usage = usage;
+}
 #else
 static inline void sparse_init(void) {}
 #endif /* CONFIG_SPARSEMEM */
diff --git a/mm/sparse.c b/mm/sparse.c
index b5a2de43ac40..6f5f340301a3 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -256,30 +256,6 @@ static void __init memblocks_present(void)
 		memory_present(nid, start, end);
 }
 
-/*
- * Subtle, we encode the real pfn into the mem_map such that
- * the identity pfn - section_mem_map will return the actual
- * physical page frame number.
- */
-static unsigned long sparse_encode_mem_map(struct page *mem_map, unsigned long pnum)
-{
-	unsigned long coded_mem_map =
-		(unsigned long)(mem_map - (section_nr_to_pfn(pnum)));
-	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
-	BUG_ON(coded_mem_map & ~SECTION_MAP_MASK);
-	return coded_mem_map;
-}
-
-static void __meminit sparse_init_one_section(struct mem_section *ms,
-		unsigned long pnum, struct page *mem_map,
-		struct mem_section_usage *usage, unsigned long flags)
-{
-	ms->section_mem_map &= ~SECTION_MAP_MASK;
-	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum)
-		| SECTION_HAS_MEM_MAP | flags;
-	ms->usage = usage;
-}
-
 static unsigned long usemap_size(void)
 {
 	return BITS_TO_LONGS(SECTION_BLOCKFLAGS_BITS) * sizeof(unsigned long);
-- 
2.43.0

