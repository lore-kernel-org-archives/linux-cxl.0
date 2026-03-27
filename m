Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB791C5486
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774615496; cv=none; b=WEr+Di+NMF8JPn9qMGTxHo3ETrWS0rvr8gSHfpZlvguNlGNHJkujKDJp1xCbkMr9wRNr8kuCDJEdDZXaCA4j4X2YM9LNjLRDVg4T9Wav8WKh4/cKbIT40HbfIyLgXqt6/dTalcbhkVVcG4QOYy8NUwy0vFgn95UxlDFsuCoyzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774615496; c=relaxed/simple;
	bh=xowaL81NGKRtgX6RTWK6OKDnVsOHauBgdYm+8wmDBFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cz0BInKp/RfBiSTMHVcvj1Ex+v7wHWybinIwfSXaVRxsdvN6EiV0pBHBhJReqdfDgyK8QnVuPr1DYa6TgOWSNXzH1/4sEt0tBiB9YVbLF/DQsVVW1trzEj6gcpQKH4ghJS2XC6p6nJsjyjKcdmZEjl7gKO09+Hnn2Mdk87mK8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kclo86X3; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kclo86X3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774615483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KbK7ntUxSzrFQGj/27aTab0fONy8ZoPaESF8ksut9hU=;
	b=Kclo86X3wPXq0hyPYxYklKXZMxUuwSaF1OL1vIZqmGsI5pKDM4aLkX0oUC0noIhMgE/kwR
	gMs9v4lQILgCEDUxRMnWZghAtynZPpEVyiEEHT05DSihJOipWiJn6alDMisXQcl+142F4s
	pCwNA8SKVWSvut/OywWAEYdqU4FtlR4=
From: Hao Li <hao.li@linux.dev>
To: david@kernel.org,
	osalvador@suse.de,
	akpm@linux-foundation.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Hao Li <hao.li@linux.dev>
Subject: [PATCH] mm/memory_hotplug: maintain N_NORMAL_MEMORY during hotplug
Date: Fri, 27 Mar 2026 20:42:47 +0800
Message-ID: <20260327124412.469833-1-hao.li@linux.dev>
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

Signed-off-by: Hao Li <hao.li@linux.dev>
---

This patch also prepares for a subsequent SLUB change that makes
can_free_to_pcs() rely on N_NORMAL_MEMORY to decide whether an object can be
freed to the sheaf.

---
 mm/memory_hotplug.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bc805029da51..5498744aa1f1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1155,6 +1155,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	int need_zonelists_rebuild = 0;
 	unsigned long flags;
 	int ret;
+	bool need_set_normal_memory = false;
 
 	/*
 	 * {on,off}lining is constrained to full memory sections (or more
@@ -1180,6 +1181,9 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 		if (ret)
 			goto failed_addition;
 	}
+	/* Adding normal memory to the node for the first time */
+	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
+		need_set_normal_memory = true;
 
 	ret = memory_notify(MEM_GOING_ONLINE, &mem_arg);
 	ret = notifier_to_errno(ret);
@@ -1209,6 +1213,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	if (node_arg.nid >= 0)
 		node_set_state(nid, N_MEMORY);
+	if (need_set_normal_memory)
+		node_set_state(nid, N_NORMAL_MEMORY);
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
 
@@ -1908,6 +1914,9 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	unsigned long flags;
 	char *reason;
 	int ret;
+	bool need_clear_normal_memory = false;
+	unsigned long node_normal_pages = 0;
+	enum zone_type zt;
 
 	/*
 	 * {on,off}lining is constrained to full memory sections (or more
@@ -1977,6 +1986,13 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			goto failed_removal_isolated;
 		}
 	}
+	/*
+	 * Check whether this operation removes the node's last normal memory.
+	 */
+	for (zt = 0; zt <= ZONE_NORMAL; zt++)
+		node_normal_pages += pgdat->node_zones[zt].present_pages;
+	if (nr_pages >= node_normal_pages && zone_idx(zone) <= ZONE_NORMAL)
+		need_clear_normal_memory = true;
 
 	ret = memory_notify(MEM_GOING_OFFLINE, &mem_arg);
 	ret = notifier_to_errno(ret);
@@ -2055,6 +2071,12 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
+	/*
+	 * Clear N_NORMAL_MEMORY first to avoid the transient state
+	 * "!N_MEMORY && N_NORMAL_MEMORY".
+	 */
+	if (need_clear_normal_memory)
+		node_clear_state(node, N_NORMAL_MEMORY);
 	/*
 	 * Make sure to mark the node as memory-less before rebuilding the zone
 	 * list. Otherwise this node would still appear in the fallback lists.
-- 
2.50.1

