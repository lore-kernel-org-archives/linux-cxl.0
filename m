Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FD534454;
	Wed,  9 Sep 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960872; cv=none; b=su6VH0Qi/8OcxIsiXawK6rQD1wMX4PFlR86LNYJavrg+OOP2oirZv/l1bm46pKb78qsrm4+/PDPv+4q2o3Uy3qq7p/TnUHACn9vFPCFU7FcDOFOboegweYJZHUnG2MlQOMGBGfIsFvJoSmfj+rliPR+Ct6JG2bHf+ywjQ0YcQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960872; c=relaxed/simple;
	bh=22aLutJEtYm1F1P07TqVwcTSIGuZ5EPTXkGcwZd1Z9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RC/AMl1CDZpYtjze0T+yI/I4a0dtH8/tU5+mwLNt8lQ6z/7gnPrlt6VskhUfnEapww9GqPDdLLJD05YjWePprDaxvJGHTkIVRYklWihpLl3Cw2QbQ6UxpEgjF/ZSUQf2vJcqfSfx7mhSQ+zh11CimJqgGwQdQxc+YD0mgQ3JVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZelQ852V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZelQ852V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB38E1F00A3E;
	Wed,  9 Sep 2026 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960870;
	bh=EfFkM8TVdbGE2NG2Pg9PpUCdJifdmydrKyHEc/A5FNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZelQ852VoOuFMeQYlpa1x3hPLSEBcmbHr/anV1cxsUAXZbU4Q5UyYHEPxH4ih1+0P
	 izH9qgUZlMVymte2q3uRmLw9/JQiFCsNpX7U/MlzLkYBWu9shEbx5HPSH+KmfDlrTd
	 arhjR1E7ccoi14BBCfMhxmd2F85EApCvid29inQNclly453UllgucI5jYUcge9USbI
	 6dMDsN01ZpUKXTL3XtyFl6qdXKtzDo11qWD9yjrkuWpfLZPXCCD8pAZAMlzeqNbrph
	 uGe4wsD1cPESHaN+3KOwYl45kJESPBhLIlf7dOzS4dMad9l5EP9icvfoPSmt+uLbOP
	 Nf1AMeDO01jZA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:32:57 +0200
Subject: [PATCH 04/12] mm/sparse: rename and cleanup sparse_init_nid()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-4-008fc8d579fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010; i=david@kernel.org;
 h=from:subject:message-id; bh=22aLutJEtYm1F1P07TqVwcTSIGuZ5EPTXkGcwZd1Z9w=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJug/EP2qvX5Rr/5ab7Y3etta32/kz7uebGjWHKIga
 7G7ofx3RykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABPh2cTIsPXCsU3TilYZ6avM
 f60osnipg1zpgRX+Pk9+n9hy7YrV04sM/12tUwMX/JfRUjlQwL7L68iE28+eWOyt/MxZH1qbwGz
 jww8A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's rename it to "sparse_metadata_init_nid", avoid the "pnum" terminology
and drop the function comment. Further, rename the "map" variable to
"mem_map" for consistency with other functions.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index a85a9c3840f6c..f84bfceb53060 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -222,37 +222,34 @@ void __weak __meminit vmemmap_populate_print_last(void)
 {
 }
 
-/*
- * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
- * And number of present sections in this node is map_count.
- */
-static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
-				   unsigned long pnum_end,
-				   unsigned long map_count)
+static void __init sparse_metadata_init_nid(int nid,
+		unsigned long start_section_nr, unsigned long end_section_nr,
+		unsigned long nr_sections)
 {
-	unsigned long pnum;
 	struct mem_section_usage *usage;
+	unsigned long section_nr;
 
-	usage = memblock_alloc_node(map_count * mem_section_usage_size(),
+	usage = memblock_alloc_node(nr_sections * mem_section_usage_size(),
 				    SMP_CACHE_BYTES, nid);
 	if (!usage)
 		panic("Failed to allocate usemap for node %d\n", nid);
 
-	for_each_present_section_nr(pnum_begin, pnum) {
-		unsigned long pfn = section_nr_to_pfn(pnum);
-		struct page *map;
+	for_each_present_section_nr(start_section_nr, section_nr) {
+		unsigned long pfn = section_nr_to_pfn(section_nr);
+		struct page *mem_map;
 
-		if (pnum >= pnum_end)
+		if (section_nr >= end_section_nr)
 			break;
 
-		map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
-						nid, NULL, NULL);
-		if (!map)
-			panic("Failed to allocate memmap for section %lu\n", pnum);
+		mem_map = __populate_section_memmap(pfn, PAGES_PER_SECTION, nid,
+						    NULL, NULL);
+		if (!mem_map)
+			panic("Failed to allocate memmap for section %lu\n",
+			      section_nr);
 		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
 							       NULL, NULL));
-		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
-					SECTION_IS_EARLY);
+		sparse_init_one_section(__nr_to_section(section_nr), section_nr,
+					mem_map, usage, SECTION_IS_EARLY);
 		usage = (void *)usage + mem_section_usage_size();
 	}
 }
@@ -270,12 +267,14 @@ static void __init sparse_metadata_init(void)
 			nr_sections++;
 			continue;
 		}
-		sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
+		sparse_metadata_init_nid(nid_begin, start_section_nr,
+					 section_nr, nr_sections);
 		nid_begin = nid;
 		start_section_nr = section_nr;
 		nr_sections = 1;
 	}
-	sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
+	sparse_metadata_init_nid(nid_begin, start_section_nr, section_nr,
+				 nr_sections);
 }
 
 /*

-- 
2.43.0

