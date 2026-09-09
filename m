Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C956329D;
	Wed,  9 Sep 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960835; cv=none; b=HjvnXHNkGj4S4JHgg87giMfF/irMmmFaScl/895fksi/1LnsJ+MNL2Jg7CJaTz/RSHVEr0i7etS9keLoKOTPvfYxeiVlD6Gw6PfYK7t0Z0QjdTc+uKbFUWfa6VdrFwIBqaO57cCaUlIaeKlhWExa3iQNSsblX++IPgb9C0R8iRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960835; c=relaxed/simple;
	bh=vPsWBsGCNqB0PxA+doAglYRMEh16VjGeSj5r8dRwLDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZUSmWULGO/us0x0vMFCDFXDB2IgxnuLHe3eSbMG+x7+xNDisH+qA2i0eRwxj3JhYpJQldPYoCLmjKrhCeYDV2x6xyKC9X/YhGTT1sMsQVPvLGO4fea6+eXHuiwaTF0mQsTyTn1MSO097AuogdL67nJCaQaOazv2/qYmsEsUgiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNKlq6KV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNKlq6KV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203D51F00A3A;
	Wed,  9 Sep 2026 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960834;
	bh=4kGoNxWFRU6HCIzI1KugsSHLIEvp/dTwub96govqYjc=;
	h=From:Subject:Date:To:Cc;
	b=TNKlq6KVjWttZMKEWLatKFAO4yVaNxPWVw3qMV6BBI/kYD1tPUDN6XJav3JbpOI0w
	 1hprAq+2eenRcnI09l3yL1lYL6zXbyMC8gBNgtJhzaQZeKvwYe8MkypIXcrK6BXzt9
	 KAuFWsHgxKPm52QF7ikX3RmcjHIuSf+nbKnGVk6izAj7NCbL2WbWlDFlgMoDjrB8B4
	 F9+MoCyfY54JJegtfkAEggcKD3zB5drGmrOEW7Ex4AlrRSMHt37+BsUQZjqcGDitxB
	 Sq4dDWgOEN/S3D0k1F59cdF2/cASJZnLRy7gO1qr739Eo2N9TfgYGa3eNAdGydBxLY
	 DMxERxjbgjhWA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 00/12] mm/sparse: remove SECTION_MARKED_PRESENT and further
 cleanups
Date: Wed, 09 Sep 2026 15:32:53 +0200
Message-Id: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAVgoWoC/yXMQQrCMBBG4auUWRtI6qDFq4hIMv7qiI0hY0Uov
 btRl9/ivZkMVWG062aqeKnpIzeEVUdyjfkCp6dm6n2/8UNgl9hZidUwYjzKHTFPxdyQhBNvfWB
 ZU2tLxVnfv+/+8LdN6QZ5fme0LB+i5Ns1eQAAAA==
X-Change-ID: 20260814-b4-sparsemem_cleanups-8bc4b47014c3
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097; i=david@kernel.org;
 h=from:subject:message-id; bh=vPsWBsGCNqB0PxA+doAglYRMEh16VjGeSj5r8dRwLDY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJshNX/ehIHmeqvOUj9N235rfU7DPdcXX94eLKsU2R
 3a9Ztz/sqOUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJLJnGyHB5Uck2xv3X2Zc+
 f/3sukK4oePZ7Yx31LOszlz/FCXTUDuT4Z9Ra5iA8l79y07bP5+JjZq8eW+29lJb1wsRlyzm/ha
 x3scNAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

SECTION_MARKED_PRESENT is really only needed during boot, where we
can instead just rely on SECTION_IS_EARLY_BIT by setting that flag
earlier.

Some preparations for doing that conversion and some cleanups in the same
(sparse) area.

Tested on x86 with and without memory hotplug through virtio-mem.

This is based on mm-unstable which carries Muchun's

	"[PATCH v5 00/17] mm: Introduce section-based vmemmap optimization
	 for HugeTLB" [1]

A (possible) resend from Muchun should only result in smaller conflicts.

[1] https://lore.kernel.org/r/20260825084608.47437-1-songmuchun@bytedance.com 

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (12):
      mm/sparse: move mem_section init to sparse_extreme_init()
      mm/sparse: refactor sparse_sections_init()
      mm/sparse: move initialization of section metadata to sparse_metadata_init()
      mm/sparse: rename and cleanup sparse_init_nid()
      mm/sparse: cleanup sparse_init_one_section()
      mm/sparse: rename __highest_present_section_nr to __highest_used_section_nr
      mm/sparse: remove pfn_in_present_section()
      mm/sparse: move __highest_used_section_nr handling
      mm/sparse: remove SECTION_MARKED_PRESENT
      mm/sparse: remove flags parameter from sparse_init_one_section()
      fs/proc/page: clarify comment in get_max_dump_pfn()
      mm/memory_hotplug: drop CONFIG_HAVE_ARCH_PFN_VALID handling from pfn_to_online_page()

 drivers/base/memory.c   |   2 +-
 fs/proc/page.c          |   7 +--
 include/linux/cache.h   |   1 +
 include/linux/mmzone.h  |  43 ++++---------
 mm/compaction.c         |   2 +-
 mm/memory_hotplug.c     |   9 +--
 mm/sparse-vmemmap.c     |   3 +-
 mm/sparse.c             | 160 +++++++++++++++++++++++-------------------------
 mm/sparse.h             |  21 +++----
 scripts/gdb/linux/mm.py |   2 +-
 10 files changed, 107 insertions(+), 143 deletions(-)

---

base-commit: b02c77c78ff74d3d88ea614335ae833e01ed5d30

change-id: 20260814-b4-sparsemem_cleanups-8bc4b47014c3

--

Cheers,

David

