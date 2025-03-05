Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1B2E336C
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135209; cv=none; b=V1pXsJ5j7J8tURf2GRVb8fpemZJAVvJ2wq+xkhBQz1l9rwiLVQt94avW8JWFuIbYlq3I2Rb+bHc0TBD9fCczAXySoCVzKN8YvTSsi015IsCX86xeoEdC4zBK1MKbR2x+X8zOvBSsNQy6bt79K5TTXLVIP+vrdfIsj3zMT+5uY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135209; c=relaxed/simple;
	bh=x20TWR57Zcv6+We8JEFlWDD9yV92gc4LpFk0HtGwQoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTo6GQKieT4utc8EDLkxGapTnDqezM3pBiRdhjzSzTJffyFhdViRIfcLGUMU5Ikp2a85gipCKF8doT8Zm7GK7PP9955DN55ULNbCfNaSlcQlt0x1pKUVzwZq4e4iOzmPXGV8n6NXipDvfBcPzxmca7jotLYu0/Mdn2N38YH7jfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmIbr7Nc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmIbr7Nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741135207; x=1772671207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x20TWR57Zcv6+We8JEFlWDD9yV92gc4LpFk0HtGwQoQ=;
  b=PmIbr7NcOtwqoSx1ry0TTrPJ2GEvmgEc28sA0px1HUyYYo4NDRUFNANK
   ungThdKFA4zSOAsKF8CmXIuttreX5N8T50Z5Ke/IwfQ0A2dghI2vC0MXw
   1JIYaWgs0qMURqU1w5U3PqwXpoF45CgNqobwDSaucs8Zj8TzG3mOrgaV3
   Vc2tuwabWYomYjG8BJNb/uxUtWYQTfcLfbt16jyZHi48v78rhjX7VQH+K
   xD6QYkMJKL53AA7Lcpd8S/J/QZJpacT2WtkaW0BkhVH1hTlFzXgV9FL52
   qmTN0wUb8pUjsj8ZPwgC7BarquEAEbfWKvyJ1iPRv7oDJ/FOYn4lp57Zo
   Q==;
X-CSE-ConnectionGUID: yyPxyl25SC68OfcCQozqIA==
X-CSE-MsgGUID: kwCnk7UbSFKCF1pQzlRXUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42325317"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="42325317"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 16:40:06 -0800
X-CSE-ConnectionGUID: vr2GY0UTTgaDY4LoPFX64A==
X-CSE-MsgGUID: LDw+7/jBTIWhCxF7G+J8OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119039269"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.168])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 16:40:07 -0800
Date: Tue, 4 Mar 2025 16:40:04 -0800
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
Message-ID: <Z8edZPIWsjSLiEac@aschofie-mobl2.lan>
References: <20250304043315.2502110-1-alison.schofield@intel.com>
 <12e0d842-0ff3-4c8a-9bc2-b5c1436521e1@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e0d842-0ff3-4c8a-9bc2-b5c1436521e1@zohomail.com>

On Tue, Mar 04, 2025 at 01:14:47PM +0800, Li Ming wrote:
> On 3/4/2025 12:33 PM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Extended Linear Cache (ELC) setup code emits a dev_warn(), "Extended
> > linear cache calculation failed." for issues found while setting up
> > the ELC.
> >
> > For platforms without CONFIG_ACPI_HMAT, every auto region setup will
> > emit the warning because the default !ACPI_HMAT return value is
> > EOPNOTSUPP. Suppress it by skipping the warn for EOPNOTSUPP. Change
> > the EOPNOTSUPP in the actual ELC failure path to ENXIO.
> >
> > In a much less likely path, the dev_warn() is emitted if the size of
> > the region resource is NULL. Move that size check out of the ELC setup
> > code since NULL resource size is unrelated to the ELC setup and should
> > cause an immediate failure to construct the auto region.
> >
> > For good measure, add the rc value to the dev_warn(). It will either
> > be the -ENOENT returned by HMAT if the mem target is not found, or
> > the -ENXIO from the region driver calculation.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 8537b6a9ca18..2d2d2f221902 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3235,13 +3235,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> >  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> >  	struct cxl_region_params *p = &cxlr->params;
> >  	int nid = phys_to_target_node(res->start);
> > -	resource_size_t size, cache_size, start;
> > +	resource_size_t size = resource_size(res);
> > +	resource_size_t cache_size, start;
> >  	int rc;
> >  
> > -	size = resource_size(res);
> > -	if (!size)
> > -		return -EINVAL;
> > -
> >  	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> >  	if (rc)
> >  		return rc;
> > @@ -3253,7 +3250,7 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> >  		dev_warn(&cxlr->dev,
> >  			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
> >  			 &cache_size, &size);
> > -		return -EOPNOTSUPP;
> > +		return -ENXIO;
> >  	}
> >  
> >  	/*
> > @@ -3304,15 +3301,18 @@ static int __construct_region(struct cxl_region *cxlr,
> >  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> >  				    dev_name(&cxlr->dev));
> >  
> > +	if (!resource_size(res))
> > +		return -EINVAL;
> > +
> 
> Hi Alison,
> 
> 
> There is a 'res = kmalloc(sizeof(*res), GFP_KERNEL);' in __construct_region() before this return, I think that you should release 'res' before returning -EINVAL.

Thanks for the review. I zoomed out a bit and can't find how
we can get here without a valid hpa_range which makes me
want to remove the check altogher. Then again it's harmless,
and not in any performance path.

Checking with DaveJ ?


> 
> Other looks good to me.
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> 
> Ming
> 
> [snip]
> 
> 
