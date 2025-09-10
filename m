Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358F23B607
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536609; cv=none; b=cL5D4mOC//Aa/P7xa0dSCqMd2ij2FLNjD4nqXNlnHYJ5QH+06Ies1CVdv3bCDmOzDQIJP2ZS0FZ0YuXd0wUb0x6SJoV2mBwtYq1ih3SovXfXPofz7DdR6DF3RMapbmOy0Hsi8TsX1PA074Q92q6mtNEiLhpv3nJ/TRvklQY0edo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536609; c=relaxed/simple;
	bh=by9F8zldkNSmrXEgfdtHpp+OwVAlmntqK9tFXdIiHyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f92bgczkYHoRGtOMmxN4OB0csZvtfj8SjmWsgEAX4x9pBg1Xpp4fvIns/zr/VjQC0aD/+nv55kzIlNU8igtn4r62FJegrr+XqYHEsPbw8Od0fK05ztulRRIemhR+12ztFFUmq0nsNSa6nINa6LaPzy4Gexsf8POcsawdWbFYZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YT6a7Wwu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YT6a7Wwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757536607; x=1789072607;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=by9F8zldkNSmrXEgfdtHpp+OwVAlmntqK9tFXdIiHyQ=;
  b=YT6a7WwuH2RYqgsCAvqMgyDnAECUrnPefCqeQv4eYyVwzR4+VP99Ubd+
   r8+kcgJAj/q88x8tfavWgNsOTI3E/Q/YO23/6SfkXRyZbpdbmHxzH/Zt5
   PhAma6jeNg7aIwYJ/dL4IRKC3RmtBgkRJtm94+tFywNgMkL5vUBCleSrm
   HtTGq0QIRrVHvmilb9g7bTkKFDJtIJ5FKDHAzqc+oJj3l2nXQU0M3HWAE
   OYuA/Aqb0Iz8oE1rbH5UBbx6CniqFZgiECg8+hUJsBJ+8FYmV+Xujmt/6
   8PYen6HX7IsqeEH605c90lKt6cMGLekWTS1hrxoyGCmunTZMH6G6uEd7x
   w==;
