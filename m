Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D273C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 23:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E23D60F0F
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 23:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhKAXQP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 19:16:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:29037 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232381AbhKAXQP (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Nov 2021 19:16:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="229861875"
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="229861875"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 15:56:18 -0700
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="599200018"
Received: from jisears-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.137.88])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 15:56:17 -0700
Date:   Mon, 1 Nov 2021 15:56:16 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 15/28] cxl/core: Introduce API to scan switch ports
Message-ID: <20211101225616.35cbr5mugssy35du@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-16-ben.widawsky@intel.com>
 <CAPcyv4hqHRjDnmkcJpUA1ejMumfP_uX1axg1cdDRKFUFUbp35Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hqHRjDnmkcJpUA1ejMumfP_uX1axg1cdDRKFUFUbp35Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-31 22:39:43, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > The CXL drivers encapsulate the components that direct memory traffic in
> > an entity known as a cxl_port. Compute Express Link specifies three such
> > components: hostbridge (ie. a collection of root ports), switches, and
> > endpoints. There are currently drivers that create these ports for the
> > hostbridges and the endpoints (cxl_acpi and cxl_mem). The new API
> > introduced allows callers to initiate a scan down from the hostbridge
> > and create ports for switches in the CXL topology.
> >
> > The intended user of this API is for endpoint devices. An endpoint
> > device will need to determine if it is CXL.mem capable, which requires
> > all components in the path from hostbridge to the endpoint to be CXL.mem
> > capable. Once an endpoint device determines it's connected to a CXL
> > capable root port, it can call this API to fill in all the ports in
> > between the hostbridge and itself.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  .../driver-api/cxl/memory-devices.rst         |   6 +
> >  drivers/cxl/core/Makefile                     |   1 +
> >  drivers/cxl/core/bus.c                        | 145 ++++++++++++++++++
> >  drivers/cxl/core/pci.c                        |  99 ++++++++++++
> >  drivers/cxl/cxl.h                             |   2 +
> >  drivers/cxl/pci.h                             |   6 +
> >  drivers/cxl/port.c                            |   2 +-
> >  tools/testing/cxl/Kbuild                      |   1 +
> >  8 files changed, 261 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/cxl/core/pci.c
> >
> > diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> > index fbf0393cdddc..547336c95593 100644
> > --- a/Documentation/driver-api/cxl/memory-devices.rst
> > +++ b/Documentation/driver-api/cxl/memory-devices.rst
> > @@ -47,6 +47,12 @@ CXL Core
> >  .. kernel-doc:: drivers/cxl/core/bus.c
> >     :identifiers:
> >
> > +.. kernel-doc:: drivers/cxl/core/pci.c
> > +   :doc: cxl pci
> > +
> > +.. kernel-doc:: drivers/cxl/core/pci.c
> > +   :identifiers:
> > +
> >  .. kernel-doc:: drivers/cxl/core/pmem.c
> >     :doc: cxl pmem
> >
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 07eb8e1fb8a6..9d33d2d5bf09 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -7,3 +7,4 @@ cxl_core-y += pmem.o
> >  cxl_core-y += regs.o
> >  cxl_core-y += memdev.o
> >  cxl_core-y += mbox.o
> > +cxl_core-y += pci.o
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index c7e1894d503b..f10e7d5b22a4 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/idr.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> > +#include <pci.h>
> >  #include "core.h"
> >
> >  /**
> > @@ -445,6 +446,150 @@ struct cxl_port *devm_cxl_add_port(struct device *uport,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> >
> > +void devm_cxl_remove_port(struct cxl_port *port)
> > +{
> > +       down_read(&root_host_sem);
> > +       if (cxl_root_host) {
> > +               devm_release_action(cxl_root_host, cxl_unlink_uport, port);
> > +               devm_release_action(cxl_root_host, unregister_port, port);
> > +       }
> > +       up_read(&root_host_sem);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_cxl_remove_port);
> 
> If the scan establishes the property that all child ports are devm
> allocated with their cxl_port-parent, and only if the cxl_port-parent
> is bound to its driver then I think we don't need to play
> devm_release_action games().
> 

We had discussed this previously. I was running into an issue when unloading
cxl_mem. I needed a way to remove the endpoint port and this was your
recommendation. Are you suggesting if the chain is set up correctly, I don't
need to do anything?

I don't remember exactly what was blowing up but I can try again after things
are properly parented.

> > +
> > +static int match_port(struct device *dev, const void *data)
> > +{
> > +       struct pci_dev *pdev = (struct pci_dev *)data;
> > +
> > +       if (dev->type != &cxl_port_type)
> > +               return 0;
> > +
> > +       return to_cxl_port(dev)->uport == &pdev->dev;
> > +}
> > +
> > +static struct cxl_port *find_cxl_port(struct pci_dev *usp)
> > +{
> > +       struct device *port_dev;
> > +
> > +       if (!pci_is_pcie(usp) || pci_pcie_type(usp) != PCI_EXP_TYPE_UPSTREAM)
> > +               return NULL;
> > +
> > +       port_dev = bus_find_device(&cxl_bus_type, NULL, usp, match_port);
> > +       if (port_dev)
> > +               return to_cxl_port(port_dev);
> > +
> > +       return NULL;
> > +}
> > +
> > +static int add_upstream_port(struct device *host, struct pci_dev *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct cxl_port *parent_port;
> > +       struct cxl_register_map map;
> > +       struct cxl_port *port;
> > +       int rc;
> > +
> > +       /*
> > +        * Upstream ports must be connected to a downstream port or root port.
> > +        * That downstream or root port must have a parent.
> > +        */
> > +       if (!pdev->dev.parent->parent)
> > +               return -ENXIO;
> > +
> > +       /* A port is useless if there are no component registers */
> > +       rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > +       if (rc)
> > +               return rc;
> > +
> > +       parent_port = find_cxl_port(to_pci_dev(pdev->dev.parent->parent));
> 
> This deref chain is unreadable. It wants a helper if it stays, but I
> can't immediately think of a reason to ever need to look at a
> grandparent in the hierarchy.

