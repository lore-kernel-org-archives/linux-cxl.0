Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF72907
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734051719; cv=none; b=rafPZyNf/9L/CuXvnEgE6UoXIY7snP7PeoBqk3ahnkk4MIeOKEXWdMiec8yWntJdDJPIdpm0kiolc+TrDmVwK5BlQkkmOkC0l9Evh2s8RENMgHoAS47pM3LXiCb3ec6zbL9jwSPYABMVGgRRflQ+EjkqJZevdy353tx156otGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734051719; c=relaxed/simple;
	bh=gE+XMjlbD6wK0m92eYbAc+ZOzvQchaLYpuEwTXR73rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxeUfNHxx5Omi9Herl8BQyTEpx11Q/JmXaZA8+XIS4z/NcIjRESsIDuDy/FIt4EJ5x2RcycMNaR9dDbGSKTdUcgSObx9hj0s+zYWfAyW9umcuJAVAG7GnTW/9O170Qb6oabZzLK0jBHqCHvVa/pR6dv2coqxePjzPYYd9gpy/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUxbmPZk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUxbmPZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734051717; x=1765587717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gE+XMjlbD6wK0m92eYbAc+ZOzvQchaLYpuEwTXR73rg=;
  b=eUxbmPZkQ1dVftW78a9gTVA8/0psX3shx1viR1vsEZrnYdf/4jGs1pIl
   mMSAdZAuY3merf4DpJRH1aWM5xfy5+bvTNcqqJocRqEKXSCnfB/+mkM6s
   cIpTFoc+lS86yrl3dwPPL6uFKHcyi2VKTJeaXZMFTAzxJ+EvMLnA6SMWC
   94CbbjXezKXKiCO5eEdKAD8jTwymyFb4fBBgBSgDQD2RbFu8Lg2OxbycQ
   bFk7QB/ANJGjax1rnDoCFvNQJBsKt1Y/84UFPqCtRSmRvwAeVuIFKjTdE
   qs2dOi0qtrtCyKvauLHghl8xXA9uGyIBUo4i8/Cj0YSRtmB5vZDuF3rSb
   w==;
X-CSE-ConnectionGUID: 93GzmNzLQ/+QLCFaVSgrTQ==
X-CSE-MsgGUID: sIPw5wHGR96e7I203Yfaxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="56968436"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="56968436"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 17:01:56 -0800
X-CSE-ConnectionGUID: 3Qejn4ZPTnWlKmvSoTPn0w==
X-CSE-MsgGUID: wqJ+12uFRsOnhQFLRL+5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="127199084"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.122])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 17:01:56 -0800
Date: Thu, 12 Dec 2024 17:01:53 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: Nathan Fontenot <nathan.fontenot@amd.com>, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <Z1uHgePW0T81r3xC@aschofie-mobl2.lan>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <Z1tmwOsAtL-wBR3Y@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1tmwOsAtL-wBR3Y@PC2K9PVX.TheFacebook.com>

