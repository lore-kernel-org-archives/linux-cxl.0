Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781B5338D;
	Mon,  7 Oct 2024 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310850; cv=none; b=VL/ALkG/rSZWD0Sv7g5deRHUlAde09oHFu3673EzySsDlPMXxS8u+Le1y7NAHgM2zzfKvLuKdKXo6yGB8UXG0kNHNos6GOJ3zKLCQXwTgA4y6uyP4xZxX70ysRLrNj3SdfwfU9TV8zoEuaX+xoqLbK+7/n+ICwNJLY0HuOcFtJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310850; c=relaxed/simple;
	bh=zpVx4NcO+FvNMmwInSSBP2llHiiEZi7422EEP8tONds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6cYpeSnGgIVZlFSUlBomKy6D0wVoQ+01l8CiX+0qTTims5qdhvEFTHcnS96o/tqQRvy1ca5LhOVUusn3/XTuboNOrpCZgNHCPfbmFZdkEedUcwln67Vggtq8X1lBg7VO689GobQiZ7Zsok0lS7r2MvmwWrrk/Hng3cDumUjKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hc4VT7NQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hc4VT7NQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728310849; x=1759846849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpVx4NcO+FvNMmwInSSBP2llHiiEZi7422EEP8tONds=;
  b=hc4VT7NQtcYCZBDh+0EYQOcQl7R5yNBBVb3mCPApp39t8tu/x7fDWGFD
   XoLlwCU/rmnUQcTq5WPS515Nzsy2xupZQI7P9eANrrloDL33f1bv3ndqg
   YihfkRizxlSE5KHj6CUcwYNRgaJ04xQqjB/FBOQ7ZDQplyqAAqUtFnJjG
   Vm7uG7FmvbBiPvGGCMMyGAokvtKFm4hun1p9BnIls0rX+A1FzUl+B/f1A
   U4kvaqrxdio0vI2lQZ1NZusu8jb33wfzIlGVoQvH8vQqCVqAW6TvwhA71
   sU5qzRH8T6Ne4aI4DUor5t4UK1vqygsZKiRRBr1ZjAh+/JKu5LQWRjsn8
   g==;
X-CSE-ConnectionGUID: zvYiRAVwQlSeXdrgE2bWXg==
X-CSE-MsgGUID: en02MRB0TQ6Ur1L096crJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38118650"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38118650"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:16:37 -0700
X-CSE-ConnectionGUID: tMxxieRtTOu1eIukJFqVAQ==
X-CSE-MsgGUID: EPQots9qQ7SVdTQRLByrJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="79479075"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:16:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sxoXG-00000000Ewb-18FR;
	Mon, 07 Oct 2024 17:16:30 +0300
Date: Mon, 7 Oct 2024 17:16:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
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
Message-ID: <ZwPtPpKk8SdbXS9h@smile.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <66da24827b2a9_22a2294b3@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66da24827b2a9_22a2294b3@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 02:37:06PM -0700, Dan Williams wrote:
> Andy Shevchenko wrote:
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
> Yes, question asked and answered. Not to your satisfaction, but the
> people that have engaged to date have been cold to the idea.

It's just matter if we care or not (about the environment, about performance
in reviewing the code, about people who might use small screens or smartphones
for reading the changes, et cetera). Even status quo should be questioned from
time to time.

> Historically, reaching into other kernel developers workflows to
> instantiate a new preference is a high risk low reward endeavor, please
> moderate your advocacy accordingly.

Yeah, I got it...

-- 
With Best Regards,
Andy Shevchenko