The goal is to be able to find the next PCIe port up in the chain.

My understanding was:
pdev = PCIe upstream switch
pdev->dev.parent = PCIe downstream switch connected to pdev.
pdev->dev.parent->parent = PCIe upstream switch connected to pdev->dev.parent

I was unable to find an idiomatic way to do that. I'm open to suggestions.

> 
> > +       if (!parent_port)
> > +               return -ENODEV;
> > +
> > +       port = devm_cxl_add_port(dev, cxl_reg_block(pdev, &map), parent_port);
> 
> This is broken because the pci device being used here does not have a
> driver that knows about CXL bus events.

I don't understand this, but I'd like to. Doesn't this make a port device which
gets probed by the port driver? Why does the PCI device matter?

(I'll mention again, switch code is not tested).

> 
> > +       put_device(&parent_port->dev);
> > +       if (IS_ERR(port))
> > +               dev_err(dev, "Failed to add upstream port %ld\n",
> > +                       PTR_ERR(port));
> > +       else
> > +               dev_dbg(dev, "Added CXL port\n");
> > +
> > +       return rc;
> > +}
> > +
> > +static int add_downstream_port(struct pci_dev *pdev)
> > +{
> > +       resource_size_t creg = CXL_RESOURCE_NONE;
> > +       struct device *dev = &pdev->dev;
> > +       struct cxl_port *parent_port;
> > +       struct cxl_register_map map;
> > +       u32 lnkcap, port_num;
> > +       int rc;
> > +
> > +       /*
> > +        * Ports are to be scanned from top down. Therefore, the upstream port
> > +        * must already exist.
> > +        */
> > +       parent_port = find_cxl_port(to_pci_dev(pdev->dev.parent));
> > +       if (!parent_port)
> > +               return -ENODEV;
> > +
> > +       /*
> > +        * The spec mandates component registers are present but the
> > +        * driver does not.
> 
> What is this trying to convey?
> 

That I'm not validating the hardware, and even though component registers are
mandatory, the driver will move on even if they're not found. This functionality
may need to change in the future and so I left the comment there.

> > +        */
> > +       rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > +       if (!rc)
> > +               creg = cxl_reg_block(pdev, &map);
> > +
> > +       if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> > +                                 &lnkcap) != PCIBIOS_SUCCESSFUL)
> > +               return 1;
> > +       port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> > +
> > +       rc = cxl_add_dport(parent_port, dev, port_num, creg, false);
> > +       put_device(&parent_port->dev);
> 
> What get_device() is this paired with?
> 

find_cxl_port() holds a reference. I had a comment somewhere to that effect but it
seems to have disappeared. Since it sounds like this code might be changing, I
won't fix that yet.

