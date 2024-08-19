Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A52C18C;
	Mon, 19 Aug 2024 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034871; cv=none; b=CUVUYxSfS9TtxvKIZZ8GT/TWnDPET2t/O3ZC1tenD2wuKT+MrBAkqkt0/N7mdJgAbHW7g0jMxvO0hATW+GMt1TUmd6Bu1RjeE1OR8JHmAIAvXhnBKXd0YK1ZvZ/rIR3j6bVpqxN5aHgPxvFoZxkTBKt3d7e631j7xbm9szpCOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034871; c=relaxed/simple;
	bh=5Z0nzJhKJas79o+LDX/DR11sJ2PP9VPjJkbhB84Rx6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZ3YhYAuJyOm8MQMlseJFfAb+bbrkFUWcsZAz7kzUeN/SBPSogShG709JizKN30B2HxU9oD660h7K4noWH8pllb6LsscSuO+FiF8s7env/x5KBCq29UfI14AUNG1IQTjcgf/Jvv2538qE2HY3c9xN2qNq6nYqy9hNtHY/iC5sUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMVKet15; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMVKet15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724034869; x=1755570869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Z0nzJhKJas79o+LDX/DR11sJ2PP9VPjJkbhB84Rx6w=;
  b=GMVKet156fyHiIIHOVwRNZlh+SNoGMemuoHiaZNY+wqYdjt+qTdjFdwI
   dkzL0ECMUBfpuilbB8VOqOe8h/iPGAtjRlVs0Zw/WBxiG1Dl2NTj8ee5Z
   Ca40KltqboT0xXroNB0dPRMvSkVH3KN394qGZC3W8m+6hgYrWe8DlhpNd
   WOGx7rJtvcLQ2MncM9xTx9sKQh3tcuF5o0rMhNHeTjCFjCt9VYcLPsL9x
   zdQedKa8keQWH0yfagDpYVCngJpzgzVYZROpyDGEnjHpgMhBTimu4HcvL
   vz88+daCI+n52o5bPUdAELdOFKYQjm28mIyXlRd7PMr2ES7/n4pRRAAs/
   w==;
X-CSE-ConnectionGUID: 9w8KR1IiS7ah5psFJuPJgQ==
X-CSE-MsgGUID: VkFBphwCS2u6yysKS4wR7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33639877"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33639877"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 19:34:28 -0700
X-CSE-ConnectionGUID: p7Xuo10/ShSKYQijg3o5Xw==
X-CSE-MsgGUID: icVulG52TRaCzAo1ZTDDIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60225690"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.245.243.221])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 19:34:23 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Date: Mon, 19 Aug 2024 10:34:13 +0800
Message-Id: <20240819023413.1109779-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a system with CXL memory installed, the resource tree (/proc/iomem)
related to CXL memory looks like something as follows.

490000000-50fffffff : CXL Window 0
  490000000-50fffffff : region0
    490000000-50fffffff : dax0.0
      490000000-50fffffff : System RAM (kmem)

When the following command line is run to try writing some memory in
CXL memory range,

 $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
 dd: error writing '/dev/mem': Bad address
 1+0 records in
 0+0 records out
 0 bytes copied, 0.0283507 s, 0.0 kB/s

the command fails as expected.  However, the error code is wrong.  It
should be "Operation not permitted" instead of "Bad address".  And,
the following warning is reported in kernel log.

 ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
 WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
 Modules linked in: cxl_pmem libnvdimm cbc encrypted_keys cxl_pmu
 CPU: 2 UID: 0 PID: 416 Comm: dd Not tainted 6.11.0-rc3-kvm #40
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 RIP: 0010:__ioremap_caller.constprop.0+0x131/0x35d
 Code: 2d 80 3d 24 6a a1 02 00 75 c1 48 8d 54 24 70 48 8d b4 24 90 00 00 00 48 c7 c7 40 3a 05 8a c6 05 07 6a a1 02 01 e8 a3 a0 01 00 <0f> 0b eb 9d 48 8b 84 24 90 00 00 00 48 8d 4c 24 60 89 ea 48 bf 00
 RSP: 0018:ffff888105387bf0 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: 0000000490000fff RCX: 0000000000000000
 RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffffed1020a70f73
 RBP: 0000000000000000 R08: ffffed100d9fce92 R09: 0000000000000001
 R10: ffffffff892348e7 R11: ffffed100d9fce91 R12: 0000000490000000
 R13: 0000000000000001 R14: 0000000000000001 R15: ffff888105387ca0
 FS:  00007f86c438c740(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055ba75b1b818 CR3: 0000000005231000 CR4: 0000000000350eb0
 Call Trace:
  <TASK>
  ? __warn+0xd7/0x1b8
  ? __ioremap_caller.constprop.0+0x131/0x35d
  ? report_bug+0x136/0x19e
  ? __ioremap_caller.constprop.0+0x131/0x35d
  ? handle_bug+0x3c/0x64
  ? exc_invalid_op+0x13/0x38
  ? asm_exc_invalid_op+0x16/0x20
  ? irq_work_claim+0x16/0x38
  ? __ioremap_caller.constprop.0+0x131/0x35d
  ? tracer_hardirqs_off+0x18/0x16d
  ? kmem_cache_debug_flags+0x16/0x23
  ? memremap+0xcb/0x184
  ? iounmap+0xfe/0xfe
  ? lock_sync+0xc7/0xc7
  ? lock_sync+0xc7/0xc7
  ? rcu_is_watching+0x1c/0x38
  ? do_raw_read_unlock+0x37/0x42
  ? _raw_read_unlock+0x1f/0x2f
  memremap+0xcb/0x184
  ? pfn_valid+0x159/0x159
  ? resource_is_exclusive+0xba/0xc5
  xlate_dev_mem_ptr+0x25/0x2f
  write_mem+0x94/0xfb
  vfs_write+0x128/0x26d
  ? kernel_write+0x89/0x89
  ? rcu_is_watching+0x1c/0x38
  ? __might_fault+0x72/0xba
  ? __might_fault+0x72/0xba
  ? rcu_is_watching+0x1c/0x38
  ? lock_release+0xba/0x13e
  ? files_lookup_fd_raw+0x40/0x4b
  ? __fget_light+0x64/0x89
  ksys_write+0xac/0xfe
  ? __ia32_sys_read+0x40/0x40
  ? tracer_hardirqs_off+0x18/0x16d
  ? tracer_hardirqs_on+0x11/0x146
  do_syscall_64+0x9a/0xfd
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7f86c4487140
 Code: 40 00 48 8b 15 c1 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
 RSP: 002b:00007ffca9f62af8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000400 RCX: 00007f86c4487140
 RDX: 0000000000000400 RSI: 000055ba75b1a000 RDI: 0000000000000001
 RBP: 000055ba75b1a000 R08: 0000000000000000 R09: 00007f86c457c080
 R10: 00007f86c43a84d0 R11: 0000000000000202 R12: 0000000000000000
 R13: 0000000000000000 R14: 000055ba75b1a000 R15: 0000000000000400
  </TASK>
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffff89091e85>] copy_process+0xb60/0x255f
 softirqs last  enabled at (0): [<ffffffff89091e85>] copy_process+0xb60/0x255f
 softirqs last disabled at (0): [<0000000000000000>] 0x0

