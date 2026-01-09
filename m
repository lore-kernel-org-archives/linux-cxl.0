Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331F3563F3;
	Fri,  9 Jan 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973990; cv=none; b=i0UivYrZt2/vNaDzBYYZrzYR4oMqOaHafu2XM3C14CrtPOnizlDpbupceleCuSnbjw+TxxEazijyS6pm3bFfboFQ9WGdU78+RJbLjR5iZyqwtvGFYwcfrR2ojwIe7P6U7hhVgcJeQCVSzc4dOdlJAEiQ6ER3gr8YHPZGgUZIfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973990; c=relaxed/simple;
	bh=uwp6a0KDk5LuWurUs5woBRhLQaQCD0gFrcuAinvzVSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgxLeib+DxnO4qIrbOtjvBJZ79b7QMOX5E4WMT2hizpnrASuwgXgrsuApddKRDYfmERoW7ZFOlLf/37fX9C+V0YmGF54lVlmWfeqSepFGyD16AVGwNF/yqTeaSH2EVUS30OOKPwACHcCiq3bwT9Xur9+EitGSLNTGkUTarIVk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bT200CUJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bT200CUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767973988; x=1799509988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uwp6a0KDk5LuWurUs5woBRhLQaQCD0gFrcuAinvzVSE=;
  b=bT200CUJ4mLMR+XO7Lk88/MjWQI4HRlKWqjlh4IyVxDws8mXWNtSI90H
   5hdpYnzYegEpEV5qze7LRrRJ6sp5a/jL4waO1eOQvNwckZN0QZO1Hre4A
   Z7HXXbc5nWzzTjFpCM3dzGt4hBkS5LDE7kM7JnWOdWoljm80y02/jd79l
   hXYBWWi6vPQ3BX32o7UcMf2ZkYkao94ZoNP5b9npEf9Dh6Y+1FFl8sprL
   +nnBwg+Z9+6MxJUxOuxy/m3DtH+tzUslw+A2SvVgr1ZMqZRFDewZaNUO3
   adfBoyR7mp40W0O/IILTVZs7Wen/hHt50zzjV75xzB3NpHPDC51eXljI5
   w==;
X-CSE-ConnectionGUID: Vo2EIjv9Qou3Kc7toJGONQ==
X-CSE-MsgGUID: fcFIPa2VRqKFPWhxu5iMzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="68360771"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="68360771"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 07:53:08 -0800
X-CSE-ConnectionGUID: RseqPFlZRiiHCxBhGdbGjg==
X-CSE-MsgGUID: 7ZC8ShgHSLmCx136ge6eNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203786771"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.37]) ([10.125.110.37])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 07:53:07 -0800
Message-ID: <eb8b98b7-1c56-415b-b0d7-a87f7a33701d@intel.com>
Date: Fri, 9 Jan 2026 08:53:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/acpi: Remove cxl_acpi_set_cache_size()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260109154042.331296-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260109154042.331296-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 8:40 AM, Li Ming wrote:
> cxl_acpi_set_cache_size() returns an error only when the size of the
> cache range is not matched with the CXL address range. Almost all
> implementation of setting cache size is in cxl_acpi_set_cache_size(),
> cxl_setup_extended_linear_size() does nothing except printing a warning
> in above error case, but cxl_acpi_set_cache_size() also prints a warning
> at the same time. So can consolidates these two functions into one, keep
> the function name as cxl_setup_extended_linear_size().
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Thanks for the cleanup. Should've happened when I moved it from core to acpi.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>



> ---
>  drivers/cxl/acpi.c | 29 +++++------------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 77ac940e3013..e65dfae42bde 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -357,7 +357,7 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
>  	return rc;
>  }
>  
> -static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
> +static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
>  {
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct range *hpa = &cxld->hpa_range;
> @@ -367,12 +367,14 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
>  	struct resource res;
>  	int nid, rc;
>  
> +	/* Explicitly initialize cache size to 0 at the beginning */
> +	cxlrd->cache_size = 0;
>  	res = DEFINE_RES_MEM(start, size);
>  	nid = phys_to_target_node(start);
>  
>  	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
>  	if (rc)
> -		return 0;
> +		return;
>  
>  	/*
>  	 * The cache range is expected to be within the CFMWS.
> @@ -384,31 +386,10 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
>  		dev_warn(&cxld->dev,
>  			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
>  			 &cache_size, &size);
> -		return -ENXIO;
> +		return;
>  	}
>  
>  	cxlrd->cache_size = cache_size;
> -
> -	return 0;
> -}
> -
> -static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
> -{
> -	int rc;
> -
> -	rc = cxl_acpi_set_cache_size(cxlrd);
> -	if (rc) {
> -		/*
> -		 * Failing to retrieve extended linear cache region resize does not
> -		 * prevent the region from functioning. Only causes cxl list showing
> -		 * incorrect region size.
> -		 */
> -		dev_warn(cxlrd->cxlsd.cxld.dev.parent,
> -			 "Extended linear cache retrieval failed rc:%d\n", rc);
> -
> -		/* Ignoring return code */
> -		cxlrd->cache_size = 0;
> -	}
>  }
>  
>  DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,

