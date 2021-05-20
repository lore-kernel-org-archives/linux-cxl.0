Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A58EC433ED
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7D6611AD
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhETTp4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 15:45:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:52833 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234247AbhETTpz (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 20 May 2021 15:45:55 -0400
IronPort-SDR: vWr0uf08aEfwBEq4RQV+ZdBfVtgWYWrYmVV6GWA7BsjttSq8rbGjUptaIyUkqN83kbpjko3h4w
 kwltlVgBB1VA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188448412"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188448412"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 12:44:33 -0700
IronPort-SDR: oUt8a1H+dYA8PGvXDDlAlab9GX0FaOj8dFkKWoNuHQhSQhXL7WNmkH1FnVXV8wRKZf9jfbXoOE
 aGBPONjXhN/A==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440592705"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 12:44:33 -0700
Date:   Thu, 20 May 2021 12:44:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/mem: Reserve all device regions at once
Message-ID: <20210520194432.GD1837122@iweiny-DESK2.sc.intel.com>
References: <20210506223654.1310516-1-ira.weiny@intel.com>
 <20210506223654.1310516-3-ira.weiny@intel.com>
 <CAPcyv4i3V2AYqoSzA=V265aUx5VpZbMXu0zFw0nk_f3FdCr-Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i3V2AYqoSzA=V265aUx5VpZbMXu0zFw0nk_f3FdCr-Yw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 19, 2021 at 06:00:51PM -0700, Dan Williams wrote:
> On Thu, May 6, 2021 at 3:37 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > In order to remap individual register sets each bar region must be
> > reserved prior to mapping.  Because the details of individual register
> > sets are contained within the BARs themselves, the bar must be mapped 2
> > times, once to extract this information and a second time for each
> > register set.
> >
> > Rather than attempt to reserve each BAR individually and track if that
> > bar has been reserved.  Open code pcim_iomap_regions() by first
> > reserving all memory regions on the device and then mapping the bars
> > individually as needed.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/pci.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 191603b4e10b..40016709b310 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -926,9 +926,9 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32
> >  {
> >         struct pci_dev *pdev = cxlm->pdev;
> >         struct device *dev = &pdev->dev;
> > +       void __iomem *rc;
> >         u64 offset;
> >         u8 bar;
> > -       int rc;
> >
> >         offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> >         bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> > @@ -940,13 +940,14 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32
> >                 return (void __iomem *)ERR_PTR(-ENXIO);
> >         }
> >
> > -       rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> > -       if (rc) {
> > +       rc = pcim_iomap(pdev, bar, 0);
> 
> It is odd that the temporary region pinning uses non-pcim, but the
> temporary mapping using pcim.

The idea of this series was to have only the final mappings be managed. But
this particular patch does not make that change.  Therefore I continue
using pcim_iomap() for this patch.

> 
> > +       if (!rc) {
> >                 dev_err(dev, "failed to map registers\n");
> > -               return (void __iomem *)ERR_PTR(rc);
> > +               return (void __iomem *)ERR_PTR(-ENOMEM);
> 
> I think since this support is a bug/compatibility fix it should
> probably be rebased to current cxl.git#next. If you still end up
> needing to return an __iomem ERR_PTR() then use IOMEM_ERR_PTR.

Actually the type of rc has changed and I think it is best to just 'return rc;'
here.

Also, in a side conversation with Dan it seems the name would be more clear.
So I will change it.

> 
> >         }
> >
> > -       dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > +       dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ 0x%llx\n",
> 
> s/0x%llx/%#llx/

ok

> 
> > +               bar, offset);
> >
> >         return pcim_iomap_table(pdev)[bar] + offset;
> >  }
> > @@ -999,6 +1000,9 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >                 return -ENXIO;
> >         }
> >
> > +       if (pci_request_mem_regions(pdev, pci_name(pdev)))
> 
> This tells me this patch is too fine grained and can't stand alone
> because it is missing the corresponding call to
> pci_release_mem_regions(). Ideally this would be kept in the same
> scope as the temporary io mapping.

Ok, I was a bit confused why I did not need this but I don't.

Dan and I discussed this offline and because pcim_enable_device() is called all
pci functions are automatically managed.

So the core will call pci_release_mem_regions() automatically for me.  It took
a bit of time for us to understand where the release call was.

I'll add a comment to this to make this more clear.

Ira

> 
> > +               return -ENODEV;
> > +
> >         /* Get the size of the Register Locator DVSEC */
> >         pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> >         regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> > --
> > 2.28.0.rc0.12.gb6a658bd00c9
> >
