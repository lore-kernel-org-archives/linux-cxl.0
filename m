Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175C13BACC
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152885; cv=none; b=FBmLGL2vmU5selBY5CT+Ka+P5YG3TVeucc7o/X27vL2uegnFXXRRcCqHbaQ29DyDuEu04lKVpf5CO1l40hZtwbqCCrwriCCdLMTe8ukKh4W7C3ek/GJe7CU7jUxDMKbr/KDh6GWIbgWIfCQUSDxUQ/WYdYd96ttZctY3UQdB3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152885; c=relaxed/simple;
	bh=LPymHoA6qtomFJj9prs4W/8rrsULUAMfwn30gfK801o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSeh0dridhqVFde65CGaKHBqOkfeG+g4graJEa89slbKOZ2ZOxNk5T/gHoITjiV7z/EnVgwntN8LwN/ckbPlO+MkfEaJ/IFspmfCOSOZlWZY0NWqsXrgr71ZYoBSbTXxXd7XQm74bUXLCbFloXfnHTP0eZk0w5IopTqLDSo0kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=R659dDfm; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="R659dDfm"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-831a5b7d250so494212241.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 14:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723152881; x=1723757681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YmoLJUzKwh05YDZkUnFH4Q03LnbmDmhfqr83K75cyk=;
        b=R659dDfmPHqrWs0s7iDXfuSm+V9j/3GmFB5pzAoEjBSgAV6VHaigwehiQ2lbpnU7UZ
         biS0xUioOK8jJq0a7QDiUz8N5LNdHECjYX+1RO6agHi/uvQwMutK4TPsO9pA1zWCwdNH
         14eI2AcLYWHYIQIWSicK/Ehra8cgJjACZS/imhFcNPhYhD2sWPVK2oxDCTg4U+emvVKw
         /rQ82Gw6vOlTvWs5FCnuQz183HaoTUAHWn1L2bNqVGp9zPFSBS6Xz3ibmQE4WDnX18OG
         70tSDrhG0qiZEU1J28Cye9drvsqtljLW5nojdEAQLgNAgYYuSjAy7CpjTa0iiD1IUkvI
         hIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723152881; x=1723757681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YmoLJUzKwh05YDZkUnFH4Q03LnbmDmhfqr83K75cyk=;
        b=l7SeBLiJtreKDt3sG50LnQneNwxP6OM+cpN3x8ysfE422o7ddA/K+Q/LBBuTMK5hiV
         YWI/XVwFbUFAlPr3/D6yZwpScHoDzv9YpVbEGFVQml2pR6Maf8d87AdIEQcxrdGqvsAr
         ELBX0Bt88fpJ7F+NEzTRTtUm1Dq6gbU/+lodGghUW32Bs425FRWbldNQWPxxMR+Rewci
         qHtNOhiwZDb6HiKMW+z+q9WOiCjWWGweyNo/gftQ6kcgo5B/sGyJ/XsWOSVcp07aXhUa
         H/lqIcLWUJ0wO38R/yH9FcDc0o9bm8Ue7q1geVXxlCwPjBhZz1ddN+bnT80OTBZuTVoq
         iDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZjgnlZTgM23RQOP5XwBTRCG6tJBUFGFkfPAdjjZ82dG2BrLHbaDTj50uSgy+IuRtjvI+4YI98guI4jqsHtjb3X1q/Jq2L4tA3
X-Gm-Message-State: AOJu0Yy54pNAR7DBEXnTxLJknEwq6uUXDlVH+AfItUNqGbzpkG5mRC7n
	1LKRVuhpuKxqm3lP49qpZ7ommwAvaZ6R+fUSOwFalKXPEY2F36FJrSRjOmKhivk=
