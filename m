Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA2374A0F
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925037; cv=none; b=JFkVFi5szk8wbsvOH9qO1l5mOa7z8+bHAoptBz+d1JBlG6LbHIWei95xctSzT0nkrTRMTP8PNepvawhVgv4oJXgxJfiXPXrYhUBtLnCx11IAvKLh0AS0ODo5h7aps6vI1TnZLcZBt4sDMDk+L7vQ8EXthLEKgvxPpjmtAqaSFqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925037; c=relaxed/simple;
	bh=xDvX3mRIKsGpaWasEuR3UJ89Gp6pouhVS2pQ4w2HG1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A58rgeDUSEtST2xFCWAlhqb1u5XUXRSWr+Ut+/q9PVQXXt4L/GLJV881Lf9ymO2FWtgx3srbl+HonTy90YWQJzrHzU461SMWmEoNDJlKyM7ByV8lHQCk7x5DC82ZRmo/eQZdxiD8NmepIPDLahrlr62GXqT6yhrvy608iAmLPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPvLao5J; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPvLao5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782925036; x=1814461036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xDvX3mRIKsGpaWasEuR3UJ89Gp6pouhVS2pQ4w2HG1M=;
  b=VPvLao5J+66rqJNQvQv/qV808C8d5bEr2xFi3F3Yvo5fB3X3BFES2yo8
   iA5tfcskEiG23JLuzQOp79wgEd4B/w0igIVSDfpSuvlkgCMaVWpN40USa
   cujfYpoRpNumISvGH8KtL9O3gP4YqYEohk5ew6p2IWRjdLOoroooNTFHi
   3gKg7VX7vPLJtSTq9w5k8Lk0QvmJAbzdF9doE9zNiE/lZJ1yKkGbG6+5U
   W9iHrEUuki8jQOcb6izhOvu1KqmZKa56ea7tkcC9+didJ/4oBPHUcJcnO
   VXvrNUbQp5rpBmLSuL40h5l9l7uKZEo2Uqdu0HNsyuxL1kL6YK8ivz5FS
   Q==;
X-CSE-ConnectionGUID: dues3+FUQrG9JnnU6zsDbQ==
X-CSE-MsgGUID: EmEFM/PpRt6OyZdAoXJeNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83699508"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83699508"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 09:57:15 -0700
X-CSE-ConnectionGUID: RX6jxmiVSTij4dxKrjKKOA==
X-CSE-MsgGUID: sx6nNNcZTrOf+mYMetCfrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="276935415"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.66]) ([10.125.110.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 09:57:14 -0700
Message-ID: <92ecdf52-993a-45e0-9fb7-4606481c378d@intel.com>
Date: Wed, 1 Jul 2026 09:57:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] cxl: Add BI register probing and port
 initialization
To: Davidlohr Bueso <dave@stgolabs.net>, djbw@kernel.org
Cc: jic23@kernel.org, benjamin.cheatham@amd.com, icheng@nvidia.com,
 alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net,
 dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
References: <20260615145529.13848-1-dave@stgolabs.net>
 <20260615145529.13848-2-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260615145529.13848-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/15/26 7:55 AM, Davidlohr Bueso wrote:
> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and helpers to map them.
> 
> cxl_dport_map_bi() maps the BI Decoder of a downstream port (root
> port or switch DSP) at dport-creation time via cxl_port_add_dport();
> cxl_port_map_bi() maps a port's own BI capability during port probe
> when the upstream link is in 256B Flit operation -- BI Decoder for
> an endpoint, BI RT for a switch USP.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/regs.c | 14 ++++++++
>  drivers/cxl/cxl.h       |  6 ++++
>  drivers/cxl/port.c      | 71 +++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h       |  6 ++++
>  4 files changed, 97 insertions(+)
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

While we are here, do you mind adding a comment above for the defines and point to 8.2.4 Table 8-74 in r4.0? 

DJ

> +
> +/* CXL 4.0 8.2.4.26 / 8.2.4.27 BI Capability Structures */
> +#define CXL_BI_RT_CAPABILITY_LENGTH 0xC
> +#define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
>  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52f..ca8d8c14b787 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -58,6 +58,62 @@ static int discover_region(struct device *dev, void *unused)
>  	return 0;
>  }
>  
> +static void cxl_dport_map_bi(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (!map->component_map.bi_decoder.valid) {
> +		dev_dbg(dev, "BI Decoder registers not found\n");
> +		return;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER)))
> +		dev_dbg(dev, "Failed to map BI Decoder capability\n");
> +}
> +
> +static void cxl_port_map_bi(struct cxl_port *port)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +	struct cxl_dport *parent_dport = port->parent_dport;
> +	struct device *udev;
> +	int cap_id;
> +
> +	/* no upstream BI registers above host bridges or the cxl_root */
> +	if (!parent_dport || is_cxl_root(parent_dport->port))
> +		return;
> +
> +	udev = is_cxl_endpoint(port) ?
> +		port->uport_dev->parent : port->uport_dev;
> +	if (!dev_is_pci(udev))
> +		return;
> +
> +	/* BI requires 256B Flit on the upstream link */
> +	if (!cxl_pci_flit_256(to_pci_dev(udev)))
> +		return;
> +
> +	/* map this port's own BI capability */
> +	if (is_cxl_endpoint(port)) {
> +		if (!map->component_map.bi_decoder.valid) {
> +			dev_dbg(&port->dev, "BI Decoder registers not found\n");
> +			return;
> +		}
> +		cap_id = CXL_CM_CAP_CAP_ID_BI_DECODER;
> +	} else {
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
> @@ -128,6 +184,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);
>  
> +	cxl_port_map_bi(port);
> +
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> @@ -252,6 +310,8 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		 * on failure, or the device does not implement RAS registers.
>  		 */
>  		devm_cxl_port_ras_setup(port);
> +
> +		cxl_port_map_bi(port);
>  	}
>  
>  	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
> @@ -261,6 +321,17 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  	/* This group was only needed for early exit above */
>  	devres_remove_group(&port->dev, no_free_ptr(port_dr_group));
>  
> +	if (dev_is_pci(dport_dev)) {
> +		switch (pci_pcie_type(to_pci_dev(dport_dev))) {
> +		case PCI_EXP_TYPE_ROOT_PORT:
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			cxl_dport_map_bi(dport);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
>  	cxl_switch_parse_cdat(dport);
>  
>  	/* New dport added, update the decoder targets */
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

