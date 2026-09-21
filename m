Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7B413797;
	Mon, 21 Sep 2026 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020799; cv=none; b=esLGHHBxy6POu9lmM6DqnMaKJoudhU213GWfTywIoTH5aTG/IUBCrVMrZu4ZNGhS4MJGWKLx5KF5N2hR5L4T0AWA2cRbrYaPu8de8CA/Tk4+BzNDH+T8R5KEpVyBFUHeroI7FrnQR3WqJvjxeWjv65FWg91Sj75mfNX8K5s0ks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020799; c=relaxed/simple;
	bh=jRIGnfYse4fXvQGtvRSVJN3HkWBLnWHH94529PFkjgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxEq89zEhdoHS9WVebmsVtY7zjMRU8y0/eiO5n9YDR3TA2+NxtTnGwJxyBq0eyqNnSl+r3QGuOVnc0wEabccdsCKDHLh8xfsEy99D3xkdfNMYw/kUmr8MHs205XwdbfW6LrDXYL0i29bHtDI/cxPAY0ybagFjiDqEQoAKekRXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L95Gueio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L95Gueio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA18B1F00899;
	Mon, 21 Sep 2026 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020793;
	bh=CdS+/4QTYMA6mkMSAisNrxryoW61WoDFfQTO+/5sNFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L95GueiosaZQg0BKiLrbDQ2H76JOpx5XQ1JBgC/3WRgTV1pywD/hQQTFC2hczp9t7
	 LMcAMhV52doEKKJ4AJbaFqNNQwCzbqlfAzjnxTCgOXC91q8dFTNEXWIb9dKIdV4aBq
	 +GCCxnVLAu8jfyg8d7Yy8ruPPlblSRPcKUZ4oetaeD+rH2oXWwo29MkQiyq3iS1QsZ
	 qH/+dBLdHmdZiWClIDnwrLnkbE9fZHLoD1hq72mRd4Plq5YnZSgrZUy//gjUJ7EOKH
	 9O/bNQRqIlECpcGhMzppG2nCCP24W+8epB070gor6ECTUmc5+FwG4XEZXEDEOpInQ+
	 yxJxT/11+hMLw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:58:56 +0200
Subject: [PATCH v2 04/13] mm/sparse: rename and cleanup sparse_init_nid()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-4-54d81d65e125@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3145; i=david@kernel.org;
 h=from:subject:message-id; bh=jRIGnfYse4fXvQGtvRSVJN3HkWBLnWHH94529PFkjgA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rSm3gnWi/35I9XhnvDe02Fc7r81Pky0njvXLCrsN
 PMmuZaPHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEwk4jUjwxxHpq7rex3tClv4
 EzbP7j6U8Upt9ZwYj3RbfaU//48qMTP8M74pVnHzVI6q/7I1L5O+1i1aHqBy+1W7Wd8lj0Cvp7e
 62AA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's rename it to "sparse_metadata_init_nid", avoid the "pnum" terminology
and drop the function comment. Further, rename the "map" variable to
"mem_map" for consistency with other functions.

Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 71288daeb3665..3c19d47559090 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -221,36 +221,33 @@ void __weak __meminit vmemmap_populate_print_last(void)
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
+		const unsigned long pfn = section_nr_to_pfn(section_nr);
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
 		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION));
-		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
-					SECTION_IS_EARLY);
+		sparse_init_one_section(__nr_to_section(section_nr), section_nr,
+					mem_map, usage, SECTION_IS_EARLY);
 		usage = (void *)usage + mem_section_usage_size();
 	}
 }
@@ -268,12 +265,14 @@ static void __init sparse_metadata_init(void)
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

