Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815EC33A9D1;
	Mon, 16 Mar 2026 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773637999; cv=none; b=mx2BJzd6XPFftztAxKVOA8WSJz87nOpFAoJztk0ZeZRpBxf2ivH0z7Lt2/jndWujzABddLgglHEE5WCoXe0QqbgEToRN/nDFrqZ61codEnlekzf6v/1Tj8RLJibFSxN8JwZczy1MOdKIpvsUal5WODAeDxtuxP93eHTdF35/Ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773637999; c=relaxed/simple;
	bh=yPPh7Rw6b55+IuHsJDVV9cU82/LoRnBv0sChcuOch68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kp5dFuspgxGblxS1GrZMt8uSxSOZqfI9bDDAxYN8pvoPzQTWx96528TMCIJ6NJ+Hu5bfpudyKxU5oy6ZeRqYeA2jfBshK+qtYEqINPAOfm3Mn+HT4wK/B+VwCVG8btWLRz3JjdVdph0+ykGWEsIrSMLAzw653JknZAyu/nLdC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-4d-69b791687819
From: Rakie Kim <rakie.kim@sk.com>
To: akpm@linux-foundation.org
Cc: gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [RFC PATCH 3/4] mm/memory-tiers: register CXL nodes to socket-aware packages via initiator
Date: Mon, 16 Mar 2026 14:12:51 +0900
Message-ID: <20260316051258.246-4-rakie.kim@sk.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260316051258.246-1-rakie.kim@sk.com>
References: <20260316051258.246-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsXC9ZZnkW7GxO2ZBk+PSVnMWb+GzeLu4wts
	FrtuhFhMn3qB0eLEzUY2i9U31zBaPN/6i9Hi593j7Bb7nz5nsVi18BqbxfGt89gttjc8YLc4
	P+sUi8XlXXPYLO6t+c9qcXLWShaLb33SFvf7HCyOrN/OZDH50gI2i9mNfYwWtyYcY7JYvSbD
	YvbRe+wOEh47Z91l91iwqdSju+0yu0fLkbesHov3vGTy2LSqk81j06dJ7B4nZvxm8dj50NKj
	t/kdm8fHp7dYPKbOrvdYv+Uqi8eZBUfYPT5vkgvgj+KySUnNySxLLdK3S+DK+HfhJ2PBDcWK
	tfcesTcwtsh0MXJySAiYSHyYcZG1i5EDzF74QRPEZBNQkji2NwakQkRAVmLq3/MsXYxcHMwC
	K1klzp/8zQySEBZIljj4YyMriM0ioCqx/mgjWJxXwFii78g5RojxmhLrNt5iAZnJCTR+2wJj
	kLAQUMm8Jx/YIcoFJU7OfAJWwiygLrF+nhBImFlAXqJ562xmkLUSAo0cEmfmP2SDGCkpcXDF
	DZYJjAKzkLTPQmifhaR9ASPzKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAuF5W+yd6B+OnC8GH
	GAU4GJV4eDMObcsUYk0sK67MPcQowcGsJMK77AhQiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/R
	t/IUIYH0xJLU7NTUgtQimCwTB6dUA2NPRP/DZ6uv3WQpbk67ZzWX8avfDSvX3RyZ504/mXs3
	LDqlOttAn4WZpeLkS2VLve5Vm5XjOjWFX/paMVyt3xKd8So4f+UKtqdyjvvio6f907i0zz/o
	Y0yZYE4nr2ri4jsbbjD7VEi9tJ9TlNqc9CHvCIeQyC7HDKmX7RoSthP2qr9KVb64WImlOCPR
	UIu5qDgRAH3R3NDnAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYQCG+XbOzjmuFmfL8KDZZV3MKE0s+CIpicKP6IeQIIihSw9uualt
	ahpIEyVMa2kl6WY2sSSnbTjSqZXWnJeZOEkcajkzNbvjDcu0bDMi/70878P756UwoR33pqRJ
	qawiSSwTETycV+IXvV9SZJYeaBrbAMuMtQQcGe8jYPNgBOy9rSXgneI+ALuGsglYM1QL4FT9
	TwAXRzpJOPf+MwZbJ6dwqK9wELCzvpyEbXdtXGhWvSWhXdONw/7mMgI6a1e40KapxuGC2geO
	qkOhxTHFhVajmQNvvdIRUJutBnC4sIMDa2olcKnhoQu1O8lQX9SkGSGRzpSGCq70kyjX+pWL
	Kp9+5CCT/iqBTLM3SdRVsoSjprHD6HrONwLNTA7jaOE1QpUfpjmoWHsZGR8P4KhHZyXDBVG8
	kHhWJk1nFYFHY3mS332LIGVwe8Yj5ztSBXI35wOKYuiDTMW0vzsStIjpeBadDzwoT9qXKf5l
	x/MBj8Loai5jty1h7mIjHce8+FHHdWec3sUY27NXOZ8OZtTWXuDODO3PGOqGcfemh2u+QRfs
	xkKXUj4xTf7VBYytdGJVwWg/xlgudGOM3srk1GuxQsDXrLE0/y3NGksHMD3wlCaly8VS2aEA
	ZaIkM0maERCXLDcB181VWctFjWC+P8wCaAqI1vMllgapkCtOV2bKLYChMJEnv8rqQvx4ceYl
	VpEco0iTsUoL8KFwkRf/VCQbK6QTxKlsIsumsIp/LYfy8FYBr8CKPgM5PTECLWHHugVnI5df
	nh4VGO7PylucX0r5hvO2LQOqgrjMqLyorFRTzHPszE69gx12ptzbExLCDxo8ua/qeNuJTcvr
	gi+GXvh+bceTI+bxNDwhpK0mry4npnEm40G+800gijgX0Tq3wji2OW6U7p4X+BZ0tnzq6dGq
	w0W4UiIO2osplOI/Gka6rOICAAA=
