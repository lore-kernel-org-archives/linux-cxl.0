Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3952D3731;
	Mon,  3 Nov 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205803; cv=none; b=NxZbFsjJHXi8E8pjwkgM+mpJQCl8tDA6548nNvDH+WeqSpKRXXsO4hmhMHvU6TIgNn9dw5/RIz9NQK1Qej9mI1QoVfqIDPy86N72kLq5ozQ00WfFSXtlb0VcGWQMCdaHcMWYZ2BRAJSO2NhBepn3jPHuBV9HDabIaBpHVrhGKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205803; c=relaxed/simple;
	bh=TPT2YWriIX3KZADc1gMp9JFzg2cjrvXy+puD0rfCGCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBrX7WBX2CVvi+69edhbofXX0klaCyCO7FUUSOXCrQOovPAQzOzVL+BHFzyV5I6Y9fku9A/Y7oXraFKMN00Q1HUo+urHmxzX9PmhNDzOEiHsdCWE2FX3+FRyZg2KbJUy2YdsbahBY7Vans0uHY5GSP02EIKPm0Yuo6zSdIWUdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlZPM7cd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlZPM7cd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762205802; x=1793741802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TPT2YWriIX3KZADc1gMp9JFzg2cjrvXy+puD0rfCGCo=;
  b=OlZPM7cdYJqXAcOBP1BnTIO4V/mzunuQqiVQ+BUZ2qiN0VQP9VlNnuZK
   6u0ZEUG8mfOyiFHyGGqmZbhZpSZm0ytGaE5SrrtEt63SBknJH68uAqZt2
   yhFwK45DB6wRfBg+NuAy0Zc1CcPlPsM+RXgCPXXkci7CG+oJZw/ut55Nw
   uLJnlJyzG4lyO4Tsp+l0pRp67wbk9oLRO52YpjZ9xNEeA4ApvuUyfaO1r
   3ecDI1rfCvFQLWqLLrnZdv20dBuZjO420CxDTs7pRKwNXbHAO87M+0Zz+
   9qiaeCZoNH/fLoMSD4UO+d+cI+JwashrVzTY3HCqpg6v8EyPeb6QrTIPP
   Q==;
X-CSE-ConnectionGUID: 26Yxg0tiRXiiKukL6dm7Gw==
X-CSE-MsgGUID: qwBq8AqkTpqHDhzMsbGf4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75743354"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75743354"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 13:36:41 -0800
X-CSE-ConnectionGUID: rc/gqVNgQ2qnj88FF3p61Q==
X-CSE-MsgGUID: CSGLMJCOSR2ab3BZaGBkqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186655702"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 13:36:40 -0800
Message-ID: <eb4285d3-4168-4d7d-8626-08ddd0c445a2@intel.com>
Date: Mon, 3 Nov 2025 14:36:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] cxl/region: Rename misleading variable name @hpa
 to @hpa_range
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-4-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251103184804.509762-4-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 11:47 AM, Robert Richter wrote:
> @hpa is actually a @hpa_range, rename variables accordingly.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a780e65532a7..bb889c891cf7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3363,9 +3363,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
>  }
>  
>  static struct cxl_decoder *
> -cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> +cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
>  {
> -	struct device *cxld_dev = device_find_child(&port->dev, hpa,
> +	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
>  						    match_decoder_by_range);
>  
>  	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
> @@ -3378,14 +3378,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct cxl_decoder *root, *cxld = &cxled->cxld;
> -	struct range *hpa = &cxld->hpa_range;
> +	struct range *hpa_range = &cxld->hpa_range;
>  
> -	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
> +	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa_range);
>  	if (!root) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> +			hpa_range->start, hpa_range->end);
>  		return NULL;
>  	}
>  
> @@ -3451,7 +3451,7 @@ static int __construct_region(struct cxl_region *cxlr,
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct range *hpa_range = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct resource *res;
>  	int rc;
> @@ -3467,13 +3467,13 @@ static int __construct_region(struct cxl_region *cxlr,
>  	}
>  
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
> -	cxlr->hpa_range = *hpa;
> +	cxlr->hpa_range = *hpa_range;
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
>  	if (!res)
>  		return -ENOMEM;
>  
> -	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> +	*res = DEFINE_RES_MEM_NAMED(hpa_range->start, range_len(hpa_range),
>  				    dev_name(&cxlr->dev));
>  
>  	rc = cxl_extended_linear_cache_resize(cxlr, res);
> @@ -3552,11 +3552,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  }
>  
>  static struct cxl_region *
> -cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> +cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
> +			 struct range *hpa_range)
>  {
>  	struct device *region_dev;
>  
> -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa_range,
>  				       match_region_by_range);
>  	if (!region_dev)
>  		return NULL;
> @@ -3566,7 +3567,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>  
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct range *hpa_range = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	bool attach = false;
>  	int rc;
> @@ -3577,12 +3578,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  		return -ENXIO;
>  
>  	/*
> -	 * Ensure that if multiple threads race to construct_region() for @hpa
> -	 * one does the construction and the others add to that.
> +	 * Ensure that if multiple threads race to construct_region()
> +	 * for the HPA range one does the construction and the others
> +	 * add to that.
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =
> -		cxl_find_region_by_range(cxlrd, hpa);
> +		cxl_find_region_by_range(cxlrd, hpa_range);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
>  	mutex_unlock(&cxlrd->range_lock);

