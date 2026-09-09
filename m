Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B11545284;
	Wed,  9 Sep 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960844; cv=none; b=W3jSV/nBqXRPgJF0+aag/MZJzpMiqpTWo9eCMPVhZ0SgKWLxGYx2DE0IuLgEBHhXJQjY4DFMyNiKJaEQ9+xaPB7cNkrMhBhaSgRzUzj//KKOpO1AlWrLnnBRczBAWl7I9gclMb6nWaqfA3NtRHhTBCY8V+Y0rlSDvCPvC0lDUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960844; c=relaxed/simple;
	bh=tuizVE3zPZHpcM2HGG+m6b3SuJ7LR3VtKbc7zGfeEhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+7bIvxKgXSdOGqRePn2SQsTkHHzcBATnhnuA4N6sCJr47dJw0stIHO8eTFyAJGk3w4Gq7KBV7/hl/r2SQgW0YyB4qO1PoUJi8zrYWisQiIwHwtpQhKCQlmjPweaINAz+3sMfCMxGZaktvPvLjLaLBvHTP5ijTBeLKtPatnxYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxAJ8TkH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxAJ8TkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A319F1F00A3D;
	Wed,  9 Sep 2026 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960843;
	bh=ke7wbwtpCjUAwuxuLGTSFpELTF8GAXgQgWxJpOfKOlk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kxAJ8TkHym33fm/nM2JegElwmiyVwFZ0YNsgval5iLx/fAaFlApVsOrk21RqvhOTw
	 bdhecW15KUMV8YzLqiIH9eH0nvy37ki3NSxffsRITrTO2nvb4Pw9r+uTw0uLYi2lQ7
	 JEBxI1bdBIc9ph6Vw/Q+9p/SAbxsj56xU9uloikO5hpn+uFjATCy8MwIALXktyfQbh
	 W5WZd1dLWstQKdJ/jti2Ep5zLEed9g5EExRVy6+g7zvzTrS0AIAUm/UJRTGFtCV7Ka
	 eY+vCZsu9eFAyTywAl+ehZ3vRHLoi8Wm+gXFid62KNoMwvpJ7I4t9YT9ozLsk3Ok5h
	 2B5UB6El4/WMw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:32:54 +0200
Subject: [PATCH 01/12] mm/sparse: move mem_section init to
 sparse_extreme_init()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-1-008fc8d579fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=david@kernel.org;
 h=from:subject:message-id; bh=tuizVE3zPZHpcM2HGG+m6b3SuJ7LR3VtKbc7zGfeEhc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJqhf+8M6eYfkbV/5ZQszo18qzdtQdUrG9MjBH/tyl
 68/zXM4p6OUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJXPZlZNhr2Gf7Y/aN9uOy
 Ru2WM1VWpqrOtt1qHfHiRc6HOeov9mkzMjzbsHlZRXPhkflTWh+3JPtvW87zXvjPD8mr2Ve0bPT
 4f7AAAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's just avoid another pair of ifdef inside a function. While at it,
switch to INTERNODE_CACHE_BYTES by just defining a fallback in cache.h
as well, given that the x86 variant already provides one.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/cache.h |  1 +
 mm/sparse.c           | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index e69768f50d532..b6e857b985bca 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -89,6 +89,7 @@
  */
 #ifndef INTERNODE_CACHE_SHIFT
 #define INTERNODE_CACHE_SHIFT L1_CACHE_SHIFT
+#define INTERNODE_CACHE_BYTES (1 << INTERNODE_CACHE_SHIFT)
 #endif
 
 #if !defined(____cacheline_internodealigned_in_smp)
diff --git a/mm/sparse.c b/mm/sparse.c
index 9349ed6326c01..6a6d258862904 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -103,11 +103,22 @@ int __meminit sparse_index_init(unsigned long section_nr, int nid)
 
 	return 0;
 }
+
+static void __init sparse_extreme_init(void)
+{
+	const unsigned long size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
+
+	mem_section = memblock_alloc_or_panic(size, INTERNODE_CACHE_BYTES);
+}
 #else /* !SPARSEMEM_EXTREME */
 int __meminit sparse_index_init(unsigned long section_nr, int nid)
 {
 	return 0;
 }
+
+static void __init sparse_extreme_init(void)
+{
+}
 #endif
 
 /*
@@ -197,13 +208,7 @@ void __init sparse_sections_init(void)
 	unsigned long start, end;
 	int i, nid;
 
-#ifdef CONFIG_SPARSEMEM_EXTREME
-	unsigned long size, align;
-
-	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
-	align = 1 << (INTERNODE_CACHE_SHIFT);
-	mem_section = memblock_alloc_or_panic(size, align);
-#endif
+	sparse_extreme_init();
 
 	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
 		memory_present(nid, start, end);

-- 
2.43.0