X-CFilter-Loop: Reflected

CXL memory nodes appear without an explicit socket association.
Relying on plain NUMA distance does not convey which physical package
(CPU socket) they should belong to, which in turn makes locality-aware
placement ambiguous.

This change introduces a registration path that binds a CXL memory node
to a socket-aware "memory package" using an initiator CPU node. The
initiator is the CPU nid that best represents the host-side attachment
of the region (e.g., the CPU closest to the region’s target). By using
this nid to resolve the package, the CXL node is grouped with the CPUs
it actually services.

The flow is:
  - Determine an initiator CPU nid for the CXL region.
  - Register the CXL node with the package layer using that initiator.

This provides a deterministic and topology-consistent way to place CXL
nodes into the correct socket grouping, reducing the risk of inadvertent
cross-socket choices that distance alone cannot prevent.

Signed-off-by: Rakie Kim <rakie.kim@sk.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 drivers/dax/kmem.c        |  2 ++
 3 files changed, 49 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5bd1213737fa..2733e0d465cc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2570,6 +2570,47 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
 	return NOTIFY_STOP;
 }
 
+static int cxl_region_find_nearest_node(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled = NULL;
+	struct cxl_memdev *cxlmd = NULL;
+	int i, numa_node;
+
+	for (i = 0; i < p->nr_targets; i++) {
+		cxled = p->targets[i];
+		cxlmd = cxled_to_memdev(cxled);
+		numa_node = dev_to_node(&cxlmd->dev);
+		if (numa_node != NUMA_NO_NODE)
+			return numa_node;
+	}
+	return NUMA_NO_NODE;
+}
+
+static int cxl_region_add_package_node(struct notifier_block *nb,
+				       unsigned long dax_nid, void *data)
+{
+	int region_nid, nearest_nid, ret;
+	struct cxl_region *cxlr = container_of(nb, struct cxl_region, package_notifier);
+
+	region_nid = phys_to_target_node(cxlr->params.res->start);
+	if (region_nid != dax_nid)
+		return NOTIFY_DONE;
+
+	nearest_nid = cxl_region_find_nearest_node(cxlr);
+	if (nearest_nid == NUMA_NO_NODE)
+		return NOTIFY_DONE;
+
+	ret = mp_add_package_node_by_initiator(dax_nid, nearest_nid);
+	if (ret) {
+		dev_info(&cxlr->dev, "failed add package node (%lu), nearest_nid (%d)\n",
+			 dax_nid, nearest_nid);
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 /**
  * devm_cxl_add_region - Adds a region to a decoder
  * @cxlrd: root decoder
@@ -3788,6 +3829,7 @@ static void shutdown_notifiers(void *_cxlr)
 
 	unregister_node_notifier(&cxlr->node_notifier);
 	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
+	unregister_mp_package_notifier(&cxlr->package_notifier);
 }
 
 static void remove_debugfs(void *dentry)
@@ -3940,6 +3982,10 @@ static int cxl_region_probe(struct device *dev)
 	cxlr->adist_notifier.priority = 100;
 	register_mt_adistance_algorithm(&cxlr->adist_notifier);
 
+	cxlr->package_notifier.notifier_call = cxl_region_add_package_node;
+	cxlr->package_notifier.priority = 100;
+	register_mp_package_notifier(&cxlr->package_notifier);
+
 	rc = devm_add_action_or_reset(&cxlr->dev, shutdown_notifiers, cxlr);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..6b6653e31135 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -551,6 +551,7 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	struct notifier_block package_notifier;
 };
 
 struct cxl_nvdimm_bridge {
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..32ee66b82cd3 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -94,6 +94,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (IS_ERR(mtype))
 		return PTR_ERR(mtype);
 
+	mp_probe_package_id(numa_node);
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
-- 
2.34.1

