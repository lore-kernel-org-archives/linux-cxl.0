Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A75C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 16:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199AC60D42
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 16:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhKBQj1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:39:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:15866 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234838AbhKBQi6 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 2 Nov 2021 12:38:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="292148811"
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="292148811"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 09:31:23 -0700
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="728413722"
Received: from cmwolf-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.136.231])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 09:31:22 -0700
Date:   Tue, 2 Nov 2021 09:31:21 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 09/28] cxl/acpi: Map single port host bridge
 component registers
Message-ID: <20211102163121.hyfj7yceainmppmk@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-10-ben.widawsky@intel.com>
 <CAPcyv4j+mv3+FyJd0OVBe_dUqzzYpS2gkEagiRp-Tqh9t7NMmg@mail.gmail.com>
 <20211101170750.sajcmjxdv5rajffe@intel.com>
 <CAPcyv4i-8oRjOPywtNwBef3irb8b44PzwBrEUdQ0Bxrzrju5+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i-8oRjOPywtNwBef3irb8b44PzwBrEUdQ0Bxrzrju5+w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-01 19:15:33, Dan Williams wrote:
> On Mon, Nov 1, 2021 at 10:08 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-10-31 11:03:37, Dan Williams wrote:
> > > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > Now that the port driver exists and is able to do proper decoder
> > > > enumeration of the component registers, it becomes trivial to use that
> > >
> > > This is the second occurrence of "becomes trivial" in this series,
> > > it's distracting because it immediately sets off alarm bells that the
> > > changelog is not in:
> > >
> > > Background
> > > Problem
> > > Solution
> > >
> > > ...format.
> >
> > Let me make sure I understand.
> >
> > Background: Now that the port driver exists...
> > Problem: host bridge uports can use the port driver [but don't yet]
> > Solution: This patch (the description is indeed missing).
> >
> > Is your point that I didn't document a solution, or something else?
> 
> Why do single port host bridge registers need to be mapped?
> 
> Why does the cxl_acpi driver need to do it and not the just introduced
> port driver?
> 
> This patch seems to be saying, map these because they can be mapped.
> 
> >
> >
> > >
> > > > for host bridge uports. For reasons out of scope, a functional change
> > > > would be visible if the HDM decoder was programmed by BIOS to values
> > > > other than the full address range. Similarly if a type2 device was
> > > > connected to this root port and programmed by BIOS, that can now be
> > > > acted upon accordingly.
> > >
> > > I would reserve discussion of "no functional change" for patches that
> > > are pure cleanup. In this case this patch will cause the kernel to
> > > behave differently when other conditions are met.
> >
> > True. I will remove that.
> >
> > >
> > > >
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > ---
> > > >  drivers/cxl/acpi.c | 25 ++++++++++++++++++++++++-
> > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > > index d61397055e9f..8cca0814dfb8 100644
> > > > --- a/drivers/cxl/acpi.c
> > > > +++ b/drivers/cxl/acpi.c
> > > > @@ -280,12 +280,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> > > >         struct cxl_port *root_port = arg;
> > > >         struct device *host = root_port->dev.parent;
> > > >         struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> > > > +       struct cxl_component_reg_map map;
> > > >         struct acpi_pci_root *pci_root;
> > > >         struct cxl_walk_context ctx;
> > > >         int single_port_map[1], rc;
> > > >         struct cxl_decoder *cxld;
> > > >         struct cxl_dport *dport;
> > > >         struct cxl_port *port;
> > > > +       void __iomem *crb;
> > > >
> > > >         if (!bridge)
> > > >                 return 0;
> > > > @@ -318,10 +320,31 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> > > >                 return -ENODEV;
> > > >         if (ctx.error)
> > > >                 return ctx.error;
> > > > +       /*
> > > > +        * If the host bridge has more than 1 root port, it must have registers
> > > > +        * controlling the HDM decoders. Those will be enumerated by the port
> > > > +        * driver.
> > > > +        */
> > > >         if (ctx.count > 1)
> > > >                 return 0;
> > > >
> > > > -       /* TODO: Scan CHBCR for HDM Decoder resources */
> > > > +       /*
> > > > +        * If the single ported host bridge has a component register block,
> > > > +        * simply let the port driver handle the decoder enumeration.
> > > > +        *
> > > > +        * Host bridge component registers live in the system's physical address
> > > > +        * space.
> > > > +        */
> > > > +       crb = ioremap(dport->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
> > >
> > > This looks broken, the driver for the port should be mapping dport
> > > component registers to offer services to upper layers.
> > >
> > > There's also a missing iounmap.
> > >
> >
> > Where's the missing iounmap?
> 
> Oops, sorry, don't know why I missed that. Forgive the noise.
> 
> > The port driver does what you say, but I need a way
> > to shortcircuit the case where the root port doesn't have component registers
> > which you've previously documented as allowed by spec. How would you recommend
> > doing that?
> 
> Perhaps cxl_port_probe() needs to special case the single dport case
> and just say, "no registers needed, single port == HDM passthrough".
> 
> Until there's a need to look at non-HDM registers I'd hold off on
> enabling this case. Probably that comes soon when considering IDE
> support, but no need to pre-enable that yet.

It seemed like a very simple thing to support given the port driver's existence
so it was added to remove a TODO. However, I will drop it as you request.

