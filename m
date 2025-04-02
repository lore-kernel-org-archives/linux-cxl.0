Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A453FC7;
	Wed,  2 Apr 2025 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558612; cv=none; b=p2ookwO1MZ62aE6CyfnuRhAun6bWVAXbeEZAcXDndbiMcp+I7Ng/wMQuujf0qboG1EEF6H7ZNCW77Nq/Z7QLhSX3nLkfd6MzuBRYrrhaIK6AImv2/HeIa9qL2zJNocOHelyN6XVSQm5+ERnlWb9HtnneTjUQuFPoUZLEijaR/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558612; c=relaxed/simple;
	bh=ev88QDfI70wGQFqzTDVwN6Lpb4hXA5Cj9+UKl3RwI9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/oHZn4+jd2iBtmRZlUay7dexkN8bV7s53hyO6jKGTWLQoOnpwwrN6KquFaa44nSjAafhlvXae2gFLdC20ijfIt9gCJZfdf9GEaOHuB12tRPNwYd196lMwaWWMaKS6bCD3lRabkQNIgPLk7raBb8DEwJ0re7E6n2HVVq81/PiHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d0-67ec97c91b7a
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
Subject: [PATCH v5 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Wed,  2 Apr 2025 10:49:02 +0900
Message-ID: <20250402014906.1086-2-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnoe7J6W/SDXY9VLOYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vF6jUZDlweO2fdZffobrvM
	7tFy5C2rx+I9L5k8Nn2axO5xYsZvFo+dDy093u+7yubxeZNcAGcUl01Kak5mWWqRvl0CV8a8
	JY+YCs7IVJyacIyxgXGGeBcjJ4eEgInEgi2HmGHs5u1LGLsYOTjYBJQkju2NAQmLCIhKzDs6
	m6WLkYuDWeAak8SBzzdZQGqEBYIl5p+NBTFZBFQl9t0XBCnnBZpy5fcJdoiJmhINl+4xgZRw
	CphKfO0GCwsBlTTdXsICUS4ocXLmEzCbWUBeonnrbGaQTRICz9kkdq48xgIxR1Li4IobLBMY
	+Wch6ZmFpGcBI9MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMBQX1b7J3oH46cLwYcYBTgYlXh4
	G3jfpAuxJpYVV+YeYpTgYFYS4Y34+jJdiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0
	xJLU7NTUgtQimCwTB6dUA6ORaOq7jgCrWUrLTJ9kXuMX+hlxQXVvoOgypwZPtwO3taPn31zj
	YN1/uta3UeDoZI3kX48uLjJa761hL9X6QmjD263/7JZeKrzy3MLMnbWb+XXKyTDN6yFGAXIF
	n36mxq6r93Gs5H97+Py8U5riQsG2/PI/tsfd/L7Jx/X2uqfTtm9MXmjprqbEUpyRaKjFXFSc
	CAB8DQbOcQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXCNUNNS/fk9DfpBst65S3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWhy69pzV
	YvWaDIvf21awOfB57Jx1l92ju+0yu0fLkbesHov3vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH
	t9seHotffGDy+LxJLoA7issmJTUnsyy1SN8ugStj3pJHTAVnZCpOTTjG2MA4Q7yLkZNDQsBE
	onn7EsYuRg4ONgEliWN7Y0DCIgKiEvOOzmbpYuTiYBa4xiRx4PNNFpAaYYFgiflnY0FMFgFV
	iX33BUHKeYGmXPl9gh1ioqZEw6V7TCAlnAKmEl+7wcJCQCVNt5ewQJQLSpyc+QTMZhaQl2je
	Opt5AiPPLCSpWUhSCxiZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgSG97LaPxN3MH657H6I
	UYCDUYmHV6DnTboQa2JZcWXuIUYJDmYlEd6Iry/ThXhTEiurUovy44tKc1KLDzFKc7AoifN6
	hacmCAmkJ5akZqemFqQWwWSZODilGhgZJQsXX35twzTB5/iidIcdj9f9l7/zQeaRH4/3zH7P
	PVYLTzFqSLRls7rtslNKmrlKJUiHu+XgPR1HxaM2qXKSLKIZvYw+gWp8+1IdTILiGeT8gk0S
	d9c/Vf+h8bpfJfP+5gtHX67UuuH8Nk5nxvUzXZPmbDypIll/Y+sanf+CzOs6Jv8+46bEUpyR
	aKjFXFScCACBHzHQawIAAA==
X-CFilter-Loop: Reflected

Memory leaks occurred when removing sysfs attributes for weighted
interleave. Improper kobject deallocation led to unreleased memory
when initialization failed or when nodes were removed.

This patch resolves the issue by replacing unnecessary `kfree()`
calls with `kobject_put()`, ensuring proper cleanup and preventing
memory leaks.

By correctly using `kobject_put()`, the release function now
properly deallocates memory without causing resource leaks,
thereby improving system stability.

Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 61 +++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bbaadbeeb291..5950d5d5b85e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3448,7 +3448,9 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
 
 	for (i = 0; i < nr_node_ids; i++)
 		sysfs_wi_node_release(node_attrs[i], wi_kobj);
-	kobject_put(wi_kobj);
+
+	kfree(node_attrs);
+	kfree(wi_kobj);
 }
 
 static const struct kobj_type wi_ktype = {
@@ -3494,15 +3496,22 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 	struct kobject *wi_kobj;
 	int nid, err;
 
-	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
-	if (!wi_kobj)
+	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
+			     GFP_KERNEL);
+	if (!node_attrs)
 		return -ENOMEM;
 
+	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
+	if (!wi_kobj) {
+		err = -ENOMEM;
+		goto node_out;
+	}
+
 	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
 				   "weighted_interleave");
 	if (err) {
-		kfree(wi_kobj);
-		return err;
+		kobject_put(wi_kobj);
+		goto err_out;
 	}
 
 	for_each_node_state(nid, N_POSSIBLE) {
@@ -3512,9 +3521,17 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 			break;
 		}
 	}
-	if (err)
+	if (err) {
 		kobject_put(wi_kobj);
+		goto err_out;
+	}
+
 	return 0;
+
+node_out:
+	kfree(node_attrs);
+err_out:
+	return err;
 }
 
 static void mempolicy_kobj_release(struct kobject *kobj)
@@ -3528,7 +3545,6 @@ static void mempolicy_kobj_release(struct kobject *kobj)
 	mutex_unlock(&iw_table_lock);
 	synchronize_rcu();
 	kfree(old);
-	kfree(node_attrs);
 	kfree(kobj);
 }
 
@@ -3542,37 +3558,22 @@ static int __init mempolicy_sysfs_init(void)
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
+		goto err_out;
 
 	err = add_weighted_interleave_group(mempolicy_kobj);
-	if (err) {
-		pr_err("mempolicy sysfs structure failed to initialize\n");
-		kobject_put(mempolicy_kobj);
-		return err;
-	}
+	if (err)
+		goto err_out;
+
+	return 0;
 
-	return err;
-node_out:
-	kfree(node_attrs);
-mempol_out:
-	kfree(mempolicy_kobj);
 err_out:
-	pr_err("failed to add mempolicy kobject to the system\n");
+	kobject_put(mempolicy_kobj);
 	return err;
 }
 
-- 
2.34.1

