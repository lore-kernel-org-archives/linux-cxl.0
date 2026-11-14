Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640242;
	b=ITJWQhh8EGuPXFOdZyrlVratH10xmBxDcI0fvIJbNQdfeY84Dx0aY6c5M6NStI1WneKO
	 0chYyKJ+KL8PwU1YF83mBJtlf2Q6cxvvMpuG562y78wTV3VttS/YXH+wo//1lEEOrTvbE
	 upxB+IjEqs/+5ehPCBf4uEmK8d2GNADDmDUtbKaJEXHIOOZhKlIkxigHr/FMQoXOVlNm6
	 4I+uHvS18SrGRPQe7L2JX+RKOIyVjPbs7yAmQqxLoBuT9H+/0h2r3JraFTdHpmDng7D03
	 bxBEXQd9zKCCtLLm/OLycIrZuhOQY1rV+mRYRS/AJrjje837ygEUPBNnS6wKPK5Jg3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
	b=FDyYwXXtsKEKYFtCeKz7TcsjxkeO1cuiHQbux9dZ9lWAyFNFN4RdE4fcXw+eLvATXf7H
	 CPcHwDTHGZJ6fv3w6yh40C+njJSxbF7B4k75rXos3D4Z/i9nhd7y56MpX5lISyDvMsbCu
	 hn7nA1stMaGKdur/y6w2c6XbKqUpm9FoZr6IdCnEf33IfeD+E1c6BBMjj+OJz7xH6OAvW
	 dTTkgfHGMtNgw6I63N256/CdF34yCUKZXJQGLCdoYDgMpIqdWIvP7id3QX9YcNy2Y5X0/
	 +3K9077ijJZ9G63UEQspc4TU99kQTd6c9m6r0dLUUsMRM6QlipwCIB1pH4PAgas+xKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=D9A1vsmT;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763D60A2639
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D763D60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=D9A1vsmT
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91ea0c05c92so32027426d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640241; x=1795245041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
        b=D9A1vsmTybX5qvyGrrwjuz0qfMhMCmSQaNyn6nnZSRb6LSMt/zZ4S9s3hm+H3FkHCR
         SG2SISoIW0tA/UkIS8ZIjAJYclJ8n15cYdVuyVR0M6TNYjxudXryIGYUlLTffCKApNtT
         L9V7DtX/RDb3IW725jkVaFFLu8fllFC8RUg/BCf/soPXFJdVTjGbGh6Y20jSFnNwtB+1
         d9upU+RfmfzHIX56UPwgbX1+NUg0F/ZhXyF8jpC4BQeYnzkcwImEQnlAEvqtk3JqdpNo
         9XdIJkNyk41TuO3O7wjteZ30+0JtKPuU1KD7fcffJ0Tvt/O93YRyjh6yIdiXMAS5kJPl
         4eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640241; x=1795245041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
        b=Sk5Srb+v/ZjxegQyLm8nCiVGmUoTIuGlsCBX3djwJUGMmtIe46FOTBD9Las7FacWwd
         2QIG7cWf9cnrsoeikp2Z3cbD3h2hUyCLZIK3yZBRwzajOqismyYpQsCxBVo6xQnLRHP3
         eHSwoJUNpDNBWoEAdpcgeRxjgDF/pAGALQb/D5JgOZf71s+imxvTmbxB6iW168xFPwNf
         bsE4Pvc5QteXBjyPYetGvqTDSabj+OF3by6g/U62boT5U2PoEy11wkkngJLqtHSipVrG
         R1bbBxE808OdzTHrj9UM4TmGHI0drNRE/6eY5QmD9KuglOawkuzD0qrHuGzf3R1j/5s4
         d1EQ==
X-Forwarded-Encrypted: i=1; AL+hErFYyBEz+ynAsLcd/dDr0ngfQp3zapfkWU/wEXLq/PneGMErZB/CCLrRcMQstz6y2DmYMIEGmz8hWUc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GhFRA+pwGQSCepwM/jmPILwBfWEOixtl9gvkKbvJkhqs3gyll
	mG2dQP9OCPQHLuKxP/I7upWEpgNiBvQz2HlHAfdJ5j+Z5C83YTwO/cGJ+lTkUoHJj/U=
X-Gm-Gg: AYBFou3dP9WDnoU8g99k0wmWd6uLoX5L1ySVzLYLgPexXdIJIRWtCPlqAaOX5hKxbuc
	cocjXkBmwP7GBJoq7yP/yfhAcAVvbWzvjaouwME8K7XiV+wA3eDSasR6nfT16txE6S1nHOhV1iZ
	MKH149dDKHn3D3Xx/W0yczfdXnyjV4Eebj+U7v92YUSYp6UUXZnalhIcO4ntoDtifh566LafE8F
	NadLbpsLrv3DBF9Cpndm6BVXo8UzQsKy3dmVE9WKojhUtxFmQT2fsm/MFAqTQtTBvGSBCfaKFCv
	jIVIMSjnd68Bo+wl8NL+UNcmQuSzUwxDAqoSaC1M6j83U1z3T6fQz6R8NqYAWGUV1FrYUj+c1rG
	xB9t712SNNh5ztFXb3wyhFcUa6BtTjQtCgmAdM9SIflFc57b2KGsM739earlXplS4RO/euKH7w9
	oHa8t+w12fJ/wT1OUmv4qZmaW/3W43e55By/6/i4sJbALi8mYYgQZs3qE0FpzUj2SQsZn0cIMfc
	4YVWDT3DalG464bBagnvmzGre8yp1yf+diJTPVT/KR+NfAShP4jwOa1pb+eHwpRDm+gTZGMYCfG
	7b0oKIawr5Z3svYsXX22vl5WAfOM5uRM2E0pGiPWeOFhTLiHmprSnSI241ZcLlpeQlCqVv8RjDA
	A4+f5QPwpfDQaAT4=
