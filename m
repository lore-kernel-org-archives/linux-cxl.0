Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D563246F8;
	Tue, 17 Mar 2026 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768086; cv=none; b=jpH0lEatKDacSJV+vrizXiVjUhZOjUn7obHLb2gVzvfqR7nVGN+Ydv+D15/bhJCPVxJjo7hgV/ZPQ0PtMG91CAusMmlOnzBdd+/b0DHohOZsogSZPO9OxZJBEKGldVhrJTgR5pupi85/h1Dqrz8+Kzk5FhJunpxrkB67BzNy3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768086; c=relaxed/simple;
	bh=aCHrUD8+LmC43GsbN4nEVNsRfFAFX8etI0ZbsdYUK/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grhXdyTzNbo3sNkSTMsZvJ6yK7JsAyE5O9rHb39naLjLjMIqd++l4gThf7w5uzQRkH36X/q3fXAVeoi6taUbVTgNXdvx5n6juOnhOCBW6cQW1QIkrDxyQ/loQf3FDK9y4GiVUdUaeuSVnCLcPgH4QfYQTrm+quvt1HYkr6dfaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpXaC+4I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpXaC+4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6E1C4CEF7;
	Tue, 17 Mar 2026 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768085;
	bh=aCHrUD8+LmC43GsbN4nEVNsRfFAFX8etI0ZbsdYUK/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpXaC+4IB9mCgF/42BlBRhw6KVqOa7RR79BYddvDCTBgjA1gLWe+RD+aF3NGvHsIs
	 ebZVzsc1DAjrIciSrlH7qS2i4CrudMkxxc8IIgtbzG2gu1vfsrz4YEk5ZTNzwV/7jz
	 1TIZruvkoK5fMndOp0pMbv9pc7nyi3gfX2lgr9AgRGkGsTovEHui3yWHJkjTQB9IRY
	 /pq3TyUUeDI1GFbTMgqJJFTNVhz4d9utSWqf97jJ+VT21vmAlHQuwIh1GJJCXxwHNZ
	 9p+fcsYVNQutrx8dnSA2jC3vnGK90ju3XFrX6ww98WIen8Qlg8ghuPrAWI75EdQl4e
	 ATXExyJTigkjQ==
Date: Tue, 17 Mar 2026 17:21:20 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 02/14] mm/sparse: remove WARN_ONs from
 (online|offline)_mem_sections()
Message-ID: <7056316c-e811-403f-9edf-8ac3c4248dba@lucifer.local>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-3-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-3-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:40PM +0100, David Hildenbrand (Arm) wrote:
> We do not allow offlining of memory with memory holes, and always
> hotplug memory without holes.
>
> Consequently, we cannot end up onlining or offlining memory sections that
> have holes (including invalid sections). That's also why these
> WARN_ONs never fired.
>
> Let's remove the WARN_ONs along with the TODO regarding double-checking.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

I'm warning up to your series! (The bad puns may/may not continue) so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/sparse.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index dfabe554adf8..93252112860e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -638,13 +638,8 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
> -		struct mem_section *ms;
> -
> -		/* onlining code should never touch invalid ranges */
> -		if (WARN_ON(!valid_section_nr(section_nr)))
> -			continue;
> +		struct mem_section *ms = __nr_to_section(section_nr);
>
> -		ms = __nr_to_section(section_nr);
>  		ms->section_mem_map |= SECTION_IS_ONLINE;
>  	}
>  }
> @@ -656,16 +651,8 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
> -		struct mem_section *ms;
> +		struct mem_section *ms = __nr_to_section(section_nr);
>
> -		/*
> -		 * TODO this needs some double checking. Offlining code makes
> -		 * sure to check pfn_valid but those checks might be just bogus
> -		 */
> -		if (WARN_ON(!valid_section_nr(section_nr)))
> -			continue;
> -
> -		ms = __nr_to_section(section_nr);
>  		ms->section_mem_map &= ~SECTION_IS_ONLINE;
>  	}
>  }
> --
> 2.43.0
>
