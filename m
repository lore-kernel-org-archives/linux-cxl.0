Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58044254AFF;
	Fri,  9 May 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817914; cv=none; b=aKQfgj26xDGUNSO13cJZTUtaYOyqWlPTieBJ6kZZzPt+AJ6281F+58I95ctsMXW255bEvrAkNhRYl8OBE0oR4hPEUNcOnUhzOjRVQpTo5eSUgOK/bDeqQyR4mL9v+PUCW9Yp46Jy4mPJ6E4KPF9nCQqCT7Vbq7gJrwop5zPkswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817914; c=relaxed/simple;
	bh=LiM82RC5VzqZIXYZK6AJ9EgWOvBAUSujh5mMx5KMKhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGKraZinbwHsqiWtP8i410noQRyOGqxC4jLmm5N+ASOgh4uZiqss8chjlmlse5IhEeqb2KUkBzNKjrVOe0HAQ3s2oitgf2WSGLIwGlRYwgkDswVDCYf+h76XA8bT6yEfoRleAVE0GYYqwMX6mzxjrey/0JcGVqByWB2LYb6rcKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNocD2z9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNocD2z9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746817911; x=1778353911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LiM82RC5VzqZIXYZK6AJ9EgWOvBAUSujh5mMx5KMKhw=;
  b=KNocD2z9kQOjXeDN4Lk2B7UwZTXfpQ+fPM1ei85RwYqto6ALDMmF0z0h
   kxoxJOLn88kefOjvww0wFRKTk4baXOZ+2GMhjkf883IImIa1mN4MMZF3m
   FqSoKpf1vqlFP7mhovlMAeg2dovD5jyo7HF4Tm3jbUwolg2nDE927N+aC
   djAFSVQoUzwmhBK8MwDWDpWbChXw5k0dVyCVxDUvwT6VD7eokjmufQ4Aw
   LIrxbgKrDrMWYARPf/HPo1T7+hZwCgpedA0Q7nnhIXTIn4SOnCn7aBEb1
   iq3R2C+priXbZhhAr9WxU1kDOV2TLenf3Jzr8dg3Qcrn+zEu6CdPHCXkO
   g==;
X-CSE-ConnectionGUID: qJ+YzW4/SIKOgkTRvhG+9g==
X-CSE-MsgGUID: YRgRfmzISFaJAsT0zQth4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48663563"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="48663563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 12:11:50 -0700
X-CSE-ConnectionGUID: 485UEADqSAScjNa/Kz2FDg==
X-CSE-MsgGUID: 4+/8bSBKQV6Asvtd6HtjkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="136656603"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 May 2025 12:11:47 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDT8K-000COV-2P;
	Fri, 09 May 2025 19:11:44 +0000
Date: Sat, 10 May 2025 03:10:50 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <202505100206.85k3mymM-lkp@intel.com>
References: <20250507072145.3614298-2-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507072145.3614298-2-dan.j.williams@intel.com>

Hi Dan,

kernel test robot noticed the following build errors:

[auto build test ERROR on b4432656b36e5cc1d50a1f2dc15357543add530e]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/cleanup-Introduce-DEFINE_ACQUIRE-a-CLASS-for-conditional-locking/20250507-152728
base:   b4432656b36e5cc1d50a1f2dc15357543add530e
patch link:    https://lore.kernel.org/r/20250507072145.3614298-2-dan.j.williams%40intel.com
patch subject: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for conditional locking
config: arm-randconfig-001-20250509 (https://download.01.org/0day-ci/archive/20250510/202505100206.85k3mymM-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250510/202505100206.85k3mymM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505100206.85k3mymM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/irqflags.h:17,
                    from arch/arm/include/asm/bitops.h:28,
                    from include/linux/bitops.h:68,
                    from arch/arm/boot/compressed/../../../../lib/lz4/lz4defs.h:40,
                    from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:36,
                    from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
                    from arch/arm/boot/compressed/decompress.c:60:
   include/linux/mutex.h: In function 'class_mutex_intr_acquire_destructor':
>> include/linux/cleanup.h:476:13: error: implicit declaration of function 'IS_ERR_OR_NULL' [-Werror=implicit-function-declaration]
           if (!IS_ERR_OR_NULL(_T)) _unlock(&_T->_locktype), ({    \
                ^~~~~~~~~~~~~~
   include/linux/cleanup.h:246:18: note: in definition of macro 'DEFINE_CLASS'
    { _type _T = *p; _exit; }      \
                     ^~~~~
   include/linux/mutex.h:216:1: note: in expansion of macro 'DEFINE_ACQUIRE'
    DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
    ^~~~~~~~~~~~~~
   include/linux/mutex.h: In function 'class_mutex_intr_acquire_constructor':
>> include/linux/cleanup.h:481:24: error: implicit declaration of function 'ERR_PTR'; did you mean 'PERCPU_PTR'? [-Werror=implicit-function-declaration]
             lock_result = ERR_PTR(ret);             \
                           ^~~~~~~
   include/linux/cleanup.h:248:13: note: in definition of macro 'DEFINE_CLASS'
    { _type t = _init; return t; }
                ^~~~~
   include/linux/mutex.h:216:1: note: in expansion of macro 'DEFINE_ACQUIRE'
    DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
    ^~~~~~~~~~~~~~
>> include/linux/cleanup.h:481:22: warning: assignment to 'struct mutex_acquire *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
             lock_result = ERR_PTR(ret);             \
                         ^
   include/linux/cleanup.h:248:13: note: in definition of macro 'DEFINE_CLASS'
    { _type t = _init; return t; }
                ^~~~~
   include/linux/mutex.h:216:1: note: in expansion of macro 'DEFINE_ACQUIRE'
    DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
    ^~~~~~~~~~~~~~
   include/linux/mutex.h: In function 'class_mutex_try_acquire_constructor':
>> include/linux/cleanup.h:481:22: warning: assignment to 'struct mutex_acquire *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
             lock_result = ERR_PTR(ret);             \
                         ^
   include/linux/cleanup.h:248:13: note: in definition of macro 'DEFINE_CLASS'
    { _type t = _init; return t; }
                ^~~~~
   include/linux/mutex.h:226:1: note: in expansion of macro 'DEFINE_ACQUIRE'
    DEFINE_ACQUIRE(mutex_try_acquire, mutex, mutex_unlock,
    ^~~~~~~~~~~~~~
   In file included from include/linux/rwsem.h:17,
                    from include/linux/mm_types.h:13,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:38,
                    from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
                    from arch/arm/boot/compressed/decompress.c:60:
   include/linux/err.h: At top level:
>> include/linux/err.h:39:35: error: conflicting types for 'ERR_PTR'
    static inline void * __must_check ERR_PTR(long error)
                                      ^~~~~~~
   In file included from include/linux/irqflags.h:17,
                    from arch/arm/include/asm/bitops.h:28,
                    from include/linux/bitops.h:68,
                    from arch/arm/boot/compressed/../../../../lib/lz4/lz4defs.h:40,
                    from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:36,
                    from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
                    from arch/arm/boot/compressed/decompress.c:60:
   include/linux/cleanup.h:481:24: note: previous implicit declaration of 'ERR_PTR' was here
             lock_result = ERR_PTR(ret);             \
                           ^~~~~~~
   include/linux/cleanup.h:248:13: note: in definition of macro 'DEFINE_CLASS'
    { _type t = _init; return t; }
                ^~~~~
   include/linux/mutex.h:216:1: note: in expansion of macro 'DEFINE_ACQUIRE'
    DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
    ^~~~~~~~~~~~~~
   In file included from include/linux/rwsem.h:17,
                    from include/linux/mm_types.h:13,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:38,
                    from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
                    from arch/arm/boot/compressed/decompress.c:60:
>> include/linux/err.h:82:33: error: conflicting types for 'IS_ERR_OR_NULL'
    static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
                                    ^~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:17,
                    from arch/arm/include/asm/bitops.h:28,
                    from include/linux/bitops.h:68,
                    from arch/arm/boot/compressed/../../../../lib/lz4/lz4defs.h:40,
                    from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:36,
                    from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
                    from arch/arm/boot/compressed/decompress.c:60:
   include/linux/cleanup.h:476:13: note: previous implicit declaration of 'IS_ERR_OR_NULL' was here
           if (!IS_ERR_OR_NULL(_T)) _unlock(&_T->_locktype), ({    \
                ^~~~~~~~~~~~~~
   include/linux/cleanup.h:246:18: note: in definition of macro 'DEFINE_CLASS'
    { _type _T = *p; _exit; }      \
                     ^~~~~
   include/linux/mutex.h:216:1: note: in expansion of macro 'DEFINE_ACQUIRE'
    DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
    ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/IS_ERR_OR_NULL +476 include/linux/cleanup.h

   416	
   417	#define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
   418		__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
   419		EXTEND_CLASS(_name, _ext,					\
   420			     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
   421			        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
   422				_t; }),						\
   423			     typeof_member(class_##_name##_t, lock) l)		\
   424		static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
   425		{ return class_##_name##_lock_ptr(_T); }
   426	
   427	/*
   428	 * DEFINE_ACQUIRE(acquire_class_name, lock_type, unlock, cond_lock):
   429	 *	Define a CLASS() that instantiates and acquires a conditional lock
   430	 *	within an existing scope. In contrast to DEFINE_GUARD[_COND](), which
   431	 *	hides the variable tracking the lock scope, CLASS(@acquire_class_name,
   432	 *	@lock) instantiates @lock as either an ERR_PTR() or a cookie that drops
   433	 *	the lock when it goes out of scope. An "_acquire" suffix is appended to
   434	 *	@lock_type to provide type-safety against mixing explicit and implicit
   435	 *	(scope-based) cleanup.
   436	 *
   437	 * Ex.
   438	 *
   439	 * DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
   440	 *                mutex_lock_interruptible)
   441	 *
   442	 *	int interruptible_operation(...)
   443	 *	{
   444	 *		...
   445	 *		CLASS(mutex_intr_acquire, lock)(&obj->lock);
   446	 *	     if (IS_ERR(lock))
   447	 *			return PTR_ERR(lock);
   448	 *		...
   449	 *	} <= obj->lock dropped here.
   450	 *
   451	 * Attempts to perform:
   452	 *
   453	 * mutex_unlock(&obj->lock);
   454	 *
   455	 * ...fail because obj->lock is a 'struct mutex_acquire' not 'struct mutex'
   456	 * instance.
   457	 *
   458	 * Also, attempts to use the CLASS() conditionally require the ambiguous
   459	 * scope to be clarified (compiler enforced):
   460	 *
   461	 *	if (...)
   462	 *		CLASS(mutex_intr_acquire, lock)(&obj->lock); // <-- "error: expected expression"
   463	 *		if (IS_ERR(lock))
   464	 *			return PTR_ERR(lock);
   465	 *
   466	 * vs:
   467	 *
   468	 *	if (...) {
   469	 *		CLASS(mutex_intr_acquire, lock)(&obj->lock);
   470	 *		if (IS_ERR(lock))
   471	 *			return PTR_ERR(lock);
   472	 *	} // <-- lock released here
   473	 */
   474	#define DEFINE_ACQUIRE(_name, _locktype, _unlock, _cond_lock)                \
   475		DEFINE_CLASS(_name, struct _locktype##_acquire *,                    \
 > 476			     if (!IS_ERR_OR_NULL(_T)) _unlock(&_T->_locktype), ({    \
   477				     struct _locktype##_acquire *lock_result;        \
   478				     int ret = _cond_lock(&to_lock->_locktype);      \
   479	                                                                             \
   480				     if (ret)                                        \
 > 481					     lock_result = ERR_PTR(ret);             \
   482				     else                                            \
   483					     lock_result =                           \
   484						     (struct _locktype##_acquire     \
   485							      *)&to_lock->_locktype; \
   486				     lock_result;                                    \
   487			     }),                                                     \
   488			     struct _locktype##_acquire *to_lock)
   489	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
