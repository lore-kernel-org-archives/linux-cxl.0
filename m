Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6721EF0B1
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292543; cv=none; b=HltdM5JhP/KQtEo++L/cLAlPcNVmFO8YJDp/wQ3zPhFfuIW2QzOAfNF5O1F8wCOac7Pp8LzcKomIRTLfkZilT59EZgfoFut8O3BgOtb8cx8eX3QeYysrz9ccFv5x68WhFTwX2FYtFsdESVPHCVmr7oPpnDyt7yOSSH941RXS7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292543; c=relaxed/simple;
	bh=ESGYuXLd8lUHMLIUAx4qcVaJrCfxdct+lLQ0dP+QXIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEdG7JOIEGM4Gb6YTelQM2RejUdZZMOnZRWziE9UN3Vf7hIhVWteNXCaiBJ7gA5CxTBzsPwLE8EeEdtK4ZGkyJofzgt2KB5uWR9sfH1O34xfD6LRTMnYdfivV0q47eoL7KGZDG5Hk9KyXzfgRyDFr66PHCzv7oHNh/MpDORKwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CLZ+BorF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CLZ+BorF"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd049b5428so135608596d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 15:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736292539; x=1736897339; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ljDiWAxTK9XfwGq+9VpYdAiTYOg1UcYumP1E9J3ixs=;
        b=CLZ+BorFyHute4yb9K7bidPQOYSpj14R0Ak+BKIfqQ/IVxLG3W+xciZ80fj6NoYdSt
         kzy970ILrPTHOsjACfybnPji3+vGWkMND/gHONdPY5uKvXRoa2NGnwrCIIutaw1+2YNm
         XTX0Hrx8LlwfCwMOyASQwY/yEHVKPi5uXjHWHdBSbk/0c0otKX8CrUiWfsVA4foXRNBu
         vZN3JGtrBNR5q9G99AlYJ2qTZum0E7STCVMQiXDvCGJSFcDO99c9xcw01W443rTF3sro
         6+XRE44zKWquiPP+A2/cLzN2CI8nuSH71CGYDmPa92GjBCDw6hypeWfxwjVR6RoXeDQR
         soEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736292539; x=1736897339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ljDiWAxTK9XfwGq+9VpYdAiTYOg1UcYumP1E9J3ixs=;
        b=NgDHSwtv+sn9pbMuklfHVG+YooHQ05PSIQMxrBYzEfPUXyC3KOclHhlZkphz589RXk
         0IOHyQrZ28Uf48dW2PARK/w0Oa1QIpcm9qOVN3nDeIDtH8+V9Dt7ZqSWIojwNqyw+26z
         wmt8l21i4MjyXavWFIx2DSMAYVdF0jBFjgJ2uHanephpkaLx9Qo2Gurt3ZI16krXjcRD
         p4Nx0cFRyOE9TUIlXsmG96F9HYehzKnio1Eli//B/DnpoJC6YXhf9E8yQmNC2O0lZNhN
         zW5nzNUxmdaG/s2pIEHVgOXHrpa/d/KRBgbm8GkZHuo7yBx153MHYMIhTigVZ4Bj9B62
         6dMg==
X-Forwarded-Encrypted: i=1; AJvYcCXhTDNSmTZCdTRlTwmScGqYCGDtHB0hnA+XA3AUFP3rfR/FmZ3yBPOLLGQOZHh3HZhSRpJ5rPASll0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIhXcWAZ7GWrqVIzqqtW3XoxaT0akZJhuzrSRmZxClGx90sAbg
	WmuqX/zFJB3EnOHOeECV4r8bxeCkKxmGYq5BdRsTyghf9gnjTrRFqbFPBE5DgGI=
X-Gm-Gg: ASbGncu1BxmFrzOb3dovgOCnDpXOZZWpBcNAS2+TPxLdTumlYNiKVrJ3FxXK1OmtZDk
	V9jJMRTIkeVJ7TvB6oACzF1jjSS3oNC7xPYzDGSFJz1TUcIbb2zpu83nvER8e5keXj5aEJY/79+
	lxTrmaAmJdPRBaIvaCrybMfPWA4G3jQ904MbDhE3qnzr2QqSPVpiBIScexQXjDTC1jEwR9G8gta
	0YAuiXINP5G343+uaTWJroGq6otq/AfR17akoNMB5WYDbqYnhdytnH6HopgMwATEt1Osos2exgU
	BrQMoEOwO8+Aqrsf7oXiw7ZeqEEYnx+hJOHmDTA=
