Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D31139CF2;
	Wed,  2 Apr 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621108; cv=none; b=pn5I9Pl8PAElb9wxCfL71mG14hAs28HMNCI8EeYp0LPp3LWGYUM382uigjZGQGeINFlB7IX48umJOzyGe7nnQ+sMYVhOSnMiZzeP7KeKrxE/QLJ8XwsiqCcjf9Do7+zeWQkvjiOqAfpW0JtCeMHIulGACj5ZMKK5u6mOeivHu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621108; c=relaxed/simple;
	bh=rZQrxSe5a6MLgywflm9dTeD9NzFbsRt/YPsxjCqa6IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9+c+47CTKmLFgXTMJQdmifVCGZKvnhCRHJHgS9yhX95KqaPg9MbA8o9UW5zccMiovFf+MAlyElt8TCQLEbCP3h95QwiA6FR3pMDlGiMN9f4m7gOOJlsf9TNfWMRquHHijLJk5G1WpIzKt7po71VRNg7hYb0oU1iFI6UifY987M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXfW6xNZ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXfW6xNZ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6feb229b716so1676407b3.3;
        Wed, 02 Apr 2025 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743621106; x=1744225906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hugjdKQ+ZgP9n9IK0KpVI4y8Euv3bvaVXpqEaZlua4Q=;
        b=LXfW6xNZzlfbrpOl4JoGPKk1BecQ5JTjqbAKCSNY76kJ2gjAalGv1YSMR+kkBrkGc3
         /iRV0jqFy91DVaIYXL8uRteiknkxDgLoiJ6Nvbf8pFlDYlhLuNFKmr60j15eecsquAlx
         6+gpBGtLcxUMxuIEPO5Fzx5XJbMzo7dYfs6IgyBV5584YSBVpfwDLUSjYEYjXQvvo+Ib
         fP33fCqZpa8zv2EFSz4kt7oq4XQB1uavvvG9fS9MXetnIMqRgTkCtJ5BlB4VoLEfaPog
         IiUuRXiXd8p02PKxHtAkXESM+IiO9qE/46qlMMSzNf2E5fioItEUDaoDgQtS1D0UhaX+
         FSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743621106; x=1744225906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hugjdKQ+ZgP9n9IK0KpVI4y8Euv3bvaVXpqEaZlua4Q=;
        b=F8Mp7L6lcHDN7YL4+vFmpY2ewyM3p7TdQe8wFxQWZBAp56U/uVg9RP2rgdW9OklZ2r
         LvwFJOyrtpq/riqIffLrXvXDlKeTUvh72RBuxzthFXWzZG8jXFD6uvHDQ7o6+PB2S8B1
         YZvGfqm+mnpyPG3HPCTi8o0soLAmfTlpsM93xLfNiYDeas0WlkveFcSWZFB9ywXPo//T
         WouA48BWq2ZH7bnsHPIC3YP4EKYFyg2Yr43iMrbjXFLoTrKR0F+GZS6EOh7gNsvbbQW4
         MCqPBOD9ktnBLxXeQ3sgqmPiFj7P18L5P4RES18tW2vXdQxZRpLcP/qiKyAMMAym40JW
         9QkA==
X-Forwarded-Encrypted: i=1; AJvYcCU36BBFgwbb0H7R6Fm7GLY/II85kNBdyz015KNb1ypoTWEenPLOQtVKGGmG9fGQ79lu9kPAF+WvqrOGX2s3@vger.kernel.org, AJvYcCXKCgfPDHr28Mm6M58NOxgZc36odeoc+IOYNFh4znQ+6ygT2tO6tAZWDVVEhPma++28mqd1vrTXl1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmf4OUPerHcWMfrA0xHY02cF2cYbwGnzm9LFbYmIO8jRSH+AtE
	KTDzvZtQLsJYCR7WcTNSRnLdrVO7PUvu2b/yZLk3/IhmlsF8jXyt2m7r5A==
X-Gm-Gg: ASbGnct3E5o78x+VZegIvLZ9mnQJ0RTPOS8FM0LdIVSjPVgNICNsvmLAnvaj6+ivm+L
	/RfKJjOXqXrQpH3BpPCGx5gDOeIWfcwdPzt/P4rj+vvX0+PMgURvxGXQTysBapZkUtFYJPBknHV
	WYfEGozwETGQ8L/FqyWiVL62exfCsFjiX/GE6KDyu1hP1q0Oj8wJjCOqLBBUmrnbECWDNZduGBN
	i3CWKJCsaJfUd62oM7ttC6w3kqZ97UvgkAQ5jhrVaNy6K8IgeIs+2PwDwbbNZa7yuGmAlk6L4eu
	qq3hNPU+vAgdPLt6bryItNx5pQiE3ZNJnbYPhm0bV0ryhCc=
