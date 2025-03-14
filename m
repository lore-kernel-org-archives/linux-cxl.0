Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB941FCFE3
	for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963466; cv=none; b=dwf2P3s6VwPOcLrYjRlKTU6aGjimorGvrgBufPk/WlzHhUwAJo77Ysqd1bxregp3VpH7f3rxspZZj9EaIicH5wPJAeNHHwSkFdL9CnKBvTwxVhqhck4Za+aY8XEJ2vt6ZftNOnZYmbnPUQQThgCp9j15TWmrv9QAamGWwBvPgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963466; c=relaxed/simple;
	bh=vzG51rFcm5EamKilCTzfA0KJqwuhT+EdYpY0LGde4cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSDCBJkRwYUOyfDOVmx0c5Cq5hIFClgDfog30LzugukPokB8GVGPut4IjoCYa47WVrNnVV2Lqp8SCvamDh0fQsaMUrvs+M9Af6ASntN1fjWMyrWG7bXc0ZUNumHSnQfF/4/05Y/Q7KTeYnNeBgJGWBH8HSpqvmFg4RkIuGWvDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCxbQgGv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCxbQgGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741963464; x=1773499464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vzG51rFcm5EamKilCTzfA0KJqwuhT+EdYpY0LGde4cs=;
  b=VCxbQgGv7TOgcDFHCDkLwRaD7HQZtSspxLDaQ/7iVlj9SuOOckr5q7dW
   MjjLo4Zp9JMCmQLEUKmzVlRF8UTeqsyPGeXrHg4zd5LGCQLXLMFF3DulJ
   Hsae54pTA2JjH6sFxzLNkxtHgq5j6vM9zl3x6CYh24AT/q0o5qkKcc2h1
   yqclAAyT8htHzCMTt/k91li8rTJLg/CBKx3gjOE5v0AWRpE2NCJWF8sBq
   AEROkXpzIjfMCyzV7SEEKRBBhfuW2c3rfLoaECn/xBNYqzraiIlumyyFL
   Ytbc1S7A1TFxen0Bv4woNYMqMC42VJute4nq5UbHDDUK9Ro6T99jvPX4/
   w==;
X-CSE-ConnectionGUID: OKkXxCwiR/q40QUW4XaWXQ==
X-CSE-MsgGUID: 7YJ1ZjjXQGa0fVArYsh1yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42846139"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42846139"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:44:23 -0700
X-CSE-ConnectionGUID: 85JZLnFqSPaMWGMPiYapfA==
X-CSE-MsgGUID: U3jPBaRcR0OY12scIGW8Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121804517"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:44:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tt6Go-00000002UH8-2R4T;
	Fri, 14 Mar 2025 16:44:18 +0200
Date: Fri, 14 Mar 2025 16:44:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org,
	Li Zhijian <lizhijian@fujitsu.com>, linux-cxl@vger.kernel.org,
	mika.westerberg@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com, huang.ying.caritas@gmail.com
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Message-ID: <Z9RAwm7zNZ796z1a@smile.fi.intel.com>
References: <174114125011.1367354.2670882864492961789.stgit@dwillia2-xfh.jf.intel.com>
 <20250314114901.00000b99@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314114901.00000b99@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 14, 2025 at 11:49:01AM +0000, Jonathan Cameron wrote:
> On Tue, 04 Mar 2025 18:22:53 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:

...

> > +	struct region_devres *dr __free(kfree) = NULL;
> > +	struct resource *res;
> > +
> 	Avoid split of the constructor / destructor with a ternary though
> 	error check is worse... Hmm.
> 
> 	struct region_devres *dr __free(kfree) =
> 		dev ? devres_alloc(devm_region_release, sizeof(*dr), GFP_KERNEL) : NULL;
> 	if (dev && !dr)
> 		return ERR_PTR(-ENOMEM);
> 
> So on balance up to you,

I'm against ternary, it looks unreadable in this case.

...

> but at very least put that __free(kfree) direclty
> above the set.

This I am neutral about. Any thing works for me.

The rest you suggested is +1 from me.

> > +	if (dev) {
> > +		dr = devres_alloc(devm_region_release,
> > +				  sizeof(struct region_devres), GFP_KERNEL);
> > +		if (!dr)
> > +			return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	res = __get_free_mem_region(base, size, align, name, desc, flags);
> > +
> Probably no blank line here would be nicer.
> 
> > +	if (IS_ERR(res) || !dr)
> 
> This conflates error and don't care if error cases and briefly
> made me scratch my head.
> 
> Maybe though it increase indent don't do early
> return on the !dr case.
> 
> 	if (IS_ERR(res))
> 		return res;
> 
> 	if (dr) {
> 		dr->parent = base;
> 
> 		...
> 
> 	}
> 
> 	return res;
> 
> > +		return res;
> > +
> > +	dr->parent = base;
> > +	dr->start = res->start;
> > +	dr->n = resource_size(res);
> > +
> > +	/* See 'struct region_devres' definition for details */
> > +	if ((flags & GFR_REQUEST_REGION) == 0)
> > +		dr->res = res;
> > +
> > +	devres_add(dev, no_free_ptr(dr));

-- 
With Best Regards,
Andy Shevchenko


