Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A137AA8F;
	Wed, 18 Mar 2026 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822065; cv=none; b=sQnJvU0RPjpE2qu3J45K16jHFquNn6nqbYFsfO2H6dGCWEyxx+A3O5OhOIZIu96wJjv0i+GM6Cp86lWkLQC3mr/+Zagt6mdFXsoz+y5+bj8jJMnqBGWgB02lIwpTMqS1iURgSrIZTG09Ub89YKVwqt96i+MEtOV7blJUyPhJqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822065; c=relaxed/simple;
	bh=EA79S28YVeZYHQpiP11IUWT/puy5gsehhvHI39K5RCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo+wSjx6MR9m6JCQ4ATVqDJVwIH0h19vdPtEDTLVJ5r8Sl17Cfm3ZMIB9LKjHT6Ja25EvJ+0dU13FAxkUjZzCC/nZEp/MN7CEXZJuekvkmm1WSTy1v4QKliYjndN9bAwXDXgjwgL1nCLix9dINJAMtPwsZcQ8LuyorNeu18eMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dopbr9ya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dopbr9ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209E8C19421;
	Wed, 18 Mar 2026 08:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773822065;
	bh=EA79S28YVeZYHQpiP11IUWT/puy5gsehhvHI39K5RCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dopbr9yafQgjd3ZiDSZBGn/mrAXnmFXRG0L6C4WtOtDytHn3DWBdmF6Yn8Mb7Yxl0
	 Ulwn3CljS3CGdFVb0E46PE1tphGRF6X0dV6JP45JIvTBuFdX7043OZKOgisLM7Nw65
	 vBUyo5nIeT/oKBeASofgIeXFwhVo7Zphn/Kvn9jECbGCGcFM/4ILQm8/XEGMs1/MYY
	 yfB1kz+TUiMTsP8cH+KOvkBB7472VS8/1FEfJCvIsydVdViqkiK0PmcF216+iWLf2k
	 89atoDsTCZVmnzV/XgzPCJVvcWLEb+VaA5IQGFHZ25s6FteU3fFl3606PSa2MXOsoG
	 ihSq7wogzqhRw==
Date: Wed, 18 Mar 2026 10:20:58 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 08/14] mm/sparse: remove sparse_decode_mem_map()
Message-ID: <abpgagKxOP7klxWC@kernel.org>
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

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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

-- 
Sincerely yours,
Mike.
