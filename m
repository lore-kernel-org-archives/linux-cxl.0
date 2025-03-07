Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0F419D8BC;
	Fri,  7 Mar 2025 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329356; cv=none; b=HbA1dC4tmOO8aB8dVmf0wFzX+iDw2twL33i4saVy2aeS9W5s/Rd/Hbqjk8bC03XtZWHXrR0fW41Cv8OYm0+RRE7V/3QVeNvz4tkuesQqmF8KUJXB4ZN1yE5WGw5VZLoAo+wSOO00/pjzAGfqcSRdfpbEotrTc3ypAuC3tukEvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329356; c=relaxed/simple;
	bh=9mGTNw5W3ZU/i2b6EIbAY3B0KwvWlf8KtVOLtypevLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKnOwMzvX9C/b4ESTIknBOQPAKQOor5nYYN85g4ZNS7GXWpX9jMBp2YclMNe8zNj5dbDJdSQOLjRx0vHk8sYH8Lx5P0V20rovceJHGpRQG7OU6ttxedyH1YAJbOb7y46B9F0NdtP0gty6fiKf4Q8S1K0ION/H0yFYCG2U3qdrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-7a-67ca93c2fd8a
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
Subject: [PATCH 1/4] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Fri,  7 Mar 2025 15:35:30 +0900
Message-ID: <20250307063534.540-2-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250307063534.540-1-rakie.kim@sk.com>
References: <20250307063534.540-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnke6hyafSDX5NF7aYs34Nm8X0qRcY
	LX7ePc5ucXzrPHaL87NOsVhc3jWHzeLemv+sFqvXZDhweOycdZfdo7vtMrvH4j0vmTw2fZrE
	7nFixm8Wj50PLT0+b5ILYI/isklJzcksSy3St0vgymhfO5ul4LJkxZ/ZzSwNjK9Fuhg5OSQE
	TCQ+felihbGfnL8LZHNwsAkoSRzbGwMSFhEQlZh3dDZLFyMXB7PAYiaJhYfXM4HUCAsESDw6
	qQVSwyKgKrHg1X5GEJtXwFhi5d9tzBAjNSUaLt1jArE5gcYfX/WIEaRVCKjm765SiHJBiZMz
	n7CA2MwC8hLNW2czg6ySEDjDJrH49g52iDmSEgdX3GCZwMg/C0nPLCQ9CxiZVjEKZeaV5SZm
	5pjoZVTmZVboJefnbmIEBvGy2j/ROxg/XQg+xCjAwajEw+sx9WS6EGtiWXFl7iFGCQ5mJRFe
	wc1AId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYz5a0MX
	Tkoq9H9o1Lom/0+lRgnjPRPL36/WLFxeJ9kh8odf2W7pYRXlAk0/Q/P4ZIknIYJrV/uffdxY
	cyRSlunBwvr83VfuXS/x3BMVPrP4qrCmzPbU5oUNGUcNBFZ1rz6uwnVbRmy5QlaQtMjnLckN
	r2XbQoVCds7pfHpx5QNv/ZeXi0oKKpRYijMSDbWYi4oTARf6rPteAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXCNUNNS/fQ5FPpBs+ucVnMWb+GzWL61AuM
	Fj/vHme3+PzsNbPF8a3z2C0Ozz3JanF+1ikWi8u75rBZ3Fvzn9Xi0LXnrBar12RY/N62gs2B
	x2PnrLvsHt1tl9k9Fu95yeSx6dMkdo8TM36zeOx8aOnx7baHx+IXH5g8Pm+SC+CM4rJJSc3J
	LEst0rdL4MpoXzubpeCyZMWf2c0sDYyvRboYOTkkBEwknpy/y9rFyMHBJqAkcWxvDEhYREBU
	Yt7R2SxdjFwczAKLmSQWHl7PBFIjLBAg8eikFkgNi4CqxIJX+xlBbF4BY4mVf7cxQ4zUlGi4
	dI8JxOYEGn981SNGkFYhoJq/u0ohygUlTs58wgJiMwvISzRvnc08gZFnFpLULCSpBYxMqxhF
	MvPKchMzc0z1irMzKvMyK/SS83M3MQIDd1ntn4k7GL9cdj/EKMDBqMTD6zH1ZLoQa2JZcWXu
	IUYJDmYlEV7BzUAh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYO
	TqkGxgnfEw6mVF0XSp5+wOhMb9hUbffv1zXfC0psWuZ74dS/jnM+GZzHk970s/HUm/+5ea7y
	7/LWisKUaxpGvTaiZv82l+mENem7vP615FL5weWWfKHWrD02/9w1vs+b//gC5/vlxyKmrDX/
	umfeiV1MT59VS2WfPy37T81BNsDm+88HOT07E+VWflViKc5INNRiLipOBADHSCavWAIAAA==
X-CFilter-Loop: Reflected

The weighted interleave policy distributes page allocations across multiple
NUMA nodes based on their performance weight, thereby optimizing memory
bandwidth utilization. The weight values for each node are configured
through sysfs.

Previously, the sysfs entries for configuring weighted interleave were only
created during initialization. This approach had several limitations:
- Sysfs entries were generated for all possible nodes at boot time,
  including nodes without memory, leading to unnecessary sysfs creation.
- Some memory devices transition to an online state after initialization,
  but the existing implementation failed to create sysfs entries for
  these dynamically added nodes. As a result, memory hotplugged nodes
  were not properly recognized by the weighed interleave mechanism.

To resolve these issues, this patch introduces two key improvements:
1) At initialization, only nodes that are online and have memory are
   recognized, preventing the creation of unnecessary sysfs entries.
2) Nodes that become available after initialization are dynamically
   detected and integrated through the memory hotplug mechanism.

With this enhancement, the weighted interleave policy now properly supports
memory hotplug, ensuring that newly added nodes are recognized and sysfs
entries are created accordingly.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 mm/mempolicy.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bbaadbeeb291..385607179ebd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -113,6 +113,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <linux/uaccess.h>
+#include <linux/memory.h>
 
 #include "internal.h"
 
@@ -3489,9 +3490,35 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
 	return 0;
 }
 
+struct kobject *wi_kobj;
+
+static int wi_node_notifier(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	int err;
+	struct memory_notify *arg = data;
+	int nid = arg->status_change_nid;
+
+	if (nid < 0)
+		goto notifier_end;
+
+	switch(action) {
+	case MEM_ONLINE:
+		err = add_weight_node(nid, wi_kobj);
+		if (err) {
+			pr_err("failed to add sysfs [node%d]\n", nid);
+			kobject_put(wi_kobj);
+			return NOTIFY_BAD;
+		}
+		break;
+	}
+
+notifier_end:
+	return NOTIFY_OK;
+}
+
 static int add_weighted_interleave_group(struct kobject *root_kobj)
 {
-	struct kobject *wi_kobj;
 	int nid, err;
 
 	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
@@ -3505,16 +3532,23 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 		return err;
 	}
 
-	for_each_node_state(nid, N_POSSIBLE) {
+	for_each_online_node(nid) {
+		if (!node_state(nid, N_MEMORY))
+			continue;
+
 		err = add_weight_node(nid, wi_kobj);
 		if (err) {
 			pr_err("failed to add sysfs [node%d]\n", nid);
-			break;
+			goto err_out;
 		}
 	}
-	if (err)
-		kobject_put(wi_kobj);
+
+	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
 	return 0;
+
+err_out:
+	kobject_put(wi_kobj);
+	return err;
 }
 
 static void mempolicy_kobj_release(struct kobject *kobj)
-- 
2.34.1

