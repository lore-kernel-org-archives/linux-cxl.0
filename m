Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07B13665A
	for <linux-cxl@vger.kernel.org>; Thu,  1 Aug 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498765; cv=none; b=ilPDJsWm9A0AltUj59TmtZyrlY8vDP+vNShyDTjHx5othCyWFsJJvt0IpMzsnm+FDTXJufQjh6UD10exHjv7pZVEhRJe8YaGKxVZDH0t+4IoruxwTpGPedX0TeHdpJzgcj0UD6HVtQJEIvdaD2VM/btR9j0ToLUzc4GkxDqHQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498765; c=relaxed/simple;
	bh=M/xm6SkF5ykK1Ce6RJ7oXAUttwpWVODq4jRA8O+iqXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf1NaeuDq85TAf1C8ZOcb3NxsPnustyqBNZTc0fwRF/EEMJherd1tJdUlwh4/NfQhkyBjCZKjB3pL1GaKagPJKzXK7LBeNr1ksgfTy+oSegCDFeMQeR+F1kFR6tsJjrIp5uTgqxCYUGOmfzQAS0e4BSTo8qZFHy96/sQWHkqKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnPCDBPqtmPXIRBA--.26100S2;
	Thu, 01 Aug 2024 15:52:33 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCn0rK0PqtmKy8KAA--.8190S2;
	Thu, 01 Aug 2024 15:52:31 +0800 (CST)
Date: Thu, 1 Aug 2024 15:52:15 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, chenbaozi@phytium.com.cn
Subject: Re: [RFC PATCH 2/8] arm64: memblock: Introduce a generic
 phys_addr_to_target_node()
Message-ID: <Zqs+rz1gSJ1QmjfG@phytium.com.cn>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529171236.32002-3-Jonathan.Cameron@huawei.com>
X-CM-TRANSID:AQAAfwCn0rK0PqtmKy8KAA--.8190S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAEAWaqm98E1AADsf
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gr48tw4rArW3Gw1kAr17GFg_yoWfJF47p3
	ykKwn8JrW7W3yIvay3X3y5Xry5Zw1rCw1fKFW7CryDuF15tr13Xr4agws0grWqy39rZF1Y
	vFs2q3W7Cw4DXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Wed, May 29, 2024 at 06:12:30PM +0100, Jonathan Cameron wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Similar to how generic memory_add_physaddr_to_nid() interrogates
