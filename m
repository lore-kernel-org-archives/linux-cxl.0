Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17D3009F0;
	Wed, 13 Aug 2025 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121541; cv=none; b=XPLcHbGCzrLFaY37RoTAFYYbHia6f4NpDRFI2hI6jlk/YmgkegGSQ1b4BNuUSpbV1t75UITqBKzo3g+salAffBAoN2LWR57Ej/xjYnL0da5aViwyivy6UtTpe6YRoUB6xUcr3HzSnEMQZ/p0Hll+MQhdY3Qau+88WNbjekZ21CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121541; c=relaxed/simple;
	bh=F4f83btsjyboCnQlU+uU8DbZkoaZ7bIdaugcop9Ogb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNvWPkXaGb61LXxrsIV7n5yGNP9BERGGGPv7v4EWJTo30v0VWpgWys4CVVBEREwT2yyo+xo3sO8OSjAZ6xhV+94uiT94EcRvODrXzD6VZ4oqPw9WI7vN/RPAH/Co3RUTR7rK7fB26Cl7EeiBv0P1399w2RR3dJkxB5xjWd2YsjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBsgOiya; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBsgOiya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755121540; x=1786657540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4f83btsjyboCnQlU+uU8DbZkoaZ7bIdaugcop9Ogb0=;
  b=LBsgOiyaEh8/uvwKfJdvxtIs/w9l7WQVoDx/r15zqK0bB7QpQyz30D3M
   I3pGvQ0hmCU9AuhXIqJmca1yk8ldYiXIkwrUPSImB8VfwSJSPa5wJ4orA
   iFzceMS4Wov183Htt4gUF4gKkxbEeX0jTLjhGPaCWUggiaycfrh5lfqbk
   Oopt/2w4OQLUNLrD7jpmrAiZGlXKondk8zEEvSGXCp/d5E7KFjpGw9QrL
   aNM/XVSk1hV3FoYZSRIYNbCEID+X6lyOd7E0ioFfcXh9uxWRDAluwXAz8
   w1TasgPsiUjJWujx3r3CHAuC6kTQbc+cT8mPlnGs/A69P71P9CG5c6LT7
   w==;
X-CSE-ConnectionGUID: bLa5Hp2ORLKryFefaCvNng==
X-CSE-MsgGUID: /4i1G92ZQ6KTzRfvFOKS0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="60056186"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="60056186"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:45:40 -0700
X-CSE-ConnectionGUID: m4AS8PwJTEyMpaFlf37SRg==
X-CSE-MsgGUID: Hu/ieqJVRsyO1K4OyLMYDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="203761935"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:45:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1umJHq-00000005W9l-2xDb;
	Thu, 14 Aug 2025 00:45:34 +0300
Date: Thu, 14 Aug 2025 00:45:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with
 DEFINE_CLASS_IS_COND_GUARD
Message-ID: <aJ0Hfqnv4LZdVcQa@smile.fi.intel.com>
References: <20250804220955.1453135-1-dan.j.williams@intel.com>
 <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
 <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 13, 2025 at 08:14:59AM -0700, Linus Torvalds wrote:
> On Wed, 13 Aug 2025 at 07:13, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Aug 04, 2025 at 03:09:54PM -0700, Dan Williams wrote:
> > >
> > > ...with a clang W=1 build. Per Nathan, clang catches unused "static inline"
> > > functions in C files since commit 6863f5643dd7 ("kbuild: allow Clang to
> > > find unused static inline functions for W=1 build").
> >
> > I so loathe that warning :/
> 
> So I entirely ignore W=1 issues, because I think so many of the extra
> warnings are bogus.
> 
> But if this one in particular is causing more problems than most -
> some teams do seem to use W=1 as part of their test builds - it's fine
> to send me a patch that just moves bad warnings to W=2.
> 
> And if anybody uses W=2 for their test builds, that's THEIR problem..

Exactly. I am only aware of W=0/W=1, I think I run W=2 once or twice in my life.

-- 
With Best Regards,
Andy Shevchenko


