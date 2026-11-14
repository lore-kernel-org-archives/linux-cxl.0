Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640214;
	b=3t0nTBuZTzRmxjaAvGDymWVjWN6vKj111bXK4Iv64wa2orB/qZ1YHo75EbSQYHijGfLX
	 9w+JgujmuYOH/RT30TdHPcC/7SxwztHYwYUQEWXkwD4tJgJVwC4pMZNI2Fbdwvzn110am
	 a5f7Ybe2ZAhgfmO8QsIDlLc5o0h1ySiRqRU1D7M/dblzh9PRw8Y9ld9LlO4jcDD3I1iZi
	 CuFcWNfPcyDNbUs0BBmDBShycCRhyqxrZOyx6rCEoy8hgku96frdgMNmRBud5fq+WVHAF
	 BeDHrBlFaw2dZD/O1+bWdiNkM06Wm1AJR/2MATp3Qe/7dPZ+qNr5QHogDgnhsMG5fzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
	b=4nKoxIWnC6R7Ti33puw95D/mv66Qb12WvRCnKbrgGFzGRiHAX6MtgcwSQz2TSG5DJXtl
	 5h44NKPlFEb0pKnz3V0DcLZ4R4rg5XtTYpxf+U2eydcgzQ44o39ZQ6POQkGs/aMfcTWO0
	 2wf5XDmCXQHV6xt0v9xLf2NqfjH+soo5Vzi9PO+m6BoXVX/mdp30fPO7pi+Hc/dC2XAuE
	 Sxyos7fgDoBbB4teKM1bk2eK6DGCxSe1gi3ov4tNCoeo/gnuvb1Yqgjnb08z84yUjwGtv
	 9QsDPm7x9Z0YcO6JsJu1uY3jrUIuh5naT9WdSs+C6A7I+WysX1xvKWdNqyaFO7Pg9Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=deoAJpuv;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268A606A33F
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F268A606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=deoAJpuv
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-94962d80d34so26213585a.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640213; x=1795245013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
        b=deoAJpuvk5/EHzr+FRoWKty8TA+vc+0SUXmTiCKtNa4uUcimyE81R96fWgRz7/nC7/
         nxOrejc2E0NpG+giC4B/bA9RN9+l3poG1jjFyoVlP+tK1N4FUjhnopETAblwvEegsWoC
         N2vrbbw0sLOK+/H4lTrzKguByBIJzuZwK7nM3cHZBJXYMU6oG+tKG62dAlm+3g1Cg81f
         VstGy/u/BNv0z/ag+mwjSrVmjQoyz5R+W7jxdvdz9gY8a6SZa7GWQvZDoyMKi60knIWj
         bNNh1qF23hvGxiMH1MoODeCtKNf/Hnaz6wjOCTAeFWZ3TQbm8zBv4b+McPCHHjOM7T2S
         JqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640213; x=1795245013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
        b=Cz+WgfRYv8J36R/PKM/zidRVz7r/eLddtUqWdy7Cruu+2LcuB69xxY0TCEwTYTxV9o
         u0R8O2KmukTHcqGaxRPXIxBlCHuFLFEABhhUPV+ra2ku7BJvFCO9tlkUOSdsx1Krtf0M
         ds8BW17gPZ8Cn8J/W8qw0nCMHnL5cz/Wmpfklbe+4/RRQD1NtxwmJhggORs0MGlMNkrR
         w4vGxMn++r6/zq4vipbXZ9aJU239euq5wj2WJOq/EEIahvE7xGSNhbwDXNberrBCkLhb
         N58khQqveLEiRetwbcUyZ+JyvsR/TbcS8AYLeUALC9WBlf9XCrHRYdPvkRKwNnytW/rg
         tbTw==
X-Forwarded-Encrypted: i=1; AL+hErHn+XQECXru2M53zCo5kU9rP/7rlcOkbpEfotsEl43tlryttf+GUMgumNRXSJbs/Ggo5O05551zuTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pmnxy5UDDCnjc7xeYKxnBQGFUODB9t1ApdSSCoUkbskuv41V7
	6/gOvLujQArsrNS4x0mKcSaZEPAXsR7ri9tmDU3cSSLpaiUuPG4LqXk13VFpZu9kirI=
