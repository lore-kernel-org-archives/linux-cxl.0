Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEB3233ED
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855656; cv=none; b=kK6p8F5QjmLlVyVg2OcST5TE0v6P08r1/nOKoYs3d/+mOlCuMt/WR7P5rvQ/iqFR1xRs4w04zr8IsfIhXwjE6Rg4yNPQXoIR6QjNbITdVUzexZgDuLQjTplhW+qtbJ6pAUScjIpAQZUeWaoMPtzCDYOPV647/rUC1AMIWzSONZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855656; c=relaxed/simple;
	bh=gl6pGyqjKJOJpLp8kEKuzbbJQXexplF0ywI3xT1S1Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUtq7SJbfC67eEv8NLIgMTMr+c/iDaVmpr+RcNwtndVBf09oSuwoCA+xmwPxKFTHApWTmhCxF+sAF7zKhmAxuWGh4fK8o+NmpWoh6rdYX0U/K7q1JAx7NzIShoyIYYuLVJnw9UtbHnXjkCHWZvepmAq3aFfb0pDjP3n4urqYPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EIlEvuNQ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EIlEvuNQ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c1d487f2cso6937391cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782855654; x=1783460454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHInMxAaQ2bUuLOe5OFmxM2p3fvBID4+2UNGvlrGK4E=;
        b=EIlEvuNQQx9Eby0Dg7ocHgYotRf58Te2Xw9jFaCYc6uVPd6Pvoe3U6z0qek/2wJJ+N
         EyjQPzVw0TdDAuKrVrLHe7ZHs/+iK//rbAGEyytGMUZfGpyBEpUnApDnLO3wDiena/kf
         /tJHqDqQa7JpDIrizMDK/+FAgpHqji83tWHJiXXC0pgDYtEqWjcGXBSNGDUkhlxdqQsG
         f+LEhlOTSJcZxXo6TfKuUdfbfaMpg/Iivx+BWRLu5bB5gdyNvTM+GxLOs70jVB2W1DRR
         BwVkCssYTemkaCsPkgJX3fHHQEo9ZcalUrdjjv+yxGJ/XeSkgruNBQoK6Vbz7KOdPU22
         45dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782855654; x=1783460454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHInMxAaQ2bUuLOe5OFmxM2p3fvBID4+2UNGvlrGK4E=;
        b=fVLwyZpvGfmTMbe3h2qt8PTmjUoWAaPgY0G+Nk+c9v9MElMrum7Qcu9mCJe0g5sOXZ
         IYEgnKeq1x0EbntUvD7cCbUobP+tTRfrzukPleWeJ/nHdpcA/swsOOeYtDRfgC4P3iDD
         Yzy5veYoODErbA/aKbM0a1tQc+pqR8cCbD78n2T+nrfXupbv398T43ZVmDMkKDEPY6cH
         J1fODNr9P7sHMdv9hGpT+tAyI1mxBHrFbCIFD1plgpsxMa3Dmz1Q8d6Bq5YgU4uJOyGj
         kevfQZYAHlAwfBK+bEwgz0WeJNEbCtztzdZvhz5UkeZEvl6Lyk6pzuVkRgOICaB78Bbp
         MF2w==
X-Forwarded-Encrypted: i=1; AFNElJ/C7kK2iqZa48YnNmqFfhMKRRnL1NZS8WmmPjuLM+n2xGh0LToyLtYBA0t1j4Dnw7nSRp4K49naxVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjK3fxrGRPwcvHnVfZEz+pLTmGtxhe23oTA+bgXuRR+3rt8eG
	g9q6ekey6XtPp/PosQ0TX2meCzzK5E242t89z8pt+LTJsS1V0L7gajjSVuI00KKeRng=
