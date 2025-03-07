Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65D19E999;
	Fri,  7 Mar 2025 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329358; cv=none; b=STGdndEVFeytSCKag+mgjDjMc8DpmWpg42DMueXpKMelqUWmz6Zr1PX5mJ3zKcpHn07IK2vgKZz9KjluTWMoIxmYXvFujmYM1Qe3CctweYPDFZsBF0E3QHYLMsw6DyQ996Rq8rdf2dDxRKuYJBy6FABdZn68w5/25Cyyib3OLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329358; c=relaxed/simple;
	bh=M4dVTb5BE2GtmoDmAT3Bm+OjrwOJaNSzE+tCB3LvtEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvaHTL7flKEeYNZwcO7pUgMjRRDdWRZUrIQBjGKxH3QgRPxrNaMH7GKRXLIM3Q6KH8T58P8/jtzzQMaDpT2hJZpLKMG/UJpYjiPpP/v47A7WRVwS5gRMjItSlk1O0h2gEP0xD84FSFCywAnKW6BpQeoy1Ggqk/DIeosQvS7Ncbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-89-67ca93c54175
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
Subject: [PATCH 2/4] mm/mempolicy: Enable sysfs support for memory hotplug in weighted interleave
Date: Fri,  7 Mar 2025 15:35:31 +0900
Message-ID: <20250307063534.540-3-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250307063534.540-1-rakie.kim@sk.com>
References: <20250307063534.540-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnke7RyafSDb5c0LKYs34Nm8X0qRcY
	LX7ePc5ucXzrPHaL87NOsVhc3jWHzeLemv+sFqvXZDhweOycdZfdo7vtMrvH4j0vmTw2fZrE
	7nFixm8Wj50PLT0+b5ILYI/isklJzcksSy3St0vgyuhuPsZa8Fix4k3bd7YGxl7pLkZODgkB
	E4lbZ76ywthrX94Esjk42ASUJI7tjQEJiwiISsw7Opuli5GLg1lgMZPEwsPrmUASwgKJEg1/
	lrGD2CwCqhJ32o+AzeEVMJa48PMAM8RMTYmGS/fA6jmB5h9f9YgRZL4QUM3fXaUQ5YISJ2c+
	YQGxmQXkJZq3zmYG2SUhcIJN4u7E50wQcyQlDq64wTKBkX8Wkp5ZSHoWMDKtYhTKzCvLTczM
	MdHLqMzLrNBLzs/dxAgM42W1f6J3MH66EHyIUYCDUYmH12PqyXQh1sSy4srcQ4wSHMxKIryC
	m4FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGKWSuH+r
	F546P1fljarLppQPzl6KHMFSy2SCH7OFVkdsPLLgoauH4Kre59LfLhdHtFhbx1R/4tPo/5e2
	8n+YrafFkdbr6WcPartf5359cdfi0DRpjxPRc9zcgwS/qs+Z2HRDzHkFn1856ysTh9szenxn
	fYi6kHudc+cWpasP1yeduvS40cdyhRJLcUaioRZzUXEiAEvJmvVfAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNS/fo5FPpBsf2qFjMWb+GzWL61AuM
	Fj/vHme3+PzsNbPF8a3z2C0Ozz3JanF+1ikWi8u75rBZ3Fvzn9Xi0LXnrBar12RY/N62gs2B
	x2PnrLvsHt1tl9k9Fu95yeSx6dMkdo8TM36zeOx8aOnx7baHx+IXH5g8Pm+SC+CM4rJJSc3J
	LEst0rdL4Mrobj7GWvBYseJN23e2BsZe6S5GTg4JAROJtS9vsnYxcnCwCShJHNsbAxIWERCV
	mHd0NksXIxcHs8BiJomFh9czgSSEBRIlGv4sYwexWQRUJe60H2EFsXkFjCUu/DzADDFTU6Lh
	0j2wek6g+cdXPWIEmS8EVPN3VylEuaDEyZlPWEBsZgF5ieats5knMPLMQpKahSS1gJFpFaNI
	Zl5ZbmJmjqlecXZGZV5mhV5yfu4mRmDoLqv9M3EH45fL7ocYBTgYlXh4PaaeTBdiTSwrrsw9
	xCjBwawkwiu4GSjEm5JYWZValB9fVJqTWnyIUZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TB
	KdXAWG8i7DNjevR7o2UPft+xnvLqhOZ+lcl/jmg7czEHyXxYcfP4v76XfquD35tpHDHyKs6P
	U3ynOKFEaV1S52VH5daT2e+eh9SG3i7m1Zgw/dq/rGsnOvsPq2t55m/kmOPBwhoVKB15s+9R
	9/Jf3Jc4xdhtzH8en5GzfmLnh0k8vaKy9l/Ky7v+K7EUZyQaajEXFScCAECoqS1ZAgAA
