Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D43AB291
	for <linux-cxl@vger.kernel.org>; Mon, 18 May 2026 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142919; cv=none; b=gBR6oZJozmIYWqFyQbBWrtCKfTDtb5+vwh0JlcEgfL203LxWfVS7NFns511jgKZp6CIP1DdKXLd4mBzzJxgxjLi37Rdn0JJzO9RfJ+0WkrckHKBBv4QnJBhv+QEn8V14gO8WbBpgjYIM5kMJkGPM7mQzpEe1N/jP2OsRwKpzdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142919; c=relaxed/simple;
	bh=XNPtYXuwElH/OaLxhx6P1kigIO/zKKCRVHFdXZhVnCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0D1LLa/mBz2tkPBYU3RjWjG8a8ihuu4+yKMgfCyiKvs1WqnT89fy3YLbUODEQ5FtVpeuvj+C/rJHaV/R69YBAuimxmBzCtMO/kYQzTQDQhxKMglqEoI6PIh5zQR16PH+2iJS1sp0+y6Fbc9zj57Rt/66qv9dDnUk6ihO3Er5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcIms5ub; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcIms5ub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779142918; x=1810678918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XNPtYXuwElH/OaLxhx6P1kigIO/zKKCRVHFdXZhVnCg=;
  b=YcIms5ubyVFghitGd9KGdmA4fovM8znCgqoo6vH555CViuxxx7PmFwqw
   WOShIm2n1vSDYxCCTFijfBV8T8wWUFN/yRhz9MOSSVbyXL6ZbujLxYEmw
   oGMyVMUga/Z3s8HuuRP8wHUDuQGShM62huP+f6IUrhhM+3NZkKUgagQXp
   t37/VzceLljB3aX5TUCDfQSIWepCAKDWJKp004CYrfLEJWShHQwEDzYFa
   VTVe8eJ7g1pmR0N/xyyYJ1le/3D6NMCha+GhyEujG5alzH0fym9Vh5gqG
   rUjAWSGGDtHxx/KGRVszdi/vEzNwbswQI5wS+gjuErNa2HrvvjdkSbyet
   Q==;
X-CSE-ConnectionGUID: udakaZ8bT5+WrPorAXpkyA==
X-CSE-MsgGUID: AcgpS0w8Su66BrzgjpH3lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97578785"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="97578785"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 15:21:57 -0700
X-CSE-ConnectionGUID: 2ZQK3xGwToapnOsfNR8s7w==
X-CSE-MsgGUID: pRAITfBeSIKk6ZphoWt1Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="239635158"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.65]) ([10.125.109.65])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 15:21:57 -0700
Message-ID: <d83b6b61-ee28-487b-bb5c-ae9ac3f84cf6@intel.com>
Date: Mon, 18 May 2026 15:21:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] cxl: Add BI register probing and port
 initialization
To: Davidlohr Bueso <dave@stgolabs.net>, djbw@kernel.org
Cc: jic23@kernel.org, benjamin.cheatham@amd.com, alucerop@amd.com,
 alison.schofield@intel.com, ira.weiny@intel.com, gourry@gourry.net,
 dongjoo.seo1@samsung.com, anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <20260516022037.1761453-2-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260516022037.1761453-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 7:20 PM, Davidlohr Bueso wrote:
> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and initialize BI registers
> during port probe for switch ports and endpoint ports.
> 
> Each port's probe initializes its own BI cap and the parent dport's
> BI Decoder. Switch DSPs are therefore mapped by the children below
> them (endpoint or sub-switch USP), and a root port is mapped by
> whichever cxl_port sits directly below it -- a switch USP, or a
> direct attached endpoint.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/regs.c | 14 +++++++
>  drivers/cxl/cxl.h       |  6 +++
>  drivers/cxl/port.c      | 89 +++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h       |  6 +++
>  4 files changed, 115 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 93710cf4f0a6..a6caa793e7a4 100644
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
> +			rmap = &map->bi_rt;
> +			break;
> +		case CXL_CM_CAP_CAP_ID_BI_DECODER:
> +			dev_dbg(dev, "found BI Decoder capability (0x%x)\n",
> +				offset);
> +			length = CXL_BI_DECODER_CAPABILITY_LENGTH;
> +			rmap = &map->bi_decoder;
> +			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>  				offset);
> @@ -211,6 +223,8 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  	} mapinfo[] = {
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>  		{ &map->component_map.ras, &regs->ras },
> +		{ &map->component_map.bi_rt, &regs->bi_rt },
> +		{ &map->component_map.bi_decoder, &regs->bi_decoder },
>  	};
>  	int i;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..760f51b43891 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -42,6 +42,12 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +#define   CXL_CM_CAP_CAP_ID_BI_RT 0xB
> +#define   CXL_CM_CAP_CAP_ID_BI_DECODER 0xC
> +
> +/* CXL 4.0 8.2.4.26 / 8.2.4.27 BI Capability Structures */
> +#define CXL_BI_RT_CAPABILITY_LENGTH 0xC
> +#define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
>  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52f..e0ac9432848a 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -58,6 +58,91 @@ static int discover_region(struct device *dev, void *unused)
>  	return 0;
>  }
>  
> +static int cxl_dport_init_bi(struct cxl_dport *dport)

