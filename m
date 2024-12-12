Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18613D521
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969255; cv=none; b=lCD0IJ6dzjg1xB7n1WKw3984kPypPlDL7qZMaYIgXyEOjFBAATlF+DlQY7HoIUW/wi72DP2jMaxYk7nNEl9tyTh40WxqKgi2QEwqfWWnquW/eWzimH8qhsj8iHlPlsz/jsVeg6kY/j2TvI+2O4zIuc8n51Z0h6KGk3meV++LRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969255; c=relaxed/simple;
	bh=/yluqfdO/e1RLDL5LRJ9aPH9pgS8hEbsx0IXJey8uNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quOq8AcTLgErPigktL82e0xo8ek7gib708YVB6WkAN02ih8sc3CNwQ4+52h7ViVx/FNfwwn+BgtXAiVCWLI492eFkdWITrf3VIRwrg/L0jMOz6y3mudUBLVv+gKr5BkIP7saWpOZkiaxOh7DrO7+mGWsQexgpgv6VAzVVOQONx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P865L1DS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P865L1DS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733969253; x=1765505253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/yluqfdO/e1RLDL5LRJ9aPH9pgS8hEbsx0IXJey8uNU=;
  b=P865L1DSp7gKqkcRzkM30V7sWXkN+zIbhgxJpD6OLnlQSqqtN+6tl/v4
   HSKzNiaBp9NB2HmvpeDoQXBv8LFV5ASyL1uno4smy9lUB7yqbAzo0sXrg
   G4HM4R4cSWlPIB0t6bpDaCqzfsvwhaDIj3/VyOVdZmm2/qxEouMJDhSx6
   11pKF6KVW5Bh5J1H4slloMMAbC3uzBi+rA+E7bGudTkHAMa8O1fJlOAv3
   X+o6IbBfgpNcaaSfvjLjA3oWdqb41SfqGQMda1mxmSTYjz30lhMOh142W
   xs2b/URk5yMs5SIlmoZpDwxmiQ5RSBbFTn+ih0Hvhbk1ConfPxXgurIt+
   Q==;
X-CSE-ConnectionGUID: Ez2aq+cLR0+d1bjI+Gmzag==
X-CSE-MsgGUID: +Iog9Q6YR9mbvixC8PkgTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34098133"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34098133"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 18:07:27 -0800
X-CSE-ConnectionGUID: chCiMb/CTW6nm3mOdKrpcg==
X-CSE-MsgGUID: HkTs3YgqR/uAtjE0ZzF/CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101006612"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.67])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 18:07:27 -0800
Date: Wed, 11 Dec 2024 18:07:24 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Nathan Fontenot <nathan.fontenot@amd.com>, linux-cxl@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <Z1pFXFGjkMMXgFy6@aschofie-mobl2.lan>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <675a12a3d09d7_10a083294c0@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675a12a3d09d7_10a083294c0@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Dec 11, 2024 at 02:30:59PM -0800, Dan Williams wrote:
> Nathan Fontenot wrote:
> > Update handling of SOFT RESERVE iomem resources that intersect with
> > CXL region resources to remove the intersections from the SOFT RESERVE
> > resources. The current approach of leaving the SOFT RESERVE
> > resource as is can cause failures during hotplug replace of CXL
> > devices because the resource is not available for reuse after
> > teardown of the CXL device.
> > 
> > The approach is to trim out any pieces of SOFT RESERVE resources
> > that intersect CXL regions. To do this, first set aside any SOFT RESERVE
> > resources that intersect with a CFMWS into a separate resource tree
> > during e820__reserve_resources_late() that would have been otherwise
> > added to the iomem resource tree.
> > 
> > As CXL regions are created the cxl resource created for the new
> > region is used to trim intersections from the SOFT RESERVE
> > resources that were previously set aside.
> > 
> > Once CXL device probe has completed ant remaining SOFT RESERVE resources
> > remaining are added to the iomem resource tree. As each resource
> > is added to the oiomem resource tree a new notifier chain is invoked
> > to notify the dax driver of newly added SOFT RESERVE resources so that
> > the dax driver can consume them.
> 
> Hi Nathan, this patch hit on all the mechanisms I would expect, but upon
> reading it there is an opportunity to zoom out and do something blunter
> than the surgical precision of this current proposal.
> 
> In other words, I appreciate the consideration of potential corner
> cases, but for overall maintainability this should aim to be an all or
> nothing approach.
> 
> Specifically, at the first sign of trouble, any CXL sub-driver probe
> failure or region enumeration timeout, that the entire CXL topology be
> torn down (trigger the equivalent of ->remove() on the ACPI0017 device),
> and the deferred Soft Reserved ranges registered as if cxl_acpi was not
> present (implement a fallback equivalent to hmem_register_devices()).
> 
> No need to trim resources as regions arrive, just tear down everything
> setup in the cxl_acpi_probe() path with devres_release_all().
> 
> So, I am thinking export a flag from the CXL core that indicates whether
> any conflict with platform-firmware established CXL regions has
> occurred.
> 
> Read that flag from an cxl_acpi-driver-launched deferred workqueue that
> is awaiting initial device probing to quiesce. If that flag indicates a
> CXL enumeration failure then trigger devres_release_all() on the
> ACPI0017 platform device and follow that up by walking the deferred Soft
> Reserve resources to register raw (unparented by CXL regions) dax
> devices.
> 

This reads like a 'poison pill' case that is in addition to the original
use cases that inspired this patch. I'm not sure I'm getting the 'all or
nothing' language.

The patch was doing Case 1) and 2). This poison-pill approach is 3)

1) SR aligns exactly with a CXL Window.
This patch removes that SR so the address space is available for reuse if
an auto-region is torn down.

2) SR is larger than a CXL Window.
Where the SR aligns with the CXL Window the SR is handled as in 1).
The SR leftovers are released to DAX.

3) Failure in auto-region assembly.
New case: tear down ACPI0017 and release all SRs.

So, after writing the above, maybe I get what the 'all' case is.
Are you suggesting we stop trimming and ignore leftovers and just
consider both 1) and 2) the 'all' case? No SR ever makes it into
the iomem resource tree so all resources are available for reuse
after teardown. And then there is 3), the nothing case! I get that.

It will waste some leftovers that could have been handed to DAX.
I know the SR greater than CXL Window came in handy for hotplug when
the SRs were not released, but I never understood if SRs greater
than CXL Window intended to serve any purpose.


> Some more comments below:

snip for now

> 
