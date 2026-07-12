Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FD2C0F91
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783871118; cv=none; b=rI3y1ycMwPIj3Wg+rhZ6NeE8wnsQpLKCh+cQxtTDe+ggJ/DfGMVFpQGRXvDEVUrghEmNb+UrswPVm1UWuZrJuZfhHOKPPo8T+UfpmExUfkwhuhkwvpJOwrQVzIPEzCgelgbaiNQJrN/QIbxvAbGLfB/v5QCllWAPYCCDOVhEXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783871118; c=relaxed/simple;
	bh=c2rTynvZmw41AyQtdN492V16tvCPLmmOtTp42guX71k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyCl0h1D+zI4mL0w4kq5FFd5/qtbTGSVPGqNSqbn5Xoopqu6AbVefe71iHnHWBnXD0skxdhnk+ijHGzR7rPaRAz5zgBPU0MJSiQ1qL37NChwhRH/3LmEoRJXtBXRWV1U6kt6I8K0TKLhqwX3Sqcm2nRFUBChgb2YrRhT7KPefrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GZsKluPo; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GZsKluPo"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5d6f35c1so193410185a.0
        for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783871115; x=1784475915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/sA+zg3hun+tcy2tg/tGGOKyNNSW3ITFRulSJiyHuZ8=;
        b=GZsKluPoHfIYmscf8u2oycQ5nBzV2tq9Xr4H8lmZkPwwcdqM7JOyiUbURgduZ2QA6P
         DalgJziqQlgfUUBh7fBEIL/RzFaywHyhsY4AkXU201TPWr5Poh49yT5t1rT4NOvODYmR
         C/cztJVHBVPDiZEZVyOh1JUH6jNfO1DGYHFS7yS4mlQtK5yRUE/pL0JgUOunX1RjDuxg
         rBTbc6gj5RhW7ubcrYO/MRZRCMmu/QEJiiOKefHBMla1Am0edz+AWwL8UKIC3FVotvAo
         VTwJlu8nwSL7lWCH8ej5HgGlXoLGPffDruzq1LECGejx9Z0qNzoSl9JOBZwFD4Y+AI3t
         T0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783871115; x=1784475915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sA+zg3hun+tcy2tg/tGGOKyNNSW3ITFRulSJiyHuZ8=;
        b=coHjocjmg+7EtqClF6OqFGZkzTMyaxi/v4Zh9LpAd199gzXUz90L5FAUf74lWimXp8
         8tLDmkpL4HLafd18mFuwW68dW4kDL463Ijucw0CKr+Zlp0dqa1BWrn3zkVilRUV4NNWw
         T1PlVaS2dbhdMFqSdkSc8oB1GsANSwSJtoXtbklay/b9mpfskeuhwI1jnnx4ROrOVWeQ
         6uP/FoK8PyhMrAZ69z93loTqnVaJSpDfr232HB7/nl/QcV8V1UYhALrsFBXQB6YFSAVM
         fcI1IiPe0Phy/zueXW86PjXdlee8MzkEfBd1Y7iPOWlgzbHoS1jpHAR0jsjy2tI/mIYK
         rlzg==
X-Forwarded-Encrypted: i=1; AHgh+RrjA8LIbJaMZYotyxCUPrfS5YPg4hsqRoQeDWTAX051D7YfSfZ0PIl6Rgdz9Yqj6gYmB0g6avDQPiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/m/ZI+GEQM0ntD6OW1IUU6UdPqxHJdCY8cUeC603823b7pC1S
	BI1Domr7SxspPDLfOxcVZLtNh59t3MRVyUEn6nd3X5yfuLST+fo/ZgojX/MgHX3FTsk=
