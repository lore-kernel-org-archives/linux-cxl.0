Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132A348463
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718543; cv=none; b=VquLw5n8KAT9yejl79CUqknGARHYMp8EYV/tiPQjAO3wqfSlK3v9S1M9U0LelwVaSSdpPE0f0A+OnT4M46D6CwLswTJJGpDov/Lnv/i50jX4egBTwkpV04uGL6XIbJ4m0WY7vL/NzIR0QeQ+l2YXi6MzaekTtdxK6SeaTh5ESIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718543; c=relaxed/simple;
	bh=klIDKNbhnlXm4+EZXLzePYjjEuLW5jpNa1qqh72tJFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pBBSXSOhbB7d8sXEHly9gLLIz4aDUJx/NjnyD3tEJY5Rk0jQ4yM/ObeRc0HTf7/tGVOtXc3iRK+wIhFp7+JxELmmI2lLP4HU1bBn9f5kmUMZAxPli37nbr7ZA/0LGZ2912vpFi4QaFusfM5sAqbPU8hvB6wcsE2u5/e1uDcos3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZ195P8I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZ195P8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782718534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YhwD5e0TAt0qKmZwhk19yeLkiMwZuJytbMfHyxkkjWg=;
	b=SZ195P8IXiaCWp6NVf6wUsA3qc5eTkZ7xd/kb1uqe3iF73/H/VKEqN4WrMHM93UWuJv8Jw
	AVbBhrXJO1PHV3XQL/tq0NOhqX1TtlUJA6dW6T/oPQ/DAoF97X8K++SiJ6WvfDXtAGHbKx
	jVrFdZo9PpQz1n0PKGCubUcQ4lxJfow=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-8rhJwU5BPRyJHvJIOEcRkg-1; Mon, 29 Jun 2026 03:35:28 -0400
X-MC-Unique: 8rhJwU5BPRyJHvJIOEcRkg-1
X-Mimecast-MFC-AGG-ID: 8rhJwU5BPRyJHvJIOEcRkg_1782718526
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36bbcd40642so1774096a91.0
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 00:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782718526; x=1783323326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhwD5e0TAt0qKmZwhk19yeLkiMwZuJytbMfHyxkkjWg=;
        b=I1C6c3f04TYR/bX7UGw5uoNMLp6yFOhsrBs7AXIlYb1GHflUPlbiUXK1BADC6HW9GR
         VwCbLzqCtLm9GU7PgF5PFKc/HLWQlyAMxCb1eT0s8Ah9na+SaTxFf3PmSrpjS1d1g8Ug
         zgSHhiDinw9N4aThZ7XcL9dS0nhYgrYz9iSOM21r+4VIZR/A4C0fs6JLi8lwFPL2s7Ej
         cwDrNPGTKHf0Yn9IybYbde90BS1Ewy0ZefAz5Q70LUc0nqj4fDkALKKUWHp+vUin1BrV
         SF1l5igWZZ3zYSyqRC8NivU4BYIy4jqHY5Ivvi7sX5X0Gs0/b53h8ZYALJMhXTinCY+c
         /DmA==
X-Forwarded-Encrypted: i=1; AFNElJ/M6EXqR1iIZdZV2Fijfvh37BpYL338D+dlurGsGXJe4qv4ZR7UMFZC0KSnREsLoX83QBPZf1iDMTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rkF01OqqkaB8GRAYZAbKElsNdk1cwUVmIY1r/Np6W3KyWufk
	+MhfN9E0ajm4uNuppdLu9cqvX9rqztLZ6KZpGv8DBPzU4WSAowNQcUjsveRU8e+WrI6sxsulTpf
	pSA7Wuu2VW2oOq56fKSwfoIQFf+qUbrLF+eFM1gH1CYx3umw3lebX+sS/8ZU7MQ==
X-Gm-Gg: AfdE7cnUpppF3ltPyRyuh9ipPkoqu/FEwygHayhvo2NzEfcqtixcbvh1KN7G5qU+ejo
	uNXNihpvMqtF4MVEXYVIjcXYBxhFp+ZAh1sky+PkEZaIcjt6hIEIveiSU86YHmLGGwQd64EG/7P
	mgIT+xhehRbALATvHrTm4k9IEcpZ3swiLvI58vNBArRQpcJpcbDRIw1hugZDeKYXXTQ+V3p77Zn
	XHnE1gNNquum0E+P111g51WbDp4gjQzOh0tmLZp2OztGHrl4fH5On6YwDEoJXkUO8JqfslfR/OS
	N/9Sp/3yA9PGXyow7qiqWhM7P6hgSJWhZEL1BWmSTQvmSUz5Kt41nBCPneCVyhlJRy9JNDDes2T
	tNGmN9PDSTUdDin5WD1swp7m/uhx8hk3s
X-Received: by 2002:a05:6a21:a08:b0:3bf:79d6:f063 with SMTP id adf61e73a8af0-3bf79d740bdmr5424833637.43.1782718525441;
        Mon, 29 Jun 2026 00:35:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:a08:b0:3bf:79d6:f063 with SMTP id adf61e73a8af0-3bf79d740bdmr5424801637.43.1782718524686;
        Mon, 29 Jun 2026 00:35:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bd55985asm7323848a12.31.2026.06.29.00.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:35:24 -0700 (PDT)
