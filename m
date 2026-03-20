Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75435AC11;
	Fri, 20 Mar 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044857; cv=none; b=nHRtDARj9Zp99CUptJVSaQR39UHpbBLIdOk3gOZ8eLUeEw9EKOaO8mrJjARrwjva6OvEZtxfZ6Ah6Pi8cYJ4RRFiYamRLhhNeRt8FV+NaTNbh+/og9lyIk7xuqXd4IRYhHIfkgm9xbyHuygIQ9JqZEwzFjXo6i9rYBPdaLIZphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044857; c=relaxed/simple;
	bh=0oSe+G0ox51l+rDc5XWCPrdWsQFUFWnEkGK5VjFVki8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLFEWWA2NMhe+sNR0ztJMp9EP8p+pL+AT3yI9YpVaUAwObXr56m3djaLRxLzbZlYZRO8d0qK3yUrW7kuEv5X8PQuft6IYbZbz6+xIsRRCiVd2Ycsl9BR+9kF/qmTG2+l7CDNZOYkmrWAo+1wJYa97Q2hS4VOzt8a8T2dPZXgAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0/W1BGD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0/W1BGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CEAC2BC9E;
	Fri, 20 Mar 2026 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044857;
	bh=0oSe+G0ox51l+rDc5XWCPrdWsQFUFWnEkGK5VjFVki8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H0/W1BGD21v37hv/vshpWeZPJIUG7Z+PAKpQpegkE2rMSL3nV8vmemwLkEqmGAqKE
	 aIJLxod5bPaIFhk0JEsIr2N4weldzrcc3Zw0DZ3mmlFMdtwYshMcQDTU2fV+pEaEhl
	 ZxWCkhqP3o9gcshisQvElHE8kAh8IjNxbkSoQ9R9CtK3DOCzidXm/vTlDvzpBAi59j
	 6vFWDdibKp6aLhEqrtJX9ezac64PXtpbT0N87txVKuXyOR009EjU+zhfmYKViMllk5
	 vce7g6QiPvGzq04BJqmkHud3AcOGsiQQsI7+czklwG/3ApFXHs15UsEjogrRFAzOBr
	 KTMrQCRHHzHxQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:40 +0100
Subject: [PATCH v2 08/15] mm/bootmem_info: avoid using
 sparse_decode_mem_map()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-8-096addc8800d@kernel.org>
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

With SPARSEMEM_VMEMMAP, we can just do a pfn_to_page(). It is not super
clear whether the start_pfn is properly aligned ... so let's just make
sure it is properly aligned to the start of the section.

We will soon might try to remove the bootmem info completely, for now,
just keep it working as is.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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

