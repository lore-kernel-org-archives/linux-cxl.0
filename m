Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3030426136C;
	Tue,  8 Apr 2025 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097643; cv=none; b=RwwPPSyn6YnadT9Zj+99SKJjVIaKQDNZsVoqXGCUYDwaLoYAHedZ5CuBQal5purHjCftpAJD0kIawL6yMDvpLGnqEAJii0OLSqONo2k5t3vlWiE2mzncv0uOXlaShaSzH6wxyax95CD0yjkBARv3GEbVmPsZmy11NvjXZYc2VWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097643; c=relaxed/simple;
	bh=TPdvCl5NTpmYRSDYVmfFoEa0px/BJOQxiXEIv4Y6Dv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqtOMIKtxS3xyzQJBGGnEJ5w0DShaGYI1+v9GLI55uKI/pWMxDDzlwzWosSScwsIpUCUkqOANSPQG+T+13eiq449DLWBse07QE2wvHprC8aIrOS59fvi51EYbUPwfjuyoFW9SmeFa20amIz8Np4T77i9oASpeib0IXiUJQVV+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f7-67f4d160c5cb
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
Subject: [PATCH v7 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Tue,  8 Apr 2025 16:32:40 +0900
Message-ID: <20250408073243.488-2-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250408073243.488-1-rakie.kim@sk.com>
References: <20250408073243.488-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnkW7CxS/pBhuPWVrMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Ms6/3MZUsFWu4u+RtcwNjPcluhg5OSQETCQ+Lj3OAmO/WrqPsYuRg4NNQEni2N4Y
	kLCIgKzE1L/ngUq4OJgFHjNJPHr+ghEkISwQLPHg2m82EJtFQFVi4apF7CA2r4CxxI0dyxgh
	ZmpKNFy6xwRicwLN/396NwvIfCGgmt7piRDlghInZz4BO4FZQF6ieetsZpBdEgLf2SQ6971g
	hpgjKXFwxQ2WCYz8s5D0zELSs4CRaRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYPgvq/0TvYPx
	04XgQ4wCHIxKPLweRz+nC7EmlhVX5h5ilOBgVhLhfTvxS7oQb0piZVVqUX58UWlOavEhRmkO
	FiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxpj0PZadc5b/b7oT2Hf3t+hhtZI59z9vy8yQ
	rTLYblpzota5L0ruxuQAi/nZGUU2c2/yBa+2UhLMels2sTp7X2rD+f9GF7uOmK1SmZheph5n
	o9zZHOl64wLzp3cGgZXhCwxWi5z943mjW1plksdLBnth47W3IkIPTzXu5H13Zv/TbBaXyxnX
	lFiKMxINtZiLihMBHMqARXsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNSzfh4pd0g7sLdCzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDLOv9zGVLBVruLvkbXMDYz3
	JboYOTkkBEwkXi3dx9jFyMHBJqAkcWxvDEhYREBWYurf8yxdjFwczAKPmSQePX/BCJIQFgiW
	eHDtNxuIzSKgKrFw1SJ2EJtXwFjixo5ljBAzNSUaLt1jArE5geb/P72bBWS+EFBN7/REiHJB
	iZMzn7CA2MwC8hLNW2czT2DkmYUkNQtJagEj0ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzA
	kF9W+2fiDsYvl90PMQpwMCrx8Hoc/ZwuxJpYVlyZe4hRgoNZSYT37cQv6UK8KYmVValF+fFF
	pTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MzfXLj3v/Tjp06bDTK51tfEZe
	erfOTol+s7ho49UHcy6UPC6R987V2xl4WKnR6v6DvZVSCxLrOndsW2LVvuxQklXsseMK062u
	XLzQz+aez3buqOtV53SmmzPFA7R5vb1ijvgfdF7j13355rYTjMd0d8h45sS+1Li469buHRw2
	fM5mc4/e3iY0VYmlOCPRUIu5qDgRAIKE/dZ1AgAA
X-CFilter-Loop: Reflected

Memory leaks occurred when removing sysfs attributes for weighted
interleave. Improper kobject deallocation led to unreleased memory
when initialization failed or when nodes were removed.

This patch resolves the issue by replacing unnecessary `kfree()`
calls with proper `kobject_del()` and `kobject_put()` sequences,
ensuring correct teardown and preventing memory leaks.

By explicitly calling `kobject_del()` before `kobject_put()`,
the release function is now invoked safely, and internal sysfs
state is correctly cleaned up. This guarantees that the memory
associated with the kobject is fully released and avoids
resource leaks, thereby improving system stability.

Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 66 ++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b28a1e6ae096..0da102aa1cfc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3479,7 +3479,9 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
 
 	for (i = 0; i < nr_node_ids; i++)
 		sysfs_wi_node_release(node_attrs[i], wi_kobj);
-	kobject_put(wi_kobj);
+
+	kfree(node_attrs);
+	kfree(wi_kobj);
 }
 
 static const struct kobj_type wi_ktype = {
@@ -3525,27 +3527,37 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 	struct kobject *wi_kobj;
 	int nid, err;
 
+	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
+			     GFP_KERNEL);
+	if (!node_attrs)
+		return -ENOMEM;
+
 	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
-	if (!wi_kobj)
+	if (!wi_kobj) {
+		kfree(node_attrs);
 		return -ENOMEM;
+	}
 
 	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
 				   "weighted_interleave");
-	if (err) {
-		kfree(wi_kobj);
-		return err;
-	}
+	if (err)
+		goto err_put_kobj;
 
 	for_each_node_state(nid, N_POSSIBLE) {
 		err = add_weight_node(nid, wi_kobj);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
-			break;
+			goto err_del_kobj;
 		}
 	}
-	if (err)
-		kobject_put(wi_kobj);
+
 	return 0;
+
+err_del_kobj:
+	kobject_del(wi_kobj);
+err_put_kobj:
+	kobject_put(wi_kobj);
+	return err;
 }
 
 static void mempolicy_kobj_release(struct kobject *kobj)
@@ -3559,7 +3571,6 @@ static void mempolicy_kobj_release(struct kobject *kobj)
 	mutex_unlock(&iw_table_lock);
 	synchronize_rcu();
 	kfree(old);
-	kfree(node_attrs);
 	kfree(kobj);
 }
 
@@ -3573,37 +3584,24 @@ static int __init mempolicy_sysfs_init(void)
 	static struct kobject *mempolicy_kobj;
 
 	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
-	if (!mempolicy_kobj) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
-			     GFP_KERNEL);
-	if (!node_attrs) {
-		err = -ENOMEM;
-		goto mempol_out;
-	}
+	if (!mempolicy_kobj)
+		return -ENOMEM;
 
 	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
 				   "mempolicy");
 	if (err)
-		goto node_out;
+		goto err_put_kobj;
 
 	err = add_weighted_interleave_group(mempolicy_kobj);
-	if (err) {
-		pr_err("mempolicy sysfs structure failed to initialize\n");
-		kobject_put(mempolicy_kobj);
-		return err;
-	}
+	if (err)
+		goto err_del_kobj;
 
-	return err;
-node_out:
-	kfree(node_attrs);
-mempol_out:
-	kfree(mempolicy_kobj);
-err_out:
-	pr_err("failed to add mempolicy kobject to the system\n");
+	return 0;
+
+err_del_kobj:
+	kobject_del(mempolicy_kobj);
+err_put_kobj:
+	kobject_put(mempolicy_kobj);
 	return err;
 }
 
-- 
2.34.1

