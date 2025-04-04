Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76200847B;
	Fri,  4 Apr 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743752809; cv=none; b=ROhyLMTGfhjq6pYHjBHBv5uvy7sFUqLPby/mYyuGMEjlqYxz5zRHsoeRZNi5anuhK7tiHDPOEg1OD7jHW1R/tHhFva+iTwcz3lzqtntNTu9n1Gm/hhQK+OYjBOKGsv1+EKwGdIkVvaTL630otsLK0cCSH/4TWLNmqClEBd8FJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743752809; c=relaxed/simple;
	bh=sYySw3ebV2rPRTM+5OKnTORtx8ZjzQN/s/eAyKcnWUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPrqhtkXuRyB0SiPx1ShcgbnQydkUZTG4zN1FgBeNCTt0yIWGdvz+uDMlRupVaGxf/mg/Pacx9l1ouhZ2VBBB3zZ0Qw9I5zP/4IX8qXkmvD127pxYaM4p7DuBgdDQzHeYoYA8olW4OBvkX/eSPb9mTi+yDYR1O6gUmJId/IzJww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ca-67ef8e5a4971
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
Subject: [PATCH v6 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Fri,  4 Apr 2025 16:46:19 +0900
Message-ID: <20250404074623.1179-2-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250404074623.1179-1-rakie.kim@sk.com>
References: <20250404074623.1179-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoW5U3/t0gzeLJC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGWcfTmIvOCZX0bPqCnsD41uJLkYODgkBE4ltP2W7GDnBzCWP2llAwmwCShLH9saA
	hEUEZCWm/j0PFObiYBZ4zCTx6PkLRpCEsECwxMQzW9lBbBYBVYnlr9rAbF6gOQ1LnjBDzNSU
	aLh0jwnE5hQwlfj98CSYLQRUs/rpEah6QYmTM5+wgNjMAvISzVtnM4MskxD4zCbxavZMJohB
	khIHV9xgmcDIPwtJzywkPQsYmVYxCmXmleUmZuaY6GVU5mVW6CXn525iBIb/sto/0TsYP10I
	PsQowMGoxMNrUfguXYg1say4MvcQowQHs5II792c9+lCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
	eY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGJfFpzHrlL/5XPjLg2FBttdtj8+in854z9resq7u
	yfO+Eyl2YjLXVx1+EDo1M61A8N6l399D5iszThAUuLKT8W5tkUOU7VbWw/tNmMx3Jtg5fOfU
	dj8q/8a82jt53eYm7k2Te3bqHb6bsnfVk/qphiIBXw8ZnDDf/+mcX2zFzgP67Fey3sq0rFZi
	Kc5INNRiLipOBACIZu2NewIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNSzeq7326wdP3XBZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBlnH05iLzgmV9Gz6gp7A+Nb
	iS5GTg4JAROJJY/aWboYOTjYBJQkju2NAQmLCMhKTP17HijMxcEs8JhJ4tHzF4wgCWGBYImJ
	Z7ayg9gsAqoSy1+1gdm8QHMaljxhhpipKdFw6R4TiM0pYCrx++FJMFsIqGb10yNQ9YISJ2c+
	YQGxmQXkJZq3zmaewMgzC0lqFpLUAkamVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIFBv6z2
	z8QdjF8uux9iFOBgVOLhtSh8ly7EmlhWXJl7iFGCg1lJhPduzvt0Id6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsYGz8fOkRFqhrbsZqyBjQHpwbcMOkMW
	fs+wM1iUfa7Wx/71+R92+8oKNq+dXvPEteHpkZZ9zxbsWRr9+I9FdaTBy6xfh/2PSkQd7W05
	defM1Tn5+z5Lpv0tWOL6K63kl9CJafclU7q2acmdeTv/xQ89l7nv5Ri2eZSXTSw8ZGRzVVD6
	cu7aKaFKLMUZiYZazEXFiQDHMuWxdgIAAA==
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
 mm/mempolicy.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bbaadbeeb291..af3753925573 100644
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
@@ -3512,9 +3521,18 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 			break;
 		}
 	}
-	if (err)
+	if (err) {
+		kobject_del(wi_kobj);
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
@@ -3528,7 +3546,6 @@ static void mempolicy_kobj_release(struct kobject *kobj)
 	mutex_unlock(&iw_table_lock);
 	synchronize_rcu();
 	kfree(old);
-	kfree(node_attrs);
 	kfree(kobj);
 }
 
@@ -3542,37 +3559,24 @@ static int __init mempolicy_sysfs_init(void)
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
+		goto err_del;
 
-	return err;
-node_out:
-	kfree(node_attrs);
-mempol_out:
-	kfree(mempolicy_kobj);
+	return 0;
+
+err_del:
+	kobject_del(mempolicy_kobj);
 err_out:
-	pr_err("failed to add mempolicy kobject to the system\n");
+	kobject_put(mempolicy_kobj);
 	return err;
 }
 
-- 
2.34.1

