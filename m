Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4481CA85
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jan 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFbR+iPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704307775; x=1735843775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/8e1DkaghMKT+3Arz3DZgV5yOV4HNtC0UXjiBjLT6XA=;
  b=VFbR+iPaLTMjXZllp+vMwoSGj56hzbB0kCjKIkIP/zGbAeSE/z0U8ZLg
   eBGtemGzxEVc+Yy/79VfRtSEYri6RXNXUKTX99yZBHicv/kcQNnWwVqfp
   tfrco5nAeY8VglVcwWjfSWlrAVWhtnnIJ1YF5HRGs6YfWSHoG6Yi235Bp
   89K1ElXQh/a+h+0s4UxKMsSI4Y708s+lwv3LLp3qiCQKnoqO0eE8nHG6o
   NrIS1WkPwoXfjuiHt4jkg5Ky/jmkYgEsyZLECpzVj0ZeGdMQT3jmErGAd
   z1wIjabKNxYmjoTfMSS+CVcqZhoA7WD6jSe7iPcu9mv9cV4xwm4xHSMUP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10441137"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="10441137"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:49:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="780064000"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="780064000"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.164.233])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:49:33 -0800
Date: Wed, 3 Jan 2024 10:49:31 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>, x86@kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] x86/numa: Make numa_fill_memblks() @end parameter
 exclusive
Message-ID: <ZZWsOxhYRAdPNNCv@aschofie-mobl2>
References: <20240102213206.1493733-1-alison.schofield@intel.com>
 <65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Jan 02, 2024 at 03:42:50PM -0800, Dan Williams wrote:
> 
> So I realize I asked for the minimal fix before a wider cleanup to
> 'struct numa_memblk' to use 'struct range', but I want to see some of
> that cleanup now. How about the below (only compile-tested) to at least
> convert numa_fill_memblks(), since it is new, and then circle back
> sometime later to move 'struct numa_memblk' to embed a 'struct range'
> directly? I.e. save touching legacy code for later, but fix the bug in
> the new code with some modernization. This also documents that
> numa_add_memblk() expects an inclusive argument.
> 
> Note that this would be 3 patches, the minimal logic fix as you have it
> without the comment changes since they become moot later, the
> introduction of range_overlaps() with namespace conflict fixup with the
> btrfs version, and using range_overlaps() to cleanup numa_fill_memblks()

Hi Dan,

Your idea to use struct range in struct numa_memblk comes as tremendous
relief after staring at open coded usage of start/end in numa_memblk.

With that acknowledged, the minimal fix to the overlap issue could be
either in x86 or acpi. We're at x86 because we wanted to be 'like'
numa_add_memblks(). A partial cleanup now makes numa_fill_memblks()
diverge further. And, to avoid the partial cleanup from being
throw-away work, it seems we'd want to define the full cleanup ahead
of time.

Also recall that we have a bigger hope of replacing this whole
numa memblk usage with the "Memblock" (with an 'o') API.

Maybe I need clarification on what you are suggesting wrt 3 patches?
Are you saying you would not merge the minimal fix unless the partial
clean up patches are included in the same set?

Also, is this something that has to be merged through x86 or might
you be able to take it though cxl tree? Yes, that's me worrying 
about the review and intake burden this puts on x86.

Alison

