Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48332366DA2
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846899; cv=none; b=LyVVBBMNeilC5CZ6SpFQaN19KC+/KT+Ylu+jCoofrV9ED78QKlTs3s9nyL3E1BnT7zEq4AfnGn6ki8ziyMlcmNfXoempWgzLyWIhDzu9vmetWkK3gfnEOoaePrBewqzmVVcGCWmbNRtOBp+gYa+Wk4vwCYt3TYI+kRBpOGN03Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846899; c=relaxed/simple;
	bh=KjN2am+60FyqL6Aw8fMJuBlsvtKu+gSJQr1kSgmtVPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roM14rV54C0vOV4YwTZMSu3s6l9ijwKUXTMiSR9K5pd3M2t0oIvR52klr/UdGAYsPoARNfg/NIAdkG5EHDGqvtA+IPhzFjNU7NYZQjYDo840MB9dnskAfJAFFncxvbcTtNtlkeDvuK4n0RyQkHVTqGro29QQidZxQJ3MYDUGwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Gc2PyINH; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Gc2PyINH"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89545bd3324so72148266d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770846895; x=1771451695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wY7FoCoT6W3h+FhLeVYQDgJWzgS3oWiQlGuojbJGq/I=;
        b=Gc2PyINHKvcQribH74dAptXxwn9ixQmCAALKf+1qt7Tr4UkiyzrCYjDanjcdXUa5gB
         kbPqXjMDJqdQmE29oKu17r1K4OmJFDfbm+Lvzr2b0p1+B74kIAqhiZsV8FbxG3jIEphh
         UEO9L7ZCmVYTf8ehJtjVjSGRKEPitvhOXnM5thj5q+tZH6e06m6wtyDEQvg3cUXxZ5ex
         x0EoH7/1zWVBltBuJOf6LQhq10I4vJMQzXAmED3g1TEVaE9P7fYaiQOdNi1FyR/F1fFN
         FYikpMgy7pKIXxYTQkZRTxDVzI912KoBaGwJwF1dsDey6xN3ROrkhwbVdQX27vqbEfyS
         2gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770846895; x=1771451695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY7FoCoT6W3h+FhLeVYQDgJWzgS3oWiQlGuojbJGq/I=;
        b=BhMbd2bA//i0CqytvAB51k2DUD4/Dv69tHRRn2px+ecJlvltHweRPNClmwjmIho9s+
         0FWumGBNv4mFbljzNaF0dHVaJdqNf//fyim6UbmKgPd6X4wqFJD9ojVA5R75YcCu0DCc
         wspMtBmy3tlgxdVyWIKO1TNr51BSGguzzWWnGp1xOvPXbMCxcU0l9ik3dYKzHeAiafW3
         YOSMQJWv5aL92c6IRu30s08LVmAKKQzpf6t1UPGtQg1GNveqvB7fS2Uh/sXrxYxzEvpJ
         ErrrHV1Rvluyw5oEQ5pJDs3zTHEbpT9C9eVnKRcHLWhl7wymTa/x7scQGHUE3qRFb18j
         2UIg==
X-Gm-Message-State: AOJu0YygBzzSmSSqtppFd/Vi+593aFUYigiuKW7fEKQ7Ro+k2p1oYcmg
	ub7Ms3qKQ32hsgB+pvhuf+9Lft+icNCALNoBUaRbxE8UCDPBcFX2Yj9gNgIFxhRQw3g=
X-Gm-Gg: AZuq6aLk7jr55V3C0m+5qvATCtf06D3lO6F3uJMF219JCe0dXkXt4JM0iTegoYlte1B
	zb+mCVcKqBH5YeFAQXA2b0vGsog2QQ33Njk2DFPuG4IWMIk7YmEgFlZCwytm7iDlOCjeFDrzWZy
	I5d99qHh7GIuJuB3qCD9B8Yt0irAnCC8Uz53TJYngz2EW/Wj45GoIP+frE6KWjjDMAMeItt/wh5
	cp41OJHokoGRU/wTQ7S2Vlr+tf7he5rAW8pDKYwJlfJLOONH48thXqh/zvm4oYOcMG9rQG7vi8u
	1tQ6lRKabxGxzAtRXVQ1eVY37zaxJAPvxkl3vv76K2bSjavsNHVdA1j2svgfp/9O8Ukf0o8ICx/
	2axxLKFtamu2Im40KWcOVKoJrN9ekEMRBcSTxiueh6ujhSqO7gZYILb5gSwHVGRwjMUq4yfEdZM
	XWy6BxIHU1GxKVzs8cDBjAN49A12HcVPyXTcxn8o4Kmdgq7yxRLGYKjo0Z9tSbLph0bPkXg9NF+
	Mnxeyp7Mv9C2/Q=
X-Received: by 2002:a05:6214:258a:b0:893:42f1:ebb with SMTP id 6a1803df08f44-897279b27a6mr15748206d6.24.1770846894943;
        Wed, 11 Feb 2026 13:54:54 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdb5f26sm23742686d6.42.2026.02.11.13.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 13:54:54 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH] mm: name the anonymous MMOP enum as enum mmop
Date: Wed, 11 Feb 2026 16:54:47 -0500
Message-ID: <20260211215447.2194189-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Give the MMOP enum (MMOP_OFFLINE, MMOP_ONLINE, etc) a proper type
name so the compiler can help catch invalid values being assigned to
variables of this type.

Leave the existing functions returning int alone to allow for
value-or-error pattern to remain unchanged without churn.

