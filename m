Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903922F17B;
	Wed, 12 Mar 2025 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766210; cv=none; b=aGC+kyQ+Bsvl8uZKy6M5/wED2H30JeL9FZ2XJoAcpdlG7nV+D3c+DpzcXMdRiCS6tu6YunlIJQ+oNqRwJnD9ourAWna5yqFp38TuDWjRSrJ/afxrrl4AoK8XLn2vXs6TzuT/B8h3GSGCv7KJnskEk/tzQ7d5NeR+ttiVG52oleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766210; c=relaxed/simple;
	bh=naojThLXGwuclXGEGRCyWW1T9MXWuYeHQV/kPVsrArI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms/PxvWDXJB8cnzthzxe+9kqRsQSCZq1T8TGwpiMT+w0oOAPOvmeAqps2y5IL0xqES1Nh/adhLNyqgH8+7cuphpKRSdXncpzIwWWD1vSmmnsG5V3yO1fzadImMi8OFojXCa3QeNWW5tLoKpw1gi4fXjLrrsSZPdMzWzovoo74GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-12-67d13e394814
From: Rakie Kim <rakie.kim@sk.com>
To: gourry@gourry.net
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [PATCH v2 3/4] mm/mempolicy: Enable sysfs support for memory hotplug in weighted interleave
Date: Wed, 12 Mar 2025 16:56:26 +0900
Message-ID: <20250312075628.648-3-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250312075628.648-1-rakie.kim@sk.com>
References: <20250312075628.648-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnka6l3cV0gyn7xSzmrF/DZjF96gVG
	i593j7NbHN86j93i/KxTLBaXd81hs7i35j+rxeo1GQ4cHjtn3WX36G67zO6xeM9LJo9Nnyax
	e5yY8ZvFY+dDS4/Pm+QC2KO4bFJSczLLUov07RK4Mu5NVS7YrFMxa21sA+Mf5S5GTg4JAROJ
	u5MusMHYf4+cZeli5OBgE1CSOLY3BiQsIiAqMe/obKAwFwezwGImiYWH1zOBJIQFUiTWP1kA
	1ssioCoxpQmkl5ODV8BYYtm79ywQMzUlGi7dA6vnBJr/4vM1MFsIqGb5uumMEPWCEidnPgGr
	ZxaQl2jeOpsZZJmEwBE2iZZDy6COk5Q4uOIGywRG/llIemYh6VnAyLSKUSgzryw3MTPHRC+j
	Mi+zQi85P3cTIzCIl9X+id7B+OlC8CFGAQ5GJR5egZwL6UKsiWXFlbmHGCU4mJVEeFfbAoV4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwTvxWl/Hp/uxg
	iXeBK+ztm6ctlLSo3ZrbWL3ozvwVzzTmzX142HOqV7IdY/DpXx82t8gEzpg7r6CB0Tx693Ge
	hKUBWbcMOt10JqzcXVp18VLw6qvph5IslD4F8v9aOfsok/2lto/657czitxmbDtZxbKkcu+L
	uXqVme++7LpWqTL7wu4fB0x9LJVYijMSDbWYi4oTAU0ibYpeAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXCNUNNS9fS7mK6wfMmLos569ewWUyfeoHR
	4ufd4+wWn5+9ZrY4vnUeu8XhuSdZLc7POsVicXnXHDaLe2v+s1ocuvac1WL1mgyL39tWsDnw
	eOycdZfdo7vtMrvH4j0vmTw2fZrE7nFixm8Wj50PLT2+3fbwWPziA5PH501yAZxRXDYpqTmZ
	ZalF+nYJXBn3pioXbNapmLU2toHxj3IXIyeHhICJxN8jZ1m6GDk42ASUJI7tjQEJiwiISsw7
	OhsozMXBLLCYSWLh4fVMIAlhgRSJ9U8WsIHYLAKqElOaQHo5OXgFjCWWvXvPAjFTU6Lh0j2w
	ek6g+S8+XwOzhYBqlq+bzghRLyhxcuYTsHpmAXmJ5q2zmScw8sxCkpqFJLWAkWkVo0hmXllu
	YmaOqV5xdkZlXmaFXnJ+7iZGYOAuq/0zcQfjl8vuhxgFOBiVeHgPqF5IF2JNLCuuzD3EKMHB
	rCTCu9oWKMSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cC4
	8ZLu56tO3VkVWU1slq+DHb9lcy9h/nCnNs5+zp7sZ2oHbniLTJLzfLbz2+tnC5U/cymXl504
	7GXS/jTDOkJf7v5fvzzvT/I/FWbdiHLLWcLlsFHVYOWnii/ntZsy8hK3HRZoOXGa3emwY5eB
	kaqA4jeVtAsLu92v3rxyonMyz7bJlfrnl3srsRRnJBpqMRcVJwIABYdkhlgCAAA=
X-CFilter-Loop: Reflected

Previously, sysfs entries for weighted interleave were only created during
initialization, preventing dynamically added memory nodes from being recognized.

This patch enables sysfs registration for nodes added via memory hotplug,
allowing weighted interleave settings to be updated as the system memory
configuration changes.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 mm/mempolicy.c | 78 +++++++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 94efff89e0be..71aff1276d4d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3389,6 +3389,13 @@ struct iw_node_attr {
 	int nid;
 };
 
