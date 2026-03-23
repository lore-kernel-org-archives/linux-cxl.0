Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806129BDBB
	for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307430; cv=none; b=H+bcBYb9pPQFSJN9Q5RZOr/GJY0+ivOwUrH8mMzqHBy3egPRzJQzNW5xlWrVUtTvee0i9PNcGuK1ONXSGKlj8mYEqNS0HEnMc6dHDMTRk8SNKoffGjFtBomlMMJELSTx3mgszXIKhh44x3Z/kl4ShFq+YAlp1z/lu7ZBbqHsSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307430; c=relaxed/simple;
	bh=IGUUaK8v9O80a4enDwnsLltr60aQkUqyMssZQR/kCEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVqXFqmzStR1AC1J0DovnzQosAUT+nvPxVwQfSIG6opb8DuRFw7mX5HqcrheIdkDtMGpCYf1MXdm3qWgMOeBVYaRd8xWy2EeXqC43cRZQ5x14266EmL4wtft2vDhJVhH2qGfR2IzFr7erJ5P7N8h7l4Vd9ffvfGbzo8xMELlEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtMlay57; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtMlay57"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774307428; x=1805843428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IGUUaK8v9O80a4enDwnsLltr60aQkUqyMssZQR/kCEk=;
  b=QtMlay57WwwTARuLD7UwtzAWn0PFWqF0k8FPDNRXEI31hbj0wKT8GpWE
   ocaW4q5+GWfdaPp/ndHOiWa6325WO/nf2hS1ePLrtEp+CZhRPp3AR1xmK
   pugr/ZxKjIEj/5CYrzSHYny0jL1yyJyhssex2Go9fNE1siI/rz7Zy+WN9
   PMuLk6Jq34xJg5USs+FdlALBCrhAbveEL9eRi9OFtObBsBWwDBOjn7kvR
   oMB89Ni4LEMI8LINSrwfHimYsmS9QQ4KAEqy4uow+enHCRBaiTELI1zzl
   Bp9dONRl2REBsHweY0AvGqe8OBs5yt4o6Fhq6MUD1c4o3oyRu8R7rQEwK
   w==;
X-CSE-ConnectionGUID: RU0cVLHwR5G16gzFrx++QQ==
X-CSE-MsgGUID: 3ycs8VjYSfu6yzQfxG2DWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="97936952"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="97936952"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 16:10:26 -0700
X-CSE-ConnectionGUID: b4dixMwOSQGKtiDG3mVsvA==
X-CSE-MsgGUID: S0xV669XRumN6b+CVo/63Q==
X-ExtLoop1: 1
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.216]) ([10.125.109.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 16:10:26 -0700
Message-ID: <5e46426b-26aa-436f-a0fa-3904f1eda36c@intel.com>
Date: Mon, 23 Mar 2026 16:10:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] cxl: Add BI register probing and port initialization
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, gourry@gourry.net, dongjoo.seo1@samsung.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-3-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260315202741.3264295-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/26 1:27 PM, Davidlohr Bueso wrote:
> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and initialize BI registers
> during port probe for both switch ports and endpoint ports.
> 
> For switch ports, map BI Decoder registers on downstream ports and
> BI Route Table registers on upstream ports. For endpoint ports, map
> the BI Decoder registers directly into the port's register block.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/regs.c | 13 ++++++
>  drivers/cxl/port.c      | 88 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 93710cf4f0a6..82e6018fd4cf 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -92,6 +92,18 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
>  			break;
> +		case CXL_CM_CAP_CAP_ID_BI_RT:
> +			dev_dbg(dev, "found BI RT capability (0x%x)\n",
> +				offset);
> +			length = CXL_BI_RT_CAPABILITY_LENGTH;
> +			rmap = &map->bi;
> +			break;
> +		case CXL_CM_CAP_CAP_ID_BI_DECODER:
> +			dev_dbg(dev, "found BI Decoder capability (0x%x)\n",
> +				offset);
> +			length = CXL_BI_DECODER_CAPABILITY_LENGTH;
> +			rmap = &map->bi;
> +			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>  				offset);
> @@ -211,6 +223,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  	} mapinfo[] = {
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>  		{ &map->component_map.ras, &regs->ras },
> +		{ &map->component_map.bi, &regs->bi },
>  	};
>  	int i;
>  
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52f..0540f0681ffb 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -58,6 +58,90 @@ static int discover_region(struct device *dev, void *unused)
>  	return 0;
>  }
>  
> +static int cxl_dport_init_bi(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (dport->regs.bi)
> +		return 0;
> +
> +	if (!cxl_pci_flit_256(to_pci_dev(dev)))
> +		return 0;
> +
> +	if (!map->component_map.bi.valid) {
> +		dev_dbg(dev, "BI decoder registers not found\n");
> +		return 0;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER))) {
> +		dev_dbg(dev, "Failed to map BI decoder capability.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cxl_uport_init_bi(struct cxl_port *port, struct device *host)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +
> +	if (port->uport_regs.bi)
> +		return;
> +
> +	if (!map->component_map.bi.valid) {
> +		dev_dbg(host, "BI RT registers not found\n");
> +		return;
> +	}
> +
> +	map->host = host;
> +	if (cxl_map_component_regs(map, &port->uport_regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_RT)))
> +		dev_dbg(&port->dev, "Failed to map BI RT capability\n");
> +}
> +
> +static void cxl_endpoint_init_bi(struct cxl_port *port)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +
> +	cxl_dport_init_bi(port->parent_dport);

I'm not sure this looks right. The parent dport of an endpoint would be the dport of a switch or a root port. Wouldn't this already been probed when the RP or switch is being probed for BI? To init the endpoint BI, wouldn't you want to init the BI registers on the device? And therefore shouldn't it be be cxl_uport_init_bi(endpoint_port, host)?

DJ

> +
> +	if (!map->component_map.bi.valid)
> +		return;
> +
> +	if (cxl_map_component_regs(map, &port->regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER)))
> +		dev_dbg(&port->dev, "Failed to map BI decoder capability\n");
> +}
> +
> +static void cxl_switch_port_init_bi(struct cxl_port *port)
> +{
> +	struct cxl_dport *parent_dport = port->parent_dport;
> +
> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return;
> +
> +	if (dev_is_pci(port->uport_dev) &&
> +	    !cxl_pci_flit_256(to_pci_dev(port->uport_dev)))
> +		return;
> +
> +	if (parent_dport && dev_is_pci(parent_dport->dport_dev)) {
> +		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
> +
> +		switch (pci_pcie_type(pdev)) {
> +		case PCI_EXP_TYPE_ROOT_PORT:
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			cxl_dport_init_bi(parent_dport);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	cxl_uport_init_bi(port, &port->dev);
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	/* Reset nr_dports for rebind of driver */
> @@ -66,6 +150,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  
> +	cxl_switch_port_init_bi(port);
> +
>  	return 0;
>  }
>  
> @@ -128,6 +214,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);
>  
> +	cxl_endpoint_init_bi(port);
> +
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)

