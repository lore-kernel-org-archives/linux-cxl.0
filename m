Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33D36AB6B;
	Tue, 10 Mar 2026 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176013; cv=none; b=kUqm25QvL3FXUV9mn1sCWtNB1iAYt2focWdeU6XuA8RZZIZu0FCY6SvMmuTnBH6ObmtyHSjfqmEIEr9mDyAvraj5o2fvImYkz9IUNOJN5Ev2j6in0a3HPTeu5YcnOZ6f4JtDQjgby89uYVsc0JYflnMWyR608mu4UfJG6V2ZxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176013; c=relaxed/simple;
	bh=XjgbHG3+bY+m5/EqVhFiacMUIZTgRuvCTMrdWRiuymU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDfwxG8sOj8qefJRjFPIRN92LKh55zqkYk5ZndTEnLO1KiL4TM3ctkTpNicnqS3wp0s3VBq0RrbJiWhBLCw/Ifq4BBZKncmxdTyeM1/FzEeRzHkrYO4f+1OzXZVp3McCHhJILCID5aGXFkJ8fUfxCLTdLMT4o3vSS+JxRuCPhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LppxghGq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LppxghGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773176012; x=1804712012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XjgbHG3+bY+m5/EqVhFiacMUIZTgRuvCTMrdWRiuymU=;
  b=LppxghGqfpDsP8bgEu8yFjZSZEsrxq7YCEuoe17vqdUVgcMQid+nyPlQ
   s87QbWzhLkCPzYuLYOePu2CrFrSFlpY6UVjx/i7SmTNI/dwOIbf6F+Ebf
   ybZZLuZw1Iw9XyXXtflGTQIF2BqwwH6psdAA3D4/USbMu4qKPtI1jlLbT
   pdBxYA68yfa/t2xmHjtoTjfQuYKT25c7a5uYVOCJb+lJQKr6VIMK/uDL5
   wTMXElYhG82tNsbWcOmiHqEN3nqOvHo4jKqSRvt6pA+gmj6bfxwjQgVuo
   l2wcBi0aUoDx0F8fCil+v3CK7C/m2W9uGZKNeG4eDRYpIlrHCwRCb3OuC
   Q==;
X-CSE-ConnectionGUID: SfnXPz7FQ+CV04JCgeyiWw==
X-CSE-MsgGUID: zq2HfuyCRPeDT1jhhp4l/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85711951"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85711951"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:53:31 -0700
X-CSE-ConnectionGUID: HaTlWljNQYeJRE8YX4igfw==
X-CSE-MsgGUID: Dt5UyB3rSXCKBoTB2iCrfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216975314"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:53:29 -0700
Message-ID: <791eb867-4f60-4634-8776-b670a62a8468@intel.com>
Date: Tue, 10 Mar 2026 13:53:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] cxl/region: Ensure endpoint is valid in
 cxl_dpa_to_region()
To: Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-5-94fe919a0b87@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-5-94fe919a0b87@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/26 8:57 AM, Li Ming wrote:
> cxl_dpa_to_region() needs to access the endpoint of the given CXL memdev
> to confirm whether the CXL memdev has memory range attached to a CXL
> region. But it is possible to be called before endpoint allocation or
> after the CXL memdev probing failure.  In these two cases,
> cxlmd->endpoint is invalid.
> 
> To solve the problem, cxl_dpa_to_region() requires that callers have to
> hold the given CXL memdev lock, it guarantees the CXL memdev probing has
> completed. And cxl_dpa_to_region() will check the given CXL memdev
> driver binding status, if the memdev has bound to the driver, the
> endpoint is guaranteed to be valid. This checking also requires the CXL
> memdev lock held.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/core.h   |  4 ++--
>  drivers/cxl/core/region.c | 11 +++++++----
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5b0570df0fd9..fa8402be860f 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -47,7 +47,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
>  int cxl_get_poison_by_endpoint(struct cxl_port *port);
> -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> +struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
>  
> @@ -58,7 +58,7 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
>  	return ULLONG_MAX;
>  }
>  static inline
> -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
> +struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	return NULL;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 806512dfab07..c555e3ae8b62 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2947,16 +2947,19 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
>  	return 1;
>  }
>  
> -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
> +struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	struct cxl_dpa_to_region_context ctx;
> -	struct cxl_port *port;
> +	struct cxl_port *port = cxlmd->endpoint;
> +
> +	device_lock_assert(&cxlmd->dev);
> +	if (!cxlmd->dev.driver)
> +		return NULL;
>  
>  	ctx = (struct cxl_dpa_to_region_context) {
>  		.dpa = dpa,
>  	};
> -	port = cxlmd->endpoint;
> -	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
> +	if (cxl_num_decoders_committed(port))
>  		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
>  
>  	return ctx.cxlr;
> 

