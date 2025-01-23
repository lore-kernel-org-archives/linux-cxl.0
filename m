Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92E1EF01
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648255; cv=none; b=cUtF67S3pvZnU6KyslfdbRrOBQyRixK1xfyIJXUo1drdkcRwg4eJy1q1bfpDVLPo5XNJXTxHkduxk52fOpl0ItiEFLltEtRg8irDdoNyxbDQ/oMZk7VHI/sBvY4V3T0sDaN8am9pqjZFXoerG7YEmioCgyKDNbAyk7qZrXWNk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648255; c=relaxed/simple;
	bh=GrDSHVUmjMFJa6wjJiLdGuQNgE23SG3pJnNQQ8BsH7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cgeuhhc8pAKRiVrGCEw45GEeJGPzkbA9a0HpqH+ovbjgr06lfJfsIJinJdE+0ZoQuql9576WfpV/hVd3BIFdya4EPtQm57Io1qDeMqlTwL84Txq7AzMQkIBLEnUmy6QABILCpsN+4TBvbZzMehHGWrJgAFiHhMX3ju2mB2myZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyYOFdv/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyYOFdv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737648254; x=1769184254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GrDSHVUmjMFJa6wjJiLdGuQNgE23SG3pJnNQQ8BsH7Q=;
  b=ZyYOFdv/+avvsGRhlcuzJBCvCVhyUwHUtql5VlXVrh4WQ6GhezVRwovM
   gtJ40O1mYsXLPWdH+wAc0ve4TsZSkX/+V7fWx9l55keipNfLRBc6nkcqz
   hxQdUli0lK/fXvTylQlCWpdOLt+vbGK9vrf4WpvgCLq/j9di28BdsQ95R
   WoMQA1aNo4Z5XfrAOHn7jWEHNJWHmLmzx0OAX3pt6Y9FlGyG68DbkSRIE
   a+C1yscX2o+i4FjcjDmPaKFZkyGAttU6oMlp0PRfR4MVMeOy1AaD1JOL7
   DPGTmYd7MZHJTKfvOfgJKzKfV+dlRcnuFvJMEPX0gbhJaDdQoRSStuKFT
   w==;
X-CSE-ConnectionGUID: Lci0DS2jTL68+cBfRi+jOw==
X-CSE-MsgGUID: TOr518rwQ0yj98gM8IJ9gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38404813"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="38404813"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 08:04:01 -0800
X-CSE-ConnectionGUID: sCNITyjCS3u0J4vSc3cWWQ==
X-CSE-MsgGUID: uDtkHxFlS/iJSP64K3NX/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="108044746"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.229]) ([10.125.110.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 08:04:00 -0800
Message-ID: <53c17311-72c6-4886-b529-7b39b03bfe5d@intel.com>
Date: Thu, 23 Jan 2025 09:03:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] cxl: Remove the CXL_DECODER_MIXED mistake
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753635601.3849855.5582594127330525596.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <173753635601.3849855.5582594127330525596.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/25 1:59 AM, Dan Williams wrote:
> CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> platform firmware has programmed an endpoint decoder that straddles a
> DPA partition boundary. While the kernel is careful to only allocate DPA
> capacity within a single partition there is no guarantee that platform
> firmware, or anything that touched the device before the current kernel,
> gets that right.
> 
> However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> designation because of the way it tracks partition boundaries. A
> request_resource() that spans ->ram_res and ->pmem_res fails with the
> following signature:
> 
>     __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
> 
> CXL_DECODER_MIXED is dead defensive programming after the driver has
> already given up on the device. It has never offered any protection in
> practice, just delete it.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/hdm.c    |    6 +++---
>  drivers/cxl/core/region.c |   12 ------------
>  drivers/cxl/cxl.h         |    4 +---
>  3 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 28edd5822486..2848d6991d45 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -332,9 +332,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	else if (resource_contains(&cxlds->ram_res, res))
>  		cxled->mode = CXL_DECODER_RAM;
>  	else {
> -		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
> -			 port->id, cxled->cxld.id, cxled->dpa_res);
> -		cxled->mode = CXL_DECODER_MIXED;
> +		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> +			 port->id, cxled->cxld.id, res);
> +		cxled->mode = CXL_DECODER_NONE;
>  	}
>  
>  	port->hdm_end++;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d77899650798..e4885acac853 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2725,18 +2725,6 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
>  		return rc;
>  
> -	/*
> -	 * Regions are only created with single mode decoders: pmem or ram.
> -	 * Linux does not support mixed mode decoders. This means that
> -	 * reading poison per endpoint decoder adheres to the requirement
> -	 * that poison reads of pmem and ram must be separated.
> -	 * CXL 3.0 Spec 8.2.9.8.4.1
> -	 */
> -	if (cxled->mode == CXL_DECODER_MIXED) {
> -		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> -		return rc;
> -	}
> -
>  	cxlmd = cxled_to_memdev(cxled);
>  	if (cxled->skip) {
>  		offset = cxled->dpa_res->start - cxled->skip;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..4d0550367042 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -379,7 +379,6 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
>  	CXL_DECODER_RAM,
>  	CXL_DECODER_PMEM,
> -	CXL_DECODER_MIXED,
>  	CXL_DECODER_DEAD,
>  };
>  
> @@ -389,10 +388,9 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  		[CXL_DECODER_NONE] = "none",
>  		[CXL_DECODER_RAM] = "ram",
>  		[CXL_DECODER_PMEM] = "pmem",
> -		[CXL_DECODER_MIXED] = "mixed",
>  	};
>  
> -	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
> +	if (mode >= CXL_DECODER_NONE && mode < CXL_DECODER_DEAD)
>  		return names[mode];
>  	return "mixed";
>  }
> 

