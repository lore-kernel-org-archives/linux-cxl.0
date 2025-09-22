Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB61B7F4;
	Mon, 22 Sep 2025 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522815; cv=none; b=flpFHGuEl1qBvsbQdFxaoxjJKF/4UxFb/KdYn+AeXc9PhpRN9YV6iEZomSU5KE7Ir4qRI5FLdshQSgA9+HiWvJiwXLFZP4Cko8WdRMUrQOpkP7gpoOYCYgeHEYQPztJDEhxkOHEcKG8ElKEaYsFgoengxiIQSpzADR53oO42K+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522815; c=relaxed/simple;
	bh=sO5MYBAEqWj1V2fWw+P0t+oUcFAL/oDWEiiyz4OrOf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWKZLQ9pcXKfxxQXE+xMn/Uh40uLpHPw+haw4JrGAGT+b8KVF4y7fENU5N1crZpaAdUeO/MsqQvq7oGvYpJgFhIuJpRF0RonMLUokE0OafbwBHI2fRVQWlaRKA3a9TV4cb84EEW6jhXmP0FAfAlfwh0Begw8PDw3VR83b3ObiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9gKUNPy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9gKUNPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758522815; x=1790058815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sO5MYBAEqWj1V2fWw+P0t+oUcFAL/oDWEiiyz4OrOf0=;
  b=j9gKUNPyIEtX5p9UpoeK/IaCr86EXMMpL2uM/9oXcQha9L7clk5qTdC1
   FJx9vYKs5X+eLpQZmyEzbmViDs/J7KPhzYjxVDkoKAr996LMl6UcWE5RP
   5eXKOBogsjVsCSD6BYJD4cmvttUm0g89wQCtj3BsbnjA9B4q8PyagFyno
   nszC/26T2Egwkr25n7I+WOw0gO71Bm5xtMHKqVgfk+Xl3w33jqs+DqujD
   jdy0QnvVs52ufYla8Em/ztgrrQW3KfyqmxhdLrS3clUBAE/iCNYDJGnPo
   +yXZirhPp3pNSLmioN6zxV2etrHe3M3KTNDlhe5A5i1yZZq6+/wRgDQrO
   A==;
X-CSE-ConnectionGUID: Agj8aT5iR3afehhwy03BqQ==
X-CSE-MsgGUID: JeuuHhisRv6PAQnIwPytKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64581798"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64581798"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 23:33:34 -0700
X-CSE-ConnectionGUID: LnH95Ob/TLqkO/y+tT8uVg==
X-CSE-MsgGUID: iYc4ajoxRhOOeTmfcGDHBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="181542596"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 23:33:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1v0a76-000000052fC-1guP;
	Mon, 22 Sep 2025 09:33:28 +0300
Date: Mon, 22 Sep 2025 09:33:28 +0300
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
Message-ID: <aNDtuF13zW8R_fkx@smile.fi.intel.com>
References: <20250904225010.1804783-1-dan.j.williams@intel.com>
 <20250917160644.6f85ca40b1e352fa117dabf9@linux-foundation.org>
 <68cb426324810_10520100fa@dwillia2-mobl4.notmuch>
 <aMxbxAGjoKWmVXLc@smile.fi.intel.com>
 <68cc5ce459c93_2dc0100e4@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cc5ce459c93_2dc0100e4@dwillia2-mobl4.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 18, 2025 at 12:26:28PM -0700, dan.j.williams@intel.com wrote:
> Andy Shevchenko wrote:
> > On Wed, Sep 17, 2025 at 04:21:07PM -0700, dan.j.williams@intel.com wrote:
> > > Andrew Morton wrote:

[..]

> > > > > Alternatively just merge the suggestion in [1], and call it a day.
> > > > > 
> > > > > Link: http://lore.kernel.org/20250813152142.GP4067720@noisy.programming.kicks-ass.net [1]
> > > > 
> > > > lgtm, unless we think this (your) patch improves the code for other reasons?
> > > 
> > > The tl;dr above is that the warning could have small value, but probably
> > > not greater than the overall benefit to Linux to stop bothering folks
> > > with this low-value warning by default at W=1.
> > > 
> > > So I am over the sunk costs, and moving this warning to W=2 is the way
> > > to go.
> > 
> > Can somebody add a fix so, we have v6.17 able to be built with `make W=1`, please?
> 
> Andy, might you have time to take Peter's proposed diff and wrap it with
> a changelog for Andrew to pull?

I will try my best, thanks!


-- 
With Best Regards,
Andy Shevchenko


