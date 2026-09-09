Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C15427E6;
	Wed,  9 Sep 2026 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960881; cv=none; b=fTpnC1T1glnMcmEGQq+8WrfQ0iI3DvlQXdotP/iH2m/FmTVzLO3hKiPf78azSgbR2OfPq8t1bdq1NO9cZUe02E6+CiX8u/NEJagxRTFQIa2OYqXvNbeq7Z33cHBKXhCHdIlGN6CVl6fgJOPnn3KotWviOLwY37D7KPuE7nrejj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960881; c=relaxed/simple;
	bh=Z7WiH4a0eM1yPjwlViyGW7AlVy9OebQyIjLQp6z8KDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fr9Gkw6KOjDeWY/sItHx0HDIoLfOLOGRltbJQNpq++PM/RW2TJrzMSpEEJ0obBVV097lyXTPzc89UHdZw3Ty/gS/TTeVzxTbMRAp3Dfhawvxe3hIYudx1OzApamm7jfSHH4yN3UeX+imoveBc2ScKlqrGxS7LTyJs4RlvSlfLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/t+Mmy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/t+Mmy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195531F00A3F;
	Wed,  9 Sep 2026 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960879;
	bh=2s0CTmVngAhgAN93TX2cVOhQyycESM96yPxbLZkJZRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D/t+Mmy8CiNwGSg0cWFN3moAPhAPZ9DE8Ga8Htq8mAEHixxrpYy6ZOeKpVtXYEOax
	 e9wfbI97DnTzPswN6LtpD2OvZ8VxEny1EOowANRDN5AMSj6mC3N41CTGuuBv1DZXJ1
	 JVZc0UTkSwh+tW379Q+rDff8oeohBos5A2I1nVxy6ij+mKswZVHoCx781LFZXjgL+a
	 UHxG3MCcZ2Z8UFWRl1xiTSiX+Vp085FS0BihF48mdBS97GEHOBaXk/u/QF3yylZRw9
	 g3gzJF+e65Q4kTli/43aExcpWz+ZFC8ug6DvycHV4ScHn8b1Rw2a585t676cE3EEFA
	 VfnKlPO7nTJtw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:32:58 +0200
Subject: [PATCH 05/12] mm/sparse: cleanup sparse_init_one_section()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-5-008fc8d579fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=david@kernel.org;
 h=from:subject:message-id; bh=Z7WiH4a0eM1yPjwlViyGW7AlVy9OebQyIjLQp6z8KDo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJhjsOtzKtPNH/67rxXoq8S2fL/FvXG3l3rXhBKN6m
 Ldyy9RzHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExESYfhr3h+9fyk4vchfZeC
 L+cHLDA1V7zKqjU799hSl9Cy00FOygz/43kCvjQdN7VIkCjau+5EcV2Nec/396s3NsR6u9t+bjL
 jAwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's avoid the "pnum" terminology.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/sparse.h b/mm/sparse.h
index 049272aba84e5..744ae29002f5e 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -90,7 +90,7 @@ void sparse_sections_init(void);
 int sparse_index_init(unsigned long section_nr, int nid);
 
 static inline void sparse_init_one_section(struct mem_section *ms,
-		unsigned long pnum, struct page *mem_map,
+		unsigned long section_nr, struct page *mem_map,
 		struct mem_section_usage *usage, unsigned long flags)
 {
 	unsigned long coded_mem_map;
@@ -102,7 +102,7 @@ static inline void sparse_init_one_section(struct mem_section *ms,
 	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
 	 * from the page pointer to obtain the PFN.
 	 */
-	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(pnum));
+	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(section_nr));
 	VM_WARN_ON_ONCE(coded_mem_map & ~SECTION_MAP_MASK);
 
 	ms->section_mem_map &= ~SECTION_MAP_MASK;

-- 
2.43.0

