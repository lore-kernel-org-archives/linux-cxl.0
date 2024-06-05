Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D579DE
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717548191; cv=none; b=Be5lS09fjCXnGXSnGeXb/NJf5c9ia2TxAuKAOv04KkgrqSILzzHUb6/jL2mgLbMC7mzN2ttLuJJHVvrEaPgyKAQ2L0390IejDu4zOFRbOA9Ooh3uDQjjZVzitdHc8eJ/T6x0vo5D7lov+ABIGS5JIqo28CyXqbv776vAuxQ2ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717548191; c=relaxed/simple;
	bh=W1RqqL5ZonCHs8QZRV9oOawLTWZpPScg74mdJDGYdNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drsqA1oU9qMVlW6rRRHbYCeVDJLRZ5sxIoDMRqr11Sf1aK1KUCh1dXSEB8jYNBSFyztp18s7ae6WZP8UHaonwwCsNxM98wrLCPR8KlZatQG/EEP7ht+7+V74/QuWkg47C01BQzPCwWmPli+uCWydg9LRjeyUWgAs/uQfh7G7+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUGpmgJD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUGpmgJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717548190; x=1749084190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W1RqqL5ZonCHs8QZRV9oOawLTWZpPScg74mdJDGYdNs=;
  b=XUGpmgJDEEW0jUDkBx5fLayn1MWvrjooNx1fOpL/FXD0SmjmCfbzgpvN
   fwL22Z9w4uLiZsRNUJA+Y6Qch/oKWCt6miJP3k177JF6kdAkiGpleWopv
   MjmJB0KQg/UyHfoyWHIzc1vVfKErpMBQ+eSw+cjqJ8JPoIsQMbng79/9d
   LGpQkjdjtGbCTubD7gfhpnpdIdC8yLX2/wmcEUZrDKz3Cz/gnxBTdpZrJ
   /N9VUlezfql0i8aAnviD/5oPz+fFPggS8wJowtaWdR4/OXrjZ77jR2pW9
   rstSK7ce6P2oM3i+cypCsaVEtzKg9hXNQlE4WQQy39mHSFH6TaE8CteEt
   g==;
X-CSE-ConnectionGUID: vDgl7AcPQYmZje0FQpfqCw==
X-CSE-MsgGUID: U+5vD5UyRpiChItwnxgM6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25535316"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="25535316"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 17:43:09 -0700
X-CSE-ConnectionGUID: NNXM1kiCQJOs8hzu791VSA==
X-CSE-MsgGUID: N2bN+G/XR8WcMo/AhYZTZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="60602033"
Received: from gjayashe-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.148.20])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 17:43:09 -0700
Date: Tue, 4 Jun 2024 17:43:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Avoid null pointer dereference in region
 lookup
Message-ID: <Zl+0mve3AnoOExXq@aschofie-mobl2>
References: <20240604003609.202682-1-alison.schofield@intel.com>
 <665f5337939f5_2a90e294f2@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665f5337939f5_2a90e294f2@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Jun 04, 2024 at 10:47:35AM -0700, Dan Williams wrote:
> Perhaps change the subject with: s/Avoid/Fix/?

OK

> 
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > cxl_dpa_to_region() looks up a region based on a memdev and DPA.
> > It wrongly assumes an endpoint found mapping the DPA is also of
> > a fully assembled region. When not true it leads to a null pointer
> > dereference looking up the region name.
> 
> Can you place the a snippet of the Call Trace here, that helps support
> that the writeup came to the right conclusion, and it helps folks
> hitting this error to find this patch in a web search.

Will add in v2

snip...
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 3c2b6144be23..88051bb673bf 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2688,22 +2688,33 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
> >  {
> >  	struct cxl_dpa_to_region_context *ctx = arg;
> >  	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_region *cxlr;
> >  	u64 dpa = ctx->dpa;
> >  
> >  	if (!is_endpoint_decoder(dev))
> >  		return 0;
> >  
> >  	cxled = to_cxl_endpoint_decoder(dev);
> > -	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> > +	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
> 
> Why add the !cxled check? to_cxl_endpoint_decoder() only returns NULL if
> someone messes up and sends a !is_endpoint_decoder(@dev) to this
> conversion routine and that check was already performed above.
> 

Abundance of caution I suppose.  I'll remove.

> >  		return 0;
> >  
> >  	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
> >  		return 0;
> >  
> > -	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
> > -		dev_name(&cxled->cxld.region->dev));
> > +	/*
> > +	 * Stop the region search (return 1) when an endpoint mapping is
> > +	 * found. The region may not be fully constructed so offering
> > +	 * the cxlr in the context structure is not guaranteed.
> > +	 */
> 
> Comment looks good...
> 
> > +	cxlr = cxled->cxld.region;
> > +	if (cxlr)
> > +		dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
> > +			dev_name(&cxlr->dev));
> > +	else
> > +		dev_dbg(dev, "dpa:0x%llx mapped in endpoint:%s\n", dpa,
> > +			dev_name(dev));
> 
> ...but I am not sure gymanistics to improve a debug message are worth
> it, especially because all of the callers either emit the found region
> in a tracepoint or print a warning, so I would just be in favor of
> deleting the debug message altogether, or at most just trimming to the
> "mapped in endpoint" one.

Yeah, probably went overboard here. Previously was offering the name
of the region so wanted to keep same - but seeing as this is a debug
only message, I think the endpoint alone, as you suggest is good.

Thanks for the review,
Alison


