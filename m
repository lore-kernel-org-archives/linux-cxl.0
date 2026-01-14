Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CB48CFC
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376856; cv=none; b=HRb8gpNiso25OcF5UtalZ912r2pyG5hGq1anpCqLAxSW+8Kzttxlb3EQe/GvCx2EJ47aD2cl27sRi5kTT5V/LCYC85V4M8aEF2Forrz0cRuvB3tzZDIlkEaMoY6dXGAcwbGxmHLiiNUEXbUhwSlZvPo8847/MEZTKIiwKpWT/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376856; c=relaxed/simple;
	bh=R9xbr6bkLBeBQ4+0OPh18Mp3k0SfUtcAaFlYKfFU1bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJDYlmPGQvksAJ1A0kr337YQxR/ynR68xWgFywxPAQiK/PxA1F1gmOsvk4yvKJ6t5ntVa/zG3UlRebEJPNlgaRZRQIaXajT+w18LYSWMZcobUyJsRWrOlc6eB4F15MU+Bw70UH928vmNi9JXS9IE6lsWkBi4o0YWp+6wH870G1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H90K7G74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H90K7G74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5294EC2BC87
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 07:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768376855;
	bh=R9xbr6bkLBeBQ4+0OPh18Mp3k0SfUtcAaFlYKfFU1bM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H90K7G74nqqGiChc8y9xf+VZrXSR4S2djva7YFxl5G0Cmex7o8oWBg958inQlEE1D
	 91TCyrzaq8ZQY9bD+PKy3fwApnXF+N9g5p95JIeR4c8nc3gyFn+ZAUYLk79LW65aTz
	 2IGOo+4cCrp4YBdD+LqGBqi/khxvST3BbLjSF33QGjJYSFAjtrZY0J2hO+qSN8D7Bj
	 W14Ds2oBZOGyMLRuWyOOLRZ+wKBzp4pf6n9IoFAi7URx7gmS2nKWboyb9gsXCXQnt7
	 lVODBBNif1xpClS2WH88SYh9WaWsPditj83diAAEtju4nJl3KPSmnIWyj15l1GPl9q
	 5rio71PKDjppQ==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso6461004a91.2
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 23:47:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzrfthxaR0X7/1xC797/5R+2GJpoK0bXJzH+rrRgQoo6GMLCyJZmnmxJwspRTeaLqFMzDwIaTUPCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTmKe+0MY5vYZqmxhQwa54v05aM0xiabJ+EBc3hQjGsw6xwp/
	86Hyyf/jjbxayNEw7lCosanjL+A2aealsxPZurQOgPHJgTJyc6wTpQlz6941T6oAOtb61wKmf0/
	WdvC3L7+oKCLf55r2/GA6Y4jboebpQ80=
X-Received: by 2002:a17:90b:2250:b0:34c:a29d:992f with SMTP id
 98e67ed59e1d1-3510913e074mr1850838a91.31.1768376854728; Tue, 13 Jan 2026
 23:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110114705.681676-1-rrichter@amd.com> <20260110114705.681676-11-rrichter@amd.com>
In-Reply-To: <20260110114705.681676-11-rrichter@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 Jan 2026 08:47:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
X-Gm-Features: AZwV_QhNaGNC9LybEwUaAOZLRwU7YyKSC5D3zXTwpGd6C0ikRjalxUE8B0EOHas
Message-ID: <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
To: Robert Richter <rrichter@amd.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gregory Price <gourry@gourry.net>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(cc Peter)

On Sat, 10 Jan 2026 at 12:46, Robert Richter <rrichter@amd.com> wrote:
>
> Add AMD Zen5 support for address translation.
>
...
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

Does the PRM service in question tolerate being invoked unprivileged?
The PRM spec requires this, and this is something we may need to
enforce at some point.

