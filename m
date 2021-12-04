Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3F4C433EF
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Dec 2021 04:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbhLDElA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 23:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhLDElA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Dec 2021 23:41:00 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D3C061751
        for <linux-cxl@vger.kernel.org>; Fri,  3 Dec 2021 20:37:35 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f125so5104138pgc.0
        for <linux-cxl@vger.kernel.org>; Fri, 03 Dec 2021 20:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0UZ5ziQSBxiFNWt3UL95ns5YwGYae4wkXg9F7Pynns=;
        b=4263k5IJf3is350f4uBYJeI5ikXaO49fbdEnUHQ85vV5G5gUafwKK6icFUxngBjsRi
         7qf3i9jPoVKxWTOLLhlhiIFLlLuodywgqK/3obSF3sqIvSrS3+LCcUt6TDFiZbm3x4ID
         gKl7vWsgWxA1dAGSl2c6ErJAYC7VEtYOaKbZu25vUF6D0+7xlC5VgfNpNp5UTA2RqUje
         aP24eO9XjhSVQPxjq0Hyb9KTWJT9qBsQgO7V9269Vt9a3S9lJ4gagQHARTwqaZ/mg3Wr
         P4U846tr8suHBc0lYhoeM+v13TDkDy8dbViVZuzi0x7QP4dZyNKf6Gb77vHXZpG+IUOo
         fW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0UZ5ziQSBxiFNWt3UL95ns5YwGYae4wkXg9F7Pynns=;
        b=BSzwgZ8T04+/zt99ljtAOwEUndqo1/laEjTbowFkOiL4IWNHGSY5jRzVXhJwHLc6Gt
         qXjtRyrEdP1wpDZskKjiveg+vvGgJgh8ktB5PlT7WlOwifD/7S5NBkwVHP7P9qhAhelF
         KS4N0rjrZnuCQ3dIYjc3T88+B52m6TSOuTM+OG7fNEt/JVa4INzZ/irkSpTKPdAaQ6oB
         0Q3anQ2QUxgUvyPI/mQOqaJfzc/WYQFAZMsKj6Y/+nTYX9MnIlHmfw3Efdu/2EYzSqyJ
         pCIAH0CU1WsJU+uhMB0dveiCV/fktXp/HX9tC071PoH7b3sGdq8S5+owhOyM5qJPLQOU
         QUhQ==
X-Gm-Message-State: AOAM533/1PITGEjxVVsDamFw9lYs9mcFOaR0usW5DtC5XQ94KqDJWkiR
        gBpTjk42/FuCLB1uvuyNTMZv5AxHB+/T6+cbBwymqw==
X-Google-Smtp-Source: ABdhPJwgk+Bn46Gn5E3pS0CG0A8MzF1G3VRy0LjHz0HObGIApuD56BrQ4OKtMOtRsi/yGHthBHGVrPgZrCbmPR1pGnQ=
X-Received: by 2002:a63:658:: with SMTP id 85mr7777771pgg.437.1638592654704;
 Fri, 03 Dec 2021 20:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20211129214721.1668325-1-ben.widawsky@intel.com> <20211129214721.1668325-8-ben.widawsky@intel.com>
In-Reply-To: <20211129214721.1668325-8-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Dec 2021 20:37:26 -0800
Message-ID: <CAPcyv4jUebWTEOaULzDDqXf50QDEBZ3F4RAZVCO_kGXHjbo_xw@mail.gmail.com>
Subject: Re: [PATCH 7/9] cxl/acpi: Map component registers for Root Ports
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 29, 2021 at 1:47 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> This implements the TODO in cxl_acpi for mapping component registers.
> cxl_acpi becomes the second consumer of CXL register block enumeration
> (cxl_pci being the first). Moving the functionality to cxl_core allows
> both of these drivers to use the functionality. Equally importantly it
> allows cxl_core to use the functionality in the future.
>
> CXL 2.0 root ports are similar to CXL 2.0 Downstream Ports with the main
> distinction being they're a part of the CXL 2.0 host bridge. While
> mapping their component registers is not immediately useful for the CXL
> drivers, the movement of register block enumeration into core is a vital
> step towards HDM decoder programming.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> Changes since v1:
> - Add comment on why component register enumeration for root ports is
>   optional (Jonathan)
> - Fix kdoc for cxl_find_regblock (Jonathan)
> - Convert cxl_reg_block macro to static inline (Dan)
> - Rename cxl_reg_block cxl_reg_block to cxl_regmap_to_base (Dan)
> - Make cxl_regmap_to_base return CXL_RESOURCE_NONE on failure (Dan)

Hmm, it's not doing that...

