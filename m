Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862C33066F
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904719; cv=none; b=P/6m4BTG2YxR7q2Ni69zHN1jlLYGdyMZ0z0fzzaoGQ48WEkG1XzwuogKuWpNGwFv/f17+qpr9c622lG8kxhUJwuum83g5T6ZRqskH8r7yVQDKeFi3TSEFzxLna7KgGFmf6guhTv96k2Q0wi7qdVxpE2hFUVPQ316QQTpcPe0/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904719; c=relaxed/simple;
	bh=c/gsoPA1qi7y8pLF+dvyA8iXUBOT9HWWVXTbFcFFRno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDl4IxxkH6IiQkxl7S8zLrl+9jGzdV/KJy7gc3SCfJzY4n4TLOqjdBrkr9TKvEU59fQjP5bl/EPIQL8UVKhhMfuuVN4YM55OhNw3xtUx7fA/FRzdv/tHwXgvEq4XMDXgquSBNAKxld2d4O8drr5Z/ps64p2yf1k5cnCrWHa4y2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CUBIwEtM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CUBIwEtM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4f1b212ba25so30774431cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 12:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904715; x=1768509515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+FiscnY2dd9CMZcfeOt+saJiVQsfJ0OYuH1fa+Xrtc=;
        b=CUBIwEtMezAFTsr7nKdE2cQFCpk8+sFgukBxxvy98gOP+Ou9aVyRIk8DtZaZa2auQv
         IQp62xbbbNyhCKmOwhgrKWVNQiRNwyIUMycw457dSeycl1vACd5fyfG9V1nC761MtleF
         iaOPjGPXOkkfezn4Ju8F3qsJEByOH6mePQ80qflBR3aXNfc2Xhh+Zc3dFXh1liLpeYyY
         9ZUj1Tb0m4FldfC643KR+MN0EaZQLIcZ8VY5nYdjOkHejho8vBiPKpl51fCjlfNY3h8+
         JhV50umCOdRf+N824YmBatKtTlMSgUOKxl2OAsEGu2H72zocV8GUgB9xGSDMxpvB5xS2
         SR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904715; x=1768509515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+FiscnY2dd9CMZcfeOt+saJiVQsfJ0OYuH1fa+Xrtc=;
        b=j+GzZnuAso8sMCQwNN1NAwIWW95kA2Tyk3147tmlocKBdmm6rK4m7ZtpEh93W1tioi
         WJxas2EORjhiP9BJtVvlNU3V3UbfrqYX15vWxPQoj6R0xc1F1DJt9NOoUbCvinprxoQv
         ijw9+B6TaZGgNrwWiGRlK0zQj3up8kB6GXAkxxmc4RarTLpNqYb7snZVoE8Hcwj1D2I6
         fGVcH2qssaOWmCjjrEOjeTDEF/wqZpBVCRrNbCVwmH7/CTisKAug5oIyjM31olQHPvF7
         yELnWO/eAJO/elFesABkpkr7wHGKukL8IryUtWwKigdguyWS00XzS+SMgf2bg6D2mhmw
         rtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpTbAOTXXvKx0gJpQN6hXnrrG3cgvi3WMukUQQTu1jGDuTkpTzsO7U+fa0vM0f14SvodTkCtiGMos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjiDugabC8JpvXlJaG7Ks5ycvSB+zni05LCoIHOzMSxAw/OsFs
	4NEk5lDao+ROSlBc5k2fF9Z8qd3jWtCWofnhD3Srl1xOb+53D9Qy4m2H2BHScEOe/eg=
