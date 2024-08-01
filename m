Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277914BF97;
	Thu,  1 Aug 2024 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476157; cv=none; b=LLnM+4g8AXzIa39IN1g+/BHe7chDCBgTCnC+dvPbqrv0iqrdLTJfGnlTrIsFVqO1O14LQSH4Z3LHXukQjJMbeyrf1fKTZeryty1bDkR2lvstuLLkoLr0J9xgocG6AEGJJNGwYFuOvmgZc3kFDPSZLI2tfpLY0zdxFE7h3NJ7/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476157; c=relaxed/simple;
	bh=OhLl8qgd07I52bmPg6uDCLhAsqFABCGpvXGulMClysI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTtFLsWaioXVi0pvTHZNq+vs/u5fW5C26s4SSReOFWZuMTWvpljuZXxSXwsKbXJ9IG16Hf3hGjZOy/HzbNbsJdkwfAc0uWMTUxbaX67hZcUfIdlL3zzl4j4fKziL32u8IKLw7tvE4ZDHUYzbi6JsvQ/Eot62NEB7CxJzbpSvkDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOdlYrb7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOdlYrb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722476155; x=1754012155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OhLl8qgd07I52bmPg6uDCLhAsqFABCGpvXGulMClysI=;
  b=EOdlYrb7tyX1wXGVGq25hrJ/zzB2CILlKOII7pi2QwX4eoqGo+534vsh
   dqU6Mq+k3r4Gi7UmBo1zZ3x5vO8JWKzs79T7nalP+hvyO6VBuBBfKBmaY
   xQloRTeCl/cuRdOaVNXISdnjAgE1tdEAQmPj3Fu2+Fs8PJfkuhclFfHGe
   iOHNZkUOxh4ZbuPAYqXpmycuprm7yOvtfOfc0u4oWN8InH0zNDaM05HJR
   +hitdnJUVDY1bSlc0wmDOnW12bJcKYvqwSjwASJ7H9MT9QVGI2uJKTaSx
   va6Hf6dWWIv3nc1U6PdDKyjZqIzaRJ3uTokGuCIwa0GE6LIZ6L/z3ZDth
   w==;
X-CSE-ConnectionGUID: 3WjnDsXeTzux4R8N0xudLg==
X-CSE-MsgGUID: sA6aji9DQ+aKQ02dIQ2aXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="30977044"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="30977044"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 18:35:54 -0700
X-CSE-ConnectionGUID: uyh47bvXTM2+/cTHbLqRBg==
X-CSE-MsgGUID: +fEmXeoFQ1WVKmRAe53z2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="85483292"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.12.57])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 18:35:54 -0700
Date: Wed, 31 Jul 2024 18:35:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH 2/3] cxl: Set target type of region with that of root
 decoder
Message-ID: <ZqrmeC8nKVR3Tksz@aschofie-mobl2>
References: <20240729084611.502889-1-ying.huang@intel.com>
 <20240729084611.502889-3-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729084611.502889-3-ying.huang@intel.com>

On Mon, Jul 29, 2024 at 04:46:10PM +0800, Ying Huang wrote:
> Now, the target type of region is hard-coded to HOSTONLYMEM, because
> only type3 expanders are supported.  To support type2 accelerators,
> set the target type of region root decoder with that of the root
> decoder.

Hi Ying,

If the target type of a region is always the same as it's root decoder,
(is it?) why do we store it as an attribute of the region. Can we look
it up when needed?

A bit more below -

> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..9a483c8a32fd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2545,7 +2545,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
> +	return devm_cxl_add_region(cxlrd, id, mode,
> +				   cxlrd->cxlsd.cxld.target_type);
>  }

Passing the 'cxlrd' and then a piece of the cxlrd (.target_type) looks
redundant.


-- Alison

>  
>  static ssize_t create_pmem_region_store(struct device *dev,
> -- 
> 2.39.2
> 
