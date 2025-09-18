Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897E221F29;
	Thu, 18 Sep 2025 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223308; cv=none; b=mikTJ4k1KhtwRoasvzpj6KbgMf4n/CtDlrEZSgT2gpof0VNAbso5x4fjUFHJueWvyJgehp6plL3z8RwpBqlhhU4kZ7ckuYrZHX0BI6SjC/BBbyl9i+ybbdq4bKNEd0vSh3W5fnVmxdaFMJvVhHuLGwFlM3+64jpa8bGxaSBd4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223308; c=relaxed/simple;
	bh=lqJ18xE2y3F/YfAM/Qm9xmLBB9T+ctDSiiZLF5pgWhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4xx0kgooUmI+f1UB911LOycNit+Z2NsfDcie+NdVUDU1ezpEKqBdl4ZhPlhk8+NRV14m44+/bOmhjoyaks4mzzRJvo7ZaP33YT0GuVMgz/J4GYaeXFgCiM9pHFdpb42ec0AI3Bzxvg4tVK3ggkJDnaUbQecew0Kg+c8wQUJnSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZWWIhYu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZWWIhYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758223307; x=1789759307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lqJ18xE2y3F/YfAM/Qm9xmLBB9T+ctDSiiZLF5pgWhA=;
  b=PZWWIhYunm8rh/NYTjF+2wEHfqksjmVRRBw784gAjVrqtRsirCTtyLmg
   sokjoI7hYPB485BQ7YbCSj+OgrPrCqV7C/bTDZhMiWgZHHLje7Q8rfJVi
   2cSw6rA3lr8kDDJuZR9+xsudgLpL3WFCWmWTkSbJy3WhzjtxfNp3IK5Ui
   BQuz4gY7GIRP+lBbR6LQUmyn7BJDCGHg7IKYPNXDekIspgD0pD8vwp//O
   U9LCDbeagaD7ki2X2fh6/GbN+gDcudoFFlByPW8VBoLcv3AcWGqE0NHRs
   3KfA9XjME+lVD3jPWKhdVvTj+CoFSENDOg9fxqRX31mLfg4xpgRVt7LjQ
   w==;
X-CSE-ConnectionGUID: 801M4g+iQamfGdKYNxdCmA==
X-CSE-MsgGUID: BurhPm8iR7uHsHzAFWE6Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64371019"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64371019"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:21:46 -0700
X-CSE-ConnectionGUID: 6OyAYguYQo6DMoCZmP64tg==
X-CSE-MsgGUID: 0Hi9TU8KSLGA4rO2/of8QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="199342826"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:21:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uzKCK-00000004Avx-2rCM;
	Thu, 18 Sep 2025 22:21:40 +0300
Date: Thu, 18 Sep 2025 22:21:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: dan.j.williams@intel.com
Cc: Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2] cleanup: Fix "unused function" warnings with
 conditional guards
Message-ID: <aMxbxAGjoKWmVXLc@smile.fi.intel.com>
References: <20250904225010.1804783-1-dan.j.williams@intel.com>
 <20250917160644.6f85ca40b1e352fa117dabf9@linux-foundation.org>
 <68cb426324810_10520100fa@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cb426324810_10520100fa@dwillia2-mobl4.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 17, 2025 at 04:21:07PM -0700, dan.j.williams@intel.com wrote:
> Andrew Morton wrote:

[..]

> > > Alternatively just merge the suggestion in [1], and call it a day.
> > > 
> > > Link: http://lore.kernel.org/20250813152142.GP4067720@noisy.programming.kicks-ass.net [1]
> > 
> > lgtm, unless we think this (your) patch improves the code for other reasons?
> 
> The tl;dr above is that the warning could have small value, but probably
> not greater than the overall benefit to Linux to stop bothering folks
> with this low-value warning by default at W=1.
> 
> So I am over the sunk costs, and moving this warning to W=2 is the way
> to go.

Can somebody add a fix so, we have v6.17 able to be built with `make W=1`, please?

-- 
With Best Regards,
Andy Shevchenko


