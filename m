Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F3FC433E0
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 22:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1424B64F7F
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhBBWHs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:07:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2487 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhBBWHs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Feb 2021 17:07:48 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVf2w2GN7z67kD0;
        Wed,  3 Feb 2021 06:03:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 23:07:05 +0100
Received: from localhost (10.47.79.68) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 22:07:04 +0000
Date:   Tue, 2 Feb 2021 22:06:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben@bwidawsk.net>
CC:     David Hildenbrand <david@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        Chris Browy <cbrowy@avery-design.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, Markus Armbruster <armbru@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH v3 17/31] hw/cxl/component: Implement host bridge
 MMIO (8.2.5, table 142)
Message-ID: <20210202220618.000058f6@Huawei.com>
In-Reply-To: <20210202210357.so4rwl7b2gcbceai@mail.bwidawsk.net>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
        <20210202005948.241655-18-ben.widawsky@intel.com>
        <20210202192135.000035e9@Huawei.com>
        <20210202194505.227fhhalahyhpmjy@mail.bwidawsk.net>
        <20210202204338.000033b0@Huawei.com>
        <20210202210357.so4rwl7b2gcbceai@mail.bwidawsk.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.79.68]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 2 Feb 2021 13:03:57 -0800
Ben Widawsky <ben@bwidawsk.net> wrote:

> On 21-02-02 20:43:38, Jonathan Cameron wrote:
> > On Tue, 2 Feb 2021 11:45:05 -0800
> > Ben Widawsky <ben@bwidawsk.net> wrote:
> >   
> > > On 21-02-02 19:21:35, Jonathan Cameron wrote:  
> > > > On Mon, 1 Feb 2021 16:59:34 -0800
> > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >     
> > > > > CXL host bridges themselves may have MMIO. Since host bridges don't have
> > > > > a BAR they are treated as special for MMIO.
> > > > > 
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > 
> > > > > --
> > > > > 
> > > > > It's arbitrarily chosen here to pick 0xD0000000 as the base for the host
> > > > > bridge MMIO. I'm not sure what the right way to find free space for
> > > > > platform hardcoded things like this is.    
> > > > 
> > > > Seems like this needs to come from the machine definition.
> > > > This is fairly easy for arm/virt, where there is a clearly laid out memory map.
> > > > For hw/i386 I'm less sure on how to do it.    
> > > 
> > > I think this is how to do it :D  
> > 
> > It may well be, but they you'll need to find a suitable region and document
> > it and ensure no one else ever tramples on it.  Easy to do on a physical system,
> > bit trickier in emulation.
> >   
> 
> Maybe? x86 is full of magic physical address holes. As long as it's conveyed to
> EDK via _CRS, I think it's pretty safe. If something else tries to use the same
> address, you should get a fairly obvious error.
> 
> Document somehow, yes please.
> 
> > >   
> > > > 
> > > > Having said that, for this particular magic device, we do have a PCI EP
> > > > associated with it.  How about putting all the host bridge MMIO into a
> > > > BAR of that rather than having it separate.   
> > > > That has the added advantage of making it discoverable from firmware.
> > > > 
> > > > Any normal system is going to have this is impdef for discovery anyway.
> > > >     
> > > 
> > > This is not how it's expected to work for Intel at least. If the device was
> > > discoverable you wouldn't need CEDT/CHBS. The magic host bridges are only
> > > advertised via the CEDT.  
> > 
> > I agree on a normal system (i.e. a real one) this doesn't work,
> > but then a normal system doesn't involve a magic PCI RCiEP that also happens
> > to instantiate an extra host bridge. This is what pxb_pcie is doing and
> > what your pxb_cxl is almost doing.
> >   
> > > 
> > > When I build and run QEMU for x86_64, I do not see the host bridge in the pci
> > > topology, do you (it's meant to not be there)?
> > > 
> > > 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
> > > ...
> > > 34:00.0 PCI bridge: Intel Corporation Device 7075
> > > 35:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01)
> > > 
> > > That's Q35, Root Port, and Type 3 device respectively.  
> > 
> > You don't see the host bridge, for pxb_cxl, but for pxb_pcie you do.
> > 00:06.0 Host bridge: Red Hat, Inc QEMU PCIe Expander bridge.
> > If you have another device after your pxb-cxl you'll also notice that there
> > is a hole punched in the list where you'd expect pxb-cxl to be (device number
> > skipped).  (that had me confused earlier).
> > 
> > This seems to be because no VID etc (unlike pxb-pcie).
> >   
> 
> Right. This was in an earlier version of the series and you made me realize if I
> got rid of them that it disappears. I really like that this more accurately
> represents the hardware.
> 
> I agree it can be implemented more simply, but why do it if you can accurately
> model it?

