Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B561B810
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002822; cv=none; b=r2mAaPV+JYdYgYCyMRNM/lh/JMJ15LqD9nG018aIEnkK5qD0ZB9q5fOfSIkPYoPhY5MHuOoyuL9VzP05g5WVl0GoaAKKJiq1gPreYlpryUA6SY5dXchmP/kamCBoWZltEc+8sA8WJ0x/vDvDPfKyXD8Zai9BtLVvkIjzTtvvDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002822; c=relaxed/simple;
	bh=TKBzr9MdzFqQF0ZQmLs4cQwZQyq+xZgr2sIqcJtyVsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1lArUYOIhGtOfpdLZ57UKoCqxTvi5kRYzFKq/cyWF5wjCbmlzAn4MhhHbI3Sf64NKs3Z6Wk0fa0n+hYqsY/n9x9L2YE+pCWfQKVpIDNWvLaMIe2bV5VEmX+Hpp4nnPb2BTeJzpGl5Tca4ZnHIgC04dfhP09TMQmGBpe5/CfU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqGCn1gH8z6K9Jp;
	Thu, 30 May 2024 01:12:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C4BF140CB9;
	Thu, 30 May 2024 01:13:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:13:37 +0100
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
Subject: [RFC PATCH 2/8] arm64: memblock: Introduce a generic phys_addr_to_target_node()
Date: Wed, 29 May 2024 18:12:30 +0100
Message-ID: <20240529171236.32002-3-Jonathan.Cameron@huawei.com>
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

From: Dan Williams <dan.j.williams@intel.com>

Similar to how generic memory_add_physaddr_to_nid() interrogates
memblock data for numa information, introduce
get_reserved_pfn_range_from_nid() to enable the same operation for
reserved memory ranges. Example memory ranges that are reserved, but
still have associated numa-info are persistent memory or Soft Reserved
(EFI_MEMORY_SP) memory.

This is Dan's patch but with the implementation of
phys_addr_to_target_node() made arm64 specific.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Jia He <justin.he@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/159457120893.754248.7783260004248722175.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/include/asm/sparsemem.h |  4 ++++
 arch/arm64/mm/init.c               | 22 ++++++++++++++++++++++
 include/linux/memblock.h           |  8 ++++++++
 include/linux/mm.h                 | 14 ++++++++++++++
 mm/memblock.c                      | 22 +++++++++++++++++++---
 mm/mm_init.c                       | 29 ++++++++++++++++++++++++++++-
 6 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 8dd1b6a718fa..5b483ad6d501 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -27,7 +27,11 @@
 #endif /* CONFIG_ARM64_64K_PAGES */
 
 #ifndef __ASSEMBLY__
+
 extern int memory_add_physaddr_to_nid(u64 addr);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+extern int phys_to_target_node(phys_addr_t start);
+#define phys_to_target_node phys_to_target_node
+
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f310cbd349ba..6a2f21b1bb58 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -75,6 +75,28 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
+int phys_to_target_node(phys_addr_t start)
+{
+	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(start);
+	int nid = __memory_add_physaddr_to_nid(start);
+
+	if (nid != NUMA_NO_NODE)
+		return nid;
+
+	/*
+	 * Search reserved memory ranges since the memory address does
+	 * not appear to be online
+	 */
+	for_each_node_state(nid, N_POSSIBLE) {
+		get_reserved_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (pfn >= start_pfn && pfn <= end_pfn)
+			return nid;
+	}
+
+	return NUMA_NO_NODE;
+}
+EXPORT_SYMBOL(phys_to_target_node);
+
 #endif /* CONFIG_NUMA */
 
 /*
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e2082240586d..c7d518a54359 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -281,6 +281,10 @@ int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 			  unsigned long *out_end_pfn, int *out_nid);
 
+void __next_reserved_pfn_range(int *idx, int nid,
+			       unsigned long *out_start_pfn,
+			       unsigned long *out_end_pfn, int *out_nid);
+
 /**
  * for_each_mem_pfn_range - early memory pfn range iterator
  * @i: an integer used as loop variable
@@ -295,6 +299,10 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 
+#define for_each_reserved_pfn_range(i, nid, p_start, p_end, p_nid)		\
+	for (i = -1, __next_reserved_pfn_range(&i, nid, p_start, p_end, p_nid); \
+	     i >= 0; __next_reserved_pfn_range(&i, nid, p_start, p_end, p_nid))
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 				  unsigned long *out_spfn,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..0c829b2d44fa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3245,9 +3245,23 @@ void free_area_init(unsigned long *max_zone_pfn);
 unsigned long node_map_pfn_alignment(void);
 extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 						unsigned long end_pfn);
+
+/*
+ * Allow archs to opt-in to keeping get_pfn_range_for_nid() available
+ * after boot.
+ */
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+#define __init_or_memblock
+#else
+#define __init_or_memblock __init
+#endif
+
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
 
