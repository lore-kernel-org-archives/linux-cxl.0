Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13EBA45;
	Fri, 12 Sep 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757698414; cv=none; b=WUdN0du7MjEI8uJI0dfy/66J1W/3fqAbw5cx6UtmCDbSO1O34ST7UyMoJpmXbMo7s4xVM4fam/L7oOVvA3DtEWvY4n4lWRbcTXZZv5eYa5fo9SofOPT4xhUBbUgErQle8kjbzebE1IUM3hpdznzvhV6qF/R//3HG9qyVbzeeGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757698414; c=relaxed/simple;
	bh=ocsrSdPooCPV6LDPxcgNVEXn4wHEWYjxRsblCQoKEVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDcW/Km2qGKsXqlMpmI0OUSi5clXHckQPKzUyaBvt6CGKd9jyUx1N9Z0f3ws3u87OoPuBQtaDLB4oWnwQ+U+qASOQXoJn5oON0saR+DA80OiAdO6OGH3Ib65z3ACyNDR+eoBmlN6ckWkFkRYwG+bmqqu6+ziCYbgcJuHoys8PNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLmvk6EP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLmvk6EP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757698413; x=1789234413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ocsrSdPooCPV6LDPxcgNVEXn4wHEWYjxRsblCQoKEVg=;
  b=YLmvk6EPzXFQkfMq1q09o3hRpFVnm7/e/UHMbk4HHV64Jze3XbqMHSTi
   l9tb6uZjkissEl07TcyJzw4Znxdsu0/6d00I2ePnSPEzKeYvTfFj/yydJ
   ONFNAAtpP+353XpNChseOCbTBWnxFbz9GJUaSAm9F3bNl0u1vrqG8Jgdq
   ApVwEm8DwP/N09zVtY+mWkxCpxAhHqsR0ya/3GUezFud/3UkULDsxKp7O
   iFeNuZ+NLL+bAoFSZ+Ylpk9vtFSwOdItM1c1pp72PNgVzue0am4Oy9wh3
   qp3dZGX9BcHU1CWCeQTjfaSy4vU+9UyaTWw4rM4OyIMEmikD9rOZbTF70
   g==;
X-CSE-ConnectionGUID: yOkjUTEWRHeJIgApP/mk3Q==
X-CSE-MsgGUID: PV8UNO8+RqG0Iogdzyhr8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="63869819"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="63869819"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 10:33:32 -0700
X-CSE-ConnectionGUID: cCAmcmmuSVmCZtgs3DOdVg==
X-CSE-MsgGUID: oBK8cLDsTjiCY0vz8tNdVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173566516"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 10:33:31 -0700
Message-ID: <60f05a02-6a0a-4616-a2f2-d7ae5709d94e@intel.com>
Date: Fri, 12 Sep 2025 10:33:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] cxl/region: Rename misleading variable name @hpa
 to @range
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
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-4-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250912144514.526441-4-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 7:45 AM, Robert Richter wrote:
> @hpa is actually a @range, rename variables accordingly.

it's a range of HPA right? May as well call it 'hpa_range' to distinguish from 'dpa_range' or 'spa_range'

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 777d04870180..13113920aba7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3367,9 +3367,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
>  }
>  
>  static struct cxl_decoder *
> -cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> +cxl_port_find_switch_decoder(struct cxl_port *port, struct range *range)
>  {
> -	struct device *cxld_dev = device_find_child(&port->dev, hpa,
> +	struct device *cxld_dev = device_find_child(&port->dev, range,
>  						    match_decoder_by_range);
>  
>  	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
> @@ -3382,14 +3382,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct cxl_decoder *root, *cxld = &cxled->cxld;
> -	struct range *hpa = &cxld->hpa_range;
> +	struct range *range = &cxld->hpa_range;
>  
> -	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
> +	root = cxl_port_find_switch_decoder(&cxl_root->port, range);
>  	if (!root) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> +			range->start, range->end);
>  		return NULL;
>  	}
>  
> @@ -3458,7 +3458,7 @@ static int __construct_region(struct cxl_region *cxlr,
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct range *range = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct resource *res;
>  	int rc;
> @@ -3474,13 +3474,13 @@ static int __construct_region(struct cxl_region *cxlr,
>  	}
>  
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
> -	cxlr->hpa_range = *hpa;
> +	cxlr->hpa_range = *range;
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
>  	if (!res)
>  		return -ENOMEM;
>  
> -	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> +	*res = DEFINE_RES_MEM_NAMED(range->start, range_len(range),
>  				    dev_name(&cxlr->dev));
>  
>  	rc = cxl_extended_linear_cache_resize(cxlr, res);
> @@ -3559,11 +3559,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  }
>  
>  static struct cxl_region *
> -cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> +cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *range)
>  {
>  	struct device *region_dev;
>  
> -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, range,
>  				       match_region_by_range);
>  	if (!region_dev)
>  		return NULL;
> @@ -3573,7 +3573,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>  
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct range *range = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	bool attach = false;
>  	int rc;
> @@ -3584,12 +3584,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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
> +		cxl_find_region_by_range(cxlrd, range);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
>  	mutex_unlock(&cxlrd->range_lock);

