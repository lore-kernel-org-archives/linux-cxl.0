Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0936BCE7;
	Wed, 19 Nov 2025 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585103; cv=none; b=qTiwzIvbAEa1paH82TndFn0QTJ8IOHWz7CNS51p6duzjTtwrEnnO8asH1E4yB/JLg2crv/iLHk57Wqhp8T5wGG5PlVmLoqipsf/VhRmAFAiIEyC13t7iuZhi9MV/gpR91KSBLYTVx07w+2Wh1fiigycEOUFWEbZnmp67cCzxOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585103; c=relaxed/simple;
	bh=B2f6B6S+FHL5hizn0UQoi04FP+vJZRObbLX2EuUyJI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwV9qV8qszZnwqC60tUYjhh9izOeT9w2DSSzncfQZDM14p35fQiqTNkEJtKkZi2pxNwJ0h1J/dHa6tkc0EKyBbv5dyGaYmvh++k2ECsXq3w67DPTab4iIp/aZkV5n74PEbcr+n4Wxec5ZlHDhDrc9YYzRkPXx0S9JTE7etWZ+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiWkHYD/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiWkHYD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763585098; x=1795121098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B2f6B6S+FHL5hizn0UQoi04FP+vJZRObbLX2EuUyJI8=;
  b=LiWkHYD/Dab81QRI4/phQBTRhwj5hHnFUFyoHurqOzzt9kJn/3AoyLbQ
   dy3f8kJ+L3C4bTDbw1Zo8qgh07XjAindLjBiZgQw5TdJHBMu8LU2ssXHm
   IwaxgDqt0dCB0MljkevvTZto9dRxH2naShT4qwTDdEmPuIZ8EhkHrLXGR
   a5E8wqoFGWCA7hqHuNlgOh3vBPrDu8KZjGvDBiCK3wOOTjrhAQ+35hJwa
   hMvup5kW732lHA7jyD1wCkYriORdmBI+WW04FeHHVwUSC9vtF+TWtlVpy
   lX0EHFmsN3tkooeLHrDusIG5W2rrTrInp238oJ/4BtnrFzjJPqiIMdEuV
   Q==;
X-CSE-ConnectionGUID: L3aMvq3YSX6lWPBU30N4hg==
X-CSE-MsgGUID: XkhoR6x/S4W14jjOfXd8LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="83264941"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="83264941"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 12:44:56 -0800
X-CSE-ConnectionGUID: qB1N2x2xSuaxI51qyH9Eyg==
X-CSE-MsgGUID: 8TkHXtv7TAeiq7ELSeHj+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="191600179"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 12:44:55 -0800
Message-ID: <48855612-3643-4d91-84aa-784cbc3fd593@intel.com>
Date: Wed, 19 Nov 2025 13:44:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/17] cxl/mem: Refactor cxl pmem region
 auto-assembling
To: Neeraj Kumar <s.neeraj@samsung.com>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com
References: <20251119075255.2637388-1-s.neeraj@samsung.com>
 <CGME20251119075324epcas5p1b0a7149ede962491e6be2d72d33f77eb@epcas5p1.samsung.com>
 <20251119075255.2637388-11-s.neeraj@samsung.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251119075255.2637388-11-s.neeraj@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 12:52 AM, Neeraj Kumar wrote:
> In 84ec985944ef3, devm_cxl_add_nvdimm() sequence was changed and called
> before devm_cxl_add_endpoint(). It's because cxl pmem region auto-assembly
> used to get called at last in cxl_endpoint_port_probe(), which requires
> cxl_nvd presence.
> 
> For cxl region persistency, region creation happens during nvdimm_probe
> which need the completion of endpoint probe.
> 
> In order to accommodate both cxl pmem region auto-assembly and cxl region
> persistency, refactored following
> 
> 1. Re-Sequence devm_cxl_add_nvdimm() after devm_cxl_add_endpoint(). This
>    will be called only after successful completion of endpoint probe.
> 
> 2. Create cxl_region_discovery() which performs pmem region
>    auto-assembly and remove cxl pmem region auto-assembly from
>    cxl_endpoint_port_probe()
> 
> 3. Register cxl_region_discovery() with devm_cxl_add_memdev() which gets
>    called during cxl_pci_probe() in context of cxl_mem_probe()
> 
> 4. As cxlmd->ops->probe() calls registered cxl_region_discovery(), so
>    move devm_cxl_add_nvdimm() before cxlmd->ops->probe(). It gurantees

