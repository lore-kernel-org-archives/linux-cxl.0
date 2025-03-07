Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B01A2380;
	Fri,  7 Mar 2025 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329359; cv=none; b=Kn0Dg5vCJH7y0helwVlR8F7JSx+/SRUBr8AEOPPriEv4vARo26uqn3jY2wTmN4qs61tlpgUbr4mT7U888jSHr0LZoY5KZvDlhtp2XebdH+FoPR8gNdMoILglmnQow6SPL0q2f4Q8axdB3Kc6Hjj4DD+Isap5ttyCM8vguCoP8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329359; c=relaxed/simple;
	bh=dCTLGNjLir+phljY7JXiiWa2WpW1Cn3pVNDFEFfQEVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YekqqgWfOqRlKyvkQOwgw0TL5+mrwKByUEgLyEAktIkJFHaoEWgcOhtBJrQ6GZUJyCinfKo+bhm7knwAphg7yyB7/f1g7jprZLNdk0zVETW/LudpJzFM9DbAMBKWwT5fmrtLbJKp6F9SoSqspls4ED0CsG7J0WdZbfvBYakzycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-95-67ca93c79c08
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
Subject: [PATCH 3/4] mm/mempolicy: Fix duplicate node addition in sysfs for weighted interleave
Date: Fri,  7 Mar 2025 15:35:32 +0900
Message-ID: <20250307063534.540-4-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnke7xyafSDZ7+NLCYs34Nm8X0qRcY
	LX7ePc5ucXzrPHaL87NOsVhc3jWHzeLemv+sFqvXZDhweOycdZfdo7vtMrvH4j0vmTw2fZrE
	7nFixm8Wj50PLT0+b5ILYI/isklJzcksSy3St0vgylg/9QRTwQ2ZigVvjzI1MN4W72Lk5JAQ
	MJGYdXwhK4zd/O0mYxcjBwebgJLEsb0xIGERAVGJeUdns3QxcnEwCyxmklh4eD0TSEJYIF7i
	+ve1zCA2i4CqxP2rDewgNq+AscSEBZNYIGZqSjRcugdWzwk0//iqR2DzhYBq/u4qhSgXlDg5
	8wlYObOAvETz1tnMILskBE6wSbS//cMMMUdS4uCKGywTGPlnIemZhaRnASPTKkahzLyy3MTM
	HBO9jMq8zAq95PzcTYzAMF5W+yd6B+OnC8GHGAU4GJV4eD2mnkwXYk0sK67MPcQowcGsJMIr
	uBkoxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgXG5Yr3O
	vOWy6ZuWlM+LtFVn6dJZLVh6fOmRXXG75ST8k/gEmOZUF52+YV35LTOk9bfs5hNlbNrFhgFr
	51dqeq+YEVTyL5rv+lv5yVmtpo+bNzs/yj8j6ROvGeXqWVOzQOmt5nP+/7pF02NF5i9yWpdu
	eLPRcN48Jot3ESlp53vv+u14NUd6rRJLcUaioRZzUXEiAEYemsBfAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNS/f45FPpBqfWaFjMWb+GzWL61AuM
	Fj/vHme3+PzsNbPF8a3z2C0Ozz3JanF+1ikWi8u75rBZ3Fvzn9Xi0LXnrBar12RY/N62gs2B
	x2PnrLvsHt1tl9k9Fu95yeSx6dMkdo8TM36zeOx8aOnx7baHx+IXH5g8Pm+SC+CM4rJJSc3J
	LEst0rdL4MpYP/UEU8ENmYoFb48yNTDeFu9i5OSQEDCRaP52k7GLkYODTUBJ4tjeGJCwiICo
	xLyjs1m6GLk4mAUWM0ksPLyeCSQhLBAvcf37WmYQm0VAVeL+1QZ2EJtXwFhiwoJJLBAzNSUa
	Lt0Dq+cEmn981SOw+UJANX93lUKUC0qcnPkErJxZQF6ieets5gmMPLOQpGYhSS1gZFrFKJKZ
	V5abmJljqlecnVGZl1mhl5yfu4kRGLrLav9M3MH45bL7IUYBDkYlHl6PqSfThVgTy4orcw8x
	SnAwK4nwCm4GCvGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBK
	NTDatp25+lR98sMWZ+XFsSp8r38xvV7x1vX+lNjs+cXnzTxqy45fKp+mvfCeR26u44dFl7LC
	PrnP/3Eou8c17M9iNfYjB9vbltdpp0XE5+5z6VW/qZfaIX1410OWmfmS3c2neRl2+ou+ErAQ
	WXb7eGaBo4dV0ts58h57PdKmtUsIHGM7pr9la6kSS3FGoqEWc1FxIgAn+We5WQIAAA==
