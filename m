Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B562505D7
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798781; cv=none; b=DLGh93Jdk2ccHWvVmi9OPdMUu+ds+as6/coFXiGP006oZxvnNByBnnhVJwfESV1LmQtj1nsKDCljg43gWHAmtCZ/PAsQ0P5z+AYz3aLQWS+me/3i10qdKZmTjN3bb8IafxPhB+TP29TgWqHNLRvG9qHQKAtE5n2NWaWt6f7q1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798781; c=relaxed/simple;
	bh=QPITIayDAokS/bvRg33ZG+IYKp/pJmDW4UeB6o1oLcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV7HFe3VOotokvzbooeUqnGHDB8q2C0X5kl7CmQmlF2WpXHKX7iSACZZHoANeotxpvFvdls+2LrZH1uj7EDK0G6su07KQxNVg2BYL6aL/zzyT13Onkhy00+OVn5VhR6ci7/KCLBupYWjDkzS1VR2FFSuXZgF+tUzAkGBkNiuFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGgvznA5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGgvznA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741798779; x=1773334779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPITIayDAokS/bvRg33ZG+IYKp/pJmDW4UeB6o1oLcY=;
  b=GGgvznA5yoKzWX4qVn7g+SH+QL8el3eU3LSeT+9YGbfm4XVqtL/orWN9
   SUxAe5isCixoVNsUV5ZqibRPCsjjGrXz8XfUu6t4UpDxFIxHaD4LvBRTI
   Vkr0F8YSZhnYGLZ19LujO7goqeaQD8LPpaCFfUX63OaP500dfmy1TpFkp
   1hsDbqtpfwKDgz+eGnCbLv5E35vyexAD4dPjDZuIF3fki9ASwwBPIziJN
   M6RPLqGwAXPIwl18xlemrZTWyl3sRaVjVwaDki8/p0Sg7GKLnWnnOQqrZ
   fU0N45Xjmlvu4A0YxzZtEHOt6/9sU9t5z2VraxqiB1nC2MQ/CtaNChXsA
   Q==;
X-CSE-ConnectionGUID: yo9Y0MaHQC2vidvJGV9qSQ==
X-CSE-MsgGUID: 3wNZC69kRambYCBdO+oYSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30473247"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="30473247"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 09:59:38 -0700
X-CSE-ConnectionGUID: FOP5PI2vRJeBGftkNzYaDA==
X-CSE-MsgGUID: tgP+ztGgQCmXCNW++IaeEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120712686"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.10])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 09:59:38 -0700
Date: Wed, 12 Mar 2025 09:59:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
Message-ID: <Z9G9eOXTY1y10qUE@aschofie-mobl2.lan>
References: <20250306232239.2609017-1-alison.schofield@intel.com>
 <67ca3c87a1dbe_1a7f29493@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ca3c87a1dbe_1a7f29493@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Mar 06, 2025 at 04:23:35PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The CXL driver requires the granularity of a region and its root
> > decoder to be the same. This is particularly restrictive for 3-way
> > host bridge interleaves where the only spec defined interleave
> > configurations for creating 6-way and 12-way regions on a 3-way HB
> > interleave require mixed granularities.
> > 
> > CXL 3.2 Specification 9.13.1.1:
> > Legal Interleaving Configurations: 12-way, 6-way, and 3-way
> > 
> > Adding support for these new interleaves touches these areas:
> > 
> > 1) User created regions employing "cxl create-region" fail when the
> > CXL CLI tool gets a mixed granularity request. That is addressed in
> > a patch to the ndctl tool.
> > 
> > 2) User created regions employing sysfs directly fail at the sysfs
> > store of the non-matching region granularity. That restriction is
> > lifted here. Note that the driver immediately allows any reasonable
> > 3-way HB granularity, but the region config may still fail later
> > if the ways/gran between region and root decoder are incompatible.
> > 
> > 3) Auto created regions, in which the drivers role is to reflect
> > the BIOS created region and provide RAS support, basically sneak on
> > by. The driver ignores the root decoders granularity and assumes it
> > is the same as the regions. The impact being that endpoint devices
> > appear out of order and DPA to HPA address translations that depend
> > on that order are invalid.
> 
> I.e. that is a bug. The question is do we backport a "fix" to make that
> config start failing per old expectations, or do we backport this patch
> to fix those known configs?
> 

For this specific config -> fix it. For all the others quietly
misassembling -> start failing.  More...

