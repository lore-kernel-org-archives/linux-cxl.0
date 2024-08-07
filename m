Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E013342F
	for <linux-cxl@vger.kernel.org>; Wed,  7 Aug 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057318; cv=none; b=G/ulJIO8dwBbMfyJUl+/j+Ret28TrqtwBQksnHKQC7L2YAObvIaTIFMLp2SEw7ib3YrMpm2XcNaoi6dSs144LtGkVRhsL+an7v/3u5MBZJopSIH9sBVJ20SaMksoeBJVkJyBu8tK1KqUbSiHqJ24QTy3it49bSV3jAXapUa4zzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057318; c=relaxed/simple;
	bh=ramDWWUQQh8KE2ZdoiDJVtctnxzKGRlijHUIG2m3TQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS79tzaFywSZHezFX8Ko3VgFeGD2vnQDFpAqfvjOAPWuL7lCaJ31DTuVxGvFm9y1wMTJZHpJp+FV1hLJcM6r0/+MWALVK7thlGaBhV76K3Q3XL7bH/4df/zETkabhYTGbfwLBpXHho6ir5ucJ/6zhvOiUZHj4Pnce2Mbk8fMvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eA3Hy9bE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eA3Hy9bE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723057316; x=1754593316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ramDWWUQQh8KE2ZdoiDJVtctnxzKGRlijHUIG2m3TQs=;
  b=eA3Hy9bErBLmHou+s2R7Bzb55RuB4fooXqSeNWT834tD3IW2OVJB6rd/
   AEZFU4qWKf2ebMnepdarZlK1eeeYdC/Xb8IHfqMVUBn4gblqCHcM3dgp+
   H4DQU1QFRKiX1DeHntkpZt0oywhOB0Z7EBcUr50+v6xQtGjsC/besClad
   5MJFYw6uSql7h/Wf4Fpu1MKqG+52a1mkW3X6LxB6ikrNg7hl0Gt/etLyH
   GGkGtiZRn6uWFwP51Ou1S1nNuVgSpMoQhiup3q7ZYGK4YloXGgEQQsyYf
   CZqgH0NR2+/ebkq2dlIzacGttkWE63pfw+apiaD8D8uyItPdbycADFjPL
   g==;
X-CSE-ConnectionGUID: BpBiXx5CSx+2pYkMXPGe9w==
X-CSE-MsgGUID: 5r570BzNQemqFidteDew3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20815710"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="20815710"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 12:01:55 -0700
X-CSE-ConnectionGUID: xn3uhSj5QtGPnA2CUtiZPg==
X-CSE-MsgGUID: i3AZDQO7R3ClWM5pgpiAlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="87617661"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.91.212])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 12:01:55 -0700
Date: Wed, 7 Aug 2024 12:01:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, ming4.li@intel.com
Subject: Re: [PATCH] cxl/pci: Fix DVSEC ranges validation to cover all ranges
Message-ID: <ZrPEoBbeV0BBdn8n@aschofie-mobl2>
References: <20240807131908.303600-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807131908.303600-1-yanfei.xu@intel.com>

On Wed, Aug 07, 2024 at 09:19:08PM +0800, Yanfei Xu wrote:
> cxl_endpoint_dvsec_info.ranges means the number of non-zero DVSEC
> range, and it will be less than the value of HDM_count when occuring
> zero DVSEC range. Hence using it for looping validation of DVSEC
> ranges in cxl_hdm_decode_init() and looping DVSEC decoder initialization
> in devm_cxl_enumerate_decoders could miss non-zero DVSEC ranges. And
> we should only create decoder for the allowed ranges.
> 
> Initializing content of all dvsec_range[] to invalid range and moving
> the check of dvsec_range_allowed() in advance to cxl_dvsec_rr_decode()
> could address that.

Hi Yanfei,

This is interesting but a bit much to review in one patch.

Please separate the fixes patch, that you comment above, from the refactoring
and the drop of wait_for_valid() changes. That'll make review easier.

