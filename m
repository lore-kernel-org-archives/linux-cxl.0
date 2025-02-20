Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF851DDC3B;
	Thu, 20 Feb 2025 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090710; cv=none; b=uW9rIRg1ZND9kX0UE//rh4RZTAiwnR/gMIybtSDBbWaSa9TwN/dWs+JCOwJUvevFX5zCJ9b426au6MNQrEfNdU2TuxDdSl8/ul2CLJihj8kNuNwZ3R0og8bCF3972AYImSXOtrUtR6KfLBje+oPMR+vTWBqicojm3lDJ4CgCxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090710; c=relaxed/simple;
	bh=bnu32KFWSbzIpYFNBPpRwx09bQ94pNBjbh/u5zmj8cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzYSikJ4cCaeXS9p6KmItjYuB6Zs5a2G+Wj+HFjxkr2WB6dk2SmhTIdPaXSOorufqDZFQz/Yb5VSLaW8gbNWuzws7QSoNVVBrDxUt5Ub8DjwqEON+HczmXFACg0Y/t5TByXj8Q0XET2Mjr2cthgJJq1NJee6h0vdItFJVlnL1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBJScumt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBJScumt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740090708; x=1771626708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bnu32KFWSbzIpYFNBPpRwx09bQ94pNBjbh/u5zmj8cw=;
  b=aBJScumtlW/6KG4YWEiaEwslJXV5UuLj/Sq7QM76uQwa6b25EfNEzfQD
   uazOTiRYpB9DXJRQAdyuuhST/7w4I0Mse0ti1jNfUw80ukYwl6Rox9CDj
   0fR+jspIGya/Sl5UVnXQTv9pINFQqGMYq5c/Qy6FwukOfdCYDV+4s9W7Y
   BfR9tLL/ekPDF6OycP7DlCRLFSbuSy6STxPNMMNGy/y3xZHGBz3GbSYAL
   O3k2F+GztDM2OwwmvcpLGPwCoz+UEkvTByun16bVIgqqWVwpVltqmimL1
   AyVz6O8LN33sgunLdlpAwQ3RXSqKBvNAjzd7ay/4ukv2jPJIcVx3AHzK0
   g==;
X-CSE-ConnectionGUID: tOpf6WK3TaSxPAgUMSJZeA==
X-CSE-MsgGUID: mDejy9U7RDCCujqwi8fH2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40081306"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40081306"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 14:31:48 -0800
X-CSE-ConnectionGUID: PQstr39QS7iYLsUPQGtGKg==
X-CSE-MsgGUID: KwgjvCsURCi3JrMheAC1Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="114903799"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 14:31:47 -0800
Message-ID: <af32c954-76a4-4328-a016-62248dd68815@intel.com>
Date: Thu, 20 Feb 2025 15:31:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] cxl/region: Calculate and store the SPA range of
 an endpoint
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-6-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250218132356.1809075-6-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 6:23 AM, Robert Richter wrote:
> To find the correct region and root port of an endpoint of a system
> needing address translation, the endpoint's HPA range must be
> translated to each of the parent port address ranges up to the root
> decoder.
> 
> Calculate the SPA range using the newly introduced callback function
> port->to_hpa() that translates the decoder's HPA range to its parent
> port's HPA range of the next outer memory domain. Introduce the helper
> function cxl_port_calc_hpa() for this to calculate address ranges
> using the low-level port->to_hpa() callbacks. Determine the root port
> SPA range by iterating all the ports up to the root. Store the
> endpoint's SPA range for later use.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 81 ++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxl.h         |  1 +
>  2 files changed, 68 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6f106bfa115f..d898c9f51113 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -832,6 +832,44 @@ static int match_free_decoder(struct device *dev, const void *data)
>  	return 1;
>  }
>  
> +static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
> +			     struct range *hpa_range)
> +{
> +	struct range hpa = *hpa_range;
> +	u64 len = range_len(&hpa);
> +
> +	if (!port->to_hpa)
> +		return 0;
> +
> +	/* Translate HPA to the next upper domain. */
> +	hpa.start = port->to_hpa(cxld, hpa.start);
> +	hpa.end = port->to_hpa(cxld, hpa.end);
> +
> +	if (hpa.start == ULLONG_MAX || hpa.end == ULLONG_MAX) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: HPA range invalid: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			hpa.start, hpa.end, hpa_range->start,
> +			hpa_range->end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	if (range_len(&hpa) != len * cxld->interleave_ways) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			hpa.start, hpa.end, hpa_range->start,
> +			hpa_range->end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	if (hpa.start == hpa_range->start && hpa.end == hpa_range->end)
> +		return 0;
> +
> +	*hpa_range = hpa;
> +
> +	/* Return 1 if modified. */
> +	return 1;
> +}
> +
>  static int match_auto_decoder(struct device *dev, const void *data)
>  {
>  	const struct cxl_region_params *p = data;
> @@ -1882,6 +1920,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  		.hpa_range = &cxled->cxld.hpa_range,
>  	};
>  
> +	/*
> +	 * Address translation is only supported for auto-discovery of
> +	 * decoders. There is no need to support address translation
> +	 * here. That is, do not recalculate ctx.hpa_range here.
> +	 */

