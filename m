Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA12641EA
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101743; cv=none; b=kQhJ7jAGHTiSa8W0QeLx32EQsmUCv18QQBHHbrJVYqI5sWdD8HI9QqGemjjI9lcQ24Q3dmDk0iJvxEiRPq/6mdfXl4kYo3RpNFbRAGuErGPaK8j51qZfyrHqPBsWwlyxmDWZ+Gzmy7eHeItnf5z93dZpUwJsfyaHIyBgOPQmAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101743; c=relaxed/simple;
	bh=H2SUF0pIlSddpGg2AyUWT1OUXbH6DqIC5hYuj1voTks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxlfydoBOa0DVDeJFO4lFjv6JbH65FsOkjP8Q0u0LQ0TbciykcQcA+jgdzE0e8OrDvBiJVSnUDu9pTmZUJPFD+yUUnWGfwr37WjmLR3XY4tUuXvxwmB4OVcLpGSJlj/1BBLV8YwB78WNu4sd+GYcr2PT3x4VDgax6LKN7c/Om4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vaKKwyCW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3omQtDWM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OstABFl3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KjDnF2o5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vaKKwyCW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3omQtDWM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OstABFl3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KjDnF2o5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 719BA1F395;
	Tue,  8 Apr 2025 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744101738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRJIRa1nusEckmUT9EBTkRycb79M/nbC/V9st37VTJs=;
	b=vaKKwyCWmNRP3SalZqr1q/030/WDz2TCiKPv8SlnHE2GKCcpcWKnfXXQICKvtTnWs/2WHV
	AQX7LgRiTjbXqaJxMkmw00XngdC6V2e2Cnpj3SU4KDNngZ38HlSeEG0TW6ZKmS7d4ZugN8
	m/gvCvVcHDtQuTKnkrrEjemQh9zK/Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744101738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRJIRa1nusEckmUT9EBTkRycb79M/nbC/V9st37VTJs=;
	b=3omQtDWM/9f5HhTy72ygeGc5pKx//1Hc6NAW7A3KcFjPj2tKojAyJpSl4UsuXSVMYgYpIG
	h71GeuoCq6ahzJCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744101737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRJIRa1nusEckmUT9EBTkRycb79M/nbC/V9st37VTJs=;
	b=OstABFl3WVco/MvfHCQY+CuIJ5OEg+hazdrrs6OrXLmJoPmuQyaHAs27HrI0iz4+RYAj/j
	gLZLAbZqe5WeuZ7EGTX7HMTtqk4cjqugetYe1VdAFrhrjT/Nm7uXqDzGYeL3wYL7l9rMfS
	AleCFiNFOhTDYeyI9ceNvhpkiLTF+Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744101737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRJIRa1nusEckmUT9EBTkRycb79M/nbC/V9st37VTJs=;
	b=KjDnF2o5clbpOhry3V4r98AXIUAmyAvAZeMV8E9Owgbh+TFsCnySO/XqW4NGZbotJzb9Xu
	c1gjlZSZ+YBUwICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4D6A13691;
	Tue,  8 Apr 2025 08:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sEziNGjh9Gd6VgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 08 Apr 2025 08:42:16 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/3] mm,memory_hotplug: Implement numa node notifier
Date: Tue,  8 Apr 2025 10:41:52 +0200
Message-ID: <20250408084153.255762-3-osalvador@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408084153.255762-1-osalvador@suse.de>
References: <20250408084153.255762-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

There are at least five consumers of hotplug_memory_notifier that what they
really are interested in is whether any numa node changed its state, e.g: going
from being memory aware to becoming memoryless and vice versa.

