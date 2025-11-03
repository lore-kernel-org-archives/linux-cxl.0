Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F9B663;
	Mon,  3 Nov 2025 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213388; cv=none; b=PO72JqfzMv7n+8iNz+5Rgw+6xE8hVI1RUnOmDMsEQaI5N+GV0sCTD4UcvCUQpXGx9wYXiDF+iLA5y22lIkkbvC+1hltIN6Qy2ai7SeWW2zkmo4DokIVrVzWQZ4mzkH8gtwT2jd+qzNcvHnMy+OUV4CEMEbmW5N3F/yLRjK+YMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213388; c=relaxed/simple;
	bh=nBO675swtX+p1Tfp1S8GGsPHZNky26PCAFnfcjgHGiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv3gGjeGKe8F0bfib6NRQCO9nNpBzYjJYkvzKtDB/YvpfdZih2uEuyDhl22+LNSXdEloSJzqNK7xrffY2cSRo3CBP0uXbAIPFzv0Wjtg5rXMNHbogjiDEWVc3x13ApHK59+O1zfPqGS38CLl2TbYXE8EW8M1EYx9l7DbUgtJ804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8CrIeLc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8CrIeLc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213388; x=1793749388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nBO675swtX+p1Tfp1S8GGsPHZNky26PCAFnfcjgHGiY=;
  b=g8CrIeLcvaSvIKtGiW3fY5OIdvUMIgHC+QjiErba9+CPqaKUMNpa9cXD
   dAji84Sibcf9fNazIwiYf94UUD1fTc+Q6axUTprzApQALf/rXDe3R8uDT
   6QdMU2szklmuigJZQDwd/wI1hy6mgMWW7bkvZ+NOyMO0GswRmkRRTgwqM
   q8uUjm2LKUlw42Dr17gSG/d9plv6IRJvGvn+B8tBWg6mNGbTSeZ+8XlGF
   WpecO9PCXr2U/IWogobr0+0GDWcJYoElaN3j27Fh6jv55wtnEombNy9Iu
   MWt23I2K2ROVKucXi1ZEWVxd9NFtxnNMPhJvqKtdACiG68N95qQgT1/G+
   g==;
X-CSE-ConnectionGUID: /yMHlAsHSZ+ewAZuOdXWpQ==
X-CSE-MsgGUID: iAyc165BRB2V3K05adlk6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64451404"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64451404"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:43:07 -0800
X-CSE-ConnectionGUID: fysLes59QF6Oifh4vgiYAA==
X-CSE-MsgGUID: iWJ3JR7LSZWZJbQnutCLHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186678470"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:43:05 -0800
Message-ID: <3b005a9a-3ce0-4fa0-80a9-8717d97338a4@intel.com>
Date: Mon, 3 Nov 2025 16:43:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/port: Remove devm_cxl_port_enumerate_dports()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250927100709.146507-1-ming.li@zohomail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250927100709.146507-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/25 3:07 AM, Li Ming wrote:
> devm_cxl_port_enumerate_dports() is not longer used after below commit
> commit 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> 
> Delete it and the relevant interface implemented in cxl_test.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to cxl/next
3f5b8f7f34f6d8e63c02d177341e43ebee4c2d36

