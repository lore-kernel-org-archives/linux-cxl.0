Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4B489FD3;
	Thu, 10 Sep 2026 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049814; cv=none; b=BE42YQ+kZ9ucz2+fv0CE3zEhTJTREFofz2PXt17dBMs0gdPQs/WSn5sdti7R9vUe9s4kbobI9KVqjJW/lHu8fazuICVWZGLrIklPIj57wMpsT9MJ4VY1lTEn/NTNRWmK1RoQUc4p8DA43tXCCcrw0wAn+q8otLJsLhAq+dSgG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049814; c=relaxed/simple;
	bh=38Ep9oRNjRWqq2y5h4nddjMtc452h0z/caU99kzEE/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIXgVIM6A9xAhnJQ2QBS0QXvqf3zQxCU235fvRCJnDNOjwdjLbATAKj0ZivHxJ1GK0spg7iVhxOk/HBDWt+lVcN5yVhPN54Xk3q4ysJze4Q+RIZ44tK5e1XfcWuplwvi8kO3jeQp9TltSJufk3lVMuXwgOHVzJ4dGs3VgnK2Wwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKkmADC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKkmADC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AFB1F000FF;
	Thu, 10 Sep 2026 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049812;
	bh=pKr5hPbNleVMkg76w58XMKUslPR6fzuboqwZkz3wepg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dKkmADC8CQOFHY6kWVFLhHmN/5gQRiSVsLiZPB0L8TvjATCyW+1Cb7C8Vy+kFGQcL
	 ruGR6HIbcw9pVnmhxY6/ubSwRuttRWtFi+0CQhHxpNcO7wlTNdnxdRXx5jCqDri41c
	 oduNfZfQDoEE9TXpXwEL78gORwyRdpVrQV9P9seIFBVR8WixbOya2rUNsvN4oGa3cj
	 G8FMuuDvWgv4ByjBxH2LX0KUHaKdt7uXUfdHWLGiEPJXYIPTAXjwujhpEq86th9s9c
	 XmCDVX70y+bfM4ZVfe6J/gglXWlFDI6WZ/z4sLsTYKcZRNuco/NOcuVL3G+T+KYPKI
	 gDhqAkWNhXCvQ==
Date: Thu, 10 Sep 2026 15:16:42 +0100
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
Subject: Re: [PATCH 08/12] mm/sparse: move __highest_used_section_nr handling
Message-ID: <aqK2_RpAlMbVYcuN@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:33:01PM +0200, David Hildenbrand (Arm) wrote:
> Let's move it to sparse_init_one_section(). However, to keep early
> boot processing working, we also have to initialize it in
> sparse_sections_init().

A why might be nice :)

I guess preparing for removal of __section_mark_present()?

Also good to have arguments as to why this is equivalent of previous
behaviour.

E.g. higher pfn = higher section nr so naturally the highest is the one you
end up wtih at the end of sparse_sections_init()?

>
> Should we use READ_ONCE/WRITE_ONCE with __highest_used_section_nr?
> Probably, something for another day.

It might be worth expanding this a bit. Do multiple threads read/write this
concurrently?

No functional change intended here or is one intended? :)

Before it was:

mm_core_init_early() -> sparse_sections_init() -> __section_mark_present()
                          sparse_add_section() -> __section_mark_present()

Now:

                                                 mm_core_init_early() -> sparse_sections_init() [early]
                                                 sparse_add_section() -> sparse_init_one_section()

But also called from mm_core_init_early():

sparse_init() -> sparse_metadata_init() -> sparse_metadata_init_nid() -> sparse_init_one_section()

Are both required?

Might be worth digging into why a bit here.


>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/sparse.c | 5 +++--
>  mm/sparse.h | 6 +++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 2b41ae36f20b8..2d0f2db34f4cf 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -177,7 +177,7 @@ static inline unsigned long first_present_section_nr(void)
>
>  void __init sparse_sections_init(void)
>  {
> -	unsigned long pfn, start_pfn, end_pfn;
> +	unsigned long pfn, start_pfn, end_pfn, section_nr;
>  	int i, nid;
>
>  	sparse_extreme_init();
> @@ -187,9 +187,9 @@ void __init sparse_sections_init(void)
>  		mminit_validate_memmodel_limits(&start_pfn, &end_pfn);
>
>  		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> -			unsigned long section_nr = pfn_to_section_nr(pfn);
>  			struct mem_section *ms;
>
> +			section_nr = pfn_to_section_nr(pfn);
>  			sparse_index_init(section_nr, nid);
>  			ms = __nr_to_section(section_nr);
>  			if (ms->section_mem_map)
> @@ -201,6 +201,7 @@ void __init sparse_sections_init(void)
>  			__section_mark_present(ms, section_nr);
>  		}
>  	}
> +	__highest_used_section_nr = section_nr;
>  }
>
>  #ifndef CONFIG_SPARSEMEM_VMEMMAP
> diff --git a/mm/sparse.h b/mm/sparse.h
> index 7c5d82ceb7142..a3af4967fd5c5 100644
> --- a/mm/sparse.h
> +++ b/mm/sparse.h
> @@ -97,6 +97,9 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>
>  	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
>
> +	if (section_nr > __highest_used_section_nr)
> +		__highest_used_section_nr = section_nr;
> +

Could also be:

	section_nr = max(section_nr, __highest_used_section_nr);

But not a big deal.


>  	/*
>  	 * We encode the start PFN of the section into the mem_map such that
>  	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
> @@ -114,9 +117,6 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>  static inline void __section_mark_present(struct mem_section *ms,
>  		unsigned long section_nr)
>  {
> -	if (section_nr > __highest_used_section_nr)
> -		__highest_used_section_nr = section_nr;
> -
>  	ms->section_mem_map |= SECTION_MARKED_PRESENT;
>  }
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