Implement a specific notifier for numa nodes when their state gets changed,
and have those consumers that only care about numa node state changes use it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/numa/hmat.c  |   6 +-
 drivers/base/node.c       |  19 +++++++
 drivers/cxl/core/region.c |  14 ++---
 drivers/cxl/cxl.h         |   4 +-
 include/linux/memory.h    |  38 ++++++++++++-
 kernel/cgroup/cpuset.c    |   2 +-
 mm/memory-tiers.c         |   8 +--
 mm/memory_hotplug.c       | 117 +++++++++++++++++++++-----------------
 mm/slub.c                 |  13 ++---
 9 files changed, 144 insertions(+), 77 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index bfbb08b1e6af..d18f3efa2149 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -918,10 +918,10 @@ static int hmat_callback(struct notifier_block *self,
 			 unsigned long action, void *arg)
 {
 	struct memory_target *target;
-	struct memory_notify *mnb = arg;
+	struct node_notify *mnb = arg;
 	int pxm, nid = mnb->status_change_nid;
 
-	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+	if (nid == NUMA_NO_NODE || action != NODE_BECAME_MEM_AWARE)
 		return NOTIFY_OK;
 
 	pxm = node_to_pxm(nid);
@@ -1074,7 +1074,7 @@ static __init int hmat_init(void)
 	hmat_register_targets();
 
 	/* Keep the table and structures if the notifier may use them */
-	if (hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
+	if (hotplug_node_notifier(hmat_callback, HMAT_CALLBACK_PRI))
 		goto out_put;
 
 	if (!hmat_set_default_dram_perf())
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ea653fa3433..182c71dfb5b8 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -110,6 +110,25 @@ static const struct attribute_group *node_access_node_groups[] = {
 	NULL,
 };
 
+static BLOCKING_NOTIFIER_HEAD(node_chain);
+
+int register_node_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&node_chain, nb);
+}
+EXPORT_SYMBOL(register_node_notifier);
+
+void unregister_node_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&node_chain, nb);
+}
+EXPORT_SYMBOL(unregister_node_notifier);
+
+int node_notify(unsigned long val, void *v)
+{
+	return blocking_notifier_call_chain(&node_chain, val, v);
+}
+
 static void node_remove_accesses(struct node *node)
 {
 	struct node_access_nodes *c, *cnext;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e8d11a988fd9..7d187088f557 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2409,12 +2409,12 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 					  unsigned long action, void *arg)
 {
 	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
-					       memory_notifier);
-	struct memory_notify *mnb = arg;
+					       node_notifier);
+	struct node_notify *mnb = arg;
 	int nid = mnb->status_change_nid;
 	int region_nid;
 
-	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+	if (nid == NUMA_NO_NODE || action != NODE_BECAME_MEM_AWARE)
 		return NOTIFY_DONE;
 
 	/*
@@ -3388,7 +3388,7 @@ static void shutdown_notifiers(void *_cxlr)
 {
 	struct cxl_region *cxlr = _cxlr;
 
-	unregister_memory_notifier(&cxlr->memory_notifier);
+	unregister_node_notifier(&cxlr->node_notifier);
 	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
 }
 
@@ -3427,9 +3427,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
-	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
-	register_memory_notifier(&cxlr->memory_notifier);
+	cxlr->node_notifier.notifier_call = cxl_region_perf_attrs_callback;
+	cxlr->node_notifier.priority = CXL_CALLBACK_PRI;
+	register_node_notifier(&cxlr->node_notifier);
 
 	cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
 	cxlr->adist_notifier.priority = 100;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index bbbaa0d0a670..d4c9a499de7a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -532,7 +532,7 @@ struct cxl_region_params {
  * @flags: Region state flags
  * @params: active + config params for the region
  * @coord: QoS access coordinates for the region
- * @memory_notifier: notifier for setting the access coordinates to node
+ * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
  */
 struct cxl_region {
@@ -545,7 +545,7 @@ struct cxl_region {
 	unsigned long flags;
 	struct cxl_region_params params;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
-	struct notifier_block memory_notifier;
+	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
 };
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 12daa6ec7d09..a5b8068cf182 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -99,6 +99,14 @@ int set_memory_block_size_order(unsigned int order);
 #define	MEM_PREPARE_ONLINE	(1<<6)
 #define	MEM_FINISH_OFFLINE	(1<<7)
 
+/* These states are used for numa node notifiers */
+#define NODE_BECOMING_MEM_AWARE		(1<<0)
+#define NODE_BECAME_MEM_AWARE		(1<<1)
+#define NODE_BECOMING_MEMORYLESS	(1<<2)
+#define NODE_BECAME_MEMORYLESS		(1<<3)
+#define NODE_CANCEL_MEM_AWARE		(1<<4)
+#define NODE_CANCEL_MEMORYLESS		(1<<5)
+
 struct memory_notify {
 	/*
 	 * The altmap_start_pfn and altmap_nr_pages fields are designated for
@@ -109,7 +117,10 @@ struct memory_notify {
 	unsigned long altmap_nr_pages;
 	unsigned long start_pfn;
 	unsigned long nr_pages;
-	int status_change_nid_normal;
+	int status_change_nid;
+};
+
+struct node_notify {
 	int status_change_nid;
 };
 
@@ -149,15 +160,34 @@ static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
 {
 	return 0;
 }
+
+static inline int register_node_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline void unregister_node_notifier(struct notifier_block *nb)
+{
+}
+static inline int node_notify(unsigned long val, void *v)
+{
+	return 0;
+}
+static inline int hotplug_node_notifier(notifier_fn_t fn, int pri)
+{
+	return 0;
+}
 #else /* CONFIG_MEMORY_HOTPLUG */
 extern int register_memory_notifier(struct notifier_block *nb);
+extern int register_node_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
+extern void unregister_node_notifier(struct notifier_block *nb);
 int create_memory_block_devices(unsigned long start, unsigned long size,
 				struct vmem_altmap *altmap,
 				struct memory_group *group);
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
+extern int node_notify(unsigned long val, void *v);
 extern struct memory_block *find_memory_block(unsigned long section_nr);
 typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
@@ -177,6 +207,12 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 	register_memory_notifier(&fn##_mem_nb);			\
 })
 
+#define hotplug_node_notifier(fn, pri) ({		\
+	static __meminitdata struct notifier_block fn##_node_nb =\
+		{ .notifier_call = fn, .priority = pri };\
+	register_node_notifier(&fn##_node_nb);			\
+})
+
 #ifdef CONFIG_NUMA
 void memory_block_add_nid(struct memory_block *mem, int nid,
 			  enum meminit_context context);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 39c1fc643d77..3323cf2124bf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3938,7 +3938,7 @@ void __init cpuset_init_smp(void)
 	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
 	top_cpuset.effective_mems = node_states[N_MEMORY];
 
