Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738E21423F;
	Wed, 19 Feb 2025 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985929; cv=none; b=gbRtzqCORGCjuMeQrmTmuak12lGo+tPzD8eO4kulkJRDILnixOShJZ6UMSNMQhyzf9dHT4fEtX5wxJvjFMzkcxHW2/dXKiOnwPnq6wsnoD5p26OxGR+yjPFWaijZKJXsBkKxu7pF8H+4l/C7bJ0EnYsXzwz94ZnLn5CQE9xouMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985929; c=relaxed/simple;
	bh=XGSkKIwZw3PqTPka1ddYLycO5ruHPaESYlAcuJunJrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYfGbrdOY5a3J82oHmp1pMzj3NVuguYl90Epa/adofEeqowCwVuiyMRWcyeCUBlhRrTJng/8+kQyT6OTprzDWbYfHXjHyzARRI9pdYcEvw4DzEEblOJrEeZyN2Y44vXgUppFm4tPITk1VPPrdz6/F7WfogEbyd1AeRBnw18/XSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNHcKml6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNHcKml6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739985927; x=1771521927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XGSkKIwZw3PqTPka1ddYLycO5ruHPaESYlAcuJunJrE=;
  b=nNHcKml6fmE0a5jdVmdSWoGILGjcrZLPemr85Qe6iKHv0sE1T7sYjMkd
   o/wQ6vQDxFmfMX9pM17y5AusWcqOk9knEHC8DkQzf3HRgTI32bK7TlpzP
   iqiDJphewMNJAfMj8msCXLp9ZWq1DiEMSe5vkvAmovTZunArMsXqJPmfb
   UBVdWxcUS6gVzrB4t0nm0pBYmTn3blwJauPCYtExwrWnBVopYQnrXE5UC
   BuLKP1UZOOU01X+/ZrVSH4L9biO7QZASV4+adWU4dM91PidXS0ArsIxna
   Ls7QrMEI0+Zb2OnrudiOSZE4IUD1Og5SbvVWHaQ/Wl+PC0ydCLTOtyrtI
   Q==;
X-CSE-ConnectionGUID: SZRoHlGcRROuuvK7SdohWQ==
X-CSE-MsgGUID: kmz9oyfQS4Ss9KebsGdsuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58279380"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58279380"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:25:26 -0800
X-CSE-ConnectionGUID: PUNdUEe2QH+TCT91695bFw==
X-CSE-MsgGUID: Z/af/wW6TmKB0wSnv6GLOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115306255"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:19:38 -0800
Message-ID: <1c00cbcf-e133-4fe0-b423-897c2b5c7dcc@intel.com>
Date: Wed, 19 Feb 2025 10:19:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] cxl/core: Use guard() to drop the goto pattern of
 cxl_dpa_free()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-5-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250217144828.30651-5-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 7:48 AM, Li Ming wrote:
> cxl_dpa_free() has a goto pattern to call up_write() for cxl_dpa_rwsem,
> it can be removed by using a guard() to replace the down_write() and
> up_write().
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 4a578092377e..874a791f8292 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -382,35 +382,27 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct device *dev = &cxled->cxld.dev;
> -	int rc;
>  
> -	down_write(&cxl_dpa_rwsem);
> -	if (!cxled->dpa_res) {
> -		rc = 0;
> -		goto out;
> -	}
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	if (!cxled->dpa_res)
> +		return 0;
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder assigned to: %s\n",
>  			dev_name(&cxled->cxld.region->dev));
> -		rc = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
>  		dev_dbg(dev, "decoder enabled\n");
> -		rc = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
>  	if (cxled->cxld.id != port->hdm_end) {
>  		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
>  			port->hdm_end);
> -		rc = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>  	}
> +
>  	devm_cxl_dpa_release(cxled);
> -	rc = 0;
> -out:
> -	up_write(&cxl_dpa_rwsem);
> -	return rc;
> +	return 0;
>  }
>  
>  int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,

