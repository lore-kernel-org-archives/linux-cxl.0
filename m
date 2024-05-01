Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA61758D
	for <linux-cxl@vger.kernel.org>; Wed,  1 May 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571181; cv=none; b=ec9vCbsWyRX2B8zyCDWHjZmrToKGXGV6jYrBNPHgEzVcXcvYcUU8He4UU4amh2PS4n8722F61CK+AzLdKMUi3VUhhmZceZYUnWO6foKaTqj8eNotEclfY1eAc7Ug7bI5bveCCSdOU8NnSYWDIFU6wEgGYxNWEttum83afG+PtnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571181; c=relaxed/simple;
	bh=iJDwLtkULXbRVbTHHwfzhg8CXynLc3Jy62/KZ77uiRE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzV31GLKIcRgnlJpLEGGxad6EaKO94LQkh3rQ3I3zTmZo0EpIdh+MQdCmA3xxwXJmlC2MYAV/4mV0dC8h2UemMcay5UpT9oOiiXeUdruS81JWnrKt3g0NXuXySy+qhhE93gGfulPVRjaE4AU3w4Vwd8K00Ixg9PJwmluEz1UGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTyvQ67gcz687yx;
	Wed,  1 May 2024 21:43:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C13D0140B73;
	Wed,  1 May 2024 21:46:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 1 May
 2024 14:46:14 +0100
Date: Wed, 1 May 2024 14:46:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <20240501144613.00004008@Huawei.com>
In-Reply-To: <20240411181641.514075-1-dave.jiang@intel.com>
References: <20240411181641.514075-1-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Apr 2024 11:16:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> For a topology where multiple targets sharing the same switch uplink, the
> bandwidth must be divided amongst all the sharing targets.
> cxl_rr->num_targets keeps track of the numbers of targets sharing the same
> upstream port. The current implementation accumulates targets during
> cxl_region_attach() and does not have the final number of targets until
> the last target is attached. If the upstream link is shared, accumulate
> bandwidth up to the switch upstream bandwidth.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Link: https://lore.kernel.org/linux-cxl/20240405143242.0000363a@Huawei.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Version info below the ---
Though it's your problem to fix that up commits anyway :)

Some passing code comments inline but as with Ira I can't see how this
works for anything involving more than one switch.

