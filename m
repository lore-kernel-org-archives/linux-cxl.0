Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77B2EB5CD;
	Wed, 13 Aug 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094436; cv=none; b=JvDwXcKNDJlmaRtM7rBvPh7zMNrO6T0LnIM93B7mQnhvgxZHDQp2UOwDp9wYV2bkY8+Cpu6fbsjPpTDRxIAJjYKtmTXtkLsrFlMKBaw5klvFInuCKFShNeehPThZy0IvbCNjbUmw/7ujeoG/a1fJKDxPepYlXDfCLfThvCyFLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094436; c=relaxed/simple;
	bh=o9+mXqAZgYbbl5JJgeqk/XBNJNga6xKxin8Qw7DRFX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG8kSdoldF27epQXugTX7YUDTi5xGWlTtCFwEvU0eeQalKUsvJHisX8SssznckJrdi1JHbdBC+b2arWiR4sds5c+LbiatoEZcbUFRaE+21hib9hSg4jSkUd8Rhj8tsPV0iC2ZOYBBbiurUyQjTRAIB7MCbTFd7FlsaPoyQVL63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F3baQ1ii; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F3baQ1ii"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K44Xl1XsCvQ5r0uMP9kh7LzOK2PeNe/STdmukBQUiGM=; b=F3baQ1ii3EIeLIpZDumSryNN6l
	cN2Q75KYD2cQ1lY0Dcaedtib3sblYth0ZONOwsnAC1bjmCBwRHCUXr5nT7I/kNNi8K6UcfZiaP+H5
	FXbTTfDQZmKq4iRn+URzbPCktXBR/bxN50xcfGWiBL+6T1x0dwCAmCNLRu/nZKt6Xp2Np89woFpmR
	eDQBWmw8qrukOtnCZn0zKRhed6Tl3Zgye7t6psHtHVg2HDjnF2Ztz9dZqE+O+rXhDkPatReUag4ra
	oHSdAWbDnZOC0Pm+omaKJ5YdykRAbD8bsctQ1Ijf9fk2q3gsSfHtLymwKg1DojVMQBu3HnylY0JkV
	ZH8Y2l4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umCEd-00000009NIE-1kSz;
	Wed, 13 Aug 2025 14:13:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E970E3002C5; Wed, 13 Aug 2025 16:13:46 +0200 (CEST)
Date: Wed, 13 Aug 2025 16:13:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.jiang@intel.com, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with
 DEFINE_CLASS_IS_COND_GUARD
Message-ID: <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
References: <20250804220955.1453135-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804220955.1453135-1-dan.j.williams@intel.com>

On Mon, Aug 04, 2025 at 03:09:54PM -0700, Dan Williams wrote:
> Andy reports that the "lock_timer" scheme in kernel/time/posix-timers.c,
> with its custom usage of DEFINE_CLASS_IS_COND_GUARD(), results in:
> 
> kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
>    89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);
> 
> ...with a clang W=1 build. Per Nathan, clang catches unused "static inline"
> functions in C files since commit 6863f5643dd7 ("kbuild: allow Clang to
> find unused static inline functions for W=1 build").

I so loathe that warning :/

> There are 2 ways to solve this, either mark the class_##_lock_err()
> function as __maybe_unused, or make sure class_##_lock_err() *is* used /
> gets called to disposition the lock status.
> 
> At present __lock_timer() only indicates failure with a NULL __guard_ptr().
> However, one could imagine that __lock_timer(), or some other custom
> conditional locking primitive, wants to pass an ERR_PTR() to indicate the
> reason for the lock acquisition failure.
> 
> Update __scoped_cond_guard() to check for ERR_PTR() in addition to NULL
> @scope values. This allows __lock_timer(), or another open coded
> DEFINE_CLASS_IS_COND_GUARD() user, to switch to passing an ERR_PTR() in the
> future. In the meantime, this just silences the warning.
> 
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Closes: http://lore.kernel.org/aIo18KZpmKuR4hVZ@black.igk.intel.com
> Fixes: 857d18f23ab1 ("cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Dave, I am sending this to you to take upstream since the warning came
> in through the CXL tree. If anyone else wants to take it just holler.
> 
>  include/linux/cleanup.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 4eb83dd71cfe..d8e7d1e5561b 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -423,7 +423,8 @@ _label:									\
>  
>  #define __scoped_cond_guard(_name, _fail, _label, args...)		\
>  	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
> -		if (!__guard_ptr(_name)(&scope)) {			\
> +		if (!__guard_ptr(_name)(&scope) ||			\
> +		     __guard_err(_name)(&scope)) {			\
>  			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
>  			_fail;						\
>  _label:									\

What does this do for code generation ?