s/gurantees/guarantees/

>    both the completion of endpoint probe and cxl_nvd presence before
>    calling cxlmd->ops->probe().
> 
> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  5 +++++
>  drivers/cxl/mem.c         | 18 +++++++++---------
>  drivers/cxl/pci.c         |  4 +++-
>  drivers/cxl/port.c        | 39 +--------------------------------------
>  5 files changed, 55 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2cf5b29cefd2..3c868c4de4ec 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3724,6 +3724,43 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
>  
> +static int discover_region(struct device *dev, void *unused)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	if (cxled->state != CXL_DECODER_STATE_AUTO)
> +		return 0;
> +
> +	/*
> +	 * Region enumeration is opportunistic, if this add-event fails,
> +	 * continue to the next endpoint decoder.
> +	 */
> +	rc = cxl_add_to_region(cxled);
> +	if (rc)
> +		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
> +			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
> +
> +	return 0;
> +}
> +
> +int cxl_region_discovery(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +
> +	device_for_each_child(&port->dev, NULL, discover_region);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_region_discovery, "CXL");
> +
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
>  {
>  	struct cxl_region_ref *iter;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ba17fa86d249..684a0d1b441a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -904,6 +904,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
> +int cxl_region_discovery(struct cxl_memdev *cxlmd);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
>  {
> @@ -926,6 +927,10 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
>  {
>  	return 0;
>  }
> +static inline int cxl_region_discovery(struct cxl_memdev *cxlmd)
> +{
> +	return 0;
> +}
>  #endif
>  
>  void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 13d9e089ecaf..f5e3e2fca86c 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -115,15 +115,6 @@ static int cxl_mem_probe(struct device *dev)
>  		return -ENXIO;
>  	}
>  
> -	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> -		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
> -		if (rc) {
> -			if (rc == -ENODEV)
> -				dev_info(dev, "PMEM disabled by platform\n");
> -			return rc;
> -		}
> -	}
> -
>  	if (dport->rch)
>  		endpoint_parent = parent_port->uport_dev;
>  	else
> @@ -143,6 +134,15 @@ static int cxl_mem_probe(struct device *dev)
>  			return rc;
>  	}
>  
> +	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
> +		if (rc) {
> +			if (rc == -ENODEV)
> +				dev_info(dev, "PMEM disabled by platform\n");
> +			return rc;
> +		}
> +	}
> +
>  	if (cxlmd->ops) {
>  		rc = cxlmd->ops->probe(cxlmd);
>  		if (rc)
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e21051d79b25..d56fdfe4b43b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -907,6 +907,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> +	struct cxl_memdev_ops ops;
>  	struct cxl_memdev *cxlmd;
>  	int rc, pmu_count;
>  	unsigned int i;
> @@ -1006,7 +1007,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
>  
> -	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds, NULL);
> +	ops.probe = cxl_region_discovery;
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds, &ops);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d5fd0c5ae49b..ad98b2881fed 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -31,33 +31,6 @@ static void schedule_detach(void *cxlmd)
>  	schedule_cxl_memdev_detach(cxlmd);
>  }
>  
> -static int discover_region(struct device *dev, void *unused)
> -{
> -	struct cxl_endpoint_decoder *cxled;
> -	int rc;
> -
> -	if (!is_endpoint_decoder(dev))
> -		return 0;
> -
> -	cxled = to_cxl_endpoint_decoder(dev);
> -	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
> -		return 0;
> -
> -	if (cxled->state != CXL_DECODER_STATE_AUTO)
> -		return 0;
> -
> -	/*
> -	 * Region enumeration is opportunistic, if this add-event fails,
> -	 * continue to the next endpoint decoder.
> -	 */
> -	rc = cxl_add_to_region(cxled);
> -	if (rc)
> -		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
> -			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
> -
> -	return 0;
> -}
> -
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	/* Reset nr_dports for rebind of driver */
> @@ -83,17 +56,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> -	rc = devm_cxl_endpoint_decoders_setup(port);
> -	if (rc)
> -		return rc;
> -
> -	/*
> -	 * Now that all endpoint decoders are successfully enumerated, try to
> -	 * assemble regions from committed decoders
> -	 */
> -	device_for_each_child(&port->dev, NULL, discover_region);
> -
> -	return 0;
> +	return devm_cxl_endpoint_decoders_setup(port);
>  }
>  
>  static int cxl_port_probe(struct device *dev)

