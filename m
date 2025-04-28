Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60C15ECD7;
	Mon, 28 Apr 2025 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745879331; cv=none; b=JCP0YkEdrE7T5x6sEPEfCPpuAewBwAubXgJi5vgUiZqi1PhcK5hzFL+tXTpuMMNMJW3+SnlCuhT+VYLZQlXvw5g8ZP12EwKgO6Timx6W4fe62uILFdxzyMby74ALw3GZufDwe3CanlWeIZPED6J+QvnZ6KKXAmoVla5wp2RpiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745879331; c=relaxed/simple;
	bh=44rzAJ7gbrN51ywSzm9xKpbUf8gwxuK3HDN71uR0VUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kE0JU36jxi0nX6pHE2jLtPegpl3CRtQLvVyEoMLWZNO/omCfl9CIihIn1S7Kx1rkKbPgKj/BU32chEXzO4kQnLNCCPeqMF1k5gdbXoRmsAoYOYaZHd6wGso2ZBRk0VYudj90cvF3UzoS4qLz4JGAjNeW62lRjSzyrfogfyYuE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqZ2xKyy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqZ2xKyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745879330; x=1777415330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=44rzAJ7gbrN51ywSzm9xKpbUf8gwxuK3HDN71uR0VUQ=;
  b=mqZ2xKyyVe7S+MAlEmTLe56wPdjKmKfOzLopIdXy4ji3JDpepE/qxYAe
   4+BWdJL/bwjzEUFZNo0ZSz6sK2p2pk6E5Nai+N5DFAhLipVFzPx+VydHR
   JeUO4GIVJdEASt6UUsah7TaVZH3Bt8HdeQRkkF7wUn0rawKfNXnyjP9Oj
   uxOQjCJu3uimNF0eKW83hoTfMF7eAbANnJECRxW8UaWaWLsSfGMcqDksu
   GrCyv56Q+dsVXBMJdw+hq5ZrTWgvAxwD0wxnkE6bgd0wnhRzPOVjPpD6b
   m4AE/DjDle7LAWCPfvxzkogp2n5OezWlMukp62kxoYJi7XTjyzF/RW3+y
   w==;
X-CSE-ConnectionGUID: gtYA8vVdSCy0XHfeLYK1QA==
X-CSE-MsgGUID: 3fWIxEiaQnevYryPzFyX6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58476995"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58476995"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:28:49 -0700
X-CSE-ConnectionGUID: IWzjDtMDT6qbZy0NcDM+lw==
X-CSE-MsgGUID: Cg9KdP4cQaWtJywnCte7aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="138454573"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.95]) ([10.125.109.95])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:28:47 -0700
Message-ID: <86b998af-a496-41fd-a4c7-2d7b622f1d15@intel.com>
Date: Mon, 28 Apr 2025 15:28:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/14] cxl/region: Avoid duplicate call of
 cxl_port_pick_region_decoder()
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
References: <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-7-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250428214318.1682212-7-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/25 2:43 PM, Robert Richter wrote:
> Function cxl_port_pick_region_decoder() is called twice, in
> alloc_region_ref() and cxl_rr_alloc_decoder(). Both functions are
> subsequently called from cxl_port_attach_region(). Make the decoder a
> function argument to both which avoids a duplicate call of
> cxl_port_pick_region_decoder().
> 
> Now, cxl_rr_alloc_decoder() no longer allocates the decoder. Instead,
> the previously picked decoder is assigned to the region reference.
> Hence, rename the function to cxl_rr_assign_decoder().
> 
> Moving the call out of alloc_region_ref() also moves it out of the
> xa_for_each() loop in there. Now, cxld is determined no longer only
> for each auto-generated region, but now once for all regions
> regardless of auto-generated or not. This is fine as the cxld argument
> is needed for all regions in cxl_rr_assign_decoder() and an error would
> be returned otherwise anyway. So it is better to determine the decoder
> in front of all this and fail early if missing instead of running
> through all that code with multiple calls of
> cxl_port_pick_region_decoder().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e104035e0855..fa3d50982d04 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -931,7 +931,8 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
>  
>  static struct cxl_region_ref *
>  alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
> -		 struct cxl_endpoint_decoder *cxled)
> +		 struct cxl_endpoint_decoder *cxled,
> +		 struct cxl_decoder *cxld)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_region_ref *cxl_rr, *iter;
> @@ -945,9 +946,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
>  			continue;
>  
>  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -			struct cxl_decoder *cxld;
> -
> -			cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
>  			if (auto_order_ok(port, iter->region, cxld))
>  				continue;
>  		}
> @@ -1029,19 +1027,11 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
>  	return 0;
>  }
>  
> -static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> -				struct cxl_endpoint_decoder *cxled,
> -				struct cxl_region_ref *cxl_rr)
> +static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> +				 struct cxl_endpoint_decoder *cxled,
> +				 struct cxl_region_ref *cxl_rr,
> +				 struct cxl_decoder *cxld)
>  {
> -	struct cxl_decoder *cxld;
> -
> -	cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
> -	if (!cxld) {
> -		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> -			dev_name(&port->dev));
> -		return -EBUSY;
> -	}
> -
>  	if (cxld->region) {
>  		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
>  			dev_name(&port->dev), dev_name(&cxld->dev),
> @@ -1132,7 +1122,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  			nr_targets_inc = true;
>  		}
>  	} else {
> -		cxl_rr = alloc_region_ref(port, cxlr, cxled);
> +		struct cxl_decoder *cxld;
> +
> +		cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
> +		if (!cxld) {
> +			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> +				dev_name(&port->dev));
> +			return -EBUSY;
> +		}
> +
> +		cxl_rr = alloc_region_ref(port, cxlr, cxled, cxld);
>  		if (IS_ERR(cxl_rr)) {
>  			dev_dbg(&cxlr->dev,
>  				"%s: failed to allocate region reference\n",
> @@ -1141,7 +1140,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  		}
>  		nr_targets_inc = true;
>  
> -		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
> +		rc = cxl_rr_assign_decoder(port, cxlr, cxled, cxl_rr, cxld);
>  		if (rc)
>  			goto out_erase;
>  	}

