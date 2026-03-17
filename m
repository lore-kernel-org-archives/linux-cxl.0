Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEF3446DA;
	Tue, 17 Mar 2026 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766654; cv=none; b=ChvTtayw8fEWHMEKXkoHD6JolzUSD4lWS8sr/Wu/duMamGszC6tTElAbjMARXR2Q92TDa7vPYV2EVuYzoks+7Qb/DVW0wTsFy8WmcdoBsf46zydKGRfFXeIaM786ZyfYRU8SMqvXU1opXrz0OKn6SPX/BnvLZTpgAWEkiFSKYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766654; c=relaxed/simple;
	bh=3YI8GLSe1tTWHR4VUkgbO+5WHzisOWZuA3eyf8N2TRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5kN8DIbGeXu8ZxV1vR4oGcautmNOZSipwVq1SjfTwWQziOyYGqm3lyikJn782JfUY8WuSz1fN9Bux2eLWIho4ysMOe8nR3mlZymOkBPYAaYMJQv700Estn+AveNLgYfByUb2QT73LTn5OC+lkgo5/uMxaPBhSa6VAI43odVlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h94nBmRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h94nBmRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B4CC4CEF7;
	Tue, 17 Mar 2026 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766654;
	bh=3YI8GLSe1tTWHR4VUkgbO+5WHzisOWZuA3eyf8N2TRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h94nBmRa1lj7MKJ7PA9M7CgVzvxBwAAV9TakhLXrNdY2dP5jXSRsFyt3auwxNmXF/
	 Cmr9K/op+yjMOSFwzQo17jrSDebrH0kymNXGRAQ34hK8tLDjPuvTMqScgg/doAonCy
	 z0QkvfRf2dThbrwJariFkrc3HxzK8XWonH4NsyuKadivtDbb0U3myTcMY+JfZ89/ZW
	 C8SD3Z7dF3dhm68HtC9CwkUO6aD5ufhtfmV4WytNrOrVNohKLEq7dut2Y66Z/PBBDc
	 ImEFj48erS2Yb/wxd/vaw04/8SLSebStL59JVB2WI8UDMUzaYYHFSPQm7AsE65fHiP
	 rvwNFWh8h8AYw==
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
Subject: [PATCH 08/14] mm/sparse: remove sparse_decode_mem_map()
Date: Tue, 17 Mar 2026 17:56:46 +0100
Message-ID: <20260317165652.99114-9-david@kernel.org>
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

section_deactivate() applies to CONFIG_SPARSEMEM_VMEMMAP only. So we can
just use pfn_to_page() (after making sure we have the start PFN of the
section), and remove sparse_decode_mem_map().

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/memory_hotplug.h |  2 --
 mm/sparse.c                    | 16 +---------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e77ef3d7ff73..815e908c4135 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -308,8 +308,6 @@ extern int sparse_add_section(int nid, unsigned long pfn,
 		struct dev_pagemap *pgmap);
 extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
 				  struct vmem_altmap *altmap);
-extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
-					  unsigned long pnum);
 extern struct zone *zone_for_pfn_range(enum mmop online_type,
 		int nid, struct memory_group *group, unsigned long start_pfn,
 		unsigned long nr_pages);
diff --git a/mm/sparse.c b/mm/sparse.c
index 636a4a0f1199..2a1f662245bc 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -274,18 +274,6 @@ static unsigned long sparse_encode_mem_map(struct page *mem_map, unsigned long p
 	return coded_mem_map;
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-/*
- * Decode mem_map from the coded memmap
- */
-struct page *sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long pnum)
-{
-	/* mask off the extra low bits of information */
-	coded_mem_map &= SECTION_MAP_MASK;
-	return ((struct page *)coded_mem_map) + section_nr_to_pfn(pnum);
-}
-#endif /* CONFIG_MEMORY_HOTPLUG */
-
 static void __meminit sparse_init_one_section(struct mem_section *ms,
 		unsigned long pnum, struct page *mem_map,
 		struct mem_section_usage *usage, unsigned long flags)
@@ -758,8 +746,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 
 	empty = is_subsection_map_empty(ms);
 	if (empty) {
-		unsigned long section_nr = pfn_to_section_nr(pfn);
-
 		/*
 		 * Mark the section invalid so that valid_section()
 		 * return false. This prevents code from dereferencing
@@ -778,7 +764,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 			kfree_rcu(ms->usage, rcu);
 			WRITE_ONCE(ms->usage, NULL);
 		}
-		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
+		memmap = pfn_to_page(SECTION_ALIGN_DOWN(pfn));
 	}
 
 	/*
-- 
2.43.0

