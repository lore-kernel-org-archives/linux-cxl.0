Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA23EDAB5;
	Mon, 21 Sep 2026 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020809; cv=none; b=bsl4jZ9o70jVc+sSV/KyiQl7gbb9jLSUWTpWNS2V1OiZ411W2sPtn/79kTt1nDSYCL1hkRDe+1wNagmUe/Eqn3Knhi3afOrtXIZNzDzGnxwQ/AeU2HO1/RG7mFSh8LcFSLvxj9BO96o+57jdWgotaCIWKFimvHpivPf/Hs7oKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020809; c=relaxed/simple;
	bh=4Bu7wqp5LPQ6WPOQiawfPpDIShUPnK46ZronN3GEgM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txtA52RgPR7Jf3/PZMAYzukzaGXpZSDMx+UA5PGFjR+uMc/uzVUNEHR0yDKphyY5MC+bCnLwsCHI5wVNLvHcrrFBLZxSam+HcNDgF+pt+GdNkvs48FLbETfliay9YDJ+aNxujdlVLcfm3RqZLFm7NrIZmsArD/kIueWvqdg+U5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSjBem8+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSjBem8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB861F000FF;
	Mon, 21 Sep 2026 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020803;
	bh=Pji+QYSqpVzdYzmgiKoCCOu4eSAGWJQKP9RUR89ehLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OSjBem8+kNwkxg3Bvo4XRxOymzwX9733IZOf4gdzSAwBDvnhPjONwtPsLSXraRCNR
	 0s7PpCuNdOSpuu87AcmpoVy4Qg4EhLWp2bKMEJ9QfMc6HeSyalwdDiDde/3j3MjeTg
	 a7MNs4pRqI4KcPwlb2nSPiH5E9MYyONCxFqDji24j9e01IDiUdnLuNo0RpNLthmZ16
	 zdnK+h0A0qn09aC/3UZ+HqXs1lUWNhK4cAiumIMY9DtycZzY8kWpCbL9fsWtg6riRm
	 OT1KR9Mey2IKNe797hS1q+l7MxJ8fVSIgmtrnLdkShDkQNQYRo9hGUjL31NOnB45dN
	 Awqg81sHr5UHg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:58:57 +0200
Subject: [PATCH v2 05/13] mm/sparse: cleanup sparse_init_one_section()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-5-54d81d65e125@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=david@kernel.org;
 h=from:subject:message-id; bh=4Bu7wqp5LPQ6WPOQiawfPpDIShUPnK46ZronN3GEgM8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rTesbSdd69Fy4mRefHe5Y16LOYVYoUWf8UFVrAoh
 i2efY+po5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgInM1WD4Kzb5q0i+l4H29A9t
 KSKqG4/5OZccfn/yRuPDKbnKpbfFHjP8M77advOK4RTJGoPddqZNl/Py5gUw+8zYVyA4x/P6tI/
 RPAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's avoid the "pnum" terminology.

Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/sparse.h b/mm/sparse.h
index 530692cdd516f..4ee507c34b98d 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -20,7 +20,7 @@ void sparse_sections_init(void);
 int sparse_index_init(unsigned long section_nr, int nid);
 
 static inline void sparse_init_one_section(struct mem_section *ms,
-		unsigned long pnum, struct page *mem_map,
+		unsigned long section_nr, struct page *mem_map,
 		struct mem_section_usage *usage, unsigned long flags)
 {
 	unsigned long coded_mem_map;
@@ -32,7 +32,7 @@ static inline void sparse_init_one_section(struct mem_section *ms,
 	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
 	 * from the page pointer to obtain the PFN.
 	 */
-	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(pnum));
+	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(section_nr));
 	VM_WARN_ON_ONCE(coded_mem_map & ~SECTION_MAP_MASK);
 
 	ms->section_mem_map &= ~SECTION_MAP_MASK;

-- 
2.43.0

