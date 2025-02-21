Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041A2AE8E;
	Fri, 21 Feb 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098429; cv=none; b=jir4ATZ9YY5U89iytlU4wHPE1PwDrGDRhB6zWHhsqqxWuGkILWyR3wx+2Ckue3blVlPDYw7zYkZbRfY4FUhKwSVGvoVKAPPyJQEOTZIDPrRQcfxvyJh3tiCX4SjSJjhS6rU7HsLNocQdRjOgdgbsbrWX0Nr2nOTWQwrgSvPeNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098429; c=relaxed/simple;
	bh=33BgvPZAiafePkil4ejP9WWjA02TZ/LaIn8LMxbUI2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CK/WNd1aGi2PI9zxz6VMFJYo5mH2xjq44KNzLNBtwkNAh0n9ke1XPLzeGenkwPz0C4YPEDl63G2V3vvRFoSq/ruEJt/o4e4++EObjYCWFURN3FjCSFb6Xjonq8zNGmda3WNXBABlQ3nSKp68MRlRN/p0f587yBmcVBr2ZAFera4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJGEpcHa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJGEpcHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740098428; x=1771634428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=33BgvPZAiafePkil4ejP9WWjA02TZ/LaIn8LMxbUI2o=;
  b=iJGEpcHapTSEJbVKoB4XEs4VMMIe0NsjveHno6vQJzvnT6EtMdCJj9MM
   tXua9g5kDpa52EKM02A3J6+jmOIUiI+KGw1TUUOAXeMCljEKGSw0benhr
   C7iLHYAb9h+oRNevbEkRrpVTLZNcTCii/RAgZ0Im8av4YgkorpcpL1Pod
   zKIl5VwYHnBlFLG+AcWFGgxyl2vaCXsPGl7A2pqzT1XbtgmQIvVhFUL85
   WpzUOd3dn7b+XNs5jLjv/yl3BmaZq5tEkyYqoIyGgSgetquK5gq3l4xKv
   kRr3eL92icFeMuqNuW776J+x5Fe7An57OfnAxZhYWA1GQWKc4+Y/IjmVn
   g==;
