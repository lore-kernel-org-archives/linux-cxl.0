Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1313EC433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 01:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31FA60EDF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 01:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhKBBsn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 21:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBBsm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Nov 2021 21:48:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB75C061714
        for <linux-cxl@vger.kernel.org>; Mon,  1 Nov 2021 18:46:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b4so11670015pgh.10
        for <linux-cxl@vger.kernel.org>; Mon, 01 Nov 2021 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJEGaQwE1GJGAwEOOSLfkoCelbGABMX6sVvad3lLMnE=;
        b=Zq80cz+OLBJ7L9C2s+8ls/J/mu8o7gFNGSAFE0BMr5N1nf0h2hebrLnbOX1InAIC6o
         2zRBOu2ONULeeAI3wJ7cxrqVE9Zs7hMH46WrbXb05hB0TD9vxMkiAe17FtyViX4+V2WW
         2lEkIsSdv0dlfHHatMLYEJzNS53BhrXXWXSplIRoUiBq1NgKG9LSzXXdOWnZ1lIjUrzj
         CPL+E7KXiZ+QytXNw77/fz8/3YMs+8AckK/O1RNRaMV44gsfCiKEQDvrZVTd6fvZX8Ko
         UOtpDQdP1T+eaWMNt6UXVwlHvGAlhg+nAhnZp9nfCVCfw7nQcYbW00b0QR4lKuGxiIPK
         aGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJEGaQwE1GJGAwEOOSLfkoCelbGABMX6sVvad3lLMnE=;
        b=dcQl6L0s6Ik9ByvksQzPwAKCyv/978+hYQe0ERR8TLv2r7C49RLn3Kh9hoLt2U+DHO
         3d32OV/Kse7Y566c4HbkbXJ3COOmN7hlJJzSoP89uBwjJabiWytcJIcLWt114HHKfsss
         Qcbz7l3zR1PrWRgG5XQkZo+tnyponF7AN/5emK/h9YPi3uNm+Z7+X5q5YACScyJQq1zV
         henlDPQZvUc4Rq1Bpp0gG+UrpNomtO3ywomrOCkzg/8S1VZkNRvk1MLsMwOB5fiuqTT+
         gXQ4ha7RRut7SMPlm5PILITGMhn2QsaHqFdJRIENJvzi1tc4T+S5/Cz7wWBGhin/pU2I
         /25A==
X-Gm-Message-State: AOAM533otSRFnEMeOdm0VMT8vgfpXUlwYdG64HiIG1zuBab6hEzpQgmq
        k/6hhh7Q0d7J9MPj47s3y3uMKCsbdtZCg0fZA/9Is4unmRUUqg==
X-Google-Smtp-Source: ABdhPJwd/NDdHaiZDxvdXbIG68t17yKwQOoJQHGPNxrrwfq/RGeIRXWbv38b+CTPPdEicM3DVUwjPSoxe8gkeh71f8s=
X-Received: by 2002:a62:646:0:b0:481:1674:8e48 with SMTP id
 67-20020a620646000000b0048116748e48mr7063971pfg.86.1635817568264; Mon, 01 Nov
 2021 18:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-16-ben.widawsky@intel.com> <CAPcyv4hqHRjDnmkcJpUA1ejMumfP_uX1axg1cdDRKFUFUbp35Q@mail.gmail.com>
 <20211101225616.35cbr5mugssy35du@intel.com>
In-Reply-To: <20211101225616.35cbr5mugssy35du@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Nov 2021 18:45:57 -0700
Message-ID: <CAPcyv4gYiun5mnRbzw_OP_+6Nk+UzwBDHuUazM_QpYcdX7hzKA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/28] cxl/core: Introduce API to scan switch ports
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