X-Gm-Gg: AYBFou1WYKenYm1ZtsUJPVw0mC7Fy6T47KWxwyHb3yaumbcxjvxLi6j3YoDLRIHsaF5
	IU0XZ4ROQNIbjRtPesb4e+mMtZnnD+gKzkWMD+vP0VqDiYKHpb8byc+zSrXcMRSi8UPopgI8Jtg
	FNuKs8AfBGx4MtTiInTHmL4Q3zIMi9O3QI3YDNOXkOeF9onUYDuB/vBMl06CsRzsvSuVwmYShnu
	IDFVXPpHH1rfqiHH0kEgAbcWopeU0fpbiGL2qXH+tTdovDqTnGbeicwQ8xFiadSppNYddLiJucB
	uPaC8FA/YvxI+koxKhhaGts/sXm2gnsQMaZUfdv2G8VFTrdhJY43+iqKv7y7/CE25901PEtWZUf
	gOINNqGRsA4yTTFDjOk9dOaGacbQ+w0i5WHsYrnunKhXTS9WpkIy4QhjzYB5ldNGGDgJR+UcG5k
	6gh8fmDo+u+iSpbBAxh8fLNHxD+Y8tWbQlhOiwk70x9wBJ1iEUusFZcEtBIxRLO0CXx/EQznsob
	p79zoicisUvlV8T//tk+lcA+BQLgoZDKbRyTONog1k1cTfGM6y7X+R2gViXT2IlLjpZDPAXOZd1
	H15XBvR5rpvRhBp9t4fxFtmqIGPpm1q9/VYhTl/mm8ocOG2B+3LaDn1iVgo8/Q4JjVj1/L2nW+Z
	IpeY43CoWjJhjLvQ=
X-Received: by 2002:a05:620a:7087:b0:949:402b:f18e with SMTP id af79cd13be357-9494bc7e777mr835710585a.66.1794640213010;
        Fri, 13 Nov 2026 23:10:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:12 -0800 (PST)
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
Subject: [PATCH 04/22] mm/page_alloc: build zonelists from common memory
Date: Sat, 14 Nov 2026 02:09:41 -0500
Message-ID: <20261114070959.3490008-5-gourry@gourry.net>
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

Zonelists decide which nodes an allocation can reach.

The fallback lists hold every node in N_MEMORY, and a node's
__GFP_THISNODE list holds its own zones whatever the node's state.

Ordinary allocations should reach only common (general purpose) memory.

Build the fallback zonelists from N_MEMORY_COMMON, and __GFP_THISNODE
zonelists only for a common node.

The build_local_zonelist() refactor lets use reuse the code to build
a local-only zonelist for nodes outside the N_MEMORY_COMMON set later.

Every node with memory is common, and a memoryless node has no zones to
list, so the zonelists are unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6ffa972811462..580feeb608b7a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5906,17 +5906,14 @@ int find_next_best_node_in(int node, nodemask_t *used_node_mask,
 }
 
 
-/*
- * Build __GFP_THISNODE zonelists
- */
-static void build_thisnode_zonelists(pg_data_t *pgdat)
+/* Build a local-only zonelist when this node is eligible. */
+static void build_local_zonelist(pg_data_t *pgdat, int zlidx, bool eligible)
 {
-	struct zoneref *zonerefs;
-	int nr_zones;
+	struct zoneref *zonerefs =
+		pgdat->node_zonelists[zlidx]._zonerefs;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_NOFALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
-	zonerefs += nr_zones;
+	if (eligible)
+		zonerefs += build_zonerefs_node(pgdat, zonerefs);
 	zonerefs->zone = NULL;
 	zonerefs->zone_idx = 0;
 }
@@ -5960,8 +5957,12 @@ static void build_node_zonelist(pg_data_t *pgdat, const nodemask_t *candidates,
 
 static void build_zonelists(pg_data_t *pgdat)
 {
-	build_node_zonelist(pgdat, &node_states[N_MEMORY], ZONELIST_FALLBACK);
-	build_thisnode_zonelists(pgdat);
+	int nid = pgdat->node_id;
+
+	build_node_zonelist(pgdat, &node_states[N_MEMORY_COMMON],
+			    ZONELIST_FALLBACK);
+	build_local_zonelist(pgdat, ZONELIST_NOFALLBACK,
+			     node_state(nid, N_MEMORY_COMMON));
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.53.1-Meta

