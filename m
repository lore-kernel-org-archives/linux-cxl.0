Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6723F38F
	for <linux-cxl@vger.kernel.org>; Fri, 28 Feb 2025 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776288; cv=none; b=s8PX1YVGUhENqQ3WD12CXf/Nw6/dcgfhFuAKkUquTc8193NArPY0ZlYYWTur9HZP07nztPla9AinS0SW3A8/QPXrTiW/o1uSez3X9EiV4FCr+GnDJToY8RRPKy5pZZUaDPt206MUfFsYseIpSvYMPARioPrU7heOH5yeaBdfixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776288; c=relaxed/simple;
	bh=EZTPs7oYAx17yyNOQQA49s2FgvokKWbA6iRIuzyM39g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGMcen0WSZkF1EPbNu2GRdlalP0vDOQM1rX7RFyZjZjFnx+VZdRAArXaN3OboWk5nYt2tFryB9sLv+TALzBS1WvtuTNdMghHCPtNrxDcvSxp12Z+9a1OjG+kqD1tpnMNEw+7dF10pH+71p/ut8Va7sH340+PTDCt5exhjBmYYi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGI23yUD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGI23yUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740776287; x=1772312287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EZTPs7oYAx17yyNOQQA49s2FgvokKWbA6iRIuzyM39g=;
  b=NGI23yUD46/WOKTc9W+U7zHpPPpoQqPcFfGiJCLshES3YxTGBVmtz7RM
   gjEpOxeKk2g06qs2RUa+/suxffDRGsS25UYCr9Ck8kuXC5hcWk4xUfWJJ
   VnISYy0wqr3+0y/0xGrBKpSIHvDBDXXgh+PFddvzLRCDANGtIiYNVS+gi
   pgvLe4wiP6+OQ8XdN4PketWo/79fPbh4wdEN4MrtHjT9z+5+1VsQJWbY3
   fn7PaTsX7LgHSuAzQM+Sb3jF66m43UbRgUheeD6mMGm9QI2r6LCH04ZQB
   lKat54Gnuj2ZyKnTzvkEo2KfstXfwMBjaQB74vMUCNCtZxcbPZopxA9OH
   w==;
X-CSE-ConnectionGUID: 7m3E77W9Q+GPtKK2qAyobA==
X-CSE-MsgGUID: yN2Vy+CCQjG0nVzKerQuZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41910207"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41910207"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:58:06 -0800
X-CSE-ConnectionGUID: DT25HYrXTFu5OKxAo/IwDg==
X-CSE-MsgGUID: Oj6rDVlZQ3WrZwZRtjqqMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117194473"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.168])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:58:06 -0800
Date: Fri, 28 Feb 2025 12:58:04 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH vv2] cxl: Fix warning from emitting resource_size_t as
 long long int on 32bit systems
Message-ID: <Z8IjXCwYSpNhVM27@aschofie-mobl2.lan>
References: <20250228204739.3849309-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228204739.3849309-1-dave.jiang@intel.com>

On Fri, Feb 28, 2025 at 01:47:39PM -0700, Dave Jiang wrote:
> Reported by kernel test bot from an ARM build:
> drivers/cxl/core/region.c:3263:26: warning: format '%lld' expects argument of type 'long long int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> 
> On a 32bit system, resource_size_t is defined as 32bit long vs on a 64bit
> system it is defined as 64bit long. Use %pa format to deal with resource_size_t.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503010252.mIDhZ5kY-lkp@intel.com/
> Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>



> ---
> v2:
> - Fix commit log spelling errors. (Alison)
> - Use %pa to deal with type resource_size_t. (Alison)
> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a83301f24fa2..8537b6a9ca18 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3251,8 +3251,8 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  
>  	if (size != cache_size) {
>  		dev_warn(&cxlr->dev,
> -			 "Extended Linear Cache size %lld != CXL size %lld. No Support!",
> -			 cache_size, size);
> +			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
> +			 &cache_size, &size);
>  		return -EOPNOTSUPP;
>  	}
>  
> -- 
> 2.48.1
> 
> 
