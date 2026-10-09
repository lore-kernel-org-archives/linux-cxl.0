Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC968502579
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584863; cv=none; b=fPm34tEwtSYwF73yJmYbH2/pPnl/uEqNcr1i2cYF/I+BMNUJxmnUBfKAkuedJEGQaWjoUavxhC+UbyRd0lFfTO+1HKIAZNXnxYJ0eyjzsjYgemG1UL104fIuXpivsyreuQynzgb7vAcR42HvCQXhEd8eMK3FutdGMiNaTGYBjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584863; c=relaxed/simple;
	bh=rcGG7u166esJWXiAbfKRGioY5El1UbHQhd1BRqBh7O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/ngYjsWILBJPxJrJ6MPDO/fSmn4RtqUGq4AFvSZKXnVIsXb5pC9ZRaMdaODSqUx5lOSTJ6l5PaEWTEX0gOca49J/0TeM35/BEMRvMySkVmSOWpILTvFZoURwhucsAq2UBtIhuzWjV6arhP+27Db549szZd7MPc7PT8lktmQYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJ10NX4t; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJ10NX4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791584863; x=1823120863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rcGG7u166esJWXiAbfKRGioY5El1UbHQhd1BRqBh7O0=;
  b=kJ10NX4tIcha3LqeRkYmwcCnUodUQKJUl+1NHZlFeJVYGoBbDxYmnErw
   6slrk2uzkS9z1Bu0cnug5oiCJFRLMGGecJb0Xlnh4lQbKdus3XwrhyUbw
   7lksoOgE7ah3wrnPGP3YdbX9eAIRv5IVrVIOgrbrga1dmfwVb+ptPzAOc
   j8sgm9H+6j2bZUzasUFLTuD/sxMKcoqzrIaRsBNlrRU53Huc6o8xeulrm
   mG0hllkrvwLKWNN2bXFAPBncWOeklvY5Khysm0hdSzA973T8OtMQBXKZp
   Gpm2b7l3vHSzAbqMFoN+nlIqSnf2U7wub5hSV+3Alj9/C3odmcesw0szr
   g==;
X-CSE-ConnectionGUID: NkMGzIO1RcSujQ3ArAHEkA==
X-CSE-MsgGUID: 7BX5KWcJRRickaqDlt8mag==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="269729"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="269729"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:27:42 -0700
X-CSE-ConnectionGUID: tVywFzr6SRGkKYOoF4Jfwg==
X-CSE-MsgGUID: 4n11cw9xSVqmeWGO13F1Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2217631"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:27:41 -0700
Message-ID: <e63056bb-ded8-42d2-9443-77b379496fcf@intel.com>
Date: Fri, 9 Oct 2026 15:27:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] cxl/region: Factor out cxl_port_peer_distance()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791575481.git.alison.schofield@intel.com>
 <2a4d99ac07511575950f6cd83df39742d1747861.1791575481.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <2a4d99ac07511575950f6cd83df39742d1747861.1791575481.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 1:24 PM, Alison Schofield wrote:
> cxl_port_setup_targets() is nearly 200 lines long and open codes each step
> of adding an endpoint to a port's decoder. One of those steps calculates
> the distance between region positions that share a downstream port.
> 
> Move that calculation to a new helper, cxl_port_peer_distance().
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1a42753fda48..80c40716c368 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1432,6 +1432,33 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_region_ref *cxl_rr_iter;
> +	struct cxl_port *iter = port;
> +	int distance = 1;
> +
> +	/*
> +	 * The "distance" between peer downstream ports represents which
> +	 * endpoint positions in the region interleave a given port can
> +	 * host.
> +	 *
> +	 * For example, at the root of a hierarchy the distance is
> +	 * always 1 as every index targets a different host-bridge. At
> +	 * each subsequent switch level those ports map every Nth region
> +	 * position where N is the width of the switch == distance.
> +	 */
> +	do {
> +		cxl_rr_iter = cxl_rr_load(iter, cxlr);
> +		distance *= cxl_rr_iter->nr_targets;
> +		iter = to_cxl_port(iter->dev.parent);
> +	} while (!is_cxl_root(iter));
> +	distance *= cxlrd->cxlsd.cxld.interleave_ways;
> +
> +	return distance;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1445,7 +1472,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_port *iter = port;
>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
> @@ -1460,27 +1486,9 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
>  	if (cxl_rr->nr_targets_set) {
> -		int i, distance = 1;
> -		struct cxl_region_ref *cxl_rr_iter;
> +		int distance = cxl_port_peer_distance(port, cxlr);
>  
> -		/*
> -		 * The "distance" between peer downstream ports represents which
> -		 * endpoint positions in the region interleave a given port can
> -		 * host.
> -		 *
> -		 * For example, at the root of a hierarchy the distance is
> -		 * always 1 as every index targets a different host-bridge. At
> -		 * each subsequent switch level those ports map every Nth region
> -		 * position where N is the width of the switch == distance.
> -		 */
> -		do {
> -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> -			distance *= cxl_rr_iter->nr_targets;
> -			iter = to_cxl_port(iter->dev.parent);
> -		} while (!is_cxl_root(iter));
> -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> -
> -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
>  				rc = check_last_peer(cxled, ep, cxl_rr,
>  						     distance);