X-Gm-Gg: AfdE7cno+7uN/SJNM/fMntx0g+QBl2TEiPQoHB7J4188pP9VTpT5pefmifXnVW+ZY65
	YS6e/TCvHuJB9iMgN8rXch78cjAx8lMV1vJil4jmQUc2FdFY5FCi8dsBWvwbIh4vwOZQny81Zdl
	zpGDa/FNKuuED6iMeO5u4YSVpZD5b0F4rc/8IUrPmCp5vLKpDhK/0w/iX8kPJ0AOfKyGnTQBCNY
	hcMgbcNnTV5I7KfDGMn89zDNamfmRMTC3mosemcWeUXoQTBoURuyVjzMPepUiwTm85YARUgKkHa
	m+v49Xro0e2uiNSdtqrOUbdHCEn5rMBp+JkasXOiCudmr8pKT95F7me1WcZ8Myh+ug+pVcgNoz8
	hE7QiH7dRLsLOPu0kz/aIhk6AhFxaHoA/R6JzgUfcWtmbVRuLfYIO3+zVWkWybYrfTg32bsXL9k
	s1332cA7ak+wyrEx7FioI1gngX1nro9JCE8dr7U2JssIEZwSchWBCWpirCocQcajYjQBoA5VrvK
	CXepknsQOlV
X-Received: by 2002:a05:620a:6f05:b0:920:4f78:3d7 with SMTP id af79cd13be357-92ef2b4b7e4mr642033485a.3.1783871115261;
        Sun, 12 Jul 2026 08:45:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61facsm862186485a.42.2026.07.12.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 08:45:14 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
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
	gourry@gourry.net
Subject: [PATCH v7 00/10] dax/kmem: atomic whole-device hotplug via sysfs
Date: Sun, 12 Jul 2026 11:44:54 -0400
Message-ID: <20260712154505.3564379-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
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
userland controllers that interfere between the two steps.

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
we are trying to solve (separate atomic steps for offline and unplug).

'unplugged' (atomic offline+remove of the whole device) is the new
capability provided by the new kmem sysfs attribute.

dax/kmem probe still creates the memory blocks by default when the
default policy is "offline", to preserve backwards compatibility.

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

dax/kmem:
  7. Resolve mhp default online type at probe time
  8. Extract hotplug/hotremove into helper functions (refactor).
  9. Add the "state" sysfs attribute.
  10. selftests/dax: regression test for the attribute.

---

v7 changes
- picked up tags
- dropped !data checks (Dan)
- re-defined 'DAX_KMEM_UNPLUGGED (-1)' (Dan)
- converted `state` to static ATTRIBUTE_GROUPS (Dan)
- dropped DEFAULT until later commit with per-driver settings (Dan)
- state_store now frees reservations on total hotplug failure (sashiko)
- kmalloc_array -> kmalloc_objs (Dan)
- unbind reworked to just remove_memory() (still never offlines, no deadlock)
- added memoryN/state and daxX.Y/state desync test
- gated destructive unbind tests behind DAX_KMEM_TEST_UNBIND
- added DAX_KMEM_TEST_DEV environment variable for target dax device
- added comment in offline_and_remove_memory_ranges for clarity
- minor spellcheck, whitespace, doc fixups

Gregory Price (10):
  mm/memory: add memory_block_aligned_range() helper
  mm/memory_hotplug: add mhp_online_type_to_str() and export string
    helpers
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: export mhp_get_default_online_type
  mm/memory_hotplug: add __add_memory_driver_managed() with online_type
    arg
  mm/memory_hotplug: add offline_and_remove_memory_ranges()
  dax/kmem: resolve default online type at probe time
  dax/kmem: extract hotplug/hotremove helper functions
  dax/kmem: add sysfs interface for atomic whole-device hotplug
  selftests/dax: add dax/kmem hotplug sysfs regression test

 Documentation/ABI/testing/sysfs-bus-dax       |  24 +
 drivers/base/memory.c                         |   9 +
 drivers/dax/bus.h                             |   2 +
 drivers/dax/kmem.c                            | 500 ++++++++++++++----
 include/linux/memory.h                        |  27 +
 include/linux/memory_hotplug.h                |  14 +
 mm/memory_hotplug.c                           | 162 ++++--
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/dax/Makefile          |   6 +
 tools/testing/selftests/dax/config            |   4 +
 .../testing/selftests/dax/dax-kmem-hotplug.sh | 317 +++++++++++
 tools/testing/selftests/dax/settings          |   1 +
 12 files changed, 928 insertions(+), 139 deletions(-)
 create mode 100644 tools/testing/selftests/dax/Makefile
 create mode 100644 tools/testing/selftests/dax/config
 create mode 100755 tools/testing/selftests/dax/dax-kmem-hotplug.sh
 create mode 100644 tools/testing/selftests/dax/settings

-- 
2.53.0-Meta