> I would lean to backporting this patch so this needs a Fixes tag.

Thanks for the review Dan. Here's a response in general, and afterwards
responses to your embedded code review comments.

I should have said this was a no switches solution. This is a no
switches solution as that meets the use case needing repair. More
on that below.

I see where this can be more restrictive so as not to let any configs
slip through that are not 100% supported by the CXL driver. Let's
discuss which configs the driver will fully support versus explicitly
reject.

Appended is a list of the 3-6-12 way interleaves described in the CXL
Spec 3.2 Table. The complete list is appended because it's important
to see all the flavors. If we only talk switch, no_switch, or mixed,
no_mixed, combinations are omitted and complexity may be underestimated.
The driver supports 3 of the 11 configs correctly: 3-A, 6-A, 12-A.
Those are the configs with cross-host bridge interleave only.

The driver may pretend to support, but fails on all others. I use the
word 'may' because user created regions fail to create, so there is
no pretending there. It is the auto regions, (BIOS configured regions)
that will appear to be recognized by the CXL driver, but in fact the
assembly is misunderstood and so RAS support is broken.

That pretend is not just for MOD3 regions. Barring a safeguard I've
missed, any auto config with mixed granularity is quietly misassembled.

That suggests a lead in patch here that shuts down the quiet misassembly
of any mixed granularity auto regions. Again, no need to shut it down
for user-created as they are already blocked. User-created regions will
require new allowances.

Which mixed granularity regions require support?

I have a user that needs config 6-B fixed. That is the 6 way region
built on a 3-way Host Bridge Interleave, no switches. It is one of
those that are quietly misassembling as an auto region. Two similar
12-ways configs, 12-B&D come along for minimal additional effort yet
I am not aware of a use case for these.

Proposal is that this patch(set) protects against the mis-assembled
configs and adds support 6-B. That would fully meet the use case at hand
and protect users against the mis-assembled regions.

I do wonder if the shutdown of mis-assembled auto regions might bring
some use cases to light 

I expect I'll work a v3 with the updates noted here while listening
for upstream feedback on driver supported configs.


--------
Section 9.13.1.1
Legal Interleaving Configurations: 12-way, 6-way, and 3-way 

Table 9-8: 3-Way Device-level Interleave at 1GB
3-A:	Cross-host Bridge: 3 way at 1GB
	Host Bridge: No interleaving
	Switch: No interleaving or absent

Table 9-7: 6-Way Device-level Interleave at 1GB
6-A:	Cross-host Bridge: 6 way at 1GB
	Host Bridge: No interleaving
	Switch: No interleaving or absent
6-B:	Cross-host Bridge: 3 way at 2 times 1GB
	Host Bridge: 2 way at 1GB
	Switch: No interleaving
6-C:	Cross-host Bridge: 3 way at 2 times 1GB
	Host Bridge: No interleaving
	Switch: 2 way at 1GB

Table 9-6: 12-Way Device-level Interleave at 1GB
12-A:	Cross-host Bridge: 12 way at 1GB
	Host Bridge: No interleaving
	Switch: No interleaving or absent
12-B:	Cross-host Bridge: 6 way at 2 times 1GB
	Host Bridge: 2 way at 1GB
	Switch: No interleaving or absent
12-C:	Cross-host Bridge: 6 way at 2 times 1GB
	Host Bridge: No interleaving
	Switch: 2 way at 1GB
12-D:	Cross-host Bridge: 3 way at 4 times 1GB
	Host Bridge: 4 way at 1GB
	Switch: No interleaving
12-E:	Cross-host Bridge: 3 way at 4 times 1GB
	Host Bridge: No interleaving
	Switch: 4 way at 1GB
12-F:	Cross-host Bridge: 3 way at 4 times 1GB
	Host Bridge: 2 way at 1GB
	Switch: 2 way at 2 times 1GB
12-G:	Cross-host Bridge: 3 way at 4 times 1GB
	Host Bridge: 2 way at 2 times 1GB
	Switch: 2 way at 1GB


> 
> > Here the driver stops making that same
> > granularity assumption and checks for an allowable granularity.
> > 
> > A new helper, interleave_granularity_allow(), is used in both the
> > user and auto creation path to allow the newly supported configs.
> 
> Minor but the function is not performing an "allow" operation it is
> evaluating an "allowed" condition, so I would have expected this to be
> named:
> 
>     is_interleave_granularity_allowed()
> 

