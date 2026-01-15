Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3A36C0B1;
	Thu, 15 Jan 2026 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478267; cv=none; b=bXXVCwMUGsiUZC867S7JK5QQOaVKRGCSHmA4zxs8X0rriDvByjRIKwo1FJ6j/r3IC2cloPQQ3RJ8IJAuj13cwU3A4l0qzptT22XDx6Vxk58a1OHbYdUjbqRZAUrDO8nVAn5wNWM58PO+a7czg+HeAyB4mbhUzE/6uHtCGdRtbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478267; c=relaxed/simple;
	bh=3yFNVx2OS+NPUw/CNGRe/9X+3quSzefgUSkG3mHbtlA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=db1uf/2o46+CNIHpN4tC/iXKjmUpfL+hztDvQ2b4oQP0wijKkQuf8/i3tX2jO0d0ahsLmwCN6EE45wD/WC2BSr5F7If43ZQGrG+3C2DKhoeKaAEb1sWn1/D2XnRg9movBxh1iizlZfp4ZVd5A01QM781z03DkEVLDOYIKLQAGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsM0v6KZczHnGk9;
	Thu, 15 Jan 2026 19:57:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B38134056A;
	Thu, 15 Jan 2026 19:57:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 11:57:40 +0000
Date: Thu, 15 Jan 2026 11:57:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
CC: Li Zhe <lizhe.67@bytedance.com>, <akpm@linux-foundation.org>,
	<ankur.a.arora@oracle.com>, <fvdl@google.com>, <joao.m.martins@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mhocko@suse.com>,
	<mjguzik@gmail.com>, <muchun.song@linux.dev>, <osalvador@suse.de>,
	<raghavendra.kt@amd.com>, <linux-cxl@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Gregory Price <gourry@gourry.net>, Dan Williams
	<dan.j.williams@intel.com>, <zhanjie9@hisilicon.com>,
	<wangzhou1@hisilicon.com>
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
Message-ID: <20260115115739.00007cf6@huawei.com>
In-Reply-To: <83798495-915b-4a5d-9638-f5b3de913b71@kernel.org>
References: <9daa39e6-9653-45cc-8c00-abf5f3bae974@kernel.org>
	<20260115093641.44404-1-lizhe.67@bytedance.com>
	<83798495-915b-4a5d-9638-f5b3de913b71@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 15 Jan 2026 12:08:03 +0100
"David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> On 1/15/26 10:36, Li Zhe wrote:
> > On Wed, 14 Jan 2026 18:21:08 +0100, david@kernel.org wrote:
> >      
> >>>> But again, I think the main motivation here is "increase application
> >>>> startup", not optimize that the zeroing happens at specific points in
> >>>> time during system operation (e.g., when idle etc).
> >>>>  
> >>>
> >>> Framing this as "increase application startup" and merely shifting the
> >>> overhead to shutdown seems like gaming the problem statement to me.
> >>> The real problem is total real time spent on it while pages are
> >>> needed.
> >>>
> >>> Support for background zeroing can give you more usable pages provided
> >>> it has the cpu + ram to do it. If it does not, you are in the worst
> >>> case in the same spot as with zeroing on free.
> >>>
> >>> Let's take a look at some examples.
> >>>
> >>> Say there are no free huge pages and you kill a vm + start a new one.
> >>> On top of that all CPUs are pegged as is. In this case total time is
> >>> the same for "zero on free" as it is for background zeroing.  
> >>
> >> Right. If the pages get freed to immediately get allocated again, it
> >> doesn't really matter who does the freeing. There might be some details,
> >> of course.
> >>  
> >>>
> >>> Say the system is freshly booted and you start up a vm. There are no
> >>> pre-zeroed pages available so it suffers at start time no matter what.
> >>> However, with some support for background zeroing, the machinery could
> >>> respond to demand and do it in parallel in some capacity, shortening
> >>> the real time needed.  
> >>
> >> Just like for init_on_free, I would start with zeroing these pages
> >> during boot.
> >>
> >> init_on_free assures that all pages in the buddy were zeroed out. Which
> >> greatly simplifies the implementation, because there is no need to track
> >> what was initialized and what was not.
> >>
> >> It's a good question if initialization during that should be done in
> >> parallel, possibly asynchronously during boot. Reminds me a bit of
> >> deferred page initialization during boot. But that is rather an
> >> extension that could be added somewhat transparently on top later.
> >>
> >> If ever required we could dynamically enable this setting for a running
> >> system. Whoever would enable it (flips the magic toggle) would zero out
> >> all hugetlb pages that are already in the hugetlb allocator as free, but
> >> not initialized yet.
> >>
> >> But again, these are extensions on top of the basic design of having all
> >> free hugetlb folios be zeroed.
> >>  
> >>>
> >>> Say a little bit of real time passes and you start another vm. With
> >>> merely zeroing on free there are still no pre-zeroed pages available
> >>> so it again suffers the overhead. With background zeroing some of the
> >>> that memory would be already sorted out, speeding up said startup.  
> >>
> >> The moment they end up in the hugetlb allocator as free folios they
> >> would have to get initialized.
> >>
> >> Now, I am sure there are downsides to this approach (how to speedup
> >> process exit by parallelizing zeroing, if ever required)? But it sounds
> >> like being a bit ... simpler without user space changes required. In
> >> theory :)  
> > 
> > I strongly agree that init_on_free strategy effectively eliminates the
> > latency incurred during VM creation. However, it appears to introduce
> > two new issues.
> > 
> > First, the process that later allocates a page may not be the one that
> > freed it, raising the question of which process should bear the cost
> > of zeroing.  
> 
> Right now the cost is payed by the process that allocates a page. If you
> shift that to the freeing path, it's still the same process, just at a
> different point in time.
> 
> Of course, there are exceptions to that: if you have a hugetlb file that
> is shared by multiple processes (-> process that essentially truncates
> the file). Or if someone (GUP-pin) holds a reference to a file even after
> it was truncated (not common but possible).
> 
> With CoW it would be the process that last unmaps the folio. CoW with
> hugetlb is fortunately something that is rare (and rather shaky :) ).
> 
> > 
> > Second, put_page() is executed atomically, making it inappropriate to
> > invoke clear_page() within that context; off-loading the zeroing to a
> > workqueue merely reopens the same accounting problem.  
> 
> I thought about this as well. For init_on_free we always invoke it for
> up to 4MiB folios during put_page() on x86-64.
> 
> See __folio_put()->__free_frozen_pages()->free_pages_prepare()
> 
> Where we call kernel_init_pages(page, 1 << order);
> 
> So surely, for 2 MiB folios (hugetlb) this is not a problem.
> 
> ... but then, on arm64 with 64k base pages we have 512 MiB folios
> (managed by the buddy!) where this is apparently not a problem? Or is
> it and should be fixed?
> 
> So I would expect once we go up to 1 GiB, we might only reveal more
> areas where we should have optimized in the first case by dropping
> the reference outside the spin lock ... and these optimizations would
> obviously (unless in hugetlb specific code ...) benefit init_on_free
> setups as well (and page poisoning).

