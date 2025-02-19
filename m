Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1C286284;
	Wed, 19 Feb 2025 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985952; cv=none; b=i/QXMsjWPYEYRt1Hv8k4eX16uXTNeaSdb+3tjE87zikQK8yn8wvCEwGOMedX3QyBMp0MHr5EMP9HYc5TtiD6mXaA8xhreiQv8F6p2SBDkV9Sq1qqp5IwqSoPjFpnpYjEYTpFSaC2TzZ2QG2HWtW6AwnAMkGQCxuxtUmssWXS+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985952; c=relaxed/simple;
	bh=9JHKrilHo2Kinz4pnuf983yiSc2MnI+9wUWr1Zn9CMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0jcKnuc6CbWe9kBoyFmwyPH0gSvYuVxohWvtt4Uo+10J/232i9hQ0Iu068iehuIBWKjunJ96mnWrmrNaoYd18vgO5k6MEtRTLSQvg9isdv1DPQ62BX4rF+siEEofRzTbXT5XUs0a5bgPAMKmbYGprYfueikuL9pKhygpSZzX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUkMQ/Dx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUkMQ/Dx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739985951; x=1771521951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9JHKrilHo2Kinz4pnuf983yiSc2MnI+9wUWr1Zn9CMk=;
  b=bUkMQ/DxVhwSw6LpqYroDF/uJ/Td4Rp/6F/lj+GbDpP7XlrCwr/X3RqD
   02E2+P9aN5l7uPl8xl2JJTzxCpZzTQJEst20E0DpEZhpHv4L8hDxJdZ2H
   b2Nndl0Y9Epgxuz9QecYyyj8UST0SPj0wmM9pucGqeZJut34P2opcaMTd
   LpXqXHiQimrcrm7Hy2ir1sTXcSxdkzVEf0dy8lcHYxlMPejHt6dbsjRQD
   HgsnzRzvR5Vqqy4M6EWo5jDQudphxdWK4UAC2fTzznre2ZXGHfzdJh80o
   fKLeXlbfQjvOdqFmTFmcqVOcBjuhRhqGX3ijwbVbqSvonj3A7wmWEnOfj
   Q==;
X-CSE-ConnectionGUID: d6ObvQyZTsefWACBJmkTJw==
X-CSE-MsgGUID: 3gyRxBb9Ruit187z+P3Xig==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58279437"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58279437"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:25:50 -0800
X-CSE-ConnectionGUID: HQJrQhxVRSuFpHD4Og5x0w==
X-CSE-MsgGUID: szGNfWYnRDCIz4FZq7ecnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115306445"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:21:11 -0800
Message-ID: <8cbe06d8-2715-497b-85eb-73a317cd2a42@intel.com>
Date: Wed, 19 Feb 2025 10:21:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] cxl/core: Use guard() to drop goto pattern of
 cxl_dpa_alloc()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-6-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250217144828.30651-6-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 7:48 AM, Li Ming wrote:
> In cxl_dpa_alloc(), some checking and operations need to be protected by
> a rwsem called cxl_dpa_rwsem, so there is a goto pattern in
> cxl_dpa_alloc() to release the rwsem. The goto pattern can be optimized
> by using guard() to hold the rwsem.
> 
> Creating a new function called __cxl_dpa_alloc() to include all checking
> and operations needed to be procted by cxl_dpa_rwsem. Using
s/procted/protected/

> guard(rwsem_write()) to hold cxl_dpa_rwsem at the beginning of the new
> function.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 874a791f8292..1edbf7873471 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -442,29 +442,25 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> -int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	resource_size_t free_ram_start, free_pmem_start;
> -	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
>  	resource_size_t start, avail, skip;
>  	struct resource *p, *last;
> -	int rc;
>  
> -	down_write(&cxl_dpa_rwsem);
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder attached to %s\n",
>  			dev_name(&cxled->cxld.region->dev));
> -		rc = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
>  
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
>  		dev_dbg(dev, "decoder enabled\n");
> -		rc = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
>  
>  	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
> @@ -504,21 +500,24 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  		skip = skip_end - skip_start + 1;
>  	} else {
>  		dev_dbg(dev, "mode not set\n");
> -		rc = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
>  
>  	if (size > avail) {
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>  			cxl_decoder_mode_name(cxled->mode), &avail);
> -		rc = -ENOSPC;
> -		goto out;
> +		return -ENOSPC;
>  	}
>  
> -	rc = __cxl_dpa_reserve(cxled, start, size, skip);
> -out:
> -	up_write(&cxl_dpa_rwsem);
> +	return __cxl_dpa_reserve(cxled, start, size, skip);
> +}
> +
> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	int rc;
>  
> +	rc = __cxl_dpa_alloc(cxled, size);
>  	if (rc)
>  		return rc;
>  

