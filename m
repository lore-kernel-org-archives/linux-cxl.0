Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C318FDDE
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229044; cv=none; b=Tzq1txZKiWULzYca80smWKaIMqHn9MOvXKCdztg9KzNp/BUxInumOvwKIo7lfZWN6nM+CiGmKWGPwotbgHxLYe6SD0y95FFSzDdJxjmlIPQHCymM6Tra0te2QByDFv4o5Zz6566SjDhpIpqvMwIxbpjrP34ki0zt2U8gTr+ALo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229044; c=relaxed/simple;
	bh=LiE3h+8F+Tpic7V3cKj9q7QAnk+hvlsWFP582UJCDt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPZo8Y8xNmtQa+3T3GtOagXaJIHSKTqSw8HPkoiVsaOJpph7w6MFLaJJAiS4o8LPq53GwaPjqyS2v/TEfShWVfBwuPQ8r3ZuQgPxf9nq0uQ2OkIPejiDBecbpTYKQ/xqK9D5auLFpbETCBIi8MarZp+dsaqBqmOyUMHq6sAiZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbdGXlRj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbdGXlRj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779229043; x=1810765043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LiE3h+8F+Tpic7V3cKj9q7QAnk+hvlsWFP582UJCDt4=;
  b=YbdGXlRjMy62ujb6sejCA8/QvqQjberuJ6uLcezl1QPpIEC+bEXPtDeN
   BfdtZSKnqkYo91qwdx6nfh39XGztYUDusbOfTIw2DB12AmBGxl2zB/pLJ
   DpSqhlqDoWB5DCMdNEMIt/bzIOGosqa9AMb38uK5ICuw7wHVD527L3b9x
   BSD31ONXx012sk7o6asoCQ0e3PAdHfkpW8+kJDRwI1FZ/D2NAEjwwP0L6
   A0lEBV3wOatKERT6w4SlGorLgY9IgxJFk157HPN/Ymmku7cyrfIgvUI28
   MddP09ZNttLSXuOlxXVzC0/Jr8OmOxT8+D5EF1XWB5syDmef80z6fsClp
   Q==;
X-CSE-ConnectionGUID: hPP4P5vxS8GjNHB7iAB76A==
X-CSE-MsgGUID: Z1VszjCoQQCiyTpW+bUOvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83976569"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83976569"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:17:22 -0700
X-CSE-ConnectionGUID: KQ1pMu0AREK7bfh/gWa6Yw==
X-CSE-MsgGUID: R3kfvf4KTruHdgoMmkTGAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="278030233"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.143]) ([10.125.109.143])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:17:15 -0700
Message-ID: <0b4861da-5f05-498a-83f9-58b7a13cd9f8@intel.com>
Date: Tue, 19 May 2026 15:17:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cxl/region: Resolve region deletion races
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, jic23@kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>
References: <20260519210158.1499795-1-djbw@kernel.org>
 <20260519210158.1499795-3-djbw@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519210158.1499795-3-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 2:01 PM, Dan Williams wrote:
> Sungwoo noticed that the sysfs trigger to delete a region may try to delete
> a region multiple times. It also has no exclusion relative to the kernel
> releasing the region via CXL root device teardown.
> 
> Instead of installing new cxl root devres actions per region, use the
> existing root decoder unregistration event to remove all remaining regions.
> An xarray of regions replaces a devres list of regions.
> 
> This handles 3 separate issues with the old approach:
> 
> 1/ sysfs users racing to delete the same region: no longer possible now
>    that the regions_lock is held over the lookup and deletion.
> 
> 2/ multiple actions triggering deletion of the same region: solved by
>    erasing regions while holding @regions_lock, and only proceeding on
>    successful erasure.
> 
> 3/ userspace racing devres_release_all() to trigger the devres not found
>    warning: solved by sysfs unregistration not requiring a release action
> 
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Reported-by: Sungwoo Kim <iam@sung-woo.kim>
> Closes: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
> Signed-off-by: Dan Williams <djbw@kernel.org>

