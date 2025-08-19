Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD925F98E
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613113; cv=none; b=sYbu8Q/q0wMus32uZ6RhdrupzbA6VdXG9npK2Qf6NsQPuflUdgjJXiUN/DnsecSJaZyLp+96lbSnb4pVc9Kct6k8t4cgydj0xYqY0mpoh9OIk04ABaUgI5Ckw4Y8tVR9UjS+jYD4SoLZDNKboYmgm0dnW9Ie5RSrYuU2/ggOoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613113; c=relaxed/simple;
	bh=rGYHYpyXB2ZJzk87s2KuTTJjyA67CBahs/afKYzM5Hc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9DdzHGHoUNYWAmHVG5QmVHdkEi5twh0q1Ol2FIOJTzRvDVCXL1njix2XCUkr9TCWCUfS30QPU+Hu/ru8zjFqa+QDZVKEcrPndumUgr6vV7HuDXtUfqCYQ7r8jr5s3wU85BsTJMTV6b2Xsln/274oAmpYSsgJQKYPWBh/zs4aeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5s740Gm9z6GCCf;
	Tue, 19 Aug 2025 22:15:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4ABD2140427;
	Tue, 19 Aug 2025 22:18:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 16:18:27 +0200
Date: Tue, 19 Aug 2025 15:18:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 11/18] cxl/core: Add CXL snoop filter setup and
 checking
Message-ID: <20250819151826.00000aab@huawei.com>
In-Reply-To: <20250812212921.9548-12-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-12-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:14 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add functions to set up and validate the snoop filter configuration of a
> CXL-capable PCIe Root Port (struct cxl_dport). Allocate space in the
> snoop filter as part of cxl_cachedev probe.
> 

Any thoughts on how to handle allocation policy, when combined with Cache_SF_Coverage
hints or indeed just overcommiting the snoop filter and relying on snoops
to clear space.

The spec is rather ambiguous on when these can be used as opposed to
just rejecting devices if we are out of space.


> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

A few comments inline.

Thanks,

Jonathan

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

static?

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
> +	sf = kzalloc(sizeof(*sf), GFP_KERNEL);
> +	if (!sf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sf->size = size;
> +	xa_init(&sf->dports);
> +	xa_init(&sf->devs);
> +	mutex_init(&sf->lock);
> +
> +	rc = xa_insert(&sf->dports, (unsigned long)dport->dport_dev, dport,

So the aim here is include all dports with this GID in sf->dports?
If so why isn't one added if the xa_load() above finds sf?

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

Not freeing sf?

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

I'd put a debug print here at least and possibly scream as fairly
sure this means we are trying to free something we never had.

> +		return;
> +
> +	guard(mutex)(&sf->lock);
> +	sf->size += cstate->size;
> +}
> +
> +int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds)

I'd rename this as it is allocating part of the capacity rather
than allocating the snoop filter representation.
_alloc_for_device maybe?


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

I'd go with the CXL spec term which is simply "CXL root port".

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

I'm not sure I'd bother with masking when it is the whole register with
no reserved bits.

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

Export seems unnecessary given it's used later in this file.
Maybe that changes in later patches.

> +


> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1771c42a1e3b..2881e0826829 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -40,6 +40,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  
>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
> +#define   CXL_CM_CAP_CAP_ID_SNOOP 0x9

Snoop filter capability is 0x8 I think.
0x9 is the timeout and isolation capability.


>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1


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

