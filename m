Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F31448E4
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651456; cv=none; b=hC19hAgA4yTETSL/GeqP0dXPUqjuNtfJVSQ9dTWupKxMi++O2BuTi2LFRaNZ+8zNgc/uq7FRc7SzeQ/YSKzmwzxVBp6jr+imyRQjeMBnT5gs6L8ocsjA/K228uFEpj1KeCK7XhwoKuL9cAG3xTRC6z2f+7CtORskBg3nYz/AmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651456; c=relaxed/simple;
	bh=dgE38lxs6asatdOLiA5spAACyW11arpM/ZND/sD1cqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BimWuxSoe/6wTIc2+5Y+Tb0E6/LMugHj4G+ln6+nVlsLK0oZCKzTf8tFuA6MJhx4qHQzbucPeYacF/VCf/468rN5AQlKadRXjrBnOeIa0L6sE6BVuszVrCByg3GYwegmqdrMFbvGQ/aFKUVy/69h4bu0AwXbz0FNC8pW7iq3/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+Q04+Xr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+Q04+Xr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737651454; x=1769187454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dgE38lxs6asatdOLiA5spAACyW11arpM/ZND/sD1cqI=;
  b=X+Q04+Xrsv7sFJ9rWFAJwSpc09lKQUwuwaDZ8GMDN62rEIrI29bUTzoZ
   RV6XcNDmthu3gJsfVBqz9jKmROw1NG/3kH85FxabInxe79aCiDzouG80n
   8ZsCiw0yWHYbabQQxsI5Wa5WAvge9lx1ggplfcGZsttKIEVvnTv5+Me0V
   UznB4K7PTFRwE5enWYeVEWGpXonmFDutFNf3NTyMgPhkvgn+7WcYlEsEE
   vk6V4Ujq6Kme1t9pMCHLYO/iWQGYFPnbV2OoX0rZLFbuzs7rnG90BCuAW
   tzVVYdl1rag7aXoX0uQcRyRGfYrdGwlT7DaqvTp9Rf4fb5esS7HcnZVW7
   A==;
