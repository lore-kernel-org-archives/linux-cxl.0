Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FEE331214
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782763740; cv=none; b=lZFl3yhbJXHHXxPNuU52icNc6rikySR30Jga/ODO7eusPbNP9Mn4vgmLNKEUP7drc9xXyv59pIKm2193hxjoni7h2ti9pW5gNxrlKGqARMWriTWrZ/faZ+yZjcK1MMIXXcip0G41pIMCVXif8ucox1IFp+0lj9vHuxYDgPxnfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782763740; c=relaxed/simple;
	bh=+i57rYrfmVL5nh6eQ5JIDF+kt5WXWnrGSd+2Io4VSn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tAPjLuMuaathLZhogRDBDZCGjbJlsBdg9sCphO8d6ATZh6YRVahEK0cdRBrhygaU94Rb1ap8u2bhdxQ7vBR7gB2WJCMFgdLIDbc6iakpB6P/EPDp7SvGALFWX2KdrlQ+YtRnUIf8CkPVpRiXDo8WV4zYBYE0igCZ+aZMlNoyKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G96EfPkN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G96EfPkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782763737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzQ5aOE5DdkQK7ZMLbfvTWuWtjZSzxV7VRGk7s0Jl/Q=;
	b=G96EfPkNValI8j8jCOY+X8VXfcGo8YFEppVFsmSRV3jELHPnrrlSm94r1V+f/vQs3S2Wnx
	8xNwgcybC6plHtwSAgY7DLkzZBqQlDP0JvTVuGu1qwsIv/bm6qOPJTPE2SBGvvqK6F878Z
	40JNr8Wo6eeAauU0j83jwmOzQK56qa8=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-_SXKtmvvOZqWfiF4Xc-Klw-1; Mon, 29 Jun 2026 16:08:55 -0400
X-MC-Unique: _SXKtmvvOZqWfiF4Xc-Klw-1
X-Mimecast-MFC-AGG-ID: _SXKtmvvOZqWfiF4Xc-Klw_1782763735
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30ba395b047so13195524eec.0
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 13:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782763734; x=1783368534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzQ5aOE5DdkQK7ZMLbfvTWuWtjZSzxV7VRGk7s0Jl/Q=;
        b=AAidoQ6r9FIL+cPcRjebSBqhQM3QSwe5THXhKDmD4vqcdsE8v+8L14nBbfZAj7uCSY
         EU0+1EWtg4kj1jxv5n/W7D2LV5ECUIcGLPmUcAm6pLmMUOAu8DXLZ3nsiZE83G/VL4sz
         Po7Yzrm0ceWt3+VWRZDsNHVS6XCpcL71rn+5jPjPG37pTb0+5VicBBWjdoeF35deOMKZ
         sUIyZBJcWkqBMw5Lw03rOiRU9UWFJVsYadtzfWLtuO3JlDt2IBRYDsAIQ0r1OQAGWzVl
         KZTLPMCRWSyCqgyWoBGMbVLEXu42iE2nV5lleHQ3wZkoS14eFvT4wLJtegnIF81e5B40
         xFWw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2qPRCeO904/GoZhcKbAiz+c2slsyHH37/U0nkngE51JHhqtXmTW1xkFC47AAgNkPheAn7b+Pv0NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/C3icOWeCCwQ5V0kMSLFEbt4seaN6K+kyZfidTJxXmPTG4QZC
	heBQIuJE8n22qGdx5Poovt5xswSEBX3qyGDPo1Kqfby8GK6cQWyDKpQKSCMwNwmeQCWFr2ymDNk
	Wyx6fgJe6RN7fzd5jKp0WTqnEgnjIRVVpGj/4nq+PTwb7Yvh34bXKA/3MZZlXxg==
X-Gm-Gg: AfdE7cmljcHaIbnPdwhO/9SYbiBFZaixerfgXMhUZtc0Gm0BVn7Xefp+4SxFTVhufXv
	y6nnBglJ1M7r++r4DBkE5/YeWCuXYXAl4kWBXqtswZ02g9wxO9+rqd7EGhkcZjY73IPIkdGRdRc
	vlICEz7W0YFm4A2W8sWCfepoua90pDbUXc20pe9Uj9dPUcJa5kMkZDzLqCGDljLaTb1nrCdorhA
	zaj7VtidfPF5lijW45AJdqgNDgHAcLcT7RGABVvFSYo6ObtHAiWesAFjDRxXxy8xEvAFjXwSkgM
	e8rNXjuGdgiLPveFExfQzvhQ9bejedrXQeKc+mt6wRplENWO7Cvif0mpQFKYDZIBvlAhZeQ3Kto
	yq69McmDtJDW6g/TQOL+CpjF8zGNwXCo4
