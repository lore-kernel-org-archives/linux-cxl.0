Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3C19258E;
	Fri, 12 Sep 2025 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720787; cv=none; b=DNNPnWkwvVxzsAYwVgiwRbE32kUDzZW3LazjSRM5PIgTeNgxUK/pt3zJafAmtBpiN0TZ9aUzJGB50OIF2Z36cufzvSWyqokrDScNvwlmsxPmpkzyA3lmT956g2D4HaARtKN7eBdgCwQjp2QC00vHDE3M7RYnYsSLNyn2LIfLgqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720787; c=relaxed/simple;
	bh=wikPThw2nfmYEsbCSrhTyxPQZOqpb06w4Hrw30fbMgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5RuIKzb72AEJH3EH59da3nIC5tNL671OcORwKAjVF/pCU5EObxdgKKtkIXnXxB4qj0cGiQlWGU4o1d1ShjtqGt/fI1rcfXiPcXLiJwzPgg3gxq9sM+UF5pJM+ozdPCfo7SBer0oby2VEguaQRLKP99ttKv0deEjSdU0/P5O/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kb/llxPA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kb/llxPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757720786; x=1789256786;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wikPThw2nfmYEsbCSrhTyxPQZOqpb06w4Hrw30fbMgg=;
  b=Kb/llxPAtU7WXFOde1er37uXw7dVzbMNHnFAVwVejanMlkgtn2mSFdpd
   kB3OATk2tc9A6QuvprZzsC1WZU4oGeMb15oziUTTBKkx9gsM5jUqfMdLA
   1ojDMy0+bHVsAOnJn/L/eUOeB/KyJ9qQ3EPprGp7jipB8UXtzfRdAit7N
   G0k1EkQVCf5v2zriaFLec7AbG9QKcr38BiwCPcfWgYRD24LwD067pggDU
   uPcgaJ4rWTtUhPEJc6NZxcpKHNGb5z33+wU4NTFLlByPhwcE0XuA9cmoP
   cIyp1lo82hNV8Y0VNykyEmO34FCQy1NOR3UKsM1ab/eETtr7+SgN2+1Gg
   w==;
X-CSE-ConnectionGUID: ypPb3lseSTuTaxiM2gXKxg==
X-CSE-MsgGUID: k5dpKgMJTiyFPkwfY2HLFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="63703744"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="63703744"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 16:46:25 -0700
X-CSE-ConnectionGUID: a3HiDbVmQpq35G3IG7+TUg==
X-CSE-MsgGUID: QbohwZbySYea/OsW4z33jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="174178774"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 16:46:24 -0700
Message-ID: <9982ec28-b3d8-44d2-be32-bab4b09a00d7@intel.com>
Date: Fri, 12 Sep 2025 16:46:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-12-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250912144514.526441-12-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/12/25 7:45 AM, Robert Richter wrote:
> Add AMD Zen5 support for address translation.
> 
> Zen5 systems may be configured to use 'Normalized addresses'. Then,
> CXL endpoints use their own physical address space and are programmed
> passthrough (DPA == HPA), the number of interleaving ways for the
> endpoint is set to one. The Host Physical Addresses (HPAs) need to be
> translated from the endpoint to its CXL host bridge. The HPA of a CXL
> host bridge is equivalent to the System Physical Address (SPA).
> 
> ACPI Platform Runtime Mechanism (PRM) is used to translate the CXL
> Device Physical Address (DPA) to its System Physical Address. This is
> documented in:
> 
>  AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
>  ACPI v6.5 Porting Guide, Publication # 58088
>  https://www.amd.com/en/search/documentation/hub.html
> 
> To implement AMD Zen5 address translation the following steps are
> needed:
> 
> AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
> call (Address Translation - CXL DPA to System Physical Address, see
> ACPI v6.5 Porting Guide above) when address translation is enabled.
> The existence of the callback can be identified using a specific GUID
> as documented. The initialization code checks firmware and kernel
> support of ACPI PRM.
> 
> Introduce a new file core/atl.c to handle ACPI PRM specific address
> translation code. Naming is loosely related to the kernel's AMD
> Address Translation Library (CONFIG_AMD_ATL) but implementation does
> not dependent on it, nor it is vendor specific. Use Kbuild and Kconfig
> options respectively to enable the code depending on architecture and
> platform options.
> 
> Implement an ACPI PRM firmware call for CXL address translation in the
> new function cxl_prm_to_hpa(). This includes sanity checks. Enable the
> callback for applicable CXL host bridges using the new cxl_atl_init()
> function.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

I'm still trying to digest the series. Couple things below.
 