X-CSE-ConnectionGUID: OlbtfrcmQNeCz6corqwHpg==
X-CSE-MsgGUID: 8tEBMFu8RZyOrIUP3t4DHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41113303"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41113303"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 16:40:27 -0800
X-CSE-ConnectionGUID: Udb3dOjcQvGSO5paC17IJg==
X-CSE-MsgGUID: F3aEuEYMShKu/+AXBF6F0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152401595"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 16:40:24 -0800
Message-ID: <a127127a-b8ea-4390-b8e9-d3ad0bcc311e@intel.com>
Date: Thu, 20 Feb 2025 17:40:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-15-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250218132356.1809075-15-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/18/25 6:23 AM, Robert Richter wrote:
> Add AMD platform specific Zen5 support for address translation.
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
> Apply platform specific changes to each port where necessary using
> platform detection and the existing architectural framework.
> 
> Add a function cxl_port_setup_amd() to implement AMD platform specific
> code. Use Kbuild and Kconfig options respectively to enable the code
> depending on architecture and platform options. Handle architecture
> specifics in arch_cxl_port_platform_setup() and create a new file
> core/x86/amd.c for this.
> 
> Introduce a function cxl_zen5_init() to handle Zen5 specific
> enablement. Zen5 platforms are detected using the PCIe vendor and
> device ID of the corresponding CXL root port. There is a check for
> ACPI PRMT CXL address translation support.
> 
> Apply cxl_zen5_to_hpa() as cxl_port->to_hpa() callback to Zen5 CXL
> host bridges to enable platform specific address translation.
> 
> Use ACPI PRM DPA-to-SPA translation to determine an endpoint's
> interleaving configuration and base address during the early
> initialization process. This is used to determine an endpoint's SPA
> range and to check the address translation setup.
> 
> The configuration can be determined calling the PRM for specific HPAs
> given. The resulting SPAs are used to calculate interleaving
> parameters of the host bridge and root port. The maximum granularity
> (chunk size) is 16k, minimum is 256. Use the following calculation for
> the given HPAs:
> 
>  ways    = hpa_len(SZ_16K) / SZ_16K
>  gran    = (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
>           / (ways - 1)
>  pos     = (hpa_len(SZ_16K) - ways * SZ_16K) / gran
> 
> Before the endpoint is attached to a region the translation is checked
> for reasonable values.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

What is the possibilty of making this ACPI PRM call interface public and teach drivers/cxl/acpi.c to make it common code? That way if the platform implements the ACPI call then the translation gets registered and we don't need to have platform specific code. Really would like to avoid drivers/cxl/core/$arch if that's possible. 

DJ

> ---
>  drivers/cxl/Kconfig           |   4 +
>  drivers/cxl/core/Makefile     |   1 +
>  drivers/cxl/core/core.h       |   3 +
>  drivers/cxl/core/region.c     |  25 +++-
>  drivers/cxl/core/x86/amd.c    | 259 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/x86/common.c |   2 +
>  6 files changed, 293 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cxl/core/x86/amd.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 876469e23f7a..e576028dd983 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -146,4 +146,8 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_AMD
> +       def_bool y
> +       depends on AMD_NB
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index db1d16d39037..cfe41b8edfd3 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -18,3 +18,4 @@ cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  
>  cxl_core-$(CONFIG_X86)		+= x86/common.o
> +cxl_core-$(CONFIG_CXL_AMD)	+= x86/amd.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index e2955f91fd98..d5c94e8cea42 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -119,5 +119,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  
>  int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
>  void arch_cxl_port_platform_setup(struct cxl_port *port);
> +#if defined(CONFIG_X86)
> +void cxl_port_setup_amd(struct cxl_port *port);
> +#endif
>  
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dab059ee26ef..b6806e67c62a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -837,10 +837,24 @@ static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
>  {
>  	struct range hpa = *hpa_range;
>  	u64 len = range_len(&hpa);
> +	int bits;
>  
>  	if (!port->to_hpa)
>  		return 0;
>  
> +	/*
> +	 * Check range and length alignment of 256 MB for the
> +	 * interleaved address range. With max. 16-way interleaving
> +	 * applied this is at least 16 KB.
> +	 */
> +
> +	if (!len || hpa_range->start & (SZ_16K - 1) || len & (SZ_16K - 1)) {
> +		dev_warn(&port->dev,
> +			"HPA range not aligned or multiple of 16 kB: %#llx-%#llx(%s)\n",
> +			hpa_range->start, hpa_range->end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
>  	/* Translate HPA to the next upper domain. */
>  	hpa.start = port->to_hpa(cxld, hpa.start);
>  	hpa.end = port->to_hpa(cxld, hpa.end);
> @@ -853,7 +867,16 @@ static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
>  		return -ENXIO;
>  	}
>  
> -	if (range_len(&hpa) != len * cxld->interleave_ways) {
> +	/*
> +	 *  Apply min and max interleaving addresses to the range.
> +	 *  Determine the interleave ways and expand the 16 KB range
> +	 *  by the power-of-2 part it.
> +	 */
> +	bits = range_len(&hpa) > len ? __ffs(range_len(&hpa) / len) : 0;
> +	hpa.start &= ~((SZ_16K << bits) - 1);
> +	hpa.end |= (SZ_16K << bits) - 1;
> +
> +	if (range_len(&hpa) % len) {
>  		dev_warn(&port->dev,
>  			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
>  			hpa.start, hpa.end, hpa_range->start,
> diff --git a/drivers/cxl/core/x86/amd.c b/drivers/cxl/core/x86/amd.c
> new file mode 100644
> index 000000000000..483c92c18054
> --- /dev/null
> +++ b/drivers/cxl/core/x86/amd.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/prmt.h>
> +#include <linux/pci.h>
> +
> +#include <cxlmem.h>
> +#include "../core.h"
> +
> +#define PCI_DEVICE_ID_AMD_ZEN5_ROOT		0x153e
> +
> +static const struct pci_device_id zen5_root_port_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ZEN5_ROOT) },
> +	{},
> +};
> +
> +static int is_zen5_root_port(struct device *dev, void *unused)
> +{
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
> +	return !!pci_match_id(zen5_root_port_ids, to_pci_dev(dev));
> +}
> +
> +static bool is_zen5(struct cxl_port *port)
> +{
> +	if (!IS_ENABLED(CONFIG_ACPI_PRMT))
> +		return false;
> +
> +	/* To get the CXL root port, find the CXL host bridge first. */
> +	if (is_cxl_root(port) ||
> +	    !port->host_bridge ||
> +	    !is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return false;
> +
> +	return !!device_for_each_child(port->host_bridge, NULL,
> +				       is_zen5_root_port);
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
> +/* Bits used for interleaving. */
> +#define SPA_INTERLEAVING_BITS	GENMASK_ULL(14, 8)
> +
> +static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> +{
> +	struct cxl_memdev *cxlmd;
> +	struct pci_dev *pci_dev;
> +	struct cxl_port *port;
> +	u64 base, spa, spa2, len, len2, offset, granularity, gran_mask;
> +	int ways, pos, ways_bits, gran_bits;
> +
> +	/*
> +	 * Nothing to do if base is non-zero and Normalized Addressing
> +	 * is disabled.
> +	 */
> +	if (cxld->hpa_range.start)
> +		return hpa;
> +
> +	/* Only translate from endpoint to its parent port. */
> +	if (!is_endpoint_decoder(&cxld->dev))
> +		return hpa;
> +
> +	/*
> +	 * Endpoints are programmed passthrough in Normalized
> +	 * Addressing mode.
> +	 */
> +	if (cxld->interleave_ways != 1) {
> +		dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
> +			cxld->interleave_ways, cxld->interleave_granularity);
> +		return ULLONG_MAX;
> +	}
> +
> +	if (hpa > cxld->hpa_range.end) {
> +		dev_dbg(&cxld->dev, "hpa addr %#llx out of range %#llx-%#llx\n",
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
> +	/*
> +	 * If the decoder is already attached we are past the decoder
> +	 * initialization, do not determine the address mapping and
> +	 * just return here.
> +	 */
> +	if (cxld->region)
> +		return prm_cxl_dpa_spa(pci_dev, hpa);
> +
> +	/*
> +	 * Determine the interleaving config. Maximum granularity
> +	 * (chunk size) is 16k, minimum is 256. Calculated with:
> +	 *
> +	 *	ways	= hpa_len(SZ_16K) / SZ_16K
> +	 * 	gran	= (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
> +	 *                / (ways - 1)
> +	 *	pos	= (hpa_len(SZ_16K) - ways * SZ_16K) / gran
> +	 */
> +
> +	base = prm_cxl_dpa_spa(pci_dev, 0);
> +	spa  = prm_cxl_dpa_spa(pci_dev, SZ_16K);
> +	spa2 = prm_cxl_dpa_spa(pci_dev, SZ_16K - SZ_256);
> +
> +	/* Includes checks to avoid div by zero */
> +	if (!base || base == ULLONG_MAX || spa == ULLONG_MAX ||
> +	    spa2 == ULLONG_MAX || spa < base + SZ_16K || spa2 <= base ||
> +	    (spa > base + SZ_16K && spa - spa2 < SZ_256 * 2)) {
> +		dev_dbg(&cxld->dev, "Error translating HPA: base: %#llx spa: %#llx spa2: %#llx\n",
> +			base, spa, spa2);
> +		return ULLONG_MAX;
> +	}
> +
> +	len = spa - base;
> +	len2 = spa2 - base;
> +
> +	/* offset = pos * granularity */
> +	if (len == SZ_16K && len2 == SZ_16K - SZ_256) {
> +		ways = 1;
> +		offset = 0;
> +		granularity = SZ_256;
> +		pos = 0;
> +		ways_bits = 0;
> +		gran_bits = 8;
> +	} else {
> +		ways = len / SZ_16K;
> +		offset = spa & (SZ_16K - 1);
> +		granularity = (len - len2 - SZ_256) / (ways - 1);
> +		ways_bits = __ffs(ways);
> +		gran_bits = __ffs(granularity);
> +		pos = offset >> gran_bits;
> +	}
> +
> +	/*
> +	 * Check the mapping: Number of ways is power of 2 or a
> +	 * multiple of 3 ways (len == ways * SZ_16K), granularitys is
> +	 * power of 2.
> +	 */
> +	if (len & ~(3ULL << (ways_bits + 14)) ||
> +	    granularity != 1 << gran_bits || offset != pos << gran_bits) {
> +		dev_dbg(&cxld->dev, "Error determining address mapping: base: %#llx spa: %#llx spa2: %#llx ways: %d pos: %d granularity: %llu\n",
> +			base, spa, spa2, ways, pos, granularity);
> +		return ULLONG_MAX;
> +	}
> +
> +	spa = prm_cxl_dpa_spa(pci_dev, hpa);
> +
> +	/*
> +	 * Check SPA using a PRM call for the closest DPA calculated
> +	 * for the HPA. If the HPA matches a different interleaving
> +	 * position other than the decoder's, determine its offset to
> +	 * adjust the SPA.
> +	 */
> +
> +	gran_mask = GENMASK_ULL(gran_bits, 0);
> +	spa2 = base + (hpa & ~gran_mask) * ways + (hpa & gran_mask);
> +	base = base - pos * granularity;
> +
> +	dev_dbg(&cxld->dev,
> +		"address mapping found for %s (hpa -> spa): %#llx -> %#llx (%#llx+%#llx) ways: %d pos: %d granularity: %llu\n",
> +		pci_name(pci_dev), hpa, spa, base, spa - base, ways, pos,
> +		granularity);
> +
> +
> +	if ((spa ^ spa2) & ~SPA_INTERLEAVING_BITS) {
> +		dev_dbg(&cxld->dev, "SPA calculation failed: %#llx:%#llx\n",
> +			spa, spa2);
> +		return ULLONG_MAX;
> +	}
> +
> +	return spa;
> +}
> +
> +static void cxl_zen5_init(struct cxl_port *port)
> +{
> +	u64 spa;
> +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> +	int rc;
> +
> +	if (!is_zen5(port))
> +		return;
> +
> +	/* Check kernel and firmware support */
> +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +
> +	if (rc == -EOPNOTSUPP) {
> +		pr_warn_once("ACPI PRMT: PRM address translation not supported by kernel\n");
> +		return;
> +	}
> +
> +	if (rc == -ENODEV) {
> +		pr_warn_once("ACPI PRMT: PRM address translation not supported by firmware\n");
> +		return;
> +	}
> +
> +	port->to_hpa = cxl_zen5_to_hpa;
> +
> +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> +		dev_name(&port->dev));
> +}
> +
> +void cxl_port_setup_amd(struct cxl_port *port)
> +{
> +	cxl_zen5_init(port);
> +}
> diff --git a/drivers/cxl/core/x86/common.c b/drivers/cxl/core/x86/common.c
> index eeb9bdadb26d..7ccd68b035e6 100644
> --- a/drivers/cxl/core/x86/common.c
> +++ b/drivers/cxl/core/x86/common.c
> @@ -9,4 +9,6 @@
>  
>  void arch_cxl_port_platform_setup(struct cxl_port *port)
>  {
> +	if (IS_ENABLED(CONFIG_CXL_AMD))
> +		cxl_port_setup_amd(port);
>  }

