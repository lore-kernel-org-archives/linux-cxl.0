Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA73358A7;
	Fri, 20 Mar 2026 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044824; cv=none; b=JFkHZC0v6M8yOlqP8f+yQvmOXxtWALdO4+3yN//HH1OHd3+B4+WVWJkk6q3hxzVHC4mF9Om5iZckSiQi2aqW986Atg+BUPxullJoHfuumlgUxjMROwBL2Dmm2mGJ08TmTpDx8XDAKxWphvV0sTBoGLZ9I9CPXXZeLIIryQpSAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044824; c=relaxed/simple;
	bh=37kqOOQ/gFodAPx12yyeumULM8pbIZCoL7z8zOpqXf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XfcCh1WB96Fo6qGrLi9lV3Zpo8ID8ZOeteIlJC+/DPO9qTbnsnoZDDJekocl40VPbUlVrjRdfPHB64iK0Nfhx7UqN+2fUu46goTaqP3x3xZ1zOvrZzqmedztOOQPmySyQD4rB/CCsgV3BtI1aYD5RCnVPoR0e8L+r30Z0zwXw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edSADuQC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edSADuQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B76C4CEF7;
	Fri, 20 Mar 2026 22:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044824;
	bh=37kqOOQ/gFodAPx12yyeumULM8pbIZCoL7z8zOpqXf0=;
	h=From:Subject:Date:To:Cc:From;
	b=edSADuQC1oEMW8dWWkRDylnwWgm554uxai5oA30QCHdfBcxx4gOYFfiqWlcULOlqU
	 ncAaN3x4odTUE7sqhieG30e+G5T5QVoPrf7LOtIJ7zwdc+jYAjo3uQVMqrNJJeh1LB
	 DefP7y/8KZQ3EQqwTivr2WJB8+ThJMSrvnvqxjBK48P30+vR6WyYgGnKflj4PDoN20
	 fc+1htlMz3x4PfxkDaXOgkjLuHxDzWNJrNrvLmOg4S39caX01QjKalCc28jgt4VjTQ
	 9M5CShjf0Cxm8//D6d5EnadKWZp4/rpCDYo+myXErcH2J+u377GWSp5NAWjvaKVldb
	 +dnQ/VfibsdLA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 00/15] mm: memory hot(un)plug and SPARSEMEM cleanups
Date: Fri, 20 Mar 2026 23:13:32 +0100
Message-Id: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIzGvWkC/x3MQQqEMBAF0atIrycQekTBq8ggMflqg2ZCGkUQ7
 25w+RZVFymyQKmrLso4ROUfC/hTkV9cnGEkFBNbbuyXrdHksmLDNvgVLu5JjUcdwsi+bgOohCl
 jkvOd9r/7fgDwqvASZAAAAA==
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

Some cleanups around memory hot(un)plug and SPARSEMEM. In essence,
we can limit CONFIG_MEMORY_HOTPLUG to CONFIG_SPARSEMEM_VMEMMAP,
remove some dead code, and move all the hotplug bits over to
mm/sparse-vmemmap.c.

Some further/related cleanups around other unnecessary code
(memory hole handling and complicated usemap allocation).

I have some further sparse.c cleanups lying around, and I'm planning
on getting rid of bootmem_info.c entirely.

Cross-compiled on a bunch of machines. Hot(un)plug tested with virtio-mem.

v1 -> v2:
* Added "mm/memory_hotplug: fix possible race in scan_movable_pages()"
* Update the comment above section_deactivate()
* Reordered the flags in sparse_init_one_section()
* Patch description improvements

---
David Hildenbrand (Arm) (15):
      mm/memory_hotplug: fix possible race in scan_movable_pages()
      mm/memory_hotplug: remove for_each_valid_pfn() usage
      mm/sparse: remove WARN_ONs from (online|offline)_mem_sections()
      mm/Kconfig: make CONFIG_MEMORY_HOTPLUG depend on CONFIG_SPARSEMEM_VMEMMAP
      mm/memory_hotplug: simplify check_pfn_span()
      mm/sparse: remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG
      mm/bootmem_info: remove handling for !CONFIG_SPARSEMEM_VMEMMAP
      mm/bootmem_info: avoid using sparse_decode_mem_map()
      mm/sparse: remove sparse_decode_mem_map()
      mm/sparse: remove CONFIG_MEMORY_HOTPLUG-specific usemap allocation handling
      mm: prepare to move subsection_map_init() to mm/sparse-vmemmap.c
      mm/sparse: drop set_section_nid() from sparse_add_section()
      mm/sparse: move sparse_init_one_section() to internal.h
      mm/sparse: move __section_mark_present() to internal.h
      mm/sparse: move memory hotplug bits to sparse-vmemmap.c

 include/linux/memory_hotplug.h |   2 -
 include/linux/mmzone.h         |   6 +-
 mm/Kconfig                     |   2 +-
 mm/bootmem_info.c              |  46 +---
 mm/internal.h                  |  47 ++++
 mm/memory_hotplug.c            |  35 ++-
 mm/mm_init.c                   |   2 +-
 mm/sparse-vmemmap.c            | 304 +++++++++++++++++++++++
 mm/sparse.c                    | 539 +----------------------------------------
 9 files changed, 377 insertions(+), 606 deletions(-)
---
base-commit: 3f4f1faa33544d0bd724e32980b6f211c3a9bc7b
change-id: 20260320-sparsemem_cleanups-ce4ddb2c47de

Best regards,
-- 
David Hildenbrand (Arm) <david@kernel.org>

