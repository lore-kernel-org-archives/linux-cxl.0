Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38A3F54CE;
	Tue, 17 Mar 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766667; cv=none; b=gNBpbO4b3nwQFXCCeZoqw3eaYzdFRSUkPHnjhBiSmV/5/A8MF+t7e+He/CYREp7LMPqUv5wRRq66EBYi3unqV7iKLMFWpQ0IhOu5xLxCowtVki8m4i11qpiVpGWdYjCRq8zLjAtkWuVjEM2yP6IbgtlNsX1sthvoUUVL92VYlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766667; c=relaxed/simple;
	bh=GmzhoQ0PJsvg3r41ZGNVjXu6dhy2NO2MgeEoTaVUJyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkfI/Re8iavQ1zRA4yfNW213wQJUclgZpYGS+5LtMOZADm+7K0LcS0OwMsN57/NK1ln7gWzc0GTBlGjTbSn7yL1OVkXLgruYWmzAwnpd22I6BmU1mLDPBIpq279RHCBGIK4CnezZZFOa4PdoqDGvLI8lpJOUbsm3lXm0IwZp3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvOITOgO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvOITOgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E24C2BCAF;
	Tue, 17 Mar 2026 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766666;
	bh=GmzhoQ0PJsvg3r41ZGNVjXu6dhy2NO2MgeEoTaVUJyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvOITOgO+ibK/lPOLHPXPeB+/05jkCMxW9PlT0bA7fNiSqObIrPhWQfImj7g4NsUq
	 Imap3UUZb/Tp92VIG/zhLpyI/ggtGmC52Tg17EJDKgxFAAbSbIyPBQcNonDJOD1ocO
	 L8whLAIiEhbgmmYDfK3CdjQ+aUo7ddrVdb+qeRT4lLLZqEq7USP2ESW+zqcvTd0sYT
	 YfZHO9mKUGFpb6acRxS0xvf8lbNt07LJo1J95hp1nZA9qI9DHCQqVIi/4ZYj9rmbQA
	 +NURaueDz8fkDy4jRiEVRYtzvnnIoPxRfsfcFjvpDQcQRwlcUlyEVMvJ3rwghpVy7e
	 99r7NDF8B9EGg==
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
Subject: [PATCH 11/14] mm/sparse: drop set_section_nid() from sparse_add_section()
Date: Tue, 17 Mar 2026 17:56:49 +0100
Message-ID: <20260317165652.99114-12-david@kernel.org>
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

CONFIG_MEMORY_HOTPLUG is CONFIG_SPARSEMEM_VMEMMAP-only. And
CONFIG_SPARSEMEM_VMEMMAP implies that NODE_NOT_IN_PAGE_FLAGS cannot be set:
see include/linux/page-flags-layout.h

	...
	#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
	#error "Vmemmap: No space for nodes field in page flags"
	...

So let's remove the set_section_nid() call to prepare for moving
CONFIG_MEMORY_HOTPLUG to mm/sparse-vmemmap.c

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 7b0bfea73a9b..b5a2de43ac40 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -769,7 +769,6 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
 	ms = __nr_to_section(section_nr);
-	set_section_nid(section_nr, nid);
 	__section_mark_present(ms, section_nr);
 
 	/* Align memmap to section boundary in the subsection case */
-- 
2.43.0