LGTM but with a nit below.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/core.h   |  2 ++
>  drivers/cxl/cxl.h         |  4 +++
>  drivers/cxl/core/port.c   |  5 ++++
>  drivers/cxl/core/region.c | 60 +++++++++++++++++++++------------------
>  4 files changed, 44 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 82ca3a476708..07555ae63859 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -52,6 +52,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
>  int devm_cxl_add_dax_region(struct cxl_region *cxlr);
>  int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
> +void kill_regions(struct cxl_root_decoder *cxlrd);
>  
>  #else
>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
> @@ -81,6 +82,7 @@ static inline int cxl_region_init(void)
>  static inline void cxl_region_exit(void)
>  {
>  }
> +static inline void kill_regions(struct cxl_root_decoder *cxlrd) { };
>  #define CXL_REGION_ATTR(x) NULL
>  #define CXL_REGION_TYPE(x) NULL
>  #define SET_CXL_REGION_ATTR(x)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3900a0778571..f43abd1903ce 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -360,6 +360,8 @@ struct cxl_rd_ops {
>   * @region_id: region id for next region provisioning event
>   * @platform_data: platform specific configuration data
>   * @regions_lock: sync region discovery, construction, and deletion
> + * @regions: regions to remove at root decoder destruct time
> + * @dead: root decoder dead to region creation
>   * @qos_class: QoS performance class cookie
>   * @ops: CXL root decoder operations
>   * @cxlsd: base cxl switch decoder
> @@ -370,6 +372,8 @@ struct cxl_root_decoder {
>  	atomic_t region_id;
>  	void *platform_data;
>  	struct mutex regions_lock;
> +	struct xarray regions;
> +	bool dead;
>  	int qos_class;
>  	struct cxl_rd_ops ops;
>  	struct cxl_switch_decoder cxlsd;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6e7a70d51cfe..1215ee4f4035 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -458,6 +458,8 @@ static void cxl_root_decoder_release(struct device *dev)
>  
>  	if (atomic_read(&cxlrd->region_id) >= 0)
>  		memregion_free(atomic_read(&cxlrd->region_id));
> +	mutex_destroy(&cxlrd->regions_lock);
> +	xa_destroy(&cxlrd->regions);
>  	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
>  	kfree(cxlrd);
>  }
> @@ -2017,6 +2019,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  	}
>  
>  	mutex_init(&cxlrd->regions_lock);
> +	xa_init(&cxlrd->regions);
>  
>  	cxld = &cxlsd->cxld;
>  	cxld->dev.type = &cxl_decoder_root_type;
> @@ -2192,6 +2195,8 @@ static void cxld_unregister(void *dev)
>  	if (is_endpoint_decoder(dev))
>  		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
>  				   DETACH_INVALIDATE);
> +	if (is_root_decoder(dev))
> +		kill_regions(to_cxl_root_decoder(dev));
>  
>  	device_unregister(dev);
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b5601e89e302..faf9785c0509 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2537,12 +2537,13 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>  	return container_of(dev, struct cxl_region, dev);
>  }
>  
> -static void unregister_region(void *_cxlr)
> +static void unregister_region(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr = _cxlr;
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_region_params *p = &cxlr->params;
>  	int i;
>  
> +	xa_erase(&cxlrd->regions, cxlr->id);
>  	device_del(&cxlr->dev);
>  
>  	/*
> @@ -2673,6 +2674,19 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>  	return NOTIFY_STOP;
>  }
>  
> +/* unwind all remaining regions */
> +void kill_regions(struct cxl_root_decoder *cxlrd)
> +{
> +	unsigned long index;
> +	struct cxl_region *cxlr;
> +
> +	guard(mutex)(&cxlrd->regions_lock);
> +	/* no more region creation */
> +	cxlrd->dead = true;
> +	xa_for_each(&cxlrd->regions, index, cxlr)
> +		unregister_region(cxlr);
> +}
> +
>  /**
>   * devm_cxl_add_region - Adds a region to a decoder
>   * @cxlrd: root decoder
> @@ -2711,14 +2725,15 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
> -	if (rc)
> +	rc = xa_insert(&cxlrd->regions, cxlr->id, cxlr, GFP_KERNEL);
> +	if (rc) {
> +		unregister_region(cxlr);
>  		return ERR_PTR(rc);
> +	}
>  
>  	dev_dbg(port->uport_dev, "%s: created %s\n",
>  		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
>  	return cxlr;
> -
>  err:
>  	put_device(dev);
>  	return ERR_PTR(rc);
> @@ -2747,6 +2762,9 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  {
>  	int rc;
>  
> +	if (cxlrd->dead)
> +		return ERR_PTR(-ENXIO);
> +
>  	switch (mode) {
>  	case CXL_PARTMODE_RAM:
>  	case CXL_PARTMODE_PMEM:
> @@ -2822,38 +2840,27 @@ static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>  }
>  DEVICE_ATTR_RO(region);
>  
> -static struct cxl_region *
> -cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
> -{
> -	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct device *region_dev;
> -
> -	region_dev = device_find_child_by_name(&cxld->dev, name);
> -	if (!region_dev)
> -		return ERR_PTR(-ENODEV);
> -
> -	return to_cxl_region(region_dev);
> -}
> -
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> -	struct cxl_port *port = to_cxl_port(dev->parent);
>  	struct cxl_region *cxlr;
> -	int rc;
> +	int rc, id;
>  
>  	ACQUIRE(mutex_intr, regions_lock)(&cxlrd->regions_lock);
>  	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
>  		return rc;
>  
> -	cxlr = cxl_find_region_by_name(cxlrd, buf);
> -	if (IS_ERR(cxlr))
> -		return PTR_ERR(cxlr);
> +	rc = sscanf(buf, "region%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;

Maybe add a check for (id >= 0) just to sanitize user input?

DJ

>  
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> -	put_device(&cxlr->dev);
> +	cxlr = xa_load(&cxlrd->regions, id);
> +	if (!cxlr || !sysfs_streq(buf, dev_name(&cxlr->dev)))
> +		return -ENODEV;
> +
> +	unregister_region(cxlr);
>  
>  	return len;
>  }
> @@ -3718,7 +3725,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  {
>  	struct cxl_endpoint_decoder *cxled = ctx->cxled;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	int rc, part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
> @@ -3739,7 +3745,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	rc = __construct_region(cxlr, ctx);
>  	if (rc) {
> -		devm_release_action(port->uport_dev, unregister_region, cxlr);
> +		unregister_region(cxlr);
>  		return ERR_PTR(rc);
>  	}
>  

