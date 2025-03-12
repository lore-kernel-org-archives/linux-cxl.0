Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A891723026F;
	Wed, 12 Mar 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766210; cv=none; b=bJyB52ry/+CsYO067rQwuRXSx452QG6IKAJa3EGwdUnz0ubzlxjeKHv08RRMD6EULRTuN9DZlT2EXJYy32srrwhZFpOSC8QhPRKx7nQWal8jx8cIXE4mc/mPy1RdZF7eafldDBQ7UjwgsaDyR8h+TDIPyXsQ6h66/9AsftS01mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766210; c=relaxed/simple;
	bh=GTPuNwymZ+04io2yMrPM0InKHZ4HpkEy8pbRYEMU+GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8kVhyqIEA7ZUuxgc83Z3T7AISwKYtB8e+n6gI7DCvcv7MZht+nnWdmeubUH65//jYmIpWkmo+HOBrvMZZpUWFjz5+ZS6k3P4dD6BMG6coDF7Z3LTdu5wOIJ/+pmV+gKgCyk7c0Yh7VfVyowHOGonVMt6TU2J4FdrlTo1eU6peI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-17-67d13e3b6a68
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
Subject: [PATCH v2 4/4] mm/mempolicy: Fix duplicate node addition in sysfs for weighted interleave
Date: Wed, 12 Mar 2025 16:56:27 +0900
Message-ID: <20250312075628.648-4-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC9ZZnka613cV0g3+LBCzmrF/DZjF96gVG
	i593j7NbHN86j93i/KxTLBaXd81hs7i35j+rxeo1GQ4cHjtn3WX36G67zO6xeM9LJo9Nnyax
	e5yY8ZvFY+dDS4/Pm+QC2KO4bFJSczLLUov07RK4Mv6fmMdc8Fym4kPrDPYGxjfiXYycHBIC
	JhJtE66xwNjTHnYxdjFycLAJKEkc2xsDEhYREJWYd3Q2UAkXB7PAYiaJhYfXM4EkhAWSJHo/
	P2cGsVkEVCUOPXrICGLzChhLXH47lxFipqZEw6V7YPWcQPNffL4GZgsB1SxfNx2qXlDi5Mwn
	YDcwC8hLNG+dzQyyTELgBJvEw4u7WSEGSUocXHGDZQIj/ywkPbOQ9CxgZFrFKJSZV5abmJlj
	opdRmZdZoZecn7uJERjIy2r/RO9g/HQh+BCjAAejEg+vQM6FdCHWxLLiytxDjBIczEoivKtt
	gUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYixdz5s00
	Wtp58klRe+3XNcfVMltvqO1XXG6xts7o8mLGfnfNt2+E3mu9iY4/bn3w5uQTzysqPrF8maJ7
	9q9vrX5Zw8V/l9R1PXb4trfO9Lq9NuPxvYZ9hzaHMC9flLCzuEUy+s+nR/4fHzfU9sTO2Lh3
	8pKwDwsrrs6JfbnSwM5d89imdG6NI0osxRmJhlrMRcWJAM+avFBgAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsXCNUNNS9fa7mK6wZXtHBZz1q9hs5g+9QKj
	xc+7x9ktPj97zWxxfOs8dovDc0+yWpyfdYrF4vKuOWwW99b8Z7U4dO05q8XqNRkWv7etYHPg
	8dg56y67R3fbZXaPxXteMnls+jSJ3ePEjN8sHjsfWnp8u+3hsfjFByaPz5vkAjijuGxSUnMy
	y1KL9O0SuDL+n5jHXPBcpuJD6wz2BsY34l2MnBwSAiYS0x52MXYxcnCwCShJHNsbAxIWERCV
	mHd0NksXIxcHs8BiJomFh9czgSSEBZIkej8/ZwaxWQRUJQ49esgIYvMKGEtcfjuXEWKmpkTD
	pXtg9ZxA8198vgZmCwHVLF83HapeUOLkzCcsIDazgLxE89bZzBMYeWYhSc1CklrAyLSKUSQz
	ryw3MTPHVK84O6MyL7NCLzk/dxMjMHiX1f6ZuIPxy2X3Q4wCHIxKPLwHVC+kC7EmlhVX5h5i
	lOBgVhLhXW0LFOJNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl4uCU
	amAsc6q5P0t43c7S+AsqSelhaa7nfkwNNe4plGMv2V0jq/jpBE/xpUfia5cqfpNPdC/4LXDu
	5YJo9kDm3uRnV5Mz56dVP2nfvKq34o7VhdjrR26sNVDaXirHOnv7HN1stewuFv7yvQ+SPNcs
	62A8Jbaj0rZiY8uLWTV3FvxbzXav1WCRXM3d5lolluKMREMt5qLiRACMy050WgIAAA==
X-CFilter-Loop: Reflected

Sysfs attributes for interleave control were registered both at initialization
and when new nodes were detected via hotplug, leading to potential duplicates.

This patch ensures that each node is registered only once, preventing conflicts
and redundant sysfs entries.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 mm/mempolicy.c | 66 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 71aff1276d4d..5f20521036ec 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3391,6 +3391,7 @@ struct iw_node_attr {
 
 struct iw_node_group {
 	struct kobject *wi_kobj;
+	struct mutex kobj_lock;
 	struct iw_node_attr **nattrs;
 };
 
@@ -3440,12 +3441,17 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static void sysfs_wi_node_release(int nid)
 {
-	if (!ngrp->nattrs[nid])
+	mutex_lock(&ngrp->kobj_lock);
+	if (!ngrp->nattrs[nid]) {
+		mutex_unlock(&ngrp->kobj_lock);
 		return;
+	}
 
 	sysfs_remove_file(ngrp->wi_kobj, &ngrp->nattrs[nid]->kobj_attr.attr);
 	kfree(ngrp->nattrs[nid]->kobj_attr.attr.name);
 	kfree(ngrp->nattrs[nid]);
+	ngrp->nattrs[nid] = NULL;
+	mutex_unlock(&ngrp->kobj_lock);
 }
 
 static void sysfs_wi_release(struct kobject *wi_kobj)
@@ -3464,35 +3470,54 @@ static const struct kobj_type wi_ktype = {
 
 static int sysfs_wi_node_add(int nid)
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
 
-	if (sysfs_create_file(ngrp->wi_kobj, &node_attr->kobj_attr.attr)) {
-		kfree(node_attr->kobj_attr.attr.name);
-		kfree(node_attr);
-		pr_err("failed to add attribute to weighted_interleave\n");
-		return -ENOMEM;
+	ret = sysfs_create_file(ngrp->wi_kobj, &ngrp->nattrs[nid]->kobj_attr.attr);
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
@@ -3588,6 +3613,7 @@ static int __init mempolicy_sysfs_init(void)
 		err = -ENOMEM;
 		goto err_out;
 	}
+	mutex_init(&ngrp->kobj_lock);
 
 	ngrp->nattrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
 			       GFP_KERNEL);
-- 
2.34.1

