Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07EE1CCEDB
	for <linux-cxl@vger.kernel.org>; Fri, 28 Feb 2025 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778988; cv=none; b=nbGzfnOemzP5ShqbRpmhWJeSenR5lsAeCr71VslgPZhJWCN4NB5gXiEqNEOq5z0g1teQECG+xSbYRquLbQmv+F/G9FXPdD9+HZ0AzuMcGuSdNFnATFAupMGJy+BIQwsGbibpUFfpnX11cWiPMsiOxjbNiJvYtQ6oaFzjOSf+L7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778988; c=relaxed/simple;
	bh=C5nQMJVQk9JYr0RH6VbBrchI1eltyCTnzemS3XBjLYA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hCn8IkhlE0sOQNi9AfuIycK2vFbnezcRdWg/UxBtDqGoV9UZoDej6Gm3zW0QKMfU4FfKZwf4p9OBBEozEvglNKf6vz+qHLoeyiBuAvvOGjzWW6yX2Ugva9bJdJF4ORdHnzvt8XAj5rRW6/y28UROy9MTL5CMtnK0m7DwnUWemdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDIA+3+Y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDIA+3+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740778986; x=1772314986;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=C5nQMJVQk9JYr0RH6VbBrchI1eltyCTnzemS3XBjLYA=;
  b=CDIA+3+YWkzEcX5ykuT5Mj4Zm9p+pIWmVDw8s113OVL8j9IbKSXFnC11
   Ip4xIalFEMkYfyKoJtLkAqSQO9H8Ir4sYXy9LBIDzDdMSP6awBAVj2GMf
   e/jwCRxGIonqnNQmghOjrl22eWqph9o0ctCSCqKFJ4xGcvxU2JYfcPMp3
   hOp8RaQljFHva58dlHN00brCheHFEhL5BiZ5VgpVFsb2fwRBTqMwYfS46
   kxQwxKrsEZYNoI0U4mHOIOX+ogLYnMakWnzW3WembX9dGF+s+5Ofe4JOp
   bPAyyQB+e5sSVH7ZgqnpJQZDhiH59swNiP06a7uGDbTMsL0TDLg3eGasu
   Q==;
X-CSE-ConnectionGUID: 3ZL5mtc6Ru6nibOba8t0TQ==
X-CSE-MsgGUID: 9+AOXsvgQKGq9q3kD8iTDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52355066"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="52355066"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 13:43:05 -0800
X-CSE-ConnectionGUID: 2sHuXhDwSWm2jqvzcFCplA==
X-CSE-MsgGUID: CVkmqPBbTZCWOEFQIIyldQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122582290"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.153]) ([10.125.108.153])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 13:43:05 -0800
Message-ID: <65001ca8-0e14-440a-a442-d7c8e6e6d04f@intel.com>
Date: Fri, 28 Feb 2025 14:43:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vv2] cxl: Fix warning from emitting resource_size_t as
 long long int on 32bit systems
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
References: <20250228204739.3849309-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250228204739.3849309-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/25 1:47 PM, Dave Jiang wrote:
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

Applied to cxl/next

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

