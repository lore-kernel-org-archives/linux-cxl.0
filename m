Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9081B85F8;
	Sat, 29 Mar 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743246154; cv=none; b=Qx7LPekO0Jaw8x4e5vYdssGKNpka6l9wR4cuvtT786xsScDzcFFcrBNTFZZbrz2We+DHT2cdgDhWG+W6PYjW1Mdn5N6Br+MDXRoei1eys41pl1eOd7F/G5ezzNi8p4GalMLva0W09YPHe4MCWMAyGEDNnJnka1/c2GG+cKijmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743246154; c=relaxed/simple;
	bh=tZ4f6/CXfzvpfMponKwg1beNNyQ2Z9N8H55MQFbCqyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGtUSH5Mk3nGzrBSR7MZWnPuvzYEKQf6RAReOKxEepR48giro5GYRCV1VlqXwH3BmXwuKBeywCZHKHbLQts7wvBpui66+glI6GbmuzuV7fX81vW0ODIXv5j+lKS/wY/WYAE7iuqX5/UXvz/SFQlMoIwcqbLKDkOCtYqxKPknGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYH5pbHH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYH5pbHH"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fead317874so24389247b3.0;
        Sat, 29 Mar 2025 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743246152; x=1743850952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kegP2Jo+VMPuo6fd4UmkQV/L75LMJeE5mnVS5qzL0Sk=;
        b=QYH5pbHHPYBA6yyO5oTsAPubVNKm8a8Wxmm8YRgx4Zh/XM3gp8pROGY1UKZ9Ef7PrJ
         xio0rIyIS0fAYEn1ghTVEoCOpQyu9k3+YyCi9IBQXy/WFQQFExUiOcK1qxXq8CXc+96R
         fz/18jebDYBR3GhzBWcm5yoQTOZqT/KlXZ0OHmc1Gdn1E3SPFixIPiGNX7dW2LiAY2my
         PJ2++uSTU+szZmuIsy0Tu86eX+UJyFdYYp6ao+aKwiIOc/gi50XnvZqFN1gPJLDAgInb
         f7oJTarP7372afIT+lwlLm/5tO7u9XVe4eHt0G1F/QaTNsvGshYyN4YpEinaBOatBVhS
         e2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743246152; x=1743850952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kegP2Jo+VMPuo6fd4UmkQV/L75LMJeE5mnVS5qzL0Sk=;
        b=ckCF2u1lkbA7l2HX5tZsoGts+yWQoXDdkm0ZcKvOCCKnHeIk7racMhANDd1u389Wi0
         p9Cnqo/+iCqP19tT4IPimixKBBRgIDjA/gJT0HaVfodKDab8i+JH57RmAuQaIwbjaC+i
         i2h+kMss5HL5jNW1B7/Y9ZkaPiHC3JU1EmDLT2vA2imSuiDnaRcP7QBa2C1dcqf/1XNR
         jkm13hVdnJ2japvpTCEinZOV+MR184PqvhR2LZSLoV7zYrtNBjD/yfGISdv7sijlUPBr
         OZhimmyoHBArmVbNA1oq3VyFmguPrBfHLnt5i1WmvYyC4cKyEMmNKRTssVZeORNzYfFo
         TlpA==
X-Forwarded-Encrypted: i=1; AJvYcCVi3qST9w8GGF5NFFJPAaYG8xs5nO7vishbkzIjiB4jyWJUgtOY6xMjRYue8x4dJQvJUFe9uaNdSgaxetRM@vger.kernel.org, AJvYcCWu1rSw3n2WJrVm2GlrNdSfS5y0GRQ+qSFidVAfp0/6r12F5ydYrYJokNTKVdFoeXlNSSoRafWgrDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEv6G9WS5zbSm4H9JMNEHNL8Us6eOsHt/WQBbq1ImBVh8ShuSp
	U/bWQsSt5aq/s/nZJ5wUBv5i+rEWGhJlln7+c4WCCqkizMb74sQS
X-Gm-Gg: ASbGncuaniudq3J0GexWO4rdxJS5A4O2N/hhV8FP1RQGmaimaW3Y9ZWIkXT/BLeuttk
	La2l7x/XbXmYHgpdwa10OHapcU/TNVdeHqK29nT10wGgbHRC57rzC4yOgdI7RInBU0hFO9D4DRa
	mXXwVM6Qw02vLUxBYAW3Fq1jQzfCtFGXWCk5Uy0y5uooyjz+Q/j5yF+HLzlg9tpigZR7NrX3c/t
	H1t867DKCB/H0PP7zHjf+jAEus7vLbV59pHd/H5mBxPm8MgobK9cMfqKeYSOly6rix63293LZin
	w3IAkW4QUf6zvNjznOK7LWofe/2S3qiyCIE=
X-Google-Smtp-Source: AGHT+IHikDbBrpRKSVoBBQy51oPmCJRoYjyoDV6yCD03iCJCyGOuBriJFADH30/J3Ck31T0ONMVQVw==
X-Received: by 2002:a05:690c:f89:b0:6fd:a226:fb74 with SMTP id 00721157ae682-702570af283mr30024487b3.4.1743246152024;
        Sat, 29 Mar 2025 04:02:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a98a230sm11888717b3.73.2025.03.29.04.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 04:02:31 -0700 (PDT)
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
	willy@infradead.org,
	ying.huang@linux.alibaba.com,
	jonathan.cameron@huawei.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	minchan@kernel.org,
	senozhatsky@chromium.org
