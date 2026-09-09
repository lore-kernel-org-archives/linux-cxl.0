Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848745678D9;
	Wed,  9 Sep 2026 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960909; cv=none; b=YBq8qjm9p/wncqh7Tv+V7j2fYBjr4Y98JSmg8ltT+szUpUcvOL/CBtPMfZoj7T/u29UIqkDkFZSKwOvayOVwWK6DhKaT8TRkKWrpvcOuEaveuErpZ/YkAOIjczdGJIG8+6v1/L5qA4ujRbTT76Xs4DfJby+hBf9OK/xnGbSQc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960909; c=relaxed/simple;
	bh=ifd00cyRI1HuxOcc2xxWxJxbUrmoY4ieu/5tTBcNKZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRBk3AFBF35H6NhZKVPrWmx/BNBB1afizFFT37xqGvQALLZVSg3DuO7lmtO9PtNWIhhLkXllLR41oZnLqPn1BVg2dz6/muly6L2bvAzEJdfxaro3qNzvFjZuXMPtAQdcS1fws/JzYHZ8Eus/6jFoVyX4vU95I59IAhU+gKDAaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUrQET7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUrQET7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FCA1F00A3D;
	Wed,  9 Sep 2026 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960908;
	bh=L2v3o67HNQ9aSFqTXVM1jpMn5NU+1i04xE3R5tvtAw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JUrQET7Bpep1u4rw0MKmhd9cfkeICsEyAERFh9SEB3R3M+csy30qdNXfG/4GEdFoe
	 ylt75rtuHgs5B902EEQK9MUSQwl8Jvgpfu87L8ifQaEXVvj2lWEQ2sNq5st4BeYXO6
	 7AFVLyGoIDL0OR6RE1ecN3f0N7liMpHacZoQ20+8IP0J88ZyM2xcWbh3R8Ek+fVCrQ
	 /IOC4FEn+4dlR9VjLohiYugge0+bl+TbMqGUOgEt+goOdwybo2LG51/wecTCLBMqbX
	 UKc1z3AWRQcg9gA+oBnjs1wQEvXxuzHAsQJ5bIom6NyHIAfadkKPvZyItRyn/yduu5
	 x32FaRXVOo9OQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:33:01 +0200
Subject: [PATCH 08/12] mm/sparse: move __highest_used_section_nr handling
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2321; i=david@kernel.org;
 h=from:subject:message-id; bh=ifd00cyRI1HuxOcc2xxWxJxbUrmoY4ieu/5tTBcNKZc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJhj/9Ny1KDloarDGVa1TGt0r2+dIpR+efCbvRNIKL
 bfLL/nlOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZhI7jxGhvXvpFgXTC59Y6Tj
 FHXihcBi00OJWlFqnZdOrNI6IaKxpoSR4c/7iSYTvC+Glr0wsct6bm6/8hnnuY4O6bVr31hNFeG
 fygkA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's move it to sparse_init_one_section(). However, to keep early
boot processing working, we also have to initialize it in
sparse_sections_init().

Should we use READ_ONCE/WRITE_ONCE with __highest_used_section_nr?
Probably, something for another day.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 5 +++--
 mm/sparse.h | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 2b41ae36f20b8..2d0f2db34f4cf 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -177,7 +177,7 @@ static inline unsigned long first_present_section_nr(void)
 
 void __init sparse_sections_init(void)
 {
-	unsigned long pfn, start_pfn, end_pfn;
+	unsigned long pfn, start_pfn, end_pfn, section_nr;
 	int i, nid;
 
 	sparse_extreme_init();
@@ -187,9 +187,9 @@ void __init sparse_sections_init(void)
 		mminit_validate_memmodel_limits(&start_pfn, &end_pfn);
 
 		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-			unsigned long section_nr = pfn_to_section_nr(pfn);
 			struct mem_section *ms;
 
+			section_nr = pfn_to_section_nr(pfn);
 			sparse_index_init(section_nr, nid);
 			ms = __nr_to_section(section_nr);
 			if (ms->section_mem_map)
@@ -201,6 +201,7 @@ void __init sparse_sections_init(void)
 			__section_mark_present(ms, section_nr);
 		}
 	}
+	__highest_used_section_nr = section_nr;
 }
 
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
diff --git a/mm/sparse.h b/mm/sparse.h
index 7c5d82ceb7142..a3af4967fd5c5 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -97,6 +97,9 @@ static inline void sparse_init_one_section(struct mem_section *ms,
 
 	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
 
+	if (section_nr > __highest_used_section_nr)
+		__highest_used_section_nr = section_nr;
+
 	/*
 	 * We encode the start PFN of the section into the mem_map such that
 	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
@@ -114,9 +117,6 @@ static inline void sparse_init_one_section(struct mem_section *ms,
 static inline void __section_mark_present(struct mem_section *ms,
 		unsigned long section_nr)
 {
-	if (section_nr > __highest_used_section_nr)
-		__highest_used_section_nr = section_nr;
-
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
 

-- 
2.43.0

