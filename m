Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E913957B
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717040586; cv=none; b=PbD2qHMjB/UkES6JGZ/kK+Bt9quOYCvmKe8hwscQHA97f5ptnL9Qbi/rsxRioEY2hEDJd22v+8MBEWmZ7aHv1OxGYTHTUkkiWcgUQs1mKxOtAKt208BUMvEhwpF4FZWIH/lQukCC+z0UACLSNWQPIbYXgClo4je67fNqgY4BtKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717040586; c=relaxed/simple;
	bh=HlOXLo/FIfp2cd8Poyjjp4s5cYCeT+Dwx5InUrdV0G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKIvhQCiDrR6GS+BNvDDUH6JrfHcYW2PqPoMfekN4oRvV9Fyt4nbi8gb25fNkVBfINBkN+gKiwGTIKokL5wqeVaNT717DzoNA9U+Idj5vSPj3ByQvzTzvEBN9tV6bojxBfgFGF+yDT9PAjZUxoTz+09U0hS6SY0/aiw+OZHOaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YN1qI6Qy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN1qI6Qy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717040585; x=1748576585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HlOXLo/FIfp2cd8Poyjjp4s5cYCeT+Dwx5InUrdV0G0=;
  b=YN1qI6Qywbj+7YWct2Bw+OYa223oGtwTKXzsvYe2D/FBm/lZc+Tf3ZIG
   XM/G0IEKirtEEjg7s1I01p+J8saISdck1X6PBeCKqvWDlK2yOpfnzBwhA
   YynJLQcbRU7tobtToG3Ie352EZs9YiqhwUYwRQecMQrZOjFEWysnIpP8J
   VVftLsKRoS1MYWbbWWCXt4BbfVMrS0MDpJjtKa4jJSicZT5sDCCfj+bm4
   LUKxTHiIkq3FLmzn8iBYsTUv09qOWBonU8eumpT2eVH1965SgWVacdRqH
   doEMxRZh8ck4q+/LpbpZN5eee/mdATIaGz/vE07Be0Fq5CtpfVxOC0mqf
   A==;
X-CSE-ConnectionGUID: z5621V9YQfOkQ6sd633EVQ==
X-CSE-MsgGUID: PCFFuTVJQRq6N5rdqc/eTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13615714"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13615714"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 20:43:04 -0700
X-CSE-ConnectionGUID: DpWUVQ0lQQORzsaz67DIrg==
X-CSE-MsgGUID: MrGI2yiqS6yqukHCRADXGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35725510"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.164.97])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 20:43:02 -0700
Date: Wed, 29 May 2024 20:43:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Foryun Ma <foryun.ma@jaguarmicro.com>
Cc: dave.jiang@intel.com, dave@stgolabs.net, linux-cxl@vger.kernel.org,
	rrichter@amd.com, angus.chen@jaguarmicro.com
Subject: Re: [PATCH] cxl/core/pci: Move reading of control register to
 immediately before usage
Message-ID: <Zlf1xa3O0DNu8Tv3@aschofie-mobl2>
References: <20240530013216.491-1-foryun.ma@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530013216.491-1-foryun.ma@jaguarmicro.com>

On Thu, May 30, 2024 at 09:32:16AM +0800, Foryun Ma wrote:
> Relocate the reading of the DVSEC control register to immediately
> before usage and avoid unnecessary PCI config access from the read
> if DVSEC capability check, hdm_count check, or device validity check
> results in failure.
> 

Thanks again. I like DaveJ's suggested wording better than what I
offered.

Please follow-up with:
- needs to be [PATCH v2], a changelog, and recipients list update.

These are described in the kernel documentation for submitting patches [1]
Check out the section of Responding to Reviews also.

FWIW - here's a sample usage that gets the recipient list for a HEAD commit: 
$ git show HEAD | perl scripts/get_maintainer.pl --nogit-fallback --no-rolestats

[1] https://docs.kernel.org/process/submitting-patches.html

> Signed-off-by: Foryun Ma <foryun.ma@jaguarmicro.com>
> ---
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
> 
