Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335F2D780C;
	Tue, 17 Mar 2026 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777361; cv=none; b=D62PuniGJ9oSrCmze93AijtORwa9LjwALuLvru1L6ais2gR4kAHPPh+EIa5tvZ84z4d8jPKzTby4YKBck7N5fsW1WEbQa9/IYbz3RMiJwk56ceMaL4YyFFM36UxW4Fqd9Em5pM7uXV8Z/XSXyxgvCHkqJhyYh14kAaK87Cuu/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777361; c=relaxed/simple;
	bh=84/Yrocy2s3h1aRMvrwLTg5dXCrLpngBo18sDPAgS7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkK/V7mhO1eq4ecdpcUh4CkDI9whL6W8cE20fDPwGYw4LkZV8o3IItRTLvobYdyAvqnKF51NyU1Va1A3LK4g5n6WmCsCktpp1y3rNSlQKRME++E/TkusgM0ZiweQxpFI4QtgsYursZQlNHboQat/dAwRKVhI9L6mHAxfPl3vIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCUiiwbk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCUiiwbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412A2C4CEF7;
	Tue, 17 Mar 2026 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773777360;
	bh=84/Yrocy2s3h1aRMvrwLTg5dXCrLpngBo18sDPAgS7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCUiiwbkHanOSlqU7zMUiNIFM+qG9DYxQxyaVLWgaR2XCJP040T/dl3zW+622zh+h
	 +AoucEiyCyEUPm/0FP37MKV8yHqxpECNiYXUDNHGge8/yKKEiitkgXOddDBCeg4O+n
	 s7Bw6aEkfRAjmxuHBCU958q6gT6n+XCWWhPFpj6pOuzm/mzTJF/H9G5WOL4h9VdjOJ
	 l9JFX1eBaphDLcD62YirDFVvSJs6oiUWTMvfaR94hQfj0L0VD+KVt+olVASrRy+aKi
	 wcUIwy6PNbwmgEW9Yf6KkFqyT6a/jsWZ3w2sYQqdhbPdLavMuQP3aVjNYiE1rQ+cDH
	 EtJ2LeRtDUpuQ==
Date: Tue, 17 Mar 2026 19:55:58 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 11/14] mm/sparse: drop set_section_nid() from
 sparse_add_section()
Message-ID: <6462237b-6a4b-4174-ae0a-bc6bd4e5838a@lucifer.local>
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

Maybe worth mentioning:

#ifdef NODE_NOT_IN_PAGE_FLAGS
...
static void set_section_nid(unsigned long section_nr, int nid)
{
	... actually does something ...
}
#else /* !NODE_NOT_IN_PAGE_FLAGS */
static inline void set_section_nid(unsigned long section_nr, int nid)
{
}
#endif

Or more succintly 'set_section_nid() is a nop' or something :P

> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

You may have dropped the call, but you've not dropped the ball, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

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
