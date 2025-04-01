Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619FD1EDA01;
	Tue,  1 Apr 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498645; cv=none; b=TccKvN7fD/Jlg2+VBy8yK7coRGcNu0DvkDAtIDCNz6W5Zgmmv5CA8CPo1NUUiEGBr8AYtC1assibiBOK/oXJTmjd0hHc6x51dEQOghnizQiyz3wq5KXf4ngXM6DlrBEcfexeZHVyz/E/aqD9CIOEuyNw+1ZOvg3QoXFTFBIwo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498645; c=relaxed/simple;
	bh=uimdlVjavfDZcsgVyO339gHPURzcTPcAOVuyKRuDtpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8fUevsiS7FDjtOVPLgBfrwAljQH9n2C30w2h1Futam/64kRG3p8n0ccld93NrCTI9aCl9er36XBdO+TaUGVHn6kb/NvTCf+7Q08PxycwOB46Sw8l5q0MJaTv52vUHM01M96WNZGqJZdODefNZNSqs3qqWgC+6lOiM+BOOOAcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-3a-67ebad8bf2ef
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
Subject: [PATCH v4 2/3] mm/mempolicy: Support dynamic sysfs updates for weighted interleave
Date: Tue,  1 Apr 2025 18:08:58 +0900
Message-ID: <20250401090901.1050-3-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXC9ZZnkW732tfpBqfei1jMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK2PV
	wj9MBWeUKjZsucfewDhHpouRk0NCwETi9Nc7TDD21tYpzF2MHBxsAkoSx/bGgIRFBEQl5h2d
	zdLFyMXBLHCNSeLA55ssIAlhgWiJqUv7wXpZBFQlJp+YzA5i8wLNOfT6HQvETE2Jhkv3wGo4
	BUwl9j89xghiCwHVPLp9hgWiXlDi5MwnYDazgLxE89bZzCDLJARes0m8mbeLGWKQpMTBFTdY
	JjDyz0LSMwtJzwJGplWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgQG/rPZP9A7GTxeCDzEKcDAq
	8fBuKH2VLsSaWFZcmXuIUYKDWUmEN+Lry3Qh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOE
	BNITS1KzU1MLUotgskwcnFINjGaBPTpT16z8870+z6xg72yB++eeVXy90CLsYzVHqWfG0YYa
	rrQ7KXUtXW87dZOungy0Z/4Y+7Pq23o9CRH/u5VXNpXP7grXkF0jlRu7YE6U/imRmWf+PeiY
	8dEwuj70l8VW4w98sfo1n5nSdFm/e/5Tu7XB4tt6XdXXjhrr0/wnZB+8aJ6+UomlOCPRUIu5
	qDgRAM+IIfR0AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNNS7d77et0g2X9XBZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLQ5de85q
	sXpNhsXvbSvYHPg8ds66y+7R3XaZ3aPlyFtWj8V7XjJ5bPo0id3jxIzfLB47H1p6vN93lc3j
	220Pj8UvPjB5fN4kF8AdxWWTkpqTWZZapG+XwJWxauEfpoIzShUbttxjb2CcI9PFyMkhIWAi
	sbV1CnMXIwcHm4CSxLG9MSBhEQFRiXlHZ7N0MXJxMAtcY5I48PkmC0hCWCBaYurSfiYQm0VA
	VWLyicnsIDYv0JxDr9+xQMzUlGi4dA+shlPAVGL/02OMILYQUM2j22dYIOoFJU7OfAJmMwvI
	SzRvnc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQKDfFntn4k7GL9c
	dj/EKMDBqMTDu6H0VboQa2JZcWXuIUYJDmYlEd6Iry/ThXhTEiurUovy44tKc1KLDzFKc7Ao
	ifN6hacmCAmkJ5akZqemFqQWwWSZODilGhgPPXnhvGnRsVNW+p9/BUqLnbaIved19N+U0qKV
	Hzr4ZKpLROYK6O07YK4aYfA0NCct7MkfO4Fdd3+5zjqSebLG9Vx2zruUJV+++Nq0dus6bL+4
	6b4oV8tsl20q9zyOrOB/5Rsv4WckOUvFRWrTf3cvB8lJmtLMprMSav23G/44EcdQ0X+7eK8S
	S3FGoqEWc1FxIgBDQjL9bgIAAA==
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
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 71 ++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5950d5d5b85e..3092a792bd28 100644
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
+static void sysfs_wi_node_release(int nid)
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
+		sysfs_wi_node_release(nid);
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
@@ -3480,57 +3484,44 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
+	wi_group = kzalloc(sizeof(struct sysfs_wi_group) + 		\
+		       nr_node_ids * sizeof(struct iw_node_attr *),	\
+		       GFP_KERNEL);
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
+	kobject_put(&wi_group->wi_kobj);
 	return err;
 }
 
-- 
2.34.1

