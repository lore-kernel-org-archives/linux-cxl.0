Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC833493D4C;
	Thu, 10 Sep 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047982; cv=none; b=WIHqjaBZiR05OCIeXIqxigiwhSdL4hDi6rc7zHT6e2YChpACH1F7f83jrG/IrmvBgyog7ppTtXisgrqvmlCYMbDP0ksrbF0AGiuXCM5M995Ve+8Fooq1lt16ckMFHXwUtO0pZoxjsVtggjPoOtkOy+A5nCId7K00s1LVo0yeT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047982; c=relaxed/simple;
	bh=E34Z6tJW53qNsLvxhsi+kDB305Wl4st8MTrqwJgLrMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcyK9/rU/hZTKNsIeSy3us9Fvg53np67n+bsemcvUFKuQu9fyXClLjdDswVGYReHKEw9VHGZ6wEhNh6diNA89TxccdxKK5rxsF7wVCvSKE9ilHqXDLF2xpudJ7Hx/J3zfs5G3qUsxRR3ORdAHApQFhs9S0BtfPJ/9j038Ky5760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvRVzZSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvRVzZSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C30C1F00893;
	Thu, 10 Sep 2026 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047980;
	bh=/Oe0BvZm5FHOvWBkLD3sNkGjaEgWZ8qDgMjtwDlhRx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fvRVzZSBUred0+u9ZQGfr/eDwhY+FWpsp+KPRzqTc4UYs+y6VkFGW+G4q5kdf/fZo
	 AEEaXO2uGaKETeaPeRvLq1Nb7fO3l5h4s28rPYakOOGfPyl89tQinq/gc2TsS7axA7
	 RosUfXB0gXldHTtA0tddCh6NOIv2257dojEqJpHI2Rl8pkue7QktJTQN0KtBXMUq+y
	 ztvRaFlzTBgWV+3khp5WfVi459lxuuiRzYbq+27orKgkKhvl6cgNSQgmNBDd7LyEuV
	 VTC0WJ1MmjAjMu5MbcTHk88L7CPBn4OSwchrXgkkk+krTVK0J/L7YDqv5j/fdEz99i
	 4kEI4T3Rk+uLw==
Date: Thu, 10 Sep 2026 14:46:10 +0100
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
Subject: Re: [PATCH 04/12] mm/sparse: rename and cleanup sparse_init_nid()
Message-ID: <aqK0S1OT5csJFIq1@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-4-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-4-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:57PM +0200, David Hildenbrand (Arm) wrote:
> Let's rename it to "sparse_metadata_init_nid", avoid the "pnum" terminology
> and drop the function comment. Further, rename the "map" variable to
> "mem_map" for consistency with other functions.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, one nit below.

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/sparse.c | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index a85a9c3840f6c..f84bfceb53060 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -222,37 +222,34 @@ void __weak __meminit vmemmap_populate_print_last(void)
>  {
>  }
>
> -/*
> - * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
> - * And number of present sections in this node is map_count.
> - */
> -static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> -				   unsigned long pnum_end,
> -				   unsigned long map_count)
> +static void __init sparse_metadata_init_nid(int nid,
> +		unsigned long start_section_nr, unsigned long end_section_nr,
> +		unsigned long nr_sections)
>  {
> -	unsigned long pnum;
>  	struct mem_section_usage *usage;
> +	unsigned long section_nr;
>
> -	usage = memblock_alloc_node(map_count * mem_section_usage_size(),
> +	usage = memblock_alloc_node(nr_sections * mem_section_usage_size(),
>  				    SMP_CACHE_BYTES, nid);
>  	if (!usage)
>  		panic("Failed to allocate usemap for node %d\n", nid);
>
> -	for_each_present_section_nr(pnum_begin, pnum) {
> -		unsigned long pfn = section_nr_to_pfn(pnum);
> -		struct page *map;
> +	for_each_present_section_nr(start_section_nr, section_nr) {
> +		unsigned long pfn = section_nr_to_pfn(section_nr);

NIT: Could be const?

> +		struct page *mem_map;
>
> -		if (pnum >= pnum_end)
> +		if (section_nr >= end_section_nr)
>  			break;
>
> -		map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
> -						nid, NULL, NULL);
> -		if (!map)
> -			panic("Failed to allocate memmap for section %lu\n", pnum);
> +		mem_map = __populate_section_memmap(pfn, PAGES_PER_SECTION, nid,
> +						    NULL, NULL);
> +		if (!mem_map)
> +			panic("Failed to allocate memmap for section %lu\n",
> +			      section_nr);
>  		memmap_boot_pages_add(section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
>  							       NULL, NULL));
> -		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
> -					SECTION_IS_EARLY);
> +		sparse_init_one_section(__nr_to_section(section_nr), section_nr,
> +					mem_map, usage, SECTION_IS_EARLY);
>  		usage = (void *)usage + mem_section_usage_size();
>  	}
>  }
> @@ -270,12 +267,14 @@ static void __init sparse_metadata_init(void)
>  			nr_sections++;
>  			continue;
>  		}
> -		sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
> +		sparse_metadata_init_nid(nid_begin, start_section_nr,
> +					 section_nr, nr_sections);
>  		nid_begin = nid;
>  		start_section_nr = section_nr;
>  		nr_sections = 1;
>  	}
> -	sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
> +	sparse_metadata_init_nid(nid_begin, start_section_nr, section_nr,
> +				 nr_sections);
>  }
>
>  /*
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
