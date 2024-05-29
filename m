Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629DFD27E
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002944; cv=none; b=C8nzVIlyJmvgRj2zJkThvfN+vo7t5KvpA9VzYV3Y4aIETeK6tLO/DMBu5XHWqe/GLnZ6qts7SR1fFaxt9qooXvm4qtl0m+l/f87yVS6Zl38cgCB6qVEAEFlGiAn/EQ7yUIq3EGlIw4brzfgGfc5YtH/mpk0fU8sS6Ru7JDgT7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002944; c=relaxed/simple;
	bh=WkxDaENqulOl1gvy56L5sLs3/LyhXGYgJXLIAYtSxPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epecs0iOyDkILF0sUMBZgFfzA8gEftnoQNP3uTkKpaZD6B3FjAw8fUghOvzlyNczACpuvCP0Yxrkwl73QxV2QLyaK5TQOjJIUfa0sWJVZLBRPSTHhwOnpJMBffkhRpzUiRnvjhO2wZOgA4RVCGcftdmo90Bldx4rJWHrwGl8XfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqGG82hwKz6K9Hp;
	Thu, 30 May 2024 01:14:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 536541400CA;
	Thu, 30 May 2024 01:15:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:15:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Will Deacon <will@kernel.org>, Jia He
	<justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
	<linuxarm@huawei.com>, <catalin.marinas@arm.com>,
	<Anshuman.Khandual@arm.com>, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Oscar Salvador <osalvador@suse.de>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, James Morse <james.morse@arm.com>
Subject: [RFC PATCH 6/8] arm64: mm: numa_fill_memblks() to add a memblock.reserved region if match.
Date: Wed, 29 May 2024 18:12:34 +0100
Message-ID: <20240529171236.32002-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

CXL memory hotplug relies on additional NUMA nodes being created
for any CXL Fixed Memory Window if there is no suitable one created
by system firmware. To detect if system firmware has created one look
for any normal memblock that overlaps with the Fixed Memory Window that
has a NUMA node (nid) set.

If one is found, add a region with the same nid to memblock.reserved
so we can match it later when CXL memory is hotplugged.
If not, add a region anyway because a suitable NUMA node will be
set later. So for now use NUMA_NO_NODE.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/mm/init.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6a2f21b1bb58..27941f22db1c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -50,6 +50,32 @@
 
 #ifdef CONFIG_NUMA
 
+/*
+ * Scan existing memblocks and if this region overlaps with a region with
+ * a nid set, add a reserved memblock.
+ */
+int __init numa_fill_memblks(u64 start, u64 end)
+{
+	struct memblock_region *region;
+
+	for_each_mem_region(region) {
+		int nid = memblock_get_region_node(region);
+
+		if (nid == NUMA_NO_NODE)
+			continue;
+		if (!(end < region->base || start >= region->base + region->size)) {
+			memblock_add_reserved_node(start, end - start, nid,
+						   MEMBLOCK_RSRV_NOINIT);
+			return 0;
+		}
+	}
+
+	memblock_add_reserved_node(start, end - start, NUMA_NO_NODE,
+				   MEMBLOCK_RSRV_NOINIT);
+
+	return NUMA_NO_MEMBLK;
+}
+
 static int __memory_add_physaddr_to_nid(u64 addr)
 {
 	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
-- 
2.39.2

