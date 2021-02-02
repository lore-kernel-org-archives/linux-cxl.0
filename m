Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BB4C433E0
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B345C64F05
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 15:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhBBP2S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235443AbhBBP0T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Feb 2021 10:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612279491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYgKeCDzCf348FNf7xkAhfu8SNW2By+My/UYI2N5YTA=;
        b=RkbGoEp+pHELtl0b2h8VPQcJ9uRlAY5FraHKkDIwdItUj+L493+YPHMEc99BL4jv502YnD
        RK6PXjysbFXLNbn7Floy+PbAEgVlZOSd7Cl3poyU9wLtYbbbexaEwt91sT0Mzyzszbzdlk
        37M8lY5UK9YdhdJWAJmN0M29wugY9T8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-3m4LvAu0Oe-ftBJo0s67Ug-1; Tue, 02 Feb 2021 10:24:50 -0500
X-MC-Unique: 3m4LvAu0Oe-ftBJo0s67Ug-1
Received: by mail-wr1-f72.google.com with SMTP id c1so12755869wrx.2
        for <linux-cxl@vger.kernel.org>; Tue, 02 Feb 2021 07:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYgKeCDzCf348FNf7xkAhfu8SNW2By+My/UYI2N5YTA=;
        b=W0ra5PZ5E70VQvgC/EZcXsWKiWlD8ULUriovNWDP5aXIWjrcTU2QIXacurFMb+YkZe
         Z9vJmwqcH12BTv8AuTcB0rKxHEZ4xurH25srg37v5xaP3C6FrmFikbxwLKHzW0f16rft
         ZKnVqljb4+H2gWL2kYsF87gyO2iPUadRKUDQGmcoB+CYTusYGfl0Mejh8I7qiwacb8Ys
         xSg1A28Q8Nu5US15ntLgm55LBn4cKrl8jNoLMOO2tpKKbigWyisUEApl4VRIbi55T4aU
         YdS643RLyS6fJt/ctwSeQSLTgVv/svQ/agwSuvhJkxGkjz4nSzdfeAKygoYyNgZC0ksa
         91mA==
X-Gm-Message-State: AOAM533zQw7Kn++TONnGubOYisu5g1TKjr/zISsbnQFeUm7Dzxj119Z6
        PR/sDryvNYIG7Lsf6Dpvgz6I/S2KpUkrMhrV8sKLG5lDU3EjI31QSIoVJtKJg32AmJqlj5ffhVl
        sLWH7uSSOc6Hxyy7JpoCE
X-Received: by 2002:adf:fc47:: with SMTP id e7mr24850957wrs.348.1612279487323;
        Tue, 02 Feb 2021 07:24:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYiSFysdxcDvlgjbvQ2inStdMHvfPGtfcArSfH+hZb4TjSguYUo/0wVcNwlKtUZx6F+BFZ8w==
X-Received: by 2002:adf:fc47:: with SMTP id e7mr24850932wrs.348.1612279487099;
        Tue, 02 Feb 2021 07:24:47 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id x125sm3006363wmx.6.2021.02.02.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 07:24:46 -0800 (PST)
Date:   Tue, 2 Feb 2021 10:24:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Subject: Re: [RFC PATCH v3 16/31] hw/pci: Plumb _UID through host bridges
Message-ID: <20210202101504-mutt-send-email-mst@kernel.org>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
 <20210202005948.241655-17-ben.widawsky@intel.com>
 <20210202150056.00003bec@Huawei.com>
MIME-Version: 1.0
In-Reply-To: <20210202150056.00003bec@Huawei.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 02, 2021 at 03:00:56PM +0000, Jonathan Cameron wrote:
> On Mon, 1 Feb 2021 16:59:33 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Currently, QEMU makes _UID equivalent to the bus number (_BBN). While
> > there is nothing wrong with doing it this way, CXL spec has a heavy
> > reliance on _UID to identify host bridges and there is no link to the
> > bus number. Having a distinct UID solves two problems. The first is it
> > gets us around the limitation of 256 (current max bus number).

Not sure I understand. You want more than 256 host bridges?

> The
> > second is it allows us to replicate hardware configurations where bus
> > number and uid aren't equivalent.

A bit more data on when this needs to be the case?

> The latter has benefits for our
> > development and debugging using QEMU.
> > 
> > The other way to do this would be to implement the expanded bus
> > numbering, but having an explicit uid makes more sense when trying to
> > replicate real hardware configurations.
> > 
> > The QEMU commandline to utilize this would be:
> >   -device pxb-cxl,id=cxl.0,bus="pcie.0",bus_nr=1,uid=x
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

However, if doing this how do we ensure UID is still unique?
What do we do for cases where UID was not specified?
One idea is to generate a string UID and just stick the bus #
in there.