X-Google-Smtp-Source: AGHT+IHlO9Ha/7YLYabER5MI1ixhiQPH6SpxlryPlhe6JKDN5HBzN9a0LLhpVn/QLfCTiAX2uYaJMw==
X-Received: by 2002:a05:690c:708c:b0:6fe:d759:b178 with SMTP id 00721157ae682-703d079ddacmr1950077b3.6.1743621105662;
        Wed, 02 Apr 2025 12:11:45 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a37b4f0sm34321607b3.37.2025.04.02.12.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 12:11:45 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	sj@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	jonathan.cameron@huawei.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	minchan@kernel.org,
	senozhatsky@chromium.org
Subject: [PATCH] zswap/zsmalloc: prefer the the original page's node for compressed data
Date: Wed,  2 Apr 2025 12:11:45 -0700
Message-ID: <20250402191145.2841864-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, zsmalloc, zswap's backend memory allocator, does not enforce
any policy for the allocation of memory for the compressed data,
instead just adopting the memory policy of the task entering reclaim,
or the default policy (prefer local node) if no such policy is
specified. This can lead to several pathological behaviors in
multi-node NUMA systems:

1. Systems with CXL-based memory tiering can encounter the following
   inversion with zswap: the coldest pages demoted to the CXL tier
   can return to the high tier when they are zswapped out, creating
   memory pressure on the high tier.

2. Consider a direct reclaimer scanning nodes in order of allocation
   preference. If it ventures into remote nodes, the memory it
   compresses there should stay there. Trying to shift those contents
   over to the reclaiming thread's preferred node further *increases*
   its local pressure, and provoking more spills. The remote node is
   also the most likely to refault this data again. This undesirable
   behavior was pointed out by Johannes Weiner in [1].

3. For zswap writeback, the zswap entries are organized in
   node-specific LRUs, based on the node placement of the original
   pages, allowing for targeted zswap writeback for specific nodes.

   However, the compressed data of a zswap entry can be placed on a
   different node from the LRU it is placed on. This means that reclaim
   targeted at one node might not free up memory used for zswap entries
   in that node, but instead reclaiming memory in a different node.

All of these issues will be resolved if the compressed data go to the
same node as the original page. This patch encourages this behavior by
having zswap pass the node of the original page to zsmalloc, and have
zsmalloc prefer the specified node if we need to allocate new (zs)pages
for the compressed data.

Note that we are not strictly binding the allocation to the preferred
node. We still allow the allocation to fall back to other nodes when
the preferred node is full, or if we have zspages with slots available
on a different node. This is OK, and still a strict improvement over
the status quo:

1. On a system with demotion enabled, we will generally prefer
   demotions over zswapping, and only zswap when pages have
   already gone to the lowest tier. This patch should achieve the
   desired effect for the most part.

2. If the preferred node is out of memory, letting the compressed data
   going to other nodes can be better than the alternative (OOMs,
   keeping cold memory unreclaimed, disk swapping, etc.).

3. If the allocation go to a separate node because we have a zspage
   with slots available, at least we're not creating extra immediate
   memory pressure (since the space is already allocated).

3. While there can be mixings, we generally reclaim pages in
   same-node batches, which encourage zspage grouping that is more
   likely to go to the right node.

4. A strict binding would require partitioning zsmalloc by node, which
   is more complicated, and more prone to regression, since it reduces
   the storage density of zsmalloc. We need to evaluate the tradeoff
   and benchmark carefully before adopting such an involved solution.

This patch does not fix zram, leaving its memory allocation behavior
unchanged. We leave this effort to future work.

[1]: https://lore.kernel.org/linux-mm/20250331165306.GC2110528@cmpxchg.org/

Suggested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zpool.h |  4 +--
 mm/zpool.c            |  8 +++---
 mm/zsmalloc.c         | 60 ++++++++++++++++++++++++++++++-------------
 mm/zswap.c            |  2 +-
 4 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index 52f30e526607..697525cb00bd 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -22,7 +22,7 @@ const char *zpool_get_type(struct zpool *pool);
 void zpool_destroy_pool(struct zpool *pool);
 
 int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
-			unsigned long *handle);
+			unsigned long *handle, const int nid);
 
 void zpool_free(struct zpool *pool, unsigned long handle);
 
