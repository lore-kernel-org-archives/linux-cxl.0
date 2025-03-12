Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1822DFBB;
	Wed, 12 Mar 2025 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766206; cv=none; b=kirKzFoh84X6dSa3UL05Q1Zzi/kkUSfTi+7hwqm3SuTz8c5h5nvV+mH6IZo7CXWVqsyGmA3lxWRARUIR+fkRBGLVElFVTWF20nTbC2VatZvW/w1xguXkrRScTo2AI4fG1lMwcu86rHhE6a6BpYOgqIgODlD5FcNYMWbrdtXZR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766206; c=relaxed/simple;
	bh=dCE/P16YkVl+KIUZa+MHrNEuJMA21cffbL94Jk48VuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVRujRt/+EhoeTzSQU3kzi/+ln/+Vtovk+rmGmrDtsIT246lQdrDEs6m9eNk/hkatwVDYqfm6yqaLvV5k9tZ7/s6iBVymbH9wNW1JNyraufoaXUvkgnY4xMYUM+Q+h3XJzK4lriWwmmBkOiirLAUButax7QN+42IBnp6Yhf1MjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-02-67d13e357e71
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
Subject: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in mempolicy_sysfs_init()
Date: Wed, 12 Mar 2025 16:56:24 +0900
Message-ID: <20250312075628.648-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsXC9ZZnka6p3cV0g9U9whZz1q9hs5g+9QKj
	xc+7x9ktjm+dx25xftYpFovLu+awWdxb85/VYvWaDAcOj52z7rJ7dLddZvdYvOclk8emT5PY
	PU7M+M3isfOhpcfnTXIB7FFcNimpOZllqUX6dglcGXfftTAWdAlUrD3/kKWBsZO3i5GTQ0LA
	ROLFtE5WGHva/g0sXYwcHGwCShLH9saAhEUERCXmHZ0NFObiYBZYzCSx8PB6JpCEsECAxPpj
	c9hBbBYBVYlbnY1gc3gFjCVmb5oGNVNTouHSPSaIuKDEyZlPWEBsZgF5ieats5lBhkoIbGCT
	aHp/gQmiQVLi4IobLBMYeWch6ZmFpGcBI9MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMDAXFb7
	J3oH46cLwYcYBTgYlXh4BXIupAuxJpYVV+YeYpTgYFYS4V1tCxTiTUmsrEotyo8vKs1JLT7E
	KM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAGL90z40VmxN38xQvPfuX6dG2H0kvlH4e
	4j9x86+NynXuicmGB9y57Is1ntr5lYo57m6I7Qq3L2/0lllwbdeGevZdzefbHhjEb0q9deK0
	PvsHgwNfuhvTvB48PhZ8dl758XsRfdf7tFNyPZvKvURXXPsrcMvxlIW7Azfnf+sID7U5uxg+
	sprfV2Ipzkg01GIuKk4EAN4JA+VIAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsXCNUNNS9fU7mK6waVnLBZz1q9hs5g+9QKj
	xc+7x9ktPj97zWxxfOs8dovDc0+yWpyfdYrF4vKuOWwW99b8Z7U4dO05q8XqNRkWv7etYHPg
	8dg56y67R3fbZXaPxXteMnls+jSJ3ePEjN8sHjsfWnp8u+3hsfjFByaPz5vkAjijuGxSUnMy
	y1KL9O0SuDLuvmthLOgSqFh7/iFLA2MnbxcjJ4eEgInEtP0bWLoYOTjYBJQkju2NAQmLCIhK
	zDs6GyjMxcEssJhJYuHh9UwgCWGBAIn1x+awg9gsAqoStzobWUFsXgFjidmbprFCzNSUaLh0
	jwkiLihxcuYTFhCbWUBeonnrbOYJjFyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZec
	n7uJERiMy2r/TNzB+OWy+yFGAQ5GJR7eA6oX0oVYE8uKK3MPMUpwMCuJ8K62BQrxpiRWVqUW
	5ccXleakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwbtFMz9984bPo7zipBRkX
	e+pEwkICP/92f7Hu5OubZhl9X4wfyWu/PB0wOfK/0cSbCarFsxUi5ZjfcGdZ+n5NWa89Q9ii
	i9Py75y3TIWra07etWI3VdArSNbolmeIzTIW5WGLMJz0o1a6s9NMLvbvKjextQ+E7Rfsmr/e
	eE1HzH6Nk1PYe4WVWIozEg21mIuKEwEOm2ZYQgIAAA==
X-CFilter-Loop: Reflected

Improper cleanup of sysfs attributes caused kobject and memory leaks when
initialization failed or nodes were removed.

This patch ensures proper deallocation of kobjects and memory, preventing
resource leaks and improving stability.

Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 mm/mempolicy.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bbaadbeeb291..1691748badb2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3541,39 +3541,40 @@ static int __init mempolicy_sysfs_init(void)
 	int err;
 	static struct kobject *mempolicy_kobj;
 
-	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
-	if (!mempolicy_kobj) {
+	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
+			     GFP_KERNEL);
+	if (!node_attrs) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
-	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
-			     GFP_KERNEL);
-	if (!node_attrs) {
+	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
+	if (!mempolicy_kobj) {
 		err = -ENOMEM;
-		goto mempol_out;
+		goto node_out;
 	}
 
 	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
 				   "mempolicy");
-	if (err)
-		goto node_out;
+	if (err) {
+		kobject_put(mempolicy_kobj);
+		goto err_out;
+	}
 
 	err = add_weighted_interleave_group(mempolicy_kobj);
 	if (err) {
-		pr_err("mempolicy sysfs structure failed to initialize\n");
 		kobject_put(mempolicy_kobj);
-		return err;
+		goto err_out;
 	}
 
-	return err;
+	return 0;
+
 node_out:
 	kfree(node_attrs);
-mempol_out:
-	kfree(mempolicy_kobj);
 err_out:
-	pr_err("failed to add mempolicy kobject to the system\n");
+	pr_err("mempolicy sysfs structure failed to initialize\n");
 	return err;
+
 }
 
 late_initcall(mempolicy_sysfs_init);

base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.34.1

