Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97E8825
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673303; cv=none; b=WAkyMWknUCu2ZVzmJD4D0Mo6Kbt9ZOvF6WdZw9c0EYQfl3+Rmd24YAT1aM47Hh4MvaV8bkr9eTBHa6aGCykRqgqlrOzB977Gfl3oU3sruh+OSh0mZdXFeYyljOfVAzEHxblEtO1klSj6dCflSVDWzbr7e1ih2Yy7eB0Fd0sPKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673303; c=relaxed/simple;
	bh=R1aGNSWaxFJ6PQ7czaGx4Y5ImI03arpaYhlgc9KIDzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u71fGMTYP9yEm9FedaSo/RIEHq/f9SQyJNWyhXY7ysCOmenCHwY4YR7TaQwdM6WEKrMLGj8wUMBYrNK/QUn5po1Bxu2cJxjHIBkSn6VJzPONZ3KgpNZWPQjhPXPbFqjj56WcDcAMDcVZcvpAFrPkhVThMknNSZIlbBLvOt2GHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DxBzMa05; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DxBzMa05"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-432c2581e58so276731cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 28 Mar 2024 17:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711673301; x=1712278101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xgOS8isMxKHzHyotyIcBuD4wYWux/bS/U8DbDxoJU0=;
        b=DxBzMa05gFAMPjuOG7lmQipmBGksU9IgSEhTCVGBtPkpGeoz/SxWHXDQPqvQWnMMSa
         U5R9GMofIiSVUgS7nDl7QX6r258mWwAbA0tMhGU4rO+rf42+bX3tgQuNPJ1niASY5Sjp
         9p954VmRrtk/YFU0Y3b9Kb4hcnHL3SMlajP2enVn3PvJ+wwxxaf8B61oKeJmj9njtum9
         K2HNYgSn0yJ3zoqJG/On9opSW6N9YSKxcxyqb/4jcwVLYdH4kzWUHI26+D2ehUjFyWRZ
         TkuNM5Gfj3IS6ay9ZlToGg3uFnValmF5Jefn+zqa/gz1EMmsMDnd9FZCyXRd+ByAiybm
         duSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711673301; x=1712278101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xgOS8isMxKHzHyotyIcBuD4wYWux/bS/U8DbDxoJU0=;
        b=AC7HcT8z1K1qcwTx+cx/RQFSzwZD+XKVch/IkBB73Jme6QBinEsDmtKXigJ6dwZOJ5
         u+7SQ8Aie+mdyu881ulxaNe13wQ3g8PHkXuTZzEP61Nun4Hw2YcxPrPhaY4PY+yyu5/+
         TkcTxplLDqIyoOWRaKmvUf+zsRkc46fmfUCQ6Nc1khgu/gSNLY2vz7gy/VKZF21Lx546
         s79A0eK1HmTooVpNunjEIvl4YbiL3cCfm4k+MqGOK+eFM/j2e5TTGr9pDMNqcY48VbLh
         GfAuMpNXVFPZBGNMdRrsoNzTi1iA8w5oKUsFtz4zqtYGLehYtwSe9Mar1sWba3bn9bUg
         PaCA==
X-Forwarded-Encrypted: i=1; AJvYcCVeVVI4NHTvfnuoVcudmEeFmgZybcJls/FEZiuffezqAOyrG0UsAaza+j8RIIx40vkj7RG1cwy0iV91y6+/thui1DMdO69X5vCY
X-Gm-Message-State: AOJu0Ywy9gT4q9PPQIzSEeqJJBLJKhHOGqOSBaqSA/g9xpaamsSZKowJ
	sus/0uqRX+iVS+BCgO03d7Fd19F1fQsjaVYHLXz8/hcjvKQEHD9lzo+mxKVHreo=
