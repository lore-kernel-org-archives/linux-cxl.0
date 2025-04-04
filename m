Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEAD634;
	Fri,  4 Apr 2025 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743752806; cv=none; b=iAriSzI0Htax+7AiWBWMcpLwn90/+PcxVf1GuU4d0Q6Q+ot/IEvR+0k76P8NpqlAG6SY6bGdEver6z+NKtebK92aYrjG4xJRDPUYLultZKBlyR6LTDPMQqvqlJP7UKKaEy3mTqiUc4z+4zLJHC0+LMOKIVJZK/FSMnBmwqwxRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743752806; c=relaxed/simple;
	bh=nAlAKH59RnEuIWwZTZIVEgs6jMvWCtq6mDaqOTq5AbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I09cgVTv/YlcVlEv+eZA18UI+wLq9OOCCPf5PhWe2R7uhxC0sq4vP2vpFChTNw9Igbf64pWQCSCtPbpjYT3UEc8oqATo1Xnf4b+1i1Cc2lEG9jRGHISyDsC7X4VMH49Y6V9S02zeLDJ+b1kDsa/DvcLWmkSAjHtj8YVFut0LT7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c2-67ef8e57bba5
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
Subject: [PATCH v6 0/3] Enhance sysfs handling for memory hotplug in weighted interleave
Date: Fri,  4 Apr 2025 16:46:18 +0900
Message-ID: <20250404074623.1179-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXC9ZZnoW543/t0g99PzC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGS/3/WIvWCtUceFgF3sD4xL+LkZODgkBE4n5r9vYYOxTS1exdjFycLAJKEkc2xsD
	EhYRkJWY+vc8SxcjFwezwGMmiUfPXzCCJIQFIiQ+PrrKCmKzCKhK3P/+nwXE5gWas/DjTnaI
	mZoSDZfuMUHEBSVOznwCVsMsIC/RvHU2M8hQCYHbbBJzrjxihWiQlDi44gbLBEbeWUh6ZiHp
	WcDItIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMKCX1f6J3sH46ULwIUYBDkYlHl6LwnfpQqyJ
	ZcWVuYcYJTiYlUR47+a8TxfiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUg
	tQgmy8TBKdXAqLqv9sc3gfYFW5+2LyvcVav2LNnKPmGeyL7pHgIfHNgf/P08NU59rab59IfT
	1fPON112Slkb67dI8qqz6f8NC7iDu+zv/2+fcTD1gcnRAx4295ZYR/0+E3j/fPmZ50Y3T/jp
	80tyzMrMTrhi6JCsfrs/NPjRn5iA2EiD99FXedjEpygW5Fp9UGIpzkg01GIuKk4EAJKXlwhk
	AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXCNUNNSze87326wYxmDYs569ewWUyfeoHR
	4uv6X8wWP+8eZ7f4/Ow1s8WqhdfYLI5vncducXjuSVaL87NOsVhc3jWHzeLemv+sFmemFVkc
	uvac1WL1mgyL39tWsDnwe+ycdZfdo7vtMrtHy5G3rB6L97xk8tj0aRK7x4kZv1k8dj609Hi/
	7yqbx7fbHh6LX3xg8th8utrj8ya5AJ4oLpuU1JzMstQifbsEroyX+36xF6wVqrhwsIu9gXEJ
	fxcjJ4eEgInEqaWrWLsYOTjYBJQkju2NAQmLCMhKTP17nqWLkYuDWeAxk8Sj5y8YQRLCAhES
	Hx9dZQWxWQRUJe5//88CYvMCzVn4cSc7xExNiYZL95gg4oISJ2c+AathFpCXaN46m3kCI9cs
	JKlZSFILGJlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBAbxsto/E3cwfrnsfohRgINRiYfX
	ovBduhBrYllxZe4hRgkOZiUR3rs579OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQn
	lqRmp6YWpBbBZJk4OKUaGFveRTzfMutlxn7Tb79u+tqwiyzZt9g1K+LpQpvbq3Pduo6fTGKR
	Pnwrpv6s0oPeuTsuR1SzMwk9fP6xz6n+veEJxauzbK5q7Kldxjp/7zp3MY10yZeq/B9X9b28
	vmtdmcg76xPJ/xhfTjwSy2Kva1BoszEjKJh9EVcdA3davry2YXXa/r8/VJVYijMSDbWYi4oT
	AV0kRJFeAgAA
X-CFilter-Loop: Reflected

The following patch series enhances the weighted interleave policy in the
memory management subsystem by improving sysfs handling, fixing memory leaks,
and introducing dynamic sysfs updates for memory hotplug support.

### Background
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

 mm/mempolicy.c | 194 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 126 insertions(+), 68 deletions(-)


base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
-- 
2.34.1