> 
> diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> index 1be13b2dfe8b..9e2279762eaa 100644
> --- a/arch/x86/include/asm/sparsemem.h
> +++ b/arch/x86/include/asm/sparsemem.h
> @@ -37,7 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> -extern int numa_fill_memblks(u64 start, u64 end);
> +struct range;
> +extern int numa_fill_memblks(struct range *range);
>  #define numa_fill_memblks numa_fill_memblks
>  #endif
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index b29ceb19e46e..ce1ccda6fee4 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched.h>
>  #include <linux/topology.h>
>  #include <linux/sort.h>
> +#include <linux/range.h>
>  
>  #include <asm/e820/api.h>
>  #include <asm/proto.h>
> @@ -971,20 +972,17 @@ static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
>  
>  /**
>   * numa_fill_memblks - Fill gaps in numa_meminfo memblks
> - * @start: address to begin fill
> - * @end: address to end fill
> + * @range: range to fill
>   *
> - * Find and extend numa_meminfo memblks to cover the @start-@end
> - * physical address range, such that the first memblk includes
> - * @start, the last memblk includes @end, and any gaps in between
> - * are filled.
> + * Find and extend numa_meminfo memblks to cover the physical address
> + * range and fill any gaps.
>   *
>   * RETURNS:
>   * 0		  : Success
> - * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
> + * NUMA_NO_MEMBLK : No memblk exists in @range
>   */
>  
> -int __init numa_fill_memblks(u64 start, u64 end)
> +int __init numa_fill_memblks(struct range *range)
>  {
>  	struct numa_memblk **blk = &numa_memblk_list[0];
>  	struct numa_meminfo *mi = &numa_meminfo;
> @@ -993,17 +991,17 @@ int __init numa_fill_memblks(u64 start, u64 end)
>  
>  	/*
>  	 * Create a list of pointers to numa_meminfo memblks that
> -	 * overlap start, end. Exclude (start == bi->end) since
> -	 * end addresses in both a CFMWS range and a memblk range
> -	 * are exclusive.
> -	 *
> -	 * This list of pointers is used to make in-place changes
> -	 * that fill out the numa_meminfo memblks.
> +	 * overlap start, end. This list is used to make in-place
> +	 * changes that fill out the numa_meminfo memblks.
>  	 */
>  	for (int i = 0; i < mi->nr_blks; i++) {
>  		struct numa_memblk *bi = &mi->blk[i];
> +		struct range bi_range = {
> +			.start = bi->start,
> +			.end = bi->end - 1,
> +		};
>  
> -		if (start < bi->end && end >= bi->start) {
> +		if (range_overlaps(range, &bi_range)) {
>  			blk[count] = &mi->blk[i];
>  			count++;
>  		}
> @@ -1015,8 +1013,8 @@ int __init numa_fill_memblks(u64 start, u64 end)
>  	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
>  
>  	/* Make sure the first/last memblks include start/end */
> -	blk[0]->start = min(blk[0]->start, start);
> -	blk[count - 1]->end = max(blk[count - 1]->end, end);
> +	blk[0]->start = min(blk[0]->start, range->start);
> +	blk[count - 1]->end = max(blk[count - 1]->end, range->end + 1);
>  
>  	/*
>  	 * Fill any gaps by tracking the previous memblks
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 12f330b0eac0..6213a15c2a8d 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -307,8 +307,10 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	int node;
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
> -	start = cfmws->base_hpa;
> -	end = cfmws->base_hpa + cfmws->window_size;
> +	struct range range = {
> +		.start = cfmws->base_hpa,
> +		.end = cfmws->base_hpa + cfmws->window_size - 1,
> +	};
>  
>  	/*
>  	 * The SRAT may have already described NUMA details for all,
> @@ -316,7 +318,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	 * found for any portion of the window to cover the entire
>  	 * window.
>  	 */
> -	if (!numa_fill_memblks(start, end))
> +	if (!numa_fill_memblks(&range))
>  		return 0;
>  
>  	/* No SRAT description. Create a new node. */
> @@ -327,7 +329,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  		return -EINVAL;
>  	}
>  
> -	if (numa_add_memblk(node, start, end) < 0) {
> +	if (numa_add_memblk(node, range.start, range.end + 1) < 0) {
>  		/* CXL driver must handle the NUMA_NO_NODE case */
>  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
>  			node, start, end);
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index a82e1417c4d2..e6c4ffc6003d 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -111,7 +111,7 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 file_offset,
>  	return NULL;
>  }
>  
> -static int range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
> +static int btrfs_range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
>  			  u64 len)
>  {
>  	if (file_offset + len <= entry->file_offset ||
> @@ -913,7 +913,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
>  
>  	while (1) {
>  		entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
> -		if (range_overlaps(entry, file_offset, len))
> +		if (btrfs_range_overlaps(entry, file_offset, len))
>  			break;
>  
>  		if (entry->file_offset >= file_offset + len) {
> @@ -1042,12 +1042,12 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
>  	}
>  	if (prev) {
>  		entry = rb_entry(prev, struct btrfs_ordered_extent, rb_node);
> -		if (range_overlaps(entry, file_offset, len))
> +		if (btrfs_range_overlaps(entry, file_offset, len))
>  			goto out;
>  	}
>  	if (next) {
>  		entry = rb_entry(next, struct btrfs_ordered_extent, rb_node);
> -		if (range_overlaps(entry, file_offset, len))
> +		if (btrfs_range_overlaps(entry, file_offset, len))
>  			goto out;
>  	}
>  	/* No ordered extent in the range */
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index a904861de800..ef35c974e5f2 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -45,7 +45,7 @@ static inline int phys_to_target_node(u64 start)
>  }
>  #endif
>  #ifndef numa_fill_memblks
> -static inline int __init numa_fill_memblks(u64 start, u64 end)
> +static inline int __init numa_fill_memblks(struct range *range)
>  {
>  	return NUMA_NO_MEMBLK;
>  }
> diff --git a/include/linux/range.h b/include/linux/range.h
> index 6ad0b73cb7ad..981fd4f7731e 100644
> --- a/include/linux/range.h
> +++ b/include/linux/range.h
> @@ -13,11 +13,18 @@ static inline u64 range_len(const struct range *range)
>  	return range->end - range->start + 1;
>  }
>  
> +/* True if r1 completely contains r2 */
>  static inline bool range_contains(struct range *r1, struct range *r2)
>  {
>  	return r1->start <= r2->start && r1->end >= r2->end;
>  }
>  
> +/* True if any part of r1 overlaps r2 */
> +static inline bool range_overlaps(const struct range *r1, const struct range *r2)
> +{
> +       return r1->start <= r2->end && r1->end >= r2->start;
> +}
> +
>  int add_range(struct range *range, int az, int nr_range,
>  		u64 start, u64 end);
>  
