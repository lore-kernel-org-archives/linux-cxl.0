Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4CA2E339D
	for <linux-cxl@vger.kernel.org>; Thu,  3 Apr 2025 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743650333; cv=none; b=eqe+wofrkEt2TZRg1zDbdUJB/fN96ALkDUw93w/kWkfgyH+HY21NhtiqYRSjZ/+FqhDwKkYKh7avQWljZCBP0ColHAfQ+VRWOnwnv2w/HwRUDso/huQGz8Rdx7okisO2U0dsvj7PcZs1BqdzVcLK+U+/sHVAhCuX3os0RcHhX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743650333; c=relaxed/simple;
	bh=v7Ooc7wvSw3zbZEldCqOf1Lpt/P+vmbyrLPaofyPe+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8TKK3yfIWIjUYILUcqg+LeDaKwGwObybfLqAK4Irr6+/gr8yFlFtRu8sYM+ftcYcpH4BQIL1Zdhs8uDfDp/A94iIFfnbWKdXkh1qsKdFZigeUpCUnInwXd/o14cwSkwDuLzXvKcT5xDaFIQSs4oytmZvmpg9XXgYuAmnydxTCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cUJvdkfK; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cUJvdkfK"
Message-ID: <a881c1f8-aaa4-4c34-9883-a1d07e117968@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743650325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7qAGq15qEL42KHQ3S9Pf/fZyUx4FjkcbUW8i8mYu0o=;
	b=cUJvdkfK6z5cXBBa5OYMd7WWFZeIwQmJ6GXCxzltrfjpCjF9svFUESAKKBUQNFwyuUlGNo
	SWnxd3ePMiFVvUS/66bP0eFPIEXkk4qpK5unoM5KBXNUsW4zbmnuXmSjJDASAFY85GJXlz
	YYCgdmxHtHLd5vY2qrND/x0uzEp03eo=
Date: Thu, 3 Apr 2025 11:18:35 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] zsmalloc: prefer the the original page's node for
 compressed data
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosry.ahmed@linux.dev, sj@kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 gourry@gourry.net, ying.huang@linux.alibaba.com,
 jonathan.cameron@huawei.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org
