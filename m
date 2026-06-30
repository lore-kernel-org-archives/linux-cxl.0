Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C62F0673
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854331; cv=none; b=PBROmW2tYRW98ySvOPrrVYdLnkqMcRfitKWr32+kFXuaHOT83M8L7n46UaitaJxzfZ9liAFgSpo40Lbr3uw6dCYHK6UnrlOo5yIcm/R2iwpytLdyki/M46MMzhMCvFSXGX6Xu+C66CrDaSL0altxdk5EWbuq5R6A/wnijQ0kJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854331; c=relaxed/simple;
	bh=ZxDj2bIyTYA2VqEzR9BlPCz00cVKtf/fVVQwM0leMSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kks1UUIitCFs3tl6YLemWPT0+CQBFpCpwEDk2rwj/CohJInRx6pL5C+LwSBVvbsmgwLT6pzTeBmcWNRJPHd+TcSD9pIc1gLM1wPa743NT0nh6sz59S7h2iZbcMxEDsQV02y4rgwwWzA0nzj7pWzzzOX3XMLRagH+DZz8Vv4PG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ge15xg39; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ge15xg39"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92c7a0a7059so331974785a.0
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782854328; x=1783459128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15soTVn10pZL1HzcUE7vkWAPLmAyPlWsN9L93RXfdBQ=;
        b=ge15xg39Ejjk7xuu9i78siBjD6WxsouzvIZQPFmnWY6K/usg39ci/H5R87WBIudlh0
         AqtOvIxqq6ISwx5tsJzQ1aiySUA+UM2xvVEafiVMlrbcmrrzaGONFP5kvhxIkGvolI+a
         Gcfo3uM7MwX7W6Fd+gB5mkuWnQmNEZGc5Uj0j/YQ5obur90P5kPeNh/RKJz7mRj9nHKW
         OmfPYdwGFnWmxbyUTPv3AI1oWfAbkugv4ZiT8rl9WZYgB6yrzXFtID3cz/My6wISK20O
         OTPZ1ThaYgKgwbhSIjzo4CvnHYBARq9EoZMleWRQK85AV4e9c5UxET+4RBd27Aimu+39
         pTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854328; x=1783459128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15soTVn10pZL1HzcUE7vkWAPLmAyPlWsN9L93RXfdBQ=;
        b=VRI4+V70bJNv3aFITQNkXFvsxHhGbvlJT4DCngT5ZVgfOknMrqbzu6pirTia0pZhx1
         sho0xXZTVJ7jt1aO7ShACVNlcOE4ObHDM9I/pC3zF7If88YwsyZICzRhMWLz0GA3pfZx
         uzlgcAVKpCzsycbiG5FdOuwZ3/VuEpGPmWPHN+965eZFoICQGdOBH3eHbQTWZJnLkmNG
         1pjleD5XbZwvIlxCIuEJ/TF3U5vc2BwYeFljLISaKj3qf5f4L3vzWKrfbGjVEzm5LU2Z
         89cqQeZ3Hd4bFtmVwomcLVL4Sr2QuZHV4MZR8M37ySeASSKbJif/YOiFnTG2lpSfTiiK
         CPpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6M8rFh0/TWNqLc80/AFPZ/IMgbqkaqSqeGFr37j6b3hcY6ds+C4ehwaR6DHPLHtRpVqTG+shdAs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2KtN9KfkIHyPfID2gWO8VRghHgbq0bD8CPiSkLx6a8Jyvwn1/
	vqw+0exuWH1U9iPAwRTqzgIJn2xSVLe2wHHV+eQKyToV3gmpJRJOl0GzcVhRlSCTYAc=
X-Gm-Gg: AfdE7ck6qknvUlRauOkk8ue/0h7NXmMRDs5hsQ4KqWDLWnkhaasr17c6znGxIfGFe/U
	cs1v5AzbZv0AZCDG3B/m+53DNQwhYWEDRJ+Ww2PGKwF1tpEeJWX8Y0UtCZj8fpBtVyMnfREkTEm
	SasgNq9k+f9jrGRWoTOIBJBqp3xAG9GALBWdFN2sX14q7wgvlEMisAOys72ZkDFQVgCa0KiInhv
	m7uZD88+7fUJUxAeaLUQAV1PZ+8Goh+DaQHMVXPNzbyhVlGtAEaZJY8jXgfa1n+032b3RlrBT+6
	RmUSX0Nj77A+PEty+vmfsD6NfgWgwgjrwSCHQiWUgycrayBENycNWd7JZtpKahmZ2HJsrrjVOVh
	KIgf1nvkJjxhNycfy2vRPV7U+kiGJ2rkp1EIF2C/grtm/08eHZ+pHumdWASZS26LvTOSYjqgQOH
	jhOi0/BbAAc26XzVNk8mNRhLysR4AoYRRE3sf6k0PF9cdIeSI6/CmuY4PSXeSrja6UUiDHReahj
	A==
