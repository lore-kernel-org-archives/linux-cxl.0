Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08233A95E;
	Tue,  4 Nov 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218012; cv=none; b=OrLQYdf3pOsgBtPoorij/DQQmXq+RrwD2+yfiNJien59SEpjikMLPBlArrfSzI7L5e99vHD6sq9tWQ+GL9wfqtacKbfqNR46lJST9nmB3kUHG+AafWg/Ejdx5N1fXJf9qGgJTs6JGVjJoGD1uCNA90gT4IAf51+Uez4/EBDLraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218012; c=relaxed/simple;
	bh=Xr+fyAfvLq6ALEQtjIKWn7BTLqTCF5SxS34QhEfHc9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnXUebJsem0uUZDHvxL5KYsFARRA5GMw6omDNVXA6ttLPRR+KoqFU8jK7P0p8LBvBqqB+HWHWl7duOwi8JeKbcMAkCGYH1w7ZRmokvd+q2vpR0uXLQF3nTjtqogKwouY3+GdCjQggK42veDTes5yCjSLpcjBhGa3PlCXkVF6V1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSFV8TPJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSFV8TPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762218011; x=1793754011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xr+fyAfvLq6ALEQtjIKWn7BTLqTCF5SxS34QhEfHc9M=;
  b=GSFV8TPJBIaAYyYksr0fFEgUU0JLtHZIJWQqULfQXYc0pUfO7FY5cta+
   avqhwseYozoB4GmbqgdT4T9ovy2UOC+ZiVNWI7nTtc9Y8gaHI06QQKzHO
   KA81emnNtK8879RlBdxSkU9Av3gSUPQH+qZGwBw9rg2wMXBreYErez98k
   kaIZWLXn9ESB40+AORS3xAU2cb+jzRdoo0AD/fm+hToSjMhSDWUUGNUpq
   Un29V4CnBxQtEMH5IVzPbLj8MErfGYhqjFxVnPY6gCZas77UXsUu+xccS
   cZ2MalLapeOWnUPit56XhMrEUDLaP9KcxEUBg3cLuZYlT2i6T59UrUULW
   A==;