On Mon, Nov 1, 2021 at 3:56 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-31 22:39:43, Dan Williams wrote:
> > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > The CXL drivers encapsulate the components that direct memory traffic in
> > > an entity known as a cxl_port. Compute Express Link specifies three such
> > > components: hostbridge (ie. a collection of root ports), switches, and
> > > endpoints. There are currently drivers that create these ports for the
> > > hostbridges and the endpoints (cxl_acpi and cxl_mem). The new API
> > > introduced allows callers to initiate a scan down from the hostbridge
> > > and create ports for switches in the CXL topology.
> > >
> > > The intended user of this API is for endpoint devices. An endpoint
> > > device will need to determine if it is CXL.mem capable, which requires
> > > all components in the path from hostbridge to the endpoint to be CXL.mem
> > > capable. Once an endpoint device determines it's connected to a CXL
> > > capable root port, it can call this API to fill in all the ports in
> > > between the hostbridge and itself.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  .../driver-api/cxl/memory-devices.rst         |   6 +
> > >  drivers/cxl/core/Makefile                     |   1 +
> > >  drivers/cxl/core/bus.c                        | 145 ++++++++++++++++++
> > >  drivers/cxl/core/pci.c                        |  99 ++++++++++++
> > >  drivers/cxl/cxl.h                             |   2 +
> > >  drivers/cxl/pci.h                             |   6 +
> > >  drivers/cxl/port.c                            |   2 +-
> > >  tools/testing/cxl/Kbuild                      |   1 +
> > >  8 files changed, 261 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/cxl/core/pci.c
> > >
> > > diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> > > index fbf0393cdddc..547336c95593 100644
> > > --- a/Documentation/driver-api/cxl/memory-devices.rst
> > > +++ b/Documentation/driver-api/cxl/memory-devices.rst
> > > @@ -47,6 +47,12 @@ CXL Core
> > >  .. kernel-doc:: drivers/cxl/core/bus.c
> > >     :identifiers:
> > >
> > > +.. kernel-doc:: drivers/cxl/core/pci.c
> > > +   :doc: cxl pci
> > > +
> > > +.. kernel-doc:: drivers/cxl/core/pci.c
> > > +   :identifiers:
> > > +
> > >  .. kernel-doc:: drivers/cxl/core/pmem.c
> > >     :doc: cxl pmem
> > >
> > > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > > index 07eb8e1fb8a6..9d33d2d5bf09 100644
> > > --- a/drivers/cxl/core/Makefile
> > > +++ b/drivers/cxl/core/Makefile
> > > @@ -7,3 +7,4 @@ cxl_core-y += pmem.o
> > >  cxl_core-y += regs.o
> > >  cxl_core-y += memdev.o
> > >  cxl_core-y += mbox.o
> > > +cxl_core-y += pci.o
> > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > index c7e1894d503b..f10e7d5b22a4 100644
> > > --- a/drivers/cxl/core/bus.c
> > > +++ b/drivers/cxl/core/bus.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/idr.h>
> > >  #include <cxlmem.h>
> > >  #include <cxl.h>
> > > +#include <pci.h>
> > >  #include "core.h"
> > >
> > >  /**
> > > @@ -445,6 +446,150 @@ struct cxl_port *devm_cxl_add_port(struct device *uport,
> > >  }
> > >  EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> > >
> > > +void devm_cxl_remove_port(struct cxl_port *port)
> > > +{
> > > +       down_read(&root_host_sem);
> > > +       if (cxl_root_host) {
> > > +               devm_release_action(cxl_root_host, cxl_unlink_uport, port);
> > > +               devm_release_action(cxl_root_host, unregister_port, port);
> > > +       }
> > > +       up_read(&root_host_sem);
> > > +}
> > > +EXPORT_SYMBOL_GPL(devm_cxl_remove_port);
> >
> > If the scan establishes the property that all child ports are devm
> > allocated with their cxl_port-parent, and only if the cxl_port-parent
> > is bound to its driver then I think we don't need to play
> > devm_release_action games().
> >
>
> We had discussed this previously. I was running into an issue when unloading
> cxl_mem. I needed a way to remove the endpoint port and this was your
> recommendation. Are you suggesting if the chain is set up correctly, I don't
> need to do anything?

I think if the chain is set up correctly then you don't need to do
anything special. The endpoint port would be devm registered by the
cxl_memdev driver to its parent cxl_port provided that port is
actively attached to its driver.

> I don't remember exactly what was blowing up but I can try again after things
> are properly parented.

Cool.

>
> > > +
> > > +static int match_port(struct device *dev, const void *data)
> > > +{
> > > +       struct pci_dev *pdev = (struct pci_dev *)data;
> > > +
> > > +       if (dev->type != &cxl_port_type)
> > > +               return 0;
> > > +
> > > +       return to_cxl_port(dev)->uport == &pdev->dev;
> > > +}
> > > +
> > > +static struct cxl_port *find_cxl_port(struct pci_dev *usp)
> > > +{
> > > +       struct device *port_dev;
> > > +
> > > +       if (!pci_is_pcie(usp) || pci_pcie_type(usp) != PCI_EXP_TYPE_UPSTREAM)
> > > +               return NULL;
> > > +
> > > +       port_dev = bus_find_device(&cxl_bus_type, NULL, usp, match_port);
> > > +       if (port_dev)
> > > +               return to_cxl_port(port_dev);
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +static int add_upstream_port(struct device *host, struct pci_dev *pdev)
> > > +{
> > > +       struct device *dev = &pdev->dev;
> > > +       struct cxl_port *parent_port;
> > > +       struct cxl_register_map map;
> > > +       struct cxl_port *port;
> > > +       int rc;
> > > +
> > > +       /*
> > > +        * Upstream ports must be connected to a downstream port or root port.
> > > +        * That downstream or root port must have a parent.
> > > +        */
> > > +       if (!pdev->dev.parent->parent)
> > > +               return -ENXIO;
> > > +
> > > +       /* A port is useless if there are no component registers */
> > > +       rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       parent_port = find_cxl_port(to_pci_dev(pdev->dev.parent->parent));
> >
> > This deref chain is unreadable. It wants a helper if it stays, but I
> > can't immediately think of a reason to ever need to look at a
> > grandparent in the hierarchy.
>
> The goal is to be able to find the next PCIe port up in the chain.
>
> My understanding was:
> pdev = PCIe upstream switch
> pdev->dev.parent = PCIe downstream switch connected to pdev.
> pdev->dev.parent->parent = PCIe upstream switch connected to pdev->dev.parent
>
> I was unable to find an idiomatic way to do that. I'm open to suggestions.