Subject: [RFC PATCH 1/2] zsmalloc: let callers select NUMA node to store the compressed objects
Date: Sat, 29 Mar 2025 04:02:29 -0700
Message-ID: <20250329110230.2459730-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250329110230.2459730-1-nphamcs@gmail.com>
References: <20250329110230.2459730-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Curerntly, zsmalloc does not specify any memory policy when it allocates
memory for the compressed objects.

Let users select the NUMA node for the memory allocation, through the
zpool-based API. Direct callers (i.e zram) should not observe any
behavioral change.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zpool.h |  4 ++--
 mm/zpool.c            |  8 +++++---
 mm/zsmalloc.c         | 28 +++++++++++++++++++++-------
 mm/zswap.c            |  2 +-
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index 52f30e526607..0df8722e13d7 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -22,7 +22,7 @@ const char *zpool_get_type(struct zpool *pool);
 void zpool_destroy_pool(struct zpool *pool);
 
 int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
-			unsigned long *handle);
+			unsigned long *handle, int *nid);
 
 void zpool_free(struct zpool *pool, unsigned long handle);
 
@@ -64,7 +64,7 @@ struct zpool_driver {
 	void (*destroy)(void *pool);
 
 	int (*malloc)(void *pool, size_t size, gfp_t gfp,
-				unsigned long *handle);
+				unsigned long *handle, int *nid);
 	void (*free)(void *pool, unsigned long handle);
 
 	void *(*obj_read_begin)(void *pool, unsigned long handle,
diff --git a/mm/zpool.c b/mm/zpool.c
index 6d6d88930932..591a13b99755 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -226,20 +226,22 @@ const char *zpool_get_type(struct zpool *zpool)
  * @size:	The amount of memory to allocate.
  * @gfp:	The GFP flags to use when allocating memory.
  * @handle:	Pointer to the handle to set
+ * @nid:	Pointer to the preferred node id.
  *
  * This allocates the requested amount of memory from the pool.
  * The gfp flags will be used when allocating memory, if the
  * implementation supports it.  The provided @handle will be
- * set to the allocated object handle.
+ * set to the allocated object handle. If @nid is provided, the
+ * allocation will prefer the specified node.
  *
  * Implementations must guarantee this to be thread-safe.
  *
  * Returns: 0 on success, negative value on error.
  */
 int zpool_malloc(struct zpool *zpool, size_t size, gfp_t gfp,
-			unsigned long *handle)
+			unsigned long *handle, int *nid)
 {
-	return zpool->driver->malloc(zpool->pool, size, gfp, handle);
+	return zpool->driver->malloc(zpool->pool, size, gfp, handle, nid);
 }
 
 /**
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 961b270f023c..35f61f14c32e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -243,9 +243,14 @@ static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
 	dec_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
 }
 
-static inline struct zpdesc *alloc_zpdesc(gfp_t gfp)
+static inline struct zpdesc *alloc_zpdesc(gfp_t gfp, int *nid)
 {
-	struct page *page = alloc_page(gfp);
+	struct page *page;
+
+	if (nid)
+		page = alloc_pages_node(*nid, gfp, 0);
+	else
+		page = alloc_page(gfp);
 
 	return page_zpdesc(page);
 }
@@ -461,10 +466,13 @@ static void zs_zpool_destroy(void *pool)
 	zs_destroy_pool(pool);
 }
 
+static unsigned long zs_malloc_node(struct zs_pool *pool, size_t size,
+				gfp_t gfp, int *nid);
+
 static int zs_zpool_malloc(void *pool, size_t size, gfp_t gfp,
-			unsigned long *handle)
+			unsigned long *handle, int *nid)
 {
-	*handle = zs_malloc(pool, size, gfp);
+	*handle = zs_malloc_node(pool, size, gfp, nid);
 
 	if (IS_ERR_VALUE(*handle))
 		return PTR_ERR((void *)*handle);
@@ -1044,7 +1052,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
  */
 static struct zspage *alloc_zspage(struct zs_pool *pool,
 					struct size_class *class,
-					gfp_t gfp)
+					gfp_t gfp, int *nid)
 {
 	int i;
 	struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE];
@@ -1061,7 +1069,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct zpdesc *zpdesc;
 
-		zpdesc = alloc_zpdesc(gfp);
+		zpdesc = alloc_zpdesc(gfp, nid);
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
@@ -1342,6 +1350,12 @@ static unsigned long obj_malloc(struct zs_pool *pool,
  * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
  */
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
+{
+	return zs_malloc_node(pool, size, gfp, NULL);
+}
+
+static unsigned long zs_malloc_node(struct zs_pool *pool, size_t size,
+				gfp_t gfp, int *nid)
 {
 	unsigned long handle;
 	struct size_class *class;
@@ -1376,7 +1390,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 
 	spin_unlock(&class->lock);
 
-	zspage = alloc_zspage(pool, class, gfp);
+	zspage = alloc_zspage(pool, class, gfp, nid);
 	if (!zspage) {
 		cache_free_handle(pool, handle);
 		return (unsigned long)ERR_PTR(-ENOMEM);
diff --git a/mm/zswap.c b/mm/zswap.c
index 204fb59da33c..89b6d4ade4cd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -981,7 +981,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 
 	zpool = pool->zpool;
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
-	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle);
+	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle, NULL);
 	if (alloc_ret)
 		goto unlock;
 
-- 
2.47.1

