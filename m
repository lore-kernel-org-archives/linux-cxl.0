Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F33B4E8F;
	Mon, 23 Mar 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274458; cv=none; b=MTGrtgXkB3rZZLYvxoa/4BUwupEwxd0MmE/+71EGcnqjibbgE1hv7VHbuz2UFKqFWt6GnvB5M3iWzEOm+opRvgixI1+de6WMAypLY/p8+erZcXEmKOBgXsngwUm7wzLODJ8DXBiKNaX9RAFWMmgm/NKsVKsRAT8wwKeNmwJheII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274458; c=relaxed/simple;
	bh=GN+aQtFvX93m6F1AZF/qXvzTDG1AkJK4lgDiQPanc1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgx28ZHk+E9Yx90jl2ad/blv7685qN6T5DN7N3gUo2bgeWPYl6q3h/krP/jMPb45xbIWh+qYqwZZQzocG+GtZsq00NAxkKPq4IhcpPS/Z6j3R7f7luos9HAdHX/mC6AwkuxusvCjz/nBZrxG7tPuc91+Dypa+iSX8unObYbcS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ0H+ebB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ0H+ebB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D756BC4CEF7;
	Mon, 23 Mar 2026 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274458;
	bh=GN+aQtFvX93m6F1AZF/qXvzTDG1AkJK4lgDiQPanc1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZ0H+ebBjC6Z2nvISQYqqvuS/fIt36YPcVPATAf/w3pQwnqfQckBpH3KO4bK6Oxpj
	 H385dEDwruCFbIaqhvFLKIwHeKTCjERKxWzlpCll7bjXWnSRqaTVCflOjkrDCqDPr8
	 cYT/Ql2Fkjo25TvXsYyILHPyupNDaztaM2u9vOGXmp4HKp/hgs3p4GZCbhoFewcDMo
	 RfEbJoXyhXcGI5gtQ8u6b8e2nZ2o5Wn/hMaiLFd44wOt8fuoHcsGMff+vASTcgC7gP
	 LhH0jSnMy/RUaKvlBxWb6Hun+y0qD3cjMWWziO5qaiXBAZwhgnInuguzLenWPLfa3E
	 Nxn//p/JlF00Q==
Date: Mon, 23 Mar 2026 14:00:53 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 01/15] mm/memory_hotplug: fix possible race in
 scan_movable_pages()
Message-ID: <33dedf0c-d394-4f81-ad29-03ca88703e3c@lucifer.local>
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
 <20260320-sparsemem_cleanups-v2-1-096addc8800d@kernel.org>
 <5b489c40-bd89-4dff-9669-560b1b28ec69@lucifer.local>
 <4caebf3b-8924-406f-9b92-909cf86ef669@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4caebf3b-8924-406f-9b92-909cf86ef669@kernel.org>

On Mon, Mar 23, 2026 at 02:40:16PM +0100, David Hildenbrand (Arm) wrote:
> On 3/23/26 14:26, Lorenzo Stoakes (Oracle) wrote:
> > On Fri, Mar 20, 2026 at 11:13:33PM +0100, David Hildenbrand (Arm) wrote:
> >> If a hugetlb folio gets freed while we are in scan_movable_pages(),
> >> folio_nr_pages() could return 0, resulting in or'ing "0 - 1 = -1"
> >> to the PFN, resulting in PFN = -1. We're not holding any locks or
> >> references that would prevent that.
> >>
> >> for_each_valid_pfn() would then search for the next valid PFN, and could
> >> return a PFN that is outside of the range of the original requested
> >> range. do_migrate_page() would then try to migrate quite a big range,
> >> which is certainly undesirable.
> >>
> >> To fix it, simply test for valid folio_nr_pages() values. While at it,
> >> as PageHuge() really just does a page_folio() internally, we can just
> >> use folio_test_hugetlb() on the folio directly.
> >>
> >> scan_movable_pages() is expected to be fast, and we try to avoid taking
> >> locks or grabbing references. We cannot use folio_try_get() as that does
> >> not work for free hugetlb folios. We could grab the hugetlb_lock, but
> >> that just adds complexity.
> >>
> >> The race is unlikely to trigger in practice, so we won't be CCing
> >> stable.
> >>
> >> Fixes: 16540dae959d ("mm/hugetlb: mm/memory_hotplug: use a folio in scan_movable_pages()")
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > Logic looks right to me, though some nits below. With those accounted for:
> >
> > Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> >
> >> ---
> >>  mm/memory_hotplug.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >> index 86d3faf50453..969cd7ddf68f 100644
> >> --- a/mm/memory_hotplug.c
> >> +++ b/mm/memory_hotplug.c
> >> @@ -1747,6 +1747,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
> >>  	unsigned long pfn;
> >>
> >>  	for_each_valid_pfn(pfn, start, end) {
> >> +		unsigned long nr_pages;
> >>  		struct page *page;
> >>  		struct folio *folio;
> >>
> >> @@ -1763,9 +1764,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
> >>  		if (PageOffline(page) && page_count(page))
> >>  			return -EBUSY;
> >>
> >> -		if (!PageHuge(page))
> >
> > Yeah interesting to see this is folio_test_hugetlb(page_folio(page)) :))
> >
> > So this is a nice change for sure.
> >
> >> -			continue;
> >>  		folio = page_folio(page);
> >> +		if (!folio_test_hugetlb(folio))
> >> +			continue;
> >>  		/*
> >>  		 * This test is racy as we hold no reference or lock.  The
> >>  		 * hugetlb page could have been free'ed and head is no longer
> >> @@ -1775,7 +1776,11 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
> >>  		 */
> >>  		if (folio_test_hugetlb_migratable(folio))
> >>  			goto found;
> >> -		pfn |= folio_nr_pages(folio) - 1;
> >> +		nr_pages = folio_nr_pages(folio);
> >> +		if (unlikely(nr_pages < 1 || nr_pages > MAX_FOLIO_NR_PAGES ||
> >
> > NIT: since nr_pages is an unsigned long, would this be better as !nr_pages || ...?
>
> It's easier on the brain when spotting that only a given range is
> allowed, without having to remember the exact type of the variable :)

Yeah it's not a big deal!

>
> So I guess it doesn't really make a difference in the end.
>
> >
> >> +			     !is_power_of_2(nr_pages)))
> >
> > Could the latter two conditions ever really happen? I guess some weird tearing
> > or something maybe?
>
> Yes, or when the fields gets reused for something else.
>
> >
> > It would also be nice to maybe separate this out as is_valid_nr_pages() or
> > something, but then again, I suppose given this is a rare case of us
> > checking this under circumstances where the value might not be valid, maybe
> > not worth it.
>
> I had the same thought. But this code is way too special regarding
> raciness that I hope nobody else will really require this ... and if
> they do, they might be doing something wrong :)

Yeah for sure, it does seem unique to this situation, so probably not worth
it!

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
