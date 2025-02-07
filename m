Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929D42069;
	Fri,  7 Feb 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738969696; cv=none; b=NvBpHF+LFYw3tDU1oaS3mW2byDeDHqu0DkJMnwnH9a0j087RzUoEux1fj9a4hfUUhE0veaR4PvK4aZo92iG6E/8xwy8YjJmtVs+OfPOCc4CsLtlkaAdaLXlfJFyrQ7d9BF5C8+pJLXdZJYnZ+0/aBkTcOS6LWOuCGaTxMtPEYK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738969696; c=relaxed/simple;
	bh=Oc7RiMoWI7yb2Dpzra2Br0c8/SWdMxeBDwF0F1BCyb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5SJjWlvcQjK/henby6uktvjtI78h78ZgwV1GwPZJZsPRJLDl/XcCn+YBv03XVW5rNpNpVksgrhDrgsIKVVd0/rDue7eXhbUVPLRA3XEMmiIwYi+smt7iRXObvFdgG8uF+ctFxi6ctPu2WC0jGNGpt9ggM4mni8pR1OleD/g814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IubVekm8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IubVekm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738969694; x=1770505694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oc7RiMoWI7yb2Dpzra2Br0c8/SWdMxeBDwF0F1BCyb8=;
  b=IubVekm82EAycqEJUEGOt0lZKB4PXE9JQgS0WuOiQF8uJg473jv1H8F7
   aEqW9Bv2niU+hTbFN8zwlLCesJ2eBXpnYuvlOQQhaqJHS+hxX9RUTnd+D
   BVcPEVbpahLyfWn50pLiwS+fytE5ab4WoRq+sDGMKwmUOx8ircGefnq5+
   XDwjj24T8lgO3rKMz7UZRv1K9UOGBJCwXfyQR8DEw3CUfsJwcULDw2BWa
   kKY2cpM4KvY0a3v433wdIAQdfKSef5G8/nnN4nuD8jBBmeV/9PAmlyGCK
   UbLc3r7kn+QrSSbAd2/Q/RE9WBVqO2+kdNcrsw4sbi2h/UNWRDLSQYFEn
   A==;
X-CSE-ConnectionGUID: U6lJF+J/TuyDIQsh0/JPuA==
X-CSE-MsgGUID: BtUWdYXRQO2sXTb4i04frQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="57041247"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="57041247"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 15:08:13 -0800
X-CSE-ConnectionGUID: Ticm+k70TgqMdmnjmXTvSA==
X-CSE-MsgGUID: 4mLKRo8+S1+cdz+jELcYUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116862702"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.82])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 15:08:13 -0800
Date: Fri, 7 Feb 2025 15:08:11 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 05/18] cxl: Introduce parent_port_of() helper
Message-ID: <Z6aSW8N4yULozrDE@aschofie-mobl2.lan>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-6-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207153753.418849-6-rrichter@amd.com>

On Fri, Feb 07, 2025 at 04:37:40PM +0100, Robert Richter wrote:
> Often a parent port must be determined. Introduce the parent_port_of()
> helper function for this.

Would this be simpler with less touchpoints:

Make next_port() available to the port driver by moving it from
region.c to port.c. Note that simply exporting from the region
driver is not an option since region driver is not guaranteed
to be configured.

(Basically I'm suggesting keep the name and touch region.c less)

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/port.c   | 15 +++++++++------
>  drivers/cxl/core/region.c | 11 ++---------
>  drivers/cxl/cxl.h         |  1 +
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f9501a16b390..d19930c009ce 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -606,17 +606,20 @@ struct cxl_port *to_cxl_port(const struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
>  
> +struct cxl_port *parent_port_of(struct cxl_port *port)
> +{
> +	if (!port || !port->parent_dport)
> +		return NULL;
> +	return port->parent_dport->port;
> +}
> +EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");
> +
>  static void unregister_port(void *_port)
>  {
>  	struct cxl_port *port = _port;
> -	struct cxl_port *parent;
> +	struct cxl_port *parent = parent_port_of(port);
>  	struct device *lock_dev;
>  
> -	if (is_cxl_root(port))
> -		parent = NULL;
> -	else
> -		parent = to_cxl_port(port->dev.parent);
> -
>  	/*
>  	 * CXL root port's and the first level of ports are unregistered
>  	 * under the platform firmware device lock, all other ports are
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5d252dfae138..54afdb0fa61c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1734,13 +1734,6 @@ static int cmp_interleave_pos(const void *a, const void *b)
>  	return cxled_a->pos - cxled_b->pos;
>
}
>  
> -static struct cxl_port *next_port(struct cxl_port *port)
> -{
> -	if (!port->parent_dport)
> -		return NULL;
> -	return port->parent_dport->port;
> -}
> -
>  static int match_switch_decoder_by_range(struct device *dev,
>  					 const void *data)
>  {
> @@ -1767,7 +1760,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	struct device *dev;
>  	int rc = -ENXIO;
>  
> -	parent = next_port(port);
> +	parent = parent_port_of(port);
>  	if (!parent)
>  		return rc;
>  
> @@ -1847,7 +1840,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  	 */
>  
>  	/* Iterate from endpoint to root_port refining the position */
> -	for (iter = port; iter; iter = next_port(iter)) {
> +	for (iter = port; iter; iter = parent_port_of(iter)) {
>  		if (is_cxl_root(iter))
>  			break;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6baec4ba9141..0d7aff8b97b3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -721,6 +721,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  int cxl_num_decoders_committed(struct cxl_port *port);
>  bool is_cxl_port(const struct device *dev);
>  struct cxl_port *to_cxl_port(const struct device *dev);
> +struct cxl_port *parent_port_of(struct cxl_port *port);
>  void cxl_port_commit_reap(struct cxl_decoder *cxld);
>  struct pci_bus;
>  int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
> -- 
> 2.39.5
> 
