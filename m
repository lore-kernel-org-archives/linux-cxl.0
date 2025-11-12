Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774F35292D
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975808; cv=none; b=JloHXwOZoLaeBTEm9bLqieiDz0ZyC5mUcqVRqP1QMPQPFKyQ/rInEDt88LIGLDU1fs49ovplEowM6WrS28ETv4NnNlptcHUgrqoO3hmqKZEG/4P2z2AeJXlCM4WSR2MwTj4gTNDrV2E7WNp224hgOixGXOCHEoTryX3HPEDR8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975808; c=relaxed/simple;
	bh=qkFB80HrhZMKpQhvPyMUjApbN47T6UHdB3cpm7OAspA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5pdMs3LnYJB43kiXmm8IbUrFQbANRcKhP8UW5pZkOEjpQC5MTZIc4tno0mLMbBXOUBV7wnpDYpI86V3tqKV8E+V81LO8ZIB838WinyMuqtaDGabD0kr57Am+zQFeP0Z+fUwreRLquEy8vJGqU2S7agWrZ638Dy8/J+oP5hGr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T/rKUQMm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T/rKUQMm"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b271e6833fso112139085a.0
        for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 11:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975803; x=1763580603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9HfsEAYF9yiUWWUj5tMirDvvn0FEtJ7B1MIYMFDuxY=;
        b=T/rKUQMmSjvQ0EA5rpdMH77VwhiM5CblzY+F23KGJH2+i0FbsXSf3lLgGeu6aFAa3x
         5r7df/efcs90iAKZlXVwDzIDAMIS4ADvFfr1EhEK0QnY8AbUW1/KurS5EBQtM+LOZSGL
         Cc13jMCILegW2HLNkqdUTaipUUtLfWZt5P7VD81nNOm3DjjbosAzABE7YFG9vazlYf3F
         aT2l50Wf5492Zuo1y4wBhJB+UGOCwdMwwKO65k0GoR2tgdfRLLra+74jRs4jJTcS7sZz
         kMc4L1Cw+/8pDlZhMJcxiUZLNXf+gcZFInG//EJ/qxZPmIV3Y7f+mdqjgS8DDes1IufY
         +QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975803; x=1763580603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9HfsEAYF9yiUWWUj5tMirDvvn0FEtJ7B1MIYMFDuxY=;
        b=UdpAzRuAQCGUgvsIdY0h4w7UGSoh6FwxB5IZ8x/kymfW297cP5zat5X8HevlW5RZf0
         WzjaWMtdvTg/c8P7OIUE5eRT2ZwtoyetGuhtJa99hevxyrr6aVBOM+c6M4rZV8BPSED5
         3H54D4CQLBrWQhI9fB4PjuO20SQOfr2NCCpVwABk9LQBwMMEBh/fQAWbBWFfxlqS4mo3
         v1JLnHaQTah+KAOzgGTK0aHdG6HgCStsNon3/T0HeiFbPmnpmB5HvSkpy6w+QyrRzFb9
         SxV70I6VoUecffq+j8JdvYangx2zrtllB9I8D7+B6poSBIckL+gI8jfrVDQvMzl4zHWb
         WFjA==
X-Forwarded-Encrypted: i=1; AJvYcCXJJRgKFckWC0U3LpNVzHbqwA2ad6KaDHdVi2PzT+ehunrbqpE8FWnX0bbvGSNnVLXdfRk76rAeayU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzhxqhJDIrJQ7dEyMP8F0ZvuDIuEH8Y98w+kUQKt8FwiWZTNZk
	E+H2m7iaB0/9qKypF+97tmw9oXqGMpEBG8+1eXis0+fAMCZNrqAnns53aT3I//9yeh8=
