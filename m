Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE13168A8
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jan 2024 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lL/hgynA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704231130; x=1735767130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6PRT94X+s5okNnoQkiUdUT0LcAHbUV6Kl5SMh98Lmm0=;
  b=lL/hgynAM03wmnYEnxxfaPQthbKpH/FgqgshTqX7mry8SvtSOJ1cxp1a
   pS9kCZgD/txKbsl3h0UiHsHzJfeN71eQvYEDKNQiP7jB4hurni9cmno+z
   mABlAUDnoMH4QTC/3nLf9/kov/AP7nvecIk036jIxzsPxIuh1BMQC7mV9
   rYKic3Z3gj6q5b5n3UKyoKGTeq+o/g1JwKsnN1SF9XcT8sHOeVPMgIAZt
   bCCPuR6bGod4bwLtxUkij334dDu13T+F8v4BMHtSubk3tp48aVXesiX+z
   mHKqXz6Y/s5QVr5hcAAkA29Hz2ddkBlKLfa5C5w2FS9k07+JhHe7DZdrx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3737444"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3737444"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 13:32:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="783303778"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="783303778"
Received: from dswillis-mobl4.amr.corp.intel.com (HELO localhost) ([10.212.157.88])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 13:32:08 -0800
From: alison.schofield@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	x86@kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH] x86/numa: Make numa_fill_memblks() @end parameter exclusive
Date: Tue,  2 Jan 2024 13:32:06 -0800
Message-Id: <20240102213206.1493733-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

numa_fill_memblks() expects inclusive [start, end] parameters but
it's only caller, acpi_parse_cfmws(), is sending an exclusive end
parameter. This means that numa_fill_memblks() can create an overlap
between different NUMA nodes with adjacent memblks. That overlap is
discovered in numa_cleanup_meminfo() and numa initialization fails
like this:

[] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
[] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
[] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]

Changing the call site to send the expected inclusive @end parameter
was considered and rejected. Rather numa_fill_memblks() is made to
handle the exclusive @end, thereby making it the same as its neighbor
numa_add_memblks().

Fixes: 8f012db27c95 ("x86/numa: Introduce numa_fill_memblks()")
Suggested by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 arch/x86/mm/numa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index b29ceb19e46e..4f81f75e4328 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -974,9 +974,9 @@ static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
  * @start: address to begin fill
  * @end: address to end fill
  *
- * Find and extend numa_meminfo memblks to cover the @start-@end
+ * Find and extend numa_meminfo memblks to cover the [start, end)
  * physical address range, such that the first memblk includes
- * @start, the last memblk includes @end, and any gaps in between
+ * @start, the last memblk excludes @end, and any gaps in between
  * are filled.
  *
  * RETURNS:
@@ -1003,7 +1003,7 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	for (int i = 0; i < mi->nr_blks; i++) {
 		struct numa_memblk *bi = &mi->blk[i];
 
-		if (start < bi->end && end >= bi->start) {
+		if (start < bi->end && end > bi->start) {
 			blk[count] = &mi->blk[i];
 			count++;
 		}

base-commit: 659c07b7699a6e50af05a3bdcc201ff000fbcada
-- 
2.37.3