X-Google-Smtp-Source: AGHT+IGRQkIbG4fv+uoIg3/nxd1eFfIFzArVzfxtSMxfeYkTUQ5hMztZBEvA8x2mPlQTJlfj6KU89Q==
X-Received: by 2002:a05:622a:1492:b0:432:b84b:ac1 with SMTP id t18-20020a05622a149200b00432b84b0ac1mr1357113qtx.19.1711673301149;
        Thu, 28 Mar 2024 17:48:21 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8749a000000b00430afbb6b50sm1102414qtq.51.2024.03.28.17.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:48:20 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Srinivasulu Thanneeru" <sthanneeru@micron.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org,
	Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v8 2/2] memory tier: create CPUless memory tiers after obtaining HMAT info
Date: Fri, 29 Mar 2024 00:48:14 +0000
Message-Id: <20240329004815.195476-3-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240329004815.195476-1-horenchuang@bytedance.com>
References: <20240329004815.195476-1-horenchuang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation treats emulated memory devices, such as
CXL1.1 type3 memory, as normal DRAM when they are emulated as normal memory
(E820_TYPE_RAM). However, these emulated devices have different
characteristics than traditional DRAM, making it important to
distinguish them. Thus, we modify the tiered memory initialization process
to introduce a delay specifically for CPUless NUMA nodes. This delay
ensures that the memory tier initialization for these nodes is deferred
until HMAT information is obtained during the boot process. Finally,
demotion tables are recalculated at the end.

* late_initcall(memory_tier_late_init);
Some device drivers may have initialized memory tiers between
`memory_tier_init()` and `memory_tier_late_init()`, potentially bringing
online memory nodes and configuring memory tiers. They should be excluded
in the late init.

* Handle cases where there is no HMAT when creating memory tiers
There is a scenario where a CPUless node does not provide HMAT information.
If no HMAT is specified, it falls back to using the default DRAM tier.

* Introduce another new lock `default_dram_perf_lock` for adist calculation
In the current implementation, iterating through CPUlist nodes requires
holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end up
trying to acquire the same lock, leading to a potential deadlock.
Therefore, we propose introducing a standalone `default_dram_perf_lock` to
protect `default_dram_perf_*`. This approach not only avoids deadlock
but also prevents holding a large lock simultaneously.

* Upgrade `set_node_memory_tier` to support additional cases, including
  default DRAM, late CPUless, and hot-plugged initializations.
To cover hot-plugged memory nodes, `mt_calc_adistance()` and
`mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` to
handle cases where memtype is not initialized and where HMAT information is
available.

* Introduce `default_memory_types` for those memory types that are not
  initialized by device drivers.
