Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18F2C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 16:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5D461166
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 16:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhIUQpc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:45:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:46639 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhIUQpc (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 21 Sep 2021 12:45:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="308966959"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="308966959"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 09:44:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="518274466"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.132.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 09:44:02 -0700
Date:   Tue, 21 Sep 2021 09:44:01 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] cxl: Move register block enumeration to core
Message-ID: <20210921164401.h46pjfwkpr7m2ven@intel.com>
References: <20210920225638.1729482-1-ben.widawsky@intel.com>
 <CAPcyv4ja65PA5qjKPW4dYsVUCEiEDKD65_5vw15VryYL1h7=QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ja65PA5qjKPW4dYsVUCEiEDKD65_5vw15VryYL1h7=QQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-21 07:07:13, Dan Williams wrote:
> On Mon, Sep 20, 2021 at 3:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > CXL drivers or cxl_core itself will require the ability to map component
> > registers in order to map HDM decoder resources amongst other things.
> > Much of the register mapping code has already moved into cxl_core. The
> > code to pull the BAR number and block office remained within cxl_pci

s/office/offset - before anyone else notices...

> > because there was no need to move it. Upcoming work will require this
> > functionality to be available outside of cxl_pci.
> >
> > There are two intentional functional changes:
> > 1. cxl_pci: If there is more than 1 component, or device register block,
> >    only the first one (of each) is checked. Previous logic checked all
> >    duplicate register blocks and additionally attempted to map unused
> >    register blocks if present.
> > 2. cxl_pci: No more dev_dbg for unused register blocks
> 
> Why not break these out into separate patches before moving the code?
> It makes it easier to review, and it increases the precision of future
> Fixes: patches if necessary.
> 

I can. Indeed it was my instinct to do so. I went against my instinct... 

What are you thinking (something like...)?
1. Change register locator identifiers to enum
2. refactor cxl_pci to use the new find() function.
3. Remove map.type
4. move required functionality to core