-	hotplug_memory_notifier(cpuset_track_online_nodes, CPUSET_CALLBACK_PRI);
+	hotplug_node_notifier(cpuset_track_online_nodes, CPUSET_CALLBACK_PRI);
 
 	cpuset_migrate_mm_wq = alloc_ordered_workqueue("cpuset_migrate_mm", 0);
 	BUG_ON(!cpuset_migrate_mm_wq);
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fc14fe53e9b7..dfe6c28c8352 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -872,7 +872,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 					      unsigned long action, void *_arg)
 {
 	struct memory_tier *memtier;
-	struct memory_notify *arg = _arg;
+	struct node_notify *arg = _arg;
 
 	/*
 	 * Only update the node migration order when a node is
@@ -882,13 +882,13 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 		return notifier_from_errno(0);
 
 	switch (action) {
-	case MEM_OFFLINE:
+	case NODE_BECAME_MEMORYLESS:
 		mutex_lock(&memory_tier_lock);
 		if (clear_node_memory_tier(arg->status_change_nid))
 			establish_demotion_targets();
 		mutex_unlock(&memory_tier_lock);
 		break;
-	case MEM_ONLINE:
+	case NODE_BECAME_MEM_AWARE:
 		mutex_lock(&memory_tier_lock);
 		memtier = set_node_memory_tier(arg->status_change_nid);
 		if (!IS_ERR(memtier))
@@ -929,7 +929,7 @@ static int __init memory_tier_init(void)
 	nodes_and(default_dram_nodes, node_states[N_MEMORY],
 		  node_states[N_CPU]);
 
-	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
+	hotplug_node_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
 	return 0;
 }
 subsys_initcall(memory_tier_init);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8305483de38b..84248f2e36f8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -701,24 +701,18 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 
 /* check which state of node_states will be changed when online memory */
 static void node_states_check_changes_online(unsigned long nr_pages,
-	struct zone *zone, struct memory_notify *arg)
+	struct zone *zone, struct node_notify *arg)
 {
 	int nid = zone_to_nid(zone);
 
 	arg->status_change_nid = NUMA_NO_NODE;
-	arg->status_change_nid_normal = NUMA_NO_NODE;
 
 	if (!node_state(nid, N_MEMORY))
 		arg->status_change_nid = nid;
-	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
-		arg->status_change_nid_normal = nid;
 }
 
-static void node_states_set_node(int node, struct memory_notify *arg)
+static void node_states_set_node(int node, struct node_notify *arg)
 {
-	if (arg->status_change_nid_normal >= 0)
-		node_set_state(node, N_NORMAL_MEMORY);
-
 	if (arg->status_change_nid >= 0)
 		node_set_state(node, N_MEMORY);
 }
@@ -1177,7 +1171,9 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	int need_zonelists_rebuild = 0;
 	const int nid = zone_to_nid(zone);
 	int ret;
-	struct memory_notify arg;
+	struct memory_notify mem_arg;
+	struct node_notify node_arg;
+	bool cancel_mem_notifier_on_err = false, cancel_node_notifier_on_err = false;
 
 	/*
 	 * {on,off}lining is constrained to full memory sections (or more
@@ -1194,11 +1190,22 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	/* associate pfn range with the zone */
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
 