X-Received: by 2002:a05:7300:1898:b0:30c:ab4f:46be with SMTP id 5a478bee46e88-30ee13a266emr558211eec.36.1782763734156;
        Mon, 29 Jun 2026 13:08:54 -0700 (PDT)
X-Received: by 2002:a05:7300:1898:b0:30c:ab4f:46be with SMTP id 5a478bee46e88-30ee13a266emr558162eec.36.1782763733406;
        Mon, 29 Jun 2026 13:08:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5ed29sm733991eec.1.2026.06.29.13.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:08:52 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:08:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <20260629092856-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rsnwnx52VVhP1ICyOvzVvLktvi1OuzY-EAG07qtfNRk_1782763735
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 03:05:18PM +0200, David Hildenbrand (Arm) wrote:
> On 6/29/26 09:34, Michael S. Tsirkin wrote:
> > On Mon, Jun 29, 2026 at 08:49:37AM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/28/26 23:45, Michael S. Tsirkin wrote:
> >>> I don't like it that we are adding overhead to the good path for
> >>> the benefit of memory failure, which never triggers on many systems,
> >>> but I don't have a better idea. Pls take a look.
> >>
> >> As I said on Friday.
> >>
> >> "It's also doesn't address the mf_mutex implications and the x86 thingies I
> >> mentioned.
> > 
> > Well I did attempt addressing this.  These would be these two:
> > 
> > 	(a) We don't hold the mf_mutex on all call paths, but we really need it so a
> > 	page_test_set_hwpoison() cannot race in weird ways with the other primitives I think.
> > 
> > page_test_set_hwpoison was this code you wrote:
> > 
> > +static void page_set_hwpoison(struct page *page)
> > +{
> > +       lockdep_assert_held(&mf_mutex);
> > +
> > +       while (!PageHWPoison(page)) {
> > +               SetPageHWPoison(page);
> > +
> > +               /* Make sure concurrent non-atomic writers completed. */
> > +               synchronize_rcu();
> > +       }
> > +}
> > 
> > and indeed the test+set combination seems racy.  But consider the version I posted, for example:
> > 
> > +/*
> > + * Drain any in-flight non-atomic page flag operations that could
> > + * clobber a concurrently set HWPoison bit.  Retries until the bit sticks.
> > + */
> > +static void set_hwpoison_drain_rcu(struct page *p)
> > +{
> > +       do {
> > +               synchronize_rcu();
> > +       } while (!TestSetPageHWPoison(p));
> > +}
> > +
> > 
> > ...
> > 
> > +static bool test_and_set_hwpoison_drain_rcu(struct page *p)
> > +{
> > +       bool was_set = TestSetPageHWPoison(p);
> > +
> > +       set_hwpoison_drain_rcu(p);
> > +       return was_set;
> > +}
> > 
> > 
> > 
> > does not seem racy without a lock. But maybe I don't get it.
> 
> 
> Staring at your implementation, just think about two concurrent invocations of
> test_and_set_hwpoison_drain() in your code:
> 
> Assume HWPoison flag is not set.
> 
> Thread 1: test_and_set_hwpoison_drain_rcu() -> TestSetPageHWPoison()
> 	-> was_set = false
> 
> Thread 2: update that overwrites page->flags. HWPoison accidentally cleared.
> 
> Thread 3: test_and_set_hwpoison_drain_rcu() -> TestSetPageHWPoison()
> 	-> was_set = false
> 
> Thread 1: does RCU sync and returns "!was_set"
> thread 2: does RCU sync and returns "!was_set"
> 
> So you could end up with two thread believing that they atomically cleared the
> flag, and you really need to lock.
> 
> We really have to document and enforce that the mutex is involved.

Sure, that will be somewhat easy to add, for anyone who works on this next. But
just to make sure, I think they (test_and variants, and clear) *are* all under
mutex in the patch I posted.  It just isn't enforced. Only set
is not and that's safe I think.


> 
> And I fear there are more nasty details to be uncovered while we rework some of
> this properly, mandating a detailed look.
> 
> For example, TestClearPageHWPoison() in put_page_back_buddy() likely needs a
> proper treatment as well.

Hmm I don't see why. It owns the page. The issue is only if one pokes at
page flags without owning it.


