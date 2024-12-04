Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068402CA9;
	Wed,  4 Dec 2024 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281274; cv=none; b=llBIG3Cd2WMsaM284kjMwcuDbHH3sjEt60miXbghGhoOd7qZoNeY06ZMlNQnhY5eCV7f8IMPbiPcbO9a1j0n9exFCVQqM8LbkS95QVfjiZ0gWmWsgfHmhPGmV9fYjLLNZNxje5bcRJ+dxSITPMUKwoqPKd6Nq4+cw9J9nrrlzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281274; c=relaxed/simple;
	bh=QWOyW0RSuqhTNUZgpIyrrKeMl0sjLC/tNnJLur0kPaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+iX/xzDffWGoC7U90FaX5fzsX083NnOnHVbePxUgMEu7OPl1MDT52BirfgnMFlGjJewvV8Pua5M4WfIYiyCl2nmiDzM71y3HYFkqzmCXpiq7KJrUqrLiW8a4yKmkhtJUJPrYBUnz8UCEh7dC1HAAiK8Et+wDldbwqCZqtRZw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sn9/+nHG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn9/+nHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733281273; x=1764817273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QWOyW0RSuqhTNUZgpIyrrKeMl0sjLC/tNnJLur0kPaY=;
  b=Sn9/+nHG1Ae42qDOmu5qvfBPduJdccqvnXBu2RC0RUEoS23DYEQ0+oIB
   Oo5E3bH2/pRCT4H11IgZURYdRV0hnApQa7Y1zouMCgWEVUawFwstHUmAo
   cMplcXep7HcU7G99/Tl8x2vEEJ0vFnvGojjZBzn/2uYhthN0QJ7HvU3Vs
   yZ8T1zqKgo/ujFyWWgWLnhcyZuvrxRLdM2ZvZ1ZMGSkXEUgo9/7aEYSSF
   FnbcBxrvNlggxP+D0HHv4t38lxph970rMWhf6dU84Ei4ggvIsfeAOqeNF
   4dkelkJDxeFz4CLLCL580/5nc0tJD8HKsdr1oWGzvrEKkgbTPT7alWlQA
   A==;
X-CSE-ConnectionGUID: DMP5c/hMQaeVRPQW/aMklg==
X-CSE-MsgGUID: K7gIEnYITTyNrNPMG7v9Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33451401"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33451401"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:01:12 -0800
X-CSE-ConnectionGUID: NwlLOQ4zQyuoS95H/H3L3A==
X-CSE-MsgGUID: nKLzkpWsQSe2kjo+Jcmvbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="124459102"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:01:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIfdQ-00000003cpL-1Rrx;
	Wed, 04 Dec 2024 05:01:04 +0200
Date: Wed, 4 Dec 2024 05:01:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Raghavendra K T <raghavendra.kt@amd.com>, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, bharata@amd.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	ilpo.jarvinen@linux.intel.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Fontenot Nathan <Nathan.Fontenot@amd.com>,
	Wei Huang <wei.huang2@amd.com>
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
Message-ID: <Z0_F8EuGpxPPytFM@smile.fi.intel.com>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <87frn5wac3.fsf@DESKTOP-5N7EMDA>
 <Z08KiPwwiw72Vo9R@smile.fi.intel.com>
 <87iks06w17.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iks06w17.fsf@DESKTOP-5N7EMDA>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 04, 2024 at 10:07:16AM +0800, Huang, Ying wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Tue, Dec 03, 2024 at 02:26:52PM +0800, Huang, Ying wrote:
> >> Raghavendra K T <raghavendra.kt@amd.com> writes:

...

> >> > git bisect had led to below commit
> >> > Fixes: b4afe4183ec7 ("resource: fix region_intersects() vs add_memory_driver_managed()")
> >> 
> >> This breaks you case, sorry about that.  But this also fixed a real bug
> >> too.  So, it's not appropriate just to revert it blindly.
> >
> > Linus was clear about this recently. Even if it fixes a bug, regression is
> > still regression and might (*) lead to a revert.
> > https://lwn.net/Articles/990599/
> >
> > (*) in general fixes are better than reverts, but depends on the timing in
> >     the release cycle the revert may be the only option.
> 
> I don't think that the timing is so tight that we should not work on
> proper fix firstly.  I'm trying to work with the reporter on this.

I agree on this, please do.

> BTW, the commit b4afe4183ec7 ("resource: fix region_intersects() vs
> add_memory_driver_managed()") fixed a security related bug.  The bug
> weakened the protection to prevent users read/write system memory via
> /dev/mem.  So, IMO, we need to be more careful about this.

My point was that the regression is obvious and it needs to be fixed.
That's all. Revert is a last resort in this sense.

-- 
With Best Regards,
Andy Shevchenko