got it.


> > Another new helper, gran_multiple(), is used in sorting, target
> > list searching, and distance calculations, supporting the new
> > root granularity to region granularity multiples.
> > 
> > And, as noted in 2), there's an added check to see if the
> > selected sysfs ways/gran make sense when considered together.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Changes in v2:
> > - Allow exactly 2*ig or 4*ig in interleave_granularity_allow()(DaveJ)
> > - Remove needless !root_decoder_gran check in gran_multiple()(Ming)
> > - Update spec references to 3.2 (DaveJ)
> > - Commit log grammar cleanup (DaveJ)
> > - Describe param 'multiple' in cxl_calc_interleave_pos() (lkp)
> > 
> > 
> >  drivers/cxl/core/region.c | 104 +++++++++++++++++++++++++++++++-------
> >  1 file changed, 85 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 8537b6a9ca18..cc2687407a3e 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -532,6 +532,31 @@ static ssize_t interleave_granularity_show(struct device *dev,
> >  	return rc;
> >  }
> >  
> > +static bool interleave_granularity_allow(struct cxl_decoder *cxld, u16 ig)
> 
> I don't like that this function takes a plain 'struct cxl_decoder *',
> this function is only relevant for root decoders so make that clear by
> requring that it is passed a 'struct cxl_root_decoder *'. Yes, it means
> redoing the "cxld = &cxlrd->cxlsd.cxld" conversion.
> 

got it: s/cxl_decoder/cxl_root_decoder


> > +{
> > +	/*
> > +	 * When the host-bridge is interleaved, disallow region granularity
> > +	 * != root granularity with the exception of 3-way HB interleaves.
> > +	 * Allow the CXL Spec defined 3-way HB interleaves that can only be
> > +	 * configured when host-bridge interleave is greater that the
> > +	 * region interleave. (CXL 3.2 Specification 9.13.1.1)
> > +	 * Allow 2+2+2 interleave where HB gran is 2 * region granularity
> > +	 *	 4+4+4 interleave where HB gran is 4 * region granularity
> 
> Only an Intel person might understand X+X+X notation topology notation.
> Just describe these configs in plain english.

Can do.

> 
>     Allow 6 endpoints across 3 host-bridges when the root-decoder
>     granularity is 2x region granularity.
> 
>     Allow 12 endpoints across 3 host-bridges when the root-decoder 
>     granularity is 4x region granularity.
> 
> The problem is that this comment assumes direct-attached endpoints. If
> you had switches between a host-bridge and endpoints then the region
> granularity is not valid to compare to the root decoder granularity.
> 

Yes it does.

> > +	 *
> > +	 * Regions with a granularity greater than the root interleave result
> > +	 * in invalid DPA translations (invalid to support).
> > +	 */
> > +	if (cxld->interleave_ways > 1 && ig != cxld->interleave_granularity) {
> > +		if (cxld->interleave_ways != 3)
> > +			return false;
> > +
> > +		if (cxld->interleave_granularity != 2 * ig &&
> > +		    cxld->interleave_granularity != 4 * ig)
> > +			return false;
> > +	}
> > +	return true;
> > +}
> > +

snip

> > @@ -1347,12 +1382,17 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		 * always 1 as every index targets a different host-bridge. At
> >  		 * each subsequent switch level those ports map every Nth region
> >  		 * position where N is the width of the switch == distance.
> > +		 *
> > +		 * With the introduction of mixed granularities in 3-way HB
> > +		 * interleaves, divide N by a multiple that represents the root
> > +		 * decoder to region granularity.
> 
> I go into more detail later, but region granularity is not relevant when
> switches are present.

No switches present. I take another look to see if any of this
doesn't clearly preclude switches.

> 
> > +	/*
> > +	 * Protect against improper gran mixes on 3-way HB interleave
> > +	 * Expect decoder gran*ways == region gran*ways
> > +	 */
> > +	if (cxlrd->cxlsd.cxld.interleave_ways == 3) {
> > +		if ((cxlrd->cxlsd.cxld.interleave_granularity * 3) !=
> > +		    (p->interleave_ways * p->interleave_granularity)) {
> 
> When switches are present p->interleave_ways and
> p->interleave_granularity are not relevant for 3-way validation. For
> example imagine an x3 HB, with x6 switches, and x12 endpoints. The mixed
> granularity is resolved at the switch level, not the region level.

No switches.
