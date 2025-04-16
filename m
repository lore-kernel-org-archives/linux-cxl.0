Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6522DFA20;
	Wed, 16 Apr 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803099; cv=none; b=G3474i07oCWPYRR1A1qFbbKBpBGsE4NNwwmhBtTUZ0jxKPZDj9x4P3U1hxW9H3zYJMhxjtvkGTMcmG1+kR1JOCiKdehqRRdrcu/IscQRu3dF28JjCAHVdcDv3qv8DiCS84ab63IpRASlKs+v4Wix6MTZ7b7EqhSWDxrZYBEgCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803099; c=relaxed/simple;
	bh=wm870a3wsMD4nHmN10jklz1xbL+ruVCnXMK7TwOfYCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrxunUukW+S2YLl92Bigf6I0CvjBD67H8bcosly2NiL+BYM6FGQsizSHS00/1du62wXw0vnqeT6rPHsuInSGryUgEGc0pOJKB8KDvSEZfSc3lH4ax7D6aQU0C6+4tjVdR2rIucplISJMKdSZf3W5Z8Q38W22+4KQbHN0lpui278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-06-67ff9511f475
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
Subject: [PATCH v8 0/3] Enhance sysfs handling for memory hotplug in weighted interleave
Date: Wed, 16 Apr 2025 20:31:18 +0900
Message-ID: <20250416113123.629-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC9ZZnka7g1P/pBlsOyFrMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4MnYtmMBa0CdfMefNPZYGxnlSXYycHBICJhLPet+xwdjbV+xm7WLk4GATUJI4tjcG
	JCwiICsx9e95li5GLg5mgcdMEo+ev2AESQgLREg0LF7ACmKzCKhKfN67hAnE5hUwllhzbyPU
	TE2Jhkv3oOKCEidnPmEBsZkF5CWat85mBhkqIXCbTeLKplnMEA2SEgdX3GCZwMg7C0nPLCQ9
	CxiZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIEBvSy2j/ROxg/XQg+xCjAwajEwxsR/y9diDWx
	rLgy9xCjBAezkgjvOXOgEG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalF
	MFkmDk6pBkZ+PaNw87qyyRufbpj1/N88A6MIsZAbPrplM/xOrv4TwmfYXdkrsY9p9vz1y8LN
	fjuKpP3vY3+89aRtwD3eqNke+l85RIIaz/adTtQWuip1IfjgSfUvXCzi8havRK3PXz2eLHAx
	hNtno2BA460zXEfu3BVdzpi1mOmUU41AhOerPQ0TO+ZcfKHEUpyRaKjFXFScCAD/F2QBZAIA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXCNUNNS1dw6v90g3d9ghZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBm7FkxgLeiTr5jz5h5LA+M8
	qS5GTg4JAROJ7St2s3YxcnCwCShJHNsbAxIWEZCVmPr3PEsXIxcHs8BjJolHz18wgiSEBSIk
	GhYvYAWxWQRUJT7vXcIEYvMKGEusubeRDWKmpkTDpXtQcUGJkzOfsIDYzALyEs1bZzNPYOSa
	hSQ1C0lqASPTKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMAgXlb7Z+IOxi+X3Q8xCnAwKvHw
	RsT/SxdiTSwrrsw9xCjBwawkwnvOHCjEm5JYWZValB9fVJqTWnyIUZqDRUmc1ys8NUFIID2x
	JDU7NbUgtQgmy8TBKdXAuFhx+aaHC5L3CkTLpvV3Cjnqi985q88VVXzyGNO3TX8ueN305zK1
	+xGp2Pc0/L9A1aHCDtvvq7onnFRtjzr2zv1Yc67Ij3WHmbcWVQYlbp/wRU/LZs31RxzP4v6n
	9DgVXdr2V/U7y7s4f6FY6Sl2u76+TWh4aPUkgrH/52futtzdWpzTy6KvKLEUZyQaajEXFScC
	AO1xIyNeAgAA
X-CFilter-Loop: Reflected

The following patch series enhances the weighted interleave policy in the
memory management subsystem by improving sysfs handling, fixing memory leaks,
and introducing dynamic sysfs updates for memory hotplug support.

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

 mm/mempolicy.c | 230 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 150 insertions(+), 80 deletions(-)


base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
-- 
2.34.1

