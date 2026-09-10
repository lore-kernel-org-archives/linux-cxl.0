Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84917305E28;
	Thu, 10 Sep 2026 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051094; cv=none; b=HSxPPpxtO4S+YZhoxmFa2mOwLE67TQfBK0fPx7qPVS8VzIAcRKvQ4K0xon49k+UqhTVh/pnWFwmTNN0myjOxtbfxU/eity7HGzv9JAU6CdwnDsajimWqh9IcS8cacEaUin4ufshkL8q82I5Yi37YCCovNTT/ncaDnJBIig3uR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051094; c=relaxed/simple;
	bh=579RDGAe/WRL3OlaVw3qhRslyCTWudTRZekqpzQAT/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0TqHnDjXn5NWQw91GiBeqFz0Ux6mEKfsGE4bdkqJWV63+qzuHtReU4TkG09y2Y7l7e8+4+Fqq3uoIWm6GtMubLPo1Gn7nhndRRPsp7uieVUxMSGSaIqRNZUWmM1GxAcKXiAkf/xO5oEpWiT8+FYEcwyreGyB3S1QzIzJm+rWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5pFoW74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5pFoW74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5071B1F000FF;
	Thu, 10 Sep 2026 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051093;
	bh=MK4zUJB9+wzOo/C/BizaklPC9wZpzdasI2Hvs/7YAKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I5pFoW746SSPNXz9o8Gr2kFBOSCOW/xePk4xTDfyqFgvoAmf0tODgEET0eRkncke9
	 XZfiCBHYBPe3zMjtgMElX9WcKhEFwpWObpy1cDNNXfZ82Q10+JbzOCJjnJSyAnK53x
	 7vuGYjH/35JsI1+OK1y/muHGz9/onzcxiv9oEU+nc6hi8+rY0ajtvZgR1zgS1lrdUl
	 MYlX5KHgZuMvcheoJuo7cNLrgBsMOqearr46U9pUJlt6Hu0phy1p2dpwJ5CUSI15fd
	 AtCXxUto9Jhl3wqLtR0RwSlAn2asx1Z4EZT3Es7V9UREdrzYdWck5ixnGT2gsty54b
	 uZsXfs+QijvtQ==
Date: Thu, 10 Sep 2026 15:38:03 +0100
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
Message-ID: <aqLAplL54O9rpM_Y@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-2-008fc8d579fe@kernel.org>
 <aqKo5vHZbDhzrUZL@gremlin>
 <44f7ce5c-b75c-4c44-9202-1d2d3a1de965@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f7ce5c-b75c-4c44-9202-1d2d3a1de965@kernel.org>

On Thu, Sep 10, 2026 at 04:30:43PM +0200, David Hildenbrand (Arm) wrote:
> On 9/10/26 15:29, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Sep 09, 2026 at 03:32:55PM +0200, David Hildenbrand (Arm) wrote:
> >> memory_present() really identifies+prepares all early sections so the
> >> initialization in sparse_init() can properly iterating them to
> >> initialize metadata.
> >>
> >> Let's just inline memory_present() into sparse_sections_init() and
> >> cleaning up the code a bit while at it: make it clear that we are operating
> >> on pfns.
> >>
> >> Note that we call set_section_nid() now only if the section
> >> was not already created earlier. Now, there is no more inconsistency
> >> between what we (temporarily) store in ms->section_mem_map and what
> >> we store in our section->nid array.
> >>
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > In general please keep move/refactor steps separate. It makes it harder to
> > review when two things are going on at one time.
> >
> > But I guess in this case the diff wouldn't be that different.
>
> Yeah, I actually want back and forth here and decided to keep it simple.

Yeah, this one's a bit of a blurry line but I think fine as it is!

>
> >
> > Anyway seems reasonable so:
> >
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Thanks!
>
> >
> >> ---
> >>  mm/sparse.c | 41 +++++++++++++++++------------------------
> >>  1 file changed, 17 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/mm/sparse.c b/mm/sparse.c
> >> index 6a6d258862904..36e3d854febc5 100644
> >> --- a/mm/sparse.c
> >> +++ b/mm/sparse.c
> >> @@ -179,22 +179,27 @@ static inline unsigned long first_present_section_nr(void)
> >>  	return next_present_section_nr(-1);
> >>  }
> >>
> >> -/* Record a memory area against a node. */
> >> -static void __init memory_present(int nid, unsigned long start, unsigned long end)
> >> +void __init sparse_sections_init(void)
> >>  {
> >> -	unsigned long pfn;
> >> +	unsigned long pfn, start_pfn, end_pfn;
> >> +	int i, nid;
> >> +
> >> +	sparse_extreme_init();
> >>
> >> -	start &= PAGE_SECTION_MASK;
> >> -	mminit_validate_memmodel_limits(&start, &end);
> >> -	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
> >> -		unsigned long section_nr = pfn_to_section_nr(pfn);
> >> -		struct mem_section *ms;
> >> +	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
> >> +		start_pfn &= PAGE_SECTION_MASK;
> >> +		mminit_validate_memmodel_limits(&start_pfn, &end_pfn);
> >>
> >> -		sparse_index_init(section_nr, nid);
> >> -		set_section_nid(section_nr, nid);
> >> +		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> >> +			unsigned long section_nr = pfn_to_section_nr(pfn);
> >> +			struct mem_section *ms;
> >>
> >> -		ms = __nr_to_section(section_nr);
> >> -		if (!ms->section_mem_map) {
> >> +			sparse_index_init(section_nr, nid);
> >> +			ms = __nr_to_section(section_nr);
> >> +			if (ms->section_mem_map)
> >> +				continue;
> >> +
> >> +			set_section_nid(section_nr, nid);
> >
> > So the main change seems to be calling set_section_nid() only if
> > !ms->section_mem_map (and obv. calculating ms earlier), as described in the
> > commit msg.
>
> Yes! I also played with having that in a standalone patch but judged that it's
> not really worth it. I can move it to a separate patch if you think it would be
> better!

No need, not really a big diff delta and you call it out in the commit msg!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
