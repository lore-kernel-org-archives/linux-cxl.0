Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8037E5FF;
	Mon, 14 Sep 2026 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379161; cv=none; b=YECR55ert6flIrLithDkEyynMVDbtJIfGI/QUPnImet15OlShp7J5bt1SYZ1CLywY4kUZ50YaWBUVSu+iwYLKLA9fDGRtDUgy8kI23fQBiAquB8jYjqQ1rLCO/Oqc/6nzPE6rWdqhvK+5ogKiZRyj0s2eMsGO8B0mkWlx00Yon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379161; c=relaxed/simple;
	bh=ZNXAF+fldZt9CiTjdoLajXZnip6ALRlCNWRxKjuS+2k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JrUW255DKImzI1T54wV2lrmfJUnOPzu7hFU2abJtMxt7EB57iR1X0wYwjqk9yKOIveapQLOxLOfCTFj6FbLe8zonnQFa2cKEqv8+Dh0YeLp6uZ7McAaaLsekyAU/4qt4lUs54FZ1hWPRbzZqlXKaE4blADH/TGvlgDIE1waLuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeeTb+Rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeeTb+Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F441F000FF;
	Mon, 14 Sep 2026 09:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379159;
	bh=EVDkiB/u4ANeDZ9eCMi1XniQjxMrh+Q0HF16352Y+vY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IeeTb+RpcbpF5esAjySgSwSY1qum2m+Nl37yAGe+xj2Q80HbvcdFIPGVCMNU3KVoP
	 uQZEQ4Zuotcba9TqQozTwh2LrGjGKJPKhXFJ6iNaGTuzV09TqvnoWOCiovZ4quMCqn
	 RUou07J5p1hWTRWC4xbxvqHxY1nHDWgzQVwFrYR2aYq6kSC1T7feIrJ3mBjAP89ABx
	 zULlCo7YhYc4TVfLt5wyBclswaBvD5+BMRkoSl+9VqLLT9fj2peM+RfWrITkyzkIgl
	 6JeugRRhmyAowxIl/JDFveZvlajXG0c7bBMoDhp4khpIOijYILwBxauL6BktzhgUAv
	 LAz122LENS5WA==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/12] mm/sparse: refactor sparse_sections_init()
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-2-008fc8d579fe@kernel.org>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-2-008fc8d579fe@kernel.org>
Date: Mon, 14 Sep 2026 12:45:42 +0300
Message-Id: <178937914266.4188640.15458944773619773879.b4-review@b4>
X-Mailer: b4 0.17-dev

> memory_present() really identifies+prepares all early sections so the
> initialization in sparse_init() can properly iterating them to

Nit:                                           ^ iterate

> initialize metadata.
> 
> Let's just inline memory_present() into sparse_sections_init() and
> cleaning up the code a bit while at it: make it clear that we are operating

 ^ clean

> on pfns.
> 
> Note that we call set_section_nid() now only if the section
> was not already created earlier. Now, there is no more inconsistency
> between what we (temporarily) store in ms->section_mem_map and what
> we store in our section->nid array.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6a6d258862904..36e3d854febc5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -179,22 +179,27 @@ static inline unsigned long first_present_section_nr(void)
>  	return next_present_section_nr(-1);
>  }
>  
> -/* Record a memory area against a node. */
> -static void __init memory_present(int nid, unsigned long start, unsigned long end)
> +void __init sparse_sections_init(void)
>  {
> -	unsigned long pfn;
> +	unsigned long pfn, start_pfn, end_pfn;
> +	int i, nid;
> +
> +	sparse_extreme_init();
>  
> -	start &= PAGE_SECTION_MASK;
> -	mminit_validate_memmodel_limits(&start, &end);
> -	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
> -		unsigned long section_nr = pfn_to_section_nr(pfn);
> -		struct mem_section *ms;
> +	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
> +		start_pfn &= PAGE_SECTION_MASK;
> +		mminit_validate_memmodel_limits(&start_pfn, &end_pfn);
>  
> -		sparse_index_init(section_nr, nid);
> -		set_section_nid(section_nr, nid);
> +		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> +			unsigned long section_nr = pfn_to_section_nr(pfn);
> +			struct mem_section *ms;
>  
> -		ms = __nr_to_section(section_nr);
> -		if (!ms->section_mem_map) {
> +			sparse_index_init(section_nr, nid);
> +			ms = __nr_to_section(section_nr);
> +			if (ms->section_mem_map)
> +				continue;
> +
> +			set_section_nid(section_nr, nid);
>  			ms->section_mem_map = sparse_encode_early_nid(nid) |
>  							SECTION_IS_ONLINE;
>  			__section_mark_present(ms, section_nr);
> @@ -202,18 +207,6 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>  	}
>  }
>  
> -/* Initialize memory section metadata for all system memory. */
> -void __init sparse_sections_init(void)
> -{
> -	unsigned long start, end;
> -	int i, nid;
> -
> -	sparse_extreme_init();
> -
> -	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
> -		memory_present(nid, start, end);
> -}
> -
>  #ifndef CONFIG_SPARSEMEM_VMEMMAP
>  struct page __init *__populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