+extern void get_reserved_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn);
+
 #ifndef CONFIG_NUMA
 static inline int early_pfn_to_nid(unsigned long pfn)
 {
diff --git a/mm/memblock.c b/mm/memblock.c
index d09136e040d3..5498d5ea70b4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1289,11 +1289,11 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
 /*
  * Common iterator interface used to define for_each_mem_pfn_range().
  */
-void __init_memblock __next_mem_pfn_range(int *idx, int nid,
+static void __init_memblock __next_memblock_pfn_range(int *idx, int nid,
 				unsigned long *out_start_pfn,
-				unsigned long *out_end_pfn, int *out_nid)
+				unsigned long *out_end_pfn, int *out_nid,
+				struct memblock_type *type)
 {
-	struct memblock_type *type = &memblock.memory;
 	struct memblock_region *r;
 	int r_nid;
 
@@ -1319,6 +1319,22 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 		*out_nid = r_nid;
 }
 
+void __init_memblock __next_mem_pfn_range(int *idx, int nid,
+				unsigned long *out_start_pfn,
+				unsigned long *out_end_pfn, int *out_nid)
+{
+	__next_memblock_pfn_range(idx, nid, out_start_pfn, out_end_pfn, out_nid,
+				  &memblock.memory);
+}
+
+void __init_memblock __next_reserved_pfn_range(int *idx, int nid,
+				unsigned long *out_start_pfn,
+				unsigned long *out_end_pfn, int *out_nid)
+{
+	__next_memblock_pfn_range(idx, nid, out_start_pfn, out_end_pfn, out_nid,
+				  &memblock.reserved);
+}
+
 /**
  * memblock_set_node - set node ID on memblock regions
  * @base: base of area to set node ID for
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f72b852bd5b8..1f6e29e60673 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1644,7 +1644,7 @@ static inline void alloc_node_mem_map(struct pglist_data *pgdat) { }
  * provided by memblock_set_node(). If called for a node
  * with no available memory, the start and end PFNs will be 0.
  */
-void __init get_pfn_range_for_nid(unsigned int nid,
+void __init_or_memblock get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn)
 {
 	unsigned long this_start_pfn, this_end_pfn;
@@ -1662,6 +1662,33 @@ void __init get_pfn_range_for_nid(unsigned int nid,
 		*start_pfn = 0;
 }
 
+/**
+ * get_reserved_pfn_range_for_nid - Return the start and end page frames for a node
+ * @nid: The nid to return the range for. If MAX_NUMNODES, the min and max PFN are returned.
+ * @start_pfn: Passed by reference. On return, it will have the node start_pfn.
+ * @end_pfn: Passed by reference. On return, it will have the node end_pfn.
+ *
+ * Mostly identical to get_pfn_range_for_nid() except it operates on
+ * reserved ranges rather than online memory.
+ */
+void __init_or_memblock get_reserved_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn)
+{
+	unsigned long this_start_pfn, this_end_pfn;
+	int i;
+
+	*start_pfn = -1UL;
+	*end_pfn = 0;
+
+	for_each_reserved_pfn_range(i, nid, &this_start_pfn, &this_end_pfn, NULL) {
+		*start_pfn = min(*start_pfn, this_start_pfn);
+		*end_pfn = max(*end_pfn, this_end_pfn);
+	}
+
+	if (*start_pfn == -1UL)
+		*start_pfn = 0;
+}
+
 static void __init free_area_init_node(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
-- 
2.39.2

