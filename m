Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DBE2620F1;
	Tue,  8 Apr 2025 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097647; cv=none; b=ZAwOY9Yuj98tGt3B4N9caBvuJT0NvO1b0H3tIcB6dg8ncWtAlUPj04YRlbMMU14rQf2ur8eFpxXRGGgQn0ZV2W1CDNJg1KwH8akES66nJj+H46u7tZR5fVtiBInKsK+WuRKh7ZOFNPKdkxLv2P7NLsxdJvibonbGY1FGKBKpbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097647; c=relaxed/simple;
	bh=E64xAlqRsZMVBNgvwkRrl49zQFfaMiYAt6ikveJR5wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUdb/JevOpn4vdfOQmpZmzvyhQt866qmYa00lna7PM/8cxGtPPEX5oDkvvgC0/1IgIK6F631JV1KkvALXz1N+/tceZfd/GBp8uo2FfIyPHWhadhRtnDIcwB+pT0+DnYJwA0+UWgzVTlv5m5fTfZx/g1ZtMtfJURlIjTZrYLqhLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-08-67f4d165d318
From: Rakie Kim <rakie.kim@sk.com>
To: akpm@linux-foundation.org
Cc: gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Tue,  8 Apr 2025 16:32:42 +0900
Message-ID: <20250408073243.488-4-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250408073243.488-1-rakie.kim@sk.com>
References: <20250408073243.488-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnkW7qxS/pBjcvyFvMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Mhq3rmAt+G5UcfX+Y7YGxllaXYycHBICJhLzllxn6mLkALMvnfYEMdkElCSO7Y0B
	qRARkJWY+vc8SxcjFwezwGMmiUfPXzCC1AgLBEvM/+UKUsMioCoxddV8NhCbV8BY4uHrP2wQ
	0zUlGi7dYwKxOYGm/z+9mwWkVQiopnd6IkS5oMTJmU9YQGxmAXmJ5q2zmSFav7NJ7LiuDmFL
	ShxccYNlAiP/LCQts5C0LGBkWsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGPjLav9E72D8dCH4
	EKMAB6MSD6/H0c/pQqyJZcWVuYcYJTiYlUR43078ki7Em5JYWZValB9fVJqTWnyIUZqDRUmc
	1+hbeYqQQHpiSWp2ampBahFMlomDU6qBsY7jyivzvy8lrx/svOF9wsxGcEPGofaQLWzslpPb
	J9Qa55q8rkq4J7DlwoLyA3Z7V0oWBLo+d7Sb+bqbcdvU9MBNzwwD+e/UTvodmDN9TUgn05Yl
	2b8Pfqm8Z//iecCV9XzXHj+WzV/8/OCt3mW8ExfOLMowmSit8ZT//iGLtqZQFZN9mfqs8kos
	xRmJhlrMRcWJALQg/uN4AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXCNUNNSzf14pd0gwc7hS3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDIat65gLfhuVHH1/mO2BsZZ
	Wl2MHBwSAiYSl057gphsAkoSx/bGdDFycogIyEpM/XuepYuRi4NZ4DGTxKPnLxhBaoQFgiXm
	/3IFqWERUJWYumo+G4jNK2As8fD1HzBbQkBTouHSPSYQmxNo+v/Tu1lAWoWAanqnJ0KUC0qc
	nPmEBcRmFpCXaN46m3kCI88sJKlZSFILGJlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIb7
	sto/E3cwfrnsfohRgINRiYfX4+jndCHWxLLiytxDjBIczEoivG8nfkkX4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYLxq+ypBVy08yWV/tCHjhLnPjRPi
	v5la+yev8Ledvip0pmzgnoDzgXsOS0iZKd7+vHLO2X+iXgseXC3PdthV+L0lvWh35faUg3qS
	PWvDNyxfd/z65dZPFYuUHT7Z+84+6tm+5Unql5z4eMu4+08Vdld+mrDE6YWs4wvX+3Wtj+6U
	T2UIjY7I+qPEUpyRaKjFXFScCACg8k82cwIAAA==
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
1) Limit sysfs entries to nodes that are online and have memory, avoiding
   the creation of sysfs entries for nodes that cannot be used.
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
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/mempolicy.c | 106 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 23 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 988575f29c53..9aa884107f4c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -113,6 +113,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <linux/uaccess.h>
+#include <linux/memory.h>
 
 #include "internal.h"
 
