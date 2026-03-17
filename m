Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB513FCC;
	Tue, 17 Mar 2026 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769789; cv=none; b=E3xb3hWZRoLWwf56cCQEp4+3XoIQsqbPXWbDoLeTb/q6ZOW7Qvq8KDFUh8N66KxuStcl66tVSIuMewgK/vjXUyqSgLbUezi001eEq0pgK20t0IJ7wTbVAeVop53HE80Jx+Nhc8lXrVTJwBlA3hf2Bl6wlvXVHRjm3Ok+jTq60mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769789; c=relaxed/simple;
	bh=9raS/7flhBB8OwQhQ4gASkXcC/85pn+Jci4JhvWANfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Olo+W2tPk9n0zvQJnvph/y5ZSunwjFUwEL5Iwmm5TUB5cSxyMeC1Pl13FsLEsH85+fmGR/z1Z3I9BTs32S1FWTEPEL4bH9ev8c4OQUmwgT0AhklBoB906Dq2azpvibu/+L5H54uqTC1txfJx2ITJHz1hg5/Eyd9bkCmC6xDH/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgYf2ED6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgYf2ED6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FF5C4CEF7;
	Tue, 17 Mar 2026 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773769788;
	bh=9raS/7flhBB8OwQhQ4gASkXcC/85pn+Jci4JhvWANfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DgYf2ED6QD1WJ+wF8r91rGazHA0yK1ttXIt6EgYz/ua6lP49TQKs9tNT3lc66Z8pO
	 45gKll3wHvsc6O9VqDVQa9uZqKq4w5aUHQDbesOjd6jP09d7ogziHFouxypjZSpo0o
	 2wZpBvDckbvCLNZg7aVWL341chOXXdpGcYr4vmJRT2RKDUhU5+zbBzIPq1n3mVuluo
	 AeDMkpCFpKCaBFdpD+3b1x3W52Gjl0rWrzcCOjlux8F14oXL1DHBZK6u/ykghz1pYp
	 gRnffeSK5tTS+NsmIGd5fMIpUv7siOEr8D8bYSu2ymCA21XTVCYzAv77I2Iv+6Si2B
	 sTvLY98exQj1w==
Date: Tue, 17 Mar 2026 17:49:44 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 06/14] mm/bootmem_info: remove handling for
 !CONFIG_SPARSEMEM_VMEMMAP
Message-ID: <e0e1ad60-5901-44cd-b077-a0aa6924ebf4@lucifer.local>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-7-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-7-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:44PM +0100, David Hildenbrand (Arm) wrote:
> It is not immediately obvious that CONFIG_HAVE_BOOTMEM_INFO_NODE is
> only selected from CONFIG_MEMORY_HOTREMOVE, which itself depends on
> CONFIG_MEMORY_HOTPLUG that ... depends on CONFIG_SPARSEMEM_VMEMMAP.

Ugh god.

>
> Let's remove the !CONFIG_SPARSEMEM_VMEMMAP leftovers.

Maybe worth explicitly saying 'dead code' here just to underline how stupid this
was...

>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

This might be dead code, but this is a dead on patch, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/bootmem_info.c | 37 -------------------------------------
>  1 file changed, 37 deletions(-)
>
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index b0e2a9fa641f..e61e08e24924 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -40,42 +40,6 @@ void put_page_bootmem(struct page *page)
>  	}
>  }
>
> -#ifndef CONFIG_SPARSEMEM_VMEMMAP
> -static void __init register_page_bootmem_info_section(unsigned long start_pfn)
> -{
> -	unsigned long mapsize, section_nr, i;
> -	struct mem_section *ms;
> -	struct page *page, *memmap;
> -	struct mem_section_usage *usage;
> -
> -	section_nr = pfn_to_section_nr(start_pfn);
> -	ms = __nr_to_section(section_nr);
> -
> -	/* Get section's memmap address */
> -	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -
> -	/*
> -	 * Get page for the memmap's phys address
> -	 * XXX: need more consideration for sparse_vmemmap...
> -	 */
> -	page = virt_to_page(memmap);
> -	mapsize = sizeof(struct page) * PAGES_PER_SECTION;
> -	mapsize = PAGE_ALIGN(mapsize) >> PAGE_SHIFT;
> -
> -	/* remember memmap's page */
> -	for (i = 0; i < mapsize; i++, page++)
> -		get_page_bootmem(section_nr, page, SECTION_INFO);
> -
> -	usage = ms->usage;
> -	page = virt_to_page(usage);
> -
> -	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
> -
> -	for (i = 0; i < mapsize; i++, page++)
> -		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
> -
> -}

So this was just dead code before? That's gross.

> -#else /* CONFIG_SPARSEMEM_VMEMMAP */
>  static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  {
>  	unsigned long mapsize, section_nr, i;
> @@ -100,7 +64,6 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  	for (i = 0; i < mapsize; i++, page++)
>  		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
>  }
> -#endif /* !CONFIG_SPARSEMEM_VMEMMAP */
>
>  void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
>  {
> --
> 2.43.0
>