FWIW I'd be interesting in seeing if we can do the zeroing async and allow
for hardware offloading. If it happens to be in CXL (and someone
built the fancy bits) we can ask the device to zero ranges of memory
for us.  If they built the HDM-DB stuff it's coherent too (came up
in the Davidlohr's LPC Device-mem talk on HDM-DB + back invalidate
support)
+CC linux-cxl and Davidlohr + a few others.

More locally this sounds like fun for DMA engines, though they are going
to rapidly eat bandwidth up and so we'll need QoS stuff in place
to stop them perturbing other workloads.

Give me a list of 1Gig pages and this stuff becomes much more efficient
than anything the CPU can do.

Jonathan

> 
> 
> Looking at __unmap_hugepage_range(), for example, we already make sure
> to not drop the reference while holding the PTL (spinlock).
> 
> In general, I think when using MMU gather we drop folio references out
> of the PTL, because we know that it can hurt performance badly.
> 
> I documented some of the nasty things that can happen with MMU gather in
> 
> commit e61abd4490684de379b4a2ef1be2dbde39ac1ced
> Author: David Hildenbrand <david@kernel.org>
> Date:   Wed Feb 14 21:44:34 2024 +0100
> 
>      mm/mmu_gather: improve cond_resched() handling with large folios and expensive page freeing
>      
>      In tlb_batch_pages_flush(), we can end up freeing up to 512 pages or now
>      up to 256 folio fragments that span more than one page, before we
>      conditionally reschedule.
>      
>      It's a pain that we have to handle cond_resched() in
>      tlb_batch_pages_flush() manually and cannot simply handle it in
>      release_pages() -- release_pages() can be called from atomic context.
>      Well, in a perfect world we wouldn't have to make our code more
>      complicated at all.
>      
>      With page poisoning and init_on_free, we might now run into soft lockups
>      when we free a lot of rather large folio fragments, because page freeing
>      time then depends on the actual memory size we are freeing instead of on
>      the number of folios that are involved.
>      
>      In the absolute (unlikely) worst case, on arm64 with 64k we will be able
>      to free up to 256 folio fragments that each span 512 MiB: zeroing out 128
>      GiB does sound like it might take a while.  But instead of ignoring this
>      unlikely case, let's just handle it.
> 
> 
> But more general, when dealing with the PTL we try to put folio references outside
> the lock (there are some cases in mm/memory.c where we apparently don't do it yet),
> because freeing memory can take a while.
> 

