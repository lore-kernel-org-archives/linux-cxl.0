Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782593FE7
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757544679; cv=none; b=oyu9y1cqHh15vkxbpx59INcBVcsm/3dbHOkB2HXQbhVERcJdDIXi7cYw7D6mwLZe8BC07oX/lMyLlkoq3SYdawUanABdPIhAbk39uBfW1lLA3wnQEkbMSm5GE53Ar8m7jQct7lafe/tcETapTDPw1IgunIEdwqhyXX4GpSuboTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757544679; c=relaxed/simple;
	bh=dz+vi2Xscke2xoFxiH3X89+oWdUa4Lnm+WWoAWg646U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XvSug+ZPyPRf1YtdYOpmIi/LVz4HZwNfVvzJbBGV/ovZzQJ1Z4JRGHWSvGFYY5hwjYLTlOYPmhCkoK2IfjLbfRqg7adTW8PrvaqG8Rkd5DaA9icy3x3GnVlNDflMlBqJ3mV+/AALNjamvYXK0mDmh+rZFci3Q27/bwDPaayL8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFqIeRmr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFqIeRmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757544677; x=1789080677;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dz+vi2Xscke2xoFxiH3X89+oWdUa4Lnm+WWoAWg646U=;
  b=TFqIeRmrynHB/RWz/tyDBv7d2MalOf9VaI9/DtLCRPB/Sx/nfL418jFb
   6VY9uxRbd0GuRD5KLbRVLgTnvUish5x6z3bkfhCmI1PhWFtol6t/94ASg
   0HPp37J9vdfp0h5vSaDfHsV6VKyQ/VrgFhHX1arm9VW5vxBhWJhcUrnLa
   NRa/Eli0NT8ykiHHd7be4Et3FtKTI5pLl/zZIbr/Nou8laioU570Oxyvl
   SBm8pP6n91nGCJL/+hFHV1d+CuyMqzXIaxqBYEXCzQEOv5QxolAp/H+uk
   nXLZK/MLDQhJwv9ecOyUVZN8K6B2gCcdnHeiLcYnQ231Uo/PP9VQrtpnE
   A==;
X-CSE-ConnectionGUID: 8UwR27nPS3O1jRGqujJn8w==
X-CSE-MsgGUID: 0GQvzUwJTcufH/5Pzs4v9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59930812"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59930812"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 15:51:15 -0700
X-CSE-ConnectionGUID: i5xgW3u9TOWjjtbUbe7eew==
X-CSE-MsgGUID: qIGnMdUCRjaO9PSqyju30g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="173899957"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.219]) ([10.125.110.219])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 15:51:14 -0700
Message-ID: <57c45f8b-2abc-48a7-a14f-2857c1fd8df1@intel.com>
Date: Wed, 10 Sep 2025 15:51:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/18] cxl/cache: Add cache device counting for CXL
 ports
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-17-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812212921.9548-17-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 2:29 PM, Ben Cheatham wrote:
> Having more than one CXL.cache enabled device under a port requires CXL
> cache id capabilities (CXL 3.2 8.2.4.28/29).
> 
> Add tracking of how many cache devices are under a port. If the required
> capabilities are absent and more than one device is enabled under the
> port, fail allocation of a cache id.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/cache.c     | 42 ++++++++++++++++++++++++++++-------------
>  drivers/cxl/core/port.c |  1 +
>  drivers/cxl/cxl.h       |  2 ++
>  3 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> index fa3223165a18..886f9794472c 100644
> --- a/drivers/cxl/cache.c
> +++ b/drivers/cxl/cache.c
> @@ -62,8 +62,12 @@ static int map_cache_idrt_cap(struct cxl_port *port)
>  	if (port->regs.cidrt)
>  		return 0;
>  
> +	/*
> +	 * A missing Cache ID Route Table capability is only an issue
> +	 * if there are multiple cache devices under the port
> +	 */
>  	if (!port->reg_map.component_map.cidrt.valid)
> -		return -ENXIO;
> +		return port->cache_devs ? -ENXIO : 0;
>  
>  	return cxl_map_component_regs(&port->reg_map, &port->regs.component,
>  				      BIT(CXL_CM_CAP_CAP_ID_CIDRT));
> @@ -71,19 +75,11 @@ static int map_cache_idrt_cap(struct cxl_port *port)
>  
>  static int map_cache_idd_cap(struct cxl_dport *dport)
>  {
> -	int agents;
> -
>  	if (dport->regs.cidd)
>  		return 0;
>  
> -	/*
> -	 * A missing Cache ID Decoder capability is only an issue
> -	 * if there are multiple cache agents in the VCS
> -	 */
> -	if (!dport->reg_map.component_map.cidd.valid) {
> -		agents = atomic_read(&dport->port->cache_agents);
> -		return agents > 1 ? -ENXIO : 0;
> -	}
> +	if (!dport->reg_map.component_map.cidd.valid)
> +		return dport->port->cache_devs ? -ENXIO : 0;

This bit is a bit weird for the series. Where did cache_agents go and why not use cache_devs to begin with for the series?

>  
>  	return cxl_map_component_regs(&dport->reg_map,
>  				      &dport->regs.component,
> @@ -136,6 +132,19 @@ static int find_cache_id(struct cxl_cachedev *cxlcd)
>  	return devm_add_action_or_reset(&cxlcd->dev, free_cache_id, cstate);
>  }
>  
> +static void cxl_deactivate_cache(void *data)
> +{
> +	struct cxl_cachedev *cxlcd = data;
> +	struct cxl_port *port = cxlcd->endpoint;
> +
> +	for (port = cxlcd->endpoint; port && !is_cxl_root(port);
> +	     port = parent_port_of(port)) {
> +		scoped_guard(device, &port->dev) {
> +			port->cache_devs--;
> +		}

I think you can just use guard() here since it goes out of scope of the for loop each iteration.

> +	}
> +}
> +
>  static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>  {
>  	struct cxl_port *endpoint = cxlcd->endpoint, *port;
> @@ -167,9 +176,17 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>  		rc = cxl_dport_program_cache_idd(dport, cxlcd);
>  		if (rc)
>  			return rc;
> +
> +		port->cache_devs++;

Does this need some locking for race protection? Maybe the port was already locked in this function earlier....

DJ

>  	}
>  
> -	return 0;
> +	if (!is_cxl_root(port)) {
> +		cxl_deactivate_cache(cxlcd);
> +		return -ENODEV;
> +	}
> +
> +	return devm_add_action_or_reset(&cxlcd->dev, cxl_deactivate_cache,
> +					cxlcd);
>  }
>  
>  static int find_snoop_gid(struct cxl_cachedev *cxlcd, u32 *gid)
> @@ -239,7 +256,6 @@ static int cxl_cache_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -
>  	return devm_cxl_cachedev_allocate_cache_id(cxlcd);
>  }
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 3606ad557bfb..f9f1f0ff08c9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -618,6 +618,7 @@ struct cxl_port *parent_port_of(struct cxl_port *port)
>  		return NULL;
>  	return port->parent_dport->port;
>  }
> +EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");
>  
>  static void unregister_port(void *_port)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9c475d8c1573..c67da9a378df 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -646,6 +646,7 @@ struct cxl_dax_region {
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
>   * @nr_hdmd: Number of HDM-D devices below port
> + * @cache_devs: Number of CXL.cache devices below this port
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -672,6 +673,7 @@ struct cxl_port {
>  	bool cdat_available;
>  	long pci_latency;
>  	int nr_hdmd;
> +	int cache_devs;
>  };
>  
>  /**

