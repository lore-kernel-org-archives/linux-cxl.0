Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71623F396
	for <linux-cxl@vger.kernel.org>; Fri, 28 Feb 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774692; cv=none; b=M3HkVqNUaX0UvlQlXUXLXZwkyZsySLB0enIP4wT2Uko8bnA/LREIqpnY5LxI7eBVnMdK/YZdgY9Jo3A3Kp/4Os+fEBA105DaqNXgPGOcTrlqjWsYOkKTaupAurWyznGLv337dy58CpWSa4ZwuTRedCPIdn3VmVnK9jL55ALjKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774692; c=relaxed/simple;
	bh=hKjEIvmC+Ggz2wCZjDKcQ7/Nls259PSHA/cFa8EFCO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN4fVFcXlPRf2Yvfbd7XHgH0enb2pu5zVbmZ3lJdfdvT/inD8LlQwwpyHvWOxzR7ZMfgbX2gdk6grC2dVgFG1QEhoHqEm1JozdVdz507PwIdxgWU5R2055MFQv22BeSfjVfxJBV7mNGcZwI6Qy9olIytIYhBwkwEstwTy/zHj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7PYpFnE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7PYpFnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740774691; x=1772310691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hKjEIvmC+Ggz2wCZjDKcQ7/Nls259PSHA/cFa8EFCO4=;
  b=V7PYpFnEgZbrzQlCm7c+kGlk3yozc/bygFniR9FyYKZzRCQU3bK51M5c
   cHG3V+hwapRUBDzj9Sx0QFi5r6sl8C73HC2F4SF0VfT1Y5QjS/TltLvd8
   +nDYnHjpEDzSRUrtGs5o+a8lbc4vhc82vQyEs56pa+M/kZIk3XHXvov+r
   a6W75yazuuIj0TIA+bTzXnOot0a6nY8fY+Djwu3CMEJoDCfQgC7zqIRBT
   iEk8X4rBZTKaRiH7VANv2pqVylBo+9fDMNv6Xcxp4fS8YK4t2qTkiS/+N
   ERRbkby7Dxegb/tgf5x3TEetPcnHFWYUyrQd7zPi7oUQWK4CQheEmrL+X
   A==;
X-CSE-ConnectionGUID: GaZ1+Ki4Su6ORe3wmqXliQ==
X-CSE-MsgGUID: uqTowbuxReKF+7xzLsZtvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52702895"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="52702895"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:31:09 -0800
X-CSE-ConnectionGUID: mjHpwI+pTAWxAVFQxSC+kg==
X-CSE-MsgGUID: KCVmQaIKQkOcJd7L4T38DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117461331"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:31:09 -0800
Date: Fri, 28 Feb 2025 12:31:07 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] cxl: Fix warning from emitting resoruce_size_t as long
 long int on 32bit systems
Message-ID: <Z8IdC2dbdWcqlg4O@aschofie-mobl2.lan>
References: <20250228194402.3745766-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228194402.3745766-1-dave.jiang@intel.com>

On Fri, Feb 28, 2025 at 12:44:02PM -0700, Dave Jiang wrote:
> Reported by kernel test bot from an ARM build:
> drivers/cxl/core/region.c:3263:26: warning: format '%lld' expects argument of type 'long long int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> 
> On a 32bit system, resoruce_size_t is defined as 32bit long vs on a 64bit

'resource' here and in commit msg.

> system it is defined as 64bit long. Define the variables as u64 instead to
> make the size same across all archs.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503010252.mIDhZ5kY-lkp@intel.com/
> Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a83301f24fa2..958c15842b1e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3235,14 +3235,15 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_region_params *p = &cxlr->params;
>  	int nid = phys_to_target_node(res->start);
> -	resource_size_t size, cache_size, start;
> +	u64 size, cache_size, start;
>  	int rc;
>  
>  	size = resource_size(res);
>  	if (!size)
>  		return -EINVAL;
>  
> -	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> +	rc = cxl_acpi_get_extended_linear_cache_size(res, nid,
> +						     (resource_size_t *)&cache_size);
>  	if (rc)
>  		return rc;

Ah...I was thinking this fixup would be either a %pa format or (u64)cast on
cache_size in the dev_warns, but this works too.

Do we also need to do this to avoid a complaint assigning to cxl_region_params:
-       p->cache_size = cache_size;
+       p->cache_size = (resource_size_t)cache_size;


>  
> -- 
> 2.48.1
> 
> 
