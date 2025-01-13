Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC3240232;
	Mon, 13 Jan 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789889; cv=none; b=tRZvbwo0xH4gbmKsuHiJm7YZS4wgRPwWeM/gG54ix2B0P0xEv33u8cy5H/9jFwswDpHUGkb3v1ymmHAQLs9hrBEH3JYphHrav2PpJS6wepdjq9lhfMD+EpLDIofeVJBiJONZH/LqTwKnMmluyGkl1rF8QoDdsGD9s/8KeocNoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789889; c=relaxed/simple;
	bh=KrxkQ4xESXwS66P/rii1UuNkT5eKN2mKOSIR7ugZI5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YutzBaq+KZNxh6Ir62HouhW3GjNB+rWnG0LqrZP4s00jmlB3XWvpEjC87p/BOssyY6FpHO0uVHROoCy2GDqRpggoDWcvXSMsphF4yMI5SkJM2QYpSVhDKWMMV99ESIB5eie/NzpfjQfzwVIvyh2e53uqzJlozapSily6YP4acFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4mgAWJE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4mgAWJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736789887; x=1768325887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KrxkQ4xESXwS66P/rii1UuNkT5eKN2mKOSIR7ugZI5g=;
  b=P4mgAWJESSIpLnzREzTRGzZufDh+gK0sq/SNRvqjKdSZCirwDscWn0iF
   pLgQmTEASBd5wR+u9Ffpl3WzIBwsFWzuQK4XyD5EX4GfassQYAAvZMR85
   BdY8erR8j1PGygQ2+zcSn+jjlYYepdUR1fgQYSEoNqgOYlkcoB4oDF2fD
   0QEOhYjL7iBISFgtTiUFSZ2DpUBkSAQKro1I0/irccCSJX9OPcLPfQEXi
   J9iSaIlGc4AHTem5NnqhGhYo17jjzy4dK9v+4RYG3XLprnixp02PCW+CP
   GCtI9Mxvpvi2gazN2ZDezu1sYTdnDnBDjvsnPI9e5LuPjsgyDOQGCwS4C
   w==;
X-CSE-ConnectionGUID: Ajbapg8FQcGqSvcCuUVC0w==
X-CSE-MsgGUID: WYBNJ8mTQ9q+/MG0TuTu/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36353081"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36353081"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:38:06 -0800
X-CSE-ConnectionGUID: 1QvN4tKdTyyPwBuRqy0L9A==
X-CSE-MsgGUID: 5Lmia9ZUSNKzbBflfo9ziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109176768"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.60])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:38:06 -0800
Date: Mon, 13 Jan 2025 09:38:04 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 24/29] cxl/region: Use endpoint's SPA range to check a
 region
Message-ID: <Z4VPfGtDiP5sYiIM@aschofie-mobl2.lan>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-25-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-25-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:10PM +0100, Robert Richter wrote:
> Endpoints or switches requiring address translation might not be aware
> of the system's interleaving configuration. Then, the configured
> endpoint's address range might not match the expected range. In
> contrast, the SPA range of an endpoint is calculated applying platform
> specific address translation. That range is correct and can be used to
> check a region range.
> 
> Adjust the region range check and use the endpoint's SPA range to
> check it.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3322bae05b9..1dae7d36d37c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1516,22 +1516,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
> -		    cxld->hpa_range.start != p->res->start ||
> -		    cxld->hpa_range.end != p->res->end ||
> +		    cxled->spa_range.start != p->res->start ||
> +		    cxled->spa_range.end != p->res->end ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
>  				__func__, iw, ig, p->res);
>  			dev_err(&cxlr->dev,
> -				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
> +				"%s:%s %s got iw: %d ig: %d state: %s %#llx-%#llx:%#llx-%#llx(%s):%#llx-%#llx(%s)\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
>  				__func__, cxld->interleave_ways,
>  				cxld->interleave_granularity,
>  				(cxld->flags & CXL_DECODER_F_ENABLE) ?
>  					"enabled" :
>  					"disabled",
> -				cxld->hpa_range.start, cxld->hpa_range.end);
> +				p->res->start, p->res->end,
> +				cxled->spa_range.start, cxled->spa_range.end,
> +				dev_name(&cxled->cxld.dev),
> +				cxld->hpa_range.start, cxld->hpa_range.end,
> +				dev_name(&cxld->dev));
>  			return -ENXIO;
>  		}
>  	} else {
> @@ -2051,13 +2055,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
> -	    resource_size(p->res)) {
> +	if (range_len(&cxled->spa_range) != resource_size(p->res)) {
>  		dev_dbg(&cxlr->dev,
> -			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
> +			"%s:%s: SPA size mismatch: %#llx-%#llx:%#llx-%#llx\n",

The cxled->spa_range is only set in the auto region path, yet this
path is taken by both auto and user created regions. User created regions
die here.


>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			(u64)resource_size(cxled->dpa_res), p->interleave_ways,
> -			(u64)resource_size(p->res));
> +			p->res->start, p->res->end,
> +			cxled->spa_range.start, cxled->spa_range.end);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.39.5
> 