X-Received: by 2002:a05:620a:29d5:b0:92b:67e6:8ac0 with SMTP id af79cd13be357-92e6284f33dmr789795885a.74.1782854328078;
        Tue, 30 Jun 2026 14:18:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62366303sm335924285a.40.2026.06.30.14.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:47 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net,
	iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	apopple@nvidia.com
Subject: [PATCH v6 00/10] dax/kmem: atomic whole-device hotplug via sysfs
Date: Tue, 30 Jun 2026 17:18:32 -0400
Message-ID: <20260630211842.2252800-1-gourry@gourry.net>
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
steps. This was discussed in the LPC2025 device memory sessions.

This series adds a sysfs "state" attribute for atomic whole-device
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
  2. mm/memory_hotplug: add mhp_online_type_to_str() and export the
     online-type string helpers.
  3. mm/memory_hotplug: pass online_type to online_memory_block().
  4. mm/memory_hotplug: export mhp_get_default_online_type().
  5. mm/memory_hotplug: add __add_memory_driver_managed() so a driver can
     select the online policy.  The override is restricted to in-tree
     modules via EXPORT_SYMBOL_FOR_MODULES().
  6. mm/memory_hotplug: add offline_and_remove_memory_ranges() for atomic,
     all-or-nothing offline+remove of several ranges under a single
     lock_device_hotplug().

dax/kmem feature:
  7. Plumb online_type through the dax device creation path.
  8. Extract hotplug/hotremove into helper functions.
  9. Add the "state" sysfs attribute.
  10. selftests/dax: regression test for the attribute.

DAX Kmem probe still creates the memory blocks by default, even when
the default policy is "offline" to preserve backwards compatibility.

Unplug (atomic offline+remove of the whole device) is the new
capability provided by the attribute.

I downgraded a BUG() to a WARN() when unbind is called while the device
is not unplugged.  The old per-block toggling pattern is still used by
userland tools and disconnects the 'state' attribute from the real region
state; until per-block control is deprecated or restricted in some way,
WARN() flags that tools should move to the new atomic pattern.

Changes since v5:
  - mm/memory_hotplug helper into own patch (david)
  - offline_and_remove_memory_ranges - nits (david)
  - offline_and_remove_memory_ranges - warn and continue (david)
  - memory_block_aligned_range(): end-address underflow (sashiko)
  - dax: store the online_type sentinel as int (sashiko)
  - dax/kmem: skip ranges that failed reservation on hotplug (sashiko)
  - dax/kmem: on unbind fallback to legacy if still online (sashiko)
  - selftests/dax: avoid cascading skips, clobbered state (sashiko)

Gregory Price (10):
  mm/memory: add memory_block_aligned_range() helper
  mm/memory_hotplug: add mhp_online_type_to_str() and export string
    helpers
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: export mhp_get_default_online_type
  mm/memory_hotplug: add __add_memory_driver_managed() with online_type
    arg
  mm/memory_hotplug: add offline_and_remove_memory_ranges()
  dax: plumb hotplug online_type through dax
  dax/kmem: extract hotplug/hotremove helper functions
  dax/kmem: add sysfs interface for atomic whole-device hotplug
  selftests/dax: add dax/kmem hotplug sysfs regression test

 Documentation/ABI/testing/sysfs-bus-dax       |  26 +
 drivers/base/memory.c                         |   9 +
 drivers/dax/bus.c                             |   3 +
 drivers/dax/bus.h                             |   9 +
 drivers/dax/cxl.c                             |   1 +
 drivers/dax/dax-private.h                     |   4 +
 drivers/dax/hmem/hmem.c                       |   1 +
 drivers/dax/kmem.c                            | 516 ++++++++++++++----
 drivers/dax/pmem.c                            |   1 +
 include/linux/memory.h                        |  27 +
 include/linux/memory_hotplug.h                |  14 +
 mm/memory_hotplug.c                           | 161 ++++--
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/dax/Makefile          |   6 +
 tools/testing/selftests/dax/config            |   4 +
 .../testing/selftests/dax/dax-kmem-hotplug.sh | 190 +++++++
 tools/testing/selftests/dax/settings          |   1 +
 17 files changed, 836 insertions(+), 138 deletions(-)
 create mode 100644 tools/testing/selftests/dax/Makefile
 create mode 100644 tools/testing/selftests/dax/config
 create mode 100755 tools/testing/selftests/dax/dax-kmem-hotplug.sh
 create mode 100644 tools/testing/selftests/dax/settings

-- 
2.53.0-Meta

