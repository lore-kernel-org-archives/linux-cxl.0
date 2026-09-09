Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BEE566C5C;
	Wed,  9 Sep 2026 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960854; cv=none; b=PDxhLdSP9pqkeqE/+cT5ej8VB7/nykrTQxXIXQQKNyaZqnYhmLfaOkWHVuGvZ+xK4SlC+wlwHgMgT/EkSQXal7Q37QhrAXv9z9Z1kBejDN9wNnXH+D29Dmc5izAcDRhCRcbTqTmSowDcRjPkEs/9o3W6XcUvzjHHccpNmeNO0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960854; c=relaxed/simple;
	bh=vj5TwCzhlLxvUe7A+Bx3R9PGajolUon6lM6RJzWmxHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLZOWFqeG1xa3swSyD0db8My0AI62kWsFxsSaSJpJGL04GRtYR1CK+UY01LyyGx9pWLyCFvJL4qSR1un54TXODYOT5JOiUHGnBRXUaa8CvlcmpZvQNSGsSLU5z0Ymq4FzCWqIVYdZJx0FRj8FvL+dAC3vxCLHS24K8X4wPnQwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKETAwhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKETAwhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97AA1F00A3A;
	Wed,  9 Sep 2026 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960852;
	bh=Vwf3XHFmLke+N9soz5HJtjy5W6jvA8C1cmDilLBFR0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VKETAwhbvv+EK0Gm31QFMYaYfrQJ2PkX9WiTurdg0GqN2atlcsKeEnI2LT69seS1g
	 ckmzVzkRoynOrvTlgBNzG1vsWAhQRsMuS1a7vuZYSDXafGxdgK9TNpx4ebCVmVAjM1
	 xDU1YFvqp0/x0rO09WvuApW6ngX9ZKM5Vkq7BQ8v35OA/CBlRB5ViylH9nulLN/f29
	 5dnXJYPV5oRwG4/vm/WSmAWMIcDVIe38hgrg+TvfeE1NJrKE8c5xy9uZKJTJnaRbyS
	 OkQib97F1RX0R0/WJwLRKYGE5XY9OxKPJH/UsYWzVYILEjG7UPdcd15Pipp0iFaPrd
	 GcwqJZUYV2Rxw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:32:55 +0200
Subject: [PATCH 02/12] mm/sparse: refactor sparse_sections_init()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-2-008fc8d579fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2859; i=david@kernel.org;
 h=from:subject:message-id; bh=vj5TwCzhlLxvUe7A+Bx3R9PGajolUon6lM6RJzWmxHU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJmg1TG/wTlyzoPKR2TK/dRFzncSdjcw5bZd5zM1//
 dqqsVqxo5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgInwTWD4ny5++k5Jx/wO5uki
 oZopr+4wct0S4XQ8sunwR2f+wENn5RgZrr9oaQteGlzRdT11x6xTOw1nq7yNDpm/IaqT039Ki3U
 fNwA=
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

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 6a6d258862904..36e3d854febc5 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -179,22 +179,27 @@ static inline unsigned long first_present_section_nr(void)
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
@@ -202,18 +207,6 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
 	}
 }
 
-/* Initialize memory section metadata for all system memory. */
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