Date: Mon, 29 Jun 2026 03:34:59 -0400
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
Message-ID: <20260629030657-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fYeTYq8tC2MytdZ_wz5JhlkmKXCgQMtXu-5hE0frNyg_1782718526
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 08:49:37AM +0200, David Hildenbrand (Arm) wrote:
> On 6/28/26 23:45, Michael S. Tsirkin wrote:
> > I don't like it that we are adding overhead to the good path for
> > the benefit of memory failure, which never triggers on many systems,
> > but I don't have a better idea. Pls take a look.
> 
> As I said on Friday.
> 
> "It's also doesn't address the mf_mutex implications and the x86 thingies I
> mentioned.

Well I did attempt addressing this.  These would be these two:

	(a) We don't hold the mf_mutex on all call paths, but we really need it so a
	page_test_set_hwpoison() cannot race in weird ways with the other primitives I think.

page_test_set_hwpoison was this code you wrote:

+static void page_set_hwpoison(struct page *page)
+{
+       lockdep_assert_held(&mf_mutex);
+
+       while (!PageHWPoison(page)) {
+               SetPageHWPoison(page);
+
+               /* Make sure concurrent non-atomic writers completed. */
+               synchronize_rcu();
+       }
+}

and indeed the test+set combination seems racy.  But consider the version I posted, for example:

+/*
+ * Drain any in-flight non-atomic page flag operations that could
+ * clobber a concurrently set HWPoison bit.  Retries until the bit sticks.
+ */
+static void set_hwpoison_drain_rcu(struct page *p)
+{
+       do {
+               synchronize_rcu();
+       } while (!TestSetPageHWPoison(p));
+}
+

...

+static bool test_and_set_hwpoison_drain_rcu(struct page *p)
+{
+       bool was_set = TestSetPageHWPoison(p);
+
+       set_hwpoison_drain_rcu(p);
+       return was_set;
+}



does not seem racy without a lock. But maybe I don't get it.



	(b) There are some leftover SetPageHWPoison etc. instances. The ones in
	arch/x86/kernel/cpu/mce/core.c likely cannot grab the mutex, but maybe they are
	corner cases either way and we can document the situation.

Well, I did try to document the situation - it's in the commit log for
patch 1:

    Note: the MCE handler in arch/x86/kernel/cpu/mce/core.c also calls
    SetPageHWPoison() and is subject to the same race.  It cannot use
    the drain helpers (MCE context cannot call synchronize_rcu()).
    For recoverable MCE errors, memory_failure() is queued via work
    items (kill_me_maybe/kill_me_never) and will re-set the bit via
    test_and_set_hwpoison_drain_rcu() if it was clobbered.  The
    mce_panic() path sets HWPoison for kdump right before panic() so
    the race is irrelevant there.  The MCG_STATUS_SEAM_NR path does
    not queue memory_failure(), but the affected page belongs to a
    TDX guest whose CPU core has already been marked dead - the page
    is not subject to concurrent non-atomic flag operations in the
    buddy allocator, so the race does not apply.






> ...
> 
> I'll either take care of that myself or find someone that can work on this with
> attention to all details.
> "

> 
> This is nothing to vibe-code. This needs a real expert.

Well I had this sitting on the disk anyway, so I thought I'd post.

I wouldn't call this vibe-code - a bunch of manual work went into this,
llms mostly as a grep/sed replacement.  But hey.  I don't object to
someone taking over, for sure. Was fun, and maybe these patches will be
helpful as a starting point.

In particular, maybe I should have been more explicit about how your
points from Friday are addressed.

If you want to add a bit more to explain the exact concerns here, for
whoever works on this next, feel free to do so.




> > 
> > Non-atomic page flag operations (page->flags.f &= ~mask, __set_bit,
> > __clear_bit) can race with atomic TestSetPageHWPoison() in
> > memory_failure().  The non-atomic RMW reads flags, memory_failure()
> > atomically sets HWPoison, then the RMW writes back the old value
> > without HWPoison, clobbering the bit.
> > 
> > The race was confirmed by injecting a cpu_relax() delay between the
> > load and store of the non-atomic RMW in __free_pages_prepare, then
> > running concurrent MADV_HWPOISON injection.  The clobbered HWPoison
> > bit was observed repeatedly.
> > 
> > This series fixes the race by:
> > 
> > 1. Having memory_failure() call synchronize_rcu() + retry after
> >    setting HWPoison, so that any in-flight non-atomic RMW that
> >    read the old flags value completes before we proceed.
> > 
> > 2. Wrapping all non-atomic page flag operations in
> >    rcu_read_lock/rcu_read_unlock (CONFIG_MEMORY_FAILURE only),
> >    so that synchronize_rcu() actually drains them.
> > 
> > Performance impact (page alloc+free microbenchmark, 200K iterations,
> > 20 runs, KVM guest, error bars are 3-sigma):
> > 
> >   !PREEMPT_RCU (x86):
> >                          insns/iter      cycles/iter
> >     base:                12237 +/- 1     17954 +/- 136
> >     patched:             +22 +/- 1       -124 +/- 122
> >                          (+0.18%)        (within noise)
> > 
> >   PREEMPT_RCU:
> >                          insns/iter      cycles/iter
> >     base:                12512 +/- 3     18541 +/- 214
> >     patched:             +95 +/- 3       -12 +/- 161
> >                          (+0.76%)        (within noise)
> > 
> > When !CONFIG_MEMORY_FAILURE, all wrappers compile away completely.
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> 
> No ;)
> 
> -- 
> Cheers,
> 
> David

