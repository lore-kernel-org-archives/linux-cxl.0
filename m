Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA61EBFE4;
	Tue,  1 Apr 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498642; cv=none; b=a7bCjM8wEZLNS2L0NsVkgNcbulpNNIlZtpvxnqciMP71KafX0eKdOIL7lFQslhmWdImIygcuIfPQn7TWnX0D7tA0DoiFvLD9UdDIBVVakozJsg3Y1QFXyTof6iHcnU5mzLSbFSamtisu4LdzH11jNcTy9rop2l4b8Fw1+JHYzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498642; c=relaxed/simple;
	bh=ev88QDfI70wGQFqzTDVwN6Lpb4hXA5Cj9+UKl3RwI9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwiYQnW9p9VkhxOb86afCU1mkhfOuVVz2cKixfOEKujMBNayZd83+n56wlLb0LJ6Pj6IMzYaAgK82t9Qsfuavc4Utz5iZ5i4OINyrdl1dROJEdaaErrcQiUiN6nUUKDAnj9l6vCqwe2s2CGBY/xgoVsNFqFMytfi33GNGrUJS1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-33-67ebad88ce4b
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
Subject: [PATCH v4 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Tue,  1 Apr 2025 18:08:57 +0900
Message-ID: <20250401090901.1050-2-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250401090901.1050-1-rakie.kim@sk.com>
References: <20250401090901.1050-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXC9ZZnkW7n2tfpBquPMlnMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK2Pe
	kkdMBWdkKk5NOMbYwDhDvIuRk0NCwERi1fZjbDD2+0vXWLsYOTjYBJQkju2NAQmLCIhKzDs6
	m6WLkYuDWeAak8SBzzdZQBLCAsESx261sYLYLAKqEp9+TGEGsXmB5vS87WKBmKkp0XDpHhOI
	zSlgKrH/6TFGEFsIqObR7TMsEPWCEidnPgGzmQXkJZq3zmYGWSYh8JpN4si008wQgyQlDq64
	wTKBkX8Wkp5ZSHoWMDKtYhTKzCvLTczMMdHLqMzLrNBLzs/dxAgM+GW1f6J3MH66EHyIUYCD
	UYmHd0Ppq3Qh1sSy4srcQ4wSHMxKIrwRX1+mC/GmJFZWpRblxxeV5qQWH2KU5mBREuc1+lae
	IiSQnliSmp2aWpBaBJNl4uCUamCc1HZh+u7uP0pmJTPajrWerHDdl/2veMYHcSaH3Oo3dgcO
	n7xVwpqerH9VViXOROG257k500uyV7jUCWk3ru4PuhBherhqX+TTn6Zpj6380u1dFafwx9bN
	cu430zjn5bujb6Lan49PLhXmz/wRyB1yW07JVOVOlRaPwrRfVezMov1nHh/84q7EUpyRaKjF
	XFScCADnxJsRdAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNNS7dj7et0g7Z3phZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLQ5de85q
	sXpNhsXvbSvYHPg8ds66y+7R3XaZ3aPlyFtWj8V7XjJ5bPo0id3jxIzfLB47H1p6vN93lc3j
	220Pj8UvPjB5fN4kF8AdxWWTkpqTWZZapG+XwJUxb8kjpoIzMhWnJhxjbGCcId7FyMkhIWAi
	8f7SNdYuRg4ONgEliWN7Y0DCIgKiEvOOzmbpYuTiYBa4xiRx4PNNFpCEsECwxLFbbawgNouA
	qsSnH1OYQWxeoDk9b7tYIGZqSjRcuscEYnMKmErsf3qMEcQWAqp5dPsMC0S9oMTJmU/AbGYB
	eYnmrbOZJzDyzEKSmoUktYCRaRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgkC+r/TNxB+OX
	y+6HGAU4GJV4eDeUvkoXYk0sK67MPcQowcGsJMIb8fVluhBvSmJlVWpRfnxRaU5q8SFGaQ4W
	JXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAOjvWp0k1ftq6J3C5mdG98Kl/1knBXCEBBQumRP
	Vr3rtQezTlyQ4HI1TnDP32V2Y219ucThj88TExz//jW/EGJZfFdzk/BCNqblEum/whS/pX99
	9zl++/1F1679ymVzifzZtfSt/Qljz9UzT4XuDFjbvDMtI1X3+98DnqdZ/28RCLlokHr5hX21
	EktxRqKhFnNRcSIAxk+6MW4CAAA=
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

