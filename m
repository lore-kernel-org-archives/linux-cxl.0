Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D703815CD;
	Fri, 20 Mar 2026 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044882; cv=none; b=atESqivwmDMUhzPvRNSiMJdrFxwMS01BBltjOFrfM4g9vR8S11MqCv7C+ea815tTTODa9X1IesOqqKg2KUzzyo8i2oT7hRdURz3mmlaWDX3W5UTFhd9xRz7/9S/v8v+RUCuqLSQ93d09yV1toPBQ4vDui0lYAkzRf14J/6LTgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044882; c=relaxed/simple;
	bh=nAADk4O++zlIdaSsGnqecpm2JFYNOEQEolE0epkoJXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsqHB0+wPU0iFqhBKyd/u4PSLj1reXEkJyxLxeUjBqIghsPc5aGiddReEd13hrXeHtabwEPd0K7b1c1rlvAbJyv6ZruAThUXJ5cO2mn5QVXhRP3JZmtH5s6OjDoGkK8BzaprjD1ORb4ee8PRmLjuMwNfsKufVGiAb6z7E3ZFBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx1QfJei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx1QfJei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CE7C2BCAF;
	Fri, 20 Mar 2026 22:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044882;
	bh=nAADk4O++zlIdaSsGnqecpm2JFYNOEQEolE0epkoJXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cx1QfJeiw+fJiVi+TEUgbrb9326n7iVHjUNLjnMKlj6iprB7t2rO+Imn/dWGqdEq7
	 YfNIyImYbgavmRQUEAmCNUElbh5Kg1BFoe5ptLbRuN7ZuReCZI4rDY2a5jP7YFa8px
	 3Dok4Agv9vTrsTBNtsOBpywS0B05t15ubKY0+5O73+1FriKKgr5AGs+05Tvmqv7AdU
	 RyCJAM88Hs+79PzvgYeXn5SyIVMvqyy3JQ8WpvMDwEKL4HxAu0dR37XakI55NSR2rh
	 eRrtwzRqU4cSFG1lF8DErPwB1lfPA7mQ94KCMiW+AgFVXhOqgZu5WkrNADCZ1pDXHB
	 SiY7M3MEQJVBQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:46 +0100
Subject: [PATCH v2 14/15] mm/sparse: move __section_mark_present() to
 internal.h
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-14-096addc8800d@kernel.org>
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
In-Reply-To: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, linux-riscv@lists.infradead.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

Let's prepare for moving memory hotplug handling from sparse.c to
sparse-vmemmap.c by moving __section_mark_present() to internal.h.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/internal.h | 9 +++++++++
 mm/sparse.c   | 8 --------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2f188f7702f7..b002c91e40a5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -987,6 +987,15 @@ static inline void sparse_init_one_section(struct mem_section *ms,
 	ms->section_mem_map |= flags | SECTION_HAS_MEM_MAP;
 	ms->usage = usage;
 }
+
+static inline void __section_mark_present(struct mem_section *ms,
+		unsigned long section_nr)
+{
+	if (section_nr > __highest_present_section_nr)
+		__highest_present_section_nr = section_nr;
+
+	ms->section_mem_map |= SECTION_MARKED_PRESENT;
+}
 #else
 static inline void sparse_init(void) {}
 #endif /* CONFIG_SPARSEMEM */
diff --git a/mm/sparse.c b/mm/sparse.c
index ed5de1a25f04..ecd4c41c0ff0 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -161,14 +161,6 @@ static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
  * those loops early.
  */
 unsigned long __highest_present_section_nr;
-static void __section_mark_present(struct mem_section *ms,
-		unsigned long section_nr)
-{
-	if (section_nr > __highest_present_section_nr)
-		__highest_present_section_nr = section_nr;
-
-	ms->section_mem_map |= SECTION_MARKED_PRESENT;
-}
 
 static inline unsigned long first_present_section_nr(void)
 {

-- 
2.43.0