@@ -64,7 +64,7 @@ struct zpool_driver {
 	void (*destroy)(void *pool);
 
 	int (*malloc)(void *pool, size_t size, gfp_t gfp,
-				unsigned long *handle);
+				unsigned long *handle, const int nid);
 	void (*free)(void *pool, unsigned long handle);
 
 	void *(*obj_read_begin)(void *pool, unsigned long handle,
diff --git a/mm/zpool.c b/mm/zpool.c
index 6d6d88930932..b99a7c03e735 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -226,20 +226,22 @@ const char *zpool_get_type(struct zpool *zpool)
  * @size:	The amount of memory to allocate.
  * @gfp:	The GFP flags to use when allocating memory.
  * @handle:	Pointer to the handle to set
+ * @nid:	The preferred node id.
  *
  * This allocates the requested amount of memory from the pool.
  * The gfp flags will be used when allocating memory, if the
  * implementation supports it.  The provided @handle will be
- * set to the allocated object handle.
+ * set to the allocated object handle. The allocation will
+ * prefer the NUMA node specified by @nid.
  *
  * Implementations must guarantee this to be thread-safe.
  *
  * Returns: 0 on success, negative value on error.
  */
 int zpool_malloc(struct zpool *zpool, size_t size, gfp_t gfp,
-			unsigned long *handle)
+			unsigned long *handle, const int nid)
 {
-	return zpool->driver->malloc(zpool->pool, size, gfp, handle);
+	return zpool->driver->malloc(zpool->pool, size, gfp, handle, nid);
 }
 
 /**
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 961b270f023c..0b8a8c445fc2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -243,9 +243,24 @@ static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
 	dec_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
 }
 
-static inline struct zpdesc *alloc_zpdesc(gfp_t gfp)
+static inline struct zpdesc *alloc_zpdesc(gfp_t gfp, const int *nid)
 {
-	struct page *page = alloc_page(gfp);
+	struct page *page;
+
+	if (nid)
+		page = alloc_pages_node(*nid, gfp, 0);
+	else {
+		/*
+		 * XXX: this is the zram path. We should consider fixing zram to also
+		 * use alloc_pages_node() and prefer the same node as the original page.
+		 *
+		 * Note that alloc_pages_node(NUMA_NO_NODE, gfp, 0) is not equivalent
+		 * to allloc_page(gfp). The former will prefer the local/closest node,
+		 * whereas the latter will try to follow the memory policy of the current
+		 * process.
+		 */
+		page = alloc_page(gfp);
+	}
 
 	return page_zpdesc(page);
 }
@@ -461,10 +476,13 @@ static void zs_zpool_destroy(void *pool)
 	zs_destroy_pool(pool);
 }
 
+static unsigned long zs_malloc_node(struct zs_pool *pool, size_t size,
+				gfp_t gfp, const int *nid);
+
 static int zs_zpool_malloc(void *pool, size_t size, gfp_t gfp,
-			unsigned long *handle)
+			unsigned long *handle, const int nid)
 {
-	*handle = zs_malloc(pool, size, gfp);
+	*handle = zs_malloc_node(pool, size, gfp, &nid);
 
 	if (IS_ERR_VALUE(*handle))
 		return PTR_ERR((void *)*handle);
@@ -1044,7 +1062,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
  */
 static struct zspage *alloc_zspage(struct zs_pool *pool,
 					struct size_class *class,
-					gfp_t gfp)
+					gfp_t gfp, const int *nid)
 {
 	int i;
 	struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE];
@@ -1061,7 +1079,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct zpdesc *zpdesc;
 
-		zpdesc = alloc_zpdesc(gfp);
+		zpdesc = alloc_zpdesc(gfp, nid);
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
@@ -1331,17 +1349,8 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 }
 
 
-/**
- * zs_malloc - Allocate block of given size from pool.
- * @pool: pool to allocate from
- * @size: size of block to allocate
- * @gfp: gfp flags when allocating object
- *
- * On success, handle to the allocated object is returned,
- * otherwise an ERR_PTR().
- * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
- */
-unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
+static unsigned long zs_malloc_node(struct zs_pool *pool, size_t size,
+				gfp_t gfp, const int *nid)
 {
 	unsigned long handle;
 	struct size_class *class;
@@ -1376,7 +1385,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 
 	spin_unlock(&class->lock);
 
-	zspage = alloc_zspage(pool, class, gfp);
+	zspage = alloc_zspage(pool, class, gfp, nid);
 	if (!zspage) {
 		cache_free_handle(pool, handle);
 		return (unsigned long)ERR_PTR(-ENOMEM);
@@ -1397,6 +1406,21 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 
 	return handle;
 }
+
+/**
+ * zs_malloc - Allocate block of given size from pool.
+ * @pool: pool to allocate from
+ * @size: size of block to allocate
+ * @gfp: gfp flags when allocating object
+ *
+ * On success, handle to the allocated object is returned,
+ * otherwise an ERR_PTR().
+ * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
+ */
+unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
+{
+	return zs_malloc_node(pool, size, gfp, NULL);
+}
 EXPORT_SYMBOL_GPL(zs_malloc);
 
 static void obj_free(int class_size, unsigned long obj)
diff --git a/mm/zswap.c b/mm/zswap.c
index 204fb59da33c..455e9425c5f5 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -981,7 +981,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 
 	zpool = pool->zpool;
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
-	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle);
+	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle, page_to_nid(page));
 	if (alloc_ret)
 		goto unlock;
 

base-commit: 8c65b3b82efb3b2f0d1b6e3b3e73c6f0fd367fb5
-- 
2.47.1

