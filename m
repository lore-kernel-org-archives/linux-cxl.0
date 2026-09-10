Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2F472096;
	Thu, 10 Sep 2026 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044756; cv=none; b=NJa0kH2k5KfhaydmgqnPO9h5g84u6acqYPneYNwsQ4CLeI5fg4sEJMRcFxaiiWsq9TiGsZGd/pZLxFcJw0px5i/oYInSRIpHgZtUSitoBViCK/sTVH89KGwK5CXID9ZFh0B3MqjRBWc1j6dVpdNXg8LxrpeYdvhFDZsLjDRisKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044756; c=relaxed/simple;
	bh=h92oM+41pfJQhBPUoqf3h5NXV7suS0PQ3SHzraNZhWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI9eyKsAQy1XHPhB0u93rjleJKW/addH1hQA6Ij8Q20N4vkURIUR2RijRYAFpu8iUT1IlQqxAZ0Pj7vIz2xOMz/GzUt7XA7wdTSovtg3v7b8beNvl0bYB/+wT/JmgzIbufMw6gWkEbw4FH6TavRyRvVtNqJC5SjFU0o8X9k/ioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeqCUcLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeqCUcLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E051F000FF;
	Thu, 10 Sep 2026 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044754;
	bh=Xkj2AEIJUTs1kEBGyfC+T4+mC4iQhp2cUZ+Brvewmzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CeqCUcLMGfRxLqY/XX/cbO647DQEZ6Mh7PWnYBSz+DKJeSPJ658VXN26O/AgJWLPD
	 /eflIiP/oB2t7cooFWq/hWvBbyg8b6p0bZyOYign06Zj42RT8NP+8gtPHWTOuyHdnl
	 lVlhN9jc7xufKTFPR0Ite0dlh++gl0Awo/ooQ+QxPaDWtgmEht6DzPIqomDJZOynNL
	 RBtZiW9Mlir9tOP2tBrLBx8f5E/kgt2mRtfdDNd9FUikkzVn+BGoFaAc4Sgn7FgeYC
	 0VBo5P4CCWTnWYoUNgz6muUp5UXnpgj3IakGl8zBZv+UrSi5ZUX4EVvfauJtFXR0wG
	 zEfJ96WE8dPOQ==
Date: Thu, 10 Sep 2026 13:52:25 +0100
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
Subject: Re: [PATCH 01/12] mm/sparse: move mem_section init to
 sparse_extreme_init()
Message-ID: <aqKnDa6ukWwAXs19@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-1-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-1-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:54PM +0200, David Hildenbrand (Arm) wrote:
> Let's just avoid another pair of ifdef inside a function. While at it,
> switch to INTERNODE_CACHE_BYTES by just defining a fallback in cache.h
> as well, given that the x86 variant already provides one.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Nic ecleanup, one nit below.

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/cache.h |  1 +
>  mm/sparse.c           | 19 ++++++++++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index e69768f50d532..b6e857b985bca 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -89,6 +89,7 @@
>   */
>  #ifndef INTERNODE_CACHE_SHIFT
>  #define INTERNODE_CACHE_SHIFT L1_CACHE_SHIFT
> +#define INTERNODE_CACHE_BYTES (1 << INTERNODE_CACHE_SHIFT)

NIT: 1UL?

>  #endif
>
>  #if !defined(____cacheline_internodealigned_in_smp)
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 9349ed6326c01..6a6d258862904 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -103,11 +103,22 @@ int __meminit sparse_index_init(unsigned long section_nr, int nid)
>
>  	return 0;
>  }
> +
> +static void __init sparse_extreme_init(void)
> +{
> +	const unsigned long size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> +
> +	mem_section = memblock_alloc_or_panic(size, INTERNODE_CACHE_BYTES);
> +}
>  #else /* !SPARSEMEM_EXTREME */
>  int __meminit sparse_index_init(unsigned long section_nr, int nid)
>  {
>  	return 0;
>  }
> +
> +static void __init sparse_extreme_init(void)
> +{
> +}
>  #endif
>
>  /*
> @@ -197,13 +208,7 @@ void __init sparse_sections_init(void)
>  	unsigned long start, end;
>  	int i, nid;
>
> -#ifdef CONFIG_SPARSEMEM_EXTREME
> -	unsigned long size, align;
> -
> -	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> -	align = 1 << (INTERNODE_CACHE_SHIFT);
> -	mem_section = memblock_alloc_or_panic(size, align);
> -#endif
> +	sparse_extreme_init();
>
>  	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
>  		memory_present(nid, start, end);
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