For the fix. I understand that you found by inspection. Is the impact
that the driver will create decoders for NOT allowed ranges?  And
forgive me for not looking further into the code yet, but I'd like you
to lead me on that and explain the impact in the commit log.

I'm confused when the above says ranges 'means the number of non-zero
DVSEC range' and then says we should not use ranges while looping
because it 'could miss non-zero DVSEC ranges.' Is the
dvsec_range_allowed() callout in cxl_hdm_decoder_init() not doing
as expected? And why is it a 'could' miss and not an always miss?

Please v2 with this as a set. I'd prefer seeing the Fix first, unless
you think the refactor and wait_for_valid() change are required before
adding the fix.

--Alison

> 
> Other non-functional changes, refectoring cxl_dvsec_rr_decode to
> improve its readability and droping wait_for_valid() to use
> cxl_dvsec_mem_range_valid().
> 
> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
> Background: Found this issue when reading the CXL code. I didn't encounter
> the discribed issue in real environment.
> 
>  drivers/cxl/core/hdm.c        |   2 +-
>  drivers/cxl/core/pci.c        | 121 +++++++++++++---------------------
>  drivers/cxl/cxl.h             |   5 +-
>  drivers/cxl/port.c            |   2 +-
>  tools/testing/cxl/test/mock.c |   4 +-
>  5 files changed, 53 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3df10517a327..65f5fd2e4189 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -768,7 +768,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  
>  	cxled = to_cxl_endpoint_decoder(&cxld->dev);
>  	len = range_len(&info->dvsec_range[which]);
> -	if (!len)
> +	if (WARN_ON(len == 0 || len == CXL_RESOURCE_NONE))
>  		return -ENOENT;
>  
>  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8567dd11eaac..c8420a7995f1 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -211,37 +211,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
>  
> -static int wait_for_valid(struct pci_dev *pdev, int d)
> -{
> -	u32 val;
> -	int rc;
> -
> -	/*
> -	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
> -	 * and Size Low registers are valid. Must be set within 1 second of
> -	 * deassertion of reset to CXL device. Likely it is already set by the
> -	 * time this runs, but otherwise give a 1.5 second timeout in case of
> -	 * clock skew.
> -	 */
> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
> -	if (rc)
> -		return rc;
> -
> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
> -		return 0;
> -
> -	msleep(1500);
> -
> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
> -	if (rc)
> -		return rc;
> -
> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
> -		return 0;
> -
> -	return -ETIMEDOUT;
> -}
> -
>  static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -322,11 +291,14 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
>  	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
>  }
>  
> -int cxl_dvsec_rr_decode(struct device *dev, int d,
> +int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>  			struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>  	int hdm_count, rc, i, ranges = 0;
> +	int d = cxlds->cxl_dvsec;
> +	struct cxl_port *root;
>  	u16 cap, ctrl;
>  
>  	if (!d) {
> @@ -357,10 +329,19 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  	if (!hdm_count || hdm_count > 2)
>  		return -EINVAL;
>  
> -	rc = wait_for_valid(pdev, d);
> -	if (rc) {
> -		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
> -		return rc;
> +	root = to_cxl_port(port->dev.parent);
> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> +		root = to_cxl_port(root->dev.parent);
> +	if (!is_cxl_root(root)) {
> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
> +		info->dvsec_range[i] = (struct range) {
> +			.start = 0,
> +			.end = CXL_RESOURCE_NONE,
> +		};
>  	}
>  
>  	/*
> @@ -373,9 +354,15 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  		return 0;
>  
>  	for (i = 0; i < hdm_count; i++) {
> +		struct device *cxld_dev;
> +		struct range dvsec_range;
>  		u64 base, size;
>  		u32 temp;
>  
> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
> +		if (rc)
> +			return rc;
> +
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
>  		if (rc)
> @@ -389,13 +376,8 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  			return rc;
>  
>  		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
> -		if (!size) {
> -			info->dvsec_range[i] = (struct range) {
> -				.start = 0,
> -				.end = CXL_RESOURCE_NONE,
> -			};
> +		if (!size)
>  			continue;
> -		}
>  
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
> @@ -411,11 +393,22 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  
>  		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>  
> -		info->dvsec_range[i] = (struct range) {
> +		dvsec_range = (struct range) {
>  			.start = base,
> -			.end = base + size - 1
> +			.end = base + size - 1,
>  		};
>  
> +		cxld_dev = device_find_child(&root->dev, &dvsec_range,
> +					     dvsec_range_allowed);
> +		if (!cxld_dev) {
> +			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
> +			continue;
> +		}
> +		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
> +		put_device(cxld_dev);
> +
> +		info->dvsec_range[ranges] = dvsec_range;
> +
>  		ranges++;
>  	}
>  
> @@ -439,9 +432,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
>  	struct device *dev = cxlds->dev;
> -	struct cxl_port *root;
> -	int i, rc, allowed;
>  	u32 global_ctrl = 0;
> +	int rc;
>  
>  	if (hdm)
>  		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> @@ -455,30 +447,16 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	else if (!hdm)
>  		return -ENODEV;
>  
> -	root = to_cxl_port(port->dev.parent);
> -	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> -		root = to_cxl_port(root->dev.parent);
> -	if (!is_cxl_root(root)) {
> -		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> -		return -ENODEV;
> -	}
> -
> -	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> -		struct device *cxld_dev;
> +	if (!info->mem_enabled) {
> +		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> +		if (rc)
> +			return rc;
>  
> -		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
> -					     dvsec_range_allowed);
> -		if (!cxld_dev) {
> -			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
> -			continue;
> -		}
> -		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
> -		put_device(cxld_dev);
> -		allowed++;
> +		return devm_cxl_enable_mem(&port->dev, cxlds);
>  	}
>  
> -	if (!allowed && info->mem_enabled) {
> -		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
> +	if (!info->ranges && info->mem_enabled) {
> +		dev_err(dev, "No available DVSEC register ranges.\n");
>  		return -ENXIO;
>  	}
>  
> @@ -491,14 +469,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
>  	 * Decoder Capability Enable.
>  	 */
> -	if (info->mem_enabled)
> -		return 0;
> -
> -	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> -	if (rc)
> -		return rc;
> -
> -	return devm_cxl_enable_mem(&port->dev, cxlds);
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a6613a6f8923..6d9126d5ee56 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -790,6 +790,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
>  }
>  int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  
> +#define CXL_DVSEC_RANGE_MAX		2
>  /**
>   * struct cxl_endpoint_dvsec_info - Cached DVSEC info
>   * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
> @@ -801,7 +802,7 @@ struct cxl_endpoint_dvsec_info {
>  	bool mem_enabled;
>  	int ranges;
>  	struct cxl_port *port;
> -	struct range dvsec_range[2];
> +	struct range dvsec_range[CXL_DVSEC_RANGE_MAX];
>  };
>  
>  struct cxl_hdm;
> @@ -810,7 +811,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  				struct cxl_endpoint_dvsec_info *info);
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> -int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
> +int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>  			struct cxl_endpoint_dvsec_info *info);
>  
>  bool is_cxl_region(struct device *dev);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 97c21566677a..a8c241cb4ce2 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	struct cxl_port *root;
>  	int rc;
>  
> -	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
> +	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
>  	if (rc < 0)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 6f737941dc0e..79fdfaad49e8 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -228,7 +228,7 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
>  
> -int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
> +int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>  			       struct cxl_endpoint_dvsec_info *info)
>  {
>  	int rc = 0, index;
> @@ -237,7 +237,7 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>  	if (ops && ops->is_mock_dev(dev))
>  		rc = 0;
>  	else
> -		rc = cxl_dvsec_rr_decode(dev, dvsec, info);
> +		rc = cxl_dvsec_rr_decode(dev, port, info);
>  	put_cxl_mock_ops(index);
>  
>  	return rc;
> -- 
> 2.39.2
> 
> 
