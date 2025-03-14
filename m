Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E82E3398;
	Fri, 14 Mar 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957320; cv=none; b=sEImh2laAICMUCesyAFlDQwDhEBJVpe1kctpKRM7fMfggKFrs/JvKbFVT4bTGnEz3llqkM4SUNGgaa8pIFL0fmK0IG5w/NSojoIjxCPMgSiv1P96kEvLBKYsAh8yWgfuiCgDAU96fSa+ZN9IYL2NdDzgeJ7zbi3k9ewbJ3+Ssro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957320; c=relaxed/simple;
	bh=XbI0s9hltLxjOgAOnZRtTprETFytgxrucjh1kd2mXSU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Np2pyy1AAjA2lt+b02V25b6kJ1qVsPMloB4jSJRFbhiEEZ7X8YHFEswbN8MDVfIAwCgaa9lVQeDxNytiWqsOLs62bmDD6Puhl7Xbfedf7WukRV9lKG9KD8SgMq85uaF4p9HDH9sVLxlfPSqWz4VW7SLbGxDrFj1Ak7K6kZElAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDkvR3SPPz67FR3;
	Fri, 14 Mar 2025 20:58:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B0246140CF4;
	Fri, 14 Mar 2025 21:01:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 14:01:54 +0100
Date: Fri, 14 Mar 2025 13:01:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v2 14/15] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <20250314130152.00004d11@huawei.com>
In-Reply-To: <20250218132356.1809075-15-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
	<20250218132356.1809075-15-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 14:23:55 +0100
Robert Richter <rrichter@amd.com> wrote:

> Add AMD platform specific Zen5 support for address translation.
>=20
> Zen5 systems may be configured to use 'Normalized addresses'. Then,
> CXL endpoints use their own physical address space and are programmed
> passthrough (DPA =3D=3D HPA), the number of interleaving ways for the
> endpoint is set to one. The Host Physical Addresses (HPAs) need to be
> translated from the endpoint to its CXL host bridge. The HPA of a CXL
> host bridge is equivalent to the System Physical Address (SPA).
>=20
> ACPI Platform Runtime Mechanism (PRM) is used to translate the CXL
> Device Physical Address (DPA) to its System Physical Address. This is
> documented in:
>=20
>  AMD Family 1Ah Models 00h=E2=80=930Fh and Models 10h=E2=80=931Fh
>  ACPI v6.5 Porting Guide, Publication # 58088
>  https://www.amd.com/en/search/documentation/hub.html
>=20
> To implement AMD Zen5 address translation the following steps are
> needed:
>=20
> Apply platform specific changes to each port where necessary using
> platform detection and the existing architectural framework.
>=20
> Add a function cxl_port_setup_amd() to implement AMD platform specific
> code. Use Kbuild and Kconfig options respectively to enable the code
> depending on architecture and platform options. Handle architecture
> specifics in arch_cxl_port_platform_setup() and create a new file
> core/x86/amd.c for this.
>=20
> Introduce a function cxl_zen5_init() to handle Zen5 specific
> enablement. Zen5 platforms are detected using the PCIe vendor and
> device ID of the corresponding CXL root port. There is a check for
> ACPI PRMT CXL address translation support.
>=20
> Apply cxl_zen5_to_hpa() as cxl_port->to_hpa() callback to Zen5 CXL
> host bridges to enable platform specific address translation.
>=20
> Use ACPI PRM DPA-to-SPA translation to determine an endpoint's
> interleaving configuration and base address during the early
> initialization process. This is used to determine an endpoint's SPA
> range and to check the address translation setup.
>=20
> The configuration can be determined calling the PRM for specific HPAs
> given. The resulting SPAs are used to calculate interleaving
> parameters of the host bridge and root port. The maximum granularity
> (chunk size) is 16k, minimum is 256. Use the following calculation for
> the given HPAs:
>=20
>  ways    =3D hpa_len(SZ_16K) / SZ_16K
>  gran    =3D (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
>           / (ways - 1)
>  pos     =3D (hpa_len(SZ_16K) - ways * SZ_16K) / gran
>=20
> Before the endpoint is attached to a region the translation is checked
> for reasonable values.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
Some trivial comments inline.  The rest I may take another look at as
not gotten my head fully around it yet.

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

Might as well just put it inline unless you have lots of uses.

> +
> +static const struct pci_device_id zen5_root_port_ids[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ZEN5_ROOT) },
> +	{},
	{}