X-Google-Smtp-Source: AGHT+IEmXn/yY+rQyRnYeDxUKc4WpVWcNRhLIpF0RwWAx3iaSmM9IJM/0AqCqxqz4V2KQtyIfTuvMA==
X-Received: by 2002:a05:6214:448f:b0:6d8:e5f4:b977 with SMTP id 6a1803df08f44-6df9b1b4e9bmr18188246d6.5.1736292539293;
        Tue, 07 Jan 2025 15:28:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181a7c1fsm188506036d6.72.2025.01.07.15.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 15:28:58 -0800 (PST)
Date: Tue, 7 Jan 2025 18:28:57 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z324ueZ0Rxj4Sq6t@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107141015.3367194-26-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:11PM +0100, Robert Richter wrote:
> 
> Add a function cxl_port_setup_amd() to implement AMD platform specific
> code. Use Kbuild and Kconfig options respectivly to enable the code
> depending on architecture and platform options. Create a new file
> core/amd.c for this.
> 

A build option here specific to AMD doesn't seem the best. At Meta,
we try to maintain a platform agnostic kernel for our fleet (at least
for build options), and this would necessitate us maintaining separate
builds for AMD systems vs other vendors.

Is there a reason to simply not include it by default and just report
whether translation is required or not? (i.e. no build option)

Or maybe generalize to CXL_PLATFORM_QUIRKS rather than CXL_AMD?

~Gregory

