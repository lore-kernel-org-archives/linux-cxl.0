Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB5201270
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000241; cv=none; b=UFpmBDuKjqh5VmwsEFznZbs2LRdCSCP5Ibr4yRBv0uDrMVEPIR9k10CJ7bQthNUUS4HLxx7j758iCbxWBqgiSpN2YXJlCAGTkJsNHsIhfsO91Lvr7a6r+JHgyDzbwBFkWjFqEc7AcUcQBjQ6VMdP79BYLzjcZah8MqAOc7HwhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000241; c=relaxed/simple;
	bh=rf+JAQlMX3w4WNixNA0YLEawv44gnQSBDA+a301zCEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOiaMykGBk8OX+ThJFt7eRSwhyozgRlDn3mvlHlcFmO89gP2S3dheBUFH4+ZD6WbHNNwKOG1VSzSztOaoDTmgiaiCysV9RRrX/M95w4zMykYnq0PEkX6zzHVdlYAsaAtYD27xagj2puShD/rQcIYc4y4tolYimIl1qZ13A5cCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leAmvcZS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leAmvcZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717000239; x=1748536239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rf+JAQlMX3w4WNixNA0YLEawv44gnQSBDA+a301zCEw=;
  b=leAmvcZSHFuMaXMBRbIQyVIgKd29iHM+5B7LwejNPuZjQzs0h4o5Wfk6
   42lHJyJ1XvHpNuy1a7prUHnkb4dx6+Dmpg0QoIUrmtIcm/Ie7HBHl0AYE
   uRShx8CBeWmzlcneQi4gr24mbGMp5GSpv1KhQhoVjZm2FenqYB3YI2OGP
   tcd9qrfB/jDkESHO1UaJvYpcu0StGgJOsGLl01LhQjnSDz48auPb0lUZm
   Iw1548+lygIF/AyrWbOSZn+lB05U27D+ZNmjt3Pf/fJDcP2UhQKnwSTma
   pZNExGpQoVZe25J76LEWmgKeEzj57lJBtB98luUXTC7kGjDLaVr07JASG
   A==;
X-CSE-ConnectionGUID: l72zmPtqScqh0ElVSqhuEw==
X-CSE-MsgGUID: wCcKzr0lSSqILM0Rn4tTGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13583442"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13583442"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:30:38 -0700
X-CSE-ConnectionGUID: YBosBNIaQh2U3lIutOkOPQ==
X-CSE-MsgGUID: cTjtLeuGQ4WADpvynNvX1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35559475"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.164.97])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:30:38 -0700
Date: Wed, 29 May 2024 09:30:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Foryun Ma <foryun.ma@jaguarmicro.com>
Cc: dave.jiang@intel.com, dave@stgolabs.net, linux-cxl@vger.kernel.org,
	rrichter@amd.com, angus.chen@jaguarmicro.com
Subject: Re: [PATCH] cxl/pci: the ctrl register should be read when it is
 being used
Message-ID: <ZldYLCxCyLwSzx5R@aschofie-mobl2>
References: <20240529093354.409-1-foryun.ma@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529093354.409-1-foryun.ma@jaguarmicro.com>

On Wed, May 29, 2024 at 05:33:54PM +0800, Foryun Ma wrote:
> When the cap register and wait_for_valid checks fail, the ctrl register
> read will be redundant.
> 

Thanks for the patch. I suggest updating the commit message to match the
style of cxl/pci.c, something like:

cxl/pci: Only read the ctrl register it checking contents

A bit more below -


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

How about moving the read a few more lines down. Put it after the
comment so that it is directly before the check.


>  	/*
>  	 * The current DVSEC values are moot if the memory capability is
>  	 * disabled, and they will remain moot after the HDM Decoder
> -- 
> 2.34.1
> 
> 
