Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B3332628;
	Tue, 17 Mar 2026 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770067; cv=none; b=fWVqCI5warYiV/Lu1sDRsBZitv/zExsORHESiXKFNipJ7DYa4We4M8Io5IEV+wjcTHQrAldpoz01IJkF0PZCEMPp+dQLFX61hyCMyGzuFAsNMQyUEYddiW0HE9BZPPxy/ydjstSTSv+URdqadB7O9S2eXQT74Ef3763/yguSlnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770067; c=relaxed/simple;
	bh=YGGHNltRGX0FS2ePD1Sk35NmzG1l/R/IBlMBvqXxvkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trTPhED3j2feIocGe7R4S1QUo+ruxh/FsAFQs608Adm+iP2wfHt5iKylawxbcEVZvh3LiE2yYAVp8mWud1zWmmcrpL5w/pi5Avu5ahGRAJGMxlL8NqQSNDkqFtCV/h86ckpYXMm3O0bP8Rqv8LBPAIRrnp7MzsqCqgmkfXgu3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbfn/CI/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbfn/CI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63F8C19424;
	Tue, 17 Mar 2026 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770067;
	bh=YGGHNltRGX0FS2ePD1Sk35NmzG1l/R/IBlMBvqXxvkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hbfn/CI/zGXlDDVFdgHQOJzpQYu/E43aEwVYQIyT6d3HT0ilz3L36kDhD5yOx2nV6
	 9tg9T9rBrRu2ooljimGeAlr/VRxPn9U2ffLhBJRrRki3YBlELUHRJSdlaYhNgTswfI
	 qPTnvuLKYz8gS7Tgxd+EASQqairTfeIf6kB1uszkJs5Th7frKObV+oyll06xIbPdyX
	 37JkK2aNfQwTC1dhMJXnuHeBvy56fkx1qtwFY5g5WZxIS7tmmzQyPybA703YTH/p0c
	 /GzKzx94feRxtu+0z6dz5jh0ZTFPuqB4+g+808r4/63nS4eYzH3JPZWYporc0+1i2I
	 cM4F06lrW2LOA==
Date: Tue, 17 Mar 2026 17:54:22 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 05/14] mm/sparse: remove !CONFIG_SPARSEMEM_VMEMMAP
 leftovers for CONFIG_MEMORY_HOTPLUG
Message-ID: <ac577def-41d0-49e7-9dc3-4074bacbfc42@lucifer.local>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-6-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-6-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:43PM +0100, David Hildenbrand (Arm) wrote:
> CONFIG_MEMORY_HOTPLUG now depends on CONFIG_SPARSEMEM_SPARSEMEM. So
> let's remove the !CONFIG_SPARSEMEM_VMEMMAP leftovers.

(As said on 6/14 that I inexplicably reviewed before this one) - might be worth
explicitly saying 'dead code' here to underline it.

>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sparsemem? More like sparsecode now! Right? RIGHT? Anyway,

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/sparse.c | 61 -----------------------------------------------------
>  1 file changed, 61 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 93252112860e..636a4a0f1199 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -657,7 +657,6 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  	}
>  }
>
> -#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  static struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>  		struct dev_pagemap *pgmap)
> @@ -729,66 +728,6 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>
>  	return rc;
>  }
> -#else
> -static struct page * __meminit populate_section_memmap(unsigned long pfn,
> -		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
> -		struct dev_pagemap *pgmap)
> -{
> -	return kvmalloc_node(array_size(sizeof(struct page),
> -					PAGES_PER_SECTION), GFP_KERNEL, nid);
> -}
> -
> -static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> -		struct vmem_altmap *altmap)
> -{
> -	kvfree(pfn_to_page(pfn));
> -}
> -
> -static void free_map_bootmem(struct page *memmap)
> -{
> -	unsigned long maps_section_nr, removing_section_nr, i;
> -	unsigned long type, nr_pages;
> -	struct page *page = virt_to_page(memmap);
> -
> -	nr_pages = PAGE_ALIGN(PAGES_PER_SECTION * sizeof(struct page))
> -		>> PAGE_SHIFT;
> -
> -	for (i = 0; i < nr_pages; i++, page++) {
> -		type = bootmem_type(page);
> -
> -		BUG_ON(type == NODE_INFO);
> -
> -		maps_section_nr = pfn_to_section_nr(page_to_pfn(page));
> -		removing_section_nr = bootmem_info(page);
> -
> -		/*
> -		 * When this function is called, the removing section is
> -		 * logical offlined state. This means all pages are isolated
> -		 * from page allocator. If removing section's memmap is placed
> -		 * on the same section, it must not be freed.
> -		 * If it is freed, page allocator may allocate it which will
> -		 * be removed physically soon.
> -		 */
> -		if (maps_section_nr != removing_section_nr)
> -			put_page_bootmem(page);
> -	}
> -}
> -
> -static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> -{
> -	return 0;
> -}
> -
> -static bool is_subsection_map_empty(struct mem_section *ms)
> -{
> -	return true;
> -}
> -
> -static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_SPARSEMEM_VMEMMAP */

So this was all dead code again? Ugh.

>
>  /*
>   * To deactivate a memory region, there are 3 cases to handle across
> --
> 2.43.0
>