@@ -3421,6 +3422,7 @@ struct iw_node_attr {
 
 struct sysfs_wi_group {
 	struct kobject wi_kobj;
+	struct mutex kobj_lock;
 	struct iw_node_attr *nattrs[];
 };
 
@@ -3470,13 +3472,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static void sysfs_wi_node_delete(int nid)
 {
-	if (!wi_group->nattrs[nid])
+	struct iw_node_attr *attr;
+
+	if (nid < 0 || nid >= nr_node_ids)
+		return;
+
+	mutex_lock(&wi_group->kobj_lock);
+	attr = wi_group->nattrs[nid];
+	if (!attr) {
+		mutex_unlock(&wi_group->kobj_lock);
 		return;
+	}
+
+	wi_group->nattrs[nid] = NULL;
+	mutex_unlock(&wi_group->kobj_lock);
 
-	sysfs_remove_file(&wi_group->wi_kobj,
-			  &wi_group->nattrs[nid]->kobj_attr.attr);
-	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
-	kfree(wi_group->nattrs[nid]);
+	sysfs_remove_file(&wi_group->wi_kobj, &attr->kobj_attr.attr);
+	kfree(attr->kobj_attr.attr.name);
+	kfree(attr);
 }
 
 static void sysfs_wi_release(struct kobject *wi_kobj)
@@ -3495,35 +3508,77 @@ static const struct kobj_type wi_ktype = {
 
 static int sysfs_wi_node_add(int nid)
 {
-	struct iw_node_attr *node_attr;
+	int ret = 0;
 	char *name;
+	struct iw_node_attr *new_attr = NULL;
 
-	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
-	if (!node_attr)
+	if (nid < 0 || nid >= nr_node_ids) {
+		pr_err("Invalid node id: %d\n", nid);
+		return -EINVAL;
+	}
+
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
+	mutex_lock(&wi_group->kobj_lock);
+	if (wi_group->nattrs[nid]) {
+		mutex_unlock(&wi_group->kobj_lock);
+		pr_info("Node [%d] already exists\n", nid);
+		kfree(new_attr);
+		kfree(name);
+		return 0;
+	}
+	wi_group->nattrs[nid] = new_attr;
 
-	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
-		kfree(node_attr->kobj_attr.attr.name);
-		kfree(node_attr);
-		pr_err("failed to add attribute to weighted_interleave\n");
-		return -ENOMEM;
+	sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
+	wi_group->nattrs[nid]->kobj_attr.attr.name = name;
+	wi_group->nattrs[nid]->kobj_attr.attr.mode = 0644;
+	wi_group->nattrs[nid]->kobj_attr.show = node_show;
+	wi_group->nattrs[nid]->kobj_attr.store = node_store;
+	wi_group->nattrs[nid]->nid = nid;
+
+	ret = sysfs_create_file(&wi_group->wi_kobj,
+				&wi_group->nattrs[nid]->kobj_attr.attr);
+	if (ret) {
+		kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
+		kfree(wi_group->nattrs[nid]);
+		wi_group->nattrs[nid] = NULL;
+		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
 	}
+	mutex_unlock(&wi_group->kobj_lock);
 
-	wi_group->nattrs[nid] = node_attr;
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
+		return NOTIFY_OK;
+
+	switch(action) {
+	case MEM_ONLINE:
+		err = sysfs_wi_node_add(nid);
+		if (err)
+			pr_err("failed to add sysfs [node%d]\n", nid);
+		break;
+	case MEM_OFFLINE:
+		sysfs_wi_node_delete(nid);
+		break;
+	}
+
+	return NOTIFY_OK;
 }
 
 static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
@@ -3534,13 +3589,17 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 			   GFP_KERNEL);
 	if (!wi_group)
 		return -ENOMEM;
+	mutex_init(&wi_group->kobj_lock);
 
 	err = kobject_init_and_add(&wi_group->wi_kobj, &wi_ktype, mempolicy_kobj,
 				   "weighted_interleave");
 	if (err)
 		goto err_put_kobj;
 
-	for_each_node_state(nid, N_POSSIBLE) {
+	for_each_online_node(nid) {
+		if (!node_state(nid, N_MEMORY))
+			continue;
+
 		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
@@ -3548,6 +3607,7 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 		}
 	}
 
+	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
 	return 0;
 
 err_del_kobj:
-- 
2.34.1

