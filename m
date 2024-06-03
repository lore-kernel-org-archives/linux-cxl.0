Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A30130AFF
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429956; cv=none; b=kI2DwWPlMm6+X/7GasD0djCODuoXB6DvOjphQ1lHccD8jkUXNOjOkgNMsJYV2Jr+z6hwZKywepaYKmej9jFAm8a75Q5CJEHX2G5FjnweLoro1jY5iFhsDWU5RXYyA31wZDsP7dFuFu6mcyLQTPlVZOa1I9VJhOZymDqqUFfZmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429956; c=relaxed/simple;
	bh=kxpqA398KxYRscQ0q+eOKKEWyaM2v9WSnxg+eJxspIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USOcG0WRkIpSzdD8aiUtSlYqidu4VRIQ8O/fuy4eERKDwpnIfHa0+9YMEs7aAU/p6/ydHCApWSkzpaS/fkFlMDFfTUteypTspsmqWYJAapF5QIsOB/xjrqR2dfJa74Bxx2nWKMJfBFbhw/fLs3XWqQ0zFhJ7xTSueRl5Ku4w/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGzxpBM1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGzxpBM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717429955; x=1748965955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kxpqA398KxYRscQ0q+eOKKEWyaM2v9WSnxg+eJxspIQ=;
  b=SGzxpBM1eGhsj0jvLBcw05q8lYjlfPQmWWM/uFgkZsemJ4VY6tQOAFvF
   oOJ5tliHXCOEOkYmkSx24+x/vXZsLmHH2bKWtfNtVrGJVLhYTZj325Q6T
   6texFHsDxjL0QX4hByJtrTSl7DqcD7aCrPgGgUrse9hqAtA4BEKcXVPHb
   viX7Hs1nNFnj0ulGFhuM5Bn9z/MulEsPnh1Vk0PDc36Haqt4LLpp1HZUd
   NHH3dfh/UhMeVKPhvzHYO+kecKHAzorepBk9vEQCsFwU44eQIRNP2us4q
   aWY1Y9ipCZ9nQe21Wwj24+Zgz8BuV8+/6AqKBzqSE7QbdfGq26AtmmmNA
   Q==;
X-CSE-ConnectionGUID: O96mD5zLTmi8jZN9stIHiw==
X-CSE-MsgGUID: YLHY1iEDRRuRNjvSx0AG/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14055968"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="14055968"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 08:52:34 -0700
X-CSE-ConnectionGUID: RYH0YMd2R+SB2Z2Lys3Idg==
X-CSE-MsgGUID: /pZoqMJhRhqO0d7iOzmCnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37549950"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.116.181])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 08:52:34 -0700
Date: Mon, 3 Jun 2024 08:52:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Foryun Ma <foryun.ma@jaguarmicro.com>
Cc: angus.chen@jaguarmicro.com, dave.jiang@intel.com, dave@stgolabs.net,
	linux-cxl@vger.kernel.org, rrichter@amd.com
Subject: Re: [PATCH v2] cxl/core/pci: Move reading of control register to
 immediately before usage
Message-ID: <Zl3mwH0kGEiDatp9@aschofie-mobl2>
References: <Zlf1xa3O0DNu8Tv3@aschofie-mobl2>
 <20240530064751.586-1-foryun.ma@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530064751.586-1-foryun.ma@jaguarmicro.com>

On Thu, May 30, 2024 at 02:47:51PM +0800, Foryun Ma wrote:
> Relocate the reading of the DVSEC control register to immediately
> before usage and avoid unnecessary PCI config access from the read
> if DVSEC capability check, hdm_count check, or device validity check
> results in failure.
> 
> Signed-off-by: Foryun Ma <foryun.ma@jaguarmicro.com>
> 
> V1->V2: change the subject and commit log, suggested by dave.jiang
> 	and add change log, suggested by Alison Schofield
> ---

I see the value in this patch as a cleanup because despite what a
reader well versed in this area might know (PCI config cycles are
cheap and these failure conditions are unlikely) the code breaks
a basic pattern - read then check, don't read, then check later.
You calling attention to it makes all of us better reviewers, and
if we don't fix it now we may see this patch again from another 
reader.

If you want to continue the submittal, please do:
- incorporate my feedback from v1: move the check to after the comment
- Post a v3 as a new message, not in reply to this message.

With that, I'll offer my Reviewed-by tag and this can be considered
for upstream merge.

-- Alison







>  drivers/cxl/core/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8567dd11eaac..627be83881e9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -338,10 +338,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  	if (rc)
>  		return rc;
>  
> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> -	if (rc)
> -		return rc;
> -
>  	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
>  		dev_dbg(dev, "Not MEM Capable\n");
>  		return -ENXIO;
> @@ -363,6 +359,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  		return rc;
>  	}
>  
> +	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> +	if (rc)
> +		return rc;
> +
>  	/*
>  	 * The current DVSEC values are moot if the memory capability is
>  	 * disabled, and they will remain moot after the HDM Decoder
> -- 
> 2.34.1
> 