X-Gm-Gg: AY/fxX6Ejdz6Vbuy/ipOwjEa2u8Pq/SE9KpAiEdDAMAV6woOsLl3/HMmcr3AuW8B0fx
	3aKuanQEtAKv3Lvnmf0qYUYF0EaIQru+KN2DOhHRktHINA+VLB1f8OJw3uMGGJpTJ+yV3UCxORW
	ZQCG7FIPHkrO9fHGZJR7XqfWknFugGE7fJvdPSof5RIFugDgaqh+0KAjuUGQQcnSFaJA/mF/705
	tJTvgAc2Oc0s++BdX0quNduD+yp3z8rf7qUFVfeRIOPQw/THvVWIQE/ZdLDD2r52PHnh3ezcJz4
	AaEyNuyNE55wWljQIj/kn7pm3bd/rQMtQ9vgJIR/+gJNXWrUPIrRaE4HuwqIiJtWIQOiFONztMm
	e9zdY/YeD3j9j++fuiM2nnAi8hMgnOEgOa9jn11dePuHhzHi/ZqIJV2JhdTtthndhz8Ar2pZUlt
	tQDwDblXuY8dtFd5nyAHw8n1uzq50RIBEBvt2A8YPFEmFxMNJt0cF3lxvTsRQoT3Ty5xKajYLjW
	Tw=
X-Google-Smtp-Source: AGHT+IGgVKMRufuoIwNk6V89uYwrjMlLk/itQMcGhMZDRBQvLjiXAI9ku2u4EWxqz6DDG1P/QUPQlA==
X-Received: by 2002:a05:622a:181e:b0:4ee:49b8:fb81 with SMTP id d75a77b69052e-4ffb4a26a6dmr88539831cf.61.1767904715304;
        Thu, 08 Jan 2026 12:38:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:38:34 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	zhengqi.arch@bytedance.com
Subject: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for device-managed memory
Date: Thu,  8 Jan 2026 15:37:47 -0500
Message-ID: <20260108203755.1163107-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces N_PRIVATE, a new node state for memory nodes 
whose memory is not intended for general system consumption.  Today,
device drivers (CXL, accelerators, etc.) hotplug their memory to access
mm/ services like page allocation and reclaim, but this exposes general
workloads to memory with different characteristics and reliability
guarantees than system RAM.

N_PRIVATE provides isolation by default while enabling explicit access
via __GFP_THISNODE for subsystems that understand how to manage these
specialized memory regions.

Motivation
==========

Several emerging memory technologies require kernel memory management
services but should not be used for general allocations:

  - CXL Compressed RAM (CRAM): Hardware-compressed memory where the
    effective capacity depends on data compressibility.  Uncontrolled
    use risks capacity exhaustion when compression ratios degrade.

  - Accelerator Memory: GPU/TPU-attached memory optimized for specific
    access patterns that are not intended for general allocation.

  - Tiered Memory: Memory intended only as a demotion target, not for
    initial allocations.

Currently, these devices either avoid hotplugging entirely (losing mm/
services) or hotplug as regular N_MEMORY (risking reliability issues).
N_PRIVATE solves this by creating an isolated node class.

Design
======

The series introduces:

  1. N_PRIVATE node state (mutually exclusive with N_MEMORY)
  2. private_memtype enum for policy-based access control
  3. cpuset.mems.sysram for user-visible isolation
  4. Integration points for subsystems (zswap demonstrated)
  5. A cxl private_region example to demonstrate full plumbing

Private Memory Types (private_memtype)
======================================

The private_memtype enum defines policy bits that control how different
kernel subsystems may access private nodes:

  enum private_memtype {
      NODE_MEM_NOTYPE,      /* No type assigned (invalid state) */
      NODE_MEM_ZSWAP,       /* Swap compression target */
      NODE_MEM_COMPRESSED,  /* General compressed RAM */
      NODE_MEM_ACCELERATOR, /* Accelerator-attached memory */
      NODE_MEM_DEMOTE_ONLY, /* Memory-tier demotion target only */
      NODE_MAX_MEMTYPE,
  };

These types serve as policy hints for subsystems:

NODE_MEM_ZSWAP
--------------
Nodes with this type are registered as zswap compression targets.  When
zswap compresses a page, it can allocate directly from ZSWAP-typed nodes
using __GFP_THISNODE, bypassing software compression if the device
provides hardware compression.

Example flow:
  1. CXL device creates private_region with type=zswap
  2. Driver calls node_register_private() with NODE_MEM_ZSWAP
  3. zswap_add_direct_node() registers the node as a compression target
  4. On swap-out, zswap allocates from the private node
  5. page_allocated() callback validates compression ratio headroom
  6. page_freed() callback zeros pages to improve device compression

