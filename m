Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635C34A799
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694358; cv=none; b=tBgyCI386H+HhpshzC3yDQm0ffKwaCFSo+N2i2jeLUXStefWkmOqbpi8yosVJWUtHYjCh8CBrBcGN/RXqMVvVTgJQxZp2eIeWR0AZUCREO+6LrblXogowgdwz3Q0EfBK8VVKwxGb7Dm5dMssc0bT3B//dmaTt5Pxvfg5TdpUp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694358; c=relaxed/simple;
	bh=QCRviciADGj1pekUeaVvIfpuqOLQFXYDvbirzdj0qiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DckeJz2xFXsbAJWhWN8p7e/f9zAcPEd2x+v9PVoadG4H8qaI8xqGofPPRPFxO9dJCOq8vvgf4UKAMYtYoIukfhDRoFHPU12wxlWsZ3pbp9KiJPKBn//lC2ZW43VJKRnDM7WINsusmGWv70lal91z5JRFWY/TxTw+Y6JM6FjK6qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sJuARc0F; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sJuARc0F"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso25034116d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780694355; x=1781299155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBoOnWfEM7GbopQoF/ni1AEm1oH3LvPc3svVnbeBTyA=;
        b=sJuARc0FJzETHFmBsqSrE+hXUwKQj43TqjZqe/+HIaJT8jMGNpPtV8G+KKvhzpCHbl
         voUUm0SabRjhPKSkHheEiGLjAdNiS87bdeCDUx5ze/EDTPBem+fFzc+8+azq5JKim5ao
         OsY3uYyekbsmswUMcT5PsgyjNX55SPwLIEyTbueGGqM59rYGHnT0nbk4CHSe5yA49JDB
         oAfcz8MdkjEO/NYkYpRUny1Wa+xfis8IADmsokATsjnQ1aZIlaUFgpm1wFBaVAppewXI
         PuHwajismERbA30Y6VNOe7aXF4gvW3//u41LqGV6Tv6vSVem0LnHLYm2nwH1IiDr2HBn
         Crfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780694355; x=1781299155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBoOnWfEM7GbopQoF/ni1AEm1oH3LvPc3svVnbeBTyA=;
        b=UCxbGSq1VKo39vOuG/mATAOjG58E+yur7g7QUNouvDyBacUq18oFPOG5P2wz9TsP9C
         SvHCq8lP0YolzsMpcwiChkn2dF0coqm5gRCCwClc652PA/tkgilMaYPlIlWaFruIMNOB
         kwKwgqig89CQ66BHGuu6H9lX4WPAVzVfUsKGt1kB33g9Zme/S31Irt09fA262dYC1VEs
         WA8JXQ0HRwsJcAnPnYc4cf6ah9TiMeVgEB9kxFw+mVHKY7jcObaU6pEtreiLjyGhve6G
         r8Bh2VrGYnQkdo8Nb0HWJU8WWY8qK6TeoqSdbmMa6QksqGno52hU/zDpsXZuNdmJQnk0
         y7tg==
X-Forwarded-Encrypted: i=1; AFNElJ/vbWvQMBZ2SskXI6h7nhFHbcJnejnYoc+d6hmc1xLsbXzxlYR6pNuEPwE2ksKbC0hqgdX0utvQbGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJUMu5wdhQ8MtpHdm2BwXbAELT0TAQvOU/8CfA9O6SUbdCPD2
	e3TfqJJWnwjjMtOQcvngYQjSMVsdyOi5N2gJLms3OIqUJt2zNzMBVs6uysItH+Oq4H0=
X-Gm-Gg: Acq92OF/pEH3Lwbchv31b0Cc9CadD35sKMOxLqHJpcHFl3eHdXtVhk0OVXgYXUriyEj
	zewDOVXdLf87QIJM+kC0RGGV1aBl4NSkk9+lxiSDMZFelIRmYoIw1JBTEGqUR7Qv27hoIjYEOkP
	cAL7d3GosEP2URYnyZWdDNturiEqWh7c6gkgG1YZVqjgcVsgCM3ihh6d63bbXea9GjkgGkjIiZv
	WEhj3QJiEn9qk3M4t4DU4/bcEyMZyjnXhD6hoXPvaN46K9dx1/KUOhrNjoGh0ZrgrW/8qwK6pHq
	nujWhySWUrKpBJWgmlUpCgyooSn4QZ9VGgnh2piJu5f7hzME96g6gZr4NIoCPdPiAF3JIgLYo0Q
	BXqQXb/7fSQz8IcbDeLDiCW+oYQs0CTuJn6P+EJCViCEHrF2DnPBFXUNGVA4qFZr/ovqpfz7oOJ
	fRIKGa/c5eZUDmjc4vECVzJoYlUpV/1IIzVkhIM70MlBaRsvey/EzqK0ddEQZlJHJfaHPHeFcNE
	cRVbgF/3VBpigtGPJZVuEM=
X-Received: by 2002:a05:6214:484a:b0:8ca:1ddd:a6b8 with SMTP id 6a1803df08f44-8cee600836dmr88586746d6.14.1780694354764;
        Fri, 05 Jun 2026 14:19:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277bbcsm90518196d6.49.2026.06.05.14.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:19:14 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	shuah@kernel.org,
	gourry@gourry.net,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com,
	apopple@nvidia.com
