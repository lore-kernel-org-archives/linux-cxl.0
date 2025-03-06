Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815F627BF7B
	for <linux-cxl@vger.kernel.org>; Thu,  6 Mar 2025 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299320; cv=none; b=G6PoU4RYR9oF+1XwzEuWWcEC2e/SDrPShzj7I0BGTD+p37rT1HwH4y49d6KyyoUahM4roo7wt1j+kbnwX31+1FFZkmEl8LxC/bX+YWvOs7waRsYmlmDO9+uRttXHvYXQP6hfQVak3mi2zqhbM0tY3CsSbx0uKiR8/Re+zOHmF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299320; c=relaxed/simple;
	bh=Q/te2Co0vqzcmT83/XX2qKytwS1/INh5Pf/mVw45swY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxiiMx4eC8V1FOY+ngFhuVPNywoEvl3n4iqkPZYXOlDhPtsBvHVt+NR6bBqL6Ab4LlU/5bwGGeqLndWPra+4dkuom3XXlU/kcEmbOI154x3R3TJVXmhFVu3eUHKCKOfFoP5WpDbNN4PVljdBfchOk5DbhsTc8UO2Fjb6/QDJLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFWWGhB4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFWWGhB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741299318; x=1772835318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/te2Co0vqzcmT83/XX2qKytwS1/INh5Pf/mVw45swY=;
  b=oFWWGhB4yAQQYP1o0ACfhUODVvZL4PzY9nthjiecmFdWw1hPyLu9dJjR
   HwtRptkOhmQqdnPf6dK61eoxlFjLsGrV8OSSTKN3e+mfd/z1HC64ztDoP
   jN0exY8jnmhCLTx428G2S0z41kV1E6/Y6RLm0C8l6z4cWWInqmy1yCUnr
   DlNlOml11BJfXV/F7zUPnnvZrSe/lefZCIvRBrCdjMfak9nYoGdoxSzNd
   qL7VQXbWVbPiqA/8zIAuwEznLXrtCdYL3KICsH4evWra2F02NzkbeRQ8d
   kuAn9tchSiQl83+x+oCzofwdOCAN6l58JdxRlh++Ogqb3OOEtlVJIJpe7
   Q==;
X-CSE-ConnectionGUID: fiY8TYOYSnODeYecunFZig==
X-CSE-MsgGUID: 5HQzYEzOSn68EcIoshyxwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52542275"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="52542275"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:15:18 -0800
X-CSE-ConnectionGUID: SQxm/Q6tRL23BShoKJBBpg==
X-CSE-MsgGUID: CLwXyObFSX6JWVL9kZyC1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156368678"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.63])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:15:17 -0800
Date: Thu, 6 Mar 2025 14:15:16 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
Message-ID: <Z8oedHttovc0ydY_@aschofie-mobl2.lan>
References: <20250224235817.2259508-1-alison.schofield@intel.com>
 <71f703fc-5171-46ad-86b5-f74432a728ae@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f703fc-5171-46ad-86b5-f74432a728ae@zohomail.com>

On Wed, Feb 26, 2025 at 03:12:46PM +0800, Li Ming wrote:
> On 2/25/2025 7:58 AM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>

snip

> >
> > +static int gran_multiple(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > +	int root_decoder_gran = cxlrd->cxlsd.cxld.interleave_granularity;
> > +	int region_gran = cxlr->params.interleave_granularity;
> > +
> > +	/*
> > +	 * In regions built upon 3-way HB interleaves, the root decoder
> > +	 * granularity can be a multiple of the region granularity. The
> > +	 * multiple value is used in sorting and distance calculations.
> > +	 */
> > +	if (cxlrd->cxlsd.cxld.interleave_ways != 3 || !root_decoder_gran)
> > +		return 1;
> 
> Hi Alison,
> 
> 
> root decoder granularity is possible to be 0 here? I checked the code, the minimal value of it should be 256(CXL_DECODER_MIN_GRANULARITY), it was set in __cxl_parse_cfmws().
> 
> maybe this '!root_decoder_gran' checking is not needed?

Thanks for looking that up. I imagine I had some divide by zero concern,
which would have been wrong too.

Removed check in v2.

-- Alison

> 
> 
> Ming
> 
> [snip]
> 
> 
