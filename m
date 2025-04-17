Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CD21B9FE;
	Thu, 17 Apr 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874954; cv=none; b=n87O/jEK3Yw+TvvoQ72xbSW/7/xKDjlrf6ukdmg5GtpJpBU/X3CujIHW0a/gVozY6mSka1biTdN9XG+WFxsi1a/c5mvgeV99NveML3C2X/g0uSFJJxpZMS4WVds7zX+FB1WuUQrbovNSjHiJkngFqaND1M2DaUv5qsqym0/F8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874954; c=relaxed/simple;
	bh=YNl0EEsMfcC1GcSComJy1zfV6k+2ujPh3rzNdEIXm4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEBjw9pHKcFt69wAu9QTngiFIClzFzo7i527H4+L1cbVMXJRR/WnRCvDKmAgdVzlmaFOlvE7B6RwZ1hAXQBRXehfRoRmjFFEKXQeL2AuE5gDQSGZFu+y6wOeXMfEcNdFaCXMDELRycSf1nTcNDK+SWRUYjX/lH0qGyrgIeTWjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-03-6800adc07388
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
Subject: [PATCH v9 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Thu, 17 Apr 2025 16:28:35 +0900
Message-ID: <20250417072839.711-2-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoe6BtQwZBh93KFnMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Ml58OMBWcEG34uK8T8wNjOdUuxg5OSQETCR+z5/ECGNPWTKDrYuRg4NNQEni2N4Y
	kLCIgKzE1L/nWboYuTiYBR4zSTx6/gKsXlggWOLr2mWsIDaLgKrEzCf/wGxeAWOJFfd2MkPM
	1JRouHSPCcTmBJo/bXcLWFwIqGbmq+lsEPWCEidnPmEBsZkF5CWat85mBlkmIfCdTeLD24NQ
	x0lKHFxxg2UCI/8sJD2zkPQsYGRaxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYActq/0TvYPx0
	IfgQowAHoxIP74lF/9OFWBPLiitzDzFKcDArifCeM/+XLsSbklhZlVqUH19UmpNafIhRmoNF
	SZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoHRl52p4grT4201GTn74s7EMvG6/3vOqivyScr8
	vdz10Bna8TZ7w34f/MJv11dv9KwqO/aEmIzZ4ZRSjr53osvOzi83usCa8U9hKtOr3K6JW+d4
	NCxkWbQyKX7pHaP83rpe1qXRTUEL89dn/44KinMQEnZcdlXxb3mqQ5LiDa5XvI8P22d47FBi
	Kc5INNRiLipOBABs+6ZOfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS/fAWoYMg7crRCzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDJefDjAVnBBt+LivE/MDYzn
	VLsYOTkkBEwkpiyZwdbFyMHBJqAkcWxvDEhYREBWYurf8yxdjFwczAKPmSQePX/BCJIQFgiW
	+Lp2GSuIzSKgKjHzyT8wm1fAWGLFvZ3MEDM1JRou3WMCsTmB5k/b3QIWFwKqmflqOhtEvaDE
	yZlPWEBsZgF5ieats5knMPLMQpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmDQ
	L6v9M3EH45fL7ocYBTgYlXh4Tyz6ny7EmlhWXJl7iFGCg1lJhPec+b90Id6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsaioHVpG8M7Ni1NO/Vx91eZdcV1
	zD6hB/pnvj4nnq1hdHda2bSPkUZMb89JnDJv+eEbbVqh8971nUvYyTdXDaQiBf/5fGhQ4/wb
	FyXuPXfJCTWl2f1P6kVySv6cPZMgcG6FiET/hGUvP/jcjwmquvyv2f76gdeG/1wL7EX7Zp5j
	iZxZ8PRV/xklluKMREMt5qLiRADp7s5sdgIAAA==
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/mempolicy.c | 121 ++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 62 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b28a1e6ae096..293b4b347975 100644
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
@@ -3473,18 +3473,42 @@ static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
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
+	rcu_assign_pointer(iw_table, NULL);
+	mutex_unlock(&iw_table_lock);
+
+	synchronize_rcu();
+	kfree(old);
+}
+
+static void wi_cleanup(struct kobject *wi_kobj) {
+	sysfs_wi_node_delete_all(wi_kobj);
+	iw_table_free();
+	kfree(node_attrs);
+}
+
+static void wi_kobj_release(struct kobject *wi_kobj)
+{
+	kfree(wi_kobj);
 }
 
 static const struct kobj_type wi_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
-	.release = sysfs_wi_release,
+	.release = wi_kobj_release,
 };
 
 static int add_weight_node(int nid, struct kobject *wi_kobj)
@@ -3525,85 +3549,58 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
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
-	return 0;
-}
 
-static void mempolicy_kobj_release(struct kobject *kobj)
-{
-	u8 *old;
+	return 0;
 
-	mutex_lock(&iw_table_lock);
-	old = rcu_dereference_protected(iw_table,
-					lockdep_is_held(&iw_table_lock));
-	rcu_assign_pointer(iw_table, NULL);
-	mutex_unlock(&iw_table_lock);
-	synchronize_rcu();
-	kfree(old);
-	kfree(node_attrs);
-	kfree(kobj);
+err_cleanup_kobj:
+	wi_cleanup(wi_kobj);
+	kobject_del(wi_kobj);
+err_put_kobj:
+	kobject_put(wi_kobj);
+	return err;
 }
 
-static const struct kobj_type mempolicy_ktype = {
-	.release = mempolicy_kobj_release
-};
-
 static int __init mempolicy_sysfs_init(void)
 {
 	int err;
 	static struct kobject *mempolicy_kobj;
 
-	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
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
+	mempolicy_kobj = kobject_create_and_add("mempolicy", mm_kobj);
+	if (!mempolicy_kobj)
+		return -ENOMEM;
 
-	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
-				   "mempolicy");
+	err = add_weighted_interleave_group(mempolicy_kobj);
 	if (err)
-		goto node_out;
+		goto err_kobj;
 
-	err = add_weighted_interleave_group(mempolicy_kobj);
-	if (err) {
-		pr_err("mempolicy sysfs structure failed to initialize\n");
-		kobject_put(mempolicy_kobj);
-		return err;
-	}
+	return 0;
 
-	return err;
-node_out:
-	kfree(node_attrs);
-mempol_out:
-	kfree(mempolicy_kobj);
-err_out:
-	pr_err("failed to add mempolicy kobject to the system\n");
+err_kobj:
+	kobject_del(mempolicy_kobj);
+	kobject_put(mempolicy_kobj);
 	return err;
 }
 
-- 
2.34.1