X-Google-Smtp-Source: AGHT+IE4Qv1sn/qov17GIXusF8ykKagazq0LzzEpnGG7EXiIsWLtpNSrGNRu3rLDOXEBkRSnwDDAyA==
X-Received: by 2002:a05:6102:2acb:b0:492:ab05:8d6e with SMTP id ada2fe7eead31-495c5b38e89mr3764112137.3.1723152880951;
        Thu, 08 Aug 2024 14:34:40 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c762bd1sm70205026d6.29.2024.08.08.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 14:34:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	dan.j.williams@intel.com,
	yi.zhang@redhat.com,
	alison.schofield@intel.com,
	david@redhat.com,
	yosryahmed@google.com
Subject: [PATCH v4 2/3] mm: add system wide stats items category
Date: Thu,  8 Aug 2024 21:34:35 +0000
Message-ID: <20240808213437.682006-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240808213437.682006-1-pasha.tatashin@soleen.com>
References: <20240808213437.682006-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/proc/vmstat contains events and stats, events can only grow, but stats
can grow and shrink.

vmstat has the following:
-------------------------
NR_VM_ZONE_STAT_ITEMS:	per-zone stats
NR_VM_NUMA_EVENT_ITEMS:	per-numa events
NR_VM_NODE_STAT_ITEMS:	per-numa stats
NR_VM_WRITEBACK_STAT_ITEMS:	system-wide background-writeback and
				dirty-throttling tresholds.
NR_VM_EVENT_ITEMS:	system-wide events
-------------------------

Rename NR_VM_WRITEBACK_STAT_ITEMS to NR_VM_STAT_ITEMS, to track the
system-wide stats, we are going to add per-page metadata stats to this
category in the next patch.

Also delete unused writeback_stat_name() function.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/vmstat.h | 15 ++++-----------
 mm/vmstat.c            |  6 +++---
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 23cd17942036..9ab4fa5e09b5 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -34,10 +34,11 @@ struct reclaim_stat {
 	unsigned nr_lazyfree_fail;
 };
 
-enum writeback_stat_item {
+/* Stat data for system wide items */
+enum vm_stat_item {
 	NR_DIRTY_THRESHOLD,
 	NR_DIRTY_BG_THRESHOLD,
-	NR_VM_WRITEBACK_STAT_ITEMS,
+	NR_VM_STAT_ITEMS,
 };
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
@@ -514,21 +515,13 @@ static inline const char *lru_list_name(enum lru_list lru)
 	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
 }
 
-static inline const char *writeback_stat_name(enum writeback_stat_item item)
-{
-	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
-			   NR_VM_NUMA_EVENT_ITEMS +
-			   NR_VM_NODE_STAT_ITEMS +
-			   item];
-}
-
 #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
 static inline const char *vm_event_name(enum vm_event_item item)
 {
 	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
 			   NR_VM_NUMA_EVENT_ITEMS +
 			   NR_VM_NODE_STAT_ITEMS +
-			   NR_VM_WRITEBACK_STAT_ITEMS +
+			   NR_VM_STAT_ITEMS +
 			   item];
 }
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 04a1cb6cc636..6f8aa4766f16 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1257,7 +1257,7 @@ const char * const vmstat_text[] = {
 	"pgdemote_khugepaged",
 	"nr_memmap",
 	"nr_memmap_boot",
-	/* enum writeback_stat_item counters */
+	/* system-wide enum vm_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
 
@@ -1790,7 +1790,7 @@ static const struct seq_operations zoneinfo_op = {
 #define NR_VMSTAT_ITEMS (NR_VM_ZONE_STAT_ITEMS + \
 			 NR_VM_NUMA_EVENT_ITEMS + \
 			 NR_VM_NODE_STAT_ITEMS + \
-			 NR_VM_WRITEBACK_STAT_ITEMS + \
+			 NR_VM_STAT_ITEMS + \
 			 (IS_ENABLED(CONFIG_VM_EVENT_COUNTERS) ? \
 			  NR_VM_EVENT_ITEMS : 0))
 
@@ -1827,7 +1827,7 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
 			    v + NR_DIRTY_THRESHOLD);
-	v += NR_VM_WRITEBACK_STAT_ITEMS;
+	v += NR_VM_STAT_ITEMS;
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
 	all_vm_events(v);
-- 
2.46.0.76.ge559c4bf1a-goog

