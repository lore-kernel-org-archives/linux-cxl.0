Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488219994F
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923303; cv=none; b=SlgFB51pF960iCTwRYhU2QA2rzmLcWGPUcZcjF76c9i7jvW+m+a4dOK41CV2boDtjrdsJ9CKTEqNV7G8mwUFTl/WwhwH7gdyM3NtytkzB9s70AUvrln3cw341EgxXw2z1VAHksT0YW9o/pDkUOjJG33VVs2UrhWtwevQJY2usBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923303; c=relaxed/simple;
	bh=v/1UIMwsP3y9X8YWxu/JTNIkPLYd6PGOUSRh72mP1d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHvktKwCz0Ki653qoSmK7DRfu9Ds3teYSkC5iPMQPNBpYhXG/9KaAmUS2XJmwyXFCHpQTzPGbn5j9jnCASFjug2acNbNzTRf36U2pN83VuwfFd4QbhCiIQm9rDTr9+FDuX0LyLhTXCAFozBlRXr4ohDpPpUN1rxTZme93WqTBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-d2-67a5dd1f99cb
Date: Fri, 7 Feb 2025 19:14:49 +0900
From: Byungchul Park <byungchul@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: Matthew Wilcox <willy@infradead.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Honggyu Kim <honggyu.kim@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <20250207101449.GA35103@system.software.com>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnoa783aXpBt96eC0m9hhY/Lx7nN3i
	/KxTLBb31vxntdj3ei+zxe8fc9gc2Dx2zrrL7tHddpndY/MKLY9Nnyaxe0y+sZzR4/MmuQC2
	KC6blNSczLLUIn27BK6M/t2HmAv2i1esvRjcwLhZqIuRk0NCwETi1fTvzDD2692nwGwWARWJ
	TbefgtlsAuoSN278BLI5OEQEVCXarrh3MXJxMAs8YpTY/n4fG0hcWCBN4u0PP5ByXgELiSs7
	mxlBaoQEdjJKzNreygqREJQ4OfMJC4jNLKAlcePfSyaQXmYBaYnl/zhAwpwCZhKXGu+ygdii
	AsoSB7YdZwKZIyGwg01iWms7O8SdkhIHV9xgmcAoMAvJ2FlIxs5CGLuAkXkVo1BmXlluYmaO
	iV5GZV5mhV5yfu4mRmBQL6v9E72D8dOF4EOMAhyMSjy8CQeWpAuxJpYVV+YeYpTgYFYS4Z2y
	BijEm5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBMTzpVU2a
	y+3vm0slg16oRpbzLL93+mZoz7ueJezHWt/u7LqSwuNiM9kgO/CeTeshFVW74N6OqU+d54n6
	cn23v6LmdlTnb/LOpqqUBboSRlylXu4/l5x9+OrzBv9LO46zua18tDxVMuD/rC9rjr90+vau
	dUmnn3+ab8X/v1d1dTXe1n7/Hr9xhxJLcUaioRZzUXEiADk2aVtmAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsXC5WfdrCt/d2m6wasNjBYTewwsft49zm7x
	+dlrZovDc0+yWpyfdYrF4t6a/6wW+17vZbb4/WMOmwOHx85Zd9k9utsus3tsXqHlsenTJHaP
	yTeWM3p8u+3hsfjFByaPz5vkAjiiuGxSUnMyy1KL9O0SuDL6dx9iLtgvXrH2YnAD42ahLkZO
	DgkBE4nXu08xg9gsAioSm24/BbPZBNQlbtz4CWRzcIgIqEq0XXHvYuTiYBZ4xCix/f0+NpC4
	sECaxNsffiDlvAIWEld2NjOC1AgJ7GSUmLW9lRUiIShxcuYTFhCbWUBL4sa/l0wgvcwC0hLL
	/3GAhDkFzCQuNd5lA7FFBZQlDmw7zjSBkXcWku5ZSLpnIXQvYGRexSiSmVeWm5iZY6pXnJ1R
	mZdZoZecn7uJERi0y2r/TNzB+OWy+yFGAQ5GJR7ehANL0oVYE8uKK3MPMUpwMCuJ8E5ZAxTi
	TUmsrEotyo8vKs1JLT7EKM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgFPjZnrMg5eqz
	h7Pr3+WvlWy++mymvLyDjpzKlN/nG/ZNu7z0ROBxgVf2P1tEmQx0pkReKJ5978dk7clSzBJJ
	a79X31FZu+pYSJLQp2fuKm77Jwc+Onxe+fK2tNlua845bfJlmfRPoqA1+Mc3+YZXj+WZDQz8
	HX593Bo7oZLlZH6o9U65Sc7Nv5VYijMSDbWYi4oTAd9z6+pWAgAA
X-CFilter-Loop: Reflected

On Fri, Feb 07, 2025 at 03:57:45AM -0500, Gregory Price wrote:
> On Fri, Feb 07, 2025 at 04:20:24PM +0900, Byungchul Park wrote:
> > On Sat, Feb 01, 2025 at 02:04:17PM +0000, Matthew Wilcox wrote:
> > 
> > We can work with from the easiest object
> 
> >e.g. page table
> 
> It's more efficient and easier to change page sizes than it is to make
> page tables migratable.

You are misunderstanding.  I didn't say 'do not change page sizes'.  I
didn't say it's easier than changing page size.  I said *both* changing
page sizes and making them migratable could reduce ZONE_NORMAL cost.

> It's also easier to reclaim cold pages eating up significantly more
> memory than the page table (which describes pages at ~8 bytes per page).

Same.  We should keep reclaiming cold pages eating up memory.  Why do we
give up reclaiming cold pages if page table becomes migratable?  I
really don't understand why you are trying to exclusively pick up only
one effort for that purpose.

> Also, there's quite a bit of literature that shows page tables landing
> on remote nodes (cross-socket) has negative performance impacts.

Exactly.  That's the motivation to suggest this topic.  That's why we
are asking about kernel object migratibility.  Of course, we try our
best to place kernel object in DRAM in the first place.  However, the
thing would arise when it becomes impossible.  It's about comparison
between 'premature reclaim and die(= oom)' and 'slight degradation of
performance'.

> Putting them on CXL makes the problem worse.

No.  Higher chance to die is worse.

> > struct page,
> 
> `struct page` is a structure that describes a physically addressed page.
> 
> It is common to access it by simply doing `pfn_to_page()`, which is a
> fairly simply conversion (bit more complex in sparsemem w/ sections)
> 
> This is used in a lockless manner to acquire page references all over
> the kernel.
> 
> Making that migratable is... ambitious, to say the least.

Yes.  I don't think it's easy.

> > and kernel stack,
> 
> The default kernel stack size is like 16kb.  You'd need like 100,000
> threads to eat up 1.5GB, and 2048 threads only eats like 32MB.
> 
> It's not an interesting amount of memory if you have a 20TB system.

Kernel stack is an example.  We can skip it and look for better
candidate.

> > When it comes to this topic, the most important thing is the collected
> > *direction* from the community so that we can start the work under the
> > *direction*.
> > 
> 
> My thoughts here are that memory tiering is the wrong tool for the
> problem you are trying to solve.

I think any valid efforts can be considered at the same time.  Is there
any reason that effort in tiering environment should be excluded?

	Byungchul

> Maybe there's a world in which we propose a ZONE_MEMDESC which is
> exclusively used for `struct page` for a node. 
> 
> At least then you could design CXL capacities *around* that.
> 
> ~Gregory
