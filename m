Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE531A89
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450445; cv=none; b=HTOZx5IoF+LjFykMA3vrgnsMvvtr92lCVXxAmFRfHRN+nef4/j/bbIJFb2ODmRuAD0H1PQL/H5WOpuB7iwM3lYRZqd+6+33+TlLzfyer2Km95jPMsr02s2YD7DsAcUJtZpiVAGnKECH3XzXJBnl0WH3PBkjn/mZcSvjrF5Ib7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450445; c=relaxed/simple;
	bh=MYC++uxKpoNFy4Ji01PCVyOdccTiEJlenCH8jwwfDkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu5ceNTXgYISlqt6lagDkb4k+XSgAo5oKNgA9yQLGUDjD3xxKFI5w0C6au13wXu165D7t/dGDhWOJgnbkgRjDylb82yx0LACp6bipQzqrejg0bYInlRVCOon57iJ/EXBYVIcV1i06G7CxLMwoy3QgVEgMdfOOAxHpuCniVZhrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2GPz5aw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2GPz5aw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740450444; x=1771986444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MYC++uxKpoNFy4Ji01PCVyOdccTiEJlenCH8jwwfDkI=;
  b=U2GPz5awJYaxJIwnWV5liH+yHaz1b+sp/EMB11yW3g/cqT0hM3PTqan3
   DgYctHVlMuGo6pPcT+P+m33FchMZTFjZ1VVQI4kZU/8cM8MKoZqHypg7N
   ZveIXOJGCIKhEZeIDq4XTfdrRj9K9b5+d3alLMT9Rl06BKn1Kg8GZjjzo
   asxkirCAgJbf0LOhY9p+mLy0NLBstRPsRL61QALbfWSqw/uXqVYZJnTSD
   pEbxFjr6pA7/FQQ2zV9K56JQzJACDiVS/+lAlFkPMfb/PJUylZUC/zqvO
   2XdyiwCqOmtfPbjEjnMwnyTDfrlAAS/O04U2noVQeWxi6i7A7uisT7Qd6
   Q==;
X-CSE-ConnectionGUID: KpJI+aHfSviAk28UVbWQXQ==
X-CSE-MsgGUID: 1ZuMCBBeR2SpStiQTV6IuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44894517"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="44894517"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 18:27:23 -0800
X-CSE-ConnectionGUID: UNH8DUc9RM+f8gpG0GScYQ==
X-CSE-MsgGUID: XdqDH0P4QoORpe8oItiOlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="116054994"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.135])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 18:27:22 -0800
Date: Mon, 24 Feb 2025 18:27:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
Message-ID: <Z70qiCzzusQ6XXhd@aschofie-mobl2.lan>
References: <20250224235817.2259508-1-alison.schofield@intel.com>
 <010e16c3-0f90-41b0-8939-4cc8cb26de7a@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010e16c3-0f90-41b0-8939-4cc8cb26de7a@intel.com>

On Mon, Feb 24, 2025 at 05:41:20PM -0700, Dave Jiang wrote:
> 
> 
> On 2/24/25 4:58 PM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The CXL driver requires the granularity of a region and it's root
> 
> s/it's/its/

got it

> 
> > decoder to be the same. This is particularly restrictive for 3-way
> > host bridge interleaves where the only spec defined interleave
> > configurations for creating 6-way and 12-way regions on a 3-way HB
> configuration?
> > interleave require mixed granularities.
> requries?

considering that 

> 
> > 
> > CXL 3.1 Specification 9.13.1.1:
> 
> May as well go to 3.2
> 

got it


> > Legal Interleaving Configurations: 12-way, 6-way, and 3-way
> > 
> > Adding support for these new interleaves touches these areas:
> > 
> > 1) User created regions employing "cxl create-region" fail when the
> > ndctl tool gets a mixed granularity request. That is addressed in
> s/ndctl/CXL CLI/
> 

got it


> > a patch to the ndctl tool.
> > 

snip

> >  
> > +static bool interleave_granularity_allow(struct cxl_decoder *cxld, u16 ig)
> > +{
> > +	/*
> > +	 * When the host-bridge is interleaved, disallow region granularity
> > +	 * != root granularity with the exception of 3-way HB interleaves.
> > +	 * Allow the CXL Spec defined 3-way HB interleaves that can only be
> > +	 * configured when host-bridge interleave is greater that the
> > +	 * region interleave. (CXL 3.1 Specification 9.13.1.1)
> spec 3.2
> 
> > +	 * Allow 2+2+2 interleave where HB gran is 2 * region granularity
> > +	 *	 4+4+4 interleave where HB gran is 4 * region granularity
> > +	 *
> > +	 * Regions with a granularity greater than the root interleave result
> > +	 * in invalid DPA translations (invalid to support).
> > +	 */
> > +	if (cxld->interleave_ways > 1 && ig != cxld->interleave_granularity) {
> > +		if (cxld->interleave_ways != 3)
> > +			return false;
> > +
> > +		if (cxld->interleave_granularity % (2 * ig) &&
> > +		    cxld->interleave_granularity % (4 * ig))
> > +			return false;
> 
> Can you please explain how the math works here? I'm not understanding the code here vs the comments above.

I'm guessing you are talking about the last chunk only. We get there
after discovering a 3-way HB interleave. (HB interleave and root decoder
interleave are the same thing.) Once we know it's a 3-way, there are
only 2 possible values and those are defined in the spec as:
	2+2+2 interleave where HB gran is 2 * region granularity
	4+4+4 interleave where HB gran is 4 * region granularity

And now that I've gotten to this part of the explanation I think
the code is allowing multiples of 2*ig and 4*ig, when it should
be a stricter check for exactly 2*ig or 4*ig.

updating that to:
	if (cxld->interleave_granularity != 2 * ig &&
	    cxld->interleave_granularity != 4 * ig)
		return false;

Thanks for that Dave!
> 
> DJ
> 

snip
