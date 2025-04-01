Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA61EBFE3;
	Tue,  1 Apr 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498642; cv=none; b=NPWl710f0Kydm9G5o8nRDdDeNp9MDzpC562Chgd4uO1GcINeY6YEd9ewMxlVr7X/LJX41XM2MRKsCBrNOOHQQYuch11uyUIsF2/zoDdcpAo0cLUmBEGXYqrp2cmd3FBDAR5E3Eea0AjFW8nT2iQAxecDhRR6UfytAehQw9uyHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498642; c=relaxed/simple;
	bh=2kqYhZb9zupAFA1/dYlWUgmRW/D4OL/sskjnsBtWyCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4v2ES0MhxoKUOWwQ6etRNPYlLSAmNsw2dbis+oNa4oIvHXz1OA+BXeHbA00sA1eRunInDNJVE9DCkVXGTSEFNMDud5xIllGnALRBSIWqTYlfIvPm4UhptH8Fdq/xxlFSVCQVUTsOXfRKyd7j+AbUHrOFJo/mD3XOdNvxU3BglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-2d-67ebad85c490
From: Rakie Kim <rakie.kim@sk.com>
To: gourry@gourry.net
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [PATCH v4 0/3] Enhance sysfs handling for memory hotplug in weighted interleave
Date: Tue,  1 Apr 2025 18:08:56 +0900
Message-ID: <20250401090901.1050-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsXC9ZZnkW7r2tfpBpvPS1nMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK2P3
	pdPMBVOEKzoOXmFtYHzC38XIySEhYCJx+nEnK4x97PYkIJuDg01ASeLY3hiQsIiAqMS8o7NZ
	uhi5OJgFrjFJHPh8kwUkISwQIbH26ip2kHoWAVWJ7t82IGFeoDGL7uxnhxipKdFw6R4TRFxQ
	4uTMJ2CtzALyEs1bZzODzJQQOMMm8eXoczaIBkmJgytusExg5J2FpGcWkp4FjEyrGIUy88py
	EzNzTPQyKvMyK/SS83M3MQLDd1ntn+gdjJ8uBB9iFOBgVOLh3VD6Kl2INbGsuDL3EKMEB7OS
	CG/E15fpQrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhj5
	2D75vnObKGacbbwmh/HOBq2sl2zGPM6HvB+oHPi34JCrXWisauKeCwvqbHOEpOba7BdY/XlP
	WPw+XdUA/2kvslVDUnjvaH/znV2Y+PDewsDn2p9Pu9RFc81MTstMMo59x8OUYHAv0k61cu6H
	ogkBWxSqzz2sPGzP8l4uWszlwJ6ID85aNUosxRmJhlrMRcWJAJoxs1VbAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsXCNUNNS7d17et0g55lQhZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLQ5de85q
	sXpNhsXvbSvYHPg8ds66y+7R3XaZ3aPlyFtWj8V7XjJ5bPo0id3jxIzfLB47H1p6vN93lc3j
	220Pj8UvPjB5fN4kF8AdxWWTkpqTWZZapG+XwJWx+9Jp5oIpwhUdB6+wNjA+4e9i5OSQEDCR
	OHZ7EmsXIwcHm4CSxLG9MSBhEQFRiXlHZ7N0MXJxMAtcY5I48PkmC0hCWCBCYu3VVewg9SwC
	qhLdv21AwrxAYxbd2c8OMVJTouHSPSaIuKDEyZlPwFqZBeQlmrfOZp7AyDULSWoWktQCRqZV
	jCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgSG7rPbPxB2MXy67H2IU4GBU4uHdUPoqXYg1say4
	MvcQowQHs5IIb8TXl+lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotg
	skwcnFINjHl5rUYXXObpiE0rXBTsNvXiOmvP6gfrvCv5e0VW7hcoL1ZKXKqkXKV3ZYZE7o6X
	u81zpqmt7Wq6cq/7jc3s9g6Zfk4NEZWdrfq1/VoPwuZ4yyb+iyzrr13/VHXRpsQqt1bD8j+p
	8z1zZrLv+u9y9mbv/fNXEo1S9zn3BHAf+9J7517JvtOBSizFGYmGWsxFxYkAfEhAf1UCAAA=
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
- Memory Leaks: Improper `kobject` deallocation caused memory leaks
  when initialization failed or when nodes were removed.
- Lack of Dynamic Updates: Sysfs attributes were created only during
  initialization, preventing nodes added at runtime from being recognized.
- Handling of Unusable Nodes: Sysfs entries were generated for all
  possible nodes (`N_POSSIBLE`), including memoryless or unavailable nodes,
  leading to sysfs entries for unusable nodes and potential
  misconfigurations.

### Patch Overview
1. [PATCH 1/3] Fix memory leaks in weighted interleave sysfs
   - Ensures proper cleanup of `kobject` allocations.
   - Replaces unnecessary `kfree()` calls with `kobject_put()`, preventing
     memory leaks and improving system stability.

2. [PATCH 2/3] Enable dynamic updates for weighted interleave sysfs
   - Restructures sysfs handling to allow runtime updates.
   - The sysfs attributes are now globally accessible, enabling external
     modules to manage interleave settings dynamically.

3. [PATCH 3/3] Support memory hotplug in weighted interleave
   - Modifies sysfs creation logic to restrict entries to nodes that are
     online and have memory, excluding unusable nodes.
   - Introduces a memory hotplug mechanism to dynamically add and remove
     sysfs attributes when nodes transition into or out of the `N_MEMORY` set.
   - Ensures that sysfs attributes are properly removed when nodes go offline,
     preventing stale or redundant entries from persisting.

These patches have been tested under CXL-based memory configurations,
including hotplug scenarios, to ensure proper behavior and stability.

 mm/mempolicy.c | 195 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 127 insertions(+), 68 deletions(-)


base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
-- 
2.34.1

