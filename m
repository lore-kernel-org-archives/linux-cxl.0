Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7421C163;
	Thu, 17 Apr 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874958; cv=none; b=NmhlMqaXbZgblMWX/zPeKe2luRLW28I4IBMu1uEjiMvKvbmrWElihWFPXbIJ7j9NXYiIBWW1jMnAcjQWtV8f/6KNvfS6cluY1BdJkxnKnvmaC7Yc+VHz9srCdGEfenbQ5wy3OVqriiSJoZI7hWEG8saCTh4QdlfY+BQKu17fNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874958; c=relaxed/simple;
	bh=7OT01MoGWMstMxt1ZCpNYviXmh+PWcMQps7TxC2tqnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3QstYeCL6kM28306uZmf7TAM/FY8EYRYG96ucz/ZGke/apEm2J7R3rICJmAUMnHyqQU3OigoCegi5UIr5z2UmIja7I8cGJ8q1GHeDl4bZcuz+AGhd7GP5gwP77enaGHUx1sIStt1ouNrabGa1AnhhqafO6IYe0edkrTwH54+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-0b-6800adc3d9e0
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
Subject: [PATCH v9 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
Date: Thu, 17 Apr 2025 16:28:36 +0900
Message-ID: <20250417072839.711-3-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250417072839.711-1-rakie.kim@sk.com>
References: <20250417072839.711-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoe7htQwZBo+buSzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGVd3/Gcs+KFZse/aSaYGxtdKXYycHBICJhKrrz5lg7GbehpZuxg5ONgElCSO7Y0B
	CYsIyEpM/XuepYuRi4NZ4DGTxKPnLxhBEsICURL/9rxhArFZBFQlLlzYDmbzChhLnNp+nxli
	pqZEw6V7YHFOoPnTdreAxYWAama+ms4GUS8ocXLmExYQm1lAXqJ562xmkGUSAp/ZJObuP8QK
	MUhS4uCKGywTGPlnIemZhaRnASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzACFhW+yd6B+On
	C8GHGAU4GJV4eE8s+p8uxJpYVlyZe4hRgoNZSYT3nPm/dCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MS5Y0uB/Jn/HuNdsR10OVcR23WHTX/OSNYjSW
	e/Uzc7vOVs1X0yY5Supxtb7qiXm8/s20QL9mvZ33Ay/0fdU4PC/3arP8y5dfZwleUVTwlXil
	YPfyajNnh/2X+Dn3DONe2hdcPVigu+7KPgklh5xlduoP/y3Yx5F/SZrFon3ptoYHXuJf5Qrb
	lViKMxINtZiLihMBCzq7+HwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS/fQWoYMgw+nrS3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDKu7vjPWPBDs2LftZNMDYyv
	lboYOTkkBEwkmnoaWbsYOTjYBJQkju2NAQmLCMhKTP17nqWLkYuDWeAxk8Sj5y8YQRLCAlES
	//a8YQKxWQRUJS5c2A5m8woYS5zafp8ZYqamRMOle2BxTqD503a3gMWFgGpmvprOBlEvKHFy
	5hMWEJtZQF6ieets5gmMPLOQpGYhSS1gZFrFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGPTL
	av9M3MH45bL7IUYBDkYlHt4Ti/6nC7EmlhVX5h5ilOBgVhLhPWf+L12INyWxsiq1KD++qDQn
	tfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qB8Y5cyodVbCVdtgl1T/0iPjft1y2/
	n8hVJeqQrNMqURE8STVDIVFe9rbu/PdzQmfsTKmyXRgb7Jax873K0rb/aZKea34E5d7SU564
	e4vJXY2ceIXs0ucNKqZLtQvvxLjdvr2RZ63/f3Hf018O3bb7f6Do5GaPUyG/n+40O2iy0d2u
	PIJTsfKzEktxRqKhFnNRcSIAgF5fKXYCAAA=
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/mempolicy.c | 64 ++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 293b4b347975..97b52d65b3ba 100644
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
@@ -3495,15 +3501,14 @@ static void iw_table_free(void)
 	kfree(old);
 }
 
-static void wi_cleanup(struct kobject *wi_kobj) {
-	sysfs_wi_node_delete_all(wi_kobj);
+static void wi_cleanup(void) {
+	sysfs_wi_node_delete_all();
 	iw_table_free();
-	kfree(node_attrs);
 }
 
 static void wi_kobj_release(struct kobject *wi_kobj)
 {
-	kfree(wi_kobj);
+	kfree(wi_group);
 }
 
 static const struct kobj_type wi_ktype = {
@@ -3511,7 +3516,7 @@ static const struct kobj_type wi_ktype = {
 	.release = wi_kobj_release,
 };
 
-static int add_weight_node(int nid, struct kobject *wi_kobj)
+static int sysfs_wi_node_add(int nid)
 {
 	struct iw_node_attr *node_attr;
 	char *name;
@@ -3533,40 +3538,33 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
@@ -3576,10 +3574,10 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 	return 0;
 
 err_cleanup_kobj:
-	wi_cleanup(wi_kobj);
-	kobject_del(wi_kobj);
+	wi_cleanup();
+	kobject_del(&wi_group->wi_kobj);
 err_put_kobj:
-	kobject_put(wi_kobj);
+	kobject_put(&wi_group->wi_kobj);
 	return err;
 }
 
-- 
2.34.1

