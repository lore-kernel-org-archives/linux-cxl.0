Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA012BEAB
	for <linux-cxl@vger.kernel.org>; Thu,  4 Apr 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246031; cv=none; b=CtJHZqEFaSXnLYmnpBArLAaqcAy/XxkG/YHr0c+b6uEH/hY0uvvnRgJ5hPuA8gzKXelkKqqkIqqJD8EBm0mBpUi9RuOwLNaH24RYro2Hcz3rwVqlStgW+o6youfaDyO5f6kp7utlqehqWVBQDLb8YV76cnO+ujoAe0/qhl4jRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246031; c=relaxed/simple;
	bh=GK3WLP3rLO3c7ioqAS+UuDcuoECmiNQsFCN6TbgEMjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZPjLJXgoNuCIjpO3jjfYx16+ibmUqmaOn+MF5cH/4W5BoPl/HlpCW2DjjsnaQvNgnGaNgQf9dgVXRZNao9s0JW7HXYhkpkshsH0Wyn7zT3quck/8K08Td73l8GksqeV65lK7JyWGNtQGYMo8V1DYK8SJgieRjwD9n6korIhBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eD+4YigM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eD+4YigM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712246029; x=1743782029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GK3WLP3rLO3c7ioqAS+UuDcuoECmiNQsFCN6TbgEMjc=;
  b=eD+4YigMBzO50Tp6wgsbjHnofvz/DFMIyCJfyPPKIzR5rkDDPkbPMPhV
   s+XHFqHgtEEX+MWyIiYHSaayqPuuYyMrTAyD4Wk6+sQkV3nYCKJMmdkm/
   434HWekyk9vB5IjGPbKGmhRKoLwEOCUdtB7xCMpw9IOG2kn0+Y3sjoiHg
   vkVeizOUsWHmLOTacUtgYVEVLU4WTeLoopy2FbC3H/La8Z2ChiSfNU4wI
   IVUdLp6diRIJkSus+Aj3rVyKbNeWhxokae4YZirDIlzeDdH/y9olO/bKY
   aw+Ax+914p2JggwxwFg2fM4UfImtNqYa6HDt0wz8kv37YieYJK6MRQpmS
   A==;
X-CSE-ConnectionGUID: kz/5+xJ3TtKDAX3Q2FLHiA==
X-CSE-MsgGUID: IFGscVWcSd2RePGI0or03Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7777597"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7777597"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:53:47 -0700
X-CSE-ConnectionGUID: GLvRV+gtRjeeI+hNQS0New==
X-CSE-MsgGUID: sE+OtRD7Q+KH+2uH6mg7Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="49780096"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.19.15])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:31:37 -0700
Date: Thu, 4 Apr 2024 08:31:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4] cxl/core: Add region info to cxl_general_media and
 cxl_dram events
Message-ID: <Zg7H15AoQG5Or5SV@aschofie-mobl2>
References: <cover.1711598777.git.alison.schofield@intel.com>
 <061d1eac5d4e270337911199f0b0633c0ff230b4.1711598777.git.alison.schofield@intel.com>
 <20240403211613.0000195d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403211613.0000195d@Huawei.com>

On Wed, Apr 03, 2024 at 09:16:13PM +0100, Jonathan Cameron wrote:
> On Wed, 27 Mar 2024 21:36:32 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > User space may need to know which region, if any, maps the DPAs
> > (device physical addresses) reported in a cxl_general_media or
> > cxl_dram event. Since the mapping can change, the kernel provides
> > this information at the time the event occurs. This informs user
> > space that at event <timestamp> this <region> mapped this <DPA>
> > to this <HPA>.
> > 
> > Add the same region info that is included in the cxl_poison trace
> > event: the DPA->HPA translation, region name, and region uuid.
> > Introduce and use new helpers that lookup that region info using
> > the struct cxl_memdev and a DPA.
> > 
> > The new fields are inserted in the trace event and no existing
> > fields are modified. If the DPA is not mapped, user will see:
> > hpa=ULLONG_MAX, region="", and uuid=0
> > 
> > This work must be protected by dpa_rwsem & region_rwsem since
> > it is looking up region mappings.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> One query one the stub.. Otherwise all lgtm
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/core.h   |  6 +++++
> >  drivers/cxl/core/mbox.c   | 17 ++++++++++----
> >  drivers/cxl/core/region.c |  8 +++++++
> >  drivers/cxl/core/trace.h  | 47 ++++++++++++++++++++++++++++++++++-----
> >  4 files changed, 69 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 24454a1cb250..848ef6904beb 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -30,8 +30,14 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
> >  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> >  u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  		  u64 dpa);
> > +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa);
> >  
> >  #else
> > +static inline
> > +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
> > +{
> > +	return NULL;
> 
> Is this ever going to be a problem for the reason you have commented below?
> 
> Maybe 
> return ""
> ?
> 
> ...

Yep. I'll make it "".
Also, I'll includ Steve Rostedt on v2. He's making changes around
assign_str() so maybe this patch can align w a simpler assign_str().

Thanks Jonathan!

> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 45eb9c560fd6..a5b1eaee1e58 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2723,6 +2723,14 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
> >  	return ctx.cxlr;
> >  }
> >  
> > +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
> > +{
> > +	struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
> > +
> > +	/* trace __string() assignment requires "", not NULL */
> > +	return cxlr ? dev_name(&cxlr->dev) : "";
> > +}
> > +
> 
> 
> 
