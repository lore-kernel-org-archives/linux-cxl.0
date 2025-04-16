Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED10A4C83;
	Wed, 16 Apr 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803104; cv=none; b=o9/uzhjgfONMXOJaAh9pG84NjG/dgQMCtft5kxKeZOP7qw+jZgFy5CwayJjvGJHDnVxmIbqLlg6T3USkSR37lNA8L6wjK9pAIwvZYrp7067SElkQ5rr9Sor1ZvsET+H0ed7o2mvqzQzfyJsq75kfbCuAKC/saf8zWqRZhwY5qI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803104; c=relaxed/simple;
	bh=DojL5Wj/u5Iox+MiFuP7XiWOZUQZruqf2pUSCmkY9+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFPkyt6JsUrREEeJdMKoFagbyOfrKmwAtmf1ZR2mCzzDVKIqIBmdspJRO+TVY8B6GJFZ49hdqV55D8RAm3NydQdWjORtQPZDSw/C5XcKierFtkOrPOoQlQWuhqrecUjpXdIx+lLQj91tK/o68MLK/yGtiqlV0XjKFfyjnHcRmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-0d-67ff95176253
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
Subject: [PATCH v8 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Wed, 16 Apr 2025 20:31:19 +0900
Message-ID: <20250416113123.629-2-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnka741P/pBvdmaVnMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Ml58mMVa8EK74k5XaAPjF+UuRk4OCQETicfTHjPC2Md/PmbqYuTgYBNQkji2NwYk
	LCIgKzH173mWLkYuDmaBx0wSj56/AKsXFgiWaNvaxw5iswioSmxqWAhm8woYS0x//w1qpqZE
	w6V7TCA2J9D8k5MWgcWFgGq2vprHCFEvKHFy5hMWEJtZQF6ieetsZpBlEgLv2SROzT0JNUhS
	4uCKGywTGPlnIemZhaRnASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzA8F9W+yd6B+OnC8GH
	GAU4GJV4eCPi/6ULsSaWFVfmHmKU4GBWEuE9Zw4U4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmv0
	rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwOjzn2lrLu+yiDePOwt2J/Q05aQcCN6+51vVrL8JphNc
	P4hvD9hzzVqvUO2EzvWucyzzPm026rq7NueaT6jD63WnHOJ9/oifOXCLz8gip/vI3D3dZ+1/
	HD17pGJBWVi00mMOVYPaV1fORP2olmipsLljFGPJfWHrgWd56avPTXu80KTEo37V+tlKLMUZ
	iYZazEXFiQAz67gYewIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNS1d86v90g+/bJC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDJefJjFWvBCu+JOV2gD4xfl
	LkZODgkBE4njPx8zdTFycLAJKEkc2xsDEhYRkJWY+vc8SxcjFwezwGMmiUfPXzCCJIQFgiXa
	tvaxg9gsAqoSmxoWgtm8AsYS099/Y4SYqSnRcOkeE4jNCTT/5KRFYHEhoJqtr+YxQtQLSpyc
	+YQFxGYWkJdo3jqbeQIjzywkqVlIUgsYmVYximTmleUmZuaY6hVnZ1TmZVboJefnbmIEhvyy
	2j8TdzB+uex+iFGAg1GJhzci/l+6EGtiWXFl7iFGCQ5mJRHec+ZAId6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsbiLeevx04Qatgp/LVyVXtPUFWpioFG
	R+3dJ3ZCnQxvQkvvHXktW64o38wXecWS72XRi5yPiy2vuKWpNUpJSa1wTngj/n91SJjsgfx/
	D68cnfJAld23acLUZbeMF7T8253T02b8xERRXuzIquCd76YaWEWXslqoJ2d67mefs/NqTDGj
	8/HVB5VYijMSDbWYi4oTAbmV3J91AgAA
X-CFilter-Loop: Reflected

Memory leaks occurred when removing sysfs attributes for weighted
interleave. Improper kobject deallocation led to unreleased memory
when initialization failed or when nodes were removed.

This patch resolves the issue by replacing unnecessary `kfree()`
calls with proper `kobject_del()` and `kobject_put()` sequences,
ensuring correct teardown and preventing memory leaks.

By explicitly calling `kobject_del()` before `kobject_put()`, the
release function is now invoked safely, and internal sysfs state is
correctly cleaned up. This guarantees that the memory associated with
the kobject is fully released and avoids resource leaks, thereby
improving system stability.

Additionally, sysfs_remove_file() is no longer called from the release
function to avoid accessing invalid sysfs state after kobject_del().
All attribute removals are now done before kobject_del(), preventing
WARN_ON() in kernfs and ensuring safe and consistent cleanup of sysfs
entries.

Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 mm/mempolicy.c | 111 +++++++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 50 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b28a1e6ae096..dcf03c389b51 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3463,8 +3463,8 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct iw_node_attr **node_attrs;
 
-static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
-				  struct kobject *parent)
+static void sysfs_wi_node_delete(struct iw_node_attr *node_attr,
+				 struct kobject *parent)
 {
 	if (!node_attr)
 		return;
@@ -3473,18 +3473,41 @@ static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
 	kfree(node_attr);
 }
 
-static void sysfs_wi_release(struct kobject *wi_kobj)
+static void sysfs_wi_node_delete_all(struct kobject *wi_kobj)
 {
-	int i;
+	int nid;
 
-	for (i = 0; i < nr_node_ids; i++)
-		sysfs_wi_node_release(node_attrs[i], wi_kobj);
-	kobject_put(wi_kobj);
+	for (nid = 0; nid < nr_node_ids; nid++)
+		sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
+}
+
+static void iw_table_free(void)
+{
+	u8 *old;
+
+	mutex_lock(&iw_table_lock);
+	old = rcu_dereference_protected(iw_table,
+					lockdep_is_held(&iw_table_lock));
+	if (old) {
+		rcu_assign_pointer(iw_table, NULL);
+		mutex_unlock(&iw_table_lock);
+
+		synchronize_rcu();
+		kfree(old);
+	} else
+		mutex_unlock(&iw_table_lock);
+}
+
+static void wi_kobj_release(struct kobject *wi_kobj)
+{
+	iw_table_free();
+	kfree(node_attrs);
+	kfree(wi_kobj);
 }
 
 static const struct kobj_type wi_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
-	.release = sysfs_wi_release,
+	.release = wi_kobj_release,
 };
 
 static int add_weight_node(int nid, struct kobject *wi_kobj)
@@ -3525,41 +3548,42 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
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
+			goto err_cleanup_kobj;
 		}
 	}
-	if (err)
-		kobject_put(wi_kobj);
+
 	return 0;
+
+err_cleanup_kobj:
+	sysfs_wi_node_delete_all(wi_kobj);
+	kobject_del(wi_kobj);
+err_put_kobj:
+	kobject_put(wi_kobj);
+	return err;
 }
 
 static void mempolicy_kobj_release(struct kobject *kobj)
 {
-	u8 *old;
-
-	mutex_lock(&iw_table_lock);
-	old = rcu_dereference_protected(iw_table,
-					lockdep_is_held(&iw_table_lock));
-	rcu_assign_pointer(iw_table, NULL);
-	mutex_unlock(&iw_table_lock);
-	synchronize_rcu();
-	kfree(old);
-	kfree(node_attrs);
 	kfree(kobj);
 }
 
@@ -3573,37 +3597,24 @@ static int __init mempolicy_sysfs_init(void)
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

