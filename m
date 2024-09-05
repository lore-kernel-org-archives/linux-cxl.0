Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB3194A61;
	Thu,  5 Sep 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533868; cv=none; b=uSfyNXNTMXUJbiHdhyWk1JpuSmzuspOWDF3bWOsxcrhRG1loWM5nhMS3rlf1FSIO/uvzDjkuWIEjZ0A7riQhznPfHOj6Bney7PawX0U1AHxsGNiLCDLbm+Gr75MMytWStrbAKVeYFDWNomnnNTCOF8B+b8qAhpziQMuoit8e8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533868; c=relaxed/simple;
	bh=DI+sK8/T3gsskf8f7Ss0ayjTN8+mqBY1/Q7agvx86X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf70tMS+94vlcLmU5HKdmCiHKyNy4FK2xPh9rmLgLZ+kMZLWDJW032PFdjzziuAUY23hmD8ogf5pbOBGi9n/oHmu8v6IpaJF1rNTCDkW5I8HVK7ooBs/Mo0V8TFISVgBCxLxGYHCIX4Y5r/r8vH6N1pxv0TNMxpDPoTWgp6CIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzVjFErf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzVjFErf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725533866; x=1757069866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DI+sK8/T3gsskf8f7Ss0ayjTN8+mqBY1/Q7agvx86X0=;
  b=CzVjFErfB4GpE0lvU/NRirGKUji9Wy7aKCPwvk1YfquCnNSoe1YTcq5m
   VWw8QLdypRa1QXXo9BCFyE+ywLIZjM560EjaZ7N2akqu4eS5ppXUFLkrS
   UlTLkOOS630ntk+z5EjyWMdoz+H7WmkrMQ4QiiUWrhKeR00wFSroFfkVV
   29yJmvYSJmmIQtqU27sIQ3+vOtv+jxvqg5/O3nXCiq6qFFw2PDEc27A/O
   QaqLDwM2QWnphwjmjkyer0Bi0AML5928AuAODm+3CpUZ/gMefHo4K8P4w
   4MSpzk5n5AR6ZudSavvx9epKNpLdlcRumdYPyP0SrBx1oaDlqswhH9KtG
   A==;
X-CSE-ConnectionGUID: yt0J0BTpS5i2yO5pVr86xQ==
X-CSE-MsgGUID: X6yOZ28jScyhZC+BB/4FYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="28131155"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="28131155"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 03:57:45 -0700
X-CSE-ConnectionGUID: iNVFaFI9Q3aOkLfmT7/UOg==
X-CSE-MsgGUID: 4r3rc4XZSy67rTi0AfwWzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="66108488"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 03:57:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smABF-00000005Mqd-4BDl;
	Thu, 05 Sep 2024 13:57:37 +0300
Date: Thu, 5 Sep 2024 13:57:37 +0300
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
Message-ID: <ZtmOobWREjR-zusm@smile.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZthWCrUR4VmroXZv@smile.fi.intel.com>
 <87tteu6c01.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tteu6c01.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 11:00:14AM +0800, Huang, Ying wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Wed, Sep 04, 2024 at 03:48:44PM +0800, Huang, Ying wrote:
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> > On Mon, Aug 19, 2024 at 10:34:13AM +0800, Huang Ying wrote:

[snip]

> >> >> +		ostart = max(res.start, p->start);
> >> >> +		oend = min(res.end, p->end);
> >> >
> >> > Isn't a reinvention of resource_intersection()? With that in place you may also
> >> > drop the above resource_overlaps().
> >> 
> >> sizeof(struct resource) == 8 * sizeof(unsigned long)
> >> 
> >> Just want to avoid to define another struct resource on stack.
> >
> > Is it a problem?
> 
> Not a serious problem.  Just prefer to avoid too much stack usage.
> IMHO, the benefit isn't large too.

Benefit is so use existing APIs and see from the code where we handle resources
(in semantic meaning).

-- 
With Best Regards,
Andy Shevchenko