X-CFilter-Loop: Reflected

Sysfs attributes for interleave control were registered both at initialization
and when new nodes were detected via hotplug, leading to potential duplicates.

This patch ensures that each node is registered only once, preventing conflicts
and redundant sysfs entries.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 mm/mempolicy.c | 65 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fc10a9a4be86..2d19434c61ed 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3391,6 +3391,7 @@ struct iw_node_attr {
 
 struct iw_node_group {
 	struct kobject *wi_kobj;
+	struct mutex kobj_lock;
 	struct iw_node_attr **nattrs;
 };
 
@@ -3441,11 +3442,15 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
 				  struct kobject *parent)
 {
-	if (!node_attr)
+	mutex_lock(&ngrp->kobj_lock);
+	if (!node_attr) {
+		mutex_unlock(&ngrp->kobj_lock);
 		return;
+	}
 	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
 	kfree(node_attr->kobj_attr.attr.name);
 	kfree(node_attr);
+	mutex_unlock(&ngrp->kobj_lock);
 }
 
 static void sysfs_wi_release(struct kobject *wi_kobj)
@@ -3464,35 +3469,54 @@ static const struct kobj_type wi_ktype = {
 
 static int add_weight_node(int nid, struct kobject *wi_kobj)
 {
-	struct iw_node_attr *node_attr;
+	int ret = 0;
 	char *name;
 
-	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
-	if (!node_attr)
-		return -ENOMEM;
+	if (nid < 0 || nid >= nr_node_ids) {
+		pr_err("Invalid node id: %d\n", nid);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&ngrp->kobj_lock);
+	if (!ngrp->nattrs[nid]) {
+		ngrp->nattrs[nid] = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);
+	} else {
+		mutex_unlock(&ngrp->kobj_lock);
+		pr_info("Node [%d] is already existed\n", nid);
+		goto out;
+	}
+	mutex_unlock(&ngrp->kobj_lock);
+
+	if (!ngrp->nattrs[nid]) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	name = kasprintf(GFP_KERNEL, "node%d", nid);
 	if (!name) {
-		kfree(node_attr);
-		return -ENOMEM;
+		kfree(ngrp->nattrs[nid]);
+		ret = -ENOMEM;
+		goto out;
 	}
 
-	sysfs_attr_init(&node_attr->kobj_attr.attr);
-	node_attr->kobj_attr.attr.name = name;
-	node_attr->kobj_attr.attr.mode = 0644;
-	node_attr->kobj_attr.show = node_show;
-	node_attr->kobj_attr.store = node_store;
-	node_attr->nid = nid;
+	sysfs_attr_init(&ngrp->nattrs[nid]->kobj_attr.attr);
+	ngrp->nattrs[nid]->kobj_attr.attr.name = name;
+	ngrp->nattrs[nid]->kobj_attr.attr.mode = 0644;
+	ngrp->nattrs[nid]->kobj_attr.show = node_show;
+	ngrp->nattrs[nid]->kobj_attr.store = node_store;
+	ngrp->nattrs[nid]->nid = nid;
 
-	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
-		kfree(node_attr->kobj_attr.attr.name);
-		kfree(node_attr);
-		pr_err("failed to add attribute to weighted_interleave\n");
-		return -ENOMEM;
+	ret = sysfs_create_file(wi_kobj, &ngrp->nattrs[nid]->kobj_attr.attr);
+	if (ret) {
+		kfree(ngrp->nattrs[nid]->kobj_attr.attr.name);
+		kfree(ngrp->nattrs[nid]);
+		pr_err("failed to add attribute to weighted_interleave: %d\n", ret);
+		goto out;
 	}
 
-	ngrp->nattrs[nid] = node_attr;
-	return 0;
+out:
+	return ret;
 }
 
 static int wi_node_notifier(struct notifier_block *nb,
@@ -3591,6 +3615,7 @@ static int __init mempolicy_sysfs_init(void)
 		err = -ENOMEM;
 		goto mempol_out;
 	}
+	mutex_init(&ngrp->kobj_lock);
 
 	ngrp->nattrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
 			     GFP_KERNEL);
-- 
2.34.1

