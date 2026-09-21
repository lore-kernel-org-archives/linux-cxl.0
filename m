Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F350840BCB8;
	Mon, 21 Sep 2026 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020779; cv=none; b=EaYZmXHGyCVdUzJ1+WsuripUKVUgwEPLbR7zAeBqP3bk3l9wjzyYi8IMVQe7+SbPVKil6RBDNeVcdPsDKEbg0GevyJVg/NcY7ZCnfuYc6HlhGqa3XUyG4SsciR5QX0YXp8J5Wgp09T3w5X+KIFbBxdIkgTo++CSc8RxQYnkC4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020779; c=relaxed/simple;
	bh=sr/2UUrbiIspfv3UAleZAwxwTqvNNou3addI+WKCBYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udkir6QQ2TAp2aFUU6VU79x1GGkSIg/R4DIXc/q4YGYoITOKXrGJh5WIruQ7QtgoUynkNUlkwbOfSWix30m1J5Ok4K8R4jsM4AA7X5YRmAH1hphax0LdgecnmSb0sz4riEJJKGs3eqCRr5M8x+tJZs5D6tPpjtp6TjyC74mJAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gue45uXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gue45uXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809E21F00899;
	Mon, 21 Sep 2026 19:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020773;
	bh=znuq93Je+7pg29stX/zTy75KNbIkjx5/fhMhp4Iv7CM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Gue45uXDlrtsZghs401ZxlvxAFCmKJrKoIl9vhZ6icV0q7WVvfPCHPvy2WCC8yGKx
	 zp+4o8cJXp3NUMtGILz2Um8/Zk5qYS79fV/7v9IEc88LdsMMJnDdjUCqDwNCT+QrId
	 vssN0OshCSc8ydk1Hu+XjoTisNJffkwsomYb8b82J8+2Kx9R2z+anPC9f53PPHBzQE
	 SgSXFYAxitEU2ZO+tm8zMQYwKmz7g0JPJw/VjspV3LnNsdAYikWF4QyPwzbJieyLPA
	 ZPcaV3xjpNoz4dlsRb1tWJLzC7q3u7jQ8lfJnQsgubv0ckAHHFAJS2z3dulC9y+km+
	 Jruri0AeIi6yg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:58:54 +0200
Subject: [PATCH v2 02/13] mm/sparse: refactor sparse_sections_init()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-2-54d81d65e125@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850; i=david@kernel.org;
 h=from:subject:message-id; bh=sr/2UUrbiIspfv3UAleZAwxwTqvNNou3addI+WKCBYU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rTqtW/P/ZulHPP1677Qrv9fnx+6quA1dRrfxuUGW
 yLfyqpO7yhlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiH9oY/iepyPyyzjMsnin9
 sZChKnYDk/IUzjs1kx/N2+usW/97Zi7Db/bbvs8nnVjFomnkv+3TG/bJ8XM/X+75vi7vq0q/ZvQ
 eZj4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

memory_present() really identifies+prepares all early sections so the
initialization in sparse_init() can properly iterating them to
initialize metadata.

Let's just inline memory_present() into sparse_sections_init() and
cleaning up the code a bit while at it: make it clear that we are operating
on pfns.

Note that we call set_section_nid() now only if the section
was not already created earlier. Now, there is no more inconsistency
between what we (temporarily) store in ms->section_mem_map and what
we store in our section->nid array.

Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 8cd2b06b231ac..2b285653abf1e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -179,40 +179,33 @@ static inline unsigned long first_present_section_nr(void)
 	return next_present_section_nr(-1);
 }
 
-/* Record a memory area against a node. */
-static void __init memory_present(int nid, unsigned long start, unsigned long end)
+void __init sparse_sections_init(void)
 {
-	unsigned long pfn;
+	unsigned long pfn, start_pfn, end_pfn;
+	int i, nid;
+
+	sparse_extreme_init();
 
-	start &= PAGE_SECTION_MASK;
-	mminit_validate_memmodel_limits(&start, &end);
-	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
-		unsigned long section_nr = pfn_to_section_nr(pfn);
-		struct mem_section *ms;
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+		start_pfn &= PAGE_SECTION_MASK;
+		mminit_validate_memmodel_limits(&start_pfn, &end_pfn);
 
-		sparse_index_init(section_nr, nid);
-		set_section_nid(section_nr, nid);
+		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+			unsigned long section_nr = pfn_to_section_nr(pfn);
+			struct mem_section *ms;
 
-		ms = __nr_to_section(section_nr);
-		if (!ms->section_mem_map) {
+			sparse_index_init(section_nr, nid);
+			ms = __nr_to_section(section_nr);
+			if (ms->section_mem_map)
+				continue;
+
+			set_section_nid(section_nr, nid);
 			ms->section_mem_map = sparse_encode_early_nid(nid) |
 							SECTION_IS_ONLINE;
 			__section_mark_present(ms, section_nr);
 		}
 	}
 }
-
-void __init sparse_sections_init(void)
-{
-	unsigned long start, end;
-	int i, nid;
-
-	sparse_extreme_init();
-
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
-		memory_present(nid, start, end);
-}
-
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
 struct page __init *__populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,

-- 
2.43.0

