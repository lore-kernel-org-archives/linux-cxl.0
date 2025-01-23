Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513A1C5D4F
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667753; cv=none; b=KT6A5chi9crHWeFq6LE8C0E4ABGdTleFSaN5T4RWZugfUzg8+7DRCHNR6ZKfOgyj0wYvnGbqH2isv20l0EYtf3iqMPh62/fxdbGZ1EreCi/OERCjenMLOb2f1xsZJqw31/EvwqTqgUHgiwdO4m8e2uYU8ZSgXXpEH3cjUTPnzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667753; c=relaxed/simple;
	bh=urD4GoTJ4FZgYrSx1G0Wa3tZ+TPretsoolj9BqK//8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnnYsVpre/HDJQzFn2ElRG5NpjisTatY7hqOxgPZy3+zl7QGBeDl+evjRRWCbiwjOREgltpXpVnqSnzx6f6qStnlYwmR9JIHtGV7W/m/SdgwYb4y8CqTZ+ooj4NpRivWWUfK5rzL55UuG49GBQII2/0PT4dQyXw44sPafHiLqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7NkszQF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7NkszQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737667751; x=1769203751;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=urD4GoTJ4FZgYrSx1G0Wa3tZ+TPretsoolj9BqK//8M=;
  b=R7NkszQF6jl3f3KlVj4C6ixP2EduZekek35634smbkYZwi92uEwIpy85
   hYESB/pLHYCESmaybmNVim87b9u59WeF8EElA8PPfodR6YX6CD1rdpgUt
   MyxRAGc9IISdsmIhkpog8M4fr3C4T7Qqe/FlWIvBvfc/DuRsMfw1qVhXe
   G/y/4eWAq1HkL4NRYDx8sUnw8tMb6meN9OCyitjUNXH2VudH4IetQfZJi
   jjQNRpSYv6z4QfP8qz6KGCO19kv69pgzum0pRINbKKkPrc5ML4Uhj2z0C
   mMRbcPFZ7lSfr6waxo1Mbu4U2IaxY3F1NYS/5TG9l/kXIZMtBQgKewg3c
   Q==;
