Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB553EFFC2;
	Mon, 21 Sep 2026 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020787; cv=none; b=V9PvtG+B8y2QTS+9Rg6ePbnPxQkBZnQSW3seCymzSYSy/p9YkNoa14YBP/UPbQ58UtbGSlVH8r3hg5zDDVaPuCNdBROj4e27It5xJuCp04hxeuapKSf9aQADKTqOkHInJJye5OD6K93800we1HoF3lFNWJwiX8xH5XEesRnqsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020787; c=relaxed/simple;
	bh=3LdazTbWXikkHaUL3kEHoOoL94yCObwwfPuFbE1hFoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uTgVIPBEje14mjyvgZf/H8n3lhThua7OY8poOJNjSoqXcFDUSeQFrne9lQXQgcNnMZr1nCqlSZjAFHIVYriZgt4AOF/TKtoiS9mFs3QfDfV/84fvswc7hMHNqMiChiGJ7gx+yZGpJy2WcX/RiKGm2zG+p2pO7GhmRsOe+ACjOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiU691py; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiU691py"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD141F000FF;
	Mon, 21 Sep 2026 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020783;
	bh=DMtBSn8yOXnXVar79nWZLJEdBKm3qvESfKRbNGf93Xs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aiU691pyrUYYyQxU9eU70qvyfBU8JxpmY83EEdT3A/04/6eqGwjXGwdaMTlulVnnf
	 9HFfooLmHjLrL0gE/kIl2vA1lVlP7vj2TOBdK7Slr35sdJ3fPiZoUYK3Pf3m3P62S0
	 JC4XZgaDwFcE6sMhmvqcRYR9F5B6CSVLRRsdjLTd4M5SJGc6BrPVNLARqh5yRpEOR2
	 aXQlz6B7Pxjtfq0dcM2prmQdsj5E66edwcStVbsf8tbBKh/1EQTV4XnxN3cYxJBRHk
	 paxFBqavHzIYpDYbLZBIM1FZs//LAy6gjSZuVytKFapn7niPNpQ2N8X6wqBYT8lsUv
	 3l4S/s+BAGQkA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:58:55 +0200
Subject: [PATCH v2 03/13] mm/sparse: move initialization of section
 metadata to sparse_metadata_init()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-3-54d81d65e125@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=david@kernel.org;
 h=from:subject:message-id; bh=3LdazTbWXikkHaUL3kEHoOoL94yCObwwfPuFbE1hFoY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rR+PSAo+0AmduX8rVPz3oSf+Dmlz4n5l4XIlOz4y
 U6PP5q96ihlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiKmsZ/occ77274PbJD6v0
 mRKb9fw7RGcvO+l2Re6mxOLm9CdFU5wZ/me/9j3RbrhlwfwTjvzSG5JrMv3bTlisn3dxduFpRYM
 D0nwA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's move the code responsible for initializing sparse metadata (usemap,
memmap) into a helper. Cleanup the variable while at it (e.g.,
"map_count").

Drop the rather obvious code comments.

No functional change intended.

Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 2b285653abf1e..71288daeb3665 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -255,38 +255,39 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 	}
 }
 
+static void __init sparse_metadata_init(void)
+{
+	unsigned long start_section_nr = first_present_section_nr();
+	int nid_begin = sparse_early_nid(__nr_to_section(start_section_nr));
+	unsigned long section_nr, nr_sections = 1;
+
+	for_each_present_section_nr(start_section_nr + 1, section_nr) {
+		const int nid = sparse_early_nid(__nr_to_section(section_nr));
+
+		if (nid == nid_begin) {
+			nr_sections++;
+			continue;
+		}
+		sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
+		nid_begin = nid;
+		start_section_nr = section_nr;
+		nr_sections = 1;
+	}
+	sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
+}
+
 /*
  * Allocate the accumulated non-linear sections, allocate a mem_map
  * for each and record the physical to section mapping.
  */
 void __init sparse_init(void)
 {
-	unsigned long pnum_end, pnum_begin, map_count = 1;
-	int nid_begin;
-
 	if (compound_info_has_mask()) {
 		VM_WARN_ON_ONCE(!IS_ALIGNED((unsigned long) pfn_to_page(0),
 				    MAX_FOLIO_VMEMMAP_ALIGN));
 	}
 
-	pnum_begin = first_present_section_nr();
-	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
-
-	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
-		int nid = sparse_early_nid(__nr_to_section(pnum_end));
-
-		if (nid == nid_begin) {
-			map_count++;
-			continue;
-		}
-		/* Init node with sections in range [pnum_begin, pnum_end) */
-		sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
-		nid_begin = nid;
-		pnum_begin = pnum_end;
-		map_count = 1;
-	}
-	/* cover the last node */
-	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
+	sparse_metadata_init();
 	sparse_init_subsection_map();
 	vmemmap_populate_print_last();
 }

-- 
2.43.0

