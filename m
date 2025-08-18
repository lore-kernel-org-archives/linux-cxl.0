Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329C238C33
	for <linux-cxl@vger.kernel.org>; Mon, 18 Aug 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537081; cv=none; b=lAhuKw6+q+z8bstVrRgqxvOSwYNusyZiDNuJQRZAIqa6V7DRlEVa8RY9E4I8MWwNHAkhLqA70CnBcmUKmRE+w0c7rHqvH7m8XYJctv18m0J3aW2Yiu6jgw0oTNnCsGVRtlLWvCssuSU/ZoY0zUC15qe+ieSq4j/6KW6WzLtrDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537081; c=relaxed/simple;
	bh=VkU+wZQkPmEp16WbCV0zpMUNGiwkcI+/aWmT/kyU20w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hv6b6vKiO+sSAEEoB3AYbv1YcGb4B8XBWDTgGgVtnTDO89RmcMRlQmnyy27IWyQT9n76mFiGIiFZ5hR1Od0cdv/S6tflSJQoycKNbL3oXCeUzIaCIrB6SLiJOwRXO09omCLVE6UObytnSpfm0JgAAcLy1pyd902w0pT7WtjHUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0eIsdLO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0eIsdLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755537080; x=1787073080;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=VkU+wZQkPmEp16WbCV0zpMUNGiwkcI+/aWmT/kyU20w=;
  b=f0eIsdLO5lbcRZ0m2xoI3xUr4k3lPOIQr8sQZFrTwa0wDNGmnR1bXBRn
   oBpVSmUY16fv3/6K1N7Pc2wr9SXoj6jeBQHmFr66XUyAMWHMkoCFiURqj
   vi6MA3UnA4ilcA0uJNmM5ZYa6n4CILDNbw5A5MzbjIRbu1HzZs6BDclch
   JrousK1FjCme9lUEBopCcs68QkNWIWcLG+4a3Gjbpgn7eYNQxn/M9vdB9
   l3tTLsSsi69TcewYeYbCzuCXFMrTy5wJpJn+KfYLXKJctGL/7TpeopVXy
   qmV25fNqOmuhdY9BVCALbQmf0t06S2mfaC0KJ97JWDoMMAW+HELJjn/4O
   g==;
X-CSE-ConnectionGUID: OWaqREDaQh+LvoN7SdJ1Hw==
X-CSE-MsgGUID: Ge9NPL9/Q2e/46KVPnx/Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57696515"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57696515"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:11:19 -0700
X-CSE-ConnectionGUID: G7vtLgb6TqquzZXJWpfCcg==
X-CSE-MsgGUID: 2VCBDpOAQqS94rHyLrUzqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="172834006"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.196]) ([10.247.119.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:11:13 -0700
Message-ID: <4463409f-bad4-4435-81de-aeda4da24190@intel.com>
Date: Mon, 18 Aug 2025 10:11:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Fix emit of type resource_size_t argument for
 validate_region_offset()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, kernel test robot <lkp@intel.com>
References: <20250818153953.3658952-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250818153953.3658952-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/25 8:39 AM, Dave Jiang wrote:
> 0day reported warnings of:
> drivers/cxl/core/region.c:3664:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> 
> drivers/cxl/core/region.c:3671:37: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> 
> Replace %#llx with %pr to emit resource_size_t arguments.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508160513.NAZ9i9rQ-lkp@intel.com/
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to next
e6a9530b3ee7407b70b60e4df70688db0d239e1a

> ---
>  drivers/cxl/core/region.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c39e2c9942b..29d3809ab2bb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3660,15 +3660,15 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
>  
>  	if (offset < p->cache_size) {
>  		dev_err(&cxlr->dev,
> -			"Offset %#llx is within extended linear cache %#llx\n",
> -			offset, p->cache_size);
> +			"Offset %#llx is within extended linear cache %pr\n",
> +			offset, &p->cache_size);
>  		return -EINVAL;
>  	}
>  
>  	region_size = resource_size(p->res);
>  	if (offset >= region_size) {
> -		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %#llx\n",
> -			offset, region_size);
> +		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %pr\n",
> +			offset, &region_size);
>  		return -EINVAL;
>  	}
>  
> 
> base-commit: d9412f08e25a5b66f9021739c090cc9b8f1089b1