Prototype Note:
  This patch set does not actually do compression ratio validation, as
  this requires an actual device to provide some kind of counter and/or
  interrupt to denote when allocations are safe.  The callbacks are
  left as stubs with TODOs for device vendors to pick up the next step
  (we'll continue with a QEMU example if reception is positive).

  For now, this always succeeds because compressed=real capacity.

NODE_MEM_COMPRESSED (CRAM)
--------------------------
For general compressed RAM devices.  Unlike ZSWAP nodes, CRAM nodes
could be exposed to subsystems that understand compression semantics:

  - vmscan: Could prefer demoting pages to CRAM nodes before swap
  - memory-tiering: Could place CRAM between DRAM and persistent memory
  - zram: Could use as backing store instead of or alongside zswap

Such a component (mm/cram.c) would differ from zswap or zram by allowing
the compressed pages to remain mapped Read-Only in the page table.

NODE_MEM_ACCELERATOR
--------------------
For GPU/TPU/accelerator-attached memory.  Policy implications:

  - Default allocations: Never (isolated from general page_alloc)
  - GPU drivers: Explicit allocation via __GFP_THISNODE
  - NUMA balancing: Excluded from automatic migration
  - Memory tiering: Not a demotion target

Some GPU vendors want management of their memory via NUMA nodes, but
don't want fallback or migration allocations to occur.  This enables
that pattern.

mm/mempolicy.c could be used to allow for N_PRIVATE nodes of this type
if the intent is per-vma access to accelerator memory (e.g. via mbind)
but this is omitted from this series from now to limit userland
exposure until first class examples are provided.

NODE_MEM_DEMOTE_ONLY
--------------------
For memory intended exclusively as a demotion target in memory tiering:

  - page_alloc: Never allocates initially (slab, page faults, etc.)
  - vmscan/reclaim: Valid demotion target during memory pressure
  - memory-tiering: Allow hotness monitoring/promotion for this region

This enables "cold storage" tiers using slower/cheaper memory (CXL-
attached DRAM, persistent memory in volatile mode) without the memory
appearing in allocation fast paths.

This also adds some additional bonus of enforcing memory placement on
these nodes to be movable allocations only (with all the normal caveats
around page pinning).

Subsystem Integration Points
============================

The private_node_ops structure provides callbacks for integration:

  struct private_node_ops {
      struct list_head list;
      resource_size_t res_start;
      resource_size_t res_end;
      enum private_memtype memtype;
      int (*page_allocated)(struct page *page, void *data);
      void (*page_freed)(struct page *page, void *data);
      void *data;
  };

page_allocated(): Called after allocation, returns 0 to accept or
-ENOSPC/-ENODEV to reject (caller retries elsewhere).  Enables:
  - Compression ratio enforcement for CRAM/zswap
  - Capacity tracking for accelerator memory
  - Rate limiting for demotion targets

page_freed(): Called on free, enables:
  - Zeroing for compression ratio recovery
  - Capacity accounting updates
  - Device-specific cleanup

Isolation Enforcement
=====================

The series modifies core allocators to respect N_PRIVATE isolation:

  - page_alloc: Constrains zone iteration to cpuset.mems.sysram
  - slub: Allocates only from N_MEMORY nodes
  - compaction: Skips N_PRIVATE nodes
  - mempolicy: Uses sysram_nodes for policy evaluation

__GFP_THISNODE bypasses isolation, enabling explicit access:

  page = alloc_pages_node(private_nid, GFP_KERNEL | __GFP_THISNODE, 0);

This pattern is used by zswap, and would be used by other subsystems
that explicitly opt into private node access.

User-Visible Changes
====================

cpuset gains cpuset.mems.sysram (read-only), shows N_MEMORY nodes.

ABI: /proc/<pid>/status Mems_allowed shows sysram nodes only.

Drivers create private regions via sysfs:
  echo region0 > /sys/bus/cxl/.../create_private_region
  echo zswap > /sys/bus/cxl/.../region0/private_type
  echo 1 > /sys/bus/cxl/.../region0/commit

Series Organization
===================

Patch 1: numa,memory_hotplug: create N_PRIVATE (Private Nodes)
  Core infrastructure: N_PRIVATE node state, node_mark_private(),
  private_memtype enum, and private_node_ops registration.

Patch 2: mm: constify oom_control, scan_control, and alloc_context 
nodemask
  Preparatory cleanup for enforcing that nodemasks don't change.

Patch 3: mm: restrict slub, compaction, and page_alloc to sysram
  Enforce N_MEMORY-only allocation for general paths.

Patch 4: cpuset: introduce cpuset.mems.sysram
  User-visible isolation via cpuset interface.

Patch 5: Documentation/admin-guide/cgroups: update docs for mems_allowed
  Document the new behavior and sysram_nodes.

Patch 6: drivers/cxl/core/region: add private_region
  CXL infrastructure for private regions.

Patch 7: mm/zswap: compressed ram direct integration
  Zswap integration demonstrating direct hardware compression.

Patch 8: drivers/cxl: add zswap private_region type
  Complete example: CXL region as zswap compression target.

Future Work
===========

This series provides the foundation.  Planned follow-ups include:

  - CRAM integration with vmscan for smart demotion
  - ACCELERATOR type for GPU memory management
  - Memory-tiering integration with DEMOTE_ONLY nodes

Testing
=======

All patches build cleanly.  Tested with:
  - CXL QEMU emulation with private regions
  - Zswap stress tests with private compression targets
  - Cpuset verification of mems.sysram isolation


Gregory Price (8):
  numa,memory_hotplug: create N_PRIVATE (Private Nodes)
  mm: constify oom_control, scan_control, and alloc_context nodemask
  mm: restrict slub, compaction, and page_alloc to sysram
  cpuset: introduce cpuset.mems.sysram
  Documentation/admin-guide/cgroups: update docs for mems_allowed
  drivers/cxl/core/region: add private_region
  mm/zswap: compressed ram direct integration
  drivers/cxl: add zswap private_region type

 .../admin-guide/cgroup-v1/cpusets.rst         |  19 +-
 Documentation/admin-guide/cgroup-v2.rst       |  26 ++-
 Documentation/filesystems/proc.rst            |   2 +-
 drivers/base/node.c                           | 199 ++++++++++++++++++
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/core.h                       |   4 +
 drivers/cxl/core/port.c                       |   4 +
 drivers/cxl/core/private_region/Makefile      |  12 ++
 .../cxl/core/private_region/private_region.c  | 129 ++++++++++++
 .../cxl/core/private_region/private_region.h  |  14 ++
 drivers/cxl/core/private_region/zswap.c       | 127 +++++++++++
 drivers/cxl/core/region.c                     |  63 +++++-
 drivers/cxl/cxl.h                             |  22 ++
 include/linux/cpuset.h                        |  24 ++-
 include/linux/gfp.h                           |   6 +
 include/linux/mm.h                            |   4 +-
 include/linux/mmzone.h                        |   6 +-
 include/linux/node.h                          |  60 ++++++
 include/linux/nodemask.h                      |   1 +
 include/linux/oom.h                           |   2 +-
 include/linux/swap.h                          |   2 +-
 include/linux/zswap.h                         |   5 +
 kernel/cgroup/cpuset-internal.h               |   8 +
 kernel/cgroup/cpuset-v1.c                     |   8 +
 kernel/cgroup/cpuset.c                        |  98 ++++++---
 mm/compaction.c                               |   6 +-
 mm/internal.h                                 |   2 +-
 mm/memcontrol.c                               |   2 +-
 mm/memory_hotplug.c                           |   2 +-
 mm/mempolicy.c                                |   6 +-
 mm/migrate.c                                  |   4 +-
 mm/mmzone.c                                   |   5 +-
 mm/page_alloc.c                               |  31 +--
 mm/show_mem.c                                 |   9 +-
 mm/slub.c                                     |   8 +-
 mm/vmscan.c                                   |   6 +-
 mm/zswap.c                                    | 106 +++++++++-
 37 files changed, 942 insertions(+), 91 deletions(-)
 create mode 100644 drivers/cxl/core/private_region/Makefile
 create mode 100644 drivers/cxl/core/private_region/private_region.c
 create mode 100644 drivers/cxl/core/private_region/private_region.h
 create mode 100644 drivers/cxl/core/private_region/zswap.c
---
base-commit: 803dd4b1159cf9864be17aab8a17653e6ecbbbb6

-- 
2.52.0
