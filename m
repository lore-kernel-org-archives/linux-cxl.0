Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EDD2063DD
	for <linux-cxl@vger.kernel.org>; Thu,  6 Mar 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295380; cv=none; b=A6FpmbRH4Ck3/Lyv+/nl6VUx8Vm9Mu0+yBhB6Xpi3VRRPKycbkC6AyM27wARq7XKIPOrulSnkM7XUsAt+9dBLsMG/a8MPHJSWVwuhRduC6OHoit3F28QVqnNiE93z9d4YbaqWVd28wBLvqe/B946Y6pzVKu6/nnAK6Woxwk+JY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295380; c=relaxed/simple;
	bh=ONIBOxEOQC7JSnTy1SWMt6S53bjr++zExN6jr9IiV0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsXNQHVTsbxiQAoH/F+eIrBouHyV6Ukhf7a3Hu43hnWfFpxHQluyJCohU2gOXwoiw3OIbXa/ivfTrBJhkXFDncKdA6Ldkhp5jUAWO00nheKjT85Ot34MVDoXpo8q0HBysM1Fhk3wPHAEBcwAftrOfeBy2wMp9SRJNphnb8qPVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpCiHWMI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpCiHWMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741295379; x=1772831379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ONIBOxEOQC7JSnTy1SWMt6S53bjr++zExN6jr9IiV0M=;
  b=GpCiHWMIEDCYbl4uTe4CNflIYH+2yvE77dRzj6LpPpuwr6cMN+coYwxz
   s+D6Kpv+FzcsJUFr8DSWX/sqfTViibyUz+Cj3FihoS4WqQEEy+4yeF+3C
   guNA4kP6x5/aUJYJu1HPDhS/O/gXtZp4hn2g/N0z/GBNlL61x30SlVpPf
   Em7+qCv0KSbdOOAmeW+hYGQ+VdksdhfYHvogYa6HEHSAnvhywPCkAb702
   OEjde4moLGhiVQHRnIJqI+Y8tT+sLaLdINOw5dMCYflIkasEyq373jYEi
   qCnSMPkPlFKRN4psp671sJjRDez0lThuKsyUkoLwK30l1sysKeKuSL0NH
   g==;
X-CSE-ConnectionGUID: KOGsdSZEQK+sjYJxcbQ2fA==
X-CSE-MsgGUID: m9eO1UkcRX+PlwPfK9BuvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42186737"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42186737"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:09:38 -0800
X-CSE-ConnectionGUID: lDRfQ+5lTxmrW0uSTXKFTg==
X-CSE-MsgGUID: YwCMi32YSp6CzmigdOM0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="119319014"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.63])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:09:37 -0800
Date: Thu, 6 Mar 2025 13:09:35 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/region: Quiet some dev_warn()s in extended linear
 cache setup
Message-ID: <Z8oPD1h-9bf_M0d9@aschofie-mobl2.lan>
References: <20250304043315.2502110-1-alison.schofield@intel.com>
 <12e0d842-0ff3-4c8a-9bc2-b5c1436521e1@zohomail.com>
 <Z8edZPIWsjSLiEac@aschofie-mobl2.lan>
 <f2b70e5f-b72b-4c5a-9eb3-df0aaa421430@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b70e5f-b72b-4c5a-9eb3-df0aaa421430@zohomail.com>

On Wed, Mar 05, 2025 at 12:41:26PM +0800, Li Ming wrote:
> On 3/5/2025 8:40 AM, Alison Schofield wrote:
> > On Tue, Mar 04, 2025 at 01:14:47PM +0800, Li Ming wrote:
> >> On 3/4/2025 12:33 PM, alison.schofield@intel.com wrote:
> >>> From: Alison Schofield <alison.schofield@intel.com>
> >>>
> >>> Extended Linear Cache (ELC) setup code emits a dev_warn(), "Extended
> >>> linear cache calculation failed." for issues found while setting up
> >>> the ELC.
> >>>
> >>> For platforms without CONFIG_ACPI_HMAT, every auto region setup will
> >>> emit the warning because the default !ACPI_HMAT return value is
> >>> EOPNOTSUPP. Suppress it by skipping the warn for EOPNOTSUPP. Change
> >>> the EOPNOTSUPP in the actual ELC failure path to ENXIO.
> >>>
> >>> In a much less likely path, the dev_warn() is emitted if the size of
> >>> the region resource is NULL. Move that size check out of the ELC setup
> >>> code since NULL resource size is unrelated to the ELC setup and should
> >>> cause an immediate failure to construct the auto region.
> >>>
> >>> For good measure, add the rc value to the dev_warn(). It will either
> >>> be the -ENOENT returned by HMAT if the mem target is not found, or
> >>> the -ENXIO from the region driver calculation.
> >>>
> >>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> >>> ---
> >>>  drivers/cxl/core/region.c | 16 ++++++++--------
> >>>  1 file changed, 8 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >>> index 8537b6a9ca18..2d2d2f221902 100644
> >>> --- a/drivers/cxl/core/region.c
> >>> +++ b/drivers/cxl/core/region.c
> >>> @@ -3235,13 +3235,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> >>>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> >>>  	struct cxl_region_params *p = &cxlr->params;
> >>>  	int nid = phys_to_target_node(res->start);
> >>> -	resource_size_t size, cache_size, start;
> >>> +	resource_size_t size = resource_size(res);
> >>> +	resource_size_t cache_size, start;
> >>>  	int rc;
> >>>  
> >>> -	size = resource_size(res);
> >>> -	if (!size)
> >>> -		return -EINVAL;
> >>> -
> >>>  	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> >>>  	if (rc)
> >>>  		return rc;
> >>> @@ -3253,7 +3250,7 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> >>>  		dev_warn(&cxlr->dev,
> >>>  			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
> >>>  			 &cache_size, &size);
> >>> -		return -EOPNOTSUPP;
> >>> +		return -ENXIO;
> >>>  	}
> >>>  
> >>>  	/*
> >>> @@ -3304,15 +3301,18 @@ static int __construct_region(struct cxl_region *cxlr,
> >>>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> >>>  				    dev_name(&cxlr->dev));
> >>>  
> >>> +	if (!resource_size(res))
> >>> +		return -EINVAL;
> >>> +
> >> Hi Alison,
> >>
> >>
> >> There is a 'res = kmalloc(sizeof(*res), GFP_KERNEL);' in __construct_region() before this return, I think that you should release 'res' before returning -EINVAL.
> > Thanks for the review. I zoomed out a bit and can't find how
> > we can get here without a valid hpa_range which makes me
> > want to remove the check altogher. Then again it's harmless,
> > and not in any performance path.
> >
> > Checking with DaveJ ?
> >
> You are right, __construct_region() is only invoked during region auto-assembly. the size of cxled's hpa_range is already checked in init_hdm_decoder() if the cxl endpoint decoder is committed.

Thanks for reviewing Ming. I'm waffling on this. Leaning towards letting
it be because this patch is about quieting the noise in the absence of
ACPI_HMAT and that check is not creating any noise.

Watch for a v2.

--Alison

> 
> 
> Ming
> 
> >> Other looks good to me.
> >>
> >> Reviewed-by: Li Ming <ming.li@zohomail.com>
> >>
> >>
> >> Ming
> >>
> >> [snip]
> >>
> >>
> 
