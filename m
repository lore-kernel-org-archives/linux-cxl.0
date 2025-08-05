Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22E1DF759;
	Tue,  5 Aug 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433511; cv=none; b=XtGLA5+wL3dLwHZaZk5wbrb2AMjMbbYlQfLGFAEC69EHtyBbI+HPvZYZhW8+JalNJsT5fXH6mmwEnwjhflG0dLcq2ZTnnv+TNyyqCjTBAQqgXQEJ7CfjQSX09FaLHOBJg4twAM9A6FLFo5BRYpBVF+aA2slqyaTKC4QFQWzY1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433511; c=relaxed/simple;
	bh=qkLwpsGo+NYgSsu3Musf3IN98rbXjnBj7WV7sNgrgLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS3tnd7h9IPhmX67vpcxSZzk8rljHyEE5f51bA2quCsFvPq++4p8Js3M3KdilFy9E7ks5g2mK2POgOpoGYUrOjhH1ebDxc1l8Ov17HEPy3gpLGK/j523LK5UOORuRlwGkOK2dD8y8wvQDi53gPspy7yHvHIj3rh23aKAFTMS7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCKCs6Xo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCKCs6Xo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754433511; x=1785969511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qkLwpsGo+NYgSsu3Musf3IN98rbXjnBj7WV7sNgrgLQ=;
  b=VCKCs6XoYLJrnvzTB7ax7wDnI2gYyFx5PsA6Nbfg7zhYw7Rbh8xuWyVp
   xcdByWTJEEchWQdZRXrivi9WoKFEWfVoOXFRDp+FB5s/Z4S44jWMZIEEF
   tsQQkxhTlgs0VNo+vgj3DUw59MRylVlig5H0aQhzCOfyOLupuWkhQFs3l
   +6fuM9IIM7an3AVqtcPqtE8S5UWLG1n66oA5isnHn9u2krTRZAGPHQkNE
   r0Dg9zBT6izurvy3acjbjIZatqGmNZYh79IPXsjeK5XU1q4Psk7demzMC
   MUOA2LuRjqomupyAEbNcDoEjn9WTu65dqb0c14Vm4UoY/vabYUv5GHvrk
   g==;
X-CSE-ConnectionGUID: 676Uuvp3QBSZvGFAwBJ04g==
X-CSE-MsgGUID: 1f1fZctSQOG86nRsBWEmJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="79292833"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="79292833"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:38:31 -0700
X-CSE-ConnectionGUID: iuzP73ZeQquPZjUWAl1WIw==
X-CSE-MsgGUID: nghmhU06TYK5mYi+ZhT4hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="163874660"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:38:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ujQIa-00000003s0w-24fl;
	Wed, 06 Aug 2025 01:38:24 +0300
Date: Wed, 6 Aug 2025 01:38:24 +0300
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
Message-ID: <aJKH4PlYXSuBua4_@smile.fi.intel.com>
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

Hmm... It seems fixes the timer case, but left others still fail:

drivers/pwm/core.c:54:1: error: unused function 'class_pwmchip_lock_err' [-Werror,-Wunused-function]
   54 | DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/cleanup.h:380:2: note: expanded from macro 'DEFINE_GUARD'
  380 |         DEFINE_CLASS_IS_GUARD(_name)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/cleanup.h:372:2: note: expanded from macro 'DEFINE_CLASS_IS_GUARD'
  372 |         __DEFINE_GUARD_LOCK_PTR(_name, _T)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/cleanup.h:358:20: note: expanded from macro '__DEFINE_GUARD_LOCK_PTR'
  358 |         static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~
<scratch space>:81:1: note: expanded from here
   81 | class_pwmchip_lock_err
      | ^~~~~~~~~~~~~~~~~~~~~~
1 error generated.

fs/namespace.c:1782:1: error: unused function 'class_namespace_lock_lock_err' [-Werror,-Wunused-function]
  1782 | DEFINE_GUARD(namespace_lock, struct rw_semaphore *, namespace_lock(), namespace_unlock())
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/cleanup.h:380:2: note: expanded from macro 'DEFINE_GUARD'
  380 |         DEFINE_CLASS_IS_GUARD(_name)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/cleanup.h:372:2: note: expanded from macro 'DEFINE_CLASS_IS_GUARD'
  372 |         __DEFINE_GUARD_LOCK_PTR(_name, _T)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/cleanup.h:358:20: note: expanded from macro '__DEFINE_GUARD_LOCK_PTR'
  358 |         static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~
<scratch space>:15:1: note: expanded from here
   15 | class_namespace_lock_lock_err
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These I have and I dunno how many more can be detected with allyesconfig and/or
allmodconfig on all possible architectures...

-- 
With Best Regards,
Andy Shevchenko