-	arg.start_pfn = pfn;
-	arg.nr_pages = nr_pages;
-	node_states_check_changes_online(nr_pages, zone, &arg);
+	mem_arg.start_pfn = pfn;
+	mem_arg.nr_pages = nr_pages;
+	node_states_check_changes_online(nr_pages, zone, &node_arg);
+
+	if (node_arg.status_change_nid >= 0) {
+		/* Node is becoming memory aware. Notify consumers */
+		cancel_node_notifier_on_err = true;
+		ret = node_notify(NODE_BECOMING_MEM_AWARE, &node_arg);
+		ret = notifier_to_errno(ret);
+		if (ret)
+			goto failed_addition;
+	}
 
-	ret = memory_notify(MEM_GOING_ONLINE, &arg);
+	cancel_mem_notifier_on_err = true;
+	mem_arg.status_change_nid = node_arg.status_change_nid;
+	ret = memory_notify(MEM_GOING_ONLINE, &mem_arg);
 	ret = notifier_to_errno(ret);
 	if (ret)
 		goto failed_addition;
@@ -1224,7 +1231,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	online_pages_range(pfn, nr_pages);
 	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
-	node_states_set_node(nid, &arg);
+	node_states_set_node(nid, &node_arg);
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
 
@@ -1245,16 +1252,26 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	kswapd_run(nid);
 	kcompactd_run(nid);
 
+	if (node_arg.status_change_nid >= 0)
+		/*
+		 * Node went from memoryless to have memory. Notifiy interested
+		 * consumers
+		 */
+		node_notify(NODE_BECAME_MEM_AWARE, &node_arg);
+
 	writeback_set_ratelimit();
 
-	memory_notify(MEM_ONLINE, &arg);
+	memory_notify(MEM_ONLINE, &mem_arg);
 	return 0;
 
 failed_addition:
 	pr_debug("online_pages [mem %#010llx-%#010llx] failed\n",
 		 (unsigned long long) pfn << PAGE_SHIFT,
 		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
-	memory_notify(MEM_CANCEL_ONLINE, &arg);
+	if (cancel_mem_notifier_on_err)
+		memory_notify(MEM_CANCEL_ONLINE, &mem_arg);
+	if (cancel_node_notifier_on_err)
+		node_notify(NODE_CANCEL_MEM_AWARE, &node_arg);
 	remove_pfn_range_from_zone(zone, pfn, nr_pages);
 	return ret;
 }
@@ -1892,48 +1909,29 @@ early_param("movable_node", cmdline_parse_movable_node);
 
 /* check which state of node_states will be changed when offline memory */
 static void node_states_check_changes_offline(unsigned long nr_pages,
-		struct zone *zone, struct memory_notify *arg)
+		struct zone *zone, struct node_notify *arg)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	unsigned long present_pages = 0;
 	enum zone_type zt;
 
 	arg->status_change_nid = NUMA_NO_NODE;
-	arg->status_change_nid_normal = NUMA_NO_NODE;
 
 	/*
-	 * Check whether node_states[N_NORMAL_MEMORY] will be changed.
-	 * If the memory to be offline is within the range
-	 * [0..ZONE_NORMAL], and it is the last present memory there,
-	 * the zones in that range will become empty after the offlining,
-	 * thus we can determine that we need to clear the node from
-	 * node_states[N_NORMAL_MEMORY].
+	 * Here we count the possible pages within the range [0..ZONE_MOVABLE].
+	 * If after having accounted all the pages, we see that the nr_pages to
+	 * be offlined is over or equal to the accounted pages, we know that the
+	 * node will become empty, ans so, we can clear it for N_MEMORY.
 	 */
-	for (zt = 0; zt <= ZONE_NORMAL; zt++)
+	for (zt = 0; zt <= ZONE_MOVABLE; zt++)
 		present_pages += pgdat->node_zones[zt].present_pages;
-	if (zone_idx(zone) <= ZONE_NORMAL && nr_pages >= present_pages)
-		arg->status_change_nid_normal = zone_to_nid(zone);
-
-	/*
-	 * We have accounted the pages from [0..ZONE_NORMAL); ZONE_HIGHMEM
-	 * does not apply as we don't support 32bit.
-	 * Here we count the possible pages from ZONE_MOVABLE.
-	 * If after having accounted all the pages, we see that the nr_pages
-	 * to be offlined is over or equal to the accounted pages,
-	 * we know that the node will become empty, and so, we can clear
-	 * it for N_MEMORY as well.
-	 */
-	present_pages += pgdat->node_zones[ZONE_MOVABLE].present_pages;
 
 	if (nr_pages >= present_pages)
 		arg->status_change_nid = zone_to_nid(zone);
 }
 
