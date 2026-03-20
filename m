Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C52341065;
	Fri, 20 Mar 2026 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044845; cv=none; b=Jhc1sMQ9qbllZ2ZMcsJfZxN7aKRhsh48bejl1rzpB0cCY11H0i7hfJmXUo77fTzT2zmQbjig9PYYuq+CNC7K+rL3J7zn97YK7enpiY326mPs/X4UZomvVRhbVUJLpVfZf+NmnkCiTrheURSh7TzCMZMc+oRkD4fisawpLa33aFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044845; c=relaxed/simple;
	bh=IA23Gy39M2F3BrgjRU1645p2gPCHoKr3S7Gd6stw5xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahFAGSLTzATzYmavn2LEqif4zP2itYfHbUcrUxwGiBxarY1ZQ4XpDv95fUXIH0pW/t2h4I6mVrfXuWc4MM0SOMWfrj/JUjz9FP8/v4kB+htD3TKIKqywDvNoKWbNNTI32EBcssX6UPX0yqUNlrMaf8TGd2NsHxzs637OrQyMY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITuTXaTR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITuTXaTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533C1C4CEF7;
	Fri, 20 Mar 2026 22:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044845;
	bh=IA23Gy39M2F3BrgjRU1645p2gPCHoKr3S7Gd6stw5xY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ITuTXaTR5d3MLfnoE8tiWvMk3cJVFd3Gn4KFKc27ZUXry5hmpyQELFB1C+kYArpwP
	 E68SqIwWSExdhJKLtwAb8/MnDcxtEzcli+cyl8rEOVXy7QUJttlz4Cs/vtHelyYvP3
	 MhBm0AMFhp9AV1a/Rp0cp6DluC2ISIen3+X7xuRxf5M//eU6B65u8yZDbBBB/9fk5o
	 CzhinwrYTx4Pr2gD4mtFdMumrSj2a/MequJzUXzrkLsZ+sT/qMEvLquBZzaeByDTBP
	 SNOXBPB7LC6GIlWCEKYfJoDyoNHCpxCA98DY3irXB4tVAUChm6T+w8VsIuqcwuBd1l
	 0psq2Gp2a4cIg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:37 +0100
Subject: [PATCH v2 05/15] mm/memory_hotplug: simplify check_pfn_span()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-5-096addc8800d@kernel.org>
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

We now always have CONFIG_SPARSEMEM_VMEMMAP, so remove the dead code.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory_hotplug.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0c26b1f2be6e..ef2b03eb1873 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -320,21 +320,13 @@ static void release_memory_resource(struct resource *res)
 static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
 {
 	/*
-	 * Disallow all operations smaller than a sub-section and only
-	 * allow operations smaller than a section for
-	 * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
-	 * enforces a larger memory_block_size_bytes() granularity for
-	 * memory that will be marked online, so this check should only
-	 * fire for direct arch_{add,remove}_memory() users outside of
-	 * add_memory_resource().
+	 * Disallow all operations smaller than a sub-section.
+	 * Note that check_hotplug_memory_range() enforces a larger
+	 * memory_block_size_bytes() granularity for memory that will be marked
+	 * online, so this check should only fire for direct
+	 * arch_{add,remove}_memory() users outside of add_memory_resource().
 	 */
-	unsigned long min_align;
-
-	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
-		min_align = PAGES_PER_SUBSECTION;
-	else
-		min_align = PAGES_PER_SECTION;
-	if (!IS_ALIGNED(pfn | nr_pages, min_align))
+	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION))
 		return -EINVAL;
 	return 0;
 }

-- 
2.43.0

