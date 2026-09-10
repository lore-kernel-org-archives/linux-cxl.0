Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B3486647;
	Thu, 10 Sep 2026 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050789; cv=none; b=PcCden9D8ieBRCBlcn6/GYF+mp5RUkKNmBSm8tKndZaK3h4GS6j7fp3q4sxobDB55AtJGv/Bh79n/slFTUMP5W6A2pT1aQY1zJNk7ESyO8JC6J/DHmv+bWjDTpbD8Q52HJqzfbIIY2fHjtvolRaxH08fKhqyObnJoDKJ6WFFISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050789; c=relaxed/simple;
	bh=1yKBBJoEhXzT0u7RXKa99EZc/h48jj478Y+U/NvKOpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R97l3yN6sn0u2sKqyx+SxcsvWDVUJhoUESXA+x/mH3ZXB73e18G3LaWVy6h+GYJB9A2b21nkPZ8quasGFTmvrduME/6jPr9DUVwMk55xnibQKmeWfG+af5+p3/RTh9gpczQdI7f55b3bJ/xqvL+j78nCvmkjm2f8wENLMVRbP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEBarzsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEBarzsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5656C1F000FF;
	Thu, 10 Sep 2026 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050787;
	bh=mzNbcMB0p1eY0jFGMUsfswHJRjfiaKQRPsj4bDo0LJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GEBarzsaT/GfzNrEw1IDRcdc2Qi0z6RKPkaAX+irMV1fAySbMqtNp/r7WYAtWlxfa
	 l3imiHeM/NxsuPRGU8OkkBuYY1c5w+2J0g4wjwX2QsglvTKjc+S3jJvaZd7CQv8++S
	 3E5z/N6S904KA/e+KOP67vV4XKI/FSODkKMiVx4S5PYKHysvIm6DbONe6+TXkarxZz
	 LTaMtBZ79JK5EJJ4BnVoV3Y1SwXRjtvoyhTrLg3sImW9ITHVpwqjLjHTOj+QuweXrH
	 lgOauZIYiV5A4zwAtlEZEa61OpwegJ6FPItysFxgJXrzzLRYiYqGkSYj/sMlNflbt1
	 Ni9OnEb92Lu1w==
Date: Thu, 10 Sep 2026 15:32:56 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/12] mm/sparse: remove SECTION_MARKED_PRESENT
Message-ID: <aqK9S1hBpPnujgz9@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-9-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-9-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:33:02PM +0200, David Hildenbrand (Arm) wrote:
> All present section iterators run before memory hotplug added any
> further memory sections, Therefore, we can simply use the SECTION_IS_EARLY
> flag by setting that flag earlier in sparse_prepare_early_sections().

Hmm? sparse_prepare_early_sections() doesn't seem to be a function that exists?

Do you mean sparse_sections_init()?

>
> Get rid of SECTION_MARKED_PRESENT entirely and rename
> for_each_present_section_nr() to for_each_early_section_nr().
>
> Also update the gdb script to use the updated value for
> SECTION_IS_EARLY.

The change seems fine.

>
> No functional change intended.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

With commit msg updated:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

One small question type comment below.