X-CSE-ConnectionGUID: HeyuPh33QiylscyosyLOSw==
X-CSE-MsgGUID: rpJ/QVCRTk+Meh4o0zGESg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75754905"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75754905"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:00:10 -0800
X-CSE-ConnectionGUID: oD9QD8CESwm6KC+TyNdanA==
X-CSE-MsgGUID: YUSJxwCRT0+9aeLucL0Q/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186693544"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:00:09 -0800
Message-ID: <d752b9b3-c032-41c5-b10f-48b711a54eee@intel.com>
Date: Mon, 3 Nov 2025 18:00:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using
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
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-11-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251103184804.509762-11-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/3/25 11:47 AM, Robert Richter wrote:
> Add AMD Zen5 support for address translation.
> 
> Zen5 systems may be configured to use 'Normalized addresses'. Then,
> host physical addresses (HPA) are different from their system physical
> addresses (SPA). The endpoint has its own physical address space and
> an incoming HPA is already converted to the device's physical address
> (DPA). Thus it has interleaving disabled and CXL endpoints are
> programmed passthrough (DPA == HPA).
> 
> Host Physical Addresses (HPAs) need to be translated from the endpoint
> to its CXL host bridge, esp. to identify the endpoint's root decoder
> and region's address range. ACPI Platform Runtime Mechanism (PRM)
> provides a handler to translate the DPA to its SPA. This is documented
> in:
> 
>  AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
>  ACPI v6.5 Porting Guide, Publication # 58088
>  https://www.amd.com/en/search/documentation/hub.html
> 
> With Normalized Addressing this PRM handler must be used to translate
> an HPA of an endpoint to its SPA.
> 
> Do the following to implement AMD Zen5 address translation:
> 
> Introduce a new file core/atl.c to handle ACPI PRM specific address
> translation code. Naming is loosely related to the kernel's AMD
> Address Translation Library (CONFIG_AMD_ATL) but implementation does
> not depend on it, nor it is vendor specific. Use Kbuild and Kconfig
> options respectively to enable the code depending on architecture and
> platform options.
> 
> AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
> call (see ACPI v6.5 Porting Guide, Address Translation - CXL DPA to
> System Physical Address). Firmware enables the PRM handler if the
> platform has address translation implemented. Check firmware and
> kernel support of ACPI PRM using the specific GUID. On success enable
> address translation by setting up the earlier introduced root port
> callback, see function cxl_prm_translate_hpa_range(). Setup is done in
> cxl_setup_prm_address_translation(), it is the only function that
> needs to be exported. For low level PRM firmware calls, use the ACPI
> framework.
> 
> Identify the region's interleaving ways by inspecting the address
> ranges. Also determine the interleaving granularity using the address
> translation callback. Note that the position of the chunk from one
> interleaving block to the next may vary and thus cannot be considered
> constant. Address offsets larger than the interleaving block size
> cannot be used to calculate the granularity. Thus, probe the
> granularity using address translation for various HPAs in the same
> interleaving block.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Just a small thing below, otherwise:
Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/acpi.c        |   2 +
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/atl.c    | 195 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   7 ++
>  5 files changed, 209 insertions(+)
>  create mode 100644 drivers/cxl/core/atl.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..e599badba69b 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,8 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_ATL
> +       def_bool y
> +       depends on ACPI_PRMT && AMD_NB
> +
>  endif
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index a54d56376787..f9bbc77f3ec2 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -916,6 +916,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	cxl_root->ops.qos_class = cxl_acpi_qos_class;
>  	root_port = &cxl_root->port;
>  
> +	cxl_setup_prm_address_translation(cxl_root);
> +
>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>  			      add_host_bridge_dport);
>  	if (rc < 0)
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
> index 000000000000..d6aa7e6d0ac5
> --- /dev/null
> +++ b/drivers/cxl/core/atl.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/prmt.h>
> +#include <linux/pci.h>
> +#include <linux/acpi.h>
> +
> +#include <cxlmem.h>
> +#include "core.h"
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
> +	u64 *spa;
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
> +		.spa     = &spa,
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
> +static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
> +{
> +	struct cxl_region_context *ctx = data;
> +	struct cxl_endpoint_decoder *cxled = ctx->cxled;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct cxl_memdev *cxlmd = ctx->cxlmd;
> +	struct range hpa_range = ctx->hpa_range;
> +	struct pci_dev *pci_dev;
> +	u64 spa_len, len = range_len(&hpa_range);
> +	u64 addr, base_spa, base = hpa_range.start;
> +	int ways, gran;
> +
> +	/*
> +	 * When Normalized Addressing is enabled, the endpoint
> +	 * maintains a 1:1 mapping between HPA and DPA. If disabled,
> +	 * skip address translation and perform only a range check.
> +	 */
> +	if (hpa_range.start != cxled->dpa_res->start)
> +		return 0;
> +
> +	if (!IS_ALIGNED(hpa_range.start, SZ_256M) ||
> +	    !IS_ALIGNED(hpa_range.end + 1, SZ_256M)) {
> +		dev_dbg(cxld->dev.parent,
> +			"CXL address translation: Unaligned decoder HPA range: %#llx-%#llx(%s)\n",
> +			hpa_range.start, hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Endpoints are programmed passthrough in Normalized
> +	 * Addressing mode.
> +	 */
> +	if (ctx->interleave_ways != 1) {
> +		dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
> +			ctx->interleave_ways, ctx->interleave_granularity);
> +		return -ENXIO;
> +	}
> +
> +	if (!cxlmd || !dev_is_pci(cxlmd->dev.parent)) {
> +		dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
> +			dev_name(cxld->dev.parent), hpa_range.start,
> +			hpa_range.end);
> +		return -ENXIO;
> +	}
> +
> +	pci_dev = to_pci_dev(cxlmd->dev.parent);
> +
> +	/* Translate HPA range to SPA. */
> +	hpa_range.start = base_spa = prm_cxl_dpa_spa(pci_dev, hpa_range.start);
> +	hpa_range.end = prm_cxl_dpa_spa(pci_dev, hpa_range.end);
> +
> +	if (hpa_range.start == ULLONG_MAX || hpa_range.end == ULLONG_MAX) {
> +		dev_dbg(cxld->dev.parent,
> +			"CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
> +			ctx->hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Since translated addresses include the interleaving
> +	 * offsets, align the range to 256 MB.
> +	 */
> +	hpa_range.start = ALIGN_DOWN(hpa_range.start, SZ_256M);
> +	hpa_range.end = ALIGN(hpa_range.end, SZ_256M) - 1;
> +
> +	spa_len = range_len(&hpa_range);
> +	if (!len || !spa_len || spa_len % len) {
> +		dev_dbg(cxld->dev.parent,
> +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
> +			ctx->hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	ways = spa_len / len;
> +	gran = SZ_256;

maybe init 'base' and 'base_hpa' here. Makes it easier to recall rather than having to go up to recall what it was.> +
> +	/*
> +	 * Determine interleave granularity
> +	 *
> +	 * Note: The position of the chunk from one interleaving block
> +	 * to the next may vary and thus cannot be considered
> +	 * constant. Address offsets larger than the interleaving
> +	 * block size cannot be used to calculate the granularity.
> +	 */
> +	while (ways > 1 && gran <= SZ_16M) {
> +		addr = prm_cxl_dpa_spa(pci_dev, base + gran);
> +		if (addr != base_spa + gran)
> +			break;
> +		gran <<= 1;
> +	}
> +
> +	if (gran > SZ_16M) {
> +		dev_dbg(cxld->dev.parent,
> +			"CXL address translation: Cannot determine granularity: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
> +			ctx->hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	ctx->hpa_range = hpa_range;
> +	ctx->interleave_ways = ways;
> +	ctx->interleave_granularity = gran;
> +
> +	dev_dbg(&cxld->dev,
> +		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
> +		dev_name(ctx->cxlmd->dev.parent), base, len, hpa_range.start,
> +		spa_len, ways, gran);
> +
> +	return 0;
> +}
> +
> +void cxl_setup_prm_address_translation(struct cxl_root *cxl_root)
> +{
> +	struct device *host = cxl_root->port.uport_dev;
> +	u64 spa;
> +	struct prm_cxl_dpa_spa_data data = { .spa = &spa, };
> +	int rc;
> +
> +	/*
> +	 * Applies only to PCIe Host Bridges which are children of the
> +	 * CXL Root Device (HID=“ACPI0017”). Check this and drop
> +	 * cxl_test instances.
> +	 */
> +	if (!acpi_match_device(host->driver->acpi_match_table, host))
> +		return;
> +
> +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> +		return;
> +
> +	cxl_root->ops.translate_hpa_range = cxl_prm_translate_hpa_range;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_setup_prm_address_translation, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 94b9fcc07469..0af46d1b0abc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -790,6 +790,13 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>  						struct device *host) { }
>  #endif
>  
> +#ifdef CONFIG_CXL_ATL
> +void cxl_setup_prm_address_translation(struct cxl_root *cxl_root);
> +#else
> +static inline
> +void cxl_setup_prm_address_translation(struct cxl_root *cxl_root) {}
> +#endif
> +
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);

