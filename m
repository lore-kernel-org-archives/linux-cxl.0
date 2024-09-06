Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464903CF73;
	Fri,  6 Sep 2024 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592164; cv=none; b=IDei3iwZepm+SOumVMwqI6k1rXspJx4fLRxdXYozhpH33NO1G7RopVM5GG2HJ2sV3J5QYp2hsKveO/9evsZzKrAy3AfqwS9kpXZ8aVSH3gLDbrRGpAKupHBt0cYqEWXt0/kIHwKD9sAiCmEf3a7t9CGQkZFJoxXF+3N5jE38/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592164; c=relaxed/simple;
	bh=VYfkWvOLxKs5tnPDOT4ijueKx8g5WPX+vAVaKP8jU2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgj4hGNTk2/FG/XHQTqK34WPPSVHwC5x1ID2GUZSwEydYyuWQadGjLiAR/v7uGYzZW2KRsj19dd+HZX7HrnoU7ENkBc0afdvH6+OvEXbj49HxHiIR1Y0EuQOK0ZfeMuq+w/GlNvzpsZUr2sSg83cmPW8ei/Z+snkmxGyn8ouQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCUMWvQA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCUMWvQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725592161; x=1757128161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYfkWvOLxKs5tnPDOT4ijueKx8g5WPX+vAVaKP8jU2Q=;
  b=UCUMWvQArr7yj+dc9nwk5s9ei9JpaqZMzVE+elW1zJmwjQJRdrdmpAwo
   ENKUXKUtv4nYveQnM2EljrPmkMQXR680bzBBjGl8uXcLMFOBfGcwW4beE
   iIXdcQIbGGZOtidUIECGBXJVPHtV/RtGVUcmg4DG7Z6T/03MN00M1W8YG
   LpnTaXmQVBrCi+HuhX6WErLnKt3npxL1JH0NgugH+G/FWLy4jqQ/wpjBY
   XigjkMOJP/IFrlcVXuniXmeAPgB5Yx5lms7LEylX/OVAB+JNe22H5ihNQ
   g5/NluLN3e9NaojomqtVoLAz3rjoeRmeKfI35f9IQdnP+ezRx1R0A+8FY
   w==;
X-CSE-ConnectionGUID: tWGFVbiHQjaQwPuTqTfmhw==
X-CSE-MsgGUID: i7yMBsyqQemLc7Ey7u4thQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="28089459"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="28089459"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:09:21 -0700
X-CSE-ConnectionGUID: 8mcJYT+lQGWTBP+e48C9Ew==
X-CSE-MsgGUID: vxdFwImFSbeOefxtS4vhhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="66364375"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.245.242.189])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:09:17 -0700
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
Subject: [PATCH -v3 1/3] resource: Fix region_intersects() vs add_memory_driver_managed()
Date: Fri,  6 Sep 2024 11:07:11 +0800
Message-Id: <20240906030713.204292-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240906030713.204292-1-ying.huang@intel.com>
References: <20240906030713.204292-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a system with CXL memory, the resource tree (/proc/iomem) related
to CXL memory may look like something as follows.

490000000-50fffffff : CXL Window 0
  490000000-50fffffff : region0
    490000000-50fffffff : dax0.0
      490000000-50fffffff : System RAM (kmem)

Because drivers/dax/kmem.c calls add_memory_driver_managed() during
onlining CXL memory, which makes "System RAM (kmem)" a descendant of
"CXL Window X".  This confuses region_intersects(), which expects all
"System RAM" resources to be at the top level of iomem_resource.  This
can lead to bugs.

For example, when the following command line is executed to write some
memory in CXL memory range via /dev/mem,

 $ dd if=data of=/dev/mem bs=$((1 << 10)) seek=$((0x490000000 >> 10)) count=1
 dd: error writing '/dev/mem': Bad address
 1+0 records in
 0+0 records out
 0 bytes copied, 0.0283507 s, 0.0 kB/s

the command fails as expected.  However, the error code is wrong.  It
should be "Operation not permitted" instead of "Bad address".  More
seriously, the /dev/mem permission checking in devmem_is_allowed()
passes incorrectly.  Although the accessing is prevented later because
ioremap() isn't allowed to map system RAM, it is a potential security
issue.  During command executing, the following warning is reported in
the kernel log for calling ioremap() on system RAM.

 ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
 WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
 Call Trace:
  memremap+0xcb/0x184
  xlate_dev_mem_ptr+0x25/0x2f
  write_mem+0x94/0xfb
  vfs_write+0x128/0x26d
  ksys_write+0xac/0xfe
  do_syscall_64+0x9a/0xfd
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

The details of command execution process are as follows.  In the above
resource tree, "System RAM" is a descendant of "CXL Window 0" instead
of a top level resource.  So, region_intersects() will report no
System RAM resources in the CXL memory region incorrectly, because it
only checks the top level resources.  Consequently,
devmem_is_allowed() will return 1 (allow access via /dev/mem) for CXL
memory region incorrectly.  Fortunately, ioremap() doesn't allow to
map System RAM and reject the access.

So, region_intersects() needs to be fixed to work correctly with the
resource tree with "System RAM" not at top level as above.  To fix it,
if we found a unmatched resource in the top level, we will continue to
search matched resources in its descendant resources.  So, we will not
miss any matched resources in resource tree anymore.

In the new implementation, an example resource tree

|------------- "CXL Window 0" ------------|
|-- "System RAM" --|

will behave similar as the following fake resource tree for
region_intersects(, IORESOURCE_SYSTEM_RAM, ),

|-- "System RAM" --||-- "CXL Window 0a" --|

Where "CXL Window 0a" is part of the original "CXL Window 0" that
isn't covered by "System RAM".

Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use like normal RAM")
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
 kernel/resource.c | 58 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 14777afb0a99..235dc77f8add 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -540,20 +540,62 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 			       size_t size, unsigned long flags,
 			       unsigned long desc)
 {
-	struct resource res;
+	resource_size_t ostart, oend;
 	int type = 0; int other = 0;
-	struct resource *p;
+	struct resource *p, *dp;
+	bool is_type, covered;
+	struct resource res;
 
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
+		is_type = (p->flags & flags) == flags &&
+			(desc == IORES_DESC_NONE || desc == p->desc);
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
+		 * will behave similar as the following fake resource
+		 * tree when searching "System RAM".
+		 *
+		 * |-- "System RAM" --||-- "CXL Window 0a" --|
+		 */
+		covered = false;
+		ostart = max(res.start, p->start);
+		oend = min(res.end, p->end);
+		for_each_resource(p, dp, false) {
+			if (!resource_overlaps(dp, &res))
+				continue;
+			is_type = (dp->flags & flags) == flags &&
+				(desc == IORES_DESC_NONE || desc == dp->desc);
+			if (is_type) {
+				type++;
+				/*
+				 * Range from 'ostart' to 'dp->start'
+				 * isn't covered by matched resource.
+				 */
+				if (dp->start > ostart)
+					break;
+				if (dp->end >= oend) {
+					covered = true;
+					break;
+				}
+				/* Remove covered range */
+				ostart = max(ostart, dp->end + 1);
+			}
+		}
+		if (!covered)
+			other++;
 	}
 
 	if (type == 0)
-- 
2.39.2

