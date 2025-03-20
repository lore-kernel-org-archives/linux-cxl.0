Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49511EE010;
	Thu, 20 Mar 2025 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742444314; cv=none; b=fHv/pxp4+2RJ/Gl/67Y0I8cscpn2PVQ3rfxuI5ciblW26XAbfafsVm6dbHepQr7Dap68hkrRCWCooMTbww5wKm5kBr87i0f06CoA6eVNmw+CfluZnco5W/u8RhE93XmcIhpdV4zSM0HtSXGp2udojxooPGPLpwLLOYCxxc+awZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742444314; c=relaxed/simple;
	bh=3XYlrZ+XnbsjuFy6YK2KNxnwj2O9KJ3LwPlsnms0OLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtaksJtavshIMRHQw86IgJ5xKnr90cKoctOLxdM4ra/hXY61csjFt18PORR2GtF+nBfIJgGZ0zFtLiR/qtYcI6RYiNjUAfMRC4TeYfeMqMZGwqmgJqOgZxTD3xpgxxuLS6Lwyn8Uxql7OZ017lyG6Fsg2hkqfgRnkptn9Y5Ycbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-46-67db970c9614
From: Rakie Kim <rakie.kim@sk.com>
To: gourry@gourry.net
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [PATCH v3 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Thu, 20 Mar 2025 13:17:48 +0900
Message-ID: <20250320041749.881-4-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250320041749.881-1-rakie.kim@sk.com>
References: <20250320041749.881-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXC9ZZnoS7P9NvpBt3TBC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2qxek2GA5fHzll32T262y6z
	e7QcecvqsXjPSyaPTZ8msXucmPGbxWPnQ0uP9/uusnl83iQXwBnFZZOSmpNZllqkb5fAlbG2
	9wFTwXODigt3VzM1MM7Q6GLk5JAQMJE4uvEIG4x9cNYmpi5GDg42ASWJY3tjQMIiAqIS847O
	Zuli5OJgFrjGJHHg800WkISwQLDEo+aTTCA2i4CqxNHlvcwgNq+AsUTL/jOMEDM1JRou3QOr
	4QSaP+XqfDaQ+UJANW/P8UKUC0qcnPkEbCSzgLxE89bZzCC7JASes0lcffYU6jZJiYMrbrBM
	YOSfhaRnFpKeBYxMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECw31Z7Z/oHYyfLgQfYhTgYFTi
	4X1x5Va6EGtiWXFl7iFGCQ5mJRFekY7b6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJ
	pCeWpGanphakFsFkmTg4pRoYS5dNOlymeTGj7MR6YZ0N+1SqRYPE59/cr/ZM0v64m722sttu
	h58ighs9pxs9aVgllT73UkL+P783u2e8Y+C1vHR4RfM5iXXd1876/NyQ+/HlLZ1TKxKtW3+9
	12SbUF2sKHrPSe3r9deL2Pce//tYSj7vvMm2t3434/7HnzN8vCIrdN6+dS82VyqxFGckGmox
	FxUnAgAEo+wMcwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNNS5dn+u10g3tdbBZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLQ5de85q
	sXpNhsXvbSvYHPg8ds66y+7R3XaZ3aPlyFtWj8V7XjJ5bPo0id3jxIzfLB47H1p6vN93lc3j
	220Pj8UvPjB5fN4kF8AdxWWTkpqTWZZapG+XwJWxtvcBU8Fzg4oLd1czNTDO0Ohi5OSQEDCR
	ODhrE1MXIwcHm4CSxLG9MSBhEQFRiXlHZ7N0MXJxMAtcY5I48PkmC0hCWCBY4lHzSSYQm0VA
	VeLo8l5mEJtXwFiiZf8ZRoiZmhINl+6B1XACzZ9ydT4byHwhoJq353ghygUlTs58AjaSWUBe
	onnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERjiy2r/TNzB+OWy
	+yFGAQ5GJR7eF1dupQuxJpYVV+YeYpTgYFYS4RXpuJ0uxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwLjIqcjtnZqO+HZmLRHtjItJW07HGT8vXqz4+9pu
	s7wlxyIP+3XdurK1kmWfXNkSfS/mtbwBMj73prrPdzHy25KkWcJn8Ng28/+ypyXTxGoKtonW
	vvgfF5p0ep/Rtb+67D+2cjz6p1u6QFspS8iSLymUf1Hogf+7GzXctkhuOlL/7Jlhe2V/qRJL
	cUaioRZzUXEiAKUUvvJtAgAA
X-CFilter-Loop: Reflected

The weighted interleave policy distributes page allocations across multiple
NUMA nodes based on their performance weight, thereby improving memory
bandwidth utilization. The weight values for each node are configured
through sysfs.

Previously, sysfs entries for configuring weighted interleave were created
for all possible nodes (N_POSSIBLE) at initialization, including nodes that
might not have memory. However, not all nodes in N_POSSIBLE are usable at
runtime, as some may remain memoryless or offline.
This led to sysfs entries being created for unusable nodes, causing
potential misconfiguration issues.

To address this issue, this patch modifies the sysfs creation logic to:
1) Limit sysfs entries to nodes that are online and have memory, reducing
   the creation of sysfs attributes for unusable nodes.
2) Support memory hotplug by dynamically adding and removing sysfs entries
   based on whether a node transitions into or out of the N_MEMORY state.

Additionally, the patch ensures that sysfs attributes are properly managed
when nodes go offline, preventing stale or redundant entries from persisting
in the system.

By making these changes, the weighted interleave policy now manages its
sysfs entries more efficiently, ensuring that only relevant nodes are
considered for interleaving, and dynamically adapting to memory hotplug
events.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 mm/mempolicy.c | 108 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 22 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6c8843114afd..91cdc1d9d43e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -113,6 +113,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <linux/uaccess.h>
+#include <linux/memory.h>
 
 #include "internal.h"
 
