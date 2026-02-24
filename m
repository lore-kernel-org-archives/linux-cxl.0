Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5BD23741
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892839; cv=none; b=ieqf5U6j6YJg3Q+9PJXRKdW8NbbDyLyVQ0BiSpQxBcvgexLIKnYCDdOzzkW9VwTQEJVycPr3RZ4bqpNmMNl3VTvJP1vmelsj5jlNAzFCBtdzaV3BZoWxYZO1gJ2YtG967EngBbGJIp8Ykl7NrrVDsv4FhPwQ+O3i8ZNx5pkuDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892839; c=relaxed/simple;
	bh=BlwPfAjqengIWtP5Rt9welh4i0kt4TM8iR7oweArZLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDtijIMz6iVQpsxsBMhi027e5vVEvnL6oz/ME9QA4lTDkzNTzhEICng5/zoh56r4erDWMNT4tv7Fu/uihABpD8MDVQrQikkeCE5EmrakWm41pBsa2WvWkMawmIAZ8RICqYYHfMGC+sQwJQKBB4l8CdHHqvtI2J9pA4NH4J5OQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njbUA0H8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njbUA0H8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771892838; x=1803428838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BlwPfAjqengIWtP5Rt9welh4i0kt4TM8iR7oweArZLk=;
  b=njbUA0H8fLToRfb4jrZdlKy9abtTs8tyLXlWFNw0eEOTGK6RF/hw6s3j
   LV9blFXSpsKM1MV2H76yJ2SS+11X4RGvlCexzGA/ueHP/RMcuHLe6eDr9
   f5tAG1t6wCf4KZARE7iZYzIJfSEwprb+oiiO4UDdugHQCcEo0+S6N18Zf
   GjGdulxF/C8u2sBDg5M7+EfmxV9IzAdLsKZTKympYGKDejDxke9FwLs4W
   GKx2IYzlTrFpT7ClXG30tn5sh11gJnziUFZVr4d0B0wpPxtbJVa0Y1NcV
   1P8q4lKVxA/uGpHzbI1dEfR+Svhy6dp+CBz2bdT5QzLbhtgAvRaFEDF3s
   A==;
X-CSE-ConnectionGUID: RdKg3lz/QgGTqarxtdVsdw==
X-CSE-MsgGUID: /1XELwGXRyGL5vaxtEtwnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76512763"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="76512763"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:27:18 -0800
X-CSE-ConnectionGUID: HOGYfdbbSJ+em5ekmlPJlg==
X-CSE-MsgGUID: AEpJsoWCSPWdv7xgEj/jXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213066971"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:27:17 -0800
Message-ID: <a746a3f9-3b1f-4d62-976e-ab0a9dd745d8@intel.com>
Date: Mon, 23 Feb 2026 17:27:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] cxl: Move pci generic code
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
 <20260223142633.2994082-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260223142633.2994082-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/26 7:26 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci_drv.c implements the functionality for a Type3 device
> initialization.
> 
> In preparation for type2 support, move helper functions from cxl/pci.c to
> cxl/core/pci.c in order to be exported and used by type2 drivers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/core.h |  2 ++
>  drivers/cxl/core/pci.c  | 62 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c |  1 -
>  drivers/cxl/cxl.h       |  2 --
>  drivers/cxl/cxlpci.h    | 13 ++++++++
>  drivers/cxl/pci.c       | 70 -----------------------------------------
>  6 files changed, 77 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 007b8aff0238..19494a8615d3 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -206,4 +206,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> +					   struct cxl_dport *dport);
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f96ce884a213..c32cc62c501d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -696,6 +696,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>  
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  struct cxl_register_map *map,
> +				  struct cxl_dport *dport)
> +{
> +	resource_size_t component_reg_phys;
> +
> +	*map = (struct cxl_register_map) {
> +		.host = &pdev->dev,
> +		.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map)
> +{
> +	int rc;
> +
> +	rc = cxl_find_regblock(pdev, type, map);
> +
> +	/*
> +	 * If the Register Locator DVSEC does not exist, check if it
> +	 * is an RCH and try to extract the Component Registers from
> +	 * an RCRB.
> +	 */
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) =
> +			cxl_pci_find_port(pdev, &dport);
> +		if (!port)
> +			return -EPROBE_DEFER;
> +
> +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> +		if (rc)
> +			return rc;
> +
> +	} else if (rc) {
> +		return rc;
> +	}
> +
> +	return cxl_setup_regs(map);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
> +
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
>  	int speed, bw;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index a010b3214342..93710cf4f0a6 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  		return CXL_RESOURCE_NONE;
>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0d350b69f1c8..031846eab02c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
>  int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
> -resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
> -					   struct cxl_dport *dport);
>  int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0cf64218aa16..b826eb53cf7b 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>  	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>  }
>  
> +/*
> + * Assume that the caller has already validated that @pdev has CXL
> + * capabilities, any RCiEP with CXL capabilities is treated as a
> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
> + * registers in a Root Complex Register Block (RCRB).
> + */
> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}
> +
>  struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
>  
> @@ -101,4 +112,6 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  #endif
>  
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a42f273ff72b..adc7c4bcb03a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -465,76 +465,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  	return 0;
>  }
>  
> -/*
> - * Assume that any RCIEP that emits the CXL memory expander class code
> - * is an RCD
> - */
> -static bool is_cxl_restricted(struct pci_dev *pdev)
> -{
> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> -}
> -
> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> -				  struct cxl_register_map *map,
> -				  struct cxl_dport *dport)
> -{
> -	resource_size_t component_reg_phys;
> -
> -	*map = (struct cxl_register_map) {
> -		.host = &pdev->dev,
> -		.resource = CXL_RESOURCE_NONE,
> -	};
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> -	if (component_reg_phys == CXL_RESOURCE_NONE)
> -		return -ENXIO;
> -
> -	map->resource = component_reg_phys;
> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> -
> -	return 0;
> -}
> -
> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map)
> -{
> -	int rc;
> -
> -	rc = cxl_find_regblock(pdev, type, map);
> -
> -	/*
> -	 * If the Register Locator DVSEC does not exist, check if it
> -	 * is an RCH and try to extract the Component Registers from
> -	 * an RCRB.
> -	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> -		struct cxl_dport *dport;
> -		struct cxl_port *port __free(put_cxl_port) =
> -			cxl_pci_find_port(pdev, &dport);
> -		if (!port)
> -			return -EPROBE_DEFER;
> -
> -		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> -		if (rc)
> -			return rc;
> -
> -		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> -		if (rc)
> -			return rc;
> -
> -	} else if (rc) {
> -		return rc;
> -	}
> -
> -	return cxl_setup_regs(map);
> -}
> -
>  static void free_event_buf(void *buf)
>  {
>  	kvfree(buf);

