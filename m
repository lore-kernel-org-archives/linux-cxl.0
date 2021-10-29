Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE83DC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B804B60FED
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhJ2V0X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:26:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:12198 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhJ2V0X (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 29 Oct 2021 17:26:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="291593854"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="291593854"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 14:23:54 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="495852933"
Received: from applebex-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.137.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 14:23:53 -0700
Date:   Fri, 29 Oct 2021 14:23:52 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 02/28] cxl: Move register block enumeration to core
Message-ID: <20211029212352.mqjo3xx3rt5rh6ya@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-3-ben.widawsky@intel.com>
 <CAPcyv4hPQc_7a4CZ=hQyKzwNWXtiRTEb+FnwmOEC62vQFaAS9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hPQc_7a4CZ=hQyKzwNWXtiRTEb+FnwmOEC62vQFaAS9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-29 13:23:55, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > CXL drivers or cxl_core itself will require the ability to map component
> > registers in order to map HDM decoder resources amongst other things.
> 
> The PCI bits of this are only needed for switch support, right?
> Everything else already knows how to find the component_reg_phys base
> before devm_cxl_add_port().
> 
> It would help if this first sentence was a specific example where the
> PCI helpers are needed outside of cxl_pci.
> 

You've already spotted the other use in the next commit. I can change "CXL
drivers" to the specific drivers and related components.

> > Much of the register mapping code has already moved into cxl_core. The
> > code to pull the BAR number and block office remained within cxl_pci
> > because there was no need to move it. Upcoming work will require this
> > functionality to be available outside of cxl_pci.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/core/regs.c | 54 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h       |  4 +++
> >  drivers/cxl/pci.c       | 52 ---------------------------------------
> >  3 files changed, 58 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index 41de4a136ecd..40598905c080 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/pci.h>
> >  #include <cxlmem.h>
> > +#include <pci.h>
> >
> >  /**
> >   * DOC: cxl registers
> > @@ -247,3 +248,56 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(cxl_map_device_regs);
> > +
> > +static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> > +                               struct cxl_register_map *map)
> > +{
> > +       map->block_offset =
> > +               ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > +       map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> > +       map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> > +}
> > +
> > +/**
> > + * cxl_find_regblock() - Locate register blocks by type
> > + * @pdev: The CXL PCI device to enumerate.
> > + * @type: Register Block Indicator id
> > + * @map: Enumeration output, clobbered on error
> > + *
> > + * Return: 0 if register block enumerated, negative error code otherwise
> > + *
> > + * A CXL DVSEC may additional point one or more register blocks, search
> > + * for them by @type.
> > + */
> > +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > +                     struct cxl_register_map *map)
> > +{
> > +       u32 regloc_size, regblocks;
> > +       int regloc, i;
> > +
> > +       regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > +                                          PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> > +       if (!regloc)
> > +               return -ENXIO;
> > +
> > +       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> > +       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> > +
> > +       regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> > +       regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> > +
> > +       for (i = 0; i < regblocks; i++, regloc += 8) {
> > +               u32 reg_lo, reg_hi;
> > +
> > +               pci_read_config_dword(pdev, regloc, &reg_lo);
> > +               pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> > +
> > +               cxl_decode_regblock(reg_lo, reg_hi, map);
> > +
> > +               if (map->reg_type == type)
> > +                       return 0;
> > +       }
> > +
> > +       return -ENODEV;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_find_regblock);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 7cd16ef144dd..f06c596fad71 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -161,6 +161,10 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >                         struct cxl_device_regs *regs,
> >                         struct cxl_register_map *map);
> >
> > +enum cxl_regloc_type;
> > +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > +                     struct cxl_register_map *map);
> > +
> >  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> >  #define CXL_TARGET_STRLEN 20
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index f19a06809079..d1adc759d051 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -400,58 +400,6 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
> >         return 0;
> >  }
> >
> > -static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> > -                               struct cxl_register_map *map)
> > -{
> > -       map->block_offset =
> > -               ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > -       map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> > -       map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> > -}
> > -
> > -/**
> > - * cxl_find_regblock() - Locate register blocks by type
> > - * @pdev: The CXL PCI device to enumerate.
> > - * @type: Register Block Indicator id
> > - * @map: Enumeration output, clobbered on error
> > - *
> > - * Return: 0 if register block enumerated, negative error code otherwise
> > - *
> > - * A CXL DVSEC may additional point one or more register blocks, search
> > - * for them by @type.
> > - */
> > -static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > -                            struct cxl_register_map *map)
> > -{
> > -       u32 regloc_size, regblocks;
> > -       int regloc, i;
> > -
> > -       regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > -                                          PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> > -       if (!regloc)
> > -               return -ENXIO;
> > -
> > -       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> > -       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> > -
> > -       regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> > -       regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> > -
> > -       for (i = 0; i < regblocks; i++, regloc += 8) {
> > -               u32 reg_lo, reg_hi;
> > -
> > -               pci_read_config_dword(pdev, regloc, &reg_lo);
> > -               pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> > -
> > -               cxl_decode_regblock(reg_lo, reg_hi, map);
> > -
> > -               if (map->reg_type == type)
> > -                       return 0;
> > -       }
> > -
> > -       return -ENODEV;
> > -}
> > -
> >  static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >                           struct cxl_register_map *map)
> >  {
> > --
> > 2.33.1
> >