@@ -3390,6 +3391,7 @@ struct iw_node_attr {
 
 struct sysfs_wi_group {
 	struct kobject wi_kobj;
+	struct mutex kobj_lock;
 	struct iw_node_attr *nattrs[];
 };
 
@@ -3439,12 +3441,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static void sysfs_wi_node_release(int nid)
 {
-	if (!sgrp->nattrs[nid])
+	struct iw_node_attr *attr;
+
+	if (nid < 0 || nid >= nr_node_ids)
+		return;
+
+	mutex_lock(&sgrp->kobj_lock);
+	attr = sgrp->nattrs[nid];
+	if (!attr) {
+		mutex_unlock(&sgrp->kobj_lock);
 		return;
+	}
+
+	sgrp->nattrs[nid] = NULL;
+	mutex_unlock(&sgrp->kobj_lock);
 
-	sysfs_remove_file(&sgrp->wi_kobj, &sgrp->nattrs[nid]->kobj_attr.attr);
-	kfree(sgrp->nattrs[nid]->kobj_attr.attr.name);
-	kfree(sgrp->nattrs[nid]);
+	sysfs_remove_file(&sgrp->wi_kobj, &attr->kobj_attr.attr);
+	kfree(attr->kobj_attr.attr.name);
+	kfree(attr);
 }
 
 static void sysfs_wi_release(struct kobject *wi_kobj)
@@ -3463,35 +3477,80 @@ static const struct kobj_type wi_ktype = {
 
 static int sysfs_wi_node_add(int nid)
 {
-	struct iw_node_attr *node_attr;
+	int ret = 0;
 	char *name;
+	struct iw_node_attr *new_attr = NULL;
+
+	if (nid < 0 || nid >= nr_node_ids) {
+		pr_err("Invalid node id: %d\n", nid);
+		return -EINVAL;
+	}
 
-	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
-	if (!node_attr)
+	new_attr = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);
+	if (!new_attr)
 		return -ENOMEM;
 
 	name = kasprintf(GFP_KERNEL, "node%d", nid);
 	if (!name) {
-		kfree(node_attr);
+		kfree(new_attr);
 		return -ENOMEM;
 	}
 
-	sysfs_attr_init(&node_attr->kobj_attr.attr);
-	node_attr->kobj_attr.attr.name = name;
-	node_attr->kobj_attr.attr.mode = 0644;
-	node_attr->kobj_attr.show = node_show;
-	node_attr->kobj_attr.store = node_store;
-	node_attr->nid = nid;
+	mutex_lock(&sgrp->kobj_lock);
+	if (sgrp->nattrs[nid]) {
+		mutex_unlock(&sgrp->kobj_lock);
+		pr_info("Node [%d] already exists\n", nid);
+		kfree(new_attr);
+		kfree(name);
+		return 0;
+	}
 
-	if (sysfs_create_file(&sgrp->wi_kobj, &node_attr->kobj_attr.attr)) {
-		kfree(node_attr->kobj_attr.attr.name);
-		kfree(node_attr);
-		pr_err("failed to add attribute to weighted_interleave\n");
-		return -ENOMEM;
+	sgrp->nattrs[nid] = new_attr;
+	mutex_unlock(&sgrp->kobj_lock);
+
+	sysfs_attr_init(&sgrp->nattrs[nid]->kobj_attr.attr);
+	sgrp->nattrs[nid]->kobj_attr.attr.name = name;
+	sgrp->nattrs[nid]->kobj_attr.attr.mode = 0644;
+	sgrp->nattrs[nid]->kobj_attr.show = node_show;
+	sgrp->nattrs[nid]->kobj_attr.store = node_store;
+	sgrp->nattrs[nid]->nid = nid;
+
+	ret = sysfs_create_file(&sgrp->wi_kobj, &sgrp->nattrs[nid]->kobj_attr.attr);
+	if (ret) {
+		kfree(sgrp->nattrs[nid]->kobj_attr.attr.name);
+		kfree(sgrp->nattrs[nid]);
+		sgrp->nattrs[nid] = NULL;
+		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
 	}
 
-	sgrp->nattrs[nid] = node_attr;
-	return 0;
+	return ret;
+}
+
+static int wi_node_notifier(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	int err;
+	struct memory_notify *arg = data;
+	int nid = arg->status_change_nid;
+
+	if (nid < 0)
+		goto notifier_end;
+
+	switch(action) {
+	case MEM_ONLINE:
+		err = sysfs_wi_node_add(nid);
+		if (err) {
+			pr_err("failed to add sysfs [node%d]\n", nid);
+			return NOTIFY_BAD;
+		}
+		break;
+	case MEM_OFFLINE:
+		sysfs_wi_node_release(nid);
+		break;
+	}
+
+notifier_end:
+	return NOTIFY_OK;
 }
 
 static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
@@ -3503,13 +3562,17 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 		       GFP_KERNEL);
 	if (!sgrp)
 		return -ENOMEM;
+	mutex_init(&sgrp->kobj_lock);
 
 	err = kobject_init_and_add(&sgrp->wi_kobj, &wi_ktype, mempolicy_kobj,
 				   "weighted_interleave");
 	if (err)
 		goto err_out;
 
-	for_each_node_state(nid, N_POSSIBLE) {
+	for_each_online_node(nid) {
+		if (!node_state(nid, N_MEMORY))
+			continue;
+
 		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
@@ -3517,6 +3580,7 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 		}
 	}
 
+	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
 	return 0;
 
 err_out:
-- 
2.34.1

