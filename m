Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3816A20D4E5;
	Thu, 20 Feb 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069546; cv=none; b=f8MLMjCZycvMq7Z8i6cMDi6vQsmXxltlgroN9xisD1SWcOGd6mcS4U8osCb0ikOOI1BVHOumMBeksJoxO1YbbivnTv3evKk6VDjzb6xBjzGjOGdHSAkGq/beUmjENf0qBdJR+1uRa5Z3gk8SygWwpFdyrMFdul1VyDrH2Ow6u90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069546; c=relaxed/simple;
	bh=6c3M3/H3d/rB8boAVdOTFz8yVLhF9V4baexn6AsQYTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Obk9dJqEbxr1EQXLGavTd1jiLfgwiowXkhq3HJj4eQBHSDjncSeVksFCFzzBfohZuYjvBFMj3MyEIVqwhsASJgQgh0lAFBZ/l/tIadTY8DHSsxvLWbUsYqSf8UyxTigcfdmh4agCKLl0ZQwh5KXdC8DYt0eXvGnmuq+6pi6uUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/JKprIb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/JKprIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740069544; x=1771605544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6c3M3/H3d/rB8boAVdOTFz8yVLhF9V4baexn6AsQYTw=;
  b=F/JKprIbO0vGHiK6UH/+d/bus+hs8Sl/M6JdyzJRk6m8gFqrbgbWgN2F
   WvLRy0pkLGmyZV8o9dKRBsnFNE3vPv9iPSdFC5VHJla5M/NIBW1vp5Zen
   wO+PJWtybuxi3QucmZU2qqTyY+Qug8owIkDZq+9jJRjLt6a8pP8PlaigM
   LgK2krnZQinQePfjmpbf8Le59jkAx8ImX8937mIL89UmoBCM7zoJfybDF
   c96X97M+GQPjpMoE7r00fgdbvzXpiLntAN1M8jtK9sQlQB0X/KvVjdYHN
   dmHcPqKg4XNSHYbtYO/eF87Bra72+9tt5AiQ8Gw4XbCHk915R2rGeOHDT
   w==;
X-CSE-ConnectionGUID: 87SbP4zaSfuiYFtsFRzOIQ==
X-CSE-MsgGUID: T0KwY2GMQR2DrqBJhlPQFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40092962"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40092962"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:39:03 -0800
X-CSE-ConnectionGUID: 2DMaJdWlSfChCTtu1Lllnw==
X-CSE-MsgGUID: jIlDam7STi6ri8i2miXBLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120035861"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:39:02 -0800
Message-ID: <d8056909-abd0-480a-862a-4ed472eab699@intel.com>
Date: Thu, 20 Feb 2025 09:39:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/18] cxl/region: Move find_cxl_root() to
 cxl_add_to_region()
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
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-9-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-9-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
> When adding an endpoint to a region, the root port is determined
> first. Move this directly into cxl_add_to_region(). This is in
> preparation of the initialization of endpoints that iterates the port
> hierarchy from the endpoint up to the root port.
> 
> As a side-effect the root argument is removed from the argument lists
> of cxl_add_to_region() and related functions. Now, the endpoint is the
> only parameter to add a region. This simplifies the function
> interface.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c |  6 ++++--
>  drivers/cxl/cxl.h         |  6 ++----
>  drivers/cxl/port.c        | 15 +++------------
>  3 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b8201c2faa87..0e38bcb43be6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3312,9 +3312,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> -int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
> +int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct device *cxlrd_dev, *region_dev;
> @@ -3324,7 +3326,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  	bool attach = false;
>  	int rc;
>  
> -	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
> +	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
>  				      match_root_decoder_by_range);
>  	if (!cxlrd_dev) {
>  		dev_err(cxlmd->dev.parent,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0d7aff8b97b3..85dfc8df0a80 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -854,8 +854,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
>  #ifdef CONFIG_CXL_REGION
>  bool is_cxl_pmem_region(struct device *dev);
>  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
> -int cxl_add_to_region(struct cxl_port *root,
> -		      struct cxl_endpoint_decoder *cxled);
> +int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
> @@ -866,8 +865,7 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  {
>  	return NULL;
>  }
> -static inline int cxl_add_to_region(struct cxl_port *root,
> -				    struct cxl_endpoint_decoder *cxled)
> +static inline int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	return 0;
>  }
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d2bfd1ff5492..74587a403e3d 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -30,7 +30,7 @@ static void schedule_detach(void *cxlmd)
>  	schedule_cxl_memdev_detach(cxlmd);
>  }
>  
> -static int discover_region(struct device *dev, void *root)
> +static int discover_region(struct device *dev, void *unused)
>  {
>  	struct cxl_endpoint_decoder *cxled;
>  	int rc;
> @@ -49,7 +49,7 @@ static int discover_region(struct device *dev, void *root)
>  	 * Region enumeration is opportunistic, if this add-event fails,
>  	 * continue to the next endpoint decoder.
>  	 */
> -	rc = cxl_add_to_region(root, cxled);
> +	rc = cxl_add_to_region(cxled);
>  	if (rc)
>  		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
>  			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
> @@ -95,7 +95,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_hdm *cxlhdm;
> -	struct cxl_port *root;
>  	int rc;
>  
>  	rc = cxl_dvsec_rr_decode(cxlds, &info);
> @@ -126,19 +125,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * This can't fail in practice as CXL root exit unregisters all
> -	 * descendant ports and that in turn synchronizes with cxl_port_probe()
> -	 */
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> -
> -	root = &cxl_root->port;
> -
>  	/*
>  	 * Now that all endpoint decoders are successfully enumerated, try to
>  	 * assemble regions from committed decoders
>  	 */
> -	device_for_each_child(&port->dev, root, discover_region);
> +	device_for_each_child(&port->dev, NULL, discover_region);
>  
>  	return 0;
>  }