-static void node_states_clear_node(int node, struct memory_notify *arg)
+static void node_states_clear_node(int node, struct node_notify *arg)
 {
-	if (arg->status_change_nid_normal >= 0)
-		node_clear_state(node, N_NORMAL_MEMORY);
-
 	if (arg->status_change_nid >= 0)
 		node_clear_state(node, N_MEMORY);
 }
@@ -1957,7 +1955,9 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	unsigned long pfn, managed_pages, system_ram_pages = 0;
 	const int node = zone_to_nid(zone);
 	unsigned long flags;
-	struct memory_notify arg;
+	struct memory_notify mem_arg;
+	struct node_notify node_arg;
+	bool cancel_mem_notifier_on_err = false, cancel_node_notifier_on_err = false;
 	char *reason;
 	int ret;
 
@@ -2016,11 +2016,21 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		goto failed_removal_pcplists_disabled;
 	}
 
-	arg.start_pfn = start_pfn;
-	arg.nr_pages = nr_pages;
-	node_states_check_changes_offline(nr_pages, zone, &arg);
+	mem_arg.start_pfn = start_pfn;
+	mem_arg.nr_pages = nr_pages;
+	node_states_check_changes_offline(nr_pages, zone, &node_arg);
+
+	if (node_arg.status_change_nid >= 0) {
+		cancel_node_notifier_on_err = true;
+		ret = node_notify(NODE_BECOMING_MEMORYLESS, &node_arg);
+		ret = notifier_to_errno(ret);
+		if (ret)
+			goto failed_removal_isolated;
+	}
 
-	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
+	cancel_mem_notifier_on_err = true;
+	mem_arg.status_change_nid = node_arg.status_change_nid;
+	ret = memory_notify(MEM_GOING_OFFLINE, &mem_arg);
 	ret = notifier_to_errno(ret);
 	if (ret) {
 		reason = "notifier failure";
@@ -2100,27 +2110,32 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * Make sure to mark the node as memory-less before rebuilding the zone
 	 * list. Otherwise this node would still appear in the fallback lists.
 	 */
-	node_states_clear_node(node, &arg);
+	node_states_clear_node(node, &node_arg);
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
 	}
 
-	if (arg.status_change_nid >= 0) {
+	if (node_arg.status_change_nid >= 0) {
 		kcompactd_stop(node);
 		kswapd_stop(node);
+		/* Node went memoryless. Notifiy interested consumers */
+		node_notify(NODE_BECAME_MEMORYLESS, &node_arg);
 	}
 
 	writeback_set_ratelimit();
 
-	memory_notify(MEM_OFFLINE, &arg);
+	memory_notify(MEM_OFFLINE, &mem_arg);
 	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
 	return 0;
 
 failed_removal_isolated:
 	/* pushback to free area */
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
-	memory_notify(MEM_CANCEL_OFFLINE, &arg);
+	if (cancel_mem_notifier_on_err)
+		memory_notify(MEM_CANCEL_OFFLINE, &mem_arg);
+	if (cancel_node_notifier_on_err)
+		node_notify(NODE_CANCEL_MEMORYLESS, &node_arg);
 failed_removal_pcplists_disabled:
 	lru_cache_enable();
 	zone_pcp_enable(zone);
diff --git a/mm/slub.c b/mm/slub.c
index e716b4cb2d0e..5c0f5d33b551 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6168,8 +6168,8 @@ static int slab_mem_going_online_callback(void *arg)
 {
 	struct kmem_cache_node *n;
 	struct kmem_cache *s;
-	struct memory_notify *marg = arg;
-	int nid = marg->status_change_nid;
+	struct node_notify *narg = arg;
+	int nid = narg->status_change_nid;
 	int ret = 0;
 
 	/*
@@ -6221,15 +6221,12 @@ static int slab_memory_callback(struct notifier_block *self,
 	int ret = 0;
 
 	switch (action) {
-	case MEM_GOING_ONLINE:
+	case NODE_BECOMING_MEM_AWARE:
 		ret = slab_mem_going_online_callback(arg);
 		break;
-	case MEM_GOING_OFFLINE:
+	case NODE_BECOMING_MEMORYLESS:
 		ret = slab_mem_going_offline_callback(arg);
 		break;
-	case MEM_ONLINE:
-	case MEM_CANCEL_OFFLINE:
-		break;
 	}
 	if (ret)
 		ret = notifier_from_errno(ret);
@@ -6304,7 +6301,7 @@ void __init kmem_cache_init(void)
 			sizeof(struct kmem_cache_node),
 			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
-	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
+	hotplug_node_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
 	/* Able to allocate the per node structures */
 	slab_state = PARTIAL;
-- 
2.49.0

