Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6359A7082F;
	Wed,  2 Apr 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558615; cv=none; b=htoDGl35BQK1JrgheH6H0HhVbIusDB4i/W+yXHABGmRias8mfKKIdhQr0hA0jd8Em/bgPhqSB8mfzLe4khhy5lznZFRev9KA7i0XIKGDElpylCEVo3hymiGv+IJYteLSfNrqiDL2JUX/VAZLYcAog4KkFidUncg1kt3ydqxqNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558615; c=relaxed/simple;
	bh=VX0p3J+m4fa+xQJLzqqXnOjle9XG1ttmj5wMfJOjGN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx6RpCIyGcMgmhbDwsOdF9aPSQw4tyEg17tgWa69yso5ECJW6+KTH5FhlGBCMvnp4dh2bQrzev890EwH4QdlOd1e2Zwj4K4n4fbx6W8SnlE/Z2sNcG4NFb0zNhaC+DiOeKK69DNScCwZO4sFb9seNp2xy8bYAmo7x83ZwcT+MEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e8-67ec97ce1b74
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
Subject: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Wed,  2 Apr 2025 10:49:04 +0900
Message-ID: <20250402014906.1086-4-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250402014906.1086-1-rakie.kim@sk.com>
References: <20250402014906.1086-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXC9ZZnoe656W/SDV42clrMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK6P/
	8H32gibjiqkvrzM1ME7T6mLk5JAQMJF40r+YDcY+9X8SaxcjBwebgJLEsb0xIGERAVGJeUdn
	s3QxcnEwC1xjkjjw+SYLSEJYIFhi5ZVjYDaLgKrEn//z2EFsXqA5S+Z9YoWYqSnRcOkeE8hM
	TgFTia/dYCVCQCVNt5ewQJQLSpyc+QTMZhaQl2jeOpsZZJeEwHM2iV39v1kg5khKHFxxg2UC
	I/8sJD2zkPQsYGRaxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREY7stq/0TvYPx0IfgQowAHoxIP
	bwPvm3Qh1sSy4srcQ4wSHMxKIrwRX1+mC/GmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQ
	nliSmp2aWpBaBJNl4uCUamD0lCxKm/rnl9xsb9mpPfmhLTdPGhyTSbqh+P17zISrs5ZeZzO9
	6rdDL8d/sk5nsoVXNEOX3Mm3VyZNkdvPManM+NusuR1LP1uw+TyMYNPzuKG0680X+2wpvdrZ
	rkk6ShIrH8VszVJNqjh/ycpHm/eAS5wWt+KfnaHHc8uLxZZ+2+y5Uvrs4j1KLMUZiYZazEXF
	iQDjDgjFcwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNNS/fs9DfpBrduG1vMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvF52evmS1WLbzGZnF86zx2i8NzT7JanJ91isXi8q45bBb31vxntTh07Tmr
	xeo1GRa/t61gc+Dz2DnrLrtHd9tldo+WI29ZPRbvecnksenTJHaPEzN+s3jsfGjp8X7fVTaP
	b7c9PBa/+MDk8XmTXAB3FJdNSmpOZllqkb5dAldG/+H77AVNxhVTX15namCcptXFyMkhIWAi
	cer/JNYuRg4ONgEliWN7Y0DCIgKiEvOOzmbpYuTiYBa4xiRx4PNNFpCEsECwxMorx8BsFgFV
	iT//57GD2LxAc5bM+8QKMVNTouHSPSaQmZwCphJfu8FKhIBKmm4vYYEoF5Q4OfMJmM0sIC/R
	vHU28wRGnllIUrOQpBYwMq1iFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDPFltX8m7mD8ctn9
	EKMAB6MSD69Az5t0IdbEsuLK3EOMEhzMSiK8EV9fpgvxpiRWVqUW5ccXleakFh9ilOZgURLn
	9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUw1quf6/c1ujPnwEfje2v/WqycdPny/lXzwm6t+21z
	hDnMc8cvhxKro6/Pdfg/0o2u28/R8bHXc4W1U6VcnqJh0JcN006uqvqh4h93fO/TrGnzWE5W
	znDLe5/qICQyfbLskQ+dbu6aO05NNFSZpaOVlRp4cUaKV9d6saqLOm6f99flbl+uFnrqtBJL
	cUaioRZzUXEiAGQV7optAgAA
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
---
 mm/mempolicy.c | 110 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 23 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3092a792bd28..ea4f3f3f2cdd 100644
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
 
@@ -3439,13 +3441,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static void sysfs_wi_node_release(int nid)
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
@@ -3464,35 +3477,81 @@ static const struct kobj_type wi_ktype = {
 
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
+		if (!node_state(nid, N_MEMORY))
+			sysfs_wi_node_release(nid);
+		break;
+	}
+
+notifier_end:
+	return NOTIFY_OK;
 }
 
 static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
@@ -3504,13 +3563,17 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 		       GFP_KERNEL);
 	if (!wi_group)
 		return -ENOMEM;
+	mutex_init(&wi_group->kobj_lock);
 
 	err = kobject_init_and_add(&wi_group->wi_kobj, &wi_ktype, mempolicy_kobj,
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
@@ -3518,6 +3581,7 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 		}
 	}
 
+	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
 	return 0;
 
 err_out:
-- 
2.34.1

