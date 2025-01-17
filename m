Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43621F91FF
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111183; cv=none; b=PKllGBxuDubWm+rEVzNl5BOVmLJEMwj/IMWRlx+VS/oSPYh0qff75an8UZAGSUQ+fsZbjlOxcv8Is4ztwMFle8uXnfPyo5+DyipcCa2qDdLjOZnjwIMl8foQoKG6ZEplk4MKo7HR9TzHyp0NRudPPgm5OzogYJ1AkvAEFmqIu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111183; c=relaxed/simple;
	bh=uJMAdgGtwHjbKIUyKD+oK4N+NvzazY0y36FMfxUvNoo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLMQ5audZvHvIRKSGg/BPnuBUzI1SzxBFPaqQui6zeTA6ajNEer5K1UHZLdVIEagBtC1MHSM2Z8QIHxXQ/kkaIdN4t5vxD+mJdpi1Vw2EmDSvGQMw3/MDz96O/mpVKFvVI9kF+TdHjFuNyXEhdf4H+LSV8HKkDkVgFx4Lklrj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZGkJ3KSqz67CtB;
	Fri, 17 Jan 2025 18:51:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A930E1403D2;
	Fri, 17 Jan 2025 18:52:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 11:52:56 +0100
Date: Fri, 17 Jan 2025 10:52:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <20250117105254.00001dd4@huawei.com>
In-Reply-To: <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
	<173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 16 Jan 2025 22:10:44 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

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

Hi Dan,

In basic form this seems fine, but I find the nr_paritions variable usage very
counter intuitive.  It's just how many we configured not how many there
are, potentially with 0 size (so not a partition).  I'd be happier if we
can avoid that by just prefilling the lot with zero size and filling in
the ones we want.  So zero size means doesn't exist and use an iterator where
appropriate to skip the zero size ones.

Without that tidied up, to me this is more confusing than the previous code.

Jonathan

> ---
>  drivers/cxl/core/cdat.c      |   15 ++-----
>  drivers/cxl/core/hdm.c       |   69 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/mbox.c      |   86 ++++++++++++++++++------------------------
>  drivers/cxl/cxlmem.h         |   79 +++++++++++++++++++++++++--------------
>  drivers/cxl/pci.c            |    7 +++
>  tools/testing/cxl/test/cxl.c |   15 ++-----
>  tools/testing/cxl/test/mem.c |    7 +++
>  7 files changed, 176 insertions(+), 102 deletions(-)
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

Ok. This removes some of the concerns from previous patch.

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
> index 7a85522294ad..7e1559b3ed88 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -342,6 +342,75 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
> +		const char *desc;
> +		int rc;
> +
> +		if (i == CXL_PARTITION_RAM)
> +			desc = "ram";
> +		else if (i == CXL_PARTITION_PMEM)
> +			desc = "pmem";
> +		else
> +			desc = "";
> +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> +				 info->range[i].start,
> +				 range_len(&info->range[i]), desc);
> +		if (rc)
> +			return rc;
> +		cxlds->nr_partitions++;
I'd just initialize the rest to 0 length similar to what is happening
if we have pmem only anyway.  Then this nr_patitions goes away and
stops being a possible source of confusion.

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_dpa_setup);

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3502f1633ad2..7dca5c8c3494 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1241,57 +1241,36 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)

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
Obviously nothing to do with your patch as such, but maybe tidy this up
by making active values == fixed values when we don't have partition control.
That seems logical anyway to me and means we only end up with one lot of
range setup in here.  I can't immediately see any side effects of doing this.



	if (mds->partition_align_bytes != 0) {
		rc = cxl_mem_get_partition_info(mds);
		if (rc)
			return rc;
	} else {
		mds->active_volatile_bytes = mds->volatile_only_bytes;
		mds->active_persistent_bytes = mds->persistent_only_bytes;
	}
 	info->range[CXL_PARTITION_RAM] = (struct range) {
		.start = 0,
		.end = mds->active_volatile_bytes - 1,
	};
	info->nr_partitions++;

	if (!mds->active_persistent_bytes)
		return 0;

	info->range[CXL_PARTITION_PMEM] = (struct range) {
		.start = mds->active_volatile_bytes,
		.end = mds->active_volatile_bytes + mds->active_persistent_bytes - 1,
	};
	info->nr_partitions++;

	return 0;
}

