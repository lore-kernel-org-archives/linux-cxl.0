Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AE4A384F
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438112; cv=none; b=eIcghf/5YtdDBetDsD3+2n9jT7NjHzJrWy3Pw+nNARhs/lv56vQt5rZimM1cFTyB5sQuSd22pbcxzcIGsdUlQJiBd+qmBOSPhH3KFYvn4oByWVTx0O1JA2Vg+F0VdWgeOnGmAjL9mdQ1iX3KqVQxkdyBETk5HXoNROhqIuM5Hik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438112; c=relaxed/simple;
	bh=1xK9WvOdopCQR3xT8/KKn1WUP9dISFUQ63DhqRI1yGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=af3L/IOkbbF7RF5ctLNhhbd5GqWfCVnJGADsDzN3qeFzifLIMAnIt2vDCfR1Up4n9NjFS+jXA1riiOfCy8FHl4ZCom1pPJkOfgjNa4oldQapcFlhkr34/OhSJ5LldGCqkiy1+Wsst5MlgeQArocluNkCM4JaPOw6oPp27TSDsxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZOZMgHT8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZOZMgHT8"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-851cbd64814so996609b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 03 Sep 2026 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788438103; x=1789042903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eoj/Cdya14SPLIE+VKDTIKpgRBY75qMbCQGmPe9FWn8=;
        b=ZOZMgHT8PXtoPkqvhqJR/vendSycyAVYQezQK1nYzDtHrz5L6u2GuOe/qImfnNvSdy
         W1Q8pXZ3iMn4h8T106eim1zOo+gFtjorISeaynxTc3xL4l5S+svlBgEeINunnD9MLL5K
         7GGjKc6oQQkUs7f/IXIifOBSGHS6SE4RuUl4ziJkxmTAt8+QhCK+656bvg+tzfC0pb0D
         C51xbQOUGx/g8eosXJXS2kYyu4Q0Ve4B+r6yo1yafdctL2Zg58E3Zr02p6pcCFL8mJlE
         yaGRSI4ymls4+TN3LF+5+cRE6yMV48xHYhMAP2bzXTW5maKqzkdA5mfFZ4k+SonWMoeg
         QTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788438103; x=1789042903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoj/Cdya14SPLIE+VKDTIKpgRBY75qMbCQGmPe9FWn8=;
        b=TTGqm/OGDHFba1VfwPze6QogN3IhgiMoRrWZusc+IJniatwBd3r69tl+1AJYt3uMw5
         /NlAXDLwJWeAZgUO5n8LxZDCWk3Ce/TEmBv9cQ2b+XJK5VO1QOF6TZ7CtNpCmkWQOOKF
         465bEj86xX/jj4KlbDGXjeDPXk0AKcJiBhixx44reMrhnvgKbB5PZ0nIZVRUOdTmocOm
         AGlp3H5FP3Oaq4vbS0HzTdeF2zpZMEzPANkB2USAflsBCSAgxJilXn4bIYplrE+ZJmpP
         BFlZkPqy18QIFgb/M7uuIj+0hRXUenvnvdhcmTC2537dhLFb4ea4ERGbILIVqzULAe1W
         FL7A==
X-Forwarded-Encrypted: i=1; AKwUvBxmtmrGNxnH4fZ479Yb3GNa/rMY0FnedH+Njn5TwIaCcnstDhUk9cK4B//oDcbbBM3D19XUvTNAZ1w=@vger.kernel.org
X-Gm-Message-State: AFuF++my+BA+BS023d5dMqsJ3eZwpoNAjM7vxlSTCKwMD+IfwKhQoPdh
	HmDZzLrUqa2ZXy36czJVMtlBZtwYf+ltqfcp1CprLTV/MGCFWJxavqYP7yQbGAyXd9Y=
X-Gm-Gg: AYBFou1eOKUpN5wjsvrtlLMnh33ayLVkHVajH8KWBxw2LZVLbLnj4AGzsfvlSX+fc4u
	Vg86Tl4+7hkg+hj9OxIYzn813hN+I5fYkHScz3SEGH3mZqxJBk5DtU4oLEM1DKfHea1RPYFNlcm
	CeiWw/UiTGJqpkR4Bu3iC2G1OW0r5X1d4tnM5BHqjUV9HMxP6wQILtlxQQ8nY6U9/jUv96f13su
	Kd9Fo2SQR7RLk+ylbUljCIvdtwb2igF26W+QbS2Ig0iwNoRreCwu26W3Gqwk9lYo5zJ0eDQ4/Yt
	nK0PNmSPGdq3yKP1W02u3bFxUn4lw6v9f0XLgPkwB9BMzgL4+wqzb6uNENXvDDY5vNRY0X9aN5s
	NO3SSVCH3TC9cQ1S9cTp/MUdEzM64c4dMd05k0K4k4ZE69KeCGiQ5nYSLI/qLDyVvw10m+Yo1tY
	x6+UbcaTGzXz5weN2v5g2I8X7YEzF+S6TdHVik9mZPCRC+7elfF5aTeMu68gqLfTm6kWRpfgyJR
	JQwwbkypKD4hHYefbN3Z1yKkg==