> > --
> > 
> > I'm guessing this patch will be somewhat controversial. For early CXL
> > work, this can be dropped without too much heartache.
> 
> Whilst I'm not personally against, this maybe best to drop for now as you
> say.
> 
> > ---
> >  hw/i386/acpi-build.c                |  3 ++-
> >  hw/pci-bridge/pci_expander_bridge.c | 19 +++++++++++++++++++
> >  hw/pci/pci.c                        | 11 +++++++++++
> >  include/hw/pci/pci.h                |  1 +
> >  include/hw/pci/pci_bus.h            |  1 +
> >  5 files changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index cf6eb54c22..145a503e92 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1343,6 +1343,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          QLIST_FOREACH(bus, &bus->child, sibling) {
> >              uint8_t bus_num = pci_bus_num(bus);
> >              uint8_t numa_node = pci_bus_numa_node(bus);
> > +            int32_t uid = pci_bus_uid(bus);
> >  
> >              /* look only for expander root buses */
> >              if (!pci_bus_is_root(bus)) {
> > @@ -1356,7 +1357,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >              scope = aml_scope("\\_SB");
> >              dev = aml_device("PC%.02X", bus_num);
> >              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> > -            init_pci_acpi(dev, bus_num, pci_bus_is_express(bus) ? PCIE : PCI);
> > +            init_pci_acpi(dev, uid, pci_bus_is_express(bus) ? PCIE : PCI);
> >  
> >              if (numa_node != NUMA_NODE_UNASSIGNED) {
> >                  aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > index b42592e1ff..5021b60435 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -67,6 +67,7 @@ struct PXBDev {
> >  
> >      uint8_t bus_nr;
> >      uint16_t numa_node;
> > +    int32_t uid;
> >  };
> >  
> >  static PXBDev *convert_to_pxb(PCIDevice *dev)

As long as we are doing this, do we want to support a string uid too?
How about a 64 bit uid? Why not?


> > @@ -98,12 +99,20 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
> >      return pxb->numa_node;
> >  }
> >  
> > +static int32_t pxb_bus_uid(PCIBus *bus)
> > +{
> > +    PXBDev *pxb = convert_to_pxb(bus->parent_dev);
> > +
> > +    return pxb->uid;
> > +}
> > +
> >  static void pxb_bus_class_init(ObjectClass *class, void *data)
> >  {
> >      PCIBusClass *pbc = PCI_BUS_CLASS(class);
> >  
> >      pbc->bus_num = pxb_bus_num;
> >      pbc->numa_node = pxb_bus_numa_node;
> > +    pbc->uid = pxb_bus_uid;
> >  }
> >  
> >  static const TypeInfo pxb_bus_info = {
> > @@ -329,6 +338,7 @@ static Property pxb_dev_properties[] = {
> >      /* Note: 0 is not a legal PXB bus number. */
> >      DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
> >      DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
> > +    DEFINE_PROP_INT32("uid", PXBDev, uid, -1),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > @@ -400,12 +410,21 @@ static const TypeInfo pxb_pcie_dev_info = {
> >  
> >  static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
> >  {
> > +    PXBDev *pxb = convert_to_pxb(dev);
> > +
> >      /* A CXL PXB's parent bus is still PCIe */
> >      if (!pci_bus_is_express(pci_get_bus(dev))) {
> >          error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
> >          return;
> >      }
> >  
> > +    if (pxb->uid < 0) {
> > +        error_setg(errp, "pxb-cxl devices must have a valid uid (0-2147483647)");
> > +        return;
> > +    }
> > +
> > +    /* FIXME: Check that uid doesn't collide with UIDs of other host bridges */
> > +
> >      pxb_dev_realize_common(dev, CXL, errp);
> >  }
> >  
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index adbe8aa260..bf019d91a0 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -170,6 +170,11 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
> >      return NUMA_NODE_UNASSIGNED;
> >  }
> >  
> > +static int32_t pcibus_uid(PCIBus *bus)
> > +{
> > +    return -1;
> > +}
> > +
> >  static void pci_bus_class_init(ObjectClass *klass, void *data)
> >  {
> >      BusClass *k = BUS_CLASS(klass);
> > @@ -184,6 +189,7 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
> >  
> >      pbc->bus_num = pcibus_num;
> >      pbc->numa_node = pcibus_numa_node;
> > +    pbc->uid = pcibus_uid;
> >  }
> >  
> >  static const TypeInfo pci_bus_info = {
> > @@ -530,6 +536,11 @@ int pci_bus_numa_node(PCIBus *bus)
> >      return PCI_BUS_GET_CLASS(bus)->numa_node(bus);
> >  }
> >  
> > +int pci_bus_uid(PCIBus *bus)
> > +{
> > +    return PCI_BUS_GET_CLASS(bus)->uid(bus);
> > +}
> > +
> >  static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
> >                                   const VMStateField *field)
> >  {
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index bde3697bee..a46de48ccd 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -463,6 +463,7 @@ static inline int pci_dev_bus_num(const PCIDevice *dev)
> >  }
> >  
> >  int pci_bus_numa_node(PCIBus *bus);
> > +int pci_bus_uid(PCIBus *bus);
> >  void pci_for_each_device(PCIBus *bus, int bus_num,
> >                           void (*fn)(PCIBus *bus, PCIDevice *d, void *opaque),
> >                           void *opaque);
> > diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> > index eb94e7e85c..3c9fbc55bb 100644
> > --- a/include/hw/pci/pci_bus.h
> > +++ b/include/hw/pci/pci_bus.h
> > @@ -17,6 +17,7 @@ struct PCIBusClass {
> >  
> >      int (*bus_num)(PCIBus *bus);
> >      uint16_t (*numa_node)(PCIBus *bus);
> > +    int32_t (*uid)(PCIBus *bus);
> >  };
> >  
> >  enum PCIBusFlags {

