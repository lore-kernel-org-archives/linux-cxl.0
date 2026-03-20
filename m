Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E33446A6;
	Fri, 20 Mar 2026 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044837; cv=none; b=TAU0WzhgGcYniEFvkPmDlEd8GEOZXDEFjKMiaw+SQ5rG5EKlCjj6p+DRG5n76kOsiU2seRz9cr3Yf1rZTQfEYbhqKikTsTPm7EoaMlcWSzabOaBNX/doYexL21/C37VTG7/IlFS1gVPfwbFvWSDfSQOPj2wImhjRZ6k+v5KDlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044837; c=relaxed/simple;
	bh=qGQ4S0Dk5OWFFlnh6q01L6aeYnQdqeH7CkkASIBS58U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTm0CM+um450/LCrmpdHf/hyXVv17a4mjBmLkNdsEss9/yG2cdBvtGpYFGbHIImgIE7kP1HOxxNE20/QWHCrZfKXVb+KOHlbBlV+KzRKKJKnJ3qwPALcYbIR0tl/52GrJJRIN7R+5AbmZSlpISuWSmuD4IBsgK0poLHSz9A0U+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax+3vlpI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax+3vlpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E915EC2BC87;
	Fri, 20 Mar 2026 22:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044836;
	bh=qGQ4S0Dk5OWFFlnh6q01L6aeYnQdqeH7CkkASIBS58U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ax+3vlpIZDyDFxIGzU4ohpjnZ07lb6mXpCmB5SmtxOCikYKHnwhZR+rhhZ3Ots9Bn
	 vHSVkAjBM3wfALykYjhp/MkzWzNvKTEd9sUM3Tw4byVmrY6/sDQ9Ob/KzLPVV38hHy
	 ivcccHnThBm+RNKbO79irp0quB1fH4ydlStXcOe0Wg8BDnojiIJshFcUy5lL2kBMkJ
	 ItQMpEA4sP1pRzpMZBjhJ9DCJmiw+MmjRupYS7CRNoQxTOeMI+PVLfKqkHhVNAvBZe
	 WYFhpaCfdn1jTQT6GaVjgORf7rnYt4myxTj3ldG0Zr25VPkt2/Jzbu6xvGk8fc9FDq
	 WP0dgVm9VXsdA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:35 +0100
Subject: [PATCH v2 03/15] mm/sparse: remove WARN_ONs from
 (online|offline)_mem_sections()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-3-096addc8800d@kernel.org>
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

We do not allow offlining of memory with memory holes, and always
hotplug memory without holes.

Consequently, we cannot end up onlining or offlining memory sections that
have holes (including invalid sections). That's also why these
WARN_ONs never fired.

Let's remove the WARN_ONs along with the TODO regarding double-checking.
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index dfabe554adf8..93252112860e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -638,13 +638,8 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
-		struct mem_section *ms;
-
-		/* onlining code should never touch invalid ranges */
-		if (WARN_ON(!valid_section_nr(section_nr)))
-			continue;
+		struct mem_section *ms = __nr_to_section(section_nr);
 
-		ms = __nr_to_section(section_nr);
 		ms->section_mem_map |= SECTION_IS_ONLINE;
 	}
 }
@@ -656,16 +651,8 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
-		struct mem_section *ms;
+		struct mem_section *ms = __nr_to_section(section_nr);
 
-		/*
-		 * TODO this needs some double checking. Offlining code makes
-		 * sure to check pfn_valid but those checks might be just bogus
-		 */
-		if (WARN_ON(!valid_section_nr(section_nr)))
-			continue;
-
-		ms = __nr_to_section(section_nr);
 		ms->section_mem_map &= ~SECTION_IS_ONLINE;
 	}
 }

-- 
2.43.0

