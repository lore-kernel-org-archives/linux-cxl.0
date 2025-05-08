Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C500623A6;
	Thu,  8 May 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702060; cv=none; b=at0sBJb1FCKtYkR8ugIVgENQmtGw3Ktvgv2SR4hdC9FmLk9AnILP/k/sPqNj8lqVjxwwYV1pyvIkcGx8pl5q4NH+KGJ1G6eBVMBl4F8yu5qU6/fN4v5nFSuugZvxTJxAR7MTw3mlfEAcKNG3YErWPFA+cU+vnB4qqS+RUGVMrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702060; c=relaxed/simple;
	bh=l3q1IQMozEcVKE1GFMh8/uWDA6LrLzBnwPibgs5IiSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMIgvlUrOfve7q79D2psMYRm95yFAItlS5aFSUBMpDwyO5RU1/VGAsNs3NybULe1HR7Ukx5p/B+Z4f0fXiTbwD36zoeIRRcmOLIVr+2x1ENO5Yeqs2/fevu3slwbjd9SzG4X/sM1el5APsjD2D8z/RVBPgh3JoinUr0iJzSe1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N6E02Kg5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N6E02Kg5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=58GUmSPvRIWyTu51o3M/HG1fyqBAnpnqbzHg0QuQnpA=; b=N6E02Kg57NeUw9NTp62E506MDB
	Vuqg2WhjXgpZkgFCPQ/O+GfYhUJZbN3wd5UoJpV9Vj4q3rRvq3PzW7myN40niDmAB4/qKDGM7tQwU
	EG0bZ88fFmY33AqMrsz/oJ7M8QnuYoss7zDRhysMzpv0owuPFVk52+ozCrImLmHYAU0XwzvcQenkZ
	kYukrRsFrZfR5JfavOOiZcFUUgF7MExWGXXGkP6TBi1W9M+PZZ6pvalluTtb1ZZOCNb3/rMBTzL8X
	N7HeLs8/f4ohGDLAlirOWohJiIAx3W8keOed/nwQl2ftGdjHO/MiIfaa+h0uhFALeSldC+jYSaKgV
	H6kLxKaw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCyzc-00000000Rc8-3exC;
	Thu, 08 May 2025 11:00:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9EF2130026A; Thu,  8 May 2025 13:00:43 +0200 (CEST)
Date: Thu, 8 May 2025 13:00:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
Message-ID: <20250508110043.GG4439@noisy.programming.kicks-ass.net>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
 <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, May 07, 2025 at 02:18:25PM -0700, Dan Williams wrote:
> Peter Zijlstra wrote:
> [..]
> > > @@ -202,6 +204,28 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
> > >  DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
> > >  DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
> > >  
> > > +/* mutex type that only implements scope-based unlock */
> > > +struct mutex_acquire {
> > > +	/* private: */
> > > +	struct mutex mutex;
> > > +};
> > > +DEFINE_GUARD(mutex_acquire, struct mutex_acquire *, mutex_lock(&_T->mutex),
> > > +	     mutex_unlock(&_T->mutex))
> > > +DEFINE_GUARD_COND(mutex_acquire, _try, mutex_trylock(&_T->mutex))
> > > +DEFINE_GUARD_COND(mutex_acquire, _intr, mutex_lock_interruptible(&_T->mutex) == 0)
> > > +DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
> > > +	       mutex_lock_interruptible)
> > > +
> > > +static inline int mutex_try_or_busy(struct mutex *lock)
> > > +{
> > > +	int ret[] = { -EBUSY, 0 };
> > > +
> > > +	return ret[mutex_trylock(lock)];
> > > +}
> > > +
> > > +DEFINE_ACQUIRE(mutex_try_acquire, mutex, mutex_unlock,
> > > +	       mutex_try_or_busy)
> > > +
> > >  extern unsigned long mutex_get_owner(struct mutex *lock);
> > >  
> > >  #endif /* __LINUX_MUTEX_H */
> > 
> > I'm terribly confused...
> 
> I suspect the disconnect is that this proposal adds safety where guard()
> does not today. That was driven by the mistake that Linus caught in the
> RFC [1]
> 
> 	at the same time I note that your patch is horribly broken. Look
> 	at your change to drivers/cxl/core/mbox.c: you made it use
> 	
> 	+       struct mutex *lock __drop(mutex_unlock) =
> 	+               mutex_intr_acquire(&mds->poison.lock);
> 	
> 	but then you didn't remove the existing unlocking, so that
> 	function still has
> 
> [1]: http://lore.kernel.org/CAHk-=wgRPDGvofj1PU=NemF6iFu308pFZ=w5P+sQyOMGd978fA@mail.gmail.com
> 
> I.e. in my haste I forgot to cleanup a straggling open-coded
> mutex_unlock(), but that is something the compiler warns about iff we
> switch to parallel primitive universe.

AFAICT all you've done is an effective rename. You can still write:

	mutex_unlock(&foo->lock.lock);

and the compiler will again happily do so.

> > What's wrong with:
> > 
> > 	CLASS(mutex_intr, lock)(&foo);
> > 	if (IS_ERR(__guard_ptr(mutex_intr)(lock)))
> > 		return __guard_ptr(mutex_intr)(lock);
> 
> __guard_ptr() returns NULL on error, not an ERR_PTR, but I get the gist.

(Yeah, I realized after sending, but didn't want to self-reply for
something minor like that :-)

> > I mean, yeah __guard_ptr(mutex_intr) doesn't really roll of the tongue,
> > but if that is the whole objection, surely we can try and fix that bit
> > instead of building an entire parallel set of primitives.
> 
> Yes, the "entire set of parallel primitives" was the least confident
> part of this proposal, but the more I look, that is a feature (albeit
> inelegant) not a bug.
> 
> Today one can write:
> 
>     guard(mutex_intr)(&lock);
>     ...
>     mutex_unlock(lock);
> 
> ...and the compiler does not tell you that the lock may not even be held
> upon return, nor that this is unlocking a lock that will also be
> unlocked when @lock goes out of scope.
> 
> The only type safety today is the BUILD_BUG_ON() in scoped_cond_guard()
> when passing in the wrong lock class.
> 
> So the proposal is, if you know what you are doing, or have a need to
> switch back and forth between scope-based and explicit unlock for a give
> lock, use the base primitives. If instead you want to fully convert to
> scope-based lock management (excise all explicit unlock() calls) *and*
> you want the compiler to validate the conversion, switch to the _acquire
> parallel universe.

As with all refactoring ever, the rename trick always works. But I don't
think that warrants building a parallel infrastructure just for that.

Specifically, it very much does not disallow calling mutex_unlock() on
your new member. So all you get is some compiler help during refactor,
and again, just rename the lock member already.

Also, if we ever actually get LLVM's Thread Safety Analysis working,
that will help us with all these problems:

  https://lore.kernel.org/all/20250304092417.2873893-1-elver@google.com/

But the compiler needs a little more work go grok C :-)