X-CSE-ConnectionGUID: t1mWbNHPQQCLiPJBBsmvdA==
X-CSE-MsgGUID: CfFaqYkVTJWO5tX8PwaLFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41025365"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="41025365"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:29:10 -0800
X-CSE-ConnectionGUID: O2QhUaiKTbmlKLIAul8npQ==
X-CSE-MsgGUID: Zy78jqz9SEiDwaUj1AOVsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="112582035"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.229]) ([10.125.110.229])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:29:09 -0800
Message-ID: <c8f6f43a-151c-429c-93de-1b72abf10e29@intel.com>
Date: Thu, 23 Jan 2025 14:29:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Alejandro Lucero <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/25 1:59 AM, Dan Williams wrote:
> Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> tracked in the partition, and no code paths have dependencies on the
> mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> can be cleaned up, specifically this ambiguity on whether the operation
> mode implied anything about the partition order.
> 
> Endpoint decoders simply reference their assigned partition where the
> operational mode can be retrieved as partition mode.
> 
> With this in place PMEM can now be partition0 which happens today when
> the RAM capacity size is zero. Dynamic RAM can appear above PMEM when
> DCD arrives, etc. Code sequences that hard coded the "PMEM after RAM"
> assumption can now just iterate partitions and consult the partition
> mode after the fact.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/cdat.c   |   21 ++-----
>  drivers/cxl/core/core.h   |    4 +
>  drivers/cxl/core/hdm.c    |   64 +++++++----------------
>  drivers/cxl/core/memdev.c |   15 +----
>  drivers/cxl/core/port.c   |   20 +++++--
>  drivers/cxl/core/region.c |  128 +++++++++++++++++++++++++--------------------
>  drivers/cxl/cxl.h         |   38 ++++---------
>  drivers/cxl/cxlmem.h      |   20 -------
>  8 files changed, 127 insertions(+), 183 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5400a421ad30..ca7fb2b182ed 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -571,29 +571,18 @@ static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
>  		.end = dpa_res->end,
>  	};
>  
> -	if (!perf)
> -		return false;
> -
>  	return range_contains(&perf->dpa_range, &dpa);
>  }
>  
> -static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxled,
> -					       enum cxl_decoder_mode mode)
> +static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_dpa_perf *perf;
>  
> -	switch (mode) {
> -	case CXL_DECODER_RAM:
> -		perf = to_ram_perf(cxlds);
> -		break;
> -	case CXL_DECODER_PMEM:
> -		perf = to_pmem_perf(cxlds);
> -		break;
> -	default:
> +	if (cxled->part < 0)
>  		return ERR_PTR(-EINVAL);
> -	}
> +	perf = &cxlds->part[cxled->part].perf;
>  
>  	if (!dpa_perf_contains(perf, cxled->dpa_res))
>  		return ERR_PTR(-EINVAL);
> @@ -654,7 +643,7 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>  	if (cxlds->rcd)
>  		return -ENODEV;
>  
> -	perf = cxled_get_dpa_perf(cxled, cxlr->mode);
> +	perf = cxled_get_dpa_perf(cxled);
>  	if (IS_ERR(perf))
>  		return PTR_ERR(perf);
>  
> @@ -1060,7 +1049,7 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  
>  	lockdep_assert_held(&cxl_dpa_rwsem);
>  
> -	perf = cxled_get_dpa_perf(cxled, cxlr->mode);
> +	perf = cxled_get_dpa_perf(cxled);
>  	if (IS_ERR(perf))
>  		return;
>  
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 800466f96a68..22dac79c5192 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -72,8 +72,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  				   resource_size_t length);
>  
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
> -int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> -		     enum cxl_decoder_mode mode);
> +int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
> +		     enum cxl_partition_mode mode);
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 591aeb26c9e1..bb478e7b12f6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -374,7 +374,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &port->dev;
> -	enum cxl_decoder_mode mode;
>  	struct resource *res;
>  	int rc;
>  
> @@ -421,18 +420,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> -	mode = CXL_DECODER_NONE;
> -	for (int i = 0; cxlds->nr_partitions; i++)
> -		if (resource_contains(&cxlds->part[i].res, res)) {
> -			mode = cxl_part_mode(cxlds->part[i].mode);
> -			break;
> -		}
> -
> -	if (mode == CXL_DECODER_NONE)
> -		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> -			 port->id, cxled->cxld.id, res);
> -	cxled->mode = mode;
> -
>  	port->hdm_end++;
>  	get_device(&cxled->cxld.dev);
>  	return 0;
> @@ -585,40 +572,36 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	return rc;
>  }
>  
> -int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> -		     enum cxl_decoder_mode mode)
> +int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
> +		     enum cxl_partition_mode mode)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> -
> -	switch (mode) {
> -	case CXL_DECODER_RAM:
> -	case CXL_DECODER_PMEM:
> -		break;
> -	default:
> -		dev_dbg(dev, "unsupported mode: %d\n", mode);
> -		return -EINVAL;
> -	}
> +	int part;
>  
>  	guard(rwsem_write)(&cxl_dpa_rwsem);
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
>  		return -EBUSY;
>  
> -	/*
> -	 * Only allow modes that are supported by the current partition
> -	 * configuration
> -	 */
> -	if (mode == CXL_DECODER_PMEM && !cxl_pmem_size(cxlds)) {
> -		dev_dbg(dev, "no available pmem capacity\n");
> -		return -ENXIO;
> +	part = -1;
> +	for (int i = 0; i < cxlds->nr_partitions; i++)
> +		if (cxlds->part[i].mode == mode) {
> +			part = i;
> +			break;
> +		}
> +
> +	if (part < 0) {
> +		dev_dbg(dev, "unsupported mode: %d\n", mode);
> +		return -EINVAL;
>  	}
> -	if (mode == CXL_DECODER_RAM && !cxl_ram_size(cxlds)) {
> -		dev_dbg(dev, "no available ram capacity\n");
> +
> +	if (!resource_size(&cxlds->part[part].res)) {
> +		dev_dbg(dev, "no available capacity for mode: %d\n", mode);
>  		return -ENXIO;
>  	}
>  
> -	cxled->mode = mode;
> +	cxled->part = part;
>  	return 0;
>  }
>  
> @@ -647,16 +630,9 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  		goto out;
>  	}
>  
> -	part = -1;
> -	for (int i = 0; i < cxlds->nr_partitions; i++) {
> -		if (cxled->mode == cxl_part_mode(cxlds->part[i].mode)) {
> -			part = i;
> -			break;
> -		}
> -	}
> -
> +	part = cxled->part;
>  	if (part < 0) {
> -		dev_dbg(dev, "partition %d not found\n", part);
> +		dev_dbg(dev, "partition not set\n");
>  		rc = -EBUSY;
>  		goto out;
>  	}
> @@ -697,7 +673,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  
>  	if (size > avail) {
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxl_decoder_mode_name(cxled->mode), &avail);
> +			res->name, &avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index be0eb57086e1..615cbd861f66 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -198,17 +198,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  	int rc = 0;
>  
>  	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> -	if (cxl_pmem_size(cxlds)) {
> -		const struct resource *res = to_pmem_res(cxlds);
> -
> -		offset = res->start;
> -		length = resource_size(res);
> -		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc)
> -			return rc;
> -	}
> -	if (cxl_ram_size(cxlds)) {
> -		const struct resource *res = to_ram_res(cxlds);
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		const struct resource *res = &cxlds->part[i].res;
>  
>  		offset = res->start;
>  		length = resource_size(res);
> @@ -217,7 +208,7 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  		 * Invalid Physical Address is not an error for
>  		 * volatile addresses. Device support is optional.
>  		 */
> -		if (rc == -EFAULT)
> +		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
>  			rc = 0;
>  	}
>  	return rc;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 78a5c2c25982..f5f2701c8771 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -194,25 +194,35 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
>  	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	/* without @cxl_dpa_rwsem, make sure @part is not reloaded */
> +	int part = READ_ONCE(cxled->part);
> +	const char *desc;
> +
> +	if (part < 0)
> +		desc = "none";
> +	else
> +		desc = cxlds->part[part].res.name;
>  
> -	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxled->mode));
> +	return sysfs_emit(buf, "%s\n", desc);
>  }
>  
>  static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
>  	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> -	enum cxl_decoder_mode mode;
> +	enum cxl_partition_mode mode;
>  	ssize_t rc;
>  
>  	if (sysfs_streq(buf, "pmem"))
> -		mode = CXL_DECODER_PMEM;
> +		mode = CXL_PARTMODE_PMEM;
>  	else if (sysfs_streq(buf, "ram"))
> -		mode = CXL_DECODER_RAM;
> +		mode = CXL_PARTMODE_RAM;
>  	else
>  		return -EINVAL;
>  
> -	rc = cxl_dpa_set_mode(cxled, mode);
> +	rc = cxl_dpa_set_part(cxled, mode);
>  	if (rc)
>  		return rc;
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9f0f6fdbc841..83b985d2ba76 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -144,7 +144,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>  	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	if (cxlr->mode != CXL_DECODER_PMEM)
> +	if (cxlr->mode != CXL_PARTMODE_PMEM)
>  		rc = sysfs_emit(buf, "\n");
>  	else
>  		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
> @@ -441,7 +441,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>  	 * Support tooling that expects to find a 'uuid' attribute for all
>  	 * regions regardless of mode.
>  	 */
> -	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
> +	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
>  		return 0444;
>  	return a->mode;
>  }
> @@ -603,8 +603,16 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> +	const char *desc;
>  
> -	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
> +	if (cxlr->mode == CXL_PARTMODE_RAM)
> +		desc = "ram";
> +	else if (cxlr->mode == CXL_PARTMODE_PMEM)
> +		desc = "pmem";
> +	else
> +		desc = "";
> +
> +	return sysfs_emit(buf, "%s\n", desc);
>  }
>  static DEVICE_ATTR_RO(mode);
>  
> @@ -630,7 +638,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  
>  	/* ways, granularity and uuid (if PMEM) need to be set before HPA */
>  	if (!p->interleave_ways || !p->interleave_granularity ||
> -	    (cxlr->mode == CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
> +	    (cxlr->mode == CXL_PARTMODE_PMEM && uuid_is_null(&p->uuid)))
>  		return -ENXIO;
>  
>  	div64_u64_rem(size, (u64)SZ_256M * p->interleave_ways, &remainder);
> @@ -1875,6 +1883,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_port *ep_port, *root_port;
>  	struct cxl_dport *dport;
> @@ -1889,17 +1898,17 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return rc;
>  	}
>  
> -	if (cxled->mode != cxlr->mode) {
> -		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> -			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> -		return -EINVAL;
> -	}
> -
> -	if (cxled->mode == CXL_DECODER_DEAD) {
> +	if (cxled->part < 0) {
>  		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
>  		return -ENODEV;
>  	}
>  
> +	if (cxlds->part[cxled->part].mode != cxlr->mode) {
> +		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch\n",
> +			dev_name(&cxled->cxld.dev), cxlr->mode);
> +		return -EINVAL;
> +	}
> +
>  	/* all full of members, or interleave config not established? */
>  	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_dbg(&cxlr->dev, "region already active\n");
> @@ -2102,7 +2111,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	down_write(&cxl_region_rwsem);
> -	cxled->mode = CXL_DECODER_DEAD;
> +	cxled->part = -1;
>  	cxl_region_detach(cxled);
>  	up_write(&cxl_region_rwsem);
>  }
> @@ -2458,7 +2467,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>   */
>  static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  					      int id,
> -					      enum cxl_decoder_mode mode,
> +					      enum cxl_partition_mode mode,
>  					      enum cxl_decoder_type type)
>  {
>  	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> @@ -2512,13 +2521,13 @@ static ssize_t create_ram_region_show(struct device *dev,
>  }
>  
>  static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  enum cxl_decoder_mode mode, int id)
> +					  enum cxl_partition_mode mode, int id)
>  {
>  	int rc;
>  
>  	switch (mode) {
> -	case CXL_DECODER_RAM:
> -	case CXL_DECODER_PMEM:
> +	case CXL_PARTMODE_RAM:
> +	case CXL_PARTMODE_PMEM:
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> @@ -2538,7 +2547,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  }
>  
>  static ssize_t create_region_store(struct device *dev, const char *buf,
> -				   size_t len, enum cxl_decoder_mode mode)
> +				   size_t len, enum cxl_partition_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>  	struct cxl_region *cxlr;
> @@ -2559,7 +2568,7 @@ static ssize_t create_pmem_region_store(struct device *dev,
>  					struct device_attribute *attr,
>  					const char *buf, size_t len)
>  {
> -	return create_region_store(dev, buf, len, CXL_DECODER_PMEM);
> +	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM);
>  }
>  DEVICE_ATTR_RW(create_pmem_region);
>  
> @@ -2567,7 +2576,7 @@ static ssize_t create_ram_region_store(struct device *dev,
>  				       struct device_attribute *attr,
>  				       const char *buf, size_t len)
>  {
> -	return create_region_store(dev, buf, len, CXL_DECODER_RAM);
> +	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM);
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>  
> @@ -2665,7 +2674,7 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
>  
>  struct cxl_poison_context {
>  	struct cxl_port *port;
> -	enum cxl_decoder_mode mode;
> +	int part;
>  	u64 offset;
>  };
>  
> @@ -2673,49 +2682,45 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  				   struct cxl_poison_context *ctx)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	const struct resource *res;
> +	struct resource *p, *last;
>  	u64 offset, length;
>  	int rc = 0;
>  
> +	if (ctx->part < 0)
> +		return 0;
> +
>  	/*
> -	 * Collect poison for the remaining unmapped resources
> -	 * after poison is collected by committed endpoints.
> -	 *
> -	 * Knowing that PMEM must always follow RAM, get poison
> -	 * for unmapped resources based on the last decoder's mode:
> -	 *	ram: scan remains of ram range, then any pmem range
> -	 *	pmem: scan remains of pmem range
> +	 * Collect poison for the remaining unmapped resources after
> +	 * poison is collected by committed endpoints decoders.
>  	 */
> -
> -	if (ctx->mode == CXL_DECODER_RAM) {
> -		offset = ctx->offset;
> -		length = cxl_ram_size(cxlds) - offset;
> +	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
> +		res = &cxlds->part[i].res;
> +		for (p = res->child, last = NULL; p; p = p->sibling)
> +			last = p;
> +		if (last)
> +			offset = last->end + 1;
> +		else
> +			offset = res->start;
> +		length = res->end - offset + 1;
> +		if (!length)
> +			break;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc == -EFAULT)
> -			rc = 0;
> +		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
> +			continue;
>  		if (rc)
> -			return rc;
> -	}
> -	if (ctx->mode == CXL_DECODER_PMEM) {
> -		offset = ctx->offset;
> -		length = resource_size(&cxlds->dpa_res) - offset;
> -		if (!length)
> -			return 0;
> -	} else if (cxl_pmem_size(cxlds)) {
> -		const struct resource *res = to_pmem_res(cxlds);
> -
> -		offset = res->start;
> -		length = resource_size(res);
> -	} else {
> -		return 0;
> +			break;
>  	}
>  
> -	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +	return rc;
>  }
>  
>  static int poison_by_decoder(struct device *dev, void *arg)
>  {
>  	struct cxl_poison_context *ctx = arg;
>  	struct cxl_endpoint_decoder *cxled;
> +	enum cxl_partition_mode mode;
> +	struct cxl_dev_state *cxlds;
>  	struct cxl_memdev *cxlmd;
>  	u64 offset, length;
>  	int rc = 0;
> @@ -2728,11 +2733,17 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  		return rc;
>  
>  	cxlmd = cxled_to_memdev(cxled);
> +	cxlds = cxlmd->cxlds;
> +	if (cxled->part < 0)
> +		mode = CXL_PARTMODE_NONE;
> +	else
> +		mode = cxlds->part[cxled->part].mode;
> +
>  	if (cxled->skip) {
>  		offset = cxled->dpa_res->start - cxled->skip;
>  		length = cxled->skip;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
>  			rc = 0;
>  		if (rc)
>  			return rc;
> @@ -2741,7 +2752,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	offset = cxled->dpa_res->start;
>  	length = cxled->dpa_res->end - offset + 1;
>  	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> -	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
>  		rc = 0;
>  	if (rc)
>  		return rc;
> @@ -2749,7 +2760,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	/* Iterate until commit_end is reached */
>  	if (cxled->cxld.id == ctx->port->commit_end) {
>  		ctx->offset = cxled->dpa_res->end + 1;
> -		ctx->mode = cxled->mode;
> +		ctx->part = cxled->part;
>  		return 1;
>  	}
>  
> @@ -2762,7 +2773,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  	int rc = 0;
>  
>  	ctx = (struct cxl_poison_context) {
> -		.port = port
> +		.port = port,
> +		.part = -1,
>  	};
>  
>  	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> @@ -3206,14 +3218,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct range *hpa = &cxled->cxld.hpa_range;
> +	int rc, part = READ_ONCE(cxled->part);
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	struct resource *res;
> -	int rc;
> +
> +	if (part < 0)
> +		return ERR_PTR(-EBUSY);
>  
>  	do {
> -		cxlr = __create_region(cxlrd, cxled->mode,
> +		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id));
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
> @@ -3416,9 +3432,9 @@ static int cxl_region_probe(struct device *dev)
>  		return rc;
>  
>  	switch (cxlr->mode) {
> -	case CXL_DECODER_PMEM:
> +	case CXL_PARTMODE_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_DECODER_RAM:
> +	case CXL_PARTMODE_RAM:
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4d0550367042..cb6f0b761b24 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -371,30 +371,6 @@ struct cxl_decoder {
>  	void (*reset)(struct cxl_decoder *cxld);
>  };
>  
> -/*
> - * CXL_DECODER_DEAD prevents endpoints from being reattached to regions
> - * while cxld_unregister() is running
> - */
> -enum cxl_decoder_mode {
> -	CXL_DECODER_NONE,
> -	CXL_DECODER_RAM,
> -	CXL_DECODER_PMEM,
> -	CXL_DECODER_DEAD,
> -};
> -
> -static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
> -{
> -	static const char * const names[] = {
> -		[CXL_DECODER_NONE] = "none",
> -		[CXL_DECODER_RAM] = "ram",
> -		[CXL_DECODER_PMEM] = "pmem",
> -	};
> -
> -	if (mode >= CXL_DECODER_NONE && mode < CXL_DECODER_DEAD)
> -		return names[mode];
> -	return "mixed";
> -}
> -
>  /*
>   * Track whether this decoder is reserved for region autodiscovery, or
>   * free for userspace provisioning.
> @@ -409,16 +385,16 @@ enum cxl_decoder_state {
>   * @cxld: base cxl_decoder_object
>   * @dpa_res: actively claimed DPA span of this decoder
>   * @skip: offset into @dpa_res where @cxld.hpa_range maps
> - * @mode: which memory type / access-mode-partition this decoder targets
>   * @state: autodiscovery state
> + * @part: partition index this decoder maps
>   * @pos: interleave position in @cxld.region
>   */
>  struct cxl_endpoint_decoder {
>  	struct cxl_decoder cxld;
>  	struct resource *dpa_res;
>  	resource_size_t skip;
> -	enum cxl_decoder_mode mode;
>  	enum cxl_decoder_state state;
> +	int part;
>  	int pos;
>  };
>  
> @@ -503,6 +479,12 @@ struct cxl_region_params {
>  	int nr_targets;
>  };
>  
> +enum cxl_partition_mode {
> +	CXL_PARTMODE_NONE,
> +	CXL_PARTMODE_RAM,
> +	CXL_PARTMODE_PMEM,
> +};
> +
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> @@ -522,7 +504,7 @@ struct cxl_region_params {
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
> - * @mode: Endpoint decoder allocation / access mode
> + * @mode: Operational mode of the mapped capacity
>   * @type: Endpoint decoder target type
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>   * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> @@ -535,7 +517,7 @@ struct cxl_region_params {
>  struct cxl_region {
>  	struct device dev;
>  	int id;
> -	enum cxl_decoder_mode mode;
> +	enum cxl_partition_mode mode;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index bad99456e901..f218d43dec9f 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,12 +97,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
>  
> -enum cxl_partition_mode {
> -	CXL_PARTMODE_NONE,
> -	CXL_PARTMODE_RAM,
> -	CXL_PARTMODE_PMEM,
> -};
> -
>  #define CXL_NR_PARTITIONS_MAX 2
>  
>  struct cxl_dpa_info {
> @@ -530,20 +524,6 @@ static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  	return resource_size(res);
>  }
>  
> -/*
> - * Translate the operational mode of memory capacity with the
> - * operational mode of a decoder
> - * TODO: kill 'enum cxl_decoder_mode' to obviate this helper
> - */
> -static inline enum cxl_decoder_mode cxl_part_mode(enum cxl_partition_mode mode)
> -{
> -	if (mode == CXL_PARTMODE_RAM)
> -		return CXL_DECODER_RAM;
> -	if (mode == CXL_PARTMODE_PMEM)
> -		return CXL_DECODER_PMEM;
> -	return CXL_DECODER_NONE;
> -}
> -
>  static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>  {
>  	return dev_get_drvdata(cxl_mbox->host);
> 