X-CSE-ConnectionGUID: kjPNoUgoS/W5E707t5N0Og==
X-CSE-MsgGUID: Lfho6YAzRfqZjzhsgUX4Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59083035"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="59083035"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 13:36:46 -0700
X-CSE-ConnectionGUID: +DoVhvacSdGKVoaLn5IpEw==
X-CSE-MsgGUID: kCPF9ceeTgyLhXoWjkLQjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="210615718"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.219]) ([10.125.110.219])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 13:36:46 -0700
Message-ID: <6c63dc30-0ec1-4ead-a884-bdc87d07f70f@intel.com>
Date: Wed, 10 Sep 2025 13:36:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/18] cxl/core: Add CXL snoop filter setup and
 checking
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-12-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812212921.9548-12-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 2:29 PM, Ben Cheatham wrote:
> Add functions to set up and validate the snoop filter configuration of a
> CXL-capable PCIe Root Port (struct cxl_dport). Allocate space in the
> snoop filter as part of cxl_cachedev probe.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/cache.c     |  26 +++++++
>  drivers/cxl/core/port.c | 145 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c |   7 ++
>  drivers/cxl/cxl.h       |  14 ++++
>  drivers/cxl/cxlcache.h  |   3 +
>  5 files changed, 195 insertions(+)
> 
> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> index 6e5161ae3107..7ef36e4bbce8 100644
> --- a/drivers/cxl/cache.c
> +++ b/drivers/cxl/cache.c
> @@ -55,11 +55,29 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
>  
> +static int find_snoop_gid(struct cxl_cachedev *cxlcd, u32 *gid)
> +{
> +	struct cxl_dport *iter = cxlcd->endpoint->parent_dport;
> +
> +	while (iter && !is_cxl_root(iter->port)) {
> +		if (iter->snoop_id != CXL_SNOOP_ID_NO_ID) {
> +			*gid = iter->snoop_id;
> +			return 0;
> +		}
> +
> +		iter = iter->port->parent_dport;
> +	}
> +
> +	*gid = CXL_SNOOP_ID_NO_ID;
> +	return -ENXIO;
> +}
> +
>  static int cxl_cache_probe(struct device *dev)
>  {
>  	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
>  	struct device *endpoint_parent;
>  	struct cxl_dport *dport;
> +	u32 gid;
>  	int rc;
>  
>  	rc = devm_cxl_enumerate_ports(&cxlcd->dev);
> @@ -96,6 +114,14 @@ static int cxl_cache_probe(struct device *dev)
>  			return rc;
>  	}
>  
> +	rc = find_snoop_gid(cxlcd, &gid);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_cxl_snoop_filter_alloc(gid, cxlcd->cxlds);
> +	if (rc)
> +		return rc;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 5144ddac7145..26ea22a2638c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -35,6 +35,9 @@ static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  static DEFINE_XARRAY(cxl_root_ports);
>  
> +DECLARE_RWSEM(cxl_snoop_rwsem);
> +static DEFINE_XARRAY(cxl_snoop_filters);
> +
>  /*
>   * The terminal device in PCI is NULL and @platform_bus
>   * for platform devices (for cxl_test)
> @@ -809,6 +812,139 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  	return rc;
>  }
>  
> +struct cxl_snoop_filter {
> +	u64 size;
> +	struct xarray dports;
> +	struct xarray devs;
> +	struct mutex lock; /* Used for filter allocations */
> +};
> +
> +static struct cxl_snoop_filter *cxl_create_snoop_filter(struct cxl_dport *dport,
> +							u32 gid, u32 size)
> +{
> +	struct cxl_snoop_filter *sf;
> +	int rc;
> +
> +	sf = xa_load(&cxl_snoop_filters, gid);
> +	if (sf)
> +		return sf;
> +
> +	guard(rwsem_write)(&cxl_snoop_rwsem);

I would move this right before the xa_insert of cxl_snoop_filters. That's what it's guarding right? Although I don't think xarray needs locking?

> +	sf = kzalloc(sizeof(*sf), GFP_KERNEL);

Maybe you can create an helper alloc function and also a free function so you can utilize __free() and avoid the gotos.

> +	if (!sf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sf->size = size;
> +	xa_init(&sf->dports);
> +	xa_init(&sf->devs);
> +	mutex_init(&sf->lock);
> +
> +	rc = xa_insert(&sf->dports, (unsigned long)dport->dport_dev, dport,
> +		       GFP_KERNEL);
> +	if (rc)
> +		goto err;
> +
> +	rc = xa_insert(&cxl_snoop_filters, gid, sf, GFP_KERNEL);
> +	if (rc)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	xa_destroy(&sf->dports);
> +	xa_destroy(&sf->devs);
> +	mutex_destroy(&sf->lock);

Probably not needed since 'sf' gets free right after.

> +	kfree(sf);
> +	return ERR_PTR(rc);
> +}
> +
> +static void cxl_destroy_snoop_filters(void)
> +{
> +	struct cxl_snoop_filter *sf;
> +	unsigned long gid;
> +
> +	guard(rwsem_write)(&cxl_snoop_rwsem);
> +	xa_for_each(&cxl_snoop_filters, gid, sf) {
> +		xa_destroy(&sf->dports);
> +		xa_destroy(&sf->devs);
> +		mutex_destroy(&sf->lock);

Are we missing a kfree(sf) here?

> +	}
> +
> +	xa_destroy(&cxl_snoop_filters);
> +}
> +
> +static void cxl_snoop_filter_free(void *data)
> +{
> +	struct cxl_cache_state *cstate = data;
> +	struct cxl_snoop_filter *sf;
> +
> +	sf = xa_load(&cxl_snoop_filters, cstate->snoop_id);
> +	if (!sf)
> +		return;
> +
> +	guard(mutex)(&sf->lock);
> +	sf->size += cstate->size;

Not sure I understand why the function is called cxl_snoop_filter_free() when we just increment the sf->size.

DJ

> +}
> +
> +int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_cache_state *cstate = &cxlds->cstate;
> +	struct cxl_snoop_filter *sf;
> +
> +	sf = xa_load(&cxl_snoop_filters, gid);
> +	if (!sf)
> +		return -ENODEV;
> +
> +	guard(mutex)(&sf->lock);
> +	if (cstate->size > sf->size)
> +		return -EBUSY;
> +
> +	sf->size -= cstate->size;
> +	cstate->snoop_id = gid;
> +	return devm_add_action_or_reset(cxlds->dev, cxl_snoop_filter_free,
> +					cstate);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_snoop_filter_alloc, "CXL");
> +
> +int cxl_dport_setup_snoop_filter(struct cxl_dport *dport)
> +{
> +	struct cxl_port *port = dport->port, *parent_port;
> +	struct cxl_snoop_filter *sf;
> +	u32 snoop, gid, size;
> +	int rc;
> +
> +	/* Only supported by CXL-enabled PCIe root ports */
> +	parent_port = parent_port_of(port);
> +	if (!parent_port || !is_cxl_root(parent_port))
> +		return 0;
> +
> +	if (!dport->reg_map.component_map.snoop.valid) {
> +		dev_dbg(dport->dport_dev, "missing snoop filter capability\n");
> +		return -ENXIO;
> +	}
> +
> +	rc = cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_SNOOP));
> +	if (rc)
> +		return rc;
> +
> +	snoop = readl(dport->regs.snoop + CXL_SNOOP_GROUP_ID_OFFSET);
> +	gid = FIELD_GET(CXL_SNOOP_GROUP_ID_MASK, snoop);
> +
> +	snoop = readl(dport->regs.snoop + CXL_SNOOP_FILTER_SIZE_OFFSET);
> +	size = FIELD_GET(CXL_SNOOP_FILTER_SIZE_MASK, snoop);
> +	if (!size)
> +		return -ENXIO;
> +
> +	sf = cxl_create_snoop_filter(dport, gid, size);
> +	if (IS_ERR(sf))
> +		return PTR_ERR(sf);
> +
> +	dport->snoop_id = gid;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_setup_snoop_filter, "CXL");
> +
>  DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
>  
>  static int cxl_einj_inject(void *data, u64 type)
> @@ -1202,6 +1338,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	dport->dport_dev = dport_dev;
>  	dport->port_id = port_id;
>  	dport->port = port;
> +	dport->snoop_id = CXL_SNOOP_ID_NO_ID;
>  
>  	if (rcrb == CXL_RESOURCE_NONE) {
>  		rc = cxl_dport_setup_regs(&port->dev, dport,
> @@ -1686,10 +1823,17 @@ static int update_decoders_with_dport(struct cxl_port *port, struct cxl_dport *d
>  static int cxl_port_setup_with_dport(struct cxl_port *port,
>  				     struct cxl_dport *dport)
>  {
> +	int rc;
> +
>  	device_lock_assert(&port->dev);
>  
>  	cxl_switch_parse_cdat(dport);
>  
> +	rc = cxl_dport_setup_snoop_filter(dport);
> +	if (rc)
> +		dev_dbg(dport->dport_dev,
> +			"failed to set up snoop filter capability: %d\n", rc);
> +
>  	return update_decoders_with_dport(port, dport);
>  }
>  
> @@ -2711,6 +2855,7 @@ static void cxl_core_exit(void)
>  	bus_unregister(&cxl_bus_type);
>  	destroy_workqueue(cxl_bus_wq);
>  	cxl_memdev_exit();
> +	cxl_destroy_snoop_filters();
>  	debugfs_remove_recursive(cxl_debugfs);
>  }
>  
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 5ca7b0eed568..0c8962fcad9b 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -92,6 +92,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
>  			break;
> +		case CXL_CM_CAP_CAP_ID_SNOOP:
> +			dev_dbg(dev, "found Snoop filter capability (0x%x)\n",
> +				offset);
> +			length = CXL_SNOOP_FILTER_CAPABILITY_LENGTH;
> +			rmap = &map->snoop;
> +			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>  				offset);
> @@ -211,6 +217,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  	} mapinfo[] = {
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>  		{ &map->component_map.ras, &regs->ras },
> +		{ &map->component_map.snoop, &regs->snoop },
>  	};
>  	int i;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1771c42a1e3b..2881e0826829 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -40,6 +40,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  
>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define   CXL_CM_CAP_CAP_ID_SNOOP 0x9
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> @@ -151,6 +152,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_SIZE SZ_512
>  #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
>  
> +/* CXL 3.2 8.2.4.23 CXL Snoop Filter Capability Structure */
> +#define CXL_SNOOP_GROUP_ID_OFFSET 0x0
> +#define   CXL_SNOOP_GROUP_ID_MASK GENMASK(15, 0)
> +#define CXL_SNOOP_FILTER_SIZE_OFFSET 0x4
> +#define   CXL_SNOOP_FILTER_SIZE_MASK GENMASK(31, 0)
> +#define CXL_SNOOP_FILTER_CAPABILITY_LENGTH 0x8
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -214,6 +222,7 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_component_regs, component,
>  		void __iomem *hdm_decoder;
>  		void __iomem *ras;
> +		void __iomem *snoop;
>  	);
>  	/*
>  	 * Common set of CXL Device register block base pointers
> @@ -256,6 +265,7 @@ struct cxl_reg_map {
>  struct cxl_component_reg_map {
>  	struct cxl_reg_map hdm_decoder;
>  	struct cxl_reg_map ras;
> +	struct cxl_reg_map snoop;
>  };
>  
>  struct cxl_device_reg_map {
> @@ -658,6 +668,8 @@ struct cxl_rcrb_info {
>  	u16 aer_cap;
>  };
>  
> +#define CXL_SNOOP_ID_NO_ID (-1)
> +
>  /**
>   * struct cxl_dport - CXL downstream port
>   * @dport_dev: PCI bridge or firmware device representing the downstream link
> @@ -682,6 +694,7 @@ struct cxl_dport {
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	long link_latency;
>  	int gpf_dvsec;
> +	int snoop_id;
>  };
>  
>  /**
> @@ -756,6 +769,7 @@ struct cxl_dev_ops {
>  struct cxl_cache_state {
>  	u64 size;
>  	u32 unit;
> +	u16 snoop_id;
>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
> index a707e402b000..c4862f7e6edc 100644
> --- a/drivers/cxl/cxlcache.h
> +++ b/drivers/cxl/cxlcache.h
> @@ -25,4 +25,7 @@ int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds);
>  struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
>  					   struct cxl_dev_state *cxlds,
>  					   const struct cxl_dev_ops *ops);
> +
> +int cxl_dport_setup_snoop_filter(struct cxl_dport *dport);
> +int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds);
>  #endif

