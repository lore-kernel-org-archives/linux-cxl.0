Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5EF40DFA6
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021615; cv=none; b=MziaICqBoAvmjp/znef9w1z8/fNgJd35F8mhJMMDMNxxIDavseXB+Ti0AFavMth9OJ9yF4ksx5Z6jBXUF8WMSfEQqBbhLVsvD0LHT9Wxg5aqZcGw/haXwviGCgwQMBMYTex7Ez5EgdurZkRbbugDgRAJj3vAPEpEXyEokJh6bIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021615; c=relaxed/simple;
	bh=wT7yZ/1LHB+mGUF5JUoafl5ag/WrqPMlQWjvLZXpT3g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLfr3nQiiU1PFwcqMy7umh/w5noBF1Doruh2IuixOEN8kjfgHb+3l4HFDbf1Xo7wC0XJUYj9/gloCQQMTX2byUh3e+s8TBdx/oZPf8q8F6Diy7dRZwkXJFp5W48A7H6HQoJYx0pC3beBxUnLbONUXGxJ28+95mhTaJd3amjUgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcn2z5GWBzJ467w;
	Fri, 20 Mar 2026 23:45:47 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id ED80F40584;
	Fri, 20 Mar 2026 23:46:48 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 15:46:48 +0000
Date: Fri, 20 Mar 2026 15:46:46 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <gourry@gourry.net>,
	<dongjoo.seo1@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/6] cxl: Add BI register probing and port
 initialization
Message-ID: <20260320154646.00002d4a@huawei.com>
In-Reply-To: <20260315202741.3264295-3-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
	<20260315202741.3264295-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 15 Mar 2026 13:27:37 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and initialize BI registers
> during port probe for both switch ports and endpoint ports.
> 
> For switch ports, map BI Decoder registers on downstream ports and
> BI Route Table registers on upstream ports. For endpoint ports, map
> the BI Decoder registers directly into the port's register block.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Various minor things in here. Biggest one is whether we can use port->regs
for the switch upstream port registers.

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
This was what triggered my reply on whether we should separate the two bi
capabilities.  
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
As below. Maybe a comment on why we might hit this twice.
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

Maybe a comment on why we'd hit this twice and locking requirements
that we don't end up racing between this check and initializing it.

In general uport_regs feels too general a name to me given we have
uport related registers mapped in various different places already.
I.e. in cxl_hdm and devm_cxl_port_ras_setup() which puts it in
port->regs.  Can we not put this one in there as well alongside the RAS
register map?  Assuming I read this right I'd be keen on a comment
update to make it clear that one is all about upstream port component
regs.


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

Rings a bell as something I moaned about before in a different series
as a pattern that is repeated too much. Though I'm still not
hugely keen on this not being named for what it is really checking
about this device.  I believe this is excluding the

devices/platform/ACPI0017:00/root0/portX which are the host bridges.

	if (parent_port_is_cxl_root(port))
		return;

> +		return;
> +
> +	if (dev_is_pci(port->uport_dev) &&

I kind of wish we also had this named to indicate (I think) that it's
excluding CXL test devices.

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

