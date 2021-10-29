Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD272C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A150661038
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhJ2U0h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJ2U0h (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 16:26:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E7C061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:24:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so7529157plq.11
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PFcjYpw9tzbWYrJgn+K0O3zPdAwHvUN3lT1vmLieWE=;
        b=pbOuv2wdjlIMlRBmV3SAtdeSaICvUr9490vCNPThpFIPt4UiGM+VrvVXh38AthDshy
         iPrT+Dx1wOW+ccaNn8GSU5t/xwPz/NhulIWylXfv71OiyAQCPXflnYH7ZU1nvz00Hnr6
         jXXd6iYcQ1wOr8A2LhumQrSh1VB3c2hoK+BLdcBn1KJ5OpJ5hokd9gJcveCohjyBi1hq
         kqID/obJIvfiDW7Oj0wcDr+KNdAiijGM62EnPbh8ztDFu+DsTbBFrQkww0wH3ojFtQcY
         ZoU5U9/ZXZP1D7pNk2QRyq17Uos996otRARhOLjS+rs8SvVgEw2rzV8M/hrAQHDCQ09i
         BvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PFcjYpw9tzbWYrJgn+K0O3zPdAwHvUN3lT1vmLieWE=;
        b=bs7IHskZpU4gy9hlP7Rm9a52uExo6IIhn+Z/e/ZEULYlRrFy/RrNzyHsY4J/J0az2r
         TIs7m6KHHe6NDdkin5FHczhQJ2EbqHYjsObS2cZankhlptQb+HN4JXSRJHQt+s+aY38U
         EPNDk1vwDFDURljr52Nizreq3/i19x5sD3Oai9dtmZ02h0/cJoRlt3r+DWSljhD3udMN
         o4moJZKGKSIH/eRQDFi2GWQdhn9IqZJqF1Tp6muYOip4YNRatMJLXLYBvlsz3r5rIRaj
         1HnyjasBCOL527jSdVnLfHH6Myw/9IGWRtwGmfwBvRywr3VokbPsuhL/lXXnDGdSBREH
         kFfA==
X-Gm-Message-State: AOAM531Rcn7iyrf+TOdX91c734pWt7maBHyWRaDi9SBoERrZxBWfQs8j
        /oKI1Brahws2H8avfd4grDwDgBVs75+kK49wrYSxhGc1J3U=
X-Google-Smtp-Source: ABdhPJxnBUJYBeCZzuxKJSGMNTCNRKPEHJPWTMlaqIZGkeALtnE88US4I0OQ7SkbPkHjENTRvddCrCC96TXWWTnGX+s=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr13715614pjb.220.1635539048052;
 Fri, 29 Oct 2021 13:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-3-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 13:23:55 -0700
Message-ID: <CAPcyv4hPQc_7a4CZ=hQyKzwNWXtiRTEb+FnwmOEC62vQFaAS9A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/28] cxl: Move register block enumeration to core
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> CXL drivers or cxl_core itself will require the ability to map component
> registers in order to map HDM decoder resources amongst other things.

The PCI bits of this are only needed for switch support, right?
Everything else already knows how to find the component_reg_phys base
before devm_cxl_add_port().

It would help if this first sentence was a specific example where the
PCI helpers are needed outside of cxl_pci.

> Much of the register mapping code has already moved into cxl_core. The
> code to pull the BAR number and block office remained within cxl_pci
> because there was no need to move it. Upcoming work will require this
> functionality to be available outside of cxl_pci.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/regs.c | 54 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  4 +++
>  drivers/cxl/pci.c       | 52 ---------------------------------------
>  3 files changed, 58 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 41de4a136ecd..40598905c080 100644
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
>  EXPORT_SYMBOL_GPL(cxl_map_device_regs);
> +
> +static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> +                               struct cxl_register_map *map)
> +{
> +       map->block_offset =
> +               ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> +       map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> +       map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
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
> + * A CXL DVSEC may additional point one or more register blocks, search
> + * for them by @type.
> + */
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +                     struct cxl_register_map *map)
> +{
> +       u32 regloc_size, regblocks;
> +       int regloc, i;
> +
> +       regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +                                          PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> +       if (!regloc)
> +               return -ENXIO;
> +
> +       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> +       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> +
> +       regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> +       regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
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
> +EXPORT_SYMBOL_GPL(cxl_find_regblock);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7cd16ef144dd..f06c596fad71 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -161,6 +161,10 @@ int cxl_map_device_regs(struct pci_dev *pdev,
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
> index f19a06809079..d1adc759d051 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -400,58 +400,6 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
>         return 0;
>  }
>
> -static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> -                               struct cxl_register_map *map)
> -{
> -       map->block_offset =
> -               ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> -       map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> -       map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
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
> - * A CXL DVSEC may additional point one or more register blocks, search
> - * for them by @type.
> - */
> -static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -                            struct cxl_register_map *map)
> -{
> -       u32 regloc_size, regblocks;
> -       int regloc, i;
> -
> -       regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -                                          PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> -       if (!regloc)
> -               return -ENXIO;
> -
> -       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> -       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> -
> -       regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> -       regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
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
> --
> 2.33.1
>
