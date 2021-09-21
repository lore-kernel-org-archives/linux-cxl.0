Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1898AC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 19:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE15061184
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 19:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhIUTIK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:08:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:22358 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231325AbhIUTIJ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 21 Sep 2021 15:08:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="210682922"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="210682922"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 12:06:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="557063409"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.132.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 12:06:38 -0700
Date:   Tue, 21 Sep 2021 12:06:37 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] cxl: Move register block enumeration to core
Message-ID: <20210921190637.x54hh4aaom5auffs@intel.com>
References: <20210920225638.1729482-1-ben.widawsky@intel.com>
 <CAPcyv4ja65PA5qjKPW4dYsVUCEiEDKD65_5vw15VryYL1h7=QQ@mail.gmail.com>
 <20210921164401.h46pjfwkpr7m2ven@intel.com>
 <CAPcyv4idgH7=4aVZWsUfeiqJyC_rh0+F5dkuWLiomL1oao7k7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4idgH7=4aVZWsUfeiqJyC_rh0+F5dkuWLiomL1oao7k7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-21 11:42:55, Dan Williams wrote:
> On Tue, Sep 21, 2021 at 9:44 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-09-21 07:07:13, Dan Williams wrote:
> > > On Mon, Sep 20, 2021 at 3:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > CXL drivers or cxl_core itself will require the ability to map component
> > > > registers in order to map HDM decoder resources amongst other things.
> > > > Much of the register mapping code has already moved into cxl_core. The
> > > > code to pull the BAR number and block office remained within cxl_pci
> >
> > s/office/offset - before anyone else notices...
> >
> > > > because there was no need to move it. Upcoming work will require this
> > > > functionality to be available outside of cxl_pci.
> > > >
> > > > There are two intentional functional changes:
> > > > 1. cxl_pci: If there is more than 1 component, or device register block,
> > > >    only the first one (of each) is checked. Previous logic checked all
> > > >    duplicate register blocks and additionally attempted to map unused
> > > >    register blocks if present.
> > > > 2. cxl_pci: No more dev_dbg for unused register blocks
> > >
> > > Why not break these out into separate patches before moving the code?
> > > It makes it easier to review, and it increases the precision of future
> > > Fixes: patches if necessary.
> > >
> >
> > I can. Indeed it was my instinct to do so. I went against my instinct...
> >
> > What are you thinking (something like...)?
> > 1. Change register locator identifiers to enum
> > 2. refactor cxl_pci to use the new find() function.
> 
> In order to ease the coordination pressure perhaps you could define a
> __weak copy of this helper in the CXL core with a comment of:
> 
> /* TODO: Delete once this same function is available from the PCI core */
> 
> ...and then separately send the refactor series to all the stakeholders.

You mean so I can work on the other drivers without being blocked on this? I
think as long as you generally agree with the final outcome, I'll be okay to
just keep working on top of this.

> 
> > 3. Remove map.type
> 
> Inject a patch for:
> 
> "No more dev_dbg() for unused register blocks"
> 
> ...here?
> 

Sure.

> > 4. move required functionality to core
> >
> > > >
> > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > ---
> > > >  drivers/cxl/core/regs.c |  89 ++++++++++++++++++++++++++++++++++
> > > >  drivers/cxl/cxl.h       |   3 ++
> > > >  drivers/cxl/pci.c       | 104 +++++++---------------------------------
> > > >  drivers/cxl/pci.h       |  14 +++---
> > > >  4 files changed, 116 insertions(+), 94 deletions(-)
> > > >
> > > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > > index 41de4a136ecd..ef6164ef449f 100644
> > > > --- a/drivers/cxl/core/regs.c
> > > > +++ b/drivers/cxl/core/regs.c
> > > > @@ -5,6 +5,7 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/pci.h>
> > > >  #include <cxlmem.h>
> > > > +#include <pci.h>
> > > >
> > > >  /**
> > > >   * DOC: cxl registers
> > > > @@ -247,3 +248,91 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> > > >         return 0;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(cxl_map_device_regs);
> > > > +
> > > > +static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi, u8 *bar,
> > > > +                                     u64 *offset, u8 *reg_type)
> > > > +{
> > > > +       *offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > > > +       *bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> > > > +       *reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> > > > +}
> > > > +
> > > > +static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
> > > > +{
> > > > +       int pos;
> > > > +
> > > > +       pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> > > > +       if (!pos)
> > > > +               return 0;
> > > > +
> > > > +       while (pos) {
> > > > +               u16 vendor, id;
> > > > +
> > > > +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
> > > > +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
> > > > +               if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> > > > +                       return pos;
> > > > +
> > > > +               pos = pci_find_next_ext_capability(pdev, pos,
> > > > +                                                  PCI_EXT_CAP_ID_DVSEC);
> > > > +       }
> > >
> > > We punted on refactoring this for the initial driver submission
> > > because it was difficult to coordinate. Now that cxl.git is an
> > > established tree, instead of moving this it seems time to address that
> > > refactor that Bjorn asked about. Bjorn, would you be willing to carry
> > > a non-rebasing branch with such a cleanup that CXL could pull from?
> > >
> >
> > Also here:
> > https://lore.kernel.org/linux-pci/20210913190131.xiiszmno46qie7v5@intel.com/
> 
> Looks good, although I notice that find_dvsec_from_pos() from
> arch/powerpc/platforms/powernv/ocxl.c wants to start searching for the
> dvsec starting from an initial offset.
> 
> >
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * cxl_get_register_block() - Find the CXL register block by identifier
> > > > + * @pdev: The PCI device implementing the registers
> > > > + * @type: Type of register block to find
> > > > + * @map: (Output) parameters used to map the regiseter block
> > >
> > > s/regiseter/register/
> > >
> > > > + *
> > > > + * If register block is found, 0 is returned and @map is populated; else returns
> > > > + * negative error code.
> > > > + */
> > > > +int cxl_get_register_block(struct pci_dev *pdev, enum cxl_regloc_type type,
> > >
> > > Seeing this broken out again it looks like a 'find' operation rather
> > > than a 'get', but not a big deal.
> > >
> >
> > I'm okay to rename it. It also makes me realize map.type becomes a useless
> > field.
> 
> True.
