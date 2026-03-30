Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E12E7179
	for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843229; cv=none; b=e6tOU1xkjnpSXuFY4jwree7kfEEkvHrjAozRUjr18JQW8Z56gahtRzYe0SYenJUj0nFkl4IjNTjgl+gF6bnZFbEyQ++KWXp8xhI/eLi9OsftPNRM6mzQW62ej+EXLpI0a9kKnL0DEvPDhwE/s3NNVRccahxd1a7pcW4Trd1agRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843229; c=relaxed/simple;
	bh=G8MvwTzxV7TL5a+rBI/6GvX32KurSc7P4XBkAFZjpdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQzHQiJcrddyr9pFfPiIyQKunDjgUrqv5M1Moj4t0FQvxN6hsDqtD7k9W8pNF2GZrAWj80btxAiBqtPgKPZ6j4p/SzXYG21MsNvSJPXVfTKi5JwOBT/tuuORCYHEXd41xX1TtP7GIB/aeNPABMPkqHKn+A/5utpV40hoIKMkVf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B63llvN7; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B63llvN7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774843224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=meMlkXTCwOF7sg5hwX0vNCdO6jmrrFvH63kgG+o11/M=;
	b=B63llvN706k3rBYnyAKSe3OYrH8O7TGPBf+CvSu9FBC7THDjR4HBa7kyWm5JUuvDpCpWnX
	tKAcpSLJ/odSDFiJ7/KSXUF7U/t7G5noyy8HIkHTLy7fOID42a/YitNIG4T0HDMZtt59FS
	vDQohd3tcuC5+MVo/cZhAiWUbp8VWAE=
From: Hao Li <hao.li@linux.dev>
To: david@kernel.org,
	osalvador@suse.de,
	akpm@linux-foundation.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	joshua.hahnjy@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Hao Li <hao.li@linux.dev>
Subject: [PATCH v2] mm/memory_hotplug: maintain N_NORMAL_MEMORY during hotplug
Date: Mon, 30 Mar 2026 11:57:49 +0800
Message-ID: <20260330035941.518186-1-hao.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

N_NORMAL_MEMORY is initialized from zone population at boot, but memory
hotplug currently only updates N_MEMORY. As a result, a node that gains
normal memory via hotplug can remain invisible to users iterating over
N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
incorrectly marked as such.

Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
offline_pages(). Set the bit when a node that currently lacks normal
memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
offlining removes the last present pages from zones <= ZONE_NORMAL.

This restores the intended semantics without bringing back the old
status_change_nid_normal notifier plumbing which was removed in
8d2882a8edb8.

Current users that benefit include list_lru, zswap, nfsd filecache,
hugetlb_cgroup, and has_normal_memory sysfs reporting.

Fixes: 8d2882a8edb8 ("mm,memory_hotplug: remove status_change_nid_normal and update documentation")
Signed-off-by: Hao Li <hao.li@linux.dev>
---
Changes: simplify the code. (Thanks Joshua and David)
---
 mm/memory_hotplug.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bc805029da51..05a47953ef21 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1209,6 +1209,13 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	if (node_arg.nid >= 0)
 		node_set_state(nid, N_MEMORY);
+	/*
+	 * Check whether we are adding normal memory to the node for the first
+	 * time.
+	 */
+	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
+		node_set_state(nid, N_NORMAL_MEMORY);
+
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
 
@@ -1908,6 +1915,8 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	unsigned long flags;
 	char *reason;
 	int ret;
+	unsigned long normal_pages = 0;
+	enum zone_type zt;
 
 	/*
 	 * {on,off}lining is constrained to full memory sections (or more
@@ -2055,6 +2064,17 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
+	/*
+	 * Check whether this operation removes the last normal memory from
+	 * the node. We do this before clearing N_MEMORY to avoid the possible
+	 * transient "!N_MEMORY && N_NORMAL_MEMORY" state.
+	 */
+	if (zone_idx(zone) <= ZONE_NORMAL) {
+		for (zt = 0; zt <= ZONE_NORMAL; zt++)
+			normal_pages += pgdat->node_zones[zt].present_pages;
+		if (!normal_pages)
+			node_clear_state(node, N_NORMAL_MEMORY);
+	}
 	/*
 	 * Make sure to mark the node as memory-less before rebuilding the zone
 	 * list. Otherwise this node would still appear in the fallback lists.
-- 
2.50.1

