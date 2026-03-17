Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBEB1DFF0;
	Tue, 17 Mar 2026 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777096; cv=none; b=KQTv7mTiGJcuQ9TqbCgGVKfvvUNMcVU5cUsrqOQnnqOtll4Jz+mf6DoSEZ7zBWq8FIqfEYFkbDZRwo1ZFL7bRoE0KyImqGiC4gTSohJcLs35R5PrjE5crxFdCI/ScrC8a+/6l2ozAErEl1jcoZ3JTb8AlqtPHLpBZghaFg7wMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777096; c=relaxed/simple;
	bh=iu2cOBnlv8s0sPRqFeh8Lvb5iEQfijsU+S3paiRMUPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5QL9shZC2RWJLAc2vZtYM8+Exy0BRApY5Gd48QZwk4Y7/60x9FX5PU4BaIDYzr7x06WZfoH9yO1udnpbd4h8AvCniBNtHr5ojbpqjBmzlOGyiiQmjqgogZYSfCbVSMJUZx28gYJzAnswP4v+tyLtzsBf6+73TIVuw+ITZAEk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1dQCYTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1dQCYTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6424C4CEF7;
	Tue, 17 Mar 2026 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773777096;
	bh=iu2cOBnlv8s0sPRqFeh8Lvb5iEQfijsU+S3paiRMUPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1dQCYTegDy2569WFfrMTmWIMTBZA/60RJwwnXYXwzqTP00HyOjBN3LLeq7rCa7Wg
	 q1sOkQuf/5w9FWqLuj0sgz1mGK+DT8GaQbzC+slmDgJPnucdTQH2Q2d5dX5ZQuV2KL
	 7Dxeq/EqYJ3B16Ko9V6xIaKpCODeLAOKWKtNx7aD6BcoGksdepPy+2y37VV+HKB3HI
	 Qze7nClTtHearOiCGQqKElBC+AFYEaE75cUkxIf6S2fSkiYxBF5VAlQZN5W9U1b6E5
	 E10NA/5deA2pIybcmP7TclZbYnkuatsA9g/CheKbXyLhCIOAPw2QGBzMy9av5PWYRP
	 VVjRnH7Mp3vvw==
Date: Tue, 17 Mar 2026 19:51:34 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 10/14] mm: prepare to move subsection_map_init() to
 mm/sparse-vmemmap.c
Message-ID: <cb710be1-5fec-409a-a017-c794ecad0382@lucifer.local>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-11-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-11-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:48PM +0100, David Hildenbrand (Arm) wrote:
> We want to move subsection_map_init() to mm/sparse-vmemmap.c.
>
> To prepare for getting rid of subsection_map_init() in mm/sparse.c
> completely, use a static inline function for !CONFIG_SPARSEMEM_VMEMMAP.
>
> While at it, move the declaration to internal.h and rename it to
> "sparse_init_subsection_map()".

Why not init_sparse_subsection_map()??
Or sparse_init_map_subsection()????
Or <all other permutations>

Joking that's fine ;)

>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

You've initialised the sparse subsection of my heart, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  include/linux/mmzone.h |  3 ---
>  mm/internal.h          | 12 ++++++++++++
>  mm/mm_init.c           |  2 +-
>  mm/sparse.c            |  6 +-----
>  4 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 7bd0134c241c..b694c69dee04 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2002,8 +2002,6 @@ struct mem_section_usage {
>  	unsigned long pageblock_flags[0];
>  };
>
> -void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
> -
>  struct page;
>  struct page_ext;
>  struct mem_section {
> @@ -2396,7 +2394,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
>  #define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
>  #define sparse_vmemmap_init_nid_late(_nid) do {} while (0)
>  #define pfn_in_present_section pfn_valid
> -#define subsection_map_init(_pfn, _nr_pages) do {} while (0)
>  #endif /* CONFIG_SPARSEMEM */
>
>  /*
> diff --git a/mm/internal.h b/mm/internal.h
> index f98f4746ac41..5f5c45d80aca 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -960,12 +960,24 @@ void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
>  		unsigned long, enum meminit_context, struct vmem_altmap *, int,
>  		bool);
>
> +/*
> + * mm/sparse.c
> + */
>  #ifdef CONFIG_SPARSEMEM
>  void sparse_init(void);
>  #else
>  static inline void sparse_init(void) {}
>  #endif /* CONFIG_SPARSEMEM */
>
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +void sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages);
> +#else
> +static inline void sparse_init_subsection_map(unsigned long pfn,
> +		unsigned long nr_pages)
> +{
> +}
> +#endif /* CONFIG_SPARSEMEM_VMEMMAP */
> +
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>
>  /*
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 969048f9b320..3c5f18537cd1 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1898,7 +1898,7 @@ static void __init free_area_init(void)
>  		pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
>  			(u64)start_pfn << PAGE_SHIFT,
>  			((u64)end_pfn << PAGE_SHIFT) - 1);
> -		subsection_map_init(start_pfn, end_pfn - start_pfn);
> +		sparse_init_subsection_map(start_pfn, end_pfn - start_pfn);
>  	}
>
>  	/* Initialise every node */
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b57c81e99340..7b0bfea73a9b 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -185,7 +185,7 @@ static void subsection_mask_set(unsigned long *map, unsigned long pfn,
>  	bitmap_set(map, idx, end - idx + 1);
>  }
>
> -void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> +void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  {
>  	int end_sec_nr = pfn_to_section_nr(pfn + nr_pages - 1);
>  	unsigned long nr, start_sec_nr = pfn_to_section_nr(pfn);
> @@ -207,10 +207,6 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
>  		nr_pages -= pfns;
>  	}
>  }
> -#else
> -void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> -{
> -}
>  #endif
>
>  /* Record a memory area against a node. */
> --
> 2.43.0
>
