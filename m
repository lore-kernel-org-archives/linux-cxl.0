Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD11DB34C;
	Wed,  7 May 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610435; cv=none; b=dyErj7b/REWoEOgkY0UZWOy9AlPcaU6rPzTU3jhn8TJ9/gEh5gFjiQkgojJi3lRiz7wnet5yH48biNDG80PDrQFak19dykvAY4U780E9nF9pjSyHoDjYeFf6uRq5KZCNiZ8Vf+i6eeidZTnL3HwBGBpXmmC9CeVOWRVmcdEfdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610435; c=relaxed/simple;
	bh=7uKxlcm8hF+GP/lEs3hwwcpIItjW1KwqPILWv/W+BAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eqj+RGUlMS9meMiPutvtgU61De8iRQBnFFJUvFaWpdGVSgsTJTAO7jfUeU/oXDiYorbdWQIK1nI8dESQzb23scETVfWqr79PyTRRFkDPa46ednRGYXCP6KYBjhxK7+O3QjvvMGPs9fwM/RPn/Pv7MaNsDZcfZooNDuT/ZETSsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KmfDcXEk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KmfDcXEk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wO8Ep5r+eRGIpCVFMRHl1DMMom/dtctroBqJhWEPXaQ=; b=KmfDcXEkKRg6PZxU6j06s6suBc
	WFCUcuSH91BNvCKSx9Qryq9k5krbIzRxS7l+VBFPhO+ZfC2Ot+HKOQnKzr/Q8eCgumO0rXR3uq514
	x990MkoNt7YPBAE1T6c0BrDXYclgunvGHVmnOibHnTnyzilt0+qXNyu0G40JqJJIcH2KH80OFtN+0
	xeMDfkgEQ5xqji1x4qLeLi0mt2lONVnBCfYvoDq9ysExRbZpBilDHGbglNE3eru6UuM9cyp/OzJNm
	d0Q+W1JHl2tCxSHd8+ZhcKm8d1zLiqFfJ2HlIpjvfCQXyQDwyqGm0oLXe1SYPTFUNrRsCk+8HUlsg
	ph3+lGCg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCb8n-00000002PXR-0iqz;
	Wed, 07 May 2025 09:32:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E1FE6300780; Wed,  7 May 2025 11:32:24 +0200 (CEST)
Date: Wed, 7 May 2025 11:32:24 +0200
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
Message-ID: <20250507093224.GD4439@noisy.programming.kicks-ass.net>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507072145.3614298-2-dan.j.williams@intel.com>

On Wed, May 07, 2025 at 12:21:39AM -0700, Dan Williams wrote:
> The scoped_cond_guard() helper has two problems. First, with "convert to
> cleanup" style patches, it results in messy diffs that re-indent large
> swaths of code. Second, it swallows return values from interruptible /
> killable locks, i.e. the return value of those is not always -EINTR.
> 
> The last attempt at improving this situation, if_not_guard() [1], was
> reverted with a suggestion:
> 
>     "I really think the basic issue is that 'cond_guard' itself is a pretty
>      broken concept. It simply doesn't work very well in the C syntax."
> 
> However, the observation is that just exposing the CLASS() to callers
> solves: the safety concern (compiler enforced "expected expression"
> checks), conveying the conditional acquisition state of the lock, and
> avoiding re-indentation caused by scoped_cond_guard(). See the commit below
> for the analysis of the revert.
> 
> Commit b4d83c8323b0 ("headers/cleanup.h: Remove the if_not_guard() facility")
> 
> The DEFINE_ACQUIRE() macro wraps a lock type like 'struct mutex' into a
> 'struct mutex_acquire' type that can only be acquired and automatically
> released by scope-based helpers. E.g.:
> 
>     [scoped_]guard(mutex_acquire)(...)
>     CLASS(mutex_intr_acquire, ...)
>     CLASS(mutex_try_acquire, ...)
> 
> Use DEFINE_ACQUIRE to create the new classes above and use
> mutex_intr_acquire in the CXL subsystem to demonstrate the conversion.
> 

> +#define DEFINE_ACQUIRE(_name, _locktype, _unlock, _cond_lock)                \
> +	DEFINE_CLASS(_name, struct _locktype##_acquire *,                    \
> +		     if (!IS_ERR_OR_NULL(_T)) _unlock(&_T->_locktype), ({    \
> +			     struct _locktype##_acquire *lock_result;        \
> +			     int ret = _cond_lock(&to_lock->_locktype);      \
> +                                                                             \
> +			     if (ret)                                        \
> +				     lock_result = ERR_PTR(ret);             \
> +			     else                                            \
> +				     lock_result =                           \
> +					     (struct _locktype##_acquire     \
> +						      *)&to_lock->_locktype; \
> +			     lock_result;                                    \
> +		     }),                                                     \
> +		     struct _locktype##_acquire *to_lock)
>  
>  #endif /* _LINUX_CLEANUP_H */
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 2143d05116be..283111f43b0f 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -64,6 +64,8 @@ do {									\
>  	__mutex_init((mutex), #mutex, &__key);				\
>  } while (0)
>  
> +#define mutex_acquire_init(lock) mutex_init(&(lock)->mutex)
> +
>  /**
>   * mutex_init_with_key - initialize a mutex with a given lockdep key
>   * @mutex: the mutex to be initialized
> @@ -202,6 +204,28 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
>  DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
>  DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
>  
> +/* mutex type that only implements scope-based unlock */
> +struct mutex_acquire {
> +	/* private: */
> +	struct mutex mutex;
> +};
> +DEFINE_GUARD(mutex_acquire, struct mutex_acquire *, mutex_lock(&_T->mutex),
> +	     mutex_unlock(&_T->mutex))
> +DEFINE_GUARD_COND(mutex_acquire, _try, mutex_trylock(&_T->mutex))
> +DEFINE_GUARD_COND(mutex_acquire, _intr, mutex_lock_interruptible(&_T->mutex) == 0)
> +DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
> +	       mutex_lock_interruptible)
> +
> +static inline int mutex_try_or_busy(struct mutex *lock)
> +{
> +	int ret[] = { -EBUSY, 0 };
> +
> +	return ret[mutex_trylock(lock)];
> +}
> +
> +DEFINE_ACQUIRE(mutex_try_acquire, mutex, mutex_unlock,
> +	       mutex_try_or_busy)
> +
>  extern unsigned long mutex_get_owner(struct mutex *lock);
>  
>  #endif /* __LINUX_MUTEX_H */

I'm terribly confused...

What's wrong with:

	CLASS(mutex_intr, lock)(&foo);
	if (IS_ERR(__guard_ptr(mutex_intr)(lock)))
		return __guard_ptr(mutex_intr)(lock);

I mean, yeah __guard_ptr(mutex_intr) doesn't really roll of the tongue,
but if that is the whole objection, surely we can try and fix that bit
instead of building an entire parallel set of primitives.


Notably, you're going to be running into trouble the moment you want to
use your acquire stuff on things like raw_spin_trylock_irqsave(),
because all that already wraps the return type, in order to hide the
flags thing etc.


