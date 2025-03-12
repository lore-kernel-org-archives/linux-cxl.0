Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFA1D88A6;
	Wed, 12 Mar 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766207; cv=none; b=uuVOBPoHnal9gXbVfhWVyoxP/f7K41BD3cZlb2cwAKgvMwlqVku5eGI94J350x1LJTBaQhb6xPBIJqByTHVReyKK3TiFClssMjDAHxg3qKwgTePMc8aJBmVAdqf+9/XLRH9xCelLvNUUovOHHjSKXBtNnwnWNEhy5Z4jA0I7s1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766207; c=relaxed/simple;
	bh=zxa+4t3KKRufqMEkn26taifZ51+A+Z4AB1xus6xf6TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hx5AB3mOdYWpk0JXhC8AYZJrvue781bq38/QC0zkd2eOyybMmQZiWHbK8VB0a0TAqun6N1itINjigWwewiVWCP4/JQTQM8L4j8LE6fw8m1ybldL/f/gxCQzDkFLxzXsg8pMRaeyx/F4Wfqa4MEFOmqbzy0k08OZYZ0cs16kdZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-09-67d13e371826
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
Subject: [PATCH v2 2/4] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Wed, 12 Mar 2025 16:56:25 +0900
Message-ID: <20250312075628.648-2-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC9ZZnka653cV0gxM3pC3mrF/DZjF96gVG
	i593j7NbHN86j93i/KxTLBaXd81hs7i35j+rxeo1GQ4cHjtn3WX36G67zO6xeM9LJo9Nnyax
	e5yY8ZvFY+dDS4/Pm+QC2KO4bFJSczLLUov07RK4Mk7t62EqWC1VMWXNfvYGxm2iXYycHBIC
	JhLzZs9ghbGv37zB1sXIwcEmoCRxbG8MSFhEQFRi3tHZLF2MXBzMAouZJBYeXs8EkhAWCJZ4
	c/E/mM0ioCqxovsZ2BxeAWOJqXMOMUPM1JRouHQPrIYTaP6Lz9fAbCGgmuXrpjNC1AtKnJz5
	hAXEZhaQl2jeOpsZZJmEwAk2iSXNa6EGSUocXHGDZQIj/ywkPbOQ9CxgZFrFKJSZV5abmJlj
	opdRmZdZoZecn7uJERjIy2r/RO9g/HQh+BCjAAejEg+vQM6FdCHWxLLiytxDjBIczEoivKtt
	gUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYJbrvZv5r
	j7Sez7DUR6rsezPb1fv5e6P47rMEFmz/ZPNxnt7KliXRC8JXXF+h2PQm2+LDHLOFEzoO91Z2
	/Y4pO21oHyp4JVP6oFqQnXtxz9cbZRVs0y4vYF4j0cy6+HzgnTKW/hpm2U3NP2VfM3/66JP8
	OCgpQaZR4YW+LPvfpvOxMzhy1O8osRRnJBpqMRcVJwIAscJsSGACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsXCNUNNS9fc7mK6wdEp3BZz1q9hs5g+9QKj
	xc+7x9ktPj97zWxxfOs8dovDc0+yWpyfdYrF4vKuOWwW99b8Z7U4dO05q8XqNRkWv7etYHPg
	8dg56y67R3fbZXaPxXteMnls+jSJ3ePEjN8sHjsfWnp8u+3hsfjFByaPz5vkAjijuGxSUnMy
	y1KL9O0SuDJO7ethKlgtVTFlzX72BsZtol2MnBwSAiYS12/eYOti5OBgE1CSOLY3BiQsIiAq
	Me/obJYuRi4OZoHFTBILD69nAkkICwRLvLn4H8xmEVCVWNH9jBXE5hUwlpg65xAzxExNiYZL
	98BqOIHmv/h8DcwWAqpZvm46I0S9oMTJmU9YQGxmAXmJ5q2zmScw8sxCkpqFJLWAkWkVo0hm
	XlluYmaOqV5xdkZlXmaFXnJ+7iZGYPAuq/0zcQfjl8vuhxgFOBiVeHgPqF5IF2JNLCuuzD3E
	KMHBrCTCu9oWKMSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp
	1cCYs0mwrrdw0aKNvbf6ZIMvtlov95w0TXbh4kamrwXrbjkveSkh8nae02TpyPrfrLuOHFC/
	sqLTxab304Hz9Xz/v6d3Hi3ws1u1ZGqYpLmkVuyZt2s0i97+P15upmZ9kjHJ2uKtk6kve8W/
	A2sT9Ce4Pe9l23E4tKExXm/64ZDuS5tFFLhfKnoqsRRnJBpqMRcVJwIAYzKyqloCAAA=
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
 mm/mempolicy.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1691748badb2..94efff89e0be 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -113,6 +113,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <linux/uaccess.h>
+#include <linux/memory.h>
 
 #include "internal.h"
 
@@ -3489,9 +3490,38 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
+	case MEM_OFFLINE:
+		sysfs_wi_node_release(node_attrs[nid], wi_kobj);
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
@@ -3505,16 +3535,23 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
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

