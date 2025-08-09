Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E519DF9A;
	Sat,  9 Aug 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732804; cv=none; b=KJHHlocTCA1oEL6Htw0nSnUeSKJ+nUtF+HzNQhbKdHNFEuLXI3tqzIqelo0JDbfn+auFDcwUlc1GvzC7BSeFPJmwhR0jQBSW6LNqZWNUxekOc3rHn9o3/AMHfw8X2vj0bLIfUrMaT54NZHtFFoq0xNwfninumzzIlt1GPdaQqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732804; c=relaxed/simple;
	bh=wdy+l8t7qIA++5RlDvu5ZdGGsffFZW4ATZxlimIuYLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjCdslP41xWy0eV8NsYOboFu0+dKYyheeSIfuCQuh32BJ1j1uGIrgEhmGPnEBSYIibZpkzdjbFcOcbPneguBV2eTvSr3knVgS367tgBLlLB5JMIaxYU5UzYN/ovb1br3kSuYlnJqyYAYZitWLOnvyXpHD6ugLAiFm7UAYKeLcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVqhjG3f; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVqhjG3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754732804; x=1786268804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wdy+l8t7qIA++5RlDvu5ZdGGsffFZW4ATZxlimIuYLg=;
  b=RVqhjG3fGGQw2hv3KlbFZ9trIMouY/2EJFTi+veNBl3y+Um7tfaCLGKs
   4rJY5fe8SS98yu8eSy+dl76LK6xVSGg35ZVkFjA+HEiTqeMlDt5I/P7MG
   3U7pqsiK8gYDA4F+WxFTpCBXx1CB5k3U0jlcoLoOqx/Ax0yBBqELplm8O
   QtNcLK6FX0DR7+Mvo9nYF5hqhSem+WPrtQywdnjvgOXvl4VW55hd6uAdH
   Q9EFWcHg+BlRtNPU+PB6CghNnr0cbf0evhmrWwUOGv9Q/D0sq2hEmRf4x
   yyudAkTNjS2LKeLKQA9dtHY6iSxEPTZiGJWMHujkUA78Xm/y7gJkn+/WV
   Q==;
X-CSE-ConnectionGUID: tXnG3J9VTFeAWSfxD7F26Q==
X-CSE-MsgGUID: vao8Mn6kRnehpbfP5AoA5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="56965705"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56965705"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 02:46:43 -0700
X-CSE-ConnectionGUID: TKcsy3kwQTqHq84z+ykv4A==
X-CSE-MsgGUID: RAzjC8bcS92sZNIqBA4Xdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="202693344"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 02:46:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ukg9t-00000004cVB-0h0M;
	Sat, 09 Aug 2025 12:46:37 +0300
Date: Sat, 9 Aug 2025 12:46:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.jiang@intel.com, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with
 DEFINE_CLASS_IS_COND_GUARD
Message-ID: <aJcY_IVHj_0xaM3_@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

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
> 
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

FWIW,

Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

but as I mentioned in previous mail, it doesn't fix all issues I have, and
maybe more.

-- 
With Best Regards,
Andy Shevchenko


