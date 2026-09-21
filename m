Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118673F1051;
	Mon, 21 Sep 2026 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020755; cv=none; b=Fy2kABAGLDRsH5PRnwgiId36eYHQu1s1h/j6xjdgMAkhvYuzGbtUN/xIvhQrYP/6DtdRfW9Yx5nLwLzzLglSd/EGzXlW5qajwBlPYJ3z6Sp8dNvoXktPrGy9oZHfTMuc28bybxLXcCEQmtl/6myZl7qtwgiFbmBNi4Blw+euOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020755; c=relaxed/simple;
	bh=Av9neL0LEVkPlIU1KnqHDojloJ3A/Q9yM5MGKwqz6Z0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q40lFonglCdh5oxAXV9ap9gXQx2hQzfSC5uRvcoSap6TCLlMOW1TsszdcHRF5zsXkzRK2sMByxrsiJpMGtauGiniKWxy3oVLy5Hhusx9Cfp8J93HACVPDEuqXk21XdWMlaCNItYHw7pZM6fPTjx5RgceiLzoXIVP5q/19izt0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl18dBiu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl18dBiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882BE1F000FF;
	Mon, 21 Sep 2026 19:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020752;
	bh=iyANBTrd7/pQCJull/2ya68CuRnYwJGmlUALpFhfxZM=;
	h=From:Subject:Date:To:Cc;
	b=Sl18dBiuA4/EcO/wURcyJXVuiTjSKzlt0ZDnKrZ5DJGIgt1rmqDll6IZBY1wAtpO7
	 XTBMmLJIWLjdgi2EL5+yBmWA7R4uaeIldDhBCR9wcrzy3NfqCnrHDTHYXoayI4kJRk
	 dcSFZ9lgaTQeRv0VSUU30KLeJZfzWqFlOMoNdtIFO1PPltCeAMpi9Cbdu7WJ2qQpwL
	 MBa+i1zskmQrAOobZZhLzibU5sMolxgcgEepK4ENj1qOiN3zqd7R39uxym0bKelLHg
	 Rr8djNbHAnLlGg6+6VvWodq8iGgVslYeN/nOaG86PoI1jBU9eRRDD/2ZKmeBPKaCgf
	 r31F22OT7n6dA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 00/13] mm/sparse: remove SECTION_MARKED_PRESENT and
 further cleanups
Date: Mon, 21 Sep 2026 21:58:52 +0200
Message-Id: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHyMsWoC/3WNyw6CMBBFf8XM2poWqxRX/ochhpYBqlDIDBAN4
 d/lsXZ5knvPmYCRPDLcDhMQjp59GxaIjgdwVRZKFD5fGCIZXaVRWlgtuMuIscHm6WrMwtCxMNZ
 pq2OptDvD8u0IC//ZvI90Zx7sC12/ytZF5blv6buFR7Xu9kYikz+NUQkppDSFM/klTgq8v5EC1
 qeWSkjnef4B29vNdM0AAAA=
X-Change-ID: 20260814-b4-sparsemem_cleanups-8bc4b47014c3
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
 linux-fsdevel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3671; i=david@kernel.org;
 h=from:subject:message-id; bh=Av9neL0LEVkPlIU1KnqHDojloJ3A/Q9yM5MGKwqz6Z0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29jQWPntcY31479w5PF+UeARMPh39VhNd7ON83GDRY
 45yNbP9HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExkfRXDP0XnLbs+1z7pU53L
 8axpTfXE2/IfTrxlaA28+VFsh6bqpceMDFs2vRJtqbwXJNS4wl1zMff8iSK7/hzfrJDdtuHSquT
 EqwwA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

SECTION_MARKED_PRESENT is really only needed during boot, where we
can instead just rely on SECTION_IS_EARLY_BIT by setting that flag
earlier.

Some preparations for doing that conversion and some cleanups in the same
(sparse) area.

Tested on x86 with and without memory hotplug through virtio-mem.

---
Changes in v2:
- Rebased to mm-unstable
- Add "scripts/gdb: mm.py: remove fallbacks for SECTION_HAS_MEM_MAP and
  SECTION_IS_EARLY"
- Improve comment in mmzone.h for __highest_used_section_nr
- Improve comment in fs/proc/page.c for get_max_dump_pfn()
- Move __highest_used_section_nr handling directly into
  __section_mark_present() callers and use max()
- Make pfn const in sparse_metadata_init_nid()
- Take care of .clang_format
- Smaller patch description fixes
- Link to v1: https://patch.msgid.link/20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org

To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Kairui Song <kasong@tencent.com>
To: Qi Zheng <qi.zheng@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
To: Barry Song <baohua@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
To: Yuanchu Xie <yuanchu@google.com>
To: Wei Xu <weixugc@google.com>
To: Baoquan He <baoquan.he@linux.dev>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Brendan Jackman <brendan.jackman@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
To: Kieran Bingham <kbingham@kernel.org>
To: Oscar Salvador <osalvador@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org
Cc: driver-core@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org

---

David Hildenbrand (Arm) (13):
      mm/sparse: move mem_section init to sparse_extreme_init()
      mm/sparse: refactor sparse_sections_init()
      mm/sparse: move initialization of section metadata to sparse_metadata_init()
      mm/sparse: rename and cleanup sparse_init_nid()
      mm/sparse: cleanup sparse_init_one_section()
      mm/sparse: rename __highest_present_section_nr to __highest_used_section_nr
      mm/sparse: remove pfn_in_present_section()
      mm/sparse: move __highest_used_section_nr handling
      scripts/gdb: mm.py: remove fallbacks for SECTION_HAS_MEM_MAP and SECTION_IS_EARLY
      mm/sparse: remove SECTION_MARKED_PRESENT
      mm/sparse: remove flags parameter from sparse_init_one_section()
      fs/proc/page: clarify comment in get_max_dump_pfn()
      mm/memory_hotplug: drop CONFIG_HAVE_ARCH_PFN_VALID handling from pfn_to_online_page()

 .clang-format           |   2 +-
 drivers/base/memory.c   |   2 +-
 fs/proc/page.c          |   7 +--
 include/linux/cache.h   |   1 +
 include/linux/mmzone.h  |  43 ++++---------
 mm/compaction.c         |   2 +-
 mm/memory_hotplug.c     |   9 +--
 mm/sparse-vmemmap.c     |   4 +-
 mm/sparse.c             | 160 +++++++++++++++++++++++-------------------------
 mm/sparse.h             |  19 ++----
 scripts/gdb/linux/mm.py |   8 +--
 11 files changed, 108 insertions(+), 149 deletions(-)

---

base-commit: 8d61431ed2607386b427752505379536eb634ce8

change-id: 20260814-b4-sparsemem_cleanups-8bc4b47014c3

--

Cheers,

David

