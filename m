Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33940A92F;
	Mon, 21 Sep 2026 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020865; cv=none; b=PT+vC7MRQa5908CHgpMxlsvUvInSTVjIceAaMCKdPOUgLZIoyFHw34mfkctQud7w82RQW7Q3G0Lt+mQvTRQ8nc2Aeya3i3usoErcLJaSXvG7puuw+M2RyQYxeqZVU30Q0pZHUKvoX2iroOwArewpPmjBlvt8SRBI3mjpJ4h5i3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020865; c=relaxed/simple;
	bh=N/9OGvGMP2oKAsMrqGIIPnQ4ai1EtHZkGHyygVZ1Lq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kro4mv0/U3sestdKem8IDkhGaGNGTFaBy0JgiY42wSd7IkTf658R/zaWms80pDudEukuVWUkmQW/nGh/+HY/4500TwS58EWiH7D1Pa5CJ6g1FJmUNBi+zX3skfTq7yctUHyJfwkhO0RgoAzqVmOicHVFkj44HvigYeKrzZA8JPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFShNioD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFShNioD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B47B1F00893;
	Mon, 21 Sep 2026 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020863;
	bh=aiW8jMRF7trBH5bkli+MjzrubVcAAqfTiLF5O9WVvhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hFShNioD8FIHUBPTTlNed6+nGMGaxBGmHT701pV1AkxSTAInddj9jcXHuknAJ0deb
	 6JuE2m9tfJWf5ihrXLNXTWSEHvC2cszDBZTxb2nIFwrYxYkvlK7m9UqPnzYL4ayK/t
	 Fh0m6UZRYqyG+3dX+gPfFwAHAyuRwgX1rEO6YBGdhm+mI2v3UkJ17xFc9fW+TaHA0k
	 RB9EYsX0YuIorA6ooaYUbo6VOTusScsUhryPOHvdGP/JhHONA0X0ffZnaJVSVD9cbR
	 vnWRVzyaZIykdCwmzyk4JITq446R74sw2TBVaH3rqtV76s2D45yyraFtH75Z6CQT9i
	 +JwyHF+JB69ww==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:59:03 +0200
Subject: [PATCH v2 11/13] mm/sparse: remove flags parameter from
 sparse_init_one_section()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-11-54d81d65e125@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2374; i=david@kernel.org;
 h=from:subject:message-id; bh=N/9OGvGMP2oKAsMrqGIIPnQ4ai1EtHZkGHyygVZ1Lq0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rRVJuerKQhvSQ5K9nXfHddWu1pWMzTxl6nqfN8+l
 5vi82d2lLIwiHEwyIopsgQF3zd4+XJdbbUbHzPMHFYmkCEMXJwCMBHZpQz//ZMUuHVl2K782c6X
 87fzp5JdmMLqktLzX6et//ih8IkZF8M/Xd/5f47OXtuteNeld9+f6otJXc6qkpr+umKa+mZcW17
 yAwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

The last user of the flags parameter that used to pass SECTION_IS_EARLY
was removed, so let's remove the parameter.

Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse-vmemmap.c | 2 +-
 mm/sparse.c         | 2 +-
 mm/sparse.h         | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f0db433e0f10b..3267f9362c68b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -869,7 +869,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	/* Align memmap to section boundary in the subsection case */
 	if (section_nr_to_pfn(section_nr) != start_pfn)
 		memmap = pfn_to_page(section_nr_to_pfn(section_nr));
-	sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
+	sparse_init_one_section(ms, section_nr, memmap, ms->usage);
 
 	return 0;
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 5d2d9f95d4024..702904b417006 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -243,7 +243,7 @@ static void __init sparse_metadata_init_nid(int nid,
 			      section_nr);
 		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
 		sparse_init_one_section(__nr_to_section(section_nr), section_nr,
-					mem_map, usage, 0);
+					mem_map, usage);
 		usage = (void *)usage + mem_section_usage_size();
 	}
 }
diff --git a/mm/sparse.h b/mm/sparse.h
index 19664d702af84..fdbc4cacf91d1 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -21,7 +21,7 @@ int sparse_index_init(unsigned long section_nr, int nid);
 
 static inline void sparse_init_one_section(struct mem_section *ms,
 		unsigned long section_nr, struct page *mem_map,
-		struct mem_section_usage *usage, unsigned long flags)
+		struct mem_section_usage *usage)
 {
 	unsigned long coded_mem_map;
 
@@ -37,8 +37,7 @@ static inline void sparse_init_one_section(struct mem_section *ms,
 	VM_WARN_ON_ONCE(coded_mem_map & ~SECTION_MAP_MASK);
 
 	ms->section_mem_map &= ~SECTION_MAP_MASK;
-	ms->section_mem_map |= coded_mem_map;
-	ms->section_mem_map |= flags | SECTION_HAS_MEM_MAP;
+	ms->section_mem_map |= coded_mem_map | SECTION_HAS_MEM_MAP;
 	ms->usage = usage;
 }
 

-- 
2.43.0

