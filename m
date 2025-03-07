Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F1419DF53;
	Fri,  7 Mar 2025 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329353; cv=none; b=DZu4Pqa9mIOEst3YkIj1H/A8RtMsrHzfGop1U91zENvK3olCJKs9Z5rOBR/9ZABoiuGofDACZlHpRYlq7pbpQjmqfnwyvz8kSD1F1fTdX8HMTeUyWTM1/YV6IJpJiw7aqAqdYwAkSCtk8oiFNldEmfKhtURyeOps1fcQbr07ryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329353; c=relaxed/simple;
	bh=esmNNp3BGyEddRUwYn/CvcroAhX1wVNY/V4QbqbB03E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BME2TGbGFRZ9SHJsqQSNTzO3OsZjnWNZcYW7ZsTgPPo4F1JX1kVJGpxZl3HC37Z80i3sSMIpCN4J+14hqkHfKR5OtKIdc9qp8JXo8q2isT5oFQ5IRj7zOrjlKhBFJwDlZwAHBnDsU/suTPbd21U1MAI43hbz2hqCeQc8Ry0sgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-6d-67ca93be1418
From: Rakie Kim <rakie.kim@sk.com>
To: gourry@gourry.net
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [PATCH 0/4] mm/mempolicy: Add memory hotplug support in weighted interleave
Date: Fri,  7 Mar 2025 15:35:29 +0900
Message-ID: <20250307063534.540-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsXC9ZZnke6+yafSDW6s0reYs34Nm8X0qRcY
	LX7ePc5ucXzrPHaL87NOsVhc3jWHzeLemv+sFqvXZDhweOycdZfdo7vtMrvH4j0vmTw2fZrE
	7nFixm8Wj50PLT0+b5ILYI/isklJzcksSy3St0vgymi+so29YI5IxfHL21gaGPsFuxg5OSQE
	TCR+X5jECGPfeL+FuYuRg4NNQEni2N4YkLCIgKjEvKOzWboYuTiYBRYzSSw8vJ4JpEZYIETi
	am8ISA2LgKrEx3OH2EDCvALGEm/3O0FM1JRouHSPCcTmFRCUODnzCQuIzSwgL9G8dTYzRM0W
	NolXzX4QtqTEwRU3WCYw8s5C0jILScsCRqZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmbGIEhuaz2
	T/QOxk8Xgg8xCnAwKvHwekw9mS7EmlhWXJl7iFGCg1lJhFdwM1CINyWxsiq1KD++qDQntfgQ
	ozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QD49LoDdkztERVGfZueNt2zvaF6lT/70cv
	PC4sUeM+YKTe2rj4W9J0uftbvSJfv+4uUd1vevjctifMhzX2ZaQ/33MxpMv0+g6e8N8vje7L
	P63bNPW3QLCW8J1L07Y2y82J8XTNtIs5mJu7LPiY8IOc1XJxqissO3ZM4og9+PTHJxmhdcob
	Kln9HJRYijMSDbWYi4oTAYEzIAxFAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsXCNUNNS3ff5FPpBtdWKFnMWb+GzWL61AuM
	Fj/vHme3+PzsNbPF8a3z2C0Ozz3JanF+1ikWi8u75rBZ3Fvzn9Xi0LXnrBar12RY/N62gs2B
	x2PnrLvsHt1tl9k9Fu95yeSx6dMkdo8TM36zeOx8aOnx7baHx+IXH5g8Pm+SC+CM4rJJSc3J
	LEst0rdL4MpovrKNvWCOSMXxy9tYGhj7BbsYOTkkBEwkbrzfwtzFyMHBJqAkcWxvDEhYREBU
	Yt7R2SxdjFwczAKLmSQWHl7PBFIjLBAicbU3BKSGRUBV4uO5Q2wgYV4BY4m3+50gJmpKNFy6
	xwRi8woISpyc+YQFxGYWkJdo3jqbeQIj1ywkqVlIUgsYmVYximTmleUmZuaY6hVnZ1TmZVbo
	JefnbmIEBuKy2j8TdzB+uex+iFGAg1GJh9dj6sl0IdbEsuLK3EOMEhzMSiK8gpuBQrwpiZVV
	qUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYyXLD8sCp8yW/vtvK8c
	P/5nrdkW+srmq+niZyvPO+e3JHvf51twV+K2Vr7cDe6PK8UWNetLWkSvnHltt1mRsPPGG6eM
	5bX3RFybee/sCVmHUN0DbeEV83i9orcaLXbZW3n376Ock9I/3P+znnQV/v3sR/y7WTy8Bm2a
	l+N1Xn23Uu2/vMtx2bubSizFGYmGWsxFxYkAmNltpUACAAA=
X-CFilter-Loop: Reflected

This patch series enhances the weighted interleave policy in mempolicy
to support memory hotplug, ensuring that newly added memory nodes are
properly recognized and integrated into the weighted interleave mechanism.

The weighted interleave policy distributes page allocations across
multiple NUMA nodes based on their performance weight, optimizing memory
bandwidth utilization. The weight values for each node are configured
through sysfs. However, the existing implementation only created sysfs
entries at initialization, leading to the following issues:

Unnecessary sysfs entries: Nodes without memory were included in sysfs
at boot.
Missing hotplug support: Nodes that became online after initialization
were not recognized, causing incomplete interleave configurations.
To resolve these issues, the first patch introduces two key changes:

Filtered sysfs creation at initialization Only nodes that are online
and have memory are registered.
Dynamic sysfs updates for hotplugged nodes  New memory nodes are
recognized and integrated via the memory hotplug mechanism.
Subsequent patches refine this functionality:

Patch 2: Enables sysfs registration for memory nodes added via hotplug.
Patch 3: Fixes a race condition that caused duplicate sysfs entries when
registering interleave settings.
Patch 4: Ensures proper deallocation of kobjects and memory, preventing
resource leaks in mempolicy_sysfs_init().
With these changes, the weighted interleave policy can dynamically adapt
to memory hotplug events, improving NUMA memory management and system
stability.

Patch Summary
[PATCH 1/4] mm/mempolicy: Support memory hotplug in weighted interleave
Adds dynamic sysfs integration for memory hotplug in weighted interleave.
[PATCH 2/4] mm/mempolicy: Enable sysfs support for memory hotplug in
weighted interleave
Implements sysfs attribute registration for newly detected memory nodes.
[PATCH 3/4] mm/mempolicy: Fix duplicate node addition in sysfs for
weighted interleave
Prevents redundant sysfs entries when configuring interleave settings.
[PATCH 4/4] mm/mempolicy: Fix memory leaks in mempolicy_sysfs_init()
Ensures proper kobject and memory deallocation to prevent resource leaks.

These patches have been tested to ensure correct memory node detection,
proper sysfs updates, and stability improvements in memory hotplug scenarios.

 mm/mempolicy.c | 172 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 122 insertions(+), 50 deletions(-)


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.34.1

