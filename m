Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D993219A76;
	Thu, 17 Apr 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874953; cv=none; b=CWs5vOSvZzRo/fKXrILKZYD3voTlYH5mivpFxxpowiYpvHydcNzupyqKFuZdKlrH0d0VyaaQ0Y8RthOjcNLCCXvdLZfpj0YUcI+LUEl8HYFfzbDIwq6vmN1LdggU0Afs2zbValUJZj8vo9DExgk1wEeK1FrfegyyHpVkMBdfUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874953; c=relaxed/simple;
	bh=bKXHuTaUCZ2Xb/kzNU41+ezyI5P4/jk2iouHpcNh4qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIsrjzuSEnA7Jc8IJpd0CO5qaqonfYRXCLJkyAZdVis8CHHn3m4Ymly6ePO3Jxjgt52i3Qp8OZP0iUEpFW+vYcggajR/2oJ8cf1mJZJZ/BN2eF31fASvXgvs9ajRbs+mSSk5CZJPBWe6oQxnrb7r3tUbcrGYW+Ipk4koN8AQMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-b0-6800adbbfdce
From: Rakie Kim <rakie.kim@sk.com>
To: akpm@linux-foundation.org
Cc: gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [PATCH v9 0/3] Enhance sysfs handling for memory hotplug in weighted interleave
Date: Thu, 17 Apr 2025 16:28:34 +0900
Message-ID: <20250417072839.711-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsXC9ZZnke7utQwZBg+2GlrMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Mg71bWUveKhQ8XLOKZYGxqvSXYycHBICJhIrLm1j7mLkgLB3uIKYbAJKEsf2xoBU
	iAjISkz9e56li5GLg1ngMZPEo+cvGEESwgIREue/7mcHsVkEVCV2HP3JBmLzChhLXN6zkQli
	vKZEw6V7TBBxQYmTM5+wgNjMAvISzVtnM4MMlRC4zyax+edVqAZJiYMrbrBMYOSdhaRnFpKe
	BYxMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECw3lZ7Z/oHYyfLgQfYhTgYFTi4T2x6H+6EGti
	WXFl7iFGCQ5mJRHec+b/0oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1I
	LYLJMnFwSjUw5n2VXvA7imON59mJziziR5g76qtsn7rLmIqtCNh+0netxnyjlkORqpdWWx+1
	q5zWPkXBt1rq13rP5s6FzzR3NpjJ9xW8Ez39X/iU+tz9gZZJvjf/2nTpGK6+nD5z9g8WJw1m
	zgMuQa8C92erMane/1sZ+9FGqjnIxdOFkf2F0ZQKjSn2SkuVWIozEg21mIuKEwENuAoFYwIA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXCNUNNS3f3WoYMg4NPlC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDIO9W1lL3ioUPFyzimWBsar
	0l2MHBwSAiYSK3a4gphsAkoSx/bGdDFycogIyEpM/XuepYuRi4NZ4DGTxKPnLxhBEsICERLn
	v+5nB7FZBFQldhz9yQZi8woYS1zes5EJxJYQ0JRouHSPCSIuKHFy5hMWEJtZQF6ieets5gmM
	XLOQpGYhSS1gZFrFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGMLLav9M3MH45bL7IUYBDkYl
	Ht4Ti/6nC7EmlhVX5h5ilOBgVhLhPWf+L12INyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQ
	QHpiSWp2ampBahFMlomDU6qB8bhKYvJ9o0W3bTh+f7hRwPpwJYdCwQyOydp/dtpH7Bde4eg1
	M1hfsknBgPPrb2WJ6Vr2awu7tT7deVU1/8E+jydnzz2Oq9gb16TCnhzMc3yt23vflEJT3rvC
	FT8KvSW8Bef2fBHaKM51mMPy+/d6Bi9/bw8Ws8faJj3XP6/N4frZaO55idFLiaU4I9FQi7mo
	OBEAsbaAJV0CAAA=
X-CFilter-Loop: Reflected

The following patch series enhances the weighted interleave policy in the
memory management subsystem by improving sysfs handling, fixing memory leaks,
and introducing dynamic sysfs updates for memory hotplug support.

Changes from v8:
https://lore.kernel.org/all/20250416113123.629-1-rakie.kim@sk.com/
- Updated lock usage during sysfs entry creation
- Fixed sysfs removal warning triggered during exception handling paths

Changes from v7:
https://lore.kernel.org/all/20250408073243.488-1-rakie.kim@sk.com/
- Refactored error handling paths to remove unnecessary `goto` usage
- Renamed unclear variables and functions for better readability

Changes from v6:
https://lore.kernel.org/all/20250404074623.1179-1-rakie.kim@sk.com/
- Removed redundant error handling in MEM_OFFLINE case

Changes from v5:
https://lore.kernel.org/all/20250402014906.1086-1-rakie.kim@sk.com/
- Added lock protection to sensitive sections

Changes from v4:
https://lore.kernel.org/all/20250401090901.1050-1-rakie.kim@sk.com/
- Added missing `kobject_del()` when removing a kobject
- Extended locking coverage to protect shared state

Changes from v3:
https://lore.kernel.org/all/20250320041749.881-1-rakie.kim@sk.com/
- Added error handling for allocation and cleanup paths
- Replaced static node attribute list with flexible array
- Reorganized four patches into three based on their functional scope

Changes from v2:
https://lore.kernel.org/all/20250312075628.648-1-rakie.kim@sk.com/
- Clarified commit messages
- Refactored to avoid passing the global structure as a parameter

Changes from v1:
https://lore.kernel.org/all/20250307063534.540-1-rakie.kim@sk.com/
- Fixed memory leaks related to `kobject` lifecycle
- Refactored sysfs layout for hotplug readiness
- Introduced initial memory hotplug support for weighted interleave

### Introduction
The weighted interleave policy distributes memory allocations across multiple
NUMA nodes based on their performance weight, thereby optimizing memory
bandwidth utilization. The weight values are configured through sysfs.

Previously, sysfs entries for weighted interleave were managed statically
at initialization. This led to several issues:
- Memory Leaks: Improper `kobject` teardown caused memory leaks
  when initialization failed or when nodes were removed.
- Lack of Dynamic Updates: Sysfs attributes were created only during
  initialization, preventing nodes added at runtime from being recognized.
- Handling of Unusable Nodes: Sysfs entries were generated for all
  possible nodes (`N_POSSIBLE`), including memoryless or unavailable nodes,
  leading to sysfs entries for unusable nodes and potential
  misconfigurations.

### Patch Overview
1. [PATCH 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
   - Ensures proper cleanup of `kobject` allocations.
   - Adds `kobject_del()` before `kobject_put()` to clean up sysfs state correctly.
   - Prevents memory/resource leaks and improves teardown behavior.
   - Ensures that `sysfs_remove_file()` is not called from the release path
     after `kobject_del()` has cleared sysfs state, to avoid potential
     inconsistencies and warnings in the kernfs subsystem.

2. [PATCH 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
   - Refactors static sysfs layout into a new `sysfs_wi_group` structure.
   - Makes per-node sysfs attributes accessible to external modules.
   - Lays groundwork for future hotplug support by enabling runtime modification.

3. [PATCH 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
   - Dynamically adds/removes sysfs entries when nodes are online/offline.
   - Limits sysfs creation to nodes with memory, avoiding unusable node entries.
   - Hooks into memory hotplug notifier for runtime updates.

These patches have been tested under CXL-based memory configurations,
including hotplug scenarios, to ensure proper behavior and stability.

 mm/mempolicy.c | 240 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 148 insertions(+), 92 deletions(-)


base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
-- 
2.34.1

