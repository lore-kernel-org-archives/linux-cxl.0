Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F58199FA7;
	Thu,  5 Sep 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539791; cv=none; b=dMMje34JGdX5zjWPEG+AthWajgpz2ElHcvTbd+a7DfCm2Ma+U4tns5CRbCwgSGd87oE518MSCvQAK99//DSKiGlAgZLocz3e8PTNUzybuiv1nXw8ZWYCFlz7Ieno8HJRzr4oWEDEd1Tq911X06wL1fAv3iwiaRB1GLfbBaELesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539791; c=relaxed/simple;
	bh=tUOAOd8CYkdJjqbj7ss21WuFdmdRdcvBFxMicTiHizk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu0MvWmulKGVXnHSOxlNAqK9q6R9VUmuKIfbQp3UMtbALNOy6Mqto9iw2pVW396QsgPNvI9OvV1bKgeuMqA0hTSIzgViTZ2Ok51H0OH9ycFjsn2KIo46og7NzqBt0PC15cYjYOwtP2AcLFCYWkcPosroUIB339cqPBG2aEA6Xzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlCvcIV0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlCvcIV0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725539790; x=1757075790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tUOAOd8CYkdJjqbj7ss21WuFdmdRdcvBFxMicTiHizk=;
  b=MlCvcIV0Tjl+njME49M0Qc9bYqMo0Gq7Zope5T5gHeUpWmm5esUVxRjp
   oCiIirIh4hfZFrv1EDyqMDcAaOhb0NxiDpjG9oYMk6uYZVJrHIZtCzir6
   siXITdVpTax286aSqm5BrYfKrqDy4TQ8Yo+t9d3HG4feb8exRvdC/TYi4
   DSfh/hWC+LiQ6o/VfL1+uANI8+51GPbznWWgjC9gRm2Gnes5JY9UW4EZv
   ijmKJgA1GgyK3MaNoO9WY9UP9hDfTBTPgdTepj/rXsPW2YZCSELLsY/uF
   VRY6sl0wgBk32aZWznHgWoMxLXmIxs92I7AR5Z/np1E6w/rbHy6r8xZvJ
   A==;
X-CSE-ConnectionGUID: 3gA+D5oiTVi+Zu0h4kba/w==
X-CSE-MsgGUID: aaQVbrtaR0mbfhAO6sA9hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27173405"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="27173405"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:36:29 -0700
X-CSE-ConnectionGUID: Exg24nuaSxatVWhPMsTnaQ==
X-CSE-MsgGUID: 6GCVJ3eWRzqlJgZaX2z7Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70408882"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:36:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smBim-00000005OTQ-0x57;
	Thu, 05 Sep 2024 15:36:20 +0300
Date: Thu, 5 Sep 2024 15:36:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <Ztmlw1q3Djn94MRQ@smile.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <65838cc0-9a20-4994-a0ef-9cd50bb00951@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65838cc0-9a20-4994-a0ef-9cd50bb00951@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 01:08:35PM +0200, David Hildenbrand wrote:
> On 05.09.24 12:56, Andy Shevchenko wrote:
> > On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
> > > Huang, Ying wrote:
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

[..]

> > > > > You may move Cc list after '---', so it won't unnecessarily pollute the commit
> > > > > message.
> > > > 
> > > > Emm... It appears that it's a common practice to include "Cc" in the
> > > > commit log.
> > > 
> > > Yes, just ignore this feedback, it goes against common practice. Cc list
> > > as is looks sane to me.
> > 
> > It seems nobody can give technical arguments why it's better than just keeping
> > them outside of the commit message. Mantra "common practice" nowadays is
> > questionable.
> 
> Just look at how patches look like in the git tree that Andrew picks up.
> (IIRC, he adds a bunch of CCs himself that are not even part of the original
> patch).

I know that and it's historical, he has a lot of the scripts that work and when
he moved to the Git it was another long story. Now you even can see how he uses
Git in his quilt approach. So, it's an exceptional and not usual workflow, hence
bad example. Try again :-)

> Having in the git tree who was actually involved/CCed can be quite valuable.
> More helpful than get_maintainers.pl sometimes.

First of all, there is no guarantee they _were_ involved. From this perspective
having Link: tag instead has much more value and supports my side of arguments.

Anything else?

-- 
With Best Regards,
Andy Shevchenko