Should this go with patch 3?

>  	for (iter = cxled_to_port(cxled); pos >= 0 && iter;
>  	     iter = parent_port_of(iter))
>  		pos = cxl_port_calc_interleave(iter, &ctx);
> @@ -3262,7 +3305,8 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *iter = cxled_to_port(cxled);
> -	struct cxl_decoder *root, *cxld = &cxled->cxld;
> +	struct cxl_port *parent = parent_port_of(iter);
> +	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct range hpa = cxld->hpa_range;
>  	struct cxl_interleave_context ctx;
>  	int rc;
> @@ -3271,25 +3315,33 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  		.hpa_range = &hpa,
>  	};
>  
> -	while (iter && !is_cxl_root(iter)) {
> +	if (!iter || !parent)

While parent_port_of() will check NULL and return NULL, it just seems icky checking the pointer after use.

DJ

> +		return -ENXIO;
> +
> +	while (iter && parent) {
> +		/* Translate HPA to the next upper memory domain. */
> +		rc = cxl_port_calc_hpa(parent, cxld, &hpa);
> +		if (rc < 0)
> +			return rc;
> +
>  		/* Convert interleave settings to next port upstream. */
>  		rc = cxl_port_calc_interleave(iter, &ctx);
>  		if (rc < 0)
>  			return rc;
>  
> -		iter = parent_port_of(iter);
> -	}
> +		iter = parent;
> +		parent = parent_port_of(iter);
>  
> -	if (!iter)
> -		return -ENXIO;
> +		if (!parent || parent->to_hpa)
> +			cxld = cxl_port_find_switch_decoder(iter, &hpa);
>  
> -	root = cxl_port_find_switch_decoder(iter, hpa);
> -	if (!root) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s no CXL window for range %#llx:%#llx\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> -		return -ENXIO;
> +		if (!cxld) {
> +			dev_err(cxlmd->dev.parent,
> +				"%s:%s no CXL window for range %#llx:%#llx\n",
> +				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +				hpa.start, hpa.end);
> +			return -ENXIO;
> +		}
>  	}
>  
>  	dev_dbg(cxld->dev.parent,
> @@ -3297,7 +3349,8 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
>  		hpa.start, hpa.end, ctx.pos);
>  
> -	cxled->cxlrd = to_cxl_root_decoder(&root->dev);
> +	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
> +	cxled->spa_range = hpa;
>  	cxled->pos = ctx.pos;
>  
>  	return 0;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 17496784f021..7303aec1c31c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -394,6 +394,7 @@ struct cxl_endpoint_decoder {
>  	struct cxl_decoder cxld;
>  	struct cxl_root_decoder *cxlrd;
>  	struct resource *dpa_res;
> +	struct range spa_range;
>  	resource_size_t skip;
>  	enum cxl_decoder_state state;
>  	int part;