X-Received: by 2002:a05:6214:c2b:b0:91c:9086:ee07 with SMTP id 6a1803df08f44-91f2420df31mr81654406d6.38.1794640240818;
        Fri, 13 Nov 2026 23:10:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:40 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 17/22] mm/vmscan: restrict reclaim to common memory
Date: Sat, 14 Nov 2026 02:09:54 -0500
Message-ID: <20261114070959.3490008-18-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reclaim serves the ordinary allocation domain.

Restrict it to N_MEMORY_COMMON:
  - start kswapd only on common nodes, at boot or hotplug.
  - walk only common zones in direct reclaim and when throttling it,
    so no reclaimer waits on a node that has no kswapd.
  - walk common nodes when MGLRU registers an mm and when its debugfs
    interface iterates or validates nodes, using first_node_state()
    and next_node_state() in place of first_memory_node and
    next_memory_node.

The fallback zonelists hold only common memory, and all memory is common
at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory_hotplug.c |  3 ++-
 mm/vmscan.c         | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 29ff2c46499b3..410a29732bae7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1207,7 +1207,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
-	kswapd_run(nid);
+	if (node_state(nid, N_MEMORY_COMMON))
+		kswapd_run(nid);
 	kcompactd_run(nid);
 
 	if (node_arg.nid >= 0)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 061fbd168d982..bb7b1c50bfb78 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2932,7 +2932,7 @@ void lru_gen_add_mm(struct mm_struct *mm)
 #endif
 	spin_lock(&mm_list->lock);
 
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
@@ -5562,7 +5562,7 @@ static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
 	do {
 		int nid;
 
-		for_each_node_state(nid, N_MEMORY) {
+		for_each_node_state(nid, N_MEMORY_COMMON) {
 			if (!nr_to_skip--)
 				return mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		}
@@ -5587,13 +5587,13 @@ static void *lru_gen_seq_next(struct seq_file *m, void *v, loff_t *pos)
 
 	++*pos;
 
-	nid = next_memory_node(nid);
+	nid = next_node_state(nid, N_MEMORY_COMMON);
 	if (nid == MAX_NUMNODES) {
 		memcg = mem_cgroup_iter(NULL, memcg, NULL);
 		if (!memcg)
 			return NULL;
 
-		nid = first_memory_node;
+		nid = first_node_state(N_MEMORY_COMMON);
 	}
 
 	return mem_cgroup_lruvec(memcg, NODE_DATA(nid));
@@ -5665,7 +5665,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 	DEFINE_MAX_SEQ(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	if (nid == first_memory_node) {
+	if (nid == first_node_state(N_MEMORY_COMMON)) {
 		const char *path = memcg ? m->private : "";
 
 #ifdef CONFIG_MEMCG
@@ -5765,7 +5765,7 @@ static int run_cmd(char cmd, u64 memcg_id, int nid, unsigned long seq,
 	int err = -EINVAL;
 	struct mem_cgroup *memcg = NULL;
 
-	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY_COMMON))
 		return -EINVAL;
 
 	if (!mem_cgroup_disabled()) {
@@ -6492,8 +6492,8 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
 	}
 
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-					sc->reclaim_idx, sc->nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, sc->reclaim_idx,
+				 sc->nodemask, N_MEMORY_COMMON) {
 		/*
 		 * Take care memory controller reclaiming has small influence
 		 * to global LRU.
@@ -6604,8 +6604,8 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	} while (--sc->priority >= 0);
 
 	last_pgdat = NULL;
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
-					sc->nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, sc->reclaim_idx,
+				 sc->nodemask, N_MEMORY_COMMON) {
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
@@ -6756,8 +6756,8 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 * for remote pfmemalloc reserves and processes on different nodes
 	 * should make reasonable progress.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-					gfp_zone(gfp_mask), nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+				 nodemask, N_MEMORY_COMMON) {
 		if (zone_idx(zone) > ZONE_NORMAL)
 			continue;
 
@@ -7736,7 +7736,7 @@ static int __init kswapd_init(void)
 {
 	int nid;
 
-	for_each_node_state(nid, N_MEMORY)
+	for_each_node_state(nid, N_MEMORY_COMMON)
  		kswapd_run(nid);
 	register_sysctl_init("vm", vmscan_sysctl_table);
 	return 0;
-- 
2.53.1-Meta

