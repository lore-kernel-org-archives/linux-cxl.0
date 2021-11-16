Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C70AC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Nov 2021 18:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2760761A02
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Nov 2021 18:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhKPSIc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:08:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:19578 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236111AbhKPSIb (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 16 Nov 2021 13:08:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="233719110"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="233719110"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 10:02:21 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="567375691"
Received: from yadavhan-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.138.51])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 10:02:20 -0800
Date:   Tue, 16 Nov 2021 10:02:18 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 15/28] cxl/core: Introduce API to scan switch ports
Message-ID: <20211116180218.zesqkzpusta2bfzi@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-16-ben.widawsky@intel.com>
 <CAPcyv4hqHRjDnmkcJpUA1ejMumfP_uX1axg1cdDRKFUFUbp35Q@mail.gmail.com>
 <20211101225616.35cbr5mugssy35du@intel.com>
 <CAPcyv4gYiun5mnRbzw_OP_+6Nk+UzwBDHuUazM_QpYcdX7hzKA@mail.gmail.com>
 <20211116165018.eboy6xc7y6lya635@intel.com>
 <CAPcyv4iHz0Zi1Lh9ZbDL2myLkYw=Vg_HWYjN1KdBBnY0o4pD5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iHz0Zi1Lh9ZbDL2myLkYw=Vg_HWYjN1KdBBnY0o4pD5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-16 09:51:36, Dan Williams wrote:
> On Tue, Nov 16, 2021 at 8:51 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-11-01 18:45:57, Dan Williams wrote:
> > > On Mon, Nov 1, 2021 at 3:56 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > On 21-10-31 22:39:43, Dan Williams wrote:
> > > > > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > > >
> > > > > > The CXL drivers encapsulate the components that direct memory traffic in
> > > > > > an entity known as a cxl_port. Compute Express Link specifies three such
> > > > > > components: hostbridge (ie. a collection of root ports), switches, and
> > > > > > endpoints. There are currently drivers that create these ports for the
> > > > > > hostbridges and the endpoints (cxl_acpi and cxl_mem). The new API
> > > > > > introduced allows callers to initiate a scan down from the hostbridge
> > > > > > and create ports for switches in the CXL topology.
> > > > > >
> > > > > > The intended user of this API is for endpoint devices. An endpoint
> > > > > > device will need to determine if it is CXL.mem capable, which requires
> > > > > > all components in the path from hostbridge to the endpoint to be CXL.mem
> > > > > > capable. Once an endpoint device determines it's connected to a CXL
> > > > > > capable root port, it can call this API to fill in all the ports in
> > > > > > between the hostbridge and itself.
> > > > > >
> > > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > > ---
> > > > > >  .../driver-api/cxl/memory-devices.rst         |   6 +
> > > > > >  drivers/cxl/core/Makefile                     |   1 +
> > > > > >  drivers/cxl/core/bus.c                        | 145 ++++++++++++++++++
> > > > > >  drivers/cxl/core/pci.c                        |  99 ++++++++++++
> > > > > >  drivers/cxl/cxl.h                             |   2 +
> > > > > >  drivers/cxl/pci.h                             |   6 +
> > > > > >  drivers/cxl/port.c                            |   2 +-
> > > > > >  tools/testing/cxl/Kbuild                      |   1 +
> > > > > >  8 files changed, 261 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 drivers/cxl/core/pci.c
> > > > > >
> > > > > > diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> > > > > > index fbf0393cdddc..547336c95593 100644
> > > > > > --- a/Documentation/driver-api/cxl/memory-devices.rst
> > > > > > +++ b/Documentation/driver-api/cxl/memory-devices.rst
> > > > > > @@ -47,6 +47,12 @@ CXL Core
> > > > > >  .. kernel-doc:: drivers/cxl/core/bus.c
> > > > > >     :identifiers:
> > > > > >
> > > > > > +.. kernel-doc:: drivers/cxl/core/pci.c
> > > > > > +   :doc: cxl pci
> > > > > > +
> > > > > > +.. kernel-doc:: drivers/cxl/core/pci.c
> > > > > > +   :identifiers:
> > > > > > +
> > > > > >  .. kernel-doc:: drivers/cxl/core/pmem.c
> > > > > >     :doc: cxl pmem
> > > > > >
> > > > > > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > > > > > index 07eb8e1fb8a6..9d33d2d5bf09 100644
> > > > > > --- a/drivers/cxl/core/Makefile
> > > > > > +++ b/drivers/cxl/core/Makefile
> > > > > > @@ -7,3 +7,4 @@ cxl_core-y += pmem.o
> > > > > >  cxl_core-y += regs.o
> > > > > >  cxl_core-y += memdev.o
> > > > > >  cxl_core-y += mbox.o
> > > > > > +cxl_core-y += pci.o
> > > > > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > > > > index c7e1894d503b..f10e7d5b22a4 100644
> > > > > > --- a/drivers/cxl/core/bus.c
> > > > > > +++ b/drivers/cxl/core/bus.c
> > > > > > @@ -8,6 +8,7 @@
> > > > > >  #include <linux/idr.h>
> > > > > >  #include <cxlmem.h>
> > > > > >  #include <cxl.h>
> > > > > > +#include <pci.h>
> > > > > >  #include "core.h"
> > > > > >
> > > > > >  /**
> > > > > > @@ -445,6 +446,150 @@ struct cxl_port *devm_cxl_add_port(struct device *uport,
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> > > > > >
> > > > > > +void devm_cxl_remove_port(struct cxl_port *port)
> > > > > > +{
> > > > > > +       down_read(&root_host_sem);
> > > > > > +       if (cxl_root_host) {
> > > > > > +               devm_release_action(cxl_root_host, cxl_unlink_uport, port);
> > > > > > +               devm_release_action(cxl_root_host, unregister_port, port);
> > > > > > +       }
> > > > > > +       up_read(&root_host_sem);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(devm_cxl_remove_port);
> > > > >
> > > > > If the scan establishes the property that all child ports are devm
> > > > > allocated with their cxl_port-parent, and only if the cxl_port-parent
> > > > > is bound to its driver then I think we don't need to play
> > > > > devm_release_action games().
> > > > >
> > > >
> > > > We had discussed this previously. I was running into an issue when unloading
> > > > cxl_mem. I needed a way to remove the endpoint port and this was your
> > > > recommendation. Are you suggesting if the chain is set up correctly, I don't
> > > > need to do anything?
> > >
> > > I think if the chain is set up correctly then you don't need to do
> > > anything special. The endpoint port would be devm registered by the
> > > cxl_memdev driver to its parent cxl_port provided that port is
> > > actively attached to its driver.
> > >
> > > > I don't remember exactly what was blowing up but I can try again after things
> > > > are properly parented.
> > >
> > > Cool.
> > >
> > > >
> > > > > > +
> > > > > > +static int match_port(struct device *dev, const void *data)
> > > > > > +{
> > > > > > +       struct pci_dev *pdev = (struct pci_dev *)data;
> > > > > > +
> > > > > > +       if (dev->type != &cxl_port_type)
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       return to_cxl_port(dev)->uport == &pdev->dev;
> > > > > > +}
> > > > > > +
> > > > > > +static struct cxl_port *find_cxl_port(struct pci_dev *usp)
> > > > > > +{
> > > > > > +       struct device *port_dev;
> > > > > > +
> > > > > > +       if (!pci_is_pcie(usp) || pci_pcie_type(usp) != PCI_EXP_TYPE_UPSTREAM)
> > > > > > +               return NULL;
> > > > > > +
> > > > > > +       port_dev = bus_find_device(&cxl_bus_type, NULL, usp, match_port);
> > > > > > +       if (port_dev)
> > > > > > +               return to_cxl_port(port_dev);
> > > > > > +
> > > > > > +       return NULL;
> > > > > > +}
> > > > > > +
> > > > > > +static int add_upstream_port(struct device *host, struct pci_dev *pdev)
> > > > > > +{
> > > > > > +       struct device *dev = &pdev->dev;
> > > > > > +       struct cxl_port *parent_port;
> > > > > > +       struct cxl_register_map map;
> > > > > > +       struct cxl_port *port;
> > > > > > +       int rc;
> > > > > > +
> > > > > > +       /*
> > > > > > +        * Upstream ports must be connected to a downstream port or root port.
> > > > > > +        * That downstream or root port must have a parent.
> > > > > > +        */
> > > > > > +       if (!pdev->dev.parent->parent)
> > > > > > +               return -ENXIO;
> > > > > > +
> > > > > > +       /* A port is useless if there are no component registers */
> > > > > > +       rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > > > > > +       if (rc)
> > > > > > +               return rc;
> > > > > > +
> > > > > > +       parent_port = find_cxl_port(to_pci_dev(pdev->dev.parent->parent));
> > > > >
> > > > > This deref chain is unreadable. It wants a helper if it stays, but I
> > > > > can't immediately think of a reason to ever need to look at a
> > > > > grandparent in the hierarchy.
> > > >
> > > > The goal is to be able to find the next PCIe port up in the chain.
> > > >
> > > > My understanding was:
> > > > pdev = PCIe upstream switch
> > > > pdev->dev.parent = PCIe downstream switch connected to pdev.
> > > > pdev->dev.parent->parent = PCIe upstream switch connected to pdev->dev.parent
> > > >
> > > > I was unable to find an idiomatic way to do that. I'm open to suggestions.
> > >
> > > Oh ok, I see it now, but I think this can be done in pure CXL terms
> > > and generic devices with the assumption that the parent device of a
> > > cxl_memdev must be a dport. Then this works whether the parent port is
> > > a platform device like ACPI or cxl_test, or a PCIe device.
> > >
> > > static int port_has_dport(struct device *dev, const void *dport_dev)
> > > {
> > >         int found = 0;
> > >         struct cxl_port *port;
> > >         struct cxl_dport *dport;
> > >
> > >         if (dev->type != &cxl_port_type)
> > >                 return 0;
> > >         port = to_cxl_port(dev);
> > >
> > >         device_lock(&port->dev);
> > >         list_for_each_entry (dport, &port->dports, list)
> > >                 if (dport->dport == dport_dev) {
> > >                         found = 1;
> > >                         break;
> > >                 }
> > >         device_unlock(&port->dev);
> > >
> > >         return found;
> > > }
> > >
> > > struct cxl_port *find_parent_cxl_port(struct cxl_memdev *cxlmd)
> > > {
> > >         return bus_find_device(&cxl_bus_type, NULL, cxlmd->dev.parent,
> > >                                port_has_dport);
> > > }
> > >
> >
> > I'm squinting at this and wondering what I will have to change to make it work.
> >
> > This logic you're asking me to change is the code which is adding the switches
> > to the port hierarchy (before the memdev adds itself as a port). I first need to
> > build that before I can check if the dport matches cxlmd->dev.parent, right?
> >
> > Since I foolishly added this patch without the consumer, I'll outline here the
> > order.
> >
> > 1. memdev driver walks up hierarchy to find root port & check for switches
> > 2. if parent.driver goto 6 (parent is CXL 2.0 capable root port)
> > 3. starting from the root port this endpoint is connected to, walk down the
> >    topology and add all upstream and downstream ports
> > 4. if parent.driver goto 6 (parent is CXL 2.0 DSP)
> > 5. ERROR - don't bind
> > 6. Add self as port
> >
> > So I'm not seeing how this can work without something like I already have.
> > Please advise. For now, I'll keep my existing logic but call the function
> > find_parent_cxl_port() so we can replace it with something more palatable.
> 
> I am assuming that the grandparent of a memdev must be a dport, and
> the grandparent of a dport must be another dport (until the root is
> reached). With that assumption the topology can be built up
> incrementally without needing to explicitly verify PCIE port types.
> Something like the following where @dev is the endpoint memdev.
> 
>         while (dport = grandparent(dev)) {
>                 if (!is_cxl_dport(dport))
>                         if (is_cxl_dport(grandparent(dport)))
>                                 /* add a new cxl_port */;
>                         else {
>                                 /* walk up and retry */;
>                                 continue;
>                         }
>                 port = dport->port;
>                 if (port->dev.driver)
>                         /* good to go, CXL.mem is enabled all the way
> to @dport */
>                 else
>                         /* CXL.mem is disabled from @dport down */
>         }
> 
> ...where that needs repeating until it either finds a disabled
> cxl_port, or until it stops adding new cxl_ports. Does that match your
> proposal?

I think I'm not conveying something properly, or I'm not fully understanding
you. The dports can only be added as you enumerate switches (assuming the
endpoint isn't directly connected to the root port). I'm specifically referring
to the enumeration part of the code where the switch port/dports are added. This
comes after the memdev driver walks up to find there is a switch in the middle.

I've done some cleanup, let me resend and we can further discuss on that. I
think it will be clearer with the last two patches here combined.

