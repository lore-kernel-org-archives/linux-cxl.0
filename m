Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE634DB52
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975797; cv=none; b=me8BiKVpqfYJmUAhg0ou7L3eStdjyip77Xsl/4ud1WMJTChYD6V9+cD63dOnnGIA49TZ2mYdM7mKRhRJYDkNJ6vkG+CNgBoIQ1kIM6cPtTv5PEmnPddA5m7olq1YqP2mM0qsKTZwFv+veh3riD4/C5htZIrsI7xwqVYBhOaLzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975797; c=relaxed/simple;
	bh=LBAE8kZkJPq29k1iLwOntoOZutywPK8fvxCPXpNAG00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKcjtlFOv+ahTmWkyDMI7o/Goc/sY5HnL4NYD+e7Hrvb76Q6GybksmTj0abT7VZznzocYREr3R5QhUCKpJ3G+qwF+KA6kVccIEwRCFwiG5G7EeSOItDtbwMvXoaLM7Ki4rhoHfDKWHiPEvWx/vyoYA7kBFGHjVcuj40RKUMCXVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U21woACI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U21woACI"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4edb029249aso10368291cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975794; x=1763580594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCG0uhUeeA1he7Dw5Q3elz2n5ZNHYlg7H15kRGg6IlY=;
        b=U21woACIC0IijHo6RyKeSPCm+5RbJUW5pOEKTWR5JuSXcjxbSz03302AaVefkaK1mN
         1YSVR62/CcaXLISutnAmS1VBXtnnQxUQorFfdAqXHmnpfJjHVI9Y7K2tvRHVushO6Oue
         6PE+SEbCrKLR5O5I0CMqw7INddgtmB1xDuFlZR47qzU9xB/XZcDuKnxcz5zp5vrhP1u5
         plxt8n3Ig/WrOi1pSpkE1Fpa82gKW5jxb9Y+utSlJnAzYiPrcSPro5ew2TTkSBC0sa/J
         XH9oigqx1GQ7eMvy4tVul+1+agNbfLI2NA4/qEpTCwAn6mUbboDZXtJ9kIfO3RT4OIQE
         PgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975794; x=1763580594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCG0uhUeeA1he7Dw5Q3elz2n5ZNHYlg7H15kRGg6IlY=;
        b=muJgRsYT6aLW9wl6Dl+wk7dNVmocjbq24UxaKoyP+TrWabDyEVp63dCMrMIxWT01Gm
         9QtapnVUhKB6M/QA24W3FqaKG7kLSZGqbvqf3V1ip1HX4rWwWaGVMKMm+4/s1z2iQoek
         kOr5fvM5I3Nzo67pvU7ZlzZ7pjhdNrBWCESg9khFmimQNG7rVc7tZddQw2xLUQz/lJGI
         i3u1aNZM+q1TkFgpbDADPKhC2FaLUHPX+Cf9EbLN4uO4HAH//YM8cdtRsVUKqy9Wukr3
         WO2TfKJtNxE/+XcM7C8iETG7N6yAC9HP1yh3N6ch2ghsF2v8zZtelVKWj8w0kcd4c0fk
         9ExQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkMGbGXyU+hYLCRqXtsyNAuyve9W4flChVHqBp8yOHxhB+isj6ZvZo7o/T+t0HoGx1mLBlh9UfMjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZclDnFWzy5o1r+Aq6JHqlHnmz2K6rNRaMdgjk3cwcpIGd0AO
	8iK/QJ+jzKQSFL40cF1S+dJdpvqzamSDs1xOI8H2igMLo7Ki/UN2u0UQR2qtL5ZYKDI=
X-Gm-Gg: ASbGncuIpn+R11krQxa3+8P3KqU4Gc5ezouygdM1hw/2KeOw8MbSOEgTwakDC6mkfln
	fpirirgaqI3iqtWP32uYVC+DTnS/3KpyL0dQBO7j85CkLlkqnPpH9oUNsbP2i4aKuPBEeTJWKaE
	qDR01eELyYMTCTVZ0Wf4w9s7lkbktVm4Z+KH4IpWLWHfFiJHLGkQDFWC302/GKXGVoEdwr3CYDb
	RjkCfg5Sx2tYMpkcBTnKKY6gedoedrQNpPNb4IqJHM9enmdv+r/qAIy6uUcX4idkc47m8D73+ax
	dVa4tl/7GnXostJMp4z61zAMglMMlUfbYDbQUiWPZDyaiAgl5/hT/tZH94UXdn51sCFjqEdNcC1
	tW3b9PYRqCtawxVIt2cnPSEYbWl73yMbz4Y8YHL3xSstNTtcio8jTDDm+oZRCe0bVEuZBsyhtrc
	GzaA+2YoPNCSDmUNP/51YCvC1ZFSX+vlauXFI23Z2etkj9KKdNTVRe+6B5ewmRO8tG+5HhT3feE
	p0=
X-Google-Smtp-Source: AGHT+IHnM9b4iMhaMM3Umfgp794GytPagXJHdOPIuSBhJp6PMVhTsTQsQQE9eWpDhS66Z0o2IvV+zA==
X-Received: by 2002:a05:622a:2d6:b0:4db:db96:15d3 with SMTP id d75a77b69052e-4eddbd61fe9mr49171401cf.31.1762975793923;
        Wed, 12 Nov 2025 11:29:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:29:53 -0800 (PST)
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
Subject: [RFC PATCH v2 02/11] mm: change callers of __cpuset_zone_allowed to cpuset_zone_allowed
Date: Wed, 12 Nov 2025 14:29:18 -0500
Message-ID: <20251112192936.2574429-3-gourry@gourry.net>
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

All current callers of __cpuset_zone_allowed() presently check if
cpusets_enabled() is true first - which is the first check of the
cpuset_zone_allowed() function.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/compaction.c |  7 +++----
 mm/page_alloc.c | 19 ++++++++-----------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..d2176935d3dd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2829,10 +2829,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 					ac->highest_zoneidx, ac->nodemask) {
 		enum compact_result status;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if ((alloc_flags & ALLOC_CPUSET) &&
+		    !cpuset_zone_allowed(zone, gfp_mask))
+			continue;
 
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd5401fb5e00..bcaf1125d109 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3750,10 +3750,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		struct page *page;
 		unsigned long mark;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if ((alloc_flags & ALLOC_CPUSET) &&
+		    !cpuset_zone_allowed(zone, gfp_mask))
+			continue;
 		/*
 		 * When allocating a page cache page for writing, we
 		 * want to get it from a node that is within its dirty
@@ -4553,10 +4552,9 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		unsigned long min_wmark = min_wmark_pages(zone);
 		bool wmark;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if ((alloc_flags & ALLOC_CPUSET) &&
+		    !cpuset_zone_allowed(zone, gfp_mask))
+			continue;
 
 		available = reclaimable = zone_reclaimable_pages(zone);
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
@@ -5052,10 +5050,9 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
 		unsigned long mark;
 
-		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
-		    !__cpuset_zone_allowed(zone, gfp)) {
+		if ((alloc_flags & ALLOC_CPUSET) &&
+		    !cpuset_zone_allowed(zone, gfp))
 			continue;
-		}
 
 		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
 		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
-- 
2.51.1

