Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60FC324B1C;
	Wed, 11 Feb 2026 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806027; cv=none; b=GZQfbBiadi8jwOVZ2sopjUSbH2pdro8D5ZEBzOE2P0iwF0C499sQ8FIWHINc+a1CXsvC5EXeM7xHfQ+zN9C/wvRY3FszqvO0wQIseIMlBmUg7PWN771oCw7LzmtLXX60+z7JBLysXAJwNgviHLN3E+VZMYbXylcdJVRLWDeEoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806027; c=relaxed/simple;
	bh=3H6ElMaFash6DA7CLjt3lGG5qn/56rrByQeE5s2cp+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6H57hAYu7XcNed+G5cYPcX92hCMW/WW/hDLuuhf1+Uc1bAT5gsQWFWHCMm3Pif9bFHyAxib2v9euKFljXVeg8bmp1IR0oavCkLt9OIPM5M+gYdIAuxEA5ZAbmNqnmLiZKQmynfxQxP9q/O/8c3jbtuFIJ/jqDnfVyAIQwKQqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3Ppr2WoxpguYHBw--.323S2;
	Wed, 11 Feb 2026 18:33:26 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwDXMO7yWoxptIgaAA--.31566S3;
	Wed, 11 Feb 2026 18:33:23 +0800 (CST)
From: Cui Chao <cuichao1753@phytium.com.cn>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	dan.j.williams@intel.com,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	qemu-devel@nongnu.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v3 1/1] mm: numa_memblks: Identify the accurate NUMA ID of CFMW
Date: Wed, 11 Feb 2026 18:33:20 +0800
Message-Id: <20260211103320.2064211-2-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260211103320.2064211-1-cuichao1753@phytium.com.cn>
References: <20260211103320.2064211-1-cuichao1753@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDXMO7yWoxptIgaAA--.31566S3
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQADAGmLkQQCTwAEs8
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw4kGF4fJw17Kr1kXw1rtFb_yoW7GFy7pa
	1IqrZYgF4kGry7GF4kZa1DJr1Sv3ZakF43GFW7CrnxuFn0gr18ur4Sqw1YvFWkGryfC3Wr
	XF4Dtw1Yv3WDZaDanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

In some physical memory layout designs, the address space of CFMW (CXL
Fixed Memory Window) resides between multiple segments of system memory
belonging to the same NUMA node. In numa_cleanup_meminfo, these multiple
segments of system memory are merged into a larger numa_memblk. When
identifying which NUMA node the CFMW belongs to, it may be incorrectly
assigned to the NUMA node of the merged system memory.

When a CXL RAM region is created in userspace, the memory capacity of
the newly created region is not added to the CFMW-dedicated NUMA node.
Instead, it is accumulated into an existing NUMA node (e.g., NUMA0
containing RAM). This makes it impossible to clearly distinguish
between the two types of memory, which may affect memory-tiering
applications.

Example memory layout:

Physical address space:
    0x00000000 - 0x1FFFFFFF  System RAM (node0)
    0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
    0x40000000 - 0x5FFFFFFF  System RAM (node0)
    0x60000000 - 0x7FFFFFFF  System RAM (node1)

After numa_cleanup_meminfo, the two node0 segments are merged into one:
    0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the range
    0x60000000 - 0x7FFFFFFF  System RAM (node1)

So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0.

To address this scenario, accurately identifying the correct NUMA node
can be achieved by checking whether the region belongs to both
numa_meminfo and numa_reserved_meminfo.

1. Issue Impact and Backport Recommendation:

This patch fixes an issue observed in QEMU emulation where, during the
dynamic creation of a CXL RAM region, the memory capacity is not assigned
to the correct CFMW-dedicated NUMA node. While hardware platforms could
potentially have such memory configurations, we are not currently aware
of any such hardware. This issue leads to:

    Failure of the memory tiering mechanism: The system is designed to
    treat System RAM as fast memory and CXL memory as slow memory. For
    performance optimization, hot pages may be migrated to fast memory
    while cold pages are migrated to slow memory. The system uses NUMA
    IDs as an index to identify different tiers of memory. If the NUMA
    ID for CXL memory is calculated incorrectly and its capacity is
    aggregated into the NUMA node containing System RAM (i.e., the node
    for fast memory), the CXL memory cannot be correctly identified. It
    may be misjudged as fast memory, thereby affecting performance
    optimization strategies.

    Inability to distinguish between System RAM and CXL memory even for
    simple manual binding: Tools like |numactl|and other NUMA policy
    utilities cannot differentiate between System RAM and CXL memory,
    making it impossible to perform reasonable memory binding.

    Inaccurate system reporting: Tools like |numactl -H|would display
    memory capacities that do not match the actual physical hardware
    layout, impacting operations and monitoring.

This issue affects all users utilizing the CXL RAM functionality who
rely on memory tiering or NUMA-aware scheduling.

Therefore, I recommend backporting this patch to all stable kernel
series that support dynamic CXL region creation.

2. Why a Kernel Update is Recommended Over a Firmware Update:

In the scenario of dynamic CXL region creation, the association between
the memory's HPA range and its corresponding NUMA node is established
when the kernel driver performs the commit operation. This is a runtime,
OS-managed operation where the platform firmware cannot intervene to
provide a fix.

Considering factors like hardware platform architecture, memory
resources, and others, such a physical address layout can indeed occur.
This patch does not introduce risk; it simply correctly handles the
NUMA node assignment for CXL RAM regions within such a physical address
layout.

Thus, I believe a kernel fix is necessary.

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 mm/numa_memblks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 5b009a9cd8b4..0892d532908c 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -568,15 +568,16 @@ static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
 int phys_to_target_node(u64 start)
 {
 	int nid = meminfo_to_nid(&numa_meminfo, start);
+	int reserved_nid = meminfo_to_nid(&numa_reserved_meminfo, start);
 
 	/*
-	 * Prefer online nodes, but if reserved memory might be
-	 * hot-added continue the search with reserved ranges.
+	 * Prefer online nodes unless the address is also described
+	 * by reserved ranges, in which case use the reserved nid.
 	 */
-	if (nid != NUMA_NO_NODE)
+	if (nid != NUMA_NO_NODE && reserved_nid == NUMA_NO_NODE)
 		return nid;
 
-	return meminfo_to_nid(&numa_reserved_meminfo, start);
+	return reserved_nid;
 }
 EXPORT_SYMBOL_GPL(phys_to_target_node);
 
-- 
2.33.0

