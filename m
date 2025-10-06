Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F5CA4B;
	Mon,  6 Oct 2025 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793433; cv=none; b=nRjciaIVDQvtTdYt6t2ANk3rvs8se79HXcfHStgfdiwEkBUmXiB+ODdCVVCdQWZ7EGE1du7rnDzYCFDgGZg63rT+J08HD5vIxUl1OLB5rN3bIu0H4KY5WoIEV5Hrkwz+OjoEuG3HaKHOUFoHMGTGozANOV+3zcpEWsWPlqpK2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793433; c=relaxed/simple;
	bh=rsn6yKqy3+8U/13uNTmF9IAoQLBkh7dQqC4YtKLNNas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuLWLW0q19ZG8ZwVhei67lOTCUKlOE0pztmN+xb4gogJx4iWGCw/vEDT3Yo0pIxU55DaOHqnhhvKbkDsOK/lmJe7vVj+mrq76W0gMqNs+tzecSuwnV4BMsIzwzlQLC+lBmSR0W2L6awAnGm9swwMezSs3MSzZ1d50U3irP1GtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtbvvCPA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtbvvCPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759793432; x=1791329432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rsn6yKqy3+8U/13uNTmF9IAoQLBkh7dQqC4YtKLNNas=;
  b=BtbvvCPAsQ4QF7BhUbaRpP5dFR9jbvOj+5kXpLJ+sZzkeFqkOC4WMtKv
   fHWMhH/DW/Q/SL15jj9UNLSZF+ptZQrcljz9obdg3VQWzQcS7eUac937T
   cgXg3jpmgQ7NWJR5w8Bx4uEm7QAVpZ4NR9dBz32geQCzaV23JZLod/0zE
   GjpT3ko+a5dDrBMsBEguD8IbnmcTogeBt3dJZ6QCTUJRvOH28Rv6ZZdk+
   qRfc2xNMZEuUZ9RJwDi5Ks8eGoIsN8OLw3UujgnrpJ0tRnsHNnvIEKQyF
   Dfoj3GKsm0qlERgeZellvoIgDiygwQW4HWfkN7mgXoYh4oL6H1YRPBzNK
   g==;
X-CSE-ConnectionGUID: cdYkGsVLRgSHX1uWfjQC8A==
X-CSE-MsgGUID: ocUqymGhS729Ht6ZSbNK0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61892015"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61892015"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 16:30:31 -0700
X-CSE-ConnectionGUID: 9gdnYC0gTSik5EUrztzeIA==
X-CSE-MsgGUID: QruypNSsRk679cBFC79VuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="203735195"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.110]) ([10.125.110.110])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 16:30:30 -0700
Message-ID: <a8c5a482-c380-421d-bb89-914fc120a01b@intel.com>
Date: Mon, 6 Oct 2025 16:30:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 v5] cxl/core: Change match_*_by_range() signatures
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Robert Richter <rrichter@amd.com>,
 Cheatham Benjamin <benjamin.cheatham@amd.com>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-2-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251006155836.791418-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/6/25 8:58 AM, Fabio M. De Francesco wrote:
> Replace struct range parameter with struct cxl_endpoint_decoder of
> which range is a member in the match_*_by_range() functions and rename
> them according to their semantics.
> 
> This is in preparation for expanding these helpers to perform arch
> specific Root Decoders and Region matchings with
> cxl_endpoint_decoder(s).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 62 ++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e14c1d305b22..43a854036202 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1766,27 +1766,29 @@ static int cmp_interleave_pos(const void *a, const void *b)
>  	return cxled_a->pos - cxled_b->pos;
>  }
>  
> -static int match_switch_decoder_by_range(struct device *dev,
> -					 const void *data)
> +static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
>  {
> +	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> -	const struct range *r1, *r2 = data;
> -
> +	const struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxlsd = to_cxl_switch_decoder(dev);
>  	r1 = &cxlsd->cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
>  
>  	if (is_root_decoder(dev))
>  		return range_contains(r1, r2);
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> -static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> -			     int *pos, int *ways)
> +static int find_pos_and_ways(struct cxl_port *port,
> +			     struct cxl_endpoint_decoder *cxled, int *pos,
> +			     int *ways)
>  {
> +	struct range *range = &cxled->cxld.hpa_range;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *parent;
>  	struct device *dev;
> @@ -1796,8 +1798,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	if (!parent)
>  		return rc;
>  
> -	dev = device_find_child(&parent->dev, range,
> -				match_switch_decoder_by_range);
> +	dev = device_find_child(&parent->dev, cxled,
> +				match_cxlsd_to_cxled_by_range);
>  	if (!dev) {
>  		dev_err(port->uport_dev,
>  			"failed to find decoder mapping %#llx-%#llx\n",
> @@ -1883,7 +1885,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  		if (is_cxl_root(iter))
>  			break;
>  
> -		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> +		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
>  		if (rc)
>  			return rc;
>  
> @@ -3342,24 +3344,30 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int match_decoder_by_range(struct device *dev, const void *data)
> +static int match_cxlrd_to_cxled_by_range(struct device *dev, const void *data)
>  {
> -	const struct range *r1, *r2 = data;
> -	struct cxl_decoder *cxld;
> +	const struct cxl_endpoint_decoder *cxled = data;
> +	struct cxl_root_decoder *cxlrd;
> +	const struct range *r1, *r2;
>  
> -	if (!is_switch_decoder(dev))
> +	if (!is_root_decoder(dev))
>  		return 0;
>  
> -	cxld = to_cxl_decoder(dev);
> -	r1 = &cxld->hpa_range;
> +	cxlrd = to_cxl_root_decoder(dev);
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +
>  	return range_contains(r1, r2);
>  }
>  
>  static struct cxl_decoder *
> -cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> +cxl_port_find_root_decoder(struct cxl_port *port,
> +			   struct cxl_endpoint_decoder *cxled)
>  {
> -	struct device *cxld_dev = device_find_child(&port->dev, hpa,
> -						    match_decoder_by_range);
> +	struct device *cxld_dev;
> +
> +	cxld_dev = device_find_child(&port->dev, cxled,
> +				     match_cxlrd_to_cxled_by_range);
>  
>  	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
>  }
> @@ -3371,9 +3379,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct cxl_decoder *root, *cxld = &cxled->cxld;
> -	struct range *hpa = &cxld->hpa_range;
>  
> -	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
> +	root = cxl_port_find_root_decoder(&cxl_root->port, cxled);
>  	if (!root) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
> @@ -3385,11 +3392,12 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	return to_cxl_root_decoder(&root->dev);
>  }
>  
> -static int match_region_by_range(struct device *dev, const void *data)
> +static int match_region_to_cxled_by_range(struct device *dev, const void *data)
>  {
> +	const struct cxl_endpoint_decoder *cxled = data;
> +	const struct range *r = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> -	const struct range *r = data;
>  
>  	if (!is_cxl_region(dev))
>  		return 0;
> @@ -3547,12 +3555,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  }
>  
>  static struct cxl_region *
> -cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> +cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
> +			 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct device *region_dev;
>  
> -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> -				       match_region_by_range);
> +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, cxled,
> +				       match_region_to_cxled_by_range);
>  	if (!region_dev)
>  		return NULL;
>  
> @@ -3561,7 +3570,6 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>  
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	bool attach = false;
>  	int rc;
> @@ -3577,7 +3585,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =
> -		cxl_find_region_by_range(cxlrd, hpa);
> +		cxl_find_region_by_range(cxlrd, cxled);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
>  	mutex_unlock(&cxlrd->range_lock);