After investigation, we found the following bug.

In the above resource tree, "System RAM" is a descendant of "CXL
Window 0" instead of a top level resource.  So, region_intersects()
will report no System RAM resources in the CXL memory region
incorrectly, because it only checks the top level resources.
Consequently, devmem_is_allowed() will return 1 (allow access via
/dev/mem) for CXL memory region incorrectly.  Fortunately, ioremap()
doesn't allow to map System RAM and reject the access.

However, region_intersects() needs to be fixed to work correctly with
the resources tree with CXL Window as above.  To fix it, if we found a
unmatched resource in the top level, we will continue to search
matched resources in its descendant resources.  So, we will not miss
any matched resources in resource tree anymore.  In the new
implementation,

|------------- "CXL Window 0" ------------|
|-- "System RAM" --|

will look as if

|-- "System RAM" --||-- "CXL Window 0a" --|

in effect.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Baoquan He <bhe@redhat.com>
---
Changelogs:

v2:

- Fix a bug which occurs when descendant of a matched resource matches.

- Revise the patch description and comments to make the algorithm clearer.
  Thanks Dan and David's comments!

- Link to v1: https://lore.kernel.org/linux-mm/20240816020723.771196-1-ying.huang@intel.com/

 kernel/resource.c | 53 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 14777afb0a99..60492f143275 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -542,18 +542,57 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 {
 	struct resource res;
 	int type = 0; int other = 0;
-	struct resource *p;
+	struct resource *p, *dp;
+	resource_size_t ostart, oend;
+	bool is_type, covered;
 
 	res.start = start;
 	res.end = start + size - 1;
 
 	for (p = parent->child; p ; p = p->sibling) {
-		bool is_type = (((p->flags & flags) == flags) &&
-				((desc == IORES_DESC_NONE) ||
-				 (desc == p->desc)));
-
-		if (resource_overlaps(p, &res))
-			is_type ? type++ : other++;
+		if (!resource_overlaps(p, &res))
+			continue;
+		is_type = (((p->flags & flags) == flags) &&
+			   ((desc == IORES_DESC_NONE) || (desc == p->desc)));
+		if (is_type) {
+			type++;
+			continue;
+		}
+		/*
+		 * Continue to search in descendant resources as if the
+		 * matched descendant resources cover some ranges of 'p'.
+		 *
+		 * |------------- "CXL Window 0" ------------|
+		 * |-- "System RAM" --|
+		 *
+		 * looks as if
+		 *
+		 * |-- "System RAM" --||-- "CXL Window 0a" --|
+		 *
+		 * in effect.
+		 */
+		covered = false;
+		ostart = max(res.start, p->start);
+		oend = min(res.end, p->end);
+		for_each_resource(p, dp, false) {
+			if (!resource_overlaps(dp, &res))
+				continue;
+			is_type = (((dp->flags & flags) == flags) &&
+				   ((desc == IORES_DESC_NONE) ||
+				    (desc == dp->desc)));
+			if (is_type) {
+				type++;
+				if (dp->start > ostart)
+					break;
+				if (dp->end >= oend) {
+					covered = true;
+					break;
+				}
+				ostart = max(ostart, dp->end + 1);
+			}
+		}
+		if (!covered)
+			other++;
 	}
 
 	if (type == 0)
-- 
2.39.2

