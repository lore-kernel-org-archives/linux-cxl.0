Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59E3F54A5;
	Tue, 17 Mar 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766621; cv=none; b=Ui8uuCeeUlQ+RyX6rM/oy7A0DWrj6dVXbAkpS5IBnb+qAy/XD+XjUt77F20ey+NBEL3m96+0DVfqqWZX8W/0WpaEaJAyEhEkG20Y+NuzLkss7ra9ForVtZwPVR3w9STVohhJNUYYgfZ7K/QXa6hQeHqvm6gUaWcdUfjbuqVcac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766621; c=relaxed/simple;
	bh=4WgVt6EG/HFCGbU0HiZBZDpDmgR6tfOQ4rfofBAntFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hod86CH1Vg6BJYY+6cZ6KD7swNa8BDva6yffg0Zwe0ODbSpCba0WnPs6rY4NpoWiIgborYkch7Ja3G9knYo5BlY/nrs/9S3xkTFo5a78FPieuAlm4DXiJhf5UhNVrWnqn1HCE84wW7i2Z2IvTU1k3LJQC5yhvQHplI+0s2NuRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BviKTgEi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BviKTgEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D908CC4CEF7;
	Tue, 17 Mar 2026 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766621;
	bh=4WgVt6EG/HFCGbU0HiZBZDpDmgR6tfOQ4rfofBAntFk=;
	h=From:To:Cc:Subject:Date:From;
	b=BviKTgEiT7EcUlsk7PLxEp4xdjdmk5atU4hSdsAOy6wHSk7KJ8KxyhvvUHycVWfIV
	 sKd3jak2pOAJaIPtdfO6IEuT9TkKWNzj0rCREE4A5tQwtCCBStJ6XmQV870joLzToB
	 IVrwqv986PbxSFGr7LJIi4Cb22cG+oaFk+x5252QHaGC+HHW4vriTp7OcsYNXpLERT
	 cCkGpKTbKqUnllQhOkZvGrBFZKLbY16Qtwt2dWj0EZjrvSbj9BVzXuBshD19FMWShb
	 hYHBNPi4S1MJgdRK4QRQu/PGbg4HAuUtSS8M5DEqs2K87vXBjiqio96q65EWPNpxid
	 zSuz9kSYmWj4Q==
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
Subject: [PATCH 00/14] mm: memory hot(un)plug and SPARSEMEM cleanups
Date: Tue, 17 Mar 2026 17:56:38 +0100
Message-ID: <20260317165652.99114-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some cleanups around memory hot(un)plug and SPARSEMEM. In essence,
we can limit CONFIG_MEMORY_HOTPLUG to CONFIG_SPARSEMEM_VMEMMAP,
remove some dead code, and move all the hotplug bits over to
mm/sparse-vmemmap.c.

Some further/related cleanups around other unnecessary code
(memory hole handling and complicated usemap allocation).

I have some further sparse.c cleanups lying around, and I'm planning
on getting rid of bootmem_info.c entirely.

Cross-compiled on a bunch of machines. Hot(un)plug tested with virtio-mem.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>

David Hildenbrand (Arm) (14):
  mm/memory_hotplug: remove for_each_valid_pfn() usage
  mm/sparse: remove WARN_ONs from (online|offline)_mem_sections()
  mm/Kconfig: make CONFIG_MEMORY_HOTPLUG depend on
    CONFIG_SPARSEMEM_VMEMMAP
  mm/memory_hotplug: simplify check_pfn_span()
  mm/sparse: remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for
    CONFIG_MEMORY_HOTPLUG
  mm/bootmem_info: remove handling for !CONFIG_SPARSEMEM_VMEMMAP
  mm/bootmem_info: avoid using sparse_decode_mem_map()
  mm/sparse: remove sparse_decode_mem_map()
  mm/sparse: remove CONFIG_MEMORY_HOTPLUG-specific usemap allocation
    handling
  mm: prepare to move subsection_map_init() to mm/sparse-vmemmap.c
  mm/sparse: drop set_section_nid() from sparse_add_section()
  mm/sparse: move sparse_init_one_section() to internal.h
  mm/sparse: move __section_mark_present() to internal.h
  mm/sparse: move memory hotplug bits to sparse-vmemmap.c

 include/linux/memory_hotplug.h |   2 -
 include/linux/mmzone.h         |   6 +-
 mm/Kconfig                     |   2 +-
 mm/bootmem_info.c              |  46 +--
 mm/internal.h                  |  47 +++
 mm/memory_hotplug.c            |  24 +-
 mm/mm_init.c                   |   2 +-
 mm/sparse-vmemmap.c            | 308 +++++++++++++++++++
 mm/sparse.c                    | 539 +--------------------------------
 9 files changed, 373 insertions(+), 603 deletions(-)


base-commit: 3f4f1faa33544d0bd724e32980b6f211c3a9bc7b
-- 
2.43.0

