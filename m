Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DA37F8A4
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784266218; cv=none; b=jhCqAm3SS5+4zHa/+VIKxHc3F05gFCzw6Te32eTgjapRrjUII8tForq3/ZeERpcvBRRQ88RwE7phZAvG63S8l9vH+MgPVCswF58i/Tk9cxyHxXMN0UEcoUuz1mQVbfB/0+u39jPPxL8hiyjnq948LhsKOQR2CIz6Uo+qo1rX/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784266218; c=relaxed/simple;
	bh=0zHSMOqRf7tKj2VmZyT/nw+2l1qOifzELoMF3o6qj2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJfp1+l6Y2WH7gDTcqIR4VBFJxvqd/XtwAh/v6xMP4H3EFypjkqjnSu4ASNoBz1g+FkPH8gyhEQOOTHTOo5vGyx2v1jIkpB8axvVBA0QxE6VXWlryPbr+zadXGhX3DYGC3Wxp8CS7r0tBLMu89gmYFWYgRbqgQdOYvjgiCt7IKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ECyRo5VN; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ECyRo5VN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784266214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=36ZQDquEIblWlclEPzlW5WX9ajSjC3KeMbCh3AwoOQk=;
	b=ECyRo5VN0omOVANxqKnks372lZPZyJ2z+xrdGKWUJUMA11MLKW9YfG9UzGqld6eiHkDnIk
	XwQNqBsmGgZnQ5ZUrGixjXwq0zRcpb1kGy6J4Uwq+xblst+MryUI2OJMBv5aEJU9LL3htS
	Lryklz64uUixVU1lYubINNHlse+p5z8=
From: Hongfu Li <hongfu.li@linux.dev>
To: david@kernel.org,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	rppt@kernel.org
Cc: linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hongfu.li@linux.dev,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] mm: add missing alloc_percpu() NULL check in hotplug init
Date: Fri, 17 Jul 2026 13:29:38 +0800
Message-ID: <20260717052938.58447-1-hongfu.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hongfu Li <lihongfu@kylinos.cn>

No NULL check is done for alloc_percpu() when initializing per-CPU
nodestats. Allocation failure leads to NULL pointer dereference
during later memset.

Make function return int, check alloc_percpu() result and return
-ENOMEM on error. The caller chain already propagates this error
correctly.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            |  3 ++-
 mm/mm_init.c                   | 14 +++++++++++---
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7c9d66729c60..f04b915678db 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -289,7 +289,7 @@ static inline void __remove_memory(u64 start, u64 size) {}
 /* Default online_type (MMOP_*) when new memory blocks are added. */
 extern enum mmop mhp_get_default_online_type(void);
 extern void mhp_set_default_online_type(enum mmop online_type);
-extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
+extern int __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
 extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory_resource(int nid, struct resource *resource,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7ac19fab2263..8b137328dcf0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1263,7 +1263,8 @@ static pg_data_t *hotadd_init_pgdat(int nid)
 	pgdat = NODE_DATA(nid);
 
 	/* init node's zones as empty zones, we don't have any present pages.*/
-	free_area_init_core_hotplug(pgdat);
+	if (free_area_init_core_hotplug(pgdat))
+		return NULL;
 
 	/*
 	 * The node we allocated has no zone fallback lists. For avoiding
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0f64909e8d20..24770947a66f 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1536,7 +1536,7 @@ void __init set_pageblock_order(void)
  * NOTE: this function is only called during memory hotplug
  */
 #ifdef CONFIG_MEMORY_HOTPLUG
-void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
+int __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 {
 	int nid = pgdat->node_id;
 	enum zone_type z;
@@ -1544,8 +1544,14 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 
 	pgdat_init_internals(pgdat);
 
-	if (pgdat->per_cpu_nodestats == &boot_nodestats)
-		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
+	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
+		struct per_cpu_nodestat __percpu *new;
+
+		new = alloc_percpu(struct per_cpu_nodestat);
+		if (!new)
+			return -ENOMEM;
+		pgdat->per_cpu_nodestats = new;
+	}
 
 	/*
 	 * Reset the nr_zones, order and highest_zoneidx before reuse.
@@ -1576,6 +1582,8 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 		zone->present_pages = 0;
 		zone_init_internals(zone, z, nid, 0);
 	}
+
+	return 0;
 }
 #endif
 
-- 
2.54.0