X-Gm-Gg: ASbGncuFi0YMGsDsso/40Frid5IrVv0NCl+v7XYPupXLHozHWOOq9RO/Ccj3HIqA5dd
	x4PvOy1iGi1K323dQRyZICgqH19rzX6OBYRWobscglKzpq8YQ5gljDBrYF80zJ1PtCja4mu/Alx
	V3/Z6iOJWkwPNenRx+V3fqdoORLDo14TIsgxjwG5uwyWEJDE01x/9+UASLPQjxEsBYQZU3e2qi6
	nYUMZ+dA8KPHbRqsfoo1vWOSSxXFpjEQBR2MQtaqFhgQvuu8ePJ/3A+CJ7v3qvSspU+XO8ALX6J
	wZv8bgLVSVi2WwF5n0QMLEDXCyFsp+iSjS6cn725lJOqW89P1z+Sr+2HVPvdB02xBuEFh9c5gPb
	tQrNbqHS0BVgjvTSDt60SD4OkFSXk9+vFkw9uVb/vl6Og4mnsnwIYX1T6lGgHhuMH68clhzVKRs
	3r4t8n3riO2lWgsk0XguTeeKW4BkzghZA8I22BowzgaQsU4cr7gFakHzhDdSJCbkJE
X-Google-Smtp-Source: AGHT+IEVluARmCpMkOWEYo8q4r5FDTRBhMVJs5VhBJ+XJ3044t3Im4FugeCYJRKlNUbrCKiFOXWBbg==
X-Received: by 2002:a05:620a:1914:b0:8b2:73f0:bd20 with SMTP id af79cd13be357-8b2ac200a20mr88765385a.39.1762975803034;
        Wed, 12 Nov 2025 11:30:03 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:30:02 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
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
Subject: [RFC PATCH v2 05/11] mm: restrict slub, oom, compaction, and page_alloc to sysram by default
Date: Wed, 12 Nov 2025 14:29:21 -0500
Message-ID: <20251112192936.2574429-6-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restrict page allocation and zone iteration behavior in mm to skip
SPM Nodes via cpusets, or mt_sysram_nodelist when cpusets is disabled.

This constrains core users of nodemasks to the mt_sysram_nodelist, which
is guaranteed to at least contain the set of nodes with sysram memory
blocks present at boot (or NULL if NUMA is compiled out).

If the sysram nodelist is empty (something in memory-tiers broken),
return NULL, which still allows all zones to be iterated.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/compaction.c |  3 +++
 mm/oom_kill.c   |  5 ++++-
 mm/page_alloc.c | 18 ++++++++++++++----
 mm/slub.c       | 15 ++++++++++++---
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index d2176935d3dd..7b73179d1fbf 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -13,6 +13,7 @@
 #include <linux/migrate.h>
 #include <linux/compaction.h>
 #include <linux/mm_inline.h>
+#include <linux/memory-tiers.h>
 #include <linux/sched/signal.h>
 #include <linux/backing-dev.h>
 #include <linux/sysctl.h>
@@ -2832,6 +2833,8 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		if ((alloc_flags & ALLOC_CPUSET) &&
 		    !cpuset_zone_allowed(zone, gfp_mask))
 			continue;
+		else if (!mt_node_allowed(zone_to_nid(zone), gfp_mask))
+			continue;
 
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c145b0feecc1..386b4ceeaeb8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -34,6 +34,7 @@
 #include <linux/export.h>
 #include <linux/notifier.h>
 #include <linux/memcontrol.h>
+#include <linux/memory-tiers.h>
 #include <linux/mempolicy.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