Because late initialized memory and default DRAM memory need to be managed,
a default memory type is created for storing all memory types that are
not initialized by device drivers and as a fallback.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 974af10cfdd8..e24fc3bebae4 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -36,6 +36,11 @@ struct node_memory_type_map {
 
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
+/*
+ * The list is used to store all memory types that are not created
+ * by a device driver.
+ */
+static LIST_HEAD(default_memory_types);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
 
@@ -108,6 +113,8 @@ static struct demotion_nodes *node_demotion __read_mostly;
 
 static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
 
+/* The lock is used to protect `default_dram_perf*` info and nid. */
+static DEFINE_MUTEX(default_dram_perf_lock);
 static bool default_dram_perf_error;
 static struct access_coordinate default_dram_perf;
 static int default_dram_perf_ref_nid = NUMA_NO_NODE;
@@ -505,7 +512,8 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
 static struct memory_tier *set_node_memory_tier(int node)
 {
 	struct memory_tier *memtier;
-	struct memory_dev_type *memtype;
+	struct memory_dev_type *mtype = default_dram_type;
+	int adist = MEMTIER_ADISTANCE_DRAM;
 	pg_data_t *pgdat = NODE_DATA(node);
 
 
@@ -514,11 +522,20 @@ static struct memory_tier *set_node_memory_tier(int node)
 	if (!node_state(node, N_MEMORY))
 		return ERR_PTR(-EINVAL);
 
-	__init_node_memory_type(node, default_dram_type);
+	mt_calc_adistance(node, &adist);
+	if (node_memory_types[node].memtype == NULL) {
+		mtype = mt_find_alloc_memory_type(adist, &default_memory_types);
+		if (IS_ERR(mtype)) {
+			mtype = default_dram_type;
+			pr_info("Failed to allocate a memory type. Fall back.\n");
+		}
+	}
+
+	__init_node_memory_type(node, mtype);
 
-	memtype = node_memory_types[node].memtype;
-	node_set(node, memtype->nodes);
-	memtier = find_create_memory_tier(memtype);
+	mtype = node_memory_types[node].memtype;
+	node_set(node, mtype->nodes);
+	memtier = find_create_memory_tier(mtype);
 	if (!IS_ERR(memtier))
 		rcu_assign_pointer(pgdat->memtier, memtier);
 	return memtier;
@@ -655,6 +672,34 @@ void mt_put_memory_types(struct list_head *memory_types)
 }
 EXPORT_SYMBOL_GPL(mt_put_memory_types);
 
+/*
+ * This is invoked via `late_initcall()` to initialize memory tiers for
+ * CPU-less memory nodes after driver initialization, which is
+ * expected to provide `adistance` algorithms.
+ */
+static int __init memory_tier_late_init(void)
+{
+	int nid;
+
+	mutex_lock(&memory_tier_lock);
+	for_each_node_state(nid, N_MEMORY)
+		if (!node_state(nid, N_CPU) &&
+			node_memory_types[nid].memtype == NULL)
+			/*
+			 * Some device drivers may have initialized memory tiers
+			 * between `memory_tier_init()` and `memory_tier_late_init()`,
+			 * potentially bringing online memory nodes and
+			 * configuring memory tiers. Exclude them here.
+			 */
+			set_node_memory_tier(nid);
+
+	establish_demotion_targets();
+	mutex_unlock(&memory_tier_lock);
+
+	return 0;
+}
+late_initcall(memory_tier_late_init);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
@@ -668,7 +713,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 {
 	int rc = 0;
 
-	mutex_lock(&memory_tier_lock);
+	mutex_lock(&default_dram_perf_lock);
 	if (default_dram_perf_error) {
 		rc = -EIO;
 		goto out;
@@ -716,23 +761,30 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 	}
 
 out:
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&default_dram_perf_lock);
 	return rc;
 }
 
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 {
-	if (default_dram_perf_error)
-		return -EIO;
+	int rc = 0;
 
-	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
-		return -ENOENT;
+	mutex_lock(&default_dram_perf_lock);
+	if (default_dram_perf_error) {
+		rc = -EIO;
+		goto out;
+	}
 
 	if (perf->read_latency + perf->write_latency == 0 ||
-	    perf->read_bandwidth + perf->write_bandwidth == 0)
-		return -EINVAL;
+	    perf->read_bandwidth + perf->write_bandwidth == 0) {
+		rc = -EINVAL;
+		goto out;
+	}
 
-	mutex_lock(&memory_tier_lock);
+	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
+		rc = -ENOENT;
+		goto out;
+	}
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
 	 * its memory latency (read + write) and inversely proportional to its
@@ -745,8 +797,9 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
 		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
 		(perf->read_bandwidth + perf->write_bandwidth);
-	mutex_unlock(&memory_tier_lock);
 
+out:
+	mutex_unlock(&default_dram_perf_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
@@ -858,7 +911,8 @@ static int __init memory_tier_init(void)
 	 * For now we can have 4 faster memory tiers with smaller adistance
 	 * than default DRAM tier.
 	 */
-	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
+	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
+									&default_memory_types);
 	if (IS_ERR(default_dram_type))
 		panic("%s() failed to allocate default DRAM tier\n", __func__);
 
@@ -868,6 +922,14 @@ static int __init memory_tier_init(void)
 	 * types assigned.
 	 */
 	for_each_node_state(node, N_MEMORY) {
+		if (!node_state(node, N_CPU))
+			/*
+			 * Defer memory tier initialization on CPUless numa nodes.
+			 * These will be initialized after firmware and devices are
+			 * initialized.
+			 */
+			continue;
+
 		memtier = set_node_memory_tier(node);
 		if (IS_ERR(memtier))
 			/*
-- 
Ho-Ren (Jack) Chuang

