Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8F1A08AF;
	Wed, 18 Mar 2026 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822021; cv=none; b=a1NWEOU3yYbjLN5vB9cRSL3cyI3um+9qXpaipw2WcWOs/iemFL0lvUakxCJZnE//fd9PsNOvT4R0LbqyoMNWKRpguxbvbJ7SpsXHFoQhdz65VhGiDCSLKpZF28Oy1Mr1gfIjFr9cvG7ONx1aYGrNZPa28qOjRGe6ih6el5lBaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822021; c=relaxed/simple;
	bh=aQAhk0sXXDYLvUo6haMj9vWgsIfwV36jAQ6E1OobyX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPm0yCddqYLu7Sg9i1m/fa5KbC3nE7p1LTFzdqWyd8uI1GQSR68+NAM0Jzg3X2gMOvuGgJHOxOdF1HX2S982L1DCpBjeXl57E1AHSydTjMzEZRcldyWmmONS/Cz8v5DTgeyAMoF8bD/GykI9hBxUuH5rXl5PZx4T2s+KP0fgO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXWpygRH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXWpygRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42A2C19421;
	Wed, 18 Mar 2026 08:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773822021;
	bh=aQAhk0sXXDYLvUo6haMj9vWgsIfwV36jAQ6E1OobyX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXWpygRHCWyhLEE+w7ya/9J5hxUvfUcyAIJcOaTEBfJjhiXVhVNFnzwLsLn1x8tcA
	 GwfaCkHE2oYzOmw1atEtba+VRHMoKJkrkkaWPZ7WI8cI8jLXOsrrzzF6oRq9OcLXCa
	 8ZYJgbIBXVc7B6FZTaXzmobFa/fjhQzwZiIDatb1bXsoZtsVl5qsagoo88d3eTuENG
	 8wN7AgE5PS+nBmxjL7Kvs2VplQoCI5CIIH+okwNXGzu4pSmGklVacd6cLC7ld3YUKq
	 yqaivLf5KshOZ/aId7JS/WdnDCiS1rsdDdWARgFNJXGlxxG8MRt8SXskbTaBWz2YtO
	 tuyTLdBlJTaMw==
Date: Wed, 18 Mar 2026 10:20:14 +0200
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
Subject: Re: [PATCH 07/14] mm/bootmem_info: avoid using
 sparse_decode_mem_map()
Message-ID: <abpgPvayKswnaEJl@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-8-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-8-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:45PM +0100, David Hildenbrand (Arm) wrote:
> With SPARSEMEM_VMEMMAP, we can just do a pfn_to_page(). It is not super
> clear whether the start_pfn is properly aligned ... so let's just make
> sure it is.
> 
> We will soon might try to remove the bootmem info completely, for now,
> just keep it working as is.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/bootmem_info.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index e61e08e24924..3d7675a3ae04 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -44,17 +44,16 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  {
>  	unsigned long mapsize, section_nr, i;
>  	struct mem_section *ms;
> -	struct page *page, *memmap;
>  	struct mem_section_usage *usage;
> +	struct page *page;
>  
> +	start_pfn = SECTION_ALIGN_DOWN(start_pfn);
>  	section_nr = pfn_to_section_nr(start_pfn);
>  	ms = __nr_to_section(section_nr);
>  
> -	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -
>  	if (!preinited_vmemmap_section(ms))
> -		register_page_bootmem_memmap(section_nr, memmap,
> -				PAGES_PER_SECTION);
> +		register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
> +					     PAGES_PER_SECTION);
>  
>  	usage = ms->usage;
>  	page = virt_to_page(usage);
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
