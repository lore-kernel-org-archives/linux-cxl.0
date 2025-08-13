Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B9208CA;
	Wed, 13 Aug 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092817; cv=none; b=qvD7964RRvOd1JDFrJf806si98Bcs1J98+kTIKq/9IqXwnS/Umv+vy2jR1S4VB/9V5K45/ZNeYBYSW6QMQjT3MS9xbtiScJTY1bYHVDbSebJp3w4GafGJMqp4dB4wv/stWuOtrcpN9VdlZJDVA5731VFA6NcB24U6JA1MCdJRqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092817; c=relaxed/simple;
	bh=TXdvPYqiXQAnQCcny+WMevzcGRF8HLT7Ggdtqds7eo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvduiDJo30CJ30FhZkga4rh3R9CyyRxxEWQNSPRJZrXEAdrlWOfk+mXeNaNyc6w9YkmMPLX2+OqoWtROwgt8DY1YDFK0uarwDJaaKbMkMdsw7VS3A3YO5pIaLPRpmjULLZDRUAm9lGV1eE16MjCrbaGK3FrjV5Od8XHarAdV5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr1GFj8p; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr1GFj8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755092816; x=1786628816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TXdvPYqiXQAnQCcny+WMevzcGRF8HLT7Ggdtqds7eo8=;
  b=mr1GFj8piGHDZbECUNj+RmTrzVU7yR5Mn1zMMYcYfKc9Na2qVwIAmqvX
   MGVzwEeYx2izI8LmLDqJZLy8p65JCyA3/+ugUlq6S89K5GpllFhjP97u5
   qexgms+ZXjkarh52AYf/pN5VJ+frisoEqPRXOkJharXlvtprDKcGge5Jx
   +YEvipBOUVsTvz/3HYIEoZe1u1b9Q5EMreZJi0jjJ3h67V1UhEMmiMkqd
   2gyZlausqCXcO1B6tuQ5uzPoMasYWsTxS3wxLkh4Kf8ushhrjlEOBJ0AC
   82jE1Zr2PddUweqc7L3r3Jk23nKaigFMATQ+KvpNc1AM1EKrYjP14GbeS
   A==;
X-CSE-ConnectionGUID: 3SvOHelST4GW8hmktZZTTQ==
X-CSE-MsgGUID: PinCTQzlTFy9YfamyIc0zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57533597"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57533597"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:46:55 -0700
X-CSE-ConnectionGUID: BlyXti81SpWWwB6JrsQJ+w==
X-CSE-MsgGUID: N0MJzIkdSMKfYhftoOiHcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166454855"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:46:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1umBoY-00000005Rln-2VmG;
	Wed, 13 Aug 2025 16:46:50 +0300
Date: Wed, 13 Aug 2025 16:46:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: dan.j.williams@intel.com
Cc: dave.jiang@intel.com, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with
 DEFINE_CLASS_IS_COND_GUARD
Message-ID: <aJyXSrgZCU8r4bJ8@smile.fi.intel.com>
References: <20250804220955.1453135-1-dan.j.williams@intel.com>
 <aJKH4PlYXSuBua4_@smile.fi.intel.com>
 <689a750ad41b2_50ce10064@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689a750ad41b2_50ce10064@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 11, 2025 at 03:56:10PM -0700, dan.j.williams@intel.com wrote:
> Andy Shevchenko wrote:
> > On Mon, Aug 04, 2025 at 03:09:54PM -0700, Dan Williams wrote:
> > > Andy reports that the "lock_timer" scheme in kernel/time/posix-timers.c,
> > > with its custom usage of DEFINE_CLASS_IS_COND_GUARD(), results in:
> > > 
> > > kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
> > >    89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);
> > > 
> > > ...with a clang W=1 build. Per Nathan, clang catches unused "static inline"
> > > functions in C files since commit 6863f5643dd7 ("kbuild: allow Clang to
> > > find unused static inline functions for W=1 build").
> > > 
> > > There are 2 ways to solve this, either mark the class_##_lock_err()
> > > function as __maybe_unused, or make sure class_##_lock_err() *is* used /
> > > gets called to disposition the lock status.
> > > 
> > > At present __lock_timer() only indicates failure with a NULL __guard_ptr().
> > > However, one could imagine that __lock_timer(), or some other custom
> > > conditional locking primitive, wants to pass an ERR_PTR() to indicate the
> > > reason for the lock acquisition failure.
> > > 
> > > Update __scoped_cond_guard() to check for ERR_PTR() in addition to NULL
> > > @scope values. This allows __lock_timer(), or another open coded
> > > DEFINE_CLASS_IS_COND_GUARD() user, to switch to passing an ERR_PTR() in the
> > > future. In the meantime, this just silences the warning.
> > 
> > Hmm... It seems fixes the timer case, but left others still fail:
> > 
> > drivers/pwm/core.c:54:1: error: unused function 'class_pwmchip_lock_err' [-Werror,-Wunused-function]
> >    54 | DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
> >       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/linux/cleanup.h:380:2: note: expanded from macro 'DEFINE_GUARD'
> >   380 |         DEFINE_CLASS_IS_GUARD(_name)
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/linux/cleanup.h:372:2: note: expanded from macro 'DEFINE_CLASS_IS_GUARD'
> >   372 |         __DEFINE_GUARD_LOCK_PTR(_name, _T)
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/linux/cleanup.h:358:20: note: expanded from macro '__DEFINE_GUARD_LOCK_PTR'
> >   358 |         static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
> >       |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> > <scratch space>:81:1: note: expanded from here
> >    81 | class_pwmchip_lock_err
> >       | ^~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> 
> Ok, so in these cases where the guard is unconditional, the _lock_err()
> method can be safely ignored. Here is a quick patch (below), only gcc
> compile tested, that tries to quiet the warning for unconditional
> guards, but keep the warning for conditional guards.
> 
> If you have some time to try it out, great, otherwise I will circle back
> with a clang W=1 compile test before submitting the formal patch:

I have applied it on top of the previous (incomplete) solution and tried on two
branches, one is based on v6.17-rc1 and the other on Linux Next. I do not see
problem anymore.

Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


