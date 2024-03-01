Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0014411
	for <linux-cxl@vger.kernel.org>; Fri,  1 Mar 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320803; cv=none; b=E4l6H0OFPkEjM6K3gONDKdId9ebCb0bhl14RuVMVHAE7+BCslyYa1ErWFNzvTcT3wTLuPcQggBNFunPCcxhYCu7uz+zlEt2sQCulm0c/sgsAm/yH+bgQj4THIv9reCUQSBdPdR5kwmec7AV/WTdiTheqGIuFyRSwiy30GvCLXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320803; c=relaxed/simple;
	bh=DrxODs7MeihmjCwmWWP/Iw1ZvFV1oq5Kdb3ANBYJxow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyl3Uqii+GscpfrJUBRZFqenMMLl9XpGbw9cwqpzlokujYNufjj6C+iZf2Cnx2cPS/nyfbAfcVp1RukwhRw/9i1hBdr/e/EzZPRGUQ6OBm7fJgYiJycELnQ+nS3MnQMyTgzi/hmNZRo5GlPm1oPsFqGjkDGfU7E7ZlpuvPTbc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TI/mzzFQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TI/mzzFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709320798; x=1740856798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DrxODs7MeihmjCwmWWP/Iw1ZvFV1oq5Kdb3ANBYJxow=;
  b=TI/mzzFQolwJqWEnp1tBECVFae8HCph1wCceHAzTbhXdvuhFapkDHQ1u
   eYVjr/cCKWzM4U6muGAmt65Uy6SSoGODFA/XX6vHoPALgV7EXQCzf/Wkc
   TkIFoc9wzLCbcV92eOxFN7NDUytTgOCo5oiMkUZk2rfARyV68184SX0+b
   5MlqWw4U1uQtpd42J6rwOw431+ELePcOaF8iMnyeUPA+c7lY/3FGOe9Up
   GnqSXWG05zTSKRemdNnQOP7KGhaHQkBwiR2s45/7cWCAuU1JhPwmSdq2u
   dNRp6m5iVaPEqsaO/irVxY5ZEqtDlYMQx/OE9lXdYjG2g/sgS3Xx+IbFx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7694287"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7694287"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:19:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8251064"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.20.131])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:19:57 -0800
Date: Fri, 1 Mar 2024 11:19:55 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] cxl/acpi: Cleanup __cxl_parse_cfmws()
Message-ID: <ZeIqW6zIR5Ykmnkn@aschofie-mobl2>
References: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>
 <ZeIekICjXpqVUrUG@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeIekICjXpqVUrUG@aschofie-mobl2>

On Fri, Mar 01, 2024 at 10:29:36AM -0800, Alison Schofield wrote:
> On Wed, Feb 28, 2024 at 12:30:56PM -0800, Dan Williams wrote:
> > As a follow on to the recent rework of __cxl_parse_cfmws() to always
> > return errors [1], use cleanup.h helpers to remove goto and other cleanups
> > now that logging is moved to the cxl_parse_cfmws() wrapper.
> 
> one question about helper below...
> 
> 
> >
> snip
> 
> > +static struct resource *alloc_cxl_resource(resource_size_t base,
> > +					   resource_size_t n, const char *fmt,
> > +					   ...)
> > +{
> > +	va_list ap;
> > +
> > +	struct resource *res __free(kfree) = kzalloc(sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return NULL;
> > +
> > +	res->start = base;
> > +	res->end = base + n - 1;
> > +	res->flags = IORESOURCE_MEM;
> > +
> > +	va_start(ap, fmt);
> > +	res->name = kvasprintf(GFP_KERNEL, fmt, ap);
> > +	va_end(ap);
> 
> Why is alloc_cxl_resource() defined w variable params and using
> kvasprintf(), rather than tailored to the one caller and used
> kasprintf()?
> 
> Perhaps you have bigger plans for this helper?
> 
> Other than that,
> 
> Reviewed-by: Alison Schofield <alison.schofield@gmail.com>

oopsy...
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> > +
> 
> snip
> 
> 
