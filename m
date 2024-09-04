Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADDF1E519;
	Wed,  4 Sep 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453844; cv=none; b=KKlB5FEESZYdf4UjNUsNbDUAusCGMxzUQhZiHBy8esStrmjamPVWBb/j5UUM48KEzfXV1k8eoPPfPtz08Q2fAqMfrG9xHAC2I5yX1WFURr3JTOh9VnDyJqz7aLdmmLIHCcufWb4VeHz3jClm1ORcxEqgoW2L7awPg1QEzwIxx9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453844; c=relaxed/simple;
	bh=tJGTLcktLd7tavZHRdOlm61GQ0ma4cOPb2sKQtEiXps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMQKlXPv9Q0lfxKuqJaIzgaNZu+nF4IJMtdT7VfT7yFMIMgMr98mOK+Y2pwpUX6xe9tNaUsdyyvuFqiR4AsszNeWsFB0DiSmtpt2h+0ROSinvODHyxHM0Dn+/TBPIao4kRonoxkDWK1CEfjAHA0oukWrnma4p6r3e46rK+A+rTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSILlcXN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSILlcXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725453842; x=1756989842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tJGTLcktLd7tavZHRdOlm61GQ0ma4cOPb2sKQtEiXps=;
  b=PSILlcXN1cu27WrHCmUB7LJnVhh20tGqLYCCueD4W7ybvkMlxF5J8wYZ
   nPdFzXFHQ+EU2z1/ljh6REGrCi2ehSEHLPkvRK3XKAzFMLeT5ESFmUbNN
   9mlrrZ0iAihUjhBmWKfFgbmAdJZz0h2nxRNH6NUSPeKNJiMTmhV2R+vDH
   e4zcewlbeIV+Myr4NNZDxZPpjSX8YSClkelss1PofGFQTeovQc9V5aCvE
   ADUZYACpueOYmcQUy+T5R9/kAtl/Feukm6aEiJLuVoFvM5UTqMFLmvsdr
   2y8RfBoF2cOd7P+Hr2tm++9ibr0z10TZl6WV/d5BXDBH7tdsb9LvPo9qp
   g==;
X-CSE-ConnectionGUID: SbgpTQAFR4GSuuP3JBmtSA==
X-CSE-MsgGUID: enrxvbL1RTa9wnGs5U9MUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="13368171"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="13368171"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:44:02 -0700
X-CSE-ConnectionGUID: mBEWJLO1SHa3KbIefr81zQ==
X-CSE-MsgGUID: vnGnocvRStC/I5gMTVre5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="70069854"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:43:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slpMY-000000053xj-3rwX;
	Wed, 04 Sep 2024 15:43:54 +0300
Date: Wed, 4 Sep 2024 15:43:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <ZthWCrUR4VmroXZv@smile.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 04, 2024 at 03:48:44PM +0800, Huang, Ying wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Mon, Aug 19, 2024 at 10:34:13AM +0800, Huang Ying wrote:

...

> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Davidlohr Bueso <dave@stgolabs.net>
> >> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> >> Cc: Dave Jiang <dave.jiang@intel.com>
> >> Cc: Alison Schofield <alison.schofield@intel.com>
> >> Cc: Vishal Verma <vishal.l.verma@intel.com>
> >> Cc: Ira Weiny <ira.weiny@intel.com>
> >> Cc: Alistair Popple <apopple@nvidia.com>
> >> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Baoquan He <bhe@redhat.com>
> >
> > You may move Cc list after '---', so it won't unnecessarily pollute the commit
> > message.
> 
> Emm... It appears that it's a common practice to include "Cc" in the
> commit log.

For what benefit? (Note, nowadays we have lore.kernel.org which is under
the control of Linux kernel project)

Personally I see only downsides of these being inside the commit message.

Here is a discussion about this
https://lore.kernel.org/linux-doc/20240423132024.2368662-1-andriy.shevchenko@linux.intel.com/

...

> >> +		ostart = max(res.start, p->start);
> >> +		oend = min(res.end, p->end);
> >
> > Isn't a reinvention of resource_intersection()? With that in place you may also
> > drop the above resource_overlaps().
> 
> sizeof(struct resource) == 8 * sizeof(unsigned long)
> 
> Just want to avoid to define another struct resource on stack.

Is it a problem?

-- 
With Best Regards,
Andy Shevchenko


