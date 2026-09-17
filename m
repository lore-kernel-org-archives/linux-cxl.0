Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F56D3515DA
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613211; cv=none; b=US8YT8STV3jQ147J/vRcsHHV40ovULVeqyfjVVLU2n8sOsynDhjZxjd7KO7AQrSOu52XbQtWI9mgdFRM4RECzm8d1f5EGxX8ufxIPe6/SI3/aU01QwLRmNBX9sbv4Zg3QqYmDEZp9CZ/5zYYPOwu5nfHFnjrW5PVVSv6rWPfeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613211; c=relaxed/simple;
	bh=OOUwAA3xZ7F8cE6MXnKWuSUzBsMJBYu8qddpG0lhrZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moM5yMQkoQ3deJDpyp4ZhqvTjMpAGJJwRwAl9ED+uOnflLME/xmTyM4DhF8mU47eTm3r97ICZ4Wj5W17bMnpy6SrvcoKqO4uToMLxp4fAaK8VcMIgHmpHGQMb5NZWALTZZpCE7qfdpVTa+1VVlmvdv0j97YkBijVl7KH3cY/Lak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SFhvKY8+; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SFhvKY8+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789613197; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=w+niSGUYXYdHclkvGFZuMvKf924+uLF1uGkWxoiKOl8=;
	b=SFhvKY8+4tPM/0TjPLAEoQYDuDx+US8s9OlJf7//pTmuceXWX7lBPlspFUJPvTShPKwxZSIOlzBohs6az5ilIboospKTrANXb824pWWO4u2CdF8GrqaEXgouEjKtmo9rHr1UEIbyBJ/jAH4QrT/fQG1x5HMJHKULYLszLmOQUQk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB6ZKVL_1789613196;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB6ZKVL_1789613196 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 10:46:37 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/region: Create node access attributes for CFMWS-only NUMA nodes
Date: Thu, 17 Sep 2026 10:46:32 +0800
Message-ID: <20260917024632.1397380-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NUMA node that only backs a CXL fixed memory window and is not
enumerated by SRAT has no memory_target in the HMAT code, so
hmat_callback() exits early at find_mem_target() and never creates
the node's accessN attributes:
/sys/devices/system/node/nodeX/accessN/initiators/* stays missing.

Commit debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated
by SRAT") had the CXL region notifier call node_set_perf_attrs()
directly for such nodes, but commit 2e454fb8056d ("cxl, acpi/hmat:
Update CXL access coordinates directly instead of through HMAT")
replaced it with node_update_perf_attrs(), which only updates
attributes that already exist and thus does nothing for these nodes.

Create the attributes with node_set_perf_attrs() when the node is not
backed by a real SRAT pxm.

Tested on a QEMU CXL topology with a CFMWS window not described by
SRAT or HMAT: node1/access0/initiators/{read,write}_{bandwidth,latency}
appear with the calculated coordinates once the region's first memory
block comes online.

Fixes: 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT")
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Changes since v1 (https://lore.kernel.org/r/20260916120338.369436-1-kanie@linux.alibaba.com):

- Open code the one-use helper (Dave Jiang)
- Comment why creating the attributes here is safe: this path runs
  at most once per node (Jonathan Cameron)
- Lead with the user visible regression (Alison Schofield)
---
 drivers/cxl/core/region.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..9a5fd3da539d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/acpi.h>
 #include <linux/memregion.h>
 #include <linux/genalloc.h>
 #include <linux/debugfs.h>
@@ -2630,7 +2631,19 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		if (cxlr->coord[i].read_bandwidth) {
-			node_update_perf_attrs(nid, &cxlr->coord[i], i);
+			/*
+			 * A CFMWS-only node (not backed by a real SRAT pxm)
+			 * has no HMAT memory_target, so hmat_callback()
+			 * never created the access attributes for it:
+			 * create them here instead of only updating them.
+			 * This is called at most once per node (see
+			 * nodemask_region_seen), so the attributes are not
+			 * created twice.
+			 */
+			if (!acpi_node_backed_by_real_pxm(nid))
+				node_set_perf_attrs(nid, &cxlr->coord[i], i);
+			else
+				node_update_perf_attrs(nid, &cxlr->coord[i], i);
 			cset++;
 		}
 	}
-- 
2.43.7

