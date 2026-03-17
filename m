Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB073264D0;
	Tue, 17 Mar 2026 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777603; cv=none; b=aODZbc/ZCg6caWm8OfEhCOMU37k1nNzlQIVx8dCkXOqkoTrRQtOs5XorhL7ztYCcAIwnBidM1l7G/q6/4bdQdEcKJfQ76JcF+aU1VbIGfmrsOicNO9UmgzXQ6C8SbmXVxQc6kyPA2s9khfmsAEYnkfHt/SKgSBKOQjADdyBsxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777603; c=relaxed/simple;
	bh=aMcAv71YOkkFD+ju6rmRuDp0ZfzNN0oX5ZYRoLlaqM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q16fdYULVtZA9x5lFlgO4KeVF8E/kMeX7L+oxSOsFdNuAsY9bSRPIMb3QcGvuDYLcGGM89OHmU9iNkBrWBMb4Y8uMRYUILcye+XVZtpZG9w3z4mpFy8NBXfWMkBfa+c0IxEbRZ9PMp/8DYsEmv3tvOjUDuQEceh7G1JPYb/Tjvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKGd0sMP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKGd0sMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBFAC4CEF7;
	Tue, 17 Mar 2026 20:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773777602;
	bh=aMcAv71YOkkFD+ju6rmRuDp0ZfzNN0oX5ZYRoLlaqM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKGd0sMPoOpRVFAvsPtlMPnbCySVNbT0yywJFqBvpiy0zWYqxgnuY+ZsiMZUGejJy
	 at8VEBsz4BvVz59tpwJzURVLDNBxEux9bzvwu034bpHA68XAWcVDIfU19lOboFHxXs
	 11Zhcykek8uAPKp/TVQUWRMO+eysqaOD1ioKfdb6Qo4ut4eF4J8ac0N0jctfHvmNKy
	 KGj0TMwBINqpF+dExGqEdAXsNbXMJtK5K1lwSlg0I0QaxlAaWdEob3Pl4N+cFa+9pY
	 sFgLrQUApIcg1iu5bMgUTS1W68KTWAJL/6v/YHinLLaG4DvTRJD/fi6lmM9hXS4I3x
	 P7nShZRDiUeJA==
Date: Tue, 17 Mar 2026 20:00:00 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 12/14] mm/sparse: move sparse_init_one_section() to
 internal.h
Message-ID: <f063704a-ffb4-4273-aa6a-ded3a565a891@lucifer.local>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-13-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-13-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:50PM +0100, David Hildenbrand (Arm) wrote:
> While at it, convert the BUG_ON to a WARN_ON, avoid long lines, and merge
> sparse_encode_mem_map() into sparse_init_one_section().
>
> Clarify the comment a bit, pointing at page_to_pfn().
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Don't need a long line to merge my:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Here!

> ---
>  include/linux/mmzone.h |  2 +-
>  mm/internal.h          | 22 ++++++++++++++++++++++
>  mm/sparse.c            | 24 ------------------------
>  3 files changed, 23 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b694c69dee04..dcbbf36ed88c 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2008,7 +2008,7 @@ struct mem_section {
>  	/*
>  	 * This is, logically, a pointer to an array of struct
>  	 * pages.  However, it is stored with some other magic.
> -	 * (see sparse.c::sparse_init_one_section())

What::the::hell::was::this::before, we're not C++ developers!!

> +	 * (see sparse_init_one_section())
>  	 *
>  	 * Additionally during early boot we encode node id of
>  	 * the location of the section here to guide allocation.
> diff --git a/mm/internal.h b/mm/internal.h
> index 5f5c45d80aca..bcf4df97b185 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -965,6 +965,28 @@ void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
>   */
>  #ifdef CONFIG_SPARSEMEM
>  void sparse_init(void);
> +
> +static inline void sparse_init_one_section(struct mem_section *ms,
> +		unsigned long pnum, struct page *mem_map,
> +		struct mem_section_usage *usage, unsigned long flags)
> +{
> +	unsigned long coded_mem_map;
> +
> +	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
> +
> +	/*
> +	 * We encode the start PFN of the section into the mem_map such that
> +	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
> +	 * from the page pointer to obtain the PFN.
> +	 */
> +	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(pnum));
> +	VM_WARN_ON(coded_mem_map & ~SECTION_MAP_MASK);

Maybe VM_WARN_ON_ONCE()?

> +
> +	ms->section_mem_map &= ~SECTION_MAP_MASK;
> +	ms->section_mem_map |= coded_mem_map;
> +	ms->section_mem_map |= SECTION_HAS_MEM_MAP | flags;

I mean this is pretty nitty but prefer 'flags | SECTION_HAS_MEM_MAP' to
show you appended to the flags :P

> +	ms->usage = usage;
> +}
>  #else
>  static inline void sparse_init(void) {}
>  #endif /* CONFIG_SPARSEMEM */
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b5a2de43ac40..6f5f340301a3 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -256,30 +256,6 @@ static void __init memblocks_present(void)
>  		memory_present(nid, start, end);
>  }
>
> -/*
> - * Subtle, we encode the real pfn into the mem_map such that
> - * the identity pfn - section_mem_map will return the actual
> - * physical page frame number.
> - */
> -static unsigned long sparse_encode_mem_map(struct page *mem_map, unsigned long pnum)
> -{
> -	unsigned long coded_mem_map =
> -		(unsigned long)(mem_map - (section_nr_to_pfn(pnum)));
> -	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
> -	BUG_ON(coded_mem_map & ~SECTION_MAP_MASK);
> -	return coded_mem_map;
> -}
> -
> -static void __meminit sparse_init_one_section(struct mem_section *ms,
> -		unsigned long pnum, struct page *mem_map,
> -		struct mem_section_usage *usage, unsigned long flags)
> -{
> -	ms->section_mem_map &= ~SECTION_MAP_MASK;
> -	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum)
> -		| SECTION_HAS_MEM_MAP | flags;
> -	ms->usage = usage;
> -}
> -
>  static unsigned long usemap_size(void)
>  {
>  	return BITS_TO_LONGS(SECTION_BLOCKFLAGS_BITS) * sizeof(unsigned long);
> --
> 2.43.0
>
