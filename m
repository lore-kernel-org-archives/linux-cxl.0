Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD41313E1D
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944190; cv=none; b=V146pWrTFHVnC+l3cVetclf9uFZJbYOJItiKISm05pXXjLM/45rsFZrmiQ/mv3KIFx9WOxuXu8LmeO1Jr5m8fiIxTJ35D6DMIJi4zPzfQPJnyrHyMUhBxu7ZoCrvGf8+3Ng1I3CF3VBZtKLRhUaIsOf5HmQpuo8Rt5u2dVKmVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944190; c=relaxed/simple;
	bh=6I/VKoVKTHo3NvNBqo5kNVhgRZgrRiag5cakTUGD0i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=adE1QMeWbRwjfIaGLpCSkJDjVsA4sp7Y7ctnA00Hz8BhE/nH8Fp1WDqQGFpnHHN71/G1p1rs6Io5QeH3pSG349YMO1c8vlXj8+4j0bHiVHSqoq8wE7gM8l4LAsGVqTszmiVQdJE+nNrKMgloTIqM9pboZ/sLZBGat7XkKOEzGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VR2/kmqP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VR2/kmqP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e65e18969so86902285a.1
        for <linux-cxl@vger.kernel.org>; Wed, 01 Jul 2026 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782944187; x=1783548987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6a1tBhtCqbCCMoKb79JV4MsL16BL9flmXbNAI1fA9CM=;
        b=VR2/kmqP4aFpJNjSXrBq+xLu/cLEk7OzHm2ezl2IfYEPaJhoQqORLVKY3irTtNJckL
         ELuHKl1KQ7ZcJ9BGIKwncUqZ3uMy4sitU1YMwSk03vpDlEojwfOYSdtEPMaFUXI0au0K
         PyE+hLaBSQqXP01X1Kv4QsTS9sNq3WCjm7s2A+Lf/9xxzUk1UbiVR9MnZI/nPj2IOcZh
         HTvFwjkWLVFFQmPBkufCQ9VjbpamWIGR+9jY7saMdtcE4RnxL1BD7kmqM0FZapVgQaAq
         9PIciddeNblRDW+7W6G2CkbYyQ9KNGd3ZQ66zIhjaG+Efw+Sc2AK/ykZyaHX5Ekuive7
         qGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944187; x=1783548987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6a1tBhtCqbCCMoKb79JV4MsL16BL9flmXbNAI1fA9CM=;
        b=WqcLYh1DGfHNBwwsw91XLbF0mrsh4zdtuw/1SPregPsm8Uelc+/+futMfgC3BAkkF8
         UR58/Z3iMsHPpMpr71hYyItug5jHpkaqXI5nStkXP+gMZhOlkdHhgdtGHIo9mXb+yBMs
         OrsNK2bwEnm3TnXJUYTb8VQkjSiXSzng8vDI4aAhw+bJXKglFj89d8E4XDjtvQInp4Xt
         RqYtg7IKeQgNtkmOE0e3skz93KF7xCBIN9jV0mtmxYOHMNB+weTEUJSzlZPhm3hrHye1
         7f9KsAbxyWKMGCeVoBdT1BLpAsC09UdrpP2DMBe1PDRZgZQPxpGXCduehaxhZWWrheG4
         wIWA==
X-Forwarded-Encrypted: i=1; AFNElJ+0AkN/xDP94F4UIafqcLQ7LmWagc5Gl1oBSORiHUsXdErIjV9zfFQwDq6ad+EjFEGchs2QOZh0t5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOFG7g+NOd41WpJORZMFvslwUvcygMbleWR+qIT/g7niuKlLu
	RP/M65IuIXoSRucgGgjWqtGJSw5GSEyjubgg7EW14X20yVzs0lAfmiLBU75C+GOlRbY=
X-Gm-Gg: AfdE7cmTXEzeWB17pdwxBr8gVdGLI+s5kChY8KlpzofzWDJ9VlWaadryZfY4a5TUZH8
	0qnRrquEgfzbS2kxY1BQ1jmTJgi8GSm3+WAcuSUir65ynaE/NeiSRqlW6iAgw4KGoj/gbZrHkAE
	ZcmScjH98XHNUMT+LfezD116FvRa7lpDwp3vZtz/bk/M3UH0eHziSoXcugAEUR7wuq2E2h/V74b
	lH5vnUqo3OdqxNRqf+e7ieXQapTYXcU9DQ7dEE/aFj0YQaITW6r/LnRDnJjifFriTfMzfPQJ7RU
	paF+VXmprMfK01DHee7OzsYt51RP3QkAi/BU2qNiwAD1TXQLw1JIX2mC3c2tyrj1hnyOGSyw+xP
	Wb+5fkFKW8HjMfqSdZ+VsmCdExLQCpQ1lYgJW9iqa/cI+u5s/2YFCbQl+BOwb9TOn3IMz4MabGr
	bPYGnbDTokes8b64IDrpgudNDKSEcp+ApRts92J1MLolvVE2E5+Vg4ooMUAS9Q9dv064jH+FG9W
	A==
X-Received: by 2002:a05:620a:890c:b0:924:eef7:d017 with SMTP id af79cd13be357-92e697f4eb1mr1050217685a.31.1782944186849;
        Wed, 01 Jul 2026 15:16:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e7ffdee03sm70988385a.4.2026.07.01.15.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:16:26 -0700 (PDT)
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
	vbabka@kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug
Date: Wed,  1 Jul 2026 18:16:13 -0400
Message-ID: <20260701221613.2818148-1-gourry@gourry.net>
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

On failure nothing needs to be unwound:
  - the node is never marked online
  - per_cpu_nodestats is left pointing at boot_nodestats
  - __add_memory_resource() cleans up pending memblock resources
  - later online attempts retry the per_cpu_nodestats allocation

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260627202243.758289-1-gourry%40gourry.net
Fixes: 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            |  3 ++-
 mm/mm_init.c                   | 14 +++++++++++---
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7c9d66729c60..06c58cb05779 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -289,7 +289,7 @@ static inline void __remove_memory(u64 start, u64 size) {}
 /* Default online_type (MMOP_*) when new memory blocks are added. */
 extern enum mmop mhp_get_default_online_type(void);
 extern void mhp_set_default_online_type(enum mmop online_type);
-extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
+int __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
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
index cfd0b2722d83..07a8c74cf7ad 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1526,7 +1526,7 @@ static inline void __init set_pageblock_order(void)
  * NOTE: this function is only called during memory hotplug
  */
 #ifdef CONFIG_MEMORY_HOTPLUG
-void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
+int __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 {
 	int nid = pgdat->node_id;
 	enum zone_type z;
@@ -1534,8 +1534,14 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 
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
@@ -1573,6 +1579,8 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 		zone->present_pages = 0;
 		zone_init_internals(zone, z, nid, 0);
 	}
+
+	return 0;
 }
 #endif
 
-- 
2.54.0

