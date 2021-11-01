Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE65C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 22:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0EA60FE8
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 22:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhKAWC6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:02:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:39625 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhKAWC5 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Nov 2021 18:02:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="317331182"
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="317331182"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 15:00:14 -0700
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="637959007"
Received: from jisears-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.137.88])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 15:00:13 -0700
Date:   Mon, 1 Nov 2021 15:00:10 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 13/28] cxl: Flesh out register names
Message-ID: <20211101220010.bryozhtydumb6waj@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-14-ben.widawsky@intel.com>
 <CAPcyv4i9zc4HtXJ4eQpVtGF38xMNNuFy1MwLQR5fb65Wy+XekQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i9zc4HtXJ4eQpVtGF38xMNNuFy1MwLQR5fb65Wy+XekQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-31 13:18:36, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > Get a better naming scheme in place for upcoming additions. To solidify
> > the schema, add all the DVSEC identifiers to start with.
> 
> The title and this changelog don't give anything of substance to
> review the patch.
> 
> This also looks like a rename and addition of more definitions. The
> rename has one rationale, the additional definitions have a different
> one, so split those into 2 patches, or fold the additions into the
> patch that uses them.
> 

I added more than necessary as a means to codify the naming scheme [as stated].
Many of them are not used. I can split this patch into two, though I personally
don't find it offensive to do it as one. Before I do that, I'd like to know
though if you're going to reject the patch if I'm not actually using all of the
defines later on.

> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > ---
> > See:
> > https://lore.kernel.org/linux-pci/20210913190131.xiiszmno46qie7v5@intel.com/
> 
> Perhaps summarize this above, it's not clear what's relevant from that
> thread to this patch.
> 
> > ---
> >  drivers/cxl/core/regs.c | 14 ++++++++------
> >  drivers/cxl/pci.h       | 38 ++++++++++++++++++++++++++++++--------
> >  2 files changed, 38 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index c8ab8880b81b..b837196fbf39 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -253,9 +253,11 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> >                                 struct cxl_register_map *map)
> >  {
> >         map->block_offset =
> > -               ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > -       map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> > -       map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> > +               ((u64)reg_hi << 32) |
> > +               (reg_lo & DVSEC_REGISTER_LOCATOR_BLOCK_OFFSET_LOW_MASK);
> > +       map->barno = FIELD_GET(DVSEC_REGISTER_LOCATOR_BIR_MASK, reg_lo);
> > +       map->reg_type =
> > +               FIELD_GET(DVSEC_REGISTER_LOCATOR_BLOCK_IDENTIFIER_MASK, reg_lo);
> >  }
> >
> >  /**
> > @@ -276,15 +278,15 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> >         int regloc, i;
> >
> >         regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > -                                          PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> > +                                          CXL_DVSEC_REGISTER_LOCATOR);
> >         if (!regloc)
> >                 return -ENXIO;
> >
> >         pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> >         regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> >
> > -       regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> > -       regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> > +       regloc += DVSEC_REGISTER_LOCATOR_BLOCK1_OFFSET;
> > +       regblocks = (regloc_size - DVSEC_REGISTER_LOCATOR_BLOCK1_OFFSET) / 8;
> >
> >         for (i = 0; i < regblocks; i++, regloc += 8) {
> >                 u32 reg_lo, reg_hi;
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index 12fdcb1b14e5..fe2898b17736 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -7,17 +7,36 @@
> >
> >  /*
> >   * See section 8.1 Configuration Space Registers in the CXL 2.0
> > - * Specification
> > + * Specification. Names are taken straight from the specification with "CXL" and
> > + * "DVSEC" redundancies removed.
> >   */
> >  #define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
> >  #define PCI_DVSEC_VENDOR_ID_CXL                0x1E98
> > -#define PCI_DVSEC_ID_CXL               0x0
> >
> > -#define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID       0x8
> > -#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET  0xC
> > +/* 8.1.3: PCIe DVSEC for CXL Device */
> > +#define CXL_DVSEC_PCIE_DEVICE                                  0
> >
> > -/* BAR Indicator Register (BIR) */
> > -#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> > +/* 8.1.4: Non-CXL Function Map DVSEC */
> > +#define CXL_DVSEC_FUNCTION_MAP                                 2
> > +
> > +/* 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
> > +#define CXL_DVSEC_PORT_EXTENSIONS                              3
> > +
> > +/* 8.1.6: GPF DVSEC for CXL Port */
> > +#define CXL_DVSEC_PORT_GPF                                     4
> > +
> > +/* 8.1.7: GPF DVSEC for CXL Device */
> > +#define CXL_DVSEC_DEVICE_GPF                                   5
> > +
> > +/* 8.1.8: PCIe DVSEC for Flex Bus Port */
> > +#define CXL_DVSEC_PCIE_FLEXBUS_PORT                            7
> > +
> > +/* 8.1.9: Register Locator DVSEC */
> > +#define CXL_DVSEC_REGISTER_LOCATOR                             8
> > +#define   DVSEC_REGISTER_LOCATOR_BLOCK1_OFFSET                 0xC
> > +#define     DVSEC_REGISTER_LOCATOR_BIR_MASK                    GENMASK(2, 0)
> > +#define            DVSEC_REGISTER_LOCATOR_BLOCK_IDENTIFIER_MASK        GENMASK(15, 8)
> > +#define     DVSEC_REGISTER_LOCATOR_BLOCK_OFFSET_LOW_MASK       GENMASK(31, 16)
> >
> >  /* Register Block Identifier (RBI) */
> >  enum cxl_regloc_type {
> > @@ -28,8 +47,11 @@ enum cxl_regloc_type {
> >         CXL_REGLOC_RBI_TYPES
> >  };
> >
> > -#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
> > -#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
> > +/* 8.1.10: MLD DVSEC */
> > +#define CXL_DVSEC_MLD                                          9
> > +
> > +/* 14.16.1 CXL Device Test Capability Advertisement */
> > +#define CXL_DVSEC_PCIE_TEST_CAPABILITY                         10
> >
> >  #define cxl_reg_block(pdev, map)                                               \
> >         ((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \
> > --
> > 2.33.1
> >
