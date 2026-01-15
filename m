Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7E3C1974;
	Thu, 15 Jan 2026 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499904; cv=none; b=gv5L+M6EHNFjS4/8zqDkOENKgNR2YbzitF3tlMnECwrmOBNBohNY8ZA6YyhvRDG1a64vaCkRlVuukGkL2iK4Zdy8itzJ7hohYFnvWXS+ZeF1c5+RsV5VWdMujFiAAvWi2RZBaYzJfEwnBD6OSr1qBp6LLm6YGEqul+ll586fVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499904; c=relaxed/simple;
	bh=65GD8xi/IxjR27B+rk/Owu31NA5ArG+n7jXk9yRwmuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1oC96gs5A663PFMQcKza7zCqzeXWlFaUQqLBiH09ygEr6o3+lEBcV7p/ORZHzgwwf8FREUTXcC0JBHfRrYW7PdY4Fgpue7lQXY0mPjBIrT4s9i4izTOfDalfaxJneLu+MgcQjqrDcasjY7ouZt2DlOPSM7NKgemXCodLlHa/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cB6FG0PI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cB6FG0PI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768499903; x=1800035903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=65GD8xi/IxjR27B+rk/Owu31NA5ArG+n7jXk9yRwmuE=;
  b=cB6FG0PI4ThKeHIRUUYD09LvG8wKMIUB5AFuLXxaS0taoxjAvi36OtkW
   bLomp5Bj6jFexDymyKipc/KO/Au5yssMCoD90t8Dth8bzRs/sfVD/TTxb
   HKmH6S+3nYTpUxz4Y70EUVPxqZDGXh2/D1u5Q08AR9NthCMHPMloKioAD
   wYtlDzYVYhwz2+HEJJeMhUPXbTShCf0Cyvx6bMY9il/JWWSEN1QQuSWem
   Hyhh3C8g9if0Pi/5mdyPkXGbACupA3lEeRQizvR3ysrJjvET+ijWinZdw
   uxReSsPmSRPcUgMSHEj/v5ZFJR8SWMQrr6g+QTetHP/l4E7nxA19f30bD
   A==;
X-CSE-ConnectionGUID: 3NdEHdi3ST6I8bKwmt1Trw==
X-CSE-MsgGUID: qOYQVfK4TY+FtxtXB1V7hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81258110"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="81258110"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 09:58:23 -0800
X-CSE-ConnectionGUID: ivvjGdewQ1GrrQkH0h4cnw==
X-CSE-MsgGUID: B51Ne39nTG+xBEWzZHmlPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="235719396"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.80]) ([10.125.111.80])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 09:58:22 -0800
Message-ID: <ac0bc413-10c5-42a5-8630-53c02f2d3fe6@intel.com>
Date: Thu, 15 Jan 2026 10:58:21 -0700
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

Applied to cxl/next
b4692385bb68b75c808a5b428ec9a5e8c5c9679f

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

