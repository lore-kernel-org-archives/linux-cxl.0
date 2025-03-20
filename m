Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A8B26AF5;
	Thu, 20 Mar 2025 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742444310; cv=none; b=rhMFfVJ31jVu1mvJds4x7uPcWFYdWO5ZiWsLJV6fP3V1a+GmgEVl7MRSLSKt03YqiCUuuom/LVeTgIJ4Vvo/EkZhl6QuhPiM92WkVxL3j1/Hlx/tNMqC2Blyr2639gI1sti6Cb9JZq9uIm5/rrVkGhD5z3vzfJi6xplGRLS9ufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742444310; c=relaxed/simple;
	bh=omRFjI677DXrKz25HAQAntUmct9Jv09QAfbIdxrT2EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOMT7MfjLqlarWpirNqnzta2b/6Dr4Jk+RAdSJeHDpNbS9EQoqAuHnYfAFgmzvHmYWMhCjkpzKyxfW5V8fQ6mYx4bqg2Qz4cKiM3ksMgbyCWE/JFLwb7CzwNuOsnlYRBbZk1NCTWUdnUUIht0f1T/sILfIkGYqAqqM4+nNA9BHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-3c-67db9707c9b5
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
Subject: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Thu, 20 Mar 2025 13:17:46 +0900
Message-ID: <20250320041749.881-2-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250320041749.881-1-rakie.kim@sk.com>
References: <20250320041749.881-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXC9ZZnoS779NvpBi9PWlnMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK2Pb
	4wbGgo/SFb27WpkaGI+LdTFyckgImEhMWHWQEcZ+u28iexcjBwebgJLEsb0xIGERAVGJeUdn
	s3QxcnEwC1xjkjjw+SYLSEJYIFjix8LjbCA2i4CqxOyXp8DivALGEuvm3GeGmKkp0XDpHhOI
	zQk0f8rV+Wwg84WAat6e44UoF5Q4OfMJWCuzgLxE89bZzCC7JARes0nsfnSKFWKOpMTBFTdY
	JjDyz0LSMwtJzwJGplWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgeG+rPZP9A7GTxeCDzEKcDAq
	8fC+uHIrXYg1say4MvcQowQHs5IIr0jH7XQh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOE
	BNITS1KzU1MLUotgskwcnFINjDMZd32LztdzXGq/evN//bCULVuiv24tivkTLHinKO/wud9L
	WnJfiedcXX2Rs25bXx/Db78b1r8eLV5iEpRpacx51lFL9rt91zxDl01rIi+3qm96pn3xfVhm
	2osTfBs/tOQ43nvgYyTBmrFEwc+7a+Ylbjf2TZIrXDxrWu+u3HGnrfynusixJUosxRmJhlrM
	RcWJAAhuJmRzAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNNS5d9+u10gx1v9SzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWhy69pzV
	YvWaDIvf21awOfB57Jx1l92ju+0yu0fLkbesHov3vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH
	t9seHotffGDy+LxJLoA7issmJTUnsyy1SN8ugStj2+MGxoKP0hW9u1qZGhiPi3UxcnJICJhI
	vN03kb2LkYODTUBJ4tjeGJCwiICoxLyjs1m6GLk4mAWuMUkc+HyTBSQhLBAs8WPhcTYQm0VA
	VWL2y1NgcV4BY4l1c+4zQ8zUlGi4dI8JxOYEmj/l6nw2kPlCQDVvz/FClAtKnJz5BKyVWUBe
	onnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERjiy2r/TNzB+OWy
	+yFGAQ5GJR7eF1dupQuxJpYVV+YeYpTgYFYS4RXpuJ0uxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwLjHLqztw+xfDgo/PkWITHu4b8XHgseZyovv26S/
	qXm2RI67xeG27jObZaL+nRWPLujmb3X/nmi+rWvXy2SjR7KpfZ5Pnpq8PiC80/z3kSetPDcd
	lk51nTwvySGlfOlR1dtT3E32dH+4MmVZ3LRKs1M7Yie8u2dd6rokb8/co6Hp9X/m3zB+x9uj
	xFKckWioxVxUnAgARxErfG0CAAA=
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
 

base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
-- 
2.34.1