X-Gm-Gg: AfdE7clR7AqdSW1LFe/iDka7zY0SPS4Fw7mSsPGr4Kb4y3AxeQ32fd0uYS/qwZwlyTj
	J3HJGtk7POR8JgdsZ+mOzbJh7ig9c/Lzict72+hR/uOzjQaLc+VdbnW7p5pnp/DOXJtH4PbTy2m
	eGA4Qq/bDZORfew7c8TdHq3XO6SmS+jBNWHfUBprTYmTx5qDr4RspKqD9exjJm93UH0+RRzNAUH
	fAI0qbxdrLkgPGfsAf78zxsO+hRTWLj1c6B7LFaGOWxP2Qbvj8Nr/iA6f+o33yBtDJkSuMFwMzR
	h+M3vCoh6Ef10U0v2nH51vvwLKJtDJAEXZC+no349ziYSGKI4FGipjXOTUGEkZu8mIpa9i51fG3
	Ildb//X1q3dpkE4B0vzjMaalozLJCff+Ff0rUv+fwlThiKS9U0jwapFAu/IVeSMBgmLMtnpEVhq
	3tuIJeigZwiaEyJAaE9t3scDrOxhVVCz4TPHuTOOKP5QkrLfbdHUjtyKXcIZXljqvvA2y0Z2isQ
	0b1BT22/NIA
X-Received: by 2002:a05:622a:1f0f:b0:51a:8c97:fb93 with SMTP id d75a77b69052e-51c1090a30amr70785981cf.60.1782855654010;
        Tue, 30 Jun 2026 14:40:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a0eb16sm27011331cf.25.2026.06.30.14.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:40:53 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	mgorman@techsingularity.net,
	hannes@cmpxchg.org,
	vbabka@kernel.org
Subject: [PATCH] mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug
Date: Tue, 30 Jun 2026 17:40:39 -0400
Message-ID: <20260630214039.2263562-1-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We miss a failed allocation check for pgdat->per_cpu_nodestats, which
results in a NULL deref when we offset into the per-cpu area.

Propagate -ENOMEM up the stack and leave per_cpu_nodestats pointing
at boot_nodestats so a later online can retry the allocation.

hotadd_init_pgdat() returns NULL on failure, which __try_online_node()
already maps to -ENOMEM.

Assisted-by: Sashiko:unknown-model
Fixes: 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            |  3 ++-
 mm/mm_init.c                   | 14 +++++++++++---
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7c9d66729c60..f04b915678db 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -289,7 +289,7 @@ static inline void __remove_memory(u64 start, u64 size) {}
 /* Default online_type (MMOP_*) when new memory blocks are added. */
 extern enum mmop mhp_get_default_online_type(void);
 extern void mhp_set_default_online_type(enum mmop online_type);
-extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
+extern int __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
 extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory_resource(int nid, struct resource *resource,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7ac19fab2263..8b137328dcf0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1263,7 +1263,8 @@ static pg_data_t *hotadd_init_pgdat(int nid)
 	pgdat = NODE_DATA(nid);
 
 	/* init node's zones as empty zones, we don't have any present pages.*/
-	free_area_init_core_hotplug(pgdat);
+	if (free_area_init_core_hotplug(pgdat))
+		return NULL;
 
 	/*
 	 * The node we allocated has no zone fallback lists. For avoiding
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 306ea5c13f54..37fd64ce144d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1536,7 +1536,7 @@ void __init set_pageblock_order(void)
  * NOTE: this function is only called during memory hotplug
  */
 #ifdef CONFIG_MEMORY_HOTPLUG
-void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
+int __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 {
 	int nid = pgdat->node_id;
 	enum zone_type z;
@@ -1544,8 +1544,14 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 
 	pgdat_init_internals(pgdat);
 
-	if (pgdat->per_cpu_nodestats == &boot_nodestats)
-		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
+	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
+		struct per_cpu_nodestat __percpu *p;
+
+		p = alloc_percpu(struct per_cpu_nodestat);
+		if (!p)
+			return -ENOMEM;
+		pgdat->per_cpu_nodestats = p;
+	}
 
 	/*
 	 * Reset the nr_zones, order and highest_zoneidx before reuse.
@@ -1583,6 +1589,8 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 		zone->present_pages = 0;
 		zone_init_internals(zone, z, nid, 0);
 	}
+
+	return 0;
 }
 #endif
 
-- 
2.53.0-Meta

