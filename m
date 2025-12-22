Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99933F8C2
	for <linux-cxl@vger.kernel.org>; Mon, 22 Dec 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411253; cv=none; b=WQvAy0kNjIA/xYhyH4oELdwK4hl0E89K6TpQfOL9oMReNvY21Qo0SX0FTdE09peBEjnoAuqOO32FjCei6G6f9oAACR2siXLs3jLK/EVjOFuqP1Vt0lc+9mA1DkrMx2TWVvqqhHqOJ6nBUBufOBDjmw3uQwN/plw96Vhxo7kH+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411253; c=relaxed/simple;
	bh=QAjfQRRtu440aAKlwc52etk5Y+Y03ws8aDHjGe3lLpE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3VqLrc1jYRuqlmtEXi5XIEzfbOzN522Ct04wIozcZe9j3wpXVFqlZ/6Kc7UsXiNwMJCmoGgZ9APiQI28bmyZ6s2RzA9tz7Q+C6Hb4v+R90tvK9iY0lU72g7Ey696/nnm6EdOm1qFCBnYJ+CvJHh8ScPjYYpkqBIV5o6AxVb7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dZfZL2p75zJ4685;
	Mon, 22 Dec 2025 21:46:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EF0A840570;
	Mon, 22 Dec 2025 21:47:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Dec
 2025 13:47:27 +0000
Date: Mon, 22 Dec 2025 13:47:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 13/17] cxl/core: Add cache id verification
Message-ID: <20251222134726.00003986@huawei.com>
In-Reply-To: <20251111214032.8188-14-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
	<20251111214032.8188-14-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 11 Nov 2025 15:40:28 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> The CXL cache id capability (CXL 3.2 8.2.4.28/29) is an optional
This should probably be more specific given there are several
capability structures and none have that name.

> capability that allows for multiple CXL.cache devices to be enabled
> under a single virtual hierarchy (VH). The cache id capability is
> required for having multiple CXL.cache devices in the same VH.
> 
> It's possible for the platform to enable and set up the cache id for a
> CXL.cache device. Add code to cxl_cache to check whether the device's
> cache id is programmed and correct. If it is programmed, allocate the
> cache id to prevent reuse.
> 
> Checking the correctness of the id requires knowing if the endpoint
> device is a type 2 device using HDM-D flows. Add a requirement for type
> 2 driver to specify if the device is using HDM-D flows before calling
> devm_cxl_add_cachedev().

Probably support this with some spec references.


> 
> Programming of cache ids will come in a later commit.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/core/cachedev.c |  20 ++++
>  drivers/cxl/core/pci.c      |   4 +-
>  drivers/cxl/core/port.c     | 229 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c     |  20 ++++
>  drivers/cxl/cxl.h           |  44 +++++++
>  drivers/cxl/cxlcache.h      |   3 +-
>  drivers/cxl/port.c          |  28 ++++-
>  7 files changed, 344 insertions(+), 4 deletions(-)

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 70666a059d1f..1504631ae620 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -750,6 +750,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  		dev->parent = uport_dev;
>  
>  	ida_init(&port->decoder_ida);
> +	ida_init(&port->cache_ida);
>  	port->hdm_end = -1;
>  	port->commit_end = -1;
>  	xa_init(&port->dports);
> @@ -2414,6 +2415,234 @@ int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, "CXL");
>  
> +static bool cache_decoder_committed(struct cxl_dport *dport)
> +{
> +	u32 cap, stat;
> +
> +	cap = readl(dport->regs.cidd + CXL_CACHE_IDD_CAP_OFFSET);
> +	if (!(cap & CXL_CACHE_IDD_CAP_COMMIT_REQUIRED))
> +		return true;
> +
> +	stat = readl(dport->regs.cidd + CXL_CACHE_IDD_STAT_OFFSET);
> +	return (stat & CXL_CACHE_IDD_STAT_COMMITTED);

Brackets not adding much so I'd drop them.

> +}
> +
> +static bool cache_decoder_valid(struct cxl_dport *dport, int id, bool endpoint)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
> +	bool flit_256b = cxl_pci_flit_256(pdev);
> +	u32 ctrl;
> +
> +	if (id && !flit_256b)
> +		return false;
> +
> +	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
> +	if ((endpoint || !flit_256b) &&
> +	    !(ctrl & CXL_CACHE_IDD_CTRL_ASGN_ID))
> +		return false;
> +	else if (!(ctrl & CXL_CACHE_IDD_CTRL_FWD_ID))

returned so no point in else.

> +		return false;
> +
> +	return true;
> +}

