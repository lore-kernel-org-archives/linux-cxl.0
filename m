Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE8632548B;
	Tue, 17 Mar 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768269; cv=none; b=V8BnkNmNRVrnLE1Ii0O53JnsK7ai1QN+qM1i8fJXz/2LNa8tFUtk8l4e4tV6XupLyUN2ufkCdVeRtregnxeegagoBO9eyPi404j64xznQy93v9W7MI7A7BZj74ipFhxFpWIRkfCzKu9dWuidL+SI3oFNqcjaw3S8L7qz3g7XgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768269; c=relaxed/simple;
	bh=7h4fdWHPisrK7hpCv9173Ird3vPPfJMliYRCEuqwTi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqBusROsXPltBqTEVPvtuqLDef+2ISkK6/NBuqCwH5g6wFml0id2pYH55HMTurQeWcykcFzUtjQ7ukXRedI/34yrRxwF1B2g/kAhrbCn7hEAR1rno8lxUeZAnDtlNMX61zCXj4QXG5ZC5WnOhOKFZGzOuSuavpLgBTJ1/mh06fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KguY9pQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KguY9pQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D1DC4CEF7;
	Tue, 17 Mar 2026 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768269;
	bh=7h4fdWHPisrK7hpCv9173Ird3vPPfJMliYRCEuqwTi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KguY9pQQ+/Dcad5ECFToTJEfKGgZPCKsWP07r9JfQttL/4O6e7dESxx/zbmbXRYPF
	 caRLA6N989yTl2M5KWUN6xTnQgUjDKA6l7C8I/cog2s0iDP3UNXyMJNWGlX/qqAZH7
	 XzNrFmBGegjnk1ME4oq7ttSBrlhYsK3eEdB1xK4SyD7319/TRRLPBqjCwwUYhgWPGv
	 ZJ2codPYjQPrcxe05joUDN4MipwCrJFTydKwg5AOEBjGqe+WIViMJMkG1yKm7QR6Cy
	 +irNlZAheB3I/KdW5osUcrYqyuCqjyVnsxZP3TyEF4mFDgD9R64qVA17uSfnBriLki
	 8K7xAPejbDSsQ==
Date: Tue, 17 Mar 2026 17:24:24 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 04/14] mm/memory_hotplug: simplify check_pfn_span()
Message-ID: <c7bd7372-ab23-4f48-af39-ea33a59dfd53@lucifer.local>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-5-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-5-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:42PM +0100, David Hildenbrand (Arm) wrote:
> We now always have CONFIG_SPARSEMEM_VMEMMAP, so remove the dead code.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

It's a sparse patch but that's ok, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/memory_hotplug.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 3495d94587e7..70e620496cec 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -320,21 +320,13 @@ static void release_memory_resource(struct resource *res)
>  static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
>  {
>  	/*
> -	 * Disallow all operations smaller than a sub-section and only
> -	 * allow operations smaller than a section for
> -	 * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
> -	 * enforces a larger memory_block_size_bytes() granularity for
> -	 * memory that will be marked online, so this check should only
> -	 * fire for direct arch_{add,remove}_memory() users outside of
> -	 * add_memory_resource().
> +	 * Disallow all operations smaller than a sub-section.
> +	 * Note that check_hotplug_memory_range() enforces a larger
> +	 * memory_block_size_bytes() granularity for memory that will be marked
> +	 * online, so this check should only fire for direct
> +	 * arch_{add,remove}_memory() users outside of add_memory_resource().
>  	 */
> -	unsigned long min_align;
> -
> -	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> -		min_align = PAGES_PER_SUBSECTION;
> -	else
> -		min_align = PAGES_PER_SECTION;
> -	if (!IS_ALIGNED(pfn | nr_pages, min_align))
> +	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION))
>  		return -EINVAL;
>  	return 0;
>  }
> --
> 2.43.0
>
