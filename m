Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028102AE84;
	Fri, 21 Mar 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571803; cv=none; b=UfJ1yDL1wnqNkmerFsTfWZrP3kNwBw2QDxp1SlVJgKzm/lPtCjaDskFvI/fsa6x8lz9JtJJq5zTvpgfWs8zo95mYwhnJ13ZNKtyWE3MRBglcgJqG+C3MaUYzjdNCQWrqjp+OarESBz4MSnTWY67t3GsmwfZe3KHjrWeLcPwZoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571803; c=relaxed/simple;
	bh=hRD7Rp/PjQ/JijKE4WjTer5g02c7lBgb3OgJxQuv3Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShFKwKfGppdFwcFxpNLZYKx5M2zqL2WYvkH+QdgOwlA6NtPYyLv54opS6HBRAVfveq+rUnlxZTlJKMmVXLRIrysPGmcdHvYXWjs36G3NyiA78j+Iu/K7TltbGSN4vCGMmSi3thl7RYM0F2qghlvwYptTzQ2EUIjQ0QYIGG/b/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2UBIBsF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2UBIBsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742571801; x=1774107801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hRD7Rp/PjQ/JijKE4WjTer5g02c7lBgb3OgJxQuv3Tg=;
  b=n2UBIBsFxohZqB9OvEAhP1p+KD5MivKzSmLiVxZyXSUP6uFjM1PK1Fod
   0DdtmmagajmFZ0w796JRb60Lr/el4VGUrc1rX1fQErGjW3ANw6I2jt9lK
   R01Q7C71c+vYY2YXx3Ndy7vsDyG8NB768OSHfStNduT1CNnxUwZAJnfWZ
   9gpeJEDYLqp/cCUZUwtw4xFYADEtxs2WhsYKnL6C3rCov8LA1Y7nsaye5
   jAXbyrtsaTdVh3cf65/+BaklSMUnoZ7lgSWsbm7tW96wgB46cRDZLdvlD
   +i1iQ99E3mZLqUagnvDgK7oH/SzJ6VsBXrOAt/hOFmyFgjY4I2ZND2ziU
   w==;
X-CSE-ConnectionGUID: mX7g1pzBQAuPNvpvzMwHhA==
X-CSE-MsgGUID: xHILkl0uQ0mqvbNPLyY5yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="47720249"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="47720249"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:43:20 -0700
X-CSE-ConnectionGUID: 9LkDpVZcQXeZJYxZ8dGPaw==
X-CSE-MsgGUID: A8voJpYcTYOh69nBJ6OyiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123609541"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.110.208]) ([10.125.110.208])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:43:19 -0700
Message-ID: <17269eeb-9ae7-48df-b4ad-70f1ecc4f9a9@intel.com>
Date: Fri, 21 Mar 2025 08:43:18 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 v3] cxl/core: Change match_*_by_range() calling
 convention
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Robert Richter <rrichter@amd.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-2-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250314113708.759808-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/25 4:36 AM, Fabio M. De Francesco wrote:
> Replace struct range parameter with struct cxl_endpoint_decoder of
> which range is a member in the match_*_by_range() functions.
> 
> This is in preparation for expanding these helpers to perform arch
> specific region matching that requires a cxl_endpoint_decoder.
> 
> No functional changes.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b3260d433ec7..97122d645cc1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1758,24 +1758,27 @@ static struct cxl_port *next_port(struct cxl_port *port)
>  static int match_switch_decoder_by_range(struct device *dev,
>  					 const void *data)
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
> +static int find_pos_and_ways(struct cxl_port *port,
> +			     struct cxl_endpoint_decoder *cxled,
>  			     int *pos, int *ways)
>  {
> +	struct range *range = &cxled->cxld.hpa_range;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *parent;
>  	struct device *dev;
> @@ -1785,7 +1788,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	if (!parent)
>  		return rc;
>  
> -	dev = device_find_child(&parent->dev, range,
> +	dev = device_find_child(&parent->dev, cxled,
>  				match_switch_decoder_by_range);
>  	if (!dev) {
>  		dev_err(port->uport_dev,
> @@ -1865,7 +1868,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  		if (is_cxl_root(iter))
>  			break;
>  
> -		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> +		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
>  		if (rc)
>  			return rc;
>  
> @@ -3199,22 +3202,26 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  static int match_root_decoder_by_range(struct device *dev,
>  				       const void *data)
>  {
> -	const struct range *r1, *r2 = data;
> +	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_root_decoder *cxlrd;
> +	const struct range *r1, *r2;
>  
>  	if (!is_root_decoder(dev))
>  		return 0;
>  
>  	cxlrd = to_cxl_root_decoder(dev);
>  	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +
>  	return range_contains(r1, r2);
>  }
>  
>  static int match_region_by_range(struct device *dev, const void *data)
>  {
> +	const struct cxl_endpoint_decoder *cxled = data;
> +	const struct range *r = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> -	const struct range *r = data;
>  
>  	if (!is_cxl_region(dev))
>  		return 0;
> @@ -3382,7 +3389,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct device *cxlrd_dev, *region_dev;
>  	struct cxl_root_decoder *cxlrd;
> @@ -3391,7 +3397,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  	bool attach = false;
>  	int rc;
>  
> -	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
> +	cxlrd_dev = device_find_child(&root->dev, cxled,
>  				      match_root_decoder_by_range);
>  	if (!cxlrd_dev) {
>  		dev_err(cxlmd->dev.parent,
> @@ -3408,7 +3414,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  	 * one does the construction and the others add to that.
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
> -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, cxled,
>  				       match_region_by_range);
>  	if (!region_dev) {
>  		cxlr = construct_region(cxlrd, cxled);