X-Received: by 2002:a05:6a00:c4c6:b0:85f:b00b:8760 with SMTP id d2e1a72fcca58-85fb00b8844mr9445221b3a.5.1788438103076;
        Thu, 03 Sep 2026 05:21:43 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f2076sm2868126b3a.4.2026.09.03.05.21.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 05:21:42 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH 0/4] mm: Reduce struct page overhead for FS-DAX pmem
Date: Thu,  3 Sep 2026 20:21:23 +0800
Message-ID: <20260903122128.12264-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AI and code-execution services increasingly run user workloads in
short-lived sandbox VMs. These VMs are usually small, densely packed, and
backed by sparse disk images, so both memory footprint and VM startup time
matter directly for consolidation density.

Using virtio-pmem with FS-DAX for the guest filesystem is one way to
reduce that footprint. It avoids keeping a second copy of file data in the
guest page cache, and turns that cache into host-side file cache that can
be accounted and reclaimed with the host's global memory view. Host-side
page-cache reclaim is also more direct than asking the guest to drop its
page cache, waiting for the freed pages to be reported back, and then
reclaiming the memory from the host side. This makes higher overcommit
more practical for dense sandbox deployments.

The remaining problem is that virtio-pmem with FS-DAX still pays the
guest-side ZONE_DEVICE metadata cost up front. The guest registers the
whole pmem aperture and allocates and initializes struct page metadata for
every advertised PFN. The vmemmap overhead is about 1.56% of the pmem
device size, and initializing all of those struct pages can noticeably
slow down startup for lightweight VMs.

Much of that private metadata is unnecessary in common sandbox setups.
Holes in a sparse rootfs image have no host storage allocated, but the
guest still allocates struct page metadata for the corresponding pmem PFNs.
Also, many filesystem workloads access files through read(2) and write(2)
rather than mmap(2); those DAX blocks are copied through the kernel and do
not need to be inserted into userspace page tables, so they do not need
private per-PFN struct page state either.

The key observation is that when sizeof(struct page) is a power of two,
each PAGE_SIZE vmemmap page contains a naturally aligned, repeatable group
of struct page slots. For an FS-DAX pmem range at device registration time,
those slots only need the same ZONE_DEVICE and dev_pagemap state before a
PFN is exposed to userspace. The kernel mainly needs the vmemmap to resolve
the PFN back to a valid device page and its dev_pagemap. It does not need
independent writable per-PFN state for ranges that are only accessed
through the DAX direct-access path, or for ranges that are never accessed
at all.

This series takes advantage of that split by separating vmemmap population
from private metadata allocation. Device registration still gives every
advertised PFN a valid struct page representation, but the vmemmap mappings
initially point at a shared read-only vmemmap page containing the common
ZONE_DEVICE state. This avoids allocating and initializing private metadata
for PFNs that may never need it.

Private writable metadata is materialized only when it becomes necessary:
before a DAX fault inserts the PFN into a userspace mapping. At that point
the PFN can participate in the normal page-based MM paths, so the shared
vmemmap page is replaced with a private writable copy. PTE faults
materialize the corresponding vmemmap page, and PMD faults materialize the
whole PMD-sized metadata range. PFNs that are never faulted continue to use
the shared vmemmap page, avoiding both the memory cost and the struct page
initialization work.

A natural follow-up is to make this optimization reversible. Once a DAX
entry is removed from the address_space, and after all mappings, references
and pins that require private metadata are gone, the corresponding vmemmap
page could be remapped back to the shared read-only vmemmap page and the
private metadata page could be freed. With that, the guest-side struct page
overhead would track the live DAX working set rather than the full advertised
pmem device size.

Patch 1 renames the architecture opt-in for runtime vmemmap remapping so
it describes the generic capability instead of the HugeTLB user.

Patch 2 avoids touching PG_hwpoison state for clean pmem pages. This keeps
the normal clean-I/O path compatible with read-only shared metadata.

Patch 3 adds the shared read-only FS-DAX vmemmap infrastructure and the
helper that materializes a private metadata page on demand.

Patch 4 opts pmem FS-DAX mappings into the new mode and materializes the
metadata before DAX inserts a PFN into a userspace mapping.

This does not change FS-DAX data path semantics. It only changes when
private struct page metadata is allocated for pmem FS-DAX PFNs.

Muchun Song (4):
  mm: generalize vmemmap remap architecture support
  nvdimm/pmem: avoid HWPoison flag updates for clean pages
  mm: add shared read-only vmemmap support for FS-DAX
  fsdax: materialize pmem vmemmap metadata on faults

 arch/loongarch/Kconfig   |  2 +-
 arch/riscv/Kconfig       |  2 +-
 arch/x86/Kconfig         |  2 +-
 drivers/nvdimm/pmem.c    |  3 +-
 fs/Kconfig               |  2 +-
 fs/dax.c                 |  5 ++++
 include/linux/memremap.h | 11 ++++++-
 mm/Kconfig               |  6 ++--
 mm/memremap.c            | 38 ++++++++++++++++++++++--
 mm/mm_init.c             | 11 +++++++
 mm/sparse-vmemmap.c      | 64 +++++++++++++++++++++++++++++++++++++---
 11 files changed, 131 insertions(+), 15 deletions(-)


base-commit: 32b6ef9a5d0eca44f9cd91f52f4faa89f145a0de
-- 
2.54.0

