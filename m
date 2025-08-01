Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53813A3ED;
	Fri,  1 Aug 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074930; cv=none; b=dKIroF/oQCsM2RTeHYzeojCRF/6khB/2hLvBtkCPh9IMN5nTbmhInlhZC7k31I3AAv69ATgCwLUU+XoFsNRZIOtfaI/ECuqbIUL/CTT9dS2UTdBHnm5mfcs7afoi52XeVHgeZMwCgNC20MdxWpzBwPG3ftywZ0lmNklBsKT20MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074930; c=relaxed/simple;
	bh=D5JGXQ87XI8CeDienzkEHNGraxFQkdmB12vbBJbuw2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV5L6KF30cGP97vMxh3w4S0jBUQQ3xcM3olHH9QIlKpY8ZK2a71VJgE6KOfOfka2hW8QYP70WlsCtNmzv43v1mKM/Ls89FVIkWaBF4JA14642CuW97ZWA254KNG658qYwtsTJ9Ux1FryprJ6TAqzWklKQCfdWdCBo8LSKHaBjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/0q8wJx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/0q8wJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2945EC4CEE7;
	Fri,  1 Aug 2025 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754074929;
	bh=D5JGXQ87XI8CeDienzkEHNGraxFQkdmB12vbBJbuw2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/0q8wJx3IYPHEU6PHWjSp1kcqlZ1HEy1UGvpMEqPnMs7OyWiYS1F0ScVn3RHWg3m
	 CDlmOQOX0z2AMjuQijCeRFW8WlU83IgxJfMjoAoIOrG3hJ21pyMH3T+9P698jOI+ZY
	 tuAs4EvBNE8+2qwaznzr+gcFEThxVUO1/Y/lm+ZfOauqPts7mmm5SyDcU3wJxEl+j9
	 KGbS9xfdAPW8gc7QcxNdsGbG1TtKUQOpPzddCXVx8b+KvslddXT/mbX9dCUWawP7KC
	 +PLaB4ikFLXXCxzGT6SGH0fUNDnYu+fF3o7X82f8nmhYY4xW6HD+FOiK71QgvocAry
	 p9C/SjMnX7Yvw==
Date: Fri, 1 Aug 2025 12:02:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: dan.j.williams@intel.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v3 0/8] cleanup: Introduce ACQUIRE(), a guard() for
 conditional locks
Message-ID: <20250801190203.GA939298@ax162>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <aIo18KZpmKuR4hVZ@black.igk.intel.com>
 <688d0c322cdd6_55f091000@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <688d0c322cdd6_55f091000@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Aug 01, 2025 at 11:49:22AM -0700, dan.j.williams@intel.com wrote:
> Andy Shevchenko wrote:
> > This series broke `make W=1` build vor clang. +Cc Nathan.
> > 
> > Par exemple:
> > 
> > /kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
> >    89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);
> >       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /include/linux/cleanup.h:376:2: note: expanded from macro 'DEFINE_CLASS_IS_COND_GUARD'
> >   376 |         __DEFINE_GUARD_LOCK_PTR(_name, _T)
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /include/linux/cleanup.h:358:20: note: expanded from macro '__DEFINE_GUARD_LOCK_PTR'
> >   358 |         static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
> >       |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> > <scratch space>:24:1: note: expanded from here
> >    24 | class_lock_timer_lock_err
> >       | ^~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> 
> A few observations:
> 
> - This is odd, the inline should have been compiled away if not used.
> - __always_inline does not help
> - Seems to go away with __maybe_unused, but that seems more like a
>   compiler band-aid than a fix

See commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build") for more information on the difference
between GCC and Clang when it comes to how 'static inline' functions
behave with -Wunused-function, namely that Clang will warn for functions
defined in .c files (but not .h files), whereas GCC will not warn for
either.

> - This locking pattern is not immediately amenable to the ACQUIRE_ERR()
>   approach because the unlock object is the return code from the
>   constructor.
> 
> Given all that, and that an ACQUIRE_ERR() would end up being messier
> than the scoped_timer_get_or_fail() approach, I think the best fix is to
> quiet the warning, but maybe Peter and Nathan have other ideas?

Yes, this is what I would recommend, as we never care if this function
is unused, right? You could probably outright substitute
'__maybe_unused' for 'inline' in this case, since the compiler is
already free to ignore it and the attribute takes care of any potential
unused warnings, which I think 'inline' is primarily used for nowadays.

Cheers,
Nathan

> -- 8< --
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 4eb83dd71cfe..0dc7148d1b88 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -348,7 +348,8 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
>  		}                                                           \
>  		return _ptr;                                                \
>  	}                                                                   \
> -	static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
> +	static __maybe_unused inline int class_##_name##_lock_err(          \
> +		class_##_name##_t *_T)                                      \
>  	{                                                                   \
>  		long _rc = (__force unsigned long)*(_exp);                  \
>  		if (!_rc) {                                                 \
