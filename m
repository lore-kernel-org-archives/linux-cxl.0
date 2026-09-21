Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17841737F;
	Mon, 21 Sep 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020818; cv=none; b=pAuScvVExF2ysSy1bYVfizYh8zU2UHTEjkhleW4j7x/J0yWU9H+uwbQkjvFWz+5tIca3I2FZaxSr4zzxXnbQTss6RpnQKdtr1fCrHwrqLdjygdY8wXiQ+QbkCGaZW0E+omq9fSS8CpzrmJq7dG2VKJ/lITxeDF/KSJPossnaCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020818; c=relaxed/simple;
	bh=ZMj3GL7XkJQuzRyY7F15KJiefRjsZ0PhiN7MkSd9scA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1IYvhv3dK3MjGWRUFDcyTPTr0BKYIjBXuwzLyaeHM8xr2rItuyVJMXYeIv4klK4i6VFM4RXbGBZwwIisgNebQuXeJzDAHT+TRdQogCkj6zjbvkVIjyef1jGWpcgqTYExxctHEZWInCtOttgnXrKUSbO2IXQkEe7hdvoufscSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq6hV1F6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq6hV1F6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD441F00899;
	Mon, 21 Sep 2026 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020813;
	bh=uohIE5Ud1GVLNxgqJo8HKP8fD50DZwtEDQQQXUSGv4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jq6hV1F6xq6J8paTwQAAKGSZfhRwBlx2ocNzRoGzAaeORMDZmCkdqNYnfSdjAeO1b
	 +9p6CA+RwWfuvXt10ONB9W+ARG+TRUSzP3yB/rvbPEoV7h3x7sWzTsshsCjvNmiYGY
	 pBeNThQ0lLtRgem+7/J6YCSayEmXI1vm2Zk2k4NBkI3YmmdMrQ3cdcuezTOKG2FrFE
	 lgDhSxeZUhIapwQdP/NIGtTHVR9WrFUgyzf1vIMzHaMAiPKF/+4ea3XVxFC/PCdRe9
	 xOsz/YATuBG0ycnif7zegeGNKE1Iar5n84GNQdAAh5k4IHAw6h6OIYVEPlVJ1t2c0T
	 4oV+JRhM4bYhg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:58:58 +0200
Subject: [PATCH v2 06/13] mm/sparse: rename __highest_present_section_nr to
 __highest_used_section_nr
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-6-54d81d65e125@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3714; i=david@kernel.org;
 h=from:subject:message-id; bh=ZMj3GL7XkJQuzRyY7F15KJiefRjsZ0PhiN7MkSd9scA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rSdNVMPfzFfW2Wpj0ti81133uaDAdce7T7Wd0Gw2
 MTRMk25o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIlIKzP8U9rU8CH6Dmtb5QHP
 w6sX/M84WP5Rv2dHk45SBPvLxqwyM4a/YhwN8mbHrj+WeuvGKmh4Y9nqR75Z1+zn/muoXe5857c
 RHwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

In preparation for getting rid of SECTION_MARKED_PRESENT, rename
__highest_present_section_nr and clarify the comment.

Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mmzone.h |  6 +++---
 mm/compaction.c        |  2 +-
 mm/sparse.c            | 12 ++++--------
 mm/sparse.h            |  4 ++--
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ebbda6f311392..0c2fea48c261b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2181,7 +2181,7 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
 	return __nr_to_section(pfn_to_section_nr(pfn));
 }
 
-extern unsigned long __highest_present_section_nr;
+extern unsigned long __highest_used_section_nr;
 
 static inline int subsection_map_index(unsigned long pfn)
 {
@@ -2280,7 +2280,7 @@ static inline unsigned long first_valid_pfn(unsigned long pfn, unsigned long end
 
 	rcu_read_lock_sched();
 
-	while (nr <= __highest_present_section_nr && pfn < end_pfn) {
+	while (nr <= __highest_used_section_nr && pfn < end_pfn) {
 		struct mem_section *ms = __pfn_to_section(pfn);
 
 		if (valid_section(ms) &&
@@ -2335,7 +2335,7 @@ static inline int pfn_in_present_section(unsigned long pfn)
 
 static inline unsigned long next_present_section_nr(unsigned long section_nr)
 {
-	while (++section_nr <= __highest_present_section_nr) {
+	while (++section_nr <= __highest_used_section_nr) {
 		if (present_section_nr(section_nr))
 			return section_nr;
 	}
diff --git a/mm/compaction.c b/mm/compaction.c
index 4994e200bbecd..f1b2060eb2016 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -216,7 +216,7 @@ static unsigned long skip_offline_sections(unsigned long start_pfn)
 	if (online_section_nr(start_nr))
 		return 0;
 
-	while (++start_nr <= __highest_present_section_nr) {
+	while (++start_nr <= __highest_used_section_nr) {
 		if (online_section_nr(start_nr))
 			return section_nr_to_pfn(start_nr);
 	}
diff --git a/mm/sparse.c b/mm/sparse.c
index 3c19d47559090..bb89017254f4d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -164,15 +164,11 @@ static void __init mminit_validate_memmodel_limits(unsigned long *start_pfn,
 }
 
 /*
- * There are a number of times that we loop over NR_MEM_SECTIONS,
- * looking for section_present() on each.  But, when we have very
- * large physical address spaces, NR_MEM_SECTIONS can also be
- * very large which makes the loops quite long.
- *
- * Keeping track of this gives us an easy way to break out of
- * those loops early.
+ * Looping over all possible memory sections is expensive, especially if
+ * NR_MEM_SECTIONS is large but only a fraction is actually used. Keep track of
+ * the highest section number we ever used.
  */
-unsigned long __highest_present_section_nr;
+unsigned long __highest_used_section_nr;
 
 static inline unsigned long first_present_section_nr(void)
 {
diff --git a/mm/sparse.h b/mm/sparse.h
index 4ee507c34b98d..242b7bab0013c 100644
--- a/mm/sparse.h
+++ b/mm/sparse.h
@@ -44,8 +44,8 @@ static inline void sparse_init_one_section(struct mem_section *ms,
 static inline void __section_mark_present(struct mem_section *ms,
 		unsigned long section_nr)
 {
-	if (section_nr > __highest_present_section_nr)
-		__highest_present_section_nr = section_nr;
+	if (section_nr > __highest_used_section_nr)
+		__highest_used_section_nr = section_nr;
 
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }

-- 
2.43.0