cc'ing Peter with whom I've discussed this just recently.



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
>  drivers/cxl/cxl.h         |   7 ++
>  5 files changed, 205 insertions(+)
>  create mode 100644 drivers/cxl/core/atl.c
>
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..103950a9b73e 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,9 @@ config CXL_MCE
>         def_bool y
>         depends on X86_MCE && MEMORY_FAILURE
>
> +config CXL_ATL
> +       def_bool y
> +       depends on CXL_REGION
> +       depends on ACPI_PRMT && AMD_NB
> +
>  endif
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index a31d0f97f916..50c2987e0459 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -925,6 +925,8 @@ static int cxl_acpi_probe(struct platform_device *pde=
v)
>         cxl_root->ops.qos_class =3D cxl_acpi_qos_class;
>         root_port =3D &cxl_root->port;
>
> +       cxl_setup_prm_address_translation(cxl_root);
> +
>         rc =3D bus_for_each_dev(adev->dev.bus, NULL, root_port,
>                               add_host_bridge_dport);
>         if (rc < 0)
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 5ad8fef210b5..11fe272a6e29 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
>  cxl_core-$(CONFIG_CXL_MCE) +=3D mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) +=3D features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) +=3D edac.o
> +cxl_core-$(CONFIG_CXL_ATL) +=3D atl.o
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
> + * AMD Family 1Ah Models 00h=E2=80=930Fh and Models 10h=E2=80=931Fh
> + * ACPI v6.5 Porting Guide, Publication # 58088
> + */
> +
> +static const guid_t prm_cxl_dpa_spa_guid =3D
> +       GUID_INIT(0xee41b397, 0x25d4, 0x452c, 0xad, 0x54, 0x48, 0xc6, 0xe=
3,
> +                 0x48, 0x0b, 0x94);
> +
> +struct prm_cxl_dpa_spa_data {
> +       u64 dpa;
> +       u8 reserved;
> +       u8 devfn;
> +       u8 bus;
> +       u8 segment;
> +       u64 *spa;
> +} __packed;
> +
> +static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
> +{
> +       struct prm_cxl_dpa_spa_data data;
> +       u64 spa;
> +       int rc;
> +
> +       data =3D (struct prm_cxl_dpa_spa_data) {
> +               .dpa     =3D dpa,
> +               .devfn   =3D pci_dev->devfn,
> +               .bus     =3D pci_dev->bus->number,
> +               .segment =3D pci_domain_nr(pci_dev->bus),
> +               .spa     =3D &spa,
> +       };
> +
> +       rc =3D acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +       if (rc) {
> +               pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa=
, rc);
> +               return ULLONG_MAX;
> +       }
> +
> +       pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %=
#llx\n", dpa, spa);
> +
> +       return spa;
> +}
> +
> +static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
> +{
> +       struct cxl_region_context *ctx =3D data;
> +       struct cxl_endpoint_decoder *cxled =3D ctx->cxled;
> +       struct cxl_decoder *cxld =3D &cxled->cxld;
> +       struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +       struct range hpa_range =3D ctx->hpa_range;
> +       struct pci_dev *pci_dev;
> +       u64 spa_len, len;
> +       u64 addr, base_spa, base;
> +       int ways, gran;
> +
> +       /*
> +        * When Normalized Addressing is enabled, the endpoint maintains =
a 1:1
> +        * mapping between HPA and DPA. If disabled, skip address transla=
tion
> +        * and perform only a range check.
> +        */
> +       if (hpa_range.start !=3D cxled->dpa_res->start)
> +               return 0;
> +
> +       /*
> +        * Endpoints are programmed passthrough in Normalized Addressing =
mode.
> +        */
> +       if (ctx->interleave_ways !=3D 1) {
> +               dev_dbg(&cxld->dev, "unexpected interleaving config: ways=
: %d granularity: %d\n",
> +                       ctx->interleave_ways, ctx->interleave_granularity=
);
> +               return -ENXIO;
> +       }
> +
> +       if (!cxlmd || !dev_is_pci(cxlmd->dev.parent)) {
> +               dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%=
#llx\n",
> +                       dev_name(cxld->dev.parent), hpa_range.start,
> +                       hpa_range.end);
> +               return -ENXIO;
> +       }
> +
> +       pci_dev =3D to_pci_dev(cxlmd->dev.parent);
> +
> +       /* Translate HPA range to SPA. */
> +       base =3D hpa_range.start;
> +       hpa_range.start =3D prm_cxl_dpa_spa(pci_dev, hpa_range.start);
> +       hpa_range.end =3D prm_cxl_dpa_spa(pci_dev, hpa_range.end);
> +       base_spa =3D hpa_range.start;
> +
> +       if (hpa_range.start =3D=3D ULLONG_MAX || hpa_range.end =3D=3D ULL=
ONG_MAX) {
> +               dev_dbg(cxld->dev.parent,
> +                       "CXL address translation: Failed to translate HPA=
 range: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +                       hpa_range.start, hpa_range.end, ctx->hpa_range.st=
art,
> +                       ctx->hpa_range.end, dev_name(&cxld->dev));
> +               return -ENXIO;
> +       }
> +
> +       /*
> +        * Since translated addresses include the interleaving offsets, a=
lign
> +        * the range to 256 MB.
> +        */
> +       hpa_range.start =3D ALIGN_DOWN(hpa_range.start, SZ_256M);
> +       hpa_range.end =3D ALIGN(hpa_range.end, SZ_256M) - 1;
> +
> +       len =3D range_len(&ctx->hpa_range);
> +       spa_len =3D range_len(&hpa_range);
> +       if (!len || !spa_len || spa_len % len) {
> +               dev_dbg(cxld->dev.parent,
> +                       "CXL address translation: HPA range not contiguou=
s: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +                       hpa_range.start, hpa_range.end, ctx->hpa_range.st=
art,
> +                       ctx->hpa_range.end, dev_name(&cxld->dev));
> +               return -ENXIO;
> +       }
> +
> +       ways =3D spa_len / len;
> +       gran =3D SZ_256;
> +
> +       /*
> +        * Determine interleave granularity
> +        *
> +        * Note: The position of the chunk from one interleaving block to=
 the
> +        * next may vary and thus cannot be considered constant. Address =
offsets
> +        * larger than the interleaving block size cannot be used to calc=
ulate
> +        * the granularity.
> +        */
> +       if (ways > 1) {
> +               while (gran <=3D SZ_16M) {
> +                       addr =3D prm_cxl_dpa_spa(pci_dev, base + gran);
> +                       if (addr !=3D base_spa + gran)
> +                               break;
> +                       gran <<=3D 1;
> +               }
> +       }
> +
> +       if (gran > SZ_16M) {
> +               dev_dbg(cxld->dev.parent,
> +                       "CXL address translation: Cannot determine granul=
arity: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +                       hpa_range.start, hpa_range.end, ctx->hpa_range.st=
art,
> +                       ctx->hpa_range.end, dev_name(&cxld->dev));
> +               return -ENXIO;
> +       }
> +
> +       ctx->hpa_range =3D hpa_range;
> +       ctx->interleave_ways =3D ways;
> +       ctx->interleave_granularity =3D gran;
> +
> +       dev_dbg(&cxld->dev,
> +               "address mapping found for %s (hpa -> spa): %#llx+%#llx -=
> %#llx+%#llx ways:%d granularity:%d\n",
> +               dev_name(cxlmd->dev.parent), base, len, hpa_range.start,
> +               spa_len, ways, gran);
> +
> +       return 0;
> +}
> +
> +void cxl_setup_prm_address_translation(struct cxl_root *cxl_root)
> +{
> +       struct device *host =3D cxl_root->port.uport_dev;
> +       u64 spa;
> +       struct prm_cxl_dpa_spa_data data =3D { .spa =3D &spa };
> +       int rc;
> +
> +       /*
> +        * Applies only to PCIe Host Bridges which are children of the CX=
L Root
> +        * Device (HID=3D=E2=80=9CACPI0017=E2=80=9D). Check this and drop=
 cxl_test instances.
> +        */
> +       if (!acpi_match_device(host->driver->acpi_match_table, host))
> +               return;
> +
> +       /* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> +       rc =3D acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +       if (rc =3D=3D -EOPNOTSUPP || rc =3D=3D -ENODEV)
> +               return;
> +
> +       cxl_root->ops.translation_setup_root =3D cxl_prm_setup_root;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_setup_prm_address_translation, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8ea334d81edf..20b0fd43fa7b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -817,6 +817,13 @@ static inline void cxl_dport_init_ras_reporting(stru=
ct cxl_dport *dport,
>                                                 struct device *host) { }
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
> --
> 2.47.3
>
>
