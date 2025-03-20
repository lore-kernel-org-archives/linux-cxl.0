Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEFB1D5142;
	Thu, 20 Mar 2025 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742444312; cv=none; b=Cqujl/1hPlQycLWZ3pwjhe0hvoE3LaZX8RRdQeqtcz0nVa5VRG4p8U66Y6OKeqzRTNnaZumQYKCtry2d6VtqfK/rL/v/E0eAD60lTo89y2C5B0YPJQnzmHYOGoJlhdMWS10T1PIvr5ekUnSu5xFq03MzKNgqICOGnbiVmQfTWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742444312; c=relaxed/simple;
	bh=EgH2C2M8SiOQiV1U+C0+wkoRva2Z7YbBNKya0LAI9Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTA/K0h5hj+xL1C5X10AVkcdKhlW/m9AZZYS4NWQxx/jmlUZmePqhqQrG8SBapQ116Xpl80vC6+oLFJoaqknzXfyfsuQbKXSMS//mYXhls8YAaXyFFh6bub8OZwnHcCgYDgErV/hRFokA4MKgeOODeMT1kwa9gbS8XfWXVVjSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-41-67db970a4ef9
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
Subject: [PATCH v3 2/3] mm/mempolicy: Support dynamic sysfs updates for weighted interleave
Date: Thu, 20 Mar 2025 13:17:47 +0900
Message-ID: <20250320041749.881-3-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250320041749.881-1-rakie.kim@sk.com>
References: <20250320041749.881-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXC9ZZnoS7X9NvpBudncFnMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK2P+
	1XnsBf8UKrZMPc3SwPhIqouRk0NCwETi8JRb7DD2yeM9jF2MHBxsAkoSx/bGgIRFBEQl5h2d
	zdLFyMXBLHCNSeLA55ssIAlhgWiJPW/2g9ksAqoSk3/eZQaxeQWMJda/OsYMMVNTouHSPSYQ
	mxNo/pSr89lA5gsB1bw9xwtRLihxcuYTsDHMAvISzVtnM4PskhB4zSbRfXouG8QcSYmDK26w
	TGDkn4WkZxaSngWMTKsYhTLzynITM3NM9DIq8zIr9JLzczcxAsN9We2f6B2Mny4EH2IU4GBU
	4uF9ceVWuhBrYllxZe4hRgkOZiURXpGO2+lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacI
	CaQnlqRmp6YWpBbBZJk4OKUaGN2eiqgLWJ0/t2T5iUZ7//uWmYUm4TMUeWLja6oDFQp5Yyx3
	Pr44XYDxcNBf3XvPAss//Ppo+m31pmf57t7l3PKdtwPCb0QuVl+6Z1tRQ11qMNeJ/Ze4f19K
	66o4+m6Ts82CzzxPJ7lc/fLU7C1DS7L3K+OJd724zDoOmc+4xK/NbSKec3JWlxJLcUaioRZz
	UXEiAJziUDpzAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNNS5dr+u10g91nGS3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWhy69pzV
	YvWaDIvf21awOfB57Jx1l92ju+0yu0fLkbesHov3vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH
	t9seHotffGDy+LxJLoA7issmJTUnsyy1SN8ugStj/tV57AX/FCq2TD3N0sD4SKqLkZNDQsBE
	4uTxHsYuRg4ONgEliWN7Y0DCIgKiEvOOzmbpYuTiYBa4xiRx4PNNFpCEsEC0xJ43+8FsFgFV
	ick/7zKD2LwCxhLrXx1jhpipKdFw6R4TiM0JNH/K1flsIPOFgGrenuOFKBeUODnzCdgYZgF5
	ieats5knMPLMQpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmCIL6v9M3EH45fL
	7ocYBTgYlXh4X1y5lS7EmlhWXJl7iFGCg1lJhFek43a6EG9KYmVValF+fFFpTmrxIUZpDhYl
	cV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+M10V1rc5dJW8UqlemXuE/jT3BacOIsS+DWxLBt
	kTba9zY2m3h4rU/hL5l3jfdc9FQN5V/3mnbclr/CLXCulHXVzeJbkyduTHYvWJSy9kPPl5tR
	Qc/XpFxYv2nmN+GSQ88VZlevl3+9dXdbl77UXLkpZuWx+mWLQh7vPnfIird8W8m38pcxBvJK
	LMUZiYZazEXFiQCZ0tl5bQIAAA==
X-CFilter-Loop: Reflected

Previously, the weighted interleave sysfs structure was statically
managed, preventing dynamic updates when nodes were added or removed.

This patch restructures the weighted interleave sysfs to support
dynamic insertion and deletion. The sysfs that was part of
the 'weighted_interleave_group' is now globally accessible,
allowing external access to that sysfs.

With this change, sysfs management for weighted interleave is
more flexible, supporting hotplug events and runtime updates
more effectively.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 mm/mempolicy.c | 70 ++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5950d5d5b85e..6c8843114afd 100644
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
+static struct sysfs_wi_group *sgrp;
+
 static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -3430,27 +3437,23 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
-static struct iw_node_attr **node_attrs;
-
-static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
-				  struct kobject *parent)
+static void sysfs_wi_node_release(int nid)
 {
-	if (!node_attr)
+	if (!sgrp->nattrs[nid])
 		return;
-	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
-	kfree(node_attr->kobj_attr.attr.name);
-	kfree(node_attr);
+
+	sysfs_remove_file(&sgrp->wi_kobj, &sgrp->nattrs[nid]->kobj_attr.attr);
+	kfree(sgrp->nattrs[nid]->kobj_attr.attr.name);
+	kfree(sgrp->nattrs[nid]);
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
+		sysfs_wi_node_release(nid);
+	kfree(sgrp);
 }
 
 static const struct kobj_type wi_ktype = {
@@ -3458,7 +3461,7 @@ static const struct kobj_type wi_ktype = {
 	.release = sysfs_wi_release,
 };
 
-static int add_weight_node(int nid, struct kobject *wi_kobj)
+static int sysfs_wi_node_add(int nid)
 {
 	struct iw_node_attr *node_attr;
 	char *name;
@@ -3480,57 +3483,44 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
 	node_attr->kobj_attr.store = node_store;
 	node_attr->nid = nid;
 
-	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
+	if (sysfs_create_file(&sgrp->wi_kobj, &node_attr->kobj_attr.attr)) {
 		kfree(node_attr->kobj_attr.attr.name);
 		kfree(node_attr);
 		pr_err("failed to add attribute to weighted_interleave\n");
 		return -ENOMEM;
 	}
 
-	node_attrs[nid] = node_attr;
+	sgrp->nattrs[nid] = node_attr;
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
+	sgrp = kzalloc(sizeof(struct sysfs_wi_group) + 			\
+		       nr_node_ids * sizeof(struct iw_node_attr *),	\
+		       GFP_KERNEL);
+	if (!sgrp)
 		return -ENOMEM;
 
-	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
-	if (!wi_kobj) {
-		err = -ENOMEM;
-		goto node_out;
-	}
-
-	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
+	err = kobject_init_and_add(&sgrp->wi_kobj, &wi_ktype, mempolicy_kobj,
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
+			goto err_out;
 		}
 	}
-	if (err) {
-		kobject_put(wi_kobj);
-		goto err_out;
-	}
 
 	return 0;
 
-node_out:
-	kfree(node_attrs);
 err_out:
+	kobject_put(&sgrp->wi_kobj);
 	return err;
 }
 
-- 
2.34.1