I'd like to understand all the reasons pxb_pcie is deliberately exposed and
whether any of them affect CXL cases.  Right now I'm not entirely sure what
they are.

> 
> > I gave vendor and device IDs (and a bar to test that could be done) and it
> > then appears just like pxb_pcie does.  Hence handy place to hang our
> > magic memory off so that EDK2 or similar can work with it and indeed
> > construct he CHBS as needed so we can get to this via the same paths as
> > a normal system.  It's a bit convoluted but in some ways more elegant. 
> >   
> 
> What are you looking to get out of EDK2 or similar? Anything you want to convey
> should work with _CRS, I think. That was the path I was going down.

If you go down the fixed route that's fine. Just seemed a bit convenient we had
somewhere to hang this that didn't rely on arbitrary fixed regions.

If we went with the BAR we'd need to enumerate first to get bar memory location
and then fill in the table.  Bit messy so fixed does look like a better option.

Jonathan

> 
> > Jonathan
> >   
> > >   
> > > > That would then let you drop the separate definition of CXLHost structure
> > > > though it needs a bit of figuring out what to do with the memory window
> > > > setup etc.
> > > > 
> > > > I tried hacking it together, but not gotten it working yet.
> > > >     
> > > > > ---
> > > > >  hw/pci-bridge/pci_expander_bridge.c | 53 ++++++++++++++++++++++++++++-
> > > > >  include/hw/cxl/cxl.h                |  2 ++
> > > > >  2 files changed, 54 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > > > > index 5021b60435..226a8a5fff 100644
> > > > > --- a/hw/pci-bridge/pci_expander_bridge.c
> > > > > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > > > > @@ -17,6 +17,7 @@
> > > > >  #include "hw/pci/pci_host.h"
> > > > >  #include "hw/qdev-properties.h"
> > > > >  #include "hw/pci/pci_bridge.h"
> > > > > +#include "hw/cxl/cxl.h"
> > > > >  #include "qemu/range.h"
> > > > >  #include "qemu/error-report.h"
> > > > >  #include "qemu/module.h"
> > > > > @@ -70,6 +71,12 @@ struct PXBDev {
> > > > >      int32_t uid;
> > > > >  };
> > > > >  
> > > > > +typedef struct CXLHost {
> > > > > +    PCIHostState parent_obj;
> > > > > +
> > > > > +    CXLComponentState cxl_cstate;
> > > > > +} CXLHost;
> > > > > +
> > > > >  static PXBDev *convert_to_pxb(PCIDevice *dev)
> > > > >  {
> > > > >      /* A CXL PXB's parent bus is PCIe, so the normal check won't work */
> > > > > @@ -85,6 +92,9 @@ static GList *pxb_dev_list;
> > > > >  
> > > > >  #define TYPE_PXB_HOST "pxb-host"
> > > > >  
> > > > > +#define TYPE_PXB_CXL_HOST "pxb-cxl-host"
> > > > > +#define PXB_CXL_HOST(obj) OBJECT_CHECK(CXLHost, (obj), TYPE_PXB_CXL_HOST)
> > > > > +
> > > > >  static int pxb_bus_num(PCIBus *bus)
> > > > >  {
> > > > >      PXBDev *pxb = convert_to_pxb(bus->parent_dev);
> > > > > @@ -198,6 +208,46 @@ static const TypeInfo pxb_host_info = {
> > > > >      .class_init    = pxb_host_class_init,
> > > > >  };
> > > > >  
> > > > > +static void pxb_cxl_realize(DeviceState *dev, Error **errp)
> > > > > +{
> > > > > +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> > > > > +    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
> > > > > +    CXLHost *cxl = PXB_CXL_HOST(dev);
> > > > > +    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
> > > > > +    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
> > > > > +
> > > > > +    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
> > > > > +                                      TYPE_PXB_CXL_HOST);
> > > > > +    sysbus_init_mmio(sbd, mr);
> > > > > +
> > > > > +    /* FIXME: support multiple host bridges. */
> > > > > +    sysbus_mmio_map(sbd, 0, CXL_HOST_BASE +
> > > > > +                            memory_region_size(mr) * pci_bus_uid(phb->bus));
> > > > > +}
> > > > > +
> > > > > +static void pxb_cxl_host_class_init(ObjectClass *class, void *data)
> > > > > +{
> > > > > +    DeviceClass *dc = DEVICE_CLASS(class);
> > > > > +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
> > > > > +
> > > > > +    hc->root_bus_path = pxb_host_root_bus_path;
> > > > > +    dc->fw_name = "cxl";
> > > > > +    dc->realize = pxb_cxl_realize;
> > > > > +    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
> > > > > +    dc->user_creatable = false;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * This is a device to handle the MMIO for a CXL host bridge. It does nothing
> > > > > + * else.
> > > > > + */
> > > > > +static const TypeInfo cxl_host_info = {
> > > > > +    .name          = TYPE_PXB_CXL_HOST,
> > > > > +    .parent        = TYPE_PCI_HOST_BRIDGE,
> > > > > +    .instance_size = sizeof(CXLHost),
> > > > > +    .class_init    = pxb_cxl_host_class_init,
> > > > > +};
> > > > > +
> > > > >  /*
> > > > >   * Registers the PXB bus as a child of pci host root bus.
> > > > >   */
> > > > > @@ -272,7 +322,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
> > > > >          dev_name = dev->qdev.id;
> > > > >      }
> > > > >  
> > > > > -    ds = qdev_new(TYPE_PXB_HOST);
> > > > > +    ds = qdev_new(type == CXL ? TYPE_PXB_CXL_HOST : TYPE_PXB_HOST);
> > > > >      if (type == PCIE) {
> > > > >          bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
> > > > >      } else if (type == CXL) {
> > > > > @@ -466,6 +516,7 @@ static void pxb_register_types(void)
> > > > >      type_register_static(&pxb_pcie_bus_info);
> > > > >      type_register_static(&pxb_cxl_bus_info);
> > > > >      type_register_static(&pxb_host_info);
> > > > > +    type_register_static(&cxl_host_info);
> > > > >      type_register_static(&pxb_dev_info);
> > > > >      type_register_static(&pxb_pcie_dev_info);
> > > > >      type_register_static(&pxb_cxl_dev_info);
> > > > > diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> > > > > index 362cda40de..6bc344f205 100644
> > > > > --- a/include/hw/cxl/cxl.h
> > > > > +++ b/include/hw/cxl/cxl.h
> > > > > @@ -17,5 +17,7 @@
> > > > >  #define COMPONENT_REG_BAR_IDX 0
> > > > >  #define DEVICE_REG_BAR_IDX 2
> > > > >  
> > > > > +#define CXL_HOST_BASE 0xD0000000
> > > > > +
> > > > >  #endif
> > > > >      
> > > > 
> > > >     
> > >   
> >   

