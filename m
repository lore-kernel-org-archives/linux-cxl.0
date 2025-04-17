Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0F21C9F3;
	Thu, 17 Apr 2025 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874958; cv=none; b=UusKZT+og/RIaq/VculeSTJv3yaMU5Kgz4xPkZ6BRmNrNqpPIwciIOEsS7qrzZhNgsq5A0+iuSCpIkyb1sYa9ZhHD6pP8mwSNXqhHuPlE9gIQKHvL6i0bWlMe5BDbpHCqtBtzMogYXcGRQP5i9EepbgaArYftQmBct/IbuIqA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874958; c=relaxed/simple;
	bh=yWyxpKG8iERiYLY2v9BSypCPX5mMGZK9dCnWQUP5Q/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJmxTIm9sFAOm/PSn1iX7tkKzY7vZxxDGc+o/3KsgUoZcR2Qsx3BlXi6wwAyHZwe6jzA/UbH3MiRFphhKosA3cnsaf9+INZ0V5iQEOUff621K+XmWc2KnhD5F0kuMd37fMZDcrY9Z+A7q45CrxOwqzxCyFkK43kmlB0QI008nGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-12-6800adc65bd6
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
Subject: [PATCH v9 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Thu, 17 Apr 2025 16:28:37 +0900
Message-ID: <20250417072839.711-4-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250417072839.711-1-rakie.kim@sk.com>
References: <20250417072839.711-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoe6xtQwZBp8X81jMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Mtrab7AWfDCuuDZ5PnsD40utLkZODgkBE4nnq6YzwtgnDjQxdTFycLAJKEkc2xsD
	EhYRkJWY+vc8SxcjFwezwGMmiUfPX4DVCwsESxxbvYgNxGYRUJU4cG8GO4jNK2AscfpWFxPE
	TE2Jhkv3wGxOoPnTdrcwg9hCQDUzX01ng6gXlDg58wkLiM0sIC/RvHU2M8gyCYHvbBIfZmyF
	Ok5S4uCKGywTGPlnIemZhaRnASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzACFhW+yd6B+On
	C8GHGAU4GJV4eE8s+p8uxJpYVlyZe4hRgoNZSYT3nPm/dCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MzPfuKj+bZR32bIltfPAaZwfl29765x6s5Wqb
	9fTuksmt/wM6lz3+ulr/lmf/uzJm0Q79m4ymnifFGVQO8qx2Sl3xdPGNkOYtpm8k1PXjn9Rs
	3prwrcHD/lL2181RH6dmRuyokZ26ZGnFBE+2VyZ/rEry5kZPKvjNMOdcyKUnIecXLzDNerzk
	gRJLcUaioRZzUXEiAAybUft8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS/fYWoYMgyPrWC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDLa2m+wFnwwrrg2eT57A+NL
	rS5GTg4JAROJEweamLoYOTjYBJQkju2NAQmLCMhKTP17nqWLkYuDWeAxk8Sj5y8YQRLCAsES
	x1YvYgOxWQRUJQ7cm8EOYvMKGEucvtXFBDFTU6Lh0j0wmxNo/rTdLcwgthBQzcxX09kg6gUl
	Ts58wgJiMwvISzRvnc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQKD
	flntn4k7GL9cdj/EKMDBqMTDe2LR/3Qh1sSy4srcQ4wSHMxKIrznzP+lC/GmJFZWpRblxxeV
	5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTCahEkfvhp+farp7Cu7N6xOYLkX
	57B6Q5OwYV9jeMD36P0HYhYe4w68YXqoo/F2mer29nn3g7+EZR70TNwitWvNd8Nt/hOFa+xe
	MXzVWKA75351G9/EKxODhRTlp85kO5eg4lIlHbDg5jvX2+G+D++oRMtyfbuzwkFhWeOUCgm5
	ixNX1W1INXihxFKckWioxVxUnAgA8/fEZXYCAAA=
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/mempolicy.c | 107 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 23 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 97b52d65b3ba..74b4e2a6c786 100644
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
@@ -3518,35 +3531,77 @@ static const struct kobj_type wi_ktype = {
 
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
@@ -3557,20 +3612,26 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
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

