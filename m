Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597C15FA93
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230628; cv=none; b=J3EF+ppunRhnOwvwRjFoG+097g4BSNjMZt4Pod3WaIqYMbDLr1Wb7d7nXjHT/zIXEz1e0hAkNA3Rg92g/V1h8TGByeATipoJjtGsc1DqLHzmNbmF3H5aRH02TTcI+CTg1d7XR/yADE24gaWeXYLxCaLFijvQP2aia7THokaYBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230628; c=relaxed/simple;
	bh=Aha4j24gTv25dSzcVlCBqTJydrCO5rRdT3UBoRvJktc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9kZv6DL6Qv4tZXlXB9nNkt00o8A+Cu7MnO0Uux7sqTxgPgTF2T4a5jmXSn+VU/4dDcGKe33fPvGw1lfqfvFCyHKBHEPjPEO0w916fIxTGad7xe/0HnXHHVLgoS3E+egZe613k265YcCTPoQkEEG3I4S5f58EBPeNvbcu5EMLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=W0SlrJ8d; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="W0SlrJ8d"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1e31bc1efso142574785a.3
        for <linux-cxl@vger.kernel.org>; Fri, 09 Aug 2024 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723230626; x=1723835426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDvms9T6MxTADOWyeqlGsrri9pz592+CY2RkeRJgrNo=;
        b=W0SlrJ8dbIHN45msSdxOC1t1XlDnfj5hJnvBnGs0v/8iPolrhGGVFH/ah3RZQsAqaZ
         P5QXoFhah9kmzTyAuqQiNZyZYp1l2uaY4g8k2rUaIIlx1Mkd6zxDecujY6sXXLdmBzoJ
         6/iJICH0XNEzWKEoV0yo/Y/Ur1C2eEjA1ltBit+EQA1hH6R20gbogg4qAXwGZZqsDKGN
         iZ5I0RVpn+OoJkWCa0kv+JuWLHFOerxctwwROnnp5MgvrX2QZXOh+neV4M7ec6MjkO6g
         CqDtKUlm5b/Pbq21Wgi2ZADYG+Ju1EB7Xxpof5KV20e8mP9fC+iMT/ioOcv32qiCV5jx
         34sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230626; x=1723835426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDvms9T6MxTADOWyeqlGsrri9pz592+CY2RkeRJgrNo=;
        b=tRfqsyrqVA9ERdMwnrfDqqbgwCP/Ya2+pvVtp/abk1gPIU7ywYvb/WlWIXpQ3tMD35
         GSv8Hmk2YW58P/Wm2GHc/5dUkPBE00onpf6iEweAqpdBckqB8u6piKaLCFfAdvw9gnx/
         lLGLjMjY0sZ1uaUIHYh64r6VoErBg449M8ZZk54SmfPRfy3RiinmA+pl5ZNAGELA7p9b
         f8xqkCorBlCLR/04RfkguuimI0eQ7B+L8cKEYHJY+7lPCrPtEHpIdMI61rK7PSrds8W7
         NSDClKA9vwlOw3ncxOCrczk9Ugh0NrCCvepzC/DXyKR8xAsc/0swNjf1Fw8JJro87ZuN
         +rTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4jfsZR2LxqNNnPQHsVe7r4m1tjhXOqruPaFe/wfyIAgVaP4v/hUQCJvo+KorEUvnTivHliwfA93l1FKfdEgFBKp14ACiV1DOZ
X-Gm-Message-State: AOJu0Yy7VlTj6SvpJBUCXXnCe8BthCVRV1FQWC/4JVGk7VLPkcVauFgg
	zMmcxfNsu3XHwUhb3stAAH06VPOkwHkWPYxrFsKrvsTCPf4Got0sF+hE6VpEIkc=
X-Google-Smtp-Source: AGHT+IFVg6UC1VsS2RarQnkmKfDpYYqkAoGLJP6WPhI6t59slYlLQRhsj/YpVmXHJEFlokfsL93xgA==
X-Received: by 2002:a05:620a:2495:b0:79f:67b:4fdc with SMTP id af79cd13be357-7a4c1791fd1mr330555485a.2.1723230626022;
        Fri, 09 Aug 2024 12:10:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7df5a55sm5522085a.86.2024.08.09.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:10:25 -0700 (PDT)
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
Subject: [PATCH v5 2/3] mm: add system wide stats items category
Date: Fri,  9 Aug 2024 19:10:19 +0000
Message-ID: <20240809191020.1142142-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240809191020.1142142-1-pasha.tatashin@soleen.com>
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
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