On Thu, Dec 12, 2024 at 05:42:08PM -0500, Gregory Price wrote:
> On Mon, Dec 02, 2024 at 09:55:42AM -0600, Nathan Fontenot wrote:
> ... snip ...
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index a83040fde236..8fc4121a1887 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> ... snip ...
> > +static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
> > +			     void *arg, const unsigned long unused)
> > +{
> 
> Chiming in a little late to the party here
> 
> I don't think encoding CXL-specific terminology and functionality
> directly into kernel/resource.c is wise by any measure.
> 
> The abstraction here is completely inverted, and this is probably
> in line with Dan's comments.
> 
> The comments in e820.c allude to a similar issue
> 
>     * Prior to inserting SOFT_RESERVED resources we want to check
>     * for an intersection with potential CXL resources.
> 
> This is similarly inverted - e820 doesn't know anthing about CXL
> and it shouldn't have to be made aware of CXL. Mucking with
> e820 is *begging* to be bitten elsewhere in parts of the system
> that depend on it to be a relatively stable source of truth.
> 
> 
> This tells me that this patch is trying to solve the wrong problem.
> 
> 
> Your changelog alludes to supporting hotplug replace
> 
> """
>   The current approach of leaving the SOFT RESERVE resource as is can
>   cause failure during hotplug replace of CXL devices because the 
>   resource is not available for reuse after teardown of the CXL device.
> """
> 
> It sounds like we should be making the SR resource available for
> re-use through proper teardown and cleanup of the resource tree,
> rather than trying to change fundamental components like e820.
> 
> If the driver was capable of using the SOFT_RESERVED region on
> initial setup, it should be capable of re-using that region.
> 
> 
> Is the issue here that the hotplug-replaced component has a
> different capacity? It it being assigned a new region entirely?
> Is it exactly the same, but the resource isn't being cleaned up?
> 
> Can you provide more specifics about the exact hotplug interaction
> that is happening? That might help understand the issue a bit better.
> 
> 
> Much of this sounds like we need additional better tear-down
> management and possibly additional cxl/acpi features to handle 
> hotplug of these devices - rather than changing resource.c.

Hi Gregory,

Never too late, and it serves to revisit and remember to carry
along some of the why behind this patch as we adopt it to do more.
Admittedly, the more, has also become the more important here!

I'm not sure what Nathan first saw that led him to this issue.
For me it was - 

BIOS labels a resource Soft Reserved and programs a region using
that range. Later, the existing cxl path to destroy that region
does not free up that Soft Reserved range. Users cannot create
another region in it's place. Resource lost. We considered simply
removing soft reserved resources on region teardown, and you can
probably find a patches on lore doing just that.

But - the problem grew. Sometimes BIOS creates an SR that is not
aligned with the region they go on to program. Stranded resources.
That's where the trim and give to DAX path originated.

But - the problem grew. Sometimes the CXL driver fails to enumerate
that BIOS defined region. More stranded resources. Let's find those
too and give them to DAX. This is something we are seeing in the
wild now and why Dan raised its priority.

Dan is also suggesting that at that last event - failure to enumerate
a BIOS defined region, we tear down the entire ACPI0017 toplogy
and give everything to DAX.

What Dan called, "the minimum requirement": all Soft Reserved ranges
end up as dax-devices sounds like the right guideline moving forward.

Hope that answers some of your why questions about the SR reuse.

It seems the worst problem, failure to enumerate a region, kind of
drives the solution now, and we should handle the soft reserveds
all the same. Even if Nathan doesn't implement it in one final
sweep through the Soft Reserveds, one way or another, those SR
ranges must end up as dax-device resources - either CXL managed
or BIOS Soft Reserved.

--Alison

> 
> 
> ~Gregory
> 
> > +	struct acpi_cedt_cfmws *cfmws;
> > +	struct srmem_arg *args = arg;
> > +	struct resource cfmws_res;
> > +	struct resource *res;
> > +
> > +	res = args->res;
> > +
> > +	cfmws = (struct acpi_cedt_cfmws *)hdr;
> > +	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
> > +				   cfmws->base_hpa + cfmws->window_size);
> > +
> > +	if (resource_overlaps(&cfmws_res, res)) {
> > +		args->overlaps += 1;
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static bool resource_overlaps_cfmws(struct resource *res)
> > +{
> > +	struct srmem_arg arg = {
> > +		.res = res,
> > +		.overlaps = 0
> > +	};
> > +
> > +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
> > +
> > +	if (arg.overlaps)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +int insert_soft_reserve_resource(struct resource *res)
> > +{
> > +	if (resource_overlaps_cfmws(res)) {
> > +		pr_info("Reserving Soft Reserve %pr\n", res);
> > +		return insert_resource(&srmem_resource, res);
> > +	}
> > +
> > +	return insert_resource(&iomem_resource, res);
> > +}
> > +EXPORT_SYMBOL(insert_soft_reserve_resource);
> > +
> >  static void __init
> >  __reserve_region_with_split(struct resource *root, resource_size_t start,
> >  			    resource_size_t end, const char *name)
> > -- 
> > 2.43.0
> > 
