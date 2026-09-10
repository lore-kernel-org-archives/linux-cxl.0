Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805AF48F823;
	Thu, 10 Sep 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046965; cv=none; b=Pzfqvw0rahNMDbnKHKPcakcvII27R6QFfn2Vt7kQNThi1r53JRC54rmZn8XATj0VyqloR/FD7HpDZcV+94JRVNxClKA9Ep2tG9sHTzlF8RhlWbM4NOYPLWP65Jx1+LW8MIovHmSUZLztOgsDu49X1u+e6ugJ0R4Tus2lbilNJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046965; c=relaxed/simple;
	bh=wP3JnJNsidmmyAvGG+yqwZTN3qrqn14kjkkMigYvCUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJjOmUhGAjcVAbODxLd2MzFx3OKFB67CkdeuqYrAkEL8KFX9O2lUlSlf3R32zWSSAIjGjpa8Cva9duiRjXMXluekOL6rdAvSiUpy7lLomPyaAvQDf4EZUEz2pvIw0nMtYxHRTJmwgn/d4gIMHofd6Z2LyMFoOVBVFo+iCklQOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5UTPdk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5UTPdk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D731F000FF;
	Thu, 10 Sep 2026 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046964;
	bh=Ir7eimU1apz9Pvr6jWkaXNCy6uCyut+eQPKcl0CYQWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U5UTPdk7aT/x2ouT3O6/in3VwRXn5hAs7cUpuk3jAnYXplgvLacmjKgvqvJBjWS4x
	 KuxbACU5JVdddACYkuyQ9smO9BFj1g7h/mqRCTdMuHiHqbZCjm2uSCHG3fYX5DHsex
	 mzXm31T6RC1ELgUg48geyqgpP6KWo8rEEj3jq6i4NBElQMX1R6FVdZrPrOu1IeXudz
	 dBc4rV7qKVQk64xkFr6cMsG0z1blhllDzxR5VKjujCzm+h/mCfYclVP3Gox6+46ZL9
	 yqOQytzr/PfVw+kZWcOqHLlA2zH3P5DPsLCnA0RBsSw2q1EpmHQO5RH2jWwF66cA/5
	 H10vodQtSQuvQ==
Date: Thu, 10 Sep 2026 14:29:14 +0100
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
Subject: Re: [PATCH 02/12] mm/sparse: refactor sparse_sections_init()
Message-ID: <aqKo5vHZbDhzrUZL@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-2-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-2-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:55PM +0200, David Hildenbrand (Arm) wrote:
> memory_present() really identifies+prepares all early sections so the
> initialization in sparse_init() can properly iterating them to
> initialize metadata.
>
> Let's just inline memory_present() into sparse_sections_init() and
> cleaning up the code a bit while at it: make it clear that we are operating
> on pfns.
>
> Note that we call set_section_nid() now only if the section
> was not already created earlier. Now, there is no more inconsistency
> between what we (temporarily) store in ms->section_mem_map and what
> we store in our section->nid array.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

In general please keep move/refactor steps separate. It makes it harder to
review when two things are going on at one time.

But I guess in this case the diff wouldn't be that different.

Anyway seems reasonable so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/sparse.c | 41 +++++++++++++++++------------------------
>  1 file changed, 17 insertions(+), 24 deletions(-)
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

So the main change seems to be calling set_section_nid() only if
!ms->section_mem_map (and obv. calculating ms earlier), as described in the
commit msg.

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
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
