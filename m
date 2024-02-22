Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E62548F8
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629754; cv=none; b=HDdTiHCOO3EAIvmKq48LJfcOMibJXesmD7sC5Xc4Gf70NYBpQ16eahw0ZhRx3ucZoN6U/35q0zL2eLSWyV/BzDXRCVvQAw3hmDySFx3qPI5vpZKQmuwx4f85bepKd68Dai9NOVdgHtQwB8IV7PSmyNHHlC2yKWvOnEY5ddP/OmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629754; c=relaxed/simple;
	bh=AYRWL+oS7FMKpzu4aqQNTreHr35WryQwWRjqX0HAnX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QX1HOUGLh0ktEP4NpXvDF8MhHNNgtJodzTbS8IS8kUEgCV1GutD2mOF7ITxa/BjnHQIigmJtpXYmG444lcOnIkkxuHorgFTm2LWZwa8cFq0Yde1CUy5UkC4eqHRhL7gmRJQSyWDXRymsOizqamCeOofK8T911Bew68Z2+ncYu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7sZS0lr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7sZS0lr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708629752; x=1740165752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AYRWL+oS7FMKpzu4aqQNTreHr35WryQwWRjqX0HAnX4=;
  b=H7sZS0lr7dsp8/TAvNrD2n5qBHekV8cp4HNzrDmQsRkg07VWQI0l9K5f
   VL/4MwVpxnnOBzvDgna6baM6B/dYB0tUzrKMsddBMZ0+Iv5+m0vs2jLOx
   5m2Z/4uIo1y7dT9qWvCk3e5NyEXybv5D/Khc2nT/qdolVs8IZ3xyyXRuK
   cI+XnldGFd4iPcQskAOsjQ6dVHC+jIzLkfdDGajiMYBz2yhNzuaAVzadv
   pWMfYtityhkabFxuG0eadq5L/fzTDl5lwsiW5mzET1e2T+t9zBax4IMlq
   S8CFsiXXREbJuzUqspzo8t5StCmnlW3QPENy2eFHXiIpe/ZLOaO5lgb5v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3041562"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3041562"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="36407770"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.29.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:22:31 -0800
Date: Thu, 22 Feb 2024 11:22:29 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Hongjian Fan <hongjian.fan@seagate.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] Defer dax when CXL window is the child of the soft
 reserve region
Message-ID: <Zdee9bI3Dnr98Jlm@aschofie-mobl2>
References: <20240222210612.15689-1-hongjian.fan@seagate.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222210612.15689-1-hongjian.fan@seagate.com>

On Thu, Feb 22, 2024 at 03:06:12PM -0600, Hongjian Fan wrote:
> On some platforms, UEFI would present a single soft reserved entry in BIOS-e820 for multiple CXL deivces. cxl_acpi would add the CXL windows as the children of the soft reserved region.
> This change would allow proper deffering dax device creation to cxl region when CXL window is the child of the soft reserved region.


Can you explain more about how this appears as an issue.

The word 'defer' is typically used to say that we are postponing
something and will do it later. Is that the case here?

Thanks for helping me understand,
Alison

> 
> 
> Signed-off-by: Hongjian Fan <hongjian.fan@seagate.com>
> ---
>  drivers/dax/hmem/hmem.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 5d2ddef0f..a57b6ae09 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -58,6 +58,11 @@ static void release_hmem(void *pdev)
>  	platform_device_unregister(pdev);
>  }
>  
> +static int is_cxl_window(struct resource *res, void *arg)
> +{
> +	return 1;
> +}
> +
>  static int hmem_register_device(struct device *host, int target_nid,
>  				const struct resource *res)
>  {
> @@ -67,8 +72,8 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	int rc;
>  
>  	if (IS_ENABLED(CONFIG_CXL_REGION) &&
> -	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> -			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +		walk_iomem_res_desc(IORES_DESC_CXL,IORESOURCE_MEM, res->start,
> +		res->end, NULL, is_cxl_window)) {
>  		dev_dbg(host, "deferring range to CXL: %pr\n", res);
>  		return 0;
>  	}
> -- 
> 2.34.1
> 