> +int cxl_endpoint_map_cache_id_regs(struct cxl_port *port)
> +{
> +	struct cxl_dport *parent_dport = port->parent_dport;
> +	int rc;
> +
> +	if (!is_cxl_cachedev(port->uport_dev))
> +		return -EINVAL;
> +
> +	port = parent_port_of(port);
> +	while (port) {
> +		if (!port->reg_map.component_map.cidrt.valid)
> +			return -ENXIO;
> +
> +		scoped_guard(device, &port->dev) {
> +			if (!port->regs.cidrt) {
> +				rc = cxl_map_component_regs(
> +					&port->reg_map, &port->regs,
> +					BIT(CXL_CM_CAP_CAP_ID_CIDRT));
> +				if (rc)
> +					return rc;
> +			}
> +		}
> +
> +		/*
> +		 * Parent dports of host bridges are cxl root (ACPI0017) dports
> +		 * and don't have cache id decoders.
> +		 */
> +		if (is_cxl_root(parent_dport->port))
> +			break;
> +
> +		if (!parent_dport->reg_map.component_map.cidd.valid)
> +			return -ENXIO;
> +
> +		scoped_guard(device, &parent_dport->port->dev) {
> +			if (!parent_dport->regs.cidd) {
> +				rc = cxl_map_component_regs(
> +					&parent_dport->reg_map,
> +					&parent_dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_CIDD));
> +				if (rc)
> +					return rc;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_map_cache_id_regs, "CXL");
> +
> +/**
> + * cxl_endpoint_allocate_cache_id - Allocate a cache id @id on the endpoint's
> + * host bridge.
> + * @endpoint: Endpoint port representing a CXL.cache device
> + * @id: Cache id to attempt to allocate
> + *
> + * Returns rc < 0 if id allocation fails. Returns allocated id otherwise.
> + */
> +int cxl_endpoint_allocate_cache_id(struct cxl_port *endpoint, int id)
> +{
> +	struct cxl_cachedev *cxlcd;
> +	struct cxl_port *hb;
> +	int nr_hdmd;
> +	u32 cap;
> +
> +	if (!is_cxl_cachedev(endpoint->uport_dev) || id < 0)
> +		return -EINVAL;
> +	cxlcd = to_cxl_cachedev(endpoint->uport_dev);
> +
> +	hb = parent_port_of(endpoint);
> +	while (!is_cxl_host_bridge(&hb->dev))
> +		hb = parent_port_of(hb);
> +
> +	if (cxl_cachedev_is_type2(cxlcd) && cxlcd->cxlds->hdmd) {
> +		cap = readl(hb->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
> +		nr_hdmd = FIELD_GET(CXL_CACHE_IDRT_CAP_TYPE2_CNT_MASK, cap);
> +
> +		guard(device)(&hb->dev);
> +		if (hb->nr_hdmd + 1 >= nr_hdmd)
> +			return -EINVAL;
> +
> +		hb->nr_hdmd++;
> +	}
> +
> +	return ida_alloc_range(&hb->cache_ida, id, id, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_allocate_cache_id, "CXL");
> +
> +void cxl_endpoint_free_cache_id(struct cxl_port *endpoint, int id)
> +{
> +	struct cxl_cachedev *cxlcd;
> +	struct cxl_port *hb;
> +
> +	if (!is_cxl_cachedev(endpoint->uport_dev))
> +		return;
> +	cxlcd = to_cxl_cachedev(endpoint->uport_dev);
> +
> +	hb = endpoint;
> +	while (!is_cxl_host_bridge(&hb->dev))
> +		hb = parent_port_of(hb);
> +
> +	if (cxl_cachedev_is_type2(cxlcd) && cxlcd->cxlds->hdmd) {
> +		guard(device)(&hb->dev);
> +		hb->nr_hdmd--;
> +	}
> +
> +	ida_free(&hb->cache_ida, id);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_free_cache_id, "CXL");

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index de29ffc3d74f..f4dc912d67ed 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -42,6 +42,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_ID_SNOOP 0x8
> +#define   CXL_CM_CAP_CAP_ID_CIDRT 0xD
> +#define   CXL_CM_CAP_CAP_ID_CIDD 0xE
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> @@ -159,6 +161,30 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_SNOOP_FILTER_SIZE_OFFSET 0x4
>  #define CXL_SNOOP_CAPABILITY_LENGTH 0x8
>  
> +/* CXL 3.2 8.2.4.28 CXL Cache ID Route Table Capability Structure */
> +#define CXL_CACHE_IDRT_CAP_OFFSET 0x0
> +#define   CXL_CACHE_IDRT_CAP_CNT_MASK GENMASK(4, 0)
> +#define   CXL_CACHE_IDRT_CAP_TYPE2_CNT_MASK GENMASK(11, 8)

As below. the -D bit should be in this name I think.

> +#define   CXL_CACHE_IDRT_CAP_COMMIT_REQUIRED BIT(16)
> +#define CXL_CACHE_IDRT_STAT_OFFSET 0x8
> +#define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
> +#define CXL_CACHE_IDRT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
> +#define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
> +#define   CXL_CACHE_IDRT_TARGETN_PORTN GENMASK(15, 8)
> +
> +/* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
> +#define CXL_CACHE_IDD_CAP_OFFSET 0x0
> +#define   CXL_CACHE_IDD_CAP_COMMIT_REQUIRED BIT(0)
> +#define CXL_CACHE_IDD_CTRL_OFFSET 0x4
> +#define   CXL_CACHE_IDD_CTRL_FWD_ID BIT(0)
> +#define   CXL_CACHE_IDD_CTRL_ASGN_ID BIT(1)
> +#define   CXL_CACHE_IDD_CTRL_TYPE2 BIT(2)

Need to include the HDM-D bit of this name or it's very confusing as
nothing stops HDM-DB devices being type 2 ones.


> +#define   CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK GENMASK(11, 8)
As above, the HDM-D part of this matters. Obviously it's a long
name but I'm not sure we can avoid that as it's a very specific
thing!



