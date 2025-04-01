Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619AB1EDA00;
	Tue,  1 Apr 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498645; cv=none; b=qrX2WONxniH5P+GIsSMssNut84+nOhkzeZPN7X1S5mq0LkN8BBN0q1Lupg7jc+iM+mU2l1XotiUXIyYSFIQAROJ6D4nPFzMyzJmcoAfh0jo6hjUt64NhIjgLLncioODVYJ8idtwXBNpBYssJKnQKw3KYmU4CRYhwG29GaQzpKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498645; c=relaxed/simple;
	bh=u7y5RQ3yhvPve+ym+NdXHsq0oUcG0iSL6jH8XakV10w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2dJNvXXzuin77TYdz0xjby9o/BQmmd0vxwN8ziVywCaU+6phapgUczyTReclTmTlJlp/NOn+8uzFHvJah4DuAuCB0J7XMkumWPd+1t8vpiyEfyf3R02aSSeVcbiC6crOC17xxYZDcFSUnju9NCgKiYUqnCdkdwu9Dcfx62PgWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-44-67ebad8d6b2a
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
Subject: [PATCH v4 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Tue,  1 Apr 2025 18:08:59 +0900
Message-ID: <20250401090901.1050-4-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250401090901.1050-1-rakie.kim@sk.com>
References: <20250401090901.1050-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXC9ZZnkW7v2tfpBv9uK1jMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK6Np
	03mmgq3GFc9O32RtYNyu1cXIySEhYCLx5MluRhh7xtyT7F2MHBxsAkoSx/bGgIRFBEQl5h2d
	zdLFyMXBLHCNSeLA55ssIAlhgWCJJwu3gvWyCKhKfOtbxgpi8wLNefX2IhvETE2Jhkv3mEBs
	TgFTif1Pj4HVCwHVPLp9hgWiXlDi5MwnYDazgLxE89bZzCDLJASes0n09KyHOk5S4uCKGywT
	GPlnIemZhaRnASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAgF9W+yd6B+OnC8GHGAU4GJV4
	eDeUvkoXYk0sK67MPcQowcGsJMIb8fVluhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC
	6YklqdmpqQWpRTBZJg5OqQZG84cM3EJ/GnxX/q1RqbZa9vhy+RveJMZvspfEruueOXl1894q
	p8fBHz+LXU2LWSWqkaHmouCR3vvWxeob47IVtXKFxgx8HJb7jeeVXtoxd3eFaLN054u1x1Mt
	BdPjP9ZIzbvGL1j59CAjw4KUTKEoCyUX7o37Tn/NuSlqdHu/1NInO8rUru5QYinOSDTUYi4q
	TgQAbczTbXQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNNS7d37et0g/WXJC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWhy69pzV
	YvWaDIvf21awOfB57Jx1l92ju+0yu0fLkbesHov3vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH
	t9seHotffGDy+LxJLoA7issmJTUnsyy1SN8ugSujadN5poKtxhXPTt9kbWDcrtXFyMkhIWAi
	MWPuSfYuRg4ONgEliWN7Y0DCIgKiEvOOzmbpYuTiYBa4xiRx4PNNFpCEsECwxJOFWxlBbBYB
	VYlvfctYQWxeoDmv3l5kg5ipKdFw6R4TiM0pYCqx/+kxsHohoJpHt8+wQNQLSpyc+QTMZhaQ
	l2jeOpt5AiPPLCSpWUhSCxiZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgQG+bLaPxN3MH65
	7H6IUYCDUYmHd0Ppq3Qh1sSy4srcQ4wSHMxKIrwRX1+mC/GmJFZWpRblxxeV5qQWH2KU5mBR
	Euf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTCu3yq6YY6s8RX3CM7POaY5/VV256dapTfw3Lb6
	qt955rhr04Nim3KVtJ+xj4JMXxwMY5vzpK9csOhnosjfxii+xMwDimFOm0xmNHKaztwiERTf
	HOleciG9+HaC7Y6anwkfih65zQhU1gziixM2n1s2b9eeiNgHVnrnHxZduMEpyZWtwzW5WYml
	OCPRUIu5qDgRAKOluJBuAgAA
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
 mm/mempolicy.c | 113 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 23 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3092a792bd28..fa755d20780c 100644
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
 
-	sysfs_remove_file(&wi_group->wi_kobj,
-			  &wi_group->nattrs[nid]->kobj_attr.attr);
-	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
-	kfree(wi_group->nattrs[nid]);
+	wi_group->nattrs[nid] = NULL;
+	mutex_unlock(&wi_group->kobj_lock);
+
+	sysfs_remove_file(&wi_group->wi_kobj, &attr->kobj_attr.attr);
+	kfree(attr->kobj_attr.attr.name);
+	kfree(attr);
 }
 
 static void sysfs_wi_release(struct kobject *wi_kobj)
@@ -3464,35 +3477,84 @@ static const struct kobj_type wi_ktype = {
 
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
 
-	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
-		kfree(node_attr->kobj_attr.attr.name);
-		kfree(node_attr);
-		pr_err("failed to add attribute to weighted_interleave\n");
-		return -ENOMEM;
+	wi_group->nattrs[nid] = new_attr;
+	mutex_unlock(&wi_group->kobj_lock);
+
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
+		if (node_state(nid, N_MEMORY)) {
+			err = sysfs_wi_node_add(nid);
+			if (err) {
+				pr_err("failed to add sysfs [node%d]\n", nid);
+				return NOTIFY_BAD;
+			}
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
@@ -3504,13 +3566,17 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
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
@@ -3518,6 +3584,7 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 		}
 	}
 
+	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
 	return 0;
 
 err_out:
-- 
2.34.1