> ---
>  drivers/cxl/acpi.c      | 13 ++++++++--
>  drivers/cxl/core/regs.c | 54 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  4 +++
>  drivers/cxl/pci.c       | 52 ---------------------------------------
>  drivers/cxl/pci.h       |  9 +++++++
>  5 files changed, 78 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3163167ecc3a..c656a49a11a9 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -7,6 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "pci.h"
>
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>  #define CFMWS_INTERLEAVE_WAYS(x)       (1 << (x)->interleave_ways)
> @@ -134,11 +135,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>
>  __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
>  {
> +       resource_size_t creg = CXL_RESOURCE_NONE;
>         struct cxl_walk_context *ctx = data;
>         struct pci_bus *root_bus = ctx->root;
>         struct cxl_port *port = ctx->port;
>         int type = pci_pcie_type(pdev);
>         struct device *dev = ctx->dev;
> +       struct cxl_register_map map;
>         u32 lnkcap, port_num;
>         int rc;
>
> @@ -152,9 +155,15 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
>                                   &lnkcap) != PCIBIOS_SUCCESSFUL)
>                 return 0;
>
> -       /* TODO walk DVSEC to find component register base */
> +       /* The driver doesn't rely on component registers for Root Ports yet. */
> +       rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +       if (!rc)
> +               dev_info(&pdev->dev, "No component register block found\n");
> +
> +       creg = cxl_regmap_to_base(pdev, &map);
> +
>         port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -       rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
> +       rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
>         if (rc) {
>                 ctx->error = rc;
>                 return rc;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e37e23bf4355..7a1c4290f0a3 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -5,6 +5,7 @@
>  #include <linux/slab.h>
>  #include <linux/pci.h>
>  #include <cxlmem.h>
> +#include <pci.h>
>
>  /**
>   * DOC: cxl registers
> @@ -247,3 +248,56 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>         return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
> +
> +static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> +                               struct cxl_register_map *map)
> +{
> +       map->block_offset = ((u64)reg_hi << 32) |
> +                           (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> +       map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> +       map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> +}
> +
> +/**
> + * cxl_find_regblock() - Locate register blocks by type
> + * @pdev: The CXL PCI device to enumerate.
> + * @type: Register Block Indicator id
> + * @map: Enumeration output, clobbered on error
> + *
> + * Return: 0 if register block enumerated, negative error code otherwise
> + *
> + * A CXL DVSEC may point to one or more register blocks, search for them
> + * by @type.
> + */
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +                     struct cxl_register_map *map)
> +{
> +       u32 regloc_size, regblocks;
> +       int regloc, i;
> +
> +       regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +                                          CXL_DVSEC_REG_LOCATOR);
> +       if (!regloc)
> +               return -ENXIO;
> +
> +       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> +       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> +
> +       regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> +       regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
> +
> +       for (i = 0; i < regblocks; i++, regloc += 8) {
> +               u32 reg_lo, reg_hi;
> +
> +               pci_read_config_dword(pdev, regloc, &reg_lo);
> +               pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> +
> +               cxl_decode_regblock(reg_lo, reg_hi, map);
> +
> +               if (map->reg_type == type)
> +                       return 0;
> +       }
> +
> +       return -ENODEV;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ab4596f0b751..7150a9694f66 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -145,6 +145,10 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>                         struct cxl_device_regs *regs,
>                         struct cxl_register_map *map);
>
> +enum cxl_regloc_type;
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +                     struct cxl_register_map *map);
> +
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ada0d67c8194..6aa3dd4b29a1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -416,58 +416,6 @@ static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *ma
>         return 0;
>  }
>
> -static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> -                               struct cxl_register_map *map)
> -{
> -       map->block_offset = ((u64)reg_hi << 32) |
> -                           (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> -       map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> -       map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> -}
> -
> -/**
> - * cxl_find_regblock() - Locate register blocks by type
> - * @pdev: The CXL PCI device to enumerate.
> - * @type: Register Block Indicator id
> - * @map: Enumeration output, clobbered on error
> - *
> - * Return: 0 if register block enumerated, negative error code otherwise
> - *
> - * A CXL DVSEC may point to one or more register blocks, search for them
> - * by @type.
> - */
> -static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -                            struct cxl_register_map *map)
> -{
> -       u32 regloc_size, regblocks;
> -       int regloc, i;
> -
> -       regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -                                          CXL_DVSEC_REG_LOCATOR);
> -       if (!regloc)
> -               return -ENXIO;
> -
> -       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> -       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> -
> -       regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> -       regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
> -
> -       for (i = 0; i < regblocks; i++, regloc += 8) {
> -               u32 reg_lo, reg_hi;
> -
> -               pci_read_config_dword(pdev, regloc, &reg_lo);
> -               pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> -
> -               cxl_decode_regblock(reg_lo, reg_hi, map);
> -
> -               if (map->reg_type == type)
> -                       return 0;
> -       }
> -
> -       return -ENODEV;
> -}
> -
>  static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>                           struct cxl_register_map *map)
>  {
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 8ae2b4adc59d..f418272dbe38 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -47,4 +47,13 @@ enum cxl_regloc_type {
>         CXL_REGLOC_RBI_TYPES
>  };
>
> +static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
> +                                                struct cxl_register_map *map)
> +{
> +       if (!map)
> +               return CXL_RESOURCE_NONE;

All the callers are passing in a non-NULL map. I was more thinking on
cxl_find_regblock() failure. It sets a signature in the map so that
cxl_regmap_to_base() returns CXL_RESOURCE_NONE.

Something like:

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 271e0ca5c8d9..20449237ec36 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -275,6 +275,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum
cxl_regloc_type type,
        u32 regloc_size, regblocks;
        int regloc, i;

+       map->block_offset = U64_MAX;
        regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
                                           CXL_DVSEC_REG_LOCATOR);
        if (!regloc)
@@ -298,6 +299,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum
cxl_regloc_type type,
                        return 0;
        }

+       map->block_offset = U64_MAX;
        return -ENODEV;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index bf527399a5de..3f3a1121eb93 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -63,7 +63,7 @@ enum cxl_regloc_type {
 static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
                                                 struct cxl_register_map *map)
 {
-       if (!map)
+       if (map->block_offset == U64_MAX)
                return CXL_RESOURCE_NONE;

        return pci_resource_start(pdev, map->barno) + map->block_offset;