> -		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> -				 mds->volatile_only_bytes, "ram");
> -		if (rc)
> -			return rc;
> -		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> -				   mds->volatile_only_bytes,
> -				   mds->persistent_only_bytes, "pmem");
> +		info->range[CXL_PARTITION_RAM] = (struct range) {
> +			.start = 0,
> +			.end = mds->volatile_only_bytes - 1,
> +		};
> +		info->nr_partitions++;
> +
> +		if (!mds->persistent_only_bytes)
> +			return 0;
> +
> +		info->range[CXL_PARTITION_PMEM] = (struct range) {
> +			.start = mds->volatile_only_bytes,
> +			.end = mds->volatile_only_bytes +
> +			       mds->persistent_only_bytes - 1,
> +		};
> +		info->nr_partitions++;

This nr partitions makes some sense though I'd be tempted to add a type
array to info so that we can just not pass empty ones if we don't want to.
Makes this code a little more complex, but not a lot and means
nr->partitions becomes the ones that actually exist.

> +		return 0;
>  	}
>  
>  	rc = cxl_mem_get_partition_info(mds);
> @@ -1300,15 +1279,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
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
> +	info->range[CXL_PARTITION_RAM] = (struct range) {
> +		.start = 0,
> +		.end = mds->active_volatile_bytes - 1,
> +	};
> +	info->nr_partitions++;
> +
> +	if (!mds->active_persistent_bytes)
> +		return 0;
> +
> +	info->range[CXL_PARTITION_PMEM] = (struct range) {
> +		.start = mds->active_volatile_bytes,
> +		.end = mds->active_volatile_bytes + mds->active_persistent_bytes - 1,
> +	};
> +	info->nr_partitions++;
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 78e92e24d7b5..2e728d4b7327 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,6 +97,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
>  
> +/* Well known, spec defined partition indices */
> +enum cxl_partition {
> +	CXL_PARTITION_RAM,
> +	CXL_PARTITION_PMEM,
> +	CXL_PARTITION_MAX,
> +};
> +
> +struct cxl_dpa_info {
> +	u64 size;
> +	struct range range[CXL_PARTITION_MAX];
> +	int nr_partitions;
> +};

blank line seems appropriate here.

> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
> +
>  static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  					 struct cxl_memdev *cxlmd)
>  {
> @@ -408,6 +422,16 @@ struct cxl_dpa_perf {
>  	int qos_class;
>  };
>  

>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -423,8 +447,8 @@ struct cxl_dpa_perf {
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
> - * @_pmem_res: Active Persistent memory capacity configuration
> - * @_ram_res: Active Volatile memory capacity configuration
> + * @part: DPA partition array
> + * @nr_partitions: Number of DPA partitions

This needs more. It is not the number of partitions present I think, it
is the number that a particular driver is potentially interested in.

>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
>   * @cxl_mbox: CXL mailbox context
> @@ -438,21 +462,39 @@ struct cxl_dev_state {
>  	bool rcd;
>  	bool media_ready;
>  	struct resource dpa_res;
> -	struct resource _pmem_res;
> -	struct resource _ram_res;
> +	struct cxl_dpa_partition part[CXL_PARTITION_MAX];
> +	unsigned int nr_partitions;
>  	u64 serial;
>  	enum cxl_devtype type;
>  	struct cxl_mailbox cxl_mbox;
>  };
>  
> -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
>  {
> -	return &cxlds->_ram_res;
> +	if (cxlds->nr_partitions > 0)
> +		return &cxlds->part[CXL_PARTITION_RAM].res;
> +	return NULL;
>  }
>  
> -static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
>  {
> -	return &cxlds->_pmem_res;
> +	if (cxlds->nr_partitions > 1)

This is very confusing as nr_partitions is being used not to indicate
number of partitions but whether a driver has filled in the data for them
(which may well be empty).

I'd rather see that as a bitmap, or a 'not set' value initialized by
the core that is then replaced when they are set.


> +		return &cxlds->part[CXL_PARTITION_PMEM].res;
> +	return NULL;
> +}
> +
> +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> +{
> +	if (cxlds->nr_partitions > 0)
> +		return &cxlds->part[CXL_PARTITION_RAM].perf;
> +	return NULL;
> +}
> +
> +static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> +{
> +	if (cxlds->nr_partitions > 1)
> +		return &cxlds->part[CXL_PARTITION_PMEM].perf;
> +	return NULL;
>  }


> @@ -860,7 +883,7 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);

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

Ok. This gets rid of some of the earlier concerns.

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


