Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6D13A258
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585997; cv=none; b=DNMf7OMwAcqjeCCvoy65G8R9dA2nrwok8dZ1w3mT8/bWO9jaC13iTwYa84IYixjb3U/MKkJnSSrbJRk5KoXV8P61hswc317V2mv7KDgE6WcAcTtmsNKpOrDU9+gVhbMMvx1FyNw6cORHnSKaG8f1gvAUp7/TmcVw9ik/8/AYNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585997; c=relaxed/simple;
	bh=SfccKTI0o8xA9Usw4S1omdFWA2PkmR1IljaKfEt0u30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIoDkx37Aye1n11zYhfYR/4MBAbkr9Nnih0idht/f3ML/+M4PG5yR+XwS35TMM3P0RzYvMWTo7CJQF91DMLbX1OEvdkT+KsTzEwDSnP+UrkHJNZXaQh6zowC/rB+itZUfZceZoXiefb+bKwLkvZ1b58JW+HYC44I7SIJqOMaDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pj4NznjG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pj4NznjG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791585996; x=1823121996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SfccKTI0o8xA9Usw4S1omdFWA2PkmR1IljaKfEt0u30=;
  b=Pj4NznjG8zvZm0vIaqPhSh1zNRmDymJ+nuNWmAgZMg4YdNd31ymZXzmt
   m88lWmIe0H0cRcCQEAEuOXdziDvQAfzJftS58gmadAzR/OFeXyHiYZc4J
   /QsPlleCx2sw3KDxaXkPeyg63Tlssj3ixGCcBZRjnlm90YlAYqbUxEKOJ
   lPS0OBzcXMdP7a9mdymdXpCPukf5Y932Cm04SCnDnKN0mDn6m79S2ODz3
   9yPjbiMZTNTaAXG+5zl6K4xKjgrx2T6KgdlR67NHA8xt1jlwfnSx2kOGv
   xaCaofSERiIhheGgQTL22a8Lj+wtYUKPGOKLkaMhtcPDS5mxT2EPe9e54
   g==;
X-CSE-ConnectionGUID: v3rG00l7QbS8DB7zCGuYGA==
X-CSE-MsgGUID: XotGrniiT/GNbNVMookWAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="384854"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="384854"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:46:35 -0700
X-CSE-ConnectionGUID: IvYz+a+XQvC5ueICydrVvQ==
X-CSE-MsgGUID: i16ImQ3wRW25Kv7nIazBzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="870120"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:46:35 -0700
Message-ID: <cd492b18-e246-49ae-901a-f47f887c4abd@intel.com>
Date: Fri, 9 Oct 2026 15:46:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] cxl/region: Factor out cxl_port_setup_decoder()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791575481.git.alison.schofield@intel.com>
 <0ded5beebbcf283885a0e5876dc7d8dd758827a2.1791575481.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <0ded5beebbcf283885a0e5876dc7d8dd758827a2.1791575481.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 1:24 PM, Alison Schofield wrote:
> Once cxl_port_setup_targets() has calculated the interleave for a port's
> decoder, it either checks that interleave against the decoder settings
> found for an auto region, or checks the decoder's interleave capabilities
> and programs the decoder for a user created region. Both paths are open
> coded in cxl_port_setup_targets().
> 
> Move both paths to a new helper, cxl_port_setup_decoder().
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 88 ++++++++++++++++++++++-----------------
>  1 file changed, 50 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 43f1ffbe64c0..4e9b0880663d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1561,46 +1561,11 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
>  	return 0;
>  }
>  
> -static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> -				  struct cxl_endpoint_decoder *cxled)
> +static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> +				  struct cxl_decoder *cxld, int child_iw, int child_ig)
>  {
> -	int child_iw, child_ig, rc, pos = cxled->pos;
> -	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
>  	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_decoder *cxld = cxl_rr->decoder;
> -	struct cxl_switch_decoder *cxlsd;
> -
> -	/*
> -	 * While root level decoders support x3, x6, x12, switch level
> -	 * decoders only support powers of 2 up to x16.
> -	 */
> -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			cxl_rr->nr_targets);
> -		return -EINVAL;
> -	}
> -
> -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> -	if (cxl_rr->nr_targets_set) {
> -		int distance = cxl_port_peer_distance(port, cxlr);
> -
> -		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> -			if (ep->dport == cxlsd->target[i]) {
> -				rc = check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> -				if (rc)
> -					return rc;
> -				goto out_target_set;
> -			}
> -		goto add_target;
> -	}
> -
> -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
> -	if (rc)
> -		return rc;
> +	int rc;
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != child_iw ||
> @@ -1639,6 +1604,53 @@ static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr
>  	}
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
>  		dev_name(&port->dev), child_iw, child_ig);
> +
> +	return 0;
> +}
> +
> +static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> +				  struct cxl_endpoint_decoder *cxled)
> +{
> +	int child_iw, child_ig, rc, pos = cxled->pos;
> +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	/*
> +	 * While root level decoders support x3, x6, x12, switch level
> +	 * decoders only support powers of 2 up to x16.
> +	 */
> +	if (!is_power_of_2(cxl_rr->nr_targets)) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			cxl_rr->nr_targets);
> +		return -EINVAL;
> +	}
> +
> +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	if (cxl_rr->nr_targets_set) {
> +		int distance = cxl_port_peer_distance(port, cxlr);
> +
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> +			if (ep->dport == cxlsd->target[i]) {
> +				rc = check_last_peer(cxled, ep, cxl_rr,
> +						     distance);
> +				if (rc)
> +					return rc;
> +				goto out_target_set;
> +			}
> +		goto add_target;
> +	}
> +
> +	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_port_setup_decoder(port, cxlr, cxld, child_iw, child_ig);
> +	if (rc)
> +		return rc;
>  add_target:
>  	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
>  		dev_dbg(&cxlr->dev,