X-CSE-ConnectionGUID: ENBxHNVKQEuQzjHv6izWLA==
X-CSE-MsgGUID: nTEo7aqGSlKUacDOrlGlYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38051270"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="38051270"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 08:57:33 -0800
X-CSE-ConnectionGUID: blCF6+N7RA+jmfTD8BPbgA==
X-CSE-MsgGUID: QDzZtPcVStqIKICMWLnIKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="108124835"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.229]) ([10.125.110.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 08:57:31 -0800
Message-ID: <528d920d-bc37-490d-8f9a-48592abfc215@intel.com>
Date: Thu, 23 Jan 2025 09:57:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Alejandro Lucero <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/25 1:59 AM, Dan Williams wrote:
> The pending efforts to add CXL Accelerator (type-2) device [1], and
> Dynamic Capacity (DCD) support [2], tripped on the
> no-longer-fit-for-purpose design in the CXL subsystem for tracking
> device-physical-address (DPA) metadata. Trip hazards include:
> 
> - CXL Memory Devices need to consider a PMEM partition, but Accelerator
>   devices with CXL.mem likely do not in the common case.
> 
> - CXL Memory Devices enumerate DPA through Memory Device mailbox
>   commands like Partition Info, Accelerators devices do not.
> 
> - CXL Memory Devices that support DCD support more than 2 partitions.
>   Some of the driver algorithms are awkward to expand to > 2 partition
>   cases.
> 
> - DPA performance data is a general capability that can be shared with
>   accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
>   suitable.
> 
> - Hardcoded assumptions around the PMEM partition always being index-1
>   if RAM is zero-sized or PMEM is zero sized.
> 
> - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
>   memory property, it should be phased in favor of a partition id and
>   the memory property comes from the partition info.
> 
> Towards cleaning up those issues and allowing a smoother landing for the
> aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> way for Memory Devices and Accelerators to initialize the DPA information
> in 'struct cxl_dev_state'.
> 
> For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> get the new data structure initialized, and cleanup some qos_class init.
> Follow on patches will go further to use the new data structure to
> cleanup algorithms that are better suited to loop over all possible
> partitions.
> 
> cxl_dpa_setup() follows the locking expectations of mutating the device
> DPA map, and is suitable for Accelerator drivers to use. Accelerators
> likely only have one hardcoded 'ram' partition to convey to the
> cxl_core.
> 
> Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/cdat.c      |   15 ++-----
>  drivers/cxl/core/hdm.c       |   75 +++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/mbox.c      |   68 ++++++++++--------------------
>  drivers/cxl/core/memdev.c    |    2 -
>  drivers/cxl/cxlmem.h         |   94 +++++++++++++++++++++++++++++-------------
>  drivers/cxl/pci.c            |    7 +++
>  tools/testing/cxl/test/cxl.c |   15 ++-----
>  tools/testing/cxl/test/mem.c |    7 +++
>  8 files changed, 183 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index b177a488e29b..5400a421ad30 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -261,25 +261,18 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  	struct device *dev = cxlds->dev;
>  	struct dsmas_entry *dent;
>  	unsigned long index;
> -	const struct resource *partition[] = {
> -		to_ram_res(cxlds),
> -		to_pmem_res(cxlds),
> -	};
> -	struct cxl_dpa_perf *perf[] = {
> -		to_ram_perf(cxlds),
> -		to_pmem_perf(cxlds),
> -	};
>  
>  	xa_for_each(dsmas_xa, index, dent) {
> -		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> -			const struct resource *res = partition[i];
> +		for (int i = 0; i < cxlds->nr_partitions; i++) {
> +			struct resource *res = &cxlds->part[i].res;
>  			struct range range = {
>  				.start = res->start,
>  				.end = res->end,
>  			};
>  
>  			if (range_contains(&range, &dent->dpa_range))
> -				update_perf_entry(dev, dent, perf[i]);
> +				update_perf_entry(dev, dent,
> +						  &cxlds->part[i].perf);
>  			else
>  				dev_dbg(dev,
>  					"no partition for dsmas dpa: %pra\n",
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7a85522294ad..3f8a54ca4624 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,9 +327,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> -	if (resource_contains(to_pmem_res(cxlds), res))
> +	if (to_pmem_res(cxlds) && resource_contains(to_pmem_res(cxlds), res))
>  		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(to_ram_res(cxlds), res))
> +	else if (to_ram_res(cxlds) && resource_contains(to_ram_res(cxlds), res))
>  		cxled->mode = CXL_DECODER_RAM;
>  	else {
>  		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> @@ -342,6 +342,77 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int add_dpa_res(struct device *dev, struct resource *parent,
> +		       struct resource *res, resource_size_t start,
> +		       resource_size_t size, const char *type)
> +{
> +	int rc;
> +
> +	*res = (struct resource) {
> +		.name = type,
> +		.start = start,
> +		.end =  start + size - 1,
> +		.flags = IORESOURCE_MEM,
> +	};
> +	if (resource_size(res) == 0) {
> +		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
> +		return 0;
> +	}
> +	rc = request_resource(parent, res);
> +	if (rc) {
> +		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
> +			res, rc);
> +		return rc;
> +	}
> +
> +	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
> +
> +	return 0;
> +}
> +
> +/* if this fails the caller must destroy @cxlds, there is no recovery */
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> +{
> +	struct device *dev = cxlds->dev;
> +
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +
> +	if (cxlds->nr_partitions)
> +		return -EBUSY;
> +
> +	if (!info->size || !info->nr_partitions) {
> +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> +		cxlds->nr_partitions = 0;
> +		return 0;
> +	}
> +
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> +
> +	for (int i = 0; i < info->nr_partitions; i++) {
> +		const struct cxl_dpa_part_info *part = &info->part[i];
> +		const char *desc;
> +		int rc;
> +
> +		if (part->mode == CXL_PARTMODE_RAM)
> +			desc = "ram";
> +		else if (part->mode == CXL_PARTMODE_PMEM)
> +			desc = "pmem";
> +		else
> +			desc = "";
> +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> +		cxlds->part[i].mode = part->mode;
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> +				 part->range.start, range_len(&part->range),
> +				 desc);
> +		if (rc)
> +			return rc;
> +		cxlds->nr_partitions++;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
> +
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  				resource_size_t base, resource_size_t len,
>  				resource_size_t skipped)
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3502f1633ad2..62bb3653362f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1241,57 +1241,39 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return rc;
>  }
>  
> -static int add_dpa_res(struct device *dev, struct resource *parent,
> -		       struct resource *res, resource_size_t start,
> -		       resource_size_t size, const char *type)
> +static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
>  {
> -	int rc;
> +	int i = info->nr_partitions;
>  
> -	res->name = type;
> -	res->start = start;
> -	res->end = start + size - 1;
> -	res->flags = IORESOURCE_MEM;
> -	if (resource_size(res) == 0) {
> -		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
> -		return 0;
> -	}
> -	rc = request_resource(parent, res);
> -	if (rc) {
> -		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
> -			res, rc);
> -		return rc;
> -	}
> -
> -	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
> +	if (size == 0)
> +		return;
>  
> -	return 0;
> +	info->part[i].range = (struct range) {
> +		.start = start,
> +		.end = start + size - 1,
> +	};
> +	info->part[i].mode = mode;
> +	info->nr_partitions++;
>  }
>  
> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> -	struct resource *ram_res = to_ram_res(cxlds);
> -	struct resource *pmem_res = to_pmem_res(cxlds);
>  	struct device *dev = cxlds->dev;
>  	int rc;
>  
>  	if (!cxlds->media_ready) {
> -		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> -		*ram_res = DEFINE_RES_MEM(0, 0);
> -		*pmem_res = DEFINE_RES_MEM(0, 0);
> +		info->size = 0;
>  		return 0;
>  	}
>  
> -	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
> +	info->size = mds->total_bytes;
>  
>  	if (mds->partition_align_bytes == 0) {
> -		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> -				 mds->volatile_only_bytes, "ram");
> -		if (rc)
> -			return rc;
> -		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> -				   mds->volatile_only_bytes,
> -				   mds->persistent_only_bytes, "pmem");
> +		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> +		add_part(info, mds->volatile_only_bytes,
> +			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> +		return 0;
>  	}
>  
>  	rc = cxl_mem_get_partition_info(mds);
> @@ -1300,15 +1282,13 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  		return rc;
>  	}
>  
> -	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> -			 mds->active_volatile_bytes, "ram");
> -	if (rc)
> -		return rc;
> -	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> -			   mds->active_volatile_bytes,
> -			   mds->active_persistent_bytes, "pmem");
> +	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> +	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> +		 CXL_PARTMODE_PMEM);
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
> @@ -1452,8 +1432,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->cxlds.reg_map.host = dev;
>  	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> -	to_ram_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
> -	to_pmem_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
>  
>  	return mds;
>  }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index c5f8320ed330..be0eb57086e1 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -80,7 +80,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(to_ram_res(cxlds));
> +	unsigned long long len = cxl_ram_size(cxlds);
>  
>  	return sysfs_emit(buf, "%#llx\n", len);
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 78e92e24d7b5..15f549afab7c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,6 +97,25 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
>  
> +enum cxl_partition_mode {
> +	CXL_PARTMODE_NONE,
> +	CXL_PARTMODE_RAM,
> +	CXL_PARTMODE_PMEM,
> +};
> +
> +#define CXL_NR_PARTITIONS_MAX 2
> +
> +struct cxl_dpa_info {
> +	u64 size;
> +	struct cxl_dpa_part_info {
> +		struct range range;
> +		enum cxl_partition_mode mode;
> +	} part[CXL_NR_PARTITIONS_MAX];
> +	int nr_partitions;
> +};
> +
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
> +
>  static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  					 struct cxl_memdev *cxlmd)
>  {
> @@ -408,6 +427,18 @@ struct cxl_dpa_perf {
>  	int qos_class;
>  };
>  
> +/**
> + * struct cxl_dpa_partition - DPA partition descriptor
> + * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> + * @perf: performance attributes of the partition from CDAT
> + * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> + */
> +struct cxl_dpa_partition {
> +	struct resource res;
> +	struct cxl_dpa_perf perf;
> +	enum cxl_partition_mode mode;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -423,8 +454,8 @@ struct cxl_dpa_perf {
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
> - * @_pmem_res: Active Persistent memory capacity configuration
> - * @_ram_res: Active Volatile memory capacity configuration
> + * @part: DPA partition array
> + * @nr_partitions: Number of DPA partitions
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
>   * @cxl_mbox: CXL mailbox context
> @@ -438,21 +469,47 @@ struct cxl_dev_state {
>  	bool rcd;
>  	bool media_ready;
>  	struct resource dpa_res;
> -	struct resource _pmem_res;
> -	struct resource _ram_res;
> +	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> +	unsigned int nr_partitions;
>  	u64 serial;
>  	enum cxl_devtype type;
>  	struct cxl_mailbox cxl_mbox;
>  };
>  
> -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +
> +/* Static RAM is only expected at partition 0. */
> +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +{
> +	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> +		return NULL;
> +	return &cxlds->part[0].res;
> +}
> +
> +/*
> + * Static PMEM may be at partition index 0 when there is no static RAM
> + * capacity.
> + */
> +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +{
> +	for (int i = 0; i < cxlds->nr_partitions; i++)
> +		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> +			return &cxlds->part[i].res;
> +	return NULL;
> +}
> +
> +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
>  {
> -	return &cxlds->_ram_res;
> +	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> +		return NULL;
> +	return &cxlds->part[0].perf;
>  }
>  
> -static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
>  {
> -	return &cxlds->_pmem_res;
> +	for (int i = 0; i < cxlds->nr_partitions; i++)
> +		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> +			return &cxlds->part[i].perf;
> +	return NULL;
>  }
>  
>  static inline resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
> @@ -499,8 +556,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> - * @_ram_perf: performance data entry matched to RAM partition
> - * @_pmem_perf: performance data entry matched to PMEM partition
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -524,29 +579,12 @@ struct cxl_memdev_state {
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
>  
> -	struct cxl_dpa_perf _ram_perf;
> -	struct cxl_dpa_perf _pmem_perf;
> -
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
>  	struct cxl_fw_state fw;
>  };
>  
> -static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> -{
> -	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> -
> -	return &mds->_ram_perf;
> -}
> -
> -static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> -{
> -	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> -
> -	return &mds->_pmem_perf;
> -}
> -
>  static inline struct cxl_memdev_state *
>  to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  {
> @@ -860,7 +898,7 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0241d1d7133a..47dbfe406236 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -900,6 +900,7 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dpa_info range_info = { 0 };
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> @@ -989,7 +990,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_mem_create_range_info(mds);
> +	rc = cxl_mem_dpa_fetch(mds, &range_info);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 7f1c5061307b..ba3d48b37de3 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1001,26 +1001,19 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
> -	const struct resource *partition[] = {
> -		to_ram_res(cxlds),
> -		to_pmem_res(cxlds),
> -	};
> -	struct cxl_dpa_perf *perf[] = {
> -		to_ram_perf(cxlds),
> -		to_pmem_perf(cxlds),
> -	};
>  
>  	if (!cxl_root)
>  		return;
>  
> -	for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> -		const struct resource *res = partition[i];
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		struct resource *res = &cxlds->part[i].res;
> +		struct cxl_dpa_perf *perf = &cxlds->part[i].perf;
>  		struct range range = {
>  			.start = res->start,
>  			.end = res->end,
>  		};
>  
> -		dpa_perf_setup(port, &range, perf[i]);
> +		dpa_perf_setup(port, &range, perf);
>  	}
>  
>  	cxl_memdev_update_perf(cxlmd);
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 347c1e7b37bd..ed365e083c8f 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1477,6 +1477,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_mockmem_data *mdata;
>  	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_dpa_info range_info = { 0 };
>  	int rc;
>  
>  	mdata = devm_kzalloc(dev, sizeof(*mdata), GFP_KERNEL);
> @@ -1537,7 +1538,11 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_mem_create_range_info(mds);
> +	rc = cxl_mem_dpa_fetch(mds, &range_info);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
>  		return rc;
>  
> 

