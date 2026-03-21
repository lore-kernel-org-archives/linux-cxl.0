Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3CB2DC332
	for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105453; cv=none; b=VzPEYMyycxRHbRZ9kSX5BuNiJACZ50nf+sTe1x/63Mzlbvl/5Qzy8Tz6EX1k+/FfnYaBUPB6yXpzrQTrBDdO4fP5xVG0vtmWVoeX+Id0E11zcsBGUV9WU1tF/4PQ2JMBGj7/fmtSVHLiRg24WE5fyxmOTCcKnKnl3u9NhnoNPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105453; c=relaxed/simple;
	bh=TQuW+OZpUZldWOSNfRy7f3RL4fU3SXCpUPS/DDnyruc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHNN0itdG0oNgBMcpF7A235fNy25ABhY5F/coPqeg5glec5CCvKq4mn+9Y2F3zaa4Y/DQUnKgYwSuzWbneHv8AqC2CysuFzYlLrG88OlN+XXZoin1pE8891QNibmY7HDGqTc1SrGQDfSYGzj80A0phfZJ+8y14zvr/FkCmTPZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WIVNG0h2; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WIVNG0h2"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-950b77942deso747648241.1
        for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774105450; x=1774710250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xO5G1TTTEFUzwGvqajKTysfZ/iiFkVbZDpQBQ6HidU=;
        b=WIVNG0h2ZeQzUPvRh2774vu4yZn07LydlNN93iXKvO232ZdcYkPvXYmTUJiPMnSHX9
         4JyCogb+fxUkSbU+dHPjh+d6bOvRt74STPFAEGg4Ez7QWHYwcJitKs/yf4oN4nzuJ4mF
         46Xe/gVjdQ0/OnBX9Hgfqwr8cTPAmn+yFcYyxogRnX/yTz6Y1OsVj5WyEN6ykUY9tlBn
         KOdO81IMC5qcW0PyAZDCinUdjN2FnNLQgllOHI5e4l3dDD2CARWQg4IkXhHR7jHZneaP
         8O/WS8dT+Q65DRR69Y9cpkYQzyskkWRtoRdORW5P6+8iS9uf77HtimFZ/fhTr9Nl/K6w
         irHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774105450; x=1774710250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xO5G1TTTEFUzwGvqajKTysfZ/iiFkVbZDpQBQ6HidU=;
        b=q9XqNQ4Fn8PxXbXi3+366/1r2GISaitqqiH4f/RHis33NO8N2V6xkR70xgCsVuKGOi
         Bu4oWhCDdGgDu2b7D+qk2zEwuQXHr68DgX40a1hIOPN9gCQMAd1i7HWEdgcTlUqu1g3h
         DBFNOFfg9Iq2ErhymUPOy7qJeNPGD1Fy7triNCSu4I1GuHdM+H2rhifv088uCZrA+PtL
         RjNCJcmcE+JIX9WzPUe2hdTuIMw7Ypp5IXR3OWeYZHwVr9+arRHoN4Ko2WHKlqpvSy1O
         9Fr97J7f+SDq5LwXvRF0SS2WWa6goDuByKMGIdKOS19kMWirxCkq26Oe/Re+k6L3gt5m
         IGcw==
X-Forwarded-Encrypted: i=1; AJvYcCVaWiKYUYc2acGviYhkNZ6cumes9dheaTq1tzANwhAl+Nl1BP3dyqyvcC7QNkcRUwIkeA+RQwFaKZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWv1Ee0Gqwu/ndZYl5TLTB1ItOxNhOOFZCwbYlSQGRx66aUFX
	RbnqHhoWH/wKUb+w4DRUOF3G2ryBQfxFlxV/LMcw6ek4J2QtazjxLUbv5WxQH4UAd/k=
X-Gm-Gg: ATEYQzxhZlWfJJKmkuyjTwkMX+4dL0jzJmwll3PZiSM/GrLFclCA5x08cGIJEJ+rb58
	xuOv5ysigODSHYEuNjatMBC/qw0Lx2b1OvBsK1Lttpg23aIiUmc89wmRqPyeMzUhIbeDmsDLfeN
	gqt56rNwWRgDQm+LziBfMSlvAGe4K/JPd0EDRMlcSVQ1fUOE61XKdxWQxf+O18LLPRNGo8MEdg5
	2d+8+nAuQL4sGBqWdrH6S0Iih9rRU2Qm/T+6cVMYCUBtZNO3SHjAHeOYVw/Qmhfo6lTPCU4/iV3
	lPtN9aYqfN4tfOa6e4ZxfaqgHhlrf5tIG86DoVOGJ3SwKm5+hX0h9GqiOSixpKEv3CyH1oPQ1kJ
	KI3aYsBbTeJBHI+6wY1/+5mLiA5Z/AszbKVflKN6vMMALMsOjFgGeWAx0V5/a3xXk3wm/nVhmWh
	iSqbKuiEX2vaQiGz6a7+dFrKK+ee3ul3I6JkO0eRxisH9TUBw5ZE7ykHEiDPnB2Mo35pOkhLP8J
	XtwM/Rl70U8DUg=
