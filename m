Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1B2D94B4;
	Wed, 30 Jul 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884616; cv=none; b=CX/MOan6ixBcaxJ5CE3L1B5C9/V7Gl8SidRG2KtYOSoDN96FerNGlRsLSFzZhRGgrXHrEFkT57n5TU1uWlkTOKMFlIAp4kTQlOCWpkYcYr+yaPvTXsjUwKDy+UH2kaMgGLccVzBfKHF49hw6AY2CFCvBmukHpcZXkXjb8+JhWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884616; c=relaxed/simple;
	bh=f3q82dC4fcAvpkwpRNPZBH2CXBSvKV3N+eEsYx/XpTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl/QsQ+Ve+Qd6xjGAfTn23LJ1XK4tRxbl1hCQUwNug2KfG0mHkBXbi3UM8A2FTXblRi/tti2Ktm4/NbTltH7I4S8HD3VBwVJRlHyz9xWrcXwtIFYEsxkj9Axpeiml7a7oVGemt5pwcd7Pw4QA4LBq+CRNC3IwJkt/zupn88PzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBrCIX0l; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBrCIX0l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753884615; x=1785420615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f3q82dC4fcAvpkwpRNPZBH2CXBSvKV3N+eEsYx/XpTo=;
  b=SBrCIX0ljvW2XUPHbzEgIGkva5gBWtea314nxWDpo0W3L010K2TQsIMw
   8ckpqqc8CJ6pY7MXq/b6/+jmVKW7qevzI0NG3DbiVEM7fv1jCUhm6rVIy
   qLnYdxvzJgeve+OkFN/J1VWwKkvoDF4U26RGtjEyVcmESbL9tgY2nyXDN
   +tY0duguSlDTliuHkvW3b6HWIMNwiNkZxDGrstzffJ2cMj9TV50lzh4vw
   CFtscn/J626ixgK35sJojSkyMdAKwKq/rHSkO4FC2jqJx1zgz3phq66Hi
   poCCrYVyfIR2e9+42tYVrHeTKz42dkBPGI5n8Mnaz2HKeMjFMlIk9Bkag
   A==;
X-CSE-ConnectionGUID: khiG5FfoSH6C/0bCCp8kmA==
X-CSE-MsgGUID: YNGG5iBHQjCfLepPh9edQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56334671"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56334671"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:10:14 -0700
X-CSE-ConnectionGUID: XsKJ/Jo5RVS1LasPilvzZw==
X-CSE-MsgGUID: JPGiqQ5eQKS9lDAqG85H3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162257888"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 30 Jul 2025 07:10:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id CF81F17; Wed, 30 Jul 2025 17:10:40 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:10:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <aIo18KZpmKuR4hVZ@black.igk.intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711234932.671292-1-dan.j.williams@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jul 11, 2025 at 04:49:24PM -0700, Dan Williams wrote:
> Changes since v2 [1]:
> - Pick up Acks and Reviews
> - Whitespace fixups for cleanup.h changes (Jonathan)
> - Use consistent local variable style for ACQUIRE_ERR() (Jonathan)
>   - Not addressed: switch to less compact style ACQUIRE_ERR()
> - Not addressed: pickup checkpatch change for ACQUIRE_ERR() style in
>   this series (Alison)
> - Drop the cxl_decoder_detach() CLASS() and convert to a helper function (Jonathan)
> - Refactor attach_target() to make it easier to read (Jonathan)
> 
> [1]: http://lore.kernel.org/20250619050416.782871-1-dan.j.williams@intel.com
> 
> For those new to this set, the motivation for this work is that the CXL
> subsystem adopted scope-based-cleanup helpers and achieved some decent
> cleanups. However, that work stalled with conditional locks. It stalled
> due to the pain points of scoped_cond_guard(). See patch1.
> 
> In the interim, approaches like rwsem_read_intr_acquire() attempted to
> workaround the pain points, but started a "parallel universe" of helpers
> that is not sustainable.
> 
>     0c6e6f1357cb cxl/edac: Add CXL memory device patrol scrub control feature
> 
> Peter fixed all of this up in a manner consistent with existing guards.
> Take that proposal and run with it to unblock further cleanups of "goto"
> in unwind paths in the CXL subsystem.
> 
> Potential follow-on work identified by this effort:
> 
> - __GUARD_IS_ERR() asm helper [2]
> - Checkpatch fixups for proposed ACQUIRE_ERR() style [3]
> 
> [2]: http://lore.kernel.org/20250514064624.GA24938@noisy.programming.kicks-ass.net
> [3]: http://lore.kernel.org/aGXDMZB6omShJpoj@aschofie-mobl2.lan

This series broke `make W=1` build vor clang. +Cc Nathan.

Par exemple:

/kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
   89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/include/linux/cleanup.h:376:2: note: expanded from macro 'DEFINE_CLASS_IS_COND_GUARD'
  376 |         __DEFINE_GUARD_LOCK_PTR(_name, _T)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/include/linux/cleanup.h:358:20: note: expanded from macro '__DEFINE_GUARD_LOCK_PTR'
  358 |         static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~
<scratch space>:24:1: note: expanded from here
   24 | class_lock_timer_lock_err
      | ^~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

-- 
With Best Regards,
Andy Shevchenko


