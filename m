Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948518FC91;
	Fri,  4 Apr 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743752811; cv=none; b=bxftHyEc3qujiSLNdlBJN4UyP6prkmboTtDdt1vdEWdvbRGgEG0Rw2TLZZE9CnJ9wmuqs/m+tm4J2Gqc/slJAoPkjRq4F3OiHeYQPLJsbwsmXcEp/mphmrbP71+wAArmg1eXY+86ejg8IxeC7TaPjMCBKRQMZ31eRmSi8DlTApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743752811; c=relaxed/simple;
	bh=HrX9Yn58RNgtGFV4viTIov2i+s6Rp3kU0uuVvAluDRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bje1KGXs/gTI7HWBpDt8vNTXhG+waOyU6lX0F2B9TKFWReyMruWXybial4UCHiOFP+yS6GtFeqStu2B9ihZZnzKjyrQEjNr8sCKv1qeIWyuOHgrU8j22Vre8CAmjHgL+D5BYCXNj9mtSEj03e8Gco5Lp0+E+k4BNtdn8JnzzRuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d0-67ef8e5ceb36
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
Subject: [PATCH v6 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
Date: Fri,  4 Apr 2025 16:46:20 +0900
Message-ID: <20250404074623.1179-3-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoW5M3/t0gzeXVS3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGff2H2QqeKFWcejmG8YGxm/yXYycHBICJhJ7pt9jhLFbV50Fsjk42ASUJI7tjQEJ
	iwjISkz9e56li5GLg1ngMZPEo+cvwGqEBaIkni1WBalhEVCVOLr+GhuIzQs0ZtryOSwQIzUl
	Gi7dYwKxOQVMJX4/PAlmCwHVrH56hB2iXlDi5MwnYPXMAvISzVtnM4PskhD4zCYx/+5ZqEGS
	EgdX3GCZwMg/C0nPLCQ9CxiZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIEhv+y2j/ROxg/XQg+
	xCjAwajEw2tR+C5diDWxrLgy9xCjBAezkgjv3Zz36UK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	jb6VpwgJpCeWpGanphakFsFkmTg4pRoY2wLnmyZ+n28i/CLDI+72odeVqs9Zlizb4Wxtcmaz
	2Mu1eT9PdpsGHb1RWjh17Up7F+6NTWkS3dvWzcku2C3wWTJ9+a9nAVNum25W+8W3ZVpUVprO
	reN1nnZXdFmljddVFLaf1Uh+PGl2Fadzd0GT6U63fUlT1l11PxYxjaF+SfEG24vHCj5/U2Ip
	zkg01GIuKk4EABrSeI57AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNSzem7326wa21UhZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBn39h9kKnihVnHo5hvGBsZv
	8l2MnBwSAiYSravOMnYxcnCwCShJHNsbAxIWEZCVmPr3PEsXIxcHs8BjJolHz1+A1QgLREk8
	W6wKUsMioCpxdP01NhCbF2jMtOVzWCBGako0XLrHBGJzCphK/H54EswWAqpZ/fQIO0S9oMTJ
	mU/A6pkF5CWat85mnsDIMwtJahaS1AJGplWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBIb+s
	9s/EHYxfLrsfYhTgYFTi4bUofJcuxJpYVlyZe4hRgoNZSYT3bs77dCHelMTKqtSi/Pii0pzU
	4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGjpDJARse9C59wZ8tkmQXtMORLeLu
	9cieiW2LTWaaGFyZ4bUxm0n0o+aKY6KLn584apRuYhi6f9eCpaIVEfUxu4tntS2dHvBVSfQC
	Z2LcRv5s9b3pX0vmqE7oVva7GV95XHWis03oJeH0/iOiawokT63KXXpvEVeh0fptTwokHN7P
	Odxla2OpxFKckWioxVxUnAgAjwN6gnUCAAA=
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
 mm/mempolicy.c | 73 ++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index af3753925573..73a9405ff352 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3388,6 +3388,13 @@ struct iw_node_attr {
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
@@ -3430,27 +3437,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
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
@@ -3458,7 +3462,7 @@ static const struct kobj_type wi_ktype = {
 	.release = sysfs_wi_release,
 };
 
-static int add_weight_node(int nid, struct kobject *wi_kobj)
+static int sysfs_wi_node_add(int nid)
 {
 	struct iw_node_attr *node_attr;
 	char *name;
@@ -3480,58 +3484,45 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
+static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 {
-	struct kobject *wi_kobj;
 	int nid, err;
 
-	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
-			     GFP_KERNEL);
-	if (!node_attrs)
+	wi_group = kzalloc(struct_size(wi_group, nattrs, nr_node_ids),
+			GFP_KERNEL);
+	if (!wi_group)
 		return -ENOMEM;
 
-	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
-	if (!wi_kobj) {
-		err = -ENOMEM;
-		goto node_out;
-	}
-
-	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
+	err = kobject_init_and_add(&wi_group->wi_kobj, &wi_ktype, mempolicy_kobj,
 				   "weighted_interleave");
-	if (err) {
-		kobject_put(wi_kobj);
+	if (err)
 		goto err_out;
-	}
 
 	for_each_node_state(nid, N_POSSIBLE) {
-		err = add_weight_node(nid, wi_kobj);
+		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
-			break;
+			goto err_del;
 		}
 	}
-	if (err) {
-		kobject_del(wi_kobj);
-		kobject_put(wi_kobj);
-		goto err_out;
-	}
 
 	return 0;
 
-node_out:
-	kfree(node_attrs);
+err_del:
+	kobject_del(&wi_group->wi_kobj);
 err_out:
+	kobject_put(&wi_group->wi_kobj);
 	return err;
 }
 
-- 
2.34.1