Oh ok, I see it now, but I think this can be done in pure CXL terms
and generic devices with the assumption that the parent device of a
cxl_memdev must be a dport. Then this works whether the parent port is
a platform device like ACPI or cxl_test, or a PCIe device.

static int port_has_dport(struct device *dev, const void *dport_dev)
{
        int found = 0;
        struct cxl_port *port;
        struct cxl_dport *dport;

        if (dev->type != &cxl_port_type)
                return 0;
        port = to_cxl_port(dev);

        device_lock(&port->dev);
        list_for_each_entry (dport, &port->dports, list)
                if (dport->dport == dport_dev) {
                        found = 1;
                        break;
                }
        device_unlock(&port->dev);

        return found;
}

struct cxl_port *find_parent_cxl_port(struct cxl_memdev *cxlmd)
{
        return bus_find_device(&cxl_bus_type, NULL, cxlmd->dev.parent,
                               port_has_dport);
}

> >
> > > +       if (!parent_port)
> > > +               return -ENODEV;
> > > +
> > > +       port = devm_cxl_add_port(dev, cxl_reg_block(pdev, &map), parent_port);
> >
> > This is broken because the pci device being used here does not have a
> > driver that knows about CXL bus events.
>
> I don't understand this, but I'd like to. Doesn't this make a port device which
> gets probed by the port driver? Why does the PCI device matter?

I am reacting to the first argument of this call being @dev that came
from the pci_dev that was passed in to be the "host" for the devm
operation. The devm release action triggers at driver unbind of that
host device, but that doesn't make sense because the driver for a
switch has nothing to do with CXL operation.

>
> (I'll mention again, switch code is not tested).
>
> >
> > > +       put_device(&parent_port->dev);
> > > +       if (IS_ERR(port))
> > > +               dev_err(dev, "Failed to add upstream port %ld\n",
> > > +                       PTR_ERR(port));
> > > +       else
> > > +               dev_dbg(dev, "Added CXL port\n");
> > > +
> > > +       return rc;
> > > +}
> > > +
> > > +static int add_downstream_port(struct pci_dev *pdev)
> > > +{
> > > +       resource_size_t creg = CXL_RESOURCE_NONE;
> > > +       struct device *dev = &pdev->dev;
> > > +       struct cxl_port *parent_port;
> > > +       struct cxl_register_map map;
> > > +       u32 lnkcap, port_num;
> > > +       int rc;
> > > +
> > > +       /*
> > > +        * Ports are to be scanned from top down. Therefore, the upstream port
> > > +        * must already exist.
> > > +        */
> > > +       parent_port = find_cxl_port(to_pci_dev(pdev->dev.parent));
> > > +       if (!parent_port)
> > > +               return -ENODEV;
> > > +
> > > +       /*
> > > +        * The spec mandates component registers are present but the
> > > +        * driver does not.
> >
> > What is this trying to convey?
> >
>
> That I'm not validating the hardware, and even though component registers are
> mandatory, the driver will move on even if they're not found. This functionality
> may need to change in the future and so I left the comment there.

I think that could be conveyed without comment with something like:

        if (rc)
                creg = CXL_RESOURCE_NONE;
        else
                creg = cxl_reg_block(pdev, &map);
