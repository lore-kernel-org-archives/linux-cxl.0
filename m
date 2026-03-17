Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660CA33D501;
	Tue, 17 Mar 2026 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775554; cv=none; b=VQsiZYmhpbW6LbpLnAGno0yCKj1ThDZVI8pIamDHOW5FrA4L0uwtt8evbCYFCX+aSzWwxPQvvlplIjPcu0TjE6zdAO2rgNbEgZ5MuAT0/3zg5RwiaCZWRtcqg2QPSAIAvwL9idOQcp3TUNVy5YbW0aWuDqH29MrSmNcEbIbhIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775554; c=relaxed/simple;
	bh=4nu8KnljxRbFha6Sm+hHFFmTLLWdkRQvURvX7OtTurU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLrIMUOw8wZ4rhdCvoCrACitV/4mO6//Zrtv4gt6Ab/IXgdZ+4osBjAjwsH7Oy7MQwC5oBOs3Wi34rgFWaazC1+VMWdqZCsebrdp/H+ylkkzWr+0YKQMsLK1LQRF3oAyqZJVmH/SQL/Rkcy8LkFWZLaR5q06n9JP8ZgoOJhxjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8zSkYT0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8zSkYT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAF7C4CEF7;
	Tue, 17 Mar 2026 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773775554;
	bh=4nu8KnljxRbFha6Sm+hHFFmTLLWdkRQvURvX7OtTurU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8zSkYT04onwGSDnKuMXibm9w3O9f3hWleOil/LUrBsyi/oH3sNoAtISP7jy/gmjB
	 Vd6WMM4NuO4qgnRTU0j6jFuBedmmyjYTV6ez0WbHQojpkql9la1JIe4iEGdZ8dNi3L
	 4H+J6yUYN2VSQ0cTjGLGAPaFsUMbYnmgIYB2wxSaT9+9ikDDJ9DgpHNAXjh5xM87LW
	 FTQkt+KzEvJSlOQBRR6zwuzj3SUuPsLXOqzhU32oIJ+V3ti+j6Er9ZEx6pgretEFMv
	 RKqU2yS8fgfwpTCwWtqvEr8G+YjC0XYI9CWz33MMVGjC8w1+wEJDqMT/Y5yWCa9KBX
	 0q1oxBZwLAf/g==
Date: Tue, 17 Mar 2026 19:25:52 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 08/14] mm/sparse: remove sparse_decode_mem_map()
Message-ID: <8af7c994-14ac-4c9f-8c27-b35969440d80@lucifer.local>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-9-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-9-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:46PM +0100, David Hildenbrand (Arm) wrote:
> section_deactivate() applies to CONFIG_SPARSEMEM_VMEMMAP only. So we can
> just use pfn_to_page() (after making sure we have the start PFN of the
> section), and remove sparse_decode_mem_map().
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

it's more like pfn_to_patch(), so that's a:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

From me!

> ---
>  include/linux/memory_hotplug.h |  2 --
>  mm/sparse.c                    | 16 +---------------
>  2 files changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index e77ef3d7ff73..815e908c4135 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -308,8 +308,6 @@ extern int sparse_add_section(int nid, unsigned long pfn,
>  		struct dev_pagemap *pgmap);
>  extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
>  				  struct vmem_altmap *altmap);
> -extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
> -					  unsigned long pnum);
>  extern struct zone *zone_for_pfn_range(enum mmop online_type,
>  		int nid, struct memory_group *group, unsigned long start_pfn,
>  		unsigned long nr_pages);
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 636a4a0f1199..2a1f662245bc 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -274,18 +274,6 @@ static unsigned long sparse_encode_mem_map(struct page *mem_map, unsigned long p
>  	return coded_mem_map;
>  }
>
> -#ifdef CONFIG_MEMORY_HOTPLUG
> -/*
> - * Decode mem_map from the coded memmap
> - */
> -struct page *sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long pnum)
> -{
> -	/* mask off the extra low bits of information */
> -	coded_mem_map &= SECTION_MAP_MASK;
> -	return ((struct page *)coded_mem_map) + section_nr_to_pfn(pnum);
> -}
> -#endif /* CONFIG_MEMORY_HOTPLUG */
> -
>  static void __meminit sparse_init_one_section(struct mem_section *ms,
>  		unsigned long pnum, struct page *mem_map,
>  		struct mem_section_usage *usage, unsigned long flags)
> @@ -758,8 +746,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>
>  	empty = is_subsection_map_empty(ms);
>  	if (empty) {
> -		unsigned long section_nr = pfn_to_section_nr(pfn);
> -
>  		/*
>  		 * Mark the section invalid so that valid_section()
>  		 * return false. This prevents code from dereferencing
> @@ -778,7 +764,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  			kfree_rcu(ms->usage, rcu);
>  			WRITE_ONCE(ms->usage, NULL);
>  		}
> -		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> +		memmap = pfn_to_page(SECTION_ALIGN_DOWN(pfn));
>  	}
>
>  	/*
> --
> 2.43.0
>

Cheers, Lorenzo