X-CFilter-Loop: Reflected

Previously, sysfs entries for weighted interleave were only created during
initialization, preventing dynamically added memory nodes from being recognized.

This patch enables sysfs registration for nodes added via memory hotplug,
allowing weighted interleave settings to be updated as the system memory
configuration changes.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 mm/mempolicy.c | 51 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 385607179ebd..fc10a9a4be86 100644
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
@@ -3431,8 +3438,6 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
-static struct iw_node_attr **node_attrs;
-
 static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
 				  struct kobject *parent)
 {
@@ -3448,7 +3453,7 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
 	int i;
 
 	for (i = 0; i < nr_node_ids; i++)
-		sysfs_wi_node_release(node_attrs[i], wi_kobj);
+		sysfs_wi_node_release(ngrp->nattrs[i], wi_kobj);
 	kobject_put(wi_kobj);
 }
 
@@ -3486,12 +3491,10 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
@@ -3504,10 +3507,10 @@ static int wi_node_notifier(struct notifier_block *nb,
 
 	switch(action) {
 	case MEM_ONLINE:
-		err = add_weight_node(nid, wi_kobj);
+		err = add_weight_node(nid, ngrp->wi_kobj);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
-			kobject_put(wi_kobj);
+			kobject_put(ngrp->wi_kobj);
 			return NOTIFY_BAD;
 		}
 		break;
@@ -3521,14 +3524,14 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
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
 
@@ -3536,7 +3539,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 		if (!node_state(nid, N_MEMORY))
 			continue;
 
-		err = add_weight_node(nid, wi_kobj);
+		err = add_weight_node(nid, ngrp->wi_kobj);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
 			goto err_out;
@@ -3547,7 +3550,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 	return 0;
 
 err_out:
-	kobject_put(wi_kobj);
+	kobject_put(ngrp->wi_kobj);
 	return err;
 }
 
@@ -3562,7 +3565,9 @@ static void mempolicy_kobj_release(struct kobject *kobj)
 	mutex_unlock(&iw_table_lock);
 	synchronize_rcu();
 	kfree(old);
-	kfree(node_attrs);
+
+	kfree(ngrp->nattrs);
+	kfree(ngrp);
 	kfree(kobj);
 }
 
@@ -3581,13 +3586,19 @@ static int __init mempolicy_sysfs_init(void)
 		goto err_out;
 	}
 
-	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
-			     GFP_KERNEL);
-	if (!node_attrs) {
+	ngrp = kzalloc(sizeof(*ngrp), GFP_KERNEL);
+	if (!ngrp) {
 		err = -ENOMEM;
 		goto mempol_out;
 	}
 
+	ngrp->nattrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
+			     GFP_KERNEL);
+	if (!ngrp->nattrs) {
+		err = -ENOMEM;
+		goto ngrp_out;
+	}
+
 	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
 				   "mempolicy");
 	if (err)
@@ -3602,7 +3613,9 @@ static int __init mempolicy_sysfs_init(void)
 
 	return err;
 node_out:
-	kfree(node_attrs);
+	kfree(ngrp->nattrs);
+ngrp_out:
+	kfree(ngrp);
 mempol_out:
 	kfree(mempolicy_kobj);
 err_out:
-- 
2.34.1

