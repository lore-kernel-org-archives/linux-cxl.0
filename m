Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B061991DD;
	Fri,  4 Apr 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743752813; cv=none; b=pHjjOhdN/xhT2IX6EF6Gt88K+i/HTcfQyhLkffMIZviPAJ3FWUUsR84Z0mRUSS2J5Pn+VV5bjMFlITW9lUyC5oOBSd8l0XSsmkvzoJ4VDysjgsEB8LSOBn15P11gm4CvL383SH1Y7N4jKUG24LoOrg8R5tHlmXeBKlSEaxAvd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743752813; c=relaxed/simple;
	bh=CSZVRIjnXcSmPYcN+7RUGoYO5fSewwMnIim4k59qa3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1mLjTet7DQ9vWftocAFmsGLPY491Bh19TbUPqToXZm33KbhBYYO0QrzrPS8u3sg88lNZEEMMSyX5xQ0/Gbom/PwEgMriE05UIbA5wL3Ut7V6IvsPgIDki9PT14R4xnL0ckn3Yoh+jOgRiMH5BdpwLVZSkHix1rAm9lRXUozXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-dc-67ef8e5e12db
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
Subject: [PATCH v6 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Fri,  4 Apr 2025 16:46:21 +0900
Message-ID: <20250404074623.1179-4-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250404074623.1179-1-rakie.kim@sk.com>
References: <20250404074623.1179-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoW5c3/t0g99TjSzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGSuW/GUruGpU8fzcKvYGxm+aXYycHBICJhKda5exwdhrGyYD2RwcbAJKEsf2xoCE
	RQRkJab+Pc/SxcjFwSzwmEni0fMXjCAJYYFgiZkHX7OD2CwCqhJPJp5jArF5gebcfnKIHWKm
	pkTDpXtgcU4BU4nfD0+C2UJANaufHmGHqBeUODnzCQuIzSwgL9G8dTYzyDIJge9sEn92rmKC
	GCQpcXDFDZYJjPyzkPTMQtKzgJFpFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZgBCyr/RO9g/HT
	heBDjAIcjEo8vBaF79KFWBPLiitzDzFKcDArifDezXmfLsSbklhZlVqUH19UmpNafIhRmoNF
	SZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFxzco/614ETW7TknFvXTW5eJ5WuFSt8/+/wpsX
	LTXbpPevgGsX2xbXtC2cxlGLNfy+3VW6cbhx7XrGZbeq58zMmPMkR9bFszi5YLOTCJfK08sx
	PrcXtTw6Nm0mzxG5FD/WKcvfpB4027zguMNiiawgyXtx72ZlTmneMc1k1n2JOekHeDZ1Z/cs
	V2Ipzkg01GIuKk4EACbiurV8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNSzeu7326wZYnWhZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBkrlvxlK7hqVPH83Cr2BsZv
	ml2MnBwSAiYSaxsms3UxcnCwCShJHNsbAxIWEZCVmPr3PEsXIxcHs8BjJolHz18wgiSEBYIl
	Zh58zQ5iswioSjyZeI4JxOYFmnP7ySF2iJmaEg2X7oHFOQVMJX4/PAlmCwHVrH56hB2iXlDi
	5MwnLCA2s4C8RPPW2cwTGHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzDo
	l9X+mbiD8ctl90OMAhyMSjy8FoXv0oVYE8uKK3MPMUpwMCuJ8N7NeZ8uxJuSWFmVWpQfX1Sa
	k1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwLj9sOLJqaY5x54umx/58Ivbm6U/
	p3mInFM4myGiMavO483KR8Evl0dNuVuUbFK7aaWpwLJ/izwnvrAzuzn/1rGsGZIb3jhELVvv
	lHCcWTsy5sHabYJfFNesm7rVesWGtUzLJQMaJVVcP/fHV+3S/i5hwtVnrhhe4qZafrx7ZW21
	191/ndaBfyYqsRRnJBpqMRcVJwIA9wOrCnYCAAA=
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
 mm/mempolicy.c | 109 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 23 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 73a9405ff352..f25c2c7f8fcf 100644
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
@@ -3464,35 +3477,80 @@ static const struct kobj_type wi_ktype = {
 
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
+		sysfs_wi_node_delete(nid);
+		break;
+	}
+
+notifier_end:
+	return NOTIFY_OK;
 }
 
 static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
@@ -3503,13 +3561,17 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
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
@@ -3517,6 +3579,7 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 		}
 	}
 
+	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
 	return 0;
 
 err_del:
-- 
2.34.1