cxl_dport_map_bi()?

> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	/*
> +	 * Already mapped. The BI Decoder iomap persists for the dport's
> +	 * lifetime via the parent cxl_port's devm context.
> +	 */
> +	if (dport->regs.bi_decoder)
> +		return 0;
> +
> +	if (!map->component_map.bi_decoder.valid) {
> +		dev_dbg(dev, "BI decoder registers not found\n");
> +		return 0;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER))) {
> +		dev_dbg(dev, "Failed to map BI decoder capability.\n");
> +		return -EINVAL;

why not return the error from cxl_map_comonent_regs()?

> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialize Back-Invalidate registers for @port: map the BI Decoder on
> + * the upstream parent dport (root port or switch DSP), and map this
> + * port's own BI capability -- BI RT for a switch USP, BI Decoder for
> + * an endpoint.
> + */
> +static void cxl_port_init_bi(struct cxl_port *port)

cxl_port_map_bi()

Also, why return void? Are errors just ignored?

> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +	struct cxl_dport *parent_dport = port->parent_dport;
> +	struct device *dport_dev, *udev;
> +	int cap_id;
> +
> +	/* no upstream BI registers above host bridges or the cxl_root */
> +	if (!parent_dport || is_cxl_root(parent_dport->port))
> +		return;
> +
> +	/* BI requires 256B Flit on the upstream link */
> +	udev = is_cxl_endpoint(port) ?
> +		port->uport_dev->parent : port->uport_dev;
> +	if (dev_is_pci(udev) && !cxl_pci_flit_256(to_pci_dev(udev)))

I would split this up and do:

if (!dev_is_pci(udev))
	return;

...

That way you can skip everything else if it's not PCI. Like that switch a few lines down.


> +		return;
> +
> +	dport_dev = parent_dport->dport_dev;

Naming it parent_dport_dev makes it easier to keep track of what is what.


> +	if (dev_is_pci(dport_dev)) {
> +		switch (pci_pcie_type(to_pci_dev(dport_dev))) {
> +		case PCI_EXP_TYPE_ROOT_PORT:
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			cxl_dport_init_bi(parent_dport);

error return value ignored

> +			break;
> +		default:
> +			break;

Should this be an error?

DJ

> +		}
> +	}
> +
> +	if (is_cxl_endpoint(port)) {
> +		if (port->regs.bi_decoder)
> +			return;
> +		if (!map->component_map.bi_decoder.valid) {
> +			dev_dbg(&port->dev, "BI Decoder registers not found\n");
> +			return;
> +		}
> +		cap_id = CXL_CM_CAP_CAP_ID_BI_DECODER;
> +	} else {
> +		if (port->regs.bi_rt)
> +			return;
> +		if (!map->component_map.bi_rt.valid) {
> +			dev_dbg(&port->dev, "BI RT registers not found\n");
> +			return;
> +		}
> +		cap_id = CXL_CM_CAP_CAP_ID_BI_RT;
> +	}
> +
> +	map->host = &port->dev;
> +	if (cxl_map_component_regs(map, &port->regs, BIT(cap_id)))
> +		dev_dbg(&port->dev, "Failed to map BI capability 0x%x\n",
> +			cap_id);
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	/* Reset nr_dports for rebind of driver */
> @@ -66,6 +151,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  
> +	cxl_port_init_bi(port);
> +
>  	return 0;
>  }
>  
> @@ -128,6 +215,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);
>  
> +	cxl_port_init_bi(port);
> +
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index fa7269154620..8ce9b4e9ca73 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -34,10 +34,14 @@ struct cxl_regs {
>  	 * Common set of CXL Component register block base pointers
>  	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
>  	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> +	 * @bi_rt: CXL 4.0 8.2.4.26 CXL BI Route Table Capability Structure
> +	 * @bi_decoder: CXL 4.0 8.2.4.27 CXL BI Decoder Capability Structure
>  	 */
>  	struct_group_tagged(cxl_component_regs, component,
>  		void __iomem *hdm_decoder;
>  		void __iomem *ras;
> +		void __iomem *bi_rt;
> +		void __iomem *bi_decoder;
>  	);
>  	/*
>  	 * Common set of CXL Device register block base pointers
> @@ -80,6 +84,8 @@ struct cxl_reg_map {
>  struct cxl_component_reg_map {
>  	struct cxl_reg_map hdm_decoder;
>  	struct cxl_reg_map ras;
> +	struct cxl_reg_map bi_rt;
> +	struct cxl_reg_map bi_decoder;
>  };
>  
>  struct cxl_device_reg_map {

