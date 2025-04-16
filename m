Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C65241105;
	Wed, 16 Apr 2025 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803108; cv=none; b=qoxPoK/6JJQHXFAJ7AJnFdwUVJmjiYWNGiamLA4nF1ZniIbX+ezZVZpFFiSTKPWf+nIzH7DgueHkBtnyA61ZQfWsvJsrLWtgNGpq4cIG5heBA7D1EspMQdb7PtnFtCGktOFicxPMya7urEIlwVjnOxk40OJGFbdPPi3NUChxEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803108; c=relaxed/simple;
	bh=g9JnpnRICVU9vxFcfjUIoFbm4Xm00Wy0Cr/gAkYvWUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhMArubIfD1/tcphSLZoZ51jZu1HHUExtaUgBdyhl3uzhPFbBoF1v5zDqp++HHa9xduKmwXbf7lZcK1WY/NGV1mfxCnYAgkgO+bfBoR9t8YTVipQZ3gRBT6jyts1c663do8h8wDtqmtlmfQECCNxR9VOoBuIEeSEYsjt4pU3KDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-25-67ff951d1539
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
Subject: [PATCH v8 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Wed, 16 Apr 2025 20:31:21 +0900
Message-ID: <20250416113123.629-4-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250416113123.629-1-rakie.kim@sk.com>
References: <20250416113123.629-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnka7s1P/pBtduiljMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Ms7unMJasMu44uSJ1cwNjDu0uhg5OSQETCTmf/zKBGMv/fSZpYuRg4NNQEni2N4Y
	kLCIgKzE1L/ngcJcHMwCj5kkHj1/wQiSEBYIlvj1dxI7iM0ioCrx5P96VhCbV8BY4uz2RcwQ
	MzUlGi7dA5vPCTT/5KRFYL1CQDVbX81jhKgXlDg58wkLiM0sIC/RvHU2M8gyCYHPbBLN/VcY
	IQZJShxccYNlAiP/LCQ9s5D0LGBkWsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGAHLav9E72D8
	dCH4EKMAB6MSD29E/L90IdbEsuLK3EOMEhzMSiK858yBQrwpiZVVqUX58UWlOanFhxilOViU
	xHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhhN5YS26e48dnyP5QLHv8w2U6qFstcKTliauCWX
	a4kHv3rHItcJzOumS+zYPEuF4ZOXjOX85Vafoo4l2DvuMOVbdDs75uoFmwwFxlo5yWv6Wt3y
	0aJL5qo1HTrF+XmZ5fFfi16v8Tqq+vrPHb7p0UvsEnWbCjYVRrud/Cud+6LyUVVIidLlRAUl
	luKMREMt5qLiRAAj0FpxfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS1d26v90gxer2S3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDLO7pzCWrDLuOLkidXMDYw7
	tLoYOTkkBEwkln76zNLFyMHBJqAkcWxvDEhYREBWYurf80BhLg5mgcdMEo+ev2AESQgLBEv8
	+juJHcRmEVCVePJ/PSuIzStgLHF2+yJmiJmaEg2X7jGB2JxA809OWgTWKwRUs/XVPEaIekGJ
	kzOfsIDYzALyEs1bZzNPYOSZhSQ1C0lqASPTKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMCg
	X1b7Z+IOxi+X3Q8xCnAwKvHwRsT/SxdiTSwrrsw9xCjBwawkwnvOHCjEm5JYWZValB9fVJqT
	WnyIUZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXA2NfIXTil1SPiGpv+7n1XO8JeBJ3a
	szH18uw/1svvcbD18K6Wi13sMlup4+zxCQqlhfZvns34H5YlyJa/2GqtoLbuLo7na0orG/0E
	futLle5exvElNdPs6E+5pMLKf1vW2lm69Nja3571qvl/Zdn/J5XPu84asjzcrqqefcvCkZN9
	xVQ39v63SizFGYmGWsxFxYkAku5R6XYCAAA=
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

Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Yunjeong Mun <yunjeong.mun@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/mempolicy.c | 107 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 23 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 998635127e9d..646fc9e8c8ac 100644
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
 
 static void sysfs_wi_node_delete_all(void)
@@ -3517,35 +3530,77 @@ static const struct kobj_type wi_ktype = {
 
 static int sysfs_wi_node_add(int nid)
 {
-	struct iw_node_attr *node_attr;
+	int ret = 0;
 	char *name;
+	struct iw_node_attr *new_attr;
 
-	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
-	if (!node_attr)
+	if (nid < 0 || nid >= nr_node_ids) {
+		pr_err("invalid node id: %d\n", nid);
+		return -EINVAL;
+	}
+
+	new_attr = kzalloc(sizeof(*new_attr), GFP_KERNEL);
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
+	sysfs_attr_init(&new_attr->kobj_attr.attr);
+	new_attr->kobj_attr.attr.name = name;
+	new_attr->kobj_attr.attr.mode = 0644;
+	new_attr->kobj_attr.show = node_show;
+	new_attr->kobj_attr.store = node_store;
+	new_attr->nid = nid;
 
-	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
-		kfree(node_attr->kobj_attr.attr.name);
-		kfree(node_attr);
-		pr_err("failed to add attribute to weighted_interleave\n");
-		return -ENOMEM;
+	mutex_lock(&wi_group->kobj_lock);
+	if (wi_group->nattrs[nid]) {
+		mutex_unlock(&wi_group->kobj_lock);
+		pr_info("node%d already exists\n", nid);
+		goto out;
 	}
 
-	wi_group->nattrs[nid] = node_attr;
+	ret = sysfs_create_file(&wi_group->wi_kobj, &new_attr->kobj_attr.attr);
+	if (ret) {
+		mutex_unlock(&wi_group->kobj_lock);
+		goto out;
+	}
+	wi_group->nattrs[nid] = new_attr;
+	mutex_unlock(&wi_group->kobj_lock);
 	return 0;
+
+out:
+	kfree(new_attr->kobj_attr.attr.name);
+	kfree(new_attr);
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
+	switch (action) {
+	case MEM_ONLINE:
+		err = sysfs_wi_node_add(nid);
+		if (err)
+			pr_err("failed to add sysfs for node%d during hotplug: %d\n",
+			       nid, err);
+		break;
+	case MEM_OFFLINE:
+		sysfs_wi_node_delete(nid);
+		break;
+	}
+
+	return NOTIFY_OK;
 }
 
 static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
@@ -3556,20 +3611,26 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
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
-			pr_err("failed to add sysfs [node%d]\n", nid);
+			pr_err("failed to add sysfs for node%d during init: %d\n",
+			       nid, err);
 			goto err_cleanup_kobj;
 		}
 	}
 
+	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
 	return 0;
 
 err_cleanup_kobj:
-- 
2.34.1