> ---
>  drivers/cxl/Kconfig       |   4 ++
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/atl.c    | 138 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/core.h   |   1 +
>  drivers/cxl/core/port.c   |   8 +++
>  5 files changed, 152 insertions(+)
>  create mode 100644 drivers/cxl/core/atl.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..31f9c96ef908 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,8 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_ATL
> +       def_bool y
> +       depends on ACPI_PRMT
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 5ad8fef210b5..11fe272a6e29 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> +cxl_core-$(CONFIG_CXL_ATL) += atl.o
> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> new file mode 100644
> index 000000000000..5fc21eddaade
> --- /dev/null
> +++ b/drivers/cxl/core/atl.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/prmt.h>
> +#include <linux/pci.h>
> +
> +#include <cxlmem.h>
> +#include "core.h"
> +
> +static bool check_prm_address_translation(struct cxl_port *port)
> +{
> +	/* Applies to CXL host bridges only */
> +	return !is_cxl_root(port) && port->host_bridge &&
> +	       is_cxl_root(to_cxl_port(port->dev.parent));
> +}
> +
> +/*
> + * PRM Address Translation - CXL DPA to System Physical Address
> + *
> + * Reference:
> + *
> + * AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
> + * ACPI v6.5 Porting Guide, Publication # 58088
> + */
> +
> +static const guid_t prm_cxl_dpa_spa_guid =
> +	GUID_INIT(0xee41b397, 0x25d4, 0x452c, 0xad, 0x54, 0x48, 0xc6, 0xe3,
> +		  0x48, 0x0b, 0x94);
> +
> +struct prm_cxl_dpa_spa_data {
> +	u64 dpa;
> +	u8 reserved;
> +	u8 devfn;
> +	u8 bus;
> +	u8 segment;
> +	void *out;
> +} __packed;
> +
> +static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
> +{
> +	struct prm_cxl_dpa_spa_data data;
> +	u64 spa;
> +	int rc;
> +
> +	data = (struct prm_cxl_dpa_spa_data) {
> +		.dpa     = dpa,
> +		.devfn   = pci_dev->devfn,
> +		.bus     = pci_dev->bus->number,
> +		.segment = pci_domain_nr(pci_dev->bus),
> +		.out     = &spa,
> +	};
> +
> +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +	if (rc) {
> +		pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa, rc);
> +		return ULLONG_MAX;
> +	}
> +
> +	pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %#llx\n", dpa, spa);
> +
> +	return spa;
> +}
> +
> +static u64 cxl_prm_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> +{
> +	struct cxl_memdev *cxlmd;
> +	struct pci_dev *pci_dev;
> +	struct cxl_port *port;
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	/* Only translate from endpoint to its parent port. */
> +	if (!is_endpoint_decoder(&cxld->dev))
> +		return hpa;
> +
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +
> +	/*
> +	 * Nothing to do if base is non-zero and Normalized Addressing
> +	 * is disabled.
> +	 */

Not sure if this comment matches the code below
> +	if (cxld->hpa_range.start != cxled->dpa_res->start)
> +		return hpa;
> +
> +	/*
> +	 * Endpoints are programmed passthrough in Normalized
> +	 * Addressing mode.
> +	 */
Not sure if the comment here matches the conditional check.  
> +	if (cxld->interleave_ways != 1) {
> +		dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
> +			cxld->interleave_ways, cxld->interleave_granularity);
> +		return ULLONG_MAX;
> +	}
> +
> +	if (hpa < cxld->hpa_range.start || hpa > cxld->hpa_range.end) {
> +		dev_dbg(&cxld->dev, "hpa addr %#llx out of range %#llx-%#llx\n",

Suggest use %pr for range printing to avoid 0-day complaints on 32bit compilers.

> +			hpa, cxld->hpa_range.start, cxld->hpa_range.end);
> +		return ULLONG_MAX;
> +	}
> +
> +	port = to_cxl_port(cxld->dev.parent);
> +	cxlmd = port ? to_cxl_memdev(port->uport_dev) : NULL;
> +	if (!port || !dev_is_pci(cxlmd->dev.parent)) {
> +		dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
> +			dev_name(cxld->dev.parent), cxld->hpa_range.start,
> +			cxld->hpa_range.end);
> +		return ULLONG_MAX;
> +	}
> +	pci_dev = to_pci_dev(cxlmd->dev.parent);
> +
> +	return prm_cxl_dpa_spa(pci_dev, hpa);
> +}
> +
> +static void cxl_prm_init(struct cxl_port *port)
> +{
> +	u64 spa;
> +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> +	int rc;
> +
> +	if (!check_prm_address_translation(port))
> +		return;
> +
> +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> +		return;
> +
> +	port->to_hpa = cxl_prm_to_hpa;
> +
> +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> +		dev_name(&port->dev));
> +}
> +
> +void cxl_atl_init(struct cxl_port *port)
> +{
> +	cxl_prm_init(port);
> +}
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index eac8cc1bdaa0..624e438d052a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -150,6 +150,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +void cxl_atl_init(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8f36ff413f5d..8007e002888e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -831,6 +831,12 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  			    &cxl_einj_inject_fops);
>  }
>  
> +static void setup_address_translation(struct cxl_port *port)
> +{
> +	if (IS_ENABLED(CONFIG_CXL_ATL))
> +		cxl_atl_init(port);
> +}
> +
>  static int cxl_port_add(struct cxl_port *port,
>  			resource_size_t component_reg_phys,
>  			struct cxl_dport *parent_dport)
> @@ -868,6 +874,8 @@ static int cxl_port_add(struct cxl_port *port,
>  			return rc;
>  	}
>  
> +	setup_address_translation(port);

Given that the address translation callback only is needed for the host bridge, should this be called from acpi_probe() when the host bridge is being setup rather than going through every port add and checking if the port is a host bridge?

DJ

> +
>  	rc = device_add(dev);
>  	if (rc)
>  		return rc;

