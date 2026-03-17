Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723803F65E5;
	Tue, 17 Mar 2026 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766637; cv=none; b=UkQPDHRZWSKLGIraYLTX4im5KodmtBks3HOzCOGBzzvUM5cS/MUCt80g/ZlQ/GL2b3GOKLJn25jvM0y9optk+2XlehcYEDXJs/kYisPKbZuGbiTzhtD5HPYvis7uiMODljWXJRk+xPJvUFH9uRrU4o/YfJPcn6v71XlI6UfEkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766637; c=relaxed/simple;
	bh=BWzG9/0Rza56pImCpceClbjm8voSGno8HwPH5Rkh+Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVSbVn9z1vZPsWSo3vB04vLCVYDPLFRRwknE0Nry5hA7Wxe5s1biRX1avXytnV+XL0WG1/UgNNLYk1lizQF32bH/5RddABvBDs2iozApViAjCNj6NpcBi4mP1EsEdu8VQ88WdrCaUXex0udCXz1fXlGAL2iBLo+o6WDmpYv9hg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYLjGDyg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYLjGDyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC353C4CEF7;
	Tue, 17 Mar 2026 16:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766637;
	bh=BWzG9/0Rza56pImCpceClbjm8voSGno8HwPH5Rkh+Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYLjGDyg61omCXDRJEGsUHy/Y8yhVjt3XBOFEWT5DvBNW6/wOkTN2nrQp//iiamco
	 J45Glob8YuJJh248GDDrl9TvvXrChdoD7QW45DlK+jNseB10iVb6OnmzEJ7xSGuzz9
	 MNqe9qt+Qb7aId7UG9ql6sLsx41tmjPUF2m9Gyb6H+0oKPeelgHh5uMD4f3yUA+N3s
	 pXJsbZj69JuOo6hD01OFutFh7AwX5KIzlGFK2VNDQL+Oya5JE+s6s+UNqy8JNSaPp3
	 fPz4UJpOsugVgQRAEXpxCWnwEi6NWKzIdnWUHVOV6XH4J7B38d6Z6oTtR/T8AdgX4d
	 rF7Vq6exNhoMw==
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
Subject: [PATCH 04/14] mm/memory_hotplug: simplify check_pfn_span()
Date: Tue, 17 Mar 2026 17:56:42 +0100
Message-ID: <20260317165652.99114-5-david@kernel.org>
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

We now always have CONFIG_SPARSEMEM_VMEMMAP, so remove the dead code.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory_hotplug.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3495d94587e7..70e620496cec 100644
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

