Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C61AAC9;
	Wed,  2 Apr 2025 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558612; cv=none; b=OYwB93GlJCODWfzTYOKN/+024ZS4goQhfsYYc0SVr5bVF+bnWPnYuRn9P3FT+P8l90TyIVsckyN7lnToktQiZOPEPuAMbgaLqA+yBl8LR4Nl+OXdpxpzmiXAEcwtOBvHMkY3bqJjB0R0DVdgG0lqrjktODLAuIh1+97/o3pOweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558612; c=relaxed/simple;
	bh=uimdlVjavfDZcsgVyO339gHPURzcTPcAOVuyKRuDtpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzPnXBOuqw0js183oXWpycV06UvXIWsrhVva+Jx8V3agz3uqSs1oDJ7j1WtHLQMuLvz8HqI3Vn4FV2CMnwGlMxkclgzDYuNBWufP9LLrDmegHVIdb+WqdtepbeNjamTHpeLN/aII5O1iJQze7pcoI4P1Aa5AEyVh7rkkKuIv8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-db-67ec97cb42b4
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
Subject: [PATCH v5 2/3] mm/mempolicy: Support dynamic sysfs updates for weighted interleave
Date: Wed,  2 Apr 2025 10:49:03 +0900
Message-ID: <20250402014906.1086-3-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250402014906.1086-1-rakie.kim@sk.com>
References: <20250402014906.1086-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnoe7p6W/SDW5eMLaYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vF6jUZDlweO2fdZffobrvM
	7tFy5C2rx+I9L5k8Nn2axO5xYsZvFo+dDy093u+7yubxeZNcAGcUl01Kak5mWWqRvl0CV8aq
	hX+YCs4oVWzYco+9gXGOTBcjJ4eEgInElB03mboYOcDs6S/kQEw2ASWJY3tjQCpEBEQl5h2d
	zdLFyMXBLHCNSeLA55ssIDXCAtESV25UgtSwCKhK7N27mgXE5gWa8uDkY3aI6ZoSDZfugU3n
	FDCV+NoNFhYCKmm6vQSqXFDi5MwnYDazgLxE89bZzCCrJASes0nMeH+HFWKOpMTBFTdYJjDy
	z0LSMwtJzwJGplWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgaG+rPZP9A7GTxeCDzEKcDAq8fA2
	8L5JF2JNLCuuzD3EKMHBrCTCG/H1ZboQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJ
	JanZqakFqUUwWSYOTqkGRoM9fZ1vRT2DxU9tjF3/nH2NQ+nP4yt787Mz2bX35+0q2euvU257
	rb/x0RzmkwFaOmvZ1/+S3vS5t2uCRtAE+VXJX16ISjdoZJf2vHTIuy/gNzvqwKZnLDfW6vz7
	bOPv8mWeyn+zGRrFc7gf7v1bF/8tsDFSWfr872+hF2/lXhF0Wnty1+SXM5VYijMSDbWYi4oT
	Aa98sNhxAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXCNUNNS/f09DfpBvv/alnMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvF52evmS1WLbzGZnF86zx2i8NzT7JanJ91isXi8q45bBb31vxntTh07Tmr
	xeo1GRa/t61gc+Dz2DnrLrtHd9tldo+WI29ZPRbvecnksenTJHaPEzN+s3jsfGjp8X7fVTaP
	b7c9PBa/+MDk8XmTXAB3FJdNSmpOZllqkb5dAlfGqoV/mArOKFVs2HKPvYFxjkwXIweHhICJ
	xPQXciAmm4CSxLG9MV2MnBwiAqIS847OZuli5OJgFrjGJHHg800WkBphgWiJKzcqQWpYBFQl
	9u5dzQJi8wJNeXDyMTuILSGgKdFw6R4TSDmngKnE126wsBBQSdPtJVDlghInZz4Bs5kF5CWa
	t85mnsDIMwtJahaS1AJGplWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiB4b2s9s/EHYxfLrsf
	YhTgYFTi4RXoeZMuxJpYVlyZe4hRgoNZSYQ34uvLdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGlsBNvbeZ7rjmH3FjLRI5yRop6f+mkNWhK/OpOF9r
	SlTAownFRpHHG6KWxebqe+nsezBt+3VXp+ezDRkkHqb0nw/8e++mkpXvvZU3Xe9sjeF04jvD
	vVC/6YDXRaZzUle3h7QxRCc0XA9m/zyt3KrjJX/F3AlzKrzdrc692G7ZFf52gQu/w1YlluKM
	REMt5qLiRABObDj4awIAAA==
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