+struct iw_node_group {
+	struct kobject *wi_kobj;
+	struct iw_node_attr **nattrs;
+};
+
+static struct iw_node_group *ngrp;
+
 static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -3431,24 +3438,22 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
-static struct iw_node_attr **node_attrs;
-
-static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
-				  struct kobject *parent)
+static void sysfs_wi_node_release(int nid)
 {
-	if (!node_attr)
+	if (!ngrp->nattrs[nid])
 		return;
-	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
-	kfree(node_attr->kobj_attr.attr.name);
-	kfree(node_attr);
+
+	sysfs_remove_file(ngrp->wi_kobj, &ngrp->nattrs[nid]->kobj_attr.attr);
+	kfree(ngrp->nattrs[nid]->kobj_attr.attr.name);
+	kfree(ngrp->nattrs[nid]);
 }
 
 static void sysfs_wi_release(struct kobject *wi_kobj)
 {
-	int i;
+	int nid;
 
-	for (i = 0; i < nr_node_ids; i++)
-		sysfs_wi_node_release(node_attrs[i], wi_kobj);
+	for (nid = 0; nid < nr_node_ids; nid++)
+		sysfs_wi_node_release(nid);
 	kobject_put(wi_kobj);
 }
 
@@ -3457,7 +3462,7 @@ static const struct kobj_type wi_ktype = {
 	.release = sysfs_wi_release,
 };
 
-static int add_weight_node(int nid, struct kobject *wi_kobj)
+static int sysfs_wi_node_add(int nid)
 {
 	struct iw_node_attr *node_attr;
 	char *name;
@@ -3479,19 +3484,17 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
 	node_attr->kobj_attr.store = node_store;
 	node_attr->nid = nid;
 
-	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
+	if (sysfs_create_file(ngrp->wi_kobj, &node_attr->kobj_attr.attr)) {
 		kfree(node_attr->kobj_attr.attr.name);
 		kfree(node_attr);
 		pr_err("failed to add attribute to weighted_interleave\n");
 		return -ENOMEM;
 	}
 
-	node_attrs[nid] = node_attr;
+	ngrp->nattrs[nid] = node_attr;
 	return 0;
 }
 
-struct kobject *wi_kobj;
-
 static int wi_node_notifier(struct notifier_block *nb,
 			       unsigned long action, void *data)
 {
@@ -3504,15 +3507,15 @@ static int wi_node_notifier(struct notifier_block *nb,
 
 	switch(action) {
 	case MEM_ONLINE:
-		err = add_weight_node(nid, wi_kobj);
+		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
-			kobject_put(wi_kobj);
+			kobject_put(ngrp->wi_kobj);
 			return NOTIFY_BAD;
 		}
 		break;
 	case MEM_OFFLINE:
-		sysfs_wi_node_release(node_attrs[nid], wi_kobj);
+		sysfs_wi_node_release(nid);
 		break;
 	}
 
@@ -3524,14 +3527,14 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 {
 	int nid, err;
 
-	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
-	if (!wi_kobj)
+	ngrp->wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
+	if (!ngrp->wi_kobj)
 		return -ENOMEM;
 
-	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
+	err = kobject_init_and_add(ngrp->wi_kobj, &wi_ktype, root_kobj,
 				   "weighted_interleave");
 	if (err) {
-		kfree(wi_kobj);
+		kfree(ngrp->wi_kobj);
 		return err;
 	}
 
@@ -3539,7 +3542,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 		if (!node_state(nid, N_MEMORY))
 			continue;
 
-		err = add_weight_node(nid, wi_kobj);
+		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
 			goto err_out;
@@ -3550,7 +3553,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 	return 0;
 
 err_out:
-	kobject_put(wi_kobj);
+	kobject_put(ngrp->wi_kobj);
 	return err;
 }
 
@@ -3565,7 +3568,9 @@ static void mempolicy_kobj_release(struct kobject *kobj)
 	mutex_unlock(&iw_table_lock);
 	synchronize_rcu();
 	kfree(old);
-	kfree(node_attrs);
+
+	kfree(ngrp->nattrs);
+	kfree(ngrp);
 	kfree(kobj);
 }
 
@@ -3578,17 +3583,23 @@ static int __init mempolicy_sysfs_init(void)
 	int err;
 	static struct kobject *mempolicy_kobj;
 
-	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
-			     GFP_KERNEL);
-	if (!node_attrs) {
+	ngrp = kzalloc(sizeof(*ngrp), GFP_KERNEL);
+	if (!ngrp) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
+	ngrp->nattrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
+			       GFP_KERNEL);
+	if (!ngrp->nattrs) {
+		err = -ENOMEM;
+		goto ngrp_out;
+	}
+
 	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
 	if (!mempolicy_kobj) {
 		err = -ENOMEM;
-		goto node_out;
+		goto nattr_out;
 	}
 
 	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
@@ -3606,12 +3617,13 @@ static int __init mempolicy_sysfs_init(void)
 
 	return 0;
 
-node_out:
-	kfree(node_attrs);
+nattr_out:
+	kfree(ngrp->nattrs);
+ngrp_out:
+	kfree(ngrp);
 err_out:
 	pr_err("mempolicy sysfs structure failed to initialize\n");
 	return err;
-
 }
 
 late_initcall(mempolicy_sysfs_init);
-- 
2.34.1

