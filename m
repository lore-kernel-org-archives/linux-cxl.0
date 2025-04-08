Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF862638AD;
	Tue,  8 Apr 2025 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097644; cv=none; b=q8LIOyBpSqRa1LyjbudE7u/fTe55/BYVwfsOSeMAKT0eBgOWX+IowXhisAwaWlmbwHiJr7hFMS8sCQ3JQE7fxpPMHgwZF5u90dBu17zh+ktje1wFlVNlLHraWwfzOnyhrV4+fntuBJMzfwxmV+PcPE2NaPflYGuGRnarJtK9iiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097644; c=relaxed/simple;
	bh=2svEH9RbknnIkNHRXnn8//SeickU4yiDMkCLnyVqPq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzmLAuLrBhsfqlw9FXlo0S3rcGGS78BkzTQmFmpd3EapBBKqdiSCrmK/NxUKxjOFb4bm5G7buFR4hE97nM8C9FmsvSD2x4ZLjGjH+0eHgfB9GpRESAusCkoPoG1CyriK9+SFkmswLtThAiSyVGeXNYANrhqn6I08SuMzG1hPBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-02-67f4d1633aca
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
Subject: [PATCH v7 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
Date: Tue,  8 Apr 2025 16:32:41 +0900
Message-ID: <20250408073243.488-3-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnkW7yxS/pBg+aJS3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGfcWTmcruKZW8f/bBKYGxjaFLkZODgkBE4llTxcwwthrDm5k7WLk4GATUJI4tjcG
	JCwiICsx9e95li5GLg5mgcdMEo+evwCrFxaIkvjw4hUriM0ioCox48s9dhCbV8BY4uaaE0wQ
	MzUlGi7dA7M5geb/P72bBWS+EFBN7/REiHJBiZMzn7CA2MwC8hLNW2czg+ySEPjOJtF/4Cgr
	xBxJiYMrbrBMYOSfhaRnFpKeBYxMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECw39Z7Z/oHYyf
	LgQfYhTgYFTi4fU4+jldiDWxrLgy9xCjBAezkgjv24lf0oV4UxIrq1KL8uOLSnNSiw8xSnOw
	KInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwStZyJp/wERVjY/7+8OU9UTbbz/O/HFLqWaUQ
	efn6nkmmi47mxqlLlf1aGB2w+ci7K/0XkifvWH/hVK/UD7ljhf5KzSqrF7c8YpI5FFv2+aDJ
	h8v1+cfNb/wPVGgvkZzG93blsj8LE4Ku7Pm8lX2Ks+5V7/ysur2FJtE7fd+lHX98iE9D/G26
	gRJLcUaioRZzUXEiAGUxcXZ7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNSzf54pd0g5M9vBZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBn3Fk5nK7imVvH/2wSmBsY2
	hS5GTg4JAROJNQc3snYxcnCwCShJHNsbAxIWEZCVmPr3PEsXIxcHs8BjJolHz18wgiSEBaIk
	Prx4xQpiswioSsz4co8dxOYVMJa4ueYEE8RMTYmGS/fAbE6g+f9P72YBmS8EVNM7PRGiXFDi
	5MwnLCA2s4C8RPPW2cwTGHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzDk
	l9X+mbiD8ctl90OMAhyMSjy8Hkc/pwuxJpYVV+YeYpTgYFYS4X078Uu6EG9KYmVValF+fFFp
	TmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+Ncx7mfisR2GoZdDDi58Gj3iaZL
	TO8ZvLZu1tw3YRHzufwbiSecd9ps/3lm2bTYmBPi/Yt1nmh5WAWu/X8nT/VBgSjnnt7OFvUN
	M5m2qhzXvPBsp/ovp7Vil8z2XRcq+7jnZcjF6Zq3OsSl7Kf3N600iFmwKfXK6uLTt69O1zt5
	xdXjSujxr7/YlFiKMxINtZiLihMBNsmrXHUCAAA=
X-CFilter-Loop: Reflected

Previously, the weighted interleave sysfs structure was statically
managed during initialization. This prevented new nodes from being
recognized when memory hotplug events occurred, limiting the ability
to update or extend sysfs entries dynamically at runtime.

To address this, this patch refactors the sysfs infrastructure and
encapsulates it within a new structure, `sysfs_wi_group`, which holds
both the kobject and an array of node attribute pointers.

By allocating this group structure globally, the per-node sysfs
attributes can be managed beyond initialization time, enabling
external modules to insert or remove node entries in response to
events such as memory hotplug or node online/offline transitions.

Instead of allocating all per-node sysfs attributes at once, the
initialization path now uses the existing sysfs_wi_node_add() and
sysfs_wi_node_delete() helpers. This refactoring makes it possible
to modularly manage per-node sysfs entries and ensures the
infrastructure is ready for runtime extension.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 61 ++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0da102aa1cfc..988575f29c53 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3419,6 +3419,13 @@ struct iw_node_attr {
 	int nid;
 };
 
+struct sysfs_wi_group {
+	struct kobject wi_kobj;
+	struct iw_node_attr *nattrs[];
+};
+
+static struct sysfs_wi_group *wi_group;
+
 static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -3461,27 +3468,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
-static struct iw_node_attr **node_attrs;
-
-static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
-				  struct kobject *parent)
+static void sysfs_wi_node_delete(int nid)
 {
-	if (!node_attr)
+	if (!wi_group->nattrs[nid])
 		return;
-	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
-	kfree(node_attr->kobj_attr.attr.name);
-	kfree(node_attr);
+
+	sysfs_remove_file(&wi_group->wi_kobj,
+			  &wi_group->nattrs[nid]->kobj_attr.attr);
+	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
+	kfree(wi_group->nattrs[nid]);
 }
 
 static void sysfs_wi_release(struct kobject *wi_kobj)
 {
-	int i;
-
-	for (i = 0; i < nr_node_ids; i++)
-		sysfs_wi_node_release(node_attrs[i], wi_kobj);
+	int nid;
 
-	kfree(node_attrs);
-	kfree(wi_kobj);
+	for (nid = 0; nid < nr_node_ids; nid++)
+		sysfs_wi_node_delete(nid);
+	kfree(wi_group);
 }
 
 static const struct kobj_type wi_ktype = {
@@ -3489,7 +3493,7 @@ static const struct kobj_type wi_ktype = {
 	.release = sysfs_wi_release,
 };
 
-static int add_weight_node(int nid, struct kobject *wi_kobj)
+static int sysfs_wi_node_add(int nid)
 {
 	struct iw_node_attr *node_attr;
 	char *name;
@@ -3511,40 +3515,33 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
 	node_attr->kobj_attr.store = node_store;
 	node_attr->nid = nid;
 
-	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
+	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
 		kfree(node_attr->kobj_attr.attr.name);
 		kfree(node_attr);
 		pr_err("failed to add attribute to weighted_interleave\n");
 		return -ENOMEM;
 	}
 
-	node_attrs[nid] = node_attr;
+	wi_group->nattrs[nid] = node_attr;
 	return 0;
 }
 
-static int add_weighted_interleave_group(struct kobject *root_kobj)
+static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 {
-	struct kobject *wi_kobj;
 	int nid, err;
 
-	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
-			     GFP_KERNEL);
-	if (!node_attrs)
+	wi_group = kzalloc(struct_size(wi_group, nattrs, nr_node_ids),
+			   GFP_KERNEL);
+	if (!wi_group)
 		return -ENOMEM;
 
-	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
-	if (!wi_kobj) {
-		kfree(node_attrs);
-		return -ENOMEM;
-	}
-
-	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
+	err = kobject_init_and_add(&wi_group->wi_kobj, &wi_ktype, mempolicy_kobj,
 				   "weighted_interleave");
 	if (err)
 		goto err_put_kobj;
 
 	for_each_node_state(nid, N_POSSIBLE) {
-		err = add_weight_node(nid, wi_kobj);
+		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
 			goto err_del_kobj;
@@ -3554,9 +3551,9 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 	return 0;
 
 err_del_kobj:
-	kobject_del(wi_kobj);
+	kobject_del(&wi_group->wi_kobj);
 err_put_kobj:
-	kobject_put(wi_kobj);
+	kobject_put(&wi_group->wi_kobj);
 	return err;
 }
 
-- 
2.34.1