> ---
> base-commit: 46037455cbb748c5e85071c95f2244e81986eb58 cxl/next
> ---
>  drivers/cxl/core/pci.c        | 87 ++++-------------------------------
>  drivers/cxl/cxlpci.h          |  1 -
>  tools/testing/cxl/Kbuild      |  1 -
>  tools/testing/cxl/test/cxl.c  | 32 -------------
>  tools/testing/cxl/test/mock.c | 15 ------
>  tools/testing/cxl/test/mock.h |  1 -
>  6 files changed, 8 insertions(+), 129 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 18825e1505d6..5b023a0178a4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -71,85 +71,6 @@ struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
>  
> -struct cxl_walk_context {
> -	struct pci_bus *bus;
> -	struct cxl_port *port;
> -	int type;
> -	int error;
> -	int count;
> -};
> -
> -static int match_add_dports(struct pci_dev *pdev, void *data)
> -{
> -	struct cxl_walk_context *ctx = data;
> -	struct cxl_port *port = ctx->port;
> -	int type = pci_pcie_type(pdev);
> -	struct cxl_register_map map;
> -	struct cxl_dport *dport;
> -	u32 lnkcap, port_num;
> -	int rc;
> -
> -	if (pdev->bus != ctx->bus)
> -		return 0;
> -	if (!pci_is_pcie(pdev))
> -		return 0;
> -	if (type != ctx->type)
> -		return 0;
> -	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> -				  &lnkcap))
> -		return 0;
> -
> -	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> -	if (rc)
> -		dev_dbg(&port->dev, "failed to find component registers\n");
> -
> -	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
> -	if (IS_ERR(dport)) {
> -		ctx->error = PTR_ERR(dport);
> -		return PTR_ERR(dport);
> -	}
> -	ctx->count++;
> -
> -	return 0;
> -}
> -
> -/**
> - * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
> - * @port: cxl_port whose ->uport_dev is the upstream of dports to be enumerated
> - *
> - * Returns a positive number of dports enumerated or a negative error
> - * code.
> - */
> -int devm_cxl_port_enumerate_dports(struct cxl_port *port)
> -{
> -	struct pci_bus *bus = cxl_port_to_pci_bus(port);
> -	struct cxl_walk_context ctx;
> -	int type;
> -
> -	if (!bus)
> -		return -ENXIO;
> -
> -	if (pci_is_root_bus(bus))
> -		type = PCI_EXP_TYPE_ROOT_PORT;
> -	else
> -		type = PCI_EXP_TYPE_DOWNSTREAM;
> -
> -	ctx = (struct cxl_walk_context) {
> -		.port = port,
> -		.bus = bus,
> -		.type = type,
> -	};
> -	pci_walk_bus(bus, match_add_dports, &ctx);
> -
> -	if (ctx.count == 0)
> -		return -ENODEV;
> -	if (ctx.error)
> -		return ctx.error;
> -	return ctx.count;
> -}
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, "CXL");
> -
>  static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -1217,6 +1138,14 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>  	return 0;
>  }
>  
> +struct cxl_walk_context {
> +	struct pci_bus *bus;
> +	struct cxl_port *port;
> +	int type;
> +	int error;
> +	int count;
> +};
> +
>  static int count_dports(struct pci_dev *pdev, void *data)
>  {
>  	struct cxl_walk_context *ctx = data;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 7ae621e618e7..1d526bea8431 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -127,7 +127,6 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>  	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>  }
>  
> -int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 0d5ce4b74b9f..3dae06ac7fba 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -4,7 +4,6 @@ ldflags-y += --wrap=is_acpi_device_node
>  ldflags-y += --wrap=acpi_evaluate_integer
>  ldflags-y += --wrap=acpi_pci_find_root
>  ldflags-y += --wrap=nvdimm_bus_register
> -ldflags-y += --wrap=devm_cxl_port_enumerate_dports
>  ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=devm_cxl_add_rch_dport
>  ldflags-y += --wrap=cxl_rcd_component_reg_phys
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 2d135ca533d0..10f9b83a9443 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -995,37 +995,6 @@ static int get_port_array(struct cxl_port *port,
>  	return 0;
>  }
>  
> -static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
> -{
> -	struct platform_device **array;
> -	int i, array_size;
> -	int rc;
> -
> -	rc = get_port_array(port, &array, &array_size);
> -	if (rc)
> -		return rc;
> -
> -	for (i = 0; i < array_size; i++) {
> -		struct platform_device *pdev = array[i];
> -		struct cxl_dport *dport;
> -
> -		if (pdev->dev.parent != port->uport_dev) {
> -			dev_dbg(&port->dev, "%s: mismatch parent %s\n",
> -				dev_name(port->uport_dev),
> -				dev_name(pdev->dev.parent));
> -			continue;
> -		}
> -
> -		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
> -					   CXL_RESOURCE_NONE);
> -
> -		if (IS_ERR(dport))
> -			return PTR_ERR(dport);
> -	}
> -
> -	return 0;
> -}
> -
>  static struct cxl_dport *mock_cxl_add_dport_by_dev(struct cxl_port *port,
>  						   struct device *dport_dev)
>  {
> @@ -1114,7 +1083,6 @@ static struct cxl_mock_ops cxl_mock_ops = {
>  	.acpi_pci_find_root = mock_acpi_pci_find_root,
>  	.devm_cxl_switch_port_decoders_setup = mock_cxl_switch_port_decoders_setup,
>  	.devm_cxl_endpoint_decoders_setup = mock_cxl_endpoint_decoders_setup,
> -	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
>  	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
>  	.devm_cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
>  	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 995269a75cbd..6fd4edb9215c 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -172,21 +172,6 @@ int __wrap_devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_endpoint_decoders_setup, "CXL");
>  
> -int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
> -{
> -	int rc, index;
> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> -
> -	if (ops && ops->is_mock_port(port->uport_dev))
> -		rc = ops->devm_cxl_port_enumerate_dports(port);
> -	else
> -		rc = devm_cxl_port_enumerate_dports(port);
> -	put_cxl_mock_ops(index);
> -
> -	return rc;
> -}
> -EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_enumerate_dports, "CXL");
> -
>  int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  {
>  	int rc, index;
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index 4ed932e76aae..580f38386224 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -19,7 +19,6 @@ struct cxl_mock_ops {
>  	bool (*is_mock_bus)(struct pci_bus *bus);
>  	bool (*is_mock_port)(struct device *dev);
>  	bool (*is_mock_dev)(struct device *dev);
> -	int (*devm_cxl_port_enumerate_dports)(struct cxl_port *port);
>  	int (*devm_cxl_switch_port_decoders_setup)(struct cxl_port *port);
>  	int (*devm_cxl_endpoint_decoders_setup)(struct cxl_port *port);
>  	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);

