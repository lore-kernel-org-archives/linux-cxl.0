Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD23446A6;
	Fri, 20 Mar 2026 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044874; cv=none; b=FpKKE/3PuyomjzDMiFvdVzqZnJ3GVD4sEHO1irEFNmoaEs9eXD4au/5Ts9b6iTmfXKgt0BiVEAQcA3oS5OVA2HcvvN+MFojoIWbiXHG/uwQO5dEBUaPZNzFYJ2jl3uMch1IE85ahgpETfItUomPoNILhENDAgvXYUqMT/0TMYkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044874; c=relaxed/simple;
	bh=XAHrKqjSHvtKR09gmzZ7AHRzSFFlyVf9ZATZwJh+JJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehYuBgGdQjzbVDRPkPhe4FB9WF4m/648DhuLELwuGKT+9+uS341MveD4pO8ad5NnqZUQvu6E1mTgYYngS/hHGy8If5thkJKjgWnF2S3eFZys0h2C6M5iRm3a08FNsa6NLGQViPyVdpnBNVdgx0oOb264Je/GF+MmKNWnsKCnp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he83wHJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he83wHJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80082C2BC87;
	Fri, 20 Mar 2026 22:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044874;
	bh=XAHrKqjSHvtKR09gmzZ7AHRzSFFlyVf9ZATZwJh+JJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=he83wHJ6PtaTiQddZeECQUCHe56n6mKcu8hA4rCvY8qPeiTp9pvI0nuQaIgKVVheS
	 fwqIjKoF6a2O37LFplX2/a8iqRJ2y5b88VJmAJjAexMzHSr/d+OXTwuH0/n/aw/2kG
	 pe8AoJbYZCphhAsSJt9zKgebzodTB5GHH/Koby6PCMOF8Iu1iXweiApBOX/ngZQOY8
	 Ut4FR3P0CEhcyvu0plHJrghUEKD+R8c6gIhegpQU8Pn0h1NNnXjHlTCsHWDRdaxfCX
	 tzIzJ9xom8PLs1C920nHcEa68Y4UbWrSPDJXagKphEeyEcTAcA/nAsU3gkKICSeI50
	 plec3jOq8bwZQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:44 +0100
Subject: [PATCH v2 12/15] mm/sparse: drop set_section_nid() from
 sparse_add_section()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-12-096addc8800d@kernel.org>
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

CONFIG_MEMORY_HOTPLUG is CONFIG_SPARSEMEM_VMEMMAP-only. And
CONFIG_SPARSEMEM_VMEMMAP implies that NODE_NOT_IN_PAGE_FLAGS cannot be set:
see include/linux/page-flags-layout.h

	...
	#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
	#error "Vmemmap: No space for nodes field in page flags"
	...

Which implies that the node is always stored in page flags and
NODE_NOT_IN_PAGE_FLAGS cannot be set. Therefore,
set_section_nid() is a NOP on CONFIG_SPARSEMEM_VMEMMAP.

So let's remove the set_section_nid() call to prepare for moving
CONFIG_MEMORY_HOTPLUG to mm/sparse-vmemmap.c

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index c96ac5e70c22..5c9cad390282 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -765,7 +765,6 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
 	ms = __nr_to_section(section_nr);
-	set_section_nid(section_nr, nid);
 	__section_mark_present(ms, section_nr);
 
 	/* Align memmap to section boundary in the subsection case */

-- 
2.43.0