> > +       if (rc)
> > +               dev_err(dev, "Failed to add downstream port to %s\n",
> > +                       dev_name(&parent_port->dev));
> > +       else
> > +               dev_dbg(dev, "Added downstream port to %s\n",
> > +                       dev_name(&parent_port->dev));
> > +
> > +       return rc;
> > +}
> > +
> > +static int match_add_ports(struct pci_dev *pdev, void *data)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct device *host = data;
> > +       int rc;
> > +
> > +       /* This port has already been added... */
> > +       if (find_cxl_port(pdev))
> > +               return 0;
> > +
> > +       if (is_cxl_switch_usp((dev)))
> > +               rc = add_upstream_port(host, pdev);
> > +
> > +       if (is_cxl_switch_dsp((dev)))
> > +               rc = add_downstream_port(pdev);
> > +
> > +       return rc;
> > +}
> > +
> > +/**
> > + * cxl_scan_ports() - Adds all ports for the subtree beginning with @dport
> > + * @dport: Beginning node of the CXL topology
> > + */
> > +void cxl_scan_ports(struct cxl_dport *dport)
> > +{
> > +       struct device *d = dport->dport;
> > +       struct pci_dev *pdev = to_pci_dev(d);
> > +
> > +       pci_walk_bus(pdev->bus, match_add_ports, &dport->port->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_scan_ports);
> > +
> >  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> >  {
> >         struct cxl_dport *dport;
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > new file mode 100644
> > index 000000000000..c0cbe984c778
> > --- /dev/null
> > +++ b/drivers/cxl/core/pci.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > +#include <linux/device.h>
> > +#include <linux/pci.h>
> > +#include <pci.h>
> > +
> > +/**
> > + * DOC: cxl pci
> > + *
> > + * Compute Express Link protocols are layered on top of PCIe. CXL core provides
> > + * a set of helpers for CXL interactions which occur via PCIe.
> > + */
> > +
> > +/**
> > + * is_cxl_mem_enabled() - Does the device understand CXL.mem protocol
> > + * @pdev: The PCI device for which to determine CXL enablement
> > + *
> > + * This is the most discrete determination as to whether a device supports
> > + * CXL.mem protocol. At a minimum, a CXL device must advertise it is capable of
> > + * negotiating the CXL.mem protocol while operating in Flex Bus.CXL mode. There
> > + * are other determining factors as to whether CXL.mem protocol is supported in
> > + * the path from root port to endpoint. Those other factors require a more
> > + * comprehensive survey of the CXL topology and would use is_cxl_mem_enabled()
> > + * as a cursory check.
> > + *
> > + * If the PCI device is enabled for CXL.mem protocol return true; otherwise
> > + * return false.
> > + *
> > + * TODO: Is there other architecturally visible state that can be used to infer
> > + *       CXL.mem protocol support?
> 
> I was expecting that cxl_port->dev.driver != NULL is the CXL subsystem
> source of truth.
> 
> > + */
> > +bool is_cxl_mem_enabled(struct pci_dev *pdev)
> > +{
> > +       int pcie_dvsec;
> > +       u16 dvsec_ctrl;
> > +
> > +       pcie_dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > +                                              CXL_DVSEC_PCIE_DEVICE);
> > +       if (!pcie_dvsec) {
> > +               dev_info(&pdev->dev,
> > +                        "Unable to determine CXL protocol support");
> > +               return false;
> > +       }
> > +
> > +       pci_read_config_word(pdev,
> > +                            pcie_dvsec + DVSEC_PCIE_DEVICE_CONTROL_OFFSET,
> > +                            &dvsec_ctrl);
> > +       if (!(dvsec_ctrl & DVSEC_PCIE_DEVICE_MEM_ENABLE)) {
> > +               dev_info(&pdev->dev, "CXL.mem protocol not enabled on device");
> > +               return false;
> > +       }
> 
> Per above, doesn't the port driver already check this?
> 
> > +
> > +       return true;
> > +}
> > +EXPORT_SYMBOL_GPL(is_cxl_mem_enabled);
> 
> Also per above, can't this stay internal to the port driver?
> 

At one point I think there was another consumer, so it got put here. I can be
internal to the port driver.

> > +
> > +/**
> > + * is_cxl_switch_usp() - Is the device a CXL.mem enabled switch
> > + * @dev: Device to query for switch type
> > + *
> > + * If the device is a CXL.mem capable upstream switch port return true;
> > + * otherwise return false.
> > + */
> > +bool is_cxl_switch_usp(struct device *dev)
> > +{
> > +       struct pci_dev *pdev;
> > +
> > +       if (!dev_is_pci(dev))
> > +               return false;
> > +
> > +       pdev = to_pci_dev(dev);
> > +
> > +       return pci_is_pcie(pdev) &&
> > +              pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM &&
> > +              is_cxl_mem_enabled(pdev);
> > +}
> > +EXPORT_SYMBOL_GPL(is_cxl_switch_usp);
> 
> Who uses this api outside of the core?
> 
> > +
> > +/**
> > + * is_cxl_switch_dsp() - Is the device a CXL.mem enabled switch
> > + * @dev: Device to query for switch type
> > + *
> > + * If the device is a CXL.mem capable downstream switch port return true;
> > + * otherwise return false.
> > + */
> > +bool is_cxl_switch_dsp(struct device *dev)
> > +{
> > +       struct pci_dev *pdev;
> > +
> > +       if (!dev_is_pci(dev))
> > +               return false;
> > +
> > +       pdev = to_pci_dev(dev);
> > +
> > +       return pci_is_pcie(pdev) &&
> > +              pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
> > +              is_cxl_mem_enabled(pdev);
> > +}
> > +EXPORT_SYMBOL_GPL(is_cxl_switch_dsp);
> 
> Same question... at a minimum wait to add exports until there is a user.
> 

Okay. It gets used by the mem driver, but I can remove the export here.

> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 419c2e2db6f0..03b414462416 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -309,6 +309,8 @@ struct cxl_port *to_cxl_port(struct device *dev);
> >  struct cxl_port *devm_cxl_add_port(struct device *uport,
> >                                    resource_size_t component_reg_phys,
> >                                    struct cxl_port *parent_port);
> > +void devm_cxl_remove_port(struct cxl_port *port);
> > +void cxl_scan_ports(struct cxl_dport *root_port);
> >
> >  int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
> >                   resource_size_t component_reg_phys, bool root_port);
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index fe2898b17736..9d6ca77d3e14 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -15,6 +15,8 @@
> >
> >  /* 8.1.3: PCIe DVSEC for CXL Device */
> >  #define CXL_DVSEC_PCIE_DEVICE                                  0
> > +#define   DVSEC_PCIE_DEVICE_CONTROL_OFFSET                     0xC
> > +#define     DVSEC_PCIE_DEVICE_MEM_ENABLE                       BIT(2)
> >
> >  /* 8.1.4: Non-CXL Function Map DVSEC */
> >  #define CXL_DVSEC_FUNCTION_MAP                                 2
> > @@ -57,4 +59,8 @@ enum cxl_regloc_type {
> >         ((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \
> >                            (map)->block_offset))
> >
> > +bool is_cxl_switch_usp(struct device *dev);
> > +bool is_cxl_switch_dsp(struct device *dev);
> > +bool is_cxl_mem_enabled(struct pci_dev *pdev);
> > +
> >  #endif /* __CXL_PCI_H__ */
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index ebbfb72ae995..3ddfd7673a56 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -170,7 +170,7 @@ static int enumerate_hdm_decoders(struct cxl_port *port,
> >                 if (rc)
> >                         put_device(&cxld->dev);
> >                 else
> > -                       rc = cxl_decoder_autoremove(port->uport->parent, cxld);
> > +                       rc = cxl_decoder_autoremove(&port->dev, cxld);
> 
> Looks like a hunk that got added to the wrong patch.

Yep

> 
> >                 if (rc)
> >                         dev_err(&port->dev, "Failed to add decoder\n");
> >         }
> > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > index 86deba8308a1..46db4dd345a0 100644
> > --- a/tools/testing/cxl/Kbuild
> > +++ b/tools/testing/cxl/Kbuild
> > @@ -31,6 +31,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pmem.o
> >  cxl_core-y += $(CXL_CORE_SRC)/regs.o
> >  cxl_core-y += $(CXL_CORE_SRC)/memdev.o
> >  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
> > +cxl_core-y += $(CXL_CORE_SRC)/pci.o
> >  cxl_core-y += config_check.o
> >
> >  cxl_core-y += mock_pmem.o
> > --
> > 2.33.1
> >