> >
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/core/regs.c |  89 ++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h       |   3 ++
> >  drivers/cxl/pci.c       | 104 +++++++---------------------------------
> >  drivers/cxl/pci.h       |  14 +++---
> >  4 files changed, 116 insertions(+), 94 deletions(-)
> >
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index 41de4a136ecd..ef6164ef449f 100644
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
> > @@ -247,3 +248,91 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(cxl_map_device_regs);
> > +
> > +static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi, u8 *bar,
> > +                                     u64 *offset, u8 *reg_type)
> > +{
> > +       *offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > +       *bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> > +       *reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> > +}
> > +
> > +static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
> > +{
> > +       int pos;
> > +
> > +       pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> > +       if (!pos)
> > +               return 0;
> > +
> > +       while (pos) {
> > +               u16 vendor, id;
> > +
> > +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
> > +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
> > +               if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> > +                       return pos;
> > +
> > +               pos = pci_find_next_ext_capability(pdev, pos,
> > +                                                  PCI_EXT_CAP_ID_DVSEC);
> > +       }
> 
> We punted on refactoring this for the initial driver submission
> because it was difficult to coordinate. Now that cxl.git is an
> established tree, instead of moving this it seems time to address that
> refactor that Bjorn asked about. Bjorn, would you be willing to carry
> a non-rebasing branch with such a cleanup that CXL could pull from?
> 

Also here:
https://lore.kernel.org/linux-pci/20210913190131.xiiszmno46qie7v5@intel.com/

> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * cxl_get_register_block() - Find the CXL register block by identifier
> > + * @pdev: The PCI device implementing the registers
> > + * @type: Type of register block to find
> > + * @map: (Output) parameters used to map the regiseter block
> 
> s/regiseter/register/
> 
> > + *
> > + * If register block is found, 0 is returned and @map is populated; else returns
> > + * negative error code.
> > + */
> > +int cxl_get_register_block(struct pci_dev *pdev, enum cxl_regloc_type type,
> 
> Seeing this broken out again it looks like a 'find' operation rather
> than a 'get', but not a big deal.
> 

I'm okay to rename it. It also makes me realize map.type becomes a useless
field.

> > +                          struct cxl_register_map *map)
> > +{
> > +       int regloc, i, rc = -ENODEV;
> > +       u32 regloc_size, regblocks;
> > +
> > +       memset(map, 0, sizeof(*map));
> > +
> > +       regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> > +       if (!regloc)
> > +               return -ENXIO;
> > +
> > +       if (pci_request_mem_regions(pdev, pci_name(pdev)))
> > +               return -ENODEV;
> > +
> > +       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> > +       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> > +
> > +       regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> > +       regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> > +
> > +       for (i = 0; i < regblocks; i++, regloc += 8) {
> > +               u32 reg_lo, reg_hi;
> > +               u8 reg_type, bar;
> > +               u64 offset;
> > +
> > +               pci_read_config_dword(pdev, regloc, &reg_lo);
> > +               pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> > +
> > +               cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
> > +                                         &reg_type);
> > +
> > +               if (reg_type == type) {
> > +                       map->barno = bar;
> > +                       map->block_offset = offset;
> > +                       map->reg_type = reg_type;
> > +                       rc = 0;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       pci_release_mem_regions(pdev);
> > +
> > +       return rc;
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(cxl_get_register_block);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 7d6b011dd963..cff3b68e03e0 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -159,6 +159,9 @@ int cxl_map_component_regs(struct pci_dev *pdev,
> >  int cxl_map_device_regs(struct pci_dev *pdev,
> >                         struct cxl_device_regs *regs,
> >                         struct cxl_register_map *map);
> > +enum cxl_regloc_type;
> > +int cxl_get_register_block(struct pci_dev *pdev, enum cxl_regloc_type type,
> > +                          struct cxl_register_map *map);
> >
> >  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> >  #define CXL_TARGET_STRLEN 20
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 64180f46c895..2d91e20bd088 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -337,29 +337,6 @@ static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
> >         pci_iounmap(to_pci_dev(cxlm->dev), base);
> >  }
> >
> > -static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
> > -{
> > -       int pos;
> > -
> > -       pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> > -       if (!pos)
> > -               return 0;
> > -
> > -       while (pos) {
> > -               u16 vendor, id;
> > -
> > -               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
> > -               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
> > -               if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> > -                       return pos;
> > -
> > -               pos = pci_find_next_ext_capability(pdev, pos,
> > -                                                  PCI_EXT_CAP_ID_DVSEC);
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> >  static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
> >                           struct cxl_register_map *map)
> >  {
> > @@ -420,14 +397,6 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
> >         return 0;
> >  }
> >
> > -static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
> > -                                     u8 *bar, u64 *offset, u8 *reg_type)
> > -{
> > -       *offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > -       *bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> > -       *reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> > -}
> > -
> >  /**
> >   * cxl_pci_setup_regs() - Setup necessary MMIO.
> >   * @cxlm: The CXL memory device to communicate with.
> > @@ -440,72 +409,31 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
> >   */
> >  static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
> >  {
> > -       void __iomem *base;
> > -       u32 regloc_size, regblocks;
> > -       int regloc, i, n_maps, ret = 0;
> > +       int i, ret = 0;
> >         struct device *dev = cxlm->dev;
> >         struct pci_dev *pdev = to_pci_dev(dev);
> > -       struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
> > -
> > -       regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> > -       if (!regloc) {
> > -               dev_err(dev, "register location dvsec not found\n");
> > -               return -ENXIO;
> > -       }
> > +       enum cxl_regloc_type types[] = {CXL_REGLOC_RBI_MEMDEV, CXL_REGLOC_RBI_COMPONENT};
> >
> > -       if (pci_request_mem_regions(pdev, pci_name(pdev)))
> > -               return -ENODEV;
> > +       for (i = 0; i < ARRAY_SIZE(types); i++) {
> > +               struct cxl_register_map map;
> > +               void __iomem *base;
> >
> > -       /* Get the size of the Register Locator DVSEC */
> > -       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> > -       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> > -
> > -       regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> > -       regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> > -
> > -       for (i = 0, n_maps = 0; i < regblocks; i++, regloc += 8) {
> > -               u32 reg_lo, reg_hi;
> > -               u8 reg_type;
> > -               u64 offset;
> > -               u8 bar;
> > -
> > -               pci_read_config_dword(pdev, regloc, &reg_lo);
> > -               pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> > -
> > -               cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
> > -                                         &reg_type);
> > -
> > -               dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
> > -                       bar, offset, reg_type);
> > -
> > -               /* Ignore unknown register block types */
> > -               if (reg_type > CXL_REGLOC_RBI_MEMDEV)
> > -                       continue;
> > -
> > -               base = cxl_pci_map_regblock(cxlm, bar, offset);
> > -               if (!base)
> > -                       return -ENOMEM;
> > -
> > -               map = &maps[n_maps];
> > -               map->barno = bar;
> > -               map->block_offset = offset;
> > -               map->reg_type = reg_type;
> > +               ret = cxl_get_register_block(pdev, types[i], &map);
> > +               if (ret)
> > +                       break;
> >
> > -               ret = cxl_probe_regs(cxlm, base + offset, map);
> > +               base = cxl_pci_map_regblock(cxlm, map.barno, map.block_offset);
> > +               if (!base) {
> > +                       ret = -ENXIO;
> > +                       break;
> > +               }
> >
> > -               /* Always unmap the regblock regardless of probe success */
> > +               ret = cxl_probe_regs(cxlm, base + map.block_offset, &map);
> >                 cxl_pci_unmap_regblock(cxlm, base);
> > -
> >                 if (ret)
> > -                       return ret;
> > -
> > -               n_maps++;
> > -       }
> > -
> > -       pci_release_mem_regions(pdev);
> > +                       break;
> >
> > -       for (i = 0; i < n_maps; i++) {
> > -               ret = cxl_map_regs(cxlm, &maps[i]);
> > +               ret = cxl_map_regs(cxlm, &map);
> >                 if (ret)
> >                         break;
> >         }
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index 8c1a58813816..7d3e4bf06b45 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -20,13 +20,15 @@
> >  #define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> >
> >  /* Register Block Identifier (RBI) */
> > -#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
> > -#define CXL_REGLOC_RBI_EMPTY 0
> > -#define CXL_REGLOC_RBI_COMPONENT 1
> > -#define CXL_REGLOC_RBI_VIRT 2
> > -#define CXL_REGLOC_RBI_MEMDEV 3
> > -#define CXL_REGLOC_RBI_TYPES CXL_REGLOC_RBI_MEMDEV + 1
> > +enum cxl_regloc_type {
> > +       CXL_REGLOC_RBI_EMPTY = 0,
> > +       CXL_REGLOC_RBI_COMPONENT,
> > +       CXL_REGLOC_RBI_VIRT,
> > +       CXL_REGLOC_RBI_MEMDEV,
> > +       CXL_REGLOC_RBI_TYPES
> > +};
> 
> This looks like another change that can go into its own patch.
> 
> >
> > +#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
> >  #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
> >
> >  #endif /* __CXL_PCI_H__ */
> > --
> > 2.33.0
> >
