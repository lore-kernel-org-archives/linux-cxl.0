Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3C30C63B;
	Tue, 17 Mar 2026 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770525; cv=none; b=Gq3d8/ijUX29zty+00vjzO5zE6M4wfAg5V0Kw+YXBetEkOxfZI8oLlTWKSRgFLD9p6wvtCPghA62ghA3hGBOg4L44YEnj1uculM0378oawlYh/PmAjL6H40ePSZJK2TzyR6Bq64sO810awZHNmfp3ozZDbJ8M7szW7bt7vQiKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770525; c=relaxed/simple;
	bh=heRUqLM6WOMvSWX3bQEpAKMgcGGvYDSbOPDUMCKJNCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX/0NXlaScFD4wQlnt1cMuDWiuX8DNJR86IYIieahE/voZjuWeXc/5ktJroEPrloiNfIZA3XRsaPQcXyeZFwlbtX9pYsogPQEQTm2mb9O6dDwVFsjHXYE72ejg73QQaAoWnCftZ+1kweDh++VcfEITLRT3IikowRFSV69tkVARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7FEkuF1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7FEkuF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608ACC4CEF7;
	Tue, 17 Mar 2026 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770525;
	bh=heRUqLM6WOMvSWX3bQEpAKMgcGGvYDSbOPDUMCKJNCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7FEkuF1UZcijSe2FoHeEAXDGEOv5m79j1JHPT7si45zPq5pFrcvqXF3ZpR/Y2+6R
	 YEmQf/TlZmXt92wb+c1wcXSW3fvnwmGlIUtXi8WmX+DevEQDM7sQcG/hJ+q2E18GJ9
	 EOFoKf1+LWoY/IBb5dLVwiC3lRkHCNxmsBVmzO6Em30pC0cvPS1IcbkFORoIaULmHi
	 y8FwOlfaP26Pxl3nkJ7mpqhv+NCL1WGCUVDYTTd2G6roRJXEC9FjECJiHe5c3BEC/N
	 tv+zBc9Py6+aMTGgTVQvXdRDmdjA5VXLZEov4q7grJU3BN1JGdv6K3OggQCz1osDXO
	 LfCD5xuNMRSPw==
Date: Tue, 17 Mar 2026 18:02:00 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 07/14] mm/bootmem_info: avoid using
 sparse_decode_mem_map()
Message-ID: <22fbfd1f-21aa-43ab-9eb5-28c57972540f@lucifer.local>
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

Maybe worth saying aligned to the start of the section?

> sure it is.
>
> We will soon might try to remove the bootmem info completely, for now,
> just keep it working as is.

*gasp*

>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

If it boots ship it, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

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

Yeah SPARSE_VMEMMAP should make it this trivial.

>  	section_nr = pfn_to_section_nr(start_pfn);
>  	ms = __nr_to_section(section_nr);
>
> -	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -

So this is nice...

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

Cheers, Lorenzo