> Introduce a function cxl_zen5_init() to handle Zen5 specific
> enablement. Zen5 platforms are detected using the PCIe vendor and
> device ID of the corresponding CXL root port.
> 
> Apply cxl_zen5_to_hpa() as cxl_port->to_hpa() callback to Zen5 CXL
> host bridges to enable platform specific address translation.
> 
> Use ACPI PRM DPA to SPA translation to determine an endpoint's
> interleaving configuration and base address during the early
> initialization proces. This is used to determine an endpoint's SPA
> range.
> 
> Since the PRM translates DPA->SPA, but HPA->SPA is needed, determine
> the interleaving config and base address of the endpoint first, then
> calculate the SPA based on the given HPA using the address base.
> 
> The config can be determined calling the PRM for specific DPAs
> given. Since the interleaving configuration is still unknown, chose
> DPAs starting at 0xd20000. This address is factor for all values from
> 1 to 8 and thus valid for all possible interleaving configuration.
> The resulting SPAs are used to calculate interleaving paramters and
> the SPA base address of the endpoint. The maximum granularity (chunk
> size) is 16k, minimum is 256. Use the following calculation for a
> given DPA:
> 
>  ways    = hpa_len(SZ_16K) / SZ_16K
>  gran    = (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
>           / (ways - 1)
>  pos     = (hpa_len(SZ_16K) - ways * SZ_16K) / gran
> 
> Once the endpoint is attached to a region and its SPA range is know,
> calling the PRM is no longer needed, the SPA base can be used.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/amd.c    | 227 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/core.h   |   6 +
>  drivers/cxl/core/port.c   |   7 ++
>  5 files changed, 245 insertions(+)
>  create mode 100644 drivers/cxl/core/amd.c
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
> index 9259bcc6773c..dc368e61d281 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -16,3 +16,4 @@ cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_AMD) += amd.o
> diff --git a/drivers/cxl/core/amd.c b/drivers/cxl/core/amd.c
> new file mode 100644
> index 000000000000..553b7d0caefd
> --- /dev/null
> +++ b/drivers/cxl/core/amd.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/prmt.h>
> +#include <linux/pci.h>
> +
> +#include "cxlmem.h"
> +#include "core.h"
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
> +static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> +{
> +	struct cxl_memdev *cxlmd;
> +	struct pci_dev *pci_dev;
> +	struct cxl_port *port;
> +	u64 dpa, base, spa, spa2, len, len2, offset, granularity;
> +	int ways, pos;
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
> +	if (hpa > cxld->hpa_range.end) {
> +		dev_dbg(&cxld->dev, "hpa addr %#llx out of range %#llx-%#llx\n",
> +			hpa, cxld->hpa_range.start, cxld->hpa_range.end);
> +		return ULLONG_MAX;
> +	}
> +
> +	/*
> +	 * If the decoder is already attached, the region's base can
> +	 * be used.
> +	 */
> +	if (cxld->region)
> +		return cxld->region->params.res->start + hpa;
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
> +	 * The PRM translates DPA->SPA, but we need HPA->SPA.
> +	 * Determine the interleaving config first, then calculate the
> +	 * DPA. Maximum granularity (chunk size) is 16k, minimum is
> +	 * 256. Calculated with:
> +	 *
> +	 *	ways	= hpa_len(SZ_16K) / SZ_16K
> +	 * 	gran	= (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
> +	 *                / (ways - 1)
> +	 *	pos	= (hpa_len(SZ_16K) - ways * SZ_16K) / gran
> +	 */
> +
> +	/*
> +	 * DPA magic:
> +	 *
> +	 * Position and granularity are unknown yet, use an always
> +	 * valid DPA:
> +	 *
> +	 * 0xd20000 = 13762560 = 16k * 2 * 3 * 2 * 5 * 7 * 2
> +	 *
> +	 * It is divisible by all positions 1 to 8. The DPA is valid
> +	 * for all positions and granularities.
> +	 */
> +#define DPA_MAGIC	0xd20000
> +	base = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC);
> +	spa  = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K);
> +	spa2 = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K - SZ_256);
> +
> +	/* Includes checks to avoid div by zero */
> +	if (!base || base == ULLONG_MAX || spa == ULLONG_MAX ||
> +	    spa2 == ULLONG_MAX || spa < base + SZ_16K || spa2 <= base ||
> +	    (spa > base + SZ_16K && spa - spa2 < SZ_256 * 2)) {
> +		dev_dbg(&cxld->dev, "Error translating HPA: base %#llx, spa %#llx, spa2 %#llx\n",
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
> +		granularity = 0;
> +		pos = 0;
> +	} else {
> +		ways = len / SZ_16K;
> +		offset = spa & (SZ_16K - 1);
> +		granularity = (len - len2 - SZ_256) / (ways - 1);
> +		pos = offset / granularity;
> +	}
> +
> +	base = base - DPA_MAGIC * ways - pos * granularity;
> +	spa = base + hpa;
> +
> +	/*
> +	 * Check SPA using a PRM call for the closest DPA calculated
> +	 * for the HPA. If the HPA matches a different interleaving
> +	 * position other than the decoder's, determine its offset to
> +	 * adjust the SPA.
> +	 */
> +
> +	dpa = (hpa & ~(granularity * ways - 1)) / ways
> +		+ (hpa & (granularity - 1));
> +	offset = hpa & (granularity * ways - 1) & ~(granularity - 1);
> +	offset -= pos * granularity;
> +	spa2 = prm_cxl_dpa_spa(pci_dev, dpa) + offset;
> +
> +	dev_dbg(&cxld->dev,
> +		"address mapping found for %s (dpa -> hpa -> spa): %#llx -> %#llx -> %#llx base: %#llx ways: %d pos: %d granularity: %llu\n",
> +		pci_name(pci_dev), dpa, hpa, spa, base, ways, pos, granularity);
> +
> +	if (spa != spa2) {
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
> +	if (!is_zen5(port))
> +		return;
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
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 800466f96a68..efe34ae6943e 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -115,4 +115,10 @@ bool cxl_need_node_perf_attrs_update(int nid);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  
> +#ifdef CONFIG_CXL_AMD
> +void cxl_port_setup_amd(struct cxl_port *port);
> +#else
> +static inline void cxl_port_setup_amd(struct cxl_port *port) {};
> +#endif
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 901555bf4b73..c8176265c15c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -831,6 +831,11 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  			    &cxl_einj_inject_fops);
>  }
>  
> +static void cxl_port_platform_setup(struct cxl_port *port)
> +{
> +	cxl_port_setup_amd(port);
> +}
> +
>  static int cxl_port_add(struct cxl_port *port,
>  			resource_size_t component_reg_phys,
>  			struct cxl_dport *parent_dport)
> @@ -868,6 +873,8 @@ static int cxl_port_add(struct cxl_port *port,
>  			return rc;
>  	}
>  
> +	cxl_port_platform_setup(port);
> +
>  	rc = device_add(dev);
>  	if (rc)
>  		return rc;
> -- 
> 2.39.5
> 