X-Received: by 2002:a05:6102:dd0:b0:601:f386:9ed2 with SMTP id ada2fe7eead31-602aea8d861mr2785184137.7.1774105450228;
        Sat, 21 Mar 2026 08:04:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90ba89fsm391979885a.40.2026.03.21.08.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:04:09 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	osalvador@suse.de
Cc: dan.j.williams@intel.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/8] mm/memory-tiers: consolidate memory type dedup into mt_get_memory_type()
Date: Sat, 21 Mar 2026 11:03:57 -0400
Message-ID: <20260321150404.3288786-2-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321150404.3288786-1-gourry@gourry.net>
References: <20260321150404.3288786-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace per-driver memory type list infrastructure with a single
mt_get_memory_type(adist) that deduplicates against the global
default_memory_types list under memory_tier_lock.

The per-driver lists (mutex + list_head + find/put wrappers) provided
dedup within a single driver, but not across drivers or with the core.
Since the number of distinct adist values is bounded and types on
default_memory_types are never freed anyway, the per-driver cleanup
on module unload was not useful.

Add MEMTIER_DEFAULT_LOWTIER_ADISTANCE to replace the default DAX
adistance, since it was really used as a standin for all kmem hotplugged
memory.  This at least makes the default tier relationship clearer to
other drivers and they can see where to put their memory in relation to
the default lower tier.

Core changes:
 - Add mt_get_memory_type() as the single exported entry point
 - Drop most other interfaces - clear_node_memory_type() is now the
   appropriate put function.
 - export MEMTIER_DEFAULT_LOWTIER_ADISTANCE

dax/kmem changes:
 - Remove MEMTIER_DEFAULT_DAX_ADISTANCE, use MEMTIER_DEFAULT_LOWTIER_ADISTANCE
 - Remove per-driver kmem_memory_type_lock/kmem_memory_types/wrappers
 - Store mtype per-device in dax_kmem_data
 - Pass data->mtype to clear_node_memory_type() instead of NULL

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c           | 32 +++++---------------------------
 include/linux/memory-tiers.h | 34 ++++++++++------------------------
 mm/memory-tiers.c            | 29 +++++++++++++----------------
 3 files changed, 28 insertions(+), 67 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 2cc8749bc871..eb693a581961 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -16,13 +16,6 @@
 #include "dax-private.h"
 #include "bus.h"
 
-/*
- * Default abstract distance assigned to the NUMA node onlined
- * by DAX/kmem if the low level platform driver didn't initialize
- * one for this NUMA node.
- */
-#define MEMTIER_DEFAULT_DAX_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 5)
-
 /* Memory resource name used for add_memory_driver_managed(). */
 static const char *kmem_name;
 /* Set if any memory will remain added when the driver will be unloaded. */
@@ -47,24 +40,10 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 struct dax_kmem_data {
 	const char *res_name;
 	int mgid;
+	struct memory_dev_type *mtype;
 	struct resource *res[];
 };
 
-static DEFINE_MUTEX(kmem_memory_type_lock);
-static LIST_HEAD(kmem_memory_types);
-
-static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
-{
-	guard(mutex)(&kmem_memory_type_lock);
-	return mt_find_alloc_memory_type(adist, &kmem_memory_types);
-}
-
-static void kmem_put_memory_types(void)
-{
-	guard(mutex)(&kmem_memory_type_lock);
-	mt_put_memory_types(&kmem_memory_types);
-}
-
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
@@ -74,7 +53,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	int i, rc, mapped = 0;
 	mhp_t mhp_flags;
 	int numa_node;
-	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
+	int adist = MEMTIER_DEFAULT_LOWTIER_ADISTANCE;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -90,7 +69,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	}
 
 	mt_calc_adistance(numa_node, &adist);
-	mtype = kmem_find_alloc_memory_type(adist);
+	mtype = mt_get_memory_type(adist);
 	if (IS_ERR(mtype))
 		return PTR_ERR(mtype);
 
@@ -189,6 +168,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		}
 		mapped++;
 	}
+	data->mtype = mtype;
 
 	dev_set_drvdata(dev, data);
 
@@ -253,7 +233,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 		 * for that. This implies this reference will be around
 		 * till next reboot.
 		 */
-		clear_node_memory_type(node, NULL);
+		clear_node_memory_type(node, data->mtype);
 	}
 }
 #else
@@ -292,7 +272,6 @@ static int __init dax_kmem_init(void)
 	return rc;
 
 error_dax_driver:
-	kmem_put_memory_types();
 	kfree_const(kmem_name);
 	return rc;
 }
@@ -302,7 +281,6 @@ static void __exit dax_kmem_exit(void)
 	dax_driver_unregister(&device_dax_kmem_driver);
 	if (!any_hotremove_failed)
 		kfree_const(kmem_name);
