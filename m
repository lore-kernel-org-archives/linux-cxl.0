Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C49314D21
	for <linux-cxl@vger.kernel.org>; Fri,  7 Nov 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555812; cv=none; b=CDk8+XSPMY0+WVbaSN/Ik/3ivxR99QB8wedDmstoMQCXf+2zCHUndran8masEBpgOjm5nHsTgmIraaCEZ2R3iCWKNPK73/wAYd1BbBlKHlUoES4cJcDY965d29USrRdsYSoNKdYLcEuNIVcya9meUJ9dEeyih3ocDV+OyjtCSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555812; c=relaxed/simple;
	bh=xnAgAOMUCvjgMIzfvkuvXLW+vDz6hedfcY4BtrN7jFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZVVEKT6Ymw3oHkpnx5mGSh4BCx1z9hbTxXhepDJfVHkRck5CKyy/yDJLVi7YgIInrJ2YVzWBuERECwI/b1g21Gge+bub/k/6jAtPy6dzoPwvFq2LmMaN9yDU/3kEB7aH8BI3zyAhJUVS56LrkbNGoVIjRT1csKRW4pj8jjwlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pse5v1JN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pse5v1JN"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eda6c385c0so305041cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 07 Nov 2025 14:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555809; x=1763160609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia+a6MlTeonyCm8y2ltZ2UGJPZEO4eqXV9rDHC4VPW4=;
        b=pse5v1JN4JmFn8nsWxTmUybb6xJrxAiWSvyLpbdxjxrkRNSOCwOXEKKSE9CYqCAz7R
         DG4tGWw2NOEVISEvoXniGE2iHCGu9HmKkj99iGiAPmNPY9H6faOormfKp5z6ExpL80tZ
         Jq27i60wbHwHmRtJITitAOuZZRfh5+fWtoLXJxG5QxkOmmYZeMysJgW/TbROgrz4GAnw
         c1ng+PmCYm1vC6DjBrKI2TdUn4VS2VGMm6MErIKWpLboZSd9aHtTZ4Z1u0Y0JNTk5917
         gZNeyismT/ARobIu1bT8jdqBJv/ojSv7Wzil4D6W2byrp4c8p+7BEM/pvK88x6H4JWGH
         DiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555809; x=1763160609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ia+a6MlTeonyCm8y2ltZ2UGJPZEO4eqXV9rDHC4VPW4=;
        b=uDJXzPJ6qrbGu9OvlQ6ObQZkmjEDgs04DmVEA1px5HZV7CAM1QL6C9PZn0vv89kORG
         6HTk6gSXHm0jykHKlBGO6Rg8BaJzA8u6aSeL/mYSMrFYMZZNUf1qmfbsUKLpceZRM35d
         wffHPHdT5Ov8hVKgjavqBg9JDtcnhmEnTZMV6sNNIom9G+D60lH05d8NjOGxoIpa++kJ
         hjY9iLE4mi9aXGh8gq1SgYCmIBFVbF0PsMTBcaoDYhmOKoUx2Y89boeCw3jl/SuCvwdh
         PyHf+cqeFYy2B0/WVO6DIR/40CRSt54StHchkREwrGOf1mipAyb6lQZIIG07cX5zsJov
         qeBA==
X-Gm-Message-State: AOJu0YwMAR6occi1rttsqOWloI3EJSime29Nsr3M+U2J6lSwjS6K0DnD
	MHABtUtHIeKUvs/xzzfYSHksDD6LIV8cepCjjVnevAOlJGmmF8sivr2b6MteJWSdINo=
X-Gm-Gg: ASbGnct4MeN2u4B/1QCH/6cpl5He1kFerp8QyfeuUOuO4ow0giLtZJt5dVkYFmLNKjr
	AkNMnwTSq6x9X0dDFzG0eJ4/ETfDAIDP4Rulb9u9ycgx2jDkSGiJGiJnn0BaWQ1iFoaoAXnn3y7
	FSK8THWnI/KnddkJsUwetn7BQXj7qw0l4gnKN9Z4l4O+uDNbqmYfw5PWUS1Lq21XCgqGLhr0Bpe
	tACSov7kLif0zlpMykO4WYEeMfXDJSqVgfAiE+X9pMvLOvdOjPbk3JJO6gscUAU0RhEq8nd6pgw
	WS7+RSfqUnLvaZllz3nlY9zJZfFOAixOGJfUgPe8TBXYlS3VuwSck+jtrf6i2YQqiPhukvMMWjH
	2xnfmBLVCGRd/6x498l2mExze8EznTfoA0Ll6W0g8B4FeUMNc4K3g19ShhMxm+Xnt+nYS24dkUd
	rZMnlrkIHMs6GBxSdyPLaLBcpLWDl3Ub+5a5MmmDwrWYGze7Ndd7Qh6qXPkJcSThOI