Subject: [PATCH v4 0/9] dax/kmem: atomic whole-device hotplug via sysfs
Date: Fri,  5 Jun 2026 22:19:02 +0100
Message-ID: <20260605211911.2160954-1-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dax kmem driver onlines memory during probe using the system
default policy, with no atomic control for the state of an entire
region at runtime - only by toggling individual memory blocks.

Offlining and removing a whole region therefore races with other
userland controllers that interfere between the offline and remove
steps. This was discussed in the LPC2025 device memory sessions [1].

This series adds a sysfs "hotplug" attribute for atomic whole-device
hotplug control, plus the mm and dax plumbing to support it.

Transitions are atomic across every range of the device. The state
names mirror the per-block memoryX/state ABI with one modification:

  - "unplugged":      memory blocks are not present
  - "online":         online as system RAM, zone chosen by the kernel
  - "online_kernel":  online in ZONE_NORMAL
  - "online_movable": online in ZONE_MOVABLE

"offline" (blocks present but offline) is reportable for backward
compatibility but is not writable because it entices the race condition
we are trying to solve (offlining all the memory blocks in one atomic
and unplugging them in another atomic).

mm preparation:
  1. mm/memory: add memory_block_aligned_range() helper.
  2. mm/memory_hotplug: pass online_type to online_memory_block().
  3. mm/memory_hotplug: export mhp_get_default_online_type().
  4. mm/memory_hotplug: add __add_memory_driver_managed() so a driver can
     select the online policy.  The override is restricted to in-tree
     modules via EXPORT_SYMBOL_FOR_MODULES().
  5. mm/memory_hotplug: add offline_and_remove_memory_ranges() for atomic,
     all-or-nothing offline+remove of several ranges under a single
     lock_device_hotplug().

dax/kmem feature:
  6. Plumb online_type through the dax device creation path.
  7. Extract hotplug/hotremove into helper functions.
  8. Add the "hotplug" sysfs attribute.
  9. selftests/dax: regression test for the attribute.

DAX Kmem probe still creates the memory blocks by default, even when
the default policy is "offline" to preserve backwards compatibility.

Unplug (atomic offline+remove of the whole device) is the new
capability provided by the attribute.

I downgraded a BUG() to a WARN() when unbind is called while the device
is not unplugged.  The old per-block toggling pattern is still used by
userland tools and disconnects the 'hotplug' value from the real region
state; until per-block control is deprecated or restricted in some way,
WARN() flags that tools should move to the new atomic pattern.

Changes since v3 [2]:
  - Dropped the memory-tier dedup patch - mt_get_memory_type()
  - Added offline_and_remove_memory_ranges() with rollback
  - Added online_kernel so we mirror memoryX/state ABI.
  - Fixed a backward-compatibility regression: probe now always creates
    memory blocks (offline policy -> present+offline) instead an unplugged
    device, which broke tools expecting the blocks to be present.
  - Restricted the __add_memory_driver_managed() export to the kmem module
    only (was "kmem,cxl_core"); cxl_core can be added when it grows a user.
  - Renamed the alignment helper to memory_block_aligned_range() and
    dropped a dead enum->string helper (reusing online_type_to_str[]).
  - Added an in-tree selftest.

[1] https://lpc.events/event/19/contributions/2016/
[2] https://lore.kernel.org/all/20260321150404.3288786-1-gourry@gourry.net/

Gregory Price (9):
  mm/memory: add memory_block_aligned_range() helper
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: export mhp_get_default_online_type
  mm/memory_hotplug: add __add_memory_driver_managed() with online_type
    arg
  mm/memory_hotplug: add offline_and_remove_memory_ranges()
  dax: plumb hotplug online_type through dax
  dax/kmem: extract hotplug/hotremove helper functions
  dax/kmem: add sysfs interface for atomic whole-device hotplug
  selftests/dax: add dax/kmem hotplug sysfs regression test

 Documentation/ABI/testing/sysfs-bus-dax       |  25 +
 drivers/dax/bus.c                             |   3 +
 drivers/dax/bus.h                             |   2 +
 drivers/dax/cxl.c                             |   1 +
 drivers/dax/dax-private.h                     |   3 +
 drivers/dax/hmem/hmem.c                       |   1 +
 drivers/dax/kmem.c                            | 500 ++++++++++++++----
 drivers/dax/pmem.c                            |   1 +
 include/linux/memory.h                        |  22 +
 include/linux/memory_hotplug.h                |  12 +
 mm/memory_hotplug.c                           | 163 +++++-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/dax/Makefile          |   6 +
 tools/testing/selftests/dax/config            |   4 +
 .../testing/selftests/dax/dax-kmem-hotplug.sh | 145 +++++
 tools/testing/selftests/dax/settings          |   1 +
 16 files changed, 774 insertions(+), 116 deletions(-)
 create mode 100644 tools/testing/selftests/dax/Makefile
 create mode 100644 tools/testing/selftests/dax/config
 create mode 100755 tools/testing/selftests/dax/dax-kmem-hotplug.sh
 create mode 100644 tools/testing/selftests/dax/settings


base-commit: 7f981ca4cef222e26fc2b4ceb2d2bfe7a6153d3a
-- 
2.54.0
