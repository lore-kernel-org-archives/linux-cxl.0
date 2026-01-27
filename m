Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6E191484;
	Tue, 27 Jan 2026 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537514; cv=none; b=geOGr/XZikbqLlwlktUjMxR3El0MXjqp1UIc5zyAIFuLeS3lixy6IDDctsVasMpoH20QrK8/gVEnMpKGtjrxE3kTp0mOp/sLUTPoBH4uYspwxMIT0PQRhvQ+AR0e+cZ+fik2X8XNhz4dgIqWeqBHuyZKHIQsO2kyO2639x3pSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537514; c=relaxed/simple;
	bh=yw5b0hqZf0UxsEDqwSLQsTvU22wBOcGqrncsJACvPdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmUX2TZMm07TCCWyvzkYUCddf6P6x+dJs0W2JuT9/UGebYtMVZMlEEBcxw2B9eGX8xvoyGqhK37/tku3Hy+BvoqMk1ZABf/7ZQOwNUuZAlP1pEudNIhTMd6KKVp0S7gNU8CAOT3BXy2g77sGUUVfzU0EzO/Tq2BEy8mekK+hrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRf9TtDP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRf9TtDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769537512; x=1801073512;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yw5b0hqZf0UxsEDqwSLQsTvU22wBOcGqrncsJACvPdY=;
  b=ZRf9TtDP8lb6b8YgszpYqFaQOYlKJgmoolN7MMYhsi43e79M4TWVvBpM
   WcHFFKulBtbrO3yaZoIwRbbBu9TJ/iW9Z87toU4hCZQapTcHJjmlUnMat
   s5yfbWw1JIRZnZvcKeZDnQLnjjs/NhVptziLkSMnd4fD+5/mV86X9RaJb
   XhE3dunELp0G2byKouSCcWpAICVks1hftC8mdHb++9XFo8MLdC0arbrGt
   MiX9Y7sSgEfV1zOXGJRsKsuL1LBxXudxK/5u531x6wfAOoy6aqVLJnrIN
   ntDhya0LEotFNw78K0h+7q0EtLWFkZE2Cbj6Y78NTpm3wcWOqpMQ6mf7q
   Q==;
X-CSE-ConnectionGUID: Kjb6Y4BcR6uMvkfrea5p4A==
X-CSE-MsgGUID: 67kMnFALTpe43nU7F/bQKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69757620"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="69757620"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 10:11:51 -0800
X-CSE-ConnectionGUID: BWy1IBNCR5CfZwDUQiSj0A==
X-CSE-MsgGUID: io0qh63/T82ZuWsAi7UIBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="230997295"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.136]) ([10.125.109.136])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 10:11:50 -0800
Message-ID: <afb5b515-f05e-4626-aa05-252c6171480c@intel.com>
Date: Tue, 27 Jan 2026 11:11:48 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
 <20260114164837.1076338-11-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114164837.1076338-11-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/14/26 9:48 AM, Robert Richter wrote:
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
> callback, see function cxl_prm_setup_translation(). Setup is done in
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
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/Kconfig       |   5 +
>  drivers/cxl/acpi.c        |   2 +
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/atl.c    | 190 ++++++++++++++++++++++++++++++++++++++

Hi Robert,
This commit mises the cxl_test update, which causes missing symbols and fails cxl_test when turned on. I'll apply the following change to fix it:

---

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 0e151d0572d1..612d8edbfc6f 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -63,6 +63,7 @@ cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
+cxl_core-$(CONFIG_CXL_ATL) += $(CXL_CORE_SRC)/atl.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o

---
DJ

>  drivers/cxl/cxl.h         |   7 ++
>  5 files changed, 205 insertions(+)
>  create mode 100644 drivers/cxl/core/atl.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..103950a9b73e 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,9 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_ATL
> +	def_bool y
> +	depends on CXL_REGION
> +	depends on ACPI_PRMT && AMD_NB
> +
>  endif
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index a31d0f97f916..50c2987e0459 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -925,6 +925,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
> index 000000000000..c36984686fb0
> --- /dev/null
> +++ b/drivers/cxl/core/atl.c
> @@ -0,0 +1,190 @@
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
> +static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
> +{
> +	struct cxl_region_context *ctx = data;
> +	struct cxl_endpoint_decoder *cxled = ctx->cxled;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range hpa_range = ctx->hpa_range;
> +	struct pci_dev *pci_dev;
> +	u64 spa_len, len;
> +	u64 addr, base_spa, base;
> +	int ways, gran;
> +
> +	/*
> +	 * When Normalized Addressing is enabled, the endpoint maintains a 1:1
> +	 * mapping between HPA and DPA. If disabled, skip address translation
> +	 * and perform only a range check.
> +	 */
> +	if (hpa_range.start != cxled->dpa_res->start)
> +		return 0;
> +
> +	/*
> +	 * Endpoints are programmed passthrough in Normalized Addressing mode.
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
> +	base = hpa_range.start;
> +	hpa_range.start = prm_cxl_dpa_spa(pci_dev, hpa_range.start);
> +	hpa_range.end = prm_cxl_dpa_spa(pci_dev, hpa_range.end);
> +	base_spa = hpa_range.start;
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
> +	 * Since translated addresses include the interleaving offsets, align
> +	 * the range to 256 MB.
> +	 */
> +	hpa_range.start = ALIGN_DOWN(hpa_range.start, SZ_256M);
> +	hpa_range.end = ALIGN(hpa_range.end, SZ_256M) - 1;
> +
> +	len = range_len(&ctx->hpa_range);
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
> +
> +	/*
> +	 * Determine interleave granularity
> +	 *
> +	 * Note: The position of the chunk from one interleaving block to the
> +	 * next may vary and thus cannot be considered constant. Address offsets
> +	 * larger than the interleaving block size cannot be used to calculate
> +	 * the granularity.
> +	 */
> +	if (ways > 1) {
> +		while (gran <= SZ_16M) {
> +			addr = prm_cxl_dpa_spa(pci_dev, base + gran);
> +			if (addr != base_spa + gran)
> +				break;
> +			gran <<= 1;
> +		}
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
> +		dev_name(cxlmd->dev.parent), base, len, hpa_range.start,
> +		spa_len, ways, gran);
> +
> +	return 0;
> +}
> +
> +void cxl_setup_prm_address_translation(struct cxl_root *cxl_root)
> +{
> +	struct device *host = cxl_root->port.uport_dev;
> +	u64 spa;
> +	struct prm_cxl_dpa_spa_data data = { .spa = &spa };
> +	int rc;
> +
> +	/*
> +	 * Applies only to PCIe Host Bridges which are children of the CXL Root
> +	 * Device (HID=“ACPI0017”). Check this and drop cxl_test instances.
> +	 */
> +	if (!acpi_match_device(host->driver->acpi_match_table, host))
> +		return;
> +
> +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> +		return;
> +
> +	cxl_root->ops.translation_setup_root = cxl_prm_setup_root;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_setup_prm_address_translation, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8ea334d81edf..20b0fd43fa7b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -817,6 +817,13 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
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