> Likely that code should be reworked entirely to not
> have arbitrary hwpoison page flag modifications throughout the codebase.
> 
> > 
> > 
> > 
> > 	(b) There are some leftover SetPageHWPoison etc. instances. The ones in
> > 	arch/x86/kernel/cpu/mce/core.c likely cannot grab the mutex, but maybe they are
> > 	corner cases either way and we can document the situation.
> > 
> > Well, I did try to document the situation - it's in the commit log for
> > patch 1:
> > 
> >     Note: the MCE handler in arch/x86/kernel/cpu/mce/core.c also calls
> >     SetPageHWPoison() and is subject to the same race.  It cannot use
> >     the drain helpers (MCE context cannot call synchronize_rcu()).
> >     For recoverable MCE errors, memory_failure() is queued via work
> >     items (kill_me_maybe/kill_me_never) and will re-set the bit via
> >     test_and_set_hwpoison_drain_rcu() if it was clobbered.  The
> >     mce_panic() path sets HWPoison for kdump right before panic() so
> >     the race is irrelevant there.  The MCG_STATUS_SEAM_NR path does
> >     not queue memory_failure(), but the affected page belongs to a
> >     TDX guest whose CPU core has already been marked dead - the page
> >     is not subject to concurrent non-atomic flag operations in the
> >     buddy allocator, so the race does not apply.
> > 
> 
> We should have a central mechanism in place to document this and avoid future
> mistakes.

Like maybe a wrapper with lots of __, "raw" and "unsafe" so people know
they need to be careful.

> I am not even sure if we should clearly document for SetPageHWPoison() when and
> how they can be used, or if we need a completely new set of helpers.
> 
> And that's something to figure out (e.g., interaction with the mutex) by looking
> into all of the details, so I expect this to take a lot more time.
> 
> [...]

And again, I'm really not sure fixing a theoretical race when memory
is failing is worth slowing the world by 0.1-1% for.



> >> This is nothing to vibe-code. This needs a real expert.
> > 
> > Well I had this sitting on the disk anyway, so I thought I'd post.
> 
> It would be good to coordinate here.
> 
> Like a reply to my mail, asking whether you should post a new version that you
> have already in place.

Sure, I'll keep this in mind, thanks!

> > 
> > I wouldn't call this vibe-code - a bunch of manual work went into this,
> > llms mostly as a grep/sed replacement.  
> 
> The version you posted earlier had real AI vibes to it, so I can only speculate.
> I know that you did some manual work on this, but the details are really ugly in
> this code.
> 
> > But hey.  I don't object to
> > someone taking over, for sure. Was fun, and maybe these patches will be
> > helpful as a starting point.
> > 
> > In particular, maybe I should have been more explicit about how your
> > points from Friday are addressed.
> 
> Yes.
> 
> > 
> > If you want to add a bit more to explain the exact concerns here, for
> > whoever works on this next, feel free to do so.
> 
> I raised some above. I'll try to find someone to take a closer look and see to
> which degree we could optimize this.


From what I saw in my testing, if we allocate 4k pages
it's hidden by the overhead. With hp and thp it's measureably
worse than rcu on !preempt config.


I also tried keeping atomics in most places but optimizing the compound
case by test and set of pg lock, just to see what happens.  Was even
worse:

  4K (base: 5105 ns):
    rcu:     +63 +/- 144 ns  (+1.2 +/- 2.8%)
    atomic:   +8 +/- 144 ns  (+0.2 +/- 2.8%)
    pg_lock: +133 +/- 144 ns  (+2.6 +/- 2.8%)

  2M-thp (base: 52965 ns):
    rcu:      +74 +/- 780 ns  (+0.1 +/- 1.5%)
    atomic:  +657 +/- 780 ns  (+1.2 +/- 1.5%)                                                                          
    pg_lock: +1691 +/- 780 ns  (+3.2 +/- 1.5%)
  
  2M-hp (base: 53788 ns):                                                                                            
    rcu:     +150 +/- 821 ns  (+0.3 +/- 1.5%)
    atomic:  +427 +/- 821 ns  (+0.8 +/- 1.5%)
    pg_lock: +2413 +/- 821 ns  (+4.5 +/- 1.5%)

this is without preempt rcu. with preempt rcu it seems
much noisier so I can't really measure it:

4K (base: 5605 ns):
    rcu:     +126 +/- 136 ns  (+2.3 +/- 2.4%)
    atomic:   +44 +/- 114 ns  (+0.8 +/- 2.0%)

  2M-regular (base: 58179 ns):
    rcu:     -834 +/- 1573 ns  (-1.4 +/- 2.7%)
    atomic:  +440 +/- 1645 ns  (+0.8 +/- 2.8%)

  2M-huge (base: 59937 ns):
    rcu:     +800 +/- 2653 ns  (+1.3 +/- 4.4%)
    atomic: -1402 +/- 2546 ns  (-2.3 +/- 4.2%)



> 
> Or if there are actually more performant alternatives that we could use. (I
> still doubt that using atomics is ok in general)

Right now I'm thinking of looking at something like stop_machine maybe.

Do you want me to try?




-- 
MST

