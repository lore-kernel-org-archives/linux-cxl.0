Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06516416
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6kCTWw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705090201; x=1736626201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2oeH9kBytaifPKHwo4OaaARYv+GCBE865IR+1EbAjEc=;
  b=k6kCTWw497a2d4kLSaIgW2POQL1jh5MzPSgDcL8nEVbwcqzjYtHiJXEw
   AJ0mMT4vW+1VNqk9rJQPWqvCzNcBU/dKDBrqULewXwSnQPa137ciT1AzR
   c9mj25gvp/tl/iGxrrKmX2bO0YXPFZfWohdIyR8j+jzYYujLqWDU8ntwn
   qGLFv7fJJ9/UgbmneTxggedzzjpGD0B3kpBfVIxg9bvNAmDC7t8jtywwj
   zdv0RGjgC0nY/P/yiDTR46EfwruTM46Y1VHAndHCZW3M98UoetypeRpyd
   nylsVn4DopJm2wnimo6VlTVTgXAkiYlqHX5GPa4Jm00+E/0FjRXMGGACC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6634119"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="6634119"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 12:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1030030291"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="1030030291"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.105.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 12:09:59 -0800
From: alison.schofield@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mike Rapoport <rppt@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
	x86@kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] x86/numa: Fix the address overlap check in numa_fill_memblks()
Date: Fri, 12 Jan 2024 12:09:50 -0800
Message-Id: <10a3e6109c34c21a8dd4c513cf63df63481a2b07.1705085543.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705085543.git.alison.schofield@intel.com>
References: <cover.1705085543.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

numa_fill_memblks() fills in the gaps in numa_meminfo memblks over a
physical address range. To do so, it first creates a list of existing
memblks that overlap that address range. The issue is that it is off
by one when comparing to the end of the address range, so memblks
that do not overlap are selected.

The impact of selecting a memblk that does not actually overlap is
that an existing memblk may be filled when the expected action is to
do nothing and return NUMA_NO_MEMBLK to the caller. The caller can
then add a new NUMA node and memblk.

Replace the broken open-coded search for address overlap with the
memblock helper memblock_addrs_overlap(). Update the kernel doc
and in code comments.

Fixes: 8f012db27c95 ("x86/numa: Introduce numa_fill_memblks()")
Suggested by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes since single patch:
- Use memblock_addrs_overlap() for address comparison (Dan)
- Update kernel doc and in code comments
- New commit message
- Update commit log
- Link to single patch:
https://lore.kernel.org/linux-cxl/20240102213206.1493733-1-alison.schofield@intel.com/

 arch/x86/mm/numa.c       | 19 +++++++------------
 include/linux/memblock.h |  2 ++
 mm/memblock.c            |  5 +++--
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index adc497b93f03..8ada9bbfad58 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -944,14 +944,12 @@ static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
  * @start: address to begin fill
  * @end: address to end fill
  *
- * Find and extend numa_meminfo memblks to cover the @start-@end
- * physical address range, such that the first memblk includes
- * @start, the last memblk includes @end, and any gaps in between
- * are filled.
+ * Find and extend numa_meminfo memblks to cover the physical
+ * address range @start-@end
  *
  * RETURNS:
  * 0		  : Success
- * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
+ * NUMA_NO_MEMBLK : No memblks exist in address range @start-@end
  */
 
 int __init numa_fill_memblks(u64 start, u64 end)
@@ -963,17 +961,14 @@ int __init numa_fill_memblks(u64 start, u64 end)
 
 	/*
 	 * Create a list of pointers to numa_meminfo memblks that
-	 * overlap start, end. Exclude (start == bi->end) since
-	 * end addresses in both a CFMWS range and a memblk range
-	 * are exclusive.
-	 *
-	 * This list of pointers is used to make in-place changes
-	 * that fill out the numa_meminfo memblks.
+	 * overlap start, end. The list is used to make in-place
+	 * changes that fill out the numa_meminfo memblks.
 	 */
 	for (int i = 0; i < mi->nr_blks; i++) {
 		struct numa_memblk *bi = &mi->blk[i];
 
-		if (start < bi->end && end >= bi->start) {
+		if (memblock_addrs_overlap(start, end - start, bi->start,
+					   bi->end - bi->start)) {
 			blk[count] = &mi->blk[i];
 			count++;
 		}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b695f9e946da..e2082240586d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -121,6 +121,8 @@ int memblock_reserve(phys_addr_t base, phys_addr_t size);
 int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 #endif
 void memblock_trim_memory(phys_addr_t align);
+unsigned long memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
+				     phys_addr_t base2, phys_addr_t size2);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
 bool memblock_validate_numa_coverage(unsigned long threshold_bytes);
diff --git a/mm/memblock.c b/mm/memblock.c
index 8c194d8afeec..d0cadeeecfe8 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -180,8 +180,9 @@ static inline phys_addr_t memblock_cap_size(phys_addr_t base, phys_addr_t *size)
 /*
  * Address comparison utilities
  */
-static unsigned long __init_memblock memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
-				       phys_addr_t base2, phys_addr_t size2)
+unsigned long __init_memblock
+memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1, phys_addr_t base2,
+		       phys_addr_t size2)
 {
 	return ((base1 < (base2 + size2)) && (base2 < (base1 + size1)));
 }
-- 
2.37.3