> memblock data for numa information, introduce
> get_reserved_pfn_range_from_nid() to enable the same operation for
> reserved memory ranges. Example memory ranges that are reserved, but
> still have associated numa-info are persistent memory or Soft Reserved
> (EFI_MEMORY_SP) memory.
> 
> This is Dan's patch but with the implementation of
> phys_addr_to_target_node() made arm64 specific.
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Jia He <justin.he@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/r/159457120893.754248.7783260004248722175.stgit@dwillia2-desk3.amr.corp.intel.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  arch/arm64/include/asm/sparsemem.h |  4 ++++
>  arch/arm64/mm/init.c               | 22 ++++++++++++++++++++++
>  include/linux/memblock.h           |  8 ++++++++
>  include/linux/mm.h                 | 14 ++++++++++++++
>  mm/memblock.c                      | 22 +++++++++++++++++++---
>  mm/mm_init.c                       | 29 ++++++++++++++++++++++++++++-
>  6 files changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 8dd1b6a718fa..5b483ad6d501 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -27,7 +27,11 @@
>  #endif /* CONFIG_ARM64_64K_PAGES */
>  
>  #ifndef __ASSEMBLY__
> +
>  extern int memory_add_physaddr_to_nid(u64 addr);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +extern int phys_to_target_node(phys_addr_t start);
> +#define phys_to_target_node phys_to_target_node
> +
>  #endif /* __ASSEMBLY__ */
>  #endif
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index f310cbd349ba..6a2f21b1bb58 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -75,6 +75,28 @@ int memory_add_physaddr_to_nid(u64 start)
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>  
> +int phys_to_target_node(phys_addr_t start)
> +{
> +	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(start);
> +	int nid = __memory_add_physaddr_to_nid(start);
> +
> +	if (nid != NUMA_NO_NODE)
> +		return nid;
> +
> +	/*
> +	 * Search reserved memory ranges since the memory address does
> +	 * not appear to be online
> +	 */
> +	for_each_node_state(nid, N_POSSIBLE) {
> +		get_reserved_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> +		if (pfn >= start_pfn && pfn <= end_pfn)
> +			return nid;
> +	}
> +
> +	return NUMA_NO_NODE;
> +}
> +EXPORT_SYMBOL(phys_to_target_node);
> +
>  #endif /* CONFIG_NUMA */
>  
>  /*
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index e2082240586d..c7d518a54359 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -281,6 +281,10 @@ int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
>  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
>  			  unsigned long *out_end_pfn, int *out_nid);
>  
> +void __next_reserved_pfn_range(int *idx, int nid,
> +			       unsigned long *out_start_pfn,
> +			       unsigned long *out_end_pfn, int *out_nid);
> +
>  /**
>   * for_each_mem_pfn_range - early memory pfn range iterator
>   * @i: an integer used as loop variable
> @@ -295,6 +299,10 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
>  	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
>  	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
>  
> +#define for_each_reserved_pfn_range(i, nid, p_start, p_end, p_nid)		\
> +	for (i = -1, __next_reserved_pfn_range(&i, nid, p_start, p_end, p_nid); \
> +	     i >= 0; __next_reserved_pfn_range(&i, nid, p_start, p_end, p_nid))
> +
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>  				  unsigned long *out_spfn,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9849dfda44d4..0c829b2d44fa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3245,9 +3245,23 @@ void free_area_init(unsigned long *max_zone_pfn);
>  unsigned long node_map_pfn_alignment(void);
>  extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>  						unsigned long end_pfn);
> +
> +/*
> + * Allow archs to opt-in to keeping get_pfn_range_for_nid() available
> + * after boot.
> + */
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> +#define __init_or_memblock
> +#else
> +#define __init_or_memblock __init
> +#endif
> +
>  extern void get_pfn_range_for_nid(unsigned int nid,
>  			unsigned long *start_pfn, unsigned long *end_pfn);
>  
> +extern void get_reserved_pfn_range_for_nid(unsigned int nid,
> +			unsigned long *start_pfn, unsigned long *end_pfn);
> +
>  #ifndef CONFIG_NUMA
>  static inline int early_pfn_to_nid(unsigned long pfn)
>  {
> diff --git a/mm/memblock.c b/mm/memblock.c
> index d09136e040d3..5498d5ea70b4 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1289,11 +1289,11 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
>  /*
>   * Common iterator interface used to define for_each_mem_pfn_range().
>   */
> -void __init_memblock __next_mem_pfn_range(int *idx, int nid,
> +static void __init_memblock __next_memblock_pfn_range(int *idx, int nid,
>  				unsigned long *out_start_pfn,
> -				unsigned long *out_end_pfn, int *out_nid)
> +				unsigned long *out_end_pfn, int *out_nid,
> +				struct memblock_type *type)
>  {
> -	struct memblock_type *type = &memblock.memory;
>  	struct memblock_region *r;
>  	int r_nid;
>  
> @@ -1319,6 +1319,22 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
>  		*out_nid = r_nid;
>  }
>  
> +void __init_memblock __next_mem_pfn_range(int *idx, int nid,
> +				unsigned long *out_start_pfn,
> +				unsigned long *out_end_pfn, int *out_nid)
> +{
> +	__next_memblock_pfn_range(idx, nid, out_start_pfn, out_end_pfn, out_nid,
> +				  &memblock.memory);
> +}
> +
> +void __init_memblock __next_reserved_pfn_range(int *idx, int nid,
> +				unsigned long *out_start_pfn,
> +				unsigned long *out_end_pfn, int *out_nid)
> +{
> +	__next_memblock_pfn_range(idx, nid, out_start_pfn, out_end_pfn, out_nid,
> +				  &memblock.reserved);
> +}
> +
>  /**
>   * memblock_set_node - set node ID on memblock regions
>   * @base: base of area to set node ID for
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f72b852bd5b8..1f6e29e60673 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1644,7 +1644,7 @@ static inline void alloc_node_mem_map(struct pglist_data *pgdat) { }
>   * provided by memblock_set_node(). If called for a node
>   * with no available memory, the start and end PFNs will be 0.
>   */
> -void __init get_pfn_range_for_nid(unsigned int nid,
> +void __init_or_memblock get_pfn_range_for_nid(unsigned int nid,
>  			unsigned long *start_pfn, unsigned long *end_pfn)
>  {
>  	unsigned long this_start_pfn, this_end_pfn;
> @@ -1662,6 +1662,33 @@ void __init get_pfn_range_for_nid(unsigned int nid,
>  		*start_pfn = 0;
>  }
>  
> +/**
> + * get_reserved_pfn_range_for_nid - Return the start and end page frames for a node
> + * @nid: The nid to return the range for. If MAX_NUMNODES, the min and max PFN are returned.
> + * @start_pfn: Passed by reference. On return, it will have the node start_pfn.
> + * @end_pfn: Passed by reference. On return, it will have the node end_pfn.
> + *
> + * Mostly identical to get_pfn_range_for_nid() except it operates on
> + * reserved ranges rather than online memory.
> + */
> +void __init_or_memblock get_reserved_pfn_range_for_nid(unsigned int nid,
> +			unsigned long *start_pfn, unsigned long *end_pfn)
> +{
> +	unsigned long this_start_pfn, this_end_pfn;
> +	int i;
> +
> +	*start_pfn = -1UL;
> +	*end_pfn = 0;
> +
> +	for_each_reserved_pfn_range(i, nid, &this_start_pfn, &this_end_pfn, NULL) {
> +		*start_pfn = min(*start_pfn, this_start_pfn);
> +		*end_pfn = max(*end_pfn, this_end_pfn);
> +	}
> +
> +	if (*start_pfn == -1UL)
> +		*start_pfn = 0;
> +}
> +
>  static void __init free_area_init_node(int nid)
>  {
>  	pg_data_t *pgdat = NODE_DATA(nid);
> -- 
> 2.39.2
>

Tested-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

