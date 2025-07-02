Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918E4C7F;
	Wed,  2 Jul 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444293; cv=none; b=M35iHjcZ5cn9g/ANNFXbJq0+tq1BkDTHxpCHHGWWx5+DbB2ilENLstZSBcPqoSrlIOYPfbax9+ugZbxoyn6rAgee8OCoGsZ0/IgwCSt6oSQEWXGEg6tBtFe94LXIQ2mALmb3/FEgV+fo78uJPHxvUEeq/2H8M1Quq8pobyalIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444293; c=relaxed/simple;
	bh=2X0ZuQ8tzFdR6e2MR2On9LEIa13O9/MXfufV8TG6ztM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD7I+mpgr3VK8o/dB1Y8RrP0qC68CJwDSYrK/il6h1Pk+JGW4txjSOMLr3MxoLOlj+FLCh0UZYTSqpKMFT0ZLfUYGo3rL8pg4PNpqqz5Z2mrrgWYdIRTfl2ECjxDZP3/xeLrHYf7H3sCpGsp4cDFZ5Uq0MR/TnoUiFiLlTmAx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ksi7vW75; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ksi7vW75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751444293; x=1782980293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2X0ZuQ8tzFdR6e2MR2On9LEIa13O9/MXfufV8TG6ztM=;
  b=Ksi7vW75rFUvzDCbn1oUpebGd7XezmYP09AaD+VXAgTto540m/7nlnOp
   xHXbO7LwHMzx1NzCBbnqJpRKrOtD6mIgfOR4U8yYjQRbZCbrng1GhUnYm
   tCUmdgPpDbTMMoWWfOJBNATzO3YUxzFEm2SkfEO0DuKqP0otmfKVui52K
   2HeL7VFH48XuIImJKeLU0tme1hrNt+NjTvuCZmx9bfgM4XTqQMWYe1LJY
   FxR2Svhl3459gl3NrWQG2PbBrrxRA1MhIQCq+u6MedZ1Ds5j/y/7tKu61
   832obxq1IbqIdMUZmVroGxMc9e4RODYpFlIGivsC3HaHNNtNy1kktO/uW
   w==;
X-CSE-ConnectionGUID: 2C9a5GGVTUCfAkIMx6/gFQ==
X-CSE-MsgGUID: /mN88kp4QaK9jJbXX6Xg0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="76273338"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="76273338"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:18:11 -0700
X-CSE-ConnectionGUID: V/cJjtAyTYGnRh1wrMD2NQ==
X-CSE-MsgGUID: evUFckWIRwumD47fT08CWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154334327"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:18:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWsfM-0000000BrY2-2PLC;
	Wed, 02 Jul 2025 11:18:04 +0300
Date: Wed, 2 Jul 2025 11:18:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: akpm@linux-foundation.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] resource: Introduce a new helper
 resource_contains_addr()
Message-ID: <aGTrPKiFUfRsY6D_@smile.fi.intel.com>
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <aGTq5MKCYBO3H9Gg@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGTq5MKCYBO3H9Gg@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 11:16:36AM +0300, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 03:20:06PM +0800, Li Ming wrote:
> > In CXL subsystem, many functions need to check an address availability
> > by checking if the resource range contains the address. Providing a new
> > helper function resource_contains_addr() to check if the resource range
> > contains the input address.
> 
> resources are about ranges and not addresses. At bare minimum naming sucks
> here. Also there is no symmetry with the intersection API. But I would argue

I meant overlaps, sorry for the confusion.

> to use resource_contains() and just provide necessary parameter with both
> start and end to be set at the same value.
> 
> 	struct resource r = DEFINE_RES...(addr);
> 
> 	if (resource_contains, res, &r)
> 		...do stuff...

-- 
With Best Regards,
Andy Shevchenko