> ---
>  drivers/base/memory.c   |  2 +-
>  include/linux/mmzone.h  | 27 ++++++++++-----------------
>  mm/sparse-vmemmap.c     |  1 -
>  mm/sparse.c             | 17 ++++++++---------
>  mm/sparse.h             |  6 ------
>  scripts/gdb/linux/mm.py |  2 +-
>  6 files changed, 20 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 5eead3346f1e3..b0338de2f1d82 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -972,7 +972,7 @@ void __init memory_dev_init(void)
>  	 * block so that it can be covered.
>  	 */
>  	block_id = ULONG_MAX;
> -	for_each_present_section_nr(0, nr) {
> +	for_each_early_section_nr(0, nr) {
>  		if (block_id != ULONG_MAX && memory_block_id(nr) == block_id)
>  			continue;
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index e0fac344f6ac2..62cff59dd80c4 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2084,7 +2084,6 @@ static inline struct mem_section *__nr_to_section(unsigned long nr)
>   * accommodate SECTION_MAP_LAST_BIT. We use BUILD_BUG_ON() to ensure this.
>   */
>  enum {
> -	SECTION_MARKED_PRESENT_BIT,
>  	SECTION_HAS_MEM_MAP_BIT,
>  	SECTION_IS_ONLINE_BIT,
>  	SECTION_IS_EARLY_BIT,
> @@ -2094,7 +2093,6 @@ enum {
>  	SECTION_MAP_LAST_BIT,
>  };
>
> -#define SECTION_MARKED_PRESENT		BIT(SECTION_MARKED_PRESENT_BIT)
>  #define SECTION_HAS_MEM_MAP		BIT(SECTION_HAS_MEM_MAP_BIT)
>  #define SECTION_IS_ONLINE		BIT(SECTION_IS_ONLINE_BIT)
>  #define SECTION_IS_EARLY		BIT(SECTION_IS_EARLY_BIT)
> @@ -2111,16 +2109,6 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
>  	return (struct page *)map;
>  }
>
> -static inline int present_section(const struct mem_section *section)
> -{
> -	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
> -}
> -
> -static inline int present_section_nr(unsigned long nr)
> -{
> -	return present_section(__nr_to_section(nr));
> -}
> -
>  static inline int valid_section(const struct mem_section *section)
>  {
>  	return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP));
> @@ -2136,6 +2124,11 @@ static inline int valid_section_nr(unsigned long nr)
>  	return valid_section(__nr_to_section(nr));
>  }
>
> +static inline int early_section_nr(unsigned long nr)
> +{
> +	return early_section(__nr_to_section(nr));
> +}
> +
>  static inline int online_section(const struct mem_section *section)
>  {
>  	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
> @@ -2315,20 +2308,20 @@ static inline unsigned long next_valid_pfn(unsigned long pfn, unsigned long end_
>
>  #endif
>
> -static inline unsigned long next_present_section_nr(unsigned long section_nr)
> +static inline unsigned long next_early_section_nr(unsigned long section_nr)
>  {
>  	while (++section_nr <= __highest_used_section_nr) {
> -		if (present_section_nr(section_nr))
> +		if (early_section_nr(section_nr))
>  			return section_nr;
>  	}
>
>  	return -1;
>  }
>
> -#define for_each_present_section_nr(start, section_nr)		\
> -	for (section_nr = next_present_section_nr(start - 1);	\
> +#define for_each_early_section_nr(start, section_nr)		\
> +	for (section_nr = next_early_section_nr(start - 1);	\
>  	     section_nr != -1;					\
> -	     section_nr = next_present_section_nr(section_nr))
> +	     section_nr = next_early_section_nr(section_nr))
>
>  /*
>   * These are _only_ used during initialisation, therefore they
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index e62e6aa07f126..5aba058df6b67 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -890,7 +890,6 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  	page_init_poison(memmap, sizeof(struct page) * nr_pages);
>
>  	ms = __nr_to_section(section_nr);
> -	__section_mark_present(ms, section_nr);
>
>  	/* Align memmap to section boundary in the subsection case */
>  	if (section_nr_to_pfn(section_nr) != start_pfn)
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 2d0f2db34f4cf..344acaaed94db 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -170,13 +170,14 @@ static void __init mminit_validate_memmodel_limits(unsigned long *start_pfn,
>   */
>  unsigned long __highest_used_section_nr;
>
> -static inline unsigned long first_present_section_nr(void)
> +static inline unsigned long first_early_section_nr(void)
>  {
> -	return next_present_section_nr(-1);
> +	return next_early_section_nr(-1);
>  }
>
>  void __init sparse_sections_init(void)
>  {
> +	const unsigned long flags = SECTION_IS_EARLY | SECTION_IS_ONLINE;
>  	unsigned long pfn, start_pfn, end_pfn, section_nr;
>  	int i, nid;
>
> @@ -196,9 +197,7 @@ void __init sparse_sections_init(void)
>  				continue;
>
>  			set_section_nid(section_nr, nid);
> -			ms->section_mem_map = sparse_encode_early_nid(nid) |
> -							SECTION_IS_ONLINE;
> -			__section_mark_present(ms, section_nr);
> +			ms->section_mem_map = sparse_encode_early_nid(nid) | flags;
>  		}
>  	}
>  	__highest_used_section_nr = section_nr;
> @@ -231,7 +230,7 @@ static void __init sparse_metadata_init_nid(int nid,
>  	if (!usage)
>  		panic("Failed to allocate usemap for node %d\n", nid);
>
> -	for_each_present_section_nr(start_section_nr, section_nr) {
> +	for_each_early_section_nr(start_section_nr, section_nr) {
>  		unsigned long pfn = section_nr_to_pfn(section_nr);
>  		struct page *mem_map;
>
> @@ -246,18 +245,18 @@ static void __init sparse_metadata_init_nid(int nid,
>  		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
>  							       NULL, NULL));
>  		sparse_init_one_section(__nr_to_section(section_nr), section_nr,
> -					mem_map, usage, SECTION_IS_EARLY);
> +					mem_map, usage, 0);
>  		usage = (void *)usage + mem_section_usage_size();
>  	}
>  }
>
>  static void __init sparse_metadata_init(void)
>  {
> -	unsigned long start_section_nr = first_present_section_nr();
> +	unsigned long start_section_nr = first_early_section_nr();
>  	int nid_begin = sparse_early_nid(__nr_to_section(start_section_nr));
>  	unsigned long section_nr, nr_sections = 1;
>
> -	for_each_present_section_nr(start_section_nr + 1, section_nr) {
> +	for_each_early_section_nr(start_section_nr + 1, section_nr) {
>  		const int nid = sparse_early_nid(__nr_to_section(section_nr));
>
>  		if (nid == nid_begin) {
> diff --git a/mm/sparse.h b/mm/sparse.h
> index a3af4967fd5c5..03351f2467e34 100644
> --- a/mm/sparse.h
> +++ b/mm/sparse.h
> @@ -114,12 +114,6 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>  	ms->usage = usage;
>  }
>
> -static inline void __section_mark_present(struct mem_section *ms,
> -		unsigned long section_nr)
> -{
> -	ms->section_mem_map |= SECTION_MARKED_PRESENT;
> -}
> -
>  static inline size_t mem_section_usage_size(void)
>  {
>  	return struct_size_t(struct mem_section_usage, pageblock_flags,
> diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
> index 193a88d763abf..73d637d28c8e6 100644
> --- a/scripts/gdb/linux/mm.py
> +++ b/scripts/gdb/linux/mm.py
> @@ -76,7 +76,7 @@ class x86_page_ops():
>              self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
>          except:
>              self.SECTION_HAS_MEM_MAP = 1 << 0
> -            self.SECTION_IS_EARLY = 1 << 3
> +            self.SECTION_IS_EARLY = 1 << 2

Seems a bit strage given the code is:

        try:
            self.SECTION_HAS_MEM_MAP = 1 << int(gdb.parse_and_eval('SECTION_HAS_MEM_MAP_BIT'))
            self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
        except:
            self.SECTION_HAS_MEM_MAP = 1 << 0
            self.SECTION_IS_EARLY = 1 << 2

Whereas other variables must be available with no try, e.g.:

        self.PAGE_OFFSET = int(gdb.parse_and_eval("page_offset_base"))
        self.VMEMMAP_START = int(gdb.parse_and_eval("vmemmap_base"))
        self.PHYS_BASE = int(gdb.parse_and_eval("(unsigned long) phys_base"))

etc.

Is there some weirdness with gdb? Or is it maybe because there are some configs
without these symbols maybe?

>
>          self.SUBSECTION_SHIFT = 21
>          self.PAGES_PER_SUBSECTION = 1 << (self.SUBSECTION_SHIFT - self.PAGE_SHIFT)
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
