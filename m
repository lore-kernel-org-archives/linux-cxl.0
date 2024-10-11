Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DF20ADCD;
	Fri, 11 Oct 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645587; cv=none; b=Dab6gp75D9WjZiimJsdOxH4gpYGI6A99hJDW7GavtClFT7y0ypRUmSCeda2U2kFG+2MhLnuqP1wFK29bCQPv3L5SuMh2BtOCzd7cDm983C+ea8qOw0/3Gl6QgS3gb2EaMEx4G5uPm5C4g6GhFNcE19MEvEqcR3LYO5v2ZFMCtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645587; c=relaxed/simple;
	bh=it95fUgt7wvO9ItiFN1pzO9CyA8MDbxEdlRQ+yGcR6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg04Te5iTLrNqYw2sLJ058PPWFoUxbPGA08q5HvE9LC0uLICxAjIzceIhGyDA4FycWbnpKRJXep65bEJEvXZTPKknGFfxYumt582urVHK7Zg2akCS+xVkc6cBQma5bRl1/ydDTwGYQWBZHh0sjqLj0WzOFkAuK2iJc5sgXgYzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSjmNEDp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSjmNEDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728645585; x=1760181585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=it95fUgt7wvO9ItiFN1pzO9CyA8MDbxEdlRQ+yGcR6A=;
  b=HSjmNEDpROId5X0+I1SoeGMvCd/Oe2XSgNCRp9mPJHG+j7i7Ghi00CSO
   zJumSbWPsPszJUPakIKb39E67sMWrFZk96/QF0GDKyuCSb+xyVDDIWIu5
   3/Bytt8z92WAqWyayhXu/jY51HHPsV09S0CsGQ1FUv8EV47bs2yluzWsD
   F/1C5XFV+51h5eySaBEkKZ08NJ762HzCU15l8ZWykz4nZ7VlsV4wasMRb
   YCoVqxFc9v4ZyHthdScJI+vgVe+n6DqK/VwmUqLz9ipTYIgzuNTkxNOYt
   q2azPnehY8PIW3BPThHvilVvlYbk1IOKVTMgEku9USF+SmaWP4ZVByiEd
   Q==;
X-CSE-ConnectionGUID: 5kpCIiKZT0urEtJZL4a02Q==
X-CSE-MsgGUID: 1koRQY6XR8O1agaxBNkUwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31742000"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="31742000"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:19:44 -0700
X-CSE-ConnectionGUID: eCCQEYFeT7O11yPccr82Xg==
X-CSE-MsgGUID: Hu6++5klQVmiU336eoBLJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81403763"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:19:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szDgG-00000001sCk-2cOi;
	Fri, 11 Oct 2024 14:19:36 +0300
Date: Fri, 11 Oct 2024 14:19:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
Message-ID: <ZwkJyMaBnN84Kbg7@smile.fi.intel.com>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
 <b8262026-533b-497b-9713-fa3e32f76d9f@redhat.com>
 <ZwkI62qBAbc02O8C@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkI62qBAbc02O8C@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 02:15:55PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2024 at 12:51:09PM +0200, David Hildenbrand wrote:
> > On 11.10.24 12:49, Andy Shevchenko wrote:
> > > On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
> > > > David Hildenbrand <david@redhat.com> writes:
> > > > > On 10.10.24 08:55, Huang Ying wrote:

...

> > > > > 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
> > > > 
> > > > Yes.  This can improve code readability.
> > > > 
> > > > A possible issue is that "_root" will be evaluated twice in above macro
> > > > definition.  IMO, this should be avoided.
> > > 
> > > Ideally, yes. But how many for_each type of macros you see that really try hard
> > > to achieve that? I believe we shouldn't worry right now about this and rely on
> > > the fact that root is the given variable. Or do you have an example of what you
> > > suggested in the other reply, i.e. where it's an evaluation of the heavy call?
> > > 
> > > > Do you have some idea about
> > > > how to do that?  Something like below?
> > > > 
> > > > #define for_each_resource_XXX(_root, _p)                                \
> > > > 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
> > > > 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
> > > 
> > > This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
> > > solve (see above).
> > 
> > Fully agreed, I didn't quite understand the concern about "evaluation" at
> > first.
> 
> It's a basic concept for macros and a good mine field even for the simple
> cases.
> 
> > If it's just reading a variable twice, it doesn't matter at all right
> > now.
> 
> The problem (even if it's a variable) is that the content of variable can be
> changed when run in non-atomic context, i.e. two evaluations will give two
> different results. Most "simple" for_each macros leave this exercise to the
> caller. That's what I also suggest for now.

For any context as Ying provided an example with calls, they have to be
idempotent, or you definitely get two different pointers for these, which is
bigger issue that what I described above.

-- 
With Best Regards,
Andy Shevchenko


