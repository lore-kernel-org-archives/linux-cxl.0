Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27FCC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 18:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiA1StE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:49:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4557 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiA1StD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 13:49:03 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jlmgk4y5tz67kNj;
        Sat, 29 Jan 2022 02:48:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 28 Jan 2022 19:49:01 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 18:49:00 +0000
Date:   Fri, 28 Jan 2022 18:48:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 13/42] hw/pxb: Allow creation of a CXL PXB (host
 bridge)
Message-ID: <20220128184859.000005eb@huawei.com>
In-Reply-To: <20220128182001.00006886@huawei.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
        <20220124171705.10432-14-Jonathan.Cameron@huawei.com>
        <87ee4t9szh.fsf@linaro.org>
        <20220128182001.00006886@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Jan 2022 18:20:01 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 27 Jan 2022 13:59:56 +0000
> Alex Bennée <alex.bennee@linaro.org> wrote:
> 
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> >   
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > This works like adding a typical pxb device, except the name is
> > > 'pxb-cxl' instead of 'pxb-pcie'. An example command line would be as
> > > follows:
> > >   -device pxb-cxl,id=cxl.0,bus="pcie.0",bus_nr=1
> > >
> > > A CXL PXB is backward compatible with PCIe. What this means in practice
> > > is that an operating system that is unaware of CXL should still be able
> > > to enumerate this topology as if it were PCIe.
> > >
> > > One can create multiple CXL PXB host bridges, but a host bridge can only
> > > be connected to the main root bus. Host bridges cannot appear elsewhere
> > > in the topology.
> > >
> > > Note that as of this patch, the ACPI tables needed for the host bridge
> > > (specifically, an ACPI object in _SB named ACPI0016 and the CEDT) aren't
> > > created. So while this patch internally creates it, it cannot be
> > > properly used by an operating system or other system software.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Jonathan.Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  hw/pci-bridge/pci_expander_bridge.c | 98 ++++++++++++++++++++++++++++-
> > >  hw/pci/pci.c                        |  7 +++
> > >  include/hw/pci/pci.h                |  6 ++
> > >  3 files changed, 109 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > > index a6caa1e7b5..7009b541de 100644
> > > --- a/hw/pci-bridge/pci_expander_bridge.c
> > > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > > @@ -17,6 +17,7 @@
> > >  #include "hw/pci/pci_host.h"
> > >  #include "hw/qdev-properties.h"
> > >  #include "hw/pci/pci_bridge.h"
> > > +#include "hw/cxl/cxl.h"
> > >  #include "qemu/range.h"
> > >  #include "qemu/error-report.h"
> > >  #include "qemu/module.h"
> > > @@ -56,6 +57,10 @@ DECLARE_INSTANCE_CHECKER(PXBDev, PXB_DEV,
> > >  DECLARE_INSTANCE_CHECKER(PXBDev, PXB_PCIE_DEV,
> > >                           TYPE_PXB_PCIE_DEVICE)
> > >  
> > > +#define TYPE_PXB_CXL_DEVICE "pxb-cxl"
> > > +DECLARE_INSTANCE_CHECKER(PXBDev, PXB_CXL_DEV,
> > > +                         TYPE_PXB_CXL_DEVICE)
> > > +
> > >  struct PXBDev {
> > >      /*< private >*/
> > >      PCIDevice parent_obj;
> > > @@ -66,8 +71,19 @@ struct PXBDev {
> > >      bool bypass_iommu;
> > >  };
> > >  
> > > +typedef struct CXLHost {
> > > +    PCIHostState parent_obj;
> > > +
> > > +    CXLComponentState cxl_cstate;
> > > +} CXLHost;
> > > +
> > >  static PXBDev *convert_to_pxb(PCIDevice *dev)
> > >  {
> > > +    /* A CXL PXB's parent bus is PCIe, so the normal check won't work */
> > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PXB_CXL_DEVICE)) {
> > > +        return PXB_CXL_DEV(dev);
> > > +    }
> > > +
> > >      return pci_bus_is_express(pci_get_bus(dev))
> > >          ? PXB_PCIE_DEV(dev) : PXB_DEV(dev);
> > >  }
> > > @@ -76,6 +92,9 @@ static GList *pxb_dev_list;
> > >  
> > >  #define TYPE_PXB_HOST "pxb-host"
> > >  
> > > +#define TYPE_PXB_CXL_HOST "pxb-cxl-host"
> > > +#define PXB_CXL_HOST(obj) OBJECT_CHECK(CXLHost, (obj), TYPE_PXB_CXL_HOST)
> > > +
> > >  static int pxb_bus_num(PCIBus *bus)
> > >  {
> > >      PXBDev *pxb = convert_to_pxb(bus->parent_dev);
> > > @@ -112,11 +131,20 @@ static const TypeInfo pxb_pcie_bus_info = {
> > >      .class_init    = pxb_bus_class_init,
> > >  };
> > >  
> > > +static const TypeInfo pxb_cxl_bus_info = {
> > > +    .name          = TYPE_PXB_CXL_BUS,
> > > +    .parent        = TYPE_CXL_BUS,
> > > +    .instance_size = sizeof(PXBBus),
> > > +    .class_init    = pxb_bus_class_init,
> > > +};
> > > +
> > >  static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
> > >                                            PCIBus *rootbus)
> > >  {
> > > -    PXBBus *bus = pci_bus_is_express(rootbus) ?
> > > -                  PXB_PCIE_BUS(rootbus) : PXB_BUS(rootbus);
> > > +    PXBBus *bus = pci_bus_is_cxl(rootbus) ?
> > > +                      PXB_CXL_BUS(rootbus) :
> > > +                      pci_bus_is_express(rootbus) ? PXB_PCIE_BUS(rootbus) :
> > > +                                                    PXB_BUS(rootbus);
> > >  
> > >      snprintf(bus->bus_path, 8, "0000:%02x", pxb_bus_num(rootbus));
> > >      return bus->bus_path;
> > > @@ -218,6 +246,16 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
> > >      return pin - PCI_SLOT(pxb->devfn);
> > >  }
> > >  
> > > +static void pxb_dev_reset(DeviceState *dev)
> > > +{
> > > +    CXLHost *cxl = PXB_CXL_HOST(dev);  
> Having fixed the stuff you observed below...
> 
> It's not that device by rather the PXB_CXL_DEV and we
> can access the CXLHost via
> PXB_CXL_DEV(dv)->cxl.cxl_host_bridge()
> at which point this seems to be working.

The infrastructure to do this isn't in place until patch 24 so I'll have
to pull some of it into this patch to allow this reset to work.

Jonathan


> 
> > > +    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
> > > +    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
> > > +
> > > +    cxl_component_register_init_common(reg_state, CXL2_ROOT_PORT);
> > > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
> > > +}
> > > +
> > >  static gint pxb_compare(gconstpointer a, gconstpointer b)
> > >  {
> > >      const PXBDev *pxb_a = a, *pxb_b = b;
> > > @@ -290,6 +328,11 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
> > >      pci_config_set_class(dev->config, PCI_CLASS_BRIDGE_HOST);
> > >  
> > >      pxb_dev_list = g_list_insert_sorted(pxb_dev_list, pxb, pxb_compare);
> > > +
> > > +    if (type == CXL) {
> > > +        pxb_dev_reset(ds);
> > > +    }
> > > +    
> > 
> > Couldn't this just be done in the cxl realize function after it calls the
> > common code?  
> yup.
> 
> >   
> > >      return;
> > >  
> > >  err_register_bus:
> > > @@ -338,6 +381,12 @@ static void pxb_dev_class_init(ObjectClass *klass, void *data)
> > >      device_class_set_props(dc, pxb_dev_properties);
> > >      dc->hotpluggable = false;
> > >      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> > > +
> > > +    /*
> > > +     * Reset doesn't seem to actually be called, but maybe it will in the
> > > +     * future?
> > > +     */
> > > +    dc->reset = pxb_dev_reset;    
> > 
> > Surely because this should be in pxb_cxl_dev_class_init?  
> 
> That would indeed do it.
> 
> Thanks.
> 
> Jonathan
> 
> >   
> > >  }
> > >  
> > >  static const TypeInfo pxb_dev_info = {
> > > @@ -389,13 +438,58 @@ static const TypeInfo pxb_pcie_dev_info = {
> > >      },
> > >  };
> > >  
> > > +static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
> > > +{
> > > +    /* A CXL PXB's parent bus is still PCIe */
> > > +    if (!pci_bus_is_express(pci_get_bus(dev))) {
> > > +        error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
> > > +        return;
> > > +    }
> > > +
> > > +    pxb_dev_realize_common(dev, CXL, errp);
> > > +}
> > > +
> > > +static void pxb_cxl_dev_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc   = DEVICE_CLASS(klass);
> > > +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> > > +
> > > +    k->realize             = pxb_cxl_dev_realize;
> > > +    k->exit                = pxb_dev_exitfn;
> > > +    /*
> > > +     * XXX: These types of bridges don't actually show up in the hierarchy so
> > > +     * vendor, device, class, etc. ids are intentionally left out.
> > > +     */
> > > +
> > > +    dc->desc = "CXL Host Bridge";
> > > +    device_class_set_props(dc, pxb_dev_properties);
> > > +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> > > +
> > > +    /* Host bridges aren't hotpluggable. FIXME: spec reference */
> > > +    dc->hotpluggable = false;
> > > +}
> > > +
> > > +static const TypeInfo pxb_cxl_dev_info = {
> > > +    .name          = TYPE_PXB_CXL_DEVICE,
> > > +    .parent        = TYPE_PCI_DEVICE,
> > > +    .instance_size = sizeof(PXBDev),
> > > +    .class_init    = pxb_cxl_dev_class_init,
> > > +    .interfaces =
> > > +        (InterfaceInfo[]){
> > > +            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > > +            {},
> > > +        },
> > > +};
> > > +
> > >  static void pxb_register_types(void)
> > >  {
> > >      type_register_static(&pxb_bus_info);
> > >      type_register_static(&pxb_pcie_bus_info);
> > > +    type_register_static(&pxb_cxl_bus_info);
> > >      type_register_static(&pxb_host_info);
> > >      type_register_static(&pxb_dev_info);
> > >      type_register_static(&pxb_pcie_dev_info);
> > > +    type_register_static(&pxb_cxl_dev_info);
> > >  }
> > >  
> > >  type_init(pxb_register_types)
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 474ea98c1d..cafebf6f59 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -229,6 +229,12 @@ static const TypeInfo pcie_bus_info = {
> > >      .class_init = pcie_bus_class_init,
> > >  };
> > >  
> > > +static const TypeInfo cxl_bus_info = {
> > > +    .name       = TYPE_CXL_BUS,
> > > +    .parent     = TYPE_PCIE_BUS,
> > > +    .class_init = pcie_bus_class_init,
> > > +};
> > > +
> > >  static PCIBus *pci_find_bus_nr(PCIBus *bus, int bus_num);
> > >  static void pci_update_mappings(PCIDevice *d);
> > >  static void pci_irq_handler(void *opaque, int irq_num, int level);
> > > @@ -2892,6 +2898,7 @@ static void pci_register_types(void)
> > >  {
> > >      type_register_static(&pci_bus_info);
> > >      type_register_static(&pcie_bus_info);
> > > +    type_register_static(&cxl_bus_info);
> > >      type_register_static(&conventional_pci_interface_info);
> > >      type_register_static(&cxl_interface_info);
> > >      type_register_static(&pcie_interface_info);
> > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > index 908896ebe8..97cbbad375 100644
> > > --- a/include/hw/pci/pci.h
> > > +++ b/include/hw/pci/pci.h
> > > @@ -409,6 +409,7 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
> > >  #define TYPE_PCI_BUS "PCI"
> > >  OBJECT_DECLARE_TYPE(PCIBus, PCIBusClass, PCI_BUS)
> > >  #define TYPE_PCIE_BUS "PCIE"
> > > +#define TYPE_CXL_BUS "CXL"
> > >  
> > >  typedef void (*pci_bus_dev_fn)(PCIBus *b, PCIDevice *d, void *opaque);
> > >  typedef void (*pci_bus_fn)(PCIBus *b, void *opaque);
> > > @@ -768,6 +769,11 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
> > >      pci_irq_deassert(pci_dev);
> > >  }
> > >  
> > > +static inline int pci_is_cxl(const PCIDevice *d)
> > > +{
> > > +    return d->cap_present & QEMU_PCIE_CAP_CXL;
> > > +}
> > > +
> > >  static inline int pci_is_express(const PCIDevice *d)
> > >  {
> > >      return d->cap_present & QEMU_PCI_CAP_EXPRESS;    
> > 
> >   
> 

