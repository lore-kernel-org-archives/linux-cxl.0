Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED41D363A;
	Mon,  7 Oct 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310380; cv=none; b=Q44xERFMvOpB4ZvyK+DIICZpzFFeImUkVdgJC3WemaZsloK+/7wlWcabXwvB6o7TC33nZrHnTM80DgpXzM5ycuo8Prb/MJ1F5kbx2zOQ9qy9uXDmuf+AXCFAmWGRHTfF9ZY/CuiJocp42pncWxI4yuKPaIFOMqli7S3nFkYU7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310380; c=relaxed/simple;
	bh=bAcQDD+8QQ8WCDszEzop3lIKjgTMQY4AjD6eofNySgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw+NVfCeRe5ym547c/VurtYJEwlqDZar0sJaIEFalLFYrbz7Rnvht1CpQ0j4RlF2Ln9pJ7P6x3GZJfOxo6Ac5ZKGI+/SIvC1qysb3svn45zgtI5K84ZsxXtznppqUv6aXnHn7NTNdVtlaCN9g+WkGLGFpKo7mLdCc5puXwgAK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJbZC9m6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJbZC9m6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728310379; x=1759846379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bAcQDD+8QQ8WCDszEzop3lIKjgTMQY4AjD6eofNySgk=;
  b=kJbZC9m6n21z767tm0Ix24r0p4yrLU7UahcMs7tm/Jblu5mFfYKVeJ3o
   wfiFG3mvHSNH+65Ah43y34xyYPJU6hS7eBuL054CWNndBu1Qo4XNJ7s8Y
   Y9eFmUkuoAmZIbAF4NmQMdK3EJjoHWZapYE36LeLAwj5cfS78WRNsRymO
   5cIL4OBO2Sqh/RklY4r3iiRwNklzkYrzrj3YpdSrIXN+3Bk8eKUgL3MeF
   sriU55S7a8e2UDPJzPV78wFzcudMXcz6xdiiqTQa3sOiox07Jr7tuNEzp
   Syp+onZw8RPOq6HQOP+0nw2RUZjdmRUe9W9vaWROKywJvRFJtNcajW5u+
   g==;
X-CSE-ConnectionGUID: 8RGFhfexSBO+GCjVR/Tohg==
X-CSE-MsgGUID: D0h5lTiUQB6YyJAPfF4oew==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27629741"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27629741"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:12:58 -0700
X-CSE-ConnectionGUID: uCD1Sb3ASam3hRd5L6XWYQ==
X-CSE-MsgGUID: OhhnmWqtRYqYbudghm2VCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75844023"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:12:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sxoTj-00000000Esa-0jwK;
	Mon, 07 Oct 2024 17:12:51 +0300
Date: Mon, 7 Oct 2024 17:12:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
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
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	Philip Li <philip.li@intel.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <ZwPsYqkLF0eWUb9e@smile.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <87v7z91teq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7z91teq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 06, 2024 at 09:07:41AM +0800, Huang, Ying wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
> >> Huang, Ying wrote:
> >> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

[..]

> >> > > You may move Cc list after '---', so it won't unnecessarily pollute the commit
> >> > > message.
> >> > 
> >> > Emm... It appears that it's a common practice to include "Cc" in the
> >> > commit log.
> >> 
> >> Yes, just ignore this feedback, it goes against common practice. Cc list
> >> as is looks sane to me.
> >
> > It seems nobody can give technical arguments why it's better than just keeping
> > them outside of the commit message. Mantra "common practice" nowadays is
> > questionable.
> 
> Cc list is used by 0day test robot to notify relevant developers and
> maintainers in addition to the author when reporting regressions.  That
> is helpful information.

I'm not objecting Cc email tags, I'm objecting having them in the commit messages!
Can you explain, how useful they are when they are placed as part of commit message
bodies?

-- 
With Best Regards,
Andy Shevchenko


