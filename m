Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72B38F94C;
	Wed, 18 Mar 2026 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823840; cv=none; b=JGY9LYShtQK4+xLi8Q7+SILzLrho8aR6yUroupPfdulTBNKtBPz2c9cx0i4QQPWC5e/ulGma1RE60niwtZ+V1xw+4/MUYIbsNaT1idvJMdIukCiNGmazQ4hERzaC3CqTPEnMyBje+SeKcdTg3LqCtLpfdnyvx0Fmpk3OvVwwXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823840; c=relaxed/simple;
	bh=nV3CgZQVuze+oFz4RZF7Bj0CJqIuEP6bWFViPuWXut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=insSU36khk6dru92GU89cwhRUQdISdGYbE/8lv/oOvEqLQsi2UOU8g7/XmwtvhRpuYx3cb/Fv7AOYXVuqN8EJXCPhAN28wlBx7dq84c1Tq0ymRUYW66a4YzlPvlTlVtS2HCeJtNiEf5G5MoWupK4yZg/qjWboWzensSIfPZTH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab6lwJ2Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab6lwJ2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693B3C19421;
	Wed, 18 Mar 2026 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773823839;
	bh=nV3CgZQVuze+oFz4RZF7Bj0CJqIuEP6bWFViPuWXut8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ab6lwJ2YzuuyOJQcorOYMuqxkU+bbI8BtyGoEKJPYdRcOE69b9R5iDPwpLA+o5r+v
	 UdxY18Nf8PFve4Ecj2wiyr23uciS56NbvrURSA3V8iPfyGkxUC9H1M3YvbVmnfaGw1
	 gtO6Xbe80k3gg7eqt+pzzokT1/K7CmtEEL0ovp0836+/58T2KhvsxUHX9s6XDP5I19
	 eaYkrSo4IvFzHnJY0RfD5ZD7cHXlHdD8JaK0fbgxsDsveyy3LaC7beF7Zh149YQmdl
	 Nwhv8dSqJr8pQvP93YezgNOutiNb3nwZ57XVGxQypSBoMmqN2GrvPPJ9DWTxDqGd9/
	 ieMr2pkNkEn/g==
Date: Wed, 18 Mar 2026 10:50:33 +0200
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
Subject: Re: [PATCH 11/14] mm/sparse: drop set_section_nid() from
 sparse_add_section()
Message-ID: <abpnWdLe1xRJ4uqt@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-12-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-12-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:49PM +0100, David Hildenbrand (Arm) wrote:
> CONFIG_MEMORY_HOTPLUG is CONFIG_SPARSEMEM_VMEMMAP-only. And
> CONFIG_SPARSEMEM_VMEMMAP implies that NODE_NOT_IN_PAGE_FLAGS cannot be set:

Maybe 

... implies that node is always in page flags and NODE_NOT_IN_PAGE_FLAGS
cannot be set

> see include/linux/page-flags-layout.h
> 
> 	...
> 	#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
> 	#error "Vmemmap: No space for nodes field in page flags"
> 	...
> 
> So let's remove the set_section_nid() call to prepare for moving
> CONFIG_MEMORY_HOTPLUG to mm/sparse-vmemmap.c
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/sparse.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7b0bfea73a9b..b5a2de43ac40 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -769,7 +769,6 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  	page_init_poison(memmap, sizeof(struct page) * nr_pages);
>  
>  	ms = __nr_to_section(section_nr);
> -	set_section_nid(section_nr, nid);
>  	__section_mark_present(ms, section_nr);
>  
>  	/* Align memmap to section boundary in the subsection case */
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