X-Google-Smtp-Source: AGHT+IH86NSTDKP1XdsF31RYjR4tNihgD5BPq31D5+FTd6nH/ZnI3iDuVFCi3Tc0xbHdRJTu/D2ZGw==
X-Received: by 2002:ac8:7d49:0:b0:4ed:6139:8ea1 with SMTP id d75a77b69052e-4eda4e734a8mr9627481cf.10.1762555809152;
        Fri, 07 Nov 2025 14:50:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:08 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH 2/9] memory-tiers: create default_sysram_nodes
Date: Fri,  7 Nov 2025 17:49:47 -0500
Message-ID: <20251107224956.477056-3-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Record the set of memory nodes present at __init time, so that hotplug
memory nodes can choose whether to expose themselves to the page
allocator at hotplug time.

Do not included non-sysram nodes in demotion targets.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory-tiers.h |  3 +++
 mm/memory-tiers.c            | 22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 7a805796fcfd..3d3f3687d134 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -39,6 +39,9 @@ struct access_coordinate;
 extern bool numa_demotion_enabled;
 extern struct memory_dev_type *default_dram_type;
 extern nodemask_t default_dram_nodes;
+extern nodemask_t default_sysram_nodelist;
+#define default_sysram_nodes (nodes_empty(default_sysram_nodelist) ? NULL : \
+			      &default_sysram_nodelist)
 struct memory_dev_type *alloc_memory_type(int adistance);
 void put_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0ea5c13f10a2..b2ee4f73ad54 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -44,7 +44,12 @@ static LIST_HEAD(memory_tiers);
 static LIST_HEAD(default_memory_types);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
-nodemask_t default_dram_nodes __initdata = NODE_MASK_NONE;
+
+/* default_dram_nodes is the list of nodes with both CPUs and RAM */
+nodemask_t default_dram_nodes = NODE_MASK_NONE;
+
+/* default_sysram_nodelist is the list of nodes with RAM at __init time */
+nodemask_t default_sysram_nodelist = NODE_MASK_NONE;
 
 static const struct bus_type memory_tier_subsys = {
 	.name = "memory_tiering",
@@ -427,6 +432,14 @@ static void establish_demotion_targets(void)
 	disable_all_demotion_targets();
 
 	for_each_node_state(node, N_MEMORY) {
+		/*
+		 * If this is not a sysram node, direct-demotion is not allowed
+		 * and must be managed by special logic that understands the
+		 * memory features of that particular node.
+		 */
+		if (!node_isset(node, default_sysram_nodelist))
+			continue;
+
 		best_distance = -1;
 		nd = &node_demotion[node];
 
@@ -457,7 +470,8 @@ static void establish_demotion_targets(void)
 				break;
 
 			distance = node_distance(node, target);
-			if (distance == best_distance || best_distance == -1) {
+			if ((distance == best_distance || best_distance == -1) &&
+			    node_isset(target, default_sysram_nodelist)) {
 				best_distance = distance;
 				node_set(target, nd->preferred);
 			} else {
@@ -812,6 +826,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 }
 EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
 
+
 /**
  * register_mt_adistance_algorithm() - Register memory tiering abstract distance algorithm
  * @nb: The notifier block which describe the algorithm
@@ -922,6 +937,9 @@ static int __init memory_tier_init(void)
 	nodes_and(default_dram_nodes, node_states[N_MEMORY],
 		  node_states[N_CPU]);
 
+	/* Record all nodes with non-hotplugged memory as default SYSRAM nodes */
+	default_sysram_nodelist = node_states[N_MEMORY];
+
 	hotplug_node_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
 	return 0;
 }
-- 
2.51.1

