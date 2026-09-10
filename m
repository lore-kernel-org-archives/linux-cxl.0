Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6B4A0905;
	Thu, 10 Sep 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051913; cv=none; b=ULDJAFAKzOQ4MpxylTZRHtF9UsqSDEdLeEpD2bauyPk4Ql6c+QL9FGPJTtSEcsOAXMdLuZFnCefOkj5ocHfmaRhK+38MNVMW/Tw0CdbTgj67WKjOdry6BJPcgOpbuDhK0T+KzTUXngkK6gjpIxy7mTLz6UNkcH5/MKJXnjKkbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051913; c=relaxed/simple;
	bh=xTIvBLza7FppaOAr4bJHGg1SXg8nXEViVJbfPhvD/wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFYOn11wWNr8EP4ZobEuzlLkxRnCO+M96sN2/yPxn3c2LKvP9YJUi2DAHcJ1quvMbv6SvQJgomM7b0ScHJiQIFpAge9VrCWGmq5XPfKiE7zS0NmuxBEl6jWT1lX8PjRywjfc8l6bSQQF6jXcpXvLdhhIGhwbup9u98o3ofaYLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4IeR6K4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4IeR6K4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C8C1F000FF;
	Thu, 10 Sep 2026 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051911;
	bh=QKA3SAsCwTPWb3dPRkQeAzxCc+HHNUR0nyN0zBxrxTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e4IeR6K4gUKeSBAujGH+MKT4fOWNEz9VqQPkSMplHJzxLh8B4iN0Y4MJCwaMAdPBf
	 PACby5HC1tL9sC+aAj+zHjq64Uc+Ur3UaZVjsdf351gH42WQGsE1gq5a2m+Kc9B9hJ
	 HRLWDcq3k6QjkB1R4B8rs0PnBWFmHojkspiFP9qB1h2QFqpq6x7D5pdv+HIEcm7K4d
	 rJ7PdbLawcU2QLlzV7zRv6vmIAJgSFrNattw1dWdaOxuuhIH1UB8hiXtVwl/xBw1BD
	 8VA6MGaaWC4pzOo1ZDHyEk648RbYscoFea2/LnKpo/xXjOrNIBea1+VxcFF4APx0EN
	 ghr+JA8aupWZA==
Date: Thu, 10 Sep 2026 15:51:41 +0100
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
Message-ID: <aqLDR2jbBVdupryZ@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>
 <aqK2_RpAlMbVYcuN@gremlin>
 <c72f7358-cb6c-448d-9ce9-c17b425964bf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72f7358-cb6c-448d-9ce9-c17b425964bf@kernel.org>

On Thu, Sep 10, 2026 at 04:29:06PM +0200, David Hildenbrand (Arm) wrote:
> On 9/10/26 16:16, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Sep 09, 2026 at 03:33:01PM +0200, David Hildenbrand (Arm) wrote:
> >> Let's move it to sparse_init_one_section(). However, to keep early
> >> boot processing working, we also have to initialize it in
> >> sparse_sections_init().
> >
> > A why might be nice :)
>
> Agreed, I'll mention that.
>
> >
> > I guess preparing for removal of __section_mark_present()?
> >
>
> Right intuition :)
>
> > Also good to have arguments as to why this is equivalent of previous
> > behaviour.
> >
> > E.g. higher pfn = higher section nr so naturally the highest is the one you
> > end up wtih at the end of sparse_sections_init()?
>
> We go over all sections, just earlier.
>
> >
> >>
> >> Should we use READ_ONCE/WRITE_ONCE with __highest_used_section_nr?
> >> Probably, something for another day.
> >
> > It might be worth expanding this a bit. Do multiple threads read/write this
> > concurrently?
>
> Hah, I'll probably just drop it. I was just stumbling over readers vs.
> concurrent updates and thought "that looks suspicious".

Ack. KCSAN will bring our sins back to bear if they matter anyway :>)

>
> >
> > No functional change intended here or is one intended? :)
> >
>
> Certainly no change intended ;)
>
> > Before it was:
> >
> > mm_core_init_early() -> sparse_sections_init() -> __section_mark_present()
> >                           sparse_add_section() -> __section_mark_present()
> >
> > Now:
> >
> >                                                  mm_core_init_early() -> sparse_sections_init() [early]
> >                                                  sparse_add_section() -> sparse_init_one_section()
> >
> > But also called from mm_core_init_early():
> >
> > sparse_init() -> sparse_metadata_init() -> sparse_metadata_init_nid() -> sparse_init_one_section()
> >
> > Are both required?
>
> sparse_metadata_init() relies on __highest_used_section_nr in the
> for_each_early_section_nr / for_each_present_section_nr, so it is required.

Ahh yeah, makes sense. Worth spelling that out :)

>
> I could probable move the update on the hotplug side into sparse_add_section()
> instead!

Ack yeah would separate things out a bit between the two!

>
> >
> >
> >>
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >>  mm/sparse.c | 5 +++--
> >>  mm/sparse.h | 6 +++---
> >>  2 files changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/mm/sparse.c b/mm/sparse.c
> >> index 2b41ae36f20b8..2d0f2db34f4cf 100644
> >> --- a/mm/sparse.c
> >> +++ b/mm/sparse.c
> >> @@ -177,7 +177,7 @@ static inline unsigned long first_present_section_nr(void)
> >>
> >>  void __init sparse_sections_init(void)
> >>  {
> >> -	unsigned long pfn, start_pfn, end_pfn;
> >> +	unsigned long pfn, start_pfn, end_pfn, section_nr;
> >>  	int i, nid;
> >>
> >>  	sparse_extreme_init();
> >> @@ -187,9 +187,9 @@ void __init sparse_sections_init(void)
> >>  		mminit_validate_memmodel_limits(&start_pfn, &end_pfn);
> >>
> >>  		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> >> -			unsigned long section_nr = pfn_to_section_nr(pfn);
> >>  			struct mem_section *ms;
> >>
> >> +			section_nr = pfn_to_section_nr(pfn);
> >>  			sparse_index_init(section_nr, nid);
> >>  			ms = __nr_to_section(section_nr);
> >>  			if (ms->section_mem_map)
> >> @@ -201,6 +201,7 @@ void __init sparse_sections_init(void)
> >>  			__section_mark_present(ms, section_nr);
> >>  		}
> >>  	}
> >> +	__highest_used_section_nr = section_nr;
> >>  }
> >>
> >>  #ifndef CONFIG_SPARSEMEM_VMEMMAP
> >> diff --git a/mm/sparse.h b/mm/sparse.h
> >> index 7c5d82ceb7142..a3af4967fd5c5 100644
> >> --- a/mm/sparse.h
> >> +++ b/mm/sparse.h
> >> @@ -97,6 +97,9 @@ static inline void sparse_init_one_section(struct mem_section *ms,
> >>
> >>  	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
> >>
> >> +	if (section_nr > __highest_used_section_nr)
> >> +		__highest_used_section_nr = section_nr;
> >> +
> >
> > Could also be:
> >
> > 	section_nr = max(section_nr, __highest_used_section_nr);
>
> Ack!
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