> 
> v2:
> - cxl_region_targets() -> cxl_port_shared_region_targets(). (Dan)
> - Use different method to calculate bandwidth. (Dan)
> ---
>  drivers/cxl/core/cdat.c   | 48 +++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/core.h   |  3 +++
>  drivers/cxl/core/pci.c    | 35 ++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c | 10 ++++++++
>  4 files changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 4b717d2f5a9d..09f3e62e19a5 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -541,6 +541,36 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  MODULE_IMPORT_NS(CXL);
>  
> +static int cxl_get_switch_uport_bandwidth(struct device *uport_dev)
> +{
> +	struct device *dev = uport_dev->parent;
> +
> +	if (!dev_is_pci(dev))
> +		return -ENODEV;
> +
> +	return cxl_pci_get_switch_usp_bandwidth(to_pci_dev(dev));
> +}
> +
> +/*
> + * Calculate the bandwidth for the cxl region based on the number of targets
> + * that share an upstream switch. The function is called while targets are
> + * being attached for a region. If the number of targets is 1, then
> + * the target either does not have a upstream switch or it's the first target
> + * of the shared link. In this case, the bandwidth is the sum of the target
> + * bandwidth and the collected region bandwidth. If the targets from cxl_rr is
> + * greater than 1, then the bandwidth is the minimum of the switch upstream
> + * port bandwidth or the region plus the target bandwidth.
> + */
> +static unsigned int calculate_region_bw(int targets, unsigned int usp_bw,
> +					unsigned int ep_bw,
> +					unsigned int region_bw)
> +{
> +	if (targets == 1)
> +		return region_bw + ep_bw;
> +
> +	return min_t(unsigned int, usp_bw, region_bw + ep_bw);
Similar to what Ira said, I can't see how this works for more complex situations
(i.e. pretty much anything involving more than one switch in parallel.).

> +}
> +
>  void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  				    struct cxl_endpoint_decoder *cxled)
>  {
> @@ -551,7 +581,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  			.start = cxled->dpa_res->start,
>  			.end = cxled->dpa_res->end,
>  	};
> +	struct cxl_port *port = cxlmd->endpoint;
>  	struct cxl_dpa_perf *perf;
> +	int usp_bw, targets;
>  
>  	switch (cxlr->mode) {
>  	case CXL_DECODER_RAM:
> @@ -569,6 +601,12 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  	if (!range_contains(&perf->dpa_range, &dpa))
>  		return;
>  
> +	usp_bw = cxl_get_switch_uport_bandwidth(port->uport_dev);
> +	if (usp_bw > 0)
> +		targets = cxl_port_shared_region_targets(port, cxlr);
> +	else

Comment on why would be helpful.  I think it's because there wasn't
a switch upstream port in the path?

> +		targets = 1;
> +
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		/* Get total bandwidth and the worst latency for the cxl region */
>  		cxlr->coord[i].read_latency = max_t(unsigned int,
> @@ -577,8 +615,14 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  		cxlr->coord[i].write_latency = max_t(unsigned int,
>  						     cxlr->coord[i].write_latency,
>  						     perf->coord[i].write_latency);
> -		cxlr->coord[i].read_bandwidth += perf->coord[i].read_bandwidth;
> -		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
> +		cxlr->coord[i].read_bandwidth =
> +			calculate_region_bw(targets, usp_bw,
> +					    perf->coord[i].read_bandwidth,
> +					    cxlr->coord[i].read_bandwidth);
> +		cxlr->coord[i].write_bandwidth =
> +			calculate_region_bw(targets, usp_bw,
> +					    perf->coord[i].write_bandwidth,
> +					    cxlr->coord[i].write_bandwidth);
>  	}
>  }
>  
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index bc5a95665aa0..99c1c24df671 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -89,9 +89,12 @@ enum cxl_poison_trace_type {
>  };
>  
>  long cxl_pci_get_latency(struct pci_dev *pdev);
> +int cxl_pci_get_switch_usp_bandwidth(struct pci_dev *pdev);
>  
>  int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>  				       enum access_coordinate_class access);
>  bool cxl_need_node_perf_attrs_update(int nid);
>  
> +int cxl_port_shared_region_targets(struct cxl_port *port, struct cxl_region *cxlr);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0df09bd79408..9281ed5a073d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1045,3 +1045,38 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
>  
>  	return cxl_flit_size(pdev) * MEGA / bw;
>  }
> +
> +static int cxl_pci_get_bandwidth(struct pci_dev *pdev)
> +{
> +	u16 lnksta;
> +	u32 width;
> +	int speed;
> +
> +	speed = pcie_link_speed_mbps(pdev);
> +	if (speed < 0)
> +		return 0;
> +	speed /= BITS_PER_BYTE;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> +
> +	return speed * width;
> +}
> +

I'd add some comments. Otherwise expectation would be that
the pdev passed in would be the usp.

> +int cxl_pci_get_switch_usp_bandwidth(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;

You set this then change it before it's used.

> +	struct pci_dev *iter = pdev;
> +
	while (pci_pcie_type(iter) == PCI_EXP_TYPE_UPSTREAM) {
		dev = iter->dev.parent;
		if (!dev || !dev_is_pci(dev))
			return -ENODEV;
		iter = to_pci_dev(dev);
	}

	return cxl_pci_get_bandwidth(iter);

> +	do {
> +		if (pci_pcie_type(iter) == PCI_EXP_TYPE_UPSTREAM)
> +			break;
> +
> +		dev = iter->dev.parent;
> +		if (!dev || !dev_is_pci(dev))
> +			return -ENODEV;
> +		iter = to_pci_dev(dev);
> +	} while (1);
> +
> +	return cxl_pci_get_bandwidth(iter);
> +}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..5a1bca31d269 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -222,6 +222,16 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
>  	return xa_load(&port->regions, (unsigned long)cxlr);
>  }
>  
> +int cxl_port_shared_region_targets(struct cxl_port *port, struct cxl_region *cxlr)
> +{
> +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +
> +	if (!cxl_rr)
> +		return 0;
> +
> +	return cxl_rr->nr_targets;
> +}
> +
>  static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  {
>  	if (!cpu_cache_has_invalidate_memregion()) {

