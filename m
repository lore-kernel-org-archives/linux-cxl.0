Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D63022FE06;
	Wed, 16 Apr 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803104; cv=none; b=nnLcKkaX9Lid5mgOcsvMXD54GINsDf7ue0vbru5F3HYGqvF7QSxjdzYreZEy+YVQ8N5Z5ZUjHSE9wvx4RraF3T1prbjWAdFvxDXbixVAsB0ggVJZ3Pf6ygA762MacS7WoyP12jNkC80pw4GVi9xMUhJWtIXIs/oNxV3BghCVRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803104; c=relaxed/simple;
	bh=ZQYKRD6tG0p3IEZNDYEtn9cibpci4J2K55EoFAoo9jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfRxwD5ajfQQYfXTSUPMg6T5Q+7dxdHw8WaAMbyGJX/j9O4zifc17uelIm0QFm8A2BDVh+6dvZKE1X4Cn1/3UznRbbVc1kVD+kslkbueKOLdp7OyaMDTjcSEN8XVv960VGzpIBR4V9MWOwug/c6+Rk0MfXhon0i2t+uPIEXEqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-17-67ff951a2965
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
Subject: [PATCH v8 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
Date: Wed, 16 Apr 2025 20:31:20 +0900
Message-ID: <20250416113123.629-3-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250416113123.629-1-rakie.kim@sk.com>
References: <20250416113123.629-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnka7U1P/pBpfPaFrMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Ms7fiSxYqlHxob2HrYFxv2IXIyeHhICJRHvHZjYYu//KSiCbg4NNQEni2N4YkLCI
	gKzE1L/nWboYuTiYBR4zSTx6/oIRJCEsECVx79ZLsF4WAVWJ5wf62UFsXgFjiTnzPrNCzNSU
	aLh0jwnE5gSaf3LSIrBeIaCara/mMULUC0qcnPmEBcRmFpCXaN46mxlkmYTAZzaJz+8XMEIM
	kpQ4uOIGywRG/llIemYh6VnAyLSKUSgzryw3MTPHRC+jMi+zQi85P3cTIzD8l9X+id7B+OlC
	8CFGAQ5GJR7eiPh/6UKsiWXFlbmHGCU4mJVEeM+ZA4V4UxIrq1KL8uOLSnNSiw8xSnOwKInz
	Gn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwZh14qLTy7sG9n6v33akS4orbNbG/6YtO4Zz3WVtZ
	lksErtu59Hje6cycv2Znzfc/yy6JOPHI+p3y2ptGpmdLf6w8VBmclN+vvtDPjONZn7+H0fT/
	k/XXCRhcMjwimK45NSNo97+pX0prcvxVvXr5Fl9ecCnnR0WzAV/b15rsdJ/Fy00edupYKbEU
	ZyQaajEXFScCACJi/KF7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNS1dq6v90g6X/JC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDLO34ksWKpR8aG9h62Bcb9i
	FyMnh4SAiUT/lZVsXYwcHGwCShLH9saAhEUEZCWm/j3P0sXIxcEs8JhJ4tHzF4wgCWGBKIl7
	t16ygdgsAqoSzw/0s4PYvALGEnPmfWaFmKkp0XDpHhOIzQk0/+SkRWC9QkA1W1/NY4SoF5Q4
	OfMJC4jNLCAv0bx1NvMERp5ZSFKzkKQWMDKtYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAz5
	ZbV/Ju5g/HLZ/RCjAAejEg9vRPy/dCHWxLLiytxDjBIczEoivOfMgUK8KYmVValF+fFFpTmp
	xYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MKdPE5C8smWc8c7JAsUVRyKydot75
	tx6xJx9j7Dtx5IH6naL6XqlTi/UfX0mx8Ylr+M32riPv0HXlCc46P78eq931RmXKhpBj7xcq
	zHnHc+rBmhUOGYH1B+62JfKuOKvgWXWxuDM47Om2zFrPAx/332Odmnxwd4TKIYcNir4/1Cem
	tWaXvdyap8RSnJFoqMVcVJwIAHl+8oN1AgAA
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
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/mempolicy.c | 60 ++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index dcf03c389b51..998635127e9d 100644
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
@@ -3461,24 +3468,23 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 
-static struct iw_node_attr **node_attrs;
-
-static void sysfs_wi_node_delete(struct iw_node_attr *node_attr,
-				 struct kobject *parent)
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
 
-static void sysfs_wi_node_delete_all(struct kobject *wi_kobj)
+static void sysfs_wi_node_delete_all(void)
 {
 	int nid;
 
 	for (nid = 0; nid < nr_node_ids; nid++)
-		sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
+		sysfs_wi_node_delete(nid);
 }
 
 static void iw_table_free(void)
@@ -3501,8 +3507,7 @@ static void iw_table_free(void)
 static void wi_kobj_release(struct kobject *wi_kobj)
 {
 	iw_table_free();
-	kfree(node_attrs);
-	kfree(wi_kobj);
+	kfree(wi_group);
 }
 
 static const struct kobj_type wi_ktype = {
@@ -3510,7 +3515,7 @@ static const struct kobj_type wi_ktype = {
 	.release = wi_kobj_release,
 };
 
-static int add_weight_node(int nid, struct kobject *wi_kobj)
+static int sysfs_wi_node_add(int nid)
 {
 	struct iw_node_attr *node_attr;
 	char *name;
@@ -3532,40 +3537,33 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
-		return -ENOMEM;
-
-	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
-	if (!wi_kobj) {
-		kfree(node_attrs);
+	wi_group = kzalloc(struct_size(wi_group, nattrs, nr_node_ids),
+			   GFP_KERNEL);
+	if (!wi_group)
 		return -ENOMEM;
-	}
 
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
 			goto err_cleanup_kobj;
@@ -3575,10 +3573,10 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 	return 0;
 
 err_cleanup_kobj:
-	sysfs_wi_node_delete_all(wi_kobj);
-	kobject_del(wi_kobj);
+	sysfs_wi_node_delete_all();
+	kobject_del(&wi_group->wi_kobj);
 err_put_kobj:
-	kobject_put(wi_kobj);
+	kobject_put(&wi_group->wi_kobj);
 	return err;
 }
 
-- 
2.34.1

