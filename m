Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A31E5720;
	Fri, 11 Oct 2024 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645363; cv=none; b=RSB4goUaMcqw+7jgDHEju0xZuf7vIcid7bnfK6LhMAhGIMDY9zMqYZuHk7cnO9b1TlktF6l4/oZFYjzk6l32bo3Z1iXfhkJUzWcECmynZtQnPextO/ne2PwTRr5mGgaH31ZechtOYZX5XTW+DT0EU2w+Usc6i7/WRyuQoid0diA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645363; c=relaxed/simple;
	bh=WHc863Te71zd6D6prIfqp6EVVtJ/33OJMkMFg8NmTzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtGI5StlFCC0Q0ZlZgvGYNjqCFxCvDkHK3AWgremM8M33ADajfotaFTfh9CsJlbw6fjVo6jlU9pscAB2cvM9gi25mt07BdumVbIh8MVS3kVdTb/kNcRrwT3eG6WnLT6JJZyJYXGini9Tp2anRTX2OsVicOCTdQ80Ta03WfjUnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnBC8Yrb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnBC8Yrb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728645363; x=1760181363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WHc863Te71zd6D6prIfqp6EVVtJ/33OJMkMFg8NmTzI=;
  b=BnBC8YrbLSMc0CySlfWkm0+otrBttHnvj2TTm9+73t9iE1s7lIuFaE9x
   1O0ekUZ0FXYPHgxS15Frce0gPqKtIfmOWGgmoXaG22/nKfLheBQNg63TJ
   7VdvXOFNiMpxgGAbXIdQ8ybH7Y5+d5KWfcIzoh2f9de8oLAvhE4ZlxckD
   pWLHdVXFcwI9gS6/dOnRAKguefdgBxn3Fmjie/OcvQW8kG/5ETp4jdQO+
   fKT2FIdumjdHNYBaLZo/25nARbz06GpJT+HXcHLDFDiQ4qcWn6aawwL8m
   U44FTj7AGwJML3SbLgxlYYsW9KWq7kquqCGmpV9ckkeVBLI4YRuxcNL8u
   Q==;
X-CSE-ConnectionGUID: RgHzts7mRlaTaH7lXjG56g==
X-CSE-MsgGUID: A7Q+V+nPQOmwmdU+F3RKLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39435471"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="39435471"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:16:02 -0700
X-CSE-ConnectionGUID: ThwDaXjUT7S9dbQ7mrq1iQ==
X-CSE-MsgGUID: /VF7qMAARhS82qredpx+aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="114342236"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:15:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szDch-00000001s9N-1xEK;
	Fri, 11 Oct 2024 14:15:55 +0300
Date: Fri, 11 Oct 2024 14:15:55 +0300
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
Message-ID: <ZwkI62qBAbc02O8C@smile.fi.intel.com>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
 <b8262026-533b-497b-9713-fa3e32f76d9f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8262026-533b-497b-9713-fa3e32f76d9f@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 12:51:09PM +0200, David Hildenbrand wrote:
> On 11.10.24 12:49, Andy Shevchenko wrote:
> > On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
> > > David Hildenbrand <david@redhat.com> writes:
> > > > On 10.10.24 08:55, Huang Ying wrote:

...

> > > > 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
> > > 
> > > Yes.  This can improve code readability.
> > > 
> > > A possible issue is that "_root" will be evaluated twice in above macro
> > > definition.  IMO, this should be avoided.
> > 
> > Ideally, yes. But how many for_each type of macros you see that really try hard
> > to achieve that? I believe we shouldn't worry right now about this and rely on
> > the fact that root is the given variable. Or do you have an example of what you
> > suggested in the other reply, i.e. where it's an evaluation of the heavy call?
> > 
> > > Do you have some idea about
> > > how to do that?  Something like below?
> > > 
> > > #define for_each_resource_XXX(_root, _p)                                \
> > > 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
> > > 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
> > 
> > This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
> > solve (see above).
> 
> Fully agreed, I didn't quite understand the concern about "evaluation" at
> first.

It's a basic concept for macros and a good mine field even for the simple
cases.

> If it's just reading a variable twice, it doesn't matter at all right
> now.

The problem (even if it's a variable) is that the content of variable can be
changed when run in non-atomic context, i.e. two evaluations will give two
different results. Most "simple" for_each macros leave this exercise to the
caller. That's what I also suggest for now.

-- 
With Best Regards,
Andy Shevchenko


