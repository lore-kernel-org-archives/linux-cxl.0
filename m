Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6340B360;
	Mon, 21 Sep 2026 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020885; cv=none; b=FDv+57asQ/DwZjyKGYbky8MuqeHYUoliJWoA64gexca/9mxvlOg14TSz7Kbn6gjBd9++jGFfYFH0XtOLFJxtFZ8gvTwxlNPkVSKP4S0gRnq12Rts9JDJekXd/NaiXu3m7D8catcaGQrNdsUqckOFCQeI1UkVsBIcxYvbOC4IG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020885; c=relaxed/simple;
	bh=wS9y+w2lDfEszO4z/i/MtEKk8SGbU5ElVBcX2HbtZBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3Mcc8qavhFQtY2UM9Ay+iPoGWZl+GLQ2Sr7AppCpw7/MPXnKRNOxR3U2NYH2OHDgxykd+uRJZYydStQvOu7zYFZ6wBSJmuEQIt14WsJk1nvw1RoxVvM9cDaQkzXkRun2jNgLpYBl9+5HHQrW5KdBp5S1KHM+YOSwssRiMlDSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElKC23rv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElKC23rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB2A1F00893;
	Mon, 21 Sep 2026 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020884;
	bh=Zg9d2/OMUG70qYu7TGJ+44plepcpjkecBMRJ5CVA3ok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ElKC23rvyO1EuK7ppMEoqRlqUUtGVy9Pz99ZAK05LZl3sJAPS75pzvrKqOsPpMgSb
	 FTEy/U2s99jvXjlClKts/61uXJrC7PNs5Epfa9Ml3BSUNVIX4qPifcyM5sI4VnmLVU
	 cm+xh/89Ej/nrPYsQkBbXBOkGWgAAr/hPCA62KX48Znd7jlaSKZKGiH1v2oKkfeYf2
	 c+/9CXxxMqPaexpw+ptD0gfSJkdiuNr0xZWKWLEYmjtFZkOJocwym4L156YICwZmVM
	 X9C4Hcqq/vLNsn0djO4/LCjOEZ/JH9R+fjbZRDcyxD00LGgKcMemXOFR+XDlM14Y6h
	 oV0lnvOj+dCJQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:59:05 +0200
Subject: [PATCH v2 13/13] mm/memory_hotplug: drop
 CONFIG_HAVE_ARCH_PFN_VALID handling from pfn_to_online_page()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-13-54d81d65e125@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=david@kernel.org;
 h=from:subject:message-id; bh=wS9y+w2lDfEszO4z/i/MtEKk8SGbU5ElVBcX2HbtZBQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rTv7z8j2O2UNOnPlhj7adzO/DcSrXuzc8wyL7/j2
 fR5wuXDHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExkdjIjw5OOOasDtXXZFWsu
 mq11P5rI8LLx5J5zS/rTo17pzi7hnMLI8LBoT8j79/clv2qv5/nSPOHy5oshduf3T1LfdzFzaeN
 8AU4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Drop CONFIG_HAVE_ARCH_PFN_VALID handling, as CONFIG_HAVE_ARCH_PFN_VALID
is never used with CONFIG_MEMORY_HOTPLUG, as the latter depends on
CONFIG_SPARSEMEM_VMEMMAP. Make sure it stays that way.

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory_hotplug.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d7a59167bec43..796af1028ee23 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -345,6 +345,8 @@ struct page *pfn_to_online_page(unsigned long pfn)
 	struct dev_pagemap *pgmap;
 	struct mem_section *ms;
 
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID));
+
 	if (nr >= NR_MEM_SECTIONS)
 		return NULL;
 
@@ -352,13 +354,6 @@ struct page *pfn_to_online_page(unsigned long pfn)
 	if (!online_section(ms))
 		return NULL;
 
-	/*
-	 * Save some code text when online_section() +
-	 * pfn_section_valid() are sufficient.
-	 */
-	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
-		return NULL;
-
 	if (!pfn_section_valid(ms, pfn))
 		return NULL;
 

-- 
2.43.0