-	kmem_put_memory_types();
 }
 
 MODULE_AUTHOR("Intel Corporation");
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 96987d9d95a8..70fbd3ad577f 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -20,11 +20,17 @@
  */
 #define MEMTIER_ADISTANCE_DRAM	((4L * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
 
+/*
+ * Default abstract distance assigned to non-DRAM memory if the platform
+ * driver didn't initialize one for this NUMA node.
+ */
+#define MEMTIER_DEFAULT_LOWTIER_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 5)
+
 struct memory_tier;
 struct memory_dev_type {
 	/* list of memory types that are part of same tier as this type */
 	struct list_head tier_sibling;
-	/* list of memory types that are managed by one driver */
+	/* memory types on global list */
 	struct list_head list;
 	/* abstract distance for this specific memory type */
 	int adistance;
@@ -39,8 +45,6 @@ struct access_coordinate;
 extern bool numa_demotion_enabled;
 extern struct memory_dev_type *default_dram_type;
 extern nodemask_t default_dram_nodes;
-struct memory_dev_type *alloc_memory_type(int adistance);
-void put_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype);
 int register_mt_adistance_algorithm(struct notifier_block *nb);
@@ -49,9 +53,7 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
-struct memory_dev_type *mt_find_alloc_memory_type(int adist,
-						  struct list_head *memory_types);
-void mt_put_memory_types(struct list_head *memory_types);
+struct memory_dev_type *mt_get_memory_type(int adist);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node, const nodemask_t *allowed_mask);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -78,18 +80,6 @@ static inline bool node_is_toptier(int node)
 #define numa_demotion_enabled	false
 #define default_dram_type	NULL
 #define default_dram_nodes	NODE_MASK_NONE
-/*
- * CONFIG_NUMA implementation returns non NULL error.
- */
-static inline struct memory_dev_type *alloc_memory_type(int adistance)
-{
-	return NULL;
-}
-
-static inline void put_memory_type(struct memory_dev_type *memtype)
-{
-
-}
 
 static inline void init_node_memory_type(int node, struct memory_dev_type *default_type)
 {
@@ -142,14 +132,10 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
 	return -EIO;
 }
 
-static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
-								struct list_head *memory_types)
+static inline struct memory_dev_type *mt_get_memory_type(int adist)
 {
 	return NULL;
 }
-
-static inline void mt_put_memory_types(struct list_head *memory_types)
-{
-}
 #endif	/* CONFIG_NUMA */
+
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 986f809376eb..c8f032a75249 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -38,14 +38,17 @@ struct node_memory_type_map {
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
 /*
- * The list is used to store all memory types that are not created
- * by a device driver.
+ * The list is used to store all memory types, both auto-initialized
+ * and driver-requested.  Drivers obtain types via mt_get_memory_type().
  */
 static LIST_HEAD(default_memory_types);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
 nodemask_t default_dram_nodes __initdata = NODE_MASK_NONE;
 
+static struct memory_dev_type *mt_find_alloc_memory_type(int adist,
+							 struct list_head *memory_types);
+
 static const struct bus_type memory_tier_subsys = {
 	.name = "memory_tiering",
 	.dev_name = "memory_tier",
@@ -621,7 +624,7 @@ static void release_memtype(struct kref *kref)
 	kfree(memtype);
 }
 
-struct memory_dev_type *alloc_memory_type(int adistance)
+static struct memory_dev_type *alloc_memory_type(int adistance)
 {
 	struct memory_dev_type *memtype;
 
@@ -635,13 +638,11 @@ struct memory_dev_type *alloc_memory_type(int adistance)
 	kref_init(&memtype->kref);
 	return memtype;
 }
-EXPORT_SYMBOL_GPL(alloc_memory_type);
 
-void put_memory_type(struct memory_dev_type *memtype)
+static void put_memory_type(struct memory_dev_type *memtype)
 {
 	kref_put(&memtype->kref, release_memtype);
 }
-EXPORT_SYMBOL_GPL(put_memory_type);
 
 void init_node_memory_type(int node, struct memory_dev_type *memtype)
 {
@@ -670,7 +671,8 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
-struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
+static struct memory_dev_type *mt_find_alloc_memory_type(int adist,
+							 struct list_head *memory_types)
 {
 	struct memory_dev_type *mtype;
 
@@ -686,18 +688,13 @@ struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *m
 
 	return mtype;
 }
-EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
 
-void mt_put_memory_types(struct list_head *memory_types)
+struct memory_dev_type *mt_get_memory_type(int adist)
 {
-	struct memory_dev_type *mtype, *mtn;
-
-	list_for_each_entry_safe(mtype, mtn, memory_types, list) {
-		list_del(&mtype->list);
-		put_memory_type(mtype);
-	}
+	guard(mutex)(&memory_tier_lock);
+	return mt_find_alloc_memory_type(adist, &default_memory_types);
 }
-EXPORT_SYMBOL_GPL(mt_put_memory_types);
+EXPORT_SYMBOL_GPL(mt_get_memory_type);
 
 /*
  * This is invoked via `late_initcall()` to initialize memory tiers for
-- 
2.53.0