Don't want to make it easy to add stuff after.

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
combine a few of these on same line perhaps?
> +	    !is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return false;

> +
> +/* Bits used for interleaving. */
> +#define SPA_INTERLEAVING_BITS	GENMASK_ULL(14, 8)
> +
> +static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> +{


> +	port =3D to_cxl_port(cxld->dev.parent);
> +	cxlmd =3D port ? to_cxl_memdev(port->uport_dev) : NULL;
> +	if (!port || !dev_is_pci(cxlmd->dev.parent)) {

Given you are going to dereference cxlmd, maybe more logical to do

	if (!cxlmd || !dev_is_pci()

> +		dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
> +			dev_name(cxld->dev.parent), cxld->hpa_range.start,
> +			cxld->hpa_range.end);
> +		return ULLONG_MAX;
> +	}
> +	pci_dev =3D to_pci_dev(cxlmd->dev.parent);
> +
> +	/*
> +	 * If the decoder is already attached we are past the decoder
> +	 * initialization, do not determine the address mapping and
> +	 * just return here.
> +	 */
> +	if (cxld->region)
> +		return prm_cxl_dpa_spa(pci_dev, hpa);
> +
>
> +	/*
> +	 * Check the mapping: Number of ways is power of 2 or a
> +	 * multiple of 3 ways (len =3D=3D ways * SZ_16K), granularitys is

granularity is=20

> +	 * power of 2.
> +	 */
> +	if (len & ~(3ULL << (ways_bits + 14)) ||
> +	    granularity !=3D 1 << gran_bits || offset !=3D pos << gran_bits) {
> +		dev_dbg(&cxld->dev, "Error determining address mapping: base: %#llx sp=
a: %#llx spa2: %#llx ways: %d pos: %d granularity: %llu\n",
> +			base, spa, spa2, ways, pos, granularity);
> +		return ULLONG_MAX;
> +	}
> +
> +	spa =3D prm_cxl_dpa_spa(pci_dev, hpa);
> +
> +	/*
> +	 * Check SPA using a PRM call for the closest DPA calculated
> +	 * for the HPA. If the HPA matches a different interleaving
> +	 * position other than the decoder's, determine its offset to
> +	 * adjust the SPA.
> +	 */
> +
> +	gran_mask =3D GENMASK_ULL(gran_bits, 0);
> +	spa2 =3D base + (hpa & ~gran_mask) * ways + (hpa & gran_mask);
> +	base =3D base - pos * granularity;
> +
> +	dev_dbg(&cxld->dev,
> +		"address mapping found for %s (hpa -> spa): %#llx -> %#llx (%#llx+%#ll=
x) ways: %d pos: %d granularity: %llu\n",
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
> +	struct prm_cxl_dpa_spa_data data =3D { .out =3D &spa, };
> +	int rc;
> +
> +	if (!is_zen5(port))
> +		return;
> +
> +	/* Check kernel and firmware support */
> +	rc =3D acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +
No blank line here. Keen the error check right up against the call.
> +	if (rc =3D=3D -EOPNOTSUPP) {
> +		pr_warn_once("ACPI PRMT: PRM address translation not supported by kern=
el\n");
> +		return;
> +	}
> +
> +	if (rc =3D=3D -ENODEV) {
> +		pr_warn_once("ACPI PRMT: PRM address translation not supported by firm=
ware\n");
> +		return;
> +	}
> +
> +	port->to_hpa =3D cxl_zen5_to_hpa;
> +
> +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> +		dev_name(&port->dev));
> +}
> +
> +void cxl_port_setup_amd(struct cxl_port *port)
> +{
> +	cxl_zen5_init(port);
> +}

