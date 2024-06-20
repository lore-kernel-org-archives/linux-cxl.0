Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884081ACE86;
	Thu, 20 Jun 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887594; cv=none; b=N4ut1vTZS0sD5krCu6s5ZfLznQzeXWoXmMkd+I0XZTe6NyKpiPlaX3Iwl4WUUXoAkDv6AEaI7jGy5PPLDaFeiG4oLNb/qpjDMbB1soBCWnQdm/ObTewljMw4fVk044vZSWasHappBb3UqF2XHntTlblaj7wJEvnUtj0e/m+y9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887594; c=relaxed/simple;
	bh=+jQD1f9qOvycTAIiPSa22+PdvGePiYEyHYTZHELciIE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgM5KoouBltoH+DQW7coo0oRHRgvWpdVw+KxLuyJmgjsnRa1uAbPSCySo2CILzSvwvKOielsMbkb6zjVto5ZrD5j2JJ6L1HIrZbiueMlzdmNA3P1xw/jHiw7XUNB7fkvbW+mwmszIdeSUlGeSxuCAueCrUOIY5RZ6Oda8VqyHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4gDl0yfQz6K9SJ;
	Thu, 20 Jun 2024 20:44:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C8BAD14058E;
	Thu, 20 Jun 2024 20:46:28 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 13:46:28 +0100
Date: Thu, 20 Jun 2024 13:46:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 4/9] cxl/pci: Map CXL PCIe ports' RAS registers
Message-ID: <20240620134626.00004dc4@Huawei.com>
In-Reply-To: <20240617200411.1426554-5-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-5-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 15:04:06 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> RAS registers are not currently mapped for CXL root ports, CXL downstream
> switch ports, and CXL upstream switch ports. Update the driver to map the
> ports' RAS registers in preparation for RAS logging and handling to be
> added in the future.
> 
> Add a 'struct cxl_regs' variable to 'struct cxl_port'. This will be used
> to store a pointer to the upstream port's mapped RAS registers.
> 
> Invoke the RAS mapping logic from the CXL memory device probe routine
> after the endpoint is added. This ensures the ports have completed
> training and the RAS registers are present in CXL.cachemem.
> 
> Refactor the cxl_dport_map_regs() function to support mapping the CXL
> PCIe ports. Also, check for previously mapped registers in the topology
> including CXL switch. Endpoints under a CXL switch share a CXL root port
> and will be iterated for each endpoint. Only map once.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Hi Terry,

A few minor comments inline.

Thanks,

Jonathan

> ---
>  drivers/cxl/core/pci.c | 30 +++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h      |  5 +++++
>  drivers/cxl/mem.c      | 32 ++++++++++++++++++++++++++++++--
>  3 files changed, 60 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0df09bd79408..e6c91b3dfccf 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -787,16 +787,26 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  	dport->regs.dport_aer = dport_aer;
>  }
>  
> -static void cxl_dport_map_regs(struct cxl_dport *dport)
> +static void cxl_port_map_regs(struct device *dev,
> +			      struct cxl_register_map *map,
> +			      struct cxl_regs *regs)
>  {
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
>  	if (!map->component_map.ras.valid)
>  		dev_dbg(dev, "RAS registers not found\n");

Maybe return here as nothing useful is going to occur after this any more.

> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> +	else if (regs->ras)
> +		dev_dbg(dev, "RAS registers already initialized\n");

likewise, return if this condition happened.

> +	else if (cxl_map_component_regs(map, &regs->component,
>  					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
> +}
> +
> +static void cxl_dport_map_regs(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct cxl_regs *regs = &dport->regs;
> +	struct device *dev = dport->dport_dev;
> +
> +	cxl_port_map_regs(dev, map, regs);
>  
>  	if (dport->rch)
>  		cxl_dport_map_rch_aer(dport);
> @@ -831,6 +841,16 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	}
>  }
>  
> +void cxl_setup_parent_uport(struct device *host, struct cxl_port *port)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +	struct cxl_regs *regs = &port->regs;
> +	struct device *uport_dev = port->uport_dev;
> +
> +	cxl_port_map_regs(uport_dev, map, regs);

Maybe it will be used later, but based on this patch alone.
	cxl_port_map_regs(port->uport_dev, &port->reg_map,
			  &port->regs);

is more compact and I don't think looses anything on readability front.


> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_uport, CXL);
> +
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 036d17db68e0..7cee678fdb75 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -587,6 +587,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -607,6 +608,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_regs regs;

Does mapping the whole cxl_regs in make sense?
At least currently we can't use the pmu regs in there from here
for instance - the mess with interrupts means that has to bind
via the port driver (for now anyway).
Maybe struct cxl_component_regs is more appropriate here?


>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -757,9 +759,12 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
> +void cxl_setup_parent_uport(struct device *host, struct cxl_port *port);
>  #else
>  static inline void cxl_setup_parent_dport(struct device *host,
>  					  struct cxl_dport *dport) { }
> +static inline void cxl_setup_parent_uport(struct device *host,
> +					  struct cxl_port *port) { }
>  #endif
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 0c79d9ce877c..51a4641fc9a6 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,10 +45,39 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static bool cxl_dev_is_pci_type(struct device *dev, u32 pcie_type)
Naming perhaps needs work to make it clear this is checking if
it's a CXL device of that type.
Also, seems like general functionality that belongs in core/pci.c or
similar.

> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	if (pci_pcie_type(pdev) != pcie_type)
> +		return false;
> +
> +	return pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +					 CXL_DVSEC_REG_LOCATOR);
> +}
> +
> +static void cxl_setup_ep_parent_ports(struct cxl_ep *ep, struct device *host)
> +{
> +	struct cxl_dport *dport = ep->dport;
> +
> +	if (cxl_dev_is_pci_type(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
> +	    cxl_dev_is_pci_type(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT))
> +		cxl_setup_parent_dport(host, ep->dport);
> +
> +	if (cxl_dev_is_pci_type(dport->port->uport_dev, PCI_EXP_TYPE_UPSTREAM))
> +		cxl_setup_parent_uport(host, ep->dport->port);
> +}
> +
>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  				 struct cxl_dport *parent_dport)
>  {
>  	struct cxl_port *parent_port = parent_dport->port;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	struct cxl_port *endpoint, *iter, *down;
>  	int rc;
>  
> @@ -62,6 +91,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  
>  		ep = cxl_ep_load(iter, cxlmd);
>  		ep->next = down;
> +		cxl_setup_ep_parent_ports(ep, &pdev->dev);
>  	}
>  
>  	/* Note: endpoint port component registers are derived from @cxlds */
> @@ -157,8 +187,6 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> -	cxl_setup_parent_dport(dev, dport);
> -
>  	device_lock(endpoint_parent);
>  	if (!endpoint_parent->driver) {
>  		dev_err(dev, "CXL port topology %s not enabled\n",

