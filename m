Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555513F54A5;
	Tue, 17 Mar 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766650; cv=none; b=UQqpVlq6ZvRMez60Mmzd5gAPK5k3NX7m+UeIMygN9XUqELSZ3tKnA1RtAu6ZSfZjlbB/ddy3F0Qp7yxlU+4gp/L/Cx+aHGSSU97heb0g7+aU0dIw8CwzLEYZbFuZSC60fzOf7294hzhMDELOi8s60LfWysbAfAREKoJJk47WW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766650; c=relaxed/simple;
	bh=zAVH1p8bTgDOcqmWvthlvGourqrwWep27NazNV4QaoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJSRR01FUJknNw2IOjpYDicYaTuH2XeQvP2gtjW6lNC8MK5qgTCTBDzbxPo2ZSQmGMqRQyz7IZfPUtvjhxGXb05gVI1eAQLlXiwOHOJTapPy2d1WXSsCJ6ErOf6ip2ZvwLTRT23QsivFPMkpxLglb+a1iIVzXYXc/uiy+bR+oSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2Vujhz2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2Vujhz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A0CC2BCB1;
	Tue, 17 Mar 2026 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766650;
	bh=zAVH1p8bTgDOcqmWvthlvGourqrwWep27NazNV4QaoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2Vujhz2LgkspV0Vdwe1zUr0moAccQujcKxybghmQZ6XXT5iXSrfQPoxTPir/ka6o
	 Ro5dnqMDCEFwJa2GKmu+8ThHTiTINRru4qBFl7I2dRo2z5eAX5yxdiClX8uIk1HBYI
	 9TEZDo12vMIKg1hRdsEc6SD2MbIuMAjmXDrLKGFBV3lXZfVZEysQZsWFnQFl+80jbO
	 9U6FAGd5plj1NWSHwynZCMLun5fFMWHYreRqzZ0jaJnHqPvgPCI1Ly3LxJKsZpVWEb
	 qNF7flFZvow1mgTGZN1MwGBMW7oDmUz6b4r9JT3ABYsXaoAwS4HMVMmUUCbS9S4tvc
	 u/wNBLoRqyJhA==
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
Subject: [PATCH 07/14] mm/bootmem_info: avoid using sparse_decode_mem_map()
Date: Tue, 17 Mar 2026 17:56:45 +0100
Message-ID: <20260317165652.99114-8-david@kernel.org>
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

With SPARSEMEM_VMEMMAP, we can just do a pfn_to_page(). It is not super
clear whether the start_pfn is properly aligned ... so let's just make
sure it is.

We will soon might try to remove the bootmem info completely, for now,
just keep it working as is.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index e61e08e24924..3d7675a3ae04 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -44,17 +44,16 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 {
 	unsigned long mapsize, section_nr, i;
 	struct mem_section *ms;
-	struct page *page, *memmap;
 	struct mem_section_usage *usage;
+	struct page *page;
 
+	start_pfn = SECTION_ALIGN_DOWN(start_pfn);
 	section_nr = pfn_to_section_nr(start_pfn);
 	ms = __nr_to_section(section_nr);
 
-	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-
 	if (!preinited_vmemmap_section(ms))
-		register_page_bootmem_memmap(section_nr, memmap,
-				PAGES_PER_SECTION);
+		register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
+					     PAGES_PER_SECTION);
 
 	usage = ms->usage;
 	page = virt_to_page(usage);
-- 
2.43.0

