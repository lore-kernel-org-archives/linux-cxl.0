Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFAA264606;
	Thu, 20 Feb 2025 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088608; cv=none; b=YIkA68NyIBlPVEgbURItAAkYGPiiIFFKfDVWqCuB/DKoTT0sDgcrPJRE7Xzy7eDX1mPR3DT2JK0kJFCghJCv/dG8VLbxWpZ1d3TIk/NIsNKVId9AO9bFbaxLsyCxk4E20JQex3mht1e2kolJbU8iqceHtudrLDwLtzwd/HfMrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088608; c=relaxed/simple;
	bh=Q+CtP725yjzh3BVHN6CrzKBaYx2g+Bje7xEBNxgNamY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6iwKkLxaeLgUnj8wq2bcExC32yWMGUlYrAPBx0uqHLk10SuSLknckGv2dOlfjb5JIi9WnScv84kA/aGGQFf8FJZGb9ASrBID6qpBjz4fthjdyyPoHxKaDPFalHrCZF7ffRDN7bSY3gCuwaMt8dcwAdpZ3TvYqSQ5URBIP+bRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcHIJhbh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcHIJhbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740088606; x=1771624606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q+CtP725yjzh3BVHN6CrzKBaYx2g+Bje7xEBNxgNamY=;
  b=ZcHIJhbhqux/ozDIkab2vXAV2g8+bBMF1F9W8QhmNclOoF5ykS6om7kF
   R8FFp4OLggf+2CYU6/57C4uhEph9yam9XZkRXnzg5tb0QBoiWoLG9Ohg1
   3pteNyj1wGg2aHBwjhg6R5/0NJITpZDx/ETUCSETuFGGtzLgcYEnsObkG
   +xHJmtCt3PwBM9P9ZJ80jcgighexeO/bVYzUXxxLS4TJzje9WUk56qz/1
   K9G4Gs0S/nQkomwr9b49xnxzDgxVAgJ2hJuzm9IqI+Z08gmCuDYv52snb
   ATFvb0M5O/zSS7Jirb7+GkQbsUPp+V12kneXFp57JsHjjBwk5dwdvjkZH
   w==;
X-CSE-ConnectionGUID: B3uZ/kvWR+aQQTYixYnc3g==
X-CSE-MsgGUID: ZiIC+n7pS8+cEwo3xezrdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="52296156"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="52296156"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 13:56:45 -0800
X-CSE-ConnectionGUID: FAig6Bl0SHOEI3bQxZ9k7g==
X-CSE-MsgGUID: ZGayH2+4Ss+SlfTn5YNbug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="119787878"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 13:56:44 -0800
Message-ID: <0279dabe-1c2f-46b2-a5c3-9a712a2c7311@intel.com>
Date: Thu, 20 Feb 2025 14:56:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] cxl/region: Calculate endpoint's region position
 during init
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
 <20250218132356.1809075-5-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250218132356.1809075-5-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 6:23 AM, Robert Richter wrote:
> The calculation of an endpoint's position in a region traverses all
> ports up to the root port and determines the corresponding decoders
> for that particular address range. For address translation the HPA
> range must be recalculated between ports. In order to prepare the
> implementation of address translation, move code to
> cxl_endpoint_decoder_initialize() and reuse the existing iterator
> there.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ad4a6ce37216..6f106bfa115f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1903,7 +1903,6 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that follow-on code paths can reliably

Do the comments need to be updated here with the deletion of that line above?

DJ

> @@ -3264,10 +3263,22 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *iter = cxled_to_port(cxled);
>  	struct cxl_decoder *root, *cxld = &cxled->cxld;
> -	struct range *hpa = &cxld->hpa_range;
> +	struct range hpa = cxld->hpa_range;
> +	struct cxl_interleave_context ctx;
> +	int rc;
>  
> -	while (iter && !is_cxl_root(iter))
> -		iter = to_cxl_port(iter->dev.parent);
> +	ctx = (struct cxl_interleave_context) {
> +		.hpa_range = &hpa,
> +	};
> +
> +	while (iter && !is_cxl_root(iter)) {
> +		/* Convert interleave settings to next port upstream. */
> +		rc = cxl_port_calc_interleave(iter, &ctx);
> +		if (rc < 0)
> +			return rc;
> +
> +		iter = parent_port_of(iter);
> +	}
>  
>  	if (!iter)
>  		return -ENXIO;
> @@ -3281,7 +3292,13 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  		return -ENXIO;
>  	}
>  
> +	dev_dbg(cxld->dev.parent,
> +		"%s:%s: range:%#llx-%#llx pos:%d\n",
> +		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
> +		hpa.start, hpa.end, ctx.pos);
> +
>  	cxled->cxlrd = to_cxl_root_decoder(&root->dev);
> +	cxled->pos = ctx.pos;
>  
>  	return 0;
>  }