@@ -1118,6 +1119,8 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 bool out_of_memory(struct oom_control *oc)
 {
 	unsigned long freed = 0;
+	if (!oc->nodemask)
+		oc->nodemask = mt_sysram_nodemask();
 
 	if (oom_killer_disabled)
 		return false;
@@ -1154,7 +1157,7 @@ bool out_of_memory(struct oom_control *oc)
 	 */
 	oc->constraint = constrained_alloc(oc);
 	if (oc->constraint != CONSTRAINT_MEMORY_POLICY)
-		oc->nodemask = NULL;
+		oc->nodemask = mt_sysram_nodemask();
 	check_panic_on_oom(oc);
 
 	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bcaf1125d109..2ea6a50f6079 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -34,6 +34,7 @@
 #include <linux/cpuset.h>
 #include <linux/pagevec.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory-tiers.h>
 #include <linux/nodemask.h>
 #include <linux/vmstat.h>
 #include <linux/fault-inject.h>
@@ -3753,6 +3754,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		if ((alloc_flags & ALLOC_CPUSET) &&
 		    !cpuset_zone_allowed(zone, gfp_mask))
 			continue;
+		else if (!mt_node_allowed(zone_to_nid(zone), gfp_mask))
+			continue;
 		/*
 		 * When allocating a page cache page for writing, we
 		 * want to get it from a node that is within its dirty
@@ -4555,6 +4558,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		if ((alloc_flags & ALLOC_CPUSET) &&
 		    !cpuset_zone_allowed(zone, gfp_mask))
 			continue;
+		else if (!mt_node_allowed(zone_to_nid(zone), gfp_mask))
+			continue;
 
 		available = reclaimable = zone_reclaimable_pages(zone);
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
@@ -4608,7 +4613,7 @@ check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
 	 */
 	if (cpusets_enabled() && ac->nodemask &&
 			!cpuset_nodemask_valid_mems_allowed(ac->nodemask)) {
-		ac->nodemask = NULL;
+		ac->nodemask = mt_sysram_nodemask();
 		return true;
 	}
 
@@ -4792,7 +4797,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * user oriented.
 	 */
 	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
-		ac->nodemask = NULL;
+		ac->nodemask = mt_sysram_nodemask();
 		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx, ac->nodemask);
 	}
@@ -4944,7 +4949,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 			ac->nodemask = &cpuset_current_mems_allowed;
 		else
 			*alloc_flags |= ALLOC_CPUSET;
-	}
+	} else if (!ac->nodemask) /* sysram_nodes may be NULL during __init */
+		ac->nodemask = mt_sysram_nodemask();
 
 	might_alloc(gfp_mask);
 
@@ -5053,6 +5059,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		if ((alloc_flags & ALLOC_CPUSET) &&
 		    !cpuset_zone_allowed(zone, gfp))
 			continue;
+		else if (!mt_node_allowed(zone_to_nid(zone), gfp))
+			continue;
 
 		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
 		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
@@ -5187,8 +5195,10 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	/*
 	 * Restore the original nodemask if it was potentially replaced with
 	 * &cpuset_current_mems_allowed to optimize the fast-path attempt.
+	 *
+	 * If not set, default to sysram nodes.
 	 */
-	ac.nodemask = nodemask;
+	ac.nodemask = nodemask ? nodemask : mt_sysram_nodemask();
 
 	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
 
diff --git a/mm/slub.c b/mm/slub.c
index 1bf65c421325..c857db97c6a0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -28,6 +28,7 @@
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/mempolicy.h>
+#include <linux/memory-tiers.h>
 #include <linux/ctype.h>
 #include <linux/stackdepot.h>
 #include <linux/debugobjects.h>
@@ -3576,11 +3577,19 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
 		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
 			struct kmem_cache_node *n;
+			int nid = zone_to_nid(zone);
+			bool allowed;
 
-			n = get_node(s, zone_to_nid(zone));
+			n = get_node(s, nid);
+			if (!n)
+				continue;
+
+			if (cpusets_enabled())
+				allowed = __cpuset_zone_allowed(zone, pc->flags);
+			else
+				allowed = mt_node_allowed(nid, pc->flags);
 
-			if (n && cpuset_zone_allowed(zone, pc->flags) &&
-					n->nr_partial > s->min_partial) {
+			if (allowed && (n->nr_partial > s->min_partial)) {
 				slab = get_partial_node(s, n, pc);
 				if (slab) {
 					/*
-- 
2.51.1

