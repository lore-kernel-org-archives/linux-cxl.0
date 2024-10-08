Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C279237708;
	Tue,  8 Oct 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406893; cv=none; b=Y1T+Mvt01LsxLw0Ep8LnNSFxTsew3SVIbw/ygW8UavClA7zyufsD9JcprqZTaZcHFdZfg9AeRwg35YopW7qoWwUT2CFteMm6d8FY2T/N7aD+zOvxRTNNU/sLf0z31iIgyrnagReejtPZAjUrE2Ina03gjGxhJiG/H83jXTxt4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406893; c=relaxed/simple;
	bh=7yDX3p5l4AOgfdAig7iHKghNGgGyy6V+GbZVWH6Nah0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZqObrxMzvTNpEE+/mu+LsDLnFQF9VAoJW56MZv0Iiad43Mev/GEzKB5p71L45bAzD9VY7F5N+NmqvG0kMZf6bQd69HItRFnrrlyfl2qUH598fbT5klL/FeeLpn0/ZuQZ4JvbZmogXgtsZ4UiaPCZc90I89UimE66UacQ78yWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhzzDFbU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhzzDFbU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728406892; x=1759942892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7yDX3p5l4AOgfdAig7iHKghNGgGyy6V+GbZVWH6Nah0=;
  b=HhzzDFbU4r9Zzjc9VlLdY3ZWwK9nXM0chO9CEHDo8c+VYN5/1fAnaPcj
   b3auopn+nFBzneVvcgUaDM/nGc8Ss5s/b5SfmYLCc5Uquh6g96b0N9RcH
   4rEZSKYAHty0IyhoSZ4bZloxUmEpXZH1rdLPTJ721ys5vVx3zgna+Sl4R
   +KMvx9SLu0XcTu34gdV7tHE8QJ9EpTotURBSWDWXlLMAYdf+9FX6r+iSu
   ydyZ9MRNTuMeb7jckuxaEGkksV5SoeAMXKFm9bNo5u75jvHO49BFewrou
   ftU9Vn/8Nn3Sl0Pnl9KLbebUlGJOk9dSedcTQV5yWIjyqrADFLUC2o+PA
   A==;
X-CSE-ConnectionGUID: Ithb/VPLS0WjUv/d++o23A==
X-CSE-MsgGUID: 1knjyHwzT6q6rso/8Q4heA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27574513"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27574513"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:01:31 -0700
X-CSE-ConnectionGUID: otqcIQWJTfm9wfBUFR+WKA==
X-CSE-MsgGUID: OIYtR1NlR0SJCumSBlYHUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="99244245"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 08 Oct 2024 10:01:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D7F8220F; Tue, 08 Oct 2024 20:01:25 +0300 (EEST)
Date: Tue, 8 Oct 2024 20:01:25 +0300
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
Message-ID: <ZwVlZROV84DDMCnc@black.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <87v7z91teq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwPsYqkLF0eWUb9e@smile.fi.intel.com>
 <871q0rnw6n.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q0rnw6n.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 08, 2024 at 10:52:00AM +0800, Huang, Ying wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Fri, Sep 06, 2024 at 09:07:41AM +0800, Huang, Ying wrote:
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> > On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
> >> >> Huang, Ying wrote:
> >> >> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

[..]

> >> >> > > You may move Cc list after '---', so it won't unnecessarily pollute the commit
> >> >> > > message.
> >> >> > 
> >> >> > Emm... It appears that it's a common practice to include "Cc" in the
> >> >> > commit log.
> >> >> 
> >> >> Yes, just ignore this feedback, it goes against common practice. Cc list
> >> >> as is looks sane to me.
> >> >
> >> > It seems nobody can give technical arguments why it's better than just keeping
> >> > them outside of the commit message. Mantra "common practice" nowadays is
> >> > questionable.
> >> 
> >> Cc list is used by 0day test robot to notify relevant developers and
> >> maintainers in addition to the author when reporting regressions.  That
> >> is helpful information.
> >
> > I'm not objecting Cc email tags, I'm objecting having them in the commit messages!
> > Can you explain, how useful they are when they are placed as part of commit message
> > bodies?
> 
> The result of regression bisection is the first bad commit.  Where we
> use the Cc list in commit message to help find out whom we should send
> the report email to.

We have all tags and MAINTAINERS database. How do you know if those who
are in the Cc list are really interested in receiving this? What make me
sure is to have Author of the culprit commit, relevant mailing list and
maintainers, also reviewers and testers, if any. All this information is
available without Cc list. But if you *really* want it, you should
follow the Link tag (for the new commits, for the past ~2+ years) and
harvest it there. And actually I use that Link to reply to the thread
directly. So, again, the Cc list in the commit message is a historical
burden that consumes a lot of time and energy and should be gone in the
future.

-- 
With Best Regards,
Andy Shevchenko


