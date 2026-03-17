Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0AB1F1513;
	Tue, 17 Mar 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777715; cv=none; b=dPmka5Zft9ovCq9RtCzmrLIAsP7boYwUU4kf4holpXtXuUSHeVV5vJ4LFOUNYDhhIqL36FHwG3ZLAATq0EFJ2fPIcvI0yDBLxW2LHobZklpQ+1Agn30H5DhhyKJ96xXb/lguwNBFFOeCEXG2kq7RJ10DIxtRwE0416p7FQk1GA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777715; c=relaxed/simple;
	bh=NKnAXN7C8VudbOPbvnyk9jdQz3ADlfDA1m5Ubw1DyQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COiYjm89W6CWUxdEmg/atdj4JsU164JlbDdXz+a3A6aii6Xrlo8YHNFHyAtdH4KLGhfD0rf4B7lDmGOTafxqJHwiUW5LrFbgl+gSJI4df1CH+s5q9H1TUOvHbQ9HJiDbfPv2Kii6Z9H31f9zHW9aGakM+6IUlltEP3PH8iPCFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5UHlDDd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5UHlDDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF764C4CEF7;
	Tue, 17 Mar 2026 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773777715;
	bh=NKnAXN7C8VudbOPbvnyk9jdQz3ADlfDA1m5Ubw1DyQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5UHlDDdZvItrfJBx8rarotr20Slalpfj+PAz+/HmNH+lo3ayJGu+6GPWXGSb9Fci
	 VyDGV+HIQX0znchJZnHBZI7aeMp1srzVtffP5/g52HIOczTQGY117+Oxs/3ocduRe/
	 huFmXW/0BWz+CwfE6AesM46XoPgg/chA39BP3d8ZM7FpHEH80g4BNG1/Yq98+jbHZu
	 3R3bf5IFqX6PXo7mKSff+aQZ97TaFJEkPZupwv+Dla+qgEx9/d/aZjGSOymU0EluoX
	 dXZuKCujkUwDOMGq8XpK+m9u+sYs9dzVquLQUi1Yj77qHBlhK3ahdDKBuU9YE8gXy5
	 mpDiP+NWEDPhw==
Date: Tue, 17 Mar 2026 20:01:53 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 13/14] mm/sparse: move __section_mark_present() to
 internal.h
Message-ID: <4839f771-1b54-4858-85f3-096aa1888189@lucifer.local>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-14-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-14-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:51PM +0100, David Hildenbrand (Arm) wrote:
> Let's prepare for moving memory hotplug handling from sparse.c to
> sparse-vmemmap.c by moving __section_mark_present() to internal.h.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Let's prepare for me finishing reviewing the series with:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/internal.h | 9 +++++++++
>  mm/sparse.c   | 8 --------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index bcf4df97b185..835a6f00134e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -987,6 +987,15 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>  	ms->section_mem_map |= SECTION_HAS_MEM_MAP | flags;
>  	ms->usage = usage;
>  }
> +
> +static inline void __section_mark_present(struct mem_section *ms,
> +		unsigned long section_nr)
> +{
> +	if (section_nr > __highest_present_section_nr)
> +		__highest_present_section_nr = section_nr;
> +
> +	ms->section_mem_map |= SECTION_MARKED_PRESENT;
> +}
>  #else
>  static inline void sparse_init(void) {}
>  #endif /* CONFIG_SPARSEMEM */
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6f5f340301a3..bf620f3fe05d 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -161,14 +161,6 @@ static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>   * those loops early.
>   */
>  unsigned long __highest_present_section_nr;
> -static void __section_mark_present(struct mem_section *ms,
> -		unsigned long section_nr)
> -{
> -	if (section_nr > __highest_present_section_nr)
> -		__highest_present_section_nr = section_nr;
> -
> -	ms->section_mem_map |= SECTION_MARKED_PRESENT;
> -}
>
>  static inline unsigned long first_present_section_nr(void)
>  {
> --
> 2.43.0
>
