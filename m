Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D87568FA1;
	Wed,  9 Sep 2026 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960929; cv=none; b=QSGx6FO2qbysUMHVaYGwGe2i7lTx1w/kllA/9ribJ/nJDAtFLheH6Ne2VHxLxexD2NTrQ6sHe01+3ok3zcpAwXPTOntudAb++RJ80f2r0XBiJObBGpMqdJvH+DuJ7Z7sYethnUPlVz1VXyCqkqPcOMPBCK8VLRX9bKMBoWe7tqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960929; c=relaxed/simple;
	bh=DckWm817GDohe+Jpj0X2/MGpAnLdf0iSl2oq+0nv+DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFM86YA5j0ss+o/qj8fCefrRBPZpcLklLMQ+m19GbuAQ9G60Q7089Y53kHk6xIBJLl+t8guQmtuYg9okLjo/7G3dsG5Fiys0eKDpV8HffHYwA/ESLfFOkagd+G3KaVXdmknZzZ9ezJ8LgjCpIZX65J1GKClcsdpU6kQom68zHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwyGU5F9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwyGU5F9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887071F00A3D;
	Wed,  9 Sep 2026 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960928;
	bh=yZNdkM0u6O9tZXo2WJInVc9+4wXdTph9vPW/LWef/ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FwyGU5F93doyR2e+TPh/mdOmwUgenFtb2TP+XJNz3h+GAaop9V50jXt3fURujWDff
	 844XCCU9pS4FYYnocBM040shpJTZzg1504KOaOOFjpbpw6yaW55hBDNAYN4gZGelNJ
	 ihdNcRxfV8z+R21OYQncFMNeyXGi+GqxojxD1Tm/awQ61Cf9zcEYnvtz6c6YoVCuYP
	 /esXF2U5FYahncfNaVAfyyVTJnnSJ0XZCY9E+GO1YsW+vTrPyS7LyiXQWGgTPzPtBl
	 mg0S8dObY9asNAhWG1oHEKPZyQtyrW7lNHEdnMQUc2zcEPuLc1MbVJ1iDeqhPEap3W
	 2q5EQjdyVe0IA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:33:03 +0200
Subject: [PATCH 10/12] mm/sparse: remove flags parameter from
 sparse_init_one_section()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-10-008fc8d579fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=david@kernel.org;
 h=from:subject:message-id; bh=DckWm817GDohe+Jpj0X2/MGpAnLdf0iSl2oq+0nv+DY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJpiGJ8Q3l91f3ndj9/ytd25uOvJENPJiXveMnvgJG
 rPSNjUYdpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRpzEM/6yXpcS7z3Bcy9Bt
 3ZL/dF3H7HstSeYHrDlieadzlPUnLWf4n2HY+OJTruOio0Fd1m7VdgLyj/v/cjssvHlvwbyEwKr
 /vAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Unused, let's remove it.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse-vmemmap.c | 2 +-
 mm/sparse.c         | 2 +-
 mm/sparse.h         | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 5aba058df6b67..25d3472972363 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -894,7 +894,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	/* Align memmap to section boundary in the subsection case */
 	if (section_nr_to_pfn(section_nr) != start_pfn)
 		memmap = pfn_to_page(section_nr_to_pfn(section_nr));
-	sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
+	sparse_init_one_section(ms, section_nr, memmap, ms->usage);
 
 	return 0;
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 344acaaed94db..d2e7c21319e27 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -245,7 +245,7 @@ static void __init sparse_metadata_init_nid(int nid,
 		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
 							       NULL, NULL));
 		sparse_init_one_section(__nr_to_section(section_nr), section_nr,
-					mem_map, usage, 0);
+					mem_map, usage);
 		usage = (void *)usage + mem_section_usage_size();
 	}
 }
diff --git a/mm/sparse.h b/mm/sparse.h
index 03351f2467e34..f45dd280db6ff 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -91,7 +91,7 @@ int sparse_index_init(unsigned long section_nr, int nid);
 
 static inline void sparse_init_one_section(struct mem_section *ms,
 		unsigned long section_nr, struct page *mem_map,
-		struct mem_section_usage *usage, unsigned long flags)
+		struct mem_section_usage *usage)
 {
 	unsigned long coded_mem_map;
 
@@ -109,8 +109,7 @@ static inline void sparse_init_one_section(struct mem_section *ms,
 	VM_WARN_ON_ONCE(coded_mem_map & ~SECTION_MAP_MASK);
 
 	ms->section_mem_map &= ~SECTION_MAP_MASK;
-	ms->section_mem_map |= coded_mem_map;
-	ms->section_mem_map |= flags | SECTION_HAS_MEM_MAP;
+	ms->section_mem_map |= coded_mem_map | SECTION_HAS_MEM_MAP;
 	ms->usage = usage;
 }
 

-- 
2.43.0