mmop_default_online_type is left as int because it uses the -1
sentinal value to signal it hasn't been initialized yet.

Keep the uint8_t buffer in offline_and_remove_memory() as-is for
space efficiency, with an explicit cast when we consume the value.

Move the enum definition before the CONFIG_MEMORY_HOTPLUG guard so
it is unconditionally available for struct memory_block in memory.h.

No functional change.

Link: https://lore.kernel.org/linux-mm/3424eba7-523b-4351-abd0-3a888a3e5e61@kernel.org/
Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Suggested-by: "David Hildenbrand (arm)" <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/memory.c          |  2 +-
 include/linux/memory.h         |  3 ++-
 include/linux/memory_hotplug.h | 16 ++++++++--------
 mm/memory_hotplug.c            | 10 +++++-----
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 751f248ca4a8..3753ca80069d 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -452,7 +452,7 @@ static ssize_t phys_device_show(struct device *dev,
 static int print_allowed_zone(char *buf, int len, int nid,
 			      struct memory_group *group,
 			      unsigned long start_pfn, unsigned long nr_pages,
-			      int online_type, struct zone *default_zone)
+			      enum mmop online_type, struct zone *default_zone)
 {
 	struct zone *zone;
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index faeaa921e55b..5bb5599c6b2b 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -19,6 +19,7 @@
 #include <linux/node.h>
 #include <linux/compiler.h>
 #include <linux/mutex.h>
+#include <linux/memory_hotplug.h>
 
 #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
 
@@ -77,7 +78,7 @@ enum memory_block_state {
 struct memory_block {
 	unsigned long start_section_nr;
 	enum memory_block_state state;	/* serialized by the dev->lock */
-	int online_type;		/* for passing data to online routine */
+	enum mmop online_type;	/* for passing data to online routine */
 	int nid;			/* NID for this memory block */
 	/*
 	 * The single zone of this memory block if all PFNs of this memory block
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f2f16cdd73ee..e77ef3d7ff73 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -16,11 +16,8 @@ struct resource;
 struct vmem_altmap;
 struct dev_pagemap;
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-struct page *pfn_to_online_page(unsigned long pfn);
-
 /* Types for control the zone type of onlined and offlined memory */
-enum {
+enum mmop {
 	/* Offline the memory. */
 	MMOP_OFFLINE = 0,
 	/* Online the memory. Zone depends, see default_zone_for_pfn(). */
@@ -31,6 +28,9 @@ enum {
 	MMOP_ONLINE_MOVABLE,
 };
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+struct page *pfn_to_online_page(unsigned long pfn);
+
 /* Flags for add_memory() and friends to specify memory hotplug details. */
 typedef int __bitwise mhp_t;
 
@@ -286,8 +286,8 @@ static inline void __remove_memory(u64 start, u64 size) {}
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /* Default online_type (MMOP_*) when new memory blocks are added. */
-extern int mhp_get_default_online_type(void);
-extern void mhp_set_default_online_type(int online_type);
+extern enum mmop mhp_get_default_online_type(void);
+extern void mhp_set_default_online_type(enum mmop online_type);
 extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
 extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
@@ -310,8 +310,8 @@ extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
 				  struct vmem_altmap *altmap);
 extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
-extern struct zone *zone_for_pfn_range(int online_type, int nid,
-		struct memory_group *group, unsigned long start_pfn,
+extern struct zone *zone_for_pfn_range(enum mmop online_type,
+		int nid, struct memory_group *group, unsigned long start_pfn,
 		unsigned long nr_pages);
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a63ec679d861..41f48f493b8e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -221,7 +221,7 @@ void put_online_mems(void)
 bool movable_node_enabled = false;
 
 static int mhp_default_online_type = -1;
-int mhp_get_default_online_type(void)
+enum mmop mhp_get_default_online_type(void)
 {
 	if (mhp_default_online_type >= 0)
 		return mhp_default_online_type;
@@ -240,7 +240,7 @@ int mhp_get_default_online_type(void)
 	return mhp_default_online_type;
 }
 
-void mhp_set_default_online_type(int online_type)
+void mhp_set_default_online_type(enum mmop online_type)
 {
 	mhp_default_online_type = online_type;
 }
@@ -1046,7 +1046,7 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
 	return movable_node_enabled ? movable_zone : kernel_zone;
 }
 
-struct zone *zone_for_pfn_range(int online_type, int nid,
+struct zone *zone_for_pfn_range(enum mmop online_type, int nid,
 		struct memory_group *group, unsigned long start_pfn,
 		unsigned long nr_pages)
 {
@@ -2305,7 +2305,7 @@ EXPORT_SYMBOL_GPL(remove_memory);
 
 static int try_offline_memory_block(struct memory_block *mem, void *arg)
 {
-	uint8_t online_type = MMOP_ONLINE_KERNEL;
+	enum mmop online_type = MMOP_ONLINE_KERNEL;
 	uint8_t **online_types = arg;
 	struct page *page;
 	int rc;
@@ -2338,7 +2338,7 @@ static int try_reonline_memory_block(struct memory_block *mem, void *arg)
 	int rc;
 
 	if (**online_types != MMOP_OFFLINE) {
-		mem->online_type = **online_types;
+		mem->online_type = (enum mmop)**online_types;
 		rc = device_online(&mem->dev);
 		if (rc < 0)
 			pr_warn("%s: Failed to re-online memory: %d",
-- 
2.47.3