References: <20250402204416.3435994-1-nphamcs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250402204416.3435994-1-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/4/3 04:44, Nhat Pham wrote:
> Currently, zsmalloc, zswap's and zram's backend memory allocator, does
> not enforce any policy for the allocation of memory for the compressed
> data, instead just adopting the memory policy of the task entering
> reclaim, or the default policy (prefer local node) if no such policy is
> specified. This can lead to several pathological behaviors in
> multi-node NUMA systems:
> 
> 1. Systems with CXL-based memory tiering can encounter the following
>     inversion with zswap/zram: the coldest pages demoted to the CXL tier
>     can return to the high tier when they are reclaimed to compressed
>     swap, creating memory pressure on the high tier.
> 
> 2. Consider a direct reclaimer scanning nodes in order of allocation
>     preference. If it ventures into remote nodes, the memory it
>     compresses there should stay there. Trying to shift those contents
>     over to the reclaiming thread's preferred node further *increases*
>     its local pressure, and provoking more spills. The remote node is
>     also the most likely to refault this data again. This undesirable
>     behavior was pointed out by Johannes Weiner in [1].
> 
> 3. For zswap writeback, the zswap entries are organized in
>     node-specific LRUs, based on the node placement of the original
>     pages, allowing for targeted zswap writeback for specific nodes.
> 
>     However, the compressed data of a zswap entry can be placed on a
>     different node from the LRU it is placed on. This means that reclaim
>     targeted at one node might not free up memory used for zswap entries
>     in that node, but instead reclaiming memory in a different node.
> 
> All of these issues will be resolved if the compressed data go to the
> same node as the original page. This patch encourages this behavior by
> having zswap and zram pass the node of the original page to zsmalloc,
> and have zsmalloc prefer the specified node if we need to allocate new
> (zs)pages for the compressed data.
> 
> Note that we are not strictly binding the allocation to the preferred
> node. We still allow the allocation to fall back to other nodes when
> the preferred node is full, or if we have zspages with slots available
> on a different node. This is OK, and still a strict improvement over
> the status quo:
> 
> 1. On a system with demotion enabled, we will generally prefer
>     demotions over compressed swapping, and only swap when pages have
>     already gone to the lowest tier. This patch should achieve the
>     desired effect for the most part.
> 
> 2. If the preferred node is out of memory, letting the compressed data
>     going to other nodes can be better than the alternative (OOMs,
>     keeping cold memory unreclaimed, disk swapping, etc.).
> 
> 3. If the allocation go to a separate node because we have a zspage
>     with slots available, at least we're not creating extra immediate
>     memory pressure (since the space is already allocated).
> 
> 3. While there can be mixings, we generally reclaim pages in
>     same-node batches, which encourage zspage grouping that is more
>     likely to go to the right node.
> 
> 4. A strict binding would require partitioning zsmalloc by node, which
>     is more complicated, and more prone to regression, since it reduces
>     the storage density of zsmalloc. We need to evaluate the tradeoff
>     and benchmark carefully before adopting such an involved solution.
> 
> [1]: https://lore.kernel.org/linux-mm/20250331165306.GC2110528@cmpxchg.org/
> 
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Looks good to me:

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>   drivers/block/zram/zram_drv.c | 11 ++++++++---
>   include/linux/zpool.h         |  4 ++--
>   include/linux/zsmalloc.h      |  3 ++-
>   mm/zpool.c                    |  8 +++++---
>   mm/zsmalloc.c                 | 18 ++++++++++--------
>   mm/zswap.c                    |  2 +-
>   6 files changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fda7d8624889..0ba18277ed7b 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1694,7 +1694,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
>   	 */
>   	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
>   			   GFP_NOIO | __GFP_NOWARN |
> -			   __GFP_HIGHMEM | __GFP_MOVABLE);
> +			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
>   	if (IS_ERR_VALUE(handle))
>   		return PTR_ERR((void *)handle);
>   
> @@ -1761,7 +1761,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>   
>   	handle = zs_malloc(zram->mem_pool, comp_len,
>   			   GFP_NOIO | __GFP_NOWARN |
> -			   __GFP_HIGHMEM | __GFP_MOVABLE);
> +			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
>   	if (IS_ERR_VALUE(handle)) {
>   		zcomp_stream_put(zstrm);
>   		return PTR_ERR((void *)handle);
> @@ -1981,10 +1981,15 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
>   	 * We are holding per-CPU stream mutex and entry lock so better
>   	 * avoid direct reclaim.  Allocation error is not fatal since
>   	 * we still have the old object in the mem_pool.
> +	 *
> +	 * XXX: technically, the node we really want here is the node that holds
> +	 * the original compressed data. But that would require us to modify
> +	 * zsmalloc API to return this information. For now, we will make do with
> +	 * the node of the page allocated for recompression.
>   	 */
>   	handle_new = zs_malloc(zram->mem_pool, comp_len_new,
>   			       GFP_NOIO | __GFP_NOWARN |
> -			       __GFP_HIGHMEM | __GFP_MOVABLE);
> +			       __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
>   	if (IS_ERR_VALUE(handle_new)) {
>   		zcomp_stream_put(zstrm);
>   		return PTR_ERR((void *)handle_new);
> diff --git a/include/linux/zpool.h b/include/linux/zpool.h
> index 52f30e526607..697525cb00bd 100644
> --- a/include/linux/zpool.h
> +++ b/include/linux/zpool.h
> @@ -22,7 +22,7 @@ const char *zpool_get_type(struct zpool *pool);
>   void zpool_destroy_pool(struct zpool *pool);
>   
>   int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
> -			unsigned long *handle);
> +			unsigned long *handle, const int nid);
>   
>   void zpool_free(struct zpool *pool, unsigned long handle);
>   
> @@ -64,7 +64,7 @@ struct zpool_driver {
>   	void (*destroy)(void *pool);
>   
>   	int (*malloc)(void *pool, size_t size, gfp_t gfp,
> -				unsigned long *handle);
> +				unsigned long *handle, const int nid);
>   	void (*free)(void *pool, unsigned long handle);
>   
>   	void *(*obj_read_begin)(void *pool, unsigned long handle,
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index c26baf9fb331..13e9cc5490f7 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -26,7 +26,8 @@ struct zs_pool;
>   struct zs_pool *zs_create_pool(const char *name);
>   void zs_destroy_pool(struct zs_pool *pool);
>   
> -unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags);
> +unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
> +			const int nid);
>   void zs_free(struct zs_pool *pool, unsigned long obj);
>   
>   size_t zs_huge_class_size(struct zs_pool *pool);
> diff --git a/mm/zpool.c b/mm/zpool.c
> index 6d6d88930932..b99a7c03e735 100644
> --- a/mm/zpool.c
> +++ b/mm/zpool.c
> @@ -226,20 +226,22 @@ const char *zpool_get_type(struct zpool *zpool)
>    * @size:	The amount of memory to allocate.
>    * @gfp:	The GFP flags to use when allocating memory.
>    * @handle:	Pointer to the handle to set
> + * @nid:	The preferred node id.
>    *
>    * This allocates the requested amount of memory from the pool.
>    * The gfp flags will be used when allocating memory, if the
>    * implementation supports it.  The provided @handle will be
> - * set to the allocated object handle.
> + * set to the allocated object handle. The allocation will
> + * prefer the NUMA node specified by @nid.
>    *
>    * Implementations must guarantee this to be thread-safe.
>    *
>    * Returns: 0 on success, negative value on error.
>    */
>   int zpool_malloc(struct zpool *zpool, size_t size, gfp_t gfp,
> -			unsigned long *handle)
> +			unsigned long *handle, const int nid)
>   {
> -	return zpool->driver->malloc(zpool->pool, size, gfp, handle);
> +	return zpool->driver->malloc(zpool->pool, size, gfp, handle, nid);
>   }
>   
>   /**
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 961b270f023c..8ba6cdf222ac 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -243,9 +243,9 @@ static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
>   	dec_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
>   }
>   
> -static inline struct zpdesc *alloc_zpdesc(gfp_t gfp)
> +static inline struct zpdesc *alloc_zpdesc(gfp_t gfp, const int nid)
>   {
> -	struct page *page = alloc_page(gfp);
> +	struct page *page = alloc_pages_node(nid, gfp, 0);
>   
>   	return page_zpdesc(page);
>   }
> @@ -462,9 +462,9 @@ static void zs_zpool_destroy(void *pool)
>   }
>   
>   static int zs_zpool_malloc(void *pool, size_t size, gfp_t gfp,
> -			unsigned long *handle)
> +			unsigned long *handle, const int nid)
>   {
> -	*handle = zs_malloc(pool, size, gfp);
> +	*handle = zs_malloc(pool, size, gfp, nid);
>   
>   	if (IS_ERR_VALUE(*handle))
>   		return PTR_ERR((void *)*handle);
> @@ -1044,7 +1044,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
>    */
>   static struct zspage *alloc_zspage(struct zs_pool *pool,
>   					struct size_class *class,
> -					gfp_t gfp)
> +					gfp_t gfp, const int nid)
>   {
>   	int i;
>   	struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE];
> @@ -1061,7 +1061,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>   	for (i = 0; i < class->pages_per_zspage; i++) {
>   		struct zpdesc *zpdesc;
>   
> -		zpdesc = alloc_zpdesc(gfp);
> +		zpdesc = alloc_zpdesc(gfp, nid);
>   		if (!zpdesc) {
>   			while (--i >= 0) {
>   				zpdesc_dec_zone_page_state(zpdescs[i]);
> @@ -1336,12 +1336,14 @@ static unsigned long obj_malloc(struct zs_pool *pool,
>    * @pool: pool to allocate from
>    * @size: size of block to allocate
>    * @gfp: gfp flags when allocating object
> + * @nid: The preferred node id to allocate new zspage (if needed)
>    *
>    * On success, handle to the allocated object is returned,
>    * otherwise an ERR_PTR().
>    * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
>    */
> -unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> +unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
> +				const int nid)
>   {
>   	unsigned long handle;
>   	struct size_class *class;
> @@ -1376,7 +1378,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>   
>   	spin_unlock(&class->lock);
>   
> -	zspage = alloc_zspage(pool, class, gfp);
> +	zspage = alloc_zspage(pool, class, gfp, nid);
>   	if (!zspage) {
>   		cache_free_handle(pool, handle);
>   		return (unsigned long)ERR_PTR(-ENOMEM);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 204fb59da33c..455e9425c5f5 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -981,7 +981,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>   
>   	zpool = pool->zpool;
>   	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
> -	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle);
> +	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle, page_to_nid(page));
>   	if (alloc_ret)
>   		goto unlock;
>   
> 
> base-commit: 8c65b3b82efb3b2f0d1b6e3b3e73c6f0fd367fb5
